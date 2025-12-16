SMODS.Joker({
	key = "pupranger",
	atlas = "slugcats",
	pos = { x = 1, y = 6 },
	rarity = 3,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { jslot = 1 }, slugcat = true },

	add_to_deck = function(self, card, from_debuff)
		if G.jokers then
			G.jokers.config.card_limit = G.jokers.config.card_limit + 1
		end
	end,

	remove_from_deck = function(self, card, from_debuff)
		if G.jokers then
			G.jokers.config.card_limit = G.jokers.config.card_limit - 1
		end
	end,
})
