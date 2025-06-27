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
		if card.ability.name == "rot" then
			for i, v in ipairs(G.hand.highlighted) do
				for i = 1, #G.hand.highlighted do
					other_card = v
					other_card:set_ability(G.P_CENTERS.m_rw_rotting)
					other_card:juice_up(0.5, 0.5)
					SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, other_card)
				end
			end
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
		if card.ability.name == "wet" then
			for i, v in ipairs(G.hand.highlighted) do
				for i = 1, #G.hand.highlighted do
					other_card = v
					other_card:set_ability(G.P_CENTERS.m_rw_wetasscard)
					other_card:juice_up(0.5, 0.5)
					SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, other_card)
				end
			end
		end
	end,
})
