SMODS.Consumable({
	key = "neuronfly",
	set = "foods",
	atlas = "weaponfoods",
	rarity = "rw_foodrare",
	pos = { x = 3, y = 1 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { extra = { h_size = 0, h_mod = 1 }, name = "neuronfly" },
	set_badges = function(self, card, badges)
		badges[#badges + 1] = create_badge(localize("k_foodrare"), G.C.RED, G.C.WHITE, 1.2)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.h_mod } }
	end,
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		if card.ability.name == "neuronfly" then
			G.hand:change_size(-card.ability.extra.h_size)
			card.ability.extra.h_size = card.ability.extra.h_size + card.ability.extra.h_mod
			G.hand:change_size(card.ability.extra.h_size)
			SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.ORANGE }, card)
		end
	end,
})
