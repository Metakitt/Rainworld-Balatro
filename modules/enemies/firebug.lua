--[[Threat:
(Starts off neutral, but if you have a joker with a spear / sporepuff, they have a 1 in 2 chance to become aggro)
(When aggro, 1 in 2 chance to destroy a random rank at the end of round)
Defeat Condition: 1 in 10 chance to defeat it if you have a joker with a sporepuff.
If not defeated: Weapons are 4x less likely to show up in shops.]]
SMODS.Joker({
	key = "firebug",
	atlas = "enemies",
	rarity = "rw_enemy",
	cost = 4,
	pos = { x = 7, y = 4 },
	unlocked = true,
	discovered = true,
	in_pool = function(self, args)
		return false
	end,
	config = { extra = { defeat = false, aggressive = false, aggodds = 2, odds = 20, enemy_type = "none", amount = 0, condition = "none", condition_req = 0, edition_condition = "e_base" }, enemy = true },
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
		-- if card.ability.extra.aggressive == false then
		-- 	return {
		-- 		vars = {
		-- 			(G.GAME and G.GAME.probabilities.normal) or 1,
		-- 			card.ability.extra.aggodds,
		-- 			card.ability.extra.odds,
		-- 		},
		-- 		key = self.key .. "_neutral",
		-- 	}
		-- end

		-- if card.ability.extra.aggressive == true then
		-- 	return {
		-- 		vars = {
		-- 			(G.GAME and G.GAME.probabilities.normal) or 1,
		-- 			card.ability.extra.aggodds,
		-- 			card.ability.extra.odds,
		-- 		},
		-- 		key = self.key .. "_aggressive",
		-- 	}
		-- end

		return {
			vars = {
				(G.GAME and G.GAME.probabilities.normal) or 1,
				card.ability.extra.aggodds,
				card.ability.extra.odds,
			},
			key = self.key .. (card.ability.extra.aggressive and "_aggressive" or "_neutral"),
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.Stickers["eternal"]:apply(card, true)
		generate_enemy()
		card.ability.extra.enemy_type = enemy_type
		card.ability.extra.amount = amount
		card.ability.extra.condition = condition_type
		card.ability.extra.condition_req = condition_req
		card.ability.extra.edition_condition = bonus_condition
		enemy_type = "None"
		enemy_amount = 0
		condition_type = "None"
		condition_req = "None"
		bonus_condition = "None"
	end,
	calculate = function(self, card, context)
		--Threat
		if
			context.setting_blind
			and (SCUG.weapon_count("rw_wspear") + SCUG.weapon_count("rw_wsporepuff")) > 0
			and card.ability.extra.aggressive == false
		then
			if pseudorandom("fireboog") < 1 / card.ability.extra.aggodds and not context.blueprint then
				card.ability.extra.aggressive = true
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
		if card.ability.extra.aggressive == true then
			if
				context.main_eval
				and context.end_of_round
				and G.GAME.blind.boss
				and card.ability.extra.defeat == false
				and not context.blueprint
			then
				for k, v in pairs(SMODS.Stickers) do
					local st, nd = string.find(k, "rw_w")
					if st == 1 and nd == 4 then
						v.rate = v.rate / 4
					end
				end

				if pseudorandom("boogpowerup") < 1 / card.ability.extra.aggodds then
					local rank = SCUG.get_rank_in_deck()
					for _, v in ipairs(G.playing_cards) do
						if v.config.card.value == rank and not context.blueprint then
							SMODS.destroy_cards(v)
						end
					end
				end
		-- Aggro
			elseif
				pseudorandom("boogpowerup") < 1 / card.ability.extra.aggodds
				and context.main_eval
				and context.end_of_round
				and card.ability.extra.defeat == false
				and not context.blueprint
				and not G.GAME.blind.boss
			then
				local rank = SCUG.get_rank_in_deck()
				for _, v in ipairs(G.playing_cards) do
					if v.config.card.value == rank and not context.blueprint then
						SMODS.destroy_cards(v)
					end
				end
			end
		end
	end,
})
