--This is a secret joker, it currently doesn't do anything (its effect is just a copy of inv's right now.--
SMODS.Joker({
	key = "plooploo",
	atlas = "plooer",
	pos = { x = 1, y = 0 },
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
			--rw_plooploo_dt_anim = 0
		end
	end,
})

--plooploo_Anim_Patch (Derived from 4D Joker / Jimball)
local upd = Game.update

rw_plooploo_dt_anim = 0

function Game:update(dt)
	upd(self, dt)

	-- if [ploo] highlighted do:

	--for i,v in ipairs(G.jokers.highlighted) do
	--for i = 1, #G.jokers.highlighted do
	--local highlighted = G.jokers.highlighted[i]
	--if G.jokers.highlighted[i].ability.key == 'rw_plooploo' then
	--print('b')
	--end
	--end
	--end [Move to update function and see if it still works]

	rw_plooploo_dt_anim = rw_plooploo_dt_anim + dt

	if G.P_CENTERS and G.P_CENTERS.j_rw_plooploo and rw_plooploo_dt_anim > 0.05 then
		rw_plooploo_dt_anim = 0

		local obj = G.P_CENTERS.j_rw_plooploo

		if obj.pos.x == 6 and obj.pos.y == 3 then
			obj.pos.x = 1
			obj.pos.y = 0
		elseif obj.pos.x < 9 then
			obj.pos.x = obj.pos.x + 1
		elseif obj.pos.y < 4 then
			obj.pos.x = 0
			obj.pos.y = obj.pos.y + 1
		end
	end
end
--
