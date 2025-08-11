-- Magician selects a random effect at the end of round. All the effects are based on different slugcats.
SMODS.Joker({
	key = "magician",
	atlas = "slugcats",
	pos = { x = 2, y = 3 },
	rarity = 3,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	perishable_compat = false,
	config = {
		extra = {
			effect = "none",
			x_chips = 1,
			chips = 0,
			x_mult = 1,
			mult = 0,
			should_score = false,
			h_size = 0,
			type = "Flush",
			wepodds = 15,
			mushodds = 10,
			munch = false,
			saintodds = 20,
			food = "none",
			hand_type = "none",
		},
		slugcat = true,
	},

	loc_vars = function(self, info_queue, card)
		if card.ability.extra.effect == "none" then
			return {
				vars = {
					(G.GAME.probabilities.normal or 1),
					card.ability.extra.effect,
					card.ability.extra.chips,
					card.ability.extra.x_mult,
					card.ability.extra.mult,
					card.ability.extra.x_chips,
				},
				key = self.key .. "",
			}
		end

		if card.ability.extra.effect == "artificer" then
			return {
				vars = {
					(G.GAME.probabilities.normal or 1),
					card.ability.extra.effect,
					card.ability.extra.chips,
					card.ability.extra.x_mult,
					card.ability.extra.mult,
					card.ability.extra.x_chips,
				},
				key = self.key .. "_artificer",
			}
		end

		if card.ability.extra.effect == "bng" then
			return {
				vars = {
					(G.GAME.probabilities.normal or 1),
					card.ability.extra.effect,
					card.ability.extra.chips,
					card.ability.extra.x_mult,
					card.ability.extra.mult,
					card.ability.extra.x_chips,
				},
				key = self.key .. "_bng",
			}
		end

		if card.ability.extra.effect == "hunter" then
			return {
				vars = {
					(G.GAME.probabilities.normal or 1),
					card.ability.extra.effect,
					card.ability.extra.chips,
					card.ability.extra.x_mult,
					card.ability.extra.mult,
					card.ability.extra.x_chips,
				},
				key = self.key .. "_hunter",
			}
		end

		if card.ability.extra.effect == "inv" then
			return {
				vars = {
					(G.GAME.probabilities.normal or 1),
					card.ability.extra.effect,
					card.ability.extra.chips,
					card.ability.extra.x_mult,
					card.ability.extra.mult,
					card.ability.extra.x_chips,
				},
				key = self.key .. "_inv",
			}
		end

		if card.ability.extra.effect == "monk" then
			return {
				vars = {
					(G.GAME.probabilities.normal or 1),
					card.ability.extra.effect,
					card.ability.extra.chips,
					card.ability.extra.x_mult,
					card.ability.extra.mult,
					card.ability.extra.x_chips,
				},
				key = self.key .. "_monk",
			}
		end

		if card.ability.extra.effect == "scugbo" then
			return {
				vars = {
					(G.GAME.probabilities.normal or 1),
					card.ability.extra.effect,
					card.ability.extra.chips,
					card.ability.extra.x_mult,
					card.ability.extra.mult,
					card.ability.extra.x_chips,
				},
				key = self.key .. "_scugbo",
			}
		end

		if card.ability.extra.effect == "slugpup" then
			return {
				vars = {
					(G.GAME.probabilities.normal or 1),
					card.ability.extra.effect,
					card.ability.extra.chips,
					card.ability.extra.x_mult,
					card.ability.extra.mult,
					card.ability.extra.x_chips,
				},
				key = self.key .. "_slugpup",
			}
		end

		if card.ability.extra.effect == "gourmand" then
			return {
				vars = {
					(G.GAME.probabilities.normal or 1),
					card.ability.extra.effect,
					card.ability.extra.chips,
					card.ability.extra.x_mult,
					card.ability.extra.mult,
					card.ability.extra.x_chips,
				},
				key = self.key .. "_gourmand",
			}
		end

		if card.ability.extra.effect == "rivulet" then
			return {
				vars = {
					(G.GAME.probabilities.normal or 1),
					card.ability.extra.effect,
					card.ability.extra.chips,
					card.ability.extra.x_mult,
					card.ability.extra.mult,
					card.ability.extra.x_chips,
				},
				key = self.key .. "_rivulet",
			}
		end

		if card.ability.extra.effect == "spearmaster" then
			return {
				vars = {
					(G.GAME.probabilities.normal or 1),
					card.ability.extra.effect,
					card.ability.extra.chips,
					card.ability.extra.x_mult,
					card.ability.extra.mult,
					card.ability.extra.x_chips,
				},
				key = self.key .. "_spearmaster",
			}
		end

		if card.ability.extra.effect == "survivor" then
			return {
				vars = {
					(G.GAME.probabilities.normal or 1),
					card.ability.extra.effect,
					card.ability.extra.chips,
					card.ability.extra.x_mult,
					card.ability.extra.mult,
					card.ability.extra.x_chips,
				},
				key = self.key .. "_survivor",
			}
		end

		if card.ability.extra.effect == "pathfinder" then
			return {
				vars = {
					(G.GAME.probabilities.normal or 1),
					card.ability.extra.effect,
					card.ability.extra.chips,
					card.ability.extra.x_mult,
					card.ability.extra.mult,
					card.ability.extra.x_chips,
				},
				key = self.key .. "_pathfinder",
			}
		end

		if card.ability.extra.effect == "blurred" then
			return {
				vars = {
					(G.GAME.probabilities.normal or 1),
					card.ability.extra.effect,
					card.ability.extra.chips,
					card.ability.extra.x_mult,
					card.ability.extra.mult,
					card.ability.extra.x_chips,
				},
				key = self.key .. "_blurred",
			}
		end

		if card.ability.extra.effect == "alacrity" then
			return {
				vars = {
					(G.GAME.probabilities.normal or 1),
					card.ability.extra.effect,
					card.ability.extra.chips,
					card.ability.extra.x_mult,
					card.ability.extra.mult,
					card.ability.extra.x_chips,
				},
				key = self.key .. "_alacrity",
			}
		end

		if card.ability.extra.effect == "magician" then
			return {
				vars = {
					(G.GAME.probabilities.normal or 1),
					card.ability.extra.effect,
					card.ability.extra.chips,
					card.ability.extra.x_mult,
					card.ability.extra.mult,
					card.ability.extra.x_chips,
				},
				key = self.key .. "_magician",
			}
		end

		if card.ability.extra.effect == "enfys" then
			return {
				vars = {
					(G.GAME.probabilities.normal or 1),
					card.ability.extra.effect,
					card.ability.extra.chips,
					card.ability.extra.x_mult,
					card.ability.extra.mult,
					card.ability.extra.x_chips,
				},
				key = self.key .. "_enfys",
			}
		end

		if card.ability.extra.effect == "saint" then
			return {
				vars = {
					(G.GAME.probabilities.normal or 1),
					card.ability.extra.effect,
					card.ability.extra.chips,
					card.ability.extra.x_mult,
					card.ability.extra.mult,
					card.ability.extra.x_chips,
				},
				key = self.key .. "_saint",
			}
		end

		if card.ability.extra.effect == "lacuna" then
			return {
				vars = {
					(G.GAME.probabilities.normal or 1),
					card.ability.extra.effect,
					card.ability.extra.chips,
					card.ability.extra.x_mult,
					card.ability.extra.mult,
					card.ability.extra.x_chips,
				},
				key = self.key .. "_lacuna",
			}
		end

		if card.ability.extra.effect == "ranger" then
			return {
				vars = {
					(G.GAME.probabilities.normal or 1),
					card.ability.extra.effect,
					card.ability.extra.chips,
					card.ability.extra.x_mult,
					card.ability.extra.mult,
					card.ability.extra.x_chips,
				},
				key = self.key .. "_ranger",
			}
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		card.ability.extra.effect = pseudorandom_element(
			{
				"artificer",
				"bng",
				"hunter",
				"inv",
				"monk",
				"rivulet",
				"slugpup",
				"spearmaster",
				"survivor",
				"scugbo",
				"blurred",
				"pathfinder",
				"gourmand",
				"alacrity",
				"magician",
				"saint",
				"enfys",
				"lacuna",
				"ranger",
			},
			pseudoseed("slugcats")
		)
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			--print(card.ability.extra.effect)
		end

		if context.end_of_round and context.main_eval then
			card.ability.extra.effect = pseudorandom_element(
				{
					"artificer",
					"bng",
					"hunter",
					"inv",
					"monk",
					"rivulet",
					"slugpup",
					"spearmaster",
					"survivor",
					"scugbo",
					"blurred",
					"pathfinder",
					"gourmand",
					"alacrity",
					"magician",
					"saint",
					"enfys",
					"lacuna",
					"ranger",
				},
				pseudoseed("slugcats")
			)
		end

		if context.joker_main and card.ability.extra.effect == "scugbo" then
			local slugcats = 0
			for k, v in ipairs(G.jokers.cards) do
				if v.ability.slugcat == true then
					slugcats = slugcats + 4
				end
			end
			return {
				chips = card.ability.extra.chips,
				x_mult = card.ability.extra.x_mult,
				x_chips = card.ability.extra.x_chips,
				mult = card.ability.extra.mult + slugcats,
			}
		end

		-- Slugpup just adds extra chips and mult, but only temporarily.
		if card.ability.extra.effect == "slugpup" then
			if context.joker_main then
				return {
					chips = card.ability.extra.chips + 20,
					x_mult = card.ability.extra.x_mult,
					x_chips = card.ability.extra.x_chips,
					mult = card.ability.extra.mult + 8,
				}
			end
		end

		--Artificer Copy effect. The first hand of round destroys a card in hand and gives permanent chips.
		if card.ability.extra.effect == "artificer" then
			if context.joker_main then
				return {
					chips = card.ability.extra.chips,
					x_mult = card.ability.extra.x_mult,
					x_chips = card.ability.extra.x_chips,
					mult = card.ability.extra.mult,
				}
			end
			if context.before and G.GAME.current_round.hands_played == 0 then
				local destructable_cards = {}
				for i = 1, #G.hand.cards do
					if G.hand.cards[i] ~= card then
						destructable_cards[#destructable_cards + 1] = G.hand.cards[i]
					end
				end
				local card_to_destroy = #destructable_cards > 0
						and pseudorandom_element(destructable_cards, pseudoseed("explode"))
					or nil
				if card_to_destroy then
					card.ability.extra.chips = card.ability.extra.chips + 50
					G.E_MANAGER:add_event(Event({
						func = function()
							(context.blueprint_card or card):juice_up(0.8, 0.8)
							SMODS.calculate_effect({ message = "Destroyed!" }, card)
							card_to_destroy:start_dissolve()
							return true
						end,
					}))
				end
			end
		end

		-- Big and Greedy. For each used food card, gains 0.5x mult.
		if card.ability.extra.effect == "bng" then
			if context.joker_main then
				return {
					chips = card.ability.extra.chips,
					x_mult = card.ability.extra.x_mult,
					x_chips = card.ability.extra.x_chips,
					mult = card.ability.extra.mult,
				}
			end
			if
				context.using_consumeable
				and context.consumeable.config.center.set == "foods"
				and not context.blueprint
			then
				card.ability.extra.x_mult = card.ability.extra.x_mult + 0.25
				SMODS.calculate_effect({ message = "Upgrade!" }, card)
			end
		end

		-- Gourmand
		if card.ability.extra.effect == "gourmand" then
			if context.joker_main then
				return {
					chips = card.ability.extra.chips,
					x_mult = card.ability.extra.x_mult,
					mult = card.ability.extra.mult,
				}
			end

			if context.main_eval and next(SMODS.find_card("j_popcorn")) and not context.blueprint then
				for _, v in pairs(SMODS.find_card("j_popcorn")) do
					if not v.getting_sliced then
						v:start_dissolve()
						card.ability.extra.x_mult = card.ability.extra.x_mult + 0.25
						card.ability.extra.munch = true
						v.getting_sliced = true
					end
				end
			end

			if context.main_eval and next(SMODS.find_card("j_cavendish")) and not context.blueprint then
				for _, v in pairs(SMODS.find_card("j_cavendish")) do
					if not v.getting_sliced then
						v:start_dissolve()
						card.ability.extra.x_mult = card.ability.extra.x_mult + 0.25
						card.ability.extra.munch = true
						v.getting_sliced = true
					end
				end
			end

			if context.main_eval and next(SMODS.find_card("j_gros_michel")) and not context.blueprint then
				for _, v in pairs(SMODS.find_card("j_gros_michel")) do
					if not v.getting_sliced then
						v:start_dissolve()
						card.ability.extra.x_mult = card.ability.extra.x_mult + 0.25
						card.ability.extra.munch = true
						v.getting_sliced = true
					end
				end
			end

			if context.main_eval and next(SMODS.find_card("j_ice_cream")) and not context.blueprint then
				for _, v in pairs(SMODS.find_card("j_ice_cream")) do
					if not v.getting_sliced then
						v:start_dissolve()
						card.ability.extra.x_mult = card.ability.extra.x_mult + 0.25
						card.ability.extra.munch = true
						v.getting_sliced = true
					end
				end
			end

			-- Uncommon Food Jokers

			if context.main_eval and next(SMODS.find_card("j_egg")) and not context.blueprint then
				for _, v in pairs(SMODS.find_card("j_egg")) do
					if not v.getting_sliced then
						v:start_dissolve()
						card.ability.extra.x_mult = card.ability.extra.x_mult + 0.25
						card.ability.extra.munch = true
						v.getting_sliced = true
					end
				end
			end

			if context.main_eval and next(SMODS.find_card("j_seltzer")) and not context.blueprint then
				for _, v in pairs(SMODS.find_card("j_seltzer")) do
					if not v.getting_sliced then
						v:start_dissolve()
						card.ability.extra.x_mult = card.ability.extra.x_mult + 0.25
						card.ability.extra.munch = true
						v.getting_sliced = true
					end
				end
			end

			if context.main_eval and next(SMODS.find_card("j_flower_pot")) and not context.blueprint then
				for _, v in pairs(SMODS.find_card("j_flower_pot")) do
					if not v.getting_sliced then
						v:start_dissolve()
						card.ability.extra.x_mult = card.ability.extra.x_mult + 0.25
						card.ability.extra.munch = true
						v.getting_sliced = true
					end
				end
			end

			if context.main_eval and next(SMODS.find_card("j_ramen")) and not context.blueprint then
				for _, v in pairs(SMODS.find_card("j_ramen")) do
					if not v.getting_sliced then
						v:start_dissolve()
						card.ability.extra.x_mult = card.ability.extra.x_mult + 0.25
						card.ability.extra.munch = true
						v.getting_sliced = true
					end
				end
			end

			if context.main_eval and next(SMODS.find_card("j_diet_cola")) and not context.blueprint then
				for _, v in pairs(SMODS.find_card("j_diet_cola")) do
					if not v.getting_sliced then
						v:start_dissolve()
						card.ability.extra.x_mult = card.ability.extra.x_mult + 0.25
						card.ability.extra.munch = true
						v.getting_sliced = true
					end
				end
			end

			if context.main_eval and next(SMODS.find_card("j_turtle_bean")) and not context.blueprint then
				for _, v in pairs(SMODS.find_card("j_turtle_bean")) do
					if not v.getting_sliced then
						v:start_dissolve()
						card.ability.extra.x_mult = card.ability.extra.x_mult + 0.25
						card.ability.extra.munch = true
						v.getting_sliced = true
					end
				end
			end

			-- Food Cards

			if context.main_eval and next(SMODS.find_card("c_rw_bluefruit")) and not context.blueprint then
				for _, v in pairs(SMODS.find_card("c_rw_bluefruit")) do
					if not v.getting_sliced then
						v:start_dissolve()
						card.ability.extra.x_mult = card.ability.extra.x_mult + 0.25
						card.ability.extra.munch = true
						v.getting_sliced = true
					end
				end
			end

			if context.main_eval and next(SMODS.find_card("c_rw_bubblefruit")) and not context.blueprint then
				for _, v in pairs(SMODS.find_card("c_rw_bubblefruit")) do
					if not v.getting_sliced then
						v:start_dissolve()
						card.ability.extra.x_mult = card.ability.extra.x_mult + 0.25
						card.ability.extra.munch = true
						v.getting_sliced = true
					end
				end
			end

			if context.main_eval and next(SMODS.find_card("c_rw_gooieduck")) and not context.blueprint then
				for _, v in pairs(SMODS.find_card("c_rw_gooieduck")) do
					if not v.getting_sliced then
						v:start_dissolve()
						card.ability.extra.x_mult = card.ability.extra.x_mult + 0.25
						card.ability.extra.munch = true
						v.getting_sliced = true
					end
				end
			end

			if context.main_eval and next(SMODS.find_card("c_rw_dandepeach")) and not context.blueprint then
				for _, v in pairs(SMODS.find_card("c_rw_dandepeach")) do
					if not v.getting_sliced then
						v:start_dissolve()
						card.ability.extra.x_mult = card.ability.extra.x_mult + 0.25
						card.ability.extra.munch = true
						v.getting_sliced = true
					end
				end
			end

			if context.main_eval and next(SMODS.find_card("c_rw_slimemold")) and not context.blueprint then
				for _, v in pairs(SMODS.find_card("c_rw_slimemold")) do
					if not v.getting_sliced then
						v:start_dissolve()
						card.ability.extra.x_mult = card.ability.extra.x_mult + 0.25
						card.ability.extra.munch = true
						v.getting_sliced = true
					end
				end
			end

			if context.main_eval and next(SMODS.find_card("c_rw_lilypuck")) and not context.blueprint then
				for _, v in pairs(SMODS.find_card("c_rw_lilypuck")) do
					if not v.getting_sliced then
						v:start_dissolve()
						card.ability.extra.x_mult = card.ability.extra.x_mult + 0.25
						card.ability.extra.munch = true
						v.getting_sliced = true
					end
				end
			end

			if context.main_eval and next(SMODS.find_card("c_rw_eggbugegg")) and not context.blueprint then
				for _, v in pairs(SMODS.find_card("c_rw_eggbugegg")) do
					if not v.getting_sliced then
						v:start_dissolve()
						card.ability.extra.x_mult = card.ability.extra.x_mult + 0.25
						card.ability.extra.munch = true
						v.getting_sliced = true
					end
				end
			end

			if context.main_eval and next(SMODS.find_card("c_rw_fireegg")) and not context.blueprint then
				for _, v in pairs(SMODS.find_card("c_rw_fireegg")) do
					if not v.getting_sliced then
						v:start_dissolve()
						card.ability.extra.x_mult = card.ability.extra.x_mult + 0.25
						card.ability.extra.munch = true
						v.getting_sliced = true
					end
				end
			end

			if context.main_eval and next(SMODS.find_card("c_rw_popcornplant")) and not context.blueprint then
				for _, v in pairs(SMODS.find_card("c_rw_popcornplant")) do
					if not v.getting_sliced then
						v:start_dissolve()
						card.ability.extra.x_mult = card.ability.extra.x_mult + 0.25
						card.ability.extra.munch = true
						v.getting_sliced = true
					end
				end
			end

			if context.main_eval and next(SMODS.find_card("c_rw_glowweed")) and not context.blueprint then
				for _, v in pairs(SMODS.find_card("c_rw_glowweed")) do
					if not v.getting_sliced then
						v:start_dissolve()
						card.ability.extra.x_mult = card.ability.extra.x_mult + 0.25
						card.ability.extra.munch = true
						v.getting_sliced = true
					end
				end
			end

			if context.main_eval and next(SMODS.find_card("c_rw_mushroom")) and not context.blueprint then
				for _, v in pairs(SMODS.find_card("c_rw_mushroom")) do
					if not v.getting_sliced then
						v:start_dissolve()
						card.ability.extra.x_mult = card.ability.extra.x_mult + 0.25
						card.ability.extra.munch = true
						v.getting_sliced = true
					end
				end
			end

			if context.main_eval and next(SMODS.find_card("c_rw_karmaf")) and not context.blueprint then
				for _, v in pairs(SMODS.find_card("c_rw_karmaf")) do
					if not v.getting_sliced then
						v:start_dissolve()
						card.ability.extra.x_mult = card.ability.extra.x_mult + 0.25
						card.ability.extra.munch = true
						v.getting_sliced = true
					end
				end
			end

			if context.main_eval and next(SMODS.find_card("c_rw_neuronfly")) and not context.blueprint then
				for _, v in pairs(SMODS.find_card("c_rw_neuronfly")) do
					if not v.getting_sliced then
						v:start_dissolve()
						card.ability.extra.x_mult = card.ability.extra.x_mult + 0.25
						card.ability.extra.munch = true
						v.getting_sliced = true
					end
				end
			end

			if card.ability.extra.munch == true then
				SMODS.calculate_effect({ message = "Crunch", sound = "rw_crunch" }, card)
				delay(0.2)
				card.ability.extra.munch = false
			end
		end

		-- Hunter. Each played hand gives +6 mult.
		if card.ability.extra.effect == "hunter" then
			if context.joker_main then
				return {
					chips = card.ability.extra.chips,
					x_mult = card.ability.extra.x_mult,
					x_chips = card.ability.extra.x_chips,
					mult = card.ability.extra.mult,
				}
			end
			if context.after and not context.blueprint then
				card.ability.extra.mult = card.ability.extra.mult + 6
				SMODS.calculate_effect({ message = localize("k_upgrade_ex") }, card)
			end
		end

		-- Inv. Start of blind gives one negative slugpup.
		if card.ability.extra.effect == "inv" then
			if context.joker_main then
				return {
					chips = card.ability.extra.chips,
					x_mult = card.ability.extra.x_mult,
					x_chips = card.ability.extra.x_chips,
					mult = card.ability.extra.mult,
				}
			end
			if context.setting_blind then
				SMODS.add_card({ set = "Joker", area = G.jokers, edition = "e_negative", key = "j_rw_slugpup" })
			end
		end

		-- Monk. Each played hand gives +12 chips.
		if card.ability.extra.effect == "monk" then
			if context.joker_main then
				return {
					chips = card.ability.extra.chips,
					x_mult = card.ability.extra.x_mult,
					x_chips = card.ability.extra.x_chips,
					mult = card.ability.extra.mult,
				}
			end
			if context.after and not context.blueprint then
				card.ability.extra.chips = card.ability.extra.chips + 12
				SMODS.calculate_effect({ message = localize("k_upgrade_ex") }, card)
			end
		end

		-- Rivulet (Skipping blind resets the ability).
		if card.ability.extra.effect == "rivulet" then
			local blind_skipped = false
			if context.joker_main then
				return {
					chips = card.ability.extra.chips,
					x_mult = card.ability.extra.x_mult,
					x_chips = card.ability.extra.x_chips,
					mult = card.ability.extra.mult,
				}
			end

			if context.skip_blind then
			local cards_created = 3
				for _ = 1, cards_created do
					local rank = pseudorandom_element(SMODS.Ranks, "rw_rivulet_rank", {})
					local suit = pseudorandom_element(SMODS.Suits, "rw_rivulet_rank", {})
					SMODS.add_card({
						area = G.deck,
						rank = rank.key,
						suit = suit.key,
						set = "Enhanced",
					})
				end
				blind_skipped = true
			end

			if blind_skipped == true then
				card.ability.extra.effect = pseudorandom_element(
					{
						"artificer",
						"bng",
						"hunter",
						"inv",
						"monk",
						"rivulet",
						"slugpup",
						"spearmaster",
						"survivor",
						"scugbo",
						"blurred",
						"pathfinder",
						"gourmand",
						"alacrity",
						"magician",
						"saint",
						"enfys",
						"lacuna",
						"ranger",
					},
					pseudoseed("slugcats")
				)
			end
		end

		-- Saint (1 in 25 chance to make a random joker eternal negative whenever you discard.)
		if card.ability.extra.effect == "saint" then
			if context.joker_main then
				return {
					chips = card.ability.extra.chips,
					x_mult = card.ability.extra.x_mult,
					x_chips = card.ability.extra.x_chips,
					mult = card.ability.extra.mult,
				}
			end
			if
				context.pre_discard
				and pseudorandom("upgrade") < G.GAME.probabilities.normal / card.ability.extra.saintodds
			then
				local saintable = EMPTY(saintable)
				for k, v in pairs(G.jokers.cards) do
					if v.ability.set == "Joker" and not v.edition then
						table.insert(saintable, v)
					end
				end

				--for k, v in pairs(G.jokers.cards) do

				local chosen_card = pseudorandom_element(saintable, pseudoseed("test"))
				if chosen_card ~= nil then
					chosen_card:set_edition("e_negative", true)
				end
				--end
			end
		end

		-- Spearmaster
		if card.ability.extra.effect == "spearmaster" then
			if context.individual and context.cardarea == G.play then
				-- Don't trigger if there is no enhancement
				if context.other_card.config.center == G.P_CENTERS.c_base then
					card.ability.extra.should_score = false
				end
			elseif context.joker_main then
				if card.ability.extra.should_score == true then
					-- Mult time baybee!!!
					return {
						chips = card.ability.extra.chips,
						x_mult = card.ability.extra.x_mult + 2,
						x_chips = card.ability.extra.x_chips,
						mult = card.ability.extra.mult,
					}
				end
			elseif context.after and context.cardarea == G.jokers then
				-- Reset trigger flag for next hand
				card.ability.extra.should_score = true
			end
		end

		-- Survivor (Temporarily gives +2 handsize)
		if card.ability.extra.effect == "survivor" then
			if context.joker_main then
				return {
					chips = card.ability.extra.chips,
					x_mult = card.ability.extra.x_mult,
					x_chips = card.ability.extra.x_chips,
					mult = card.ability.extra.mult,
				}
			end
			if context.setting_blind then
				G.hand:change_size(-card.ability.extra.h_size)
				card.ability.extra.h_size = 2
				G.hand:change_size(card.ability.extra.h_size)
			end
		end

		if context.setting_blind and card.ability.extra.effect ~= "survivor" then
			G.hand:change_size(-card.ability.extra.h_size)
			card.ability.extra.h_size = 0
			G.hand:change_size(card.ability.extra.h_size)
		end

		-- Pathfinder (Discarding a flush gives a random tarot card)
		if card.ability.extra.effect == "pathfinder" then
			if context.joker_main then
				return {
					chips = card.ability.extra.chips,
					x_mult = card.ability.extra.x_mult,
					x_chips = card.ability.extra.x_chips,
					mult = card.ability.extra.mult,
				}
			end

			if
				context.pre_discard
				and G.consumeables.config.card_limit ~= #G.consumeables.cards
				and not context.blueprint
			then
				if G.FUNCS.get_poker_hand_info(G.hand.highlighted) == card.ability.extra.type then
					G.E_MANAGER:add_event(Event({
						func = function()
							G.E_MANAGER:add_event(Event({
								trigger = "after",
								delay = 0.7,
								blockable = false,
								func = function()
									local n_card = SMODS.create_card({ set = "Tarot", area = G.consumeables })
									G.consumeables:emplace(n_card)
									return true
								end,
							}))
							return true
						end,
					}))
				end
			end
		end

		-- Blurred (1 in 10 chance to half chip blinds when a hand is played.
		if card.ability.extra.effect == "blurred" then
			if context.joker_main then
				return {
					chips = card.ability.extra.chips,
					x_mult = card.ability.extra.x_mult,
					x_chips = card.ability.extra.x_chips,
					mult = card.ability.extra.mult,
				}
			end
			if context.after and not context.blueprint then
				if pseudorandom("mushroom") < G.GAME.probabilities.normal / card.ability.extra.mushodds then
					G.GAME.blind.chips = G.GAME.blind.chips / 2
					G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
				end
			end
		end

		-- Lacuna
		if card.ability.extra.effect == "lacuna" then
			local consume = G.consumeables.cards[1]

			if context.joker_main then
				return {
					chips = card.ability.extra.chips,
					x_mult = card.ability.extra.x_mult,
					x_chips = card.ability.extra.x_chips,
					mult = card.ability.extra.mult,
				}
			end

			if context.setting_blind and consume ~= nil then
				if
					consume.ability.set == "Planet"
					and pseudorandom("randomlevel") < G.GAME.probabilities.normal / card.ability.extra.odds
				then
					--print ('levelupplanet')
					card.ability.extra.hand_type = pseudorandom_element(
						{
							"Flush",
							"Pair",
							"High Card",
							"Three of a Kind",
							"Full House",
							"Four of a Kind",
							"Flush",
							"Straight",
							"Two Pair",
							"Straight Flush",
						},
						pseudoseed("levelup")
					)
					update_hand_text(
						{ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
						{
							handname = localize(card.ability.extra.hand_type, "poker_hands"),
							chips = G.GAME.hands[card.ability.extra.hand_type].chips,
							mult = G.GAME.hands[card.ability.extra.hand_type].mult,
							level = G.GAME.hands[card.ability.extra.hand_type].level,
						}
					)
					level_up_hand(used_tarot, card.ability.extra.hand_type)
					update_hand_text(
						{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
						{ mult = 0, chips = 0, handname = "", level = "" }
					)
				end

				if
					consume.ability.set == "Tarot"
					and context.main_eval
					and G.consumeables.config.card_limit > #G.consumeables.cards
				then
					--print ('tarot')
					local n_card = SMODS.create_card({ set = "Tarot", area = G.consumeables })
					G.consumeables:emplace(n_card)
				end

				if consume.ability.set == "Spectral" then
					--print ('spectral')

					--for k, v in pairs(G.deck.cards) do
					--print(chosen_card)
					local chosen_card = pseudorandom_element(G.deck.cards, pseudoseed("test"))
					local seal_type = pseudorandom(pseudoseed("certsl"))
					if seal_type > 0.75 then
						chosen_card:set_seal("Red", true)
					elseif seal_type > 0.5 then
						chosen_card:set_seal("Blue", true)
					elseif seal_type > 0.25 then
						chosen_card:set_seal("Gold", true)
					else
						chosen_card:set_seal("Purple", true)
					end

					--end
				end

				if
					consume.ability.set == "foods"
					and pseudorandom("upgrade") < G.GAME.probabilities.normal / card.ability.extra.odds
				then
					local buffup = {}
					for i = 1, #G.hand.cards do
						buffup = G.hand.cards[i]
						buffup.ability.perma_bonus = buffup.ability.perma_bonus + 20
						buffup:juice_up(0.5, 0.5)
						SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, buffup)
					end
				end

				if
					consume.ability.set == "obtainweapon"
					and pseudorandom("upgrade") < G.GAME.probabilities.normal / card.ability.extra.oddswep
				then
					--print ('disaster')

					local jokers = {}
					for i, v in pairs(G.jokers.cards) do
						jokers[#jokers + 1] = v
					end

					local chosen_joker = jokers[math.random(1, #jokers)]
					local weapon = pseudorandom_element(
						{
							"rw_wbeehive",
							"rw_wcherrybomb",
							"rw_wspear",
							"rw_wspear_ele",
							"rw_wspear_exp",
							"rw_wspear_fire",
							"rw_wflashbang",
							"rw_wgrenade",
							"rw_wjokerifle",
							"rw_wrock",
							"rw_wsingularity",
							"rw_wsporepuff",
						},
						pseudoseed("levelup")
					)
					SMODS.Stickers[weapon]:apply(chosen_joker, true)
				end
			end
		end

		-- Alacrity
		if card.ability.extra.effect == "alacrity" then
			if context.joker_main then
				return {
					chips = card.ability.extra.chips,
					x_mult = card.ability.extra.x_mult,
					x_chips = card.ability.extra.x_chips + 2,
					mult = card.ability.extra.mult,
				}
			end
		end

		-- Ranger

		if card.ability.extra.effect == "ranger" then
			if context.joker_main then
				return {
					chips = card.ability.extra.chips,
					x_mult = card.ability.extra.x_mult,
					x_chips = card.ability.extra.x_chips,
					mult = card.ability.extra.mult,
				}
			end
			if context.setting_blind then
				G.hand:change_size(-card.ability.extra.h_size)
				card.ability.extra.h_size = 3
				G.hand:change_size(card.ability.extra.h_size)
			end
		end

		if context.setting_blind and card.ability.extra.effect ~= "ranger" then
			G.hand:change_size(-card.ability.extra.h_size)
			card.ability.extra.h_size = 0
			G.hand:change_size(card.ability.extra.h_size)
		end

		-- Enfys
		if card.ability.extra.effect == "enfys" then
			if context.joker_main then
				return {
					chips = card.ability.extra.chips,
					x_mult = card.ability.extra.x_mult,
					x_chips = card.ability.extra.x_chips,
					mult = card.ability.extra.mult,
				}
			end
			if context.setting_blind then
				card.ability.extra.food = pseudorandom_element(
					{
						"j_popcorn",
						"j_gros_michel",
						"j_ice_cream",
						"j_egg",
						"j_flower_pot",
						"j_ramen",
						"j_diet_cola",
						"j_turtle_bean",
					},
					pseudoseed("foods")
				)
				SMODS.add_card({ set = "Joker", area = G.jokers, edition = "e_negative", key = card.ability.extra.food })
			end
		end

		-- Magician (Buffs all stats by 2 at the start of blind)
		if card.ability.extra.effect == "magician" then
			if context.setting_blind then
				card.ability.extra.chips = card.ability.extra.chips + 2
				card.ability.extra.x_mult = card.ability.extra.x_mult + 0.5
				card.ability.extra.x_chips = card.ability.extra.x_chips + 0.5
				card.ability.extra.mult = card.ability.extra.mult + 2
			end
			if context.joker_main then
				return {
					chips = card.ability.extra.chips,
					x_mult = card.ability.extra.x_mult,
					x_chips = card.ability.extra.x_chips,
					mult = card.ability.extra.mult,
				}
			end
		end
	end,
})
