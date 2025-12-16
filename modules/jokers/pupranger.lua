SMODS.Joker({
	key = "pupranger",
	atlas = "slugcats",
	pos = { x = 1, y = 6 },
	rarity = 3,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { jslot = 1 , growth = 3}, slugcat = true },
	loc_vars = function(self, info_queue, card)
	info_queue[#info_queue + 1] = { set = "Other", key = "slugpup_grows_up", vars = { card.ability.extra.growth } }
	end,
	add_to_deck = function(self, card, from_debuff)
		if G.jokers then
			G.jokers.config.card_limit = G.jokers.config.card_limit + 1
		end
	end,

	remove_from_deck = function(self, card, from_debuff)
		if G.jokers then
			G.jokers.config.card_limit = G.jokers.config.card_limit - 1
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
	end
})
