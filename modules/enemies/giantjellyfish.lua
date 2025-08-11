-- Threat: Increases required Score per Blind by the amount of jokers * 5% (So if you have 5 jokers, it'd be a 25% increase).
-- Defeat: Play 3 hands with a Spear.
-- Not Defeated: Destroys a random Voucher.

SMODS.Joker({
	key = "giantjellyfish",
	config = {
		extra = {
			spears_needed = 3,
			spears_tanked = 0,
			pct_per_joker = 5,
			defeat = false,
		},
		enemy = true,
	},
	rarity = "rw_enemy",
	cost = 0,
	atlas = "enemies",
	pos = { x = 5, y = 2 },
	discovered = true,
	blueprint_compat = false,
	perishable_compat = false,
	rw_wbeehive_compat = false,
	rw_wcherrybomb_compat = false,
	rw_wspear_ele_compat = false,
	rw_wspear_exp_compat = false,
	rw_wspear_fire_compat = false,
	rw_wflashbang_compat = false,
	rw_wgrenade_compat = false,
	rw_wjokerifle_compat = false,
	rw_wrock_compat = false,
	rw_wsingularity_compat = false,
	rw_wspear_compat = false,
	rw_wsporepuff_compat = false,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.pct_per_joker,
				card.ability.extra.spears_needed,
				card.ability.extra.spears_tanked,
				card.ability.extra.pct_per_joker * (G and G.jokers and #G.jokers.cards or 0),
			},
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.Stickers["eternal"]:apply(card, true)
	end,
	calculate = function(self, card, context)
		-- Threat
		if context.setting_blind and not context.blueprint and not card.ability.extra.defeat then
			local score_mult = 1 + (card.ability.extra.pct_per_joker * #G.jokers.cards) / 100
			G.GAME.blind.chips = G.GAME.blind.chips * score_mult
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			card:juice_up()
			G.GAME.blind:wiggle()
		end
		-- Defeat
		if context.before and not context.blueprint then
			for _, v in pairs(G.jokers.cards) do
				for k, _ in pairs(v.ability) do
					st, nd = string.find(k, "rw_wspear")
					if st and nd then
						card.ability.extra.spears_tanked = card.ability.extra.spears_tanked + 1
					end
				end
			end
			if card.ability.extra.spears_tanked >= card.ability.extra.spears_needed then
				card.ability.extra.defeat = true
			end
		end
		if context.after and not context.blueprint and card.ability.extra.defeat then
			SMODS.destroy_cards(card, true)
		end
		-- Undefeated
		if
			context.main_eval
			and context.end_of_round
			and G.GAME.blind.boss
			and card.ability.extra.defeat == false
			and not context.blueprint
		then
			if #G.GAME.used_vouchers > 0 then
				local unvoucher, key = pseudorandom_element(G.GAME.used_vouchers, "rw_giant_jellyfish", {})
				G.GAME.used_vouchers[key] = nil
				card_eval_status_text(card, "extra", nil, nil, nil, {
					message = localize({
						type = "variable",
						key = "a_voucher_lost",
						vars = { localize({ type = "name_text", set = "Voucher", key = key }) },
					}),
					colour = G.C.RED,
					delay = 1.5,
				})
			end
		end
	end,
})
