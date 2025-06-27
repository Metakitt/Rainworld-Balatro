SMODS.Joker({
	key = "ranger",
	atlas = "slugcats",
	loc_txt = {
		name = "Ranger",
		text = {
			"{C:edition}+1{} Joker Slot",
			"{C:attention}+1{} consumable Slot",
			"{C:attention}+1{} hand size",
			"{C:blue}-1{} hand each round",
		},
	},
	pos = { x = 3, y = 3 },
	rarity = 3,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { jslot = 1, cslot = 1, h_size = 1, h_plays = 1 }, slugcat = true },

	add_to_deck = function(self, card, from_debuff)
		if G.jokers then
			G.jokers.config.card_limit = G.jokers.config.card_limit + 1
		end

		ease_hands_played(-card.ability.extra.h_plays)
		G.hand:change_size(card.ability.extra.h_size)
		G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
		G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.h_plays
	end,

	remove_from_deck = function(self, card, from_debuff)
		if G.jokers then
			G.jokers.config.card_limit = G.jokers.config.card_limit - 1
		end

		G.hand:change_size(-card.ability.extra.h_size)
		G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.h_plays
		ease_hands_played(card.ability.extra.h_plays)
		G.consumeables.config.card_limit = G.consumeables.config.card_limit - 1
	end,
})
