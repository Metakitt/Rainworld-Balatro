SMODS.Sticker({
	key = "wspear_ele",
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
			local lodging = math.random(1, 100)
			local gourmandexhausted = math.random(1, 4)

			if lodging >= 3 or card.config.center_key == "j_rw_artificer" then
				if
					(
						card.config.center_key == "j_rw_monk"
						or card.config.center_key == "j_rw_inv"
						or card.config.center_key == "j_rw_saint"
					)
					and not next(SMODS.find_card("j_splash"))
					and not next(SMODS.find_card("j_seltzer"))
				then
					return {
						x_mult = 1.25,
					}
				elseif
					(
						card.config.center_key == "j_rw_hunter"
						or card.config.center_key == "j_rw_artificer"
						or card.config.center_key == "j_rw_spearmaster"
					)
					and not next(SMODS.find_card("j_splash"))
					and not next(SMODS.find_card("j_seltzer"))
				then
					return {
						x_mult = 1.75,
					}
				elseif
					card.config.center_key == "j_rw_gourmand"
					and gourmandexhausted == 4
					and not next(SMODS.find_card("j_splash"))
					and not next(SMODS.find_card("j_seltzer"))
				then
					return {
						x_mult = 0.9,
					}
				elseif
					card.config.center_key == "j_rw_gourmand"
					and gourmandexhausted < 4
					and not next(SMODS.find_card("j_splash"))
					and not next(SMODS.find_card("j_seltzer"))
				then
					return {
						x_mult = 3,
					}
				elseif not next(SMODS.find_card("j_splash")) then
					return {
						x_mult = 1.5,
					}
				elseif
					(
						card.config.center_key == "j_rw_monk"
						or card.config.center_key == "j_rw_inv"
						or card.config.center_key == "j_rw_saint"
					) and (next(SMODS.find_card("j_splash")) or next(SMODS.find_card("j_seltzer")))
				then
					return {
						x_mult = 1.25,
						x_chips = 1.25,
					}
				elseif
					(
						card.config.center_key == "j_rw_hunter"
						or card.config.center_key == "j_rw_artificer"
						or card.config.center_key == "j_rw_spearmaster"
					) and (next(SMODS.find_card("j_splash")) or next(SMODS.find_card("j_seltzer")))
				then
					return {
						x_mult = 1.75,
						x_chips = 1.75,
					}
				elseif
					card.config.center_key == "j_rw_gourmand"
					and gourmandexhausted == 4
					and (next(SMODS.find_card("j_splash")) or next(SMODS.find_card("j_seltzer")))
				then
					return {
						x_mult = 0.9,
						x_chips = 0.9,
					}
				elseif
					card.config.center_key == "j_rw_gourmand"
					and gourmandexhausted < 4
					and (next(SMODS.find_card("j_splash")) or next(SMODS.find_card("j_seltzer")))
				then
					return {
						x_mult = 3,
						x_chips = 3,
					}
				elseif next(SMODS.find_card("j_splash")) or next(SMODS.find_card("j_seltzer")) then
					return {
						x_mult = 1.5,
						x_chips = 1.5,
					}
				end
			end
			if lodging <= 2 and card.config.center_key ~= "j_rw_artificer" then
				SMODS.Stickers.rw_wspear_ele:apply(card)
			end
		end
	end,
})

SMODS.Consumable({
	key = "spear_ele",
	loc_txt = {
		name = "Electric Spear",
		text = { "Gives an Electric Spear", "to 1 Joker." },
	},
	set = "obtainweapon",
	atlas = "weaponfoods",
	pos = { x = 5, y = 2 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { extra = { upgrade = 15 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "rw_wspear_ele" }
	end,
	can_use = function(self, card)
		return #G.jokers.highlighted == 1
	end,
	use = function(self, card, area, copier)
		for i, v in ipairs(G.jokers.highlighted) do
			for i = 1, #G.jokers.highlighted do
				SMODS.Stickers["rw_wspear_ele"]:apply(v, true)
			end
		end
	end,
})
