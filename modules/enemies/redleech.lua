--[[Red Leech
Appears: Ante 1 and 2
Threat: -20 Chips. Each played hand summons a new leech.
Defeat condition: Play two 'High Cards'.
If not defeated: Destroys a random joker.]]

SMODS.Joker({
	key = "redleech",
	atlas = "enemies",
	rarity = "rw_enemy",
	cost = 4,
	pos = { x = 5, y = 0 },
	unlocked = true,
	discovered = true,
	in_pool = function(self, args)
		return false
	end,
	config = { extra = { defeat = false, highcardcount = 0, dying = false, unchips = -20, odds = 3 }, enemy = true },
	blueprint_compat = false,
	perishable_compat = false,
	rw_wbeehive_compat = false,
	rw_wcherrybomb_compat = false,
	rw_wspear_ele_compat = false,
	rw_wspear_exp_compat = false,
	rw_wspear_fire_compat = false,
	rw_wflashbang_compat = false,
	rw_wgrenade_compat = false,
	rw_wjokerifle_compat = false,
	rw_wrock_compat = false,
	rw_wsingularity_compat = false,
	rw_wspear_compat = false,
	rw_wsporepuff_compat = false,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.unchips, card.ability.extra.odds, card.ability.extra.highcardcount } }
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.Stickers["eternal"]:apply(card, true)
	end,
	calculate = function(self, card, context)
		--Threat
		if context.joker_main and not context.blueprint then
			return {
				chips = card.ability.extra.unchips,
			}
		end

		if
			context.after
			and pseudorandom("moreleech") < 1 / card.ability.extra.odds
			and card.ability.extra.dying == false
			and not context.blueprint
		then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 1.3,
				func = function()
					SMODS.add_card({ set = "Joker", area = G.jokers, key = "j_rw_redleech", no_edition = true })
					return true
				end,
				blocking = false,
			}))
		end

		--Defeat
		if context.before and not context.blueprint then
			if
				next(context.poker_hands["High Card"])
				and context.scoring_name == "High Card"
				and not context.blueprint
			then
				card.ability.extra.highcardcount = card.ability.extra.highcardcount + 1
			end
		end

		if card.ability.extra.highcardcount >= 2 and not context.blueprint then
			card.ability.extra.defeat = true
			card.ability.extra.dying = true
		end

		if context.after and card.ability.extra.defeat == true and not context.blueprint then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 1.3,
				func = function()
					SMODS.destroy_cards(card, true)
					return true
				end,
				blocking = false,
			}))
		end
		--Undefeated

		if
			context.main_eval
			and context.end_of_round
			and G.GAME.blind.boss
			and card.ability.extra.defeat == false
			and not context.blueprint
		then
			local destructable_jokers = {}
			for i = 1, #G.jokers.cards do
				if
					G.jokers.cards[i] ~= card
					and not G.jokers.cards[i].ability.eternal
					and not G.jokers.cards[i].getting_sliced
					and not context.blueprint
				then
					destructable_jokers[#destructable_jokers + 1] = G.jokers.cards[i]
				end
			end
			local joker_to_destroy = #destructable_jokers > 0
					and pseudorandom_element(destructable_jokers, pseudoseed("explode"))
				or nil

			if joker_to_destroy and not (context.blueprint_card or card).getting_sliced and not context.blueprint then
				joker_to_destroy.getting_sliced = true
				G.E_MANAGER:add_event(Event({
					func = function()
						joker_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
						return true
					end,
				}))
			end
		end
	end,
})
