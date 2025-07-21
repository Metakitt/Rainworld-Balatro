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
	eternal_compat = true,
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
		G.GAME.obtainweapon_rate = (G.GAME.obtainweapon_rate or 0) * 3
		if G.GAME.obtainweapon_rate == 0 then
			card.ability.extra.force_boost = true
			G.GAME.obtainweapon_rate = 3
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if card.ability.extra.force_boost then
			G.GAME.obtainweapon_rate = G.GAME.obtainweapon_rate - 3
		end
		G.GAME.obtainweapon_rate = (G.GAME.obtainweapon_rate or 0) / 3
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.jokers and not context.blueprint_card then
			if pseudorandom("rw_scavendish") < 1 / card.ability.extra.odds then
				SMODS.destroy_cards(card)
				return { message = localize("k_extinct_ex") }
			else
				return { message = localize("k_safe_ex") }
			end
		end
	end,
})
