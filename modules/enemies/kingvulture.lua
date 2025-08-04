-- Threat: 1 in 8 chance for hand to score 0 instead.
-- Defeat condition: Score 3 hands while having a joker with a spear (or any of the spears really)
-- If not defeated: Removes all weapons from currently owned jokers.
SMODS.Joker({
	key = "kingvulture",
	config = {
		extra = {
			nope_odds = 4,
			spears_tanked = 0,
			spears_needed = 5,
			defeat = false,
		},
		enemy = true,
	},
	rarity = "rw_enemy",
	cost = 1,
	atlas = "enemies",
	pos = { x = 4, y = 3 },
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
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.nope_odds,
				card.ability.extra.spears_needed,
				card.ability.extra.spears_tanked,
			},
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.Stickers["eternal"]:apply(card, true)
	end,
	calculate = function(self, card, context)
		-- Threat
		if
			context.final_scoring_step
			and context.cardarea == G.jokers
			and not card.ability.extra.defeat
			and pseudorandom("vulched") < 1 / card.ability.extra.nope_odds
			and not context.blueprint
			and not card.ability.extra.defeat
		then
			card_eval_status_text(card, "extra", nil, nil, nil, {
				message = localize("k_nope_ex"),
				colour = G.C.RED,
			})
			return {
				x_chips = 0,
				x_mult = 0,
			}
		end
		-- Defeat
		if context.before and not context.blueprint then
			for _, v in pairs(G.jokers.cards) do
				for k, _ in pairs(v.ability) do
					st, nd = string.find(k, "rw_wspear")
					if st and nd then
						card.ability.extra.spears_tanked = card.ability.extra.spears_tanked + 1
					end
				end
			end
			if card.ability.extra.spears_tanked >= card.ability.extra.spears_needed then
				card.ability.extra.defeat = true
			end
		end
		if context.after and not context.blueprint and card.ability.extra.defeat then
			SMODS.destroy_cards(card, true)
		end
		-- Undefeated
		if
			context.main_eval
			and context.end_of_round
			and G.GAME.blind.boss
			and card.ability.extra.defeat == false
			and not context.blueprint
		then
			-- Die
            G.E_MANAGER:add_event(Event({
                trigger = "ease",
                delay = 2.0,
                ref_table = G.GAME,
                ref_value = "chips",
                ease_to = SCUG.big(0),
				func = (function(x) return math.floor(x) end)
            }))
            end_round()
		end
	end,
})
