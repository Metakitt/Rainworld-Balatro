local common_keys = {
	"j_popcorn",
	"j_cavendish",
	"j_gros_michel",
	"j_ice_cream",
	"j_egg",
}
local uncommon_keys = {
	"j_seltzer",
	"j_flower_pot",
	"j_ramen",
	"j_diet_cola",
	"j_turtle_bean",
}

SMODS.Joker({
	key = "gourmand",
	atlas = "slugcats",
	pos = { x = 4, y = 0 },
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	perishable_compat = false,
	config = {
		extra = {
			xmult_mod = 1,
			xmult_gain_common = 0.25,
			xmult_gain_uncommon = 0.5,
			xmult_gain_food = 0.1,
			munch = false,
		},
		slugcat = true,
	},

	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult_gain_common, card.ability.extra.xmult_gain_uncommon, card.ability.extra.xmult_gain_food },
		}
	end,

	calculate = function(self, card, context)
		if context.joker_main then
			return {
				xmult = card.ability.extra.xmult_mod,
			}
		end

		if context.main_eval and not context.blueprint then
			for _, center in ipairs(common_keys) do
				if #SMODS.find_card(center, true) then
					for _, v in pairs(SMODS.find_card(center, true)) do
						if not v.getting_sliced then
							v:start_dissolve()
							card.ability.extra.xmult_mod = card.ability.extra.xmult_mod
								+ card.ability.extra.xmult_gain_common
							card.ability.extra.munch = true
							v.getting_sliced = true
						end
					end
				end
			end
			for _, center in ipairs(uncommon_keys) do
				if #SMODS.find_card(center, true) then
					for _, v in pairs(SMODS.find_card(center, true)) do
						if not v.getting_sliced then
							v:start_dissolve()
							card.ability.extra.xmult_mod = card.ability.extra.xmult_mod
								+ card.ability.extra.xmult_gain_uncommon
							card.ability.extra.munch = true
							v.getting_sliced = true
						end
					end
				end
			end
			for _, _card in ipairs(G.consumeables.cards) do
				if _card.config and _card.config.center and _card.config.center.set == "foods" then
					if not _card.getting_sliced then
						_card:start_dissolve()
						card.ability.extra.xmult_mod = card.ability.extra.xmult_mod + card.ability.extra.xmult_gain_food
						card.ability.extra.munch = true
						_card.getting_sliced = true
					end
				end
			end
		end

		if card.ability.extra.munch == true then
			SMODS.calculate_effect({ message = "Crunch", sound = "rw_crunch" }, card)
			delay(0.2)
			card.ability.extra.munch = false
		end
	end,
})
