--[[if context.individual and context.cardarea == G.joker then
-- iterate over the joker field; check how many jokers are "slugcats"
if context.other_card is
]]
SMODS.Joker({
	key = "scugbo",
	atlas = "slugcats",
	loc_txt = {
		name = "Scugbo",
		text = {
			"{C:mult}+#1#{} Mult for",
			"each Slugcat.",
		},
	},
	rarity = 1,
	cost = 4,
	pos = { x = 7, y = 2 },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	attributes = { "slugcat", "mult", "joker" },
	config = { extra = { upgrade = 4 }, slugcat = true },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.upgrade } }
	end,
	calculate = function(self, card, context)
		if context.joker_main and not context.blueprint then
			local scugbocursed = math.random(1, 100)
			if scugbocursed == 100 then
				card.children.center:set_sprite_pos({ x = 8, y = 2 })
			end
			local slugcats = 0
			for k, v in ipairs(G.jokers.cards) do
				-- if v.ability.slugcat == true then
				if v:has_attribute("slugcat") then
					slugcats = slugcats + 1
				end
			end
			return {
				mult = slugcats * card.ability.extra.upgrade,
			}
		end
	end,
})
