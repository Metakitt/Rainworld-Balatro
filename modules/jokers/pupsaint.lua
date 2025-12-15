SMODS.Joker({
	key = "pupsaint",
	atlas = "slugcats",
	pos = { x = 7, y = 0 },
	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	config = {
		extra = { attuned = false, mult = 0, chips = 0, discards = 10, saint_discards = 10, recharge = false, xmult = 1, recharging = "Ready" },
		name = "Saint",
		slugcat = true,
	},
	loc_vars = function(self, info_queue, card)
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
				card.ability.extra.saint_discards = card.ability.extra.saint_discards - 1
			end
		end
		
		if context.discard and card.ability.extra.saint_discards <= 0 and not context.blueprint then
		card.ability.extra.recharge = true
		card.ability.extra.mult = card.ability.extra.mult + 2
		card.ability.extra.chips = card.ability.extra.chips + 2
		end

		if context.discard
			and card.ability.extra.recharge == true
			and not context.blueprint
		then
			if card.ability.extra.saint_discards < card.ability.extra.discards then
				card.ability.extra.saint_discards = card.ability.extra.saint_discards + 1
			else
				card.ability.extra.recharge = false
			end
		end
	end,
})
