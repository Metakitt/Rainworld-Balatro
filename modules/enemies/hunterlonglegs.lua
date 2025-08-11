--[[Threat: 1 in 8 chance to rot a random joker with each played hand. -1 Mult each played hand.
Defeat: Score a card with at least +6 Extra Mult.
If Not Defeated: Ante + 1]]

SMODS.Joker({
	key = "hunterlonglegs",
	atlas = "enemies",
	rarity = "rw_enemy",
	cost = 4,
	pos = { x = 1, y = 4 },
	unlocked = true,
	discovered = true,
	in_pool = function(self, args)
		return false
	end,
	config = { extra = { center_table = 1, defeat = false, odds = 8, antimult = 0 }, enemy = true },
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
		info_queue[#info_queue + 1] = { key = "rw_wspear_exp", set = "Other" }
		return { vars = { card.ability.extra.odds, card.ability.extra.bombattack } }
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.Stickers["eternal"]:apply(card, true)
	end,
	calculate = function(self, card, context)
		--Threat
		if context.joker_main and not context.blueprint then
			card.ability.extra.antimult = card.ability.extra.antimult - 1
			for i = 1, #G.jokers.cards do
				if pseudorandom("bite") < 1 / card.ability.extra.odds and not context.blueprint then
					G.jokers.cards[i]:set_rotted()
				end
			end
			return {
				mult = card.ability.extra.antimult,
			}
		end

		--Defeat
		if context.before and not context.blueprint then
			for i = 1, #G.play.cards do
				if G.play.cards[i].ability.perma_mult >= 6 and not context.blueprint then
					card.ability.extra.defeat = true
				end
			end
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
			and G.GAME.round_resets.blind_ante ~= 8
			and G.GAME.blind.boss
			and card.ability.extra.defeat == false
			and not context.blueprint
		then
			card.ability.extra.center_table = 1
			ease_ante(card.ability.extra.center_table)
			G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
			G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + card.ability.extra.center_table
		end
	end,
})
