SMODS.Sticker({
	key = "wsporepuff",
	loc_txt = {
		label = "Sporepuff",
	},
	badge_colour = HEX("875796"),
	atlas = "enhancedcards_scug",
	pos = { x = 3, y = 1 },
	default_compat = true,
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
	set = "obtainweapon",
	atlas = "weaponfoods",
	pos = { x = 0, y = 3 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { weapon = "rw_wsporepuff" },
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
