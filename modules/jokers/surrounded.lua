SMODS.Joker({
	key = "surrounded",
	config = {
		extra = {
			price_mult = 0.5,
		},
	},
	rarity = 3,
	cost = 8,
	atlas = "slugcats",
	pos = { x = 7, y = 4 },
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		local surrounded = G.jokers and (SCUG.enemy_count() / #G.jokers.cards > 0.5) or false
		return {
			vars = {
				surrounded and "active" or "inactive",
				colours = {
					surrounded and G.C.GREEN or G.C.RED,
				},
			},
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			G.jokers.config.card_limit = G.jokers.config.card_limit + SCUG.enemy_count()
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if not from_debuff then
			G.jokers.config.card_limit = G.jokers.config.card_limit - SCUG.enemy_count()
		end
	end,
	calculate = function(self, card, context)
		if not context.blueprint and context.cardarea == G.jokers then
			if card:can_calculate() and context.starting_shop or context.reroll_shop then
				local surrounded = G.jokers and (SCUG.enemy_count() / #G.jokers.cards > 0.5) or false
				if surrounded then
					G.E_MANAGER:add_event(Event({
						func = function()
							for _, v in pairs(G.shop_jokers.cards) do
								if not v.rw_ambush_discount then
									v.cost = math.max(1, math.floor(v.cost / 2))
									v.sell_cost = math.max(1, math.floor(v.cost / 2))
									v.rw_ambush_discount = true
								end
							end
							for _, v in pairs(G.shop_booster.cards) do
								if not v.rw_ambush_discount then
									v.cost = math.max(1, math.floor(v.cost / 2))
									v.sell_cost = math.max(1, math.floor(v.cost / 2))
									v.rw_ambush_discount = true
								end
							end
							card:juice_up()
							return true
						end,
					}))
				end
			end
		end

		if
			context.card_added
			and not context.blueprint
			and context.card.config.center.set == "Joker"
			and context.card.config.center.rarity == "rw_enemy"
		then
			G.jokers.config.card_limit = G.jokers.config.card_limit + 1
		end
		if
			context.joker_type_destroyed
			and not context.blueprint
			and context.card.config.center.set == "Joker"
			and context.card.config.center.rarity == "rw_enemy"
		then
			print(context.card.config.center.set)
			print(context.card.config.center.rarity)
			G.jokers.config.card_limit = G.jokers.config.card_limit - 1
		end
	end,
})
