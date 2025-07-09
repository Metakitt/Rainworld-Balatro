SMODS.Joker({
	key = "saint",
	atlas = "slugcats",
	pos = { x = 7, y = 0 },
	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	config = {
		extra = { attuned = false, discards = 25, saint_discards = 25, recharge = false, xmult = 1, recharging = "Ready" },
		name = "Saint",
		blessed = false,
		slugcat = true,
	},

	loc_vars = function(self, info_queue, card)
		-- if card.ability.extra.attuned == true then
		-- 	return {
		-- 		-- vars = { card.ability.extra.saint_discards, card.ability.extra.recharging },
		-- 		key = self.key .. "attuned",
		-- 	}
		-- end

		-- if card.ability.extra.attuned == false then
		-- 	return {
		-- 		vars = { card.ability.extra.saint_discards, card.ability.extra.recharging },
		-- 		key = self.key .. "neutral",
		-- 	}
		-- end
		local ret_table = { key = self.key, vars = { card.ability.extra.saint_discards, card.ability.extra.discards } }
		ret_table["key"] = self.key .. ((card.ability.extra.attuned and "attuned") or (card.ability.extra.recharge and "recharging") or "neutral")
		if card.ability.extra.recharge then
			ret_table.vars[1] = card.ability.extra.discards - ret_table.vars[1]
		end
		return ret_table
	end,

	calculate = function(self, card, context)
		if
			context.discard
			and card.ability.name == "Saint"
			and card.ability.extra.attuned == false
			and card.ability.extra.recharge == false
			and not context.blueprint
		then
			card.children.center:set_sprite_pos({ x = 7, y = 0 })
			if card.ability.extra.saint_discards <= 1 then
				card.children.center:set_sprite_pos({ x = 8, y = 0 })
				card.ability.extra.attuned = true
			else
				card.ability.extra.saint_discards = card.ability.extra.saint_discards - 1
			end

			return
		end

		if
			context.discard
			and card.ability.name == "Saint"
			and card.ability.extra.attuned == false
			and card.ability.extra.recharge == true
			and not context.blueprint
		then
			card.children.center:set_sprite_pos({ x = 7, y = 0 })
			if card.ability.extra.saint_discards < card.ability.extra.discards then
				card.ability.extra.saint_discards = card.ability.extra.saint_discards + 1
			else
				card.ability.extra.recharge = false
				-- card.ability.extra.recharging = "Ready"
			end

			return
		end

		if
			context.setting_blind
			and G.GAME.blind.boss
			and card.ability.extra.attuned == true
			and card.ability.extra.recharge == false
			and not context.blueprint
		then
			local jokers = {}
			for i, v in pairs(G.jokers.cards) do
				if not v:get_edition() and v ~= card then
					jokers[#jokers + 1] = v
				end
			end

			local chosen_joker = jokers[math.random(1, #jokers)]

			if chosen_joker then
				chosen_joker:set_edition("e_negative", true)
				SMODS.Stickers["eternal"]:apply(chosen_joker, true)
				card.ability.extra.recharge = true
				card.ability.extra.attuned = false
				-- card.ability.extra.recharging = "Recharging"
				card.ability.extra.blessed = true

				if card.ability.extra.blessed == true and not context.blueprint then
					local destructable_jokers = {}
					for i = 1, #G.jokers.cards do
						if
							G.jokers.cards[i] ~= card
							and G.jokers.cards[i] ~= chosen_joker
							and not G.jokers.cards[i].ability.eternal
							and not G.jokers.cards[i].getting_sliced
						then
							destructable_jokers[#destructable_jokers + 1] = G.jokers.cards[i]
						end
					end
					local joker_to_destroy = #destructable_jokers > 0
							and pseudorandom_element(destructable_jokers, pseudoseed("explode"))
						or nil

					if joker_to_destroy and not (context.blueprint_card or card).getting_sliced then
						joker_to_destroy.getting_sliced = true
						G.E_MANAGER:add_event(Event({
							func = function()
								joker_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
								return true
							end,
						}))
					end
				end
			end
		end

		if card.ability.extra.recharge == true and not context.blueprint then
			card.children.center:set_sprite_pos({ x = 7, y = 0 })
		end
	end,
})
