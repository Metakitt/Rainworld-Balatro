SMODS.Joker({
	key = "puprivulet",
	atlas = "slugcats",
	pos = { x = 6, y = 5 },
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { randomnumber = 1 }, slugcat = true },

	calculate = function(self, card, context)
		if context.skip_blind then
			local card_numbers = { 1, 1, 1, 1, 1, 1, 2, 2, 2, 2 }

			card.ability.extra.randomnumber = SCUG.number_in_range(1, 10, "rw_rivulet")
			local cards_created = card_numbers[card.ability.extra.randomnumber]
			local all_cards = {}

			for _ = 1, cards_created do
				local rank = pseudorandom_element(SMODS.Ranks, "rw_rivulet_rank", {})
				local suit = pseudorandom_element(SMODS.Suits, "rw_rivulet_rank", {})
				all_cards[#all_cards + 1] = SMODS.add_card({
					area = G.deck,
					rank = rank.key,
					suit = suit.key,
					set = "Enhanced",
				})
			end
			SMODS.calculate_context { playing_card_added = true, cards = all_cards }
		end
	end,
})
