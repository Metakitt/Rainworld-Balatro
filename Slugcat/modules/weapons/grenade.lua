SMODS.Sticker({
	key = "wgrenade",
	loc_txt = {
		label = "Grenade",
	},
	badge_colour = HEX("875796"),
	atlas = "enhancedcards_scug",
	pos = { x = 0, y = 1 },
	default_compat = "true",
	compat_exceptions = {},
	sets = {
		Joker = true,
		Tarot = false,
		Spectral = false,
		foods = false,
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { G.GAME.grenademult } }
	end,
	rate = 0.08,
	needs_enable_flag = false,
	calculate = function(self, card, context)
		if context.discard then
			if G.GAME.current_round.discards_used <= 0 and #context.full_hand == 1 then
				SMODS.calculate_effect({ message = localize("k_upgrade_ex") }, card)
				G.GAME.grenademult = G.GAME.grenademult + 3

				return {
					remove = true,
					card = self,
				}
			end
		end

		if context.joker_main then
			return {
				mult = G.GAME.grenademult,
			}
		end
	end,
})

SMODS.Consumable({
	key = "grenade",
	loc_txt = {
		name = "Grenade",
		text = { "Gives a Grenade", "to 1 Joker." },
	},
	set = "obtainweapon",
	atlas = "weaponfoods",
	pos = { x = 9, y = 2 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { extra = { upgrade = 15 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "rw_wgrenade2" }
	end,
	can_use = function(self, card)
		return #G.jokers.highlighted == 1
	end,
	use = function(self, card, area, copier)
		for i, v in ipairs(G.jokers.highlighted) do
			for i = 1, #G.jokers.highlighted do
				SMODS.Stickers["rw_wgrenade"]:apply(v, true)
			end
		end
	end,
})
