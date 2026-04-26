SMODS.Joker({
	key = "puparsenal",
	config = {
		extra = {
			pupwep_mult = 1,
			growth = 3
		},
		slugcat = true
	},
	rarity = 1,
	cost = 5,
	atlas = "slugcats",
	pos = { x = 0, y = 6 },
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "slugcat", "weapon", "mult" },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "slugpup_grows_up", vars = { card.ability.extra.growth } }
		return {
			vars = {
				card.ability.extra.pupwep_mult,
				card.ability.extra.pupwep_mult * SCUG.num_owned_weapons(),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint and card.ability.extra.growth > 0 then
			card.ability.extra.growth = card.ability.extra.growth - 1
			if card.ability.extra.growth <= 0 then
				card.ability.extra.growth = nil
				card:grow_up()
			end
		end

		if context.joker_main then
			return {
				mult = card.ability.extra.pupwep_mult * SCUG.num_owned_weapons(),
			}
		end
	end,
})
