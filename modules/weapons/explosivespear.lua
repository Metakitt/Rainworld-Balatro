SMODS.Sticker({
	key = "wspear_exp",
	loc_txt = {
		label = "Explosive Spear",
	},
	badge_colour = HEX("875796"),
	atlas = "enhancedcards_scug",
	pos = { x = 2, y = 2 },
	default_compat = true,
	compat_exceptions = {},
	sets = {
		Joker = true,
		Tarot = false,
		Spectral = false,
		foods = false,
	},
	rate = 0.005,
	needs_enable_flag = false,
	loc_vars = function(self, info_queue, card)
		if
			card.config.center_key == "j_rw_monk"
			or card.config.center_key == "j_rw_inv"
			or card.config.center_key == "j_rw_saint"
		then
			return { key = self.key .. "_monk_inv" }
		end

		if
			card.config.center_key == "j_rw_hunter"
			or card.config.center_key == "j_rw_artificer"
			or card.config.center_key == "j_rw_spearmaster"
		then
			return { key = self.key .. "_hunter_artificer_spearmaster" }
		end

		if card.config.center_key == "j_rw_gourmand" then
			return { key = self.key .. "_gourmand" }
		end
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local lodging = math.random(1, 100)
			local gourmandexhausted = math.random(1, 4)
			local destroycard = math.random(1, 6)

			if lodging >= 3 or card.config.center_key == "j_rw_artificer" then
				if destroycard == 4 then
					if card.config.center_key == "j_rw_artificer" then
						card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.bonus_chips
					end
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
						G.E_MANAGER:add_event(Event({
							func = function()
								(context.blueprint_card or card):juice_up(0.8, 0.8)
								SMODS.calculate_effect({ message = "Destroyed!" }, card)
								card_to_destroy:start_dissolve()
								SMODS.calculate_context({ remove_playing_cards = true, removed = { card_to_destroy } })
								return true
							end,
						}))
					end
				end

				if
					card.config.center_key == "j_rw_monk"
					or card.config.center_key == "j_rw_inv"
					or card.config.center_key == "j_rw_saint"
				then
					return {
						x_mult = 2.5,
					}
				elseif
					card.config.center_key == "j_rw_hunter"
					or card.config.center_key == "j_rw_artificer"
					or card.config.center_key == "j_rw_spearmaster"
				then
					return {
						x_mult = 3.5,
					}
				elseif card.config.center_key == "j_rw_gourmand" and gourmandexhausted == 4 then
					return {
						x_mult = 0.7,
					}
				elseif card.config.center_key == "j_rw_gourmand" and gourmandexhausted < 4 then
					return {
						x_mult = 6,
					}
				else
					return {
						x_mult = 3,
					}
				end
			end
			if lodging <= 2 and card.config.center_key ~= "j_rw_artificer" then
				SMODS.Stickers.rw_wspear:apply(card)
			end
		end
	end,
})

SMODS.Consumable({
	key = "spear_exp",
	loc_txt = {
		name = "Explosive Spear",
		text = { "Gives an Explosive Spear", "to 1 Joker." },
	},
	set = "obtainweapon",
	atlas = "weaponfoods",
	pos = { x = 4, y = 2 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { extra = { upgrade = 15 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "rw_wspear_exp" }
	end,
		can_use = function(self, card)
		if G.jokers.highlighted[1].ability.enemy == true then 
		return false
		end
	if not G.jokers.highlighted[1].ability.enemy then
		return true
		end
	end,
	use = function(self, card, area, copier)
		for i, v in ipairs(G.jokers.highlighted) do
			for i = 1, #G.jokers.highlighted do
				SMODS.Stickers["rw_wspear_exp"]:apply(v, true)
			end
		end
	end,
})
