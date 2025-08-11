SMODS.Consumable({
	key = "slimemold",
	set = "foods",
	atlas = "weaponfoods",
	rarity = "rw_foodcommon",
	pos = { x = 6, y = 0 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { extra = { upgrade = 7 }, name = "slimemold" },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.upgrade, 2 }}
	end,
	set_badges = function(self, card, badges)
		badges[#badges + 1] = create_badge(localize("k_foodcommon"), G.C.BLUE, G.C.WHITE, 1.2)
	end,
	can_use = function(self, card)
		return #G.hand.highlighted <= 2 and #G.hand.highlighted > 0
	end,
	use = function(self, card, area, copier)
		if card.ability.name == "slimemold" then
			local other_card = G.hand.highlighted[i]
			for i = 1, #G.hand.highlighted do
				local other_card = G.hand.highlighted[i]
				other_card.ability.perma_mult = other_card.ability.perma_mult or 0
				other_card.ability.perma_mult = other_card.ability.perma_mult + card.ability.extra.upgrade
				other_card:juice_up(0.5, 0.5)
				SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, other_card)
			end
		end
	end,
})
