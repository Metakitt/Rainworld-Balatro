SMODS.Joker({
	key = "wormgrass",
	atlas = "enemies",
	rarity = "rw_enemy",
	cost = 4,
	pos = { x = 3, y = 0 },
	unlocked = true,
	discovered = true,
	in_pool = function(self, args)
		return false
	end,
	config = { extra = { defeat = false, threshold = 1000 }, enemy = true },
	blueprint_compat = false,
	perishable_compat = false,
	rw_wbeehive_compat = false,
	rw_wcherrybomb_compat = false,
	rw_wspear_ele_compat = false,
	rw_wspear_exp_compat = false,
	rw_wspear_fire_compat = false,
	rw_wflashbang_compat = false,
	rw_wgrenade_compat = false,
	rw_wjokerifle_compat = false,
	rw_wrock_compat = false,
	rw_wsingularity_compat = false,
	rw_wspear_compat = false,
	rw_wsporepuff_compat = false,
	loc_vars = function(self, info_queue, card)
		return { vars = { number_format(card.ability.extra.threshold) } }
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.Stickers["eternal"]:apply(card, true)
	end,
	calculate = function(self, card, context)
		--Threat
		if context.destroy_card and context.cardarea == G.play and not context.blueprint then
			return { remove = true }
		end

		if context.destroy_card and context.cardarea == "unscored" and not context.blueprint then
			return { remove = true }
		end

		--Defeat
		if G.GAME.chips > SCUG.big(card.ability.extra.threshold) and not context.blueprint then
			card.ability.extra.defeat = true
		end
		if card.ability.extra.defeat == true and not context.blueprint then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 1.3,
				func = function()
					SMODS.destroy_cards(card, true)
					return true
				end,
				blocking = false,
			}))
		end
		-- Undefeated
		-- No effect if left undefeated.
	end,
})
