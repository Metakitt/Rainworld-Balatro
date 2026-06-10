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
	config = { extra = { chips = 0, bonus_chips = 50, odds = 6, rounds_to_ascend = 5 }, slugcat = true, no_lodge = true, spear_strength = "strong" },

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
	set_sprites = function(self, card, front)
	if card.ability and card.ability.rw_ascended == true then
	G.E_MANAGER:add_event(Event({
	blockable = false,
	func = function()
	card.children.center:set_sprite_pos({ x = 1, y = 1 })
	return true
	end
	}))
	
	
	else
	G.E_MANAGER:add_event(Event({
	blockable = false,
	func = function()
	card.children.center:set_sprite_pos({ x = 1, y = 0 })
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
	card.children.center:set_sprite_pos({ x = 1, y = 1 })
	card.ability.extra.chips = card.ability.extra.chips * 2
	SMODS.Stickers["rw_ascended"]:apply(card, true)
	end

	
	--
	
	
		if context.joker_main then
		if card.ability.rw_ascended ~= nil then
		card.ability.extra.chips = card.ability.extra.chips + 20
		return {
				chips = card.ability.extra.chips,
			}
		else
			return {
				chips = card.ability.extra.chips,
			}
		end
		end

		if context.remove_playing_cards or context.cards_destroyed and not context.blueprint and not card.ability.rw_ascended == true then
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
			and not card.ability.rw_ascended == true
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
