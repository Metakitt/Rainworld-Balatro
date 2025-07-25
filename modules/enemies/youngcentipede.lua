SMODS.Joker {
key = 'youngcentipede',
atlas = "enemies",
rarity = 'rw_enemy',
cost = 4,
pos = { x = 2, y = 0 },
unlocked = true,
discovered = true,
in_pool = function (self, args)
    return false
end,
config = { extra = {defeat = false, four_count = 0, takeyourmoney = -10}, enemy = true},
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
    return { vars = { card.ability.extra.four_count, math.abs(card.ability.extra.takeyourmoney) } }
    end,
add_to_deck = function(self, card, from_debuff) 
SMODS.Stickers["eternal"]:apply(card,true)
    end,
calculate = function(self, card, context)

--Threat
-- Young Centipede has no direct threat.

--Defeat
 if context.before and not context.blueprint then
 if next(context.poker_hands['Four of a Kind']) and not context.blueprint then
    card.ability.extra.four_count = card.ability.extra.four_count + 1
 card.ability.extra.defeat = true
end
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



if context.main_eval and context.end_of_round and G.GAME.blind.boss and card.ability.extra.defeat == false and not context.blueprint  then
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
