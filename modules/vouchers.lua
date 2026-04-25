SMODS.Voucher({
	key = "weaponsale",
	loc_txt = {
		name = "Fair Trade",
		text = { "Weapon cards can appear in the shop." },
	},
	atlas = "scugvouchers",
	pos = { x = 0, y = 0 },

	redeem = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.obtainweapon_rate = (G.GAME.obtainweapon_rate or 0) + 2
				return true
			end,
		}))
	end,
})

SMODS.Voucher({
	key = "weaponboss",
	loc_txt = {
		name = "Scavenger Stash",
		text = { "{C:green}#1# in #2#{} chance to get a",
			"weapon at the end of a Boss Blind." },
	},
	atlas = "scugvouchers",
	pos = { x = 0, y = 1 },
	requires = { "v_rw_weaponsale" },
	config = { extra = { odds = 3 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "rw_scavstash") } }
	end,
	calculate = function(self, card, context)
		if
			G.GAME.last_blind.boss
			and context.end_of_round
			and context.main_eval
			and SMODS.pseudorandom_probability(card, "rw_weapon", 1, card.ability.extra.odds, "rw_scavstash")
		then
			local cr = SCUG.number_in_range(1, 11, "rw_weapon")
			local weaponselected = "none"
			if cr <= 5 then
				weaponselected = pseudorandom_element(
					{ "bluefruit", "spear", "rock", "cherrybomb", "grenade" }, --, "pearl" },
					pseudoseed("common")
				)
			elseif cr > 5 and cr <= 9 then
				weaponselected = pseudorandom_element(
					{ "spear_ele", "spear_exp", "beehive", "flashbang", "sporepuff" },
					pseudoseed("uncommon")
				)
			elseif cr > 9 then
				weaponselected = pseudorandom_element({ "singularity", "spear_fire", "jokerifle" }, pseudoseed("rare"))
			end

			if #G.consumeables.cards ~= G.consumeables.config.card_limit then
				SMODS.add_card { set = "obtainweapon", area = G.consumeables, key = "c_rw_" .. weaponselected }
			end
		end
	end,
})

SMODS.Voucher({
	key = "relay",
	loc_txt = {
		name = "Relay",
		text = { "Skipping a blind grants a random tag." },
	},
	atlas = "scugvouchers",
	pos = { x = 2, y = 0 },
	calculate = function(self, card, context)
		if context.skip_blind then
			local random_tag = pseudorandom_element(SMODS.Tags, "rw_random_tag")
			add_tag(Tag(random_tag.key))
		end
	end
})


SMODS.Voucher({
	key = "chain",
	loc_txt = {
		name = "Chain",
		text = { "Skipping a blind grants another random tag." },
	},
	atlas = "scugvouchers",
	pos = { x = 2, y = 1 },
	requires = { "v_rw_relay" },
	calculate = function(self, card, context)
		if context.skip_blind then
			local random_tag = pseudorandom_element(SMODS.Tags, "rw_random_tag")
			add_tag(Tag(random_tag.key))
		end
	end
})

if SCUG.config.allow_enemy_spawns then
	SMODS.Voucher({
		key = "rainfall",
		loc_txt = {
			name = "Rainfall",
			text = { "Enemies are half as likely to appear on all blinds." },
		},
		atlas = "scugvouchers",
		pos = { x = 1, y = 0 },
		calculate = function(self, card, context)
			if context.mod_probability and context.identifier == "rw_enemy_spawn" then
				return
				{
					denominator = context.denominator * 2
				}
			end
		end
	})

	SMODS.Voucher({
		key = "downpour",
		loc_txt = {
			name = "Downpour",
			text = { "Enemies no longer spawn." },
		},
		atlas = "scugvouchers",
		pos = { x = 1, y = 1 },
		requires = { "v_rw_rainfall" },
		calculate = function(self, card, context)
			if context.fix_probability and context.identifier == "rw_enemy_spawn" then
				return
				{
					numerator = 0
				}
			end
		end
	})
end
