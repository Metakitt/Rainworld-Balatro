SMODS.Consumable({
	key = "eggbugegg",
	set = "foods",
	atlas = "weaponfoods",
	rarity = "rw_fooduncommon",
	pos = { x = 8, y = 0 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { extra = { upgrade = 4 }, name = "eggbugegg" },
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.upgrade,
			},
		}
	end,
	set_badges = function(self, card, badges)
		badges[#badges + 1] = create_badge(localize("k_fooduncommon"), G.C.GREEN, G.C.WHITE, 1.2)
	end,
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		if card.ability.name == "eggbugegg" then
			-- local suit = pseudorandom_element(SMODS.Suits, pseudoseed("mysuit"))
			local suit = SCUG.get_suit_in_deck()
			for _,v in ipairs(G.playing_cards) do
				local other_card = v --G.playing_cards[i]
				if other_card:is_suit(suit) then
					other_card.ability.perma_bonus = other_card.ability.perma_bonus or 0
					other_card.ability.perma_bonus = other_card.ability.perma_bonus + card.ability.extra.upgrade
					other_card:juice_up(0.5, 0.5)
					SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, other_card)
				end
			end
		end
	end,
})
