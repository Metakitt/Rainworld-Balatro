SMODS.Sticker({
	key = "wsingularity",
	loc_txt = {
		label = "Singularity Bomb",
	},
	badge_colour = HEX("875796"),
	atlas = "enhancedcards_scug",
	pos = { x = 2, y = 1 },
	default_compat = true,
	compat_exceptions = {},
	sets = {
		Joker = true,
		Tarot = false,
		Spectral = false,
		foods = false,
	},
	rate = 0.002,
	needs_enable_flag = false,
	calculate = function(self, card, context)
		if context.joker_main and G.GAME.current_round.hands_played == 0 then
			if #context.full_hand == 1 then
				for k, v in ipairs(G.hand.cards) do
					SMODS.calculate_context({ remove_playing_cards = true, removed = { v } })
					v:start_dissolve()
				end
				SMODS.Stickers.rw_wsingularity:apply(card)
				G.GAME.chips = G.GAME.blind.chips
				G.STATE_COMPLETE = true
			end
		end
	end,
})

SMODS.Consumable({
	key = "singularity",
	loc_txt = {
		name = "Singularity Bomb",
		text = { "Gives a Singularity Bomb", "to 1 Joker." },
	},
	set = "obtainweapon",
	atlas = "weaponfoods",
	pos = { x = 7, y = 2 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { extra = { upgrade = 15 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "rw_wsingularity" }
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
		for i, v in ipairs(G.jokers.highlighted) do
			for i = 1, #G.jokers.highlighted do
				SMODS.Stickers["rw_wsingularity"]:apply(v, true)
			end
		end
	end,
})
