--[[Threat: Each played hand becomes wet. At the start of blind, 1 in 20 chance for each card to become wet.
Defeat: Have a Grenade with a +20 Bonus.
Not Defeated: All wet cards are destroyed.]]

SMODS.Joker {
key = 'aquapede',
atlas = 'enemies',
rarity = 'rw_enemy',
cost = 4,
pos = { x = 5, y = 4 },
unlocked = true,
discovered = true,
in_pool = function (self, args)
    return false
end,
config = { extra = {defeat = false, wetodds = 20, mult_threshold = 20}, enemy = true},
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
    info_queue[#info_queue+1] = G.P_CENTERS.m_rw_wetasscard
    info_queue[#info_queue+1] = {key = "rw_wgrenade2", set = "Other"}
    return { vars = { card.ability.extra.wetodds, card.ability.extra.mult_threshold } }
    end,
add_to_deck = function(self, card, from_debuff) 
SMODS.Stickers["eternal"]:apply(card,true)
    end,
calculate = function(self, card, context)

--Threat
if context.before and not context.blueprint then
for i = 1, #G.play.cards do
		local wet = {}
			if G.play.cards[i].config.center ~= G.P_CENTERS.m_rw_wetasscard then
				wet = G.play.cards[i]
				wet:set_ability(G.P_CENTERS.m_rw_wetasscard)
				wet:juice_up()
			end
		end
		end
		
if context.setting_blind and not context.blueprint then
for i = 1, #G.deck.cards do
if pseudorandom('wet') < 1 / card.ability.extra.wetodds and not context.blueprint then
G.deck.cards[i]:set_ability(G.P_CENTERS.m_rw_wetasscard)
end
end
end

--Defeat
if context.joker_main and not context.blueprint then
for i = 1, #G.jokers.cards do
if G.jokers.cards[i].ability.rw_wgrenade and G.GAME.grenademult >= card.ability.extra.mult_threshold and not context.blueprint then
card.ability.extra.defeat = true
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
end

--Undefeated

if context.main_eval and context.end_of_round and G.GAME.blind.boss and card.ability.extra.defeat == false and not context.blueprint  then
    local _, wet_cards = SCUG.enhancement_count("m_rw_wetasscard", true)
    SMODS.destroy_cards(wet_cards)

end
end
	}
