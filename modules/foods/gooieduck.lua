SMODS.Consumable({
	key = "gooieduck",
	set = "foods",
	atlas = "weaponfoods",
	rarity = "rw_foodcommon",
	pos = { x = 4, y = 0 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { extra = { upgrade = 2, uses = 2 }, name = "gooieduck" },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.upgrade, card.ability.extra.uses } }
	end,
	set_badges = function(self, card, badges)
		badges[#badges + 1] = create_badge(localize("k_foodcommon"), G.C.BLUE, G.C.WHITE, 1.2)
	end,
	can_use = function(self, card)
		return #G.hand.cards > 0
	end,
	keep_on_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		if card.ability.extra.uses > 0 then
			for _, v in ipairs(G.hand.cards) do
				v.ability.perma_bonus = v.ability.perma_bonus or 0
				v.ability.perma_bonus = v.ability.perma_bonus + card.ability.extra.upgrade
				v:juice_up(0.5, 0.5)
				SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, v)
			end
			card.ability.extra.uses = card.ability.extra.uses - 1
		end
		if card.ability.extra.uses == 0 then
			-- card:start_dissolve()
			SMODS.destroy_cards(card)
		end
		SCUG.inc_food_count()
	end,
})
