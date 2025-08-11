SMODS.Enhancement({
	key = "rotting",
	config = { bonus = -25, countdown_to_destruction = 5 },
	atlas = "enhancedcards_scug",
	pos = { x = 0, y = 0 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.countdown_to_destruction, card.ability.bonus } }
	end,
	weight = 5,
	in_pool = function(self, args)
		if args and args.source == "sta" then
			return true
		else
			return false
		end
	end,
})


SMODS.Enhancement({
	key = "wetasscard",
	config = { x_chips = 1.5, countdown_to_dry = 5 },
	atlas = "enhancedcards_scug",
	pos = { x = 2, y = 0 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.x_chips, card.ability.countdown_to_dry } }
	end,
	weight = 5,
	always_scores = true,
})
