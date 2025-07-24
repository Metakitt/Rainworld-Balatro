SMODS.Joker({
	key = "threat",
	config = {
		extra = {
			enemult = 1,
		},
	},
	rarity = 2,
	cost = 6,
	atlas = "slugcats",
	pos = { x = 6, y = 4 },
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.enemult,
				1 + (SCUG.enemy_count() * card.ability.extra.enemult),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return { xmult = 1 + (SCUG.enemy_count() * card.ability.extra.enemult) }
		end
	end,
})
