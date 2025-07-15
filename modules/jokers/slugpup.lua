SMODS.Joker({
	key = "slugpup",
	atlas = "slugpups",
	rarity = 1,
	cost = 4,
	pos = { x = 0, y = 0 },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { mult = 4, chips = 10, spupx = 0, spupy = 0, generated = false}, slugcat = true },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.chips }}
	end,
	add_to_deck = function(self, card, from_debuff)
		card.ability.extra.spupx = math.random(0, 9)
		card.ability.extra.spupy = math.random(0, 6)
		card.ability.extra.generated = true
		card.children.center:set_sprite_pos({ x = card.ability.extra.spupx, y = card.ability.extra.spupy })
	end,
	calculate = function(self, card, context)
	
		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
				chips = card.ability.extra.chips,
			}
		end
	end,
})
