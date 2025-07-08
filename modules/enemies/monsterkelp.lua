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
config = { extra = {defeat = false, handcount = 0, dying = false}, enemy = true},
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
    return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end,
add_to_deck = function(self, card, from_debuff) 
SMODS.Stickers["eternal"]:apply(card,true)
    end,
calculate = function(self, card, context)

--Threat
if context.joker_main and not context.blueprint then
return {
chips = -60
}
end

--Defeat
if context.joker_main and not context.blueprint then
 for i = 1, #G.jokers.cards do
 if (G.jokers.cards[i].ability.rw_wflashbang or G.jokers.cards[i].ability.rw_wspear) and not context.blueprint then
 card.ability.extra.handcount = card.ability.extra.handcount + 1
 if card.ability.extra.handcount >= 2 then
 card.ability.extra.defeat = true
 end
end
end
end

 if context.after and card.ability.extra.defeat == true and not context.blueprint then
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

if context.main_eval and context.end_of_round and G.GAME.blind.boss and card.ability.extra.defeat == false and not context.blueprint then
for i=1, #G.deck.cards do
G.deck.cards[i].ability.perma_bonus = G.deck.cards[i].ability.perma_bonus - 10
end
for i=1, #G.hand.cards do
G.hand.cards[i].ability.perma_bonus = G.hand.cards[i].ability.perma_bonus - 10
end
for i=1, #G.discard.cards do
G.discard.cards[i].ability.perma_bonus = G.discard.cards[i].ability.perma_bonus - 10
end
end
end
	}
