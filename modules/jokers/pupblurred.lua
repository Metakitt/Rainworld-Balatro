SMODS.Joker({
	key = "pupblurred",
	atlas = "slugcats",
	rarity = 2,
	cost = 4,
	pos = { x = 8, y = 5 },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { pupodds = 30, growth = 3 }, slugcat = true },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "slugpup_grows_up", vars = { card.ability.extra.growth } }
		return { vars = { SMODS.get_probability_vars(card, 1, card.ability.extra.pupodds, "rw_blurred") } }
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			if SMODS.pseudorandom_probability(card, "rw_blurred", 1, card.ability.extra.pupodds, "rw_blurred") then
				G.GAME.blind.chips = G.GAME.blind.chips / 2
				G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			end
		end

		if context.setting_blind and not context.blueprint and card.ability.extra.growth > 0 then
			card.ability.extra.growth = card.ability.extra.growth - 1
			if card.ability.extra.growth <= 0 then
				card.ability.extra.growth = nil
				card:grow_up()
			end
		end
	end,
})
