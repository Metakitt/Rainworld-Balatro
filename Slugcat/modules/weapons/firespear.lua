SMODS.Sticker {
key = 'wspear_fire',
loc_txt = {
label = 'Fire Spear',
},
badge_colour = HEX('875796'),
atlas = 'enhancedcards_scug', 
pos = { x = 1, y = 2},
default_compat = true,
compat_exceptions = {},
sets = {
Joker = true,
Tarot = false,
Spectral = false,
foods = false
},
rate = 0.002,
needs_enable_flag = false,
loc_vars = function(self, info_queue, card)
    if card.config.center_key == 'j_rw_monk' or card.config.center_key == 'j_rw_inv'then
    return {key = self.key..'_monk_inv' }
    end
	
	if card.config.center_key == 'j_rw_hunter' or card.config.center_key == 'j_rw_artificer' then
    return {key = self.key..'_hunter_artificer_spearmaster' }
    end
	
	if card.config.center_key == 'j_rw_gourmand' then
    return {key = self.key..'_gourmand' }
    end
	
	if card.config.center_key == 'j_rw_saint' then
    return {key = self.key..'_saint' }
    end
	
	end,
calculate = function(self, card, context)

if context.joker_main then
local lodging = math.random(1,100)
local gourmandexhausted = math.random(1,4)


if lodging >= 3 or card.config.center_key == 'j_rw_artificer' then
if card.config.center_key == 'j_rw_monk' or card.config.center_key == 'j_rw_inv' then
return {
x_mult = 3.75
}
elseif card.config.center_key == 'j_rw_hunter' or card.config.center_key == 'j_rw_artificer' or card.config.center_key == 'j_rw_spearmaster' then
return {
x_mult = 5.25
}
elseif card.config.center_key == 'j_rw_gourmand' and gourmandexhausted == 4 then
return {
x_mult = 0.5
}
elseif card.config.center_key == 'j_rw_gourmand' and gourmandexhausted < 4 then 
return {
x_mult = 9
}
elseif card.config.center_key == 'j_rw_saint' then
return {
x_mult = 10
}
else
return {
x_mult = 4.5
}
end
G.GAME.blind.chips = G.GAME.blind.chips * 1.05
G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
end
if lodging <= 2 and card.config.center_key ~= 'j_rw_artificer' then
SMODS.Stickers.rw_wspear:apply(card)
end

end
end

}


SMODS.Consumable {
key = 'firespear',
loc_txt = {
name = 'Fire Spear',
text = { "Gives a Fire Spear", "to 1 Joker.",
},
},
set = 'obtainweapon',
atlas = 'weaponfoods',
pos = { x = 6, y = 2 },
cost = 3,
unlocked = true,
discovered = true,
config = { extra = { upgrade = 15 }, test = true},
loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = { set = 'Other', key = 'rw_wspear_fire'}
		end,
can_use = function(self, card)
	return #G.jokers.highlighted == 1
	end,
use = function(self,card,area,copier)

for i,v in ipairs(G.jokers.highlighted) do
for i = 1, #G.jokers.highlighted do
local highlighted = G.jokers.highlighted[i]
SMODS.Stickers["rw_wspear_fire"]:apply(highlighted,true)

end
end
end
	
	}