-- Things it will eat:
-- Owned Jokers:
-- -- Rotting Jokers: +5 Mult. Prioritized.
-- -- Not Rotting Jokers: +2 Mult
-- -- Enemies:
-- -- -- Not Rot Enemies: Random boost (+3 Mult, +5 Chips, 0.1X Mult, $2 - $5, Gain a weapon)
-- -- -- Rot Enemies: Increase boost (+7 Mult, +12 Chips, 0.25X Mult, $5 - $11, Gain a weapon and spawn a Weapon Card). Prioritized.
-- Owned Consumables:
-- -- Weapon Card: Gain the weapon. If owned, +2 Mult.
-- -- Food Card: +5 Chips.
-- -- Other: Half the sell value (max of $1)
-- Playing Cards from Hand:
-- -- Not Rot cards: 20% of Chips or 2 Chips, whichever's higher
-- -- Rot cards: 20% of abs(Chips) or 4 Chips, whichever's's higher. Prioritized.
-- Any card in the Shop: Nothing!
-- Cards in opened packs: Nothing!
-- Boosters: +1 Mult per card in the pack
-- Vouchers: +0.5X Mult

-- With apologies to Doctor Flamingo.

-- You want lore? Okay.
-- Hunger is a Slugcat made, or probably genetically engineered, by Five Pebbles.
-- Hunger was made to be infinitely hungry as a direct solution to the Rot problem.
-- Making an infinitely hungry creature in response to an infinitely hungry threat is an awful idea.
-- Regardless, Hunger accomplishes this purpose well enough, so is left to its own devices.
-- Hunger then, at some point, simply falls out of the superstructure via a combination of pipe travel and holes.
-- Hunger is an invasive species. It was not meant to exist outside of Five Pebbles.
-- But since it does, it's gonna eat. That's all it wants and needs to do, after all.

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
		slugcat = true,
	},
	rarity = 3,
	cost = 5,
	atlas = "slugcats",
	pos = { x = 6, y = 3 },
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
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
			#SMODS.find_card("j_rw_hunger") > 0
			and card.ability.extra.grace <= 0
			and card.ability.extra.can_munch
			and (pseudorandom(pseudoseed("crumchy")) < G.GAME.probabilities.normal / card.ability.extra.munch_chance)
		then
			-- Get all on-screen cards
			local rot_edibles = {}
			local edibles = {}
			-- Shop: Shop cards, booster packs, vouchers
			if G.STATE == G.STATES.SHOP then
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
						if hand_card.config.center_key == "m_rw_rotting" then
							t.rot = true
						end
						table.insert(edibles, t)
					end
				end
			end
			-- Any time: Jokers, consumeables
			for _, joker in ipairs(G.jokers.cards) do
				local t = { card = joker, type = "owned_joker" }
				if joker.ability.rw_rotted or (string.find(joker.config.center_key, "longlegs")) then
					t.rot = true
				end
				if joker.config.center.rarity == "rw_enemy" then
					t.type = "enemy"
				end
				table.insert(edibles, t)
			end
			for _, consum in ipairs(G.consumeables.cards) do
				local t = { card = consum, type = "owned_consumable" }
				if consum.config.center.set == "foods" then
					t.type = "food"
				end
				if consum.config.center.set == "obtainweapon" then
					t.type = "weapon"
				end
				table.insert(edibles, t)
			end

			for _, v in ipairs(edibles) do
				if v.rot then
					table.insert(rot_edibles, v)
				end
			end

			local snack, key = pseudorandom_element(#rot_edibles > 0 and rot_edibles or edibles, "crumchy", {})
			if snack and snack.card ~= card then
				-- sendDebugMessage(snack.card.config.center.key, "Rainworld")
				-- sendDebugMessage(snack.type, "Rainworld")
				local rot_boost = snack.rot or false
				card.ability.extra.can_munch = false
				if snack.card.ability.eternal then
					G.E_MANAGER:add_event(Event({
						func = function()
							snack.card:set_eternal(false)
							card_eval_status_text(snack.card, "extra", nil, nil, nil, {
								message = localize("k_saved_ex"),
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
								message = localize("k_eaten_ex"),
								colour = G.C.RED,
								instant = instant,
							})
							SMODS.destroy_cards(snack.card)
							return true
						end,
					}))
					-- Rewards for your misery
					if snack.type == "owned_joker" then
						local extra_mult = rot_boost and 5 or 2
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
								ease_dollars(math.max(1, math.floor(snack.card.sell_cost / 2)))
								return true
							end,
						}))
					elseif snack.type == "weapon" then
						local weapon = string.sub(snack.card.config.center_key, 6)
						local weapon_key = "rw_w" .. weapon
						if weapon_key then
							if card.ability[weapon_key] then
								G.E_MANAGER:add_event(Event({
									delay = 1,
									func = function()
										card_eval_status_text(card, "extra", nil, nil, nil, {
											message = localize({ type = "variable", key = "a_mult", vars = { 2 } }),
											colour = G.C.RED,
										})
										card.ability.extra.mult = card.ability.extra.mult + 2
										return true
									end,
								}))
							else
								G.E_MANAGER:add_event(Event({
									func = function()
										SMODS.Stickers[weapon_key]:apply(card, true)
										card_eval_status_text(card, "extra", nil, nil, nil, {
											message = localize("k_plus_weapon"),
											colour = G.C.WEAPON,
										})
										return true
									end,
								}))
							end
						end
					elseif snack.type == "food" then
						G.E_MANAGER:add_event(Event({
							delay = 1,
							func = function()
								card_eval_status_text(card, "extra", nil, nil, nil, {
									message = localize({ type = "variable", key = "a_chips", vars = { 5 } }),
									colour = G.C.BLUE,
								})
								card.ability.extra.chips = card.ability.extra.chips + 5
								return true
							end,
						}))
					elseif snack.type == "hand_card" then
						local card_chips = snack.card.base.nominal
							+ snack.card.ability.bonus
							+ snack.card.ability.perma_bonus
						if rot_boost then
							card_chips = math.abs(card_chips)
						end
						card_chips = math.max(math.floor(card_chips / 5), rot_boost and 4 or 2)
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
					-- Actually useful
					elseif snack.type == "enemy" then
						local MULT = rot_boost and 7 or 3
						local CHIPS = rot_boost and 12 or 5
						local XMULT = rot_boost and 0.25 or 0.1
						local CASH = rot_boost and SCUG.number_in_range(5, 11) or SCUG.number_in_range(2, 5)
						local options = {
							"weapon",
							"mult",
							"chips",
							"cash",
							"xmult",
							"mult",
							"chips",
							"cash",
							"mult",
							"chips",
							"cash",
							"xmult",
							"weapon",
						}
						local reward = pseudorandom_element(options, pseudoseed("rw_hunger_enemy_bonus"))

						if reward == "mult" then
							G.E_MANAGER:add_event(Event({
								delay = 1,
								func = function()
									card_eval_status_text(card, "extra", nil, nil, nil, {
										message = localize({ type = "variable", key = "a_mult", vars = { MULT } }),
										colour = G.C.RED,
									})
									card.ability.extra.mult = card.ability.extra.mult + MULT
									return true
								end,
							}))
						elseif reward == "chips" then
							G.E_MANAGER:add_event(Event({
								delay = 1,
								func = function()
									card_eval_status_text(card, "extra", nil, nil, nil, {
										message = localize({ type = "variable", key = "a_chips", vars = { CHIPS } }),
										colour = G.C.BLUE,
									})
									card.ability.extra.chips = card.ability.extra.chips + CHIPS
									return true
								end,
							}))
						elseif reward == "xmult" then
							G.E_MANAGER:add_event(Event({
								delay = 1,
								func = function()
									card.ability.extra.x_mult = card.ability.extra.x_mult + XMULT
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
						elseif reward == "cash" then
							G.E_MANAGER:add_event(Event({
								delay = 1,
								func = function()
									card:juice_up()
									ease_dollars(CASH)
									return true
								end,
							}))
						elseif reward == "weapon" then
							local earned_weapon, _ =
								pseudorandom_element(G.P_CENTER_POOLS.obtainweapon, pseudoseed("rw_hunger_weapon"))
							local weapon_key = earned_weapon.key
							if card.ability[weapon_key] then
								G.E_MANAGER:add_event(Event({
									delay = 1,
									func = function()
										card_eval_status_text(card, "extra", nil, nil, nil, {
											message = localize({ type = "variable", key = "a_mult", vars = { MULT } }),
											colour = G.C.RED,
										})
										card.ability.extra.mult = card.ability.extra.mult + MULT
										return true
									end,
								}))
							else
								G.E_MANAGER:add_event(Event({
									func = function()
										SMODS.Stickers[weapon_key]:apply(card, true)
										card_eval_status_text(card, "extra", nil, nil, nil, {
											message = localize("k_plus_weapon"),
											colour = G.C.WEAPON,
										})
										return true
									end,
								}))
							end
							if rot_boost then
								G.E_MANAGER:add_event(Event({
									delay = 1,
									func = function()
										SMODS.add_card({ set = "obtainweapon", area = G.consumeables })
										return true
									end,
								}))
							end
						end
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
