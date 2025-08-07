SMODS.Sticker({
	key = "wspear_fire",
	loc_txt = {
		label = "Fire Spear",
	},
	badge_colour = HEX("875796"),
	atlas = "enhancedcards_scug",
	pos = { x = 1, y = 2 },
	default_compat = true,
	compat_exceptions = {},
	sets = {
		Joker = true,
		Tarot = false,
		Spectral = false,
		foods = false,
	},
	rate = 0.002,
	needs_enable_flag = false,
	loc_vars = function(self, info_queue, card)
		if card.config.center_key == "j_rw_monk" or card.config.center_key == "j_rw_inv" then
			return { key = self.key .. "_monk_inv" }
		end

		if card.config.center_key == "j_rw_hunter" or card.config.center_key == "j_rw_artificer" then
			return { key = self.key .. "_hunter_artificer_spearmaster" }
		end

		if card.config.center_key == "j_rw_gourmand" then
			return { key = self.key .. "_gourmand" }
		end

		if card.config.center_key == "j_rw_saint" then
			return { key = self.key .. "_saint" }
		end
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local should_lodge = SCUG.number_in_range(1, 100) <= 2 -- 2% chance
			local gourmand_exhausted = SCUG.number_in_range(1, 4) == 4 -- 25% chance
			local mult_effect = not should_lodge or card.ability.no_lodge

			if mult_effect then
				local return_table = { x_mult = 4.5 }

				if card.config.center_key == "j_rw_monk" or card.config.center_key == "j_rw_inv" then
					return_table.x_mult = 3.75
				elseif
					card.config.center_key == "j_rw_hunter"
					or card.config.center_key == "j_rw_artificer"
					or card.config.center_key == "j_rw_spearmaster"
				then
					return_table.x_mult = 5.25
				elseif card.config.center_key == "j_rw_gourmand" then
					return_table.x_mult = gourmand_exhausted and 0.5 or 9
				elseif card.config.center_key == "j_rw_saint" then
					return_table.x_mult = 10
				end

				return return_table
			else
				SMODS.Stickers.rw_wspear_fire:apply(card, nil)
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = localize("k_spear_lodged_elip"),
					colour = G.C.WEAPON,
				})
			end

			-- local lodging = math.random(1, 100)
			-- local gourmandexhausted = math.random(1, 4)

			-- if lodging >= 3 or card.config.center_key == "j_rw_artificer" then
			-- 	if card.config.center_key == "j_rw_monk" or card.config.center_key == "j_rw_inv" then
			-- 		return {
			-- 			x_mult = 3.75,
			-- 		}
			-- 	elseif
			-- 		card.config.center_key == "j_rw_hunter"
			-- 		or card.config.center_key == "j_rw_artificer"
			-- 		or card.config.center_key == "j_rw_spearmaster"
			-- 	then
			-- 		return {
			-- 			x_mult = 5.25,
			-- 		}
			-- 	elseif card.config.center_key == "j_rw_gourmand" and gourmandexhausted == 4 then
			-- 		return {
			-- 			x_mult = 0.5,
			-- 		}
			-- 	elseif card.config.center_key == "j_rw_gourmand" and gourmandexhausted < 4 then
			-- 		return {
			-- 			x_mult = 9,
			-- 		}
			-- 	elseif card.config.center_key == "j_rw_saint" then
			-- 		return {
			-- 			x_mult = 10,
			-- 		}
			-- 	else
			-- 		return {
			-- 			x_mult = 4.5,
			-- 		}
			-- 	end
			-- 	G.GAME.blind.chips = G.GAME.blind.chips * 1.05
			-- 	G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			-- end
			-- if lodging <= 2 and card.config.center_key ~= "j_rw_artificer" then
			-- 	SMODS.Stickers.rw_wspear:apply(card)
			-- end
		end
		if context.setting_blind then
			G.GAME.blind.chips = G.GAME.blind.chips * 1.05
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		end
	end,
})

SMODS.Consumable({
	key = "firespear",
	set = "obtainweapon",
	atlas = "weaponfoods",
	pos = { x = 6, y = 2 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { weapon = "rw_wspear_fire" },
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
