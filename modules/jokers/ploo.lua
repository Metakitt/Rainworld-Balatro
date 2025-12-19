--This is a secret joker, it           does       a  thing (its effect is                      right now.--
SMODS.Joker({
	key = "plooploo",
	atlas = "plooer",
	pos = { x = 1, y = 0 },
	rarity = 3,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { pup_mult = 1.5 }, slugcat = true },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.pup_mult } }
	end,
	in_pool = function(self, args)
		return #SMODS.find_card("j_rw_slugpup", true) > 0
	end,
	calculate = function(self, card, context)
		if
			context.other_joker and context.other_joker.config.center_key == "j_rw_slugpup"
		then
			-- context.other_joker:juice_up(0.5, 0.5) -- Like Baseball Card
			return { x_mult = card.ability.extra.pup_mult }
		end
	end,
	set_card_type_badge = function(self, card, badges)
		badges[#badges + 1] = create_badge("?ploo", G.C.WHITE, G.C.BLACK, 1.2)
	end
})
