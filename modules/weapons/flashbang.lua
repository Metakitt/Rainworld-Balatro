local common_keys = {
	"j_rw_mirosbird"
}
SMODS.Sticker({
	key = "wflashbang",
	loc_txt = {
		label = "Flashbang",
	},
	badge_colour = HEX("875796"),
	atlas = "enhancedcards_scug",
	pos = { x = 4, y = 2 },
	default_compat = true,
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
		for _, center in ipairs(common_keys) do
        if (#SMODS.find_card('j_rw_mirosbird',true) or #SMODS.find_card('j_rw_mirosvulture',true)) then
		for _, v in pairs(SMODS.find_card(center, true)) do
		v.ability.extra.flashbang = v.ability.extra.flashbang + 1
		G.from_boss_tag = true
		G.FUNCS.reroll_boss()
		SMODS.Stickers.rw_wflashbang:apply(card)
		end
		else
		G.from_boss_tag = true
		G.FUNCS.reroll_boss()
		SMODS.Stickers.rw_wflashbang:apply(card)
		end
		end
		end
	    
		end,
})

SMODS.Consumable({
	key = "flashbang",
	set = "obtainweapon",
	atlas = "weaponfoods",
	pos = { x = 8, y = 2 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { weapon = "rw_wflashbang" },
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
