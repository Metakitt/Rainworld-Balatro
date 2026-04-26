-- Possible Talisman compatibility
SCUG.big = function(x)
	return (Talisman and to_big(x)) or x
end
-- Possible Talisman compatibility
SCUG.num = function(x)
	return (Talisman and to_number(x)) or x
end

---@param min integer? Minimum number that can be picked. Defaults to 1.
---@param max integer? Maximum number that can be picked. Defaults to 20.
---@param seed string? Pseudorandom seed. Defaults to "Rainworld"
---@return integer
---Returns a random integer between two numbers, including those numbers.
SCUG.number_in_range = function(min, max, seed)
	return math.floor(((max or 20) - (min or 1) + 1) * pseudorandom(seed or "Rainworld")) + min
end

---Clamp a value between any two bounds.
---@param value number
---@param min number
---@param max number
---@return number
SCUG.clamp = function(value, min, max)
	return math.max(math.min(value, max), min)
end

---Checks whether a value is in a table, regardless of the key it's stored under.
---@param value any
---@param table table
---@return boolean
SCUG.value_in_table = function(value, table)
	for _, v in pairs(table) do
		if v == value then
			return true
		end
	end
	return false
end

---Check if an item is in a pool.
---@param item string|Card|table
---@param pool string
---@return boolean
SCUG.is_in_pool = function(item, pool)
	if not SMODS.ObjectTypes[pool] then return false end

	if type(item) == "table" then
		if item.config and item.config.center and item.config.center.pools then
			if type(item.config.center.pools) == "table" then
				for k, v in pairs(item.config.center.pools) do
					if k == pool and v then return true end
				end
			end
		end
	elseif type(item) == "string" then
		if G.P_CENTERS[item] then
			for k, v in pairs(G.P_CENTERS[item].pools) do
				if k == pool and v then return true end
			end
		end
	end
	return false
end

---Gets a random suit which exists in the deck, with no weighting for frequency.
---@param args table|{} Passed into `pseudorandom_element` directly.
SCUG.get_suit_in_deck = function(args)
	args = args or {}
	local all_suits = {}
	for _, card in ipairs(G.playing_cards) do
		if not SMODS.has_no_suit(card) then
			local card_suit = card.config.card.suit
			if not SCUG.value_in_table(card_suit, all_suits) then
				table.insert(all_suits, card_suit)
			end
		end
	end
	return pseudorandom_element(all_suits, "get_suit", args)
end
---Gets a random rank which exists in the deck, with no weighting for frequency.
---@param args table|{} Passed into `pseudorandom_element` directly.
SCUG.get_rank_in_deck = function(args)
	args = args or {}
	local all_ranks = {}
	for _, card in ipairs(G.playing_cards) do
		if not SMODS.has_no_rank(card) then
			local card_suit = card.config.card.value
			if not SCUG.value_in_table(card_suit, all_ranks) then
				table.insert(all_ranks, card_suit)
			end
		end
	end
	return pseudorandom_element(all_ranks, "get_rank", args)
end

---Helper function for calculating Scavenger reputation.
---@param card Card|table The Scavenger to calculate for.
---@return number reputation The new reputation.
SCUG.scav_rep = function(card)
	local scug_rep = (1 * #SMODS.find_card("j_rw_monk", true))
		+ (-1 * #SMODS.find_card("j_rw_rivulet", true))
		+ (-2 * (#SMODS.find_card("j_rw_hunter", true) + #SMODS.find_card("j_rw_spearmaster", true)))
	local reputation = scug_rep
		+ (card and card.ability and card.ability.extra and card.ability.extra.permanent_reputation or 0)
	if #SMODS.find_card("j_rw_artificer", true) > 0 then
		reputation = -1000
	end
	return SCUG.clamp(reputation, -4, 4)
end

---Counts how many of an enhancement there are in the full deck. Returns the count, then the cards with that enhancement.
---@param enhancement_key string Key for the enhancement.
---@param count_debuffed boolean|nil Whether or not to include debuffed cards in the count.
---@return integer count How many cards have that enhancement.
---@return table cards All cards with that enhancement.
SCUG.enhancement_count = function(enhancement_key, count_debuffed)
	count_debuffed = count_debuffed or false
	local cards = {}
	if G and G.playing_cards then
		for _, v in ipairs(G.playing_cards) do
			if v.config.center_key == enhancement_key then
				if v:can_calculate(count_debuffed) then
					table.insert(cards, v)
				end
			end
		end
	end
	return #cards, cards
end

---Counts the total number of owned weapons across all Jokers.
---@param count_debuffed boolean? Whether to include weapons on debuffed Jokers. Defaults to `false`.
---@return integer
SCUG.num_owned_weapons = function(count_debuffed)
	count_debuffed = count_debuffed or false
	local weapons = 0
	if G.jokers then
		for _, v in pairs(G.jokers.cards) do
			if count_debuffed or v:can_calculate() then
				for _, vv in pairs(v.ability) do
					if type(vv) == "table" and vv.weapon then
						weapons = weapons + 1
					end
				end
			end
		end
	end
	return weapons
end

---Counts how many of a certain weapon is owned across all Jokers.
---@param weapon_key string The key of the weapon.
---@param count_debuffed boolean? Whether to include weapons on debuffed Jokers. Defaults to `false`.
---@return integer count The number of that weapon owned.
---@return table jokers All Jokers with that weapon.
SCUG.weapon_count = function(weapon_key, count_debuffed)
	count_debuffed = count_debuffed or false
	local cards_with_weapon = {}
	if G.jokers then
		for _, v in ipairs(G.jokers.cards) do
			for k, _ in pairs(v.ability) do
				if k == weapon_key then
					table.insert(cards_with_weapon, v)
				end
			end
		end
	end
	return #cards_with_weapon, cards_with_weapon
end

---Returns how many cards are debuffed by Beehive.
---@param card_table table Which cards to consider.
---@return number count How many cards are debuffed.
SCUG.bee_debuffed_count = function(card_table)
	local count = 0
	for _, v in ipairs(card_table) do
		if v.ability.debuff_sources and v.ability.debuff_sources["bees"] then
			count = count + 1
		end
	end
	return count
end

---Counts how many enemies are currently active.
---@return integer count The number of enemies.
SCUG.enemy_count = function()
	local enemy_count = 0
	if G.jokers then
		for _, v in pairs(G.jokers.cards) do
			if v.config.center.rarity == "rw_enemy" then
				enemy_count = enemy_count + 1
			end
		end
	end
	return enemy_count
end

---Helper function to determine whether or not Wet/Moldy cards get wetter.
---@return boolean
SCUG.sufficiently_wet = function()
	-- Decks: Looks to the Moon
	if G.GAME.selected_back.effect.center.key == "b_rw_LTTMdeck" then
		return true
	end
	-- Jokers
	local wet_keys = {
		"j_splash",
		"j_seltzer",
		"j_dietcola",
		"j_rw_rivulet",
		"j_rw_stupid_wet_rat",
	}
	for _, key in ipairs(wet_keys) do
		if #SMODS.find_card(key) > 0 then return true end
	end
	return false
end

---@param original_table table
---@return table
local copy_table = function(original_table)
	local copied = {}
	for k, v in pairs(original_table) do
		copied[k] = v
	end
	return copied
end

---Grow a Slugpup into a Slugcat.
---@param alt_keys table? Any additional keys, picks any of these keys or the auto-generated key at random.
function Card:grow_up(alt_keys)
	local possible_keys = alt_keys or {}
	local auto_key = string.gsub(self.config.center_key, "pup", "")
	if
		auto_key ~= self.config.center_key
		and G.P_CENTERS[auto_key]
	then
		table.insert(possible_keys, auto_key)
	end

	local ability = copy_table(self.ability)
	local ability_extra = copy_table(self.ability.extra)
	self:set_ability(pseudorandom_element(possible_keys, "rw_grow_up", {}), true)
	for k, v in pairs(ability) do
		if k ~= "extra" and self.ability[k] then self.ability[k] = v end
	end
	for k, v in pairs(ability_extra) do
		if self.ability.extra[k] then self.ability.extra[k] = v end
	end
end
