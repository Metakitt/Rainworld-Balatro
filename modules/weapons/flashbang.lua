SMODS.Sticker({
	key = "wflashbang",
	loc_txt = {
		label = "Flashbang",
	},
	badge_colour = HEX("875796"),
	atlas = "enhancedcards_scug",
	pos = { x = 4, y = 2 },
	default_compat = "true",
	compat_exceptions = {},
	sets = {
		Joker = true,
		Tarot = false,
		Spectral = false,
		foods = false,
	},
	rate = 0.03,
	needs_enable_flag = false,
	calculate = function(self, card, context)
		if context.skip_blind then
			G.from_boss_tag = true
			G.FUNCS.reroll_boss()
			SMODS.Stickers.rw_wflashbang:apply(card)
		end
	end,
})

SMODS.Consumable({
	key = "flashbang",
	loc_txt = {
		name = "Flashbang",
		text = { "Gives a Flashbang", "to 1 Joker." },
	},
	set = "obtainweapon",
	atlas = "weaponfoods",
	pos = { x = 8, y = 2 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { extra = { upgrade = 15 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "rw_wflashbang" }
	end,
	can_use = function(self, card)
		return #G.jokers.highlighted == 1
	end,
	use = function(self, card, area, copier)
		for i, v in ipairs(G.jokers.highlighted) do
			for i = 1, #G.jokers.highlighted do
				SMODS.Stickers["rw_wflashbang"]:apply(v, true)
			end
		end
	end,
})
