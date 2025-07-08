SMODS.Consumable({
	key = "karmaf",
	set = "foods",
	atlas = "weaponfoods",
	rarity = "rw_foodrare",
	pos = { x = 4, y = 1 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { extra = { center_table = -1 }, name = "karmaflower" },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.center_table }}
	end,
	set_badges = function(self, card, badges)
		badges[#badges + 1] = create_badge(localize("k_foodrare"), G.C.RED, G.C.WHITE, 1.2)
	end,
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		if card.ability.name == "karmaflower" then
			card.ability.extra.center_table = -1
			ease_ante(card.ability.extra.center_table)
			G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
			G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + card.ability.extra.center_table
		end
	end,
})
