SMODS.Joker({
	key = "enfys",
	atlas = "slugcats",
	pos = { x = 4, y = 3 },
	soul_pos = { x = 5, y = 3 },
	rarity = 4,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	attributes = { "slugcat", "generation", "joker" },
	config = { extra = { food = "none" }, slugcat = true },

	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval then
			local food, _ = pseudorandom_element(SMODS.get_attribute_pool("food"), "foods", {})
			SMODS.add_card({ set = "Joker", area = G.jokers, edition = "e_negative", key = food })
		end
	end,
})
