--[[Threat: Always selects a card.
Defeat Condition: Use 2 planet cards.
If not defeated: Sets all your hands back to level 1.]]

SMODS.Joker({
	key = "cyanlizard",
	atlas = "enemies",
	rarity = "rw_enemy",
	cost = 4,
	pos = { x = 4, y = 1 },
	unlocked = true,
	discovered = true,
	in_pool = function(self, args)
		return false
	end,
	config = { extra = { defeat = false, planetcount = 0 }, enemy = true },
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
		return { vars = { card.ability.extra.planetcount } }
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.Stickers["eternal"]:apply(card, true)
	end,
	calculate = function(self, card, context)
		--Threat
		if context.hand_drawn and not context.blueprint then
			local any_forced = nil
			for k, v in ipairs(G.hand.cards) do
				if v.ability.forced_selection then
					any_forced = true
				end
			end
			if not any_forced then
				G.hand:unhighlight_all()
				local forced_card = pseudorandom_element(G.hand.cards, pseudoseed("cerulean_bell"))
				forced_card.ability.forced_selection = true
				G.hand:add_to_highlighted(forced_card)
			end
		end

		--Defeat
		if context.using_consumeable and context.consumeable.ability.set == "Planet" and not context.blueprint then
			card.ability.extra.planetcount = card.ability.extra.planetcount + 1
		end
		if card.ability.extra.planetcount >= 2 then
			card.ability.extra.defeat = true
		end
		if context.after and card.ability.extra.defeat == true and not context.blueprint then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 1.3,
				func = function()
					SMODS.destroy_cards(card, true)
					return true
				end,
				blocking = false,
			}))
		end
		--Undefeated

		if
			context.main_eval
			and context.end_of_round
			and G.GAME.blind.boss
			and card.ability.extra.defeat == false
			and not context.blueprint
		then
			-- adapted from base game black hole code
			update_hand_text(
				{ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
				{ handname = localize("k_all_hands"), chips = "...", mult = "...", level = "" }
			)
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					play_sound("tarot1")
					card:juice_up(0.8, 0.5)
					G.TAROT_INTERRUPT_PULSE = true
					return true
				end,
			}))
			update_hand_text({ delay = 0 }, { mult = "-", StatusText = true })
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.9,
				func = function()
					play_sound("tarot1")
					card:juice_up(0.8, 0.5)
					return true
				end,
			}))
			update_hand_text({ delay = 0 }, { chips = "-", StatusText = true })
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.9,
				func = function()
					play_sound("tarot1")
					card:juice_up(0.8, 0.5)
					G.TAROT_INTERRUPT_PULSE = nil
					return true
				end,
			}))
			update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = " = 1" })
			delay(1.3)
			for k, v in pairs(G.GAME.hands) do
				-- level_up_hand(card, k, true)
				v.level = SCUG.big(1)
				v.chips = v.s_chips
				v.mult = v.s_mult
			end
			-- also ripped from base game
			update_hand_text(
				{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
				{ mult = 0, chips = 0, handname = "", level = "" }
			)
		end
	end,
})
