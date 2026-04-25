SMODS.Joker({
	key = "pupenfys",
	atlas = "slugcats",
	loc_txt = {
		name = "Enfys pup",
		text = {
			"At the {C:attention}end of round{},",
			"creates a random,",
			"{C:edition}negative{} Food Consumeable.",
		},
	},
	pos = { x = 4, y = 6 },
	rarity = 3,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	attributes = { "slugcat", "generation", "rw_food" },
	config = { extra = { food = "none", growth = 3}, slugcat = true },
	loc_vars = function(self, info_queue, card)
	info_queue[#info_queue + 1] = { set = "Other", key = "slugpup_grows_up", vars = { card.ability.extra.growth } }
	end,
	calculate = function(self, card, context)
	if context.setting_blind and not context.blueprint and card.ability.extra.growth > 0 then
			card.ability.extra.growth = card.ability.extra.growth - 1
			if card.ability.extra.growth <= 0 then
				card.ability.extra.growth = nil
				card:grow_up()
			end
		end

		if context.end_of_round and context.main_eval then
			SMODS.add_card({ set = "foods", area = G.consumeables, edition = "e_negative" })
		end
	end,
})
