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
config = { extra = {defeat = false, high_count = 0, flush_house_count = 0}, enemy = true},
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
    return { vars = { card.ability.extra.high_count, card.ability.extra.flush_house_count } }
    end,
add_to_deck = function(self, card, from_debuff) 
SMODS.Stickers["eternal"]:apply(card,true)
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
if card.ability.extra.high_count == 5 and card.ability.extra.flush_house_count == 1 then
card.ability.extra.defeat = true
end

 if context.after and card.ability.extra.defeat == true and not context.blueprint then
 G.E_MANAGER:add_event(Event({
    trigger = "after", 
    delay = 1.3, 
    func = function() 
        SMODS.destroy_cards(card, true) 
        return true 
    end,
	 blocking = false
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
