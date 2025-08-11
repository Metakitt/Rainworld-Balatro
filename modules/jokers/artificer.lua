SMODS.Joker({
	key = "artificer",
	atlas = "slugcats",
	pos = { x = 1, y = 0 },
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	perishable_compat = false,
	config = { extra = { chips = 0, bonus_chips = 50, odds = 6 }, slugcat = true, no_lodge = true },

	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.chips,
				(G.GAME.probabilities.normal or 1),
				card.ability.extra.odds,
				card.ability.extra.bonus_chips,
				card.ability.extra.bonus_chips / 2,
			},
		}
	end,

	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chip_mod = card.ability.extra.chips,
				message = localize({ type = "variable", key = "a_chips", vars = { card.ability.extra.chips } }),
			}
		end

		if context.remove_playing_cards or context.cards_destroyed and not context.blueprint then
			for i = 1, #context.removed do
				card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.bonus_chips
				SMODS.calculate_effect({ message = localize("k_upgrade_ex") }, card)
			end
		end

		if context.hand_drawn and pseudorandom("kill") < G.GAME.probabilities.normal / card.ability.extra.odds then
			local destructable_cards = {}
			for i = 1, #G.hand.cards do
				if G.hand.cards[i] ~= card then
					destructable_cards[#destructable_cards + 1] = G.hand.cards[i]
				end
			end
			local card_to_destroy = #destructable_cards > 0
					and pseudorandom_element(destructable_cards, pseudoseed("explode"))
				or nil
			if card_to_destroy then
				card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.bonus_chips / 2
				G.E_MANAGER:add_event(Event({
					func = function()
						(context.blueprint_card or card):juice_up(0.8, 0.8)
						SMODS.calculate_effect({ message = "Destroyed!" }, card)
						card_to_destroy:start_dissolve()
						return true
					end,
				}))
			end
		end
	end,
})
