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
	config = { extra = { odds = 6, blink = false }, spear_strength = "weak" },

	loc_vars = function(self, info_queue, card)
		return { vars = { SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "rw_inv") }, slugcat = true }
	end,

	calculate = function(self, card, context)
		if
			context.end_of_round
			and context.main_eval
			and SMODS.pseudorandom_probability(card, "rw_inv", 1, card.ability.extra.odds, "rw_inv")
		then
			local spup = SMODS.add_card({ set = "Joker", area = G.jokers, edition = "e_negative", key = "j_rw_slugpup" })
			spup.cost = 0
			spup.sell_cost = 0
		end
	end,
})
