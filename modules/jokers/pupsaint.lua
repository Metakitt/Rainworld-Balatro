SMODS.Joker({
	key = "pupsaint",
	atlas = "slugcats",
	pos = { x = 7, y = 5 },
	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	attributes = { "slugcat", "discard", "mult", "chips", spear_strength = "weak" },
	config = {
		extra = { attuned = false, mult = 0, chips = 0, pupgain = 2, pupdiscards = 10, pupsaint_discards = 10, recharge = false, xmult = 1, recharging = "Ready", growth = 3 },
		name = "Saint",
		slugcat = true,
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "slugpup_grows_up", vars = { card.ability.extra.growth } }
		return {
			vars = { card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.pupdiscards, card.ability.extra.pupsaint_discards, card.ability.extra.pupgain },
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

		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
				chips = card.ability.extra.chips,
			}
		end

		if context.discard
			and card.ability.extra.recharge == false
			and not context.blueprint
		then
			card.ability.extra.pupsaint_discards = card.ability.extra.pupsaint_discards - 1
		end


		if context.discard and card.ability.extra.pupsaint_discards <= 0 and not context.blueprint then
			card.ability.extra.recharge = true
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "mult",
				scalar_value = "pupgain",
				no_message = true
			})
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "chips",
				scalar_value = "pupgain",
				message_colour = G.C.PURPLE
			})
		end

		if context.discard
			and card.ability.extra.recharge == true
			and not context.blueprint
		then
			if card.ability.extra.pupsaint_discards < card.ability.extra.pupdiscards then
				card.ability.extra.pupsaint_discards = card.ability.extra.pupsaint_discards + 1
			else
				card.ability.extra.recharge = false
			end
		end
	end,
})
