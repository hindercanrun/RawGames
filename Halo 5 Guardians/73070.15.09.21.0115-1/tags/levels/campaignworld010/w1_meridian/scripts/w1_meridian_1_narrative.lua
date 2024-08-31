--## SERVER

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ WORLD 01 NARRATIVE - MERIDIAN 1 *_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*

-- =================================================================================================
-- =================================================================================================b
-- =================================================================================================
-- *** GLOBALS ***
-- =================================================================================================		
global b_all_outpost_enemies_dead : boolean = false;
global b_scorpion_discovered:boolean = false;
global b_meridian_temp_cin_complete : boolean = false;
global turret_nudge_played:boolean = false;
global b_outpost_combat_complete:boolean = false;
global b_left_outpost:boolean = false;
global b_advanced_to_gate:boolean = false;
global b_start_opening_door:boolean = false;
global gate_all_clear:boolean = false;
global b_elevator_interior_exit:boolean = false;
global b_pelican_down:boolean = false;
global vale_cleared_line_played:boolean = false;
global locke_cleared_line_played:boolean = false;
global tanaka_cleared_line_played:boolean = false;
global buck_cleared_line_played:boolean = false;
global b_turrets_online:boolean = false;
	global b_meridian_idle_chatter_on:boolean = false;
	global b_meridian_chatter_1_played:boolean = false;
	global b_meridian_chatter_2_played:boolean = false;
	global b_meridian_chatter_3_played:boolean = false;
	global b_meridian_chatter_4_played:boolean = false;
	global b_meridian_chatter_5_played:boolean = false;
	global b_meridian_chatter_6_played:boolean = false;
	global b_meridian_chatter_7_played:boolean = false;
global sloan_pa_playing:boolean = false;
global b_robards_area_enter:boolean = false;
global b_tanaka_sniper:boolean = false;
global b_sniped_the_generator:boolean = false;
global b_garage_intro:boolean = false;
global sloan_cleared_line_played:boolean=false;
global miner_chatter_hall_01_played:boolean = false;
global miner_chatter_hall_02_played:boolean = false;
global miner_chatter_hall_03_played:boolean = false;
global miner_chatter_hall_04_played:boolean = false;
global miner_chatter_hall_05_played:boolean = false;
global miner_chatter_injured_01_played:boolean = false;
global miner_chatter_injured_02_played:boolean = false;
global miner_chatter_injured_03_played:boolean = false;
global miner_crouched_chatter_01_played:boolean = false;
global miner_crouched_chatter_02_played:boolean = false;
global miner_crouched_chatter_03_played:boolean = false;
global miner_crouched_chatter_04_played:boolean = false;
global miner_crouched_chatter_05_played:boolean = false;
global miner_crouched_chatter_06_played:boolean = false;
global miner_standing_01_played:boolean = false;
global b_gate_button_used:boolean = false;
global b_two_gate_buttons_used:boolean = false;
global b_outpost_objective:boolean = false;
global b_pa_line_playing:boolean = false;
global s_thread_mer_elevator_log:thread = nil;
global collectible_vo_on:boolean = nil;
global b_outpost_combat_complete2:boolean = false;
--/////////////////////////////////////////////////////////////////////////////////
-- MAIN
--/////////////////////////////////////////////////////////////////////////////////

function w1_meridian_one_startup():void
	print("NARRATIVE  -  MERIDIAN - WELCOME - Start ");

		
	
		--Wake(dormant.w1_garage_scripts);
		--Wake(dormant.w1_warthog_scripts);
		--Wake(dormant.w1_elevator_scripts);

--	SET THE DISPLAY OF TEMP BLURB OFF	
	--dialog_line_temp_blurb_force_set(false);
	--b_temp_line_display_blurb = false;

--	SET THE NARRATIVE DEBUG INFO ON


	
	
end


-- =================================================================================================
-- =================================================================================================


-- =================================================================================================
--
--					ELEVATOR/OUTPOST SECTION
--
-- Covers content in the elevator and elevator outpost.
--
-- =================================================================================================

function dormant.w1_elevator_scripts()
		NarrativeQueue.QueueConversation(W1HubMeridian_space_elevator_bASE__door_reveal);
		
		CreateThread(collectible_used_controller);
		NarrativeQueue.QueueConversation(W1HubMeridian_SPACE_ELEVATOR_EXTERIOR__BANDWAGON_ARRIVES);	
		NarrativeQueue.QueueConversation(W1HubMeridian_space_elevator_exterioR__POWER_WEAPONS);
		NarrativeQueue.QueueConversation(W1HubMeridian_turret_callout);
		
		CreateThread(w1_meridian_1_all_enemies_dead);
		NarrativeQueue.QueueConversation(W1HubMeridian_space_elevator_exterioR__SNIPER_TOWER);
		--CreateThread(w1_mer_unsc_datapad_01);
		CreateThread(nar_ass_turret_listener);
		--CreateThread(w1_mer_unsc_datapad_02);
		--CreateThread(w1_mer_unsc_datapad_03);
		
		CreateThread(w1_meridian_1_fore_alive);
		--CreateThread(w1_mer_meridian_radio_01);
		
		NarrativeQueue.QueueConversation(W1HubMeridian_AUDIO_LOG__FIRST_OLD_MERIDIAN_RADIO);
		CreateThread(w1_meridian_1_generator_destroyed);
		
		
		CreateThread(nar_miner_chatter_crouching_handler);
		CreateThread(nar_miner_chatter_standing_handler);
		s_thread_mer_elevator_log = CreateThread(w1_meridian_elevator_screen);
end

-- =================================================================================================


function w1_meridian_1_elevator_VO()
sleep_s(2);
	NarrativeQueue.QueueConversation(W1HubMeridian_MERIDIAN__SPACE_ELEVATOR_RIDe);
end

global W1HubMeridian_MERIDIAN__SPACE_ELEVATOR_RIDe = {
	name = "W1HubMeridian_MERIDIAN__SPACE_ELEVATOR_RIDe",



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
			text = "The Covenant glassed this planet in '48. It was a UNSC colony then, but we never came back.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_04200.sound'),
		},
		[2] = {
			
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
						sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Run by a private corp now, like most of the frontier worlds. Chipping away the glass, making her livable.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_VO_SCR_W1HubMeridian_UN_Tanaka_00300.sound'),
			
		},
	--			[3] = {
	
	--		character = CHARACTER_OBJECTS.elevator_pa, -- GAMMA_CHARACTER: Tanaka
	--		text = "...",
	--		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_elevatorpa_00100.sound'),
			--playDurationAdjustment = 0.75,
		--	AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
		---	
		--		return 2; -- GAMMA_NEXT_LINE_NUMBER
		--	end,
	--	},
		[3] = {
			sleepBefore = 1,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Why are we taking the long way down?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_VO_SCR_W1HubMeridian_UN_Buck_00100.sound'),
		},
		[4] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

		sleepBefore = 1,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka 
			text = "Because it's polite. Grew up on an indie colony like Meridian. Folks out here don't take well to the UNSC landing in the middle of town. Tend to see it as an act of aggression.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_VO_SCR_W1HubMeridian_UN_Tanaka_00100.sound'),
			
		},
		[5] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
				sleepBefore = 1.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Speaking of acts of aggression.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_07400.sound'),
		},
		[6] = {
			
		sleepBefore = 2,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Those are Forerunner ships!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_03200.sound'),
		},


		[7] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "What the hell are Forerunners doing here?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_00400.sound'),
		},
		[8] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
				
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "We're going to find out.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_01000.sound'),
		},
		[9] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
		sleepBefore = 1,
			
			text = "Whoever the hell is on my elevator, identify yourself.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_00400.sound'),
			
		},
		[10] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "This is Spartan Jameson Locke, UNSC. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_00300.sound'),
		},
		[11] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
		sleepBefore = 0.5,
			
			text = "Thugs! The lot of you! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_00100.sound'),
		},
		[12] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "To whom am I speaking?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_04607.sound'),
		},
		[13] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
		sleepBefore = 0.5,
			
			text = "This is Governor Sloan--",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_00700.sound'),
		},
	
	
		[14] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 2,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Governor didn't seem to want our help.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_03600.sound'),
		},
		[15] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 1,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Well, he's going to get it anyway.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_02000.sound'),
		},
},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_elevatorpa_00200.sound'), OBJECTS.vo_emitter_zs_01_left);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_elevatorpa_00200b.sound'), OBJECTS.vo_emitter_zs_01_right);
		
		
	end,

	localVariables = {},
};

global W1HubMeridian_sloan_announcement = {
	name = "W1HubMeridian_sloan_announcement",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = CHARACTER_OBJECTS.interior_pa, -- GAMMA_CHARACTER: Minerfemale05
			text = "Sloan announcement.",
			tag = TAG('ound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_VO_SCR_W1HubMeridian_UN_SLOAN_01500.sound'),
			playDurationAdjustment = 0.99,
		},
	[2] = {
			character = CHARACTER_OBJECTS.interior_pa_2, -- GAMMA_CHARACTER: Minerfemale05
			text = "Sloan announcement.",
			tag = TAG('ound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_VO_SCR_W1HubMeridian_UN_SLOAN_01500.sound'),
		},
              
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		miner_chatter_injured_01_played = true;
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};

function w1_meridian_1_elevator_base()
	print("w1_meridian_1_elevator_base");
	sleep_s(2);
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_VO_SCR_W1HubMeridian_UN_SLOAN_01500.sound'), OBJECTS.interior_pa);
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_VO_SCR_W1HubMeridian_UN_SLOAN_01500.sound'), OBJECTS.interior_pa_2);
end

global W1HubMeridian_SPACE_ELEVATOR_MINER_MEET = {
	name = "W1HubMeridian_SPACE_ELEVATOR_MINER_MEET",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,
		sleepBefore = 2.5,
	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		object_destroy(OBJECTS.elevator_audio_log_control);
			--	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale01_00100.sound'), OBJECTS.elevator_base_miner);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return object_get_health (ai_get_object(AI.sq_welcomeparty.welcome_miner)) >= 0.99;
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "What's going on?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_00400.sound'),
					sleepAfter = 7,
		},
		[2] = {

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Osiris, the people of Meridian Station need our assistance.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_04626.sound'),
		},



	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
			--	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale01_00200.sound'), OBJECTS.elevator_base_miner);
			CreateThread(nar_miner_chatter_hall_handler);
		CreateThread(w1_meridian_1_elevator_base);
			CreateThread(w1_meridian_1_interior_pa);
			b_outpost_objective = true;
			ObjectiveShow (TITLES.ct_obj_meridian_1);
	end,


		localVariables = {
		checkConditionsPassed = 0,
	},
};

function nar_distress_call_start()
	object_create("elevator_audio_log_control");
end

global W1HubMeridian_SPACE_ELEVATOR_BASE__MINER_AT_CONSOLE = {
	name = "W1HubMeridian_SPACE_ELEVATOR_BASE__MINER_AT_CONSOLE",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.sq_lobby_marines_idle.spawnpoint22, -- GAMMA_CHARACTER: MinerFEMALE04
			text = "Meridian Station, what's your status?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minerfemale04_00300.sound'),
		},
		[2] = {
	
			character = CHARACTER_OBJECTS.mer_log_speaker, -- GAMMA_CHARACTER: SLOAN
			text = "Invaders haven't breached the town.  Turrets are doing their job keeping them back, as well as a our folks in the sky.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_01200.sound'),
		},
		[3] = {
			character = AI.sq_lobby_marines_idle.spawnpoint22, -- GAMMA_CHARACTER: Minerfemale04
			text = "That's such a relief.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minerfemale04_00400.sound'),
		},
		[4] = {
	
			character = CHARACTER_OBJECTS.mer_log_speaker, -- GAMMA_CHARACTER: SLOAN
			text = "Just hold on out there. We'll get through this.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_01300.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};


global W1HubMeridian_SPACE_ELEVATOR_BASE__Distraught_miner = {
	name = "W1HubMeridian_SPACE_ELEVATOR_BASE__Distraught_miner",

CanStart = function (thisConvo, queue) -- BOOLEAN
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if (ai_living_count (AI.miners_elevator_int) >= 1 ) then
			thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return volume_test_players(VOLUMES.elevator_landing_01) and objects_distance_to_object(players_human(),ai_get_object(AI.miners_elevator_int.marine_right_01)) < 8 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.miners_elevator_int.marine_right_01, -- GAMMA_CHARACTER: MINERFEMALE06
			text = "There's people out there still. Fighting. And I'm just standing here doing nothing. I need to go out there. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minerfemale06_00100.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		--[[]]
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};


function nar_miner_chatter_hall_handler()

	NarrativeQueue.QueueConversation(miner_chatter_hall_01);
	SleepUntil([| miner_chatter_hall_01_played == true], 10);
		NarrativeQueue.QueueConversation(W1HubMeridian_SPACE_ELEVATOR_BASE__INJURED_MINER_3);
		
		sleep_s(10);
				NarrativeQueue.QueueConversation(miner_chatter_hall_04);
	SleepUntil([| miner_chatter_hall_02_played == true], 10);
		sleep_s(10);
		NarrativeQueue.QueueConversation(miner_chatter_hall_03);
		NarrativeQueue.QueueConversation(W1HubMeridian_SPACE_ELEVATOR_BASE__INJURED_MINER_4);
		--sleep_s(5);
		--NarrativeQueue.QueueConversation(W1HubMeridian_SPACE_ELEVATOR_BASE__MINER_AT_CONSOLE);
	SleepUntil([| miner_chatter_hall_04_played == true], 10);
		sleep_s(20);
		NarrativeQueue.QueueConversation(miner_chatter_hall_05);		
			

end


global miner_chatter_hall_01 = {
	name = "miner_chatter_hall_01",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		if (thisConvo.localVariables.checkConditionsPassed == 0) then
			if (ai_living_count (AI.sq_lobby_marines_idle) >= 1 ) then
				thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.sq_lobby_marines_idle.spawnpoint25)) < 5 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,
	

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.sq_lobby_marines_idle.spawnpoint25, -- GAMMA_CHARACTER: MiNERMALE02
			text = "What the hell are those things?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale02_00400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		miner_chatter_hall_01_played = true;
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};
global miner_chatter_hall_02 = {
	name = "miner_chatter_hall_02",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		if (thisConvo.localVariables.checkConditionsPassed == 0) then
			if (ai_living_count (AI.sq_lobby_marines_idle) >= 1 ) then
				thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.sq_lobby_marines_idle.spawnpoint21)) < 5 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,
	

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
	[1] = {

			character = AI.sq_lobby_marines_idle.spawnpoint21, -- GAMMA_CHARACTER: MiNERMALE03
			text = "What is this? What's happening?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minerfemale07_00100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		miner_chatter_hall_02_played = true;
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};

global miner_chatter_hall_03 = {
	name = "miner_chatter_hall_03",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		if (thisConvo.localVariables.checkConditionsPassed == 0) then
			if (ai_living_count (AI.sq_lobby_marines_idle) >= 1 ) then
				thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.sq_lobby_marines_idle.spawnpoint21)) < 5 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,
	

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
			[1] = {
			character = AI.sq_lobby_marines_idle.spawnpoint21, -- GAMMA_CHARACTER: MiNERMALE03
			text = "Get the hell off Meridian, you monsters.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minerfemale07_00200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		miner_chatter_hall_03_played = true;
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};

global miner_chatter_hall_04 = {
	name = "miner_chatter_hall_04",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		if (thisConvo.localVariables.checkConditionsPassed == 0) then
			if (ai_living_count (AI.sq_lobby_marines_idle) >= 1 ) then
				thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.sq_lobby_marines_idle.spawnpoint23)) < 5 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,
	

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.sq_lobby_marines_idle.spawnpoint24, -- GAMMA_CHARACTER: MINERFEMALE01
			text = "Why are Spartans here?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_VO_SCR_W1HubMeridian_UN_MINERMALE02_00500.sound'),
		},
		[2] = {
			character = AI.sq_lobby_marines_idle.spawnpoint23, -- GAMMA_CHARACTER: MiNERMALE05
			text = "Governor Sloan was right. The UNSC have come for us.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minerfemale05_00400.sound'),
		},
			},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		miner_chatter_hall_04_played = true;
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};

global miner_chatter_hall_05 = {
	name = "miner_chatter_hall_05",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		if (thisConvo.localVariables.checkConditionsPassed == 0) then
			if (ai_living_count (AI.sq_marines_mid_front) >= 1 ) then
				thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.sq_marines_mid_front.sp1)) < 5 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,
	

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
	[1] = {

			character = AI.sq_marines_mid_front.sp1, -- GAMMA_CHARACTER: MINERFEMALE01
			text = "I can fight. I shouldn't be hiding in here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minerfemale01_01500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
			miner_chatter_hall_05_played = true;
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};


global miner_chatter_hall_06 = {
	name = "miner_chatter_hall_06",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		if (thisConvo.localVariables.checkConditionsPassed == 0) then
			if (ai_living_count (AI.sq_marines_mid_front) >= 1 ) then
				thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.sq_marines_mid_front.sp1)) < 5 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,
	

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.sq_marines_mid_front.sp1, -- GAMMA_CHARACTER: MiNERMALE02
			text = "What are Spartans doing here?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minerfemale01_01600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		miner_crouched_chatter_06_played = true;
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};


function nar_miner_chatter_injured_handler()
	

end

global W1HubMeridian_SPACE_ELEVATOR_BASE__INJURED_MINER_1 = {
	name = "W1HubMeridian_SPACE_ELEVATOR_BASE__INJURED_MINER_1",

CanStart = function (thisConvo, queue) -- BOOLEAN
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if (ai_living_count (AI.miner_welcome_party) >= 1 ) then
			thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.miner_welcome_party.injured_miner_04)) < 5 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.miner_welcome_party.injured_miner_04, -- GAMMA_CHARACTER: Minerfemale05
			text = "My shoulder... I think it's dislocated...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale05_01300.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		miner_chatter_injured_01_played = true;
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};



global W1HubMeridian_SPACE_ELEVATOR_BASE__INJURED_MINER_2 = {
	name = "W1HubMeridian_SPACE_ELEVATOR_BASE__INJURED_MINER_2",

CanStart = function (thisConvo, queue) -- BOOLEAN
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if (ai_living_count (AI.miner_welcome_party) >= 1 ) then
			thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return volume_test_players(VOLUMES.injured_miner_area) and objects_distance_to_object(players_human(),ai_get_object(AI.miner_welcome_party.injured_miner_06)) < 5 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.miner_welcome_party.injured_miner_06, -- GAMMA_CHARACTER: Minermale07
			text = "Those things...what are they...why're they here...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale07_00100.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		miner_chatter_injured_02_played = true;
	end,

	localVariables = {
		checkConditionsPassed = 0,
	},
};


global W1HubMeridian_SPACE_ELEVATOR_BASE__INJURED_MINER_3 = {
	name = "W1HubMeridian_SPACE_ELEVATOR_BASE__INJURED_MINER_3",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		if (thisConvo.localVariables.checkConditionsPassed == 0) then
			if (ai_living_count (AI.sq_lobby_marines_idle) >= 1 ) then
				thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.sq_lobby_marines_idle.spawnpoint26)) < 5 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,
	

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.sq_lobby_marines_idle.spawnpoint26, -- GAMMA_CHARACTER: MiNERMALE06
			text = "Has anyone heard from Apogee Station? ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale06_00600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		miner_chatter_injured_03_played = true;
		NarrativeQueue.QueueConversation(miner_chatter_hall_02);
	end,
		localVariables = {
		checkConditionsPassed = 0,
	},
};

global W1HubMeridian_SPACE_ELEVATOR_BASE__INJURED_MINER_4 = {
	name = "W1HubMeridian_SPACE_ELEVATOR_BASE__INJURED_MINER_4",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		if (thisConvo.localVariables.checkConditionsPassed == 0) then
			if (ai_living_count (AI.sq_lobby_marines_idle) >= 1 ) then
				thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.sq_lobby_marines_idle.spawnpoint26)) < 5 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = 	AI.sq_lobby_marines_idle.spawnpoint26, -- GAMMA_CHARACTER: MiNERMALE06
			text = "UNSC forces on Meridian?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale06_00700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};



function nar_miner_chatter_crouching_handler()

	NarrativeQueue.QueueConversation(miner_crouched_chatter_01);
	SleepUntil([| miner_crouched_chatter_01_played == true], 10);
	sleep_s(15);
		NarrativeQueue.QueueConversation(miner_crouched_chatter_02);
	SleepUntil([| miner_crouched_chatter_02_played == true], 10);
	sleep_s(15);
		NarrativeQueue.QueueConversation(miner_crouched_chatter_03);
	SleepUntil([| miner_crouched_chatter_03_played == true], 10);
	sleep_s(15);
		NarrativeQueue.QueueConversation(miner_crouched_chatter_04);

end

global miner_crouched_chatter_03 = {
	name = "miner_crouched_chatter_03",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		if (thisConvo.localVariables.checkConditionsPassed == 0) then
			if (ai_living_count (AI.miners_elevator_int) >= 1 ) then
				thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.miners_elevator_int.marine_right_01)) < 5 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,
	

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
			[1] = {
			character = AI.miners_elevator_int.marine_right_01, -- GAMMA_CHARACTER: MiNERFEMALE06
			text = "I think I'm gonna be sick.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minerfemale06_00200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
			miner_crouched_chatter_01_played = true;
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};

global miner_crouched_chatter_02 = {
	name = "miner_crouched_chatter_02",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		if (thisConvo.localVariables.checkConditionsPassed == 0) then
			if (ai_living_count (AI.miners_elevator_int) >= 1 ) then
				thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.miners_elevator_int.marine_left)) < 5 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,
	

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.miners_elevator_int.marine_left, -- GAMMA_CHARACTER: MINERMALE04
			text = "This can't be real. Those things can't be real.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale04_00700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		miner_crouched_chatter_02_played = true;
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};


global miner_crouched_chatter_01 = {
	name = "miner_crouched_chatter_01",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		if (thisConvo.localVariables.checkConditionsPassed == 0) then
			if (ai_living_count (AI.miners_elevator_int) >= 1 ) then
				thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.miners_elevator_int.marine_right_01)) < 5 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,
	

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.miners_elevator_int.marine_right_01, -- GAMMA_CHARACTER: MiNERFEMALE06
			text = "Spartans on Meridian. Never thought I'd see the day.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minerfemale06_00300.sound'),
		},
		
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		 miner_crouched_chatter_03_played = true;
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};


global miner_crouched_chatter_04 = {
	name = "miner_crouched_chatter_04",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		if (thisConvo.localVariables.checkConditionsPassed == 0) then
			if (ai_living_count (AI.miners_elevator_int) >= 1 ) then
				thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.miners_elevator_int.marine_left)) < 5 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,
	

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.miners_elevator_int.marine_left, -- GAMMA_CHARACTER: MINERMALE04
			text = "Spartans? Oh no. Why?\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale04_00800.sound'),
		},
--           
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		 miner_crouched_chatter_04_played = true;
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};

function nar_miner_chatter_standing_handler()

	NarrativeQueue.QueueConversation(miner_standing_01);
	

end


global miner_standing_01 = {
	name = "miner_standing_01",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		if (thisConvo.localVariables.checkConditionsPassed == 0) then
			if (ai_living_count (AI.sq_interior_miners) >= 1 ) then
				thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.sq_interior_miners.first_miner)) < 5 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,
	

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.sq_interior_miners.first_miner, -- GAMMA_CHARACTER: MiNERMALE05
			text = "Everyone remain calm. Governor Sloan's on top of the situation.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minerfemale05_00300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		miner_standing_01_played = true;
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};



function w1_meridian_1_interior_pa()
	sleep_s(10);
	if b_elevator_interior_exit == false and b_pa_line_playing == false then 
	 b_pa_line_playing = true;
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_elevatorpa_00300.sound'), OBJECTS.interior_pa);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_elevatorpa_00300b.sound'), OBJECTS.interior_pa_2);
		SoundImpulseStartServer(TAG('sound\003_ambience\003_amb_positional\003_amb_positional_battle\003_amb_positional_battle_explosionsdistantlow_meridian_loop_a.sound'), nil, 1)
	sleep_s(15);
	b_pa_line_playing = false;
	CreateThread(w1_meridian_1_interior_pa);
	end
end
global W1HubMeridian_space_elevator_bASE__door_reveal = {
	name = "W1HubMeridian_space_elevator_bASE__door_reveal",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.elevator_landing_01); -- GAMMA_CONDITION
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
				return volume_test_object(VOLUMES.elevator_landing_01, SPARTANS.locke) == true; -- GAMMA_TRANSITION: If locke
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Meridian control. We need you to open the doors to the space elevator.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_04632.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
		},
--                                                   IF VALE

		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.elevator_landing_01, SPARTANS.vale) == true; -- GAMMA_TRANSITION: If locke
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Meridian control. We need you to open the doors to the space elevator.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_06400.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
		},
--                                                   IF TANAKA

		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.elevator_landing_01, SPARTANS.tanaka) == true; -- GAMMA_TRANSITION: If locke
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
		text = "Meridian control. We need you to open the doors to the space elevator.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_08000.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
		},
--                                                   IF BUCK

		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.elevator_landing_01, SPARTANS.buck) == true; -- GAMMA_TRANSITION: If locke
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Meridian control. We need you to open the doors to the space elevator.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_07700.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 5;
			end,
		},
		[5] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
								hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("minermale02_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,
	
		sleepBefore = 1,
			character =  AI.miners_guarding_door.scared_marine_02, -- GAMMA_CHARACTER: MiNERMALE02
			text = "But it's overrun!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale02_00300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[6] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.elevator_landing_01, SPARTANS.locke) == true; -- GAMMA_TRANSITION: If locke
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Open the doors so we can help.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_03100.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 7;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 10; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--                                                   IF VALE

		[7] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.elevator_landing_01, SPARTANS.vale) == true; -- GAMMA_TRANSITION: If locke
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Open the doors so we can help.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_04900.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 8;
			end,
				AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 10; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--                                                   IF TANAKA

		[8] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.elevator_landing_01, SPARTANS.tanaka) == true; -- GAMMA_TRANSITION: If locke
			end,
			sleepBefore = 0.5,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Open the doors so we can help.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_05800.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 9;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 10; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--                                                   IF BUCK

		[9] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.elevator_landing_01, SPARTANS.buck) == true; -- GAMMA_TRANSITION: If locke
			end,
			sleepBefore = 0.5,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Open the doors so we can help.\r\n\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_05700.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 10;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 10; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[10] = {
				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("minermale01_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,
		
		sleepBefore = 0.5,
			character = AI.miners_guarding_door.scared_marine_01, -- GAMMA_CHARACTER: MINERMALE01
			text = "Dammit, Kyle! Do it!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale01_00300.sound'),
		},

		[11] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("minermale02_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,
		sleepBefore = 0.5,
			character = AI.miners_guarding_door.scared_marine_02, -- GAMMA_CHARACTER: Minermale02
			text = "Fine! Go!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale02_00200.sound'),
		},
		
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		b_open_elevator_exit = true;
		CreateThread(nar_scared_miner);
	end,

	localVariables = {},
};

function nar_scared_miner()
	sleep_s(15);
	NarrativeQueue.QueueConversation(W1HubMeridian_SPACE_ELEVATOR_BASE__Distraught_miner);
end


	function dormant.w1_facility_reveal()
	-- Called in missions script when doors open.
	b_elevator_interior_exit = true;
	sleep_s(2);
	NarrativeQueue.QueueConversation(W1HubMeridian_space_elevator_bASE__door_reveal2);
	KillScript(w1_meridian_1_interior_pa);
	sleep_s(10);
		CreateThread(nar_outpost_nudge_controller);
		
		sleep_s(15);
		
		
	NarrativeQueue.QueueConversation(nar_random_miner_02);
end	

global W1HubMeridian_space_elevator_bASE__door_reveal2 = {
	name = "W1HubMeridian_space_elevator_bASE__door_reveal2",
				canStartOnce = true,
	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_outpost_volume); -- GAMMA_CONDITION
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
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Base is on lockdown. No way out.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_03300.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
		},
		[2] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Must be a way to shut down the security system. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_00400.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
		},
		[3] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) --  
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Yeah. Eliminate the threat. Lockdown ends. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_00500.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				hud_hide_radio_transmission_hud();
				PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_00900.sound'), OBJECTS.exterior_pa);
				PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_00900.sound'), OBJECTS.exterior_pa_2);
				ObjectiveShow (TITLES.ct_obj_meridian_2);
				return 4; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		
	[4] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,	
			sleepBefore = 7,
			text = "Elevator Control! Get those automated turrets online!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_01700.sound'),
		},
		[5] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("minermale02_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,	
		sleepBefore = 0.5,
			
			text = "We're trying, Governor! Security Tower door's jammed!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale02_00700.sound'),
		},
		[6] = {

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 1,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Automated turrets? Those could be useful.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_06400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		b_open_elevator_exit = true;
		--CreateThread(nar_generator_hit_cutoff);
		CreateThread(w1_meridian_1_exterior_pa);
		NarrativeQueue.QueueConversation(nar_random_miner_05);
	end,

	localVariables = {},
};


function w1_meridian_1_exterior_pa()
	sleep_s(10);
	if b_outpost_combat_complete == false and b_left_outpost == false and b_pa_line_playing == false then 
	b_pa_line_playing = true;
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_elevatorpa_00500.sound'), OBJECTS.exterior_pa);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_elevatorpa_00500b.sound'), OBJECTS.exterior_pa_2);
	end
	sleep_s(7);
	b_pa_line_playing = false;
	sleep_s(28);
	sleep_s(15);
	sloan_pa_playing = false;
	if b_outpost_combat_complete == false and b_left_outpost == false and b_pa_line_playing == false then 
		b_pa_line_playing = true;
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_elevatorpa_00500.sound'), OBJECTS.exterior_pa);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_elevatorpa_00500b.sound'), OBJECTS.exterior_pa_2);
	end
	sleep_s(7);
	b_pa_line_playing = false;
	sleep_s(18);
	if b_outpost_combat_complete == false and b_left_outpost == false and b_pa_line_playing == false then 
	sloan_pa_playing = true;
	b_pa_line_playing = true;
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_elevatorpa_00500.sound'), OBJECTS.exterior_pa);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_elevatorpa_00500b.sound'), OBJECTS.exterior_pa_2);
		--PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_01000.sound'), OBJECTS.exterior_pa);
	end
	sleep_s(7);
	b_pa_line_playing = false;
	sleep_s(18);
	sloan_pa_playing = false;
	if b_outpost_combat_complete == false and b_left_outpost == false and b_pa_line_playing == false then 
	b_pa_line_playing = true;
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_elevatorpa_00500.sound'), OBJECTS.exterior_pa);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_elevatorpa_00500b.sound'), OBJECTS.exterior_pa_2);
	end
	sleep_s(7);
	b_pa_line_playing = false;
	sleep_s(23);
	sloan_pa_playing = false;
	if b_outpost_combat_complete == false and b_left_outpost == false and b_pa_line_playing == false then 
	b_pa_line_playing = true;
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_elevatorpa_00500.sound'), OBJECTS.exterior_pa);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_elevatorpa_00500b.sound'), OBJECTS.exterior_pa_2);
		--PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_01100.sound'), OBJECTS.exterior_pa);
	end
	sleep_s(7);
	b_pa_line_playing = false;
	sleep_s(13);
	if b_outpost_combat_complete == false and b_left_outpost == false  then 
		CreateThread(w1_meridian_1_pa_controller);
	end
end

function w1_meridian_1_pa_controller()
	if b_outpost_combat_complete == false and b_left_outpost == false and b_pa_line_playing == false then 
		b_pa_line_playing = true;
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_elevatorpa_00500.sound'), OBJECTS.exterior_pa);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_elevatorpa_00500b.sound'), OBJECTS.exterior_pa_2);
	end
 sleep_s(7);
	b_pa_line_playing = false;
	sleep_s(33);
	if b_outpost_combat_complete == false and b_left_outpost == false  then 
		CreateThread(w1_meridian_1_pa_controller);
	end
	
end




global nar_random_miner_02 = {
	name = "nar_random_miner_02",

CanStart = function (thisConvo, queue) -- BOOLEAN
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if (ai_living_count (AI.sq_miners_upper) >= 1 ) then
			thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return sloan_pa_playing == false and volume_test_players(VOLUMES.nar_outpost_volume) and objects_distance_to_object(players_human(),ai_get_object(AI.sq_miners_upper.spawnpoint09)) < 4;
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
		print("nar_bridge_access narrative");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
		[1] = {
					character = AI.sq_miners_upper.spawnpoint09,
		text = "We're surrounded!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale05_00900.sound'),
			
		},

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud(); -- VOID
		AIDialogManager.EnableAIDialog();
	
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};
global nar_random_miner_03 = {
	name = "nar_random_miner_03",

CanStart = function (thisConvo, queue) -- BOOLEAN
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if (ai_living_count (AI.sq_outpost_left_sniper) >= 1 ) then
			thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return sloan_pa_playing == false and volume_test_players(VOLUMES.nar_outpost_volume) and (objects_distance_to_object(players_human(),ai_get_object(AI.sq_outpost_left_sniper.spawnpoint09)) < 5 or objects_distance_to_object(players_human(),ai_get_object(AI.sq_outpost_left_sniper.spawnpoint17)) < 5);
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,

	sleepBefore = function(thisConvo, queue) return random_range(1,3) end,

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_bridge_access narrative");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return b_outpost_combat_complete == false; -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,
		
				
			character = AI.sq_outpost_left_sniper.spawnpoint17,
			text = "I didn't survive Alluvian just to die here!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale03_00500.sound'),
						AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return b_outpost_combat_complete == false; -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,
		
				
			character = AI.sq_outpost_left_sniper.spawnpoint09,
			text = "I didn't survive Alluvian just to die here!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale03_00500.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud(); -- VOID
		AIDialogManager.EnableAIDialog();
	
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};

global nar_random_miner_04 = {
	name = "nar_random_miner_04",

CanStart = function (thisConvo, queue) -- BOOLEAN
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if (ai_living_count (AI.sq_miners_topright_top) >= 1 ) then
			thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return sloan_pa_playing == false and volume_test_players(VOLUMES.nar_outpost_volume) and objects_distance_to_object(players_human(),ai_get_object(AI.sq_miners_topright_top.spawnpoint04)) < 4;
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
		print("nar_bridge_access narrative");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return b_outpost_combat_complete == false; -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,
		
				
	
			character = AI.sq_miners_topright_top.spawnpoint04, -- GAMMA_CHARACTER: MiNERMALE02
			text = "I'm running out of ammo!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale02_00600.sound'),


		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud(); -- VOID
		AIDialogManager.EnableAIDialog();

	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};

global nar_random_miner_05 = {
	name = "nar_random_miner_05",

CanStart = function (thisConvo, queue) -- BOOLEAN
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if (ai_living_count (AI.sq_miners_frontyard_left) >= 1 ) then
			thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return sloan_pa_playing == false and volume_test_players(VOLUMES.nar_outpost_volume) and objects_distance_to_object(players_human(),ai_get_object(AI.sq_miners_frontyard_left.spawnpoint96)) < 4;

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

	sleepBefore = 2, 

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_bridge_access narrative");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
	
	
			[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return b_outpost_combat_complete == false; -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,
		
			character = AI.sq_miners_frontyard_left.spawnpoint96, -- GAMMA_CHARACTER: MiNERFEMALE01
			text = "Watch out! They're coming from everywhere!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minerfemale01_01700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud(); -- VOID
		AIDialogManager.EnableAIDialog();
	
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};


global W1HubMeridian_turret_callout = {
	name = "W1HubMeridian_turret_callout",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.w1_meridian_1_turret_hint) and b_sniped_the_generator == false and b_outpost_combat_complete == false; -- GAMMA_CONDITION
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
				return volume_test_object(VOLUMES.w1_meridian_1_turret_hint, SPARTANS.tanaka) and b_turrets_online == false and b_sniped_the_generator == false; -- GAMMA_TRANSITION: IF PLAYER LOOKS AT GATEWAY
				
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Turret controls oughta be around here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_04100.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},

		[2] = {
		
			character = AI.sq_miners_topright_top.spawnpoint03, -- GAMMA_CHARACTER: Minermale05
			text = "Turret controls are in there, but the door's jammed!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale05_00100.sound'),
		},


	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		NarrativeQueue.QueueConversation(nar_random_miner_04);
	end,

	localVariables = {},
};

function nar_ass_turret_listener()
	
       SleepUntil([| object_valid( "dc_gun_button" ) ], 60);
	   PrintNarrative("LISTENER - dc_gun_button THREADED");
       SleepUntil([| device_get_power( OBJECTS.dc_gun_button) == 1 ], 60);
	   
       PrintNarrative("LISTENER - dc_gun_button");

       CreateThread(RegisterInteractEvent, nar_ass_turret_launcher, OBJECTS.dc_gun_button);


end

function nar_ass_turret_launcher(trigger:object, activator:object)

       PrintNarrative("LAUNCHER - assault_data_control_launcher");

       print(activator, " is the activator of ", trigger);

       CreateThread(UnregisterInteractEvent, nar_ass_turret_listener, OBJECTS.dc_gun_button);

       CreateThread(W1HubMeridian_turret_used, activator)
end


function W1HubMeridian_turret_used(activator:object)
		b_turrets_online = true;
		sleep_s(2.5);
		if b_outpost_combat_complete == false and b_sniped_the_generator == false then
			if activator == SPARTANS.tanaka then
				NarrativeQueue.QueueConversation(W1HubMeridian_turret_used_tanaka);
			elseif activator == SPARTANS.buck then
				NarrativeQueue.QueueConversation(W1HubMeridian_turret_used_buck);
			elseif activator == SPARTANS.locke then
				NarrativeQueue.QueueConversation(W1HubMeridian_turret_used_locke);
			elseif activator == SPARTANS.vale then
				NarrativeQueue.QueueConversation(W1HubMeridian_turret_used_vale);
			end
		end
end

global W1HubMeridian_turret_used_tanaka = {
	name = "W1HubMeridian_turret_used_tanaka",


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
			text = "Turrets are online.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_00700.sound'),

		},
				[2] = {
		
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			sleepBefore = 2,
			
			text = "Who-- Spartans? You activated the turrets?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_01800.sound'),

		
		},
		[3] = {
	
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "We're here to help, Governor.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_04616.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[4] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			
			text = "[dismissive grunt] ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_01900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};

global W1HubMeridian_turret_used_locke = {
	name = "W1HubMeridian_turret_used_locke",


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
			text = "Turrets are online.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_00700.sound'),
		},
				[2] = {
		
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
		sleepBefore = 2,
			
			text = "Who-- Spartans? You activated the turrets?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_01800.sound'),

		
		},
		[3] = {

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "We're here to help, Governor.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_04616.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[4] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			
			text = "[dismissive grunt] ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_01900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};

global W1HubMeridian_turret_used_vale = {
	name = "W1HubMeridian_turret_used_vale",


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
			text = "Turrets are online.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_00500.sound'),

	
		},
		[2] = {
		
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
		sleepBefore = 2,
			
			text = "Who-- Spartans? You activated the turrets?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_01800.sound'),

		
		},
		[3] = {

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "We're here to help, Governor.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_04616.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[4] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			
			text = "[dismissive grunt] ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_01900.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};

global W1HubMeridian_turret_used_buck = {
	name = "W1HubMeridian_turret_used_buck",


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
			text = "Turrets are online.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_00500.sound'),

	
		},
				[2] = {
		
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
		sleepBefore = 2,
			
			text = "Who-- Spartans? You activated the turrets?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_01800.sound'),

		
		},
		[3] = {

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "We're here to help, Governor.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_04616.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[4] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			
			text = "[dismissive grunt] ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_01900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};

global W1HubMeridian_SPACE_ELEVATOR_EXTERIOR__BANDWAGON_ARRIVES = {
	name = "W1HubMeridian_SPACE_ELEVATOR_EXTERIOR__BANDWAGON_ARRIVES",

CanStart = function (thisConvo, queue) -- BOOLEAN
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if (ai_living_count (AI.sq_outpost_knight) >= 1 ) then
			thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_can_see_object( SPARTANS.vale, ai_get_object(AI.sq_outpost_knight.knight_comm), 15 ) or objects_can_see_object( SPARTANS.tanaka, ai_get_object(AI.sq_outpost_knight.knight_comm), 15 ) or objects_can_see_object( SPARTANS.locke, ai_get_object(AI.sq_outpost_knight.knight_comm), 15 ) or objects_can_see_object( SPARTANS.buck, ai_get_object(AI.sq_outpost_knight.knight_comm), 15 );
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
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
				return objects_can_see_object( SPARTANS.vale, ai_get_object(AI.sq_outpost_knight.knight_comm), 15 ) ; -- GAMMA_TRANSITION: If buck WITNESSES
			end,
			

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Knight commander just showed up with reinforcements!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_01700.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return objects_can_see_object( SPARTANS.buck, ai_get_object(AI.sq_outpost_knight.knight_comm), 15 ) ; -- GAMMA_TRANSITION: If buck WITNESSES
			end,


					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Knight commander just showed up with a fresh pack of Prometheans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_01900.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return objects_can_see_object( SPARTANS.locke, ai_get_object(AI.sq_outpost_knight.knight_comm), 15 ); -- GAMMA_TRANSITION: IF LOCKE WITNESSES
			end,

	
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Knight commander just showed up with reinforcements!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_02700.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return objects_can_see_object( SPARTANS.tanaka, ai_get_object(AI.sq_outpost_knight.knight_comm), 15 ); -- GAMMA_TRANSITION: If tanaka WITNESSES
			end,


					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Knight commander just showed up with a fresh pack of Prometheans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_02200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--           After:
	},
	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		CreateThread(nar_knight_commander_nudge_controller);
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};


function nar_knight_commander_nudge_controller()
	sleep_s(45);
	if ai_living_count (AI.sq_outpost_knight) >= 1 then
SleepUntil( [| b_collectible_used == false ], 1);
		NarrativeQueue.QueueConversation(W1HubMeridian_knight_commander_nudge);
	end

end

global W1HubMeridian_knight_commander_nudge= {
	name = "W1HubMeridian_knight_commander_nudge",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_outpost_volume, SPARTANS.buck) and b_collectible_used == false; -- GAMMA_TRANSITION: If vale
			end,
		

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Remember, they're weak on those glowing orbs at the sides! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_03800.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
	
	If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_outpost_volume, SPARTANS.tanaka) and b_collectible_used == false; -- GAMMA_TRANSITION: If vale
			end,
		

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Remember, they're weak on those glowing orbs at the sides! \r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_04400.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
		If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_outpost_volume, SPARTANS.vale) and b_collectible_used == false; -- GAMMA_TRANSITION: If vale
			end,
		
			

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Remember, they're weak on those glowing orbs at the sides! \r\n\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_03400.sound'),

		
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {
		checkConditionsPassed = 0,
	},
};


global W1HubMeridian_space_elevator_exterioR__SNIPER_TOWER = {
	name = "W1HubMeridian_space_elevator_exterioR__SNIPER_TOWER",

	CanStart = function (thisConvo, queue)
		return b_outpost_combat_complete == false and volume_test_players(VOLUMES.w1_meridian_1_sniper_nest) and volume_test_players_lookat(VOLUMES.w1_meridian_1_generator, 100, 20); -- GAMMA_CONDITION
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
				return volume_test_object(VOLUMES.w1_meridian_1_sniper_nest, SPARTANS.vale); -- GAMMA_TRANSITION: If vale DISCOVERS
			end,

			

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "There's a clear shot to a generator from up here.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_VO_SCR_W1HubMeridian_UN_VALE_05000.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.w1_meridian_1_sniper_nest, SPARTANS.tanaka); -- GAMMA_TRANSITION: If tanaka DISCOVERS
			end,

	
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "There's a clear shot to a generator from up here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_01900.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
			b_tanaka_sniper = true;
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.w1_meridian_1_sniper_nest, SPARTANS.buck); -- GAMMA_TRANSITION: If buck discovers
			end,


					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "There's a clear shot to a generator up here. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_01700.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.w1_meridian_1_sniper_nest, SPARTANS.locke); -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,


					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "There's a clear shot to a generator from up here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_02400.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--		[5] = {
--					If = function (thisLine, thisConvo, queue, lineNumber)
--				return b_two_gate_buttons_used == false; -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
--			end,
--				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
--				hud_show_radio_transmission_hud("buck_transmission_name");
--end,
----	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
--			text = "Reckon that generator powers the gate? ",
--			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_06500.sound'),

		
--		},
		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return b_tanaka_sniper == false and b_two_gate_buttons_used == false; -- GAMMA_TRANSITION: If buck discovers
			end,


					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Take the shot. It'll drop power to the gate.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_02000.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 6;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		
		[6] = {
								If = function (thisLine, thisConvo, queue, lineNumber)
				return b_two_gate_buttons_used == false; -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,

				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Take the shot. It'll drop power to the gate.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_02500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		NarrativeQueue.QueueConversation(nar_random_miner_03);
		
	end,

	localVariables = {},
};

function nar_generator_hit_cutoff()
	SleepUntil([|object_get_health(OBJECTS.cr_outpost_generator) <= 0], 1);
	
	--NarrativeQueue.InterruptConversation(W1HubMeridian_Space_elevator_exterior__Generator_HIT);
end

global W1HubMeridian_Space_elevator_exterior__Generator_HIT = {
	name = "W1HubMeridian_Space_elevator_exterior__Generator_HIT",

	CanStart = function (thisConvo, queue)
		return object_get_health(OBJECTS.cr_outpost_generator) < 0.75; -- GAMMA_CONDITION
	end,

	sleepBefore = 1,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
		If = function (thisLine, thisConvo, queue, lineNumber)
				return unit_has_weapon_readied(SPARTANS.buck, TAG('objects\weapons\rifle\sniper_rifle\sniper_rifle.weapon' )); -- GAMMA_TRANSITION: If buck
			end,

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Did some damage to that generator. Going to take a few more shots to drop it, though.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_07500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return unit_has_weapon_readied(SPARTANS.locke, TAG('objects\weapons\rifle\sniper_rifle\sniper_rifle.weapon' )); -- GAMMA_TRANSITION: If buck
			end,

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Did some damage to that generator. Going to take a few more shots to drop it, though.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_04628.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return unit_has_weapon_readied(SPARTANS.vale, TAG('objects\weapons\rifle\sniper_rifle\sniper_rifle.weapon' )); -- GAMMA_TRANSITION: If buck
			end,
	
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Did some damage to that generator. Going to take a few more shots to drop it, though.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_06200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return unit_has_weapon_readied(SPARTANS.tanaka, TAG('objects\weapons\rifle\sniper_rifle\sniper_rifle.weapon' )); -- GAMMA_TRANSITION: If buck
			end,


					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Did some damage to that generator. Going to take a few more shots to drop it, though.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_07700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
					hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


	


function w1_meridian_1_generator_destroyed()
	SleepUntil([|b_any_gen_off == true and b_outpost_combat_complete == false], 1);
	print("w1_meridian_1_generator_destroyed");
		sleep_s(2);
	b_sniped_the_generator = true;
	if b_outpost_combat_complete == false and b_pa_line_playing == false then 
	b_pa_line_playing = true;
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_VO_SCR_W1HubMeridian_UN_ELEVATORPA_00700.sound'), OBJECTS.exterior_pa);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_VO_SCR_W1HubMeridian_UN_ELEVATORPA_00700b.sound'), OBJECTS.exterior_pa_2);
		sleep_s(7);
		b_pa_line_playing = false;
	end
end


function nar_outpost_nudge_controller()
	sleep_s(300);
	if b_outpost_combat_complete == false and b_two_gate_buttons_used == false and b_sniped_the_generator == false then
	SleepUntil( [| b_collectible_used == false ], 1);
			--story_blurb_add("other", "NUDGE FORWARD");
		NarrativeQueue.QueueConversation(nar_outpost_nudge1);
	end
end

global nar_outpost_nudge1 = {
	name = "nar_outpost_nudge1",

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_outpost_nudge narrative");
		AIDialogManager.DisableAIDialog();
		--story_blurb_add("other", "PLAYING VO");
	end,

	lines = {
		[1] = {
		If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_outpost_volume, SPARTANS.buck) and unit_get_health( SPARTANS.buck) > 0; -- GAMMA_TRANSITION: If vale
			end,
		

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "We gotta get that gate open. Either eliminate all the Prometheans or bust it open by force.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_04000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
		If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_outpost_volume, SPARTANS.vale) and unit_get_health( SPARTANS.vale) > 0; -- GAMMA_TRANSITION: If vale
			end,
		

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "The only way we'll get that gate open is eliminating all Prometheans or breaking it down.\r\n\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_03600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
		If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_outpost_volume, SPARTANS.tanaka) and unit_get_health( SPARTANS.tanaka) > 0; -- GAMMA_TRANSITION: If vale
			end,
		

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Gate won't open until there's no threat or it's broken down.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_04600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud(); -- VOID
		AIDialogManager.EnableAIDialog();
	end,
};

function nar_kill_outpost_chatter()

	SleepUntil( [| volume_test_players(VOLUMES.nar_kill_outpost_chatter) ],1);
CreateThread(meridian_idle_chatter_off);
end


function nar_leave_outpost_nudge_controller()
	CreateThread(advanced_to_bridge);
	CreateThread(nar_kill_outpost_chatter);
	if b_left_outpost == false then
		--story_blurb_add("other", "OUTPOST CHATTER");
		CreateThread(meridian_idle_chatter_start);

	end
	sleep_s(75);
	if b_left_outpost == false then
	SleepUntil( [| b_collectible_used == false ], 1);
		--story_blurb_add("other", "NUDGE TO LEAVE");
		NarrativeQueue.QueueConversation(nar_leave_outpost_nudge2);
	end
	sleep_s(31);
	if b_left_outpost == false then
		--story_blurb_add("other", "OUTPOST CHATTER");
		CreateThread(meridian_idle_chatter_start);

	end
	

end


function advanced_to_bridge()
SleepUntil([| volume_test_players(VOLUMES.b_advanced_to_gate) ], 1);
	
	
	b_advanced_to_gate = true;
end
global nar_leave_outpost_chatter3 = {
	name = "nar_leave_outpost_chatter3",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return volume_test_players(VOLUMES.nar_outpost_volume) and (b_left_outpost == false);
	end,

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_outpost_nudge narrative");
		
		AIDialogManager.DisableAIDialog();
	end,
	
	
	lines = {
			[1] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "The Covenant glassed this planet in '48. It was a UNSC colony then, but we never came back.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_04200.sound'),
		},
		[2] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Run by a private corp now, like most of the frontier worlds. Chipping away the glass, making her livable. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_00300.sound'),
		},
		[3] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Dirty work. But noble.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_00200.sound'),
		},
	
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud(); -- VOID
		AIDialogManager.EnableAIDialog();
	end,
};





global nar_leave_outpost_nudge2 = {
	name = "nar_leave_outpost_nudge2",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return volume_test_players(VOLUMES.nar_outpost_volume) and (b_left_outpost == false);
	end,

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	sleepBefore = 1,


	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_outpost_nudge narrative");
		
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
			character = CHARACTER_SPARTANS.buck,
			text = "Buck : Meridian Station's a bit down the road. We should grab a warthog and get driving.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_04400.sound'),
			sleepAfter = 0,

		},
	
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud(); -- VOID
		AIDialogManager.EnableAIDialog();
	end,
};



function dormant.w1_turret_turned_back_on()
	print("deprecated");
end	


global W1HubMeridian_space_elevator_exterioR__POWER_WEAPONS = {
	name = "W1HubMeridian_space_elevator_exterioR__POWER_WEAPONS",

	CanStart = function (thisConvo, queue)
		return b_outpost_combat_complete == false and volume_test_players(VOLUMES.w1_meridian_weapon); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 1.5,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, "W1HubMeridian_space_elevator_exterioR__POWER_WEAPONS narrative");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.w1_meridian_weapon, SPARTANS.buck); -- GAMMA_TRANSITION: If buck discovers
			end,


					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Found a heavy weapons cache. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_00700.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.w1_meridian_weapon, SPARTANS.locke); -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Found a heavy weapons cache.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_00900.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.w1_meridian_weapon, SPARTANS.vale); -- GAMMA_TRANSITION: If vale DISCOVERS
			end,

			

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Found a heavy weapons cache.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_00700.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.w1_meridian_weapon, SPARTANS.tanaka); -- GAMMA_TRANSITION: If tanaka DISCOVERS
			end,


					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Found a heavy weapons cache.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_00900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
			[5] = {
			

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
sleepBefore = 1,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Why do civilians have heavy weapons?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_05300.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[6] = {

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Save the discussion of frontier politics until after the fight.\r\n\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_06400.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


global W1HubMeridian_space_elevator_exterioR__POST_GATE_OPENING = {
	name = "W1HubMeridian_space_elevator_exterioR__POST_GATE_OPENING",

	sleepBefore = 1.5,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_player_lookat(VOLUMES.meridian_gate_lookat, SPARTANS.vale, 50, 50); -- GAMMA_TRANSITION: If vale WITNESSES
			end,

			

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Gates are open!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_01600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_player_lookat(VOLUMES.meridian_gate_lookat, SPARTANS.buck, 50, 50); -- GAMMA_TRANSITION: When gate opens
				-- If buck WITNESSES
			end,


					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Gates are open!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_01800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
			[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_player_lookat(VOLUMES.meridian_gate_lookat, SPARTANS.tanaka, 50, 50); -- GAMMA_TRANSITION: If tanaka WITNESSES
			end,


					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Gates are open!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_02100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_player_lookat(VOLUMES.meridian_gate_lookat, SPARTANS.locke, 50, 50); -- GAMMA_TRANSITION: IF LOCKE WITNESSES
			end,


					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Gates are open!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_02600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
				[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return b_sniped_the_generator == true; -- GAMMA_TRANSITION: AFTER ALL:
			end,


	
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
		sleepBefore = 1,
			
			text = "What in the hell are you doing?!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_02000.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[6] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return b_sniped_the_generator == true; -- GAMMA_TRANSITION: AFTER ALL:
			end,

	
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 1,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "We're headed for Meridian Station. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_04617.sound'),
		},
		[7] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return b_sniped_the_generator == true; -- GAMMA_TRANSITION: AFTER ALL:
			end,

		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
		sleepBefore = 1,
			
			text = "So you bust up the place on your way out?! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_02100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
			
			
	end,

	localVariables = {},
};

function w1_meridian_1_gates_open()
		SleepUntil([|	volume_test_players_lookat(VOLUMES.meridian_gate_lookat,50, 50) == true], 5);
		b_outpost_combat_complete = true;
		
		NarrativeQueue.QueueConversation(W1HubMeridian_space_elevator_exterioR__POST_GATE_OPENING);
	

end
				
		
function w1_meridian_1_all_enemies_dead(player_object:object):void
	SleepUntil([|ai_living_count(AI.sg_fore_op_knights) >= 1], 1);
	print ("Knight is alive. Now we wait until he dies.");
	SleepUntil([|ai_living_count(AI.sg_fore_outpost_all) <= 0 ], 1);
	
	--SleepUntil([| volume_test_players(VOLUMES.nar_outpost_volume) ], 1);
	
			b_outpost_combat_complete = true;
			sleep_s(3);
			
			SleepUntil([| b_pa_line_playing == false ], 1);
			b_pa_line_playing = true;
			PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_VO_SCR_W1HubMeridian_UN_ElevatorPA_00600.sound'), OBJECTS.exterior_pa);
			PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_VO_SCR_W1HubMeridian_UN_ElevatorPA_00600b.sound'), OBJECTS.exterior_pa_2);
			sleep_s(4);
			NarrativeQueue.QueueConversation(W1HubMeridian_space_elevator_exterioR__KILL_EVERYTHING);
			b_pa_line_playing = false;
			
			
	
end			
			
	global W1HubMeridian_space_elevator_exterioR__KILL_EVERYTHING = {
	name = "W1HubMeridian_space_elevator_exterioR__KILL_EVERYTHING",



	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_outpost_volume, SPARTANS.buck) and unit_get_health( SPARTANS.buck) > 0; -- GAMMA_TRANSITION: If vale
			end,
		

				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Looks like we're all clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_00600.sound'),
				AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},

		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_outpost_volume, SPARTANS.tanaka) and unit_get_health( SPARTANS.tanaka) > 0; -- GAMMA_TRANSITION: If vale
			end,
		
				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Looks like we're all clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_02400.sound'),
		AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_outpost_volume, SPARTANS.vale) and unit_get_health( SPARTANS.vale) > 0; -- GAMMA_TRANSITION: If vale
			end,
		
				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Looks like we're all clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_02000.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_outpost_volume, SPARTANS.locke) and unit_get_health( SPARTANS.locke) > 0; -- GAMMA_TRANSITION: If vale
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Looks like we're all clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_04602.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
			[5] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			sleepBefore = 1,
			
			text = "Spartans? Was that your doing?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_01600.sound'),
		},
		[6] = {
				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "We just helped, Governor. Your people did a lot.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_04615.sound'),
		},
	},
	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
			b_outpost_combat_complete2 = true;
		CreateThread(nar_leave_outpost_nudge_controller);
	end,

	localVariables = {},
};		
	
-- =================================================================================================
--
--					WARTHOG RIDE THROUGH BRIDGE
--
-- Covers content in the warthog ride through the bridge
--
-- =================================================================================================

function dormant.w1_warthog_scripts()
	
	
	CreateThread(w1_meridian_1_pelican_down);

	
end

-- =================================================================================================
		
				

function w1_meridian_1_fore_alive()
SleepUntil([| volume_test_players(VOLUMES.gate_exit) and b_outpost_combat_complete == true], 1);
		if (b_all_outpost_enemies_dead == false) then 
		NarrativeQueue.QueueConversation(W1HubMeridian_WARTHOG_DRIVE__LEAVE_WITHOUT_KILLING_ALL);
		sleep_s(1);
		
		CreateThread(w1_meridian_1_warthog_ride_1);
		
		else
			CreateThread(w1_meridian_1_warthog_ride_1);
		end
end		

global W1HubMeridian_WARTHOG_DRIVE__LEAVE_WITHOUT_KILLING_ALL = {
	name = "W1HubMeridian_WARTHOG_DRIVE__LEAVE_WITHOUT_KILLING_ALL",

		canStartOnce = true,
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
			text = "There are still Prometheans back there.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_03500.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
	
		},
		[2] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "You heard the man. People in town aren't well armed. They need us more.\r\n\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_04500.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};				

function w1_meridian_1_warthog_ride_1()
	b_left_outpost = true;
	NarrativeQueue.QueueConversation(W1HubMeridian_WARTHOG_DRIVE__START_);
	CreateThread(meridian_idle_chatter_off);
end			
global W1HubMeridian_WARTHOG_DRIVE__START_ = {
	name = "W1HubMeridian_WARTHOG_DRIVE__START_",

		CanStart = function (thisConvo, queue)
		return unit_get_health( SPARTANS.tanaka) > 0 and b_pelican_down == false and b_outpost_combat_complete2 == true; -- GAMMA_CONDITION
	end,


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
		sleepBefore = 2.5,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "This road'll lead straight to Meridian Station.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_06500.sound'),
		},
	
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};



function w1_meridian_1_pelican_down()
	SleepUntil([| volume_test_players(VOLUMES.tv_bridge_crash_vign) ], 1);
	
	sleep_s(1.5);
	b_pelican_down = true;
	NarrativeQueue.EndConversationEarly(W1HubMeridian_WARTHOG_DRIVE__LEAVE_WITHOUT_KILLING_ALL);
	NarrativeQueue.InterruptConversation(W1HubMeridian_WARTHOG_DRIVE__START_);	
				hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("minerfemale04_transmission_name");
				hud_set_radio_transmission_portrait_index(15);		
	sleep_s(0.5);
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minerfemale04_00200.sound'), nil);
	sleep_s(4);
		hud_hide_radio_transmission_hud();
	b_pelican_down = false;
	
end	

global W1HubMeridian_DRIVE_VO__TEAM_SECONDARY_VO_1 = {
	name = "W1HubMeridian_DRIVE_VO__TEAM_SECONDARY_VO_1",

		CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.b_advanced_to_gate); -- GAMMA_CONDITION
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
								hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,		
			sleepBefore = 2,
			text = "McCord River, report in.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_02200.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				hud_hide_radio_transmission_hud();
				return 2; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			sleepBefore = 1,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
								hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("minerfemale03_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,		
			text = "Governor Sloan! McCord River Bridge is sealed, but we're under heavy assault!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minerfemale03_00100.sound'),
		},
--                                                   VIGNETTE START
-- 
--           Its gates are currently shut as a group of miners fend off a
--           Promethean attack.

		[3] = {
										OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
								hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("minermale03_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,
			sleepBefore = 0.5,
			text = "What do we do?!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale03_00100.sound'),
		},
		[4] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
								hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,	
					sleepBefore = 1,
			
			text = "Make damn sure they don't get through to town!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_02300.sound'),
		},
		[5] = {
				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 1,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Governor, if you open the bridge, Osiris can help Meridian Station.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_04700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[6] = {

				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Governor, if you open the bridge, we can help Meridian Station.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_04000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[7] = {

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Governor, if you open the bridge, we can help Meridian Station.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_04600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[8] = {
		
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Governor, if you open the bridge, we can help Meridian Station.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_03300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},

		[9] = {
	
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			sleepBefore = 1,
			text = "I let you through, those monster follow! No way!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_02400.sound'),
		},
--           **IF THE SPARTANS DESTROYED THE GENERATOR, PLAY THIS:

		[10] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return b_sniped_the_generator == true; -- GAMMA_TRANSITION: AFTER ALL:
			end,

		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			sleepBefore = 0.5,
			text = "After your wanton destruction at the space elevator, you're damn lucky I don't have my people shoot you too!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_02500.sound'),
		},
--           **IF WE PLAY THAT LINE OR NOT, PLAY THIS NEXT:

		[11] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			sleepBefore = 1,
			text = "If you want to help, then secure that bridge!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_02600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		NarrativeQueue.QueueConversation(nar_random_miner_bridge_01);
		NarrativeQueue.QueueConversation(nar_random_miner_bridge_03);
	end,

	localVariables = {},
};


	
-- =================================================================================================
--
--					BRIDGE
--
-- Covers bridge and bowl.
--
-- =================================================================================================

function dormant.w1_bridge_scripts()
	
	
		NarrativeQueue.QueueConversation(W1HubMeridian_Meridian_Station_BRIDGE_END);

	
	
	NarrativeQueue.QueueConversation(W1HubMeridian_DRIVE_VO__TEAM_SECONDARY_VO_1);
		
	--NarrativeQueue.QueueConversation(nar_gate_soldier_officer);

end

-- =================================================================================================
		
function nar_start_next_miner()

sleep_s(5);
NarrativeQueue.QueueConversation(nar_random_miner_bridge_02);

end		
	
global nar_random_miner_bridge_02 = {
	name = "nar_random_miner_bridge_02",

CanStart = function (thisConvo, queue) -- BOOLEAN
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if (ai_living_count (AI.sq_marines_bridge_entrance_01) >= 1 ) then
			thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.sq_marines_bridge_entrance_01.spawn_points_0)) < 4;
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
		print("nar_bridge_access narrative");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
		[1] = {
			character = AI.sq_marines_bridge_entrance_01.spawn_points_0, -- GAMMA_CHARACTER: MinerMALE06
			text = "Are those-- Spartans?!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale06_00900.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud(); -- VOID
		AIDialogManager.EnableAIDialog();
	
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};

	
global nar_random_miner_bridge_03 = {
	name = "nar_random_miner_bridge_03",

CanStart = function (thisConvo, queue) -- BOOLEAN
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if (ai_living_count (AI.sq_marines_bridge_entrance_05) >= 1 ) then
			thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.sq_marines_bridge_entrance_05.spawn_points_4)) < 4;
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
		print("nar_bridge_access narrative");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
		[1] = {
			character = AI.sq_marines_bridge_entrance_05.spawn_points_4, -- GAMMA_CHARACTER: MiNERMALE05
			text = "What are Spartans doing on Meridian?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale05_01000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud(); -- VOID
		AIDialogManager.EnableAIDialog();

	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};	

global nar_random_miner_bridge_01 = {
	name = "nar_random_miner_bridge_01",

CanStart = function (thisConvo, queue) -- BOOLEAN
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if (ai_living_count (AI.sq_marines_bridge_entrance_01) >= 1 ) then
			thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.sq_marines_bridge_entrance_01.spawn_points_0)) < 4;
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
		print("nar_bridge_access narrative");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
		[1] = {
			character = AI.sq_marines_bridge_entrance_01.spawn_points_0, -- GAMMA_CHARACTER: MinerMALE03
			text = "Do we shoot the aliens or the Spartans?!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale03_00700.sound'),
		},
		[2] = {
			character = AI.sq_marines_bridge_entrance_03.spawn_points_2, -- GAMMA_CHARACTER: MinERFEMALE06
			text = "The aliens, you idiot! The Spartans are helping!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale08_00100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud(); -- VOID
		AIDialogManager.EnableAIDialog();
		CreateThread(nar_start_next_miner);
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};



global nar_gate_soldier_officer = {
	name = "nar_gate_soldier_officer",

CanStart = function (thisConvo, queue) -- BOOLEAN
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if (ai_living_count (AI.sq_pro_drive) >= 1 ) then
			thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.sq_pro_drive.officer)) < 8;
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
		print("nar_gate_soldier_officer narrative");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object(SPARTANS.vale,ai_get_object(AI.sq_pro_drive.officer)) < 8 ;
			end,

				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "VALE: New kind of soldier here! Looks like he's leading the others!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_04300.sound'),
			sleepAfter = 0,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object(SPARTANS.buck,ai_get_object(AI.sq_pro_drive.officer)) < 8 ;
			end,

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Buck : New kind of soldier here! Looks like he's leading the others!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_VO_SCR_W1HubMeridian_UN_Buck_04900.sound'),
			sleepAfter = 0,
			
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[3] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object(SPARTANS.tanaka,ai_get_object(AI.sq_pro_drive.officer)) < 8 ;
			end,

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Tanaka : New kind of soldier here! Looks like he's leading the others!.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_05200.sound'),
			sleepAfter = 0,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[4] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object(SPARTANS.locke,ai_get_object(AI.sq_pro_drive.officer)) < 8 ;
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke,
			text = "Locke : New kind of soldier here! Looks like he's leading the others!",
			tag =  TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_03500.sound'),
			sleepAfter = 0,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
			[5] = {
			sleepBefore = 1,
			character = AI.sq_pro_drive.officer,
			text = "Soldier: The edict of Eternal Warden is clear. Humans must not penetrate the facility.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_fr_soldier01_00200.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[6] = {
		ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object(SPARTANS.buck,ai_get_object(AI.sq_pro_drive.officer)) < 8 ;
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Buck: What’s a Warden Eternal?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_VO_SCR_W1HubMeridian_UN_Buck_01300.sound'),
		},
		[7] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character =  CHARACTER_SPARTANS.vale,
			text = "Vale: New to me.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_VO_SCR_W1HubMeridian_UN_Vale_01100.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud(); -- VOID
		AIDialogManager.EnableAIDialog();
		
	end,
		localVariables = {
		checkConditionsPassed = 0,
	},
};

					




global W1HubMeridian_Meridian_Station_BRIDGE_END = {
	name = "W1HubMeridian_Meridian_Station_BRIDGE_END",
	CanStart = function (thisConvo, queue) -- BOOLEAN
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if ai_living_count (AI.sq_pro_drive) > 0 then
			thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return ai_living_count (AI.sq_pro_drive) == 0;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,
	sleepBefore = 3.5,
	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			text = "I'll be damned. The propaganda about Spartans does not lie. Listen. Across the bridge, closer to town, there's others that could use your help.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_02700.sound'),
			
		},
		[2] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 1,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "We can do that, sir.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_04618.sound'),
		},
		[3] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			sleepBefore = 0.5,
			text = "Alright. Opening up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_02800.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
	b_open_bridge = true;
		CreateThread(meridian_bridge_chatter_stop);
	CreateThread(meridian_idle_chatter_start);
	NarrativeQueue.QueueConversation(W1HubMeridian_Tanaka_Memory);
	end,
		localVariables = {
		checkConditionsPassed = 0,
	},
};			

function meridian_bridge_chatter_stop()
SleepUntil( [| volume_test_players(VOLUMES.meridian_bridge_chatter_stop) ],1);
CreateThread(meridian_idle_chatter_off);
end
					
-- =================================================================================================
--
--					BOWL 2
--
-- Covers bridge and bowl.
--
-- =================================================================================================

function dormant.w1_bowl2_scripts()
	
	
	
	CreateThread(nar_entered_scorpion_garage);
	CreateThread(w1_scorpion_area_enter);
--	CreateThread(w1_mer_unsc_black_market);

	NarrativeQueue.QueueConversation(W1HubMeridian_Meridian_Station_BRIDGE__SOLDIERS_TAKE_warthog);
	NarrativeQueue.QueueConversation(W1HubMeridian_SCORPION_GARAGE_BOWL__INSIDE);
	NarrativeQueue.QueueConversation(W1HubMeridian_SCORPION_GARAGE_BOWL__SLOAN_CONTACT);
	NarrativeQueue.QueueConversation(W1HubMeridian_BIG_BOWL__BATTLEWAGON_VO);
	NarrativeQueue.QueueConversation(nar_scorpion_area_enter1);
	
	NarrativeQueue.QueueConversation(W1HubMeridian_SCORPION_GARAGE_BOWL__COMBAT_END);
end

-- =================================================================================================
	
		
global W1HubMeridian_Meridian_Station_BRIDGE__SOLDIERS_TAKE_warthog = {
	name = "W1HubMeridian_Meridian_Station_BRIDGE__SOLDIERS_TAKE_warthog",
	CanStart = function (thisConvo, queue) -- BOOLEAN
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if (ai_living_count (AI.sq_bridge_soldiers) >= 1 ) then
			thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(), AI.sq_bridge_soldiers.gunner) < 6 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
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
				return objects_distance_to_object( SPARTANS.buck, AI.sq_bridge_soldiers.gunner) < 6; -- GAMMA_TRANSITION: If buck is alive
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "The Soldiers can drive?!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_01200.sound'),


			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object( SPARTANS.tanaka, AI.sq_bridge_soldiers.gunner) < 6; -- GAMMA_TRANSITION: If tanaka is alive
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "The Soldiers can drive?!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_02600.sound'),


			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object( SPARTANS.vale, AI.sq_bridge_soldiers.gunner) < 6; -- GAMMA_TRANSITION: IF VALE IS ALIVE
			end,
				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "The Soldiers can drive?!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_02200.sound'),


			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object( SPARTANS.locke, AI.sq_bridge_soldiers.gunner) < 6; -- GAMMA_TRANSITION: IF LOCKE IS ALIVE
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "The Soldiers can drive?!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_04603.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {
		checkConditionsPassed = 0,
	},

};



-- =================================================================================================
--
--					WARTHOG RIDE GARAGE TO TOWN
--
-- Covers content in the warthog ride after the bridge
--
-- =================================================================================================

function dormant.w1_garage_scripts()
	
	
	NarrativeQueue.QueueConversation(W1HubMeridian_Combat_at_gate);
	
	
	
end

-- =================================================================================================

function w1_meridian_1_cov_ship_appear()
	print("Deprecated.");
end

function w1_meridian_1_ship_destroy()
	print("Deprecated.");
end


function w1_scorpion_area_enter()

	SleepUntil( [| volume_test_players(VOLUMES.nar_scorpion_area_enter) ],1);
CreateThread(meridian_idle_chatter_off);
end

global nar_scorpion_area_enter1 = {
	name = "nar_scorpion_area_enter1",
		canStartOnce = true,
	CanStart = function (thisConvo, queue) -- BOOLEAN
		return volume_test_players(VOLUMES.nar_scorpion_area_enter);
	end,
	Priority = function (self, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_scorpion_area_enter narrative");
		AIDialogManager.DisableAIDialog();
	end,
	
	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
								hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("minermale05_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
		 
			
			text = "Governor Sloan! This is Billy at the garage! We're pinned down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale05_00400.sound'),
		},
		[2] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			sleepBefore = 2,
			text = "Spartans, my people in the service garage could sure use your help. And, well, they might just have something you'd find useful.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_VO_SCR_W1HubMeridian_UN_SLOAN_04400.sound'),
		},
		[3] = {
				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "They have a tank? Why do they have a tank.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_VO_SCR_W1HubMeridian_UN_VALE_05500.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[4] = {
				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Gift horses, Vale. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_06700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud(); -- VOID
		AIDialogManager.EnableAIDialog();
	end,
};

global W1HubMeridian_BIG_BOWL__BATTLEWAGON_VO = {
	name = "W1HubMeridian_BIG_BOWL__BATTLEWAGON_VO",

CanStart = function (thisConvo, queue) -- BOOLEAN
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if (ai_living_count (AI.sq_prom_b2_c_02) >= 1 ) then
			thisConvo.localVariables.checkConditionsPassed = 1;
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return volume_test_players(VOLUMES.big_combat_area) and objects_can_see_object( players_human(), ai_get_object(AI.sq_prom_b2_c_02.knight_bat), 6 ) ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
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
				return objects_can_see_object( SPARTANS.buck, ai_get_object(AI.sq_prom_b2_c_02.knight_bat), 6 ); -- GAMMA_TRANSITION: IF LOCKE WITNESSES
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "That knight's got a scattershot! Watch the spread on that!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_02100.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,


			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return objects_can_see_object( SPARTANS.locke, ai_get_object(AI.sq_prom_b2_c_02.knight_bat), 6 ); -- GAMMA_TRANSITION: IF LOCKE WITNESSES
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "That knight's got a scattershot! Watch the spread on that!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_02800.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return objects_can_see_object( SPARTANS.vale, ai_get_object(AI.sq_prom_b2_c_02.knight_bat), 6 ); -- GAMMA_TRANSITION: IF LOCKE WITNESSES
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "That knight's got a scattershot! Watch the spread on that!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_01900.sound'),
				AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return objects_can_see_object( SPARTANS.tanaka, ai_get_object(AI.sq_prom_b2_c_02.knight_bat), 6 ); -- GAMMA_TRANSITION: IF LOCKE WITNESSES

			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "That knight's got a scattershot! Watch the spread on that!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_02300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {
		checkConditionsPassed = 0,
	},
};

function nar_entered_scorpion_garage()
SleepUntil([| volume_test_players(VOLUMES.w1_meridian_1_scorpion) ], 1);
	b_scorpion_discovered = true;
end


global W1HubMeridian_SCORPION_GARAGE_BOWL__INSIDE = {
	name = "W1HubMeridian_SCORPION_GARAGE_BOWL__INSIDE",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.w1_meridian_1_scorpion) and unit_get_health( SPARTANS.vale) > 0 and unit_get_health( SPARTANS.locke) > 0 ; -- GAMMA_CONDITION
	end,
	sleepBefore = 3,

			canStartOnce = true,
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
			text = "Why did they have a Scorpion? This is UNSC gear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_02900.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[2] = {
	OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		sleepBefore = 1,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LocKE
			text = "Corporate security. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_04633.sound'),
		},
		[3] = {
	OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke (ALT)
			text = "Private security for a frontier colony isn't unusual. Surprising to see something this heavy though.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_04634.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};


global W1HubMeridian_SCORPION_GARAGE_BOWL__COMBAT_END = {
	name = "W1HubMeridian_SCORPION_GARAGE_BOWL__COMBAT_END",

CanStart = function (thisConvo, queue) -- BOOLEAN
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if (ai_living_count(AI.sg_bowl_2_main_force) >= .25 ) then
			thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return ai_living_fraction(AI.sg_bowl_2_main_force) <= 0.25 and IsGoalActive(Meridian.goal_bowl_2_drive);
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,

				sleepBefore = 4,
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return b_robards_area_enter == false;
			end,
						If = function (thisLine, thisConvo, queue, lineNumber)
				return b_scorpion_discovered == false; -- GAMMA_TRANSITION: IF linda
			end,

		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			sleepBefore = 0.5,
			text = "Well done, Spartans. Head over to the garage, I'll have Billy open up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_03300.sound'),


		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return b_robards_area_enter == false and b_scorpion_discovered == false and b_garage_intro == false;
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
										hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("minermale04_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			sleepBefore = 0.5,
			text = "Spartans?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale04_00100.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return b_robards_area_enter == false and b_scorpion_discovered == false and b_garage_intro == false;
			end,

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
										hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("minermale05_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			sleepBefore = 0.5,
			text = "Ho-lee... ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale05_01100.sound'),
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return b_robards_area_enter == false and b_scorpion_discovered == false and b_garage_intro == false;
			end,

		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			sleepBefore = 0.5,
			text = "Billy, they're gonna need to borrow your toy.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_03000.sound'),
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return b_robards_area_enter == false and b_scorpion_discovered == false and b_garage_intro == false;
			end,

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
										hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("minermale05_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			sleepBefore = 0.5,
			text = "What?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale05_01200.sound'),
		},
		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return b_robards_area_enter == false and b_scorpion_discovered == false and b_garage_intro == false;
			end,
			sleepBefore = 0.5,
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			
			text = "They'll get more use out of it than you will.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_03100.sound'),
		},

	},
	
	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		
		CreateThread(nar_robards_area_enter);
		CreateThread(nar_stop_bowl_chatter);
		NarrativeQueue.QueueConversation(W1HubMeridian_Tanaka_Memory2);
		NarrativeQueue.QueueConversation(W1HubMeridian_SCORPION_GARAGE_BOWL__COMBAT_END2);
	end,

	localVariables = {
		checkConditionsPassed = 0,
	},
};

global W1HubMeridian_SCORPION_GARAGE_BOWL__COMBAT_END2 = {
	name = "W1HubMeridian_SCORPION_GARAGE_BOWL__COMBAT_END2",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return ai_living_count(AI.sg_bowl_2_main_force) < 1;

	end,
	sleepbefore = 6,
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return b_robards_area_enter == false and volume_test_object(VOLUMES.big_combat_area, SPARTANS.vale) and unit_get_health( SPARTANS.vale) > 0;
			end,
										OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Area's clear!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_01200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return b_robards_area_enter == false and volume_test_object(VOLUMES.big_combat_area, SPARTANS.tanaka) and unit_get_health( SPARTANS.tanaka) > 0;
			end,
										OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Area's clear!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_02700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return b_robards_area_enter == false and volume_test_object(VOLUMES.big_combat_area, SPARTANS.buck) and unit_get_health( SPARTANS.buck) > 0;
			end,
										OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Area's clear!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_02300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return b_robards_area_enter == false and volume_test_object(VOLUMES.big_combat_area, SPARTANS.locke) and unit_get_health( SPARTANS.locke) > 0;
			end,
										OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Area's clear!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_04604.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
						[5] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return b_robards_area_enter == false;
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepbefore = 3,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Meridian station's just up the hill.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_VO_SCR_W1HubMeridian_UN_TANAKA_06600.sound'),
	
		},
	},

	OnFinish = function (thisConvo, queue)
					hud_hide_radio_transmission_hud();
					CreateThread(meridian_idle_chatter_start);
	end,
	localVariables = {
		checkConditionsPassed = 0,
	},
};


global W1HubMeridian_SCORPION_GARAGE_BOWL_TANK = {
	name = "W1HubMeridian_SCORPION_GARAGE_BOWL_TANK",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.w1_meridian_1_scorpion); -- GAMMA_CONDITION
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
				return b_robards_area_enter == false and b_scorpion_discovered == false and b_garage_intro == false;
			end,

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");

				hud_show_radio_transmission_hud("minermale04_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			
			text = "Spartans?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale04_00100.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return b_robards_area_enter == false and b_scorpion_discovered == false and b_garage_intro == false;
			end,
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
		hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");

				hud_show_radio_transmission_hud("minermale05_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			
			text = "Ho-lee... ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale05_01100.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return b_robards_area_enter == false and b_scorpion_discovered == false and b_garage_intro == false;
			end,

		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			
			text = "Billy, they're gonna need to borrow your toy.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_03000.sound'),
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return b_robards_area_enter == false and b_scorpion_discovered == false and b_garage_intro == false;
			end,

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
										hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("minermale05_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			
			text = "What?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_minermale05_01200.sound'),
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return b_robards_area_enter == false and b_scorpion_discovered == false and b_garage_intro == false;
			end,

		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			
			text = "They'll get more use out of it than you will.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_03100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		b_garage_intro = true;
	end,

	localVariables = {},
};

function nar_stop_bowl_chatter()

	SleepUntil( [| volume_test_players(VOLUMES.nar_stop_bowl_chatter)],1);
CreateThread(meridian_idle_chatter_off);
end

function nar_robards_area_enter()

	SleepUntil( [| volume_test_players(VOLUMES.w1_meridian_1_robards2) ],1);
CreateThread(meridian_idle_chatter_off);
b_robards_area_enter = true;

end


global W1HubMeridian_SCORPION_GARAGE_BOWL__SLOAN_CONTACT = {
	name = "W1HubMeridian_SCORPION_GARAGE_BOWL__SLOAN_CONTACT",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.w1_meridian_1_robards2); -- GAMMA_CONDITION
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
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			
			text = "Spartans, you're close to Meridian Station now. If you could clear out the land between where you are and town...?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_03400.sound'),
		},

		[2] = {


							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Of course, Governor.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_04619.sound'),


		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return b_sniped_the_generator == true; -- GAMMA_TRANSITION: If players did not clear prometheans from the outpost
			end,
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
		sleepBefore = 0.5,
			
			text = "Least you could do after busting up my gate.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_03500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 4; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--           After the conditional VO, if everyone is alive:

		[4] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 1.5,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Wow. Pretty quick turnaround from 'get off my planet' to 'hey, can you help?'",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_06600.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[5] = {
			
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "At least he's talking to us. That's a start.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_05400.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};


global W1HubMeridian_MERIDIAN_STATION__VTOLS = {
	name = "W1HubMeridian_MERIDIAN_STATION__VTOLS_",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.w1_meridian_1_town_reveal); -- GAMMA_CONDITION
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
				return volume_test_object(VOLUMES.w1_meridian_1_town_reveal, SPARTANS.tanaka); -- GAMMA_TRANSITION: If tanaka WITNESSES
			end,

			sleepBefore = 2,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Forerunner Phaetons in the sky, hitting Meridian Station.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_05100.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.w1_meridian_1_town_reveal, SPARTANS.vale); -- GAMMA_TRANSITION: If vale
			end,
			sleepBefore = 2,
			
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Forerunner Phaetons in the sky, hitting Meridian Station.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_04200.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.w1_meridian_1_town_reveal, SPARTANS.buck); -- GAMMA_TRANSITION: IF BUCK
			end,
			sleepBefore = 2,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Forerunner Phaetons in the sky, hitting Meridian Station.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_04800.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.w1_meridian_1_town_reveal, SPARTANS.locke); -- GAMMA_TRANSITION: IF LOCKE
			end,
			sleepBefore = 2,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Forerunner Phaetons in the sky, hitting Meridian Station.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_03400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};


global W1HubMeridian_Combat_at_gate = {
	name = "W1HubMeridian_Meridian_Station__Combat_at_gate",


	CanStart = function (thisConvo, queue) -- BOOLEAN
		return volume_test_players(VOLUMES.w1_meridian_1_gate_combat);
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
		hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
				CreateThread(town_alarm_start);
		end,
			
			text = "They're right on our doorstep, Spartans. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_03600.sound'),
		},

		[2] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 1,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Osiris, clear the area so they can open the gates!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_01700.sound'),
		},
--           After the first wave of Prometheans is eliminated, the miners
--           prepare to open the gate...



	},
	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
			NarrativeQueue.QueueConversation(W1HubMeridian_MERIDIAN_STATION_wave1_done);
			
	end,
	localVariables = {
		checkConditionsPassed = 0,
	},

};

global W1HubMeridian_MERIDIAN_STATION__Phaetons_appear = {
	name = "W1HubMeridian_MERIDIAN_STATION__Phaetons_appear",

	
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
			[1] = {
						If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.final_combat_area, SPARTANS.tanaka); -- GAMMA_TRANSITION: IF LOCKE
			end,
			
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Phaetons taking shots at us!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_06800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
								If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.final_combat_area, SPARTANS.buck); -- GAMMA_TRANSITION: IF LOCKE
			end,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Phaetons taking shots at us!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_06700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
								If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.final_combat_area, SPARTANS.vale); -- GAMMA_TRANSITION: IF LOCKE
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Phaetons taking shots at us!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_05600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
								If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.final_combat_area, SPARTANS.locke); -- GAMMA_TRANSITION: IF LOCKE
			end,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Phaetons taking shots at us!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_04621.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};
global W1HubMeridian_MERIDIAN_STATION_wave1_done = {
	name = "W1HubMeridian_MERIDIAN_STATION_wave1_done",

	CanStart = function (thisConvo, queue) -- BOOLEAN
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if ai_living_count(AI.sg_end_gate_enemies) > 0 and ai_living_count(AI.sq_end_gate_officers) > 0 then
			thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return ai_living_count(AI.sg_end_gate_enemies) <= 0 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,

	sleepBefore = 2,

	
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
		sleepBefore = 2,
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
		hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			
			text = "Is that good? Are we all clear?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_03700.sound'),
		},
--           ...Just as a second wave attacks:

		[2] = {
		sleepBefore = 6,
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
		hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
				CreateThread(town_alarm_stop);
		end,
		
		
			text = "Aw, hell. Here they come!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_03800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
			CreateThread(f_drygrannis_arrival_complete);
						CreateThread(w1_meridian_1_gate_nudge);
	end,

	localVariables = {
		checkConditionsPassed = 0,
	},
};



								
global nar_gate_more_to_kill = {
	name = "nar_gate_more_to_kill",

	--CanStart = function (thisConvo, queue)
	--	return ai_living_count(AI.sg_pro_all) > 1; -- GAMMA_CONDITION
--	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_gate_more_to_kill narrative");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
			[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return sloan_cleared_line_played == false;
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
end,

			text = "Still a few of those things out there, Spartans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_04000.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				sloan_cleared_line_played = true;
				return 0;
			end,

		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.final_combat_area, SPARTANS.vale) and vale_cleared_line_played == false and unit_get_health( SPARTANS.vale) > 0; -- GAMMA_TRANSITION: IF LOCKE
			end,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "VALE: There’s a few more hostile targets left to clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_03100.sound'),
			sleepAfter = 0,
			
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				vale_cleared_line_played = true;
				return 0;
			end,
		},
		[3] = {
				If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.final_combat_area, SPARTANS.buck) and buck_cleared_line_played == false and unit_get_health( SPARTANS.buck) > 0;
			end,

										OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Buck : Got a few more prometheans to clear up here!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_03500.sound'),
			sleepAfter = 0,
			
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				buck_cleared_line_played = true;
				return 0;
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.final_combat_area, SPARTANS.tanaka) and tanaka_cleared_line_played == false and unit_get_health( SPARTANS.tanaka) > 0;
			end,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Tanaka : Got a few more hostiles to clean up here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_04300.sound'),
			sleepAfter = 0,
			
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 5;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				tanaka_cleared_line_played = true;
				return 0;
			end,
		},
		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.final_combat_area, SPARTANS.locke) and locke_cleared_line_played == false and unit_get_health( SPARTANS.locke) > 0;
			end,

									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke,
			text = "Locke : More hostiles on radar. We need to clean them up before we can move on.",
			tag =  TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_03600.sound'),
			sleepAfter = 0,
	
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				locke_cleared_line_played = true;
				return 0;
			end,
		},
		
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud(); -- VOID
		AIDialogManager.EnableAIDialog();
		CreateThread(w1_meridian_1_gate_nudge);
	end,
};

function w1_meridian_1_gate_nudge()
	
	sleep_s(120);
	
	if gate_all_clear == false then 	

		NarrativeQueue.QueueConversation(nar_gate_more_to_kill);
	end
	
end
		




global W1HubMeridian_Meridian_Station__Combat_COMPLETE = {
	name = "W1HubMeridian_Meridian_Station__Combat_COMPLETE",



	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
		hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			
			text = "Looks like you've done it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_04100.sound'),
		},
		[2] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
		hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			sleepBefore = 1,
			
			text = "Never thought I'd thank the UNSC for a damn thing, but I do thank you, Spartans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_04200.sound'),
		},
				[3] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
		hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
		sleepBefore = 1,
			
			text = "Come on inside.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_sloan_04300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		CreateThread(nar_chatter_controller);
	end,

	localVariables = {},
};
		
			
function dormant.w1_meridian_gate_complete() 
gate_all_clear = true;
	sleep_s(2);
	NarrativeQueue.QueueConversation(W1HubMeridian_Meridian_Station__Combat_COMPLETE);
	--sleep_s(1);
	--NarrativeQueue.QueueConversation(W1HubMeridian_Meridian_Station2);
end


function nar_chatter_controller()
	CreateThread(meridian_idle_chatter_start);
	sleep_s(45);
	CreateThread(meridian_idle_chatter_start);
	sleep_s(45);
	CreateThread(meridian_idle_chatter_start);
end
					
-- =================================================================================================
--
--					SECONDARY AUDIO LOGS
--
-- Audio Log Content	
--
-- =================================================================================================

function w1_mer_audio_log()
	
	
	
end

-- =================================================================================================

global W1HubMeridian_AUDIO_LOG__FIRST_OLD_MERIDIAN_RADIO = {
	name = "W1HubMeridian_AUDIO_LOG__FIRST_OLD_MERIDIAN_RADIO",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.glassed_radio_discovery); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		PROFILE.core.miner_radio_collection = true;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.glassed_radio_discovery, SPARTANS.locke); -- GAMMA_TRANSITION: If locke
			end,

										OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "What's this? Looks like it came out of the glass.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_locke_04606.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.glassed_radio_discovery, SPARTANS.vale); -- GAMMA_TRANSITION: If VALE
			end,

			
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "What's this? Looks like it came out of the glass.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_02800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.glassed_radio_discovery, SPARTANS.buck); -- GAMMA_TRANSITION: If BUCK
			end,

									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "What's this? Looks like it came out of the glass.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_03000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.glassed_radio_discovery, SPARTANS.tanaka); -- GAMMA_TRANSITION: If tanaka WITNESSES
			end,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Looks like the miners pulled this out of the glass.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_03800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--           AFTER:

		[5] = {
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Looks like a radio from before the glassing.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_03900.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};



global W1HubMeridian_Tanaka_Memory = {
	name = "W1HubMeridian_Tanaka_Memory",

CanStart = function (thisConvo, queue) -- BOOLEAN
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if ( ai_living_count(AI.sq_pro_drive) <= 0 ) then
			thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return volume_test_object(VOLUMES.w1_meridian_tanaka_memory_1, SPARTANS.tanaka) and b_collectible_used == false;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, "W1HubMeridian_Tanaka_Memory narrative");
			--story_blurb_add("domain", "TOAST: TANAKA MEMORY UNLOCKED IN SERVICE RECORD");
	end,

	lines = {
		[1] = {
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Seen others of course, but a glassed world really only looks like one thing to these eyes. Minab. Home.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_03600.sound'),
		},
		[2] = {
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Whole world got glassed. Some say it was lucky to survive... but those folk didn't scratch out a living as the sky turned black and the temperatures dropped. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_08100.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {
		checkConditionsPassed = 0,
	},
};


global W1HubMeridian_Tanaka_Memory2 = {
	name = "W1HubMeridian_Tanaka_Memory2",

		CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sg_bowl_2_all) <= .25 and volume_test_object(VOLUMES.w1_meridian_tanaka_memory_2, SPARTANS.tanaka) and b_collectible_used == false; -- GAMMA_CONDITION
	end,



	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, "W1HubMeridian_Tanaka_Memory2 narrative");
			--story_blurb_add("domain", "TOAST: TANAKA MEMORY UNLOCKED IN SERVICE RECORD");
	end,

	lines = {
		[1] = {
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Used to call these ships mules. Took one for a joy ride once. Came to an abrupt halt when skill was outstripped by desire for adventure. Threw the brake and prayed for the best. Worked out for all involved but the mule itself.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_06300.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {
		checkConditionsPassed = 0,
	},
};



-- =================================================================================================
--
--					CHATTER
--
-- Team secondary chatter.
--
-- =================================================================================================


-- =================================================================================================



global W1HubMeridian_Team_Chatter_01 = {
	name = "W1HubMeridian_Team_Chatter_01",

	CanStart = function (thisConvo, queue)
		return unit_get_health( SPARTANS.buck) > 0 and unit_get_health( SPARTANS.vale) > 0 and b_collectible_used ~= true; -- GAMMA_CONDITION
	end,

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue) -- VOID
		print("nar_outpost_nudge narrative");
		
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return b_meridian_idle_chatter_on == true;
			end,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Vale : We've seen Prometheans lots of places, but there's always been a Forerunner element.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_03700.sound'),
			sleepAfter = 0,
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
			
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return b_meridian_idle_chatter_on == true;
			end,
			sleepBefore = 0.5,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Buck : Yeah? So?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_04100.sound'),
			sleepAfter = 0,

			
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return b_meridian_idle_chatter_on == true;
			end,
			sleepBefore = 0.5,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale,
			text = "Vale : Meridian was a fully settled colony. No record of Forerunner discoveries here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_03800.sound'),
			sleepAfter = 0,

		
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return b_meridian_idle_chatter_on == true;
			end,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck,
			text = "Buck : So why are there Prometheans here now?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_04200.sound'),
			sleepAfter = 0,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
	[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return b_meridian_idle_chatter_on == true;
			end,
			sleepBefore = 0.5,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale,
			text = "Vale : That's what I'm asking. Haven't you been listening?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_03900.sound'),
			sleepAfter = 0,	
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},		
	[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return b_meridian_idle_chatter_on == true;
			end,
			sleepBefore = 0.5,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck,
			text = "Buck : Ya know, you'd get along with Veronica real nice, Vale.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_04300.sound'),
			sleepAfter = 0,

		
		},	
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud(); -- VOID
		AIDialogManager.EnableAIDialog();
	end,
};



global W1HubMeridian_Team_Chatter_02 = {
	name = "W1HubMeridian_Team_Chatter_02",

CanStart = function (thisConvo, queue)
		return unit_get_health( SPARTANS.vale) > 0 and unit_get_health( SPARTANS.tanaka) > 0 and unit_get_health( SPARTANS.buck) > 0 and b_collectible_used ~= true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return b_meridian_idle_chatter_on == true;
			end,
			
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "So, when this planet is 'chipped out of the glass', who has land rites? ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_04400.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[2] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return b_meridian_idle_chatter_on == true;
			end,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "No way to be sure of old property lines. Land'll be sold to cover the cost of the cleanup.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_05300.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[3] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return b_meridian_idle_chatter_on == true;
			end,
			
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Doesn't seem fair to the people who lost their homes.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_vale_04500.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[4] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return b_meridian_idle_chatter_on == true;
			end,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "You made it through boot camp and still use the word 'fair'?\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_05000.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};

global W1HubMeridian_Team_Chatter_03 = {
	name = "W1HubMeridian_Team_Chatter_03",
	
CanStart = function (thisConvo, queue)
		return unit_get_health( SPARTANS.tanaka) > 0 and unit_get_health( SPARTANS.buck) > 0 and b_collectible_used ~= true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
		If = function(thisLine, thisConvo, queue, lineNumber)
				return b_meridian_idle_chatter_on == true;
			end,
			
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Buck, heard you're in a relationship with someone else in the service.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_05400.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[2] = {
		If = function(thisLine, thisConvo, queue, lineNumber)
				return b_meridian_idle_chatter_on == true;
			end,
			sleepBefore = 0.5,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "That's true.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_05400.sound'),
		},
		[3] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return b_meridian_idle_chatter_on == true;
			end,
			sleepBefore = 0.5,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "How do you do it? Can't possibly see much of each other bein on mission all the time.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_05500.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[4] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return b_meridian_idle_chatter_on == true;
			end,
			sleepBefore = 0.5,
										OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "It's hard, but we make it work. Why do you ask, Tanaka? Got your eye on someone?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_buck_05500.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[5] = {
						If = function(thisLine, thisConvo, queue, lineNumber)
				return b_meridian_idle_chatter_on == true;
			end,
			sleepBefore = 0.5,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "No! Just was wonderin, that's all.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubmeridian\001_vo_scr_w1hubmeridian_un_tanaka_05600.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

function collectible_used_controller()
	SleepUntil([| device_get_position(OBJECTS.dc_mer_collect_01) == 1 or device_get_position(OBJECTS.dc_mer_collect_02) == 1 or device_get_position(OBJECTS.dc_mer_collect_03) == 1 or device_get_position(OBJECTS.dc_mer_collect_04) == 1 or device_get_position(OBJECTS.dc_mer_collect_05) == 1 or device_get_position(OBJECTS.dc_mer_collect_07) == 1], 1);
	--story_blurb_add("domain", "COLLCTIBLE USED");
	collectible_vo_on = true;
	sleep_s(30);
	collectible_vo_on = false;
	CreateThread(collectible_used_controller);
end

function w1_meridian_elevator_screen()
	SleepUntil([| device_get_position(OBJECTS.elevator_audio_log_control) == 1 ], 1);
	print("_______destroying control");
	Sleep(2);
	object_destroy(OBJECTS.elevator_audio_log_control);
	sleep_s(2);
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_collectibles\001_vo_scr_collectibles_un_minerfemale05_00100.sound'), OBJECTS.mer_log_speaker);
	--NarrativeQueue.QueueConversation(Collectibles_Evacuation_AUDIO_LOG__CONSOLE_distress_call);
end

function meridian_idle_chatter_start()
b_meridian_idle_chatter_on = true;
PrintNarrative("Enabled Idle Chatter");
	sleep_rand_s(45, 65);
	SleepUntil( [| b_collectible_used ~= true ], 1);

	--if b_meridian_idle_chatter_on and 
	--(
	--ai_combat_status(GetMusketeerSquad()) <= 2 and										--	SPARTANS ARE NOT IN COMBAT
	--(object_get_shield( SPARTANS.locke) == 1 and object_get_shield( SPARTANS.buck) == 1 and object_get_shield( SPARTANS.tanaka) == 1 and object_get_shield( SPARTANS.vale) == 1)
		--				) then 
	if b_meridian_idle_chatter_on == true then
		if b_meridian_chatter_2_played == true and b_meridian_chatter_3_played == false and b_meridian_idle_chatter_on == true then
			NarrativeQueue.QueueConversation(W1HubMeridian_Team_Chatter_03);
			b_meridian_chatter_3_played = true;
		elseif b_meridian_chatter_1_played == true and b_meridian_chatter_2_played == false and b_meridian_idle_chatter_on == true then
			NarrativeQueue.QueueConversation(W1HubMeridian_Team_Chatter_02);
			b_meridian_chatter_2_played = true;
		elseif b_meridian_chatter_1_played == false and b_meridian_idle_chatter_on == true then
			NarrativeQueue.QueueConversation(W1HubMeridian_Team_Chatter_01);
			b_meridian_chatter_1_played = true;
		end
	end
end


function meridian_idle_chatter_off()
	
	PrintNarrative("Killed Idle Chatter");
	NarrativeQueue.EndConversationEarly(W1HubMeridian_Team_Chatter_01);
	NarrativeQueue.EndConversationEarly(W1HubMeridian_Team_Chatter_02);
	NarrativeQueue.EndConversationEarly(W1HubMeridian_Team_Chatter_03);

	b_meridian_idle_chatter_on = false;			
	
end




--## CLIENT


function remoteClient.nar_test_bink()

	hud_play_pip_from_tag(TAG('bink\campaign\h5_pip_proxy_60.bink'));
end
