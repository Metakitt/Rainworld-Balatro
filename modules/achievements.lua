-- [Achievements]
-- = Rain World
-- Have Monk, Survivor and Hunter in your Joker Field.
SMODS.Achievement({
	key = "rainworld",
	unlock_condition = function(self, args)
		if args.type == "modify_jokers" then
			local j = { monk = false, survivor = false, hunter = false }
			for _, v in pairs(G.jokers.cards) do
				if v.config.center_key == "j_rw_monk" then
					j.monk = true
				elseif v.config.center_key == "j_rw_survivor" then
					j.survivor = true
				elseif v.config.center_key == "j_rw_hunter" then
					j.hunter = true
				end
			end
			return j.monk and j.survivor and j.hunter
		end
	end,
})

-- = Rain World: Downpour
-- Complete a run with any 3 of these:
-- Saint, Gourmand, Spearmaster, Rivulet, Artificer
SMODS.Achievement({
	key = "downpour",
	unlock_condition = function(self, args)
		if args.type == "win" then
			local applicable_jokers =
				{ "j_rw_saint", "j_rw_gourmand", "j_rw_spearmaster", "j_rw_rivulet", "j_rw_artificer" }
			local num_owned = 0
			for _, v in pairs(G.jokers.cards) do
				if SCUG.in_table(v.config.center_key, applicable_jokers) then
					num_owned = num_owned + 1
				end
			end
			return num_owned >= 3
		end
	end,
})

-- = Rain World: Watcher
-- ???

-- = The Survivor
-- Have any Slugcat for the duration of 5 Antes.
SMODS.Achievement({
	key = "passage_survivor",
	unlock_condition = function(self, args)
		if args.type == "round_win" then
			return G.GAME.rw_achievement_stats.scug_antes >= 5
		end
	end,
})

-- = The Monk
-- ???

-- = The Hunter
-- ???

-- = The Saint
-- Do not defeat any enemies during 6 rounds.
-- (Excludes: Batflies, Infant Centipedes, COalescipedes, Leeches, Jellyfish)

-- = The Outlaw
-- Kill 7 creatures. If you finish an Ante without killing any creatures that Ante, it resets to 0.
SMODS.Achievement({
	key = "passage_outlaw",
	unlock_condition = function(self, args)
		if args.type == "rw_enemy_kills" then
			local idxs = {}
			for k, _ in G.GAME.rw_achievement_stats.ante_kills do
				idxs[#idxs + 1] = k
			end
			table.sort(idxs)
			local num_kills = 0
			for i = idxs[1], idxs[#idxs] do
				if G.GAME.rw_achievement_stats.ante_kills[i] then
					num_kills = num_kills + #G.GAME.rw_achievement_stats.ante_kills[i]
					if num_kills >= 7 then
						return true
					end
				else
					num_kills = 0
				end
			end
		end
	end,
})

-- = The Chieftain
-- ???

-- = The Wanderer
-- ???

-- = The Dragon Slayer
-- Kill Six Different types of lizards (doesn't have to be the same run)

-- = The Friend
-- Tame a Lizard (Unimplemented)

-- = The Scholar
-- ???

-- = The Martyr
-- Complete a run without using a food item.
SMODS.Achievement({
	key = "downpour",
	unlock_condition = function(self, args)
		if args.type == "win" then
			return G.GAME.consumeable_usage_total.foods == nil
		end
	end,
})

-- = The Nomad
-- ???

-- = The Pilgrim
-- ???

-- = The Mother
-- Complete a run with a Slugpup.
SMODS.Achievement({
	key = "downpour",
	unlock_condition = function(self, args)
		if args.type == "win" then
			for _, v in pairs(G.jokers.cards) do
				if v.config.center_key == "j_rw_slugpup" then
					return true
				end
			end
		end
	end,
})
