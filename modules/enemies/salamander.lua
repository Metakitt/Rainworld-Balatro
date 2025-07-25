--[[Threat: Iterates over the whole deck, 1 in 4 chance to make each card moldy.
Defeat condition: Use 4 tarot cards.
If not defeated: Moldy cards become rot immediately.
Currently, it turns cards wet and not moldy, as moldy cards are not currently implemented.
]]

SMODS.Joker({
	key = "salamander",
	atlas = "enemies",
	rarity = "rw_enemy",
	cost = 4,
	pos = { x = 1, y = 2 },
	unlocked = true,
	discovered = true,
	in_pool = function(self, args)
		return false
	end,
	config = { extra = { defeat = false, tarotcount = 0, wetodds = 4 }, enemy = true },
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
		info_queue[#info_queue+1] = G.P_CENTERS.m_rw_rotting
		return { vars = { card.ability.extra.wetodds, card.ability.extra.tarotcount } }
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.Stickers["eternal"]:apply(card, true)
	end,
	calculate = function(self, card, context)
		--Threat
		if context.setting_blind and not context.blueprint then
			for i = 1, #G.deck.cards do
				if pseudorandom("bite") < 1 / card.ability.extra.wetodds and not context.blueprint then
					G.deck.cards[i]:set_ability(G.P_CENTERS.m_rw_wetasscard)
				else
					--print('Safe')
				end
			end
		end
		--Defeat
		if context.using_consumeable and context.consumeable.ability.set == "Tarot" and not context.blueprint then
			card.ability.extra.tarotcount = card.ability.extra.tarotcount + 1
		end
		if card.ability.extra.tarotcount >= 4 then
			card.ability.extra.defeat = true
		end

		if context.after and card.ability.extra.defeat == true and not context.blueprint then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 1.3,
				func = function()
					SMODS.destroy_cards(card, true)
					return true
				end,
				blocking = false,
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
			for _, v in ipairs(G.deck.cards) do
				if v.config.center_key == "m_rw_wetasscard" then
					v:set_ability(G.P_CENTERS.m_rw_rotting)
				end
			end
		end
	end,
})
