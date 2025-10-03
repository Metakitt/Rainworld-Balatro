--[[Threat: Only Flush, Straight and Full House count for scoring.
Defeat: Score 3 Flushes, 2 Full Houses and 1 Straight
Not Defeated: Nothing.]]

SMODS.Joker({
	key = "bigspider",
	atlas = "enemies",
	rarity = "rw_enemy",
	cost = 4,
	pos = { x = 6, y = 1 },
	unlocked = true,
	discovered = true,
	in_pool = function(self, args)
		return false
	end,
	config = {
		extra = {
			defeat = false,
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
				card.ability.extra.flush_count,
				card.ability.extra.full_house_count,
				card.ability.extra.straight_count,
			},
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.Stickers["eternal"]:apply(card, true)
		card.ability.extra.enemy_conditions = SCUG.generate_enemy()
		if card.ability.extra.enemy_conditions.condition == "HandType" then
			card.ability.extra.enemy_conditions.requirement =
				pseudorandom_element({ "Flush", "Straight", "Full House" }, pseudoseed("spider"))
		end
	end,
	calculate = function(self, card, context)
		--Threat
		if context.debuff_hand and not context.blueprint then
			if
				not (
					context.poker_hands["Flush"][1]
					or context.poker_hands["Straight"][1]
					or context.poker_hands["Full House"][1]
				)
			then
				return { debuff = true }
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
		--Nothing happens.
	end,
})
