SMODS.Joker {
key = 'chieftain',
atlas = "enemies",
rarity = 'rw_enemy',
cost = 4,
pos = { x = 3, y = 5 },
unlocked = true,
discovered = true,
in_pool = function (self, args)
    return false
end,
config = { extra = {defeat = false, threshold = 1.50}, enemy = true},
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
if context.before and not context.blueprint then
-- removes a random weapon from each joker each hand
end

--Defeat
		if context.main_eval and context.end_of_round and not context.blueprint then
			local score_ratio = G.GAME.chips / G.GAME.blind.chips
			if score_ratio >= SCUG.big(card.ability.extra.threshold) then
				card.ability.extra.defeat = true
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = "Safe.",
					colour = G.C.RED
				})
				SMODS.destroy_cards(card, true)
			end
		end

--Undefeated

if context.main_eval and context.end_of_round and G.GAME.blind.boss and card.ability.extra.defeat == false and not context.blueprint  then
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
	}
