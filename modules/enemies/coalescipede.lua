SMODS.Joker({
	key = "coalescipede",
	atlas = "enemies",
	rarity = "rw_enemy",
	cost = 4,
	pos = { x = 7, y = 0 },
	unlocked = true,
	discovered = true,
	in_pool = function(self, args)
		return false
	end,
	config = { extra = { defeat = false, odds = 10 }, enemy = true, spider = true },
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
		info_queue[#info_queue + 1] = { key = "rw_wflashbang", set = "Other" }
		local num_pedes = (G.GAME and G.jokers and #SMODS.find_card("j_rw_coalescipede")) or 1
		return { vars = { -num_pedes, card.ability.extra.odds, number_format(-(num_pedes ^ 2)) } }
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.Stickers["eternal"]:apply(card, true)
	end,
	calculate = function(self, card, context)
		--Threat
		if context.joker_main and not context.blueprint then
			-- local pede = 0
			-- for k, v in ipairs(G.jokers.cards) do
			-- 	if v.ability.spider == true then
			-- 		pede = pede - 1
			-- 	end
			-- end
			return {
				chips = -#SMODS.find_card("j_rw_coalescipede"),
			}
		end
		if
			context.after
			and pseudorandom("morepede") < 1 / card.ability.extra.odds
			and not context.blueprint
			and not card.ability.extra.defeat
		then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 1.3,
				func = function()
					SMODS.add_card({ set = "Joker", area = G.jokers, key = "j_rw_coalescipede", no_edition = true })
					return true
				end,
				blocking = false,
			}))
		end

		--Defeat
		if context.main_eval and not context.blueprint then
			-- for i = 1, #G.jokers.cards do
			-- 	if G.jokers.cards[i].ability.rw_wflashbang and not context.blueprint then
			-- 		card.ability.extra.defeat = true
			-- 	end
			-- end
			if SCUG.weapon_count("rw_wflashbang") > 0 then
				card.ability.extra.defeat = true
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
		end

		--Undefeated
		if
			context.main_eval
			and context.end_of_round
			and G.GAME.blind.boss
			and card.ability.extra.defeat == false
			and not context.blueprint
		then
			for i = 1, 2 do
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 1.3 + (i - 1) / 2,
					func = function()
						SMODS.add_card({ set = "Joker", area = G.jokers, key = "j_rw_coalescipede", no_edition = true })
						return true
					end,
					blocking = false,
				}))
			end
		end
	end,
})
