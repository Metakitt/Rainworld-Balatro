SMODS.Joker({
	key = "blurred",
	atlas = "slugcats",
	rarity = 2,
	cost = 4,
	pos = { x = 9, y = 2 },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { odds = 20 }, slugcat = true },
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "rw_blurred")
		return { vars = { numerator, denominator }}
	end,
	calculate = function(self, card, context)
		if context.joker_main and not context.blueprint then
			return {
				swap = true,
			}
		end

		if context.setting_blind then
			if SMODS.pseudorandom_probability(card, "rw_blurred", 1, card.ability.extra.odds, "rw_blurred") then
				G.GAME.blind.chips = G.GAME.blind.chips / 2
				G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			end
		end
	end,
})
