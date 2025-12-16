SMODS.Joker({
	key = "eggv",
	atlas = "slugcats",
	pos = { x = 0, y = 7 },
	rarity = 3,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { pupodds = 3, money = 3, blink = false, growth = 3 } },

	loc_vars = function(self, info_queue, card)
	info_queue[#info_queue + 1] = { set = "Other", key = "slugpup_grows_up", vars = { card.ability.extra.growth } }
		return { vars = { SMODS.get_probability_vars(card, 1, card.ability.extra.pupodds, "rw_inv") }, slugcat = true }
	end,

	calculate = function(self, card, context)
		if
			context.end_of_round
			and context.main_eval
			and SMODS.pseudorandom_probability(card, "rw_inv", 1, card.ability.extra.pupodds, "rw_inv")
		then
			card.ability.extra_value = card.ability.extra_value + card.ability.extra.money
                    card:set_cost()
                    return {
                        message = localize('k_val_up'),
                        colour = G.C.MONEY
                    }
		end
	end,
})

--Inv_Anim_Patch (Derived from 4D Joker / Jimball)
local upd = Game.update

rw_inv_dt_anim = 0

function Game:update(dt)
	upd(self, dt)

	rw_inv_dt_anim = rw_inv_dt_anim + dt

	if G.P_CENTERS and G.P_CENTERS.j_rw_inv and rw_inv_dt_anim > 0.05 then
		rw_inv_dt_anim = 0

		local obj = G.P_CENTERS.j_rw_inv

		if obj.pos.x == 8 then
			obj.pos.x = 0
			obj.pos.y = 1
		elseif obj.pos.x < 8 then
			obj.pos.x = obj.pos.x + 1
		end
	end
end
--
