SMODS.Sticker({
	key = "wbeehive",
	config = {
		weapon = true,
		min_bonus = 5
	},
	loc_txt = {
		label = "Beehive",
	},
	badge_colour = HEX("875796"),
	atlas = "enhancedcards_scug",
	pos = { x = 0, y = 3 },
	default_compat = true,
	compat_exceptions = {},
	sets = {
		Joker = true,
		Tarot = false,
		Spectral = false,
		foods = false,
	},
	rate = 0.03,
	needs_enable_flag = false,
	calculate = function(self, card, context)
		if context.setting_blind and G.GAME.blind.boss and context.main_eval then
			local suit, _ = SCUG.get_suit_in_deck()
			if not suit then return end
			local suit_debuff, _ = SCUG.get_suit_in_deck({
				in_pool = function(v)
					return v ~= suit
				end
			})
			if not suit_debuff then return end

			for _, v in pairs(G.playing_cards) do
				if v:is_suit(suit) then
					if v.ability.perma_bonus <= 0 then
						v.ability.perma_bonus = self.config.min_bonus
					end
					if v.ability.perma_bonus > 0 then
						v.ability.perma_bonus = (v.ability.perma_bonus or 0) * 2
					end
					v:juice_up(0.5, 0.5)
					SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, v)
				elseif v:is_suit(suit_debuff) then
					SMODS.debuff_card(v, true, "bees")
				end
			end
		elseif context.end_of_round and context.main_eval and context.beat_boss then
			for _, v in pairs(G.playing_cards) do
				SMODS.debuff_card(v, false, "bees")
			end
		end
	end,
})

SMODS.Consumable({
	key = "beehive",
	set = "obtainweapon",
	atlas = "weaponfoods",
	pos = { x = 1, y = 2 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { weapon = "rw_wbeehive" },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = card.ability.weapon }
	end,
	can_use = function(self, card)
		return #G.jokers.highlighted == 1
			and not G.jokers.highlighted[1].ability.enemy
			and not G.jokers.highlighted[1].ability[card.ability.weapon]
	end,
	use = function(self, card, area, copier)
		for _, v in ipairs(G.jokers.highlighted) do
			SMODS.Stickers[card.ability.weapon]:apply(v, true)
		end
	end,
})
