-- Threat: At the Start of blind, 1 in 2 chance to pull a random enemy.
-- Defeat: Can't be defeated. Has a chance to go dormant at the end of reach blind. (1 in 4)
-- Not defeated: Rare chance to destroy a joker. Otherwise, nothing.

SMODS.Joker({
	key = "stowaway",
	config = {
		extra = {
			enemy_chance = 2,
			dormant_chance = 4,
			dormant_timer = 0,
			joker_chance = 50,
		},
	},
	rarity = "rw_enemy",
	cost = 0,
	atlas = "enemies",
	pos = { x = 2, y = 4 },
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		local awake = {
			vars = {
				1, -- G.GAME and G.GAME.probabilities.normal or 1,
				card.ability.extra.enemy_chance,
				card.ability.extra.dormant_chance,
				card.ability.extra.joker_chance,
			},
		}
		local asleep = {
			key = self.key .. "_dormant",
			vars = {
				card.ability.extra.dormant_timer,
			},
		}
		return card.ability.extra.dormant_timer > 0 and asleep or awake
	end,
	calculate = function(self, card, context)
		-- Threat
		if context.setting_blind and not context.blueprint and card.ability.extra.dormant_timer == 0 then
			if pseudorandom("rw_stowaway_spawn") < 1 / card.ability.extra.enemy_chance then
				SCUG.spawn_enemy({ guarantee = true })
			end
		end
		-- "Defeat"
		if context.end_of_round and not context.blueprint then
			if card.ability.extra.dormant_timer == 0 then
				if
					pseudorandom("rw_stowaway_sleep")
					< 1 / card.ability.extra.dormant_chance
				then
					card.ability.extra.dormant_timer = SCUG.number_in_range(3, 6, "rw_stowaway_eepy")
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = "Dormant...",
						colour = G.C.FILTER,
					})
				end
			else
				card.ability.extra.dormant_timer = card.ability.extra.dormant_timer - 1
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = card.ability.extra.dormant_timer == 0 and "Awake!" or card.ability.extra.dormant_timer,
					colour = G.C.FILTER,
				})
			end
		end
		-- Undefeated
		if
			context.main_eval
			and context.end_of_round
			and G.GAME.blind.boss
			and card.ability.extra.defeat == false
			and not context.blueprint
			and card.ability.extra.dormant_timer == 0
		then
			if pseudorandom("rw_stowaway_kill") < 1 / card.ability.extra.joker_chance then
				local random_joker = pseudorandom_element(G.jokers.cards, "rw_stowaway_kill", {})
				if not SMODS.is_eternal(random_joker) then
					SMODS.destroy_cards(random_joker)
					card:juice_up()
				end
			end
		end
	end,
})
