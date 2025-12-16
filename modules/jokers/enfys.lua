local ENFYS_FOOD_LIST = {
	"j_popcorn",
	"j_gros_michel",
	"j_ice_cream",
	"j_egg",
	"j_flower_pot",
	"j_ramen",
	"j_diet_cola",
	"j_turtle_bean",
}

SMODS.Joker({
	key = "enfys",
	atlas = "slugcats",
	loc_txt = {
		name = "Enfys",
		text = {
			"At the {C:attention}end of round{},",
			"creates a random,",
			"{C:edition}negative{} Food Joker.",
		},
	},
	pos = { x = 4, y = 3 },
	soul_pos = { x = 5, y = 3 },
	rarity = 4,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { food = "none" }, slugcat = true },

	calculate = function(self, card, context)
		if context.setting_blind then
			card.ability.extra.food = pseudorandom_element(
				{
					"j_popcorn",
					"j_gros_michel",
					"j_ice_cream",
					"j_egg",
					"j_flower_pot",
					"j_ramen",
					"j_diet_cola",
					"j_turtle_bean",
				},
				pseudoseed("foods")
			)
		end

		if context.end_of_round and context.main_eval then
			local food, _ = pseudorandom_element(ENFYS_FOOD_LIST, "foods", {})
			SMODS.add_card({ set = "Joker", area = G.jokers, edition = "e_negative", key = food })
		end
	end,
})
