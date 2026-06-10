SMODS.Joker({
	key = "hunter",
	atlas = "slugcats",
	pos = { x = 2, y = 0 },
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = true,
	config = {
		extra = { center_table = 1, odds = 10, mult = 0, mult_gain = 8, spear = false, spear_strength = "strong", rounds_to_ascend = 5 },
		slugcat = true,
		second_spear = true,
	},
	blueprint_compat = true,
	perishable_compat = false,
	attributes = { "slugcat", "mult", "chance", "ante" },
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "rw_hunter")
		return {
			vars = {
				numerator, denominator,
				card.ability.extra.mult,
				card.ability.extra.mult_gain,
			},
		}
	end,
	set_sprites = function(self, card, front)
	if card.ability and card.ability.rw_ascended == true then
	G.E_MANAGER:add_event(Event({
	blockable = false,
	func = function()
	card.children.center:set_sprite_pos({ x = 2, y = 1 })
	return true
	end
	}))
	
	
	else
	G.E_MANAGER:add_event(Event({
	blockable = false,
	func = function()
	card.children.center:set_sprite_pos({ x = 2, y = 0 })
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
	card.children.center:set_sprite_pos({ x = 2, y = 1 })
	SMODS.Stickers["rw_ascended"]:apply(card, true)
	end
	
	
	--
		if context.setting_blind and card.ability.rw_ascended == true then
			return { xblindsize = 1.25 }
		end
		
		if context.end_of_round and context.main_eval and card.ability.rw_ascended == true then
		local scored_chips = SMODS.calculate_round_score()
		card.ability.extra.mult =  card.ability.extra.mult + (scored_chips * 0.00001)
		end
	
		if context.after and not card.ability.rw_ascended == true and not context.blueprint then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "mult",
				scalar_value = "mult_gain",
				message_colour = G.C.MULT
			})
		end

		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
			}
		end

		if
			context.setting_blind
			and SMODS.pseudorandom_probability(card, "rw_hunter", 1, card.ability.extra.odds, "rw_hunter")
			and G.GAME.round_resets.blind_ante < 8
			and not card.ability.rw_ascended == true
			and not context.blueprint
		then
			card.ability.extra.center_table = 1
			ease_ante(card.ability.extra.center_table)
			G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
			G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + card.ability.extra.center_table
		end
	end,
})
