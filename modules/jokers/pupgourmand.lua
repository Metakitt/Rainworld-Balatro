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
	key = "pupgourmand",
	atlas = "slugcats",
	pos = { x = 4, y = 5 },
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	perishable_compat = false,
	attributes = { "slugcat", "xmult", "scaling", "food", "destroy_card" },
	config = {
		extra = {
			xmult_mod = 1,
			pupxmult_gain_common = 0.1,
			pupxmult_gain_uncommon = 0.25,
			pupxmult_gain_food = 0.05,
			munch = false,
			growth = 3
		},
		slugcat = true,
		gourmand = true,
	},

	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "slugpup_grows_up", vars = { card.ability.extra.growth } }
		return {
			vars = { card.ability.extra.xmult_mod, card.ability.extra.pupxmult_gain_common, card.ability.extra.pupxmult_gain_uncommon, card.ability.extra.pupxmult_gain_food },
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		local hungerchance = SCUG.number_in_range(1, 666, "ohfuck")
		if hungerchance == 666 then
			SMODS.add_card({ set = "Joker", area = G.jokers, key = "j_rw_eater" })
			for k, v in ipairs(G.jokers.cards) do
				if v.ability.hunger then
					v.ability.extra.x_mult = v.ability.extra.x_mult + 1
				end
			end
		end
	end,

	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint and card.ability.extra.growth > 0 then
			card.ability.extra.growth = card.ability.extra.growth - 1
			if card.ability.extra.growth <= 0 then
				card.ability.extra.growth = nil
				card:grow_up()
			end
		end

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
								+ card.ability.extra.pupxmult_gain_common
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
								+ card.ability.extra.pupxmult_gain_uncommon
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
						card.ability.extra.xmult_mod = card.ability.extra.xmult_mod + card.ability.extra.pupxmult_gain_food
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
