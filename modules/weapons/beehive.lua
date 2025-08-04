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
			for i = 1, #G.deck.cards do
				local chosen_cards = G.deck.cards[i]

				if suit.key == "Clubs" then
					if
						chosen_cards:is_suit("Hearts")
						or chosen_cards:is_suit("Spades")
						or chosen_cards:is_suit("Diamonds")
					then
						SMODS.debuff_card(chosen_cards, true, "bees")
					end
					if chosen_cards:is_suit("Clubs") and chosen_cards.ability.perma_bonus <= 0 then
						chosen_cards.ability.perma_bonus = 5
					end
					if chosen_cards:is_suit("Clubs") and chosen_cards.ability.perma_bonus > 0 then
						chosen_cards.ability.perma_bonus = chosen_cards.ability.perma_bonus or 0
						chosen_cards.ability.perma_bonus = chosen_cards.ability.perma_bonus * 2
						chosen_cards:juice_up(0.5, 0.5)
						SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, chosen_cards)
					end
				end

				if suit.key == "Hearts" then
					if
						chosen_cards:is_suit("Clubs")
						or chosen_cards:is_suit("Spades")
						or chosen_cards:is_suit("Diamonds")
					then
						SMODS.debuff_card(chosen_cards, true, "bees")
					end
					if chosen_cards:is_suit("Hearts") and chosen_cards.ability.perma_bonus <= 0 then
						chosen_cards.ability.perma_bonus = 5
					end
					if chosen_cards:is_suit("Hearts") and chosen_cards.ability.perma_bonus > 0 then
						chosen_cards.ability.perma_bonus = chosen_cards.ability.perma_bonus or 0
						chosen_cards.ability.perma_bonus = chosen_cards.ability.perma_bonus * 2
						chosen_cards:juice_up(0.5, 0.5)
						SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, chosen_cards)
					end
				end

				if suit.key == "Diamonds" then
					if
						chosen_cards:is_suit("Hearts")
						or chosen_cards:is_suit("Spades")
						or chosen_cards:is_suit("Clubs")
					then
						SMODS.debuff_card(chosen_cards, true, "bees")
					end
					if chosen_cards:is_suit("Diamonds") and chosen_cards.ability.perma_bonus <= 0 then
						chosen_cards.ability.perma_bonus = 5
					end
					if chosen_cards:is_suit("Diamonds") and chosen_cards.ability.perma_bonus > 0 then
						chosen_cards.ability.perma_bonus = chosen_cards.ability.perma_bonus or 0
						chosen_cards.ability.perma_bonus = chosen_cards.ability.perma_bonus * 2
						chosen_cards:juice_up(0.5, 0.5)
						SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, chosen_cards)
					end
				end

				if suit.key == "Spades" then
					if
						chosen_cards:is_suit("Hearts")
						or chosen_cards:is_suit("Clubs")
						or chosen_cards:is_suit("Diamonds")
					then
						SMODS.debuff_card(chosen_cards, true, "bees")
					end
					if chosen_cards:is_suit("Spades") and chosen_cards.ability.perma_bonus <= 0 then
						chosen_cards.ability.perma_bonus = 5
					end
					if chosen_cards:is_suit("Spades") and chosen_cards.ability.perma_bonus > 0 then
						chosen_cards.ability.perma_bonus = chosen_cards.ability.perma_bonus or 0
						chosen_cards.ability.perma_bonus = chosen_cards.ability.perma_bonus * 2
						chosen_cards:juice_up(0.5, 0.5)
						SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, chosen_cards)
					end
				end
			end
		elseif context.end_of_round then
			for i = 1, #G.deck.cards do
				local chosen_cards = G.deck.cards[i]
				SMODS.debuff_card(chosen_cards, "reset", "bees")
			end
			for i = 1, #G.hand.cards do
				local chosen_cards = G.hand.cards[i]
				SMODS.debuff_card(chosen_cards, "reset", "bees")
			end
			for i = 1, #G.discard.cards do
				local chosen_cards = G.discard.cards[i]
				SMODS.debuff_card(chosen_cards, "reset", "bees")
			end
		end
	end,
})

SMODS.Consumable({
	key = "beehive",
	loc_txt = {
		name = "Beehive",
		text = { "Gives a Beehive", "to 1 Joker." },
	},
	set = "obtainweapon",
	atlas = "weaponfoods",
	pos = { x = 1, y = 2 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { extra = { upgrade = 15 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "rw_wbeehive" }
	end,
		can_use = function(self, card)
		if G.jokers.highlighted[1].ability.enemy == true then 
		return false
		end
	if not G.jokers.highlighted[1].ability.enemy then
		return true
		end
	end,
	use = function(self, card, area, copier)
		for i, v in ipairs(G.jokers.highlighted) do
			for i = 1, #G.jokers.highlighted do
				SMODS.Stickers["rw_wbeehive"]:apply(v, true)
			end
		end
	end,
})
