SMODS.Joker({
	key = "arsenal",
	config = {
		extra = {
			wep_mult = 3,
		},
		slugcat = true
	},
	rarity = 1,
	cost = 5,
	atlas = "slugcats",
	pos = { x = 0, y = 4 },
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		local wep_count = 0
		if G and G.jokers and G.jokers.cards then
			for _, v in ipairs(G.jokers.cards) do
				for k, _ in pairs(v.ability) do
					local _st, _nd = string.find(k, "rw_w")
					if _st == 1 and _nd == 4 then
						wep_count = wep_count + 1
					end
				end
			end
		end
		return {
			vars = {
				card.ability.extra.wep_mult,
				card.ability.extra.wep_mult * wep_count,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local wep_count = 0
			for _, v in ipairs(G.jokers.cards) do
				for k, _ in pairs(v.ability) do
					local _st, _nd = string.find(k, "rw_w")
					if _st == 1 and _nd == 4 then
						wep_count = wep_count + 1
					end
				end
			end
			return {
				mult = card.ability.extra.wep_mult * wep_count,
			}
		end
	end,
})
