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
	loc_vars = function(self, info_queue, tag)
		return { vars = { tag.config.money } }
	end,
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
SMODS.Tag({
	key = "rivulet",
	config = {
		cards = 3,
	},
	atlas = "scugtags",
	pos = { x = 0, y = 1 },
	discovered = true,
	loc_vars = function(self, info_queue, tag)
		return { vars = {
			tag.config.cards,
		} }
	end,
	apply = function(self, tag, context)
		if context.type == "immediate" or context.type == "new_blind_choice" or context.type == "round_start_bonus" then
			tag:yep("+", G.C.SECONDARY_SET.Enhanced, function()
				local num_cards = tag.config.cards
				local i = 0
				SMODS.add_card({ set = "Enhanced", area = G.play, key_append = "tag_rw_rivulet" })
				SMODS.add_card({ set = "Enhanced", area = G.play, key_append = "tag_rw_rivulet" })
				SMODS.add_card({ set = "Enhanced", area = G.play, key_append = "tag_rw_rivulet" })
				while i < num_cards do
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = i == 0 and 0.7 or 0.2,
						func = function()
							draw_card(G.play, G.deck, 90, "up", nil)
							return true
						end,
					}))
					i = i + 1
				end
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
})

-- Power Tag
-- Mega Weapon pack
SMODS.Tag({
	key = "power",
	config = {
		pack_type = "p_rw_weapon_mega_1",
	},
	atlas = "scugtags",
	pos = { x = 1, y = 1 },
	discovered = true,
	loc_vars = function(self, info_queue, tag)
		info_queue[#info_queue + 1] = { set = "Other", key = tag.config.pack_type }
	end,
	min_ante = 2,
	apply = function(self, tag, context)
		if context.type == "new_blind_choice" then
			-- Weird evil booster pack code.
			-- Every mod I've seen copies this, so.
			local lock = tag.ID
			G.CONTROLLER.locks[lock] = true
			tag:yep("+", G.C.WEAPON, function()
				local key = tag.config.pack_type
				local card = Card(
					G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
					G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
					G.CARD_W * 1.27,
					G.CARD_H * 1.27,
					G.P_CARDS.empty,
					G.P_CENTERS[key],
					{ bypass_discovery_center = true, bypass_discovery_ui = true }
				)
				card.cost = 0
				card.from_tag = true
				G.FUNCS.use_card({ config = { ref_table = card } })
				card:start_materialize()
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
})

-- Quick-Equip Tag
-- Gives each of your jokers a random weapon
SMODS.Tag({
	key = "quickequip",
	config = {},
	atlas = "scugtags",
	pos = { x = 2, y = 1 },
	discovered = true,
	min_ante = 2,
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
						if not v.ability.enemy and not v.ability[new_weapon] then
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
SMODS.Tag({
	key = "feast",
	config = {
		pack_type = "p_rw_megafoodpack",
	},
	atlas = "scugtags",
	pos = { x = 3, y = 1 },
	discovered = true,
	loc_vars = function(self, info_queue, tag)
		info_queue[#info_queue + 1] = { set = "Other", key = tag.config.pack_type }
	end,
	apply = function(self, tag, context)
		if context.type == "new_blind_choice" then
			-- Weird evil booster pack code.
			-- Every mod I've seen copies this, so.
			local lock = tag.ID
			G.CONTROLLER.locks[lock] = true
			tag:yep("+", G.C.WEAPON, function()
				local key = tag.config.pack_type
				local card = Card(
					G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
					G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
					G.CARD_W * 1.27,
					G.CARD_H * 1.27,
					G.P_CARDS.empty,
					G.P_CENTERS[key],
					{ bypass_discovery_center = true, bypass_discovery_ui = true }
				)
				card.cost = 0
				card.from_tag = true
				G.FUNCS.use_card({ config = { ref_table = card } })
				card:start_materialize()
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
})

-- Healthy Tag
-- Turns Rot cards back to normal cards.
SMODS.Tag({
	key = "healthy",
	atlas = "scugtags",
	pos = { x = 0, y = 2 },
	discovered = true,
	in_pool = function(self, args)
		local rot_jokers = 0
		if G.jokers then
			for _, v in pairs(G.jokers.cards) do
				if v.ability.rw_rotted then
					rot_jokers = rot_jokers + 1
				end
			end
		end
		return (rot_jokers + SCUG.enhancement_count("m_rw_rotting", true)) > 0
	end,
	min_ante = 2,
	apply = function(self, tag, context)
		if context.type == "immediate" or context.type == "new_blind_choice" or context.type == "round_start_bonus" then
			tag:yep("<3", G.C.EDITION, function()
				for _, v in pairs(G.jokers.cards) do
					if v.ability.rw_rotted then
						v.ability.rw_rotted = nil
						v:juice_up()
					end
				end
				for _, v in pairs(G.playing_cards) do
					if SMODS.has_enhancement(v, "m_rw_rotting") then
						v:set_ability(G.P_CENTERS.c_base, nil, true)
					end
				end
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
})
