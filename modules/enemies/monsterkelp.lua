--[[Threat: -60 Chips
Defeat condition: Score two hands while a joker is holding a flashbang or a spear.
If not defeated: All cards in your deck get -10 extra chips.]]

SMODS.Joker {
key = 'monsterkelp',
atlas = 'enemies',
rarity = 'rw_enemy',
cost = 4,
pos = { x = 0, y = 2 },
unlocked = true,
discovered = true,
in_pool = function (self, args)
    return false
end,
config = { extra = {defeat = false, handcount = 0, dying = false, unchips = -60, card_unchips = -10}, enemy = true},
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
    info_queue[#info_queue+1] = {key = "rw_wspear", set = "Other"}
    info_queue[#info_queue+1] = {key = "rw_wflashbang", set = "Other"}
    return { vars = { card.ability.extra.unchips, card.ability.extra.handcount, card.ability.extra.card_unchips } }
    end,
add_to_deck = function(self, card, from_debuff) 
SMODS.Stickers["eternal"]:apply(card,true)
    end,
calculate = function(self, card, context)

--Threat
if context.joker_main and not context.blueprint then
return {
chips = card.ability.extra.unchips
}
end

--Defeat
if context.joker_main and not context.blueprint then
--  for i = 1, #G.jokers.cards do
--  if (G.jokers.cards[i].ability.rw_wflashbang or G.jokers.cards[i].ability.rw_wspear) and not context.blueprint then
--  card.ability.extra.handcount = card.ability.extra.handcount + 1
card.ability.extra.handcount = card.ability.extra.handcount + SCUG.weapon_count("rw_wspear") + SCUG.weapon_count("rw_wflashbang")
 if card.ability.extra.handcount >= 2 then
 card.ability.extra.defeat = true
 end
-- end
-- end
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

if context.main_eval and context.end_of_round and G.GAME.blind.boss and card.ability.extra.defeat == false and not context.blueprint then
for _,v in pairs(G.playing_cards) do
    v.ability.perma_bonus = v.ability.perma_bonus + card.ability.extra.card_unchips
end
end
end
	}
