SMODS.Joker({
	key = "slugpup",
	atlas = "slugpups",
	rarity = 1,
	cost = 4,
	pos = { x = 0, y = 0 },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	attributes = { "slugcat", "slugpup", "mult", "chips" },
	config = { extra = { mult = 4, chips = 10, spupx = 0, spupy = 0, generated = false, growth = 3 }, slugcat = true },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.chips } }
	end,
	add_to_deck = function(self, card, from_debuff)
		card.ability.extra.spupx = math.random(0, 9)
		card.ability.extra.spupy = math.random(0, 6)
		card.ability.extra.generated = true
		card.children.center:set_sprite_pos({ x = card.ability.extra.spupx, y = card.ability.extra.spupy })
	end,
	set_sprites = function(self, card, front)
		G.E_MANAGER:add_event(Event({
			blockable = false,
			func = function()
				card.children.center:set_sprite_pos({ x = card.ability.extra.spupx, y = card.ability.extra.spupy })
				return true
			end
		}))
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
				chips = card.ability.extra.chips,
			}
		end

		if context.setting_blind and not context.blueprint and card.ability.extra.growth > 0 then
			card.ability.extra.growth = card.ability.extra.growth - 1
			if card.ability.extra.growth <= 0 then
				card.ability.extra.growth = nil
				card:grow_up({ "j_rw_slugcat" })
			end
		end
	end,
})
