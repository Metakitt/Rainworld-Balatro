SMODS.Joker({
	key = "monk",
	atlas = "slugcats",
	pos = { x = 0, y = 0 },
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	attributes = { "slugcat", "chance", "ante" },
	config = { extra = { center_table = -1, odds = 10, rounds_to_ascend = 5 }, slugcat = true, spear_strength = "weak" },

	loc_vars = function(self, info_queue, card)
		return { vars = { SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "rw_monk") } }
	end,
	set_sprites = function(self, card, front)
	if card.ability and card.ability.rw_ascended == true then
	G.E_MANAGER:add_event(Event({
	blockable = false,
	func = function()
	card.children.center:set_sprite_pos({ x = 0, y = 1 })
	return true
	end
	}))
	
	
	else
	G.E_MANAGER:add_event(Event({
	blockable = false,
	func = function()
	card.children.center:set_sprite_pos({ x = 0, y = 0 })
	return true
	end
	}))
	end
	end,
	calculate = function(self, card, context)
	
	-- Temporary / Default 'ascension' requirement
	
	if context.setting_blind and card.ability.rw_ascended ~= true then
	card.ability.extra.rounds_to_ascend = card.ability.extra.rounds_to_ascend -1
	end
	
	if card.ability.extra.rounds_to_ascend <= 0 and card.ability.rw_ascended ~= true then
	card.children.center:set_sprite_pos({ x = 0, y = 1 })
	SMODS.Stickers["rw_ascended"]:apply(card, true)
	end
	
	--
	if context.setting_blind and card.ability.rw_ascended == true then
			return { xblindsize = 0.75 }
		end
	
		if
			context.setting_blind
			and SMODS.pseudorandom_probability(card, "rw_monk", 1, card.ability.extra.odds, "rw_monk")
			and not card.ability.rw_ascended == true
		then
			card.ability.extra.center_table = -1
			ease_ante(card.ability.extra.center_table)
			G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
			G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + card.ability.extra.center_table
		end
	end,
})
