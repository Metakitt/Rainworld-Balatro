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
					"in your deck to become Rot.",
					"{C:attention}To Defeat{}: Score a hand while holding an {C:attention}Explosive Spear{}.",
					"{C:attention}Undefeated{}: Chooses a random {C:attention}rank{} and turns it",
					"to Rot at end of {C:attention}Boss Blind{}.",
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
					"{C:attention}Threat{}: {C:chips}-1{} Chip per {C:attention}Coalescipede{}. {C:inactive}[{C:chips}#1#{C:inactive} from all]",
					"Each played hand has a {C:green}1 in #2# chance",
					"to spawn another {C:attention}Coalescipede{}.",
					"{C:attention}To Defeat{}: Have a Joker with a {C:attention}Flashbang{}.",
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
					"{C:attention}To Defeat:{} Score a hand while holding an {C:attention}Explosive Spear{}.",
					"{C:attention}Undefeated:{} Chance goes up. Maxes out at {C:green}1 in 2{}.",
				},
			},
			j_rw_daddylonglegs = {
				name = "Daddy Long Legs",
				text = {
					"{C:attention}Threat{}: At the start of each blind,",
					"{C:green}1 in #1#{} chance for each card",
					"in your deck to become Rot.",
					"{C:attention}To Defeat{}: Score two hands while holding",
					"an {C:attention}Explosive Spear{}. [{C:attention}#2#{}/2]",
					"{C:attention}Undefeated{}: Chooses a random {C:attention}suit{} and turns it",
					"to Rot at end of {C:attention}Boss Blind{}.",
				},
			},
			j_rw_salamander = {
				name = "Salamander",
				text = {
					"{C:attention}Threat{}: At the start of each blind,",
					"{C:green}1 in #1#{} chance for each card",
					"in your deck to become Wet.",
					"{C:attention}To Defeat{}: Use 4 {C:tarot}Tarot{} Cards. [{C:attention}#2#{}/4]",
					"{C:attention}Undefeated{}: Wet cards become Rot Cards.",
				},
			},
			j_rw_monsterkelp = {
				name = "Monster Kelp",
				text = {
					"{C:attention}Threat{}: {C:chips}#1#{} chips",
					"{C:attention}To Defeat{}: Score two hands while holding",
					"a {C:attention}Flashbang or Spear{}. [{C:attention}#2#{}/2]",
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
					"{C:attention}To Defeat{}: Have a Joker with a {C:mult}+#2#{} Mult {C:attention}Grenade{}.",
					"{C:attention}Undefeated{}: {C:attention}All{} Wet cards are {C:red}destroyed{}.",
				},
			},
			j_rw_centiwing = {
				name = "Centiwing",
				text = {
					"{C:attention}Threat{}: #1# Chips after scoring.",
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
					"{C:attention}To Defeat{}: Play a hand with an {C:attention}Electric Spear{}.",
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

			--endregion
			--region Slugcats + Other Jokers
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
					"Currently {C:mult}X#1#{} Mult",
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
					"{C:mult}X#1#{} Mult if all scoring",
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
					"{C:mult}X3 Mult{} if all scoring",
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
			--endregion
		},
	},
	misc = {
		dictionary = {
			k_foodcommon = "Common",
			k_fooduncommon = "Uncommon",
			k_foodrare = "Rare",
			k_enemy = "Enemy",
		},
	},
}
