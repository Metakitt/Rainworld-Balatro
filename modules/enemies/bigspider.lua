--[[Threat: Only Flush, Straight and Full House count for scoring.
Defeat: Score 3 Flushes, 2 Full Houses and 1 Straight
Not Defeated: Nothing.]]

SMODS.Joker {
key = 'bigspider',
atlas = "enemies",
rarity = 'rw_enemy',
cost = 4,
pos = { x = 6, y = 1 },
unlocked = true,
discovered = true,
in_pool = function (self, args)
    return false
end,
config = { extra = {defeat = false, flush_count = 0, full_house_count = 0, straight_count = 0}, enemy = true},
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
    return { vars = { card.ability.extra.flush_count, card.ability.extra.full_house_count, card.ability.extra.straight_count } }
    end,
add_to_deck = function(self, card, from_debuff) 
SMODS.Stickers["eternal"]:apply(card,true)
    end,
calculate = function(self, card, context)

--Threat
if context.debuff_hand and not context.blueprint then
if not ( context.poker_hands['Flush'][1] or context.poker_hands['Straight'][1] or context.poker_hands['Full House'][1] ) then
return { debuff = true }
end
end

if context.before and not context.blueprint then
-- Add other hands that are "Flush" or "Straight" (Straight Flush, Royal Flush, Flush House...)

			if
				(next(context.poker_hands["Flush"]) or next(context.poker_hands["Flush Five"]))
				and (context.scoring_name == "Flush" or context.scoring_name == "Flush Five")
				and not context.blueprint
			then
				card.ability.extra.flush_count = card.ability.extra.flush_count + 1
			elseif (next(context.poker_hands["Straight"])
			and context.scoring_name == "Straight"
			and not context.blueprint)
			then
			card.ability.extra.straight_count = card.ability.extra.straight_count + 1
			elseif next(context.poker_hands["Full House"])
			and context.scoring_name == "Full House"
			and not context.blueprint
			then
			card.ability.extra.full_house_count = card.ability.extra.full_house_count + 1
			end
		end


--Defeat
if card.ability.extra.flush_count == 3 and card.ability.extra.full_house_count == 2 and card.ability.extra.straight_count == 1 then
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

end
	}
