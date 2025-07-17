SMODS.Consumable({
	key = "dandepeach",
	set = "foods",
	atlas = "weaponfoods",
	rarity = "rw_fooduncommon",
	pos = { x = 5, y = 0 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { extra = { upgrade = 20 }, name = "dandepeach" },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.upgrade } }
	end,
	set_badges = function(self, card, badges)
		badges[#badges + 1] = create_badge(localize("k_fooduncommon"), G.C.GREEN, G.C.WHITE, 1.2)
	end,
	can_use = function(self, card)
		return #G.hand.cards > 0
	end,
	use = function(self, card, area, copier)
		if card.ability.name == "dandepeach" then
			rank = pseudorandom_element(SMODS.Ranks, "rw_dandepeach_rank", {})
			suit = pseudorandom_element(SMODS.Suits, "rw_dandepeach_suit", {})
			local other_card = SMODS.add_card({
				set = "Base",
				rank = rank.key,
				suit = suit.key,
				area = G.hand,
			})
			other_card.ability.perma_bonus = other_card.ability.perma_bonus or 0
			other_card.ability.perma_bonus = other_card.ability.perma_bonus + card.ability.extra.upgrade
		end
	end,
})
