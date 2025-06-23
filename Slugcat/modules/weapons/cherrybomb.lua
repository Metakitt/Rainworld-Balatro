--Cherrybomb's effect is temporary; i wanted it to have four fingers effect but that's a bit more complicated.
SMODS.Sticker({
	key = "wcherrybomb",
	loc_txt = {
		label = "Cherrybomb",
	},
	badge_colour = HEX("875796"),
	atlas = "enhancedcards_scug",
	pos = { x = 1, y = 3 },
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
		if context.joker_main then
			local randomnumber = math.random(6, 12)
			return {
				mult = randomnumber,
			}
		end
	end,
})

SMODS.Consumable({
	key = "cherrybomb",
	loc_txt = {
		name = "Cherrybomb",
		text = { "Gives a Cherrybomb to 1 Joker." },
	},
	set = "obtainweapon",
	atlas = "weaponfoods",
	pos = { x = 2, y = 2 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { extra = { upgrade = 15 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "rw_wcherrybomb" }
	end,
	can_use = function(self, card)
		return #G.jokers.highlighted == 1
	end,
	use = function(self, card, area, copier)
		for i, v in ipairs(G.jokers.highlighted) do
			for i = 1, #G.jokers.highlighted do
				SMODS.Stickers["rw_wcherrybomb"]:apply(v, true)
			end
		end
	end,
})
