SMODS.Sticker({
	key = "wrock",
	config = {
		weapon = true,
		x_chips = 2
	},
	loc_txt = {
		label = "Rock",
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { self.config.x_chips }
		}
	end,
	badge_colour = HEX("875796"),
	atlas = "enhancedcards_scug",
	pos = { x = 1, y = 1 },
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
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				x_chips = self.config.x_chips,
			}
		end
	end,
})

SMODS.Consumable({
	key = "rock",
	set = "obtainweapon",
	atlas = "weaponfoods",
	pos = { x = 0, y = 2 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { weapon = "rw_wrock" },
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
