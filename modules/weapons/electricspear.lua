SMODS.Sticker({
	key = "wspear_ele",
	config = {
		weapon = true,
	},
	loc_txt = {
		label = "Electric Spear",
	},
	badge_colour = HEX("875796"),
	atlas = "enhancedcards_scug",
	pos = { x = 0, y = 2 },
	default_compat = true,
	compat_exceptions = {},
	sets = {
		Joker = true,
		Tarot = false,
		Spectral = false,
		foods = false,
	},
	rate = 0.01,
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
			local should_lodge = SMODS.pseudorandom_probability(card, "rw_spear", 1, 50, "rw_spear_lodge")
			local gourmand_exhausted = SMODS.pseudorandom_probability(card, "rw_spear", 1, 4, "rw_spear_exhaust")
			local mult_effect = not should_lodge or card.ability.no_lodge

			if mult_effect then
				local return_table = { x_mult = 1.5 }

				if
					card.config.center_key == "j_rw_monk"
					or card.config.center_key == "j_rw_inv"
					or card.config.center_key == "j_rw_saint"
				then
					return_table.x_mult = 1.25
				elseif
					card.config.center_key == "j_rw_hunter"
					or card.config.center_key == "j_rw_artificer"
					or card.config.center_key == "j_rw_spearmaster"
				then
					return_table.x_mult = 1.75
				elseif card.config.center_key == "j_rw_gourmand" then
					return_table.x_mult = gourmand_exhausted and 0.9 or 3
				end

				if next(SMODS.find_card("j_splash")) or next(SMODS.find_card("j_seltzer")) then
					return_table.x_chips = return_table.x_mult
				end

				return return_table
			else
				SMODS.Stickers.rw_wspear_ele:apply(card, nil)
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = localize("k_spear_lodged_elip"),
					colour = G.C.WEAPON,
				})
			end
		end
	end,
})

SMODS.Consumable({
	key = "spear_ele",
	set = "obtainweapon",
	atlas = "weaponfoods",
	pos = { x = 5, y = 2 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { weapon = "rw_wspear_ele" },
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
