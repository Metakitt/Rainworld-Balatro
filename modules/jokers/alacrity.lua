SMODS.Joker({
	key = "alacrity",
	atlas = "slugcats",
	pos = { x = 1, y = 3 },
	rarity = 1,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = {}, slugcat = true },

	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,

	calculate = function(self, card, context)
		if context.joker_main and G.GAME.current_round.hands_played == 0 then
			return {
				x_chips = 2,
				-- chip_message = "x2 Chips",
			}
		end
	end,
})
