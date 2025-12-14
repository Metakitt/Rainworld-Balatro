SMODS.Joker({
	key = "pinklizard",
	atlas = "enemies",
	rarity = "rw_enemy",
	cost = 4,
	pos = { x = 1, y = 0 },
	unlocked = true,
	discovered = true,
	in_pool = function(self, args)
		return false
	end,
	config = {
		extra = {
			defeat = false,
			card_odds = 2,
			deck_odds = 20,
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
		if card.ability.extra.enemy_conditions then
			info_queue[#info_queue + 1] = SCUG.get_enemy_defeat_conditions(card.ability.extra.enemy_conditions)
		end
		local numerator, card_odds = SMODS.get_probability_vars(card, 1, card.ability.extra.card_odds, "rw_pinklizard")
		local _, deck_odds = SMODS.get_probability_vars(card, 1, card.ability.extra.card_odds, "rw_pinklizard")
		return {
			vars = { numerator, card_odds, deck_odds },
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.Stickers["eternal"]:apply(card, true)
		card.ability.extra.enemy_conditions = SCUG.generate_enemy()
	end,
	calculate = function(self, card, context)
		--Threat
		if context.after and not context.blueprint then
			local destroyablecards = EMPTY(destroyablecards)
			for k, v in pairs(G.playing_cards) do
				table.insert(destroyablecards, v)
			end

			local chosen_card = pseudorandom_element(destroyablecards, pseudoseed("test"))
			if
				chosen_card ~= nil
				and SMODS.pseudorandom_probability(card, "rw_pinklizard", 1, card.ability.extra.card_odds, "rw_pinklizard_onecard")
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
			for i = 1, #G.playing_cards do
				if SMODS.pseudorandom_probability(card, "rw_pinklizard", 1, card.ability.extra.deck_odds, "rw_pinklizard_deckcards") then
					SMODS.destroy_cards(G.playing_cards[i])
				end
			end
		end
	end,
})
