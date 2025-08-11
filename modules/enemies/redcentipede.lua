SMODS.Joker {
key = 'redcentipede',
atlas = "enemies",
rarity = 'rw_enemy',
cost = 4,
pos = { x = 2, y = 5 },
unlocked = true,
discovered = true,
in_pool = function (card, args)
    return false
end,
config = { extra = {defeat = false, hands_sub = 0}, enemy = true},
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
loc_vars = function(card, info_queue, card)
    return { vars = {  } }
    end,
add_to_deck = function(card, card, from_debuff) 
SMODS.Stickers["eternal"]:apply(card,true)
    end,
calculate = function(card, card, context)

--Threat
   if context.setting_blind and not context.blueprint then 
        card.ability.extra.hands_sub = G.GAME.round_resets.hands - 1
        ease_hands_played(-card.ability.extra.hands_sub)
    end

--Defeat
--(Boss, cant be defeated)

--Undefeated



if context.main_eval and context.end_of_round and G.GAME.blind.boss and card.ability.extra.defeat == false and not context.blueprint  then
ease_hands_played(card.ability.extra.hands_sub)
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
end
	}
