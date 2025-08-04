SMODS.Joker({
	key = "redlizard",
	config = {
		extra = {
			threshold = 1.25,
		},
		enemy = true
	},
	rarity = "rw_enemy",
	cost = 0,
	atlas = "enemies",
	pos = { x = 3, y = 4 },
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
		return { vars = {
			card.ability.extra.threshold * 100,
		} }
	end,
    add_to_deck = function(self, card, from_debuff)
		SMODS.Stickers["eternal"]:apply(card, true)
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
