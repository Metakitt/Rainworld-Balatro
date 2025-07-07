SCUG = SMODS.current_mod
-- Possible Talisman compatibility
SCUG.big = function(x)
	return (Talisman and to_big(x)) or x
end
SCUG.num = function(x)
	return (Talisman and to_number(x)) or x
end

---@param min integer Minimum number that can be picked. Defaults to 1.
---@param max integer Maximum number that can be picked. Defaults to 20.
---@param seed string Pseudorandom seed. Defaults to "Rainworld"
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
