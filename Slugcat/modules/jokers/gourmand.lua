SMODS.Joker {
key = 'gourmand',
atlas = 'slugcats',
pos = { x = 4, y = 0 },
rarity = 2,
cost = 6,
unlocked = true,
discovered = true,
blueprint_compat = true,
config = { extra = { xmult_mod = 1, xmult_gain_common = 0.25, xmult_gain_uncommon = 0.5, xmult_gain_food = 0.1, munch = false }, slugcat = true},

loc_vars = function(self, info_queue, card)
    return { vars = {card.ability.extra.xmult_mod } }
    end,
	
	calculate = function(self, card, context)
	if context.joker_main then
	return{
	xmult = card.ability.extra.xmult_mod
	}
	end
	
	
	--Common
	if context.main_eval and next(SMODS.find_card('j_popcorn')) and not context.blueprint then 
	for _,v in pairs(SMODS.find_card('j_popcorn')) do
	if not v.getting_sliced then
	v:start_dissolve()
	card.ability.extra.xmult_mod = card.ability.extra.xmult_mod + card.ability.xmult_gain_common
	card.ability.extra.munch = true
	v.getting_sliced = true end
	end
	end
	
	if context.main_eval and next(SMODS.find_card('j_cavendish')) and not context.blueprint then 
	for _,v in pairs(SMODS.find_card('j_cavendish')) do
	if not v.getting_sliced then
	v:start_dissolve()
	card.ability.extra.xmult_mod = card.ability.extra.xmult_mod + card.ability.xmult_gain_common
	card.ability.extra.munch = true
	v.getting_sliced = true end
	end
	end
	
	if context.main_eval and next(SMODS.find_card('j_gros_michel')) and not context.blueprint then 
	for _,v in pairs(SMODS.find_card('j_gros_michel')) do
	if not v.getting_sliced then
	v:start_dissolve()
	card.ability.extra.xmult_mod = card.ability.extra.xmult_mod + card.ability.xmult_gain_common
	card.ability.extra.munch = true
	v.getting_sliced = true end
	end
	end
	
	if context.main_eval and next(SMODS.find_card('j_ice_cream')) and not context.blueprint then 
	for _,v in pairs(SMODS.find_card('j_ice_cream')) do
	if not v.getting_sliced then
	v:start_dissolve()
	card.ability.extra.xmult_mod = card.ability.extra.xmult_mod + card.ability.xmult_gain_common
	card.ability.extra.munch = true
	v.getting_sliced = true end
	end
	end
	
	-- Uncommon Food Jokers
	
	if context.main_eval and next(SMODS.find_card('j_egg')) and not context.blueprint then 
	for _,v in pairs(SMODS.find_card('j_egg')) do
	if not v.getting_sliced then
	v:start_dissolve()
	card.ability.extra.xmult_mod = card.ability.extra.xmult_mod + card.ability.xmult_gain_uncommon
	card.ability.extra.munch = true
	v.getting_sliced = true end
	end
	end
	
	if context.main_eval and next(SMODS.find_card('j_seltzer')) and not context.blueprint then 
	for _,v in pairs(SMODS.find_card('j_seltzer')) do
	if not v.getting_sliced then
	v:start_dissolve()
	card.ability.extra.xmult_mod = card.ability.extra.xmult_mod + card.ability.xmult_gain_uncommon
	card.ability.extra.munch = true
	v.getting_sliced = true end
	end
	end
	
	if context.main_eval and next(SMODS.find_card('j_flower_pot')) and not context.blueprint then 
	for _,v in pairs(SMODS.find_card('j_flower_pot')) do
	if not v.getting_sliced then
	v:start_dissolve()
	card.ability.extra.xmult_mod = card.ability.extra.xmult_mod + card.ability.xmult_gain_uncommon
	card.ability.extra.munch = true
	v.getting_sliced = true end
	end
	end
	
	if context.main_eval and next(SMODS.find_card('j_ramen')) and not context.blueprint then 
	for _,v in pairs(SMODS.find_card('j_ramen')) do
	if not v.getting_sliced then
	v:start_dissolve()
	card.ability.extra.xmult_mod = card.ability.extra.xmult_mod + card.ability.xmult_gain_uncommon
	card.ability.extra.munch = true
	v.getting_sliced = true end
	end
	end
	
	if context.main_eval and next(SMODS.find_card('j_diet_cola')) and not context.blueprint then 
	for _,v in pairs(SMODS.find_card('j_diet_cola')) do
	if not v.getting_sliced then
	v:start_dissolve()
	card.ability.extra.xmult_mod = card.ability.extra.xmult_mod + card.ability.xmult_gain_uncommon
	card.ability.extra.munch = true
	v.getting_sliced = true end
	end
	end
	
	if context.main_eval and next(SMODS.find_card('j_turtle_bean')) and not context.blueprint then 
	for _,v in pairs(SMODS.find_card('j_turtle_bean')) do
	if not v.getting_sliced then
	v:start_dissolve()
	card.ability.extra.xmult_mod = card.ability.extra.xmult_mod + card.ability.xmult_gain_uncommon
	card.ability.extra.munch = true
	v.getting_sliced = true end
	end
	end
	
	-- Food Cards
	
	if context.main_eval and next(SMODS.find_card('c_rw_bluefruit')) and not context.blueprint then 
	for _,v in pairs(SMODS.find_card('c_rw_bluefruit')) do
	if not v.getting_sliced then
	v:start_dissolve()
	card.ability.extra.xmult_mod = card.ability.extra.xmult_mod + card.ability.xmult_gain_food
	card.ability.extra.munch = true
	v.getting_sliced = true end
	end
	end
	
	if context.main_eval and next(SMODS.find_card('c_rw_bubblefruit')) and not context.blueprint then 
	for _,v in pairs(SMODS.find_card('c_rw_bubblefruit')) do
	if not v.getting_sliced then
	v:start_dissolve()
	card.ability.extra.xmult_mod = card.ability.extra.xmult_mod + card.ability.xmult_gain_food
	card.ability.extra.munch = true
	v.getting_sliced = true end
	end
	end
   
   if context.main_eval and next(SMODS.find_card('c_rw_gooieduck')) and not context.blueprint then 
   for _,v in pairs(SMODS.find_card('c_rw_gooieduck')) do
   if not v.getting_sliced then
	v:start_dissolve()
	card.ability.extra.xmult_mod = card.ability.extra.xmult_mod + card.ability.xmult_gain_food
	card.ability.extra.munch = true
	v.getting_sliced = true end
   end
   end

	if context.main_eval and next(SMODS.find_card('c_rw_dandepeach')) and not context.blueprint then 
	for _,v in pairs(SMODS.find_card('c_rw_dandepeach')) do
	if not v.getting_sliced then
	v:start_dissolve()
	card.ability.extra.xmult_mod = card.ability.extra.xmult_mod + card.ability.xmult_gain_food
	card.ability.extra.munch = true
	v.getting_sliced = true end
	end
	end
	
	if context.main_eval and next(SMODS.find_card('c_rw_slimemold')) and not context.blueprint then 
	for _,v in pairs(SMODS.find_card('c_rw_slimemold')) do
	if not v.getting_sliced then
	v:start_dissolve()
	card.ability.extra.xmult_mod = card.ability.extra.xmult_mod + card.ability.xmult_gain_food
	card.ability.extra.munch = true
	v.getting_sliced = true end
	end
	end
	
	if context.main_eval and next(SMODS.find_card('c_rw_lilypuck')) and not context.blueprint then 
	for _,v in pairs(SMODS.find_card('c_rw_lilypuck')) do
	if not v.getting_sliced then
	v:start_dissolve()
	card.ability.extra.xmult_mod = card.ability.extra.xmult_mod + card.ability.xmult_gain_food
	card.ability.extra.munch = true
	v.getting_sliced = true end
	end
	end
	
	if context.main_eval and next(SMODS.find_card('c_rw_eggbugegg')) and not context.blueprint then 
	for _,v in pairs(SMODS.find_card('c_rw_eggbugegg')) do
	if not v.getting_sliced then
	v:start_dissolve()
	card.ability.extra.xmult_mod = card.ability.extra.xmult_mod + card.ability.xmult_gain_food
	card.ability.extra.munch = true
	v.getting_sliced = true end
	end
	end
	
	if context.main_eval and next(SMODS.find_card('c_rw_fireegg')) and not context.blueprint then 
	for _,v in pairs(SMODS.find_card('c_rw_fireegg')) do
	if not v.getting_sliced then
	v:start_dissolve()
	card.ability.extra.xmult_mod = card.ability.extra.xmult_mod + card.ability.xmult_gain_food
	card.ability.extra.munch = true
	v.getting_sliced = true end
	end
	end
	
	if context.main_eval and next(SMODS.find_card('c_rw_popcornplant')) and not context.blueprint then 
	for _,v in pairs(SMODS.find_card('c_rw_popcornplant')) do
	if not v.getting_sliced then
	v:start_dissolve()
	card.ability.extra.xmult_mod = card.ability.extra.xmult_mod + card.ability.xmult_gain_food
	card.ability.extra.munch = true
	v.getting_sliced = true end
	end
	end
	
	if context.main_eval and next(SMODS.find_card('c_rw_glowweed')) and not context.blueprint then 
	for _,v in pairs(SMODS.find_card('c_rw_glowweed')) do
	if not v.getting_sliced then
	v:start_dissolve()
	card.ability.extra.xmult_mod = card.ability.extra.xmult_mod + card.ability.xmult_gain_food
	card.ability.extra.munch = true
	v.getting_sliced = true end
	end
	end
	
	if context.main_eval and next(SMODS.find_card('c_rw_mushroom')) and not context.blueprint then 
	for _,v in pairs(SMODS.find_card('c_rw_mushroom')) do
	if not v.getting_sliced then
	v:start_dissolve()
	card.ability.extra.xmult_mod = card.ability.extra.xmult_mod + card.ability.xmult_gain_food
	card.ability.extra.munch = true
	v.getting_sliced = true end
	end
	end
	
	if context.main_eval and next(SMODS.find_card('c_rw_karmaf')) and not context.blueprint then 
	for _,v in pairs(SMODS.find_card('c_rw_karmaf')) do
	if not v.getting_sliced then
	v:start_dissolve()
	card.ability.extra.xmult_mod = card.ability.extra.xmult_mod + card.ability.xmult_gain_food
	card.ability.extra.munch = true
	v.getting_sliced = true end
	end
	end
	
	if context.main_eval and next(SMODS.find_card('c_rw_neuronfly')) and not context.blueprint then 
	for _,v in pairs(SMODS.find_card('c_rw_neuronfly')) do
	if not v.getting_sliced then
	v:start_dissolve()
	card.ability.extra.xmult_mod = card.ability.extra.xmult_mod + card.ability.xmult_gain_food
	card.ability.extra.munch = true
	v.getting_sliced = true end
	end
	end
	
	if card.ability.extra.munch == true then
	SMODS.calculate_effect({message = 'Crunch', sound = 'rw_crunch'}, card)
	delay (0.2)
	card.ability.extra.munch = false
	end
	
	end
	}