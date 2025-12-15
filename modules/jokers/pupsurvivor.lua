SMODS.Joker({
	key = "pupsurvivor",
	atlas = "slugcats",
	pos = { x = 3, y = 0 },
	rarity = 3,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { h_size = 0, h_mod = 1, odds = 5, growth = 0 }, slugcat = true },

	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "rw_survivor")
		return {
			vars = {
				numerator, denominator,
				card.ability.extra.h_mod,
				card.ability.extra.h_size,
			},
		}
	end,

	calculate = function(self, card, context)
	
	if context.setting_blind and card.ability.extra.growth < 3 then
	card.ability.extra.growth = card.ability.extra.growth + 1
	end
	
	if card.ability.extra.growth >= 3 then
    local ability = copy_table(card.ability)
    card:set_ability('j_rw_survivor')
    card.ability = ability
	end
	
		if
			G.GAME.last_blind.boss
			and context.end_of_round
			and context.main_eval
			and SMODS.pseudorandom_probability(card, "rw_survivor", 1, card.ability.extra.odds, "rw_survivor")
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