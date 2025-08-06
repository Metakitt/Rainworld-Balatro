-- Scavenger
-- (Starts as a regular Joker; does this:)
-- (If you have a food card, 1 in 4 chance for it to be consumed and replaced with a weapon card at the start of blind.)
-- Scavenger have reputation; this reputation is on a scale of -4 to 4.
-- A reputation of -2 or less means they hate you, and the card turns into an enemy card.
-- As an enemy, does the following:
-- 1 in 6 chance with each played hand to remove a random weapon from a random joker.
-- If it removes a weapon from a joker that round, it temporarily gains an additional effect:
-- 0.9x Chips
-- A reputation of more than -2 to less than 2 does the following:
-- Scavenger is neutral, acts as its regular joker effect.
-- A reputation of 2 or more:
-- Its effect instead changes to give a random food or random weapon card at the start of each blind. (25% chance for it to be a weapon card, 75% chance for Food)

-- How does reputation work?
-- If you have Monk, +1 to Reputation.
-- If you have Hunter, -2 Reputation.
-- If you have Rivulet, -1 Reputation.
-- If you have Spearmaster, -2 Reputation.
-- If you have Artificer, Scavenger immediately turns into an enemy card, regardless of reputation.

-- Other Slugcats are Neutral to Scavengers.

-- Reputation starts at 0, and is modified these ways:
-- = It gains or lose reputation depending which Slugcats are present.
-- = It gains 0.1 Reputation each time it's (original) effect is triggered.
-- = Being given a weapon raises it by 0.2.
-- = Beating a Boss Blind. (Gains 0.5 Reputation)

-- Other Notes:
-- Enemy scavengers can be turned back into a neutral joker under circumstances where its reputation raises back up (such as obtaining monk or defeating boss blind).

SMODS.Joker({
	key = "scavenger",
	config = {
		extra = {
			permanent_reputation = 0.0,
			trade_odds = 3,
			yoink_odds = 6,
			yoinked = false,
			yoink_chips = 0.9,
			trade_rep = 0.1,
			weapon_rep = 0.2,
			boss_rep = 0.5,
		},
	},
	rarity = 2,
	cost = 5,
	atlas = "slugcats",
	pos = { x = 1, y = 4 },
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		local return_table = {
			key = self.key,
			vars = {},
		}

		local reputation = SCUG.scav_rep(card)
		if reputation <= -2 then
			return_table.key = return_table.key .. "_enemy"
			return_table.vars = {
				1,
				card.ability.extra.yoink_odds,
				card.ability.extra.yoink_chips,
			}
		elseif reputation >= 2 then
			return_table.key = return_table.key .. "_friendly"
			return_table.vars = {
				1,
				card.ability.extra.trade_odds,
			}
		else
			return_table.key = return_table.key .. "_neutral"
			return_table.vars = {
				1,
				card.ability.extra.trade_odds,
			}
		end
		table.insert(
			return_table.vars,
			(reputation >= 4 and "MAX (4 or more)") or (reputation <= -4 and "MIN (-4 or less)") or reputation
		)

		return return_table
	end,
	calculate = function(self, card, context)
		local reputation = SCUG.scav_rep(card)
		if reputation <= -2 then -- Enemy code
			if
				context.before
				-- and context.main_eval
				and not context.blueprint
				and pseudorandom("rw_scavenger_yoink") < 1 / card.ability.extra.yoink_odds
			then
				local joker_weapons = {}
				for i, v in ipairs(G.jokers.cards) do
					if v ~= card then
						for k, _ in pairs(v.ability) do
							local st, nd = string.find(k, "rw_w")
							if st == 1 and nd == 4 then
								table.insert(joker_weapons, { i, k })
							end
						end
					end
				end
				print(joker_weapons)
				if #joker_weapons > 0 then
					local stolen, _ = pseudorandom_element(joker_weapons, "rw_scavenger_yoink", {})
					local mark = G.jokers.cards[stolen[1]]
					mark.ability[stolen[2]] = nil
					mark:juice_up()
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = "Yoinked!",
						colour = G.C.RED,
					})
					card.ability.extra.yoinked = true
				end
			end
			if context.joker_main and not context.blueprint and card.ability.extra.yoinked then
				card.ability.extra.yoinked = false
				return {
					xchips = card.ability.extra.yoink_chips,
				}
			end
		elseif reputation >= 2 then -- Friendly code
			if context.setting_blind then
				local gift_type = (pseudorandom("rw_scavenger_gift") < 1 / card.ability.extra.trade_odds)
						and "obtainweapon"
					or "foods"
				if #G.consumeables.cards < G.consumeables.config.card_limit then
					SMODS.add_card({
						set = gift_type,
						area = G.consumeables,
					})
				end
			end
		else -- Neutral code
			if context.setting_blind and not context.blueprint then
				local foods = {}
				for i, k in ipairs(G.consumeables.cards) do
					if k.config.center.set == "foods" then
						table.insert(foods, i)
					end
				end
				if #foods > 0 and pseudorandom("rw_scavenger_trade") < 1 / card.ability.extra.trade_odds then
					local trade_idx = pseudorandom_element(foods, "rw_scavenger_trade", {})
					local traded = G.consumeables.cards[trade_idx]
					traded:start_dissolve()
					SMODS.add_card({ set = "obtainweapon", area = G.consumeables })
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = localize({
							type = "variable",
							key = "a_reputation",
							vars = { card.ability.extra.trade_rep },
						}),
						colour = G.C.MONEY,
					})
					card.ability.extra.permanent_reputation = card.ability.extra.permanent_reputation
						+ card.ability.extra.trade_rep
				end
			end
		end

		-- General code
		-- Visual confirmation of scug rep changes
		if
			(context.card_added or context.card_destroyed or context.selling_card)
			and context.cardarea == G.jokers
			and not context.blueprint
		then
			local key = context.card.config.center_key
			local rep = 0
			local rep_mult = (context.card_destroyed or context.selling_card) and -1 or 1
			if key == "j_rw_monk" then
				rep = 1
			elseif key == "j_rw_rivulet" then
				rep = -1
			elseif key == "j_rw_hunter" or key == "j_rw_spearmaster" then
				rep = -2
			elseif key == "j_rw_artificer" then
				rep = -1000
			end
			rep = rep * rep_mult

			if rep ~= 0 then
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = localize({
						type = "variable",
						key = rep > 0 and "a_reputation" or "a_reputation_minus",
						vars = { math.abs(rep) },
					}),
					colour = G.C.MONEY,
				})
			end
		end

		-- Given a weapon
		if
			context.using_consumeable
			and context.consumeable.config.center.set == "obtainweapon"
			and G.jokers.highlighted[1] == card
		then
			card_eval_status_text(card, "extra", nil, nil, nil, {
				message = localize({
					type = "variable",
					key = "a_reputation",
					vars = { card.ability.extra.weapon_rep },
				}),
				colour = G.C.MONEY,
			})
			card.ability.extra.permanent_reputation = card.ability.extra.permanent_reputation
				+ card.ability.extra.weapon_rep
		end

		-- Beat a boss
		if context.main_eval and context.end_of_round and G.GAME.blind.boss and not context.blueprint then
			card_eval_status_text(card, "extra", nil, nil, nil, {
				message = localize({
					type = "variable",
					key = "a_reputation",
					vars = { card.ability.extra.boss_rep },
				}),
				colour = G.C.MONEY,
			})
			card.ability.extra.permanent_reputation = card.ability.extra.permanent_reputation
				+ card.ability.extra.boss_rep
		end
	end,
})
