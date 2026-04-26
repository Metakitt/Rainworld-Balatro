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
	config = {
		extra = {
			defeat = false,
			unchips = -8000,
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
	attributes = { "enemy", "score", "modify_card" },
	loc_vars = function(self, info_queue, card)
		if card.ability.extra.enemy_conditions then
			info_queue[#info_queue + 1] = SCUG.get_enemy_defeat_conditions(card.ability.extra.enemy_conditions)
		end
		return { vars = { number_format(card.ability.extra.unchips) } }
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.Stickers["eternal"]:apply(card, true)
		card.ability.extra.enemy_conditions = SCUG.generate_enemy()
	end,
	calculate = function(self, card, context)
		card.ability.extra.unchips = get_blind_amount(G.GAME.round_resets.ante) / -5

		--Threat
		if
			context.before
			and context.cardarea == G.jokers
			and not context.blueprint
			and not card.ability.extra.defeat
		then
			return {
				score = card.ability.extra.unchips
			}
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
			for _, v in pairs(G.playing_cards) do
				if v.ability.perma_bonus >= 5 then
					SMODS.debuff_card(v, true, "centiwing")
				end
			end
		end
	end,
})
