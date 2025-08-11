SMODS.Joker ({
key = 'trainlizard',
atlas = "enemies",
rarity = 'rw_enemy',
cost = 4,
pos = { x = 0, y = 5 },
unlocked = true,
discovered = true,
in_pool = function (self, args)
    return false
end,
config = { extra = {defeat = false, jokersold = 0, scoredhand = 0}, enemy = true},
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
    return { vars = { card.ability.extra.jokersold, card.ability.extra.scoredhand } }
    end,
add_to_deck = function(self, card, from_debuff) 
SMODS.Stickers["eternal"]:apply(card,true)
    end,
calculate = function(self, card, context)

--Threat
if context.setting_blind then
local jokers = {}
			for i, v in pairs(G.jokers.cards) do
				if v.ability.enemy ~= true and v.ability.eternal ~= true and v ~= nil then
					jokers[#jokers + 1] = v
				end
			end
			if #G.jokers.cards >= 2 then
			local chosen_joker = jokers[math.random(1, #jokers)]
			SMODS.debuff_card(chosen_joker, true, "train")
			end
end


if (context.before or context.discard) and not context.blueprint then
local rank = SCUG.get_rank_in_deck() 
    for _, v in ipairs(G.deck.cards) do
        if v.config.card.value == rank and not context.blueprint then
            SMODS.debuff_card(v, true, "train")
        end
    end
	 for _, v in ipairs(G.hand.cards) do
        if v.config.card.value == rank and not context.blueprint then
            SMODS.debuff_card(v, true, "train")
        end
    end
	 for _, v in ipairs(G.discard.cards) do
        if v.config.card.value == rank and not context.blueprint then
            SMODS.debuff_card(v, true, "train")
        end
    end
	end

--Defeat
 if context.selling_card and context.card.ability.set == "Joker" and not context.blueprint then
 card.ability.extra.jokersold = card.ability.extra.jokersold + 1
end

if context.after and card.ability.extra.defeat == false and not context.blueprint then
card.ability.extra.scoredhand = card.ability.extra.scoredhand + 1
end

if card.ability.extra.scoredhand >= 3 and card.ability.extra.jokersold >= 3 then
 for _,v in ipairs(G.hand.cards) do
 SMODS.debuff_card(v, remove, "train")
 end
 for _,v in ipairs(G.deck.cards) do
 SMODS.debuff_card(v, remove, "train")
 end
 for _,v in ipairs(G.discard.cards) do
 SMODS.debuff_card(v, remove, "train")
 end
card.ability.extra.defeat = true
end

if card.ability.extra.defeat == true and not context.blueprint then
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
if
			context.main_eval
			and context.end_of_round
			and G.GAME.blind.boss
			and card.ability.extra.defeat == false
			and not context.blueprint
		then
			-- Die
            G.E_MANAGER:add_event(Event({
                trigger = "ease",
                delay = 2.0,
                ref_table = G.GAME,
                ref_value = "chips",
                ease_to = SCUG.big(0),
				func = (function(x) return math.floor(x) end)
            }))
            end_round()
		end
    end
})
