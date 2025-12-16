SMODS.Joker({
	key = "pupenfys",
	atlas = "slugcats",
	loc_txt = {
		name = "Enfys",
		text = {
			"At the {C:attention}end of round{},",
			"creates a random,",
			"{C:edition}negative{} Food Consumeable.",
		},
	},
	pos = { x = 5, y = 6 },
	soul_pos = { x = 5, y = 3 },
	rarity = 4,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { food = "none" }, slugcat = true },

	calculate = function(self, card, context)

		if context.end_of_round and context.main_eval then
			SMODS.add_card({ set = "foods", area = G.consumeables, edition = "e_negative" })
		end
	end,
})
