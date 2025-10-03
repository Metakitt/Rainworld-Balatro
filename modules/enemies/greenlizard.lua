SMODS.Joker({
	key = "greenlizard",
	atlas = "enemies",
	rarity = "rw_enemy",
	cost = 4,
	pos = { x = 0, y = 0 },
	unlocked = true,
	discovered = true,
	in_pool = function(self, args)
		return false
	end,
	config = {
		extra = {
			defeat = false,
			midround_destroy_odds = 2,
			boss_destroy_odds = 3,
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
		return {
			vars = {
				card.ability.extra.midround_destroy_odds,
				card.ability.extra.boss_destroy_odds,
			},
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.Stickers["eternal"]:apply(card, true)
		card.ability.extra.enemy_conditions = SCUG.generate_enemy()
	end,
	calculate = function(self, card, context)
		--Threat
		if
			context.main_eval
			and context.end_of_round
			and not G.GAME.blind.boss
			and not context.blueprint
			and not card.ability.extra.defeat
		then
			local destroyablejokers = EMPTY(destroyablejokers)
			for k, v in pairs(G.jokers.cards) do
				if v.ability.set == "Joker" and not v.ability.eternal then
					table.insert(destroyablejokers, v)
				end
			end

			local chosen_card = pseudorandom_element(destroyablejokers, pseudoseed("test"))
			if
				chosen_card ~= nil
				and pseudorandom("bite") < 1 / card.ability.extra.midround_destroy_odds
				and not chosen_card.getting_sliced
				and not context.blueprint
			then
				SMODS.destroy_cards(chosen_card)
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
			for i = 1, #G.jokers.cards do
				if
					pseudorandom("bite") < 1 / card.ability.extra.boss_destroy_odds
					and not G.jokers.cards[i].ability.eternal
					and not context.blueprint
				then
					SMODS.destroy_cards(G.jokers.cards[i])
				else
					--print('Safe')
				end
			end
		end
	end,
})
