SMODS.Consumable({
	key = "eggbugegg",
	set = "foods",
	atlas = "weaponfoods",
	rarity = "rw_fooduncommon",
	pos = { x = 8, y = 0 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { extra = { upgrade = 4 }, name = "eggbugegg" },
	set_badges = function(self, card, badges)
		badges[#badges + 1] = create_badge(localize("k_fooduncommon"), G.C.GREEN, G.C.WHITE, 1.2)
	end,
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		if card.ability.name == "eggbugegg" then
			local suit = pseudorandom_element(SMODS.Suits, pseudoseed("mysuit"))

			if suit.key == "Clubs" then
				for i = 1, #G.deck.cards do
					local other_card = G.deck.cards[i]
					if other_card:is_suit("Clubs") then
						other_card.ability.perma_bonus = other_card.ability.perma_bonus or 0
						other_card.ability.perma_bonus = other_card.ability.perma_bonus + card.ability.extra.upgrade
						other_card:juice_up(0.5, 0.5)
						SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, other_card)
					end
				end
			end

			if suit.key == "Hearts" then
				for i = 1, #G.deck.cards do
					local other_card = G.deck.cards[i]
					if other_card:is_suit("Hearts") then
						other_card.ability.perma_bonus = other_card.ability.perma_bonus or 0
						other_card.ability.perma_bonus = other_card.ability.perma_bonus + card.ability.extra.upgrade
						other_card:juice_up(0.5, 0.5)
						SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, other_card)
					end
				end
			end

			if suit.key == "Diamonds" then
				for i = 1, #G.deck.cards do
					local other_card = G.deck.cards[i]
					if other_card:is_suit("Diamonds") then
						other_card.ability.perma_bonus = other_card.ability.perma_bonus or 0
						other_card.ability.perma_bonus = other_card.ability.perma_bonus + card.ability.extra.upgrade
						other_card:juice_up(0.5, 0.5)
						SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, other_card)
					end
				end
			end

			if suit.key == "Spades" then
				for i = 1, #G.deck.cards do
					local other_card = G.deck.cards[i]
					if other_card:is_suit("Spades") then
						other_card.ability.perma_bonus = other_card.ability.perma_bonus or 0
						other_card.ability.perma_bonus = other_card.ability.perma_bonus + card.ability.extra.upgrade
						other_card:juice_up(0.5, 0.5)
						SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, other_card)
					end
				end
			end
		end
	end,
})
