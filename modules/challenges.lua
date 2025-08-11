SMODS.Challenge({
	loc_txt = "Slugcat Parade",
	key = "rwparade",
	jokers = {
		{ id = "j_rw_artificer", eternal = true },
		{ id = "j_rw_hunter", eternal = true },
		{ id = "j_rw_gourmand", eternal = true },
		{ id = "j_rw_monk", eternal = true },
		{ id = "j_rw_saint", eternal = true },
		{ id = "j_rw_rivulet", eternal = true },
		{ id = "j_rw_spearmaster", eternal = true },
		{ id = "j_rw_survivor", eternal = true },
	},
	rules = {
		modifiers = {
			{ id = "joker_slots", value = 8 },
		},
	},
})

SMODS.Challenge {
	loc_txt = "Starvation",
	key = "starvation",
	jokers = {
		{ id = "j_rw_hunger", eternal = true }
	}
}
