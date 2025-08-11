SMODS.Sticker({
	key = "wspear_exp",
	loc_txt = {
		label = "Explosive Spear",
	},
	badge_colour = HEX("875796"),
	atlas = "enhancedcards_scug",
	pos = { x = 2, y = 2 },
	default_compat = true,
	compat_exceptions = {},
	sets = {
		Joker = true,
		Tarot = false,
		Spectral = false,
		foods = false,
	},
	rate = 0.005,
	needs_enable_flag = false,
	loc_vars = function(self, info_queue, card)
		if
			card.config.center_key == "j_rw_monk"
			or card.config.center_key == "j_rw_inv"
			or card.config.center_key == "j_rw_saint"
		then
			return { key = self.key .. "_monk_inv" }
		end

		if
			card.config.center_key == "j_rw_hunter"
			or card.config.center_key == "j_rw_artificer"
			or card.config.center_key == "j_rw_spearmaster"
		then
			return { key = self.key .. "_hunter_artificer_spearmaster" }
		end

		if card.config.center_key == "j_rw_gourmand" then
			return { key = self.key .. "_gourmand" }
		end
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local should_lodge = SCUG.number_in_range(1, 100) <= 2 -- 2% chance
			local gourmand_exhausted = SCUG.number_in_range(1, 4) == 4 -- 25% chance
			local mult_effect = not should_lodge or card.ability.no_lodge
			local destroy_a_card = SCUG.number_in_range(1, 6) == 4 -- 16.6% chance

			if mult_effect then
				local return_table = { x_mult = 3 }

				if destroy_a_card and #G.hand.cards > 0 then
					local destroy_him = pseudorandom_element(G.hand.cards, pseudoseed("rw_wspear_exp"));
					(context.blueprint_card or card):juice_up(0.8, 0.8)
					SMODS.calculate_effect({ message = "Destroyed!" }, context.blueprint_card or card)
					SMODS.destroy_cards(destroy_him)
				end

				if
					card.config.center_key == "j_rw_monk"
					or card.config.center_key == "j_rw_inv"
					or card.config.center_key == "j_rw_saint"
				then
					return_table.x_mult = 2.5
				elseif
					card.config.center_key == "j_rw_hunter"
					or card.config.center_key == "j_rw_artificer"
					or card.config.center_key == "j_rw_spearmaster"
				then
					return_table.x_mult = 3.5
				elseif card.config.center_key == "j_rw_gourmand" then
					return_table.x_mult = gourmand_exhausted and 0.7 or 6
				end

				return return_table
			else
				SMODS.Stickers.rw_wspear_exp:apply(card, nil)
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = localize("k_spear_lodged_elip"),
					colour = G.C.WEAPON,
				})
			end

			-- local lodging = math.random(1, 100)
			-- local gourmandexhausted = math.random(1, 4)
			-- local destroycard = math.random(1, 6)

			-- if lodging >= 3 or card.config.center_key == "j_rw_artificer" then
			-- 	if destroycard == 4 then
			-- 		if card.config.center_key == "j_rw_artificer" then
			-- 			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.bonus_chips
			-- 		end
			-- 		local destructable_cards = {}
			-- 		for i = 1, #G.hand.cards do
			-- 			if G.hand.cards[i] ~= card then
			-- 				destructable_cards[#destructable_cards + 1] = G.hand.cards[i]
			-- 			end
			-- 		end
			-- 		local card_to_destroy = #destructable_cards > 0
			-- 				and pseudorandom_element(destructable_cards, pseudoseed("explode"))
			-- 			or nil
			-- 		if card_to_destroy then
			-- 			G.E_MANAGER:add_event(Event({
			-- 				func = function()
			-- 					(context.blueprint_card or card):juice_up(0.8, 0.8)
			-- 					SMODS.calculate_effect({ message = "Destroyed!" }, card)
			-- 					card_to_destroy:start_dissolve()
			-- 					SMODS.calculate_context({ remove_playing_cards = true, removed = { card_to_destroy } })
			-- 					return true
			-- 				end,
			-- 			}))
			-- 		end
			-- 	end

			-- 	if
			-- 		card.config.center_key == "j_rw_monk"
			-- 		or card.config.center_key == "j_rw_inv"
			-- 		or card.config.center_key == "j_rw_saint"
			-- 	then
			-- 		return {
			-- 			x_mult = 2.5,
			-- 		}
			-- 	elseif
			-- 		card.config.center_key == "j_rw_hunter"
			-- 		or card.config.center_key == "j_rw_artificer"
			-- 		or card.config.center_key == "j_rw_spearmaster"
			-- 	then
			-- 		return {
			-- 			x_mult = 3.5,
			-- 		}
			-- 	elseif card.config.center_key == "j_rw_gourmand" and gourmandexhausted == 4 then
			-- 		return {
			-- 			x_mult = 0.7,
			-- 		}
			-- 	elseif card.config.center_key == "j_rw_gourmand" and gourmandexhausted < 4 then
			-- 		return {
			-- 			x_mult = 6,
			-- 		}
			-- 	else
			-- 		return {
			-- 			x_mult = 3,
			-- 		}
			-- 	end
			-- end
			-- if lodging <= 2 and card.config.center_key ~= "j_rw_artificer" then
			-- 	SMODS.Stickers.rw_wspear:apply(card)
			-- end
		end
	end,
})

SMODS.Consumable({
	key = "spear_exp",
	set = "obtainweapon",
	atlas = "weaponfoods",
	pos = { x = 4, y = 2 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { weapon = "rw_wspear_exp" },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = card.ability.weapon }
	end,
	can_use = function(self, card)
		return #G.jokers.highlighted == 1
			and not G.jokers.highlighted[1].ability.enemy
			and not G.jokers.highlighted[1].ability[card.ability.weapon]
	end,
	use = function(self, card, area, copier)
		for _, v in ipairs(G.jokers.highlighted) do
			SMODS.Stickers[card.ability.weapon]:apply(v, true)
		end
	end,
})
