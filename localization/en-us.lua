--Note: Make sure that for the food consumables they are all referred to as "Food Card". Food also uses its own custom color code, simply 'food'.
return {
	descriptions = {
		Enhanced = {
			m_rw_rotting = {
				name = "Rot",
				text = {
					"{C:chips}#2#{} chips",
					"This card is rotting away",
					"{C:attention}#1#{} round(s) to destruction",
				},
			},
			m_rw_wetasscard = {
				name = "Wet",
				text = {
					"{X:chips,C:white}X#1#{} chips, always scores",
					"{C:attention}#2#{} round(s) until dry",
				},
			},
		},
		Other = {
			rw_wsporepuff = {
				name = "Sporepuff",
				text = {
					"Decreases required",
					"chips by {C:attention}5%{}.",
				},
			},
			rw_wbeehive = {
				name = "Beehive",
				text = {
					"At the start of {C:attention}Boss{}",
					"{C:attention}Blind{}, selects a random",
					"suit and {C:attention}doubles{} extra",
					"chips of {C:attention}all{} cards in it,",
					"but debuffs {C:attention}all{} other",
					"suits until the end of",
					"{C:attention}Boss Blind{}. Cards with",
					"no extra chips are",
					"given {C:chips}+5{} extra chips",
					"to {C:attention}double{}.",
				},
			},
			rw_wcherrybomb = {
				name = "Cherrybomb",
				text = {
					"{C:mult}+6~12{} Mult.",
				},
			},
			rw_wsingularity = {
				name = "Singularity Bomb",
				text = {
					"If {C:attention}first hand{}",
					"of round has only",
					"{C:attention}1{} card,{C:attention} destroys{}",
					"your entire{C:attention} hand{}",
					"and wins the blind.",
					"{C:inactive}One-time use{}.",
				},
			},
			rw_wgrenade = {
				name = "Grenade",
				text = {
					"If {C:attention}first discard{} of",
					"round has only {C:attention}1{} card",
					"{C:attention}destroy{} it. Gains {C:mult}+3{}",
					"Mult for each {C:attention}card{}",
					"{C:attention}destroyed{} by Grenade",
					"this run.",
					"{C:inactive}(Currently {}{C:mult}+#1#{}{C:inactive}){}",
				},
			},
			rw_wgrenade2 = {
				name = "Grenade",
				text = {
					"If {C:attention}first discard{} of",
					"round has only {C:attention}1{} card",
					"{C:attention}destroy{} it. Gains {C:mult}+3{}",
					"Mult for each {C:attention}card{}",
					"{C:attention}destroyed{} by Grenade",
					"this run.",
				},
			},
			rw_wflashbang = {
				name = "Flashbang",
				text = {
					"Re-rolls the next {C:attention}Boss{}",
					"{C:attention}Blind{} when a {C:attention}Blind{}",
					"is skipped.",
					"{C:inactive}One-time use{}.",
				},
			},
			rw_wrock = {
				name = "Rock",
				text = {
					"{X:chips,C:white}X2{} Chips",
				},
			},
			rw_wspear = {
				name = "Spear",
				text = {
					"{X:mult,C:white}X1.5{} Mult",
				},
			},
			rw_hunter_wspear = {
				name = "2nd Spear",
				text = { "X1.75 Mult when Held" },
			},
			rw_wspear_monk_inv = {
				name = "Spear",
				text = { "{X:mult,C:white}X1.25{} Mult" },
			},
			rw_wspear_hunter_artificer_spearmaster = {
				name = "Spear",
				text = { "{X:mult,C:white}X1.75{} Mult" },
			},
			rw_wspear_gourmand = {
				name = "Spear",
				text = {
					"{X:mult,C:white}X3{} Mult",
					"{C:green}1 in 4{} chance to be",
					"exhausted and give",
					"{X:mult,C:white}X0.9{}Mult instead.",
				},
			},
			rw_wspear_exp = {
				name = "Explosive Spear",
				text = {
					"{X:mult,C:white}X3{} Mult",
					"{C:green}1 in 6{} chance to",
					"{C:attention}destroy{} a random card",
					"in {C:attention}hand{} when scoring.",
				},
			},
			rw_wspear_exp_monk_inv = {
				name = "Explosive Spear",
				text = {
					"{X:mult,C:white}X2.5{} Mult",
					"{C:green}1 in 6{} chance to",
					"{C:attention}destroy{} a random card",
					"in {C:attention}hand{} when scoring.",
				},
			},
			rw_wspear_exp_hunter_artificer_spearmaster = {
				name = "Explosive Spear",
				text = {
					"{X:mult,C:white}X3.5{} Mult",
					"{C:green}1 in 6{} chance to",
					"{C:attention}destroy{} a random card",
					"in {C:attention}hand{} when scoring.",
				},
			},
			rw_wspear_exp_gourmand = {
				name = "Explosive Spear",
				text = {
					"{X:mult,C:white}X6{} Mult",
					"{C:green}1 in 4{} chance to be",
					"exhausted and give",
					"{X:mult,C:white}X0.9{} Mult instead.",
					"{C:green}1 in 6{} chance to",
					"{C:attention}destroy{} a random card",
					"in {C:attention}hand{} when scoring.",
				},
			},
			rw_wspear_ele = {
				name = "Electric Spear",
				text = {
					"{X:mult,C:white}X1.5{} Mult",
					"If Seltzer or Splash",
					"is present, gives",
					"{X:chips,C:white}X1.5{} Chips as well.",
				},
			},
			rw_wspear_ele_monk_inv = {
				name = "Electric Spear",
				text = {
					"{X:mult,C:white}X1.25{} Mult",
					"If Seltzer or Splash",
					"is present, gives",
					"{X:chips,C:white}X1.25{} Chips as well.",
				},
			},
			rw_wspear_ele_hunter_artificer_spearmaster = {
				name = "Electric Spear",
				text = {
					"{X:mult,C:white}X1.75{} Mult",
					"If Seltzer or Splash",
					"is present, gives",
					"{X:chips,C:white}X1.75{} Chips as well.",
				},
			},
			rw_wspear_ele_gourmand = {
				name = "Electric Spear",
				text = {
					"{X:mult,C:white}X3{} Mult",
					"If Seltzer or Splash",
					"is present, gives",
					"{X:chips,C:white}X3{} Chips as well.",
					"{C:green}1 in 4{} chance to be",
					"exhausted and give {X:mult,C:white}X0.9 Mult{}",
					"and {X:chips,C:white}X0.9{} Chips{C:inactive}(With Seltzer/Splash){} instead.",
				},
			},
			rw_wspear_fire = {
				name = "Fire Spear",
				text = {
					"{X:mult,C:white}X4.5{} Mult",
					"Increases required",
					"chips by {C:attention}5%{}.",
				},
			},
			rw_wspear_fire_monk_inv = {
				name = "Fire Spear",
				text = {
					"{X:mult,C:white}X3.25{} Mult",
					"Increases required",
					"chips by {C:attention}5%{}.",
				},
			},
			rw_wspear_fire_hunter_artificer_spearmaster = {
				name = "Fire Spear",
				text = {
					"{X:mult,C:white}X5.25{} Mult",
					"Increases required",
					"chips by {C:attention}5%{}.",
				},
			},
			rw_wspear_fire_gourmand = {
				name = "Fire Spear",
				text = {
					"{X:mult,C:white}X9{} Mult",
					"Increases required",
					"chips by {C:attention}5%{}.",
					"{C:green}1 in 4{} chance to be",
					"exhausted and give",
					"{X:mult,C:white}X0.5{} Mult instead.",
				},
			},
			rw_wspear_fire_saint = {
				name = "Fire Spear",
				text = {
					"{X:mult,C:white}X10{} Mult",
					"Increases required",
					"chips by {C:attention}5%{}.",
				},
			},
			rw_wjokerifle = {
				name = "Joke Rifle",
				text = {
					"At the start",
					"of {C:attention}Blind{},",
					"selects a",
					"random effect.",
					"{C:inactive}(Loaded with: Nothing){}",
					"Does nothing.",
				},
			},
			rw_wjokerifle_bluefruit = {
				name = "Joke Rifle",
				text = {
					"At the start",
					"of {C:attention}Blind{},",
					"selects a",
					"random effect.",
					"{C:inactive}(Loaded with: Blue Fruit){}",
					"{C:attention}Cards{} in the {C:attention}first{}",
					"{C:attention}played hand{} gains",
					"{C:chips}+15{} extra chips.",
				},
			},
			rw_wjokerifle_rock = {
				name = "Joke Rifle",
				text = {
					"At the start",
					"of {C:attention}Blind{},",
					"selects a",
					"random effect.",
					"{C:inactive}(Loaded with: Rock){}",
					"{X:chips,C:white}X2{} Chips",
				},
			},
			rw_wjokerifle_pearl = {
				name = "Joke Rifle",
				text = {
					"At the start",
					"of {C:attention}Blind{},",
					"selects a",
					"random effect.",
					"{C:inactive}(Loaded with: Pearl){}",
					"At the end of",
					"{C:attention}Blind{},",
					"{C:green}1 in 4{} chance",
					"to turn this",
					"Joker {C:edition}Polychrome{}.",
				},
			},
			rw_wjokerifle_cherrybomb = {
				name = "Joke Rifle",
				text = {
					"At the start",
					"of {C:attention}Blind{},",
					"selects a",
					"random effect.",
					"{C:inactive}(Loaded with: Cherrybomb){}",
					"{C:mult}+6~12{} Mult.",
				},
			},
			rw_wjokerifle_beehive = {
				name = "Joke Rifle",
				text = {
					"At the start",
					"of {C:attention}Blind{},",
					"selects a",
					"random effect.",
					"{C:inactive}(Loaded with: Beehive){}",
					"At the start of {C:attention}Blind{},",
					"selects a random suit ",
					"and {C:attention}doubles{} extra",
					"chips of {C:attention}all{} cards in it,",
					"but debuffs {C:attention}all{} other",
					"suits until the end of",
					"{C:attention}Blind{}. Cards with",
					"no extra chips are",
					"given {C:chips}+5{} extra chips",
					"to {C:attention}double{}.",
				},
			},
			rw_wjokerifle_flashbang = {
				name = "Joke Rifle",
				text = {
					"At the start",
					"of {C:attention}Blind{}, selects",
					"a random effect.",
					"{C:inactive}(Loaded with: Flashbang){}",
					"Re-rolls the next {C:attention}Boss{}",
					"{C:attention}Blind{} when a {C:attention}Blind{}",
					"is skipped.",
				},
			},
			rw_wjokerifle_grenade = {
				name = "Joke Rifle",
				text = {
					"At the start",
					"of {C:attention}Blind{},",
					"selects a",
					"random effect.",
					"{C:inactive}(Loaded with: Grenade){}",
					"If {C:attention}first discard{} of",
					"round has only {C:attention}1{} card",
					"{C:attention}destroy{} it. Gains {C:mult}+3{}",
					"Mult for each {C:attention}card{}",
					"{C:attention}destroyed{} by Grenade",
					"this run.",
					"{C:inactive}(Currently {}{C:mult}+#1#{}{C:inactive}){}",
				},
			},
			rw_wjokerifle_sporepuff = {
				name = "Joke Rifle",
				text = {
					"At the start",
					"of {C:attention}Blind{},",
					"selects a",
					"random effect.",
					"{C:inactive}(Loaded with: Sporepuff){}",
					"Decreases required",
					"chips by {C:attention}5%{}.",
				},
			},
			rw_wjokerifle_singularity = {
				name = "Joke Rifle",
				text = {
					"At the start",
					"of {C:attention}Blind{},",
					"selects a",
					"random effect.",
					"{C:inactive}(Loaded with: Singularity Bomb){}",
					"If {C:attention}first hand{}",
					"of round has only",
					"{C:attention}1{} card,{C:attention} destroys{}",
					"your entire{C:attention} hand{}",
					"and wins the blind.",
				},
			},

			rw_rotted = {
				name = "Rot",
				text = {
					"{C:chips}-25{} Chips",
					"{C:green}1 in 20 chance to spread",
					"to another {C:attention}Joker{} at the end of {C:attention}Blind{}",
					"{C:attention}#1#{} round(s) to destruction",
				},
			},
		},
		foods = {
			c_rw_bluefruit = {
				name = "Blue Fruit",
				text = {
					"Permanently gives",
					"{C:chips}+#1#{} extra Chips",
					"to one card.",
				},
			},
			c_rw_rotting2 = {
				name = "Rot Fruit",
				text = {
					"Makes your card Rot.",
					"For testing purpose only.",
				},
			},
			c_rw_bubblefruit = {
				name = "Bubble Fruit",
				text = {
					"If Rivulet, Splash,",
					"Diet Cola or Seltzer",
					"is present:",
					"{X:chips,C:white}X4{} to {C:attention}one{} card's",
					"extra chips.",
					"Otherwise, {X:chips,C:white}X2{} to {C:attention}one{}",
					"card's extra chips.",
				},
			},
			c_rw_gooieduck = {
				name = "Gooieduck",
				text = {
					"Permanently gives",
					"{C:chips}+#1#{} Chips to all cards",
					"in {C:attention}hand{}",
					"{C:inactive}({C:attention}#2#{C:inactive} more uses)",
				},
			},
			c_rw_dandepeach = {
				name = "Dandelion Peach",
				text = {
					"Adds a random playing",
					"card with {C:chips}+#1#{} extra",
					"chips to your hand.",
				},
			},
			c_rw_slimemold = {
				name = "Slime Mold",
				text = {
					"Permanently gives",
					"{C:mult}+#1#{} Mult to",
					"{C:attention}#2#{} selected cards",
				},
			},
			c_rw_lilypuck = {
				name = "Lilypuck",
				text = {
					"Adds a permanent",
					"copy of a random",
					"{C:attention}card{} in your {C:attention}hand{}",
					"to the {C:attention}deck{}",
					"and draws it.",
				},
			},
			c_rw_eggbugegg = {
				name = "Eggbug Egg",
				text = {
					"Every {C:attention}card{} of",
					"a random {C:attention}suit{}",
					"in the {C:attention}deck{} gains",
					"{C:chips}+#1#{} extra chips.",
				},
			},
			c_rw_fireegg = {
				name = "Fire Egg",
				text = {
					"Every {C:attention}card{} of",
					"a random {C:attention}suit{}",
					"in the {C:attention}deck{} gains",
					"{C:mult}+#1#{} extra Mult.",
				},
			},
			c_rw_popcornplant = {
				name = "Popcorn Plant",
				text = {
					"Every {C:attention}card{} of",
					"a random {C:attention}suit{}",
					"in the {C:attention}deck{} gains",
					"{C:mult}+#1#{} extra Mult and",
					"{C:chips}+#1#{} extra chips.",
				},
			},
			c_rw_glowweed = {
				name = "Glow Weed",
				text = {
					"{C:green}#1# in #2#{} chance",
					"two selected cards",
					"become {C:edition}Foil{}.",
				},
			},
			c_rw_mushroom = {
				name = "Mushroom",
				text = {
					"{C:green}#1# in #2#{} chance to halve",
					"current {C:attention}Blind{} chip",
					"requirement.",
					"{C:green}#1# in #3# chance to add",
					"a copy of itself",
					"after being used.",
				},
			},
			c_rw_karmaf = {
				name = "Karma Flower",
				text = {
					"{C:attention}#1#{} Ante.",
				},
			},
			c_rw_neuronfly = {
				name = "Neuron Fly",
				text = {
					"{C:attention}+#1#{} hand size.",
				},
			},
		},
		obtainweapon = {
			c_rw_singularity = {
				name = "Singularity Bomb",
				text = { "Gives a Singularity Bomb", "to 1 Joker." },
			},
			c_rw_jokerifle = {
				name = "Joke Rifle",
				text = { "Gives a Joke Rifle", "to 1 Joker." },
			},
			c_rw_beehive = {
				name = "Beehive",
				text = { "Gives a Beehive", "to 1 Joker." },
			},
			c_rw_cherrybomb = {
				name = "Cherrybomb",
				text = { "Gives a Cherrybomb to 1 Joker." },
			},
			c_rw_spear_ele = {
				name = "Electric Spear",
				text = { "Gives an Electric Spear", "to 1 Joker." },
			},
			c_rw_spear_exp = {
				name = "Explosive Spear",
				text = { "Gives an Explosive Spear", "to 1 Joker." },
			},
			c_rw_firespear = {
				name = "Fire Spear",
				text = { "Gives a Fire Spear", "to 1 Joker." },
			},
			c_rw_flashbang = {
				name = "Flashbang",
				text = { "Gives a Flashbang", "to 1 Joker." },
			},
			c_rw_grenade = {
				name = "Grenade",
				text = { "Gives a Grenade", "to 1 Joker." },
			},
			c_rw_rock = {
				name = "Rock",
				text = { "Gives a Rock", "to 1 Joker." },
			},
			c_rw_spear = {
				name = "Spear",
				text = { "Gives a Spear", "to 1 Joker." },
			},
			c_rw_sporepuff = {
				name = "Sporepuff",
				text = { "Gives a Sporepuff", "to 1 Joker." },
			},
		},
		Joker = {
			--region Enemies
			j_rw_greenlizard = {
				name = "Green Lizard",
				text = {
					"{C:attention}Threat{}: {C:green}1 in #1#{} chance",
					"to {C:red}destroy{} a random Joker",
					"at the {C:attention}end of round{}.",
					"{C:attention}To Defeat{}: Score a {C:attention}Flush{}. [{C:attention}#3#{}/1]",
					"{C:attention}Undefeated{}: {C:green}1 in #2#{} chance to {C:red}destroy",
					"{C:attention}each{} of your Jokers at the",
					"end of {C:attention}Boss Blind{}.",
				},
			},
			j_rw_pinklizard = {
				name = "Pink Lizard",
				text = {
					"{C:attention}Threat{}: {C:green}1 in #1#{} chance",
					"to {C:red}destroy{} a random card",
					"in the deck after playing a hand.",
					"{C:attention}To Defeat{}: Score a {C:attention}Straight{}. [{C:attention}#3#{}/1]",
					"{C:attention}Undefeated{}: {C:green}1 in #2#{} chance to {C:red}destroy",
					"{C:attention}each{} card in your deck at the",
					"end of {C:attention}Boss Blind{}.",
				},
			},
			j_rw_youngcentipede = {
				name = "Young Centipede",
				text = {
					"{C:attention}Threat{}: {C:inactive}None.{}",
					"{C:attention}To Defeat{}: Score a {C:attention}Four of a Kind{}. [{C:attention}#1#{}/1]",
					"{C:attention}Undefeated{}: Lose {C:money}$#2#{} at",
					"the end of {C:attention}Boss Blind{}.",
				},
			},
			j_rw_wormgrass = {
				name = "Wormgrass",
				text = {
					"{C:attention}Threat{}: {C:red}Destroys{} cards after they've been played.",
					"{C:attention}To Defeat{}: Score #1# chips or more.",
					"{C:attention}Undefeated{}: {C:inactive}Nothing.{}",
				},
			},
			j_rw_brotherlonglegs = {
				name = "Brother Long Legs",
				text = {
					"{C:attention}Threat{}: At the start of each blind,",
					"{C:green}1 in #1#{} chance for each card",
					"in your deck to become {C:rot}Rot{}.",
					"{C:attention}To Defeat{}: Score a hand while holding an {C:weapon}Explosive Spear{}.",
					"{C:attention}Undefeated{}: Chooses a random {C:attention}rank{} and turns it",
					"to {C:rot}Rot{} at end of {C:attention}Boss Blind{}.",
				},
			},
			j_rw_bluelizard = {
				name = "Blue Lizard",
				text = {
					"{C:attention}Threat{}: {X:chips,C:white}X#1#{} Chips.",
					"{C:attention}To Defeat{}: Score a card with at least {C:chips}#2#{} extra chips.",
					"{C:attention}Undefeated{}: Each card in your",
					"deck gets {C:chips}#3#{} extra chips at the",
					"end of {C:attention}Boss Blind{}.",
				},
			},
			j_rw_redleech = {
				name = "Red Leech",
				text = {
					"{C:attention}Threat{}: {C:chips}#1#{} Chips. Each played hand has a {C:green}1 in #2#{}",
					"chance to spawn a new Red Leech.",
					"{C:attention}To Defeat{}: Play two {C:attention}High Card{} hands. [{C:attention}#3#{}/2]",
					"{C:attention}Undefeated{}: {C:red}Destroys{} a random Joker at",
					"the end of {C:attention}Boss Blind{}.",
				},
			},
			j_rw_coalescipede = {
				name = "Coalescipede",
				text = {
					"{C:attention}Threat{}: Each {C:attention}Coalescipede{} gives {C:chips}#1#{} Chips. {C:inactive}[{C:chips}#3#{C:inactive} from all]",
					"Each played hand has a {C:green}1 in #2# chance",
					"to spawn another {C:attention}Coalescipede{}.",
					"{C:attention}To Defeat{}: Have a Joker with a {C:weapon}Flashbang{}.",
					"{C:attention}Undefeated{}: Spawns two more {C:attention}Coalescipedes{} at",
					"the end of {C:attention}Boss Blind{}.",
				},
			},
			j_rw_jungleleech = {
				name = "Jungle Leech",
				text = {
					"{C:attention}Threat{}: {C:mult}#1#{} Mult.",
					"{C:green}1 in #3#{} chance to gain {C:mult}#2#{} Mult",
					"and {C:green}1 in #4#{} chance to spawn another",
					"{C:attention}Jungle Leech{} each hand played.",
					"{C:attention}To Defeat{}: Sell a {C:food}Food{} card and play five {C:attention}High Card{} hands.",
					"{C:inactive}[{C:attention}#5#{C:inactive} sold, {C:attention}#6#{C:inactive}/5 played]",
					"{C:attention}Undefeated{}: {C:green}1 in #7#{} chance to remove {C:food}Food{} cards from the shop.",
				},
			},
			j_rw_whitelizard = {
				name = "White Lizard",
				text = {
					"{C:attention}Threat{}: {X:mult,C:white}X#1#{} Mult",
					"{C:attention}To Defeat{}: Play a hand with a {C:attention}Wild Card{}.",
					"{C:attention}Undefeated{}: Sets your most played",
					"{C:purple}poker hand{} back to level 1.",
				},
			},
			j_rw_poleplant = {
				name = "Pole Plant",
				text = {
					"{C:attention}Threat{}: {C:mult}#1#{} Mult",
					"{C:attention}To Defeat{}: Score two {C:attention}Mult Cards{}. [{C:attention}#2#{}/2]",
					"{C:attention}Undefeated{}: All playing cards get {C:mult}#3#{} Extra Mult.",
				},
			},
			j_rw_dropwig = {
				name = "Dropwig",
				text = {
					"{C:attention}Threat{}: If you score {C:attention}#3#% or more{} of the Blind's",
					"chips {C:attention}#2#{} more time(s), you {C:red}lose the run{}.",
					"{C:attention}To Defeat{}: Win {C:attention}#1#{} more blind(s) without",
					"going over the threshold.",
					"{C:attention}Undefeated{}: {C:inactive}Nothing.{}",
				},
			},
			j_rw_inspector = {
				name = "Inspector",
				text = {
					"{C:attention}Threat: {C:green}1 in #1#{} chance to {C:red}reject{} played hand.",
					"{s:0.8,C:inactive}(Shuffles cards back into deck, {s:0.8,C:blue}refunds{s:0.8,C:inactive} the hand)",
					"{C:attention}To Defeat:{} Score a hand while holding an {C:weapon}Explosive Spear{}.",
					"{C:attention}Undefeated:{} Chance goes up. Maxes out at {C:green}1 in 2{}.",
				},
			},
			j_rw_daddylonglegs = {
				name = "Daddy Long Legs",
				text = {
					"{C:attention}Threat{}: At the start of each blind,",
					"{C:green}1 in #1#{} chance for each card",
					"in your deck to become {C:rot}Rot{}.",
					"{C:attention}To Defeat{}: Score two hands while holding",
					"an {C:weapon}Explosive Spear{}. [{C:attention}#2#{}/2]",
					"{C:attention}Undefeated{}: Chooses a random {C:attention}suit{} and turns it",
					"to {C:rot}Rot{} at end of {C:attention}Boss Blind{}.",
				},
			},
			j_rw_salamander = {
				name = "Salamander",
				text = {
					"{C:attention}Threat{}: At the start of each blind,",
					"{C:green}1 in #1#{} chance for each card",
					"in your deck to become Wet.",
					"{C:attention}To Defeat{}: Use 4 {C:tarot}Tarot{} Cards. [{C:attention}#2#{}/4]",
					"{C:attention}Undefeated{}: Wet cards become {C:rot}Rot Cards{}.",
				},
			},
			j_rw_monsterkelp = {
				name = "Monster Kelp",
				text = {
					"{C:attention}Threat{}: {C:chips}#1#{} chips",
					"{C:attention}To Defeat{}: Score two hands while holding",
					"a {C:weapon}Flashbang or Spear{}. [{C:attention}#2#{}/2]",
					"{C:attention}Undefeated{}: Each card in your",
					"deck gets {C:chips}#3#{} extra chips at the",
					"end of {C:attention}Boss Blind{}.",
				},
			},
			j_rw_yellowlizard = {
				name = "Yellow Lizard",
				text = {
					"{C:attention}Threat{}: At the end of round, {C:money}-$#1#{} and",
					"{C:green}1 in #2#{} chance to summon",
					"another Yellow Lizard.",
					"{C:attention}To Defeat{}: Reroll the Shop {C:attention}#3#{} more times.",
					"{C:attention}Undefeated{}: Sets Money to {C:money}-$20{}.",
				},
			},
			j_rw_aquapede = {
				name = "Aquapede",
				text = {
					"{C:attention}Threat{}: At the start of Blind,",
					"{C:green}1 in #1#{} chance for each card",
					"in the deck to become Wet.",
					"Each played hand becomes Wet.",
					"{C:attention}To Defeat{}: Have a Joker with a {C:mult}+#2#{} Mult {C:weapon}Grenade{}.",
					"{C:attention}Undefeated{}: {C:attention}All{} Wet cards are {C:red}destroyed{}.",
				},
			},
			j_rw_centiwing = {
				name = "Centiwing",
				text = {
					"{C:attention}Threat{}: #1# Chips to score after each {C:attention}hand{} played.",
					"{C:attention}To Defeat{}: Score 3 cards with {C:chips}20 or more{} Extra Chips. [{C:attention}#2#{}/3]",
					"{C:attention}Undefeated{}: All cards with {C:chips}5 or more{} extra chips",
					"in the deck are {C:red}debuffed permanently{}.",
				},
			},
			j_rw_cyanlizard = {
				name = "Cyan Lizard",
				text = {
					"{C:attention}Threat{}: Always selects a card.",
					"{C:attention}To Defeat{}: Use 2 {C:planet}Planet{} cards. [{C:attention}#1#{}/2]",
					"{C:attention}Undefeated{}: Sets all your {C:purple}poker hands{} to level 1.",
				},
			},

			j_rw_sealeech = {
				name = "Sea Leech",
				text = {
					"{C:attention}Threat{}: {C:chips}#1#{} Chips and {C:mult}#1#{} Mult per {C:attention}Sea Leech{}.",
					"{C:green}1 in #2#{} chance to spawn a",
					"{C:attention}Sea Leech{} after playing a hand.",
					"{C:attention}To Defeat{}: Play a hand with an {C:weapon}Electric Spear{}.",
					"{C:attention}Undefeated{}: Spawns a new Sea Leech at",
					"the end of {C:attention}Boss Blind{}.",
				},
			},

			j_rw_bigspider = {
				name = "Big Spider",
				text = {
					"{C:attention}Threat{}: Only {C:attention}Flush{}, {C:attention}Full House{}",
					"or {C:attention}Straight{} hands count for scoring.",
					"{C:attention}To Defeat{}: Play 3 {C:attention}Flush{}, 2 {C:attention}Full House{}",
					"and 1 {C:attention}Straight{}.",
					"{C:inactive}Scored: Flush[#1#], Full House[#2#], Straight[#3#]{}",
					"{C:attention}Undefeated{}: Nothing.",
				},
			},

			j_rw_eellizard = {
				name = "Eel Lizard",
				text = {
					"{C:attention}Threat:{} {C:spades}Dark {C:clubs}suits{} are {C:red}debuffed{}.",
					"{C:attention}To Defeat:{} Score 2 {C:attention}Wet Cards{}. [{C:attention}#1#{}/2]",
					"{C:attention}Undefeated:{} {C:spades}Dark {C:clubs}suits{} stay {C:red}permanently debuffed{}.",
				},
			},
			j_rw_blacklizard = {
				name = "Black Lizard",
				text = {
					"{C:attention}Threat:{} {C:hearts}Light {C:diamonds}suits{} are {C:red}debuffed{}.",
					"{C:attention}To Defeat:{} Score a {C:attention}Flush House{} with a {C:spades}dark {C:clubs}suit{}.",
					"{C:attention}Undefeated:{} {C:hearts}Light {C:diamonds}suits{} stay {C:red}permanently debuffed{}.",
				},
			},

			j_rw_spitterspider = {
				name = "Spitter Spider",
				text = {
					"{C:attention}Threat{}: Only {C:attention}Five of a Kind{}, {C:attention}Four of a Kind{}",
					"or {C:attention}Three of a Kind{} hands count for scoring.",
					"{C:attention}To Defeat{}: Play 3 {C:attention}Three of a Kind{}, 2 {C:attention}Four of a Kind{}",
					"and 1 {C:attention}Five of a Kind{}.",
					"{C:inactive}Scored: Five of a Kind[#1#], Four of a Kind[#2#], Three of a Kind[#3#]{}",
					"{C:attention}Undefeated{}: Nothing.",
				},
			},

			j_rw_motherspider = {
				name = "Mother Spider",
				text = {
					"{C:attention}Threat{}: Only {C:attention}High Card{} and {C:attention}Flush House{}",
					"hands count for scoring.",
					"{C:attention}To Defeat{}: Play 5 {C:attention}High Card{} and 1 {C:attention}Flush House.{}",
					"{C:inactive}Scored: High Card[#1#], Flush House[#2#]{}",
					"{C:attention}Undefeated{}: Nothing.",
				},
			},

			j_rw_strawberrylizard = {
				name = "Strawberry Lizard",
				text = {
					"{C:attention}Threat{}: A random Joker is {C:attention}debuffed{}",
					"at the start of {C:attention}Blind{}.",
					"{C:attention}To Defeat{}: Sell a Joker.",
					"{C:attention}Undefeated{}: The last debuffed Joker becomes",
					"{C:purple}Eternal{} and remains debuffed permanently.",
				},
			},

			j_rw_caramellizard = {
				name = "Caramel Lizard",
				text = {
					"{C:attention}Threat{}:{C:food}Food{} cards and {C:food}Food{} packs",
					"no longer appear in the shop.",
					"Jokers that benefit from {C:food}Food{} cards are",
					"{C:attention}reset{} to their default values.",
					"{C:attention}To Defeat{}: Score a lucky card.",
					"{C:attention}Undefeated{}: {C:food}Food{} cards and {C:food}Food{} packs",
					"no longer appear for the rest of the run.",
					"Caramel Lizard leaves.",
				},
			},
			j_rw_vulture = {
				name = "Vulture",
				text = {
					"{C:attention}Threat{}: {C:green}1 in #1#{} chance that hand scores {C:red}0{}.",
					"{C:attention}To Defeat{}: Score #2# {C:weapon}Spears{} of any kind. [{C:attention}#3#{}/#2#]",
					"{s:0.8,C:weapon}(Normal, Explosive, Electric, Fire)",
					"{C:attention}Undefeated{}: All {C:weapon}Weapons{} are",
					"removed from {C:attention}all{} Jokers.",
				},
			},
			j_rw_kingvulture = {
				name = "King Vulture",
				text = {
					"{C:attention}Threat{}: {C:green}1 in #1#{} chance that hand scores {C:red}0{}.",
					"{C:attention}To Defeat{}: Score #2# {C:weapon}Spears{} of any kind. [{C:attention}#3#{}/#2#]",
					"{s:0.8,C:weapon}(Normal, Explosive, Electric, Fire)",
					"{C:attention}Undefeated{}: {C:red}Die{}.",
				},
			},
			j_rw_blackholelizard = {
				name = "Black Hole Lizard",
				text = {
					"{C:attention}Threat{}: {C:inactive}None.",
					"{C:attention}To Defeat{}: Have a Joker with a {C:weapon}Singularity Bomb{}",
					"{s:0.8,C:inactive}(Destroys the Singularity Bomb)",
					"{C:attention}Undefeated{}: {s:1.2,E:1,C:dark_edition}?????",
				},
			},
			j_rw_giantjellyfish = {
				name = "Giant Jellyfish",
				text = {
					"{C:attention}Threat:{} Blinds are {C:attention}#1#%{} larger per Joker",
					"{s:0.8,C:inactive}(Currently {s:0.8,C:attention}+#4#%{s:0.8,C:inactive})",
					"{C:attention}To Defeat:{} Score #2# {C:weapon}Spears{} of any kind [{C:attention}#3#{}/#2#]",
					"{C:attention}Undefeated:{} Lose a random Voucher you've redeemed",
				},
			},
			j_rw_stowaway = {
				name = "Stowaway",
				text = {
					"{C:attention}Threat: {C:green}#1# in #2#{} chance to spawn an Enemy",
					"when Blind is selected",
					"{C:red}Cannot be Defeated: {C:green}#1# in #3#{} chance to go",
					"dormant at end of round",
					"{C:attention}Undefeated: {C:green}#1# in #4#{} chance to destroy",
					"a random Joker",
				},
			},
			j_rw_stowaway_dormant = {
				name = "Stowaway",
				text = {
					"{C:inactive}Sleeping for {C:attention}#1#",
					"{C:inactive}more round(s)...",
				},
			},
			j_rw_redlizard = {
				name = "Red Lizard",
				text = {
					"{C:attention}Threat:{} Halves your Mult before score is totalled",
					"{C:attention}To Defeat:{} Score {C:attention}#1#%{} of the Blind's chips",
					"{C:attention}Undefeated: {C:red}Die",
				},
			},

			j_rw_maturecentipede = {
				name = "Mature Centipede",
				text = {
					"{C:attention}Threat:{} xMult Jokers are {C:attention}disabled{}.",
					"Jokers with xMult {C:weapon}weapons{} are {C:attention}disabled{}.",
					"{C:attention}To Defeat:{} Score {C:attention}3[#1#/3]{} hands.",
					"{C:attention}Undefeated: {C:attention}Destroys{} all disabled Jokers.",
				},
			},

			j_rw_overgrowncentipede = {
				name = "Overgrown Centipede",
				text = {
					"{C:attention}Threat:{} xMult and xChips Jokers are {C:attention}disabled{}.",
					"Jokers with xMult or xChips {C:weapon}weapons{} are {C:attention}disabled{}.",
					"{C:attention}To Defeat:{} Score {C:attention}3[#1#/3]{} hands.",
					"{C:attention}Undefeated: {C:attention}Destroys{} all disabled Jokers.",
				},
			},
			j_rw_jokelizard = {
				name = "Joke Lizard",
				text = {
					"{C:attention}Threat:{} When Blind is selected, {C:green}1 in #1#{}",
					"chance to replace all your Jokers with new ones",
					"{s:0.8,C:inactive}(New Jokers have equal or lesser rarity)",
					"{C:attention}To Defeat: {}Have a Joker with a {C:weapon}Joke Rifle",
					"{C:attention}Undefeated: {C:green}Guaranteed{} to replace your",
					"Jokers, then escapes",
				},
			},
			j_rw_mirosbird = {
				name = "Miros Bird",
				text = {
					"{C:attention}Threat: Blinds{} require double the amount of chips until defeated.",
					"{C:attention}To Defeat:{} Use {C:attention}2{} {C:weapon}Flashbangs{}{C:attention}[#1#/2]{}",
					"{C:attention}Undefeated: All Blinds{} permanently require double the amount of chips.",
					"This effect stacks with its threat effect.",
				},
			},

			j_rw_motherlonglegs = {
				name = "Mother Long Legs",
				text = {
					"{C:attention}Threat{}: At the start of each blind,",
					"{C:green}1 in #1#{} chance for each card",
					"in your deck, hand and jokers to become {C:rot}Rot{}.",
					"{C:attention}To Defeat{}: Score a hand while holding",
					"a {C:weapon}Singularity Bomb{}. [{C:attention}#2#{}/2]",
					"{C:attention}Undefeated{}: Chooses a random {C:attention}rank{} and Joker",
					"and turns it to {C:rot}Rot{} at end of {C:attention}Boss Blind{}.",
				},
			},

			j_rw_hunterlonglegs = {
				name = "Mother Long Legs",
				text = {
					"{C:attention}Threat{}:{C:green}1 in #1#{} chance for a random",
					"Joker to become {C:rot}Rot{} each played hand.",
					"{C:attention}To Defeat{}: Score a card with at least",
					"{C:mult}+6{} extra mult.",
					"{C:attention}Undefeated{}: {C:attention}+1{} Ante",
				},
			},

			j_rw_mirosvulture = {
				name = "Miros Vulture",
				text = {
					"{C:attention}Threat:{} Each {C:attention}played hand{} increases {C:attention}Blind{} requirement by 10%.",
					"{C:attention}To Defeat:{} Use {C:attention}2{} {C:weapon}Flashbangs{}{C:attention}[#1#/2]{}",
					"{C:attention}Undefeated{}: All {C:weapon}Weapons{} are",
					"removed from {C:attention}all{} owned Jokers.",
					"{C:green}#2# in #3#{} chance to end the run.",
				},
			},

			j_rw_firebug_neutral = {
				name = "Firebug",
				text = {
					"Neutral unless provoked.",
					"Having a Joker with a {C:weapon}Sporepuff{} or a {C:weapon}Spear{}",
					"has a {C:green}#1# in #2#{} chance to provoke it",
					"at the start of {C:attention}Blind{}.",
				},
			},

			j_rw_firebug_aggressive = {
				name = "Firebug",
				text = {
					"{C:attention}Threat:{} #1# in #2# chance to destroy a random",
					"{C:attention}rank{} in the deck at the end of round.",
					"{C:attention}To Defeat:{} #1# in #3# chance to defeat it each played hand",
					"if you have a Joker with a {C:weapon}Sporepuff{}.",
					"{C:attention}Undefeated{}: Weapons are 4x less likely to",
					"appear on jokers in the shop.",
				},
			},

			j_rw_trainlizard = {
				name = "Train Lizard",
				text = {
					"{C:attention}Threat:{} Debuffs a random {C:attention}rank{} every hand",
					"or discard. Debuffs a random Joker every {C:attention}round{}.",
					"Joker remains debuffed even if defeated.",
					"{C:attention}To Defeat:{} Sell 3 Jokers[#1#/3] and score 3 hands[#2#/3].",
					"{C:attention}Undefeated{}: {C:red}Die{}.",
				},
			},

			j_rw_leviathan = {
				name = "Leviathan",
				text = {
					"{C:attention}Threat: Blinds{} require double the amount of chips.",
					"The final {C:attention}Blind{} requires four times the amount of chips.",
					"{C:attention}To Defeat:{} Cannot be defeated. Leaves on Ante 9+.",
					"{C:attention}Undefeated{}: {C:red}Die{}.",
				},
			},

			j_rw_redcentipede = {
				name = "Red Centipede",
				text = {
					"{C:attention}Threat: Defeat {C:attention}Blinds{} in one hand.",
					"{C:attention}To Defeat:{} Cannot be defeated. Leaves on Ante 9+.",
					"{C:attention}Undefeated{}: {C:red}Die{}.",
				},
			},

			j_rw_chieftain = {
				name = "Chieftain",
				text = {
					"{C:attention}Threat: Each played hand removes a random {C:weapon}Weapon{} from each Joker.",
					"{C:attention}To Defeat:{} Win a blind while scoring {C:attention}#1#% or more{} of its chips.",
					"{C:attention}Undefeated{}: {C:red}Die{}.",
				},
			},

			--endregion
			--region Slugcats
			j_rw_abundance = {
				name = "Abundance",
				text = {
					"At the start of {C:attention}Blind{},",
					"if there are no empty Joker spaces,",
					"create a random {C:food}Food{} card.",
					"If there are empty Joker spaces,",
					"create a {C:attention}Slugpup{} instead.",
				},
			},
			j_rw_artificer = {
				name = "Artificer",
				text = {
					"Each playing card {C:attention}destroyed",
					"gives {C:chips}+#4#{} chips.",
					"{C:green}#2# in #3#{} chance to {C:attention}destroy",
					"a card when drawing a hand.",
					"Cards {C:attention}destroyed{} with this",
					"ability only give {C:chips}+#5#{} chips.",
					"(Currently {C:chips}#1#{} Chips)",
				},
			},
			j_rw_greedyscugbig = {
				name = "Big and Greedy",
				text = {
					"Each {C:food}Food{} card used",
					"gives {X:mult,C:white}X#2#{} Mult.",
					"Currently {X:mult,C:white}X#1#{} Mult",
				},
			},
			j_rw_greedyscugsmall = {
				name = "Small and Greedy",
				text = {
					"Each {C:food}Food{} card used",
					"gives {X:mult,C:white}X#2#{} Mult.",
					"Currently {X:mult,C:white}X#1#{} Mult",
				},
			},
			j_rw_hunger = {
				name = "Hunger",
				text = {
					"{s:1.2}He hungers...",
					"{s:0.8,C:inactive}({s:0.8,C:blue}+#1#{s:0.8,C:inactive}, {s:0.8,C:red}+#2#{s:0.8,C:inactive}, {s:0.8,C:white,X:red}X#3#{s:0.8,C:inactive})",
				},
			},
			j_rw_gourmand = {
				name = "Gourmand",
				text = {
					"{C:blue}Common{} Food Jokers",
					"give {X:mult,C:white}X#2#{} Mult,",
					"{C:green}Uncommon{} Food Jokers",
					"give {X:mult,C:white}X#3#{} Mult,",
					"{C:food}Food{} cards",
					"give {X:mult,C:white}X#4#{} Mult.",
					"and are {C:attention}destroyed{}.",
					"Currently {X:mult,C:white}X#1#{} Mult",
				},
			},
			j_rw_hunter = {
				name = "Hunter",
				text = {
					"{C:mult}+#4#{} Mult per hand played.",
					"When {C:attention}Blind{} is selected,",
					"{C:green}#1# in #2# chance{} to",
					"increase {C:attention}Ante{} by 1.",
					"(Currently {C:mult}#3# {}Mult)",
				},
			},
			j_rw_inv = {
				name = "Inv",
				text = {
					"{C:green}#1# in #2#{} chance to create",
					"a {C:dark_edition}Negative{} Slugpup at the",
					"end of each {C:attention}Blind{}.",
				},
			},
			j_rw_monk = {
				name = "Monk",
				text = {
					"When {C:attention}Blind{} is selected,",
					"{C:green}#1# in #2#{} chance to",
					"decrease {C:attention}Ante{} by 1.",
				},
			},
			j_rw_rivulet = {
				name = "Rivulet",
				text = {
					"Each skipped {C:attention}Blind{}",
					"adds 1 to 3 {C:attention}Enhanced{}",
					"cards to the deck.",
				},
			},
			j_rw_saintneutral = {
				name = "Saint",
				text = {
					"After discarding {C:attention}#2#{} cards,",
					"Saint becomes {C:edition}Attuned{}.",
					"(#1# more cards)",
				},
			},
			j_rw_saintattuned = {
				name = "Saint {C:edition}(Attuned)",
				text = {
					"At the start of {C:attention}Boss Blind{}",
					"a random Joker is",
					"{C:attention}destroyed{} and",
					"another Joker becomes",
					"{C:purple}Eternal{} AND {C:dark_edition}Negative{}.",
				},
			},
			j_rw_saintrecharging = {
				name = "Saint {C:inactive}(Recharging)",
				text = {
					"Saint is tired...",
					"Discard {C:attention}#1#{} more",
					"cards to recover",
				},
			},
			j_rw_slugpup = {
				name = "Slugpup",
				text = {
					"{C:mult}+#1#{} Mult",
					"{C:chips}+#2#{} Chips",
				},
			},
			j_rw_spearmaster = {
				name = "Spearmaster",
				text = {
					"{C:white,X:mult}X#1#{} Mult if all scoring",
					"cards are {C:attention}Enhanced",
				},
			},
			j_rw_survivor = {
				name = "Survivor",
				text = {
					"{C:green}#1# in #2#{}  chance to",
					"increase hand size by #3#",
					"after defeating {C:attention}Boss Blind.",
					"Currently {C:attention}+#4#{} hand size.",
				},
			},
			j_rw_lacuna = {
				name = "Lacuna",
				text = {
					"At the start of {C:attention}Blind{},",
					"leftmost consumable card",
					"does the following:",
					"{C:planet}Planet{}",
					"{C:green}#1# in 4{} chance to level",
					"up a random {C:attention}poker hand{}.",
					"{C:tarot}Tarot{}",
					"Gives a random {C:tarot}tarot{} card.",
					"{C:spectral}Spectral{}",
					"Gives a random {C:attention}seal{} to a",
					"random {C:attention}card{} in the {C:attention}deck{}.",
					"{C:food}Food{}",
					"{C:green}#1# in 4{} chance to give {C:chips}+20{} chips",
					"to all {C:attention}cards{} in the {C:attention}hand{}.",
					"{C:weapon}Weapon{}",
					"{C:green} #1# in 15{} chance to give a",
					"random {C:weapon}weapon{}",
					"to a random Joker.",
				},
			},
			j_rw_alacrity = {
				name = "Alacrity",
				text = {
					"{X:chips,C:white}X2{} Chips on",
					"the {C:attention}first hand{}",
					"of round.",
				},
			},
			j_rw_magician = {
				name = "Magician",
				text = {
					"(Currently: {C:chips}+#3#{} Chips,",
					"{C:mult}+#5#{} Mult, {X:mult,C:white}X#4#{} Mult",
					"and {X:chips,C:white}X#6#{} Chips.)",
				},
			},
			j_rw_magician_artificer = {
				name = "Magician",
				text = {
					"{C:attention}First hand{} of round",
					"{C:attention}destroys{} a random",
					"card in hand then",
					"gains {C:chips}+50{} Chips.",
					"(Currently: {C:chips}+#3#{} Chips,",
					"{C:mult}+#5#{} Mult, {X:mult,C:white}X#4#{} Mult",
					"and {X:chips,C:white}X#6#{} Chips.)",
				},
			},
			j_rw_magician_bng = {
				name = "Magician",
				text = {
					"Each {C:food}Food{} card used",
					"gives {X:mult,C:white}X0.25{} Mult.",
					"(Currently: {C:chips}+#3#{} Chips,",
					"{C:mult}+#5#{} Mult, {X:mult,C:white}X#4#{} Mult",
					"and {X:chips,C:white}X#6#{} Chips.)",
				},
			},
			j_rw_magician_hunter = {
				name = "Magician",
				text = {
					"{C:mult}+6{} Mult per {C:attention}hand{} played.",
					"(Currently: {C:chips}+#3#{} Chips,",
					"{C:mult}+#5#{} Mult, {X:mult,C:white}X#4#{} Mult",
					"and {X:chips,C:white}X#6#{} Chips.)",
				},
			},
			j_rw_magician_monk = {
				name = "Magician",
				text = {
					"{C:chips}+12{} Chips per {C:attention}hand{} played.",
					"(Currently: {C:chips}+#3#{} Chips,",
					"{C:mult}+#5#{} Mult, {X:mult,C:white}X#4#{} Mult",
					"and {X:chips,C:white}X#6#{} Chips.)",
				},
			},
			j_rw_magician_inv = {
				name = "Magician",
				text = {
					"Creates a {C:edition}Negative{} Slugpup",
					"at the start of {C:attention}Blind{}.",
					"(Currently: {C:chips}+#3#{} Chips,",
					"{C:mult}+#5#{} Mult, {X:mult,C:white}X#4#{} Mult",
					"and {X:chips,C:white}X#6#{} Chips.)",
				},
			},
			j_rw_magician_scugbo = {
				name = "Magician",
				text = {
					"{C:mult}+4{} Mult for",
					"each Slugcat Joker.",
					"(Currently: {C:chips}+#3#{} Chips,",
					"{C:mult}+#5#{} Mult, {X:mult,C:white}X#4#{} Mult",
					"and {X:chips,C:white}X#6#{} Chips.)",
				},
			},
			j_rw_magician_slugpup = {
				name = "Magician",
				text = {
					"{C:mult}+4{} Mult",
					"{C:chips}+10{} Chips",
					"(Currently: {C:chips}+#3#{} Chips,",
					"{C:mult}+#5#{} Mult, {X:mult,C:white}X#4#{} Mult",
					"and {X:chips,C:white}X#6#{} Chips.)",
				},
			},
			j_rw_magician_gourmand = {
				name = "Magician",
				text = {
					"Food Jokers and {C:food}Food{}",
					"cards give {X:mult,C:white}X0.25{} Mult",
					"each and are destroyed.",
					"(Currently: {C:chips}+#3#{} Chips,",
					"{C:mult}+#5#{} Mult, {X:mult,C:white}X#4#{} Mult",
					"and {X:chips,C:white}X#6#{} Chips.)",
				},
			},
			j_rw_magician_rivulet = {
				name = "Magician",
				text = {
					"Each skipped {C:attention}Blind{}",
					"adds 3 {C:attention}Enhanced{}",
					"cards to the deck",
					"and randomizes its",
					"current effect.",
					"(Currently: {C:chips}+#3#{} Chips,",
					"{C:mult}+#5#{} Mult, {X:mult,C:white}X#4#{} Mult",
					"and {X:chips,C:white}X#6#{} Chips.)",
				},
			},
			j_rw_magician_spearmaster = {
				name = "Magician",
				text = {
					"{C:white,X:mult}X3{} Mult if all scoring",
					"cards are {C:attention}Enhanced{}.",
					"(Currently: {C:chips}+#3#{} Chips,",
					"{C:mult}+#5#{} Mult, {X:mult,C:white}X#4#{} Mult",
					"and {X:chips,C:white}X#6#{} Chips.)",
				},
			},
			j_rw_magician_survivor = {
				name = "Magician",
				text = {
					"{C:attention}+2{} hand size",
					"(Currently: {C:chips}+#3#{} Chips,",
					"{C:mult}+#5#{} Mult, {X:mult,C:white}X#4#{} Mult",
					"and {X:chips,C:white}X#6#{} Chips.)",
				},
			},
			j_rw_magician_pathfinder = {
				name = "Magician",
				text = {
					"If {C:attention}discard{} is",
					"a {C:attention}Flush{}",
					"gain a random",
					"{C:tarot}Tarot{} card.",
					"(Currently: {C:chips}+#3#{} Chips,",
					"{C:mult}+#5#{} Mult, {X:mult,C:white}X#4#{} Mult",
					"and {X:chips,C:white}X#6#{} Chips.)",
				},
			},
			j_rw_magician_blurred = {
				name = "Magician",
				text = {
					"{C:green}#1# in 10{} chance to",
					"halve {C:attention}Blind{} Chips",
					"when a {C:attention}hand{}",
					"is played.",
					"(Currently: {C:chips}+#3#{} Chips,",
					"{C:mult}+#5#{} Mult, {X:mult,C:white}X#4#{} Mult",
					"and {X:chips,C:white}X#6#{} Chips.)",
				},
			},
			j_rw_magician_alacrity = {
				name = "Magician",
				text = {
					"{X:chips,C:white}X2{} Chips on",
					"the first {C:attention}hand{}",
					"of round.",
					"(Currently: {C:chips}+#3#{} Chips,",
					"{C:mult}+#5#{} Mult, {X:mult,C:white}X#4#{} Mult",
					"and {X:chips,C:white}X#6#{} Chips.)",
				},
			},
			j_rw_magician_magician = {
				name = "Magician",
				text = {
					"At the start of {C:attention}Blind{},",
					"permanently gains",
					"{C:chips}+2{} Chips, {C:mult}+2{} Mult",
					"{X:chips,C:white}X0.5{} Chips and {X:mult,C:white}X0.5{} Mult.",
					"(Currently: {C:chips}+#3#{} Chips,",
					"{C:mult}+#5#{} Mult, {X:mult,C:white}X#4#{} Mult",
					"and {X:chips,C:white}X#6#{} Chips.)",
				},
			},
			j_rw_magician_enfys = {
				name = "Magician",
				text = {
					"At the start of {C:attention}Blind{},",
					"creates a random,",
					"{C:edition}negative{} Food Joker.",
					"(Currently: {C:chips}+#3#{} Chips,",
					"{C:mult}+#5#{} Mult, {X:mult,C:white}X#4#{} Mult",
					"and {X:chips,C:white}X#6#{} Chips.)",
				},
			},
			j_rw_magician_saint = {
				name = "Magician",
				text = {
					"Each {C:attention}discard{} has",
					"a {C:green}#1# in 20{} chance",
					"to turn a random",
					"Joker {C:edition}Negative{}.",
					"(Currently: {C:chips}+#3#{} Chips,",
					"{C:mult}+#5#{} Mult, {X:mult,C:white}X#4#{} Mult",
					"and {X:chips,C:white}X#6#{} Chips.)",
				},
			},
			j_rw_magician_lacuna = {
				name = "Magician",
				text = {
					"At the start of {C:attention}Blind{},",
					"leftmost consumable card",
					"does the following:",
					"{C:planet}Planet{}",
					"{C:green}#1# in 4{} chance to level",
					"up a random {C:attention}poker hand{}.",
					"{C:tarot}Tarot{}",
					"Gives a random {C:tarot}tarot{} card.",
					"{C:spectral}Spectral{}",
					"Gives a random {C:attention}seal{} to a",
					"random {C:attention}card{} in the {C:attention}deck{}.",
					"{C:food}Food{}",
					"{C:green}#1# in 4{} chance to give {C:chips}+20{} chips",
					"to all {C:attention}cards{} in the {C:attention}hand{}.",
					"{C:weapon}Weapon{}",
					"{C:green} #1# in 15{} chance to give a",
					"random {C:weapon}weapon{}",
					"to a random Joker.",
					"(Currently: {C:chips}+#3#{} Chips,",
					"{C:mult}+#5#{} Mult, {X:mult,C:white}X#4#{} Mult",
					"and {X:chips,C:white}X#6#{} Chips.)",
				},
			},
			j_rw_magician_ranger = {
				name = "Magician",
				text = {
					"{C:attention}+3{} hand size",
					"(Currently: {C:chips}+#3#{} Chips,",
					"{C:mult}+#5#{} Mult, {X:mult,C:white}X#4#{} Mult",
					"and {X:chips,C:white}X#6#{} Chips.)",
				},
			},
			j_rw_arsenal = {
				name = "Arsenal",
				text = {
					"{C:mult}+#1#{} Mult for every {C:weapon}Weapon",
					"held by your Jokers",
					"{C:inactive}(Currently {C:mult}+#2# {C:inactive}Mult)",
				},
			},
			--endregion
			--region Not-Slugcats
			j_rw_scavenger_neutral = {
				name = "Scavenger",
				text = {
					"When Blind is selected, {C:green}#1# in #2#",
					"chance to trade a {C:food}Food{} card",
					"for a {C:weapon}Weapon{} card",
					"{C:inactive}[Reputation: {C:attention}#3#{C:inactive}]",
				},
			},
			j_rw_scavenger_enemy = {
				name = "Scavenger",
				text = {
					"{C:attention}Threat: {C:green}#1# in #2#{} chance to steal",
					"a {C:weapon}Weapon{} from a Joker each hand,",
					"if successful, gives {X:chips,C:white}X#3#{} Chips",
					"{C:inactive}[Reputation: {C:attention}#4#{C:inactive}]",
				},
			},
			j_rw_scavenger_friendly = {
				name = "Scavenger",
				text = {
					"When Blind is selected, {C:green}#1# in #2#",
					"chance to receive a {C:weapon}Weapon{} card;",
					"Otherwise, receive a {C:food}Food{} card",
					"{C:inactive}[Reputation: {C:attention}#3#{C:inactive}]",
				},
			},
			j_rw_ecoboost = {
				name = "Ecoboost",
				text = {
					"This Joker gains {X:chips,C:white}X#1#{} Chips",
					"whenever an {C:rw_enemy}Enemy{} spawns",
					"{C:inactive}(Currently {X:chips,C:white}X#2#{C:inactive} Chips)",
				},
			},
			j_rw_stupid_wet_rat = {
				name = "Stupid Wet Rat",
				text = {
					"{X:chips,C:white}X#1#{} Chips for every",
					"Wet Card in your deck",
					"{C:inactive}(Currently {X:chips,C:white}X#2#{C:inactive} Chips)",
				},
			},
			j_rw_scavendish = {
				name = "Scavendish",
				text = {
					"{X:weapon,C:white} X#1# {} Weapon spawn rate",
					"{C:green}#2# in #3#{} chance this",
					"card is destroyed",
					"at end of round",
				},
			},
			j_rw_threat = {
				name = "Threat",
				text = {
					"{X:mult,C:white}X#1#{} Mult for every",
					"{C:rw_enemy}Enemy{} present",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
				},
			},
			j_rw_surrounded = {
				name = "Surrounded",
				text = {
					"+1 Joker Slot per {C:rw_enemy}Enemy",
					"If there are {C:attention}more {C:rw_enemy}Enemies{} than",
					"other Jokers, Shop cards are {C:money}half-price",
					"{B:1,C:white}#1#",
				},
			},
			j_rw_familypower = {
				name = "Family Power",
				text = {
					"If there are more Jokers than",
					"{C:rw_enemy}Enemies{}, {C:attention}all{} cards of {V:1}#1#",
					"suit trigger {C:attention}#2#{} additional time",
					"{s:0.8,C:inactive}(Suit changes at start of Blind)",
					"{B:2,C:white}#3#",
				},
			},
			j_rw_surv_fittest = {
				name = "Survival of the Fittest",
				text = {
					"Each {C:rw_enemy}Enemy{} defeated this run",
					"gives {C:money}$#1#{} at end of round",
					"{C:inactive}(Currently {C:money}$#2#{C:inactive})",
				},
			},
			j_rw_communication = {
				name = "Mark of Communication",
				text = {
					"Each used {C:attention}Consumable{} has a",
					"{C:green}#1# in #2#{} chance to spawn another",
					"random {C:attention}Consumable",
				},
			},
			--endregion
		},
		Tag = {
			tag_rw_survivalist = {
				name = "Survivalist Tag",
				text = {
					"Shop has a",
					"{C:attention}Slugcat Joker",
				},
			},
			tag_rw_top_pup = {
				name = "Top-Pup Tag",
				text = {
					"Gives a free",
					"{C:dark_edition}Negative {C:attention}Slugpup",
				},
			},
			tag_rw_danger = {
				name = "Danger Tag",
				text = {
					"Encounter an {C:rw_enemy}Enemy",
					"but gain {C:money}$#1#",
					"{s:0.8}50% chance to encounter {s:0.8,C:rw_enemy}two",
				},
			},
			tag_rw_escape = {
				name = "Escape Tag",
				text = {
					"Remove one {C:rw_enemy}Enemy{} from",
					"your Joker slots",
				},
			},
			tag_rw_rivulet = {
				name = "Rivulet Tag",
				text = {
					"Add #1# {C:attention}Enhanced{}",
					"cards to your deck",
				},
			},
			tag_rw_power = {
				name = "Power Tag",
				text = {
					"Gives a free",
					"{C:weapon}Mega Weapon Pack",
				},
			},
			tag_rw_quickequip = {
				name = "Quick-Equip Tag",
				text = {
					"Gives each Joker",
					"a random {C:weapon}Weapon",
				},
			},
			tag_rw_feast = {
				name = "Feast Tag",
				text = {
					"Gives a free",
					"{C:food}Mega Food Pack",
				},
			},
			tag_rw_healthy = {
				name = "Healthy Tag",
				text = {
					"Removes {C:rot}Rot{} from",
					"all cards and Jokers",
				},
			},
		},
	},
	misc = {
		dictionary = {
			k_foodcommon = "Common",
			k_fooduncommon = "Uncommon",
			k_foodrare = "Rare",
			k_enemy = "Enemy",
			k_yoinked_ex = "Yoinked!",
			k_over_elip = "Over...",
			k_under_ex = "Under!",
			k_dormant_elip = "Dormant...",
			k_awake_ex = "Awake!",
			k_plus_weapon = "+1 Weapon",
			k_spear_lodged_elip = "Spear Lodged...",
		},
		v_dictionary = {
			a_reputation = "+#1# Reputation",
			a_reputation_minus = "-#1# Reputation",
			a_score = "+#1# Score",
			a_score_minus = "-#1# Score",
			a_voucher_lost = "Lost #1#...",
		},
	},
}
