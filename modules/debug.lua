-- These are items for testing different things. Right now, it only contains a consumeable that allows you to make a card rot.

SMODS.ConsumableType({
	key = "testeritems",
	collection_rows = { 6, 7 },
	primary_colour = HEX("1b5699"),
	secondary_colour = HEX("1b5699"),
	loc_txt = {
		collection = "Tester",
		name = "Tester",

		undiscovered = {
			name = "Not Discovered",
			text = { "Purchase or use", "this card in an", "unseeded run to", "learn what it does" },
		},
	},
})

SMODS.Consumable({
	key = "rotting2",
	loc_txt = {
		name = "Rot Fruit",
		text = {
			"Makes selected",
			"playing card Rot.",
		},
	},
	set = "testeritems",
	atlas = "weaponfoods",
	pos = { x = 0, y = 0 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { extra = { upgrade = 15 }, name = "rot" },
	can_use = function(self, card)
		return #G.hand.highlighted == 1
	end,
	use = function(self, card, area, copier)
		for _, v in ipairs(G.hand.highlighted) do
			v:set_ability(G.P_CENTERS.m_rw_rotting)
			v:juice_up(0.5, 0.5)
			SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, v)
		end
	end,
})

SMODS.Consumable({
	key = "wetty",
	loc_txt = {
		name = "Wet Fruit",
		text = {
			"Makes selected",
			"playing card Wet.",
		},
	},
	set = "testeritems",
	atlas = "weaponfoods",
	pos = { x = 1, y = 0 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { extra = { upgrade = 15 }, name = "wet" },
	can_use = function(self, card)
		return #G.hand.highlighted == 1
	end,
	use = function(self, card, area, copier)
		for _, v in ipairs(G.hand.highlighted) do
			v:set_ability(G.P_CENTERS.m_rw_wetasscard)
			v:juice_up(0.5, 0.5)
			SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, v)
		end
	end,
})
