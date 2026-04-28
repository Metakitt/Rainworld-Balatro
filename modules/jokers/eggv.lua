SMODS.Joker({
	key = "eggv",
	atlas = "sofanthiel",
	pos = { x = 0, y = 1 },
	rarity = 3,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	attributes = { "slugcat", "economy", "chance", "sell_value" },
	config = { extra = { pupodds = 3, money = 3, blink = false, growth = 3 }, spear_strength = "weak" },

	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "eggv_pick_up", vars = { card.ability.extra.growth } }
		return { vars = { SMODS.get_probability_vars(card, 1, card.ability.extra.pupodds, "rw_eggv") }, slugcat = true }
	end,

	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint and card.ability.extra.growth > 0 then
			card.ability.extra.growth = card.ability.extra.growth - 1
			if card.ability.extra.growth <= 0 then
				card.ability.extra.growth = nil
				card:grow_up({ "j_rw_inv" })
			end
		end

		if
			context.end_of_round
			and context.main_eval
			and SMODS.pseudorandom_probability(card, "rw_eggv", 1, card.ability.extra.pupodds, "rw_eggv")
		then
			card.ability.extra_value = card.ability.extra_value + card.ability.extra.money
			card:set_cost()
			return {
				message = localize('k_val_up'),
				colour = G.C.MONEY
			}
		end
	end,
})
