SMODS.Consumable({
	key = "bubblefruit",
	set = "foods",
	atlas = "weaponfoods",
	rarity = "rw_foodcommon",
	pos = { x = 1, y = 0 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { extra = { upgrade = 15 }, name = "bubblefruit" },
	set_badges = function(self, card, badges)
		badges[#badges + 1] = create_badge(localize("k_foodcommon"), G.C.BLUE, G.C.WHITE, 1.2)
	end,
	update = function(self, card, dt)
		if
			card.ability.name == "bubblefruit" and next(SMODS.find_card("j_rw_rivulet"))
			or next(SMODS.find_card("j_splash"))
			or next(SMODS.find_card("j_seltzer"))
			or next(SMODS.find_card("j_dietcola"))
		then
			card.children.center:set_sprite_pos({ x = 2, y = 0 })
			if
				card.ability.name == "bubblefruit"
				and not next(SMODS.find_card("j_rw_rivulet"))
				and not next(SMODS.find_card("j_splash"))
				and not next(SMODS.find_card("j_seltzer"))
				and not next(SMODS.find_card("j_dietcola"))
			then
				card.children.center:set_sprite_pos({ x = 1, y = 0 })
			end
		end
	end,
	can_use = function(self, card)
		return #G.hand.highlighted == 1
	end,
	use = function(self, card, area, copier)
		if
			card.ability.name == "bubblefruit"
			and not next(SMODS.find_card("j_rw_rivulet"))
			and not next(SMODS.find_card("j_splash"))
			and not next(SMODS.find_card("j_seltzer"))
			and not next(SMODS.find_card("j_dietcola"))
		then
			for i, v in ipairs(G.hand.highlighted) do
				for i = 1, #G.hand.highlighted do
					other_card = v
					other_card.ability.perma_bonus = other_card.ability.perma_bonus or 0
					other_card.ability.perma_bonus = other_card.ability.perma_bonus * 2
					other_card:juice_up(0.5, 0.5)
					SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, other_card)
				end
			end
		end
		if
			card.ability.name == "bubblefruit" and next(SMODS.find_card("j_rw_rivulet"))
			or next(SMODS.find_card("j_splash"))
			or next(SMODS.find_card("j_seltzer"))
			or next(SMODS.find_card("j_dietcola")) and not G.STATE == G.STATES.SMODS_BOOSTER_OPENED
		then
			for i, v in ipairs(G.hand.highlighted) do
				for i = 1, #G.hand.highlighted do
					other_card = v
					other_card.ability.perma_bonus = other_card.ability.perma_bonus or 0
					other_card.ability.perma_bonus = other_card.ability.perma_bonus * 4
					other_card:juice_up(0.5, 0.5)
					SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, other_card)
				end
			end
		end
	end,
})
