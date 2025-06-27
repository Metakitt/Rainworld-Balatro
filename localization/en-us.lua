--Note: Make sure that for the food consumables they are all referred to as "Food Card". Food also uses its own custom color code, simply 'food'.
return {
    descriptions = {
	 
        Enhanced = {
		
		m_rw_rotting = {
		name = 'Rot',
		text = {
		    '{C:chips}-25{} chips',
            'This card is rotting away.',
			'[#1#] rounds to destruction.'	
		},
	},
		
		
		
        },	
		Other = {
		
		rw_wsporepuff = {
        name = 'Sporepuff',
        text = { 
		    "Decreases required", 
            "chips by {C:attention}5%{}.",
        },
    },

        rw_wbeehive = {
        name = 'Beehive',
        text = { "At the start of {C:attention}Boss{}", 
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
        name = 'Cherrybomb',
        text = { 
		    "{C:mult}+6~12{} Mult."
        },
    },

        rw_wsingularity = {
		name = 'Singularity Bomb',
		text = { 
		    "If {C:attention}first hand{}",
			"of round has only", 
			"{C:attention}1{} card,{C:attention} destroys{}", 
			"your entire{C:attention} hand{}",
			"and wins the blind.", 
			"{C:inactive}One-time use{}."
        },
    },

        rw_wgrenade = {
        name = 'Grenade',
        text = { 
		    "If {C:attention}first discard{} of", 
			"round has only {C:attention}1{} card", 
			"{C:attention}destroy{} it. Gains {C:mult}+3{}", 
			"Mult for each {C:attention}card{}",
			"{C:attention}destroyed{} by Grenade",
			"this run.",
			"{C:inactive}(Currently {}{C:mult}+#1#{}{C:inactive}){}"
        },
    },

        rw_wgrenade2 = {
        name = 'Grenade',
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
        name = 'Flashbang',
        text = { 
		    "Re-rolls the next {C:attention}Boss{}", 
		    "{C:attention}Blind{} when a {C:attention}Blind{}", 
		    "is skipped.", 
		    "{C:inactive}One-time use{}."
        },
    },


        rw_wrock = {
        name = 'Rock',
        text = { 
		    "{X:chips,C:white}2x{} Chips",
        },
    },
		
		rw_wspear = {
		name = 'Spear',
		text = { 
             "{X:mult,C:white}1.5x{} Mult",
        },
    },
	
	    rw_hunter_wspear = {
        name = '2nd Spear',
		text = { "1.75x Mult when Held",
        },
    },

		rw_wspear_monk_inv = {
		name = 'Spear',
		text = { "{X:mult,C:white}1.25x{} Mult",
		},
    },

		rw_wspear_hunter_artificer_spearmaster = {
		name = 'Spear',
		text = { "{X:mult,C:white}1.75x{} Mult",
		},
    },

		rw_wspear_gourmand = {
		name = 'Spear',
		text = { 
		"{X:mult,C:white}3x{} Mult",
		"{C:green}1 in 4{} chance to be",
		"exhausted and give",
		"{X:mult,C:white}0.9x{}Mult instead."
		},
    },

		rw_wspear_exp = {
		name = 'Explosive Spear',
		text = {
		    "{X:mult,C:white}3x{} Mult", 
			"{C:green}1 in 6{} chance to", 
			"{C:attention}destroy{} a random card", 
			"in {C:attention}hand{} when scoring.",
		},
    },

		rw_wspear_exp_monk_inv = {
		name = 'Explosive Spear',
		text = {
		    "{X:mult,C:white}2.5x{} Mult", 
			"{C:green}1 in 6{} chance to", 
			"{C:attention}destroy{} a random card", 
			"in {C:attention}hand{} when scoring.",
		},
    },

		rw_wspear_exp_hunter_artificer_spearmaster = {
		name = 'Explosive Spear',
		text = { 
            "{X:mult,C:white}3.5x{} Mult", 
			"{C:green}1 in 6{} chance to", 
			"{C:attention}destroy{} a random card", 
			"in {C:attention}hand{} when scoring.",
		},
	},

		rw_wspear_exp_gourmand = {
		name = 'Explosive Spear',
		text = { 
			"{X:mult,C:white}6x{} Mult",
			"{C:green}1 in 4{} chance to be",
			"exhausted and give",
			"{X:mult,C:white}0.9x{} Mult instead.",
			"{C:green}1 in 6{} chance to", 
			"{C:attention}destroy{} a random card", 
			"in {C:attention}hand{} when scoring."
		},
	},

		rw_wspear_ele = {
		name = 'Electric Spear',
		text = { 
			"{X:mult,C:white}1.5x{} Mult", 
			"If Seltzer or Splash", 
			"is present, gives", 
			"{X:chips,C:white}1.5x{} Chips as well.",
		},
    },

		rw_wspear_ele_monk_inv = {
		name = 'Electric Spear',
		text = { 
     	   "{X:mult,C:white}1.25x{} Mult", 
			"If Seltzer or Splash", 
			"is present, gives", 
			"{X:chips,C:white}1.25x{} Chips as well.",
		},
    },

		rw_wspear_ele_hunter_artificer_spearmaster = {
		name = 'Electric Spear',
		text = { 
			"{X:mult,C:white}1.75x{} Mult", 
			"If Seltzer or Splash", 
			"is present, gives", 
			"{X:chips,C:white}1.75x{} Chips as well.",
		},
	},

		rw_wspear_ele_gourmand = {
		name = 'Electric Spear',
		text = { 
			"{X:mult,C:white}3x{} Mult", 
			"If Seltzer or Splash", 
			"is present, gives", 
			"{X:chips,C:white}3x{} Chips as well.",
    	    "{C:green}1 in 4{} chance to be",
     	   "exhausted and give {X:mult,C:white}0.9x Mult{}",
    	    "and {X:chips,C:white}0.9x{} Chips{C:inactive}(With Seltzer/Splash){} instead.",
		},
    },

		rw_wspear_fire = {
		name = 'Fire Spear',
		text = { 
			"{X:mult,C:white}4.5x{} Mult", 
			"Increases required", 
			"chips by {C:attention}5%{}."
		},
	},

		rw_wspear_fire_monk_inv = {
		name = 'Fire Spear',
		text = { 
			"{X:mult,C:white}3.25x{} Mult", 
			"Increases required", 
			"chips by {C:attention}5%{}."
		},
	},

		rw_wspear_fire_hunter_artificer_spearmaster = {
		name = 'Fire Spear',
		text = { 
			"{X:mult,C:white}5.25x{} Mult", 
			"Increases required", 
			"chips by {C:attention}5%{}."
		},
	},

		rw_wspear_fire_gourmand = {
		name = 'Fire Spear',
		text = { 
			"{X:mult,C:white}9x{} Mult", 
			"Increases required", 
			"chips by {C:attention}5%{}.",
			"{C:green}1 in 4{} chance to be",
			"exhausted and give",
			"{X:mult,C:white}0.5x{} Mult instead."
		},
	},

		rw_wspear_fire_saint = {
		name = 'Fire Spear',
		text = { 
			"{X:mult,C:white}10x{} Mult", 
			"Increases required", 
			"chips by {C:attention}5%{}."
		},
	},

		rw_wjokerifle = {
		name = 'Joke Rifle',
		text = {
			"At the start", 
			"of {C:attention}Blind{},",
			"selects a", 
			"random effect.",
			"{C:inactive}(Loaded with: Nothing){}",
			"Does nothing."
		},
	},

		rw_wjokerifle_bluefruit = {
		name = 'Joke Rifle',
		text = {
			"At the start", 
			"of {C:attention}Blind{},",
			"selects a", 
			"random effect.",
			"{C:inactive}(Loaded with: Blue Fruit){}",
			"{C:attention}Cards{} in the {C:attention}first{}", 
			"{C:attention}played hand{} gains", 
			"{C:chips}+15{} extra chips."
		},
	},

		rw_wjokerifle_rock = {
		name = 'Joke Rifle',
		text = {
			"At the start", 
			"of {C:attention}Blind{},",
			"selects a", 
			"random effect.",
			"{C:inactive}(Loaded with: Rock){}",
			"{X:chips,C:white}2x{} Chips"
		},
	},

		rw_wjokerifle_pearl = {
		name = 'Joke Rifle',
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
			"Joker {C:edition}Polychrome{}."
		},
	},

		rw_wjokerifle_cherrybomb = {
		name = 'Joke Rifle',
		text = {
			"At the start", 
			"of {C:attention}Blind{},",
			"selects a", 
			"random effect.",
			"{C:inactive}(Loaded with: Cherrybomb){}",
			"{C:mult}+6~12{} Mult."
		},
	},

		rw_wjokerifle_beehive = {
		name = 'Joke Rifle',
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
		name = 'Joke Rifle',
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
		name = 'Joke Rifle',
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
		    "{C:inactive}(Currently {}{C:mult}+#1#{}{C:inactive}){}"
		},
	},

		rw_wjokerifle_sporepuff = {
		name = 'Joke Rifle',
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
		name = 'Joke Rifle',
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
			"and wins the blind."
		},
	},


		},
	
	    foods = {
		
		c_rw_bluefruit = {
		name = 'Blue Fruit',
		text = {
            'Permanently gives',
			'{C:chips}+15{} extra Chips',
			'to one card.'
		},
	},
	
		c_rw_rotting2 = {
		name = 'Rot Fruit',
		text = {
            'Makes your card Rot.',
			'For testing purpose only.'
		},
	},
	
	    c_rw_bubblefruit = {
		name = 'Bubble Fruit',
		text = {
            'If Rivulet, Splash,',
			'Diet Cola or Seltzer',
			'is present:',
			"{X:chips,C:white}4x{} to {C:attention}one{} card's", 
			"extra chips.",
			"Otherwise, {X:chips,C:white}2x{} to {C:attention}one{}",
         	"card's extra chips."
		},
	},
	
	    c_rw_gooieduck = {
        name = 'Gooieduck',
        text = {
            'Permanently gives',
            '{C:chips}+2{} Chips to all cards',
            'in {C:attention}hand{}. Can be', 
			'used {C:attention}two{} times.',
       }
    },
	
	    c_rw_dandepeach = {
		name = 'Dandelion Peach',
		text = {
            'Adds a random playing',
			'card with {C:chips}+20{} extra',
			'chips to your hand.'
		}
	},
	
	    c_rw_slimemold = {
		name = 'Slime Mold',
		text = {
            'Permanently gives',
			'{C:mult}+7{} Mult', 
			'to {C:attention}two{} cards.'
		}
	},
	
	    c_rw_lilypuck = {
		name = 'Lilypuck',
		text = {
            'Adds a permanent',
			'copy of a random',
			'{C:attention}card{} in your {C:attention}hand{}',
			'to the {C:attention}deck{}', 
			'and draws it.'
		}
	},
	
	    c_rw_eggbugegg = {
		name = 'Eggbug Egg',
		text = {
            'Every {C:attention}card{} of', 
			'a random {C:attention}suit{}',
			'in the {C:attention}deck{} gains',
			'{C:chips}+4{} extra chips.'
		}
	},
	
	    c_rw_fireegg = {
		name = 'Fire Egg',
		text = {
            'Every {C:attention}card{} of', 
			'a random {C:attention}suit{}',
			'in the {C:attention}deck{} gains',
			'{C:mult}+4{} extra mult.'
		}
	},
	
	    c_rw_popcornplant = {
		name = 'Popcorn Plant',
		text = {
            'Every {C:attention}card{} of', 
			'a random {C:attention}suit{}',
			'in the {C:attention}deck{} gains',
			'{C:mult}+2{} extra mult and',
			'{C:chips}+2{} extra chips.'
		}
	},
	
	    c_rw_glowweed = {
		name = 'Glow Weed',
		text = {
            '{C:green}#1# in #2#{} chance',
			'two selected cards',
			'become {C:edition}Foil{}.'
		}
	},
	
	    c_rw_mushroom = {
		name = 'Mushroom',
		text = {
                        '{C:green}#1# in #2#{} chance to halve',
			'current {C:attention}Blind{} chip',
			'requirement.',
			'{C:green}#1# in #3# chance to add',
			'a copy of itself',
			'after being used.'
		}
	},
	
		c_rw_karmaf = {
		name = 'Karma Flower',
		text = {
            '-{C:attention}1{} Ante.'
		}
	},
	
	    c_rw_neuronfly = {
		name = 'Neuron Fly',
		text = {
                        '+1 {C:attention}hand{} size.'
		}
	},
	
		
		},
        Joker = {
		
		j_rw_greenlizard = {
		name = "Green Lizard",
		text = {
		        "{C:green}Enemy{}",
			"{C:attention}Threat{}: {C:green}1 in 2{} chance",
			"to destroy a random joker",
			"at the {C:attention}end of round{}.",
			"{C:attention}To Defeat{}: Score a {C:attention}Flush{}.",
			"{C:attention}Undefeated{}: {C:green}1 in 3{} chance to destroy",
			"each of your jokers at the",
			"end of {C:attention}Boss Blind{}."
			},
			},
			
			j_rw_pinklizard = {
		name = "Pink Lizard",
		text = {
		        "{C:green}Enemy{}",
			"{C:attention}Threat{}: {C:green}1 in 2{} chance",
			"to destroy a random card",
                        "in the deck after playing a hand.",
			"{C:attention}To Defeat{}: Score a {C:attention}Straight{}.",
			"{C:attention}Undefeated{}: {C:green}1 in 20{} chance to destroy",
			"each card in your deck at the",
			"end of {C:attention}Boss Blind{}."
			},
			},
			
			j_rw_youngcentipede = {
		name = "Young Centipede",
		text = {
		    "{C:green}Enemy{}",
			"{C:attention}Threat{}: None.",
			"{C:attention}To Defeat{}: Score a {C:attention}Four of a Kind{}.",
			"{C:attention}Undefeated{}: -{C:attention} 10${} at",
			"the end of {C:attention}Boss Blind{}."
			},
			},
			
			j_rw_wormgrass = {
		name = "Wormgrass",
		text = {
		        "{C:green}Enemy{}",
			"{C:attention}Threat{}: Destroys cards after they've been played.",
			"{C:attention}To Defeat{}: Score 1000 chips.",
			"{C:attention}Undefeated{}: Nothing."
			},
			},
			
			j_rw_brotherlonglegs = {
		name = "Brother Long Legs",
		text = {
		    "{C:green}Enemy{}",
			"{C:attention}Threat{}: At the start of each blind,", 
			"1 in 20 chance for each card",
                        "in your deck to become rot.",
			"{C:attention}To Defeat{}: Score a hand while holding an explosive spear.",
			"{C:attention}Undefeated{}:Chooses a random rank and turns it",  
			" to rot at end of {C:attention}Boss Blind{}."
			},
			},
			
			j_rw_bluelizard = {
		name = "Blue Lizard",
		text = {
		    "{C:green}Enemy{}",
			"{C:attention}Threat{}: x0.75 Chips .",
			"{C:attention}To Defeat{}: Score a card with at least 10 extra chips.",
			"{C:attention}Undefeated{}: Each card in your", 
			"deck gets -5 extra chips at the",
			"end of {C:attention}Boss Blind{}."
			},
			},

			j_rw_redleech = {
		name = "Red Leech",
		text = {
		        "{C:green}Enemy{}",
			"{C:attention}Threat{}:-20 Chips. Each played hand has a {C:green}1 in 3{}", 
			"chance to spawn a new red leech.",
			"{C:attention}To Defeat{}: Play two High Cards hands.",
			"{C:attention}Undefeated{}:  Destroys a random joker at",
			"the end of {C:attention}Boss Blind{}."
			},
			},

			j_rw_coalescipede = {
		name = "Coalescipede",
		text = {
		    "{C:green}Enemy{}",
			"{C:attention}Threat{}: -1 Chips per Coalescipede.",
			"{C:attention}To Defeat{}: Have a Joker with a Flashbang.",
			"{C:attention}Undefeated{}: Spawns two more Coalescipede at",
			"the end of {C:attention}Boss Blind{}."
			},
			},
			
         j_rw_jungleleech = {
		name = "Jungle Leech",
		text = {
		    "{C:green}Enemy{}",
			"{C:attention}Threat{}: -0.5 Mult.", 
			"{C:green}1 in 2{} chance to gain -0.1 Mult",
			"and {C:green}1 in 10{} chance to spawn another", 
			"Jungle Leech each hand played.",
			"{C:attention}To Defeat{}: Sell a {C:food}Food{} card and play five High Card hands.",
			"{C:attention}Undefeated{}: {C:green}1 in 20{} chance to remove {C:food}Food{} cards from the shop."
			},
			},
			
		
		j_rw_abundance = { 
		name = "Abundance",
		text = {
			"At the start of {C:attention}Blind{},",
			"if there are no empty Joker spaces,",
			"create {C:attention}1{} random {C:food}Food{} card.",
			"If there are empty Joker spaces,",
			"create {C:attention}1{} Slugpup instead." 
			},
		},
		
		j_rw_artificer = {
		name = 'Artificer',
		text = {
			"Each playing card {C:attention}destroyed{}",
			"gives {C:chips}+50{} chips.",
			"{C:green}#2# in #3#{} chance to {C:attention}destroy{}",
			"a card when drawing a hand.",
			"Cards {C:attention}destroyed{} with this",
			"ability only give {C:chips}+25{} chips.",
            "(Currently {C:chips}#1#{} Chips)"
		     },
		},
		
		j_rw_greedyscugbig = {
		name = 'Big and Greedy',
		text = {
			"Each {C:food}Food{} card used",
			"gives {X:mult,C:white}0.25x{} Mult.",
			"Currently {X:mult,C:white}x#1#{} Mult"
		}
	},
	
	j_rw_greedyscugsmall = {
		name = 'Small and Greedy',
		text = {
			"Each {C:food}Food{} card used",
			"gives {X:mult,C:white}0.25x{} Mult.",
			"Currently {X:mult,C:white}x#1#{} Mult"
		}
	},
	
	j_rw_hunger = {
	name = 'Hunger',
		text = {
            "He hungers."
		}
	},
	
	j_rw_gourmand = {
	name = 'Gourmand',
		text = {
            "{C:blue}Common{} Food Jokers", 
			"give {X:mult,C:white}0.25x{} Mult,",
			"{C:green}Uncommon{} Food Jokers", 
			"give {X:mult,C:white}0.50x{} Mult,",
			"{C:food}Food{} cards",
			"give {X:mult,C:white}0.10x{} Mult.",
			"and are {C:attention}destroyed{}.",
			"Currently {C:mult}x#1#{} Mult"
		}
	},
	
	j_rw_hunter = {
		name = 'Hunter',
		text = {
			"{C:mult}+8{} Mult per hand played.",
			"When {C:attention}Blind{} is selected,",
            "{C:green}#1# in #2# chance{} to",
            "increase {C:attention}Ante{} by 1.",	
			"(Currently {C:mult}#3# {}Mult)"
		}
	},
	
	j_rw_inv = {
        name = 'Inv',
        text = {
	     "{C:green}#1# in #2#{} chance to create",
			"a Negative Slugpup at the",
			"end of a {C:attention}Blind{}."
		}
	},
	
	j_rw_monk = {
		name = 'Monk',
		text = {
			"When {C:attention}Blind{} is selected,",
			"{C:green}#1# in #2#{} chance to",
            "decrease {C:attention}Ante{} by 1."
		}
	},
	
	j_rw_rivulet = {
		name = 'Rivulet',
		text = {
            "Each skipped {C:attention}Blind{}",
			"adds 1 to 3 {C:attention}Enhanced{}",
			"cards to the deck."
		}
	},
	
		j_rw_saintneutral = {
		name = 'Saint',
		text = {
            "Every {C:attention}25{}[#1#] cards discarded,",
			"Saint becomes {C:edition}Attuned{}.",
			"Recharging?: #2#"
		
		}
	},
	
		j_rw_saintattuned = {
		name = '{C:edition}Saint(Attuned)',
		text = {
			"At the start of {C:attention}Boss Blind{}",
			"a random Joker is",
			"{C:attention}destroyed{} and",
			"another Joker becomes", 
			"{C:purple}Eternal{} AND {C:edition}Negative{}.",
		}
	},
	
		j_rw_slugpup = {
		name = 'Slugpup',
		text = {
			"{C:mult}+4{} Mult",
			"{C:chips}+10{} Chips"
		
		}
	},
	
	    j_rw_spearmaster = {
		name = 'Spearmaster',
		text = {
            "{C:mult}3x Mult{} if all scoring",
			"cards are Enhanced."
		}
	},
    
	    j_rw_survivor = {
		name = 'Survivor',
		text = {
            "{C:green}#1# in #2#{}  chance to",
            "increase hand size by #3#",	
			"after defeating {C:attention}Boss Blind.",
		    "Currently {C:attention}+#4#{} hand size."
		}
	},
	
	    j_rw_lacuna = {
		name = 'Lacuna',
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
			"random {C:weapon}weapon{}" ,
			"to a random Joker.",			
		}
	},

	
	
	j_rw_magician = {
		name = 'Magician',
		text = {
         "(Currently: {C:chips}+#3#{} Chips,", 
			"{C:mult}+#5#{} Mult, {X:mult,C:white}#4#x{} Mult",
			"and {X:chips,C:white}#6#x{} Chips.)"
		}
	},
	
		j_rw_magician_artificer = {
		name = 'Magician',
		text = {
            "{C:attention}First hand{} of round",
			"{C:attention}destroys{} a random",
            "card in hand then",
			"gains {C:chips}+50{} Chips.",
			"(Currently: {C:chips}+#3#{} Chips,", 
			"{C:mult}+#5#{} Mult, {X:mult,C:white}#4#x{} Mult",
			"and {X:chips,C:white}#6#x{} Chips.)"
		}
	},
	
	j_rw_magician_bng = {
		name = 'Magician',
		text = {
           "Each {C:food}Food{} card used",
			"gives {X:mult,C:white}0.25x{} Mult.",
			"(Currently: {C:chips}+#3#{} Chips,", 
			"{C:mult}+#5#{} Mult, {X:mult,C:white}#4#x{} Mult",
			"and {X:chips,C:white}#6#x{} Chips.)"
		}
	},
	
	j_rw_magician_hunter = {
		name = 'Magician',
		text = {
           "{C:mult}+6{} Mult per {C:attention}hand{} played.",
			"(Currently: {C:chips}+#3#{} Chips,", 
			"{C:mult}+#5#{} Mult, {X:mult,C:white}#4#x{} Mult",
			"and {X:chips,C:white}#6#x{} Chips.)"
		}
	},
	
		j_rw_magician_monk = {
		name = 'Magician',
		text = {
           "{C:chips}+12{} Chips per {C:attention}hand{} played.",
			"(Currently: {C:chips}+#3#{} Chips,", 
			"{C:mult}+#5#{} Mult, {X:mult,C:white}#4#x{} Mult",
			"and {X:chips,C:white}#6#x{} Chips.)"
		}
	},
	
	j_rw_magician_inv = {
		name = 'Magician',
		text = {
           "Creates a {C:edition}Negative{} Slugpup",
		   "at the start of {C:attention}Blind{}.",
			"(Currently: {C:chips}+#3#{} Chips,", 
			"{C:mult}+#5#{} Mult, {X:mult,C:white}#4#x{} Mult",
			"and {X:chips,C:white}#6#x{} Chips.)"
		}
	},
	
	j_rw_magician_scugbo = {
		name = 'Magician',
		text = {
           "{C:mult}+4{} Mult for",
			"each Slugcat Joker.",
			"(Currently: {C:chips}+#3#{} Chips,", 
			"{C:mult}+#5#{} Mult, {X:mult,C:white}#4#x{} Mult",
			"and {X:chips,C:white}#6#x{} Chips.)"
		}
	},
	
	j_rw_magician_slugpup = {
		name = 'Magician',
		text = {
          "{C:mult}+4{} Mult",
			"{C:chips}+10{} Chips",
			"(Currently: {C:chips}+#3#{} Chips,", 
			"{C:mult}+#5#{} Mult, {X:mult,C:white}#4#x{} Mult",
			"and {X:chips,C:white}#6#x{} Chips.)"
		}
	},
	
	j_rw_magician_gourmand = {
		name = 'Magician',
		text = {
			"Food Jokers and {C:food}Food{}",
			"cards give {X:mult,C:white}0.25x{} Mult",
			"each and are destroyed.",
			"(Currently: {C:chips}+#3#{} Chips,", 
			"{C:mult}+#5#{} Mult, {X:mult,C:white}#4#x{} Mult",
			"and {X:chips,C:white}#6#x{} Chips.)"
		}
	},
	
		j_rw_magician_rivulet = {
		name = 'Magician',
		text = {
			"Each skipped {C:attention}Blind{}",
			"adds 3 {C:attention}Enhanced{}",
			"cards to the deck",
			"and randomizes its",
			"current effect.",
			"(Currently: {C:chips}+#3#{} Chips,", 
			"{C:mult}+#5#{} Mult, {X:mult,C:white}#4#x{} Mult",
			"and {X:chips,C:white}#6#x{} Chips.)"
		}
	},
	
	j_rw_magician_spearmaster = {
		name = 'Magician',
		text = {
			"{C:mult}3x Mult{} if all scoring",
			"cards are {C:attention}Enhanced{}.",
			"(Currently: {C:chips}+#3#{} Chips,", 
			"{C:mult}+#5#{} Mult, {X:mult,C:white}#4#x{} Mult",
			"and {X:chips,C:white}#6#x{} Chips.)"
		}
	},
	
		j_rw_magician_survivor = {
		name = 'Magician',
		text = {
			"{C:attention}+2{} hand size",
			"(Currently: {C:chips}+#3#{} Chips,", 
			"{C:mult}+#5#{} Mult, {X:mult,C:white}#4#x{} Mult",
			"and {X:chips,C:white}#6#x{} Chips.)"
		}
	},
	
	j_rw_magician_pathfinder = {
		name = 'Magician',
		text = {
			  "If {C:attention}discard{} is",
			"a {C:attention}Flush{}",
			"gain a random",
			"{C:tarot}Tarot{} card.",
			"(Currently: {C:chips}+#3#{} Chips,", 
			"{C:mult}+#5#{} Mult, {X:mult,C:white}#4#x{} Mult",
			"and {X:chips,C:white}#6#x{} Chips.)"
		}
	},
	
		j_rw_magician_blurred = {
		name = 'Magician',
		text = {
			"{C:green}#1# in 10{} chance to",
			"halve {C:attention}Blind{} Chips",
			"when a {C:attention}hand{}",
			"is played.",
			"(Currently: {C:chips}+#3#{} Chips,", 
			"{C:mult}+#5#{} Mult, {X:mult,C:white}#4#x{} Mult",
			"and {X:chips,C:white}#6#x{} Chips.)"
		}
	},
	
	j_rw_magician_alacrity = {
		name = 'Magician',
		text = {
			"{X:chips,C:white}2x{} Chips on",
			"the first {C:attention}hand{}",
			"of round.",
			"(Currently: {C:chips}+#3#{} Chips,", 
			"{C:mult}+#5#{} Mult, {X:mult,C:white}#4#x{} Mult",
			"and {X:chips,C:white}#6#x{} Chips.)"
		}
	},
	
	j_rw_magician_magician = {
		name = 'Magician',
		text = {
		    "At the start of {C:attention}Blind{},",
			"permanently gains",
			"{C:chips}+2{} Chips, {C:mult}+2{} Mult",
			"{X:chips,C:white}0.5x{} Chips and {X:mult,C:white}0.5x{} Mult.",
		    "(Currently: {C:chips}+#3#{} Chips,", 
			"{C:mult}+#5#{} Mult, {X:mult,C:white}#4#x{} Mult",
			"and {X:chips,C:white}#6#x{} Chips.)"
		}
	},
	
	j_rw_magician_enfys = {
		name = 'Magician',
		text = {
		    "At the start of {C:attention}Blind{},",
			"creates a random,",
			"{C:edition}negative{} Food Joker.",
			"(Currently: {C:chips}+#3#{} Chips,", 
			"{C:mult}+#5#{} Mult, {X:mult,C:white}#4#x{} Mult",
			"and {X:chips,C:white}#6#x{} Chips.)"
		}
	},
	
		j_rw_magician_saint = {
		name = 'Magician',
		text = {
		    "Each {C:attention}discard{} has",
		    "a {C:green}#1# in 20{} chance",
			"to turn a random",
			"Joker {C:edition}Negative{}.",
			"(Currently: {C:chips}+#3#{} Chips,", 
			"{C:mult}+#5#{} Mult, {X:mult,C:white}#4#x{} Mult",
			"and {X:chips,C:white}#6#x{} Chips.)"
		}
	},
	
	j_rw_magician_lacuna = {
		name = 'Magician',
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
			"random {C:weapon}weapon{}" ,
			"to a random Joker.",
			"(Currently: {C:chips}+#3#{} Chips,", 
			"{C:mult}+#5#{} Mult, {X:mult,C:white}#4#x{} Mult",
			"and {X:chips,C:white}#6#x{} Chips.)"
		}
	},
	
	j_rw_magician_ranger = {
		name = 'Magician',
		text = {
		   "{C:attention}+3{} hand size",
			"(Currently: {C:chips}+#3#{} Chips,", 
			"{C:mult}+#5#{} Mult, {X:mult,C:white}#4#x{} Mult",
			"and {X:chips,C:white}#6#x{} Chips.)"
		}
	},
	
		
		},
    },
	misc = {
	dictionary = {
	
	k_foodcommon = "Common",
	k_fooduncommon = "Uncommon",
	k_foodrare = "Rare",
	
	},
	},
	
	
	
   
}

