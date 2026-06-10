SMODS.Joker({
	key = "spearmaster",
	atlas = "slugcats",
	pos = { x = 5, y = 0 },
	rarity = 3,
	cost = 8,
	config = { extra = { xmult = 3, should_score = true, rounds_to_ascend = 5 }, slugcat = true, second_spear = true, spear_strength = "strong" },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	attributes = { "slugcat", "xmult", "enhancements"},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult } }
	end,
	set_sprites = function(self, card, front)
	if card.ability and card.ability.rw_ascended == true then
	G.E_MANAGER:add_event(Event({
	blockable = false,
	func = function()
	card.children.center:set_sprite_pos({ x = 5, y = 1 })
	return true
	end
	}))
	
	
	else
	G.E_MANAGER:add_event(Event({
	blockable = false,
	func = function()
	card.children.center:set_sprite_pos({ x = 5, y = 0 })
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
	card.children.center:set_sprite_pos({ x = 5, y = 1 })
	card.ability.extra.xmult = 5
	SMODS.Stickers["rw_ascended"]:apply(card, true)
	end
	

	
	--
	
		if context.individual and context.cardarea == G.play then
			-- Don't trigger if there is no enhancement
			if context.other_card.config.center == G.P_CENTERS.c_base then
				card.ability.extra.should_score = false
			end
		elseif context.joker_main then
			if card.ability.extra.should_score == true then
				-- Mult time baybee!!!
				return { xmult = card.ability.extra.xmult }
			end
		elseif context.after and context.cardarea == G.jokers then
			-- Reset trigger flag for next hand
			card.ability.extra.should_score = true
		end
	end,
})
