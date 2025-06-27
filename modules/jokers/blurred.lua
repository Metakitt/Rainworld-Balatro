SMODS.Joker({
	key = "blurred",
	atlas = "slugcats",
	loc_txt = {
		name = "Blur",
		text = {
			"Reverses {C:chips}Chips{}",
			"and {C:mult}Mult{}.",
			"At the start of {C:attention}Blind{},",
			"{C:green}1 in 20{} chance to",
			"half {C:attention}Blind{} chips.",
		},
	},
	rarity = 2,
	cost = 4,
	pos = { x = 9, y = 2 },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { odds = 20 }, slugcat = true },
	-- loc vars needed for displaying odds
	calculate = function(self, card, context)
		if context.joker_main and not context.blueprint then
			return {
				swap = true,
			}
		end

		if context.setting_blind then
			if pseudorandom("mushroom") < G.GAME.probabilities.normal / card.ability.extra.odds then
				G.GAME.blind.chips = G.GAME.blind.chips / 2
				G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			end
		end
	end,
})
