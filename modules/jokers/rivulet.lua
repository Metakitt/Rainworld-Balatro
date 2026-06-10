SMODS.Joker({
	key = "rivulet",
	atlas = "slugcats",
	pos = { x = 6, y = 0 },
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	attributes = { "slugcat", "generation", "skip" },
	config = { extra = { randomnumber = 1, rounds_to_ascend = 5 }, slugcat = true },
	set_sprites = function(self, card, front)
	if card.ability and card.ability.rw_ascended == true then
	G.E_MANAGER:add_event(Event({
	blockable = false,
	func = function()
	card.children.center:set_sprite_pos({ x = 6, y = 1 })
	return true
	end
	}))
	
	
	else
	G.E_MANAGER:add_event(Event({
	blockable = false,
	func = function()
	card.children.center:set_sprite_pos({ x = 6, y = 0 })
	return true
	end
	}))
	end
	end,
	calculate = function(self, card, context)
	
	-- Temporary / Default 'ascension' requirement
	
	if context.setting_blind and card.ability.rw_ascended ~= true then
	card.ability.extra.rounds_to_ascend = card.ability.extra.rounds_to_ascend -1
	end
	
	if card.ability.extra.rounds_to_ascend <= 0 and card.ability.rw_ascended ~= true then
	card.children.center:set_sprite_pos({ x = 6, y = 1 })
	SMODS.Stickers["rw_ascended"]:apply(card, true)
	end
	
	--
	
		if context.skip_blind then
		if card.ability.rw_ascended ~= true then
			local card_numbers = { 1, 1, 1, 1, 1, 1, 2, 2, 2, 3 }

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
			else
			local card_numbers = { 1, 2, 2, 3, 3, 3, 4, 4, 5, 5 }

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
		end
	end,
})
