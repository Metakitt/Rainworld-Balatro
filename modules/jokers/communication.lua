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
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				G.GAME and G.GAME.probabilities.normal or 1,
				card.ability.extra.odds,
			},
		}
	end,
	calculate = function(self, card, context)
		if
			context.using_consumeable
			and pseudorandom("rw_communication") < G.GAME.probabilities.normal / card.ability.extra.odds
		then
			local valid = false
			local new_consum = { key = "c_wheel_of_fortune" }
			repeat
				new_consum =
					G.P_CENTERS[pseudorandom_element(G.P_CENTER_POOLS.Consumeables, pseudoseed("rw_communication")).key]
				valid = new_consum.discovered and not new_consum.hidden and true or false
			until valid
			G.E_MANAGER:add_event(Event({
				func = function()
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = "Message Received!",
						colour = G.C.SECONDARY_SET.Planet,
					})
					G.E_MANAGER:add_event(Event({
						func = function()
							SMODS.add_card({ key = new_consum.key, area = G.consumeables })
							return true
						end,
					}))
					return true
				end,
			}))
		end
	end,
})
