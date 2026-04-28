SMODS.Booster({
	key = "regularfoodpack",
	group_key = "k_food_pack",
	kind = "foods",
	atlas = "boosterslug",
	pos = { x = 1, y = 0 },
	config = { extra = 3, choose = 1 },
	cost = 4,
	weight = 1.2,
	unlocked = true,
	discovered = true,
	draw_hand = true,
	create_card = function(self, card)
		return {
			set = "foods",
			area = G.pack_cards,
			skip_materialize = true,
		}
	end,
})

SMODS.Booster({
	key = "selectfoodpack",
	group_key = "k_food_pack",
	kind = "rw_foods",
	atlas = "boosterslug",
	pos = { x = 0, y = 0 },
	config = { extra = 3, choose = 1 },
	cost = 4,
	weight = 0.9,
	unlocked = true,
	discovered = true,
	select_card = "consumeables",
	create_card = function(self, card)
		return {
			set = "foods",
			area = G.pack_cards,
			skip_materialize = true,
		}
	end,
})

SMODS.Booster({
	key = "jumbofoodpack",
	group_key = "k_food_pack",
	kind = "foods",
	atlas = "boosterslug",
	pos = { x = 2, y = 0 },
	config = { extra = 5, choose = 1 },
	cost = 6,
	weight = 0.8,
	unlocked = true,
	discovered = true,
	draw_hand = true,
	create_card = function(self, card)
		return {
			set = "foods",
			area = G.pack_cards,
			skip_materialize = true,
		}
	end,
})

SMODS.Booster({
	key = "megafoodpack",
	group_key = "k_food_pack",
	kind = "foods",
	atlas = "boosterslug",
	pos = { x = 3, y = 0 },
	config = { extra = 5, choose = 2 },
	cost = 6,
	weight = 0.5,
	unlocked = true,
	discovered = true,
	draw_hand = true,
	create_card = function(self, card)
		return {
			set = "foods",
			area = G.pack_cards,
			skip_materialize = true,
		}
	end,
})

-- TODO: Figure out how to finagle the create_card function so it can't make weapons you can't apply
SMODS.Booster({
	key = "weapon_normal_1",
	group_key = "k_weapon_pack",
	kind = "rw_obtainweapon",
	atlas = "boosterslug",
	pos = { x = 0, y = 1 },
	config = { extra = 2, choose = 1 },
	cost = 4,
	weight = 0.5,
	unlocked = true,
	discovered = true,
	create_card = function(self, card, i)
		return { set = "obtainweapon", area = G.pack_cards, skip_materialize = true }
	end,
})

SMODS.Booster({
	key = "weapon_normal_2",
	group_key = "k_weapon_pack",
	kind = "rw_obtainweapon",
	atlas = "boosterslug",
	pos = { x = 1, y = 1 },
	config = { extra = 2, choose = 1 },
	cost = 4,
	weight = 0.5,
	unlocked = true,
	discovered = true,
	create_card = function(self, card, i)
		return { set = "obtainweapon", area = G.pack_cards, skip_materialize = true }
	end,
})

SMODS.Booster({
	key = "weapon_jumbo_1",
	group_key = "k_weapon_pack",
	kind = "rw_obtainweapon",
	atlas = "boosterslug",
	pos = { x = 2, y = 1 },
	config = { extra = 4, choose = 1 },
	cost = 4,
	weight = 0.4,
	unlocked = true,
	discovered = true,
	create_card = function(self, card, i)
		return { set = "obtainweapon", area = G.pack_cards, skip_materialize = true }
	end,
})

SMODS.Booster({
	key = "weapon_mega_1",
	group_key = "k_weapon_pack",
	kind = "rw_obtainweapon",
	atlas = "boosterslug",
	pos = { x = 3, y = 1 },
	config = { extra = 4, choose = 2 },
	cost = 4,
	weight = 0.12,
	unlocked = true,
	discovered = true,
	create_card = function(self, card, i)
		return { set = "obtainweapon", area = G.pack_cards, skip_materialize = true }
	end,
})
