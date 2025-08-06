SMODS.Joker({
	key = "hunter",
	atlas = "slugcats",
	pos = { x = 2, y = 0 },
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = true,
	config = {
		extra = { center_table = 1, odds = 10, mult = 0, mult_gain = 8, spear = false },
		slugcat = true,
		second_spear = true,
	},
	blueprint_compat = true,
	perishable_compat = false,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				(G.GAME.probabilities.normal or 1),
				card.ability.extra.odds,
				card.ability.extra.mult,
				card.ability.extra.mult_gain,
			},
		}
	end,

	calculate = function(self, card, context)
		if context.after and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
			SMODS.calculate_effect({ message = localize("k_upgrade_ex") }, card)
		end

		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
			}
		end

		if
			context.setting_blind
			and pseudorandom("hunterhell") < G.GAME.probabilities.normal / card.ability.extra.odds
			and G.GAME.round_resets.blind_ante < 8
			and not context.blueprint
		then
			card.ability.extra.center_table = 1
			ease_ante(card.ability.extra.center_table)
			G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
			G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + card.ability.extra.center_table
		end
	end,
})
