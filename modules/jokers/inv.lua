SMODS.Joker({
	key = "inv",
	atlas = "sofanthiel",
	pos = { x = 0, y = 0 },
	rarity = 3,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	attributes = { "slugcat", "chance", "generate", "joker" },
	config = { extra = { odds = 6, blink = false, asc_odds = 20 }, spear_strength = "weak", slugcat = true },

	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_rw_slugpup
		return {
			vars = { SMODS.get_probability_vars(card, 1, (card.ability and card.ability.rw_ascended) and card.ability.extra.asc_odds or card.ability.extra.odds, "rw_inv") },
			key = card.config.center_key .. ((card.ability and card.ability.rw_ascended) and "_ascended" or "")
		}
	end,

	calculate = function(self, card, context)
		local create_spup = function()
			local spup = SMODS.add_card({ set = "Joker", area = G.jokers, edition = "e_negative", attributes = { "slugpup" } })
			spup.cost = 0
			spup.sell_cost = 0
		end

		if context.end_of_round and context.main_eval then
			if card.ability.rw_ascended or SMODS.pseudorandom_probability(card, "rw_inv", 1, card.ability.extra.odds, "rw_inv") then
				create_spup()
			end
			if card.ability.rw_ascended and SMODS.pseudorandom_probability(card, "rw_inv", 1, card.ability.extra.asc_odds, "rw_inv") then
				create_spup()
			end
		end
	end,
})
