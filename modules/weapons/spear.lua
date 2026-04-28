SMODS.Sticker({
	key = "wspear",
	config = {
		weapon = true,
		spear = true,
		mult_bonus = {
			normal = 1.5,
			weak = 1.25,
			strong = 1.75,
			exhausting = 3,
			exhausting_tired = 0.9
		}
	},
	badge_colour = HEX("875796"),
	atlas = "enhancedcards_scug",
	pos = { x = 3, y = 2 },
	default_compat = true,
	compat_exceptions = {},
	sets = {
		Joker = true,
		Tarot = false,
		Spectral = false,
		foods = false,
	},
	rate = 0.06,
	needs_enable_flag = false,
	loc_vars = function(self, info_queue, card)
		local strength = (card and card.ability and card.ability.spear_strength) or "normal"
		local ret_vars = { self.config.mult_bonus[strength] }
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

			if mult_effect then
				local strength = card.ability.spear_strength or "normal"
				if strength == "exhausting" and gourmand_exhausted then
					strength = "exhausting_tired"
				end
				return { x_mult = self.config.mult_bonus[strength] }
			else
				if card.ability.rw_hunter_wspear then
					SMODS.Stickers.rw_hunter_wspear:apply(card, nil)
				else
					SMODS.Stickers.rw_wspear:apply(card, nil)
				end

				SMODS.calculate_effect({
					message = localize("k_spear_lodged_elip"),
					colour = G.C.WEAPON
				}, card)
			end
		end
	end,
})

SMODS.Sticker({
	key = "hunter_wspear",
	config = {
		x_mult = 1.75
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.x_mult } }
	end,
	badge_colour = HEX("875796"),
	atlas = "enhancedcards_scug",
	pos = { x = 3, y = 2 },
	default_compat = false,
	compat_exceptions = {},
	sets = {
		Joker = false,
		Tarot = false,
		Spectral = false,
		foods = false,
	},
	needs_enable_flag = false,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				x_mult = self.config.x_mult,
			}
		end
	end,
})

SMODS.Consumable({
	key = "spear",
	set = "obtainweapon",
	atlas = "weaponfoods",
	pos = { x = 3, y = 2 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { weapon = "rw_wspear" },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = card.ability.weapon, vars = SMODS.Stickers[card.ability.weapon]:loc_vars({}, {}).vars }
	end,
	can_use = function(self, card)
		if #G.jokers.highlighted == 1 and not G.jokers.highlighted[1].ability.enemy then
			local j = G.jokers.highlighted[1]
			return not j.ability[card.ability.weapon]
				or (j.ability[card.ability.weapon] and (j.ability.second_spear and not j.ability["rw_hunter_wspear"]))
		end

		return false
	end,
	use = function(self, card, area, copier)
		-- This gives Hunter or Spearmaster a second spear.
		for i = 1, #G.jokers.highlighted do
			local highlighted = G.jokers.highlighted[i]
			if not highlighted.ability.rw_wspear then
				SMODS.Stickers["rw_wspear"]:apply(highlighted, true)
			elseif
				highlighted.ability.rw_wspear
				and not highlighted.ability.rw_hunter_wspear
				and highlighted.ability.second_spear
			then
				SMODS.Stickers["rw_hunter_wspear"]:apply(highlighted, true)
			end
		end
	end,
})
