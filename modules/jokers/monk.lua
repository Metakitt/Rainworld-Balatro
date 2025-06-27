SMODS.Joker({
	key = "monk",
	atlas = "slugcats",
	pos = { x = 0, y = 0 },
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { center_table = -1, odds = 10 }, slugcat = true },

	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,

	calculate = function(self, card, context)
		if
			context.setting_blind
			and pseudorandom("monkpacifist") < G.GAME.probabilities.normal / card.ability.extra.odds
		then
			card.ability.extra.center_table = -1
			ease_ante(card.ability.extra.center_table)
			G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
			G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + card.ability.extra.center_table
		end
	end,
})
