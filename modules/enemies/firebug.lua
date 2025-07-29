--[[Threat:
(Starts off neutral, but if you have a joker with a spear / sporepuff, they have a 1 in 2 chance to become aggro) (When aggro, 1 in 2 chance to destroy a random rank at the end of round)
Defeat Condition: 1 in 10 chance to defeat it if you have a joker with a sporepuff.
If not defeated: Weapons are 4x less likely to show up in shops.]]
SMODS.Joker {
key = 'firebug',
atlas = "enemies",
rarity = 'rw_enemy',
cost = 4,
pos = { x = 7, y = 4 },
unlocked = true,
discovered = true,
in_pool = function (self, args)
    return false
end,
config = { extra = {defeat = false, aggressive = false, aggodds = 2, odds = 20}, enemy = true},
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
if card.ability.extra.aggressive == false then
			return {
				vars = { (G.GAME and G.GAME.probabilities.normal) or 1, card.ability.extra.aggodds,
				card.ability.extra.odds },
				key = self.key .. "_neutral",
			}
		end

		if card.ability.extra.aggressive == true then
			return {
				vars = { (G.GAME and G.GAME.probabilities.normal) or 1, card.ability.extra.aggodds,
				card.ability.extra.odds },
				key = self.key .. "_aggressive",
			}
		end
    end,
add_to_deck = function(self, card, from_debuff) 
SMODS.Stickers["eternal"]:apply(card,true)
    end,
calculate = function(self, card, context)

--Threat
if context.setting_blind and (SCUG.weapon_count("rw_wspear") + SCUG.weapon_count("rw_wsporepuff")) > 0 and card.ability.extra.aggressive == false then
if pseudorandom("fireboog") < 1 / card.ability.extra.aggodds and not context.blueprint then
card.ability.extra.aggressive = true
end
end
		

--Defeat
 if context.before and not context.blueprint and pseudorandom('boogdestruction') < 1 / card.ability.extra.odds then
 if SCUG.weapon_count("rw_wsporepuff") > 0 and not context.blueprint then
 card.ability.extra.defeat = true
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
--Undefeated + Aggro


if card.ability.extra.aggressive == true then
if context.main_eval and context.end_of_round and G.GAME.blind.boss and card.ability.extra.defeat == false and not context.blueprint then
for k,v in pairs(SMODS.Stickers) do
			local st, nd = string.find(k, "rw_w")
			if st == 1 and nd == 4 then
				v.rate = v.rate / 4
			end
		end
	
	if pseudorandom('boogpowerup') < 1 / card.ability.extra.aggodds then
 local rank = SCUG.get_rank_in_deck()
    for _, v in ipairs(G.deck.cards) do
        if v.config.card.value == rank and not context.blueprint then
            SMODS.destroy_cards(v)
        end
    end
end
	
elseif pseudorandom('boogpowerup') < 1 / card.ability.extra.aggodds and context.main_eval and context.end_of_round and card.ability.extra.defeat == false and not context.blueprint and not G.GAME.blind.boss then
 local rank = SCUG.get_rank_in_deck()
    for _, v in ipairs(G.deck.cards) do
        if v.config.card.value == rank and not context.blueprint then
            SMODS.destroy_cards(v)
        end
    end
end
end
end
	}
