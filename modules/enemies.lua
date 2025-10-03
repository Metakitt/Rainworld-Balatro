assert(SMODS.load_file("modules/enemies/greenlizard.lua"))()
assert(SMODS.load_file("modules/enemies/pinklizard.lua"))()
assert(SMODS.load_file("modules/enemies/youngcentipede.lua"))()
assert(SMODS.load_file("modules/enemies/wormgrass.lua"))()
assert(SMODS.load_file("modules/enemies/brotherlonglegs.lua"))()
assert(SMODS.load_file("modules/enemies/redleech.lua"))()
assert(SMODS.load_file("modules/enemies/bluelizard.lua"))()
assert(SMODS.load_file("modules/enemies/coalescipede.lua"))()
assert(SMODS.load_file("modules/enemies/whitelizard.lua"))()
assert(SMODS.load_file("modules/enemies/poleplant.lua"))()
assert(SMODS.load_file("modules/enemies/dropwig.lua"))()
assert(SMODS.load_file("modules/enemies/inspector.lua"))()
assert(SMODS.load_file("modules/enemies/jungleleech.lua"))()
assert(SMODS.load_file("modules/enemies/daddylonglegs.lua"))()
assert(SMODS.load_file("modules/enemies/salamander.lua"))()
assert(SMODS.load_file("modules/enemies/monsterkelp.lua"))()
assert(SMODS.load_file("modules/enemies/yellowlizard.lua"))()
assert(SMODS.load_file("modules/enemies/aquapede.lua"))()
assert(SMODS.load_file("modules/enemies/centiwing.lua"))()
assert(SMODS.load_file("modules/enemies/cyanlizard.lua"))()
assert(SMODS.load_file("modules/enemies/sealeech.lua"))()
assert(SMODS.load_file("modules/enemies/bigspider.lua"))()
assert(SMODS.load_file("modules/enemies/spitterspider.lua"))()
assert(SMODS.load_file("modules/enemies/motherspider.lua"))()
assert(SMODS.load_file("modules/enemies/eellizard.lua"))()
assert(SMODS.load_file("modules/enemies/blacklizard.lua"))()
assert(SMODS.load_file("modules/enemies/strawberrylizard.lua"))()
assert(SMODS.load_file("modules/enemies/caramellizard.lua"))()
assert(SMODS.load_file("modules/enemies/vulture.lua"))()
assert(SMODS.load_file("modules/enemies/kingvulture.lua"))()
assert(SMODS.load_file("modules/enemies/blackholelizard.lua"))()
assert(SMODS.load_file("modules/enemies/giantjellyfish.lua"))()
assert(SMODS.load_file("modules/enemies/stowaway.lua"))()
assert(SMODS.load_file("modules/enemies/redlizard.lua"))()
assert(SMODS.load_file("modules/enemies/maturecentipede.lua"))()
assert(SMODS.load_file("modules/enemies/overgrowncentipede.lua"))()
assert(SMODS.load_file("modules/enemies/jokelizard.lua"))()
assert(SMODS.load_file("modules/enemies/mirosbird.lua"))()
assert(SMODS.load_file("modules/enemies/motherlonglegs.lua"))()
assert(SMODS.load_file("modules/enemies/hunterlonglegs.lua"))()
assert(SMODS.load_file("modules/enemies/mirosvulture.lua"))()
assert(SMODS.load_file("modules/enemies/firebug.lua"))()
assert(SMODS.load_file("modules/enemies/trainlizard.lua"))()
assert(SMODS.load_file("modules/enemies/leviathan.lua"))()
assert(SMODS.load_file("modules/enemies/redcentipede.lua"))()
assert(SMODS.load_file("modules/enemies/chieftain.lua"))()
assert(SMODS.load_file("modules/enemies/testenemy.lua"))()

--[[
Enemy general format:
Spawn Antes: Antes the enemy can spawn in.
Threat: What the enemy does to disadvantage the player in any way. This can be any kind of condition, as long as it provides an obstacle.
Defeat Condition: What the player must do to defeat (destroy) the enemy. When an enemy is defeated, its 'defeat' ability becomes "True".
Undefeated: What happens when the enemy is left undefeated at the end of boss blind. This triggers everytime the enemy is dragged through a Boss Blind.

Boss Enemies are enemies that can only spawn either on a) boss blinds or b) in the final blind, any strong enemy with no defeat condition.
They remain until the end, if you play endless, they remove themselves.

Some general ideas or notes:
= Undefeated condition loop must ALWAYS include the "defeat" ability as false; as to prevent it from triggering if the enemy is defeated during the end of a boss blind. [Done on current set]
= All enemies must have the following:
  - No blueprint, perishable or any weapon compat. [Done on current set]
  - not context.blueprint on all statements.  [Done on current set]
= Maybe on the lower stakes; Enemies are destroyed after their undefeated condition triggers.
= Similarly, lower stakes reduce enemy spawn rate and higher stakes boosts it.
= An enemy that doubles other enemies' Undefeated conditions.
= Jokers that interact with enemies;
  - For each enemy defeated, gain (something). (Survival of the Fittest) (Slugcat standing proudly with a spear in the air over a dead creature)
  - For each enemy present, gain (something). (Threat) (Many creatures forming a pattern over the card)
  - For each enemy spawned this run, gain (something). (Ecoboost) (A Slugcat hiding behind an obstacle/pipe with a whole ecosystem behind)
  - If there are more enemies than jokers do something. (Surrounded) (Maybe a slugcat by itself surrounded by lizards?)
  - If there are more jokers than enemies do something. (Family Power) (Four slugcats surrounding a strong enemy)


Ante 1 enemies (Count:6):
= Green Lizard [ X ] (Also appears in 2, 3, 4)
= Pink Lizard [ X ] (Also appears in 2, 3, 4)
= Young Centipede [ X ] (Also appears in 2, 3)
= Worm Grass [ X ] (Also appears in 2, 3, 4, 5,)
= Brother Long Legs [ X ] (Also appears in 2, 3, 4)
= Red Leech [ X ] (Also appears in 2)

Ante 2 enemies(Count:10):
= Blue Lizard [ X ] (Also appears in 3)
= Coalescipede [ X ] (Also appears in 3, 4, 6)
= Inspectors [ X ] (Also appears in 3)
= Jungle Leech [ X ] (Also appears in 3, 4)

Ante 3 enemies(Count:15):
= White Lizard [ X ] (Also appears in 4, 5)
= Pole Plant [ X ] (Appears from 3 onwards)
= Cyan Lizard [ X ] (Also appears in 4, 5)
= Dropwig [ X ] (Also appears in 4)
= Big Spider [ X ] (Also appears in 6)
= Sea Leech [ X ] (Appears 3,6,7)

Ante 4 enemies(Count:15):
= Monster Kelp [ X ] (Also appears in 5)
= Salamander [ X ] (Also appears in 5)
= Eel Lizard [ X ] (Also appears in 5)
= Caramel Lizard [ X ] (Exclusive to Ante 4)
= Spitter Spider [ X ] (Also appears in 6)
= Giant Jellyfish [ X ] (Also appears in 5,7,8)

Ante 5 enemies(Count:15):
= Yellow Lizard [ X ] (Appears from 5 onwards)
= Black Lizard [ X ] (Appears from 5 onwards)
= Vulture [ X ] (Appears from 5 onwards)
= Mature Centipede [ X ] (Exclusive to Ante 5)
= Overgrown Centipede [ X ] (Exclusive to Ante 5)
= Daddy Long Legs [ X ] (Appears from 5 onwards)
= King Vulture [ X ] (Appears from 5 onwards)


Ante 6 enemies(Count:15):
= Strawberry Lizard [ X ] (Exclusive to Ante 6)
= Centiwing [ X ] (Also appears in 7)
= Miros Bird [ ] (Also appears in 7)
= Mother Long Legs [ ] (Appears from 6 onwards)
= Hunter Long Legs [ ] (Exclusive to Ante 6)
= Stowaway [ X ] (Also appears in 7)

Ante 7 enemies(Count:15):
= Red Lizard [ X ] (Also appears in 8)
= Mother Spider [ X ] (Exclusive to Ante 7)
= Aquapede [ X ] (Exclusive to Ante 7)
= Miros Vulture [ ] (Also appears in 8)
= Firebugs [ ] (Exclusive to Ante 7)

Ante 8 enemies(Count:13):
= Train Lizard [ ] (Exclusive to Ante 8)
= Leviathan [ ] (Exclusive to Ante 8)
= Red Centipede [ ] (Exclusive to Ante 8)
= Chieftain [ ] (Exclusive to Ante 8)

Ante 1 and 2 have a 1 in 10 chance to roll an enemy on each blind.
Ante 3 through 5 have a 1 in 8 chance to roll an enemy on each blind.
Ante 6 and 7 have a 1 in 4 chance to roll an enemy on each blind.
Ante 8 has a 1 in 3 chance to roll an enemy on each blind.
The exception is for the Red centipede, Train Lizard and Leviathan, which can only be rolled on the Boss Blind AND only have a 1 in 6 chance to roll.
--]]

-- TODO: Test what decreasing by 1 each ante does.
-- Leads to same initial and end values (10 for Ante 1, 3 for Ante 8)
local ENEMY_SPAWN_DENOMINATORS = {
	10,
	10,
	8,
	8,
	8,
	4,
	4,
	3,
}
ENEMY_SPAWN_DENOMINATORS[0] = 10 -- Ante 0- spawn chance
ENEMY_SPAWN_DENOMINATORS[9] = 5 -- Ante 9+ spawn chance

-- Full list per ante:
-- This is a table of tables. First index is what ante, second index is what the picked value is.
-- Returns the card's key.
-- TODO: There should maybe be some Ante 0 table. Just in case
local ENEMY_ANTE_TABLES = {

	--[[Ante 1
Green Lizard (5/20 or 1/4) (25%)
Pink Lizard  (5/20 or 1/4) (25%)
Young Centipede (3/20 or 1.5/10) (15%)
Worm Grass (3/20 or 1.5/10) (15%)
Brother Long Legs (1/20 or 0.5/10) (5%)
Red Leech (3/20 or 1.5/10) (15%)
If there are 20 numbers to pick for:
1: Brother Long Legs
2,3,4,5,6: Green Lizard
7,8,9,10,11: Pink Lizard
12,13,14:Young Centipede
15,16,17 Wormgrass
18,19,20 Red Leech
]]

	{
		"j_rw_brotherlonglegs",
		"j_rw_greenlizard",
		"j_rw_greenlizard",
		"j_rw_greenlizard",
		"j_rw_greenlizard",
		"j_rw_greenlizard",
		"j_rw_pinklizard",
		"j_rw_pinklizard",
		"j_rw_pinklizard",
		"j_rw_pinklizard",
		"j_rw_pinklizard",
		"j_rw_youngcentipede",
		"j_rw_youngcentipede",
		"j_rw_youngcentipede",
		"j_rw_wormgrass",
		"j_rw_wormgrass",
		"j_rw_wormgrass",
		"j_rw_redleech",
		"j_rw_redleech",
		"j_rw_redleech",
	},

	--[[Ante 2
Green Lizard
Pink Lizard
Young Centipede
Worm Grass
Brother Long Legs
Red Leech
Blue Lizard
Coalescipede
Inspectors
Jungle Leech
1,2,3: Blue Lizard
4,5,6: Inspectors
7,8,9: Coalescipede
10,11,12: Jungle Leech
13,14: Red Leech
15,16: Worm Grass
17: Green Lizard
18: Pink Lizard
19: Young Centipede
20: Brother Long Legs
]]

	{
		"j_rw_bluelizard",
		"j_rw_bluelizard",
		"j_rw_bluelizard",
		"j_rw_inspector",
		"j_rw_inspector",
		"j_rw_inspector",
		"j_rw_coalescipede",
		"j_rw_coalescipede",
		"j_rw_coalescipede",
		"j_rw_jungleleech",
		"j_rw_jungleleech",
		"j_rw_jungleleech",
		"j_rw_redleech",
		"j_rw_redleech",
		"j_rw_wormgrass",
		"j_rw_wormgrass",
		"j_rw_greenlizard",
		"j_rw_pinklizard",
		"j_rw_youngcentipede",
		"j_rw_brotherlonglegs",
	},

	--[[Ante 3
Green Lizard
Pink Lizard
Young Centipede
Worm Grass
Brother Long Legs
Blue Lizard
Coalescipede
Inspectors
Jungle Leech
White Lizard
Pole Plant
Cyan Lizard
Dropgwig
Big Spider
Sea Leech
(on 30) Maybe instead it can be on 20(?)
1: Green Lizard
2: Pink Lizard
3: Young Centipede
4: Worm Grass
5: Brother Long Legs
6: Coalescipede
7: Inspectors
8: Jungle Leech
9,10: White Lizard
11,12: Pole Plant
13,14: Cyan Lizard
15,16: Dropwig
17,18: Big Spider
19,20: Sea Leech
]]

	{
		"j_rw_greenlizard",
		"j_rw_pinklizard",
		"j_rw_youngcentipede",
		"j_rw_wormgrass",
		"j_rw_brotherlonglegs",
		"j_rw_coalescipede",
		"j_rw_inspector",
		"j_rw_jungleleech",
		"j_rw_poleplant",
		"j_rw_poleplant",
		"j_rw_cyanlizard",
		"j_rw_cyanlizard",
		"j_rw_dropwig",
		"j_rw_dropwig",
		"j_rw_bigspider",
		"j_rw_bigspider",
		"j_rw_sealeech",
		"j_rw_sealeech",
	},

	--[[Ante 4
Green Lizard
Pink Lizard
Worm Grass
Brother Long Legs
Coalescipede
Jungle Leech
White Lizard
Pole Plant
Cyan Lizard
Dropwig
Monster Kelp
Salamander
Eel Lizard
Caramel Lizard
Spitter Spider
Giant Jellyfish
On 20:
1: Green Lizard or Pink Lizard (50/50)
2: Worm Grass or Monster Kelp (50/50)
3,4: Brother Long Legs
5,6: Coalescipede
7,8: Jungle Leech
9,10: White Lizard
11: Pole Plant
12,13: Cyan Lizard
14,15: Dropwig
16: Salamander
17: Eel Lizard
18: Caramel Lizard
19: Spitter Spider
20: Giant Jellyfish
]]

	{
		{ "j_rw_greenlizard", "j_rw_pinklizard" },
		{ "j_rw_wormgrass", "j_rw_monsterkelp" },
		"j_rw_brotherlonglegs",
		"j_rw_brotherlonglegs",
		"j_rw_coalescipede",
		"j_rw_coalescipede",
		"j_rw_jungleleech",
		"j_rw_jungleleech",
		"j_rw_whitelizard",
		"j_rw_whitelizard",
		"j_rw_poleplant",
		"j_rw_cyanlizard",
		"j_rw_cyanlizard",
		"j_rw_dropwig",
		"j_rw_dropwig",
		"j_rw_salamander",
		"j_rw_eellizard",
		"j_rw_caramellizard",
		"j_rw_spitterspider",
		"j_rw_giantjellyfish",
	},

	--[[Ante 5
Worm Grass
White Lizard
Pole Plant
Cyan Lizard
Monster Kelp
Salamander
Eel Lizard
Giant Jellyfish
Yellow Lizard
Black Lizard
Vulture
Mature Centipede
Overgrown Centipede
Daddy Long Legs
King Vulture
On 20:
1: Worm Grass
2,3: White Lizard
4,5: Pole Plant
6: Cyan Lizard
7: Monster Kelp
8,9:Salamander
10,11:Eel Lizard
12,13: Giant Jellyfish
14: Yellow Lizard
15: Black Lizard
16,17: Vulture
18: Mature Centipede / Overgrown Centipede (50/50)
19: Daddy Long Legs
20: King Vulture
]]
	{
		"j_rw_wormgrass",
		"j_rw_whitelizard",
		"j_rw_whitelizard",
		"j_rw_poleplant",
		"j_rw_poleplant",
		"j_rw_cyanlizard",
		"j_rw_monsterkelp",
		"j_rw_salamander",
		"j_rw_salamander",
		"j_rw_eellizard",
		"j_rw_eellizard",
		"j_rw_giantjellyfish",
		"j_rw_giantjellyfish",
		"j_rw_yellowlizard",
		"j_rw_blacklizard",
		"j_rw_vulture",
		"j_rw_vulture",
		{ "j_rw_maturecentipede", "j_rw_overgrowncentipede" },
		"j_rw_daddylonglegs",
		"j_rw_kingvulture",
	},

	--[[Ante 6
Coalescipede
Pole Plant
Big Spider
Sea Leech
Spitter Spider
Yellow Lizard
Black Lizard
Vulture
Daddy Long Legs
King Vulture
Strawberry Lizard
Centiwing
Miros Bird
Mother Long Legs
Hunter Long Legs
Stowaway
(On 20)
1,2: Coalescipede
3,4: Pole Plant
5: Big Spider
6,7: Sea Leech
8: Spitter Spider
9,10:Yellow Lizard
11,12: Black Lizard
13: Vulture
14,15: Strawberry Lizard
16: Centiwing
17: Miros Bird
18: Mother Long Legs
19: Hunter Long Legs
20: Stowaway
]]

	{
		"j_rw_coalescipede",
		"j_rw_coalescipede",
		"j_rw_poleplant",
		"j_rw_poleplant",
		"j_rw_bigspider",
		"j_rw_sealeech",
		"j_rw_sealeech",
		"j_rw_spitterspider",
		"j_rw_yellowlizard",
		"j_rw_yellowlizard",
		"j_rw_blacklizard",
		"j_rw_blacklizard",
		"j_rw_vulture",
		"j_rw_strawberrylizard",
		"j_rw_strawberrylizard",
		"j_rw_centiwing",
		"j_rw_mirosbird",
		"j_rw_motherlonglegs",
		"j_rw_hunterlonglegs",
		"j_rw_stowaway",
	},

	--[[Ante 7
Pole Plant
Sea Leech
Giant Jellyfish
Yellow Lizard
Black Lizard
Vulture
Daddy Long Legs
King Vulture
Centiwing
Miros Bird
Mother Long Legs
Stowaway
Red Lizard
Mother Spider
Aquapede
Miros Vulture
Firebugs
(On 20)
1,2: Pole Plant
3,4: Sea Leech
5,6: Giant Jellyfish
7: Yellow Lizard
8: Black Lizard
9: Vulture 
10,11: Daddy Long Legs
12: King Vulture / Miros Vulture 50/50
13: Centiwing
14: Miros Bird 
15: Mother Long Legs
16: Stowaway
17: Red Lizard
18: Mother Spider
19: Aquapede
20: Firebug
]]

	{
		"j_rw_poleplant",
		"j_rw_poleplant",
		"j_rw_sealeech",
		"j_rw_sealeech",
		"j_rw_giantjellyfish",
		"j_rw_giantjellyfish",
		"j_rw_yellowlizard",
		"j_rw_blacklizard",
		"j_rw_vulture",
		"j_rw_daddylonglegs",
		"j_rw_daddylonglegs",
		{ "j_rw_kingvulture", "j_rw_mirosvulture" },
		"j_rw_centiwing",
		"j_rw_mirosbird",
		"j_rw_motherlonglegs",
		"j_rw_stowaway",
		"j_rw_redlizard",
		"j_rw_motherspider",
		"j_rw_aquapede",
		"j_rw_firebug",
	},

	--[[Ante 8
Pole Plant
Giant Jellyfish
Yellow Lizard
Black Lizard
Vulture
Daddy Long Legs
King Vulture
Mother Long Legs
Red Lizard
Miros Vulture
Train Lizard
Leviathan
Red Centipede
Chieftain
1: Pole Plant
2,3: Giant Jellyfish
4: Yellow Lizard
5: Black Lizard
6,7,8: Vulture
9,10: Daddy Long Legs
11,12: King Vulture
13,14: Mother Long Legs
15: Red Lizard
16: Miros Vulture
17: Train Lizard
18: Leviathan
19: Red Centipede
20: Chieftain
]]

	{
		"j_rw_poleplant",
		"j_rw_giantjellyfish",
		"j_rw_giantjellyfish",
		"j_rw_yellowlizard",
		"j_rw_blacklizard",
		"j_rw_vulture",
		"j_rw_vulture",
		"j_rw_vulture",
		"j_rw_daddylonglegs",
		"j_rw_daddylonglegs",
		"j_rw_kingvulture",
		"j_rw_kingvulture",
		"j_rw_motherlonglegs",
		"j_rw_motherlonglegs",
		"j_rw_redlizard",
		"j_rw_mirosvulture",
		"j_rw_trainlizard",
		"j_rw_leviathan",
		"j_rw_redcentipede",
		"j_rw_chieftain",
	},
}

local endless_table = {}
for _, ante_table in pairs(ENEMY_ANTE_TABLES) do
	for _, key in pairs(ante_table) do
		if type(key) == "string" then
			if not SCUG.in_table(key, endless_table) then
				endless_table[#endless_table + 1] = key
			end
		elseif type(key) == "table" then
			for _, real_key in pairs(key) do
				if not SCUG.in_table(real_key, endless_table) then
					endless_table[#endless_table + 1] = real_key
				end
			end
		end
	end
end
ENEMY_ANTE_TABLES[9] = endless_table

SCUG.spawn_enemy = function(args)
	args = args or {}
	local _ante = args.ante or G.GAME.round_resets.ante
	local ante_num = SCUG.clamp(_ante, 1, 9)
	-- Enemy Selection
	-- This checks if an enemy spawns or not.
	if args.guarantee or pseudorandom("rw_spawn_enemy") < 1 / ENEMY_SPAWN_DENOMINATORS[ante_num] then
		sendDebugMessage("Spawning an enemy!", "Rainworld")
		local valid_selection = false
		local enemy_key = "j_rw_greenlizard" -- Fallback value
		if not args.enemy_key then
			local enemy_pool = ENEMY_ANTE_TABLES[ante_num]
			local enemy_choice = SCUG.number_in_range(1, #enemy_pool, "rw_enemy_selection")
			repeat
				local _enemy = enemy_pool[enemy_choice]
				if type(_enemy) == "table" then
					enemy_key = _enemy[SCUG.number_in_range(1, #_enemy, "rw_enemy_selection")]
				elseif type(_enemy) == "string" then
					enemy_key = _enemy
				end

				-- If this enemy exists, use it
				if G.P_CENTERS[enemy_key] then
					valid_selection = true
					-- Otherwise, use one lower on the list (more likely to exist, probably)
				else
					sendWarnMessage("Enemy " .. enemy_key .. " not enabled!", "Rainworld")
					enemy_choice = enemy_choice - 1
				end

				-- If we can't find one, break the loop and use the fallback
				if enemy_choice < 1 then
					sendErrorMessage(
						"Couldn't find a suitable enemy for Ante "
							.. _ante
							.. "! Falling back to "
							.. enemy_key
							.. "...",
						"Rainworld"
					)
					break
				end
			until valid_selection
		else
			enemy_key = args.enemy_key
		end
		-- Here's your awful prize
		sendDebugMessage("Chose " .. ((not string.find(enemy_key, "^j_")) and G.P_CENTERS[enemy_key].name or localize({
			type = "name_text",
			set = "Joker",
			key = enemy_key,
		})) .. "!", "Rainworld")
		SMODS.add_card({ set = "Joker", area = G.jokers, key = enemy_key, no_edition = true })
	end
end

function SCUG.generate_enemy()
	local ret = {}
	-- Choose requirement
	local enemy_type_list = { "Score", "Sell", "Use", "Win", "Reroll", "Special" }
	ret.enemy_type = pseudorandom_element(enemy_type_list, pseudoseed("type"))
	ret.amount = SCUG.number_in_range(1, 5, "lots")

	-- Choose subtype
	local subtypes = {
		["Score"] = { "HandType", "ChipAmount", "CardExtraChips", "CardWeapon", "CardEditionEnhancement" },
		["Sell"] = { "SellJoker", "SellConsumable" },
		["Win"] = { "Blind", "BossBlind", "BlindThreshold", "%BlindChips" },
		["Special"] = { "GrenadeMult" },
	}
	ret.condition = (subtypes[ret.enemy_type] and pseudorandom_element(subtypes[ret.enemy_type], pseudoseed("type")))
		or ret.enemy_type

	-- Flesh out requirements
	local chosen_requirement
	if ret.condition == "HandType" then
		local hand_list = { "High Card", "Flush" }
		ret.requirement = pseudorandom_element(hand_list, pseudoseed("type"))
	elseif ret.condition == "ChipAmount" then
		-- TODO: Make this scale with ante?
		ret.requirement = 500 + 25 * SCUG.number_in_range(1, 20, "chip_amount")
	elseif ret.condition == "SellJoker" then
		local enhanced_check = SCUG.number_in_range(1, 20, "ough")
		local editiontype = { "e_holo", "e_foil", "e_polychrome", "e_negative" }
		chosen_requirement = "Joker"
		ret.requirement = chosen_requirement
		if enhanced_check == 14 then
			ret.edition_condition = pseudorandom_element(editiontype, pseudoseed("type"))
		end
	elseif ret.condition == "CardExtraChips" then
		chosen_requirement = SCUG.number_in_range(1, 20, "chippies")
		ret.requirement = chosen_requirement
	elseif ret.condition == "CardWeapon" then
		local weapontypes = {
			"rw_wbeehive",
			"rw_wcherrybomb",
			"rw_wspear_ele",
			"rw_wspear_exp",
			"rw_wspear_fire",
			"rw_wflashbang",
			"rw_wgrenade",
			"rw_wjokerifle",
			"rw_wrock",
			"rw_wsingularity",
			"rw_wspear",
			"rw_wsporepuff",
		}
		chosen_requirement = pseudorandom_element(weapontypes, pseudoseed("violence"))
		ret.requirement = chosen_requirement
	elseif ret.condition == "CardEditionEnhancement" then
		local editiontype = {
			"e_holo",
			"e_foil",
			"e_polychrome",
			"m_bonus",
			"m_mult",
			"m_wild",
			"m_glass",
			"m_steel",
			"m_stone",
			"m_gold",
			"m_lucky",
			"m_rw_rotting",
			"m_rw_wetasscard",
		}
		chosen_requirement = pseudorandom_element(editiontype, pseudoseed("edition"))
		ret.requirement = chosen_requirement
	elseif ret.condition == "SellConsumable" or ret.condition == "Use" then
		local consumable_type = { "Tarot", "Planet", "foods", "obtainweapon" }
		chosen_requirement = pseudorandom_element(consumable_type, pseudoseed("type"))
		ret.requirement = chosen_requirement
	elseif ret.condition == "Blind" then
		ret.requirement = "DefeatBlind"
	elseif ret.condition == "BossBlind" then
		ret.requirement = "DefeatBossBlind"
	elseif ret.condition == "BlindThreshold" or ret.condition == "%BlindChips" then
		local thresholds = { 1.15, 1.20, 1.25, 1.30, 1.40, 1.50 }
		chosen_requirement = pseudorandom_element(thresholds, pseudoseed("type"))
		ret.requirement = chosen_requirement
	elseif ret.condition == "Reroll" then
		ret.requirement = "RerollShop"
	elseif ret.condition == "GrenadeMult" then
		chosen_requirement = SCUG.number_in_range(10, 40, "chippies")
		ret.requirement = chosen_requirement
	end

	print(ret)
	return ret
end

---Returns how much the enemy's countdown should tick down by.
---@param context table The context given.
---@param conditions table The enemy's conditions.
---@return number
SCUG.enemy_should_count_down = function(context, conditions)
	if not conditions then
		return 0
	end
	if
		context.joker_main
		and conditions.enemy_type == "Special"
		and conditions.condition == "GrenadeMult"
		and not context.blueprint
	then
		local num_matches = 0
		for i = 1, #G.jokers.cards do
			if
				G.jokers.cards[i].ability.rw_wgrenade
				and G.GAME.grenademult >= conditions.requirement
				and not context.blueprint
			then
				num_matches = num_matches + 1
			end
		end
		return num_matches
	end

	if context.before and conditions.enemy_type == "Score" then
		if conditions.condition == "HandType" then
			if
				next(context.poker_hands[conditions.requirement])
				and context.scoring_name == conditions.requirement
				and not context.blueprint
			then
				return 1
			end
		elseif conditions.condition == "CardExtraChips" then
			local num_matches = 0
			for i = 1, #G.play.cards do
				if G.play.cards[i].ability.perma_bonus >= conditions.requirement and not context.blueprint then
					num_matches = num_matches + 1
				end
			end
			return num_matches
		elseif conditions.condition == "CardWeapon" then
			local num_matches = 0
			for _, v in pairs(G.jokers.cards) do
				for k, _ in pairs(v.ability) do
					st, nd = string.find(k, conditions.requirement)
					if st and nd then
						num_matches = num_matches + 1
					end
				end
			end
			return num_matches
		elseif conditions.condition == "CardEditionEnhancement" then
			local num_matches = 0
			for _, v in pairs(context.scoring_hand) do
				if v.edition and v.edition.key == conditions.requirement then
					num_matches = num_matches + 1 -- NOTE: Line was empty, this should be here?
				elseif v.config.center_key == conditions.requirement then
					--	if (v.edition.key == conditions.requirement or v.config.center_key == conditions.requirement) then
					num_matches = num_matches + 1
				end
			end
			return num_matches
		end
	end

	if
		context.using_consumeable
		and conditions.enemy_type == "Use"
		and conditions.condition == "Use"
		and context.consumeable.ability.set == conditions.requirement
		and not context.blueprint
	then
		return 1
	end

	if context.selling_card and conditions.enemy_type == "Sell" then
		--print('a')
		if context.card.ability.set == conditions.requirement then
			-- print("is sold")
			if conditions.edition_condition then
				-- print("fulfillsrequirement")
				if context.card.edition and context.card.edition.key == conditions.edition_condition then
					-- print("amountgoesdown")
					return 1
				end
			else
				return 1
			end
		end
	end

	if context.main_eval and context.end_of_round and conditions.enemy_type == "Win" and not context.blueprint then
		-- print("do we get here?")
		if conditions.condition == "%BlindChips" then
			local score_ratio = G.GAME.chips / G.GAME.blind.chips
			if score_ratio >= SCUG.big(conditions.requirement) then
				return 1
			end
		elseif conditions.condition == "BlindThreshold" then
			local score_ratio = G.GAME.chips / G.GAME.blind.chips
			if score_ratio <= SCUG.big(conditions.requirement) then
				return 1
			end
		elseif conditions.condition == "Blind" and conditions.requirement == "DefeatBlind" then
			-- print("should tick?")
			return 1
		end

		if
			G.GAME.blind.boss
			and conditions.condition == "BossBlind"
			and conditions.requirement == "DefeatBossBlind"
		then
			return 1
		end
	end

	if conditions.enemy_type == "Score" and conditions.condition == "ChipAmount" then
		if G.GAME.chips > SCUG.big(conditions.requirement) and not context.blueprint then
			return 1
		end
	end

	if context.reroll_shop and conditions.enemy_type == "Reroll" then
		return 1
	end

	return 0
end

--[[
function generate_enemy()

local enemy_type_keys = {"Score", "Sell"}
--local chosen_enemy_type = pseudorandom_element(enemy_type_keys, pseudoseed("typer"))
local enemy_amount = SCUG.number_in_range(1, 5, "enemy_amount")
enemy_type = pseudorandom_element(enemy_type_keys, pseudoseed("typer")) --What type of defeat condition the enemy has (Can be "Score", "Sell", "Win", "Use" or "Reroll")
amount = enemy_amount --How many times the condition must be fulfilled
condition = chosen_score_condition -- The name of the specific condition. Each enemy type has its own set of conditions
ret.requirement = condition -- Specific requirements
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
end
]]

local new_roundref = new_round
function new_round()
	new_roundref()
	if not G.GAME.challenge_tab then
		SCUG.spawn_enemy()
	end
end
