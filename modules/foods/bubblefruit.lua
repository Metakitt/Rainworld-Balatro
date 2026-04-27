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
			next(SMODS.find_card("j_rw_rivulet"))
			or next(SMODS.find_card("j_splash"))
			or next(SMODS.find_card("j_seltzer"))
			or next(SMODS.find_card("j_dietcola"))
		then
			card.children.center:set_sprite_pos({ x = 2, y = 0 })
			if

				not next(SMODS.find_card("j_rw_rivulet"))
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
			not next(SMODS.find_card("j_rw_rivulet"))
			and not next(SMODS.find_card("j_splash"))
			and not next(SMODS.find_card("j_seltzer"))
			and not next(SMODS.find_card("j_dietcola"))
		then
			for i, v in ipairs(G.hand.highlighted) do
				v.ability.perma_bonus = v.ability.perma_bonus or 0
				v.ability.perma_bonus = v.ability.perma_bonus * 2
				v:juice_up(0.5, 0.5)
				SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, v)
			end
		end
		if
			next(SMODS.find_card("j_rw_rivulet"))
			or next(SMODS.find_card("j_splash"))
			or next(SMODS.find_card("j_seltzer"))
			or next(SMODS.find_card("j_dietcola")) and not G.STATE == G.STATES.SMODS_BOOSTER_OPENED
		then
			for i, v in ipairs(G.hand.highlighted) do
				v.ability.perma_bonus = v.ability.perma_bonus or 0
				v.ability.perma_bonus = v.ability.perma_bonus * 4
				v:juice_up(0.5, 0.5)
				SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, v)
			end
		end
		SCUG.inc_food_count()
	end,
})
