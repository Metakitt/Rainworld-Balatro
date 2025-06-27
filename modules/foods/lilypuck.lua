SMODS.Consumable({
	key = "lilypuck",
	set = "foods",
	atlas = "weaponfoods",
	rarity = "rw_fooduncommon",
	pos = { x = 7, y = 0 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { extra = { upgrade = 15 }, name = "lilypuck" },
	set_badges = function(self, card, badges)
		badges[#badges + 1] = create_badge(localize("k_fooduncommon"), G.C.GREEN, G.C.WHITE, 1.2)
	end,
	can_use = function(self, card)
		if card.area == G.pack_cards or G.GAME.blind.in_blind then
			return true
		end
	end,
	use = function(self, card, area, copier)
		if card.ability.name == "lilypuck" then
			for k, v in pairs(G.hand.cards) do
			end
			local chosen_hand = pseudorandom_element(G.hand.cards, pseudoseed("test"))

			G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.4,
				func = function()
					local other_card =
						copy_card(chosen_hand, nil, nil, nil, chosen_hand.edition and chosen_hand.edition.negative)
					other_card:start_materialize()
					other_card:add_to_deck()
					G.deck.config.card_limit = G.deck.config.card_limit + 1
					G.hand:emplace(other_card)
					playing_card_joker_effects({ other_card })
					table.insert(G.playing_cards, other_card)
					draw_card(G.play, G.deck, 90, "up", nil)
					if other_card.edition and other_card.edition.negative then
						other_card:set_edition(nil, true)
					end

					return true
				end,
			}))
		end
	end,
})
