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
			local randomnumber = SCUG.number_in_range(6, 12)
			return {
				mult = randomnumber,
			}
		end
	end,
})

SMODS.Consumable({
	key = "cherrybomb",
	set = "obtainweapon",
	atlas = "weaponfoods",
	pos = { x = 2, y = 2 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { weapon = "rw_wcherrybomb" },
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
