SMODS.Consumable({
	key = "mushroom",
	set = "foods",
	atlas = "weaponfoods",
	rarity = "rw_foodcommon",
	pos = { x = 2, y = 1 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { extra = { upgrade = 4, odds = 5, replication = 3 }, name = "mushroom" },
	set_badges = function(self, card, badges)
		badges[#badges + 1] = create_badge(localize("k_foodcommon"), G.C.BLUE, G.C.WHITE, 1.2)
	end,
	loc_vars = function(self, info_queue, card)
		local numerator, half_odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "rw_mushroom")
		local _, dupe_odds = SMODS.get_probability_vars(card, 1, card.ability.extra.replication, "rw_mushroom")
		return { vars = { numerator, half_odds, dupe_odds } }
	end,
	can_use = function(self, card)
		return G.GAME.blind.in_blind
	end,
	select_card = "consumeables",
	use = function(self, card, area, copier)
		if
			SMODS.pseudorandom_probability(card, "rw_mushroom", 1, card.ability.extra.odds, "rw_mushroom_chips")
			and G.GAME.blind.in_blind
		then
			-- G.GAME.blind.chips = G.GAME.blind.chips / 2
			-- G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			SMODS.calculate_effect({ xblindsize = 0.5 }, card)
		end
		if SMODS.pseudorandom_probability(card, "rw_mushroom", 1, card.ability.extra.replication, "rw_mushroom_replicate") then
			-- local _card = copy_card(card)
			-- _card:add_to_deck()
			-- G.consumeables:emplace(_card)
			-- _card:start_materialize(nil, _first_dissolve)
			-- _first_dissolve = true
			-- card:start_dissolve()
			SMODS.add_card {
				set = "foods",
				key = "c_rw_mushroom"
			}
		end
		SCUG.inc_food_count()
	end,
})
