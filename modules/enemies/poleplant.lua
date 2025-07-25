SMODS.Joker {
key = 'poleplant',
atlas = 'enemies',
rarity = 'rw_enemy',
cost = 4,
pos = { x = 3, y = 1 },
unlocked = true,
discovered = true,
in_pool = function (self, args)
    return false
end,
config = { extra = {defeat = false, multcards = 0, mult = -3, card_mult = -1}, enemy = true},
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
    info_queue[#info_queue+1] =G.P_CENTERS.m_mult
    return { vars = { card.ability.extra.mult, card.ability.extra.multcards, card.ability.extra.card_mult } }
    end,
add_to_deck = function(self, card, from_debuff) 
SMODS.Stickers["eternal"]:apply(card,true)
    end,
calculate = function(self, card, context)

--Threat
if context.joker_main and not context.blueprint then
return {
mult = card.ability.extra.mult
}
end

--Defeat
 if context.before and not context.blueprint then
 for i=1, #G.play.cards do
if G.play.cards[i].config.center.key == 'm_mult' and not context.blueprint then
card.ability.extra.multcards = card.ability.extra.multcards + 1
end
end
end

if card.ability.extra.multcards >= 2 then
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

if context.main_eval and context.end_of_round and G.GAME.blind.boss and card.ability.extra.defeat == false and not context.blueprint  then
for _,v in pairs(G.playing_cards) do
    v.ability.perma_mult = v.ability.perma_mult + card.ability.extra.card_mult
end
end
end
	}
