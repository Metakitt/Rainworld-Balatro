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
		return { vars = { SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "rw_scavstash") }}
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
					{ "bluefruit", "spear", "rock", "cherrybomb", "grenade"}, --, "pearl" },
					pseudoseed("common")
				)
			elseif cr > 5 and cr <= 9 then
				weaponselected = pseudorandom_element(
					{ "electricspear", "explosivespear", "beehive", "flashbang", "sporepuff" },
					pseudoseed("uncommon")
				)
			elseif cr > 9 then
				weaponselected = pseudorandom_element({ "singularity", "firespear", "jokerifle" }, pseudoseed("rare"))
			end

			if #G.consumeables.cards ~= G.consumeables.config.card_limit then
				-- if weaponselected == "beehive" then
				-- 	SMODS.add_card({ set = "obtainweapon", area = G.consumeables, key = "c_rw_beehive" }) --
				-- elseif weaponselected == "cherrybomb" then
				-- 	SMODS.add_card({ set = "obtainweapon", area = G.consumeables, key = "c_rw_cherrybomb" }) --
				-- elseif weaponselected == "electricspear" then
				-- 	SMODS.add_card({ set = "obtainweapon", area = G.consumeables, key = "c_rw_spear_ele" }) --
				-- elseif weaponselected == "explosivespear" then
				-- 	SMODS.add_card({ set = "obtainweapon", area = G.consumeables, key = "c_rw_spear_exp" }) --
				-- elseif weaponselected == "firespear" then
				-- 	SMODS.add_card({ set = "obtainweapon", area = G.consumeables, key = "c_rw_spear_fire" }) --
				-- elseif weaponselected == "flashbang" then
				-- 	SMODS.add_card({ set = "obtainweapon", area = G.consumeables, key = "c_rw_flashbang" }) --
				-- elseif weaponselected == "grenade" then
				-- 	SMODS.add_card({ set = "obtainweapon", area = G.consumeables, key = "c_rw_grenade" }) --
				-- elseif weaponselected == "jokerifle" then
				-- 	SMODS.add_card({ set = "obtainweapon", area = G.consumeables, key = "c_rw_jokerifle" }) --
				-- elseif weaponselected == "rock" then
				-- 	SMODS.add_card({ set = "obtainweapon", area = G.consumeables, key = "c_rw_rock" }) --
				-- elseif weaponselected == "singularity" then
				-- 	SMODS.add_card({ set = "obtainweapon", area = G.consumeables, key = "c_rw_singularity" }) --
				-- elseif weaponselected == "spear" then
				-- 	SMODS.add_card({ set = "obtainweapon", area = G.consumeables, key = "c_rw_spear" }) --
				-- elseif weaponselected == "sporepuff" then
				-- 	SMODS.add_card({ set = "obtainweapon", area = G.consumeables, key = "c_rw_sporepuff" }) --
				-- end
				SMODS.add_card {set = "obtainweapon", area = G.consumeables, key = "c_rw_" .. weaponselected}
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
	pos = { x = 0, y = 0 },
	calculate = function(self, card, context)
	if context.skip_blind then
	local tags = { "tag_uncommon", "tag_rare", "tag_negative", "tag_foil", "tag_holographic", "tag_polychrome", "tag_investment", "tag_voucher", "tag_boss", "tag_standard", "tag_charm", "tag_meteor", "tag_buffoon", "tag_handy", "tag_garbage", "tag_ethereal", "tag_coupon", "tag_double", "tag_juggle", "tag_d6", "tag_topup", "tag_speed", "tag_orbital", "tag_economy", "tag_rw_survivalist", "tag_rw_top_pup", "tag_rw_danger", "tag_rw_escape", "tag_rw_rivulet", "tag_rw_power", "tag_rw_quickequip", "tag_rw_feast", "tag_rw_healthy" }
	local chosen_tag = pseudorandom_element(tags, "rw_tags")
	add_tag(Tag(chosen_tag))
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
	pos = { x = 0, y = 0 },
	requires = { "v_rw_relay" },
	calculate = function(self, card, context)
	if context.skip_blind then
	local tags = { "tag_uncommon", "tag_rare", "tag_negative", "tag_foil", "tag_holographic", "tag_polychrome", "tag_investment", "tag_voucher", "tag_boss", "tag_standard", "tag_charm", "tag_meteor", "tag_buffoon", "tag_handy", "tag_garbage", "tag_ethereal", "tag_coupon", "tag_double", "tag_juggle", "tag_d6", "tag_topup", "tag_speed", "tag_orbital", "tag_economy", "tag_rw_survivalist", "tag_rw_top_pup", "tag_rw_danger", "tag_rw_escape", "tag_rw_rivulet", "tag_rw_power", "tag_rw_quickequip", "tag_rw_feast", "tag_rw_healthy" }
	local chosen_tag = pseudorandom_element(tags, "rw_tags")
	add_tag(Tag(chosen_tag))
	end
	end
})
