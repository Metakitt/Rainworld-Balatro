-- Eats Rot.
-- -- Rotting Jokers: +3 Mult, removes the Rot sticker
-- -- Rot Enemies: X0.2 Mult, removes the enemy
-- -- Rot Cards: +4 Chips, removes the enhancement

local bonuses = {
	chips = 4,
	mult = 3,
	x_mult = 0.2
}

SMODS.Joker({
	key = "eater",
	config = {
		extra = {
			chips = 0,
			mult = 0,
			pup_x_mult = 1,
			munch_chance = 1000,
			grace_reset = 2,
			grace = 10,
			can_munch = true,
			growth = 8
		},
		slugcat = true,
		hunger = true,
	},
	rarity = 3,
	cost = 5,
	atlas = "slugcats",
	pos = { x = 6, y = 6 },
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	attributes = { "slugcat", "chips", "mult", "xmult", "modify_card", "destroy_card", "rot" },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "eater_unfortunate", vars = { card.ability.extra.growth } }
		return {
			vars = {
				card.ability.extra.chips,
				card.ability.extra.mult,
				card.ability.extra.pup_x_mult,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chips = card.ability.extra.chips,
				mult = card.ability.extra.mult,
				xmult = card.ability.extra.pup_x_mult,
			}
		end
		if context.main_eval and not context.blueprint and card.ability.extra.growth <= 0 then
			card.ability.extra.growth = nil
			local extra_mult = card.ability.extra.pup_x_mult - 1
			card:grow_up({ "j_rw_hunger" })
			card.ability.extra.x_mult = card.ability.extra.x_mult + extra_mult
		end
	end,
	update = function(self, card, dt)
		if card.ability.extra.grace > 0 then
			card.ability.extra.grace = card.ability.extra.grace - dt
		end

		if
			#SMODS.find_card("j_rw_eater") > 0
			and card.ability.extra.grace <= 0
			and card.ability.extra.can_munch
			and SMODS.pseudorandom_probability(card, "rw_hunger", 1, card.ability.extra.munch_chance, "rw_hunger")
		then
			-- Get all on-screen cards
			local rot_cards = {}
			-- Actively playing: Cards in hand. NOT cards being scored.
			if G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.HAND_PLAYED then
				if G.hand and G.hand.cards then
					for _, hand_card in ipairs(G.hand.cards) do
						local t = { card = hand_card, type = "rot_card" }
						if hand_card.config.center_key == "m_rw_rotting" then
							table.insert(rot_cards, t)
						end
					end
				end
			end
			-- Any time: Jokers
			for _, joker in ipairs(G.jokers.cards) do
				local t = { card = joker, type = "owned_joker" }
				if joker.ability.rw_rotted then
					t.type = "rot_sticker"
					table.insert(rot_cards, t)
				elseif (string.find(joker.config.center_key, "longlegs")) then
					t.type = "rot_enemy"
					table.insert(rot_cards, t)
				end
			end
			if #rot_cards > 0 then
				local snack, key = pseudorandom_element(rot_cards, "crumchy", {})
				if snack and snack.card ~= card then
					card.ability.extra.can_munch = false
					if snack.type == "rot_sticker" then
						G.E_MANAGER:add_event(Event({
							func = function()
								SMODS.calculate_effect({ message = localize("k_eaten_ex"), colour = G.C.GREEN },
									snack.card)
								snack.card.ability.rw_rotted = false
								return true
							end,
						}))
						G.E_MANAGER:add_event(Event({
							delay = 1,
							func = function()
								SMODS.scale_card(card, {
									ref_table = card.ability.extra,
									ref_value = "mult",
									scalar_table = bonuses,
									scalar_value = "mult",
									message_key = "a_mult",
									message_colour = G.C.MULT
								})
								return true
							end,
						}))
					elseif snack.type == "rot_card" then
						local card_chips = 4
						G.E_MANAGER:add_event(Event({
							func = function()
								SMODS.calculate_effect({ message = localize("k_eaten_ex"), colour = G.C.GREEN },
									snack.card)
								snack.card:set_ability("c_base")
								return true
							end,
						}))
						G.E_MANAGER:add_event(Event({
							delay = 1,
							func = function()
								SMODS.scale_card(card, {
									ref_table = card.ability.extra,
									ref_value = "chips",
									scalar_table = bonuses,
									scalar_value = "chips",
									message_key = "a_chips",
									message_colour = G.C.CHIPS
								})
								return true
							end,
						}))
					elseif snack.type == "rot_enemy" then
						G.E_MANAGER:add_event(Event({
							func = function()
								SMODS.calculate_effect({ message = localize("k_eaten_ex"), colour = G.C.GREEN },
									snack.card)
								SMODS.destroy_cards(snack.card, true)
								return true
							end,
						}))
						G.E_MANAGER:add_event(Event({
							delay = 1,
							func = function()
								SMODS.scale_card(card, {
									ref_table = card.ability.extra,
									ref_value = "pup_x_mult",
									scalar_table = bonuses,
									scalar_value = "x_mult",
									message_key = "a_xmult",
									message_colour = G.C.MULT
								})
								return true
							end,
						}))
					end
				end
				G.E_MANAGER:add_event(Event({
					delay = 0.1,
					func = function()
						card.ability.extra.can_munch = true
						return true
					end,
				}))
				card.ability.extra.growth = card.ability.extra.growth - 1
				card.ability.extra.grace = card.ability.extra.grace_reset * math.min(G.SETTINGS.GAMESPEED, 4)
			end
		end
	end,
})
