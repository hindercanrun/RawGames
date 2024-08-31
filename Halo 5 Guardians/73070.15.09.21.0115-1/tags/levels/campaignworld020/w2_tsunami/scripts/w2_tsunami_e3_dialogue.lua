--## SERVER

-- =====================================================================================================================================
--  _______ _____ _    _ _   _          __  __ _____ 
-- |__   __/ ____| |  | | \ | |   /\   |  \/  |_   _|
--    | | | (___ | |  | |  \| |  /  \  | \  / | | |  
--    | |  \___ \| |  | | . ` | / /\ \ | |\/| | | |  
--    | |  ____) | |__| | |\  |/ ____ \| |  | |_| |_ 
--    |_| |_____/ \____/|_| \_/_/    \_\_|  |_|_____|
--                                                   
-- =====================================================================================================================================                                                                                                                          
                                                                                                                          

-- =================================================================================================
-- *** GLOBALS ***
-- =================================================================================================


-- =================================================================================================
-- *** MAIN ***
-- =================================================================================================



global E3Demo_BEGINS = {
	name = "E3Demo_BEGINS",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
--[[
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Weapons free. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_00100.sound'),
		},
		[2] = {
			sleepBefore = 0.5,
			
			text = "Reinforcers have arrived! Fire!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_cv_elitee3_00500.sound'),
		},
--]]
			[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					
							hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
						sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Let's move. Vale, keep an ear on Comms.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_02400.sound'),
		},
		[2] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
											
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
						sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VaLE
			text = "Affirmative.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_vale_01900.sound'),
		},
		[3] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
						sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE (ALT)
			text = "Buck, Tanaka, defensive positions.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_02900.sound'),
		},
	};

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};
global E3Demo_wounded_elite = {
	name = "E3Demo_wounded_elite",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {

			text = "I will never bow to Infidels ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_cv_elitee3_00400.sound'),
		},
	};

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};
global E3Demo_arcade = {
	name = "E3Demo_arcade",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
													hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: taNAKA
			text = "Seem to have missed the party.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_tanaka_01800.sound'),
		},
	};

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};
global E3Demo_TRACKING_ROOM_enter = {
	name = "E3Demo_TRACKING_ROOM_enter",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Do we know if the Chief come this way?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_buck_03100.sound'),
		},
		[2] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Let's see. Activating the Artemis.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_01100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_TRACKING_ROOM_ping = {
	name = "E3Demo_TRACKING_ROOM_ping",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Got a reading.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_01200.sound'),
		},
		[2] = {
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Vale, do you see this too?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_02300.sound'),
		},
				[3] = {
													OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Let me take a look.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_vale_03300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};



global E3Demo_TRACKING_ROOM_approach_clue = {
	name = "E3Demo_TRACKING_ROOM_approach_clue",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
						text = "Chief's assault rifle. No ammo.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_vale_00600.sound'),
		},
		[2] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "The Master Chief's been through here then.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_tanaka_00700.sound'),
		},
				[3] = {		
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
						sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Which means he has a head start on the Guardian. Let's get moving.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_00400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};
global E3Demo_grunts_die = {
	name = "E3Demo_grunts_die",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			
			text = "[pain and death noises]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_cv_grunte3_00600.sound'),
		},

	};
	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_shade_turret_attack = {
	name = "E3Demo_shade_turret_attack",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Take cover!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_tanaka_00100.sound'),
		},
		[2] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Buck. Focus Hydra fire on that turret.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_00200.sound'),
		},
		[3] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "You got it, Locke.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_buck_00100.sound'),
		},
	};	
	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_shade_turret_destroyed = {
	name = "E3Demo_shade_turret_destroyed",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		
		[1] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Problem solved.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_buck_00200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_PLASMACASTER_arrives = {
	name = "E3Demo_PLASMACASTER_arrives",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "To the left!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_vale_00100.sound'),
		},
		[2] = {
			
			text = "Destroy them!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_cv_elitee3_00100.sound'),
		},
		[3] = {
			
			text = "Charge the humans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_cv_grunte3_00300.sound'),
		},
		[4] = {
			
			text = "Stay right there and let me shoot you!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_cv_grunte3_00400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};
global E3Demo_PLASMACASTER_dies = {
	name = "E3Demo_PLASMACASTER_dies",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			
			text = "[pain and death noises]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_cv_elitee3_00200.sound'),
		},


	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


global E3Demo_PLASMACASTER_grunt_dies = {
	name = "E3Demo_PLASMACASTER_grunt_dies",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {

			text = "[pain and death noises]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_cv_grunte3_00500.sound'),
		},


	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


global E3Demo_JACKALS_arrive = {
	name = "E3Demo_JACKALS_arrive",

	CanStart = function (thisConvo, queue)
		return false; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
			hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Incoming Jackals!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_tanaka_00200.sound'),
		},
		[2] = {
			
			text = "Charge! Charge!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_cv_jackale3_00100.sound'),
		},
		[3] = {
			
			text = "Open fire!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_cv_jackale3_00200.sound'),
		},
			},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};



global E3Demo_JACKALS_die = {
	name = "E3Demo_JACKALS_die",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
			hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Get moving. We're not letting the Chief reach the Guardian.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_00400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_grunt_runsaway = {
	name = "E3Demo_grunt_runsaway",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			
			text = "Help! Helphelp!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_cv_grunte3_00800.sound'),
		},
--           001_VO_AI_CV_Grunt02_02Combat_PanicPlasmaGrenadeGR_00500.wav

		[2] = {
			
			text = "I regret everything!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_cv_grunte3_00900.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};
global E3Demo_ELITE_ZEALOT_arrives = {
	name = "E3Demo_ELITE_ZEALOT_arrives",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Elite! Active camo!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_buck_00300.sound'),
		},
		[2] = {
			
			text = "Gods guide my wrath!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_cv_elitee3_00300.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_ELITE_ZEALOT_dies = {
	name = "E3Demo_ELITE_ZEALOT_dies",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Nice work, Locke.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_tanaka_00300.sound'),
		},
--           Osiris continues through the door.

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_PHANTOM_CHASES_SPIRIT = {
	name = "E3Demo_PHANTOM_CHASES_SPIRIT",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Looks like Arbiter's doing a good job of running the Covenant out of town.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_vale_00200.sound'),
		},
		[2] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "He's been fighting for this moment a long time, Vale. The Covenant's finally breaking.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_00500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_GUARDIAN_RISES = {
	name = "E3Demo_GUARDIAN_RISES",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "There's the Guardian!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_tanaka_01600.sound'),
		},
		[2] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Think the Chief's already on board?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_buck_00400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_GUARDIAN_RISES_incoming = {
	name = "E3Demo_GUARDIAN_RISES_incoming",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

				[1] = {
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Watch out!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_tanaka_00600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};
global E3Demo_GUARDIAN_pelican_crash = {
	name = "E3Demo_GUARDIAN_pelican_crash",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Everyone in one piece?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_00600.sound'),
		},
		[2] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Affirmative.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_tanaka_00500.sound'),
		},
		[3] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "I think so?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_buck_00500.sound'),
		},
		[4] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Yeah.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_vale_00400.sound'),
		},
		[5] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "This is our only path to the Guardian. Get moving!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_00700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


global E3Demo_DESTRUCTION_ALLEY_start = {
	name = "E3Demo_DESTRUCTION_ALLEY_start",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Watch out!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_tanaka_00600.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_DESTRUCTION_ALLEY_second = {
	name = "E3Demo_DESTRUCTION_ALLEY_second",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Keep your head down and run!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_00800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_DESTRUCTION_ALLEY_locke_falls = {
	name = "E3Demo_DESTRUCTION_ALLEY_locke_falls",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Locke!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_vale_00500.sound'),
		},
				[2] = {
											OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 2.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "I'm okay. Keep going!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_00900.sound'),
		},
				
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_DESTRUCTION_ALLEY_buck_gogo = {
	name = "E3Demo_DESTRUCTION_ALLEY_buck_gogo",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
				[1] = {
											OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Go! Go! Move, Spartans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_buck_02000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_DESTRUCTION_ALLEY_locke_stand = {
	name = "E3Demo_DESTRUCTION_ALLEY_locke_stand",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
	[1] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "I'm okay.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_00900.sound'),
		},
--           Osiris reaches the end of the crumbling ground and dive into
--           the tracking room.

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


global E3Demo_TRACKING_ROOM_enter_made = {
	name = "E3Demo_TRACKING_ROOM_enter_made",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Made it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_01000.sound'),
		},
				[2] = {
										OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BuCK
			text = "Yeah, safe and sound inside a crumbling building.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_buck_02600.sound'),
		},
				[3] = {
										OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
						sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Better than the bottom of the ocean...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_tanaka_01500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_TRACKING_ROOM_soldier_fx = {
	name = "E3Demo_TRACKING_ROOM_soldier_fx",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
												OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Did you see that?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_vale_02900.sound'),
		},
		[2] = {
												OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
						sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "You think it's Prometheans?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_buck_02700.sound'),
		},
		--[[[3] = {
												OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
						sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "I think it's dangerous. Be ready for anything.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_02600.sound'),
		},]]
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_SOLDIER_ATTACK = {
	name = "E3Demo_SOLDIER_ATTACK",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Incoming!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_vale_00300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_SOLDIER_ATTACK_2 = {
	name = "E3Demo_SOLDIER_ATTACK_2",



	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Heads up! Promethean Soldiers!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_buck_00700.sound'),
		},
--           A Soldier teleports down

		[2] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Open fire!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_01300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};
global E3Demo_SOLDIER_away = {
	name = "E3Demo_SOLDIER_away",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Thought we only had Covenant forces to deal with here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_vale_00700.sound'),
		},
		[2] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "The Guardian's active, so are its defense systems. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_01400.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_DOOR_SCENE = {
	name = "E3Demo_DOOR_SCENE",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Move in and clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_01500.sound'),
		},

		[2] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepbefore = 3,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Prometheans everywhere.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_buck_00900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_PHAETON_ROOM_PHAETON_FIGHT = {
	name = "E3Demo_PHAETON_ROOM_PHAETON_FIGHT",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Phaeton!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_tanaka_00800.sound'),
		},
--[[
		[2] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Buck, light it up!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_01600.sound'),
		},
				[3] = {
											OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
						sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "You got it!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_buck_01800.sound'),
		},
--]]
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_PHAETON_ROOM_PHAETON_light_it_up = {
	name = "E3Demo_PHAETON_ROOM_PHAETON_light_it_up",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Buck, light it up!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_01600.sound'),
		},
		[2] = {
											OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
						sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "You got it!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_buck_01800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_PHAETON_ROOM_PHAETON_down = {
	name = "E3Demo_PHAETON_ROOM_PHAETON_down",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
			[1] = {
												OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Target down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_buck_01900.sound'),
		},
		
		[2] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Tanaka! Help, Vale!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_02000.sound'),
		},
		[3] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "On it!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_tanaka_01100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


global E3Demo_post_phaeton_ramp_climb = {
	name = "E3Demo_post_phaeton_ramp_climb",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "So... Chief was fighting Covenant, but not Prometheans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_vale_02300.sound'),
		},
		[2] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
						text = "Vale's right.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_buck_01000.sound'),
		},
		[3] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "So, what? Prometheans just let the Chief walk through?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_tanaka_00900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_post_phaeton_soldier_appears = {
	name = "E3Demo_post_phaeton_soldier_appears",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		
		[1] = {
			
			text = "Target profiles are complete.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_fr_soldiere3_00100.sound'),
		},
		[2] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: taNAKA
			text = "Soldiers!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_tanaka_01900.sound'),
		},
--           Locke shotgun blasts the Soldiers.

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_FINAL_FIGHT_AREA_ENTER = {
	name = "E3Demo_FINAL_FIGHT_AREA_ENTER",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Well, whatever deal the Chief had, they're not letting us through.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_buck_01100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};
global E3Demo_FINAL_FIGHT_AREA_scan = {
	name = "E3Demo_FINAL_FIGHT_AREA_scan",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Weapon cache up there. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_01700.sound'),
		},
		[2] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Vale, Tanaka, flank left. Buck, head up with me.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_01800.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_PLASMACASTER_pickup = {
	name = "E3Demo_PLASMACASTER_pickup",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
			hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Plasma caster. Perfect.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_00300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_THE_BIG_FIGHT = {
	name = "E3Demo_THE_BIG_FIGHT",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
			hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "More soldiers!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_buck_01300.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_SOLDIER_captains = {
	name = "E3Demo_SOLDIER_captains",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BuCK
			text = "Soldier Captains on deck!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_buck_04600.sound'),
		},
		[2] = {
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Take them down!\r\n\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_04600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


global E3Demo_buck_on_turret = {
	name = "E3Demo_buck_on_turret",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
		
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Soldiers!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_buck_01300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_buck_on_turret_soldiers = {
	name = "E3Demo_buck_on_turret_soldiers",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
			hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Soldiers!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_buck_01300.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};



global E3Demo_KNIGHT_appears = {
	name = "E3Demo_KNIGHT_appears",



	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Knight on the field! Surround and contain.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_01900.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_KNIGHT_one_plate = {
	name = "E3Demo_KNIGHT_ASSASSINATION",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "That's one!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_tanaka_01000.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_two_plate = {
	name = "E3Demo_two_plate",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
	

		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Two!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_vale_01200.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_phaeton_vale_hit = {
	name = "E3Demo_phaeton_vale_hit",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "[pained emote] I'm down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_vale_01700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};



global E3Demo_tanaka_helps_vale = {
	name = "E3Demo_tanaka_helps_vale",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
			hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "On your feet, Spartan.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_tanaka_02000.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};
global E3Demo_KNIGHT_ASSASSINATION_post = {
	name = "E3Demo_KNIGHT_ASSASSINATION_post",



	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
			hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "You okay, Vale?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_02100.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
			hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Yeah. Thanks, Tanaka.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_vale_01500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


global E3Demo_fire_on_knight = {
	name = "E3Demo_fire_on_knight",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			
			text = "[screech sfx]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_fr_knighte3_00100.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
			hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Buck! Now!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_02700.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_buck_on_knight = {
	name = "E3Demo_buck_on_knight",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
			hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BuCK
			text = "Time to dance. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_buck_02400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_reach_the_guardian = {
	name = "E3Demo_reach_the_guardian",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VaLE
			text = "Okay... we made it to the Guardian.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_vale_02700.sound'),
		},
		[2] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Yeah, but where's the Chief?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_tanaka_02400.sound'),
		},
		[3] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BuCK
			text = "My money says he's already on board.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_buck_02900.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_buck_downs_knight = {
	name = "E3Demo_buck_downs_knight",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
	
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
			hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Well done, Buck.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_02800.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
			hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "I aim to please... and for the brain stem.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_buck_02500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_Warden_callout = {
	name = "E3Demo_Warden_callout",
-- fasdf

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

	
		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Warden!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_locke_05200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


global E3Demo_reach_Guardian = {
	name = "E3Demo_reach_Guardian",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VaLE
			text = "We made it. There's the Guardian.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_vale_02600.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};
global E3Demo_WARDEN_APPEARS = {
	name = "E3Demo_WARDEN_APPEARS",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
	
			text = "I am the Warden Eternal. Keeper of the Domain and her secrets.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_fr_wardeneternal_00100.sound'),
		},

	},
	 
	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global E3Demo_slipspace_portal = {
	name = "E3Demo_slipspace_portal",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						hud_set_radio_transmission_team_string_id("Osiristeam_transmission_name");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: taNAKA
			text = "Locke! Slipspace portal.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_e3demo\001_vo_scr_e3demo_un_tanaka_01200.sound'),
		},


	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


