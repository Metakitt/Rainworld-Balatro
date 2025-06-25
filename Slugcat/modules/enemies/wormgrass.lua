SMODS.Joker {
key = 'wormgrass',
atlas = 'slugpups',
rarity = 1,
cost = 4,
pos = { x = 0, y = 0 },
unlocked = true,
discovered = true,
in_pool = function (self, args)
return false
end,
config = { extra = {defeat = false}, enemy = true},
loc_vars = function(self, info_queue, card)
    return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end,
add_to_deck = function(self, card, from_debuff) 
SMODS.Stickers["eternal"]:apply(card,true)
    end,
calculate = function(self, card, context)

--Threat
if context.destroy_card and context.cardarea == G.play and not context.blueprint then
return {remove = true}
end

if context.destroy_card and context.cardarea == 'unscored' and not context.blueprint then
return {remove = true}
end

--Defeat
 if G.GAME.chips > 1000 then
 card.ability.extra.defeat = true
end
 if card.ability.extra.defeat == true then
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
-- Undefeated
-- No effect if left undefeated.
end
	}
