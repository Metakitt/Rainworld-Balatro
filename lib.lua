SCUG = SMODS.current_mod
-- Possible Talisman compatibility
SCUG.big = function(x)
	return (Talisman and to_big(x)) or x
end
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

SCUG.clamp = function(value, min, max)
	return math.max(math.min(value, max), min)
end

SCUG.in_table = function(key, table)
	for _, v in pairs(table) do
		if v == key then
			return true
		end
	end
	return false
end

SCUG.get_suit_in_deck = function()
	local all_suits = {}
	for _, card in ipairs(G.playing_cards) do
		if not SMODS.has_no_suit(card) then
			local card_suit = card.config.card.suit
			if not SCUG.in_table(card_suit, all_suits) then
				table.insert(all_suits, card_suit)
			end
		end
	end
	local chosen_suit, _ = pseudorandom_element(all_suits, "get_suit", {})
	return chosen_suit
end
SCUG.get_rank_in_deck = function()
	local all_ranks = {}
	for _, card in ipairs(G.playing_cards) do
		if not SMODS.has_no_rank(card) then
			local card_suit = card.config.card.value
			if not SCUG.in_table(card_suit, all_ranks) then
				table.insert(all_ranks, card_suit)
			end
		end
	end
	local chosen_rank, _ = pseudorandom_element(all_ranks, "get_rank", {})
	return chosen_rank
end

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

---param enhancement_key string
---param count_debuffed boolean|nil
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
