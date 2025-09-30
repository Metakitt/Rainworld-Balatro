assert(SMODS.load_file("./lib.lua"))()
assert(SMODS.load_file("./modules/atlas.lua"))()
assert(SMODS.load_file("./modules/foods.lua"))()
assert(SMODS.load_file("./modules/jokers.lua"))()
assert(SMODS.load_file("./modules/challenges.lua"))()
assert(SMODS.load_file("./modules/booster.lua"))()
assert(SMODS.load_file("./modules/deck.lua"))()
assert(SMODS.load_file("./modules/food_rarities.lua"))()
assert(SMODS.load_file("./modules/weapons.lua"))()
assert(SMODS.load_file("./modules/vouchers.lua"))()
assert(SMODS.load_file("./modules/blinds.lua"))()
assert(SMODS.load_file("./modules/enemies.lua"))()
assert(SMODS.load_file("./modules/enhancement.lua"))()
assert(SMODS.load_file("./modules/stickers.lua"))()
assert(SMODS.load_file("./modules/tags.lua"))()
--assert(SMODS.load_file("./modules/debug.lua"))()

--Debug allows for the use of the Rot fruit for testing rot! Wet fruit as well for wet cards!

local wet_keys = {
	"j_splash",
	"j_seltzer",
	"j_dietcola",
	"j_rw_rivulet",
	"j_rw_stupid_wet_rat"
}

SMODS.Sound({
	key = "crunch",
	path = {
		["default"] = "crunch.mp3",
	},
})

local game_igo = Game.init_game_object
function Game:init_game_object()
	local ret = game_igo(self)
	ret.rottedjoker = 5
	ret.mirosbird = 1
	ret.mirosvulture = 1
	ret.rw_enemies_slain = 0
	return ret
end

function generate_enemy()
local enemy_type_list = {"Score", "Sell", "Use", "Win", "Reroll", "Special"}
local chosen_requirement = "None"
enemy_type = pseudorandom_element(enemy_type_list,pseudoseed("type"))
amount = SCUG.number_in_range(1, 5, "lots")
condition_type = 0
bonus_condition = "e_base" --currently set to default

if enemy_type == "Score" then
local condition_type_list = {"HandType", "ChipAmount", "CardExtraChips", "CardWeapon", "CardEditionEnhancement"}
condition_type = pseudorandom_element(condition_type_list,pseudoseed("type"))
elseif enemy_type == "Sell" then
local condition_type_list = {"SellJoker", "SellConsumable"}
condition_type = pseudorandom_element(condition_type_list,pseudoseed("type"))
elseif enemy_type == "Use" then
condition_type = "Use"
elseif enemy_type == "Win" then
local condition_type_list = {"Blind", "BossBlind", "BlindThreshold", "%BlindChips"}
condition_type = pseudorandom_element(condition_type_list,pseudoseed("type"))
elseif enemy_type == "Reroll" then
condition_type = "Reroll"
elseif enemy_type == "Special" then
local condition_type_list = {"GrenadeMult"}
condition_type = pseudorandom_element(condition_type_list,pseudoseed("type"))
end

if condition_type == "HandType" then
local hand_list = {"High Card", "Flush"}
chosen_requirement = pseudorandom_element(hand_list,pseudoseed("type"))
condition_req = chosen_requirement
elseif condition_type == "ChipAmount" then
chosen_requirement = SCUG.number_in_range(500,1000, "chip_amount")
condition_req = chosen_requirement
elseif condition_type == "SellJoker" then
local enhanced_check = SCUG.number_in_range(1,20, "ough")
local editiontype = {"e_holo", "e_foil", "e_polychrome", "e_negative"}
chosen_requirement = "Joker"
condition_req = chosen_requirement
if enhanced_check == 14 then
chosen_requirement = "Joker"
bonus_condition = pseudorandom_element(editiontype,pseudoseed("type"))
condition_req = chosen_requirement
end
elseif condition_type == "CardExtraChips" then
chosen_requirement = SCUG.number_in_range(1, 20, "chippies")
condition_req = chosen_requirement
elseif condition_type == "CardWeapon" then
local weapontypes = {"rw_wbeehive", "rw_wcherrybomb", "rw_wspear_ele", "rw_wspear_exp",  "rw_wspear_fire", "rw_wflashbang", "rw_wgrenade", "rw_wjokerifle", "rw_wrock", "rw_wsingularity", "rw_wspear", "rw_wsporepuff"}
chosen_requirement = pseudorandom_element(weapontypes, pseudoseed("violence"))
condition_req = chosen_requirement
elseif condition_type == "CardEditionEnhancement" then
local editiontype = {"e_holo", "e_foil", "e_polychrome", "m_bonus", "m_mult", "m_wild", "m_glass", "m_steel", "m_stone", "m_gold", "m_lucky", "m_rw_rotting", "m_rw_wetasscard"}
chosen_requirement = pseudorandom_element(editiontype, pseudoseed("edition"))
condition_req = chosen_requirement
elseif (condition_type == "SellConsumable" or condition_type == "Use") then
local consumable_type = {"Tarot", "Planet", "foods", "obtainweapon"} 
chosen_requirement = pseudorandom_element(consumable_type,pseudoseed("type"))
condition_req = chosen_requirement
elseif condition_type == "Blind" then
condition_req = "DefeatBlind"
elseif condition_type == "BossBlind" then
condition_req = "DefeatBossBlind"
elseif (condition_type == "BlindThreshold" or condition_type == "%BlindChips") then
local thresholds = {1.15, 1.20, 1.25, 1.30, 1.40, 1.50}
chosen_requirement = pseudorandom_element(thresholds,pseudoseed("type"))
condition_req = chosen_requirement
elseif condition_type == "Reroll" then
condition_req = "RerollShop"
elseif condition_type == "GrenadeMult" then
chosen_requirement = SCUG.number_in_range(10, 40, "chippies")
condition_req = chosen_requirement
end
end

--[[
function generate_enemy()

local enemy_type_keys = {"Score", "Sell"}
--local chosen_enemy_type = pseudorandom_element(enemy_type_keys, pseudoseed("typer"))
local enemy_amount = SCUG.number_in_range(1, 5, "enemy_amount")
enemy_type = pseudorandom_element(enemy_type_keys, pseudoseed("typer")) --What type of defeat condition the enemy has (Can be "Score", "Sell", "Win", "Use" or "Reroll")
amount = enemy_amount --How many times the condition must be fulfilled
condition_type = chosen_score_condition -- The name of the specific condition. Each enemy type has its own set of conditions
condition_req = condition -- Specific requirements
bonus_condition = edition_condition--This is for when a card has an extra requirement; like an edition; but the main function has multiple different card types (like jokers + consumables); but only one needs the edition condition
print(enemy_type)
if enemy_type == "Score" and enemy_type ~= "Sell" then
print ("This enemy requires scoring")
local score_condition = {"HandType", "ChipAmount","CardExtraChips","CardWeapon","CardEdition","CardEnhancement"}
chosen_score_condition = pseudorandom_element(score_condition, pseudoseed("score"))
--print(chosen_score_condition)
	if chosen_score_condition == "HandType" then
	local handtypes = {"High Card", "Flush"}
	condition = pseudorandom_element(handtypes, pseudoseed("hands"))
	end
	
	if chosen_score_condition == "ChipAmount" and enemy_type ~= "Sell"  then
	local chipamount = SCUG.number_in_range(500, 1000, "chip_amount")
	condition = chipamount
	end
	
	if chosen_score_condition == "CardExtraChips" and enemy_type ~= "Sell"  then
	local extrachips = SCUG.number_in_range(1, 20, "chippies")
	condition = extrachips
	end
	
	if chosen_score_condition == "CardWeapon" then
	local weapontypes = {"rw_wbeehive", "rw_wcherrybomb", "rw_wspear_ele", "rw_wspear_exp",  "rw_wspear_fire", "rw_wflashbang", "rw_wgrenade", "rw_wjokerifle", "rw_wrock", "rw_wsingularity", "rw_wspear", "rw_wsporepuff"}
	local chosen_weapon = pseudorandom_element(weapontypes, pseudoseed("violence"))
	condition = chosen_weapon --placeholder
	end
	if chosen_score_condition == "CardEditionEnhancement" and enemy_type ~= "Sell"  then
	-- Score a hand with a CardEdition x times.
	local editiontype = {"e_holo", "e_foil", "e_polychrome", "m_bonus", "m_mult", "m_wild", "m_glass", "m_steel", "m_stone", "m_gold", "m_lucky", "m_rw_rotting", "m_rw_wetasscard"}
	local chosen_edition = pseudorandom_element(editiontype, pseudoseed("edition"))
	condition = chosen_edition
	end
	end	
	
    if enemy_type == "Sell" and enemy_type ~= "Score" then -- might have to make chosen_score_condition be SellJoker or SellConsumable for ease
	print ("This enemy requires Selling")
	
	local score_condition = {"SellConsumable","SellJoker"}
	chosen_score_condition = pseudorandom_element(score_condition, pseudoseed("sellme")) --chooses if its a consumable or joker sell condition
	--print(chosen_score_condition)
	
	local enhanced_check = SCUG.number_in_range(1,20, "ough")
	local editiontype = {"e_holo", "e_foil", "e_polychrome", "e_negative"}
	
	
	if chosen_score_condition == "SellJoker" then
	condition = "Joker"
	if enhanced_check == 14 then
	--sell an enhanced joker
	local edition_condition = pseudorandom_element(editiontype, pseudoseed("sellme"))
	else
	edition_condition = "e_base"
	end
	elseif chosen_score_condition == "SellConsumable" and enemy_type ~= "Score" then
	local consumable_type = {"Tarot", "Planet", "Spectral", "foods", "obtainweapon"} 
	condition = nil
	condition = pseudorandom_element(consumable_type, pseudoseed("sellme"))
	end
	end
	end	]]
	
	
	

-- Patches for Game Functions

local end_round_ref = end_round
function end_round()
	end_round_ref()
	for k, x in pairs(G.deck.cards) do
		if x.config.center == G.P_CENTERS.m_rw_wetasscard and not x.debuff then
			local enhanced = {}
			enhanced[#enhanced + 1] = x
			x.ability.countdown_to_dry = x.ability.countdown_to_dry - 1
			--[[Add check here if a joker is wet to increase rather than decrease]]

			--Drying part of function
			local z = {}
			for i = 1, #G.deck.cards do
				if
					G.deck.cards[i].config.center == G.P_CENTERS.m_rw_wetasscard
					and G.deck.cards[i].ability.countdown_to_dry < 1
				then
					z = G.deck.cards[i]
					z:set_ability(G.P_CENTERS.c_base)
					--z.config.center = G.P_CENTERS.c_base
				end
			end
		end
	end

	--For cards in the hand at the end of the round;
	for k, x in pairs(G.hand.cards) do
		if x.config.center == G.P_CENTERS.m_rw_wetasscard and not x.debuff then
			local enhanced = {}
			enhanced[#enhanced + 1] = x
			x.ability.countdown_to_dry = x.ability.countdown_to_dry - 1

			--Drying part of function
			local z = {}
			for i = 1, #G.hand.cards do
				if
					G.hand.cards[i].config.center == G.P_CENTERS.m_rw_wetasscard
					and G.hand.cards[i].ability.countdown_to_dry < 1
				then
					z = G.hand.cards[i]
					z:set_ability(G.P_CENTERS.c_base)
					--z.config.center = G.P_CENTERS.c_base
				end
			end
		end
	end
end

local GF_evaluate_play = G.FUNCS.evaluate_play
function G.FUNCS.evaluate_play(e)
	GF_evaluate_play(e)

	if G.GAME.blind.config.blind.key == "bl_rw_rotblind" and not G.GAME.blind.disabled then
		local rot = {}
		for i = 1, #G.play.cards do
			if G.play.cards[i].config.center ~= G.P_CENTERS.m_rw_rotting then
				rot = G.play.cards[i]
				--SMODS.calculate_effect({message = 'Rotted!'}, rot)
				rot:set_ability(G.P_CENTERS.m_rw_rotting)
				rot:juice_up()
			end
		end
	end
end

local new_roundref = new_round
function new_round()
	new_roundref()
	-- Joke Rifle's random effect
	local cr = SCUG.number_in_range(1, 11, "rw_wjokerifle")
	if cr <= 5 then
		G.GAME.jokerifle =
			pseudorandom_element({ "bluefruit", "rock", "cherrybomb", "none", "pearl" }, pseudoseed("common"))
	elseif cr > 5 and cr <= 9 then
		G.GAME.jokerifle =
			pseudorandom_element({ "beehive", "flashbang", "grenade", "sporepuff" }, pseudoseed("uncommon"))
	elseif cr > 9 then
		G.GAME.jokerifle = "singularity"
	end

	-- This checks for rotting cards and triggers their countdown + destroys the card if its reached the end of its lifespan

	for k, x in pairs(G.deck.cards) do
		if x.config.center == G.P_CENTERS.m_rw_rotting and not x.debuff then
			local enhanced = {}
			enhanced[#enhanced + 1] = x
			x.ability.countdown_to_destruction = x.ability.countdown_to_destruction - 1

			if x.ability.countdown_to_destruction == 0 then
				--Destruction part of function
				local z = {}
				for i = 1, #G.deck.cards do
					if
						G.deck.cards[i].config.center == G.P_CENTERS.m_rw_rotting
						and G.deck.cards[i].ability.countdown_to_destruction < 1
					then
						z = G.deck.cards[i]
						z:start_dissolve()

						--SMODS.calculate_effect({message = localize('k_upgrade_ex')}, artirot)
					end
				end
				--Artificer's check
				if next(SMODS.find_card("j_rw_artificer")) then
					for i = 1, #SMODS.find_card("j_rw_artificer") do
						local artirot = SMODS.find_card("j_rw_artificer")[i]
						artirot.ability.extra.chips = artirot.ability.extra.chips + artirot.ability.extra.bonus_chips
					end
				end
			end

			-- 1 in 5 chance to make another random card a rot card.
			local timeforrot = pseudorandom("rw_rot") < 0.2 -- Also 1 in 5
			if timeforrot then
				local notrot = {}
				for i = 1, #G.deck.cards do
					if
						G.deck.cards[i] ~= card
						and G.deck.cards[i].config.center ~= G.P_CENTERS.m_rw_rotting
						and not G.deck.cards[i].getting_sliced
					then
						notrot[#notrot + 1] = G.deck.cards[i]
					end
				end
				local rotted = #notrot > 0 and pseudorandom_element(notrot, pseudoseed("explode")) or nil
				if #notrot > 0 then
					rotted:set_ability(G.P_CENTERS.m_rw_rotting)
				end
			end
		end
	end

	-- This checks for joker cards to calculate the rot for
	for i = 1, #G.jokers.cards do
		G.jokers.cards[i]:calculate_rotted()
	end
end

--Definitions for Localization
G.C.FOOD = HEX("0736f3")
G.C.WEAPON = HEX("875796")
G.C.ROT = HEX("000070")

local loc_colour_RW = loc_colour
function loc_colour(_c, _default)
	if not G.ARGS.LOC_COLOURS then
		loc_colour_RW()
	end
	G.ARGS.LOC_COLOURS.weapon = G.C.WEAPON
	G.ARGS.LOC_COLOURS.food = G.C.FOOD
	G.ARGS.LOC_COLOURS.rot = G.C.ROT
	return loc_colour_RW(_c, _default)
end
