SMODS.Back({
	name = "5P Deck",
	key = "pebblesdeck",
	atlas = "enhancedcards_scug",
	pos = { x = 1, y = 0 },
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.rotten_cards } }
	end,
	config = {
		rotten_cards = 8
	},
	apply = function(self, back)
		G.E_MANAGER:add_event(Event({
			func = function()
				-- local cardstomodify = {}
				local notrot = {}
				-- for i = 1, #G.deck.cards do
				-- 	if
				-- 		G.deck.cards[i] ~= card
				-- 		and G.deck.cards[i].config.center ~= G.P_CENTERS.m_rw_rotting
				-- 		and not G.deck.cards[i].getting_sliced
				-- 	then
				-- 		notrot[#notrot + 1] = G.deck.cards[i]
				-- 	end
				-- end
				-- local rotted = #notrot > 0 and pseudorandom_element(notrot, pseudoseed("explode")) or nil
				-- if #notrot > 0 then
				-- 	rotted:set_ability(G.P_CENTERS.m_rw_rotting)
				-- end
				-- local rotted = #notrot > 0 and pseudorandom_element(notrot, pseudoseed("explode")) or nil
				-- if #notrot > 0 then
				-- 	rotted:set_ability(G.P_CENTERS.m_rw_rotting)
				-- end
				-- local rotted = #notrot > 0 and pseudorandom_element(notrot, pseudoseed("explode")) or nil
				-- if #notrot > 0 then
				-- 	rotted:set_ability(G.P_CENTERS.m_rw_rotting)
				-- end
				-- local rotted = #notrot > 0 and pseudorandom_element(notrot, pseudoseed("explode")) or nil
				-- if #notrot > 0 then
				-- 	rotted:set_ability(G.P_CENTERS.m_rw_rotting)
				-- end
				-- local rotted = #notrot > 0 and pseudorandom_element(notrot, pseudoseed("explode")) or nil
				-- if #notrot > 0 then
				-- 	rotted:set_ability(G.P_CENTERS.m_rw_rotting)
				-- end
				-- local rotted = #notrot > 0 and pseudorandom_element(notrot, pseudoseed("explode")) or nil
				-- if #notrot > 0 then
				-- 	rotted:set_ability(G.P_CENTERS.m_rw_rotting)
				-- end
				-- local rotted = #notrot > 0 and pseudorandom_element(notrot, pseudoseed("explode")) or nil
				-- if #notrot > 0 then
				-- 	rotted:set_ability(G.P_CENTERS.m_rw_rotting)
				-- end
				-- local rotted = #notrot > 0 and pseudorandom_element(notrot, pseudoseed("explode")) or nil
				-- if #notrot > 0 then
				-- 	rotted:set_ability(G.P_CENTERS.m_rw_rotting)
				-- end
				for _, v in pairs(G.playing_cards) do
					notrot[#notrot + 1] = v
				end
				pseudoshuffle(notrot)
				for i = 1, (back.effect.config.rotten_cards) do
					notrot[i]:set_ability(G.P_CENTERS.m_rw_rotting)
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
	pos = { x = 5, y = 0 },
	calculate = function(self, back, context)
		if context.end_of_round and context.main_eval then
			for _, other_card in ipairs(G.playing_cards) do
				if other_card:is_suit("Clubs") then
					other_card.ability.perma_bonus = other_card.ability.perma_bonus or 0
					other_card.ability.perma_bonus = other_card.ability.perma_bonus + 2
					-- card_eval_status_text(other_card, "extra", nil, nil, nil, {
					-- 	message = localize("k_upgrade_ex"),
					-- 	colour = G.C.BLUE,
					-- })
					SMODS.calculate_effect({
						message = localize("k_upgrade_ex"),
						colour = G.C.BLUE
					}, other_card)
				end
			end

			local cardamount = SCUG.number_in_range(1, 4, "wetitup")
			for i = 1, math.min(cardamount, #G.playing_cards) do
				local card, card_index = pseudorandom_element(G.playing_cards, pseudoseed('tester'))
				card:set_ability(G.P_CENTERS.m_rw_wetasscard)
			end
		end
	end
})

--[[All Club cards gain 3 extra chip at the end of each Blind.
All Club cards gain 1 Mult at the end of each boss Blind.
1~4 cards become wet at the end of each blind.
Cards can become moldy / rot.]]
