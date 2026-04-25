SMODS.Joker({
	key = "pupmonk",
	atlas = "slugcats",
	pos = { x = 1, y = 5 },
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	attributes = { "slugcat", "chance", "ante" },
	config = { extra = { center_table = -1, pupodds = 20, growth = 3 }, slugcat = true },

	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "slugpup_grows_up", vars = { card.ability.extra.growth } }
		return { vars = { SMODS.get_probability_vars(card, 1, card.ability.extra.pupodds, "rw_monk") } }
	end,

	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint and card.ability.extra.growth > 0 then
			card.ability.extra.growth = card.ability.extra.growth - 1
			if card.ability.extra.growth <= 0 then
				card.ability.extra.growth = nil
				card:grow_up()
				return
			end
		end

		if
			context.setting_blind
			and SMODS.pseudorandom_probability(card, "rw_monk", 1, card.ability.extra.pupodds, "rw_monk")
		then
			card.ability.extra.center_table = -1
			ease_ante(card.ability.extra.center_table)
			G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
			G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + card.ability.extra.center_table
		end
	end,
})
