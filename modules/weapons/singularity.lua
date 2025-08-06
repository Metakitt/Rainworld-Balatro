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
	set = "obtainweapon",
	atlas = "weaponfoods",
	pos = { x = 7, y = 2 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { weapon = "rw_wsingularity" },
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
