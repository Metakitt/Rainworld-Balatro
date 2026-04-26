SMODS.Joker({
	key = "pupartificer",
	atlas = "slugcats",
	pos = { x = 2, y = 5 },
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	perishable_compat = false,
	attributes = { "slugcat", "chips", "destroy_card", "chance", "scaling" },
	config = { extra = { chips = 0, pupbonus_chips = 20, pupodds = 10, growth = 3 }, slugcat = true, no_lodge = true },

	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "slugpup_grows_up", vars = { card.ability.extra.growth } }
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.pupodds, "rw_artificer")
		return {
			vars = {
				card.ability.extra.chips,
				numerator, denominator,
				card.ability.extra.pupbonus_chips,
				card.ability.extra.pupbonus_chips / 2,
			},
		}
	end,

	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint and card.ability.extra.growth > 0 then
			card.ability.extra.growth = card.ability.extra.growth - 1
			if card.ability.extra.growth <= 0 then
				card.ability.extra.growth = nil
				card:grow_up()
				return
			end
		end

		if context.joker_main then
			return {
				chips = card.ability.extra.chips,
				-- message = localize({ type = "variable", key = "a_chips", vars = { card.ability.extra.chips } }),
			}
		end

		if context.remove_playing_cards or context.cards_destroyed and not context.blueprint then
			-- for i = 1, #context.removed do
				-- card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.pupbonus_chips
				-- SMODS.calculate_effect({ message = localize("k_upgrade_ex") }, card)
			-- end
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "chips",
				scalar_value = "pupbonus_chips",
				operation = function(ref_table, ref_value, initial, change)
					ref_table[ref_value] = initial + (change * #context.removed)
				end,
				message_colour = G.C.CHIPS
			})
		end

		if
			context.hand_drawn
			and SMODS.pseudorandom_probability(card, "rw_artificer", 1, card.ability.extra.pupodds, "rw_artificer")
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
				-- card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.pupbonus_chips
				-- G.E_MANAGER:add_event(Event({
				-- 	func = function()
				-- 		(context.blueprint_card or card):juice_up(0.8, 0.8)
				-- 		SMODS.calculate_effect({ message = "Destroyed!" }, card)
				-- 		card_to_destroy:start_dissolve()
				-- 		return true
				-- 	end,
				-- }))
				SMODS.destroy_cards(card_to_destroy)
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "chips",
					scalar_value = "pupbonus_chips",
					message_key = "k_destroyed_ex",
					message_colour = G.C.CHIPS
				})
			end
		end
	end,
})
