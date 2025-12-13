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
