SMODS.Back({
	name = "5P Deck",
	key = "pebblesdeck",
	atlas = "enhancedcards_scug",
	pos = { x = 1, y = 0 },
	loc_txt = {
		name = "5P deck",
		text = {
			"Start with {C:attention}8",
			"{C:rot}Rot{} cards.",
		},
	},
	apply = function()
		G.E_MANAGER:add_event(Event({
			func = function()
				local cardstomodify = {}
				local notrot = {}
				for i = 1, #G.deck.cards do
					if
						G.deck.cards[i] ~= card
						and G.deck.cards[i].config.center ~= G.P_CENTERS.m_rw_rotting
						and not G.deck.cards[i].getting_sliced
					then
						notrot[#notrot + 1] = G.deck.cards[i]
					end
				end
				local rotted = #notrot > 0 and pseudorandom_element(notrot, pseudoseed("explode")) or nil
				if #notrot > 0 then
					rotted:set_ability(G.P_CENTERS.m_rw_rotting)
				end
				local rotted = #notrot > 0 and pseudorandom_element(notrot, pseudoseed("explode")) or nil
				if #notrot > 0 then
					rotted:set_ability(G.P_CENTERS.m_rw_rotting)
				end
				local rotted = #notrot > 0 and pseudorandom_element(notrot, pseudoseed("explode")) or nil
				if #notrot > 0 then
					rotted:set_ability(G.P_CENTERS.m_rw_rotting)
				end
				local rotted = #notrot > 0 and pseudorandom_element(notrot, pseudoseed("explode")) or nil
				if #notrot > 0 then
					rotted:set_ability(G.P_CENTERS.m_rw_rotting)
				end
				local rotted = #notrot > 0 and pseudorandom_element(notrot, pseudoseed("explode")) or nil
				if #notrot > 0 then
					rotted:set_ability(G.P_CENTERS.m_rw_rotting)
				end
				local rotted = #notrot > 0 and pseudorandom_element(notrot, pseudoseed("explode")) or nil
				if #notrot > 0 then
					rotted:set_ability(G.P_CENTERS.m_rw_rotting)
				end
				local rotted = #notrot > 0 and pseudorandom_element(notrot, pseudoseed("explode")) or nil
				if #notrot > 0 then
					rotted:set_ability(G.P_CENTERS.m_rw_rotting)
				end
				local rotted = #notrot > 0 and pseudorandom_element(notrot, pseudoseed("explode")) or nil
				if #notrot > 0 then
					rotted:set_ability(G.P_CENTERS.m_rw_rotting)
				end

				return true
			end,
		}))
	end,
})

SMODS.Back({
	name = "Looks To The Moon Deck",
	key = "LTTMdeck",
	atlas = "enhancedcards_scug",
	pos = { x = 1, y = 0 },
	loc_txt = {
		name = "Looks To The Moon deck",
		text = {
			"Club cards gain 2 extra chips",
			"at the end of each blind.",
			"1~4 random cards become Wet",
			"at the end of each blind.",
			"Cards can become Moldy and Rot."
		},
	},
	calculate = function(self,back,context)
	
	if context.end_of_round and context.main_eval then
	--local suit = SCUG.get_suit_in_deck() --pseudorandom_element(SMODS.Suits, pseudoseed("mysuit"))
			for _, other_card in ipairs(G.playing_cards) do
				if other_card:is_suit("Clubs") then
					other_card.ability.perma_bonus = other_card.ability.perma_bonus or 0
					other_card.ability.perma_bonus = other_card.ability.perma_bonus + 2
					card_eval_status_text(other_card, "extra", nil, nil, nil, {
						message = localize("k_upgrade_ex"),
						colour = G.C.BLUE,
					})
				end
			end
	end
	
	
	
	end
})

--[[All Club cards gain 3 extra chip at the end of each Blind.
All Club cards gain 1 Mult at the end of each boss Blind.
1~4 cards become wet at the end of each blind.
Cards can become moldy / rot.]]
