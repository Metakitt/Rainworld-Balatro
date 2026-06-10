SMODS.Joker({
	key = "survivor",
	atlas = "slugcats",
	pos = { x = 3, y = 0 },
	rarity = 3,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	attributes = { "slugcat", "chance", "hand_size", "boss_blind" },
	config = { extra = { h_size = 0, h_mod = 1, odds = 2, rounds_to_ascend = 5 }, slugcat = true},

	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "rw_survivor")
		return {
			vars = {
				numerator, denominator,
				card.ability.extra.h_mod,
				card.ability.extra.h_size,
			},
		}
	end,
	set_sprites = function(self, card, front)
	if card.ability and card.ability.rw_ascended == true then
	G.E_MANAGER:add_event(Event({
	blockable = false,
	func = function()
	card.children.center:set_sprite_pos({ x = 3, y = 1 })
	return true
	end
	}))
	
	
	else
	G.E_MANAGER:add_event(Event({
	blockable = false,
	func = function()
	card.children.center:set_sprite_pos({ x = 3, y = 0 })
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
	card.children.center:set_sprite_pos({ x = 3, y = 1 })
	SMODS.Stickers["rw_ascended"]:apply(card, true)
	end
	
	if card.ability.rw_ascended == true and context.end_of_round and context.main_eval and SMODS.pseudorandom_probability(card, "rw_survivor", 1, card.ability.extra.odds, "rw_survivor") then
	G.hand:change_size(-card.ability.extra.h_size)
			card.ability.extra.h_size = card.ability.extra.h_size + card.ability.extra.h_mod
			G.hand:change_size(card.ability.extra.h_size)
			return {
				message = localize("k_upgrade_ex"),
				colour = G.C.MULT,
			}
	end
	
	--
	
		if
			G.GAME.last_blind.boss
			and context.end_of_round
			and context.main_eval
			and SMODS.pseudorandom_probability(card, "rw_survivor", 1, card.ability.extra.odds, "rw_survivor")
			and not card.ability.rw_ascended == true
		then
			G.hand:change_size(-card.ability.extra.h_size)
			card.ability.extra.h_size = card.ability.extra.h_size + card.ability.extra.h_mod
			G.hand:change_size(card.ability.extra.h_size)
			return {
				message = localize("k_upgrade_ex"),
				colour = G.C.MULT,
			}
		end
	end,
})
