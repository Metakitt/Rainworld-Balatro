SMODS.Joker({
	key = "pupsaint",
	atlas = "slugcats",
	pos = { x = 7, y = 5 },
	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	config = {
		extra = { attuned = false, mult = 0, chips = 0, pupdiscards = 10, pupsaint_discards = 10, recharge = false, xmult = 1, recharging = "Ready", growth = 3},
		name = "Saint",
		slugcat = true,
	},
	loc_vars = function(self, info_queue, card)
	info_queue[#info_queue + 1] = { set = "Other", key = "slugpup_grows_up", vars = { card.ability.extra.growth } }
	end,

	calculate = function(self, card, context)
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
			card.ability.extra.mult = card.ability.extra.mult + 2
			card.ability.extra.chips = card.ability.extra.chips + 2
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
