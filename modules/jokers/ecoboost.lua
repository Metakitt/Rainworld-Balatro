SMODS.Joker({
	key = "ecoboost",
	config = {
		extra = {
			x_chips = 1,
			x_chip_gain = 0.5,
		},
	},
	rarity = 3,
	cost = 8,
	atlas = "slugcats",
	pos = { x = 2, y = 4 },
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.x_chip_gain,
				card.ability.extra.x_chips,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return { xchips = card.ability.extra.x_chips }
		end

		if context.card_added and not context.blueprint then
			if context.card.config.center.set == "Joker" and context.card.config.center.rarity == "rw_enemy" then
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = localize({
						type = "variable",
						key = "a_xchips",
						vars = { card.ability.extra.x_chip_gain },
					}),
					colour = G.C.CHIPS,
				})
				card.ability.extra.x_chips = card.ability.extra.x_chips + card.ability.extra.x_chip_gain
			end
		end
	end,
})
