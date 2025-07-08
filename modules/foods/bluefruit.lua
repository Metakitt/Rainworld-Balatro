SMODS.Consumable({
	key = "bluefruit",
	set = "foods",
	atlas = "weaponfoods",
	rarity = "rw_foodcommon",
	pos = { x = 0, y = 0 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { extra = { upgrade = 15 }, name = "bluefruit" },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.upgrade }}
	end,
	set_badges = function(self, card, badges)
		badges[#badges + 1] = create_badge(localize("k_foodcommon"), G.C.BLUE, G.C.WHITE, 1.2)
	end,
	can_use = function(self, card)
		return #G.hand.highlighted == 1
	end,
	use = function(self, card, area, copier)
		if card.ability.name == "bluefruit" then
			for i, v in ipairs(G.hand.highlighted) do
				for i = 1, #G.hand.highlighted do
					other_card = v
					other_card.ability.perma_bonus = other_card.ability.perma_bonus or 0
					other_card.ability.perma_bonus = other_card.ability.perma_bonus + card.ability.extra.upgrade
					other_card:juice_up(0.5, 0.5)
					SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, other_card)
				end
			end
		end
	end,
})
