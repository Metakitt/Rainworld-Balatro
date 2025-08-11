SMODS.Joker({
	key = "blackholelizard",
	config = {
		extra = {
			defeat = false,
		},
		enemy = true,
	},
	rarity = "rw_enemy",
	cost = 3,
	atlas = "enemies",
	pos = { x = 7, y = 5 },
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
		card:set_edition("e_negative")
	end,
	calculate = function(self, card, context)
		-- Defeat
		if context.before and not context.blueprint then
			for _, v in pairs(G.jokers.cards) do
				for k, _ in pairs(v.ability) do
					if k == "rw_wsingularity" then
						card.ability.extra.defeat = true
						SMODS.Stickers["rw_wsingularity"]:apply(v, nil)
						SMODS.destroy_cards(card, true)
					end
				end
			end
		end
		-- Undefeated
		if
			context.main_eval
			and context.end_of_round
			and G.GAME.blind.boss
			and card.ability.extra.defeat == false
			and not context.blueprint
		then
			G.FUNCS.start_run(nil, {})
		end
	end,
})
