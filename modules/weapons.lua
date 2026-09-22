--[[
Weapons FAQ
Can a joker have multiple weapons?
Multiple weapons can generate on the same card through the shop or packs, but you can't apply extra weapons through consumeables.

How can I obtain weapons?
Weapons sometime spawns on jokers in the shop or packs.
Some new jokers (in the future) will have the ability to duplicate their own weapons onto other jokers or give weapon consumeables.
Not yet implemented "Scavenge" joker, which has a 1 in 6 chance to find a weapon consumeable when rerolling in the shop.
Weapon consumeables applied onto jokers.

The Weapon file is starting to be big and hard to navigate; so I've separated it into different files.
-Weapon files atm will contain two things; the weapon and the consumeable version of said weapon.
]]

SCUG.load_folder("modules/weapons")

-- Weapon Consumeable type
SMODS.ConsumableType({
	key = "obtainweapon",
	collection_rows = { 6, 7 },
	primary_colour = HEX("875796"),
	secondary_colour = HEX("875796"),
	shop_rate = 0,
	default = "c_rw_wspear"
})


-- function here that checks if card has one of the weapons as sticker, and if so, it can't have another. Or make all weapons incompatible with each other?
