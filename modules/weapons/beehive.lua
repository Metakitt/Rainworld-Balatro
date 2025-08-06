SMODS.Sticker({
	key = "wbeehive",
	loc_txt = {
		label = "Beehive",
	},
	badge_colour = HEX("875796"),
	atlas = "enhancedcards_scug",
	pos = { x = 0, y = 3 },
	default_compat = true,
	compat_exceptions = {},
	sets = {
		Joker = true,
		Tarot = false,
		Spectral = false,
		foods = false,
	},
	rate = 0.03,
	needs_enable_flag = false,
	calculate = function(self, card, context)
		if context.setting_blind and G.GAME.blind.boss and context.main_eval then
			--print ('a')
			local suit = pseudorandom_element(SMODS.Suits, pseudoseed("mysuit"))
			for _, v in pairs(G.playing_cards) do
				if v:is_suit(suit.name) then
					if v.ability.perma_bonus <= 0 then
						v.ability.perma_bonus = 5
					end
					if v.ability.perma_bonus > 0 then
						v.ability.perma_bonus = (v.ability.perma_bonus or 0) * 2
					end
					v:juice_up(0.5, 0.5)
					SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, v)
				else
					SMODS.debuff_card(v, true, "bees")
				end
			end
			-- for i = 1, #G.deck.cards do
			-- 	local chosen_cards = G.deck.cards[i]

			-- 	if suit.key == "Clubs" then
			-- 		if
			-- 			chosen_cards:is_suit("Hearts")
			-- 			or chosen_cards:is_suit("Spades")
			-- 			or chosen_cards:is_suit("Diamonds")
			-- 		then
			-- 			SMODS.debuff_card(chosen_cards, true, "bees")
			-- 		end
			-- 		if chosen_cards:is_suit("Clubs") and chosen_cards.ability.perma_bonus <= 0 then
			-- 			chosen_cards.ability.perma_bonus = 5
			-- 		end
			-- 		if chosen_cards:is_suit("Clubs") and chosen_cards.ability.perma_bonus > 0 then
			-- 			chosen_cards.ability.perma_bonus = chosen_cards.ability.perma_bonus or 0
			-- 			chosen_cards.ability.perma_bonus = chosen_cards.ability.perma_bonus * 2
			-- 			chosen_cards:juice_up(0.5, 0.5)
			-- 			SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, chosen_cards)
			-- 		end
			-- 	end

			-- 	if suit.key == "Hearts" then
			-- 		if
			-- 			chosen_cards:is_suit("Clubs")
			-- 			or chosen_cards:is_suit("Spades")
			-- 			or chosen_cards:is_suit("Diamonds")
			-- 		then
			-- 			SMODS.debuff_card(chosen_cards, true, "bees")
			-- 		end
			-- 		if chosen_cards:is_suit("Hearts") and chosen_cards.ability.perma_bonus <= 0 then
			-- 			chosen_cards.ability.perma_bonus = 5
			-- 		end
			-- 		if chosen_cards:is_suit("Hearts") and chosen_cards.ability.perma_bonus > 0 then
			-- 			chosen_cards.ability.perma_bonus = chosen_cards.ability.perma_bonus or 0
			-- 			chosen_cards.ability.perma_bonus = chosen_cards.ability.perma_bonus * 2
			-- 			chosen_cards:juice_up(0.5, 0.5)
			-- 			SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, chosen_cards)
			-- 		end
			-- 	end

			-- 	if suit.key == "Diamonds" then
			-- 		if
			-- 			chosen_cards:is_suit("Hearts")
			-- 			or chosen_cards:is_suit("Spades")
			-- 			or chosen_cards:is_suit("Clubs")
			-- 		then
			-- 			SMODS.debuff_card(chosen_cards, true, "bees")
			-- 		end
			-- 		if chosen_cards:is_suit("Diamonds") and chosen_cards.ability.perma_bonus <= 0 then
			-- 			chosen_cards.ability.perma_bonus = 5
			-- 		end
			-- 		if chosen_cards:is_suit("Diamonds") and chosen_cards.ability.perma_bonus > 0 then
			-- 			chosen_cards.ability.perma_bonus = chosen_cards.ability.perma_bonus or 0
			-- 			chosen_cards.ability.perma_bonus = chosen_cards.ability.perma_bonus * 2
			-- 			chosen_cards:juice_up(0.5, 0.5)
			-- 			SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, chosen_cards)
			-- 		end
			-- 	end

			-- 	if suit.key == "Spades" then
			-- 		if
			-- 			chosen_cards:is_suit("Hearts")
			-- 			or chosen_cards:is_suit("Clubs")
			-- 			or chosen_cards:is_suit("Diamonds")
			-- 		then
			-- 			SMODS.debuff_card(chosen_cards, true, "bees")
			-- 		end
			-- 		if chosen_cards:is_suit("Spades") and chosen_cards.ability.perma_bonus <= 0 then
			-- 			chosen_cards.ability.perma_bonus = 5
			-- 		end
			-- 		if chosen_cards:is_suit("Spades") and chosen_cards.ability.perma_bonus > 0 then
			-- 			chosen_cards.ability.perma_bonus = chosen_cards.ability.perma_bonus or 0
			-- 			chosen_cards.ability.perma_bonus = chosen_cards.ability.perma_bonus * 2
			-- 			chosen_cards:juice_up(0.5, 0.5)
			-- 			SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, chosen_cards)
			-- 		end
			-- 	end
			-- end
		elseif context.end_of_round then
			-- for i = 1, #G.deck.cards do
			-- 	local chosen_cards = G.deck.cards[i]
			-- 	SMODS.debuff_card(chosen_cards, "reset", "bees")
			-- end
			-- for i = 1, #G.hand.cards do
			-- 	local chosen_cards = G.hand.cards[i]
			-- 	SMODS.debuff_card(chosen_cards, "reset", "bees")
			-- end
			-- for i = 1, #G.discard.cards do
			-- 	local chosen_cards = G.discard.cards[i]
			-- 	SMODS.debuff_card(chosen_cards, "reset", "bees")
			-- end
			for _, v in pairs(G.playing_cards) do
				SMODS.debuff_card(v, "reset", "bees")
			end
		end
	end,
})

SMODS.Consumable({
	key = "beehive",
	set = "obtainweapon",
	atlas = "weaponfoods",
	pos = { x = 1, y = 2 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { weapon = "rw_wbeehive" },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = card.ability.weapon }
	end,
	can_use = function(self, card)
		return #G.jokers.highlighted == 1
			and not G.jokers.highlighted[1].ability.enemy
			and not G.jokers.highlighted[1].ability[card.ability.weapon]
	end,
	use = function(self, card, area, copier)
		for _, v in ipairs(G.jokers.highlighted) do
			SMODS.Stickers[card.ability.weapon]:apply(v, true)
		end
	end,
})
