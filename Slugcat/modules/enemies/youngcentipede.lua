SMODS.Joker {
key = 'youngcentipede',
atlas = 'slugpups',
rarity = 1,
cost = 4,
pos = { x = 0, y = 0 },
unlocked = true,
discovered = true,
in_pool = function (self, args)
    return false
end,
config = { extra = {defeat = false, takeyourmoney = -10}, enemy = true},
loc_vars = function(self, info_queue, card)
    return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end,
add_to_deck = function(self, card, from_debuff) 
SMODS.Stickers["eternal"]:apply(card,true)
    end,
calculate = function(self, card, context)

--Threat
-- Young Centipede has no direct threat.

--Defeat
 if context.before then
 if next(context.poker_hands['Four of a Kind']) and not context.blueprint then
 card.ability.extra.defeat = true
end
end
 if context.after and card.ability.extra.defeat == true then
 G.E_MANAGER:add_event(Event({
    trigger = "after", 
    delay = 1.3, 
    func = function() 
        card:start_dissolve() 
        return true 
    end,
	 blocking = false
}))
 
end
--Undefeated



if context.main_eval and context.end_of_round and G.GAME.blind.boss  then
ease_dollars(card.ability.extra.takeyourmoney)
return {
message = localize('$')..card.ability.extra.takeyourmoney,
colour = G.C.MONEY,
delay = 0.45, 
        }
else
--print('Safe')
end
end
	}
