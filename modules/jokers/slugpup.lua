SMODS.Joker({
	key = "slugpup",
	atlas = "slugpups",
	rarity = 1,
	cost = 4,
	pos = { x = 0, y = 0 },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { mult = 4, chips = 10 }, slugcat = true },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.chips }}
	end,
	add_to_deck = function(self, card, from_debuff)
		local spupx = math.random(0, 9)
		local spupy = math.random(0, 6)
		card.children.center:set_sprite_pos({ x = spupx, y = spupy })
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
