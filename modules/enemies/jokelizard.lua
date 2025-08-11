SMODS.Joker({
	key = "jokelizard",
	config = {
		extra = { defeat = false },
		enemy = true,
	},
	rarity = "rw_enemy",
	cost = 0,
	atlas = "enemies",
	pos = { x = 6, y = 5 },
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
		info_queue[#info_queue + 1] = { key = "rw_wjokerifle", set = "Other" }
		return { vars = { G.jokers and math.max(1, #G.jokers.cards - 1) or 5 } }
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.Stickers["eternal"]:apply(card, true)
	end,
	calculate = function(self, card, context)
		-- Defeat
		if not card.ability.extra.defeat then
			if SCUG.weapon_count("rw_wjokerifle") > 0 then
				card.ability.extra.defeat = true
				SMODS.destroy_cards(card)
			end
		end
		-- Threat/Undefeated
		if
			(
				context.main_eval
				and context.end_of_round
				and G.GAME.blind.boss
				and card.ability.extra.defeat == false
				and not context.blueprint
			)
			or (
				context.setting_blind
				and not card.ability.extra.defeat
				and not context.blueprint
				and pseudorandom("rw_jokelizard") < 1 / math.max(1, #G.jokers.cards - 1)
			)
		then
			if (#G.jokers.cards - 1) > 0 then
				local jojers = {}
				local negatives = 0
				for _, v in pairs(G.jokers.cards) do
					if not SMODS.is_eternal(v) then
						negatives = negatives + (v.edition and v.edition.negative and 1 or 0)
						table.insert(jojers, v)
					end
				end
				-- print(jojers)
				for i = 1, #jojers do
					local rarity = jojers[i].config.center.rarity
					if type(rarity) == "number" then
						rarity = math.max(1, rarity - (pseudorandom("rw_jokelizard") < 0.5 and 1 or 0))
                        rarity = ({"Common", "Uncommon", "Rare", "Legendary"})[rarity]
					end
					SMODS.destroy_cards(jojers[i])
					local new_joker = SMODS.add_card({ set = "Joker", rarity = rarity })
					if negatives > 0 then
						new_joker:set_edition("e_negative")
						negatives = negatives - 1
					end
				end
				if context.end_of_round and G.GAME.blind.boss then
					SMODS.destroy_cards(card, true)
				end
			end
		end
	end,
})
