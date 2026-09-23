SMODS.Joker({
	key = "printer",
	atlas = "slugcats",
	pos = { x = 7, y = 6 },
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	attributes = { "machine" },
	config = { extra = { odds = 3 }},
	loc_vars = function(self, info_queue, card)
		return { vars = {  } }
	end,
	calculate = function(self, card, context)
		
		if
			G.GAME.last_blind.boss
			and context.end_of_round
			and context.main_eval
		then
			local spup = SMODS.add_card({ set = "Joker", area = G.jokers, edition = "e_negative", attributes = {"slugpup"}})
			spup.cost = 0
			spup.sell_cost = 0
			if SMODS.pseudorandom_probability(card, "rw_printer", 1, card.ability.extra.odds, "rw_printer") then
			SMODS.destroy_cards(card, {immediate})
			end
		end
	end,
})
