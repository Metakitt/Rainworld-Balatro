--[[Threat: At the start of each blind, 1 in 20 chance for each card in your deck to become rot.
Defeat condition: Score a hand while holding an explosive spear.
If not defeated: Chooses a random rank. Turns it to rot.]]

SMODS.Joker {
key = 'brotherlonglegs',
atlas = 'slugpups',
rarity = 1,
cost = 4,
pos = { x = 0, y = 0 },
unlocked = true,
discovered = true,
in_pool = function (self, args)
    return false
end,
config = { extra = {defeat = false, odds = 20}, enemy = true},
loc_vars = function(self, info_queue, card)
    return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end,
add_to_deck = function(self, card, from_debuff) 
SMODS.Stickers["eternal"]:apply(card,true)
    end,
calculate = function(self, card, context)

--Threat
if context.setting_blind then
for i = 1, #G.deck.cards do
if pseudorandom('bite') < 0.05 then
G.deck.cards[i]:set_ability(G.P_CENTERS.m_rw_rotting)
else
--print('Safe')
end
end
end
--Defeat
 if context.joker_main then
 for i = 1, #G.jokers.cards do
 if G.jokers.cards[i].ability.rw_wspear_exp and not context.blueprint then
 card.ability.extra.defeat = true
end
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

if context.main_eval and context.end_of_round and G.GAME.blind.boss then
	if context.main_eval and context.end_of_round and G.GAME.blind.boss then
    local rank = pseudorandom_element(SMODS.Ranks, pseudoseed("rotten_rank"))
    for _, v in ipairs(G.deck.cards) do
        if v:get_id() == rank.id then
            v:set_ability(G.P_CENTERS.m_rw_rotting)
        end
    end
end
end
	end
	}
	