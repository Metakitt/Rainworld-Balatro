SMODS.Joker({
	key = "dropwig",
	atlas = "enemies",
	rarity = "rw_enemy",
	cost = 4,
	pos = { x = 5, y = 1 },
	unlocked = true,
	discovered = true,
	in_pool = function(self, args)
		return false
	end,
	config = { extra = { defeat = false, counter = 0, deathcounter = 5, threshold = 1.50 }, enemy = true },
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
		return { vars = { card.ability.extra.deathcounter, 5 - card.ability.extra.counter, 100 * card.ability.extra.threshold } }
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.Stickers["eternal"]:apply(card, true)
	end,
	calculate = function(self, card, context)
		--Threat
		if context.main_eval and context.end_of_round and not context.blueprint then
			local score_ratio = G.GAME.chips / G.GAME.blind.chips
			if score_ratio >= SCUG.big(card.ability.extra.threshold) then
				card.ability.extra.counter = card.ability.extra.counter + 1
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = localize("k_over_elip"),
					colour = G.C.RED
				})
			-- Defeat
			else
				card.ability.extra.deathcounter = card.ability.extra.deathcounter - 1
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = localize("k_under_ex"),
					colour = G.C.GREEN
				})
				if card.ability.extra.deathcounter <= 0 then
					card.ability.extra.defeat = true
					SMODS.destroy_cards(card, true)
				end
			end
		end
		--Undefeated
		-- It doesn't have an undefeated condition but if its counter goes up to 5, you die.
		if context.main_eval and context.end_of_round and card.ability.extra.counter >= 5 and not context.blueprint then
			--print('dead')
			G.STATE = G.STATES.GAME_OVER
			G.STATE_COMPLETE = false
		end
	end,
})
