SMODS.Joker({
	key = "inv",
	atlas = "slugcats",
	pos = { x = 0, y = 1 },
	rarity = 3,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { odds = 6, blink = false } },

	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds }, slugcat = true }
	end,

	calculate = function(self, card, context)
		if
			context.end_of_round
			and context.main_eval
			and pseudorandom("survive") < G.GAME.probabilities.normal / card.ability.extra.odds
		then
			SMODS.add_card({ set = "Joker", area = G.jokers, edition = "e_negative", key = "j_rw_slugpup" })
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
