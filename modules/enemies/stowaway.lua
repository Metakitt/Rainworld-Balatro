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
		enemy = true,
	},
	rarity = "rw_enemy",
	cost = 0,
	atlas = "enemies",
	pos = { x = 2, y = 4 },
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
	attributes = { "enemy", "generation", "destroy_card", "chance" },
	loc_vars = function(self, info_queue, card)
		local numerator, enem_chance = SMODS.get_probability_vars(card, 1, card.ability.extra.enemy_chance, "rw_stowaway")
		local _, dorm_chance = SMODS.get_probability_vars(card, 1, card.ability.extra.dormant_chance, "rw_stowaway")
		local _, joke_chance = SMODS.get_probability_vars(card, 1, card.ability.extra.joker_chance, "rw_stowaway")
		local awake = {
			vars = {
				numerator,
				enem_chance,
				dorm_chance,
				joke_chance
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
	add_to_deck = function(self, card, from_debuff)
		SMODS.Stickers["eternal"]:apply(card, true)
	end,
	calculate = function(self, card, context)
		-- Threat
		if context.setting_blind and not context.blueprint and card.ability.extra.dormant_timer == 0 then
			if SMODS.pseudorandom_probability(card, "rw_stowaway", 1, card.ability.extra.enemy_chance, "rw_stowaway_spawn") then
				sendDebugMessage("Stowaway spawn!", "Rainworld")
				SCUG.spawn_enemy({ guarantee = true })
			end
		end

		-- "Defeat"
		if context.end_of_round and not context.blueprint and context.main_eval then
			if card.ability.extra.dormant_timer == 0 then
				if SMODS.pseudorandom_probability(card, "rw_stowaway", 1, card.ability.extra.dormant_chance, "rw_stowaway_sleep") then
					card.ability.extra.dormant_timer = SCUG.number_in_range(3, 6, "rw_stowaway_eepy")
					SMODS.calculate_effect({
						message = localize("k_dormant_elip"),
						colour = G.C.FILTER,
					}, card)
				end
			else
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "dormant_timer",
					scalar_table = { one = 1 },
					scalar_value = "one",
					operation = '-',
					no_message = true
				})
				SMODS.calculate_effect({
					message = card.ability.extra.dormant_timer == 0 and localize("k_awake_ex") or localize({
						type = "variable",
						key = "a_remaining",
						vars = { card.ability.extra.dormant_timer },
					}),
					colour = G.C.FILTER,
				}, card)
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
			if SMODS.pseudorandom_probability(card, "rw_stowaway", 1, card.ability.extra.joker_chance, "rw_stowaway_kill") then
				local random_joker = pseudorandom_element(G.jokers.cards, "rw_stowaway_kill", {})
				if not SMODS.is_eternal(random_joker) then
					SMODS.destroy_cards(random_joker)
					card:juice_up()
				end
			end
		end
	end,
})
