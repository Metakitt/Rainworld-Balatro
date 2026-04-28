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
	attributes = { "slugcat", "chips", "destroy_card", "chance", "scaling" },
	config = { extra = { chips = 0, bonus_chips = 50, odds = 6 }, slugcat = true, no_lodge = true, spear_strength = "strong" },

	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "rw_artificer")
		return {
			vars = {
				card.ability.extra.chips,
				numerator, denominator,
				card.ability.extra.bonus_chips,
				card.ability.extra.bonus_chips / 2,
			},
		}
	end,

	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chips = card.ability.extra.chips,
			}
		end

		if context.remove_playing_cards or context.cards_destroyed and not context.blueprint then
			-- for _ = 1, #context.removed do
			-- 	card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.bonus_chips
			-- 	SMODS.calculate_effect({ message = localize("k_upgrade_ex") }, card)
			-- end
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "chips",
				scalar_value = "bonus_chips",
				operation = function(ref_table, ref_value, initial, change)
					ref_table[ref_value] = initial + (change * #context.removed)
				end,
				message_colour = G.C.BLUE
			})
		end

		if
			context.hand_drawn
			and SMODS.pseudorandom_probability(card, "rw_artificer", 1, card.ability.extra.odds, "rw_artificer")
		then
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
				-- card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.bonus_chips / 2
				-- G.E_MANAGER:add_event(Event({
				-- 	func = function()
				-- 		(context.blueprint_card or card):juice_up(0.8, 0.8)
				-- 		SMODS.calculate_effect({ message = "Destroyed!" }, card)
				-- 		SMODS.destroy_cards(card_to_destroy)
				-- 		return true
				-- 	end,
				-- }))
				-- SMODS.destroy_cards(card_to_destroy)
				G.E_MANAGER:add_event(Event({
					func = function()
						if SMODS.shatters(card_to_destroy) then
							card_to_destroy:shatter()
						else
							card_to_destroy:start_dissolve()
						end
						return true
					end
				}))
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "chips",
					scalar_value = "bonus_chips",
					operation = function(ref_table, ref_value, initial, change)
						ref_table[ref_value] = initial + (change / 2)
					end,
					no_message = true
				})
				SMODS.calculate_effect({
					message = localize("k_destroyed_ex"),
					colour = G.C.CHIPS
				}, card)
			end
		end
	end,
})
