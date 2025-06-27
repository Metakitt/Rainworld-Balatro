SMODS.Sticker({
	key = "wrock",
	loc_txt = {
		label = "Rock",
	},
	badge_colour = HEX("875796"),
	atlas = "enhancedcards_scug",
	pos = { x = 1, y = 1 },
	default_compat = "true",
	compat_exceptions = {},
	sets = {
		Joker = true,
		Tarot = false,
		Spectral = false,
		foods = false,
	},
	rate = 0.06,
	needs_enable_flag = false,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				x_chips = 2,
			}
		end
	end,
})

SMODS.Consumable({
	key = "rock",
	loc_txt = {
		name = "Rock",
		text = { "Gives a Rock", "to 1 Joker." },
	},
	set = "obtainweapon",
	atlas = "weaponfoods",
	pos = { x = 0, y = 2 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { extra = { upgrade = 15 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "rw_wrock" }
	end,
	can_use = function(self, card)
		return #G.jokers.highlighted == 1
	end,
	use = function(self, card, area, copier)
		for i, v in ipairs(G.jokers.highlighted) do
			for i = 1, #G.jokers.highlighted do
				SMODS.Stickers["rw_wrock"]:apply(v, true)
			end
		end
	end,
})
