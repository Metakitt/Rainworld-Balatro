SMODS.Joker {
key = 'bluelizard',
set = 'Joker',
atlas = 'enemies',
rarity = "rw_enemy",
cost = 4,
pos = { x = 6, y = 0 },
unlocked = true,
discovered = true,
in_pool = function (self, args)
    return false
end,
config = { extra = {defeat = false, chip_mod = 0.75, chip_threshold = 10, crunch = -5}, enemy = true},
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
    return { vars = { card.ability.extra.chip_mod, card.ability.extra.chip_threshold, card.ability.extra.crunch } }
    end,
add_to_deck = function(self, card, from_debuff) 
SMODS.Stickers["eternal"]:apply(card,true)
    end,
calculate = function(self, card, context)

--Threat
if context.joker_main and not context.blueprint then
return {
x_chips = card.ability.extra.chip_mod,
-- chip_message = 'x0.75 Chips'
}
end

--Defeat
 if context.before and not context.blueprint then
 for i=1, #G.play.cards do
if G.play.cards[i].ability.perma_bonus >= card.ability.extra.chip_threshold and not context.blueprint then
card.ability.extra.defeat = true
end
end
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
    v.ability.perma_bonus = v.ability.perma_bonus + card.ability.extra.crunch
end

end
end
	}
