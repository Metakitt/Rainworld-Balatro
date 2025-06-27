SMODS.Joker({
	key = "pathfinder",
	atlas = "slugcats",
	loc_txt = {
		name = "Pathfinder",
		text = {
			"If {C:attention}discard{} is",
			"a {C:attention}Flush{}",
			"gain a random",
			"{C:tarot}Tarot{} card.",
		},
	},
	rarity = 1,
	cost = 4,
	pos = { x = 9, y = 1 },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { type = "Flush" }, slugcat = true },

	calculate = function(self, card, context)
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
								local n_card = SMODS.create_card({ set = "Tarot", area = G.consumeables })
								G.consumeables:emplace(n_card)
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
