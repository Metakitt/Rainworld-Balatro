SMODS.Joker {
key = 'pinklizard',
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
if context.after and not context.blueprint then
 local destroyablecards = EMPTY(destroyablecards)
            for k, v in pairs(G.deck.cards) do
                    table.insert(destroyablecards, v)
				end   

local chosen_card = pseudorandom_element(destroyablecards, pseudoseed('test'))
if chosen_card ~= nil and pseudorandom('bite') < 0.5 and not chosen_card.getting_sliced and not context.blueprint then
chosen_card:start_dissolve()
end
end
--Defeat
 if context.before and not context.blueprint then
 if next(context.poker_hands['Straight']) and not context.blueprint then
 card.ability.extra.defeat = true
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
for i = 1, #G.deck.cards do
if pseudorandom('bite') < 0.05 then
G.deck.cards[i]:start_dissolve()
else
--print('Safe')
end
end
	
end
	
end
	}
