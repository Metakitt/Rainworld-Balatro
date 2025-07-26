SMODS.Booster({
	key = "regularfoodpack",
	loc_txt = {
		name = "Regular Food Pack",
		text = {
			"Choose {C:attention}1{} out of {C:attention}3{} Food cards to be used immediately.",
		},
		group_name = "Food Pack",
	},
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
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end,
})

SMODS.Booster({
	key = "jumbofoodpack",
	loc_txt = {
		name = "Jumbo Food Pack",
		text = {
			"Choose {C:attention}1{} out of {C:attention}5{} Food cards to be used immediately.",
		},
		group_name = "Food Pack",
	},
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
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end,
})

SMODS.Booster({
	key = "megafoodpack",
	loc_txt = {
		name = "Mega Food Pack",
		text = {
			"Choose {C:attention}2{} out of {C:attention}5{} Food cards to be used immediately.",
		},
		group_name = "Food Pack",
	},
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
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra } }
	end,
})

SMODS.Booster({
	key = "selectfoodpack",
	loc_txt = {
		name = "Select Food Pack",
		text = {
			"Choose {C:attention}1{} out of {C:attention}3{} Food cards.",
		},
		group_name = "Food Pack",
	},
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

-- TODO: Figure out how to finagle the create_card function so it can't make weapons you can't apply
SMODS.Booster({
	key = "weapon_normal_1",
	loc_txt = {
		name = "Weapon Pack",
		text = {
			"Choose {C:attention}1{} out of {C:attention}2{C:weapon} Weapons",
			"to apply to your Jokers",
		},
		group_name = "Weapon Pack",
	},
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
	loc_txt = {
		name = "Weapon Pack",
		text = {
			"Choose {C:attention}1{} out of {C:attention}2{C:weapon} Weapons",
			"to apply to your Jokers",
		},
		group_name = "Weapon Pack",
	},
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
	loc_txt = {
		name = "Jumbo Weapon Pack",
		text = {
			"Choose {C:attention}1{} out of {C:attention}4{C:weapon} Weapons",
			"to apply to your Jokers",
		},
		group_name = "Weapon Pack",
	},
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
	loc_txt = {
		name = "Mega Weapon Pack",
		text = {
			"Choose {C:attention}2{} out of {C:attention}4{C:weapon} Weapons",
			"to apply to your Jokers",
		},
		group_name = "Weapon Pack",
	},
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