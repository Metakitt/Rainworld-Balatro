SMODS.Joker({
	key = "abundance",
	atlas = "slugcats",
	pos = { x = 9, y = 0 },
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,

	calculate = function(self, card, context)
		if
			context.setting_blind
			and context.main_eval
			and G.jokers.config.card_limit <= #G.jokers.cards
			and G.consumeables.config.card_limit > #G.consumeables.cards
		then
			local n_card = SMODS.create_card({ set = "foods", area = G.consumeables })
			G.consumeables:emplace(n_card)
		elseif context.setting_blind and context.main_eval and G.jokers.config.card_limit > #G.jokers.cards then
			SMODS.add_card({ set = "Joker", area = G.jokers, key = "j_rw_slugpup" })
		end
	end,
})
