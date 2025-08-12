SMODS.Joker({
	key = "stupid_wet_rat",
	config = {
		extra = {
			wet_xchips = 0.1,
		},
		slugcat = true
	},
	rarity = 1,
	cost = 4,
	atlas = "slugcats",
	pos = { x = 4, y = 4 },
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		local wet_count, _ = SCUG.enhancement_count("m_rw_wetasscard")
        return {
			vars = {
				card.ability.extra.wet_xchips,
				1 + (wet_count * card.ability.extra.wet_xchips),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
            local wet_count, _ = SCUG.enhancement_count("m_rw_wetasscard")
			return { xchips = 1 + (wet_count * card.ability.extra.wet_xchips) }
		end
	end,
})
