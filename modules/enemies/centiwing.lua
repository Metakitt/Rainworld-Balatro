--[[Threat: -3000 Chips after calculations.
Defeat condition: Score 3 cards with extra chips > 20
If not defeated: All cards with 5 or more extra chips in the deck are debuffed.]]

SMODS.Joker({
	key = "centiwing",
	atlas = "enemies",
	rarity = "rw_enemy",
	cost = 4,
	pos = { x = 6, y = 3 },
	unlocked = true,
	discovered = true,
	in_pool = function(self, args)
		return false
	end,
	config = { extra = { defeat = false, bonuscards = 0, unchips = -8000 }, enemy = true },
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
		return { vars = { number_format(card.ability.extra.unchips), card.ability.extra.bonuscards } }
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.Stickers["eternal"]:apply(card, true)
	end,
	calculate = function(self, card, context)
		card.ability.extra.unchips = get_blind_amount(G.GAME.round_resets.ante) / -5

		--Threat
		if
			context.after
			and context.cardarea == G.jokers
			and not context.blueprint
			and not card.ability.extra.defeat
		then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.1,
				func = function()
					G.GAME.chips = G.GAME.chips + SCUG.big(card.ability.extra.unchips)
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = localize({
							type = "variable",
							key = "a_score_minus",
							vars = { math.abs(card.ability.extra.unchips) },
						}), --card.ability.extra.unchips .. " Score",
						colour = G.C.PURPLE,
					})
					-- Evil LocalThunk "disable SFX" code
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.06 * G.SETTINGS.GAMESPEED,
						blockable = false,
						blocking = false,
						func = function()
							play_sound("tarot2", 0.76, 0.4)
							return true
						end,
					}))
					play_sound("tarot2", 1, 0.4)
					return true
				end,
			}))
		end

		--Defeat
		if context.before and not context.blueprint then
			for i = 1, #G.play.cards do
				if G.play.cards[i].ability.perma_bonus >= 20 and not context.blueprint then
					card.ability.extra.bonuscards = card.ability.extra.bonuscards + 1
				end
			end
		end

		if card.ability.extra.bonuscards >= 3 then
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
			for _, v in pairs(G.playing_cards) do
				if v.ability.perma_bonus >= 5 then
					SMODS.debuff_card(v, true, "centiwing")
				end
			end
		end
	end,
})
