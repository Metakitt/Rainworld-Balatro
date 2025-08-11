--[[Threat: Removes food cards and food packs from shop. Cards that use food items are set back to default value.
Defeat Condition: Score a lucky card.
If not defeated: Leaves and food cards no longer appear in the shop.]]
SMODS.Joker({
	key = "caramellizard",
	atlas = "enemies",
	rarity = "rw_enemy",
	cost = 4,
	pos = { x = 3, y = 2 },
	unlocked = true,
	discovered = true,
	in_pool = function(self, args)
		return false
	end,
	config = { extra = { defeat = false }, enemy = true },
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
		return { vars = {} }
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.Stickers["eternal"]:apply(card, true)
		G.GAME.foods_rate = 0
		G.P_CENTERS.p_rw_selectfoodpack.weight = 0
		G.P_CENTERS.p_rw_regularfoodpack.weight = 0
	end,
	update = function(self, card, front)
		if card.ability.extra.defeat == false and G.GAME and G.jokers then
			for i, v in pairs(G.jokers.cards) do
				if v.config.center.key == "j_rw_abundance" then
					local abundont = v
					SMODS.debuff_card(abundont, true, "caramel")
				end
				if v.config.center.key == ("j_rw_greedyscug" or "j_rw_greedyscugbig" or "j_rw_greedyscugsmall") then
					v.ability.extra.xmult_mod = 1
					v.ability.extra.xmult_gain_food = 0.25
					v.ability.extra.food_used_total = 0
				end
				if v.config.center.key == "j_rw_gourmand" then
					v.ability.extra.xmult_mod = 1
					v.ability.extra.xmult_gain_common = 0.25
					v.ability.extra.xmult_gain_uncommon = 0.5
					v.ability.extra.xmult_gain_food = 0.1
				end
				if v.config.center.key == "j_rw_magician" then
					v.ability.extra.x_chips = 1
					v.ability.extra.chips = 0
					v.ability.extra.x_mult = 1
					v.ability.extra.mult = 0
				end
			end
		end
	end,
	calculate = function(self, card, context)
		--Threat
		-- Sets spawning of food to 0 when added to deck.

		--Defeat
		if context.before and not context.blueprint then
			for _, v in pairs(context.scoring_hand) do
				if v.config.center_key == "m_lucky" then
					G.GAME.foods_rate = 3.5
					G.P_CENTERS.p_rw_selectfoodpack.weight = 0.9
					G.P_CENTERS.p_rw_regularfoodpack.weight = 1.2
					card.ability.extra.defeat = true
				end
			end
		end
		if card.ability.extra.defeat == true and not context.blueprint then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 1.3,
				func = function()
					SMODS.destroy_cards(card, true)
					for i, v in pairs(G.jokers.cards) do
						if v.config.center.key == "j_rw_abundance" then
							local abundont = v
							SMODS.debuff_card(abundont, false, "caramel")
						end
					end
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
			-- Maybe make it so that jokers that benefit from food can no longer spawn or destroyed or smth
			SMODS.destroy_cards(card, true)
		end
	end,
})
