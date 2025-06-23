-- Things it will eat:
-- Owned Jokers: +2 Mult
-- Owned Consumables: $1
-- Playing Cards from Hand: 20% of Chips or 2 Chips, whichever's higher
-- Any card in the Shop: Nothing!
-- Boosters: +1 Mult per card in the pack
-- Vouchers: +0.5X Mult

SMODS.Joker({
	key = "hunger",
	config = {
		extra = {
			chips = 0,
			mult = 0,
			x_mult = 4,
			munch_chance = 1000,
			grace_reset = 2,
			grace = 10,
			can_munch = true,
		},
	},
	rarity = 3,
	cost = 5,
	atlas = "slugcats",
	pos = { x = 6, y = 3 },
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.chips,
				card.ability.extra.mult,
				card.ability.extra.x_mult,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chips = card.ability.extra.chips,
				mult = card.ability.extra.mult,
				xmult = card.ability.extra.x_mult,
			}
		end
	end,
	update = function(self, card, dt)
		if card.ability.extra.grace > 0 then
			card.ability.extra.grace = card.ability.extra.grace - dt
		end

		if
			#SMODS.find_card("j_rw_hunger") > 0 -- Make sure to replace this with the actual key
			and card.ability.extra.grace <= 0
			and card.ability.extra.can_munch
			and (pseudorandom(pseudoseed("crumchy")) < G.GAME.probabilities.normal / card.ability.extra.munch_chance)
		then
			-- Get all on-screen cards
			local edibles = {}
			-- Shop: Shop cards, booster packs, vouchers
			if G.STATE == G.STATES.SHOP then
				-- local shop_areas = { G.shop_vouchers, G.shop_booster, G.shop_jokers }
				-- for _, area in ipairs(shop_areas) do
				-- 	if area then
				-- 		for _, v in ipairs(area.cards) do
				-- 			table.insert(edibles, v)
				-- 		end
				-- 	end
				-- end
				if G.shop_vouchers then
					for _, voucher in ipairs(G.shop_vouchers.cards) do
						local t = { card = voucher, type = "voucher" }
						table.insert(edibles, t)
					end
				end
				if G.shop_booster then
					for _, booster in ipairs(G.shop_booster.cards) do
						local t = { card = booster, type = "booster" }
						table.insert(edibles, t)
					end
				end
				if G.shop_cards then
					for _, shop_card in ipairs(G.shop_jokers.cards) do
						local t = { card = shop_card, type = "shop_card" }
						table.insert(edibles, t)
					end
				end
			end
			-- In a booster pack: All the cards in said booster
			if
				G.STATE == G.STATES.TAROT_PACK
				or G.STATE == G.STATES.PLANET_PACK
				or G.STATE == G.STATES.SPECTRAL_PACK
				or G.STATE == G.STATES.BUFFOON_PACK
				or G.STATE == G.STATES.STANDARD_PACK
				or G.STATE == G.STATES.SMODS_BOOSTER_OPENED
			then
				if G.pack_cards and G.pack_cards.cards then
					for _, pack_card in ipairs(G.pack_cards.cards) do
						local t = { card = pack_card, type = "pack_card" }
						table.insert(edibles, t)
					end
				end
			end
			-- Actively playing: Cards in hand. NOT cards being scored.
			if G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.HAND_PLAYED then
				if G.hand and G.hand.cards then
					for _, hand_card in ipairs(G.hand.cards) do
						local t = { card = hand_card, type = "hand_card" }
						table.insert(edibles, t)
					end
				end
			end
			-- Any time: Jokers, consumeables
			for _, joker in ipairs(G.jokers.cards) do
				local t = { card = joker, type = "owned_joker" }
				table.insert(edibles, t)
			end
			for _, consum in ipairs(G.consumeables.cards) do
				local t = { card = consum, type = "owned_consumable" }
				table.insert(edibles, t)
			end

			local snack, key = pseudorandom_element(edibles, "crumchy", {})
			if snack and snack.card ~= card then
				sendDebugMessage(snack.card.config.center.key, "Rainworld")
				card.ability.extra.can_munch = false
				if snack.card.ability.eternal then
					G.E_MANAGER:add_event(Event({
						func = function()
							snack.card:set_eternal(false)
							card_eval_status_text(snack.card, "extra", nil, nil, nil, {
								message = "Saved!",
								colour = G.C.ETERNAL,
								instant = instant,
							})
							return true
						end,
					}))
				else
					G.E_MANAGER:add_event(Event({
						func = function()
							card_eval_status_text(snack.card, "extra", nil, nil, nil, {
								message = "Eaten!",
								colour = G.C.RED,
								instant = instant,
							})
							SMODS.destroy_cards(snack.card)
							return true
						end,
					}))
					-- Rewards for your misery
					if snack.type == "owned_joker" then
						local extra_mult = 2
						G.E_MANAGER:add_event(Event({
							delay = 1,
							func = function()
								card_eval_status_text(card, "extra", nil, nil, nil, {
									message = localize({ type = "variable", key = "a_mult", vars = { extra_mult } }),
									colour = G.C.RED,
								})
								card.ability.extra.mult = card.ability.extra.mult + extra_mult
								return true
							end,
						}))
					elseif snack.type == "owned_consumable" then
						G.E_MANAGER:add_event(Event({
							delay = 1,
							func = function()
								card:juice_up()
								ease_dollars(1)
								return true
							end,
						}))
					elseif snack.type == "hand_card" then
						local card_chips = snack.card.base.nominal
							+ snack.card.ability.bonus
							+ snack.card.ability.perma_bonus
						card_chips = math.max(math.floor(card_chips / 5), 2)
						G.E_MANAGER:add_event(Event({
							delay = 1,
							func = function()
								card_eval_status_text(card, "extra", nil, nil, nil, {
									message = localize({ type = "variable", key = "a_chips", vars = { card_chips } }),
									colour = G.C.BLUE,
								})
								card.ability.extra.chips = card.ability.extra.chips + card_chips
								return true
							end,
						}))
					elseif snack.type == "booster" then
						local cards_in_pack = snack.card.config.center.config.extra
						G.E_MANAGER:add_event(Event({
							delay = 1,
							func = function()
								card_eval_status_text(card, "extra", nil, nil, nil, {
									message = localize({ type = "variable", key = "a_mult", vars = { cards_in_pack } }),
									colour = G.C.RED,
								})
								card.ability.extra.mult = card.ability.extra.mult + cards_in_pack
								return true
							end,
						}))
					elseif snack.type == "voucher" then
						G.E_MANAGER:add_event(Event({
							delay = 1,
							func = function()
								card.ability.extra.x_mult = card.ability.extra.x_mult + 0.5
								card_eval_status_text(card, "extra", nil, nil, nil, {
									message = localize({
										type = "variable",
										key = "a_xmult",
										vars = { card.ability.extra.x_mult },
									}),
									colour = G.C.RED,
								})
								return true
							end,
						}))
					end
				end
				G.E_MANAGER:add_event(Event({
					delay = 0.1,
					func = function()
						card.ability.extra.can_munch = true
						return true
					end,
				}))
				card.ability.extra.grace = card.ability.extra.grace_reset * math.min(G.SETTINGS.GAMESPEED, 4)
			end
		end
	end,
})
