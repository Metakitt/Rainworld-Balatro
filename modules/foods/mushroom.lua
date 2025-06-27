SMODS.Consumable({
	key = "mushroom",
	set = "foods",
	atlas = "weaponfoods",
	rarity = "rw_foodcommon",
	pos = { x = 2, y = 1 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { extra = { upgrade = 4, odds = 5, replication = 3, pack = true }, name = "mushroom" },
	set_badges = function(self, card, badges)
		badges[#badges + 1] = create_badge(localize("k_foodcommon"), G.C.BLUE, G.C.WHITE, 1.2)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.replication } }
	end,
	add_to_deck = function(self, card, from_debuff)
		if card.ability.extra.pack == true then
			card.ability.extra.pack = false
		end
	end,
	keep_on_use = function(self, card)
		return true
	end,
	can_use = function(self, card)
		if card.area == G.pack_cards or G.GAME.blind.in_blind then
			return true
		end
	end,
	use = function(self, card, area, copier)
		if card.ability.extra.pack == true then
			card.ability.extra.pack = false
		end
		if
			card.ability.name == "mushroom"
			and card.area == G.consumeables
			and card.area ~= G.pack_cards
			and card.ability.extra.pack == false
		then
			if
				pseudorandom("mushroom") < G.GAME.probabilities.normal / card.ability.extra.odds
				and G.GAME.blind.in_blind
			then
				G.GAME.blind.chips = G.GAME.blind.chips / 2
				G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
				if pseudorandom("mushroom") < G.GAME.probabilities.normal / card.ability.extra.replication then
					local _card = copy_card(card)
					_card:add_to_deck()
					G.consumeables:emplace(_card)
					_card:start_materialize(nil, _first_dissolve)
					_first_dissolve = true
					card:start_dissolve()
				end
			end

			card:start_dissolve()
		end
	end,
})
