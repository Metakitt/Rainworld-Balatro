SMODS.Joker({
	key = "redlizard",
	config = {
		extra = {
			threshold = 1.25,
		},
	},
	rarity = "rw_enemy",
	cost = 0,
	atlas = "enemies",
	pos = { x = 3, y = 4 },
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.threshold * 100,
		} }
	end,
	calculate = function(self, card, context)
		-- Threat
		if context.main_eval and context.final_scoring_step and not context.blueprint then
			return {
				xmult = 0.5,
			}
		end
		-- Defeat
		if context.end_of_round and context.main_eval and not context.blueprint then
			local score_ratio = G.GAME.chips / G.GAME.blind.chips
			if score_ratio >= SCUG.big(card.ability.extra.threshold) then
				SMODS.destroy_cards(card, true)
			end
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
				func = function(x)
					return math.floor(x)
				end,
			}))
			end_round()
		end
	end,
})
