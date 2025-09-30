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
		
		if context.joker_main and card.ability.extra.enemy_type == "Special" and card.ability.extra.condition == "GrenadeMult" and not context.blueprint then
			for i = 1, #G.jokers.cards do
				if
					G.jokers.cards[i].ability.rw_wgrenade
					and G.GAME.grenademult >= card.ability.extra.condition_req
					and not context.blueprint
				then
				card.ability.extra.amount = card.ability.extra.amount - 1
				end
			end
		end
		
		if context.before and card.ability.extra.enemy_type == "Score" then
		if card.ability.extra.condition == "HandType" then
	    if next(context.poker_hands[card.ability.extra.condition_req]) and context.scoring_name == card.ability.extra.condition_req and not context.blueprint then
		card.ability.extra.amount = card.ability.extra.amount - 1
		end	
		elseif card.ability.extra.condition == "CardExtraChips" then
		for i = 1, #G.play.cards do
				if
					G.play.cards[i].ability.perma_bonus >= card.ability.extra.condition_req and not context.blueprint
				then
					card.ability.extra.amount = card.ability.extra.amount - 1
				end
			end
		elseif card.ability.extra.condition == "CardWeapon" then
			for _, v in pairs(G.jokers.cards) do
				for k, _ in pairs(v.ability) do
					st, nd = string.find(k, card.ability.extra.condition_req)
					if st and nd then
						card.ability.extra.amount = card.ability.extra.amount - 1
					end
				end
			end
		elseif card.ability.extra.condition == "CardEditionEnhancement" then
		for _, v in pairs(context.scoring_hand) do
		    if v.edition and v.edition.key == card.ability.extra.condition_req then
			elseif v.config.center_key == card.ability.extra.condition_req then
			--	if (v.edition.key == card.ability.extra.condition_req or v.config.center_key == card.ability.extra.condition_req) then
					card.ability.extra.amount = card.ability.extra.amount - 1
					end
			end
		end
		end 
		
		if card.ability.extra.enemy_type == "Use" and card.ability.extra.condition == "Use" and context.using_consumeable and context.consumeable.ability.set == card.ability.extra.condition_req and not context.blueprint then
			card.ability.extra.amount = card.ability.extra.amount - 1
		end
		
		if card.ability.extra.enemy_type == "Sell" then
		--print('a')
		if context.selling_card then
		print('is sold')
		if context.card.ability.set == card.ability.extra.condition_req then
		print('fulfillsrequirement')
        if context.card.edition and context.card.edition.key == edition_ then
		print('amountgoesdown')
		card.ability.extra.amount = card.ability.extra.amount - 1
		else
		card.ability.extra.amount = card.ability.extra.amount - 1
		end
		end
		end
		end
		
		if card.ability.extra.enemy_type == "Win" and context.main_eval and context.end_of_round and not context.blueprint then
		if not G.GAME.blind.boss then
		if card.ability.extra.condition == "%BlindChips" then
			local score_ratio = G.GAME.chips / G.GAME.blind.chips
			if score_ratio >= SCUG.big(card.ability.extra.condition_req) then
				card.ability.extra.amount = card.ability.extra.amount - 1
			end
			elseif card.ability.extra.condition == "BlindThreshold" then
			local score_ratio = G.GAME.chips / G.GAME.blind.chips
			if score_ratio <= SCUG.big(card.ability.extra.condition_req) then
				card.ability.extra.amount = card.ability.extra.amount - 1
			end
			elseif card.ability.extra.condition == "DefeatBlind" then
			card.ability.extra.amount = card.ability.extra.amount - 1
			end
			end
		else
		if card.ability.extra.condition == "DefeatBossBlind" then
		card.ability.extra.amount = card.ability.extra.amount - 1
		end
		end
        
		
		if card.ability.extra.enemy_type == "Score" and card.ability.extra.condition == "ChipAmount" then
		if G.GAME.chips > SCUG.big(card.ability.extra.condition_req) and not context.blueprint then
			card.ability.extra.amount = card.ability.extra.amount - 1
		end
		end
		
		if context.reroll_shop and card.ability.extra.enemy_type == "Reroll" and card.ability.extra.condition == "RerollShop" then
			card.ability.extra.amount = card.ability.extra.amount - 1
		end
		
		if card.ability.extra.amount <= 0 then
		card.ability.extra.defeat = true
		end
	
		if context.main_eval and card.ability.extra.defeat == true and not context.blueprint then
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
