SMODS.Joker({
	key = "spearmaster",
	atlas = "slugcats",
	pos = { x = 5, y = 0 },
	rarity = 3,
	cost = 8,
	config = { extra = { xmult = 3, should_score = true }, slugcat = true, second_spear = true },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult } }
	end,

	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			-- Don't trigger if there is no enhancement
			if context.other_card.config.center == G.P_CENTERS.c_base then
				card.ability.extra.should_score = false
			end
		elseif context.joker_main then
			if card.ability.extra.should_score == true then
				-- Mult time baybee!!!
				return { xmult = card.ability.extra.xmult }
			end
		elseif context.after and context.cardarea == G.jokers then
			-- Reset trigger flag for next hand
			card.ability.extra.should_score = true
		end
	end,
})
