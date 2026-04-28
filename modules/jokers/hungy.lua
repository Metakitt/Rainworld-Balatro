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
-- -- Other: Half the sell value (min of $1)
-- Playing Cards from Hand:
-- -- Not Rot cards: 20% of Chips or 2 Chips, whichever's higher
-- -- Rot cards: 20% of abs(Chips) or 4 Chips, whichever's higher. Prioritized.
-- Any card in the Shop: Nothing!
-- Cards in opened packs: Nothing!
-- Boosters: +1 Mult per card in the pack
-- Vouchers: +0.5X Mult

-- You want lore? Okay.
-- Hunger is a Slugcat made, or probably genetically engineered, by Five Pebbles.
-- Hunger was made to be infinitely hungry as a direct solution to the Rot problem.
-- Making an infinitely hungry creature in response to an infinitely hungry threat is an awful idea.
-- Regardless, Hunger accomplishes this purpose well enough, so is left to its own devices.
-- Hunger then, at some point, simply falls out of the superstructure via a combination of pipe travel and holes.
-- Hunger is an invasive species. It was not meant to exist outside of Five Pebbles.
-- But since it does, it's gonna eat. That's all it wants and needs to do, after all.

local hunger_bonus = {
	normal = {
		mult = 2,
		chips = 2,
		x_mult = 0.5,
		food_chips = 5
	},
	normal_boosted = {
		mult = 5,
		chips = 4,
	},
	enemy = {
		mult = 3,
		chips = 5,
		x_mult = 0.1,
		cash_min = 2,
		cash_max = 5
	},
	enemy_boosted = {
		mult = 7,
		chips = 12,
		x_mult = 0.25,
		cash_min = 5,
		cash_max = 11
	}
}

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
		hunger = true,
	},
	rarity = 3,
	cost = 5,
	atlas = "slugcats",
	pos = { x = 6, y = 3 },
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	attributes = { "slugcat", "chips", "mult", "xmult", "destroy_card", "economy", "generation" },
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
			and SMODS.pseudorandom_probability(card, "rw_hunger", 1, card.ability.extra.munch_chance, "rw_hunger")
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
				local rot_boost = snack.rot or false
				card.ability.extra.can_munch = false
				if snack.card.ability.eternal then
					G.E_MANAGER:add_event(Event({
						func = function()
							SMODS.Stickers["eternal"]:apply(snack.card, false)
							SMODS.calculate_effect({
								message = localize("k_saved_ex"),
								colour = G.C.ETERNAL,
							}, snack.card)
							return true
						end,
					}))
				else
					G.E_MANAGER:add_event(Event({
						func = function()
							SMODS.calculate_effect({
								message = localize("k_eaten_ex"),
								colour = G.C.RED,
							}, snack.card)
							SMODS.destroy_cards(snack.card)
							return true
						end,
					}))
					-- Rewards for your misery
					if snack.type == "owned_joker" then
						G.E_MANAGER:add_event(Event({
							delay = 1,
							func = function()
								SMODS.scale_card(card, {
									ref_table = card.ability.extra,
									ref_value = "mult",
									scalar_table = hunger_bonus["normal" .. (rot_boost and "_boosted" or "")],
									scalar_value = "mult",
									message_key = "a_mult",
									message_colour = G.C.MULT
								})
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
										SMODS.scale_card(card, {
											ref_table = card.ability.extra,
											ref_value = "mult",
											scalar_table = hunger_bonus["normal"],
											scalar_value = "mult",
											message_key = "a_mult",
											message_colour = G.C.MULT
										})
										return true
									end,
								}))
							else
								G.E_MANAGER:add_event(Event({
									func = function()
										SMODS.Stickers[weapon_key]:apply(card, true)
										SMODS.calculate_effect(
											{ message = localize("k_plus_weapon"), colour = G.C.WEAPON }, card)
										return true
									end,
								}))
							end
						end
					elseif snack.type == "food" then
						G.E_MANAGER:add_event(Event({
							delay = 1,
							func = function()
								SMODS.scale_card(card, {
									ref_table = card.ability.extra,
									ref_value = "chips",
									scalar_table = hunger_bonus["normal"],
									scalar_value = "food_chips",
									message_key = "a_chips",
									message_colour = G.C.CHIPS
								})
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
						G.E_MANAGER:add_event(Event({
							delay = 1,
							func = function()
								SMODS.scale_card(card, {
									ref_table = card.ability.extra,
									ref_value = "chips",
									scalar_table = hunger_bonus["normal" .. (rot_boost and "_boosted" or "")],
									scalar_value = "chips",
									operation = function(ref_table, ref_value, initial, change)
										ref_table[ref_value] = initial + math.max(math.floor(card_chips / 5), change)
									end,
									message_key = "a_chips",
									message_colour = G.C.CHIPS
								})
								return true
							end,
						}))
					elseif snack.type == "booster" then
						G.E_MANAGER:add_event(Event({
							delay = 1,
							func = function()
								SMODS.scale_card(card, {
									ref_table = card.ability.extra,
									ref_value = "mult",
									scalar_table = snack.card.config.center.config,
									scalar_value = "extra",
									message_key = "a_mult",
									message_colour = G.C.MULT
								})
								return true
							end,
						}))
					elseif snack.type == "voucher" then
						G.E_MANAGER:add_event(Event({
							delay = 1,
							func = function()
								SMODS.scale_card(card, {
									ref_table = card.ability.extra,
									ref_value = "x_mult",
									scalar_table = hunger_bonus["normal"],
									scalar_value = "x_mult",
									message_key = "a_xmult",
									message_colour = G.C.MULT
								})
								return true
							end,
						}))
						-- Actually useful
					elseif snack.type == "enemy" then
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
									SMODS.scale_card(card, {
										ref_table = card.ability.extra,
										ref_value = "mult",
										scalar_table = hunger_bonus["enemy" .. (rot_boost and "_boosted" or "")],
										scalar_value = "mult",
										message_key = "a_mult",
										message_colour = G.C.MULT
									})
									return true
								end,
							}))
						elseif reward == "chips" then
							G.E_MANAGER:add_event(Event({
								delay = 1,
								func = function()
									SMODS.scale_card(card, {
										ref_table = card.ability.extra,
										ref_value = "chips",
										scalar_table = hunger_bonus["enemy" .. (rot_boost and "_boosted" or "")],
										scalar_value = "chips",
										message_key = "a_chips",
										message_colour = G.C.CHIPS
									})
									return true
								end,
							}))
						elseif reward == "xmult" then
							G.E_MANAGER:add_event(Event({
								delay = 1,
								func = function()
									SMODS.scale_card(card, {
										ref_table = card.ability.extra,
										ref_value = "x_mult",
										scalar_table = hunger_bonus["enemy" .. (rot_boost and "_boosted" or "")],
										scalar_value = "x_mult",
										message_key = "a_xmult",
										message_colour = G.C.MULT
									})
									return true
								end,
							}))
						elseif reward == "cash" then
							local tbl = hunger_bonus["enemy" .. (rot_boost and "_boosted" or "")]
							local dollars = SCUG.number_in_range(tbl.cash_min, tbl.cash_max)
							G.E_MANAGER:add_event(Event({
								delay = 1,
								func = function()
									card:juice_up()
									ease_dollars(dollars)
									return true
								end,
							}))
						elseif reward == "weapon" then
							local earned_weapon, _ =
								pseudorandom_element(G.P_CENTER_POOLS.obtainweapon, pseudoseed("rw_hunger_weapon"))
							local weapon_key = earned_weapon.config.weapon
							if card.ability[weapon_key] then
								G.E_MANAGER:add_event(Event({
									delay = 1,
									func = function()
										SMODS.scale_card(card, {
											ref_table = card.ability.extra,
											ref_value = "mult",
											scalar_table = hunger_bonus["enemy" .. (rot_boost and "_boosted" or "")],
											scalar_value = "mult",
											message_key = "a_mult",
											message_colour = G.C.MULT
										})
										return true
									end,
								}))
							else
								G.E_MANAGER:add_event(Event({
									func = function()
										SMODS.Stickers[weapon_key]:apply(card, true)
										SMODS.calculate_effect(
											{ message = localize("k_plus_weapon"), colour = G.C.WEAPON }, card)
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
