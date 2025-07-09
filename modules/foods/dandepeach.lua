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
		return { vars = { card.ability.extra.upgrade }}
	end,
	set_badges = function(self, card, badges)
		badges[#badges + 1] = create_badge(localize("k_fooduncommon"), G.C.GREEN, G.C.WHITE, 1.2)
	end,
	can_use = function(self, card)
		return #G.hand.cards > 0
	end,
	use = function(self, card, area, copier)
		if card.ability.name == "dandepeach" then
			_rank = pseudorandom_element(
				{ "A", "J", "Q", "K", "2", "3", "4", "5", "6", "7", "8", "9", "T" },
				pseudoseed("test")
			)
			_suit = pseudorandom_element({ "S", "H", "D", "C" }, pseudoseed("test"))
			G.deck.config.card_limit = G.deck.config.card_limit + 1
			local other_card = create_playing_card(
				{ front = G.P_CARDS[_suit .. "_" .. _rank], center = G.P_CENTERS.c_base },
				G.hand,
				nil,
				nil,
				{ G.C.SECONDARY_SET.Enhanced }
			)
			playing_card_joker_effects({ other_card })
			other_card.ability.perma_bonus = other_card.ability.perma_bonus or 0
			other_card.ability.perma_bonus = other_card.ability.perma_bonus + card.ability.extra.upgrade
		end
	end,
})
