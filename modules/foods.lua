SCUG.load_folder("modules/foods")

SMODS.ConsumableType({
	key = "foods",
	default = "c_rw_bluefruit",
	collection_rows = { 6, 7 },
	primary_colour = HEX("1b5699"),
	secondary_colour = HEX("1b5699"),
	shop_rate = 3.5,
	rarities = {
		{ key = "rw_foodcommon", rate = 0.7 },
		{ key = "rw_fooduncommon", rate = 0.27 },
		{ key = "rw_foodrare", rate = 0.02 },
	},
})

SCUG.inc_food_count = function ()
	if G.GAME.consumeable_usage_total.foods ~= nil then
		G.GAME.consumeable_usage_total.foods = G.GAME.consumeable_usage_total.foods + 1
	else
		G.GAME.consumeable_usage_total.foods = 1
	end
end