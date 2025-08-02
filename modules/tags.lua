-- Survivalist Tag
--Shop has a random Slugcat.
SMODS.Tag({
	key = "survivalist",
	atlas = "scugtags",
	pos = { x = 0, y = 0 },
	discovered = true,
	apply = function(self, tag, context)
		if context.type == "store_joker_create" then
			-- Get random scug
			local scugs = {}
			for k, v in pairs(G.P_CENTERS) do
				if v.config and v.config.slugcat and v.rarity ~= 4 then
					table.insert(scugs, k)
				end
			end
			local yours, _ = pseudorandom_element(scugs, pseudoseed("tag_rw_survivalist"))
			local slugcat =
				SMODS.create_card({ set = "Joker", key = tostring(yours), no_edition = true, area = context.area })
			create_shop_card_ui(slugcat, "Joker", context.area)
			slugcat.states.visible = false
			tag:yep("+", G.C.RARITY.Uncommon, function()
				slugcat:start_materialize()
				-- This code makes it free
				-- slugcat.ability.couponed = true
				-- slugcat:set_cost()
				return true
			end)
			tag.triggered = true
			return slugcat
		end
	end,
})

-- Top-Pup Tag
-- Gain 1 Negative Slugpup
SMODS.Tag({
	key = "top_pup",
	atlas = "scugtags",
	pos = { x = 1, y = 0 },
	discovered = true,
	apply = function(self, tag, context)
		if context.type == "immediate" or context.type == "eval" then
			tag:yep("+", G.C.DARK_EDITION, function()
				SMODS.add_card({ set = "Joker", key = "j_rw_slugpup", edition = "e_negative" })
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
})

-- Danger Tag
-- Spawns 1~2 Enemies but gain 20$.
SMODS.Tag({
	key = "danger",
	config = {
		money = 20,
	},
	atlas = "scugtags",
	pos = { x = 2, y = 0 },
	discovered = true,
	min_ante = 2,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			local lock = tag.ID
			G.CONTROLLER.locks[lock] = true
			tag:yep("+", G.C.RARITY.rw_enemy, function()
				local num_enemies = pseudorandom("tag_rw_danger") < 0.5 and 2 or 1
				while num_enemies > 0 do
					SCUG.spawn_enemy({ guarantee = true })
					num_enemies = num_enemies - 1
				end
				ease_dollars(tag.config.money)
				return true
			end)
			tag.triggered = true
			G.CONTROLLER.locks[lock] = nil
			return true
		end
	end,
})

-- Escape Tag
-- Removes a random enemy.
SMODS.Tag({
	key = "escape",
	atlas = "scugtags",
	pos = { x = 3, y = 0 },
	discovered = true,
	min_ante = 2,
	in_pool = function(self, args)
		return SCUG.enemy_count() > 0
	end,
	apply = function(self, tag, context)
		-- Get enemies
		if context.type == "immediate" or context.type == "round_start_bonus" then
			local enemies = {}
			for _, v in ipairs(G.jokers.cards) do
				if v.config.center.rarity == "rw_enemy" then
					table.insert(enemies, v)
				end
			end
			if #enemies > 0 then
				tag:yep("-", G.C.RARITY.rw_enemy, function()
					SMODS.destroy_cards(pseudorandom_element(enemies, pseudoseed("tag_rw_escape")), true)
					return true
				end)
				tag.triggered = true
				return true
			end
		end
	end,
})

-- Rivulet Tag
-- Gain 3 enhanced cards.

-- Power Tag
-- Mega Weapon pack

-- Quick-Equip Tag
-- Gives each of your jokers a random weapon
SMODS.Tag({
	key = "quickequip",
	config = {},
	atlas = "scugtags",
	pos = { x = 2, y = 1 },
	discovered = true,
	loc_vars = function(self, info_queue, tag)
		return { vars = {} }
	end,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			local ALL_WEAPONS = {}
			for k, _ in pairs(SMODS.Stickers) do
				local st, nd = string.find(k, "rw_w")
				if st == 1 and nd == 4 then
					table.insert(ALL_WEAPONS, k)
				end
			end
			tag:yep("+", G.C.WEAPON, function()
				for _, v in ipairs(G.jokers.cards) do
					local valid_weapons = {}
					for i, x in ipairs(ALL_WEAPONS) do
						valid_weapons[i] = x
					end
					local valid = false
					repeat
						local new_weapon, n = pseudorandom_element(valid_weapons, pseudoseed("tag_rw_quickequip"))
						if not v.ability[new_weapon] then
							valid = true
							SMODS.Stickers[new_weapon]:apply(v, true)
						else
							table.remove(valid_weapons, tonumber(n))
						end
					until valid or #valid_weapons == 0
				end
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
})

-- Feast Tag
-- Mega Food Pack

-- Healthy Tag
-- Turns Rot cards back to normal cards.
