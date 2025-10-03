--[[Threat: At the start of each blind, 1 in 20 chance for each card in your deck to become rot.
Defeat condition: Score a hand while holding an explosive spear.
If not defeated: Chooses a random rank. Turns it to rot.]]

SMODS.Joker({
	key = "brotherlonglegs",
	atlas = "enemies",
	rarity = "rw_enemy",
	cost = 4,
	pos = { x = 4, y = 0 },
	unlocked = true,
	discovered = true,
	in_pool = function(self, args)
		return false
	end,
	config = {
		extra = {
			defeat = false,
			odds = 20,
		},
		enemy = true,
	},
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
		info_queue[#info_queue + 1] = G.P_CENTERS.m_rw_rotting
		info_queue[#info_queue + 1] = { key = "rw_wspear_exp", set = "Other" }
		return { vars = { card.ability.extra.odds } }
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.Stickers["eternal"]:apply(card, true)
		card.ability.extra.enemy_conditions = SCUG.generate_enemy()
	end,
	calculate = function(self, card, context)
		--Threat
		if context.setting_blind and not context.blueprint then
			for i = 1, #G.playing_cards do
				if pseudorandom("bite") < 1 / card.ability.extra.odds and not context.blueprint then
					G.playing_cards[i]:set_ability(G.P_CENTERS.m_rw_rotting)
				else
					--print('Safe')
				end
			end
		end
		--Defeat
		local tick_down = SCUG.enemy_should_count_down(context, card.ability.extra.enemy_conditions)
		if tick_down > 0 then
			card.ability.extra.enemy_conditions.amount = card.ability.extra.enemy_conditions.amount - tick_down
		end

		if
			context.main_eval
			and card.ability.extra.enemy_conditions.amount <= 0
			and not card.ability.extra.defeat
			and not context.blueprint
		then
			card.ability.extra.defeat = true
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
			local rank = SCUG.get_rank_in_deck() --pseudorandom_element(SMODS.Ranks, pseudoseed("rotten_rank"))
			for _, v in ipairs(G.playing_cards) do
				if v.config.card.value == rank and not context.blueprint then
					v:set_ability(G.P_CENTERS.m_rw_rotting)
				end
			end
		end
	end,
})
