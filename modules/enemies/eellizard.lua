SMODS.Joker({
	key = "eellizard",
	config = {
		extra = {
			wetcount = 0,
			defeat = false,
		},
	},
	rarity = "rw_enemy",
	cost = 3,
	atlas = "enemies",
	pos = { x = 2, y = 2 },
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.wetcount,
		} }
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.Stickers["eternal"]:apply(card, true)
        -- Threat
		for _, v in pairs(G.playing_cards) do
			if v:is_suit("Spades", true) or v:is_suit("Clubs", true) then
				SMODS.debuff_card(v, true, "eel_lizard_temporary")
			end
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		for _, v in pairs(G.playing_cards) do
			if v:is_suit("Spades", true) or v:is_suit("Clubs", true) then
				SMODS.debuff_card(v, false, "eel_lizard_temporary")
			end
		end
	end,
	calculate = function(self, card, context)
		-- Defeat
		if context.before and not context.blueprint then
			for _, v in pairs(context.scoring_hand) do
				if v.config.center_key == "m_rw_wetasscard" then
					card.ability.extra.wetcount = card.ability.extra.wetcount + 1
				end
			end
			if card.ability.extra.wetcount >= 2 then
				card.ability.extra.defeat = true
			end
		end
		if context.after and card.ability.extra.defeat then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 1.3,
				func = function()
					SMODS.destroy_cards(card, true)
					return true
				end,
			}))
		end
		-- Undefeated
		if
			context.main_eval
			and context.end_of_round
			and G.GAME.blind.boss
			and card.ability.extra.defeat == false
			and not context.blueprint
		then
			for _, v in pairs(G.playing_cards) do
				if v:is_suit("Spades", true) or v:is_suit("Clubs", true) then
					SMODS.debuff_card(v, true, "eel_lizard_permanent")
				end
			end
		end
	end,
})
