SMODS.Joker({
	key = "gourmand",
	atlas = "slugcats",
	pos = { x = 4, y = 0 },
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	perishable_compat = false,
	config = {
		extra = {
			xmult_mod = 1,
			xmult_per_rarity = { 0.25, 0.5, 0.75, 1 },
			xmult_gain_food = 0.1,
			munch = false,
		},
		slugcat = true,
		gourmand = true,
	},

	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult_per_rarity[1], card.ability.extra.xmult_per_rarity[2], card.ability.extra.xmult_gain_food },
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		if SMODS.pseudorandom_probability(card, "ohfuck", 1, 666, "rw_gourmand_hunger", true) then
			local hunger = SMODS.add_card({ set = "Joker", area = G.jokers, key = "j_rw_hunger" })
			hunger.ability.extra.x_mult = hunger.ability.extra.x_mult + 1
			-- card:start_dissolve()
			SMODS.destroy_cards(card, true)
		end
	end,

	calculate = function(self, card, context)
		if context.joker_main then
			return {
				xmult = card.ability.extra.xmult_mod,
			}
		end

		if context.card_added and not context.blueprint then
			if SCUG.is_in_pool(context.card, "Food") then
				card.ability.extra.munch = true
				card.ability.extra.xmult_mod = card.ability.extra.xmult_mod +
					card.ability.extra.xmult_per_rarity[context.card.config.center.rarity or 1]
				SMODS.destroy_cards(context.card, true)
			elseif context.card.config.center.set == "foods" then
				card.ability.extra.munch = true
				card.ability.extra.xmult_mod = card.ability.extra.xmult_mod + card.ability.extra.xmult_gain_food
				SMODS.destroy_cards(context.card, true)
			end
		end

		if card.ability.extra.munch == true then
			SMODS.calculate_effect({ message = "Crunch", sound = "rw_crunch" }, card)
			delay(0.2)
			card.ability.extra.munch = false
		end
	end,
})

local use_and_sell_buttonsref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
	local retval = use_and_sell_buttonsref(card)

	if card.area and card.area.config.type == 'joker' and card.ability.set == 'Joker' and card.ability.gourmand then
		local spit =
		{
			n = G.UIT.C,
			config = { align = "cr" },
			nodes = {

				{
					n = G.UIT.C,
					config = { ref_table = card, align = "cr", maxw = 1.25, padding = 0.1, r = 0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.RED, one_press = true, button = 'sell_card', func = 'can_spitout' },
					nodes = {
						{ n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
						{
							n = G.UIT.C,
							config = { align = "tm" },
							nodes = {
								{
									n = G.UIT.R,
									config = { align = "cm" },
									nodes = {
										{ n = G.UIT.T, config = { text = localize('b_regurgitate'), colour = G.C.UI.TEXT_LIGHT, scale = 0.75, shadow = true } }
									}
								},
								{
									n = G.UIT.R,
									config = { align = "cm" },
									nodes = {
										{ n = G.UIT.T, config = { text = localize('mult_cost1'), colour = G.C.WHITE, scale = 0.75, shadow = true, padding = 0.15 } },
									}
								},
								{
									n = G.UIT.R,
									config = { align = "cm" },
									nodes = {
										{ n = G.UIT.T, config = { ref_table = card, text = localize('mult_cost2'), colour = G.C.WHITE, scale = 0.75, shadow = true } }

									}
								}
							}
						}
					}
				}
			}
		}
		retval.nodes[1].nodes[2].nodes = retval.nodes[1].nodes[2].nodes or {}
		table.insert(retval.nodes[1].nodes[2].nodes, spit)
		return retval
	end

	return retval
end

function Card:can_spitout()
	if self.ability.extra.xmult_mod >= 1 and self.ability.gourmand then
		return true
	end
	return false
end

function Card:spitout()
	if self.ability.extra.xmult_mod >= 1 then
		local chosen_card = SCUG.number_in_range(1, 20, "fatass")

		if G.consumeables.config.card_limit > #G.consumeables.cards then
			self.ability.extra.xmult_mod = self.ability.extra.xmult_mod - 0.2
			if chosen_card <= 6 then
				SMODS.add_card({ set = "foods", area = G.consumeables, key = 'c_rw_bubblefruit' })
			elseif chosen_card >= 7 and chosen_card <= 11 then
				SMODS.add_card({ set = "foods", area = G.consumeables, key = 'c_rw_mushroom' })
			elseif chosen_card >= 12 and chosen_card <= 15 then
				SMODS.add_card({ set = "obtainweapon", area = G.consumeables, key = 'c_rw_cherrybomb' })
			elseif chosen_card >= 16 and chosen_card <= 18 then
				SMODS.add_card({ set = "obtainweapon", area = G.consumeables, key = 'c_rw_sporepuff' })
			elseif chosen_card == 19 then
				SMODS.add_card({ set = "obtainweapon", area = G.consumeables, key = 'c_rw_beehive' })
			elseif chosen_card == 20 then
				SMODS.add_card({ set = "obtainweapon", area = G.consumeables, key = 'c_rw_grenade' })
			end
		else
			card_eval_status_text(self, "extra", nil, nil, nil, {
				message = "No Room!",
				colour = G.C.RED,
			})
		end

		--SMODS.add_card({ set = "Joker", area = G.jokers, edition = "e_negative"})
	else
		card_eval_status_text(self, "extra", nil, nil, nil, {
			message = "Too Hungry!",
			colour = G.C.RED,
		})
	end
end

G.FUNCS.can_spitout = function(e)
	e.config.colour = G.C.RED
	e.config.button = 'spitout'
end

G.FUNCS.spitout = function(e)
	local card = e.config.ref_table
	card:spitout()
end
