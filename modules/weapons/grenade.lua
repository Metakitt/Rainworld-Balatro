SMODS.Sticker({
	key = "wgrenade",
	config = {
		mult = 0,
		mult_gain = 3,
		weapon = true
	},
	loc_txt = {
		label = "Grenade",
	},
	badge_colour = HEX("875796"),
	atlas = "enhancedcards_scug",
	pos = { x = 0, y = 1 },
	default_compat = true,
	compat_exceptions = {},
	sets = {
		Joker = true,
		Tarot = false,
		Spectral = false,
		foods = false,
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { SMODS.signed(card.ability.rw_wgrenade.mult) } }
	end,
	rate = 0.08,
	needs_enable_flag = false,
	calculate = function(self, card, context)
		if context.discard then
			if G.GAME.current_round.discards_used <= 0 and #context.full_hand == 1 then
				-- SMODS.calculate_effect({ message = localize("k_upgrade_ex") }, card)
				-- card.ability.rw_wgrenade.mult = card.ability.rw_wgrenade.mult + 3
				SMODS.scale_card(card, {
					ref_table = card.ability.rw_wgrenade,
					ref_value = "mult",
					scalar_value = "gain",
					message_colour = G.C.MULT
				})

				return {
					remove = true,
					card = self,
				}
			end
		end

		if context.joker_main then
			return {
				mult = card.ability.rw_wgrenade.mult,
			}
		end
	end,
})

SMODS.Consumable({
	key = "grenade",
	set = "obtainweapon",
	atlas = "weaponfoods",
	pos = { x = 9, y = 2 },
	cost = 3,
	unlocked = true,
	discovered = true,
	config = { weapon = "rw_wgrenade" },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = card.ability.weapon .. '2' }
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
