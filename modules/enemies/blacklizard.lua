SMODS.Joker({
	key = "blacklizard",
	config = {
		extra = {
			defeat = false,
		}, enemy = true,
	},
	rarity = "rw_enemy",
	cost = 3,
	atlas = "enemies",
	pos = { x = 7, y = 2 },
	discovered = true,
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
	add_to_deck = function(self, card, from_debuff)
		SMODS.Stickers["eternal"]:apply(card, true)
		-- Threat
		for _, v in pairs(G.playing_cards) do
			if v:is_suit("Hearts", true) or v:is_suit("Diamonds", true) then
				SMODS.debuff_card(v, true, "black_lizard_temporary")
			end
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		for _, v in pairs(G.playing_cards) do
			if v:is_suit("Hearts", true) or v:is_suit("Diamonds", true) then
				SMODS.debuff_card(v, false, "black_lizard_temporary")
			end
		end
	end,
	calculate = function(self, card, context)
		-- Defeat
		if context.before and not context.blueprint then
			if #context.poker_hands["Flush House"] > 0 then
				local valid = true
				for _, v in ipairs(context.poker_hands["Flush House"][1]) do
					valid = valid and not (v:is_suit("Hearts", true) or v:is_suit("Diamonds", true))
				end
				card.ability.extra.defeat = valid
			end
		end
		if context.after and card.ability.extra.defeat then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 1.3,
				func = function()
					SMODS.destroy_cards(card, true)
					return true
				end,
			}))
		end
		-- Undefeated
		if
			context.main_eval
			and context.end_of_round
			and G.GAME.blind.boss
			and card.ability.extra.defeat == false
			and not context.blueprint
		then
			for _, v in pairs(G.playing_cards) do
				if v:is_suit("Hearts", true) or v:is_suit("Diamonds", true) then
					SMODS.debuff_card(v, true, "black_lizard_permanent")
				end
			end
		end
	end,
})
