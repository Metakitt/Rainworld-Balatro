SMODS.Joker({
	key = "communication",
	config = {
		extra = {
			odds = 5,
		},
	},
	rarity = 1,
	cost = 4,
	atlas = "slugcats",
	pos = { x = 3, y = 4 },
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "chance", "generation", },
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "rw_communication")
			},
		}
	end,
	calculate = function(self, card, context)
		if
			context.using_consumeable
			and SMODS.pseudorandom_probability(card, "rw_communication", 1, card.ability.extra.odds, "rw_communication")
		then
			SMODS.calculate_effect({ message = localize("k_msg_ex"), colour = G.C.SECONDARY_SET.Planet }, card)
			G.E_MANAGER:add_event(Event({
				func = function()
					SMODS.add_card { set = 'Consumeables', soulable = false }
					return true
				end
			}))
		end
	end,
})
