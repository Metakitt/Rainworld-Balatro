--[[Threat: Blind requirement increases by 10% permanently for each hand scored.
Defeat Condition: Use two flashbangs.
If not defeated: Removes weapons from currently owned jokers. 1 in 50 chance to end the run instead.]]
SMODS.Joker {
key = 'mirosvulture',
atlas = "enemies",
rarity = 'rw_enemy',
cost = 4,
pos = { x = 6, y = 4 },
unlocked = true,
discovered = true,
in_pool = function (self, args)
    return false
end,
config = { extra = {defeat = false, flashbang = 0, odds = 50}, enemy = true},
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
    return { vars = { card.ability.extra.flashbang,(G.GAME and G.GAME.probabilities.normal) or 1,
				card.ability.extra.odds } }
    end,
add_to_deck = function(self, card, from_debuff) 
SMODS.Stickers["eternal"]:apply(card,true)
    end,
calculate = function(self, card, context)
--Threat

if context.after and not context.blueprint then
G.GAME.mirosbird = G.GAME.mirosbird + 0.1
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

if
			context.main_eval
			and context.end_of_round
			and G.GAME.blind.boss
			and card.ability.extra.defeat == false
			and not context.blueprint
		then
		if pseudorandom("rw_scavendish") < G.GAME.probabilities.normal / card.ability.extra.odds then
		G.E_MANAGER:add_event(Event({
                trigger = "ease",
                delay = 2.0,
                ref_table = G.GAME,
                ref_value = "chips",
                ease_to = SCUG.big(0),
				func = (function(x) return math.floor(x) end)
            }))
            end_round()
		else
			for _, v in pairs(G.jokers.cards) do
				for k, _ in pairs(v.ability) do
					st, nd = string.find(k, "rw_w")
					if st and nd then
						SMODS.Stickers[k]:apply(v, nil)
					end
				end
			end
			card_eval_status_text(card, "extra", nil, nil, nil, {
				message = localize("k_yoinked_ex"),
				colour = G.C.RED,
			})
		end
end
end
	}
