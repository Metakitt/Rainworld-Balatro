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
--assert(SMODS.load_file("./modules/debug.lua"))()

--Debug allows for the use of the Rot fruit for testing rot! Wet fruit as well for wet cards!

SCUG = SMODS.current_mod
-- Possible Talisman compatibility
SCUG.big = function(x) return (Talisman and to_big(x)) or x end
SCUG.num = function(x) return (Talisman and to_number(x)) or x end

---@param min integer Minimum number that can be picked. Defaults to 1.
---@param max integer Maximum number that can be picked. Defaults to 20.
---@param seed string Pseudorandom seed. Defaults to "Rainworld"
---@return integer
---Returns a random integer between two numbers, including those numbers.
SCUG.number_in_range = function(min, max, seed)
    return math.floor(((max or 20) - (min or 1) + 1) * pseudorandom(seed or "Rainworld")) + min
end

SMODS.Sound {
key = 'crunch',
path = {
 	['default'] = 'crunch.mp3',
	}
}

SMODS.Enhancement{
key = 'rotting',
config = {bonus = -25, countdown_to_destruction = 5}, 
atlas = 'enhancedcards_scug', 
pos = { x = 0, y = 0 },
loc_vars = function(self, info_queue, card)
	return { vars = {card.ability.countdown_to_destruction} }
	end,
weight = 5,
in_pool = function(self,args)
if args and args.source == 'sta' then
return true
else
return false
end
end
}

SMODS.Enhancement{
key = 'wetasscard',
loc_txt = {
        name = 'Wet',
		text = {
		'Wet',
		'#1#',
		}
		},
config = { x_chips = 1.5, countdown_to_dry = 5}, 
atlas = 'enhancedcards_scug', 
pos = { x = 2, y = 0 },
loc_vars = function(self, info_queue, card)
	return { vars = {card.ability.countdown_to_dry} }
	end,
weight = 5,
always_scores = true,
}

-- Patches for Game Functions

local wetcardedit = end_round
function end_round()
wetcardedit()
for k, x in pairs(G.deck.cards) do
if x.config.center == G.P_CENTERS.m_rw_wetasscard and not x.debuff then
 local enhanced = {} 
 enhanced[#enhanced+1] = x
 x.ability.countdown_to_dry =  x.ability.countdown_to_dry -1
 
 --Drying part of function
 local z = {}
 for i = 1, #G.deck.cards do
 if G.deck.cards[i].config.center == G.P_CENTERS.m_rw_wetasscard and G.deck.cards[i].ability.countdown_to_dry < 1 then
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
 enhanced[#enhanced+1] = x
 x.ability.countdown_to_dry =  x.ability.countdown_to_dry -1
 
 --Drying part of function
 local z = {}
 for i = 1, #G.hand.cards do
 if G.hand.cards[i].config.center == G.P_CENTERS.m_rw_wetasscard and G.hand.cards[i].ability.countdown_to_dry < 1 then
 z = G.hand.cards[i]
 z:set_ability(G.P_CENTERS.c_base)
 --z.config.center = G.P_CENTERS.c_base
 
	end
	end
 end
 end

end

local rotting_blind = G.FUNCS.evaluate_play
function G.FUNCS.evaluate_play ()
rotting_blind()

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

-- Enemy Selection

-- This checks if an enemy spawns or not.
local enemy_spawn = pseudorandom("enemyspawn") < 0.2 -- 1 in 5
print(enemy_spawn)

-- It's a 1 in 10 chance so if its a 5, it goes through.
if enemy_spawn then
if G.GAME.round_resets.ante == 1 then
local enemy_roster_ante1 = SCUG.number_in_range(1, 20, "enemychoice" .. G.GAME.round_resets.ante)
print(enemy_roster_ante1)
if enemy_roster_ante1 == 1 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_brotherlonglegs', no_edition = true})
elseif enemy_roster_ante1 >= 2 and enemy_roster_ante1 <= 6 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_greenlizard', no_edition = true})
elseif enemy_roster_ante1 >= 7 and enemy_roster_ante1 <= 11  then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_pinklizard', no_edition = true})
elseif enemy_roster_ante1 >= 12 and enemy_roster_ante1 <= 14  then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_youngcentipede', no_edition = true})
elseif enemy_roster_ante1 >= 15 and enemy_roster_ante1 <= 17  then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_wormgrass', no_edition = true})
elseif enemy_roster_ante1 >= 18 and enemy_roster_ante1 <= 20  then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_redleech', no_edition = true})
end

elseif G.GAME.round_resets.ante == 2 then
--Unimplemented enemies commented out to prevent crashing.
local enemy_roster_ante2 = SCUG.number_in_range(1, 20, "enemychoice" .. G.GAME.round_resets.ante)
if enemy_roster_ante2 >= 1 and enemy_roster_ante2 <= 3  then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_bluelizard', no_edition = true})
elseif enemy_roster_ante2 >= 4 and enemy_roster_ante2 <= 6 then
--SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_inspector', no_edition = true})
elseif enemy_roster_ante2 >= 7 and enemy_roster_ante2 <= 9  then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_coalescipede', no_edition = true})
elseif enemy_roster_ante2 >= 10 and enemy_roster_ante2 <= 12  then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_jungleleech', no_edition = true})
elseif enemy_roster_ante2 >= 13 and enemy_roster_ante2 <= 14  then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_redleech', no_edition = true})
elseif enemy_roster_ante2 >= 15 and enemy_roster_ante2 <= 16  then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_wormgrass', no_edition = true})
elseif enemy_roster_ante2 == 17 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_greenlizard', no_edition = true})
elseif enemy_roster_ante2 == 18 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_pinklizard', no_edition = true})
elseif enemy_roster_ante2 == 19 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_youngcentipede', no_edition = true})
elseif enemy_roster_ante2 == 20 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_brotherlonglegs', no_edition = true})
end

--Starting Ante 3 onwards; It's just a temporary placeholder set just to keep the structure going.
elseif G.GAME.round_resets.ante == 3 then
local enemy_roster_ante3 = SCUG.number_in_range(1, 20, "enemychoice" .. G.GAME.round_resets.ante)
if enemy_roster_ante3 == 1 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_greenlizard', no_edition = true})
elseif enemy_roster_ante3 == 2 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_pinklizard', no_edition = true})
elseif enemy_roster_ante3 == 3 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_youngcentipede', no_edition = true})
elseif enemy_roster_ante3 == 4 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_wormgrass', no_edition = true})
elseif enemy_roster_ante3 == 5 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_brotherlonglegs', no_edition = true})
elseif enemy_roster_ante3 == 6 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_coalescipede', no_edition = true})
--elseif enemy_roster_ante3 == 7 then
--SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_inspector', no_edition = true})
elseif enemy_roster_ante3 == 8 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_jungleleech', no_edition = true})
elseif enemy_roster_ante3 >= 9 and enemy_roster_ante3 <= 10 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_whitelizard', no_edition = true})
elseif enemy_roster_ante3 >= 11 and enemy_roster_ante3 <= 12 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_poleplant', no_edition = true})
--elseif enemy_roster_ante3 >= 13 and enemy_roster_ante3 <= 14 then
--SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_cyanlizard', no_edition = true})
elseif enemy_roster_ante3 >= 15 and enemy_roster_ante3 <= 16 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_dropwig', no_edition = true})
--elseif enemy_roster_ante3 >= 17 and enemy_roster_ante3 <= 18 then
--SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_bigspider', no_edition = true})
--elseif enemy_roster_ante3 >= 19 and enemy_roster_ante3 <= 20 then
--SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_sealeech', no_edition = true})
end

elseif G.GAME.round_resets.ante == 4 then
local enemy_roster_ante4 = SCUG.number_in_range(1, 20, "enemychoice" .. G.GAME.round_resets.ante)
if enemy_roster_ante4 == 1 then

if pseudorandom('lizard') < 0.5 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_greenlizard', no_edition = true})
else
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_pinklizard', no_edition = true})
end

elseif enemy_roster_ante4 == 2 then
if pseudorandom('plant') < 0.5 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_wormgrass', no_edition = true})
else
--SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_monsterkelp', no_edition = true})
end

elseif enemy_roster_ante4 >= 3 and enemy_roster_ante4 <= 4 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_brotherlonglegs', no_edition = true})

elseif enemy_roster_ante4 >= 5 and enemy_roster_ante4 <= 6 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_coalescipede', no_edition = true})

elseif enemy_roster_ante4 >= 7 and enemy_roster_ante4 <= 8 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_jungleleech', no_edition = true})

elseif enemy_roster_ante4 >= 9 and enemy_roster_ante4 <= 10 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_whitelizard', no_edition = true})

elseif enemy_roster_ante4 == 11 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_poleplant', no_edition = true})

--elseif enemy_roster_ante4 >= 12 and enemy_roster_ante4 <= 13 then
--SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_cyanlizard', no_edition = true})

elseif enemy_roster_ante4 >= 14 and enemy_roster_ante4 <= 15 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_dropwig', no_edition = true})

--[[elseif enemy_roster_ante4 == 16 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_salamander', no_edition = true})

elseif enemy_roster_ante4 == 17 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_eellizard', no_edition = true})

elseif enemy_roster_ante4 == 18 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_caramellizard', no_edition = true})

elseif enemy_roster_ante4 == 19 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_spitterspider', no_edition = true})

elseif enemy_roster_ante4 == 20 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_giantjellyfish', no_edition = true})]]

end

elseif G.GAME.round_resets.ante == 5 then
local enemy_roster_ante5 = SCUG.number_in_range(1, 20, "enemychoice" .. G.GAME.round_resets.ante)
if enemy_roster_ante5 == 1 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_wormgrass', no_edition = true})
elseif enemy_roster_ante5 >= 2 and enemy_roster_ante5 <= 3 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_whitelizard', no_edition = true})
elseif enemy_roster_ante5 >= 4 and enemy_roster_ante5 <= 5 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_poleplant', no_edition = true})
--[[elseif enemy_roster_ante5 == 6 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_cyanlizard', no_edition = true})
elseif enemy_roster_ante5 == 7 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_monsterkelp', no_edition = true})
elseif enemy_roster_ante5 >= 8 and enemy_roster_ante5 <= 9 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_salamander', no_edition = true})
elseif enemy_roster_ante5 >= 10 and enemy_roster_ante5 <= 11 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_eellizard', no_edition = true})
elseif enemy_roster_ante5 >= 12 and enemy_roster_ante5 <= 13 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_giantjellyfish', no_edition = true})
elseif enemy_roster_ante5 == 14 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_yellowlizard', no_edition = true})
elseif enemy_roster_ante5 == 15 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_blacklizard', no_edition = true})
elseif enemy_roster_ante5 == 18 then
if pseudorandom('pede') < 0.5 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_maturecentipede', no_edition = true})
else
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_overgrowncentipede', no_edition = true})
end
elseif enemy_roster_ante5 == 19 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_daddylonglegs', no_edition = true})
elseif enemy_roster_ante5 == 20 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_kingvulture', no_edition = true})]]
end

elseif G.GAME.round_resets.ante == 6 then
local enemy_roster_ante6 = SCUG.number_in_range(1, 20, "enemychoice" .. G.GAME.round_resets.ante)
if enemy_roster_ante6 >= 1 and enemy_roster_ante6 <= 2 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_coalescipede', no_edition = true})
elseif enemy_roster_ante6 >= 3 and enemy_roster_ante6 <= 4 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_poleplant', no_edition = true})
--[[elseif enemy_roster_ante6 == 5 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_bigspider', no_edition = true})
elseif enemy_roster_ante6 >= 6 and enemy_roster_ante6 <= 7 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_sealeech', no_edition = true})
elseif enemy_roster_ante6 == 8 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_spitterspider', no_edition = true})
elseif enemy_roster_ante6 >= 9 and enemy_roster_ante6 <= 10 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_yellowlizard', no_edition = true})
elseif enemy_roster_ante6 >= 11 and enemy_roster_ante6 <= 12 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_blacklizard', no_edition = true})
elseif enemy_roster_ante6 == 13 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_vulture', no_edition = true})
elseif enemy_roster_ante6 >= 14 and enemy_roster_ante6 <= 15 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_strawberrylizard', no_edition = true})
elseif enemy_roster_ante6 == 16 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_centiwing', no_edition = true})
elseif enemy_roster_ante6 == 17 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_mirosbird', no_edition = true})
elseif enemy_roster_ante6 == 18 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_motherlonglegs', no_edition = true})
elseif enemy_roster_ante6 == 19 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_hunterlonglegs', no_edition = true})
elseif enemy_roster_ante6 == 20 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_stowaway', no_edition = true})]]
end

elseif G.GAME.round_resets.ante == 7 then
local enemy_roster_ante7 = SCUG.number_in_range(1, 20, "enemychoice" .. G.GAME.round_resets.ante)
if enemy_roster_ante7 >= 1 and enemy_roster_ante7 <= 2 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_poleplant', no_edition = true})
--[[elseif enemy_roster_ante7 >= 3 and enemy_roster_ante7 <= 4 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_sealeech', no_edition = true})
elseif enemy_roster_ante7 >= 5 and enemy_roster_ante7 <= 6 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_giantjellyfish', no_edition = true})
elseif enemy_roster_ante7 == 7 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_yellowlizard', no_edition = true})
elseif enemy_roster_ante7 == 8 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_blacklizard', no_edition = true})
elseif enemy_roster_ante7 == 9 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_vulture', no_edition = true})
elseif enemy_roster_ante7 >= 10 and enemy_roster_ante7 <= 11 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_daddylonglegs', no_edition = true})
elseif enemy_roster_ante7 == 12 then
if pseudorandom('pede') < 0.5 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_kingvulture', no_edition = true})
else
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_mirosvulture', no_edition = true})
end
elseif enemy_roster_ante7 == 13 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_centiwing', no_edition = true})
elseif enemy_roster_ante7 == 14 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_mirosbird', no_edition = true})
elseif enemy_roster_ante7 == 15 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_motherlonglegs', no_edition = true})
elseif enemy_roster_ante7 == 16 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_stowaway', no_edition = true})
elseif enemy_roster_ante7 == 17 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_redlizard', no_edition = true})
elseif enemy_roster_ante7 == 18 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_motherspider', no_edition = true})
elseif enemy_roster_ante7 == 19 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_aquapede', no_edition = true})
elseif enemy_roster_ante7 == 20 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_firebug', no_edition = true})]]
end

elseif G.GAME.round_resets.ante == 8 then
local enemy_roster_ante8 = SCUG.number_in_range(1, 20, "enemychoice" .. G.GAME.round_resets.ante)
if enemy_roster_ante8 == 1 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_poleplant', no_edition = true})
--[[elseif enemy_roster_ante8 >= 2 and enemy_roster_ante8 <= 3 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_giantjellyfish', no_edition = true})
elseif enemy_roster_ante8 == 4 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_yellowlizard', no_edition = true})
elseif enemy_roster_ante8 == 5 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_blacklizard', no_edition = true})
elseif enemy_roster_ante8 >= 6 and enemy_roster_ante8 <= 8 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_vulture', no_edition = true})
elseif enemy_roster_ante8 >= 9 and enemy_roster_ante8 <= 10 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_daddylonglegs', no_edition = true})
elseif enemy_roster_ante8 >= 11 and enemy_roster_ante8 <= 12 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_kingvulture', no_edition = true})
elseif enemy_roster_ante8 >= 13 and enemy_roster_ante8 <= 14 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_motherlonglegs', no_edition = true})
elseif enemy_roster_ante8 == 15 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_redlizard', no_edition = true})
elseif enemy_roster_ante8 == 16 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_mirosvulture', no_edition = true})
elseif enemy_roster_ante8 == 17 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_trainlizard', no_edition = true})
elseif enemy_roster_ante8 == 18 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_leviathan', no_edition = true})
elseif enemy_roster_ante8 == 19 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_redcentipede', no_edition = true})
elseif enemy_roster_ante8 == 20 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_chieftain', no_edition = true})
]]

end

elseif G.GAME.round_resets.ante > 8 then
-- Ante 9+ can roll ANY creature as a spawn. Currently it only rolls for coded enemies.
local enemy_roster_ante9 = pseudorandom_element({1,2,3,4,5,6,7,8,9,11,12,13,14}, pseudoseed("seed"))
if enemy_roster_ante9 == 1 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_greenlizard', no_edition = true})
elseif enemy_roster_ante9 == 2 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_pinklizard', no_edition = true})
elseif enemy_roster_ante9 == 3 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_youngcentipede', no_edition = true})
elseif enemy_roster_ante9 == 4 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_wormgrass', no_edition = true})
elseif enemy_roster_ante9 == 5 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_brotherlonglegs', no_edition = true})
elseif enemy_roster_ante9 == 7 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_redleech', no_edition = true})
elseif enemy_roster_ante9 == 8 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_bluelizard', no_edition = true})
elseif enemy_roster_ante9 == 9 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_coalescipede', no_edition = true})
--elseif enemy_roster_ante9 == 10 then
--SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_inspector', no_edition = true})
elseif enemy_roster_ante9 == 11 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_jungleleech', no_edition = true})
elseif enemy_roster_ante9 == 12 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_whitelizard', no_edition = true})
elseif enemy_roster_ante9 == 13 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_poleplant', no_edition = true})
elseif enemy_roster_ante9 == 14 then
SMODS.add_card({set = "Joker", area = G.jokers, key = 'j_rw_dropwig', no_edition = true})
end

end
end



-- Joke Rifle's random effect
local cr = SCUG.number_in_range(1, 11, "rw_wjokerifle")
if cr <= 5 then
G.GAME.jokerifle = pseudorandom_element({'bluefruit', 'rock', 'cherrybomb', 'none', 'pearl'}, pseudoseed('common'))
elseif cr > 5 and cr <= 9 then
G.GAME.jokerifle = pseudorandom_element({'beehive', 'flashbang', 'grenade', 'sporepuff'}, pseudoseed('uncommon'))
elseif cr > 9 then
G.GAME.jokerifle = 'singularity'
end

-- This checks for rotting cards and triggers their countdown + destroys the card if its reached the end of its lifespan
for k, x in pairs(G.deck.cards) do
if x.config.center == G.P_CENTERS.m_rw_rotting and not x.debuff then
 local enhanced = {} 
 enhanced[#enhanced+1] = x
 x.ability.countdown_to_destruction =  x.ability.countdown_to_destruction -1
 

 if x.ability.countdown_to_destruction == 0 then
 
 
 --Destruction part of function
 local z = {}
 for i = 1, #G.deck.cards do
 if G.deck.cards[i].config.center == G.P_CENTERS.m_rw_rotting and G.deck.cards[i].ability.countdown_to_destruction < 1 then
 z = G.deck.cards[i]
 z:start_dissolve()
 
    --SMODS.calculate_effect({message = localize('k_upgrade_ex')}, artirot)
	end
	end
 --Artificer's check
	if next(SMODS.find_card('j_rw_artificer')) then 
    for i = 1, #SMODS.find_card('j_rw_artificer') do
    local artirot = SMODS.find_card('j_rw_artificer')[i]
	artirot.ability.extra.chips = artirot.ability.extra.chips + artirot.ability.extra.bonus_chips
    end
    end
    end
 
 -- 1 in 5 chance to make another random card a rot card.
 local timeforrot = pseudorandom("rw_rot") < 0.2 -- Also 1 in 5
 if timeforrot then
 
  local notrot = {}
                for i = 1, #G.deck.cards do
                    if G.deck.cards[i] ~= card and G.deck.cards[i].config.center ~= G.P_CENTERS.m_rw_rotting and not G.deck.cards[i].getting_sliced then notrot[#notrot+1] = G.deck.cards[i] end
                end
                local rotted = #notrot > 0 and pseudorandom_element(notrot, pseudoseed('explode')) or nil
				if #notrot > 0 then
				rotted:set_ability(G.P_CENTERS.m_rw_rotting)
				end
                end
            end
end
end



--Definitions for Localization				
G.C.FOOD = HEX('0736f3')
G.C.WEAPON = HEX('875796')

function loc_colour(_c, _default)
  G.ARGS.LOC_COLOURS = G.ARGS.LOC_COLOURS or {
    food = G.C.FOOD,
	weapon = G.C.WEAPON,
	red = G.C.RED,
    mult = G.C.MULT,
    blue = G.C.BLUE,
    chips = G.C.CHIPS,
    green = G.C.GREEN,
    money = G.C.MONEY,
    gold = G.C.GOLD,
    attention = G.C.FILTER,
    purple = G.C.PURPLE,
    white = G.C.WHITE,
    inactive = G.C.UI.TEXT_INACTIVE,
    spades = G.C.SUITS.Spades,
    hearts = G.C.SUITS.Hearts,
    clubs = G.C.SUITS.Clubs,
    diamonds = G.C.SUITS.Diamonds,
    tarot = G.C.SECONDARY_SET.Tarot,
    planet = G.C.SECONDARY_SET.Planet,
    spectral = G.C.SECONDARY_SET.Spectral,
    edition = G.C.EDITION,
    dark_edition = G.C.DARK_EDITION,
    legendary = G.C.RARITY[4],
    enhanced = G.C.SECONDARY_SET.Enhanced
  }
  return G.ARGS.LOC_COLOURS[_c] or _default or G.C.UI.TEXT_DARK
end

