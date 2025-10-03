SMODS.Joker({
	key = "jungleleech",
	atlas = "enemies",
	rarity = "rw_enemy",
	cost = 4,
	pos = { x = 1, y = 1 },
	unlocked = true,
	discovered = true,
	in_pool = function(self, args)
		return false
	end,
	config = {
		extra = {
			defeat = false,
			dying = false,
			mult = -0.5,
			multmod = -0.1,
			multodds = 2,
			leechodds = 10,
			highcardcount = 0,
			foodcardsold = 0,
			foododds = 20,
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
				card.ability.extra.mult,
				card.ability.extra.multmod,
				card.ability.extra.multodds,
				card.ability.extra.leechodds,
				card.ability.extra.foodcardsold,
				card.ability.extra.highcardcount,
				card.ability.extra.foododds,
			},
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.Stickers["eternal"]:apply(card, true)
		card.ability.extra.enemy_conditions = SCUG.generate_enemy()
	end,
	calculate = function(self, card, context)
		--Threat
		if context.joker_main and not context.blueprint then
			return {
				mult = card.ability.extra.mult,
			}
		end

		if
			context.after
			and pseudorandom("moreleech") < 1 / card.ability.extra.leechodds
			and card.ability.extra.dying == false
			and not context.blueprint
		then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 1.3,
				func = function()
					SMODS.add_card({ set = "Joker", area = G.jokers, key = "j_rw_jungleleech", no_edition = true })
					return true
				end,
				blocking = false,
			}))
			if pseudorandom("morepower") < 1 / card.ability.extra.multodds then
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.multmod
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
			and pseudorandom("moreleech") < 1 / card.ability.extra.foododds
			and not context.blueprint
		then
			G.E_MANAGER:add_event(Event({
				func = function()
					G.GAME.obtainfoods_rate = 0
					return true
				end,
			}))
		end
	end,
})
