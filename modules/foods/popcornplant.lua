SMODS.Consumable({
	key = "popcornplant",
	set = "foods",
	atlas = "weaponfoods",
	rarity = "rw_fooduncommon",
	pos = { x = 0, y = 1 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { extra = { upgrade = 2 }, name = "popcornplant" },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.upgrade } }
	end,
	set_badges = function(self, card, badges)
		badges[#badges + 1] = create_badge(localize("k_fooduncommon"), G.C.GREEN, G.C.WHITE, 1.2)
	end,
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		if card.ability.name == "popcornplant" then
			local suit = SCUG.get_suit_in_deck() --pseudorandom_element(SMODS.Suits, pseudoseed("mysuit"))
			for _, other_card in ipairs(G.deck.cards) do
				if other_card:is_suit(suit) then
					other_card.ability.perma_bonus = other_card.ability.perma_bonus or 0
					other_card.ability.perma_bonus = other_card.ability.perma_bonus + card.ability.extra.upgrade
					other_card.ability.perma_mult = other_card.ability.perma_mult or 0
					other_card.ability.perma_mult = other_card.ability.perma_mult + card.ability.extra.upgrade
					card_eval_status_text(other_card, "extra", nil, nil, nil, {
						message = localize("k_upgrade_ex"),
						colour = G.C.CHIPS,
					})
				end
			end
		end
	end,
})
