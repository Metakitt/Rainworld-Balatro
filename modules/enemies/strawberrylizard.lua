--[[Threat: A random joker is debuffed at the start of blind.
Defeat condition: Sell a joker.
If not defeated: Makes the last debuffed joker Eternal and it remains debuffed.]]
SMODS.Joker {
key = 'strawberrylizard',
atlas = "enemies",
rarity = 'rw_enemy',
cost = 4,
pos = { x = 5, y = 3 },
unlocked = true,
discovered = true,
in_pool = function (self, args)
    return false
end,
config = { extra = {defeat = false}, enemy = true, last_joker = {}, eternals = {}},
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
    return { vars = {  } }
    end,
add_to_deck = function(self, card, from_debuff) 
SMODS.Stickers["eternal"]:apply(card,true)
    end,
calculate = function(self, card, context)

--Threat
local eternals = {}
if context.setting_blind then
local jokers = {}
			for i, v in pairs(G.jokers.cards) do
				if v.ability.enemy ~= true and v.ability.eternal ~= true and v ~= nil then
					jokers[#jokers + 1] = v
				end
			end
			if #G.jokers.cards >= 2 then
			local chosen_joker = jokers[math.random(1, #jokers)]
			-- print(chosen_joker)
			card.ability.last_joker = chosen_joker
			--chosen_joker:set_debuff(true, "strawberry")
			SMODS.debuff_card(chosen_joker, true, "strawberry")
			end
end

--Defeat
 if context.selling_card and context.card.ability.set == "Joker" and not context.blueprint then
 card.ability.extra.defeat = true
end

 if card.ability.extra.defeat == true and not context.blueprint then
 for _,v in ipairs(G.jokers.cards) do
 SMODS.debuff_card(v, remove, "strawberry")
 end
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

if context.main_eval and context.end_of_round and G.GAME.blind.boss and card.ability.extra.defeat == false and not context.blueprint then
local last_joker = card.ability.last_joker
SMODS.Stickers["eternal"]:apply(last_joker, true)
end
end
	}
