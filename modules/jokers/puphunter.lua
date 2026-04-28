SMODS.Joker({
	key = "puphunter",
	atlas = "slugcats",
	pos = { x = 3, y = 5 },
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = true,
	config = {
		extra = { center_table = 1, pupodds = 20, mult = 0, pupmult_gain = 2, spear = false, growth = 3, spear_strength = "strong" },
		slugcat = true,
		second_spear = true,
	},
	blueprint_compat = true,
	perishable_compat = false,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "slugpup_grows_up", vars = { card.ability.extra.growth } }
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.pupodds, "rw_hunter")
		return {
			vars = {
				numerator, denominator,
				card.ability.extra.mult,
				card.ability.extra.pupmult_gain,
			},
		}
	end,

	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint and card.ability.extra.growth > 0 then
			card.ability.extra.growth = card.ability.extra.growth - 1
			if card.ability.extra.growth <= 0 then
				card.ability.extra.growth = nil
				card:grow_up()
				return
			end
		end

		if context.after and not context.blueprint then
			-- card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.pupmult_gain
			-- SMODS.calculate_effect({ message = localize("k_upgrade_ex") }, card)
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "mult",
				scalar_value = "pupmult_gain",
				message_colour = G.C.MULT
			})
		end

		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
			}
		end

		if
			context.setting_blind
			and SMODS.pseudorandom_probability(card, "rw_hunter", 1, card.ability.extra.pupodds, "rw_hunter")
			and G.GAME.round_resets.blind_ante < 8
			and not context.blueprint
		then
			card.ability.extra.center_table = 1
			ease_ante(card.ability.extra.center_table)
			G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
			G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + card.ability.extra.center_table
		end
	end,
})
