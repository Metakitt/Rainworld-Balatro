SMODS.Blind({
	key = "rotblind",
	loc_txt = {
		name = "Rot",
		text = {
			"All cards of a played",
			"hand become Rot.",
		},
	},
	boss = { min = 4, max = 10 },
	boss_colour = HEX("1b5699"),
	atlas = "theblinds",
	pos = { x = 0, y = 0 },
	calculate = function(self, blind, context)
		if context.after and not blind.disabled then
			G.E_MANAGER:add_event(Event({
				func = function()
					blind:wiggle()
					for i = 1, #G.play.cards do
						G.E_MANAGER:add_event(Event({
							func = function()
								G.play.cards[i]:juice_up()
								G.play.cards[i]:set_ability("m_rw_rotting")
								return true
							end
						}))
					end
					return true
				end
			}))
			delay(0.8)
			blind.triggered = true
		end
	end
})

--[[
SMODS.Blind {
key = 'cycleblind',
loc_txt = {
name= "Cycle",
text = { 'Each played hand has a chance to end the blind with no reward and go back an ante.'

SMODS.Blind {
key = 'ascensionblind',
loc_txt = {
name = "Ascent",
text = { 'Each played hand increases the required chips by 20%' } ]]
