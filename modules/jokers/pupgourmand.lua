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
	attributes = { "slugcat", "xmult", "scaling", "rw_food", "joker", "destroy_card" },
	config = {
		extra = {
			xmult_mod = 1,
			pupxmult_per_rarity = { 0.1, 0.25, 0.5, 0.75 },
			pupxmult_gain_food = 0.05,
			munch = false,
			growth = 3
		},
		slugcat = true,
		gourmand = true,
		spear_strength = "exhausting"
	},

	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "slugpup_grows_up", vars = { card.ability.extra.growth } }
		return {
			vars = { card.ability.extra.xmult_mod, card.ability.extra.pupxmult_per_rarity[1], card.ability.extra.pupxmult_per_rarity[2], card.ability.extra.pupxmult_gain_food },
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
		if context.card_added and not context.blueprint then
			if context.card:has_attribute("food") then
				card.ability.extra.munch = true
				card.ability.extra.xmult_mod = card.ability.extra.xmult_mod +
					card.ability.extra.pupxmult_per_rarity[context.card.config.center.rarity or 1]
				SMODS.destroy_cards(context.card, true)
			elseif context.card.config.center.set == "foods" then
				card.ability.extra.munch = true
				card.ability.extra.xmult_mod = card.ability.extra.xmult_mod + card.ability.extra.pupxmult_gain_food
				SMODS.destroy_cards(context.card, true)
			end
		end

		if card.ability.extra.munch == true then
			SMODS.calculate_effect({ message = "Crunch", sound = "rw_crunch" }, card)
			delay(0.2)
			card.ability.extra.munch = false
		end
	end,
})
