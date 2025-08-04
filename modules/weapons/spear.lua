SMODS.Sticker({
	key = "wspear",
	loc_txt = {
		label = "Spear",
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
					card.config.center_key == "j_rw_monk"
					or card.config.center_key == "j_rw_inv"
					or card.config.center_key == "j_rw_saint"
				then
					return {
						x_mult = 1.25,
					}
				elseif
					card.config.center_key == "j_rw_hunter"
					or card.config.center_key == "j_rw_artificer"
					or card.config.center_key == "j_rw_spearmaster"
				then
					return {
						x_mult = 1.75,
					}
				elseif card.config.center_key == "j_rw_gourmand" and gourmandexhausted == 4 then
					return {
						x_mult = 0.9,
					}
				elseif card.config.center_key == "j_rw_gourmand" and gourmandexhausted < 4 then
					return {
						x_mult = 3,
					}
				else
					return {
						x_mult = 1.5,
					}
				end
			end
			if lodging <= 2 and card.config.center_key ~= "j_rw_artificer" then
				SMODS.Stickers.rw_wspear:apply(card)
			end
		end
	end,
})

SMODS.Sticker({
	key = "hunter_wspear",
	loc_txt = {
		label = "2nd Spear",
	},
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
				x_mult = 1.75,
			}
		end
	end,
})

SMODS.Consumable({
	key = "spear",
	loc_txt = {
		name = "Spear",
		text = { "Gives a Spear", "to 1 Joker." },
	},
	set = "obtainweapon",
	atlas = "weaponfoods",
	pos = { x = 3, y = 2 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { extra = { upgrade = 15 }, test = true },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "rw_wspear" }
	end,
	can_use = function(self, card)
		if G.jokers.highlighted[1].ability.enemy == true then 
		return false
		end
	if not G.jokers.highlighted[1].ability.enemy then
		return true
		end
	end,
	use = function(self, card, area, copier)
		-- This gives Hunter or Spearmaster a second spear.
		for i, v in ipairs(G.jokers.highlighted) do
			for i = 1, #G.jokers.highlighted do
				local highlighted = G.jokers.highlighted[i]
				if not G.jokers.highlighted[i].ability.rw_wspear then
					SMODS.Stickers["rw_wspear"]:apply(highlighted, true)
				elseif
					highlighted.ability.rw_wspear
					and (
						highlighted.config.center.key == "j_rw_hunter"
						or highlighted.config.center.key == "j_rw_spearmaster"
					)
				then
					SMODS.Stickers["rw_hunter_wspear"]:apply(highlighted, true)
				end
			end
		end
	end,
})
