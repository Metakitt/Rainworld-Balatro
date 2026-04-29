SMODS.Joker({
	key = "arsenal",
	config = {
		extra = {
			wep_mult = 3,
		},
		slugcat = true
	},
	rarity = 1,
	cost = 5,
	atlas = "slugcats",
	pos = { x = 0, y = 4 },
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "slugcat", "weapon", "mult" },
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.wep_mult,
				card.ability.extra.wep_mult * SCUG.num_owned_weapons(),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult = card.ability.extra.wep_mult * SCUG.num_owned_weapons(),
			}
		end
	end,
})
