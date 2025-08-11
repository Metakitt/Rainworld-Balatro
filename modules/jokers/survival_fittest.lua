SMODS.Joker({
	key = "surv_fittest",
	config = {
		extra = {
			cash_per_kill = 2,
		},
	},
	rarity = 1,
	cost = 5,
	atlas = "slugcats",
	pos = { x = 9, y = 4 },
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.cash_per_kill,
				card.ability.extra.cash_per_kill * (G.GAME and G.GAME.rw_enemies_slain or 0),
			},
		}
	end,
	calc_dollar_bonus = function(self, card)
		local kills = (G.GAME and G.GAME.rw_enemies_slain or 0)
		if kills > 0 then
			return card.ability.extra.cash_per_kill * kills
		end
	end,
})
