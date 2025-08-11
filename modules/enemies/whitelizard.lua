SMODS.Joker({
	key = "whitelizard",
	atlas = "enemies",
	rarity = "rw_enemy",
	cost = 4,
	pos = { x = 2, y = 1 },
	unlocked = true,
	discovered = true,
	in_pool = function(self, args)
		return false
	end,
	config = { extra = { defeat = false, xmult = 0.9 }, enemy = true },
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
		info_queue[#info_queue+1] = G.P_CENTERS.m_wild
		return { vars = { card.ability.extra.xmult } }
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.Stickers["eternal"]:apply(card, true)
	end,
	calculate = function(self, card, context)
		--Threat
		if context.joker_main and not context.blueprint then
			return {
				x_mult = card.ability.extra.xmult,
			}
		end

		--Defeat

		if context.individual and context.cardarea == G.play and not context.blueprint then
			if SMODS.has_enhancement(context.other_card, "m_wild") then
				card.ability.extra.defeat = true
			end
		end

		if context.after and card.ability.extra.defeat == true and not context.blueprint then
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
		--Undefeated

		if
			context.main_eval
			and context.end_of_round
			and G.GAME.blind.boss
			and card.ability.extra.defeat == false
			and not context.blueprint
		then
			local _handname, _played, _order = "High Card", -1, 100
			for k, v in pairs(G.GAME.hands) do
				if v.played > _played or (v.played == _played and v.order > _order) then
					_handname = k
					_played = v.played
					_order = v.order
				end
			end
			local unlevel = SCUG.big(1) - G.GAME.hands[_handname].level
			if unlevel < SCUG.big(0) then
				-- print(G.GAME.hands[_handname].level .. unlevel .. " -> 1")
				SMODS.smart_level_up_hand(card, _handname, false, SCUG.num(unlevel))
			end
		end
	end,
})
