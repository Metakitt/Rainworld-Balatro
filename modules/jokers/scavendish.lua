SMODS.Joker({
	key = "scavendish",
	config = {
		extra = {
			weapon_rate_mult = 3,
			odds = 1000,
			force_boost = false,
		},
	},
	rarity = 3,
	cost = 7,
	atlas = "slugcats",
	pos = { x = 5, y = 4 },
	discovered = true,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.weapon_rate_mult,
                (G.GAME and G.GAME.probabilities.normal) or 1,
				card.ability.extra.odds,
			},
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		for k,v in pairs(SMODS.Stickers) do
			local st, nd = string.find(k, "rw_w")
			if st == 1 and nd == 4 then
				v.rate = v.rate * 3
			end
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		for k,v in pairs(SMODS.Stickers) do
			local st, nd = string.find(k, "rw_w")
			if st == 1 and nd == 4 then
				v.rate = v.rate / 3
			end
		end
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.jokers and not context.blueprint_card then
			if pseudorandom("rw_scavendish") < G.GAME.probabilities.normal / card.ability.extra.odds then
				SMODS.destroy_cards(card, true)
				return { message = localize("k_extinct_ex") }
			else
				return { message = localize("k_safe_ex") }
			end
		end
	end,
})
