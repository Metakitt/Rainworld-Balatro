-- There's evil in here.

SMODS.Joker({
	key = "inspector",
	config = {
		extra = {
			odds = 6,
			defeat = false,
			smacked = false,
			reload = {},
		},
		enemy = true,
	},
	rarity = "rw_enemy",
	cost = 0,
	atlas = "enemies",
	pos = { x = 0, y = 1 },
	discovered = true,
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
	in_pool = function(self, args)
		return false
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "rw_wspear_exp", set = "Other" }
		return {
			vars = {
				-- Fixed chance; Does not use G.GAME.probabilities.normal
				card.ability.extra.odds,
			},
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.Stickers["eternal"]:apply(card, true)
	end,
	calculate = function(self, card, context)
		-- Defeat
		if context.before and not context.blueprint then
			-- for _, joker in ipairs(G.jokers.cards) do
			if not card.ability.extra.defeat and SCUG.weapon_count("rw_wspear_exp") > 0 then
				card.ability.extra.defeat = true
			end
			-- end
		end
		if context.after and card.ability.extra.defeat then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 1.3,
				func = function()
					SMODS.destroy_cards(card, true)
					return true
				end,
			}))
		end
		-- Undefeated
		if
			context.main_eval
			and context.end_of_round
			and G.GAME.blind.boss
			and card.ability.extra.defeat == false
			and not context.blueprint
		then
			if card.ability.extra.odds > 2 then
				card.ability.extra.odds = card.ability.extra.odds - 1
			end
		end
		-- Threat pt.1
		if context.debuffed_hand then
			for _, v in ipairs(context.full_hand) do
				table.insert(card.ability.extra.reload, v)
			end
			-- print(#card.ability.extra.reload)
		end
		if context.after then
			G.E_MANAGER:add_event(
				Event({
					blocking = false,
					func = function()
						local function all_in_discard()
							local check_table = {}
							for i = 1, #card.ability.extra.reload do
								for j = 1, #G.discard.cards do
									if G.discard.cards[j] == card.ability.extra.reload[i] then
										check_table[i] = true
									end
								end
							end
							-- print(#check_table, #card.ability.extra.reload)
							return #check_table == #card.ability.extra.reload
						end

						if all_in_discard() then
							if card.ability.extra.smacked then
								G.E_MANAGER:add_event(Event({
									trigger = "immediate",
									func = function()
										local num_undiscard = #card.ability.extra.reload
										for i = 1, num_undiscard do
											-- print("attempting undiscard")
											local undiscard = card.ability.extra.reload[i]
											-- Evil LocalThunk code
											draw_card(
												G.discard,
												G.deck,
												i * 100 / num_undiscard,
												"up",
												nil,
												undiscard,
												0.005,
												i % 2 == 0,
												nil,
												math.max((21 - i) / 20, 0.7)
											)
										end
										card.ability.extra.smacked = false
										return true
									end,
								}))
								-- Your hand back :)
								ease_hands_played(1)
							end
							-- Clear table
							G.E_MANAGER:add_event(Event({
								func = function()
									for k, _ in pairs(card.ability.extra.reload) do
										card.ability.extra.reload[k] = nil
									end
									return true
								end,
							}))
							return true
						else
							return false
						end
					end,
				}),
				"other"
			)
		end
		if context.debuff_hand and not context.check then
			for _, k in ipairs(G.jokers.cards) do
				if k.config.center_key == "j_rw_inspector" then
					if pseudorandom("rw_inspected") < (1 / k.ability.extra.odds) then
						-- Lets you know who screwed you over
						G.E_MANAGER:add_event(Event({
							func = function()
								-- k:juice_up()
								k.ability.extra.smacked = true
								return true
							end,
						}))
						return {
							debuff = true,
							debuff_source = card,
							debuff_text = "Rejected!",
						}
					end
				end
			end
		end
	end,
})