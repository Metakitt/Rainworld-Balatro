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
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
		if
			G.GAME.last_blind.boss
			and context.end_of_round
			and context.main_eval
			and pseudorandom("weapon") < G.GAME.probabilities.normal / card.ability.extra.odds
		then
			local cr = math.random(1, 11)
			local weaponselected = "none"
			if cr <= 5 then
				weaponselected = pseudorandom_element(
					{ "bluefruit", "spear", "rock", "cherrybomb", "grenade", "pearl" },
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
