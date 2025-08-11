SMODS.Joker {
key = 'mirosbird',
atlas = "enemies",
rarity = 'rw_enemy',
cost = 4,
pos = { x = 7, y = 3 },
unlocked = true,
discovered = true,
in_pool = function (self, args)
    return false
end,
config = { extra = {defeat = false, flashbang = 0}, enemy = true},
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
    return { vars = { card.ability.extra.flashbang } }
    end,
add_to_deck = function(self, card, from_debuff) 
SMODS.Stickers["eternal"]:apply(card,true)
    end,
calculate = function(self, card, context)
--Threat
if context.setting_blind and not context.blueprint then
G.GAME.blind.chips = G.GAME.blind.chips * 2
G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
end

--Defeat
if context.skip_blind and not context.blueprint then
if card.ability.extra.flashbang >= 2 then
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
		
--Undefeated



if context.main_eval and context.end_of_round and G.GAME.blind.boss and card.ability.extra.defeat == false and not context.blueprint  then
G.GAME.mirosbird = 2
end
end
	}
