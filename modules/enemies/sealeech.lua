--[[Threat: -1 Mult and -1 Chip for each Sea Leech. 20% chance to spawn a new leech.
Defeat: Play a hand with an Electric Spear.
Not Defeated: Spawns another Sea Leech.]]

SMODS.Joker({
	key = "sealeech",
	atlas = "enemies",
	rarity = "rw_enemy",
	cost = 4,
	pos = { x = 7, y = 1 },
	unlocked = true,
	discovered = true,
	in_pool = function(self, args)
		return false
	end,
	config = { extra = { defeat = false, unchult = -1, leechodds = 5 }, enemy = true, sealeech = true },
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
		info_queue[#info_queue+1] = {key = "rw_wspear_ele", set = "Other"}
		return { vars = { card.ability.extra.unchult, card.ability.extra.leechodds } }
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.Stickers["eternal"]:apply(card, true)
	end,
	calculate = function(self, card, context)
		--Threat
		if context.joker_main and not context.blueprint then
			local leech = #SMODS.find_card("j_rw_sealeech")
			-- for k, v in ipairs(G.jokers.cards) do
			-- 	if v.ability.sealeech == true then
			-- 		leech = leech - 1
			-- 	end
			-- end
			return {
				chips = card.ability.extra.unchult * leech,
				mult = card.ability.extra.unchult * leech,
			}
		end

		if context.after and pseudorandom("moreleech") < 1 / card.ability.extra.leechodds and not context.blueprint and not card.ability.extra.defeat then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 1.3,
				func = function()
					SMODS.add_card({ set = "Joker", area = G.jokers, key = "j_rw_sealeech", no_edition = true })
					return true
				end,
				blocking = false,
			}))
		end

		--Defeat
		if context.main_eval and not context.blueprint then
			-- for i = 1, #G.jokers.cards do
			-- 	if G.jokers.cards[i].ability.rw_wspear_ele and not context.blueprint then
			
			-- 		card.ability.extra.defeat = true
			-- 	end
			-- end
			if SCUG.weapon_count("rw_wspear_ele") > 0 then card.ability.extra.defeat = true end
		end
		if context.after and card.ability.extra.defeat == true then
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
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 1.3,
				func = function()
					SMODS.add_card({ set = "Joker", area = G.jokers, key = "j_rw_sealeech", no_edition = true })
					return true
				end,
				blocking = false,
			}))
		end
	end,
})
