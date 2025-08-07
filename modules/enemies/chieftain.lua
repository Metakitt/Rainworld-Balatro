SMODS.Joker({
	key = "chieftain",
	atlas = "enemies",
	rarity = "rw_enemy",
	cost = 4,
	pos = { x = 3, y = 5 },
	unlocked = true,
	discovered = true,
	in_pool = function(self, args)
		return false
	end,
	config = { extra = { defeat = false, threshold = 1.50 }, enemy = true },
	blueprint_compat = false,
	perishable_compat = false,
	rw_wbeehive_compat = false,
	rw_wcherrybomb_compat = false,
	rw_wspear_ele_compat = false,
	rw_wspear_exp_compat = false,
	rw_wspear_fire_compat = false,
	rw_wflashbang_compat = false,
	rw_wgrenade_compat = false,
	rw_wjokerifle_compat = false,
	rw_wrock_compat = false,
	rw_wsingularity_compat = false,
	rw_wspear_compat = false,
	rw_wsporepuff_compat = false,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.threshold * 100 } }
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.Stickers["eternal"]:apply(card, true)
	end,
	calculate = function(self, card, context)
		--Threat
		if context.before and not context.blueprint then
			for _, v in ipairs(G.jokers.cards) do
				if v ~= card then
					local joker_weapons = {}
					for k, _ in pairs(v.ability) do
						local st, nd = string.find(k, "rw_w")
						if st == 1 and nd == 4 then
							table.insert(joker_weapons, k)
						end
					end
					if #joker_weapons > 0 then
						local not_anymore, _ = pseudorandom_element(joker_weapons, pseudoseed("rw_chieftain"))
						v.ability[not_anymore] = nil
						v:juice_up()
					end
				end
			end
			G.E_MANAGER:add_event(Event({
				func = function()
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = localize("k_yoinked_ex"),
						colour = G.C.RED
					})
					return true
				end
			}))
		end

		--Defeat
		if context.main_eval and context.end_of_round and not context.blueprint then
			local score_ratio = G.GAME.chips / G.GAME.blind.chips
			if score_ratio >= SCUG.big(card.ability.extra.threshold) then
				card.ability.extra.defeat = true
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = localize("k_safe_ex"),
					colour = G.C.RED,
				})
				SMODS.destroy_cards(card, true)
			end
		end

		--Undefeated

		if
			context.main_eval
			and context.end_of_round
			and G.GAME.blind.boss
			and card.ability.extra.defeat == false
			and not context.blueprint
		then
			G.E_MANAGER:add_event(Event({
				trigger = "ease",
				delay = 2.0,
				ref_table = G.GAME,
				ref_value = "chips",
				ease_to = SCUG.big(0),
				func = function(x)
					return math.floor(x)
				end,
			}))
			end_round()
		end
	end,
})
