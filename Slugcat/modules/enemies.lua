--[[
Ante 1 enemies:
= Green Lizard
= Pink Lizard
= Young Centipede
= Worm Grass
= Brother Long Legs

Ante 1 has a 1 in 10 chance to roll an enemy on each blind.

--]]

SMODS.Joker {
key = 'greenlizard',
atlas = 'slugpups',
rarity = 1,
cost = 4,
pos = { x = 0, y = 0 },
unlocked = true,
discovered = true,
blueprint_compat = true,
config = { extra = {defeat = false}, enemy = true},
loc_vars = function(self, info_queue, card)
    return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end,
add_to_deck = function(self, card, from_debuff) 
SMODS.Stickers["eternal"]:apply(card,true)
    end,
calculate = function(self, card, context)

--Threat
if context.main_eval and context.end_of_round and not G.GAME.blind.boss then
 local destroyablejokers = EMPTY(destroyablejokers)
            for k, v in pairs(G.jokers.cards) do
                if v.ability.set == 'Joker' and not v.ability.eternal then
                    table.insert(destroyablejokers, v)
                end
				end   

local chosen_card = pseudorandom_element(destroyablejokers, pseudoseed('test'))
if chosen_card ~= nil and pseudorandom('bite') < 0.5 and not chosen_card.getting_sliced then
chosen_card:start_dissolve()
end
end
--Defeat
 if context.before then
 if next(context.poker_hands['Flush']) and not context.blueprint then
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
for i = 1, #G.jokers.cards do
if pseudorandom('bite') < 0.3 and not G.jokers.cards[i].ability.eternal then
G.jokers.cards[i]:start_dissolve()
else
--print('Safe')
end
end
	
end
	
end
	}

