--[[Threat: Only High cards and Flush Houses count for scoring. Other hands will be destroyed.
Defeat: Score 5 High Cards and 1 Flush House.
Not Defeated: Nothing.]]

SMODS.Joker {
key = 'motherspider',
atlas = "enemies",
rarity = 'rw_enemy',
cost = 4,
pos = { x = 4, y = 4 },
unlocked = true,
discovered = true,
in_pool = function (self, args)
    return false
end,
config = { extra = {defeat = false, enemy_type = "none", amount = 0, condition = "none", condition_req = 0, edition_condition = "e_base"}, enemy = true},
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
    return { vars = { } }
    end,
add_to_deck = function(self, card, from_debuff) 
SMODS.Stickers["eternal"]:apply(card,true)
generate_enemy()
local appropriate_condition_type = {"High Card", "Flush House"}
local chosen_condition = pseudorandom_element(appropriate_condition_type, pseudoseed("spider"))
		card.ability.extra.enemy_type = enemy_type
		card.ability.extra.amount = amount
		if card.ability.extra.enemy_type == "HandType" then
		card.ability.extra.condition = chosen_condition
		else
		card.ability.extra.condition = condition_type
		end
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
if context.debuff_hand and not context.blueprint then
if not ( context.poker_hands['High Card'][1] or context.poker_hands['Flush House'][1] ) then
return { debuff = true}
end
end


if context.before and not context.blueprint then

			if
				next(context.poker_hands["High Card"])
				and context.scoring_name == "High Card"
				and not context.blueprint
			then
				card.ability.extra.high_count = card.ability.extra.high_count + 1
			elseif next(context.poker_hands["Flush House"])
			and context.scoring_name == "Flush House"
			and not context.blueprint
			then
			card.ability.extra.flush_house_count = card.ability.extra.flush_house_count + 1			
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
--Nothing happens.

--Currently, it works as intended but doing remove rather than dissolve just obliterates the cards from existence. Dissolve leaves ghost cards.
local Blind_debuff_hand = Blind.debuff_hand
function Blind:debuff_hand(cards, hand, handname, check)
	local ret = Blind_debuff_hand(self, cards, hand, handname, check)
	if ret then
		for _, k in ipairs(G.jokers.cards) do
			if k.config.center_key == "j_rw_motherspider" then
				for _, v in pairs(G.play.cards) do
				v:remove()
				--SMODS.calculate_context{destroy_card = v, remove = true}
				end
				end
			end
		end
	return ret
	end

	--[[local oldblinddebuffhand = Blind.debuff_hand
function Blind:debuff_hand(cards, hand, handname, check)
    local g = oldblinddebuffhand(self, cards, hand, handname, check)
    if g then
        for k, v in pairs(G.play.cards) do
            v:start_dissolve()
        end
    end
    return g
end]]
	

end

	}
