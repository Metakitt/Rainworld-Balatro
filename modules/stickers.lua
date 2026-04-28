SMODS.Sticker({
	key = "rotted",
	badge_colour = HEX("000070"),
	atlas = "enhancedcards_scug",
	pos = { x = 4, y = 0 },
	default_compat = true,
	compat_exceptions = {},
	sets = {
		Joker = true,
		Tarot = false,
		Spectral = false,
		foods = false,
	},
	rate = 0,
	needs_enable_flag = false,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.rotted_tally } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chips = -25,
			}
		end

		if context.end_of_round and context.main_eval then
			if SMODS.pseudorandom_probability(card, "rw_rot", 1, 20, "rw_rot_spread", true) then
				local notrot = {}
				for i = 1, #G.jokers.cards do
					if
						G.jokers.cards[i] ~= card
						and G.jokers.cards[i].ability.rotted ~= true
						and not G.jokers.cards[i].getting_sliced
					then
						notrot[#notrot + 1] = G.jokers.cards[i]
					end
				end
				local rotted = #notrot > 0 and pseudorandom_element(notrot, pseudoseed("explode")) or nil
				if #notrot > 0 then
					rotted:set_rotted()
				end
			end
		end
	end,
})

function Card:set_rotted(_rotted)
	self.ability.rw_rotted = nil
	if self.config.center.rw_rotted_compat ~= false then
		self.ability.rw_rotted = true
		self.ability.rotted_tally = G.GAME.rottedjoker
	end
end

function Card:calculate_rotted()
	if self.ability.rw_rotted and self.ability.rotted_tally > 0 then
		if self.ability.rotted_tally == 1 then
			self.ability.rotted_tally = 0
			SMODS.calculate_effect({
				message = localize("k_rotted_ex"),
			}, self)
			SMODS.destroy_cards(self)
		else
			self.ability.rotted_tally = self.ability.rotted_tally - 1
			SMODS.calculate_effect({
				message = localize({ type = "variable", key = "a_remaining", vars = { self.ability.rotted_tally } }),
			}, self)
		end
	end
end
