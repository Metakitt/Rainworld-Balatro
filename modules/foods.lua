assert(SMODS.load_file("modules/foods/bluefruit.lua"))()
assert(SMODS.load_file("modules/foods/bubblefruit.lua"))()
assert(SMODS.load_file("modules/foods/gooieduck.lua"))()
assert(SMODS.load_file("modules/foods/dandepeach.lua"))()
assert(SMODS.load_file("modules/foods/slimemold.lua"))()
assert(SMODS.load_file("modules/foods/lilypuck.lua"))()
assert(SMODS.load_file("modules/foods/eggbugegg.lua"))()
assert(SMODS.load_file("modules/foods/fireegg.lua"))()
assert(SMODS.load_file("modules/foods/popcornplant.lua"))()
assert(SMODS.load_file("modules/foods/glowweed.lua"))()
assert(SMODS.load_file("modules/foods/mushroom.lua"))()
assert(SMODS.load_file("modules/foods/karmaf.lua"))()
assert(SMODS.load_file("modules/foods/neuronfly.lua"))()

SMODS.ConsumableType({
	key = "foods",
	default = "c_rw_bluefruit",
	collection_rows = { 6, 7 },
	primary_colour = HEX("1b5699"),
	secondary_colour = HEX("1b5699"),
	loc_txt = {
		collection = "Food",
		name = "Food",

		undiscovered = {
			name = "Not Discovered",
			text = { "Purchase or use", "this card in an", "unseeded run to", "learn what it does" },
		},
	},
	shop_rate = 3.5,
	rarities = {
		{ key = "rw_foodcommon", rate = 0.7 },
		{ key = "rw_fooduncommon", rate = 0.27 },
		{ key = "rw_foodrare", rate = 0.02 },
	},
})
