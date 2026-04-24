SMODS.Rarity({
	key = "foodcommon",
	loc_txt = {
		name = 'Common',
	},
	pools = {
		-- ["foods"] = true,
		["foods"] = { rate = 0.7 },
	},
	badge_colour = HEX("1b5699"),
	default_weight = 0.7,
})

SMODS.Rarity({
	key = "fooduncommon",
	loc_txt = {
		name = 'Uncommon',
	},
	pools = {
		-- ["foods"] = true,
		["foods"] = { rate = 0.27 },
	},
	badge_colour = HEX("1b5699"),
	default_weight = 0.27,
})

SMODS.Rarity({
	key = "foodrare",
	loc_txt = {
		name = 'Rare',
	},
	pools = {
		-- ["foods"] = true,
		["foods"] = { rate = 0.02 },
	},
	badge_colour = HEX("1b5699"),
	default_weight = 0.02,
})

SMODS.Rarity({
	key = "enemy",
	loc_txt = {
		name = 'Enemy',
	},
	badge_colour = HEX("811331"),
	default_weight = 0,
})