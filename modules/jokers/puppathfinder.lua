SMODS.Joker({
	key = "puppathfinder",
	atlas = "slugcats",
	rarity = 1,
	cost = 4,
	pos = { x = 9, y = 5 },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	attributes = { "slugcat", "hand_type", "generation", "tarot", "discard" },
	config = { extra = { type = "Flush", growth = 3 }, slugcat = true },
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

		if
			context.pre_discard
			and G.consumeables.config.card_limit ~= #G.consumeables.cards
			and not context.blueprint
		then
			if G.FUNCS.get_poker_hand_info(G.hand.highlighted) == card.ability.extra.type then
				G.E_MANAGER:add_event(Event({
					func = function()
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.7,
							blockable = false,
							func = function()
								SMODS.add_card { set = "Tarot", area = G.consumeables }
								return true
							end,
						}))
						return true
					end,
				}))
			end
		end
	end,
})
