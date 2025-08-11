SMODS.Joker({
	key = "greedyscug",
	atlas = "slugcats",
	pos = { x = 0, y = 2 },
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	perishable_compat = false,
	config = { extra = { xmult_mod = 1, xmult_gain_food = 0.25, food_used_total = 0 }, slugcat = true },

	loc_vars = function(self, info_queue, card)
		if card.ability.extra.food_used_total <= 6 then
			return {
				vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult_gain_food },
				key = self.key .. "small",
			}
		end

		if card.ability.extra.food_used_total >= 7 then
			return {
				vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult_gain_food },
				key = self.key .. "big",
			}
		end
	end,

	calculate = function(self, card, context)
		if context.joker_main then
			return {
				xmult = card.ability.extra.xmult_mod,
			}
		end

		if context.using_consumeable and context.consumeable.config.center.set == "foods" and not context.blueprint then
			card.ability.extra.xmult_mod = card.ability.extra.xmult_mod + card.ability.extra.xmult_gain_food
			card.ability.extra.food_used_total = card.ability.extra.food_used_total + 1
			SMODS.calculate_effect({ message = "Upgrade!" }, card)
		end
		
		if card.ability.extra.food_used_total == 0 then
			card.children.center:set_sprite_pos({ x = 0, y = 2 })
		end

		if card.ability.extra.food_used_total == 1 then
			card.children.center:set_sprite_pos({ x = 1, y = 2 })
		end

		if card.ability.extra.food_used_total == 3 then
			card.children.center:set_sprite_pos({ x = 2, y = 2 })
		end

		if card.ability.extra.food_used_total == 5 then
			card.children.center:set_sprite_pos({ x = 3, y = 2 })
		end

		if card.ability.extra.food_used_total == 7 then
			card.children.center:set_sprite_pos({ x = 4, y = 2 })
		end

		if card.ability.extra.food_used_total == 10 then
			card.children.center:set_sprite_pos({ x = 5, y = 2 })
		end

		if card.ability.extra.food_used_total > 12 then
			card.children.center:set_sprite_pos({ x = 6, y = 2 })
		end
	end,
})
