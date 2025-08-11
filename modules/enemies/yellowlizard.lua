--[[Threat: -2$ at the end of round. 1 in 5 chance to call another Yellow Lizard.
Defeat Condition: Reroll in the shop 5 times.
If not defeated: Sets money to -20$. ]]

SMODS.Joker({
	key = "yellowlizard",
	atlas = "enemies",
	rarity = "rw_enemy",
	cost = 4,
	pos = { x = 6, y = 2 },
	unlocked = true,
	discovered = true,
	in_pool = function(self, args)
		return false
	end,
	config = { extra = { defeat = false, takeyourmoney = -2, rerollneeded = 5, lizodds = 5 }, enemy = true },
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
		return { vars = { math.abs(card.ability.extra.takeyourmoney), card.ability.extra.lizodds, card.ability.extra.rerollneeded } }
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.Stickers["eternal"]:apply(card, true)
	end,
	calculate = function(self, card, context)
		--Threat
		if context.main_eval and context.end_of_round and not G.GAME.blind.boss and not context.blueprint then
			ease_dollars(card.ability.extra.takeyourmoney)
			if pseudorandom("morelizard") < 1 / card.ability.extra.lizodds then
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 1.3,
					func = function()
						SMODS.add_card({ set = "Joker", area = G.jokers, key = "j_rw_yellowlizard", no_edition = true })
						return true
					end,
					blocking = false,
				}))
			end
			return {
				message = localize("$") .. card.ability.extra.takeyourmoney,
				colour = G.C.MONEY,
				delay = 0.45,
			}
		end

		--Defeat
		if context.reroll_shop then
			card.ability.extra.rerollneeded = card.ability.extra.rerollneeded - 1
		if card.ability.extra.rerollneeded <= 0 then
			card.ability.extra.defeat = true
			SMODS.destroy_cards(card, true)
		end

		end

		

		if context.after and card.ability.extra.defeat == true and not context.blueprint then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 1.3,
				func = function()
					SMODS.destroy_cards(card, true)
					return true
				end,
				blocking = false,
			}))
		end
		--Undefeated
		if
			context.main_eval
			and context.end_of_round
			and G.GAME.blind.boss
			and card.ability.extra.defeat == false
			and not context.blueprint
		then
			ease_dollars(-G.GAME.dollars - 20, true)
		end
	end,
})
