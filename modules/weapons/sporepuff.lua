SMODS.Sticker({
	key = "wsporepuff",
	loc_txt = {
		label = "Sporepuff",
	},
	badge_colour = HEX("875796"),
	atlas = "enhancedcards_scug",
	pos = { x = 3, y = 1 },
	default_compat = "true",
	compat_exceptions = {},
	sets = {
		Joker = true,
		Tarot = false,
		Spectral = false,
		foods = false,
	},
	rate = 0.08,
	needs_enable_flag = false,
	calculate = function(self, card, context)
		if context.setting_blind then
			G.GAME.blind.chips = G.GAME.blind.chips * 0.95
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		end
	end,
})

SMODS.Consumable({
	key = "sporepuff",
	loc_txt = {
		name = "Sporepuff",
		text = { "Gives a Sporepuff", "to 1 Joker." },
	},
	set = "obtainweapon",
	atlas = "weaponfoods",
	pos = { x = 0, y = 3 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { extra = { upgrade = 15 } },
	can_use = function(self, card)
		return #G.jokers.highlighted == 1
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "rw_wsporepuff" }
	end,
	use = function(self, card, area, copier)
		for i, v in ipairs(G.jokers.highlighted) do
			for i = 1, #G.jokers.highlighted do
				SMODS.Stickers["rw_wsporepuff"]:apply(v, true)
			end
		end
	end,
})
