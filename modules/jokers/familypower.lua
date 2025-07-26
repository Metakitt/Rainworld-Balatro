SMODS.Joker({
	key = "familypower",
	config = {
		extra = {
			retriggers = 1,
			suit = "Spades",
		},
	},
	rarity = 1,
	cost = 6,
	atlas = "slugcats",
	pos = { x = 8, y = 4 },
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		local surrounded = G.jokers and (SCUG.enemy_count() / #G.jokers.cards > 0.5) or false
		return {
			vars = {
				localize(card.ability.extra.suit, "suits_singular"),
				card.ability.extra.retriggers,
				not surrounded and "active" or "inactive",
				colours = {
					G.C.SUITS[card.ability.extra.suit],
					not surrounded and G.C.GREEN or G.C.RED,
				},
			},
		}
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			card.ability.extra.suit = SCUG.get_suit_in_deck()
		end

		if
			(context.cardarea == G.play or context.cardarea == G.hand)
			and context.repetition
			and not context.repetition_only
		then
			if context.other_card:is_suit(card.ability.extra.suit) then
				return {
					repetitions = card.ability.extra.retriggers,
					message = localize("k_again_ex"),
					card = card,
				}
			end
		end
	end,
})
