SMODS.Joker({
	key = "pupranger",
	atlas = "slugcats",
	pos = { x = 1, y = 6 },
	rarity = 3,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	attributes = { "slugcat", "slugpup", "joker_slot", "passive" },
	config = { extra = { jslot = 1, growth = 3 }, slugcat = true, card_limit = 1 },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "slugpup_grows_up", vars = { card.ability.extra.growth } }
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint and card.ability.extra.growth > 0 then
			card.ability.extra.growth = card.ability.extra.growth - 1
			if card.ability.extra.growth <= 0 then
				card.ability.extra.growth = nil
				card:grow_up()
			end
		end
	end,
	in_pool = function(self, args)
		return args.source ~= "sho"
	end,
})
