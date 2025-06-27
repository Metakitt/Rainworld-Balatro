SMODS.Consumable({
	key = "glowweed",
	set = "foods",
	atlas = "weaponfoods",
	rarity = "rw_foodrare",
	pos = { x = 1, y = 1 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { extra = { upgrade = 4, odds = 2 }, name = "glowweed" },
	set_badges = function(self, card, badges)
		badges[#badges + 1] = create_badge(localize("k_foodrare"), G.C.RED, G.C.WHITE, 1.2)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	can_use = function(self, card)
		return #G.hand.highlighted <= 2 and #G.hand.highlighted > 0
	end,
	use = function(self, card, area, copier)
		if
			card.ability.name == "glowweed"
			and pseudorandom("glowweed") < G.GAME.probabilities.normal / card.ability.extra.odds
		then
			local other_card = G.hand.highlighted[i]
			for i = 1, #G.hand.highlighted do
				local other_card = G.hand.highlighted[i]
				other_card:set_edition("e_foil")
				other_card:juice_up(0.5, 0.5)
				SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, other_card)
			end
		end
	end,
})
