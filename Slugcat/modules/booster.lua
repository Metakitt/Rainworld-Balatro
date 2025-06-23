SMODS.Booster({
	key = "usefood_normal_1",
	loc_txt = {
		name = "Regular Food Pack",
		text = {
			"Choose {C:attention}1{} out of {C:attention}3{} Food cards to be used immediately.",
		},
		group_name = "Food Pack",
	},
	kind = "foods",
	atlas = "boosterslug",
	pos = { x = 0, y = 0 },
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
	key = "keepfood_normal_1",
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
