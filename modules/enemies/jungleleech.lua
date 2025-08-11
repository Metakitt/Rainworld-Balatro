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
                card.ability.extra.foododds
			},
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.Stickers["eternal"]:apply(card, true)
	end,
	calculate = function(self, card, context)
		--Threat
		if context.joker_main and not context.blueprint then
			return {
				mult = card.ability.extra.mult
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
		if context.before and not context.blueprint then
			if
				next(context.poker_hands["High Card"])
				and context.scoring_name == "High Card"
				and not context.blueprint
			then
				card.ability.extra.highcardcount = card.ability.extra.highcardcount + 1
			end
		end

		if
			context.selling_card
			and context.card.ability.set == "foods"
			and context.card ~= card
			and not context.blueprint
		then
			card.ability.extra.foodcardsold = card.ability.extra.foodcardsold + 1
		end

		if card.ability.extra.highcardcount >= 5 and card.ability.extra.foodcardsold >= 1 and not context.blueprint then
			card.ability.extra.defeat = true
			card.ability.extra.dying = true
		end

		if context.after and card.ability.extra.defeat == true and not context.blueprint then
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
