SMODS.Joker({
	key = "pupsurvivor",
	atlas = "slugcats",
	pos = { x = 3, y = 0 },
	rarity = 3,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { h_size = 0, h_mod = 1, pupodds = 5, growth = 3 }, slugcat = true },

	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "slugpup_grows_up", vars = { card.ability.extra.growth } }

		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.pupodds, "rw_survivor")
		return {
			vars = {
				numerator, denominator,
				card.ability.extra.h_mod,
				card.ability.extra.h_size,
			},
		}
	end,

	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint and card.ability.extra.growth > 0 then
			card.ability.extra.growth = card.ability.extra.growth - 1
			if card.ability.extra.growth <= 0 then
				card.ability.extra.growth = nil
				card:grow_up()
			end
		end
		
		if
			G.GAME.last_blind.boss
			and context.end_of_round
			and context.main_eval
			and SMODS.pseudorandom_probability(card, "rw_survivor", 1, card.ability.extra.pupodds, "rw_survivor")
		then
			G.hand:change_size(-card.ability.extra.h_size)
			card.ability.extra.h_size = card.ability.extra.h_size + card.ability.extra.h_mod
			G.hand:change_size(card.ability.extra.h_size)
			return {
				message = localize("k_upgrade_ex"),
				colour = G.C.MULT,
			}
		end
	end,
})

--growth_temp_hsize = 0
