SMODS.Sticker({
	key = "wspear_exp",
	config = {
		weapon = true,
		spear = true,
		mult_bonus = {
			normal = 3,
			weak = 2.5,
			strong = 3.5,
			exhausting = 6,
			exhausting_tired = 0.7
		}
	},
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
		-- if
		-- 	card.config.center_key == "j_rw_monk"
		-- 	or card.config.center_key == "j_rw_inv"
		-- 	or card.config.center_key == "j_rw_saint"
		-- then
		-- 	return { key = self.key .. "_monk_inv" }
		-- end

		-- if
		-- 	card.config.center_key == "j_rw_hunter"
		-- 	or card.config.center_key == "j_rw_artificer"
		-- 	or card.config.center_key == "j_rw_spearmaster"
		-- then
		-- 	return { key = self.key .. "_hunter_artificer_spearmaster" }
		-- end

		-- if card.config.center_key == "j_rw_gourmand" then
		-- 	return { key = self.key .. "_gourmand" }
		-- end
		local strength = (card and card.ability and card.ability.spear_strength) or "normal"
		local dnum, ddenom = SMODS.get_probability_vars(card, 1, 6, "rw_spear_destroy")
		local ret_vars = { self.config.mult_bonus[strength], dnum, ddenom }
		if strength == "exhausting" then
			local num, denom = SMODS.get_probability_vars(card, 1, 4, "rw_spear_exhaust")
			ret_vars = SMODS.merge_lists { ret_vars, { num, denom, self.config.mult_bonus.exhausting_tired } }
		end
		return {
			key = self.key .. (strength == "exhausting" and "_exhausting" or ""),
			vars = ret_vars
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local should_lodge = SMODS.pseudorandom_probability(card, "rw_spear", 1, 50, "rw_spear_lodge")
			local gourmand_exhausted = SMODS.pseudorandom_probability(card, "rw_spear", 1, 4, "rw_spear_exhaust")
			local mult_effect = not should_lodge or card.ability.no_lodge
			local destroy_a_card = SMODS.pseudorandom_probability(card, "rw_spear", 1, 6, "rw_spear_destroy")

			if mult_effect then
				-- local return_table = { x_mult = 3 }

				if destroy_a_card and #G.hand.cards > 0 then
					local destroy_him = pseudorandom_element(G.hand.cards, pseudoseed("rw_wspear_exp"));
					(context.blueprint_card or card):juice_up(0.8, 0.8)
					SMODS.calculate_effect({ message = "Destroyed!" }, context.blueprint_card or card)
					SMODS.destroy_cards(destroy_him)
				end

				-- if
				-- 	card.config.center_key == "j_rw_monk"
				-- 	or card.config.center_key == "j_rw_inv"
				-- 	or card.config.center_key == "j_rw_saint"
				-- then
				-- 	return_table.x_mult = 2.5
				-- elseif
				-- 	card.config.center_key == "j_rw_hunter"
				-- 	or card.config.center_key == "j_rw_artificer"
				-- 	or card.config.center_key == "j_rw_spearmaster"
				-- then
				-- 	return_table.x_mult = 3.5
				-- elseif card.config.center_key == "j_rw_gourmand" then
				-- 	return_table.x_mult = gourmand_exhausted and 0.7 or 6
				-- end

				-- return return_table
				local strength = card.ability.spear_strength or "normal"
				if strength == "exhausting" and gourmand_exhausted then
					strength = "exhausting_tired"
				end
				return { x_mult = self.config.mult_bonus[strength] }
			else
				SMODS.Stickers.rw_wspear_exp:apply(card, nil)
				-- card_eval_status_text(card, "extra", nil, nil, nil, {
				-- 	message = localize("k_spear_lodged_elip"),
				-- 	colour = G.C.WEAPON,
				-- })
				SMODS.calculate_effect({
					message = localize("k_spear_lodged_elip"),
					colour = G.C.WEAPON
				}, card)
			end
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
		info_queue[#info_queue + 1] = { set = "Other", key = card.ability.weapon, vars = SMODS.Stickers[card.ability.weapon]:loc_vars({}, {}).vars }
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
