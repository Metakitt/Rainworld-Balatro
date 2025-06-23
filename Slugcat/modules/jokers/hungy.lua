-- Things it will eat:

SMODS.Joker({
	key = "hunger",
	config = {
		extra = {
			x_mult = 4,
			munch_chance = 1000,
			grace_reset = 2,
			grace = 10,
			can_munch = true,
		},
	},
	rarity = 3,
	cost = 5,
	atlas = "slugcats",
	pos = { x = 6, y = 3 },
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	-- loc_vars = function(self, info_queue, card)
	--     return { vars = {

	--     }}
	-- end,
	calculate = function(self, card, context)
		if context.joker_main then
			return { xmult = card.ability.extra.x_mult }
		end
	end,
	update = function(self, card, dt)
		if card.ability.extra.grace > 0 then
			card.ability.extra.grace = card.ability.extra.grace - dt
		end

		if
			#SMODS.find_card("j_rw_hunger") > 0 -- Make sure to replace this with the actual key
			and card.ability.extra.grace <= 0
			and card.ability.extra.can_munch
			and (pseudorandom(pseudoseed("crumchy")) < G.GAME.probabilities.normal / card.ability.extra.munch_chance)
		then
			-- Get all on-screen cards
			local all_cards = {}
			-- Shop: Shop cards, booster packs, vouchers
			if G.STATE == G.STATES.SHOP then
				local shop_areas = { G.shop_vouchers, G.shop_booster, G.shop_jokers }
				for _, area in ipairs(shop_areas) do
					if area then
						for _, v in ipairs(area.cards) do
							table.insert(all_cards, v)
						end
					end
				end
			end
			-- In a booster pack: All the cards in said booster
			if
				G.STATE == G.STATES.TAROT_PACK
				or G.STATE == G.STATES.PLANET_PACK
				or G.STATE == G.STATES.SPECTRAL_PACK
				or G.STATE == G.STATES.BUFFOON_PACK
				or G.STATE == G.STATES.STANDARD_PACK
				or G.STATE == G.STATES.SMODS_BOOSTER_OPENED
			then
				if G.pack_cards and G.pack_cards.cards then
					for _, _card in ipairs(G.pack_cards.cards) do
						table.insert(all_cards, _card)
					end
				end
			end
			-- Actively playing: Cards in hand. NOT cards being scored.
			if G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.HAND_PLAYED then
				if G.hand and G.hand.cards then
					for _, _card in ipairs(G.hand.cards) do
						table.insert(all_cards, _card)
					end
				end
			end
			-- Any time: Jokers, consumeables
			local omnipresent_areas = { G.jokers, G.consumeables }
			for _, area in ipairs(omnipresent_areas) do
				for _, _card in ipairs(area.cards) do
					table.insert(all_cards, _card)
				end
			end

            local snack, key = pseudorandom_element(all_cards, 'crumchy', {})
            if snack and snack ~= card then
                print(snack.config.center.key)
                card.ability.extra.can_munch = false
                if snack.ability.eternal then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            snack:set_eternal(false)
                            card_eval_status_text(snack, "extra", nil, nil, nil, {
                                message = "Saved!",
                                colour = G.C.ETERNAL,
                                instant = instant
                            })
                            return true
                        end
                    }))
                else
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card_eval_status_text(snack, "extra", nil, nil, nil, {
                                message = "Eaten!",
                                colour = G.C.RED,
                                instant = instant
                            })
                            SMODS.destroy_cards(snack)
                            return true
                        end
                    }))
                end
                G.E_MANAGER:add_event(Event({
                    delay = 0.1,
                    func = function()
                        card.ability.extra.can_munch = true
                        return true
                    end
                }))
                card.ability.extra.grace = card.ability.extra.grace_reset * math.min(G.SETTINGS.GAMESPEED, 4)
            end
        end
    end
}