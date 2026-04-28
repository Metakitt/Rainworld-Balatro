--[[
The effect change at the start of each blind. most likely will have to init a var to store that effect.
A) Blue Fruit
Boosts each card in the first hand by 15 chips.
B) Rock
[ Rock's Effect ]
C) Pearl
1 in 10 chance to turn this joker Polychrome (if it doesn't already have an edition)
D) Grenade
[ Grenade's Effect ]
E) Singularity Bomb
[ Sing. Bomb effect but doesn't destroy itself ]
Rarest effect
(The four next effects do the same as their regular counterparts)
F) Beehive
G) Cherrybomb
H) Flashbang
I) Sporepuff
J) Noodlefly Egg
Spawns a baby negative noodlefly that is removed at the end of the round.

Sequence of event
define a variable that changes

There's 10 entries;
Common effects

Blue fruit
Rock
Cherrybomb
Noodlefly egg [Currently shows up as "none" and does nothing.]
Pearl

Uncommon effect
Beehive (This is a modified version of beehive that works on any blind)
Flashbang
Grenade
Sporepuff

Rare effect
Singularity bomb

So the game rolls a mathrandom (1,11).
value 1 through 5(inclusive so 1,2,3,4,5) is common
value 6 to 9 (6,7,8,9) is uncommon
and value (10,11) is rare
cr stands for chosenrarity

At the start of blind, chooses a random effect.
(Loaded with: (name of item))
(effect of item)

]]
SMODS.Sticker({
	key = "wjokerifle",
	config = {
		weapon = true,
	},
	badge_colour = HEX("875796"),
	atlas = "enhancedcards_scug",
	pos = { x = 4, y = 1 },
	default_compat = true,
	compat_exceptions = {},
	sets = {
		Joker = true,
		Tarot = false,
		Spectral = false,
		foods = false,
	},
	rate = 0.005,
	needs_enable_flag = false,
	loc_vars = function(self, info_queue, card)
		return {
			key = self.key .. '_' .. ((G.GAME and G.GAME.jokerifle) or "none")
		}
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			card.ability.extra.grenade_primed = nil
		end

		if G.GAME.jokerifle == "beehive" then
			if context.setting_blind then
				local suit = pseudorandom_element(SMODS.Suits, pseudoseed("mysuit"))
				for _, v in pairs(G.playing_cards) do
					if v:is_suit(suit.name) then
						if v.ability.perma_bonus <= 0 then
							v.ability.perma_bonus = 5
						end
						if v.ability.perma_bonus > 0 then
							v.ability.perma_bonus = (v.ability.perma_bonus or 0) * 2
						end
						v:juice_up(0.5, 0.5)
						SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, v)
					else
						SMODS.debuff_card(v, true, "bees")
					end
				end
			elseif context.end_of_round then
				for _, v in pairs(G.playing_cards) do
					SMODS.debuff_card(v, false, "bees")
				end
			end
		end

		if context.setting_blind and G.GAME.jokerifle == "sporepuff" then
			G.GAME.blind.chips = G.GAME.blind.chips * 0.95
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		end

		if context.discard and G.GAME.jokerifle == "grenade" then
			if G.GAME.current_round.discards_used <= 0 and #context.full_hand == 1 then
				if card.config.center_key == "j_rw_artificer" then
					card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.bonus_chips
				end
				SMODS.calculate_effect({ message = localize("k_primed_ex") }, card)
				card.ability.extra.grenade_primed = true

				return {
					remove = true,
					card = self,
				}
			end
		end

		if context.skip_blind and G.GAME.jokerifle == "flashbang" then
			G.GAME.jokerifle = "none"
			G.from_boss_tag = true
			G.FUNCS.reroll_boss()
		end

		if context.joker_main then
			if G.GAME.jokerifle == "singularity" and G.GAME.current_round.hands_played == 0 then
				if #context.full_hand == 1 then
					SMODS.destroy_cards(G.hand.cards)
					SMODS.Stickers.rw_wsingularity:apply(card, false)
					G.GAME.chips = G.GAME.blind.chips
					G.STATE_COMPLETE = true
				end
			elseif G.GAME.jokerifle == "bluefruit" and G.GAME.current_round.hands_played == 0 then
				for i = 1, #G.play.cards do
					local upgrade = G.play.cards[i]
					upgrade:juice_up()
					upgrade.ability.perma_bonus = upgrade.ability.perma_bonus or 0
					upgrade.ability.perma_bonus = upgrade.ability.perma_bonus + 15
				end
			elseif G.GAME.jokerifle == "rock" then
				return {
					x_chips = 2,
				}
			elseif G.GAME.jokerifle == "cherrybomb" then
				local bomb = SCUG.number_in_range(6, 12)
				return {
					mult = bomb,
				}
			elseif G.GAME.jokerifle == "grenade" and card.ability.extra.grenade_primed then
				return {
					mult = 20
				}
			elseif G.GAME.jokerifle == "none" then
				--do nothing (for now)
			end
		end

		if context.end_of_round and context.main_eval then
			if G.GAME.jokerifle == "pearl" then
				local chrome = math.random(1, 4)
				if chrome == 4 then
					card:set_edition("e_polychrome", true)
				end
			end
		end
	end,
})

SMODS.Consumable({
	key = "jokerifle",
	set = "obtainweapon",
	atlas = "weaponfoods",
	pos = { x = 1, y = 3 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { weapon = "rw_wjokerifle" },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = card.ability.weapon }
	end,
	can_use = function(self, card)
		return #G.jokers.highlighted == 1
			and not G.jokers.highlighted[1].ability.enemy
			and not G.jokers.highlighted[1].ability[card.ability.weapon]
	end,
	use = function(self, card, area, copier)
		for _, v in ipairs(G.jokers.highlighted) do
			SMODS.Stickers[card.ability.weapon]:apply(v, true)
		end
	end,
})
