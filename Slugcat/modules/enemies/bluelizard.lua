SMODS.Joker {
key = 'bluelizard',
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
if context.joker_main then
return {
x_chips = 0.75,
chip_message = 'x0.75 Chips'
}
end

--Defeat
 if context.before then
 for i=1, #G.play.cards do
if G.play.cards[i].ability.perma_bonus > 10 then
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

if context.main_eval and context.end_of_round and G.GAME.blind.boss  then
for i=1, #G.deck.cards do
G.deck.cards[i].ability.perma_bonus = G.deck.cards[i].ability.perma_bonus - 5
end
for i=1, #G.hand.cards do
G.hand.cards[i].ability.perma_bonus = G.hand.cards[i].ability.perma_bonus - 5
end
for i=1, #G.discard.cards do
G.discard.cards[i].ability.perma_bonus = G.discard.cards[i].ability.perma_bonus - 5
end

end
end
	}
