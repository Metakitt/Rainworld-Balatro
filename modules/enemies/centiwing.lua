--[[Threat: -3000 Chips after calculations.
Defeat condition: Score 3 cards with extra chips > 20
If not defeated: All cards with 5 or more extra chips in the deck are debuffed.]]

SMODS.Joker {
key = 'centiwing',
atlas = 'enemies',
rarity = 'rw_enemy',
cost = 4,
pos = { x = 6, y = 3 },
unlocked = true,
discovered = true,
in_pool = function (self, args)
    return false
end,
config = { extra = {defeat = false, bonuscards = 0, unchips = -8000}, enemy = true},
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
    return { vars = { number_format(card.ability.extra.unchips), card.ability.extra.bonuscards } }
    end,
add_to_deck = function(self, card, from_debuff) 
SMODS.Stickers["eternal"]:apply(card,true)
    end,
calculate = function(self, card, context)

if G.GAME.round_resets.ante == 7 then
card.ability.extra.unchips = -8000
elseif G.GAME.round_resets.ante == 8 then
card.ability.extra.unchips = -12000
elseif G.GAME.round_resets.ante > 8 then
card.ability.extra.unchips = -8000 * (G.GAME.round_resets.ante/2)
end

--Threat
if context.final_scoring_step and context.cardarea == G.jokers and not context.blueprint then
G.GAME.chips = G.GAME.chips + SCUG.big(card.ability.extra.unchips)
end

--Defeat
if context.before and not context.blueprint then
for i=1, #G.play.cards do
if G.play.cards[i].ability.perma_bonus >= 20 and not context.blueprint then
card.ability.extra.bonuscards = card.ability.extra.bonuscards + 1
end
end
end

if card.ability.extra.bonuscards >= 3 then
card.ability.extra.defeat = true
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

if context.main_eval and context.end_of_round and G.GAME.blind.boss and card.ability.extra.defeat == false and not context.blueprint  then

for _, v in ipairs(G.deck.cards) do
	if v.ability.perma_bonus >= 5 then
	SMODS.debuff_card(v, true, "centiwing")
        end
    end
	
	for _, v in ipairs(G.hand.cards) do
	if v.ability.perma_bonus >= 5  then
       SMODS.debuff_card(v, true, "centiwing")
        end
    end
	
for _, v in ipairs(G.discard.cards) do
	if v.ability.perma_bonus >= 5  then
         SMODS.debuff_card(v, true, "centiwing")
        end
    end


end
end
	}
