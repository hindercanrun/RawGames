--## SERVER

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ WORLD 03 NARRATIVE - HALSEY *_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*

-- =================================================================================================
-- =================================================================================================b
-- =================================================================================================
-- *** GLOBALS ***
-- =================================================================================================		

	global clamber_volume_hit:boolean=false;
	global vale_does_something_awesome:boolean=false;
	global buck_does_something_awesome:boolean=false;
	global tanaka_does_something_awesome:boolean=false;
	global b_big_battle_start:boolean=false;
	global all_knights_cleared:boolean=false;
	global b_halsey_line:boolean=false;
	global cliffside_moved_on:boolean=false;
	global tracking_system_hit:boolean=false;
	global airlock_move_on:boolean=false;
	global b_moved_into_temple:boolean=false;
	global b_moved_into_vault:boolean=false;
	global vault_battle_complete:boolean=false;
	global crag_moved_on:boolean=false;
	global b_big_battle_complete:boolean=false;
	global b_killed_all:boolean=false;
	global nar_airlock_post_played:boolean=false;
	global kraken_lines_playing:boolean=false;
	global crag_battle_entered:boolean=false;
	global b_halsey_idle_chatter_on:boolean = false;
	global camp_moved_on:boolean = false;
	global b_shoulder_bash_done = false;
	global b_halsey_chatter_1_played:boolean = false;
	global b_halsey_chatter_2_played:boolean = false;
	global b_halsey_chatter_3_played:boolean = false;
	global b_halsey_chatter_4_played:boolean = false;
	global b_halsey_chatter_5_played:boolean = false;
	global b_halsey_chatter_6_played:boolean = false;
	global b_tracking_pinged:boolean = false;
	global b_halsey_tracking_tutorial:boolean = false;
	global b_transmission_received:boolean = false;
	global b_end_architecture_convo:boolean = false;
	global b_kraken_leaving:boolean = false;
	global b_mission_start:boolean = false;
--/////////////////////////////////////////////////////////////////////////////////
-- MAIN
--/////////////////////////////////////////////////////////////////////////////////

function nar_halsey_init():void
	print("::: HALSEY NARRATIVE START :::");
	--Wake(dormant.halsey_level_start);
	CreateThread(nar_beginning_ai_off);
	NarrativeQueue.QueueConversation(nar_camp_intro);
	CreateThread(nar_camp_battle_controller);
	NarrativeQueue.QueueConversation(nar_bash_intro);
		CreateThread(nar_function_soldier_chatter_stop);
				NarrativeQueue.QueueConversation(nar_structure_view);
				NarrativeQueue.QueueConversation(nar_infidel_elite);
	b_mission_start = true;
	--156430 -- deleting the kill for subtitles -- it will go into the bink when skipping/ending
end


function nar_goal_halsey_camp():void
	
	print("nar_goal_halsey_camp");

	
	
	
	
end
	
function nar_goal_halsey_cliffside():void	
	print("nar_goal_halsey_cliffside");
	
	
end
	
function nar_goal_halsey_steps():void
	print("nar_goal_halsey_steps");
	CreateThread(nar_proceed_to_bowl);
end
	
function nar_goal_halsey_crag():void
--SleepUntil([| list_count(players()) ~= 0], 10);
--	story_blurb_add("domain", "CRAG STARTED");
	print("nar_goal_halsey_crag");
	
	NarrativeQueue.QueueConversation(nar_crag_intro);
	
end
	
function nar_goal_halsey_airlock():void
	print("nar_goal_halsey_airlock");
	NarrativeQueue.QueueConversation(nar_airlock_intro);
	--SleepUntil([| list_count(players()) ~= 0], 10);
	CreateThread(nar_airlock_entered);
	CreateThread(nar_tracking_system_used);
	RegisterSpartanTrackingPingObjectEvent(halsey_ping_vo, OBJECTS.dc_tr_airlock_02)
	CreateThread(nar_button_listener);
end
	
function nar_goal_halsey_overlook():void
	print("nar_goal_halsey_overlook");
	--SleepUntil([| list_count(players()) ~= 0], 10);
	
	NarrativeQueue.QueueConversation(nar_overlook_kraken);
end
	
function nar_goal_halsey_hill():void
	print("nar_goal_halsey_hill");
	--SleepUntil([| list_count(players()) ~= 0], 10);
			
	CreateThread(nar_hill_area_enter);
	NarrativeQueue.QueueConversation(nar_hill_intro);
	NarrativeQueue.QueueConversation(W3Halsey_KAMTCHATKA__KRAKEN_LEAVES);
	NarrativeQueue.QueueConversation(nar_hallway_intro);
	CreateThread(nar_halsey_infiltration_enter);
end
	
function nar_goal_halsey_hallway():void
	print("nar_goal_halsey_hallway");
	--SleepUntil([| list_count(players()) ~= 0], 10);
	NarrativeQueue.QueueConversation(nar_hallway_hack);
	
end
	
function nar_goal_halsey_vault():void
	print("nar_goal_halsey_vault");
	
	--SleepUntil([| list_count(players()) ~= 0], 10);
	NarrativeQueue.QueueConversation(nar_vault_intro);
	--NarrativeQueue.QueueConversation(nar_vault_elites);
	
	CreateThread(nar_vault_enter_boolean);
	NarrativeQueue.QueueConversation(nar_control_room_intro);
	--NarrativeQueue.QueueConversation(nar_vault_elitevo);
	CreateThread(nar_control_room_enter);
	
end
	
function nar_goal_halsey_control_room():void
	print("nar_goal_halsey_control_room");
	--SleepUntil([| list_count(players()) ~= 0], 10);
	--NarrativeQueue.QueueConversation(nar_halsey_domain_murals);
end




-- =================================================================================================
--
--					CAMP SECTION
--
-- Covers content in the camp.
--
-- =================================================================================================

function sound_impulse_start_client_narr_go(soundTag:tag, theObject:object, theScale:number):void
print('PASS 3');
	RunClientScript("sound_impulse_start_client_narr", soundTag, theObject, theScale);

end



function nar_bink_test()
	sleep_s(2);
	print("nar_bink_test");
		RunClientScript("nar_test_bink1");
	
end

function nar_bink_test2()
	sleep_s(2);
	print("nar_bink_test2");
	RunClientScript("nar_test_bink2");
	
end

global nar_camp_intro = {
	name = "nar_camp_intro",

	Priority = function (self, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	sleepBefore = 8.75,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_camp_intro narrative");
		AIDialogManager.DisableAIDialog(AI.sg_camp_all);
		
		--PlayDialogOnClients(TAG('sound\001_vo\001_vo_ai\001_vo_ai_elite01\001_vo_ai_cv_elite01_01contact_seefoeel.sound'), OBJECTS.elite_audio_cue);
		--hud_show_radio_transmission_portrait(TAG('fx\bitmaps\arrays\single\tech\cortana_orb_01.bitmap'));
	end,

	lines = {

	
		[1] = {

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "INCOMING!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_05000.sound'),
		},
		[2] = {
			sleepBefore = 5,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck,
			text = "Buck: We could've taken 'em.!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_VO_SCR_W3Halsey_UN_Buck_00800.sound'),
		},

	},

	OnFinish = function (thisConvo, queue) -- VOID
	hud_hide_radio_transmission_hud();
		AIDialogManager.EnableAIDialog();
		NarrativeQueue.QueueConversation(nar_camp_buck_advice);
		CreateThread(nar_beginning_ai_off);
	end,
};

function nar_beginning_ai_off()
AIDialogManager.EnableAIDialog();
AIDialogManager.DisableAIDialog(AI.sg_camp_all);
		
end


function camp_nudge_manager()
	sleep_s(60);
	SleepUntil( [| b_collectible_used == false ], 1);
	if crag_battle_entered == false then
		--	story_blurb_add("domain", "nudge1");
		NarrativeQueue.QueueConversation(W3Halsey_Secondary__Push_forward_nudges);
	end
end





global W3Halsey_Secondary__Push_forward_nudges = {
	name = "W3Halsey_Secondary__Push_forward_nudges",



	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
			
	end,

	lines = {
		[1] = {
				If = function (thisLine, thisConvo, queue, lineNumber)
				return b_collectible_used == false; -- GAMMA_TRANSITION: If vale
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Halsey and Jul aren't just going to wait around for us. Maybe we should get a move on.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_buck_03700.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global nar_infidel_elite = {
	name = "nar_infidel_elite",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return objects_distance_to_object(players_human(),ai_get_object(AI.vin_intro_ship_crash_squad.ship_crash_eli_injured)) < 3;
	end,

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.NPC;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		
	end,

	lines = {
		[1] = {
			character = AI.vin_intro_ship_crash_squad.ship_crash_eli_injured, -- GAMMA_CHARACTER: ELITE01
			text = "I will never bow to Infidels",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_cv_elite01_01300.sound'),
		},
--                                                   CUT TO:
--           ________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		--[[]]
	end,

	localVariables = {},
};

global nar_intro_gruntvo = {
	name = "nar_intro_gruntvo",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return objects_distance_to_object(players_human(),ai_get_object(AI.sq_camp_01.spawn_points_0)) < 4;
	end,

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.NPC;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_intro_gruntvo narrative");
		--	story_blurb_add("domain", "GRUNT VO");
		AIDialogManager.DisableAIDialog();
		
	end,

	lines = {
		[1] = {
			character = AI.sq_camp_01.spawn_points_0,
			text = "Grunt01 : Humans now?!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_cv_grunt01_00100.sound'),
	
		},
	--	[2] = {
	--		character = AI.sq_camp_02.spawn_points_0,
	--		text = "Grunt02 : No kolo steaks are worth this!",
	--		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_cv_grunt02_00100.sound'),
	--	},
	},

	OnFinish = function (thisConvo, queue) -- VOID
		AIDialogManager.EnableAIDialog();
		
	end,
};


global nar_camp_buck_advice = {
	name = "nar_camp_buck_advice",



	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_camp_intro narrative");
		AIDialogManager.DisableAIDialog();
		
		--ShowMissionTempPip("COVENANT COMM SIGNAL", 5)
	end,

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	sleepBefore = 1,

	lines = {
		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Let's move. Vale, keep an ear on Comms. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_07400.sound'),
		},
		[2] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VaLE
			text = "Affirmative.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_06400.sound'),
		},
		[3] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Buck, Tanaka, pull security.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_07500.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[4] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "On it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_06000.sound'),
		},
		[5] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BuCK
			text = "Aye.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_buck_06300.sound'),
			sleepAfter = 0.5,
		},


	},

	OnFinish = function (thisConvo, queue) -- VOID
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
		CreateThread(camp_nudge_manager);
				NarrativeQueue.QueueConversation(nar_intro_gruntvo);
		
		
	end,
	localVariables = {
		checkConditionsPassed = 0,
	},
};

global nar_structure_view = {
	name = "nar_structure_view",
		CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_camp_buck_advice); -- GAMMA_CONDITION
	end,
		canStartOnce = true,	

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_camp_intro narrative");
		AIDialogManager.DisableAIDialog();
			RunClientScript("pip_halsey_forerunnertemple_60");
		--ShowMissionTempPip("COVENANT COMM SIGNAL", 5)
	end,

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,


	lines = {
	
				[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Halsey and Mdama are holed up inside a Forerunner structure ahead. That's our target.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_07100.sound'),
		},
		[2] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "So Halsey called us?",
			sleepBefore = 1,
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_06900.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				
				return 3;
			end,
			
		},
		[3] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "She said there was something big happening and gave Captain Lasky coordinates to find her.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_06600.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				
				return 4;
			end,
			
		},
				[4] = {
					If = function (thisLine, thisConvo, queue, lineNumber)
				return not volume_test_players(VOLUMES.nar_battle_begins);
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "It must be something big.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_00700.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not volume_test_players(VOLUMES.nar_battle_begins);
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Or one hell of a trap.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_buck_05500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue) -- VOID
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
		CreateThread(new_objective, TITLES.obj_halsey_1, false);
				
		
		
		
	end,
	localVariables = {
		checkConditionsPassed = 0,
	},
};


function nar_camp_battle_controller()
	SleepUntil( [| volume_test_players(VOLUMES.nar_battle_begins) ],1);
	print("CRAG BATTLE ENTERED");
	--CreateThread(audio_halsey_thread_up_intro_cliffside);
	AIDialogManager.EnableAIDialog();
	NarrativeQueue.QueueConversation(W3Halsey_Kamtchatka__First_combat);
	crag_battle_entered = true;
	sleep_s(3);
	NarrativeQueue.QueueConversation(nar_camp_battle_enter_elitevo);		
			NarrativeQueue.QueueConversation(nar_cliffside_battlecomplete);
end

global W3Halsey_Kamtchatka__First_combat = {
	name = "W3Halsey_Kamtchatka__First_combat",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_battle_begins, SPARTANS.vale);
			end,
										OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Contact.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_06500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_battle_begins, SPARTANS.buck);
			end,
										OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Contact.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_buck_06400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_battle_begins, SPARTANS.tanaka);
			end,
										OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Contact.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_06100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_battle_begins, SPARTANS.locke);
			end,
										OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Contact.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_07600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


global nar_camp_battle_enter_elitevo = {
	name = "nar_camp_battle_enter_elitevo",


CanStart = function (thisConvo, queue) -- BOOLEAN
		if (thisConvo.localVariables.checkConditionsPassed == 0) then
			if object_index_valid(AI.sq_cliff_cov_04.spawn_points_0) then
				thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.sq_cliff_cov_04.spawn_points_0)) < 8 and cliffside_moved_on == false;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
end,
	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.NPC;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_camp_battle_reveal narrative");
		--	story_blurb_add("domain", "ELITE CALLOUT");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
		[1] = {
			character = AI.sq_cliff_cov_04.spawn_points_0,
			text = "Elite01 : They must not break through the line to Mdama!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_VO_SCR_W3Halsey_CV_ELITE01_00900.sound'),
			sleepAfter = 0,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[2] = {
			character = AI.sq_cliff_cov_04.spawn_points_0,
			text = "Elite01 : Mdamas work must continue or Sanghelios is lost to us!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_cv_elite01_01100.sound'),
			sleepAfter = 0,
		},
	},

	OnFinish = function (thisConvo, queue) -- VOID
		AIDialogManager.EnableAIDialog();
		
	end,
		localVariables = {
		checkConditionsPassed = 0,
	},
};



global nar_cliffside_battlecomplete = {
	name = "nar_cliffside_battlecomplete",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return ai_living_count(AI.sg_cliff_all) < 0.5 and ai_living_count(AI.vin_pawns_v_grunt_squad) < 0.5 and ai_living_count(AI.vin_crawlers_tug_war_grunt) < 0.5 and ai_living_count(AI.pawn_v_jackal_squad) < 0.5 and cliffside_moved_on == false;
	end,

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,
	
	sleepBefore = 2,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_battle_look narrative");
		
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
		[1] = {
				If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_battle_begins, SPARTANS.vale) and unit_get_health( SPARTANS.vale) > 0; -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,
			
			sleepBefore = 1,
			
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Vale : Needs text.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_02600.sound'),
			sleepAfter = 0,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
			
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_battle_begins, SPARTANS.buck) and unit_get_health( SPARTANS.buck) > 0; -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,
			sleepBefore = 1,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Buck : Needs text.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_buck_01300.sound'),
			sleepAfter = 0,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
			
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_battle_begins, SPARTANS.tanaka) and unit_get_health( SPARTANS.tanaka) > 0; -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,
		sleepBefore = 1,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Tanaka : Needs text.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_01700.sound'),
			sleepAfter = 0,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_battle_begins, SPARTANS.locke) and unit_get_health( SPARTANS.locke) > 0; -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,
		sleepBefore = 1,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Locke: Needs text.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_00100.sound'),
			sleepAfter = 0,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[5] = {

									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 1,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Locke: Needs text.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_02600.sound'),
			sleepAfter = 0,

			
		},
	},

	OnFinish = function (thisConvo, queue) -- VOID
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
		CreateThread(cliffside_nudge_manager);
		CreateThread(halsey_idle_chatter_start);
		CreateThread(nar_function_soldier_chatter_off);
	end,
};
	

function cliffside_nudge_manager()
	sleep_s(75);
	SleepUntil( [| b_collectible_used == false ], 1);
	if cliffside_moved_on == false then
		--	story_blurb_add("domain", "nudge1");
		NarrativeQueue.QueueConversation(nar_cliffside_pushforward);
	end
end

global nar_cliffside_pushforward = {
	name = "nar_cliffside_pushforward",
		CanStart = function (thisConvo, queue)
		return (b_halsey_idle_chatter_on == false) ; -- GAMMA_CONDITION
	end,

	

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_cliffside_pushforward narrative");
	--	story_blurb_add("domain", "nudge2");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
		[1] = {
				If = function (thisLine, thisConvo, queue, lineNumber)
				return b_collectible_used == false; -- GAMMA_TRANSITION: If vale
			end,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Locke : Needs text.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_02700.sound'),
			sleepAfter = 0,
			
			
		},
	},

	OnFinish = function (thisConvo, queue) -- VOID
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
	end,
};

-- =================================================================================================
--
--					HALSEY STEPS
--
-- Covers content in the steps section.
--
-- =================================================================================================

global nar_steps_clamber_introduction = {
	name = "halsey_clamber_introduction",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return volume_test_players(VOLUMES.nar_steps_jul_discussion);
	end,

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_steps_clamber_introduction narrative");
		clamber_volume_hit = true;
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_steps_jul_discussion, SPARTANS.vale);
			end,

									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Vale : Needs text!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_02800.sound'),
			sleepAfter = 0,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_steps_jul_discussion, SPARTANS.tanaka);
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Tanaka :  Needs text.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_01900.sound'),
			sleepAfter = 0,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[3] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_steps_jul_discussion, SPARTANS.buck);
			end,

										OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Buck : Needs text.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_buck_02400.sound'),
			sleepAfter = 0,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[4] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_steps_jul_discussion, SPARTANS.locke);
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Locke : Needs text.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_02800.sound'),
			sleepAfter = 0,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[5] = {

								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Tanaka :  Needs text.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_02100.sound'),
			sleepAfter = 0,

	
		},
	},

	OnFinish = function (thisConvo, queue) -- VOID
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
	end,
};

global nar_steps_jul_discussion = {
	name = "halsey_jul_discussion",

	
	CanStart = function (thisConvo, queue) -- BOOLEAN
		return volume_test_players(VOLUMES.nar_steps_jul_discussion);
	end,
	

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_steps_jul_discussion narrative");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Vale : 'Mdama's alliance with the Prometheans doesn't seem to be going well.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_00100.sound'),
			sleepAfter = 0,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[2] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Locke :Even so, ‘Mdama’s the de fact head of the Covenant. Which means he’s still a threat.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_00600.sound'),
			sleepAfter = 0,
		},
		[3] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Locke :But if he goes down, chances are good the whole thing falls with him.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_04500.sound'),
			sleepAfter = 0,
		},
	},

	OnFinish = function (thisConvo, queue) -- VOID
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
	end,
	localVariables = {
		checkConditionsPassed = 0,
	},
};



-- =================================================================================================
--
--					CRAG SECTION
--
-- Covers content in the crag section.
--
-- =================================================================================================
function nar_function_soldier_chatter_off()
SleepUntil([| volume_test_players(VOLUMES.nar_steps_chatter_off)], 1);
	CreateThread(halsey_idle_chatter_off);
	
end

function nar_function_soldier_chatter_stop()
SleepUntil([| volume_test_players(VOLUMES.tv_steps_sol_spawn)], 1);
		CreateThread(halsey_idle_chatter_off);
		cliffside_moved_on = true;
		AIDialogManager.DisableAIDialog();
	NarrativeQueue.QueueConversation(W3Halsey_Kamtchatka__SOLDIER_CHASE);
	sleep_s(10);
	AIDialogManager.EnableAIDialog();
end

global W3Halsey_Kamtchatka__SOLDIER_CHASE = {
	name = "W3Halsey_Kamtchatka__SOLDIER_CHASE",
		CanStart = function (thisConvo, queue) -- BOOLEAN
		return volume_test_players(VOLUMES.tv_steps_sol_spawn);
	end,

	canStartOnce = true,

	
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		
	end,

	lines = {

		[1] = {
		If = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.tv_steps_sol_spawn02, SPARTANS.vale);
			end,
			sleepBefore = 1,
			
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale -- GAMMA_CHARACTER: VALE
			text = "Forerunner soldiers!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_00400.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.tv_steps_sol_spawn02, SPARTANS.locke);
			end,
			sleepBefore = 1,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke -- GAMMA_CHARACTER: Locke
			text = "Forerunner soldiers!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_06100.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.tv_steps_sol_spawn02, SPARTANS.buck);
			end,
			sleepBefore = 1,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Forerunner soldiers!\r\n\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_buck_04700.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.tv_steps_sol_spawn02, SPARTANS.tanaka);
			end,
			sleepBefore = 1,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka -- GAMMA_CHARACTER: TANAKA
			text = "Forerunner soldiers!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_04500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		
		[5] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke -- GAMMA_CHARACTER: locke
			text = "Up the cliffs. Get after them.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_06300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},


	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global nar_bash_intro = {
	name = "nar_bash_intro",
CanStart = function (thisConvo, queue) -- BOOLEAN
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if volume_test_players(VOLUMES.nar_bash_intro) then
			thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_can_see_object( players_human(), OBJECTS.sc_shoulderbash_steps01, 8 ) and b_shoulder_bash_done == false;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,
		canStartOnce = true,
	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_bash_intro narrative");
		
		AIDialogManager.DisableAIDialog();
	end,

	lines = {

	[1] = {
		If = function(thisLine, thisConvo, queue, lineNumber)
				return objects_can_see_object( SPARTANS.locke, OBJECTS.sc_shoulderbash_steps01, 8);
			end,
			
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke -- GAMMA_CHARACTER: Locke
			text = "Soldiers just teleported through that ice wall.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_06400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 8; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
		
		ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return objects_can_see_object( SPARTANS.tanaka, OBJECTS.sc_shoulderbash_steps01, 8 );
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka -- GAMMA_CHARACTER: Tanaka
			text = "Soldiers just teleported through that ice wall.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_04700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
		ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return objects_can_see_object( SPARTANS.buck, OBJECTS.sc_shoulderbash_steps01, 8 );
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Soldiers just teleported through that ice wall.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_buck_05000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
		ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return objects_can_see_object( SPARTANS.vale, OBJECTS.sc_shoulderbash_steps01, 8 );
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale -- GAMMA_CHARACTER: VALE
			text = "Soldiers just teleported through that ice wall.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_04500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 7; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return b_shoulder_bash_done == false;
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka -- GAMMA_CHARACTER: TANAKA
			text = "It's cracked. Could charge through.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_VO_SCR_W3Halsey_UN_TANAKA_05900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[6] = {
		ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return b_shoulder_bash_done == false;
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "It's cracked. Could charge through.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_VO_SCR_W3Halsey_UN_BUCK_06200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[7] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return b_shoulder_bash_done == false;
			end, 
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale -- GAMMA_CHARACTER: vaLE
			text = "It's cracked. We can charge through.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_VO_SCR_W3Halsey_UN_VALE_06300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[8] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return b_shoulder_bash_done == false;
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke -- GAMMA_CHARACTER: locke
			text = "It's cracked. We can charge through.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_VO_SCR_W3Halsey_UN_LOCKE_07300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue) -- VOID
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
	end,
			localVariables = {
		checkConditionsPassed = 0,
	},
};




global nar_soldier_intro = {
	name = "halsey_soldier_intro",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return volume_test_players(VOLUMES.nar_bash_complete);
	end,
		canStartOnce = true,
	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.NPC;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_soldier_intro narrative");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
		[1] = {
			sleepBefore = 1,
			character = AI.vin_soldier_reveal_first.soldier_reveal_first_sol1,
			text = "Soldier01 : Humans detected.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_fr_soldier01_00100.sound'),
			sleepAfter = 0,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[2] = {
			character = AI.vin_soldier_reveal_first.soldier_reveal_first_sol2,
			text = "Soldier02 : We advise dissolution.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_soldier02_00100.sound'),
			sleepAfter = 0,
		},
		
	},

	OnFinish = function (thisConvo, queue) -- VOID
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
	end,
};

function nar_proceed_to_bowl()
SleepUntil( [| volume_test_players(VOLUMES.halsey_small_bowl) ],1);
	
	b_shoulder_bash_done = true;
end

global nar_crag_intro = {
	name = "nar_crag_intro",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return volume_test_players(VOLUMES.halsey_small_bowl);
	end,
	sleepbefore = 3,
	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_crag_intro narrative");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
			[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.halsey_small_bowl, SPARTANS.locke);
			end,
	sleepBefore = 2,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Locke : Needs text.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_03000.sound'),
			sleepAfter = 0,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.halsey_small_bowl, SPARTANS.tanaka);
			end,
	sleepBefore = 2,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Tanaka : Needs text",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_02700.sound'),
			sleepAfter = 0,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[3] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.halsey_small_bowl, SPARTANS.buck);
			end,
	sleepBefore = 2,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Buck : Needs text",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_VO_SCR_W3Halsey_UN_BUCK_05700.sound'),
			sleepAfter = 0,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[4] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.halsey_small_bowl, SPARTANS.vale);
			end,

				sleepBefore = 2,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Vale : Needs text.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_00300.sound'),
			sleepAfter = 0,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[5] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
sleepBefore = 1,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Buck : We could push right up the middle, but that will be rough. Might want to consider flanking them.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_buck_01000.sound'),
			sleepAfter = 0,
		},
				[6] = {
				sleepBefore = 1,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Move smart. Fire with a purpose.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_07900.sound'),
		},
	
	},

	OnFinish = function (thisConvo, queue) -- VOID
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
		
	end,
};
	
global nar_crag_combat_complete = {
	name = "nar_crag_combat_complete",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return crag_moved_on == false and ai_living_count(AI.sg_crag_all) < 1;
	end,

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,
	sleepBefore = 5,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_crag_combat_complete narrative");
		AIDialogManager.DisableAIDialog();
			CreateThread(nar_airlock_chatter_off);
	end,

	lines = {

			[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_crag_area, SPARTANS.locke) and unit_get_health( SPARTANS.locke) > 0; -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Locke : Needs text.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_03100.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,


		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_crag_area, SPARTANS.vale) and unit_get_health( SPARTANS.buck) > 0; -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Buck : Needs text",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_buck_02700.sound'),

					AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
	
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_crag_area, SPARTANS.vale) and unit_get_health( SPARTANS.vale) > 0; -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Vale : Needs text.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_03000.sound'),

					AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
		},
					[4] = {
		ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_crag_area, SPARTANS.vale) and unit_get_health( SPARTANS.tanaka) > 0; -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Tanaka : Needs text",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_02800.sound'),

			
		},
				[5] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,			
			sleepBefore = 1,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Good work, everyone.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_08000.sound'),

			
		},
				[6] = {
			sleepBefore = 2,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "I noticed in the briefing Doctor Halsey lost her left arm? When did that happen?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_07100.sound'),
							AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[7] = {
			sleepBefore = 0.5,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Jul did it. No idea when or why.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_08700.sound'),
							AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[8] = {
			sleepBefore = 0.5,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Reckon it wasn't an argument or he'd have cut off her head instead of her arm.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_06500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue) -- VOID
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
		CreateThread(crag_nudge_manager);
		CreateThread(nar_crag_chatter_start);
	end,
};

function nar_crag_chatter_start()
	if b_end_architecture_convo == false then
		CreateThread(halsey_idle_chatter_start);
	end
end

function crag_nudge_manager()
	sleep_rand_s(66,75);
	SleepUntil( [| b_collectible_used == false ], 1);
	if crag_moved_on == false then
			--story_blurb_add("domain", "nudge1");
		NarrativeQueue.QueueConversation(nar_crag_nudge);
	end
end

global W3Halsey_KAMTCHATKA__APPROACH_FORERUNNER_ROOM = {
	name = "W3Halsey_KAMTCHATKA__APPROACH_FORERUNNER_ROOM",
		canStartOnce = true,
		sleepBefore = 1,
	CanStart = function (thisConvo, queue) -- BOOLEAN
		return volume_test_players(VOLUMES.nar_approach_structure);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
					If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_approach_structure, SPARTANS.locke); -- GAMMA_TRANSITION: If locke
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Forerunner architecture.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_06700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},

		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_approach_structure, SPARTANS.vale); -- GAMMA_TRANSITION: If locke
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Forerunner architecture.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_05600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_approach_structure, SPARTANS.tanaka); -- GAMMA_TRANSITION: If locke
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Forerunner architecture.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_05100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_approach_structure, SPARTANS.buck); -- GAMMA_TRANSITION: If locke
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Forerunner architecture.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_buck_05300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--           Followed by what was Chatter 04

		[5] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Gotta respect the Forerunner Builders. They made things to last.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_04300.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 7;
			end,
		},
		[6] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "And shoved it in every corner of everything. Can't land on a planet without tripping over something they left behind.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_buck_04600.sound'),
		},
		[7] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return b_end_architecture_convo == false;
			end,
			
		
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VaLE
			text = "The rate of discoveries has been stepping up lately. Have you noticed that? Ever since Requiem.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_04200.sound'),
		},
--           
--           __________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


global nar_crag_nudge= {
	name = "nar_crag_nudge",

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_cliffside_pushforward narrative");
	--	story_blurb_add("domain", "nudge2");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
		[1] = {
				If = function (thisLine, thisConvo, queue, lineNumber)
				return b_collectible_used == false and crag_moved_on == false and b_end_architecture_convo == false; -- GAMMA_TRANSITION: If vale
			end,			
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Locke : Needs text.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_VO_SCR_W3Halsey_UN_Locke_05700.sound'),
			sleepAfter = 0,
			
			
		},
	},

	OnFinish = function (thisConvo, queue) -- VOID
	hud_hide_radio_transmission_hud();
		AIDialogManager.EnableAIDialog();
	end,
};

-- =================================================================================================
--
--					AIRLOCK SECTION
--
-- Covers content in the airlock.
--
-- =================================================================================================

function nar_airlock_chatter_off()
SleepUntil( [| volume_test_players(VOLUMES.nar_airlock_chatter_off) ],1);
	b_end_architecture_convo = true;
CreateThread(halsey_idle_chatter_off);
end

function nar_airlock_entered()
SleepUntil( [| volume_test_players(VOLUMES.nar_airlock_intro) ],1);
	CreateThread(halsey_idle_chatter_off);
	NarrativeQueue.EndConversationEarly(W3Halsey_KAMTCHATKA__APPROACH_FORERUNNER_ROOM);

end
global nar_airlock_intro = {
	name = "nar_airlock_intro",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return volume_test_players(VOLUMES.nar_airlock_intro);
	end,

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_airlock_intro narrative");
		crag_moved_on = true;
		
		
		AIDialogManager.DisableAIDialog();
	end,

	lines = {

		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return tracking_system_hit == false and volume_test_object(VOLUMES.nar_airlock_intro, SPARTANS.buck);
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Buck : The door is sealed tight.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_buck_01100.sound'),
			sleepAfter = 0,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return tracking_system_hit == false and volume_test_object(VOLUMES.nar_airlock_intro, SPARTANS.locke);
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Locke : The door is sealed tight.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_01000.sound'),
			sleepAfter = 0,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[3] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return tracking_system_hit == false and volume_test_object(VOLUMES.nar_airlock_intro, SPARTANS.tanaka);
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Tanaka : Door's sealed up good and tight.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_00400.sound'),
			sleepAfter = 0,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[4] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return tracking_system_hit == false and volume_test_object(VOLUMES.nar_airlock_intro, SPARTANS.vale);
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Vale : The door is sealed tight.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_00600.sound'),
			sleepAfter = 0,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[5] = {
							If = function(thisLine, thisConvo, queue, lineNumber)
				return tracking_system_hit == false;
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 1,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Tanaka : Forerunner security station. Must be in lockdown.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_02900.sound'),
			sleepAfter = 0,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 6;
			end,
		},
		[6] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return tracking_system_hit == false;
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 1,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Buck : Any way to lift it?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_buck_01200.sound'),
			sleepAfter = 0,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 7;
			end,
		},
		[7] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return tracking_system_hit == false;
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 1,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Locke : The Artemis is can communicate with Forerunner systems. Trick it into thinking we have credentials.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_03200.sound'),
						AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
			b_halsey_tracking_tutorial = true;
				return 8; -- GAMMA_NEXT_LINE_NUMBER
			end,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
			b_halsey_tracking_tutorial = true;
				return 0;
			end,
			sleepAfter = 0,
		},
		[8] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return tracking_system_hit == false;
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 1,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Tanaka :  Halsey figure that one out for Oni?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_03000.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
			sleepAfter = 0,
		},
		[9] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return tracking_system_hit == false;
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 1,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Locke : I believe it was the Master Chief's AI, Cortana, actually.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_03300.sound'),
			sleepAfter = 0,
		},
	},

	OnFinish = function (thisConvo, queue) -- VOID
	hud_hide_radio_transmission_hud();
		AIDialogManager.EnableAIDialog();
		CreateThread(tracking_nudge_manager);
		
	end,
};




function nar_tracking_system_used()
	SleepUntil([| b_airlock_tracking or (device_get_position(OBJECTS.dc_tr_airlock_02) ~= 0)], 1);
	tracking_system_hit = true;

	NarrativeQueue.QueueConversation(nar_airlock_end);
end

function nar_button_listener()
	
       SleepUntil([| object_valid( "dc_tr_airlock_02" ) ], 60);
	   PrintNarrative("LISTENER - dc_tr_airlock_02 THREADED");
       SleepUntil([| device_get_power( OBJECTS.dc_tr_airlock_02) == 1 ], 60);
	   
       PrintNarrative("LISTENER - dc_tr_airlock_02");

       CreateThread(RegisterInteractEvent, nar_button_launcher, OBJECTS.dc_tr_airlock_02);


end

function nar_button_launcher(trigger:object, activator:object)

       PrintNarrative("LAUNCHER - nar_button_launcher");

       print(activator, " is the activator of ", trigger);

       CreateThread(UnregisterInteractEvent, nar_button_listener, OBJECTS.dc_tr_airlock_02);

       CreateThread(nar_tracking_button_used, activator)
end


function nar_tracking_button_used(activator:object)
		
		sleep_s(1.5);
		
			if activator == SPARTANS.tanaka then
				NarrativeQueue.QueueConversation(nar_tracking_button_used_tanaka);
			elseif activator == SPARTANS.buck then
				NarrativeQueue.QueueConversation(nar_tracking_button_used_buck);
			elseif activator == SPARTANS.locke then
				NarrativeQueue.QueueConversation(nar_tracking_button_used_locke);
			elseif activator == SPARTANS.vale then
				NarrativeQueue.QueueConversation(nar_tracking_button_used_vale);
			end
		
end

global nar_tracking_button_used_locke = {
	name = "nar_tracking_button_used_locke",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,		
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Let's see... this should do it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_08100.sound'),

	
		},

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global nar_tracking_button_used_tanaka = {
	name = "nar_tracking_button_used_tanaka",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
	
		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Let's see... this should do it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_06200.sound'),

		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


global nar_tracking_button_used_vale = {
	name = "nar_tracking_button_used_vale",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
	
		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Let's see... this should do it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_06600.sound'),

		},

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


global nar_tracking_button_used_buck = {
	name = "nar_tracking_button_used_buck",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,			
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Let's see... this should do it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_buck_06500.sound'),


		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global nar_airlock_end = {
	name = "nar_airlock_end",
		
		
		CanStart = function (thisConvo, queue) -- BOOLEAN
	
			return (device_get_position(OBJECTS.dm_airlock_door_02) == 1 and volume_test_players_lookat(VOLUMES.nar_lookat_door, 10, 10)) or volume_test_players(VOLUMES.nar_exit_airlock);
	
	end,

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_airlock_end narrative");
		CreateThread(nar_overlook_kraken_con);
		AIDialogManager.DisableAIDialog();
		
	end,

	lines = {
			[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_player_lookat( VOLUMES.nar_lookat_door, unit_get_player(SPARTANS.locke), 10, 10 ); -- GAMMA_TRANSITION: If locke
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Door is open.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_01200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_player_lookat( VOLUMES.nar_lookat_door, unit_get_player(SPARTANS.tanaka), 10, 10 ); -- GAMMA_TRANSITION: If tanaka
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Door is open.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_05600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_player_lookat( VOLUMES.nar_lookat_door, unit_get_player(SPARTANS.vale), 10, 10 ); -- GAMMA_TRANSITION: If vale
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Door is open.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_06100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_player_lookat( VOLUMES.nar_lookat_door, unit_get_player(SPARTANS.buck), 10, 10 ); -- GAMMA_TRANSITION: If buck
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Door is open.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_buck_06000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "The Artemis did the trick.\r\n\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_00900.sound'),
			
			
		},
		[6] = {
		
			If = function (self, queue, lineNumber) -- BOOLEAN
				return b_transmission_received == true;
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,		
			sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale -- GAMMA_CHARACTER: Vale
			text = "Another transmission.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_05200.sound'),
			
				AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
			
				return 8;
			end,
		},
		[7] = {
			If = function (self, queue, lineNumber) -- BOOLEAN
				return b_transmission_received == false;
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
		sleepBefore = 1,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Locke, listen to this...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_01200.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				b_transmission_received  = true;
				return 8;
			end,
				
		},
				[8] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
			hud_set_radio_transmission_team_string_id("covenantteam_transmission_name");
								hud_set_radio_transmission_portrait_index(18);
				hud_show_radio_transmission_hud("jul_transmission_name");
			end,
			sleepBefore = 0.5,		
			text = "They are assaulting the back of the temple! Bring in the Kraken!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_cv_jul_00200.sound'),
							playDurationAdjustment = 0.4,
		},
		[9] = {

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "They are assaulting the back of the temple. Bring in the Kraken.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_06000.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
	},

	OnFinish = function (thisConvo, queue) -- VOID
	hud_hide_radio_transmission_hud();
	CreateThread(airlock_nudge_manager);
		
	end,
		localVariables = {
		checkConditionsPassed = 0,
	},
};

function airlock_nudge_manager()
	sleep_s(45);
	if airlock_move_on == false then
		SleepUntil( [| b_collectible_used == false ], 1);
		--	story_blurb_add("domain", "nudge1");
		NarrativeQueue.QueueConversation(nar_airlock_nudge);
	end
end


global W3Halsey_KAMCHATKA__BATTLE_VISTA2 = {
	name = "W3Halsey_KAMCHATKA__BATTLE_VISTA2",

	sleepBefore = 2,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_set_radio_transmission_team_string_id("covenantteam_transmission_name");
				hud_show_radio_transmission_hud("jul_transmission_name");
				hud_set_radio_transmission_portrait_index(18);
			end,
			
			text = "Hold position! Buy more time!",
			
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_cv_jul_00700.sound'),
										playDurationAdjustment = 0.4,
		},
		[2] = {
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Hold position. Buy more time.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_06700.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
		},
		[3] = {
			
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
	sleepBefore = 1,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = " Vale : Jul's getting desperate.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_00800.sound'),
			sleepAfter = 0,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 7;
			end,
		},
		[4] = {
		
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Locke:  The Covenant exists because Mdama resurrected it. If he goes down, chances are good the whole thing falls with him.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_04500.sound'),
		},
		[4] = {

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
	sleepBefore = 1.5,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka -- GAMMA_CHARACTER: Tanaka
			text = "How'd you learn to speak Sangheili, Vale?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_00500.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[5] = {

			
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
	sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale -- GAMMA_CHARACTER: Vale
			text = "When I was a kid I was stuck on a diplomatic shuttle adrift in deep space for six months. My options were be real bored or spend the time getting smart.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_00500.sound'),
		},
		
	},

	OnFinish = function (thisConvo, queue) -- VOID
	hud_hide_radio_transmission_hud();
		AIDialogManager.EnableAIDialog();
	CreateThread(nar_overlook_ai_off);
	--CreateThread(nar_hill_chatter);
		CreateThread(krakenwatch_nudge_manager);
		
		
	end,
};


function nar_overlook_ai_off()
AIDialogManager.DisableAIDialog();
end

function nar_hill_chatter()
if volume_test_players( VOLUMES.halsey_big_combat_zone) ~= true then
	CreateThread(halsey_idle_chatter_start);
	CreateThread(nar_hill_area_chatter_off);
	NarrativeQueue.EndConversationEarly(W3Halsey_KAMCHATKA__BATTLE_VISTA2);
end
end

function nar_airlock_post_controller()
	if kraken_lines_playing == false and nar_airlock_post_played == false then
		--	story_blurb_add("domain", "nudge1");
			nar_airlock_post_played = true;
	
		
	end

end




function tracking_nudge_manager()
	sleep_s(30);
	if tracking_system_hit == false then
	SleepUntil( [| b_collectible_used == false ], 1);
			--story_blurb_add("domain", "nudge1");
		NarrativeQueue.QueueConversation(nar_tracking_nudge);
		
	end
	sleep_s(45);
	if tracking_system_hit == false then
	SleepUntil( [| b_collectible_used == false ], 1);
			--story_blurb_add("domain", "nudge1");
		NarrativeQueue.QueueConversation(nar_tracking_nudge2);
		
	end
	sleep_s(45);
	if tracking_system_hit == false then
	SleepUntil( [| b_collectible_used == false ], 1);
			--story_blurb_add("domain", "nudge1");
		NarrativeQueue.QueueConversation(nar_tracking_nudge3);
		
	end
end

global nar_tracking_nudge= {
	name = "nar_tracking_nudge",

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	Priority = function (thisConvo, queue) -- ENUM
	return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_cliffside_pushforward narrative");
	--	story_blurb_add("domain", "nudge2");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VaLE
			text = "See anything on the Artemis? ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_05700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue) -- VOID
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
	end,
};

global nar_tracking_nudge2 = {
	name = "nar_tracking_nudge2",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Artemis showing anything?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_05200.sound'),
		},
--                                                   CUT TO:
--           ____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


global nar_tracking_nudge3 = {
	name = "nar_tracking_nudge3",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BuCK
			text = "What's the Artemis show? Anything?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_buck_05400.sound'),
		},
--                                                   CUT TO:
--           ____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};




function halsey_ping_vo()
	sleep_s(2);
       print("OnPinged!");
	  if b_tracking_pinged == false then
	  b_tracking_pinged = true;
		NarrativeQueue.QueueConversation(W3Halsey_KAMTCHATKA__AIRLOCK_TRACKING_SUCCESS);
		end
       
end




global W3Halsey_KAMTCHATKA__AIRLOCK_TRACKING_SUCCESS = {
	name = "W3Halsey_KAMTCHATKA__AIRLOCK_TRACKING_SUCCESS",



	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
					If = function (thisLine, thisConvo, queue, lineNumber)
				return tracking_system_hit == false; -- GAMMA_TRANSITION: If locke
			end,
										OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Systems analyzed. Looks like there's an override switch near the top of the room.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_06800.sound'),
		},
--           ____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global nar_airlock_nudge= {
	name = "nar_airlock_nudge",

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("airlock_nudge_manager narrative");
		--story_blurb_add("domain", "nudge2");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return (kraken_lines_playing == false) and b_collectible_used == false; -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,
			
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Tanaka: Needs text.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_03100.sound'),
			sleepAfter = 0,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			
		},
			[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return (kraken_lines_playing == false) and b_collectible_used == false; -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Locke : Needs text.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_03600.sound'),
			sleepAfter = 0,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,

			
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return (kraken_lines_playing == false) and b_collectible_used == false; -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,
			
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Vale : Needs text.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_03100.sound'),
			sleepAfter = 0,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
		},
		[4] = {
		If = function (thisLine, thisConvo, queue, lineNumber)
				return (kraken_lines_playing == false) and b_collectible_used == false; -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Buck : Needs text",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_VO_SCR_W3Halsey_UN_BUCK_05800.sound'),
			sleepAfter = 0,
		
		},
	},

	OnFinish = function (thisConvo, queue) -- VOID
	hud_hide_radio_transmission_hud();
		AIDialogManager.EnableAIDialog();
	end,
};

-- =================================================================================================
--
--					OVERLOOK SECTION
--
-- Covers content in the airlock.
--
-- =================================================================================================

function nar_overlook_kraken_con()
SleepUntil([| volume_test_players(VOLUMES.nar_overlook_kraken) ], 1);
	
	airlock_move_on = true;
end


global nar_overlook_kraken = {	
	name = "nar_overlook_kraken",
	
	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_overlook_kraken); -- GAMMA_CONDITION
	end,

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,


	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_overlook_kraken narrative");
		AIDialogManager.DisableAIDialog();
		
	end,

	lines = {
	
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_overlook_kraken, SPARTANS.locke);
			end,
			sleepBefore = 2,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Locke : Kraken sighted!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_01700.sound'),
			sleepAfter = 1,

		},
		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_overlook_kraken, SPARTANS.tanaka);
			end,
			sleepBefore = 2,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Tanaka : Kraken!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_01000.sound'),
			sleepAfter = 1,

		},
		[3] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_overlook_kraken, SPARTANS.buck);
			end,
			sleepBefore = 2,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Buck : There's the Kraken!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_buck_01600.sound'),
			sleepAfter = 1,
	
		},
		[4] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_overlook_kraken, SPARTANS.vale);
			end,
			sleepBefore = 2,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Vale : Kraken sighted!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_00900.sound'),
			sleepAfter = 1,
			
		},
		
	
	},

	OnFinish = function (thisConvo, queue) -- VOID
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
			kraken_lines_playing = false;
		NarrativeQueue.QueueConversation(W3Halsey_KAMCHATKA__BATTLE_VISTA2);
				CreateThread(nar_airlock_post_controller);
		--NarrativeQueue.QueueConversation(nar_overlook_halsey);
	end,
};

global nar_overlook_halsey = {
	name = "nar_overlook_halsey",

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_overlook_halsey narrative");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
		[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Tanaka : How'd you learn to speak Sangheili, Vale?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_00500.sound'),
			sleepAfter = 0,
		AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[2] = {
			
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Vale : When I was a kid I was stuck on a diplomatic shuttle adrift in deep space for six months. My options were be real bored or spend the time getting smart.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_00500.sound'),
			sleepAfter = 0,
		},
	},

	OnFinish = function (thisConvo, queue) -- VOID
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
	end,
};



function krakenwatch_nudge_manager()
	sleep_s(60);
	SleepUntil( [| b_collectible_used == false ], 1);
	if b_big_battle_start == false then
		--	story_blurb_add("domain", "nudge1");
		NarrativeQueue.QueueConversation(krakenwatch_nudge);
	end
end

global krakenwatch_nudge= {
	name = "krakenwatch_nudge",

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("airlock_nudge_manager narrative");
		--story_blurb_add("domain", "nudge2");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
		[1] = {

				If = function (thisLine, thisConvo, queue, lineNumber)
				return b_collectible_used == false; -- GAMMA_TRANSITION: If vale
			end,			

								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Locke: Needs text.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_03900.sound'),
			sleepAfter = 0,
			
			
		},
	},

	OnFinish = function (thisConvo, queue) -- VOID
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
	end,
};


-- =================================================================================================
--
--					HILL SECTION
--
-- Covers content in the hill.
--
-- =================================================================================================

function nar_hill_area_chatter_off()
	SleepUntil([| volume_test_players( VOLUMES.nar_hill_area_chatter_off)], 1);

	CreateThread(halsey_idle_chatter_off);
end

function nar_hill_area_enter()
	SleepUntil([| volume_test_players( VOLUMES.halsey_big_combat_zone)], 1);

	CreateThread(halsey_idle_chatter_off);
end

global nar_hill_intro = {
	name = "nar_hill_intro",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return volume_test_players(VOLUMES.halsey_big_combat_zone);
	end,

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,


	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_hill_intro narrative");
		b_big_battle_start = true;
		
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
	
			[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.halsey_big_combat_zone, SPARTANS.locke);
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Locke : Text needed.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_01900.sound'),
			sleepAfter = 0,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.halsey_big_combat_zone, SPARTANS.tanaka);
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Tanaka : Text needed.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_03200.sound'),
			sleepAfter = 0,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},

		[3] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.halsey_big_combat_zone, SPARTANS.buck);
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Buck : Text needed.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_buck_03100.sound'),
			sleepAfter = 0,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[4] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.halsey_big_combat_zone, SPARTANS.vale);
			end,
			
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Vale : Text needed.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_03200.sound'),
			sleepAfter = 0,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},

		[5] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
			sleepBefore = 2,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Locke : Text needed",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_04000.sound'),
			

		},
		[6] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
			sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Buck : Text needed",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_buck_03200.sound'),
			sleepAfter = 0,
			
		},

	},

	OnFinish = function (thisConvo, queue) -- VOID
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
		CreateThread(bigcombat_nudge_manager);
		CreateThread(nar_turn_on_ai);
		NarrativeQueue.QueueConversation(nar_drop_pod);
		NarrativeQueue.QueueConversation(nar_bigcombat_complete);
	end,
};

function nar_turn_on_ai()
AIDialogManager.EnableAIDialog();
		AIDialogManager.EnableAIDialog();
end
global nar_drop_pod = {
	name = "nar_drop_pod",
CanStart = function (thisConvo, queue) -- BOOLEAN
		if (thisConvo.localVariables.checkConditionsPassed == 0) then
			if object_index_valid(AI.sq_hill_cov_pod_1.spawnpoint04) then
				thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.sq_hill_cov_pod_1.spawnpoint04)) < 6 and b_moved_into_temple == false;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
end,
	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_drop_pod narrative");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
		[1] = {
			character = AI.sq_hill_cov_pod_1.spawnpoint04,
			text = "Elite02 : Hold your ground! We must not break!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_cv_elite02_00600.sound'),
			sleepAfter = 0,
		},
		[2] = {
			character = AI.sq_hill_cov_pod_1.spawnpoint04,
			text = "Elite02 : Lose this position and we lose this war!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_cv_elite02_00700.sound'),
			sleepAfter = 0,
		},
	},

	OnFinish = function (thisConvo, queue) -- VOID
	hud_hide_radio_transmission_hud();
		AIDialogManager.EnableAIDialog();
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};



function bigcombat_nudge_manager()
	sleep_s(120);
	SleepUntil( [| b_collectible_used == false ], 1);
	if b_big_battle_complete == false then
		--	story_blurb_add("domain", "nudge1");
		NarrativeQueue.QueueConversation(nar_bigcombat_nudge);
	end
end


global nar_bigcombat_nudge= {
	name = "nar_bigcombat_nudge",

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("airlock_nudge_manager narrative");
		--story_blurb_add("domain", "nudge2");
		AIDialogManager.DisableAIDialog();
	end,
		
	lines = {
		[1] = {
									If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.halsey_big_combat_zone, SPARTANS.locke) and (unit_get_health( SPARTANS.locke) > 0); -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,

								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Locke: Needs text!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_04100.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
	},
	[2] = {
									If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.halsey_big_combat_zone, SPARTANS.buck) and (unit_get_health( SPARTANS.buck) > 0); -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Buck : Needs text!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_buck_03300.sound'),
			
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
				AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[3] = {

									If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.halsey_big_combat_zone, SPARTANS.vale) and (unit_get_health( SPARTANS.vale) > 0); -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,
			
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Vale : Needs text!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_03300.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[4] = {
									If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.halsey_big_combat_zone, SPARTANS.tanaka) and (unit_get_health( SPARTANS.tanaka) > 0); -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Tanaka : Needs text!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_03300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		
	},

	OnFinish = function (thisConvo, queue) -- VOID
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
	end,
};

global W3Halsey_KAMTCHATKA__KRAKEN_LEAVES = {
	name = "W3Halsey_KAMTCHATKA__KRAKEN_LEAVES",

	CanStart = function (thisConvo, queue)
		return b_kraken_leaving == true; -- GAMMA_CONDITION
	end,

	sleepBefore = 10,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Kraken is falling back! Forerunner defenses were too much for it!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_07000.sound'),

		
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};



global nar_bigcombat_complete= {
	name = "nar_bigcombat_complete",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		if (thisConvo.localVariables.checkConditionsPassed == 0) then
			if volume_test_players( VOLUMES.halsey_big_battle_end) then
				thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return ( ai_living_count (AI.sg_hill_cov) <= 0.5 and ai_living_count (AI.sg_hill_for) <= 0.5 ) and b_moved_into_temple == false ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,

	sleepBefore = 4,

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("airlock_nudge_manager narrative");
		--story_blurb_add("domain", "nudge2");
		b_big_battle_complete = true;
		b_killed_all = true;
		AIDialogManager.DisableAIDialog();
	end,
		
	lines = {

		[1] = {
									If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.halsey_big_combat_zone, SPARTANS.tanaka) and unit_get_health( SPARTANS.tanaka) > 0; -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Tanaka : Needs text!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_03400.sound'),
			sleepAfter = 0,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[2] = {
			sleepBefore = 2,
							If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.halsey_big_combat_zone, SPARTANS.vale) and unit_get_health( SPARTANS.vale) > 0; -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,
			
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Vale : Needs text!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_03400.sound'),
			sleepAfter = 0,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[3] = {
									If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.halsey_big_combat_zone, SPARTANS.buck) and unit_get_health( SPARTANS.buck) > 0 ; -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Buck : Needs text!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_buck_03400.sound'),
			sleepAfter = 0,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[4] = {
									If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.halsey_big_combat_zone, SPARTANS.locke) and unit_get_health( SPARTANS.locke) > 0; -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Locke: Needs text!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_04800.sound'),
			sleepAfter = 0,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[5] = {
		

								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
			sleepBefore = 2,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Locke: Needs text!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_04700.sound'),
			sleepAfter = 0,
		
		},
			[6] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
				sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Move in, Osiris!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_08600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue) -- VOID
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
		
		CreateThread(moveintotemple_nudge_controller);
		CreateThread(nar_infiltration_enter_chatter_off);
	end,
		localVariables = {
		checkConditionsPassed = 0,
	},
};

function moveintotemple_nudge_controller()
	if b_moved_into_temple == false then
	CreateThread(halsey_idle_chatter_start);
	end
	sleep_s(75);
	SleepUntil( [| b_collectible_used == false ], 1);
	if b_moved_into_temple == false then
			--story_blurb_add("domain", "nudge1");
		NarrativeQueue.QueueConversation(nar_moveintotemple_nudge);
	end
end

global nar_moveintotemple_nudge= {
	name = "nar_moveintotemple_nudge",

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("airlock_nudge_manager narrative");
		--story_blurb_add("domain", "nudge2");
		AIDialogManager.DisableAIDialog();
	end,
		
	lines = {
		[1] = {
				If = function (thisLine, thisConvo, queue, lineNumber)
				return b_collectible_used == false; -- GAMMA_TRANSITION: If vale
			end,
		
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Tanaka: Needs text!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_03500.sound'),
			sleepAfter = 0,
		},
	
	},

	OnFinish = function (thisConvo, queue) -- VOID
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
	end,
};


-- =================================================================================================
--
--					HALLWAY SECTION
--
-- Covers content in the hallway section.
--
-- =================================================================================================

--CanStart = function (thisConvo, queue) -- BOOLEAN
--		if (thisConvo.localVariables.checkConditionsPassed == 0) then
--			if ((ai_living_count (AI.sq_hill_cov_pad02) >= 1 and ai_living_count (AI.sg_hill_holdout) >= 1 )) then
--				thisConvo.localVariables.checkConditionsPassed = 1;
--				
--			end
--
--			return false;
--		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
--			return volume_test_players(VOLUMES.halsey_infiltration_enter) or (ai_living_count (AI.sq_hill_cov_pad02) <= 1 and ai_living_count (AI.sg_hill_holdout) <= 1 );
--		else
--			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
--		end

--		return false;
--	end,
function nar_infiltration_enter_chatter_off()
	SleepUntil([| volume_test_players( VOLUMES.nar_infiltration_enter_chatter_off)], 1);
	
		CreateThread(halsey_idle_chatter_off);
	end


function nar_halsey_infiltration_enter()
	SleepUntil([| volume_test_players( VOLUMES.halsey_infiltration_enter)], 1);
	b_moved_into_temple = true;
			CreateThread(halsey_idle_chatter_off);
	end

global nar_hallway_intro = {
	name = "nar_hallway_intro",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		
			return volume_test_players(VOLUMES.halsey_infiltration_enter);

	end,
				canStartOnce = true,		
	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_hallway_intro narrative");
		AIDialogManager.DisableAIDialog();


		b_big_battle_complete = true;
		b_moved_into_temple = true;
		--CreateThread (ShowMissionTempPip,"Motion Graphic - Comm Signal", 8);
	end,

	lines = {
	[1] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Must have dealt a blow to Mdama's authority when the Prometheans turned on him. Gained a lot of followers stylin himself as a Forerunner prophet.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_00300.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Jul Mdama is an opportunist, not a leader. It was only a matter of time until his version of the Covenant started to break.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_08800.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BuCK
			text = "Well, it could stand to break a little faster if you ask me.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_buck_06900.sound'),
		
		},

	},

	OnFinish = function (thisConvo, queue) -- VOID
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {
		checkConditionsPassed = 0,
	},
};



global nar_hallway_hack = {
	name = "nar_hallway_hack",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return volume_test_players(VOLUMES.tv_goal_09_vault);
		--return (ai_living_count (AI.sq_cliff_3_8) <= 0);
	end,

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_hallway_hack narrative");
	end,
};

-- =================================================================================================
--
--					VAULT SECTION
--
-- Covers content in the vault section.
--
-- =================================================================================================

function nar_vault_enter_boolean()

SleepUntil([| volume_test_players(VOLUMES.tv_goal_09_vault) ], 1);
		b_halsey_line = true;

end

global nar_vault_intro = {
	name = "nar_vault_intro",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return volume_test_players(VOLUMES.tv_goal_09_vault);
	end,

	sleepBefore = 1,

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_vault_intro narrative");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
		[1] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Locke : I'm zeroing in on Halsey's position, Osiris. She's within a hundred meters - dead ahead.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_02500.sound'),
			sleepAfter = 0,

		
		},

	},

	OnFinish = function (thisConvo, queue) -- VOID
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
		
	end,
};

function nar_knight_breach_start()
	
sleep_s(2.5);
NarrativeQueue.QueueConversation(nar_vault_knight_breach);
end


global nar_vault_elites = {
	name = "nar_vault_elites",

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_vault_elites narrative");
		RunClientScript("pip_genereic_radio_intercept_60");
		--story_blurb_add("domain", "PIP: COVENANT RADIO TRANSMISSION.");
		AIDialogManager.DisableAIDialog();
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_cv_elite01_00300.sound'), nil);
	end,

	lines = {		
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return not (b_halsey_line == true);
			end,
			
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Vale : Why does M'dama allow the infidel into the holy site and deny us, his honor guard?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_00700.sound'),
			sleepAfter = 0,

			AfterPlayed = function(self, queue, lineNumber)
				PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_cv_elite01_00300.sound'), nil);
				return lineNumber + 1;
			end,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return not (b_halsey_line == true);
			end,
			
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Vale : She has poisoned his mind. She is dangerous.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_00800.sound'),
			sleepAfter = 0,

			AfterPlayed = function(self, queue, lineNumber)
				PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_cv_elite01_00300.sound'), nil);
				return lineNumber + 1;
			end,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return not (b_halsey_line == true);
			end,
			
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Vale : And he wonders why so many have left his cause.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_00900.sound'),
			sleepAfter = 0,
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return not (b_halsey_line == true);
			end,
			
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Vale : They really don't like Halsey.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_01900.sound'),
			sleepAfter = 0,
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return not (b_halsey_line == true);
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Tanaka : Can't argue with their taste.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_02000.sound'),
			sleepAfter = 0,
		},
	},

	OnFinish = function (thisConvo, queue) -- VOID
	hud_hide_radio_transmission_hud();
		AIDialogManager.EnableAIDialog();
	end,
};

global nar_vault_knight_breach = {
	name = "nar_vault_knight_breach",

		CanStart = function (thisConvo, queue) -- BOOLEAN
		return volume_test_players_lookat( VOLUMES.tv_hallway_lookat, 5, 5 );
	end,

	
	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,
	
	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_vault_knight_breach narrative");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
			[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_player_lookat( VOLUMES.tv_hallway_lookat, unit_get_player(SPARTANS.locke), 5, 5 ) ; -- GAMMA_TRANSITION: If buck WITNESSES
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Knights!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_08300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
						If = function (thisLine, thisConvo, queue, lineNumber)
				return  volume_test_player_lookat( VOLUMES.tv_hallway_lookat, unit_get_player(SPARTANS.vale), 5, 5 ) ; -- GAMMA_TRANSITION: If buck WITNESSES
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VaLE
			text = "Knights!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_06800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_player_lookat( VOLUMES.tv_hallway_lookat, unit_get_player(SPARTANS.tanaka), 5, 5 )  ; -- GAMMA_TRANSITION: If buck WITNESSES
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TanAKA
			text = "Knights!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_06300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_player_lookat( VOLUMES.tv_hallway_lookat, unit_get_player(SPARTANS.buck), 5, 5 ) ; -- GAMMA_TRANSITION: If buck WITNESSES
			end,			
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Buck : Head's up! Knights!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_buck_01900.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 5;
			end,
		},
	
		[5] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
			sleepBefore = 1,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Tanaka : Not the usual kind, though. They've had an upgrade!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_03600.sound'),
			sleepAfter = 0,

		},
				[6] = {
											OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
				RunClientScript("pip_halsey_knight_hitpoint_60");
end,
sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: locke
			text = "Concentrate fire on the broken armor!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_02200.sound'),
		},


	},

	OnFinish = function (thisConvo, queue) -- VOID
	hud_hide_radio_transmission_hud();
		AIDialogManager.EnableAIDialog();
		NarrativeQueue.QueueConversation(nar_vault_knight_breach2);
		
	end,
		localVariables = {
		checkConditionsPassed = 0,
	},
};

global nar_vault_knight_breach2 = {
	name = "nar_vault_knight_breach2",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_vault_vo_start) ; -- GAMMA_CONDITION
	end,

	
	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,
	
	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_vault_knight_breach narrative");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {

		[1] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Locke : We can't let them through to Halsey. Our orders are to bring her in alive. Clear this area, Osiris.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_05000.sound'),
			sleepAfter = 0,

		},

	},

	OnFinish = function (thisConvo, queue) -- VOID
	hud_hide_radio_transmission_hud();
		AIDialogManager.EnableAIDialog();
		CreateThread(nar_vault_vo_start);
	end,
		localVariables = {
		checkConditionsPassed = 0,
	},
};

function nar_vault_vo_start()
	
	CreateThread(nar_vault_knight_nudge_controller);
		CreateThread(vault_nudge_manager);
		NarrativeQueue.QueueConversation(nar_vaultcombat_complete);
		

end


global nar_vault_elitevo = {
	name = "nar_vault_elitevo",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return objects_distance_to_object(players_human(),ai_get_object(AI.sq_vault_cov_01.spawn_points_0)) < 5;	
	end,

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.NPC;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_vault_knight_breach narrative");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
		[1] = {
			sleepBefore = 3,
			character = AI.sq_vault_cov_01.spawn_points_0,
			text = "Elite03 : Needs text!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_cv_elite03_00100.sound'),
			sleepAfter = 0,
		},
		[2] = {
			character = AI.sq_vault_cov_01.spawn_points_0,
			text = "Elite03 : Needs text!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_cv_elite03_00200.sound'),
			sleepAfter = 0,
		},
		

	},

	OnFinish = function (thisConvo, queue) -- VOID
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
		
	end,
};

function nar_vault_knight_nudge_controller()
sleep_s(60);

if all_knights_cleared == false then
	NarrativeQueue.QueueConversation(nar_vault_knight_nudge);
end

end

global nar_vault_knight_nudge = {
	name = "halsey_knight_nudge",

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_vault_knight_nudge narrative");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
		[1] = {
		
			If = function(thisLine, thisConvo, queue, lineNumber)
				return (not all_knights_cleared) and (not vault_battle_complete);
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Tanaka : The glowing area! It's vulnerable! Shoot there!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_01300.sound'),
			sleepAfter = 0,
		},
	},

	OnFinish = function (thisConvo, queue) -- VOID
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
	end,
};

function vault_nudge_manager()
	sleep_s(90);
	if vault_battle_complete == false then
		--	story_blurb_add("domain", "nudge1");
		NarrativeQueue.QueueConversation(nar_vault_nudge);
	end
end

global nar_vault_nudge= {
	name = "nar_vault_nudge",

		CanStart = function (thisConvo, queue) -- BOOLEAN
		return (ai_living_count (AI.sg_vault) < 4 );
	end,

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("airlock_nudge_manager narrative");
	--	story_blurb_add("domain", "nudge2");
		AIDialogManager.DisableAIDialog();
	end,
		
	lines = {
		[1] = {
				If = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.vale) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
			
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Vale : Needs text!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_03500.sound'),
			sleepAfter = 0,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.buck) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Buck : Needs text!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_buck_03500.sound'),
			sleepAfter = 0,
			
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[3] = {
					ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.locke) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Locke: Needs text!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_05100.sound'),
			sleepAfter = 0,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.tanaka) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Tanaka : Needs text!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_03700.sound'),
			sleepAfter = 0,

		},
				[5] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
				sleepBefore = 1,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Keep up the pressure, Osiris.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_08400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},
	OnFinish = function (thisConvo, queue) -- VOID
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
	end,
};


global nar_vaultcombat_complete= {
	name = "nar_vaultcombat_complete",
	CanStart = function (thisConvo, queue) -- BOOLEAN
		return (ai_living_count (AI.sg_vault) < 1 );
	end,

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	sleepBefore = 2,

	OnStart = function (thisConvo, queue) -- VOID
		print("airlock_nudge_manager narrative");
		vault_battle_complete = true;
		AIDialogManager.DisableAIDialog();
	end,
		
	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return unit_get_health( SPARTANS.buck) > 0; -- GAMMA_TRANSITION: If buck WITNESSES
			end,
		
			sleepBefore = 1,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Buck : Needs text!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_buck_03600.sound'),
			sleepAfter = 0,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return unit_get_health( SPARTANS.tanaka) > 0; -- GAMMA_TRANSITION: If buck WITNESSES
			end,
		sleepBefore = 1,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Tanaka : Needs text!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_03800.sound'),
				sleepAfter = 0,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,		

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return unit_get_health( SPARTANS.locke) > 0; -- GAMMA_TRANSITION: If buck WITNESSES
			end,
		sleepBefore = 1,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Locke: Needs text!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_05200.sound'),
			sleepAfter = 0,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return unit_get_health( SPARTANS.vale) > 0; -- GAMMA_TRANSITION: If buck WITNESSES
			end,
		sleepBefore = 1,
			
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Vale : Needs text!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_03600.sound'),
			sleepAfter = 0,


			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},

		
		[5] = {
		
		sleepBefore = 1,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Locke: Needs text!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_locke_05300.sound'),
			sleepAfter = 0,

		
		},
	},

	OnFinish = function (thisConvo, queue) -- VOID
	hud_hide_radio_transmission_hud();
		AIDialogManager.EnableAIDialog();
		CreateThread(vaultexit_nudge_controller);
	
	end,
};

function vaultexit_nudge_controller()
	sleep_s(75);
	SleepUntil( [| b_collectible_used == false ], 1);
	if b_moved_into_vault == false then
			--story_blurb_add("domain", "nudge1");
		NarrativeQueue.QueueConversation(nar_moveintovault_nudge);
	end
end

global nar_moveintovault_nudge= {
	name = "nar_moveintovault_nudge",

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_moveintovault_nudge narrative");
		--story_blurb_add("domain", "nudge2");
		AIDialogManager.DisableAIDialog();

	end,
		
	lines = {
		[1] = {
				If = function (thisLine, thisConvo, queue, lineNumber)
				return b_collectible_used == false; -- GAMMA_TRANSITION: If vale
			end,		
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Vale: Needs text!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_03700.sound'),
			sleepAfter = 0,
		},
	
	},

	OnFinish = function (thisConvo, queue) -- VOID
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
	end,
};

-- =================================================================================================
--
--					CONTROL ROOM SECTION
--
-- Covers content in the control room section.
--
-- =================================================================================================


function nar_control_room_enter()
	SleepUntil([| volume_test_players( VOLUMES.nar_control_room_intro)], 1);
		CreateThread(halsey_idle_chatter_off);
		b_moved_into_vault = true;
		
		NarrativeQueue.InterruptConversation(nar_moveintovault_nudge);
end


global nar_control_room_intro = {
	name = "nar_control_room_intro",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return volume_test_players(VOLUMES.nar_control_room_intro);
	end,

	
	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_control_room_intro narrative");
		b_moved_into_vault = true;
		AIDialogManager.DisableAIDialog();

	end,

	lines = {

	},

	OnFinish = function (thisConvo, queue) -- VOID
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
	end,
		localVariables = {
		checkConditionsPassed = 0,
	},
};

function dormant.knight_combat_complete()
print("old");
--	Wake(dormant.halsey_domain_murals);
--	Wake(dormant.halsey_combat_complete);
end

-- =================================================================================================
--
--					SECONDARY AUDIO LOGS
--
-- Audio Log Content	
--
-- =================================================================================================


-- =================================================================================================



-- =================================================================================================
--
--					CHATTER
--
-- Team secondary chatter.
--
-- =================================================================================================


-- =================================================================================================

global W3Halsey_KAMTCHATKA__CHATTER_04 = {
	name = "W3Halsey_KAMTCHATKA__CHATTER_04",

	CanStart = function (thisConvo, queue)
		return unit_get_health( SPARTANS.vale) > 0; -- GAMMA_CONDITION
	end,


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		
	end,

	lines = {

		[1] = {
		
			If = function (self, queue, lineNumber) -- BOOLEAN
				return b_halsey_idle_chatter_on == true and b_transmission_received == true;
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
								RunClientScript("pip_genereic_radio_intercept_60");
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale -- GAMMA_CHARACTER: Vale
			text = "Another transmission.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_05200.sound'),
											AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
					sleepAfter = 1,
				AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				
				PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_cv_elite01_00500.sound'), nil);
				return 3;
			end,
		},
		[2] = {
			If = function (self, queue, lineNumber) -- BOOLEAN
				return b_transmission_received == false;
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Locke, listen to this...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_01200.sound'),
											AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
			sleepAfter = 1,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				b_transmission_received  = true;
				hud_show_radio_transmission_hud("jul_transmission_name");
				
				return 3;
			end,
				
		},
		[3] = {
			If = function (self, queue, lineNumber) -- BOOLEAN
				return b_halsey_idle_chatter_on == true;
			end,

			text = "If 'Mdama succeeds here, we will crush the Arbiter.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_cv_elite01_00500.sound'),
			playDurationAdjustment = 0.7,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				
				return lineNumber + 1;
			end,
		},
			[4] = {
						If = function (self, queue, lineNumber) -- BOOLEAN
				return b_halsey_idle_chatter_on == true;
			end,
										OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "If 'Mdama succeeds here, we will crush the Arbiter.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_04800.sound'),
											AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},	
		[5] = {
			If = function (self, queue, lineNumber) -- BOOLEAN
				return b_halsey_idle_chatter_on == true;
			end,
			sleepBefore = 1,
			

			text = "First the Arbiter, and then his human friends. Assuming 'Mdama cements his hold on power. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_cv_elite02_00300.sound'),
					playDurationAdjustment = 0.7,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				
				return lineNumber + 1;
			end,
		},
		[6] = {
				If = function (self, queue, lineNumber) -- BOOLEAN
				return b_halsey_idle_chatter_on == true;
			end,
										OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "First the Arbiter, and then his human friends. Assuming 'Mdama cements his hold on power.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_04900.sound'),
											AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[7] = {
		If = function (self, queue, lineNumber) -- BOOLEAN
				return b_halsey_idle_chatter_on == true;
			end,
			sleepBefore = 1,
			
		
			text = "The Sangheili have always been the strength of the Covenant. We do not need the Prophets to lead us. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_cv_elite01_00600.sound'),
			playDurationAdjustment = 0.7,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				
				return lineNumber + 1;
			end,
		},
		[8] = {
				If = function (self, queue, lineNumber) -- BOOLEAN
				return b_halsey_idle_chatter_on == true;
			end,
										OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "The Sangheili have always been the strength of the Covenant. We do not need the Prophets to lead us.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_05000.sound'),
											AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},		
		[9] = {
			If = function (self, queue, lineNumber) -- BOOLEAN
				return b_halsey_idle_chatter_on == true;
			end,
			sleepBefore = 1,
			
			text = "Indeed, brother. 'Mdama will light the path to the Great Journey.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_cv_elite02_00400.sound'),
			playDurationAdjustment = 0.7,
		},
		[10] = {
				If = function (self, queue, lineNumber) -- BOOLEAN
				return b_halsey_idle_chatter_on == true;
			end,
										OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Indeed, brother. 'Mdama will light the path to the Great Journey.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_05100.sound'),
		},		
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		b_halsey_idle_chatter_on = false;
	end,

	localVariables = {},
};












global W3Halsey_KAMTCHATKA__CHATTER_02 = {
	name = "W3Halsey_KAMTCHATKA__CHATTER_02",

	CanStart = function (thisConvo, queue)
		return unit_get_health( SPARTANS.vale) > 0; -- GAMMA_CONDITION
	end,


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	RunClientScript("pip_genereic_radio_intercept_60");
	end,

	lines = {

		[1] = {
		
			If = function (self, queue, lineNumber) -- BOOLEAN
				return b_halsey_idle_chatter_on == true and b_transmission_received == true;
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
								
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale -- GAMMA_CHARACTER: Vale
			text = "Another transmission.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_05200.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
					sleepAfter = 1,
				AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				
				PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_cv_elite01_00500.sound'), nil);
				return 3;
			end,
		},
		[2] = {
			ElseIf = function (self, queue, lineNumber) -- BOOLEAN
				return b_transmission_received == false;
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Locke, listen to this...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_01200.sound'),
											AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
			sleepAfter = 1,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				b_transmission_received  = true;
				
				return 3;
			end,
				
		},
		[3] = {
				If = function (self, queue, lineNumber) -- BOOLEAN
				return b_halsey_idle_chatter_on == true;
			end,
			sleepBefore = 0.5,
			

			text = "(IN SANGHEILI)\r\nI never believed Mdama had as much control over these Prometheans as he claimed. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_cv_elite01_00800.sound'),
					playDurationAdjustment = 0.3,
				AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				
				return lineNumber + 1;
			end,
		},
			[4] = {
				If = function (self, queue, lineNumber) -- BOOLEAN
				return b_halsey_idle_chatter_on == true;
			end,
													OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "I never believed Mdama had as much control over these Prometheans as he claimed. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_05300.sound'),
											AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[5] = {
				If = function (self, queue, lineNumber) -- BOOLEAN
				return b_halsey_idle_chatter_on == true;
			end,
			sleepBefore = 1,
			

			text = "He claws at whatever advantage presents itself. We will see if this mission bears any fruit or whether it becomes yet another in his long list of failures.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_cv_elite02_00800.sound'),
			playDurationAdjustment = 0.4,
		},
		[6] = {
				If = function (self, queue, lineNumber) -- BOOLEAN
				return b_halsey_idle_chatter_on == true;
			end,
													OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "He claws at whatever advantage presents itself. We will see if this mission bears any fruit or whether it becomes yet another in his long list of failures.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_05400.sound'),
											AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		b_halsey_idle_chatter_on = false;
	end,

	localVariables = {},
};


global W3Halsey_KAMTCHATKA__CHATTER_03 = {
	name = "W3Halsey_KAMTCHATKA__CHATTER_03",

	CanStart = function (thisConvo, queue)
		return unit_get_health( SPARTANS.vale) > 0; -- GAMMA_CONDITION
	end,


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {

						If = function (self, queue, lineNumber) -- BOOLEAN
				return b_halsey_idle_chatter_on == true;
			end,
					
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Vale : We know so little about Forerunner civilization. Halsey's obsession with them almost makes sense to me.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_01500.sound'),
			sleepAfter = 0,
		},
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		b_halsey_idle_chatter_on = false;
	end,

	localVariables = {},
};

global W3Halsey_KAMTCHATKA__CHATTER_01 = {
	name = "W3Halsey_KAMTCHATKA__CHATTER_01",
		CanStart = function (thisConvo, queue)
		return unit_get_health( SPARTANS.tanaka) > 0 and unit_get_health( SPARTANS.vale) > 0; -- GAMMA_CONDITION
	end,


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
					If = function (self, queue, lineNumber) -- BOOLEAN
				return b_halsey_idle_chatter_on == true;
			end,
			
										OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Gotta respect the Forerunner Builders. They made things to last.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_tanaka_04300.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[2] = {
					If = function (self, queue, lineNumber) -- BOOLEAN
				return b_halsey_idle_chatter_on == true;
			end,
			
										OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "And shoved it in every corner of everything. Can't land on a planet without tripping over something they left behind.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_buck_04600.sound'),
		},
		[3] = {
					If = function (self, queue, lineNumber) -- BOOLEAN
				return b_halsey_idle_chatter_on == true;
			end,
			
										OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VaLE
			text = "The rate of discoveries has been stepping up lately. Have you noticed that? Ever since Requiem.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3halsey\001_vo_scr_w3halsey_un_vale_04200.sound'),
		},
--           
--           __________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

function halsey_idle_chatter_start()
b_halsey_idle_chatter_on = true;
PrintNarrative("Enabled Idle Chatter");
	sleep_rand_s(45, 65);
	SleepUntil( [| b_collectible_used == false ], 1);
	if b_halsey_chatter_2_played == true and b_halsey_chatter_3_played == false and b_halsey_idle_chatter_on == true then
	NarrativeQueue.QueueConversation(W3Halsey_KAMTCHATKA__CHATTER_03);
			b_halsey_chatter_3_played = true;
		
		elseif b_halsey_chatter_1_played == true and b_halsey_chatter_2_played == false and b_halsey_idle_chatter_on == true then
			b_halsey_chatter_2_played = true;
			NarrativeQueue.QueueConversation(W3Halsey_KAMTCHATKA__CHATTER_02);
		elseif b_halsey_chatter_1_played == false and b_halsey_idle_chatter_on == true then
			b_halsey_chatter_1_played = true;
			NarrativeQueue.QueueConversation(W3Halsey_KAMTCHATKA__CHATTER_01);
		end
	
end


function halsey_idle_chatter_off()
	
	PrintNarrative("Killed Idle Chatter");
	NarrativeQueue.EndConversationEarly(W3Halsey_KAMTCHATKA__CHATTER_01);
NarrativeQueue.EndConversationEarly(W3Halsey_KAMTCHATKA__CHATTER_02);
NarrativeQueue.EndConversationEarly(W3Halsey_KAMTCHATKA__CHATTER_03);

	b_halsey_idle_chatter_on = false;			
	
end






--## CLIENT 
function remoteClient.pip_halsey_forerunnertemple_60()
	
	hud_play_pip_from_tag(TAG('bink\campaign\pip_halsey_forerunnertemple_60.bink'));
end

function remoteClient.pip_halsey_knight_hitpoint_60()
	
	hud_play_pip_from_tag(TAG('bink\campaign\pip_halsey_knight_hitpoint_60.bink'));
end

function remoteClient.pip_genereic_radio_intercept_60()
	
	hud_play_pip_from_tag(TAG('bink\campaign\pip_genereic_radio_intercept_60.bink'));
end



function remoteClient.nar_test_bink1()
	
	hud_play_pip_from_tag(TAG('ui\wpf\gltest\test.bink'));
end

function remoteClient.nar_test_bink2()

	hud_play_pip_from_tag(TAG('bink\campaign\h5_pip_proxy_60.bink'));
end



function remoteClient.sound_impulse_start_client_narr(soundTag:tag, theObject:object, theScale:number)
print('PASS 5');

	sound_impulse_start(soundTag, theObject, theScale);
end


--156430 - making this client and called from the cinematic to improve subtitle matching
--createing a global client function for tracking this thread and killing it when the cinema is skipped or ended
global th_halsey_cinematic_subtitles:thread = nil;

function HalseyCinematicSubtitlesPlay()
	print ("starting halsey_cinematic_subtitles thread because cinema is starting");
	th_halsey_cinematic_subtitles = CreateThread (halsey_cinematic_subtitles);
end

function HalseyCinematicSubtitlesKill()
	if th_halsey_cinematic_subtitles then
		print ("killing halsey_cinematic_subtitles thread because cinema is skipping or ending");
		KillThread (th_halsey_cinematic_subtitles);
		th_halsey_cinematic_subtitles = nil;
	end
end

function HalseyCinematicSubtitlesPrint(snd_sound:tag, o_object:object)
	print ("subtitles starting ", snd_sound, o_object);
	sound_impulse_start_dialogue(snd_sound, o_object);
end

function halsey_cinematic_subtitles()
	sleep_s(32);

	HalseyCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_000opening\001_VO_CIN_000Opening_UN_HALSEY_00400.sound'), nil);
	sleep_s(4);

	HalseyCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_000opening\001_VO_CIN_000Opening_UN_HALSEY_00100.sound'), nil);
	sleep_s(7.75);

	HalseyCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_000opening\001_VO_CIN_000Opening_UN_HALSEY_00500.sound'), nil);
	sleep_s(8.5);

	HalseyCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_000opening\001_vo_cin_000opening_un_halsey_00200.sound'), nil);
	sleep_s(36.5);

	HalseyCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_000opening\001_vo_cin_000opening_un_lasky_00100.sound'), nil);
	sleep_s(10);

	HalseyCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_000opening\001_VO_CIN_000Opening_UN_Lasky_00500.sound'), nil);
	sleep_s(7.75);

	HalseyCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_000opening\001_vo_cin_000opening_un_palmer_00100.sound'), nil);
	sleep_s(9);

	HalseyCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_000opening\001_vo_cin_000opening_un_palmer_00200.sound'), nil);
	sleep_s(5.75);

	HalseyCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_000opening\001_vo_cin_000opening_un_locke_00100.sound'), nil);
	sleep_s(2);

	HalseyCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_000opening\001_vo_cin_000opening_un_lasky_00300.sound'), nil);
	sleep_s(3);

	HalseyCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_000opening\001_vo_cin_000opening_un_locke_00200.sound'), nil);
	sleep_s(1.5);

	HalseyCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_000opening\001_vo_cin_000opening_un_vale_00100.sound'), nil);
	sleep_s(2);

	HalseyCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_000opening\001_vo_cin_000opening_un_tanaka_00300.sound'), nil);
	sleep_s(3.5);

	HalseyCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_000opening\001_vo_cin_000opening_un_buck_00601.sound'), nil);
	sleep_s(3.5);

	HalseyCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_000opening\001_vo_cin_000opening_un_buck_00602.sound'), nil);
	sleep_s(3);

	HalseyCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_000opening\001_vo_cin_000opening_un_locke_01200.sound'), nil);
	sleep_s(3);

	HalseyCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_000opening\001_vo_cin_000opening_un_buck_00400.sound'), nil);
	sleep_s(1);

	HalseyCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_000opening\001_vo_cin_000opening_un_locke_01300.sound'), nil);
	sleep_s(36.5);

	HalseyCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_000opening\001_vo_cin_000opening_un_locke_00600.sound'), nil);
	sleep_s(2.5);

	HalseyCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_000opening\001_vo_cin_000opening_un_tanaka_00200.sound'), nil);
	sleep_s(2);

	HalseyCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_000opening\001_vo_cin_000opening_un_locke_00700.sound'), nil);
	sleep_s(2);

	HalseyCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_000opening\001_vo_cin_000opening_un_buck_00200.sound'), nil);
	sleep_s(2);

	HalseyCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_000opening\001_vo_cin_000opening_un_vale_00300.sound'), nil);
	sleep_s(3.75);

	HalseyCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_000opening\001_vo_cin_000opening_un_locke_00300.sound'), nil);
	sleep_s(2);

	HalseyCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_000opening\001_vo_cin_000opening_un_buck_00100.sound'), nil);
	sleep_s(48.5);

	HalseyCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_000opening\001_VO_CIN_000Opening_UN_Lasky_00200.sound'), nil);
end