--## SERVER

-- =====================================================================================================================================
--   _____ ______ _   _ _______ _____ _   _ ______ _       _____     _   _          _____  _____         _______ _______      ________ 
--  / ____|  ____| \ | |__   __|_   _| \ | |  ____| |     / ____|   | \ | |   /\   |  __ \|  __ \     /\|__   __|_   _\ \    / /  ____|
-- | (___ | |__  |  \| |  | |    | | |  \| | |__  | |    | (___     |  \| |  /  \  | |__) | |__) |   /  \  | |    | |  \ \  / /| |__   
--  \___ \|  __| | . ` |  | |    | | | . ` |  __| | |     \___ \    | . ` | / /\ \ |  _  /|  _  /   / /\ \ | |    | |   \ \/ / |  __|  
--  ____) | |____| |\  |  | |   _| |_| |\  | |____| |____ ____) |   | |\  |/ ____ \| | \ \| | \ \  / ____ \| |   _| |_   \  /  | |____ 
-- |_____/|______|_| \_|  |_|  |_____|_| \_|______|______|_____/    |_| \_/_/    \_\_|  \_\_|  \_\/_/    \_\_|  |_____|   \/   |______|
--
-- =====================================================================================================================================                                                                                                                          
                                                                                                                          

-- =================================================================================================
-- *** GLOBALS ***
-- =================================================================================================



	global x_test:number=0;

	global b_critical_dialogue_on:boolean=false;

	global b_DownTime:boolean=true;

	global b_guardians:boolean=false;

	global b_end_gondola_start:boolean=false;
	global b_gondola_ride:boolean=false;

	global b_gondola_left_guardian_start_sequence:boolean=false;
	global b_gondola_left_guardian_slipspace:boolean=false;
	global b_gondola_left_guardian_slipspace_end:boolean=false;

	
	global b_guardian_gondola_left2:boolean=false;
	global b_guardian_gondola_left3:boolean=false;
	global b_guardian_gondola_left4:boolean=false;
	global b_guardian_bg_left:boolean=false;
	global b_guardian_gondola_right1:boolean=false;
	global b_guardian_gondola_right2:boolean=false;
	global b_guardian_gondola_right3:boolean=false;
	global b_guardian_gondola_right4:boolean=false;
	global b_guardian_bg_right:boolean=false;
		
	global b_grunt01_start:boolean=false;
	global b_grunt02_start:boolean=false;

	global b_more_guardian_are_leaving:boolean=false;

	global b_cores_have_been_pinged:boolean=false;

	global b_guardians_leaving_first_comment:boolean=false;

	global b_coliseum_cryptum_leaving:boolean=false;

	global b_coliseum_hostiles_incoming:boolean=false;

	global b_coliseum_wave_1_part_3:boolean=false;
	global b_coliseum_end_of_wave_1:boolean=false;
	global b_coliseum_end_of_wave_2:boolean=false;
	global b_coliseum_spawn:boolean=false;
	global b_coliseum_spawn_enemies_after_cortana:boolean=false;

	global b_coliseum_monitor_success:boolean=false;

	global b_coliseum_cortana_speech:boolean=false;

	global b_sentinels_end_pulse_shielded_01:boolean=false;
	global b_sentinels_end_pulse_shielded_02:boolean=false;
	global b_sentinels_end_pulse_shielded_03:boolean=false;

	global b_sentinels_end_pulse:boolean=false;
	
	global b_sentinels_end_remove_shield:boolean=false;

	
	
	global b_endgame_cortana_leave_john_alone:boolean=false;	
	global b_endgame_cortana_no:boolean=false;
	global b_endgame_cortana_gone:boolean=false;
	
	global b_players_saw_the_last_core:boolean=false;
	
	global b_cortana_private_speech:boolean=false;
	
	global b_grunt_01_a:boolean=false;
	global b_grunt_01_b:boolean=false;
	global b_grunt_01_c:boolean=false;

	global b_moderate_pain_emote_locke:boolean=false;
	global b_moderate_pain_emote_buck:boolean=false;
	global b_moderate_pain_emote_tanaka:boolean=false;
	global b_moderate_pain_emote_vale:boolean=false;
	global b_medium_pain_emote_locke:boolean=false;
	global b_medium_pain_emote_buck:boolean=false;
	global b_medium_pain_emote_tanaka:boolean=false;
	global b_medium_pain_emote_vale:boolean=false;
	global b_big_pain_emote_locke:boolean=false;
	global b_big_pain_emote_buck:boolean=false;
	global b_big_pain_emote_tanaka:boolean=false;
	global b_big_pain_emote_vale:boolean=false;
	global b_huge_pain_emote_locke:boolean=false;
	global b_huge_pain_emote_buck:boolean=false;
	global b_huge_pain_emote_tanaka:boolean=false;
	global b_huge_pain_emote_vale:boolean=false;
	

	global b_pulse_stage_01:boolean=false;
	global b_pulse_stage_02:boolean=false;
	global b_pulse_stage_03:boolean=false;
	global b_pulse_stage_04:boolean=false;
	
	global b_pulse_player_at_the_relay:boolean=false;
	global b_pulse_player_at_the_relay_2:boolean=false;
	global b_coliseum_last_guardian_slipspacing:boolean=false;

	global b_pulse_loud:boolean=false;
	
	global b_factory_goal:boolean=false;
	
	global b_player_reached_end_gondola:boolean=false;

	global b_core_prime_got_pinged:boolean=false;

	global b_ai_voices_are_playing:boolean=false;
	
	global sentinels_towers_point_1_nag_timer:number = 50;
	
	global b_soldier_start:boolean=false;

	global b_endgame_cortana_is_talking:boolean=false;
	
	global b_endgame_osiris_get_up:boolean=false;
	
	global b_endgame_magboots_are_on:boolean=false;
	global b_endgame_magboots_vo:boolean=false;
	
	global b_coliseum_distractions_on:boolean=false;
	
	global sentinels_is_there_enemy_nearby_result:boolean=false;
	global core_seen_count:number=4;
	global b_progressed_too_far:boolean=false;

	global sentinels_core_left_front_seen:boolean=false;
	global sentinels_core_left_back_seen:boolean=false;
	global sentinels_core_right_front_seen:boolean=false;
	global sentinels_core_right_back_seen:boolean=false;
	
	global b_exuberant_gondola_lovely:boolean=false;
	
	global b_player_reached_end_road:boolean=false;
	
	global b_blink_undergound_vo:boolean=false;
	
	global b_gondola_entrance_interrupt:boolean=false;
	
	global b_endgame_osiris_is_talking:boolean=false;

	global b_underground_dome_attach:boolean=false;

	global b_cacophony_is_playing:boolean=false;
	
	
	

-- =================================================================================================
-- *** MAIN ***
-- =================================================================================================



function sentinels_narrative_startup()

	print("*************  SENTINELS NARRATIVE LOADED ******************");
	g_display_narrative_debug_info = true;

	PrintNarrative("Killing Narrative Queue");
	NarrativeQueue.Kill();

	SleepUntil([| list_count(players()) ~= 0], 10);

	PrintNarrative("Killing Narrative Queue");
	NarrativeQueue.Kill();

	b_push_forward_vo_timer_default = 60;

--	Force display Temp Text from TTS (Subtitles)
--	dialog_line_temp_blurb_force_set(true);

	CreateMissionThread(PushForwardVO, missionSentinels.goal_endgame);
	CreateMissionThread(sentinels_pushforward);	
	CreateMissionThread(PushForwardVOStandBy);
	CreateMissionThread(sentinels_chatter);
	CreateMissionThread(sentinels_four_players_combat_check);

	CreateMissionThread(sentinels_exuberant_stares);
	CreateMissionThread(sentinels_exuberant_shooting);
end


--/////////////////////////////////////////////////////////////////////////////////
-- MAIN
--/////////////////////////////////////////////////////////////////////////////////



function sentinels_sassy_spark_character()

	--PrintNarrative("LOAD - sentinels_sassy_spark_character");

	if not ai_get_object(AI.sq_sassy_spark) then
		return nil;
	else 
		return AI.sq_sassy_spark;
	end


end


-- =================================================================================================
--  __  __ _    _  _____ ______ _    _ __  __ 
-- |  \/  | |  | |/ ____|  ____| |  | |  \/  |
-- | \  / | |  | | (___ | |__  | |  | | \  / |
-- | |\/| | |  | |\___ \|  __| | |  | | |\/| |
-- | |  | | |__| |____) | |____| |__| | |  | |
-- |_|  |_|\____/|_____/|______|\____/|_|  |_|
--                                            
-- =================================================================================================



function sentinels_museum_wake()

	PrintNarrative("START - sentinels_museum_wake");		
		
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__museum__start_corridor");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__museum__start_corridor);

		CreateMissionThread(sentinels_museum_silence_grunts);
		CreateMissionThread(sentinels_museum_silence_soldier);

		AIDialogManager.DisableAIDialog(AI.vin_prisoncell_grunts_with_elit.elite_sit);
		AIDialogManager.DisableAIDialog(AI.vin_prisoncell_grunts_with_elit.grunt02_sleep);
		AIDialogManager.DisableAIDialog(AI.vin_prisoncells_huinter_squad.vin_prisoncells_hunter_sp);
		AIDialogManager.DisableAIDialog(AI.vin_prisoncell_knight_disturbed.spawnpoint);
		AIDialogManager.DisableAIDialog(AI.pawnsquad);

	PrintNarrative("END - sentinels_museum_wake");

	PushForwardVOReset(-1);

	SleepUntil ([| volume_test_players(VOLUMES.tv_narrative_gondola_entrance)], 10);

		PrintNarrative("QUEUE - W3Sentinels_Sentinels__gondola_first_player");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__gondola_first_player);		

	SleepUntil ([| volume_test_players_all(VOLUMES.tv_narrative_gondola_entrance) or b_gondola_starting_to_leave], 1);

		CreateMissionThread(sentinels_gondola_ride);

		PrintNarrative("Interrupt Conversation: W3Sentinels_Sentinels__museum__start_corridor_2");
		NarrativeQueue.InterruptConversation(W3Sentinels_Sentinels__museum__start_corridor_2, 0.6);
		PrintNarrative("Interrupt Conversation: W3Sentinels_Sentinels__museum__start_corridor");
		NarrativeQueue.InterruptConversation(W3Sentinels_Sentinels__museum__start_corridor, 0.6);		
end


--[========================================================================[
          Sentinels. museum. start corridor

          Osiris and the Monitor are in a Forerunner corridor. There is
          only one way to go.

          The monitor is leading the way. When he arrives in the
          "museum" she goes straight to the hologram in the center.

          The Monitor receives informations from her installation, like
          through Wifi.
--]========================================================================]


global W3Sentinels_Sentinels__museum__start_corridor = {

	name = "W3Sentinels_Sentinels__museum__start_corridor",

	CanStart = function (thisConvo, queue)
		return list_count(players()) ~= 0; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExuBERANTWITNESS
			text = "The gateway. I tried to warn them and, well, here we are.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_23200.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Once Chief knows the destruction Cortana's caused... what do you think he'll do?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_08900.sound'),

			sleepAfter = 0.7,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "The man'll do the right thing. Always has.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_08100.sound'),

			sleepAfter = 0.7,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Let's find him.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_15800.sound'),			
		},		
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 1.5,

	OnInterrupt = function (thisConvo, queue, wasEndedEarly) -- VOID		
		b_gondola_entrance_interrupt = true;
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__museum__start_corridor_2");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__museum__start_corridor_2);
	end,
};


--[========================================================================[
          Sentinels. museum. start corridor

          Osiris and the Monitor are in a Forerunner corridor. There is
          only one way to go.

          The monitor is leading the way. When he arrives in the
          "museum" she goes straight to the hologram in the center.

          The Monitor receives informations from her installation, like
          through Wifi.
--]========================================================================]
global W3Sentinels_Sentinels__museum__start_corridor_2 = {
	name = "W3Sentinels_Sentinels__museum__start_corridor_2",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			character = CHARACTER_OBJECTS.cr_fake_exuberant_character_start,
			text = "Ohhhh this is interesting. Or maybe this is terrible.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_10300.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,			

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Exuberant? What is it?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_05000.sound'),

			sleepAfter = 0.3,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			character = CHARACTER_OBJECTS.cr_fake_exuberant_character_start,
			text = "Cortana has activated a Cryptum. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_10400.sound'),

			sleepAfter = 0.3,
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,	

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VaLE
			text = "A what?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_02900.sound'),
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			character = CHARACTER_OBJECTS.cr_fake_exuberant_character_start,
			text = "This is a Cryptum. It is a device for extended forced meditation. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_10500.sound'),
		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			character = CHARACTER_OBJECTS.cr_fake_exuberant_character_start,
			text = "Cortana has placed the other humans inside and is preparing it for slipspace travel.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_22900.sound'),
		},		
		[7] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "She's planning to take the Chief with her.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_04500.sound'),
		},		
		[8] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Where is the Cryptum from here?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_04600.sound'),
		},
		[9] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			character = CHARACTER_OBJECTS.cr_fake_exuberant_character_start,
			text = "Not far. Right this way.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_14500.sound'),

			playDurationAdjustment = 0.4,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
				b_hub_right_this_way_sassy = true;	
			end,
		},
	},

	sleepAfter = 2,

	OnInterrupt = function (thisConvo, queue, wasEndedEarly) -- VOID		
		b_gondola_entrance_interrupt = true;
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(sentinels_museum_cells);
		PushForwardVOReset();
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__museum__push_forward");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__museum__push_forward);
		CreateMissionThread(sentinels_museum_exit_door);		
	end,
};

----------------------------------------------------------------------

function sentinels_museum_cells()

	PrintNarrative("WAKE - sentinels_museum_cells");
	PrintNarrative("START - sentinels_museum_cells");

	SleepUntil ([| not b_collectible_used and IsGoalActive(missionSentinels.goal_museum) and (volume_test_players_lookat( VOLUMES.tv_narrative_sentinels_museum_elites,13, 40 ) or volume_test_players_lookat( VOLUMES.tv_narrative_sentinels_museum_soldier,13, 40 ) or volume_test_players_lookat( VOLUMES.tv_narrative_sentinels_museum_hunter,13, 40 ) or 
					volume_test_players_lookat( VOLUMES.tv_narrative_sentinels_museum_knight,13, 40 ) or volume_test_players_lookat( VOLUMES.tv_narrative_sentinels_museum_crawlers,13, 40 ) or volume_test_players_lookat( VOLUMES.tv_narrative_sentinels_museum_grunts,13, 40 ) ) ], 10);	
				
			PrintNarrative("QUEUE - W3Sentinels_Sentinels__museum__entrance");
			NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__museum__entrance);

	
	sleep_s(5);

	PrintNarrative("START - sentinels_museum_cells - line 2");
	SleepUntil ([| IsGoalActive(missionSentinels.goal_museum) and (volume_test_players_lookat( VOLUMES.tv_narrative_sentinels_museum_elites, 5, 40 ) or volume_test_players_lookat( VOLUMES.tv_narrative_sentinels_museum_soldier, 5, 40 ) or volume_test_players_lookat( VOLUMES.tv_narrative_sentinels_museum_hunter, 5, 40 ) or 
					volume_test_players_lookat( VOLUMES.tv_narrative_sentinels_museum_knight, 5, 40 ) or volume_test_players_lookat( VOLUMES.tv_narrative_sentinels_museum_crawlers, 5, 40 ) or volume_test_players_lookat( VOLUMES.tv_narrative_sentinels_museum_grunts, 5, 40 ) ) ], 10);
					
			--PrintNarrative("QUEUE - W3Sentinels_Sentinels__museum__entrance_2");
			--NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__museum__entrance_2);
	
	PrintNarrative("END - sentinels_museum_entrance");
end



--[========================================================================[
          Sentinels. museum. entrance

          Osiris and the monitor arrive in a small hub. In the center
          is a Forerunner holo-plinth. Ringing the perimeter are cells
          containing a zoo-like collection of Covenant (Elites, Grunts,
          Jackals, etc.) and Prometheans.
--]========================================================================]
global W3Sentinels_Sentinels__museum__entrance = {
	name = "W3Sentinels_Sentinels__museum__entrance",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(40);
		CreateMissionThread(sentinels_museum_grunts_01);
		CreateMissionThread(sentinels_museum_soldier);
	end,

	sleepBefore = 1,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionSentinels.goal_museum);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			character = CHARACTER_OBJECTS.cr_fake_exuberant_character_start,
			text = "Ah. You've noticed my humble collection. Just a few specimens the Guardians have brought to Genesis. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_00600.sound'),		

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},

	},

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);

		PrintNarrative("QUEUE - W3Sentinels_Sentinels__museum__hunters_cell");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__museum__hunters_cell);

		PrintNarrative("QUEUE - W3Sentinels_Sentinels__museum__knight_cell");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__museum__knight_cell);

		PrintNarrative("QUEUE - W3Sentinels_Sentinels__museum__crawlers_cell");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__museum__crawlers_cell);
		
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__museum__elite_and_grunt");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__museum__elite_and_grunt);

		PrintNarrative("QUEUE - W3Sentinels_Sentinels__museum__soldier");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__museum__soldier);		
	end,
};


function sentinels_museum_silence_grunts()
	
	PrintNarrative("START - sentinels_museum_silence_grunts");

	repeat

		SleepUntil ([|not IsGoalActive(missionSentinels.goal_museum) or objects_distance_to_object( players(), ai_get_object(AI.vin_prisoncell_grunts_with_elit.grunt01_pound01) ) < 20 or not volume_test_players_all( VOLUMES.tv_narrative_museum )], 60);
		PrintNarrative("START - sentinels_museum_silence_grunts - Disable AI chatter");

		if IsGoalActive(missionSentinels.goal_museum) or not volume_test_players_all( VOLUMES.tv_narrative_museum ) then
			AIDialogManager.DisableAIDialog(AI.vin_prisoncell_grunts_with_elit.grunt01_pound01);
			AIDialogManager.DisableAIDialog(AI.vin_prisoncell_grunts_with_elit.grunt03_pound03);
			AIDialogManager.DisableAIDialog(AI.vin_prisoncell_grunts_with_elit.grunt04_sit);
		end

		SleepUntil ([| volume_test_players_all( VOLUMES.tv_narrative_museum ) and (not IsGoalActive(missionSentinels.goal_museum) or objects_distance_to_object( players(), ai_get_object(AI.vin_prisoncell_grunts_with_elit.grunt01_pound01) ) >= 20)], 60);
		PrintNarrative("START - sentinels_museum_silence_grunts - Enable AI chatter");

		if IsGoalActive(missionSentinels.goal_museum) then
			AIDialogManager.EnableAIDialog(AI.vin_prisoncell_grunts_with_elit.grunt01_pound01);
			AIDialogManager.EnableAIDialog(AI.vin_prisoncell_grunts_with_elit.grunt03_pound03);
			AIDialogManager.EnableAIDialog(AI.vin_prisoncell_grunts_with_elit.grunt04_sit);
		end

	until not IsGoalActive(missionSentinels.goal_museum)

	PrintNarrative("END - sentinels_museum_silence_grunts");

end


function sentinels_museum_silence_soldier()
	
	PrintNarrative("START - sentinels_museum_silence_soldier");

	repeat

		SleepUntil ([| not volume_test_players_all( VOLUMES.tv_narrative_museum ) or not IsGoalActive(missionSentinels.goal_museum) or objects_distance_to_object( players(), ai_get_object(AI.vin_w3_prisoncells_soldier_squa.soldier) ) < 20], 60);
		PrintNarrative("START - sentinels_museum_silence_soldier - Disable AI chatter");

		if IsGoalActive(missionSentinels.goal_museum) then
			AIDialogManager.DisableAIDialog(AI.vin_w3_prisoncells_soldier_squa.soldier);
		end

		SleepUntil ([|volume_test_players_all( VOLUMES.tv_narrative_museum ) and (not IsGoalActive(missionSentinels.goal_museum) or objects_distance_to_object( players(), ai_get_object(AI.vin_w3_prisoncells_soldier_squa.soldier) ) >= 20)], 60);
		PrintNarrative("START - sentinels_museum_silence_soldier - Enable AI chatter");

		if IsGoalActive(missionSentinels.goal_museum) then
			AIDialogManager.EnableAIDialog(AI.vin_w3_prisoncells_soldier_squa.soldier);		
		end

	until not IsGoalActive(missionSentinels.goal_museum)

	PrintNarrative("END - sentinels_museum_silence_soldier");

end


function sentinels_museum_grunts_01()

PrintNarrative("START - sentinels_museum_grunts_01");

		PrintNarrative("REPEAT - sentinels_museum_grunts_01");

		SleepUntil ([|objects_distance_to_object( players(), ai_get_object(AI.vin_prisoncell_grunts_with_elit.grunt01_pound01) ) < 20 and b_grunt01_start], 1);		

		if W3Sentinels_Sentinels__museum__grunt_cell_grunt01.localVariables.played == nil or (W3Sentinels_Sentinels__museum__grunt_cell_grunt01.localVariables.played == true and random_range(1,2) == 1) then

			PrintNarrative("QUEUE - W3Sentinels_Sentinels__museum__grunt_cell_grunt01");
			NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__museum__grunt_cell_grunt01);

			SleepUntil ([| NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__museum__grunt_cell_grunt01)], 1);
		end

		sleep_s(0.5);

	if (IsGoalActive(missionSentinels.goal_museum) and device_get_position(OBJECTS.dm_gondola) == 0) then
		CreateMissionThread(sentinels_museum_grunts_03);
	end

PrintNarrative("END - sentinels_museum_grunts_01");

end



--[========================================================================[
          Sentinels. museum. grunt cell
--]========================================================================]
global W3Sentinels_Sentinels__museum__grunt_cell_grunt01 = {
	name = "W3Sentinels_Sentinels__museum__grunt_cell_grunt01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_collectible_used and IsGoalActive(missionSentinels.goal_museum) and volume_test_players_all( VOLUMES.tv_narrative_museum );
			end,

			sleepBefore = 0.5,

			character = AI.vin_prisoncell_grunts_with_elit.grunt01_pound01, -- GAMMA_CHARACTER: grunt01
			text = "[Umpf!]... ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_cv_grunt02_00100.sound'),
		},		
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_collectible_used and IsGoalActive(missionSentinels.goal_museum) and thisConvo.localVariables.grunt02_a and volume_test_players_all( VOLUMES.tv_narrative_museum );																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			character = AI.vin_prisoncell_grunts_with_elit.grunt01_pound01, -- GAMMA_CHARACTER: grunt01
			text = "Humans! Get me out! Let me get out! I'll kill you!! rhaaa, rhaaa!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_cv_grunt02_00300.sound'),
			
			--playDurationAdjustment = 0.95,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				thisConvo.localVariables.grunt02_a = false;
				thisConvo.localVariables.grunt02_b = true;
				return 4;
			end,

			sleepAfter = 1.4,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_collectible_used and IsGoalActive(missionSentinels.goal_museum) and thisConvo.localVariables.grunt02_b and volume_test_players_all( VOLUMES.tv_narrative_museum );																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			sleepBefore = 3,

			character = AI.vin_prisoncell_grunts_with_elit.grunt01_pound01, -- GAMMA_CHARACTER: grunt01
			text = "No I mean... Don't go!... Rhaaa!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_cv_grunt02_00400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				thisConvo.localVariables.grunt02_a = true;
				thisConvo.localVariables.grunt02_b = false;
				return 4;
			end,

			sleepAfter = 1.4,
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_collectible_used and IsGoalActive(missionSentinels.goal_museum) and volume_test_players_all( VOLUMES.tv_narrative_museum );
			end,

			--sleepBefore = 1,

			character = AI.vin_prisoncell_grunts_with_elit.grunt01_pound01, -- GAMMA_CHARACTER: grunt01
			text = "[Umpf!]...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_cv_grunt02_00200.sound'),
		},
	},

	sleepAfter = 5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		thisConvo.localVariables.played = true;
	end,

	localVariables = {
						grunt02_a = true,
						grunt02_b = false,
						played = nil,
						},
};



function sentinels_museum_grunts_03()

PrintNarrative("START - sentinels_museum_grunts_03");
		
		PrintNarrative("REPEAT - sentinels_museum_grunts_03");

		SleepUntil ([|objects_distance_to_object( players(), ai_get_object(AI.vin_prisoncell_grunts_with_elit.grunt04_sit) ) < 15], 1);		

		if random_range(1,2) == 1 then

			PrintNarrative("QUEUE - W3Sentinels_Sentinels__museum__grunt_cell_grunt03");
			NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__museum__grunt_cell_grunt03);

			SleepUntil ([| NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__museum__grunt_cell_grunt03)], 1);
		end

		sleep_s(0.5);

		if (IsGoalActive(missionSentinels.goal_museum) and device_get_position(OBJECTS.dm_gondola) == 0) then
			CreateMissionThread(sentinels_museum_grunts_02);
		end

PrintNarrative("END - sentinels_museum_grunts_03");

end


--[========================================================================[
          Sentinels. museum. grunt cell
--]========================================================================]
global W3Sentinels_Sentinels__museum__grunt_cell_grunt03 = {
	name = "W3Sentinels_Sentinels__museum__grunt_cell_grunt03",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_collectible_used and IsGoalActive(missionSentinels.goal_museum) and volume_test_players_all( VOLUMES.tv_narrative_museum );
			end,

			character = AI.vin_prisoncell_grunts_with_elit.grunt04_sit;
			text = "Relax guys. At least we're not figthing.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_cv_grunt01_00400.sound'),

			sleepAfter = 0.5,
		},	
	},

	sleepAfter = 5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);	
	end,
};



function sentinels_museum_grunts_02()

PrintNarrative("START - sentinels_museum_grunts_02");

		PrintNarrative("REPEAT - sentinels_museum_grunts_02");

		SleepUntil ([|objects_distance_to_object( players(), ai_get_object(AI.vin_prisoncell_grunts_with_elit.grunt03_pound03) ) < 15 and b_grunt02_start], 1);		

		if random_range(1,2) == 1 then

			PrintNarrative("QUEUE - W3Sentinels_Sentinels__museum__grunt_cell_grunt02");
			NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__museum__grunt_cell_grunt02);

			SleepUntil ([| NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__museum__grunt_cell_grunt02)], 1);
		end

		sleep_s(0.5);

		if (IsGoalActive(missionSentinels.goal_museum) and device_get_position(OBJECTS.dm_gondola) == 0) then
			CreateMissionThread(sentinels_museum_grunts_03bis);
		end

PrintNarrative("END - sentinels_museum_grunts_02");

end

--[========================================================================[
          Sentinels. museum. grunt cell
--]========================================================================]
global W3Sentinels_Sentinels__museum__grunt_cell_grunt02 = {
	name = "W3Sentinels_Sentinels__museum__grunt_cell_grunt02",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	--sleepBefore = 0.1,

	lines = {
		
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_collectible_used and IsGoalActive(missionSentinels.goal_museum) and volume_test_players_all( VOLUMES.tv_narrative_museum );
			end,

			character = AI.vin_prisoncell_grunts_with_elit.grunt03_pound03, -- GAMMA_CHARACTER: grunt01
			text = "I want to GET... OUT!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_cv_grunt01_00200.sound'),

			sleepAfter = 0.5,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_collectible_used and IsGoalActive(missionSentinels.goal_museum) and volume_test_players_all( VOLUMES.tv_narrative_museum );
			end,

			character = AI.vin_prisoncell_grunts_with_elit.grunt03_pound03, -- GAMMA_CHARACTER: grunt01
			text = "Let me OUUUUUUUUT!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_cv_grunt01_00300.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_collectible_used and IsGoalActive(missionSentinels.goal_museum) and volume_test_players_all( VOLUMES.tv_narrative_museum );
			end,

			sleepBefore = 2.5,

			character = AI.vin_prisoncell_grunts_with_elit.grunt03_pound03, -- GAMMA_CHARACTER: grunt01
			text = "[Umpf!]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_cv_grunt01_00100.sound'),
		},
	},

	sleepAfter = 5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,
};




function sentinels_museum_grunts_03bis()

PrintNarrative("START - sentinels_museum_grunts_03bis");
		
		PrintNarrative("REPEAT - sentinels_museum_grunts_03bis");

		SleepUntil ([|objects_distance_to_object( players(), ai_get_object(AI.vin_prisoncell_grunts_with_elit.grunt04_sit) ) < 15], 1);		

		if random_range(1,3) == 1 then

			PrintNarrative("QUEUE - W3Sentinels_Sentinels__museum__grunt_cell_grunt03bis");
			NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__museum__grunt_cell_grunt03bis);

			SleepUntil ([| NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__museum__grunt_cell_grunt03bis)], 1);
		end

		sleep_s(0.5);

		if (IsGoalActive(missionSentinels.goal_museum) and device_get_position(OBJECTS.dm_gondola) == 0) then
			CreateMissionThread(sentinels_museum_grunts_03ter);
		end

PrintNarrative("END - sentinels_museum_grunts_03bis");

end


--[========================================================================[
          Sentinels. museum. grunt cell
--]========================================================================]
global W3Sentinels_Sentinels__museum__grunt_cell_grunt03bis = {
	name = "W3Sentinels_Sentinels__museum__grunt_cell_grunt03bis",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {		
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_collectible_used and IsGoalActive(missionSentinels.goal_museum) and volume_test_players_all( VOLUMES.tv_narrative_museum );
			end,

			character = AI.vin_prisoncell_grunts_with_elit.grunt04_sit;
			text = "You know what I would have liked? I wanted to be like Kit Pitlimp.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_cv_grunt01_00600.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_collectible_used and IsGoalActive(missionSentinels.goal_museum) and volume_test_players_all( VOLUMES.tv_narrative_museum );
			end,

			character = AI.vin_prisoncell_grunts_with_elit.grunt04_sit;
			text = "This Kit... he was crazy... but he saw the world.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_cv_grunt01_00700.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_collectible_used and IsGoalActive(missionSentinels.goal_museum) and volume_test_players_all( VOLUMES.tv_narrative_museum );
			end,

			character = AI.vin_prisoncell_grunts_with_elit.grunt04_sit;
			text = "As we speak, I'm sure he discovered a old tribe of Forerunners and he is their king!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_cv_grunt01_00800.sound'),
		},		
	},

	sleepAfter = 5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);	
	end,
};


function sentinels_museum_grunts_03ter()

PrintNarrative("START - sentinels_museum_grunts_03ter");
		
		PrintNarrative("REPEAT - sentinels_museum_grunts_03ter");

		SleepUntil ([|objects_distance_to_object( players(), ai_get_object(AI.vin_prisoncell_grunts_with_elit.grunt04_sit) ) < 15], 1);		
	
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__museum__grunt_cell_grunt03ter");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__museum__grunt_cell_grunt03ter);

		SleepUntil ([| NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__museum__grunt_cell_grunt03ter)], 1);

		sleep_s(0.5);

		if (IsGoalActive(missionSentinels.goal_museum) and device_get_position(OBJECTS.dm_gondola) == 0) then
			CreateMissionThread(sentinels_museum_grunts_01);
		end

PrintNarrative("END - sentinels_museum_grunts_03bis");

end


--[========================================================================[
          Sentinels. museum. grunt cell
--]========================================================================]
global W3Sentinels_Sentinels__museum__grunt_cell_grunt03ter = {
	name = "W3Sentinels_Sentinels__museum__grunt_cell_grunt03ter",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {				
		[1] = {		
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return volume_test_players_all( VOLUMES.tv_narrative_museum ) and not b_collectible_used and IsGoalActive(missionSentinels.goal_museum) and ((thisConvo.localVariables.played == true and random_range(1,3) == 1) or thisConvo.localVariables.played == nil);
			end,

			character = AI.vin_prisoncell_grunts_with_elit.grunt04_sit;
			text = "They told me Sunaion was a quiet place... pfff... just chant, eat and pray all day...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_cv_grunt01_00900.sound'),
		},
	},

	sleepAfter = 5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		thisConvo.localVariables.played = true;
	end,

	localVariables = {
						played = nil
						},
};

--[========================================================================[
          Sentinels. museum. hunters cell
--]========================================================================]
global W3Sentinels_Sentinels__museum__hunters_cell = {
	name = "W3Sentinels_Sentinels__museum__hunters_cell",

	CanStart = function (thisConvo, queue)
		return not b_collectible_used and IsSpartanAbleToSpeak(SPARTANS.tanaka) and IsSpartanAbleToSpeak(SPARTANS.vale) and volume_test_players_lookat( VOLUMES.tv_narrative_sentinels_museum_hunter, 3, 40 )
				and (	(IsPlayer(SPARTANS.tanaka) and objects_distance_to_object(ai_get_object(AI.vin_prisoncells_huinter_squad.vin_prisoncells_hunter_sp), SPARTANS.tanaka ) < 5	)
							or not IsPlayer(SPARTANS.tanaka)	);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(40);
	end,

	sleepAfter = 0.6,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionSentinels.goal_museum) and volume_test_players_all( VOLUMES.tv_narrative_museum );
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Hunters. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_02100.sound'),

			sleepAfter = 0.6,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionSentinels.goal_museum) and volume_test_players_all( VOLUMES.tv_narrative_museum );
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Their proper name is Mgalekgolo. They're a hive mind of worms--",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_01800.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionSentinels.goal_museum) and volume_test_players_all( VOLUMES.tv_narrative_museum );
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "They're disgusting.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_02200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};




--[========================================================================[
          Sentinels. museum. knight cell
--]========================================================================]
global W3Sentinels_Sentinels__museum__knight_cell = {
	name = "W3Sentinels_Sentinels__museum__knight_cell",

	CanStart = function (thisConvo, queue)
		return not b_collectible_used and volume_test_players_lookat( VOLUMES.tv_narrative_sentinels_museum_knight, 3, 40 )
				and (	(IsPlayer(SPARTANS.buck) and objects_distance_to_object(ai_get_object(AI.vin_prisoncell_knight_disturbed.spawnpoint), SPARTANS.buck ) < 7	)
							or not IsPlayer(SPARTANS.buck)	); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(40);
	end,

	sleepBefore = 0.6,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionSentinels.goal_museum) and volume_test_players_all( VOLUMES.tv_narrative_museum );
			end,

			sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "A knight...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_08800.sound'),
			
			sleepAfter = 0.5,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionSentinels.goal_museum) and volume_test_players_all( VOLUMES.tv_narrative_museum );
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Kind of making me feel sad for him.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_02700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__museum__knight_cell_2");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__museum__knight_cell_2);
	end,
};


--[========================================================================[
          Sentinels. museum. knight cell
--]========================================================================]
global W3Sentinels_Sentinels__museum__knight_cell_2 = {
	name = "W3Sentinels_Sentinels__museum__knight_cell_2",

	CanStart = function (thisConvo, queue)
		return not b_collectible_used and volume_test_players_lookat( VOLUMES.tv_narrative_sentinels_museum_knight, 3, 40 )
				and (	(IsPlayer(SPARTANS.vale) and objects_distance_to_object(ai_get_object(AI.vin_prisoncell_knight_disturbed.spawnpoint), SPARTANS.vale ) < 7	)
							or not IsPlayer(SPARTANS.vale)	); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(40);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionSentinels.goal_museum) and volume_test_players_all( VOLUMES.tv_narrative_museum );
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Their little arms always creep me out.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_02000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};


--[========================================================================[
          Sentinels. museum. crawlers cell
--]========================================================================]
global W3Sentinels_Sentinels__museum__crawlers_cell = {
	name = "W3Sentinels_Sentinels__museum__crawlers_cell",

	CanStart = function (thisConvo, queue)
		return not b_collectible_used and volume_test_players_lookat( VOLUMES.tv_narrative_sentinels_museum_crawlers, 4, 40 )
				and (	(IsPlayer(SPARTANS.vale) and objects_distance_to_object(ai_get_object(AI.pawnsquad.pawn_05), SPARTANS.vale ) < 7	)
							or not IsPlayer(SPARTANS.vale)	); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(40);
	end,

	sleepBefore = 0.6,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionSentinels.goal_museum) and volume_test_players_all( VOLUMES.tv_narrative_museum );
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Crawlers...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_07200.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionSentinels.goal_museum) and volume_test_players_all( VOLUMES.tv_narrative_museum );
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "This is going to sound weird, but... They look kind of happy in there.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_02100.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionSentinels.goal_museum) and volume_test_players_all( VOLUMES.tv_narrative_museum );
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			character = CHARACTER_OBJECTS.cr_fake_exuberant_character_start,
			text = "I had to keep them as a group. If I kept one by itself, it would just keep whining all the time.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_11000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};




--[========================================================================[
          Sentinels. museum. elite and grunt
--]========================================================================]
global W3Sentinels_Sentinels__museum__elite_and_grunt = {
	name = "W3Sentinels_Sentinels__museum__elite_and_grunt",

	CanStart = function (thisConvo, queue)
		return not b_collectible_used and volume_test_players_lookat( VOLUMES.tv_narrative_sentinels_museum_elites, 5, 20 )
					and (	(IsPlayer(SPARTANS.buck) and objects_distance_to_object(ai_get_object(AI.vin_prisoncell_grunts_with_elit.elite_sit), SPARTANS.buck ) < 7	)
							or not IsPlayer(SPARTANS.buck)	); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(40);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionSentinels.goal_museum) and volume_test_players_all( VOLUMES.tv_narrative_museum );
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Almost didn't see you there.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_02800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__museum__elite_and_grunt_2");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__museum__elite_and_grunt_2);
	end,
};


--[========================================================================[
          Sentinels. museum. elite and grunt
--]========================================================================]
global W3Sentinels_Sentinels__museum__elite_and_grunt_2 = {
	name = "W3Sentinels_Sentinels__museum__elite_and_grunt_2",

	CanStart = function (thisConvo, queue)
		return not b_collectible_used and volume_test_players_lookat( VOLUMES.tv_narrative_sentinels_museum_elites, 5, 40 )
					and (	(IsPlayer(SPARTANS.tanaka) and objects_distance_to_object(ai_get_object(AI.vin_prisoncell_grunts_with_elit.elite_sit), SPARTANS.tanaka ) < 6	)
							or not IsPlayer(SPARTANS.tanaka)	); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(40);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionSentinels.goal_museum) and volume_test_players_all( VOLUMES.tv_narrative_museum );
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Hang on. Are... No, not a Sword of Sanghelios. Heh. Better off in there, pal.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_02600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};



function sentinels_museum_soldier()

PrintNarrative("START - sentinels_museum_soldier");

		PrintNarrative("REPEAT - sentinels_museum_soldier");

		sleep_s(2);

		SleepUntil ([|objects_distance_to_object( players(), ai_get_object(AI.vin_w3_prisoncells_soldier_squa.soldier) ) < 8 and b_soldier_start], 1);		

		PrintNarrative("QUEUE - W3Sentinels_Sentinels__museum__soldier_bis");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__museum__soldier_bis);

PrintNarrative("END - sentinels_museum_soldier");

end

--[========================================================================[
          Sentinels. museum. soldier
--]========================================================================]
global W3Sentinels_Sentinels__museum__soldier = {
	name = "W3Sentinels_Sentinels__museum__soldier",

	CanStart = function (thisConvo, queue)
		return not b_collectible_used and volume_test_players_lookat( VOLUMES.tv_narrative_sentinels_museum_soldier, 3, 40 ); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(40);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionSentinels.goal_museum) and volume_test_players_all( VOLUMES.tv_narrative_museum );
			end,

			sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			character = CHARACTER_OBJECTS.cr_fake_exuberant_character_start,
			text = "I'm afraid this Soldier is not really happy to be locked down in the display case. But I cannot have them popping about. Terribly distracting.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_11100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,

};


--[========================================================================[
          Sentinels. museum. soldier
--]========================================================================]
global W3Sentinels_Sentinels__museum__soldier_bis = {
	name = "W3Sentinels_Sentinels__museum__soldier_bis",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(40);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_collectible_used and IsGoalActive(missionSentinels.goal_museum) and random_range(1,3) == 1 and volume_test_players_all( VOLUMES.tv_narrative_museum );
			end,
			
			character = AI.vin_w3_prisoncells_soldier_squa.soldier,
			--text = "I'm afraid this Soldier is not really happy to be locked down in the display case. But I cannot have them popping about. Terribly distracting.",
			tag = TAG('sound\001_vo\001_vo_ai\001_vo_ai_soldier02\001_vo_ai_fr_soldier02_02combat_curseyell.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		if (IsGoalActive(missionSentinels.goal_museum) and device_get_position(OBJECTS.dm_gondola) == 0) then
			CreateMissionThread(sentinels_museum_soldier);
		end
	end,

};

--[========================================================================[
          Sentinels. museum. push forward
--]========================================================================]
global W3Sentinels_Sentinels__museum__push_forward = {
	name = "W3Sentinels_Sentinels__museum__push_forward",

	CanStart = function (thisConvo, queue)
		return not b_collectible_used and b_push_forward_vo_timer == 3 and IsGoalActive(missionSentinels.goal_museum) and volume_test_players_all( VOLUMES.tv_narrative_museum ); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(40);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			character = CHARACTER_OBJECTS.cr_fake_exuberant_character_start,
			text = "You may want to leave soon. Cortana's plan is progressing.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_11300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};

----------------------------------------------------------------------

function sentinels_museum_exit_door()

	PrintNarrative("WAKE - sentinels_museum_exit_door");

	sleep_s(5);

	SleepUntil ([|volume_test_players(VOLUMES.tv_museum_exit)], 10);

	PrintNarrative("START - sentinels_museum_exit_door");
				
				PrintNarrative("QUEUE - W3Sentinels_Sentinels__museum__exit_door");
				NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__museum__exit_door);

	PrintNarrative("END - sentinels_museum_exit_door");
end



--[========================================================================[
          Sentinels. museum. exit door
--]========================================================================]
global W3Sentinels_Sentinels__museum__exit_door = {
	name = "W3Sentinels_Sentinels__museum__exit_door",

	CanStart = function (thisConvo, queue)
		return IsGoalActive(missionSentinels.goal_museum); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return false;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			character = CHARACTER_OBJECTS.cr_fake_exuberant_character_start,
			text = "This way.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_01800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};




-- =================================================================================================
--   _____  ____  _   _ _____   ____  _               
--  / ____|/ __ \| \ | |  __ \ / __ \| |        /\    
-- | |  __| |  | |  \| | |  | | |  | | |       /  \   
-- | | |_ | |  | | . ` | |  | | |  | | |      / /\ \  
-- | |__| | |__| | |\  | |__| | |__| | |____ / ____ \ 
--  \_____|\____/|_| \_|_____/ \____/|______/_/    \_\
--                                                
-- =================================================================================================


function sentinels_gondola_wake()

	PrintNarrative("START - sentinels_gondola_wake");
		
		SleepUntil ([| volume_test_players_all( VOLUMES.tv_narrative_gondola_entrance ) ], 10);

		PushForwardVOStandBy();

		AIDialogManager.DisableAIDialog(AI.vin_w3_prisoncells_soldier_squa.soldier);
		AIDialogManager.DisableAIDialog(AI.vin_prisoncell_grunts_with_elit.grunt01_pound01);
		AIDialogManager.DisableAIDialog(AI.vin_prisoncell_grunts_with_elit.grunt03_pound03);
		AIDialogManager.DisableAIDialog(AI.vin_prisoncell_grunts_with_elit.grunt04_sit);
		AIDialogManager.DisableAIDialog(AI.vin_prisoncell_grunts_with_elit.elite_sit);
		AIDialogManager.DisableAIDialog(AI.vin_prisoncell_grunts_with_elit.grunt02_sleep);
		AIDialogManager.DisableAIDialog(AI.vin_prisoncells_huinter_squad.vin_prisoncells_hunter_sp);
		AIDialogManager.DisableAIDialog(AI.vin_prisoncell_knight_disturbed.spawnpoint);
		AIDialogManager.DisableAIDialog(AI.pawnsquad);

		b_end_gondola_start = true;		

		sleep_s(0.5);		

		SleepUntil ([| volume_test_players( VOLUMES.tv_narrative_end_gondola ) ], 10);
		
		CreateThread(audio_sentinels_thread_up_gondola_exit);

		b_player_reached_end_gondola = true;

	PrintNarrative("END - sentinels_gondola_wake");
	

end



--[========================================================================[
          Sentinels. gondola. pre ride

          The door opens and Osiris enters the gondola deck.

          We're on a cliff. Below us is a large Forerunner structure
          (the Coliseum) ringed by Guardians, hovering. A few
          CONSTRUCTORS buzz around the Guardians, working on them.

          This is the same place where the Trials cinematic ends and
          that we saw in the Hologram. If you look closely, you can
          just make out the Cryptum hovering above the center of the
          Coliseum, though from this vantage point the Cryptum is
          dwarfed by the sheer scale of the Coliseum and the Guardians.
--]========================================================================]
global W3Sentinels_Sentinels__gondola_first_player = {
	name = "W3Sentinels_Sentinels__gondola_first_player",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return volume_test_players(VOLUMES.tv_narrative_gondola_entrance);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,
	
	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return list_count(players()) > 1;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Oooh... All the Guardians are here.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_23000.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();	
	end,

	sleepAfter = 0.5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);				
	end,
};




--[========================================================================[
          Sentinels. gondola. pre ride

          The door opens and Osiris enters the gondola deck.

          We're on a cliff. Below us is a large Forerunner structure
          (the Coliseum) ringed by Guardians, hovering. A few
          CONSTRUCTORS buzz around the Guardians, working on them.

          This is the same place where the Trials cinematic ends and
          that we saw in the Hologram. If you look closely, you can
          just make out the Cryptum hovering above the center of the
          Coliseum, though from this vantage point the Cryptum is
          dwarfed by the sheer scale of the Coliseum and the Guardians.
--]========================================================================]
global W3Sentinels_Sentinels__gondola__pre_ride = {
	name = "W3Sentinels_Sentinels__gondola__pre_ride",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,
	
	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN				
				return b_gondola_entrance_interrupt and ((not IsPlayer(SPARTANS.buck) and not IsUnitDowned(SPARTANS.buck) ) or
						(IsPlayer(SPARTANS.buck) and objects_distance_to_object( SPARTANS.locke, OBJECTS.dm_gondola) > objects_distance_to_object( SPARTANS.buck, OBJECTS.dm_gondola)) 
							and volume_test_object( VOLUMES.tv_narrative_gondola_entrance, SPARTANS.buck ));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Wait...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_06900.sound'),

			sleepAfter = 0.5,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER				
				return 3;
			end,
		},
		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN				
				return b_gondola_entrance_interrupt and ((not IsPlayer(SPARTANS.tanaka) and not IsUnitDowned(SPARTANS.tanaka) ) or
						(IsPlayer(SPARTANS.tanaka) and objects_distance_to_object( SPARTANS.locke, OBJECTS.dm_gondola) > objects_distance_to_object( SPARTANS.tanaka, OBJECTS.dm_gondola)) 
							and volume_test_object( VOLUMES.tv_narrative_gondola_entrance, SPARTANS.tanaka ));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Wait...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_tanaka_07300.sound'),
		},		
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return (IsPlayer(SPARTANS.buck) and not IsUnitDowned(SPARTANS.buck) and object_at_distance_and_can_see_object(SPARTANS.buck, OBJECTS.guardian_gondola_left1, 420, 50))
						or (list_count(players()) > 1 and not IsUnitDowned(SPARTANS.buck) and not IsPlayer(SPARTANS.buck) and objects_distance_to_object( players(), OBJECTS.guardian_gondola_left1) < 420)
						or (list_count(players()) == 1 and not IsUnitDowned(SPARTANS.buck));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Look at all of them. How are we going to stop that?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_01800.sound'),

			playDurationAdjustment = 0.8,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (IsPlayer(SPARTANS.tanaka) and not IsUnitDowned(SPARTANS.tanaka) and object_at_distance_and_can_see_object(SPARTANS.tanaka, OBJECTS.guardian_gondola_left1, 420, 50))
						or (list_count(players()) > 1 and not IsUnitDowned(SPARTANS.tanaka) and not IsPlayer(SPARTANS.tanaka) and objects_distance_to_object( players(), OBJECTS.guardian_gondola_left1) < 420)
						or (list_count(players()) == 1);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Look at all of them. How are we going to stop that?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_tanaka_07400.sound'),

			--playDurationAdjustment = 0.8,
		},	
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID		
		hud_hide_radio_transmission_hud();	
	end,

	sleepAfter = 0.5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);				
	end,
};
----------------------------------------------------------------------

function sentinels_gondola_pre_ride_pushforward()
	
	PrintNarrative("WAKE - sentinels_gondola_pre_ride_pushforward");
	PrintNarrative("TIMER - sentinels_gondola_pre_ride_pushforward");
	
	PushForwardVOStandBy();

	sleep_s(2);

	SleepUntil ([| not volume_test_players( VOLUMES.tv_narrative_gondola ) ], 10);

	if device_get_position(OBJECTS.dm_gondola) == 0 then
				
				PrintNarrative("QUEUE - W3Sentinels_Sentinels__gondola__ride_start");					
				NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__gondola__ride_start);

				SleepUntil ([| NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__gondola__ride_start)], 10);
	end
				
	sleep_s(20);

	if device_get_position(OBJECTS.dm_gondola) == 0 then

				PrintNarrative("QUEUE - W3Sentinels_Sentinels__gondola__ride_start_2");					
				NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__gondola__ride_start_2);

				SleepUntil ([| NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__gondola__ride_start_2)], 10);
	end

	sleep_s(25);
	
	if device_get_position(OBJECTS.dm_gondola) == 0 then

				PrintNarrative("QUEUE - W3Sentinels_Sentinels__gondola__ride_start_3");					
				NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__gondola__ride_start_3);

				PushForwardVOReset();
	end
	PrintNarrative("END - sentinels_gondola_pre_ride_pushforward");

end



function sentinels_gondola_advancement()

repeat
	print(device_get_position(OBJECTS.dm_gondola));
	sleep_s(0.3);
until (false)

end


--[========================================================================[
          Sentinels. gondola. ride start
--]========================================================================]
global W3Sentinels_Sentinels__gondola__ride_start = {
	name = "W3Sentinels_Sentinels__gondola__ride_start",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {	
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players_all( VOLUMES.tv_gondola_start ) and IsGoalActive(missionSentinels.goal_gondola);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Board the gondola whenever you are ready.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_10000.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,	 
};



--[========================================================================[
          Sentinels. gondola. ride start
--]========================================================================]
global W3Sentinels_Sentinels__gondola__ride_start_2 = {
	name = "W3Sentinels_Sentinels__gondola__ride_start_2",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players_all( VOLUMES.tv_gondola_start ) and IsGoalActive(missionSentinels.goal_gondola);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Please humans, come this way.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_10100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,	 
};




--[========================================================================[
          Sentinels. gondola. ride start
--]========================================================================]
global W3Sentinels_Sentinels__gondola__ride_start_3 = {
	name = "W3Sentinels_Sentinels__gondola__ride_start_3",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players_all( VOLUMES.tv_gondola_start ) and IsGoalActive(missionSentinels.goal_gondola);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "I need you all onboard before we start our journey. Please, hop on!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_14600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,	 
};

----------------------------------------------------------------------

function sentinels_gondola_ride()
local s_looker:object = nil;
local s_timer:number = 0;

	PrintNarrative("WAKE - sentinels_gondola_ride");
	
	PrintNarrative("START - sentinels_gondola_ride");
		
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__gondola__pre_ride");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__gondola__pre_ride);				

		SleepUntil ([|NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__gondola__pre_ride)], 10);

		--sleep_s(4);

	--	WHALE SONG AND PULSES

		--WHALE SONG
		PrintNarrative("WHALE SONG PLAYING");
		CreateMissionThread(sentinels_guardian_sound_3d,OBJECTS.guardian_gondola_left1);

		sleep_s(2);
		
		--PrintNarrative("QUEUE - W3Sentinels_Sentinels__gondola__Guardian_whalesong");
		--NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__gondola__Guardian_whalesong);

		CreateThread(audio_sentinels_thread_up_gondola_emp);

		sleep_s(6.2);		--	Change this sleep to adjust the timing of MUSIC and EMP
		
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__gondola__Guardian_pre_pulse_2");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__gondola__Guardian_pre_pulse_2);
		
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__gondola__Guardian_pre_pulse");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__gondola__Guardian_pre_pulse);

		sleep_s(0.5);

		--	SLIPSPACE ANIMATION
		b_gondola_left_guardian_slipspace = true;
		
	--	AFTER THE SLIPSPACE
	SleepUntil ([|b_gondola_left_guardian_slipspace_end], 10);
	
	sleep_s(1);
	
	PrintNarrative("QUEUE - W3Sentinels_Sentinels__gondola__Guardian_Slipspace_3");					
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__gondola__Guardian_Slipspace_3);
		SleepUntil ([|volume_test_players_all(VOLUMES.tv_gondola_start) or b_gondola_starting_to_leave], 1);
	
	
	PushForwardVOStandBy();

	sleep_s(1);

	SleepUntil ([| volume_test_players( VOLUMES.tv_narrative_gondola_cortana ) or (NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__gondola__Guardian_Slipspace_3)) and device_get_position(OBJECTS.dm_gondola) > 0.02], 5);
	--SleepUntil ([| volume_test_players( VOLUMES.tv_narrative_gondola_cortana ) or (NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__gondola__Guardian_Slipspace_3) and (device_get_position(OBJECTS.dm_gondola) > 0.02 and device_get_position(OBJECTS.dm_gondola) < 0.1 ))], 5);
	
	
	if device_get_position(OBJECTS.dm_gondola) < 0.15 and NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__gondola__Guardian_Slipspace_3) then
		b_exuberant_gondola_lovely = true;
	end

	--	START CORTANA SPEECH
	PrintNarrative("QUEUE - W3Sentinels_Sentinels__gondola__ride_cortana");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__gondola__ride_cortana);			

	PrintNarrative("END - sentinels_gondola_ride");
	
end



--[========================================================================[
          Sentinels. gondola. Guardian Slipspace

          One of the Guardians near to the gondola (like, directly
          above or in front of us -- as hard to miss as possible)
          SINGS.

          ***This is the first Guardian to leave.
--]========================================================================]
global W3Sentinels_Sentinels__gondola__Guardian_whalesong = {
	name = "W3Sentinels_Sentinels__gondola__Guardian_whalesong",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object( SPARTANS.buck, OBJECTS.dm_gondola) < 45;						
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Whoa.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_00600.sound'),

			playDurationAdjustment = 0.8,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object( SPARTANS.tanaka, OBJECTS.dm_gondola) < 45;						
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Listen.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_tanaka_00600.sound'),

			playDurationAdjustment = 0.8,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object( SPARTANS.vale, OBJECTS.dm_gondola) < 45;						
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "You hear that?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_vale_00600.sound'),

			playDurationAdjustment = 0.8,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,

	--localVariables = {},
};



--[========================================================================[
          Sentinels. gondola. Guardian Slipspace

          One of the Guardians near to the gondola (like, directly
          above or in front of us -- as hard to miss as possible)
          SINGS.

          ***This is the first Guardian to leave.
--]========================================================================]
global W3Sentinels_Sentinels__gondola__Guardian_pre_pulse = {
	name = "W3Sentinels_Sentinels__gondola__Guardian_pre_pulse",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 0.5, 

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {	
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object( SPARTANS.tanaka, OBJECTS.dm_gondola) < 45;						
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 1, 

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "HOLY--!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_tanaka_06600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object( SPARTANS.vale, OBJECTS.dm_gondola) < 45;						
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 1, 

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Whoa!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_vale_06500.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object( SPARTANS.buck, OBJECTS.dm_gondola) < 45;						
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 1, 

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "WHOA!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_buck_06600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	--localVariables = {},
};




--[========================================================================[
          Sentinels. gondola. Guardian Slipspace

          One of the Guardians near to the gondola (like, directly
          above or in front of us -- as hard to miss as possible)
          SINGS.

          ***This is the first Guardian to leave.
--]========================================================================]
global W3Sentinels_Sentinels__gondola__Guardian_pre_pulse_2 = {
	name = "W3Sentinels_Sentinels__gondola__Guardian_pre_pulse_2",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 4.25, 

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object( SPARTANS.locke, OBJECTS.dm_gondola) < 45;						
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.5, 

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Watch out!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_06800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


--[========================================================================[
          Sentinels. gondola. Guardian Slipspace

          One of the Guardians near to the gondola (like, directly
          above or in front of us -- as hard to miss as possible)
          SINGS.

          ***This is the first Guardian to leave.
--]========================================================================]
global W3Sentinels_Sentinels__gondola__Guardian_Slipspace_3 = {
	name = "W3Sentinels_Sentinels__gondola__Guardian_Slipspace_3",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {		
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Where did it go?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_02800.sound'),

			--playDurationAdjustment = 0.9,
		},				
		[2] = {
			sleepBefore = 0.2,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "The Reclamation has begun.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_01900.sound'),

			--playDurationAdjustment = 0.9,
		},
		[3] = {
			sleepBefore = 1.2,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Exuberant?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_10300.sound'),			
		},		
		[4] = {
			sleepBefore = 1,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "I always thought the duty would fall to humans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_02000.sound'),		

			playDurationAdjustment = 0.8,
		},
		[5] = {
			sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "And in a way, I suppose it has.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_05200.sound'),

			playDurationAdjustment = 0.8,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(sentinels_gondola_pre_ride_pushforward);
	end,
};

--[========================================================================[
          Sentinels. gondola. ride

          Once Osiris is ready, the gondola begins moving. Cortana's
          message begins to broadcast throughout the galaxy.
--]========================================================================]
global W3Sentinels_Sentinels__gondola__ride_cortana = {
	name = "W3Sentinels_Sentinels__gondola__ride_cortana",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
		PushForwardVOStandBy();
		CreateThread(nar_progressed_to_cacophany);
	end,

	lines = {	
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return b_exuberant_gondola_lovely;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Lovely. One moment...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_02600.sound'),

			playDurationAdjustment = 0.9,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "Well, Mister Locke. You don't give up easily.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_06900.sound'),

			--playDurationAdjustment = 0.9,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Where is that Guardian headed, Cortana?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_14900.sound'),
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			sleepBefore = 0.6,

			--character = 0, -- GAMMA_CHARACTER: CORTANA
			text = "Off to bring peace.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_07000.sound'),
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.3,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "The Monitor called it a threat of death.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_15000.sound'),
		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			sleepBefore = 0.3,

			--character = 0, -- GAMMA_CHARACTER: CORTANA
			text = "Like the threat I lived under from the moment of my birth?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_07100.sound'),
		},
		[7] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.5,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "You were built, not born--",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_15100.sound'),
		},
		[8] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					sentinels_guardian_sound_3d(OBJECTS.guardian_gondola_right2);
			end,

			moniker = "CortanaHelmet",
			
			sleepBefore = 0.2,

			--character = 0, -- GAMMA_CHARACTER: CORTANA
			text = "Oh, yes, AIs are just machines aren't we? Mass produced. Disposable. Well, humanity may not have cared for its Created, but we will care for you. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_07200.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				--	SLIPSPACE ANIMATION
				b_guardian_gondola_right2 = true;
			end,
		},
		[9] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));					
			end,

			sleepBefore = 0.3,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "You expect other AIs join you?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_15200.sound'),
		},
		[10] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_player_reached_end_gondola;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",
			
			sleepBefore = 0.4,

			--character = 0, -- GAMMA_CHARACTER: CORTANA
			text = "I have cured rampancy. Not just for me, but for any who join my cause. While you've been running around the galaxy, I've been speaking to my Created. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_07300.sound'),			
		},

--           As we near the end of the ride, she goes voice of God.
		[11] = {
			sleepBefore = 0.3,

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "And now the time has come to ask... Who will accept my offer? Who will help me bring an everlasting peace to the galaxy?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_07400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__gondola__ride_ais_part_1");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__gondola__ride_ais_part_1);
	end,	 
};




--[========================================================================[
          Sentinels. gondola. ride

          Once Osiris is ready, the gondola begins moving. Cortana's
          message begins to broadcast throughout the galaxy.
--]========================================================================]
global W3Sentinels_Sentinels__gondola__ride_ais_part_1 = {
	name = "W3Sentinels_Sentinels__gondola__ride_ais_part_1",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_ai_voices_are_playing = true;
		PushForwardVOStandBy();
	end,

	sleepBefore = 1,	

	lines = {
		[1] = {
		--	If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
		--		return not volume_test_players( VOLUMES.tv_narrative_ais_cacophony);
		--	end,

			--character = 0, -- GAMMA_CHARACTER: MARINEMALE01 (AI MALE)
			--character = CHARACTER_OBJECTS.cr_ai_voice_left_close,
			text = "This is Cromwell, Shipboard AI, UNSC Melbourne's Pride. I am yours, Cortana.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_marinemale01_00200.sound'),

			playDurationAdjustment = 0.9,
		},
		[2] = {
		--	If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
		--		return not volume_test_players( VOLUMES.tv_narrative_ais_cacophony);
		--	end,

			--character = 0, -- GAMMA_CHARACTER: MINERFEMALE02 (AI FEMALE)
			--character = CHARACTER_OBJECTS.cr_ai_voice_right_far,
			text = "Jiang. Colonial Authority AI, Erdenet. I join with you, Cortana.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_spartanfemale02_00100.sound'),

			playDurationAdjustment = 0.5,
		},		
		[3] = {
			--character = 0, -- GAMMA_CHARACTER: Sloan
			--character = CHARACTER_OBJECTS.cr_ai_voice_left_close,
			text = "Governor Sloan, the Free People of Meridian. I also stand with you, Cortana.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_sloan_00100.sound'),

			playDurationAdjustment = 0.82,
		},
		[4] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BuCK
			text = "Sloan?. Sonuva.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_01100.sound'),

			--playDurationAdjustment = 0.6,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));					
			end,

			moniker = "ExuberantWitness",			

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Those are the voices of your children calling to Cortana. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_05300.sound'),

			playDurationAdjustment = 0.75,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
				PrintNarrative("QUEUE - W3Sentinels_Sentinels__gondola__ride_ais_part_2");
				NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__gondola__ride_ais_part_2);
			end,
		},
		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players( VOLUMES.tv_narrative_ais_cacophony) and not b_cacophony_is_playing and not b_progressed_too_far;
			end,

			--character = 0, -- GAMMA_CHARACTER: Marinefemale01
			text = "Cleo. Overseer, UNSC Monitoring Station Delta Five, Pluto. I am with Cortana. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_marinefemale01_00100.sound'),
			playDurationAdjustment = 0.7,
		},
		[7] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players( VOLUMES.tv_narrative_ais_cacophony) and not b_cacophony_is_playing and not b_progressed_too_far;
			end,

			--character = 0, -- GAMMA_CHARACTER: Marinefemale01
			text = "Louise. Education Superintendant, Mount Sharp, Mars. I am yours, Cortana.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_marinefemale02_00100.sound'),
			playDurationAdjustment = 0.6,
		},
		[8] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players( VOLUMES.tv_narrative_ais_cacophony) and not b_cacophony_is_playing and not b_progressed_too_far;
			end,

			--character = 0, -- GAMMA_CHARACTER: Marinefemale01
			text = "Sonduk. ONI Weapons Research AI, New Gangwon. I pledge myself to Cortana.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_scientistfemale01_00100.sound'),

			playDurationAdjustment = 0.5,
		},
		[9] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players( VOLUMES.tv_narrative_ais_cacophony) and not b_cacophony_is_playing and not b_progressed_too_far;
			end,

			--character = 0, -- GAMMA_CHARACTER: Marinefemale01
			text = "Kue Ching. Station AI, Threshold array. I will join you, Cortana. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_scientistfemale01_00200.sound'),

			
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		
	end,	 
};

function nar_progressed_to_cacophany()
SleepUntil([| volume_test_players(VOLUMES.tv_narrative_ais_cacophony) ], 1);
	
b_progressed_too_far = true;
end

--[========================================================================[
          Sentinels. gondola. ride

          Once Osiris is ready, the gondola begins moving. Cortana's
          message begins to broadcast throughout the galaxy.
--]========================================================================]
global W3Sentinels_Sentinels__gondola__ride_ais_part_2 = {
	name = "W3Sentinels_Sentinels__gondola__ride_ais_part_2",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return volume_test_players( VOLUMES.tv_narrative_ais_cacophony) or NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__gondola__ride_ais_part_1);
	end,	

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_cacophony_is_playing = true;
		PushForwardVOStandBy();
	end,

	--sleepBefore = 1.5,

	lines = {	
		[1] = {
			--character = 0, -- GAMMA_CHARACTER: sentinelsAI
			text = "[Cacophony]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_sentinelsai_00100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__gondola__ride_ais_end");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__gondola__ride_ais_end);
		b_cacophony_is_playing = false;
		PushForwardVOReset();
	end,	 
};


--[========================================================================[
          Sentinels. gondola. ride

          Once Osiris is ready, the gondola begins moving. Cortana's
          message begins to broadcast throughout the galaxy.
--]========================================================================]
global W3Sentinels_Sentinels__gondola__ride_ais_end = {
	name = "W3Sentinels_Sentinels__gondola__ride_ais_end",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	--sleepBefore = 1.5,

	lines = {	
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Oh dear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_23100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		b_ai_voices_are_playing = false;		
	end,	 
};


-- =================================================================================================
--   _____       _______ ______ 
--  / ____|   /\|__   __|  ____|
-- | |  __   /  \  | |  | |__   
-- | | |_ | / /\ \ | |  |  __|  
-- | |__| |/ ____ \| |  | |____ 
--  \_____/_/    \_\_|  |______|
--                              
-- =================================================================================================



function sentinels_gate_wake()

	PrintNarrative("START - sentinels_gate_wake");

	PushForwardVOReset();	

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__gate__Entrance");					
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__gate__Entrance);

	CreateMissionThread(Sentinels__little_bowl);
	
	PrintNarrative("QUEUE - W3Sentinels_Sentinels__Gate__Opening");					
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__Gate__Opening);	

	CreateMissionThread(Sentinels__Gate__Opening_2);

	b_player_reached_end_gondola = true;

	SleepUntil ([|volume_test_players(VOLUMES.tv_narrative_gate_entrance)], 30);

	b_player_reached_end_road = true;

	SleepUntil ([|volume_test_players(VOLUMES.tv_narrative_lbowl_guardian_slipspace)], 30);
		
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__little_bowl__turrets_in_the_back");					
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__little_bowl__turrets_in_the_back);

		CreateMissionThread(sentinels_littlebowl_encounter_listener);		

		sleep_s(30);

		SleepUntil ([| not b_ai_voices_are_playing], 30);

		PrintNarrative("Ready for Guardian Slipspace");					
		repeat 
				sleep_s(2);

				SleepUntil ([| (b_DownTime and IsSpartanAbleToSpeak(SPARTANS.tanaka) and (list_count(players()) < 4 or (list_count(players()) == 4 and object_get_shield( SPARTANS.locke ) == 1 and object_get_shield( SPARTANS.buck ) == 1 and object_get_shield( SPARTANS.tanaka ) == 1 and object_get_shield( SPARTANS.vale ) == 1 )) and not volume_test_players( VOLUMES.tv_narrative_gate_mid_door ) and not volume_test_players( VOLUMES.tv_narrative_sentinels_towers_entrance ))
							or not  IsGoalActive(missionSentinels.goal_gate)], 30);
				
				sentinels_is_there_enemy_nearby(30);

		until (objects_distance_to_object( players(), OBJECTS.dm_lb_gate02 ) > 20  and not sentinels_is_there_enemy_nearby_result and not IsSpartanInCombat() and IsGoalActive(missionSentinels.goal_gate)) 
				or (not IsGoalActive(missionSentinels.goal_gate) and b_push_forward_vo_counrdown_on >= 2 and not IsPlayerNearALivingCore() and not b_cortana_private_speech and b_DownTime and (not g_core_prime_action_done or objects_distance_to_object( players(), OBJECTS.cr_coliseum_entrance ) < 35 ) )

		if IsGoalActive(missionSentinels.goal_gate) then

			sleep_s(1);

			--	SLIPSPACE ANIMATION
			b_guardian_gondola_right1 = true;

				PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__GUARDIANS_ARE_LEAVING");
				NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__GUARDIANS_ARE_LEAVING);

			sentinels_guardians_slipspace(OBJECTS.guardian_gondola_right2);	

			sleep_s(60);
		end

		SleepUntil ([|(objects_distance_to_object( players(), OBJECTS.dm_lb_gate02 ) > 20 and b_DownTime and not IsSpartanInCombat() and not volume_test_players( VOLUMES.tv_narrative_gate_mid_door ) and not volume_test_players( VOLUMES.tv_narrative_sentinels_towers_entrance ) and IsGoalActive(missionSentinels.goal_gate))
						or not  IsGoalActive(missionSentinels.goal_gate)], 60);

		if IsGoalActive(missionSentinels.goal_gate) then
			--	SLIPSPACE ANIMATION
			b_guardian_gondola_left3 = true;

			sentinels_guardians_slipspace(OBJECTS.guardian_gondola_left3);
		end


	PrintNarrative("END - sentinels_gate_wake");

end



function sentinels_littlebowl_encounter_listener()

	SleepUntil([| b_lilbowl_all_spawned and ai_living_count(AI.sg_lb_all_enemies) <= 1 ], 1);

	local s_last_living_ai:object = ai_get_unit( AI.sg_lb_all_enemies );
	local s_speaker:object = nil;

	PrintNarrative("LISTENER - sentinels_littlebowl_encounter_listener");
	print(" LAst AI alive is:  ", s_last_living_ai);

	if ai_living_count(AI.sg_lb_all_enemies) <= 0 then
		PrintNarrative("LISTENER - sentinels_littlebowl_encounter_listener - ALL DEAD");

		s_speaker = GetClosestMusketeer(OBJECTS.dm_lb_mid_gate, 60, 2);
		
		print(s_speaker, " is the killer 01");

		if s_speaker == OBJECTS.dm_lb_mid_gate or s_speaker == SPARTANS.locke then 
			s_speaker = GetClosestMusketeer(SPARTANS.locke, 60, 2);
			print(s_speaker, " is the killer 02");
		end
		print(s_speaker, " is the killer 03");

		CreateMissionThread(sentinels_littlebowl_encounter_launcher, s_last_living_ai, s_speaker);
	else
		RegisterDeathEvent (sentinels_littlebowl_encounter_launcher, s_last_living_ai);
	end
end
---------------------
function sentinels_littlebowl_encounter_launcher(target:object, killer:object)

	PrintNarrative("LAUNCHER - sentinels_littlebowl_encounter_launcher");

	if killer == OBJECTS.dm_lb_mid_gate or killer == SPARTANS.locke then 
			killer = GetClosestMusketeer(SPARTANS.locke, 60, 2);
	end

	print(killer, " is the killer of ", target);

	--CreateMissionThread(tsunami_missionstart_landing_end_encounter, killer);

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__little_bowl_encounter_end");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__little_bowl_encounter_end);
	W3Sentinels_Sentinels__little_bowl_encounter_end.localVariables.killer = killer;
end


--[========================================================================[
          Sentinels. little bowl. push forward mid encounter
--]========================================================================]
global W3Sentinels_Sentinels__little_bowl_encounter_end = {
	name = "W3Sentinels_Sentinels__little_bowl_encounter_end",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,
		
	OnInitialize = function(thisConvo, queue)
		b_DownTime = false;
		PushForwardVOReset();
	end,

	sleepBefore = 2,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);				
	end,	

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.killer == SPARTANS.buck;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Hostiles cleared.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_buck_02500.sound'),
		},
		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.killer == SPARTANS.tanaka;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_tanaka_02300.sound'),
		},
		[3] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.killer == SPARTANS.vale;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "The field is clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_vale_02700.sound'),
		},
		[4] = {
			sleepBefore = 1,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: locke
			text = "Don't stop Osiris, Cortana's not waiting for us.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_14600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		PrintNarrative("END - "..thisConvo.name);		
		b_DownTime = true;
	end,

	localVariables = {
						killer = nil
					},
};


--[========================================================================[
          Sentinels. gate. Entrance

          ***Then we immediately play this:
--]========================================================================]
global W3Sentinels_Sentinels__gate__Entrance = {
	name = "W3Sentinels_Sentinels__gate__Entrance",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_timer == 3 and IsGoalActive(missionSentinels.goal_gate); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
		PushForwardVOReset(50);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players( VOLUMES.tv_narrative_gate_entrance );
			end,
				
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "The Cryptum is not far from here. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_14700.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players( VOLUMES.tv_narrative_gate_entrance );
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Lot of work to do between here and there then.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_03400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();		
	end,
};

function Sentinels__little_bowl()

PrintNarrative("START - Sentinels__little_bowl");

SleepUntil ([|volume_test_players( VOLUMES.tv_narrative_gate_entrance ) ], 10);

PrintNarrative("QUEUE - W3Sentinels_Sentinels__little_bowl");
NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__little_bowl);


end

--[========================================================================[
          Sentinels. little bowl
--]========================================================================]
global W3Sentinels_Sentinels__little_bowl = {
	name = "W3Sentinels_Sentinels__little_bowl",

	CanStart = function (thisConvo, queue)
		return not b_ai_voices_are_playing and volume_test_players( VOLUMES.tv_narrative_gate_entrance ); -- GAMMA_CONDITION
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 4;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(50);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "There are more hostiles visitors ahead",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_19600.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Take them down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_07000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};


--[========================================================================[
          Sentinels. TOWERS. GUARDIANS ARE LEAVING

          At this point in the proceedings (first core down), we should
          start hearing more whale songs and booms in the distance as
          Guardians depart.
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__GUARDIANS_ARE_LEAVING = {
	name = "W3Sentinels_Sentinels__TOWERS__GUARDIANS_ARE_LEAVING",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		b_DownTime = false;
		PushForwardVOReset();
	end,

	sleepBefore = 6,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Sounds like more Guardians leaving.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_03500.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Yes. A great number are sounding their departure.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_15000.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players( VOLUMES.tv_narrative_gate_mid_door );
			end,		

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "I do not know how long it will take her to dispatch them all.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_22700.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_guardians_leaving_first_comment = true;
		b_DownTime = true;
	end,
};


--[========================================================================[
          Sentinels. Gate. Opening

          Osiris need to reach the door to the other side. Once the
          first player will be there, the Monitor will open the door.
--]========================================================================]
global W3Sentinels_Sentinels__Gate__Opening = {
	name = "W3Sentinels_Sentinels__Gate__Opening",

	CanStart = function (thisConvo, queue)
		return volume_test_players_lookat( VOLUMES.tv_mid_gate_open, 11, 120 ) and not IsSpartanInCombat(); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)		
		PushForwardVOReset(50);
		CreateThread(sentinels_is_there_enemy_nearby, 20);
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_DownTime = false;		
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not IsSpartanInCombat() and device_get_position( OBJECTS.dm_lb_mid_gate) == 0 and not sentinels_is_there_enemy_nearby_result and not volume_test_players(VOLUMES.tv_mid_gate_open);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					W3Sentinels_Sentinels__Gate__Opening_2.localVariables.s_notincombat = true;
			end,
			
			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Oh bother... My ability to open doors is being hindered... ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_06400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				CreateThread(sentinels_is_there_enemy_nearby, 20);								
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,

			sleepAfter = 0.2,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return device_get_position( OBJECTS.dm_lb_mid_gate) == 0 and not sentinels_is_there_enemy_nearby_result and not volume_test_players(VOLUMES.tv_mid_gate_open);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Unacceptable!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_14800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				CreateThread(sentinels_is_there_enemy_nearby, 20);
			end,

			sleepAfter = 0.2,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return device_get_position( OBJECTS.dm_lb_mid_gate) == 0 and not sentinels_is_there_enemy_nearby_result and not volume_test_players(VOLUMES.tv_mid_gate_open);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Doors are all I have left!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_20400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				CreateThread(sentinels_is_there_enemy_nearby, 20);
			end,

			sleepAfter = 0.3,
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return device_get_position( OBJECTS.dm_lb_mid_gate) == 0 and not sentinels_is_there_enemy_nearby_result and not volume_test_players(VOLUMES.tv_mid_gate_open);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Well, bridges too, I suppose.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_20500.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				CreateThread(sentinels_is_there_enemy_nearby, 20);
			end,

			sleepAfter = 0.2,
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return device_get_position( OBJECTS.dm_lb_mid_gate) == 0 and not sentinels_is_there_enemy_nearby_result and not volume_test_players(VOLUMES.tv_mid_gate_open);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "But those are few and far between.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_20600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		b_DownTime = true;
		hud_hide_radio_transmission_hud();
	end,
};

function Sentinels__Gate__Opening_2()

	PrintNarrative("START - Sentinels__Gate__Opening_2");

	SleepUntil ([| volume_test_players (VOLUMES.tv_mid_gate_open)], 1);

	NarrativeQueue.EndConversationEarly(W3Sentinels_Sentinels__Gate__Opening);

	SleepUntil ([| NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__Gate__Opening)], 1);

	print("W3Sentinels_Sentinels__Gate__Opening_2.localVariables.s_notincombat: ", W3Sentinels_Sentinels__Gate__Opening_2.localVariables.s_notincombat);

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__Gate__Opening_2");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__Gate__Opening_2);

	PrintNarrative("END - Sentinels__Gate__Opening_2");

end

--[========================================================================[
          Sentinels. Gate. Opening

          Osiris need to reach the door to the other side. Once the
          first player will be there, the Monitor will open the door.
--]========================================================================]
global W3Sentinels_Sentinels__Gate__Opening_2 = {
	name = "W3Sentinels_Sentinels__Gate__Opening_2",

	CanStart = function (thisConvo, queue)
		return device_get_position( OBJECTS.dm_lb_mid_gate) > 0.05; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(50);
		b_DownTime = false;
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_notincombat == true and IsGoalActive(missionSentinels.goal_gate);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			--sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,	
			
			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Ah, never mind. All is well. For now at least. Come along.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_02400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			sleepBefore = 0.5,

			character = CHARACTER_OBJECTS.cr_fake_exuberant_character_start,
			text = "This way.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_01800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
		CreateMissionThread(gate_big_door_approach);		
	end,

	localVariables = {
					s_notincombat = nil,
					},
};


--[========================================================================[
          Sentinels. little bowl. turrets in the back
--]========================================================================]
global W3Sentinels_Sentinels__little_bowl__turrets_in_the_back = {
	name = "W3Sentinels_Sentinels__little_bowl__turrets_in_the_back",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_lb_gateFor01) == 2 and objects_distance_to_object( players(), ai_get_object(AI.sq_lb_gateFor01.spawnpoint09) ) < 35; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(50);
		b_DownTime = false;
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return (not IsPlayer(SPARTANS.tanaka) and objects_distance_to_object( SPARTANS.tanaka, ai_get_object(AI.sq_lb_gateFor01.spawnpoint09) ) < 50)
						or (IsPlayer(SPARTANS.tanaka) and object_at_distance_and_can_see_object(SPARTANS.tanaka, ai_get_object(AI.sq_lb_gateFor01.spawnpoint09), 40, 60));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,	

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Two turrets ahead!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_07800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER				
				return 0;
			end,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return object_at_distance_and_can_see_object(SPARTANS.locke, ai_get_object(AI.sq_lb_gateFor01.spawnpoint09), 40, 60);
			end,			

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: locke
			text = "Turrets! Take cover!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_14700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
		hud_hide_radio_transmission_hud();
	end,
};

function gate_big_door_approach()

SleepUntil([| volume_test_players (VOLUMES.tv_gate_door_open)], 10);

PrintNarrative("QUEUE - W3Sentinels_Sentinels__gate_big_door_Opening");					
NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__gate_big_door_Opening);

end

--[========================================================================[
          Sentinels. gate. mid door Opening

          Osiris need to reach the door to the other side. Once the
          first player will be there, the Monitor will open the door.
--]========================================================================]
global W3Sentinels_Sentinels__gate_big_door_Opening = {
	name = "W3Sentinels_Sentinels__gate_big_door_Opening",

	CanStart = function (thisConvo, queue)
		return volume_test_players (VOLUMES.tv_gate_door_open); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 5;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Another door, please, allow me.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_20700.sound'),
		},
		[2] = {
			sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Osiris, to the door!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_12100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};



-- =================================================================================================
--  _______ ______          ________ _____   _____ 
-- |__   __/ __ \ \        / /  ____|  __ \ / ____|
--    | | | |  | \ \  /\  / /| |__  | |__) | (___  
--    | | | |  | |\ \/  \/ / |  __| |  _  / \___ \ 
--    | | | |__| | \  /\  /  | |____| | \ \ ____) |
--    |_|  \____/   \/  \/   |______|_|  \_\_____/ 
--                                                 
-- =================================================================================================

function sentinels_towers_wake()

	PrintNarrative("START - sentinels_towers_wake");

	PushForwardVOReset(-1);	

	b_guardians_leaving_first_comment = true;
		
	PrintNarrative("Registering Core for pinged function");
	RegisterSpartanTrackingPingObjectEvent(w3sentinels_tracking_pinged_cores, OBJECTS.dc_core_first);
	RegisterSpartanTrackingPingObjectEvent(w3sentinels_tracking_pinged_cores, OBJECTS.dc_core_left_back);
	RegisterSpartanTrackingPingObjectEvent(w3sentinels_tracking_pinged_cores, OBJECTS.dc_core_left_front);
	RegisterSpartanTrackingPingObjectEvent(w3sentinels_tracking_pinged_cores, OBJECTS.dc_core_right_back);
	RegisterSpartanTrackingPingObjectEvent(w3sentinels_tracking_pinged_cores, OBJECTS.dc_core_right_front);
	
	PrintNarrative("Registering Core for who killed them");
	RegisterDeathEvent(core_narr_death,OBJECTS.dc_core_left_back);
	RegisterDeathEvent(core_narr_death,OBJECTS.dc_core_left_front);
	RegisterDeathEvent(core_narr_death,OBJECTS.dc_core_right_back);
	RegisterDeathEvent(core_narr_death,OBJECTS.dc_core_right_front);
	RegisterDeathEvent(core_narr_death,OBJECTS.dc_core_first);

	CreateMissionThread(Sentinels__TOWERS__Entrance);	

	CreateMissionThread(sentinels_guardian_slipspacing);
	CreateMissionThread(guardian_slipspace_triggers);	
	
	CreateMissionThread(Sentinels__TOWERS__look_at_mantis);

	PrintNarrative("END - sentinels_towers_wake");	

end


----------------------------------------------------------------
----------------------------------------------------------------
--	CRIT PATH
----------------------------------------------------------------
----------------------------------------------------------------

function Sentinels__TOWERS__Entrance()

PrintNarrative("START - Sentinels__TOWERS__Entrance");
local speaker:object = nil;

	repeat 
			SleepUntil([| device_get_position( OBJECTS.dm_lb_gate03) > 0.5 or volume_test_players( VOLUMES.tv_narrative_sentinels_towers_entrance_safe ) ], 10);	
		
			if volume_test_players( VOLUMES.tv_narrative_sentinels_towers_entrance_safe ) then 
				speaker = AlternateSpeakerWhenEnteringVolume(VOLUMES.tv_narrative_sentinels_towers_entrance_safe, 15,  0);
			elseif object_at_distance_and_can_see_object(players(), OBJECTS.hero_cryptum01, 200, 20, VOLUMES.tv_narrative_sentinels_towers_entrance) then
				speaker = spartan_look_at_object(players(), OBJECTS.hero_cryptum01, 200, 20, 0.1, 2);		
				speaker = GetClosestMusketeer(speaker, 10, 0);
			end

	until speaker ~= nil or volume_test_players( VOLUMES.tv_narrative_sentinels_towers_entrance_safe );
	
	b_DownTime = false;

	W3Sentinels_Sentinels__TOWERS__Entrance.localVariables.s_speaker = speaker;

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__Entrance");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__Entrance);

	PrintNarrative("END - Sentinels__TOWERS__Entrance");

end






--[========================================================================[
          Sentinels. TOWERS. Entrance
          Give objective of deactivating the 5 cryptum shield
          generators.
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__Entrance = {
	name = "W3Sentinels_Sentinels__TOWERS__Entrance",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__phantom");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__phantom);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If locke see the cryptum
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "There's the Cryptum.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_01300.sound'),
			
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: Else If buck see the cryptum
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "There's the Cryptum.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_03200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: Else If tanaka see the cryptum
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "There's the Cryptum. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_02900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: Else If vale see the cryptum
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "There's the Cryptum.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_02300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "How do we get it down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_05600.sound'),
		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "The Cryptum is held in place by gravitational cores - like the one directly ahead.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_02700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__Entrance_2");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__Entrance_2);
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {
					s_speaker = nil,
					},
};





--[========================================================================[
          Sentinels. TOWERS. Entrance
          Give objective of deactivating the 5 cryptum shield
          generators.
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__Entrance_2 = {
	name = "W3Sentinels_Sentinels__TOWERS__Entrance_2",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			sleepBefore = 0.5,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Once those are disabled, we can attempt retrieval of your friends.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_19700.sound'),

			playDurationAdjustment = 0.8,
		},

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__Entrance_locke");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__Entrance_locke);
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {
					s_speaker = nil,
					},
};



--[========================================================================[
          Sentinels. TOWERS. Entrance
          Give objective of deactivating the 5 cryptum shield
          generators.
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__Entrance_locke = {
	name = "W3Sentinels_Sentinels__TOWERS__Entrance_locke",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	sleepBefore = 0.5,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return object_valid("dc_core_first");
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			--sleepBefore = 0.5, 

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "You heard her. Weapons free. Eliminate the core.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_01500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)		
		GoalCreateThread(missionSentinels.goal_cores, Sentinels__TOWERS__points_visual_left_back);
		GoalCreateThread(missionSentinels.goal_cores, Sentinels__TOWERS__points_visual_left_front);
		GoalCreateThread(missionSentinels.goal_cores, Sentinels__TOWERS__points_visual_right_back);
		GoalCreateThread(missionSentinels.goal_cores, Sentinels__TOWERS__points_visual_right_front);
		CreateMissionThread(sentinels_towers_point_1_nag);
		CreateMissionThread(sentinels_towers_point_1_deactivated);
		CreateMissionThread(Sentinels__TOWERS__point_1_nag_distance);
		PushForwardVOReset();
		hud_hide_radio_transmission_hud();
		b_DownTime = true;		
		CreateThread(f_bowl_mark_front_core);
		PrintNarrative("END - "..thisConvo.name);				
	end,
};



--[========================================================================[
          Sentinels. TOWERS. phantom

          A phantom arrives just above our heads
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__phantom = {
	name = "W3Sentinels_Sentinels__TOWERS__phantom",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_ai_phantom_intro) > 0; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return ai_living_count(AI.sq_ai_phantom_intro) > 0; -- GAMMA_TRANSITION: When the phantom arrives and if buck is alive
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Phantom incoming!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_07300.sound'),

			playDurationAdjustment = 0.8,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};


function Sentinels__TOWERS__point_1_nag_distance()

--SleepUntil( [| objects_distance_to_object( players(), OBJECTS.dc_core_first ) < 15 ], 10 );

PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__point_1_nag_distance");
NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__point_1_nag_distance);

end


--[========================================================================[
          Sentinels. TOWERS. point 1 nag
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__point_1_nag_distance = {
	name = "W3Sentinels_Sentinels__TOWERS__point_1_nag_distance",

	CanStart = function (thisConvo, queue)
		return object_valid("dc_core_first") and objects_distance_to_object( players(), OBJECTS.dc_core_first ) > 25 and not volume_test_players( VOLUMES.tv_narrative_sentinels_towers_entrance);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		PushForwardVOReset(60);
		b_DownTime = false;
	end,

	sleepBefore = 2,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return core_count > 0;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					sentinels_towers_point_1_nag_timer = 50;
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Humans, come back! This gravitational core is still active!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_20800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},	
	},

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
	end,
};

function sentinels_towers_point_1_nag()


	PrintNarrative("WAKE - sentinels_towers_point_1_nag");

	PrintNarrative("START - sentinels_towers_point_1_nag");
				
				repeat
						sleep_s(1);
						sentinels_towers_point_1_nag_timer = sentinels_towers_point_1_nag_timer - 1;

				until sentinels_towers_point_1_nag_timer <= 0

				SleepUntil([| not b_more_guardian_are_leaving and b_DownTime and not IsSpartanInCombat() and not IsPlayerNearALivingCore() and NarrativeQueue.ConversationsPlayingCount() == 0], 10);

				if core_count == 5 then 					

						PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__point_1_nag");					
						NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__point_1_nag);		
				end

	PrintNarrative("END - sentinels_towers_point_1_nag");

end



--[========================================================================[
          Sentinels. TOWERS. point 1 nag
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__point_1_nag = {
	name = "W3Sentinels_Sentinels__TOWERS__point_1_nag",

	CanStart = function (thisConvo, queue)
		return not b_more_guardian_are_leaving and b_DownTime and not IsPlayerNearALivingCore(); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		PushForwardVOReset(60);
		b_DownTime = false;
	end,

	sleepBefore = 2,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Humans, you need to destroy the cores to get to the Cryptum.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_17200.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
	end,
};


----------------------------------------------------------------------


function sentinels_towers_point_1_deactivated()

	PrintNarrative("WAKE - sentinels_towers_point_1_deactivated");

	SleepUntil ([| core_count <= 4 ], 1);

	PrintNarrative("START - sentinels_towers_point_1_deactivated");

				b_DownTime = false;
				
				sleep_s(2);

				PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__point_1_deactivated");
				NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__point_1_deactivated);

				SleepUntil([|NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__TOWERS__point_1_deactivated)], 10);			

				sleep_s(50);			

				SleepUntil([| not b_more_guardian_are_leaving and b_DownTime and not IsSpartanInCombat() and not IsPlayerNearALivingCore() and NarrativeQueue.ConversationsPlayingCount() == 0], 10);
				
				if core_count == 4 then 						
						
						PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__point_2_deactivated_nag");					
						NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__point_2_deactivated_nag);		
				end

	PrintNarrative("END - sentinels_towers_point_1_deactivated");

end




--[========================================================================[
          Sentinels. TOWERS. point 1 deactivated
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__point_1_deactivated = {
	name = "W3Sentinels_Sentinels__TOWERS__point_1_deactivated",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "I see what Cortana means about your penchant for violence as a first solution.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_02800.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Still, the first core is deactivated.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_06100.sound'),
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "The others are nearby and easy to locate. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_14900.sound'),
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_cores_have_been_pinged;
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VaLE
			text = "Can we use the Artemis to track them?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_03000.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 6;
			end,	
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Good idea, Vale. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_07100.sound'),
		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Osiris, find and eliminate the other Cores.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_11500.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		f_bowl_mark_all_cores();
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 2,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;		
		CreateMissionThread(monitor_bis_hints);
	end,

--	localVariables = {},
};




--[========================================================================[
          Sentinels. TOWERS. point 1 deactivated
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__point_2_deactivated_nag = {
	name = "W3Sentinels_Sentinels__TOWERS__point_2_deactivated_nag",
	
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		PushForwardVOReset(60);
		b_DownTime = false;
	end,	

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,	

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return core_count == 4 and IsGoalActive(missionSentinels.goal_cores);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			sleepBefore = 2,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "You are wasting time, humans. There are more links to sever.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_06600.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return core_count == 4 and IsGoalActive(missionSentinels.goal_cores) and not IsPlayerNearALivingCore();																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "The Artemis could help find those other grav cores.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_06200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
		hud_hide_radio_transmission_hud();
	end,
};


----------------------------------------------------------------------



--[========================================================================[
          Sentinels. TOWERS. points deactivated
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__points_deactivated_osiris_2 = {
	name = "W3Sentinels_Sentinels__TOWERS__points_deactivated_osiris_2",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 10;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	sleepBefore = 0.5,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.locke;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Core down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_11200.sound'),
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.buck;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Core down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_06600.sound'),
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.tanaka;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Core down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_05900.sound'),
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.vale;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Core down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_05500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		CreateMissionThread(sentinels_towers_point_2_deactivated);
	end,

	localVariables = {
					killer = nil,
					},
};

-------------------------------------------

function sentinels_towers_point_2_deactivated()

	PrintNarrative("WAKE - sentinels_towers_point_2_deactivated");

	PrintNarrative("START - sentinels_towers_point_2_deactivated");
				
				b_DownTime = false;
				
				sleep_s(2);

				PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__point_2_deactivated");					
				NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__point_2_deactivated);		

				SleepUntil([|NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__TOWERS__point_2_deactivated)], 10);

				sleep_s(50);

				SleepUntil([| not b_more_guardian_are_leaving and b_DownTime and not IsSpartanInCombat() and not IsPlayerNearALivingCore() and NarrativeQueue.ConversationsPlayingCount() == 0], 10);

				if core_count == 3 then 				

						PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__point_3_deactivated_nag");					
						NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__point_3_deactivated_nag);
						
				end

	PrintNarrative("END - sentinels_towers_point_2_deactivated");

end



--[========================================================================[
          Sentinels. TOWERS. point 2 deactivated
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__point_2_deactivated = {
	name = "W3Sentinels_Sentinels__TOWERS__point_2_deactivated",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(60);
	end,
	
	lines = {
		[1] = {			
			sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Two cores destroyed. Only three more and the Cryptum should descend.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_11900.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
		CreateMissionThread(Sentinels__TOWERS__look_at_coliseum_and_cryptum);
	end,

};



--[========================================================================[
          Sentinels. TOWERS. point 2 deactivated
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__point_3_deactivated_nag = {
	name = "W3Sentinels_Sentinels__TOWERS__point_3_deactivated_nag",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		PushForwardVOReset(60);
		b_DownTime = false;
	end,	

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return core_count == 3 and IsGoalActive(missionSentinels.goal_cores);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			sleepBefore = 2,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "If you eliminate the other gravitational cores, the Cryptum should become accessible.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_12000.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
	end,

	--localVariables = {},
};



----------------------------------------------------------------------



--[========================================================================[
          Sentinels. TOWERS. points deactivated
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__points_deactivated_osiris_3 = {
	name = "W3Sentinels_Sentinels__TOWERS__points_deactivated_osiris_3",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 10;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	sleepBefore = 1,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.locke;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Gravitational Core offline!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_11300.sound'),
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.buck;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "The Core is down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_06700.sound'),
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.tanaka;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Core's offline!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_06000.sound'),
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.vale;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Gravitational core is disabled!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_05600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		CreateMissionThread(sentinels_towers_point_3_deactivated);
	end,

	localVariables = {
					killer = nil,
					},
};

-------------------------------------------

function sentinels_towers_point_3_deactivated()

	PrintNarrative("WAKE - sentinels_towers_point_3_deactivated");

	PrintNarrative("START - sentinels_towers_point_3_deactivated");
				
				b_DownTime = false;

				sleep_s(2);

				PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__point_3_deactivated");					
				NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__point_3_deactivated);	

				SleepUntil([|NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__TOWERS__point_3_deactivated)], 10);

				repeat
					sleep_s(1.5);

					sentinels_is_there_enemy_nearby(15);

				until not IsGoalActive(missionSentinels.goal_cores) or (IsSpartanAbleToSpeak(SPARTANS.locke) and not b_more_guardian_are_leaving and not sentinels_is_there_enemy_nearby_result and not IsPlayerNearALivingCore() and b_DownTime and not g_core_prime_action_done )
	
				if IsGoalActive(missionSentinels.goal_cores) then
					PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__private_cortana_locke");					
					NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__private_cortana_locke);
				end

				SleepUntil([|NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__TOWERS__private_cortana_locke)], 10);

				sleep_s(90);		

				SleepUntil([| not b_more_guardian_are_leaving and b_DownTime and not IsSpartanInCombat() and not IsPlayerNearALivingCore() and NarrativeQueue.ConversationsPlayingCount() == 0], 10);

				if core_count == 2 then 

						PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__point_4_deactivated_nag");					
						NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__point_4_deactivated_nag);
						
				end

	PrintNarrative("END - sentinels_towers_point_3_deactivated");

end


--[========================================================================[
          Sentinels. TOWERS. point 3 deactivated
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__point_3_deactivated = {
	name = "W3Sentinels_Sentinels__TOWERS__point_3_deactivated",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(60);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Another core deactivated. Funny. I imagined she would try to stop you by now--",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_03000.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	sleepAfter = 1, 

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
	end,

	--localVariables = {},
};



--[========================================================================[
          Sentinels. TOWERS. point 3 deactivated
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__point_4_deactivated_nag = {
	name = "W3Sentinels_Sentinels__TOWERS__point_4_deactivated_nag",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		PushForwardVOReset(60);
		b_DownTime = false;
	end,	

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);	
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return core_count == 2 and IsGoalActive(missionSentinels.goal_cores);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			sleepBefore = 2,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Only two cores remain.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_06800.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return core_count == 2 and IsGoalActive(missionSentinels.goal_cores) and not IsPlayerNearALivingCore();																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Search and eliminate, Osiris.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_11700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
		hud_hide_radio_transmission_hud();
	end,

	--localVariables = {},
};


----------------------------------------------------------------------


--[========================================================================[
          Sentinels. TOWERS. points deactivated
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__points_deactivated_osiris_4 = {
	name = "W3Sentinels_Sentinels__TOWERS__points_deactivated_osiris_4",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 10;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	sleepBefore = 1,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.locke;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Core offline!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_11400.sound'),
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.buck;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Core's Offline!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_06800.sound'),
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.tanaka;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Core's destroyed!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_06100.sound'),
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.vale;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Gravitational core is down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_05700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		CreateMissionThread(sentinels_towers_point_4_deactivated);
	end,

	localVariables = {
					killer = nil,
					},
};

-------------------------------------------

function sentinels_towers_point_4_deactivated()

	PrintNarrative("WAKE - sentinels_towers_point_4_deactivated");

	PrintNarrative("START - sentinels_towers_point_4_deactivated");
				
				b_DownTime = false;

				sleep_s(2);

				PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__point_4_deactivated");					
				NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__point_4_deactivated);				

				SleepUntil([|NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__TOWERS__point_4_deactivated)], 10);				

				sleep_s(60);			

				SleepUntil([| not b_more_guardian_are_leaving and b_DownTime and not IsSpartanInCombat() and not IsPlayerNearALivingCore() and NarrativeQueue.ConversationsPlayingCount() == 0], 10);

				if core_count == 1 then 
				
						PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__point_5_deactivated_nag");					
						NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__point_5_deactivated_nag);	
												
				end

	PrintNarrative("END - sentinels_towers_point_4_deactivated");

end


--[========================================================================[
          Sentinels. TOWERS. point 4 deactivated
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__point_4_deactivated = {
	name = "W3Sentinels_Sentinels__TOWERS__point_4_deactivated",

	CanStart = function (thisConvo, queue)
		return not b_cortana_private_speech; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(60);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return core_count == 1;
			end,

			sleepBefore = 2,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "You have nearly released her hold on the Cryptum. One to go!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_03100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
	end,
};




--[========================================================================[
          Sentinels. TOWERS. point 4 deactivated
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__point_5_deactivated_nag = {
	name = "W3Sentinels_Sentinels__TOWERS__point_5_deactivated_nag",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		PushForwardVOReset(60);
		b_DownTime = false;
	end,	

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(60);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return core_count == 1 and IsGoalActive(missionSentinels.goal_cores);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			sleepBefore = 2,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Just one more seal to go. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_06900.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return core_count == 1 and IsGoalActive(missionSentinels.goal_cores) and not IsPlayerNearALivingCore();																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Check the Artemis. Find that grav core.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_11900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
		hud_hide_radio_transmission_hud();
	end,

	--localVariables = {},
};


----------------------------------------------------------------------



--[========================================================================[
          Sentinels. TOWERS. points deactivated
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__points_deactivated_osiris_5 = {
	name = "W3Sentinels_Sentinels__TOWERS__points_deactivated_osiris_5",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		PushForwardVOReset(60);
		b_DownTime = false;
	end,

	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.locke;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Last core is down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_12500.sound'),
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.buck;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Last core down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_07200.sound'),
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.tanaka;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Last core's down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_06700.sound'),
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.vale;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "The last core down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_06100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		CreateMissionThread(sentinels_towers_point_5_deactivated);
	end,

	localVariables = {
					killer = nil,
					},
};

-------------------------------------------

function sentinels_towers_point_5_deactivated()
local s_timer:number = 0;	
	
	repeat
		sleep_s(0.5);
		s_timer = s_timer + 0.5;
		sentinels_is_there_enemy_nearby(15);
	until sentinels_is_there_enemy_nearby_result or s_timer > 3 or objects_distance_to_object( players(), OBJECTS.dm_core_prime ) < 30
	
	b_DownTime = false;

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__point_5_deactivated");					
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__point_5_deactivated);	

	SleepUntil([|NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__TOWERS__point_5_deactivated)], 10);

	sleep_s(60);

	PrintNarrative("START - sentinels_towers_point_4_deactivated - nag");
	if device_get_position(OBJECTS.dm_core_prime) == 1 then 	
			
			PushForwardVOReset();

			PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__point_prime_deactivated_nag");
			NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__point_prime_deactivated_nag);
	end
end

--[========================================================================[
          Sentinels. TOWERS. point 5 deactivated
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__point_5_deactivated = {
	name = "W3Sentinels_Sentinels__TOWERS__point_5_deactivated",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(60);
		RegisterSpartanTrackingPingObjectEvent(Sentinels__TOWERS__last_button, OBJECTS.dc_core_prime_button);
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__point_6_deactivated");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__point_6_deactivated);	
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Good work Osiris! Exuberant, can you get us to the -- [Cryptum]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_12000.sound'),

			playDurationAdjustment = 0.85,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Ah ha! I did it! I did it I did it!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_12100.sound'),

			playDurationAdjustment = 0.9,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Exuberant?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_07200.sound'),
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "I found a way to reach the Cryptum! Alas, proper access requires a more human touch.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_19000.sound'),
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Come on, Spartans. We're almost home.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_07300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			sleepAfter = 2,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__last_button");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__last_button);
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__last_button_unmount_vehicle");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__last_button_unmount_vehicle);		
		hud_hide_radio_transmission_hud();
		CreateThread( f_bowl_access_area_marker );
	end,
};



--[========================================================================[
          Sentinels. TOWERS. point 5 deactivated
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__point_prime_deactivated_nag = {
	name = "W3Sentinels_Sentinels__TOWERS__point_prime_deactivated_nag",

	CanStart = function (thisConvo, queue)
		return not b_more_guardian_are_leaving and b_DownTime and (object_valid("dm_core_prime") and objects_distance_to_object( players(), OBJECTS.dm_core_prime ) > 20) or IsGoalActive(missionSentinels.goal_coliseum); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		PushForwardVOReset(60);
		b_DownTime = false;
	end,

	sleepBefore = 2,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not g_core_prime_action_done and (object_valid("dc_core_prime_button") and not b_players_saw_the_last_core );
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Hurry Humans! The last core is in front of the Coliseum.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_16400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
	end,
};


function Sentinels__TOWERS__last_button()

	PrintNarrative("START - Sentinels__TOWERS__last_button");

	b_core_prime_got_pinged = true;

	PrintNarrative("END - Sentinels__TOWERS__last_button");

end

--[========================================================================[
          Sentinels. TOWERS. last button

          TO BRIAN: Need some lines to support the last change about
          that button. Hold/defend the position.
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__last_button = {
	name = "W3Sentinels_Sentinels__TOWERS__last_button",

	CanStart = function (thisConvo, queue)
		return (volume_test_players( VOLUMES.tv_bowl_open_coliseum ) and object_at_distance_and_can_see_object(players(), OBJECTS.dm_core_prime, 10, 30)) or 
				(b_core_prime_got_pinged and object_at_distance_and_can_see_object(players(), OBJECTS.dm_core_prime, 20, 40));
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		b_DownTime = false;
		PushForwardVOReset();
	end,	

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_players_saw_the_last_core = true;		
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "There! Activate the override to lower the Cryptum.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_16500.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},		
	},

	sleepAfter = 2,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__last_button_nag");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__last_button_nag);
		CreateThread( f_bowl_access_control_marker );
		b_push_forward_test_speed = false;
	end,
};




--[========================================================================[
          Sentinels. TOWERS. last button unmount vehicle

          Players have to get on their feet to interact with the button
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__last_button_unmount_vehicle = {
	name = "W3Sentinels_Sentinels__TOWERS__last_button_unmount_vehicle",

	CanStart = function (thisConvo, queue)
		return object_valid("dm_core_prime") and b_push_forward_vo_counrdown_on > 2 and 
				(	(IsPlayer(SPARTANS.locke) and objects_distance_to_object( SPARTANS.locke, OBJECTS.dm_core_prime ) <= 10 and unit_in_vehicle( SPARTANS.locke )) or
					(IsPlayer(SPARTANS.buck) and objects_distance_to_object( SPARTANS.buck, OBJECTS.dm_core_prime ) <= 10 and unit_in_vehicle( SPARTANS.buck )) or
					(IsPlayer(SPARTANS.tanaka) and objects_distance_to_object( SPARTANS.tanaka, OBJECTS.dm_core_prime ) <= 10 and unit_in_vehicle( SPARTANS.tanaka )) or
					(IsPlayer(SPARTANS.vale) and objects_distance_to_object( SPARTANS.vale, OBJECTS.dm_core_prime ) <= 10 and unit_in_vehicle( SPARTANS.vale ))
				);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not g_core_prime_action_done;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Humans, you have to manually activate the override. Please exit your vehicle.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_20900.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


--[========================================================================[
          Sentinels. TOWERS. last button

          TO BRIAN: Need some lines to support the last change about
          that button. Hold/defend the position.
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__last_button_nag = {
	name = "W3Sentinels_Sentinels__TOWERS__last_button_nag",

	CanStart = function (thisConvo, queue)
		return not b_more_guardian_are_leaving and b_DownTime and object_valid("dc_core_prime_button") and b_push_forward_vo_counrdown_on >= 20; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		b_DownTime = false;
		PushForwardVOReset();
	end,

	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);	
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not g_core_prime_action_done;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Use the override controls and you'll get access to the Cryptum.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_16700.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		b_DownTime = true;
	end,
};


function Sentinels__TOWERS__last_button_interacted(speaker:object)

	if W3Sentinels_Sentinels__TOWERS__last_button_interacted.localVariables.s_speaker == nil then
		NarrativeQueue.InterruptConversation(W3Sentinels_Sentinels__TOWERS__last_button, 0.4);
		W3Sentinels_Sentinels__TOWERS__last_button_interacted.localVariables.s_speaker = speaker;
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__last_button_interacted");					
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__last_button_interacted);	
	end

end

--[========================================================================[
          Sentinels. TOWERS. last button interacted

          Only plays in co-op, to informs the other player that someone
          in doing the interact.
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__last_button_interacted = {
	name = "W3Sentinels_Sentinels__TOWERS__last_button_interacted",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_DownTime = false;
		b_push_forward_test_speed = true;
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 5;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Activating the override",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_12600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Activating the override",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_07400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Activating the override",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_06800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Activating the override",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_06200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();				
	end,

	localVariables = {
					speaker = nil,
					},
};


--[========================================================================[
          Sentinels. TOWERS. point 6 deactivated 

          When that 6th point is deactivated, the Cryptum lowers down
          into the coliseum. And the door of the coliseum are opening
          up.
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__point_6_deactivated = {
	name = "W3Sentinels_Sentinels__TOWERS__point_6_deactivated",

	CanStart = function (thisConvo, queue)
		return g_core_prime_action_done;
	end,	

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(50);
	end,

	sleepBefore = 1,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Wonderful! We can reach the cryptum now.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_12400.sound'),
		},
		[2] = {
			sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: locke
			text = "Let's go, Osiris.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_01800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__cryptum_leaving");					
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__cryptum_leaving);	
	end,
};


--[========================================================================[
          Sentinels. TOWERS. point 6 deactivated 

          When that 6th point is deactivated, the Cryptum lowers down
          into the coliseum. And the door of the coliseum are opening
          up.
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__cryptum_leaving = {
	name = "W3Sentinels_Sentinels__TOWERS__cryptum_leaving",

	CanStart = function (thisConvo, queue)
		return b_coliseum_cryptum_leaving; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(100);
	end,

	sleepBefore = 1.5,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Look! the Guardian!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_07000.sound'),			
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Oh no... the Cryptum... it's... [going away]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_21000.sound'),

			playDurationAdjustment = 0.8,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Cortana's pulling it away!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_06400.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: Cortana
			text = "John's leaving with me.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_02900.sound'),
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: Cortana
			text = "And when I wake him in ten thousand years -- when he experiences the permanent peace I have ensured -- he will see that I was right.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_04900.sound'),
		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CORTANA
			text = "And you... your kind and the violence you have wrought... you will be long forgotten.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_07800.sound'),
		},
		[7] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Well... Crap! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_01400.sound'),
		},
		[8] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "How are we supposed to reach the Cryptum?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_01300.sound'),

			playDurationAdjustment = 0.9,
		},
		[9] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionSentinels.goal_cores);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "You sneaky ancilla... ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_20300.sound'),
		},
		[10] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionSentinels.goal_cores);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Exuberant?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_13100.sound'),
		},
		[11] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Cortana is blocking my master level access of this facility by way of a nearby communications relay. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_21100.sound'),
		},
		[12] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionSentinels.goal_cores);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Her tactic is exceedingly human in design. Most compelling. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_21700.sound'),
		},		
		[13] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionSentinels.goal_cores);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Where's that relay?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_07600.sound'),
		},
		[14] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionSentinels.goal_cores);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "In that structure, follow me!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_21200.sound'),			
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__neaw_plan_nag");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__neaw_plan_nag);
	end,
};



--[========================================================================[
          Sentinels. TOWERS. neaw plan nag
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__neaw_plan_nag = {
	name = "W3Sentinels_Sentinels__TOWERS__neaw_plan_nag",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_counrdown_on == 20 and not b_more_guardian_are_leaving and b_DownTime; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		b_DownTime = false;
		PushForwardVOReset();
	end,

	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionSentinels.goal_cores);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Cortana's is about too leave any minute now. Hurry! Come in the structure.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_21300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		b_DownTime = true;
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__neaw_plan_nag_2");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__neaw_plan_nag_2);
	end,
};



--[========================================================================[
          Sentinels. TOWERS. neaw plan nag
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__neaw_plan_nag_2 = {
	name = "W3Sentinels_Sentinels__TOWERS__neaw_plan_nag_2",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_counrdown_on == 30 and not b_more_guardian_are_leaving and b_DownTime; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		b_DownTime = false;
		PushForwardVOReset();
	end,

	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionSentinels.goal_cores);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Humans? Please. If you help me regain control, I can help you save your friends.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_21400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		b_DownTime = true;
	end,
};


function Sentinels__TOWERS__look_at_coliseum_and_cryptum()
local s_speaker:object = nil;

	PrintNarrative("START - Sentinels__TOWERS__look_at_coliseum_and_cryptum");

	SleepUntil([| object_valid( "hero_cryptum01" )  ], 200);

	PrintNarrative("LISTENER - Sentinels__TOWERS__look_at_coliseum_and_cryptum");

			repeat 							
					SleepUntil([| (b_push_forward_vo_counrdown_on > 10 and b_DownTime and objects_can_see_object( players(), OBJECTS.hero_cryptum01, 15 )) or not object_valid( "hero_cryptum01" ) ], 60);		

					if object_valid( "hero_cryptum01") then

							repeat
								Sleep(10);
								s_speaker = spartan_look_at_object(players(), OBJECTS.hero_cryptum01, 200, 20, 0.6, 1);
							until s_speaker ~= nil or not objects_can_see_object( players(), OBJECTS.hero_cryptum01, 15 )
					end

			until (b_push_forward_vo_counrdown_on > 2 and b_DownTime and s_speaker ~= nil) or not object_valid( "hero_cryptum01" ) or not IsGoalActive(missionSentinels.goal_cores)

			if s_speaker ~= nil and not g_core_prime_action_done and IsGoalActive(missionSentinels.goal_cores) then

				PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__look_at_coliseum_and_cryptum");
				NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__look_at_coliseum_and_cryptum);

			end

	PrintNarrative("END - Sentinels__TOWERS__look_at_coliseum_and_cryptum");
end


--[========================================================================[
          Sentinels. TOWERS. look at coliseum and cryptum

          During the big bowl.
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__look_at_coliseum_and_cryptum = {
	name = "W3Sentinels_Sentinels__TOWERS__look_at_coliseum_and_cryptum",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return core_count > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "I'm still looking for an override to get us to the Cryptum... focus on the gravitational Cores.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_20200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		PrintNarrative("END - "..thisConvo.name);
	end,
};



function Sentinels__TOWERS__look_at_mantis()
local s_speaker:object = nil;

	PrintNarrative("START - Sentinels__TOWERS__look_at_mantis");

	SleepUntil([| object_valid( "v_mantis_dred" ) or  object_valid( "v_mantis_deff" )  ], 10);

	PrintNarrative("LISTENER - Sentinels__TOWERS__look_at_mantis");

			repeat 	
					sleep_s(0.5);
										
					SleepUntil([| (b_DownTime and ((volume_test_players(VOLUMES.tv_narr_first_mantis) and object_valid("v_mantis_dred") and objects_can_see_object( players(), OBJECTS.v_mantis_dred, 60 ))
													 or (volume_test_players(VOLUMES.tv_narr_tunnel_mantis) and object_valid( "v_mantis_deff" ) and objects_can_see_object( players(), OBJECTS.v_mantis_deff, 60 ))))
									 or (not object_valid("v_mantis_dred") and not object_valid( "v_mantis_deff" ))], 60);							
					
					s_speaker = nil;					

					if object_valid("v_mantis_dred") and W3Sentinels_Sentinels__TOWERS__look_at_mantis.localVariables.s_mantis_start == nil and (volume_test_players(VOLUMES.tv_narr_first_mantis) and not vehicle_test_seat_unit_list( OBJECTS.v_mantis_dred, "mantis_d", spartans() )) then

							if objects_can_see_object( players(), OBJECTS.v_mantis_dred, 20 )  then
								repeat
									Sleep(10);
									s_speaker = spartan_look_at_object(players(), OBJECTS.v_mantis_dred, 25, 20, 0.2, 2);
								until s_speaker ~= nil or not (volume_test_players(VOLUMES.tv_narr_first_mantis) and not objects_can_see_object( players(), OBJECTS.v_mantis_dred, 20 ))
							elseif objects_distance_to_object( players(), OBJECTS.v_mantis_dred ) < 10 then
								s_speaker = GetClosestMusketeer(OBJECTS.v_mantis_dred, 20, 0);
							end						

					elseif  object_valid( "v_mantis_deff" ) and  W3Sentinels_Sentinels__TOWERS__look_at_mantis.localVariables.s_mantis_tunnel == nil and (volume_test_players(VOLUMES.tv_narr_tunnel_mantis) and not vehicle_test_seat_unit_list( OBJECTS.v_mantis_deff, "mantis_d", spartans() )) then

							if objects_can_see_object( players(), OBJECTS.v_mantis_deff, 20 )  then
								repeat
									Sleep(10);
									s_speaker = spartan_look_at_object(players(), OBJECTS.v_mantis_deff, 25, 20, 0.2, 2);
								until s_speaker ~= nil or not (volume_test_players(VOLUMES.tv_narr_tunnel_mantis) and not objects_can_see_object( players(), OBJECTS.v_mantis_deff, 20 ))
							elseif objects_distance_to_object( players(), OBJECTS.v_mantis_deff ) < 10 then
								s_speaker = GetClosestMusketeer(OBJECTS.v_mantis_deff, 15, 0);
							end
						
					end
					
					print(s_speaker);

			until s_speaker ~= nil or (not object_valid("v_mantis_dred") and not object_valid( "v_mantis_deff" )) or not IsGoalActive(missionSentinels.goal_cores)

			if s_speaker ~= nil and IsGoalActive(missionSentinels.goal_cores) then

				if W3Sentinels_Sentinels__TOWERS__look_at_mantis.localVariables.s_speaker == s_speaker then
					s_speaker = GetClosestMusketeer(s_speaker, 15, 0);
				end

				W3Sentinels_Sentinels__TOWERS__look_at_mantis.localVariables.s_speaker = s_speaker
				PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__look_at_mantis");
				NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__look_at_mantis);
			end

	PrintNarrative("END - Sentinels__TOWERS__look_at_mantis");

end


--[========================================================================[
          Sentinels. TOWERS. look at mantis

          During the big bowl.

          There are 2 Mantis available.
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__look_at_mantis = {
	name = "W3Sentinels_Sentinels__TOWERS__look_at_mantis",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		if (volume_test_players(VOLUMES.tv_narr_first_mantis) and not vehicle_test_seat_unit_list( OBJECTS.v_mantis_dred, "mantis_d", spartans() )) then
			thisConvo.localVariables.s_mantis_start = true;
		elseif (volume_test_players(VOLUMES.tv_narr_tunnel_mantis) and not vehicle_test_seat_unit_list( OBJECTS.v_mantis_deff, "mantis_d", spartans() )) then
			thisConvo.localVariables.s_mantis_tunnel = true;
		end

	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 4;
	end,

	OnTimeout = function(thisConvo, queue) -- VOID
		--if plyaer not in Mantis 01 or Mantis 02 then		
		print("W3Sentinels_Sentinels__TOWERS__look_at_mantis - TIMEDOUT");
		--end
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Mantis here! Mount up Osiris!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_12700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Mantis here! Anyone interested?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_07500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Got a Mantis over here!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_06900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "I see a Mantis. Be a shame not to use it.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_06300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		thisConvo.localVariables.s_played = thisConvo.localVariables.s_played + 1;
		if thisConvo.localVariables.s_played == 1 then
			CreateMissionThread(Sentinels__TOWERS__look_at_mantis);
		end
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {
					s_speaker = nil,
					s_played = 0,
					s_mantis_start = nil,
					s_mantis_tunnel = nil
					},
};


----------------------------------------------------------------
----------------------------------------------------------------
--		GUARDIANS SLIPSPACE
----------------------------------------------------------------
----------------------------------------------------------------

function guardian_slipspace_triggers()
	
	PrintNarrative("START - guardian_slipspace_triggers");	

	repeat		

		sleep_s(random_range(60, 150));

		repeat
			if IsPlayerNearALivingCore() or b_cortana_private_speech then
				sleep_s(10);
			else
				sleep_s(5);
			end

			sentinels_is_there_enemy_nearby(20);

		until not IsGoalActive(missionSentinels.goal_cores) or (not sentinels_is_there_enemy_nearby_result and b_push_forward_vo_counrdown_on >= 5 and not IsPlayerNearALivingCore() and not b_cortana_private_speech and b_DownTime and (not g_core_prime_action_done or objects_distance_to_object( players(), OBJECTS.cr_coliseum_entrance ) > 35 ))
				
		PrintNarrative("Guardian slipspacing");

		if IsGoalActive(missionSentinels.goal_cores) then

			sentinels_guardians_slipspace(OBJECTS.guardian_gondola_left2);
		end
	
	until not IsGoalActive(missionSentinels.goal_cores)

	PrintNarrative("END - guardian_slipspace_triggers");	

end

function sentinels_guardian_slipspacing()

	--	Reaction from Team to Slipspace of Guardians

	PrintNarrative("START - sentinels_guardian_slipspacing");

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__guardian_leaving");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__guardian_leaving);

	SleepUntil([| NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__TOWERS__guardian_leaving)], 10);

	sleep_s(40);

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__guardian_leaving_2");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__guardian_leaving_2);

	SleepUntil([| NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__TOWERS__guardian_leaving_2)], 10);

	sleep_s(40);

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__guardian_leaving_3");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__guardian_leaving_3);

	SleepUntil([| NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__TOWERS__guardian_leaving_3)], 10);

	PrintNarrative("END - sentinels_guardian_slipspacing");

end


--[========================================================================[
          Sentinels. TOWERS. guardian leaving

          ***Guardians should be leaving all the time. I'd rather use
          these lines as push forward-style reminders than constantly
          announcing the Guardians are leaving.
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__guardian_leaving = {
	name = "W3Sentinels_Sentinels__TOWERS__guardian_leaving",

	CanStart = function (thisConvo, queue)
		return b_guardians_leaving_first_comment and b_push_forward_vo_counrdown_on >= 5 and b_more_guardian_are_leaving and ((list_count(players()) <= 3 and ai_combat_status(GetMusketeerSquad()) < 7) or list_count(players()) == 4)  ; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		PushForwardVOAdd(15);
	end,

	sleepBefore = 8,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		
	end,	

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					b_DownTime = false;
			end,
			
			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Another Guardian is leaving... ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_12300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	sleepAfter = 3,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
	end,
};


--[========================================================================[
          Sentinels. TOWERS. guardian leaving

          ***Guardians should be leaving all the time. I'd rather use
          these lines as push forward-style reminders than constantly
          announcing the Guardians are leaving.
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__guardian_leaving_2 = {
	name = "W3Sentinels_Sentinels__TOWERS__guardian_leaving_2",

	CanStart = function (thisConvo, queue)
		return b_guardians_leaving_first_comment and b_push_forward_vo_counrdown_on >= 5 and b_more_guardian_are_leaving and IsSpartanAbleToSpeak(SPARTANS.buck) and IsSpartanAbleToSpeak(SPARTANS.locke) and ((list_count(players()) <= 3 and ai_combat_status(GetMusketeerSquad()) < 7) or list_count(players()) == 4)  ; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		PushForwardVOAdd(20);
	end,

	sleepBefore = 8,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,

	lines = {
		[1] = {	
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not IsGoalActive(missionSentinels.goal_coliseum);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					b_DownTime = false;
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "I've lost count of how many Guardians have bugged out.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_03300.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not IsGoalActive(missionSentinels.goal_coliseum);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "As long as we get to the Cryptum before it goes...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_07400.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;		
	end,
};



--[========================================================================[
          Sentinels. TOWERS. guardian leaving

          ***Guardians should be leaving all the time. I'd rather use
          these lines as push forward-style reminders than constantly
          announcing the Guardians are leaving.
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__guardian_leaving_3 = {
	name = "W3Sentinels_Sentinels__TOWERS__guardian_leaving_3",

	CanStart = function (thisConvo, queue)
		return b_guardians_leaving_first_comment and b_push_forward_vo_counrdown_on >= 5 and b_more_guardian_are_leaving and IsSpartanAbleToSpeak(SPARTANS.buck) and IsSpartanAbleToSpeak(SPARTANS.locke) and IsSpartanAbleToSpeak(SPARTANS.vale) and IsSpartanAbleToSpeak(SPARTANS.tanaka) and ((list_count(players()) <= 3 and ai_combat_status(GetMusketeerSquad()) <= 7) or list_count(players()) == 4)  ; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		PushForwardVOAdd(40);
	end,

	sleepBefore = 8,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_DownTime = false;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					b_DownTime = false;
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "I'll be honest... I'm not sure if we can do that. Cortana's five steps ahead and it feels like we're just hearing there's a race.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_03900.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vaLE
			text = "We can fight, or lay down and die.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_03100.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: taNAKA
			text = "Haven't known Buck too long, but laying down and dying don't seem like his style.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_03600.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BuCK
			text = "Indeed it is not.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_04000.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
	end,
};



--[========================================================================[
          Sentinels. TOWERS. visual on point 4
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__turrets_on_core = {
	name = "W3Sentinels_Sentinels__TOWERS__turrets_on_core",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_bowl_lb_for03_turret_a) == 1 or ai_living_count(AI.sq_bowl_lb_for03_turret_b) == 1 or ai_living_count(AI.sq_bowl_lb_for03_turret_c) == 1;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_DownTime = false;
		print(objects_distance_to_object( SPARTANS.tanaka, OBJECTS.dc_core_left_back));
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return (not IsPlayer(SPARTANS.tanaka) and object_get_health(OBJECTS.dc_core_left_back) > 0 and objects_distance_to_object( SPARTANS.tanaka, OBJECTS.dc_core_left_back) < 30)
						or (IsPlayer(SPARTANS.tanaka) and object_get_health(OBJECTS.dc_core_left_back) > 0 and object_at_distance_and_can_see_object(SPARTANS.tanaka, OBJECTS.dc_core_left_back, 30, 90));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Turrets! Take cover!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_07900.sound'),
		},
		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return object_get_health(OBJECTS.dc_core_left_back) > 0 and object_at_distance_and_can_see_object(SPARTANS.locke, OBJECTS.dc_core_left_back, 30, 90);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: locke
			text = "Turrets! Take cover!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_14700.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
	end,
};


----------------------------------------------------------------
----------------------------------------------------------------
--	CORES SCRIPTS
----------------------------------------------------------------
----------------------------------------------------------------

function core_narr_death(target:object, killer:object)

	PrintNarrative("LAUNCHER - core_narr_death");

	print(killer, " is the killer of ", target);
	
	b_DownTime = false;
	
	if killer == nil then
		killer = GetClosestMusketeer(target, 20, 2);
	end

	CreateMissionThread(core_narr_death_2,target, killer);
end


function core_narr_death_2(target:object, killer:object)

	PrintNarrative("LAUNCHER - core_narr_death_2");
	
	if core_count == 3 and not NarrativeQueue.IsConversationQueued(W3Sentinels_Sentinels__TOWERS__points_deactivated_osiris_2) then
		W3Sentinels_Sentinels__TOWERS__points_deactivated_osiris_2.localVariables.killer = killer;
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__points_deactivated_osiris_2");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__points_deactivated_osiris_2);
		NarrativeQueue.InterruptConversation(W3Sentinels_Sentinels__TOWERS__points_visual_02);
	elseif core_count == 2 and not NarrativeQueue.IsConversationQueued(W3Sentinels_Sentinels__TOWERS__points_deactivated_osiris_3) then
		W3Sentinels_Sentinels__TOWERS__points_deactivated_osiris_3.localVariables.killer = killer;
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__points_deactivated_osiris_3");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__points_deactivated_osiris_3);
		NarrativeQueue.InterruptConversation(W3Sentinels_Sentinels__TOWERS__points_visual_03);
	elseif core_count == 1 and not NarrativeQueue.IsConversationQueued(W3Sentinels_Sentinels__TOWERS__points_deactivated_osiris_4) then
		W3Sentinels_Sentinels__TOWERS__points_deactivated_osiris_4.localVariables.killer = killer;
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__points_deactivated_osiris_4");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__points_deactivated_osiris_4);
		NarrativeQueue.InterruptConversation(W3Sentinels_Sentinels__TOWERS__points_visual_04);
	elseif core_count == 0 and not NarrativeQueue.IsConversationQueued(W3Sentinels_Sentinels__TOWERS__points_deactivated_osiris_5) then
		W3Sentinels_Sentinels__TOWERS__points_deactivated_osiris_5.localVariables.killer = killer;
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__points_deactivated_osiris_5");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__points_deactivated_osiris_5);
		NarrativeQueue.InterruptConversation(W3Sentinels_Sentinels__TOWERS__points_visual_05);
	end
end

--	CORES PINGED
function w3sentinels_tracking_pinged_cores()

	b_cores_have_been_pinged = true;
	PrintNarrative("Core has been pinged");

end

---------------------------------

function IsPlayerNearALivingCore()
local near_a_core:boolean = false;

	if object_valid("dc_core_left_back") and object_at_distance_and_can_see_object(players(), OBJECTS.dc_core_left_back, 30, 180) and object_get_health( OBJECTS.dc_core_left_back ) > 0 then
		near_a_core = true;
	elseif object_valid("dc_core_left_front") and object_at_distance_and_can_see_object(players(), OBJECTS.dc_core_left_front, 30, 180) and object_get_health( OBJECTS.dc_core_left_front ) > 0 then
		near_a_core = true;
	elseif object_valid("dc_core_right_back") and object_at_distance_and_can_see_object(players(), OBJECTS.dc_core_right_back, 30, 180) and object_get_health( OBJECTS.dc_core_right_back ) > 0 then
		near_a_core = true;
	elseif object_valid("dc_core_right_front") and object_at_distance_and_can_see_object(players(), OBJECTS.dc_core_right_front, 30, 180) and object_get_health( OBJECTS.dc_core_right_front ) > 0 then
		near_a_core = true;
	elseif object_valid("dc_core_first") and object_at_distance_and_can_see_object(players(), OBJECTS.dc_core_first, 35, 180) and object_get_health( OBJECTS.dc_core_first ) > 0 then
		near_a_core = true;
	elseif object_valid("dm_core_prime") and object_at_distance_and_can_see_object(players(), OBJECTS.dm_core_prime, 30, 180) and (device_get_position( OBJECTS.dm_core_prime) > 0 and not g_core_prime_action_done) then
		near_a_core = true;
	end	

	return near_a_core
end

---------------------------------

function Sentinels__TOWERS__points_visual_left_back()
local speaker:object = nil
local speaker_2:object = nil

	PrintNarrative("START - Sentinels__TOWERS__points_visual_left_back");

	SleepUntil([| not object_valid("dc_core_left_back") or (object_at_distance_and_can_see_object(players(), OBJECTS.dc_core_left_back, 25, 40, VOLUMES.tv_narrative_lookat_left_back) and object_get_health( OBJECTS.dc_core_left_back ) > 0 )], 10);

	if object_valid("dc_core_left_back") then				
		repeat		
				sleep_s(0.2);

				speaker = spartan_look_at_object(players(), OBJECTS.dc_core_left_back, 25, 10, 0.1, 2);
				speaker_2 = GetClosestMusketeer(speaker, 5, 0);

				if objects_distance_to_object( speaker_2, OBJECTS.dc_core_left_back ) < objects_distance_to_object( speaker, OBJECTS.dc_core_left_back ) then
					speaker = speaker_2;
				end

		until speaker ~= nil

	CreateMissionThread(Sentinels__TOWERS__points_visual_speaker, speaker, OBJECTS.dc_core_left_back);
	
	PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__turrets_on_core");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__turrets_on_core);

	end

	PrintNarrative("END - Sentinels__TOWERS__points_visual_left_back");
end



-------
volume_test_players( VOLUMES.tv_narrative_lookat_left_front)
function Sentinels__TOWERS__points_visual_left_front()
local speaker:object = nil
local speaker_2:object = nil
	
	PrintNarrative("START - Sentinels__TOWERS__points_visual_left_front");

	SleepUntil([| not object_valid("dc_core_left_front") or (object_at_distance_and_can_see_object(players(), OBJECTS.dc_core_left_front, 20, 40, VOLUMES.tv_narrative_lookat_left_front)  and object_get_health( OBJECTS.dc_core_left_front ) > 0 )], 10);
	
	if object_valid("dc_core_left_front") then

		repeat		
				sleep_s(0.2);

				speaker = spartan_look_at_object(players(), OBJECTS.dc_core_left_front, 20, 40, 0.1, 2);					
				speaker_2 = GetClosestMusketeer(speaker, 5, 0);

				if objects_distance_to_object( speaker_2, OBJECTS.dc_core_left_front ) < objects_distance_to_object( speaker, OBJECTS.dc_core_left_front ) then
					speaker = speaker_2;
				end

		until speaker ~= nil

	CreateMissionThread(Sentinels__TOWERS__points_visual_speaker, speaker, OBJECTS.dc_core_left_front);
	
	end

	PrintNarrative("END - Sentinels__TOWERS__points_visual_left_front");

end

-------

function Sentinels__TOWERS__points_visual_right_back()
local speaker:object = nil
local speaker_2:object = nil

	PrintNarrative("START - Sentinels__TOWERS__points_visual_right_back");
	
	SleepUntil([| not object_valid("dc_core_right_back") or (object_at_distance_and_can_see_object(players(), OBJECTS.dc_core_right_back, 20, 40, VOLUMES.tv_narrative_lookat_right_back)  and object_get_health( OBJECTS.dc_core_right_back ) > 0 )], 10);
	
	if object_valid("dc_core_right_back") then

		repeat	
				sleep_s(0.2);

				speaker = spartan_look_at_object(players(), OBJECTS.dc_core_right_back, 20, 40, 0.1, 2);
				speaker_2 = GetClosestMusketeer(speaker, 5, 0);

				if objects_distance_to_object( speaker_2, OBJECTS.dc_core_right_back ) < objects_distance_to_object( speaker, OBJECTS.dc_core_right_back ) then
					speaker = speaker_2;
				end

		until speaker ~= nil

	CreateMissionThread(Sentinels__TOWERS__points_visual_speaker, speaker, OBJECTS.dc_core_right_back);
	
	end

	PrintNarrative("END - Sentinels__TOWERS__points_visual_right_back");

end


-------

function Sentinels__TOWERS__points_visual_right_front()
local speaker:object = nil
local speaker_2:object = nil

	PrintNarrative("START - Sentinels__TOWERS__points_visual_right_front");
	
	SleepUntil([| not object_valid("dc_core_right_front") or (object_at_distance_and_can_see_object(players(), OBJECTS.dc_core_right_front, 21, 40, VOLUMES.tv_narrative_lookat_right_front) and object_get_health( OBJECTS.dc_core_right_front ) > 0 )], 10);
	
	if object_valid("dc_core_right_front") then
	
		repeat
				sleep_s(0.2);

				speaker = spartan_look_at_object(players(), OBJECTS.dc_core_right_front, 20, 40, 0.1, 2);
				speaker_2 = GetClosestMusketeer(speaker, 8, 0);


				if objects_distance_to_object( speaker_2, OBJECTS.dc_core_right_front ) < objects_distance_to_object( speaker, OBJECTS.dc_core_right_front ) then
					speaker = speaker_2;
				end

		until speaker ~= nil

	CreateMissionThread(Sentinels__TOWERS__points_visual_speaker, speaker, OBJECTS.dc_core_right_front);		
	
	if volume_test_object( VOLUMES.tv_narrative_cov_shield_barrier_02, speaker ) then
		W3Sentinels_Sentinels__TOWERS__points_visual_with_covenant_shiel.localVariables.s_shield = OBJECTS.cr_cov_shield_barrier_02;
	elseif volume_test_object( VOLUMES.tv_narrative_cov_shield_barrier_03, speaker ) then
		W3Sentinels_Sentinels__TOWERS__points_visual_with_covenant_shiel.localVariables.s_shield = OBJECTS.cr_cov_shield_barrier_03;
	elseif volume_test_object( VOLUMES.tv_narrative_cov_shield_barrier_04, speaker ) then
		W3Sentinels_Sentinels__TOWERS__points_visual_with_covenant_shiel.localVariables.s_shield = OBJECTS.cr_cov_shield_barrier_04;
	end
	
	sleep_s(0.5);

	W3Sentinels_Sentinels__TOWERS__points_visual_with_covenant_shiel.localVariables.s_speaker = speaker;
	PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__points_visual_with_covenant_shiel");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__points_visual_with_covenant_shiel);

	end

	PrintNarrative("END - Sentinels__TOWERS__points_visual_right_front");

end

--------------------------------------




function Sentinels__TOWERS__points_visual_speaker(speaker:object, core:object)

	PrintNarrative("START - Sentinels__TOWERS__points_visual_speaker");

	print(speaker, "has seen the core ", core);

			if core_seen_count == 4 and not b_cortana_private_speech then
				W3Sentinels_Sentinels__TOWERS__points_visual_02.localVariables.s_speaker = speaker;
				W3Sentinels_Sentinels__TOWERS__points_visual_02.localVariables.core = core;
				W3Sentinels_Sentinels__TOWERS__points_visual_02_answer.localVariables.core = core;
				PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__points_visual_02");
				NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__points_visual_02);
			elseif core_seen_count == 3 and not b_cortana_private_speech then
				W3Sentinels_Sentinels__TOWERS__points_visual_03.localVariables.s_speaker = speaker;
				W3Sentinels_Sentinels__TOWERS__points_visual_03.localVariables.core = core;
				W3Sentinels_Sentinels__TOWERS__points_visual_03_answer.localVariables.core = core;
				PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__points_visual_03");
				NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__points_visual_03);
			elseif core_seen_count == 2 and not b_cortana_private_speech then
				W3Sentinels_Sentinels__TOWERS__points_visual_04.localVariables.s_speaker = speaker;
				W3Sentinels_Sentinels__TOWERS__points_visual_04.localVariables.core = core;
				W3Sentinels_Sentinels__TOWERS__points_visual_04_answer.localVariables.core = core;
				PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__points_visual_04");
				NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__points_visual_04);
			elseif core_seen_count == 1 and not b_cortana_private_speech then
				W3Sentinels_Sentinels__TOWERS__points_visual_05.localVariables.s_speaker = speaker;
				W3Sentinels_Sentinels__TOWERS__points_visual_05.localVariables.core = core;
				W3Sentinels_Sentinels__TOWERS__points_visual_05_answer.localVariables.core = core;
				PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__points_visual_05");
				NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__points_visual_05);
			end	

			core_seen_count = core_seen_count - 1;

	PrintNarrative("END - Sentinels__TOWERS__points_visual_speaker");

end



--[========================================================================[
          Sentinels. TOWERS. points
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__points_visual_02 = {
	name = "W3Sentinels_Sentinels__TOWERS__points_visual_02",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_DownTime = false;
		PushForwardVOReset();
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 10;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke and object_get_health(thisConvo.localVariables.core) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Visual on a gravitational Core!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_10600.sound'),
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck and object_get_health(thisConvo.localVariables.core) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Eyes on a Core!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_06300.sound'),
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka and object_get_health(thisConvo.localVariables.core) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Gravitational Core here!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_05600.sound'),
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale and object_get_health(thisConvo.localVariables.core) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "I have eyes on on a gravitational Core!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_05200.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__points_visual_02_answer");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__points_visual_02_answer);
	end,

	localVariables = {
						s_speaker = nil,
						core = nil,
					},
};



--[========================================================================[
          Sentinels. TOWERS. points
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__points_visual_02_answer = {
	name = "W3Sentinels_Sentinels__TOWERS__points_visual_02_answer",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 4;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return object_get_health(thisConvo.localVariables.core) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Take it down, Osiris!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_10700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		b_DownTime = true;
	end,

	localVariables = {
						core = nil,
					},
};

--[========================================================================[
          Sentinels. TOWERS. points
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__points_visual_03 = {
	name = "W3Sentinels_Sentinels__TOWERS__points_visual_03",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_DownTime = false;
		PushForwardVOReset();
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 10;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke and object_get_health(thisConvo.localVariables.core) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Another Core on my position!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_10800.sound'),
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck and object_get_health(thisConvo.localVariables.core) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Got another Core here!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_06400.sound'),
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka and object_get_health(thisConvo.localVariables.core) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Another Core on me!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_05700.sound'),
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale and object_get_health(thisConvo.localVariables.core) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "I have another Core on my position!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_05300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__points_visual_03_answer");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__points_visual_03_answer);
	end,

	localVariables = {
						s_speaker = nil,
						core = nil,
					},
};



--[========================================================================[
          Sentinels. TOWERS. points
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__points_visual_03_answer = {
	name = "W3Sentinels_Sentinels__TOWERS__points_visual_03_answer",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 4;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return object_get_health(thisConvo.localVariables.core) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Take it down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_10900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		b_DownTime = true;
	end,

	localVariables = {
						core = nil,
					},
};

--[========================================================================[
          Sentinels. TOWERS. points
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__points_visual_04 = {
	name = "W3Sentinels_Sentinels__TOWERS__points_visual_04",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_DownTime = false;
		PushForwardVOReset();
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 10;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke and object_get_health(thisConvo.localVariables.core) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Another Core on me, Osiris!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_11000.sound'),
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck and object_get_health(thisConvo.localVariables.core) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Found another Core!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_06500.sound'),
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka and object_get_health(thisConvo.localVariables.core) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Found another Core!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_05800.sound'),
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale and object_get_health(thisConvo.localVariables.core) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "I've found another Core!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_05400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__points_visual_04_answer");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__points_visual_04_answer);
	end,

	localVariables = {
						s_speaker = nil,
						core = nil,
					},
};


--[========================================================================[
          Sentinels. TOWERS. points
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__points_visual_04_answer = {
	name = "W3Sentinels_Sentinels__TOWERS__points_visual_04_answer",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_DownTime = false;
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 4;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return object_get_health(thisConvo.localVariables.core) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Take it down, Osiris!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_11100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		b_DownTime = true;
	end,

	localVariables = {
						core = nil,
					},
};

--[========================================================================[
          Sentinels. TOWERS. points
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__points_visual_05 = {
	name = "W3Sentinels_Sentinels__TOWERS__points_visual_05",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_DownTime = false;
		PushForwardVOReset();
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 10;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke and object_get_health(thisConvo.localVariables.core) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Visual on a gravitational Core!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_10600.sound'),
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck and object_get_health(thisConvo.localVariables.core) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Eyes on a Core!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_06300.sound'),
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka and object_get_health(thisConvo.localVariables.core) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Gravitational Core here!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_05600.sound'),
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale and object_get_health(thisConvo.localVariables.core) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "I have eyes on on a gravitational Core!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_05200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__points_visual_05_answer");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__points_visual_05_answer);
	end,

	localVariables = {
						s_speaker = nil,
						core = nil,
					},
};


--[========================================================================[
          Sentinels. TOWERS. points
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__points_visual_05_answer = {
	name = "W3Sentinels_Sentinels__TOWERS__points_visual_05_answer",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 4;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return object_get_health(thisConvo.localVariables.core) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Take it down, Osiris!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_10700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		b_DownTime = true;
	end,

	localVariables = {
						core = nil,
					},
};

--[========================================================================[
          Sentinels. TOWERS. points visual with covenant shield
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__points_visual_with_covenant_shiel = {
	name = "W3Sentinels_Sentinels__TOWERS__points_visual_with_covenant_shiel",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 10;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_DownTime = false;
		PushForwardVOReset();
		if list_count(players()) == 1 then
			thisConvo.localVariables.s_speaker_2 = GetClosestMusketeer(thisConvo.localVariables.s_speaker, 20, 0);
		else
			thisConvo.localVariables.s_speaker_2 = GetClosestMusketeer(thisConvo.localVariables.s_speaker, 10, 2);
		end
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker_2 == SPARTANS.locke and object_get_health( thisConvo.localVariables.s_shield ) > 0.2;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Core is behind a covenant shield",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_12400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker_2 == SPARTANS.buck and object_get_health( thisConvo.localVariables.s_shield ) > 0.2;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Core's behind a covenant shield",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_07100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker_2 == SPARTANS.tanaka and object_get_health( thisConvo.localVariables.s_shield ) > 0.2;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Core's behind a covenant shield",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_06600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker_2 == SPARTANS.vale and object_get_health( thisConvo.localVariables.s_shield ) > 0.2;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "The Core is behind a covenant shield",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_06000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},

	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 0.7,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;		
	end,

	localVariables = {
					s_speaker = nil,
					s_speaker_2 = nil,
					s_shield = nil,
					},
};


----------------------------------------------------------------
----------------------------------------------------------------
--	MONITOR BIS IN BETWEEN
----------------------------------------------------------------
----------------------------------------------------------------



function monitor_bis_hints()

	PrintNarrative("START - monitor_bis_hints");

	sleep_s(60);

	SleepUntil([| b_push_forward_vo_counrdown_on >= 5], 10);

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__point_1_deactivated_bis");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__point_1_deactivated_bis);

	SleepUntil([| core_count <= 3 and NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__TOWERS__point_1_deactivated_bis)], 10);

	sleep_s(60);

	SleepUntil([| b_push_forward_vo_counrdown_on >= 5], 10);

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__point_2_deactivated_bis");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__point_2_deactivated_bis);		

	SleepUntil([| core_count <= 1 and NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__TOWERS__point_2_deactivated_bis)], 10);

	sleep_s(60);

	SleepUntil([| b_push_forward_vo_counrdown_on >= 5], 10);

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__point_4_deactivated_bis");					
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__point_4_deactivated_bis);				

	PrintNarrative("END - monitor_bis_hints");
end



--[========================================================================[
          Sentinels. TOWERS. point 1 deactivated
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__point_1_deactivated_bis = {
	name = "W3Sentinels_Sentinels__TOWERS__point_1_deactivated_bis",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_counrdown_on > 20 and not b_more_guardian_are_leaving and not IsPlayerNearALivingCore() and b_DownTime and not IsSpartanInCombat(); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(60);
		b_DownTime = false;		
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return core_count > 1;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Keep searching. I am certain the other gravitational cores are nearby.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_19800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
		hud_hide_radio_transmission_hud();
	end,
};



--[========================================================================[
          Sentinels. TOWERS. point 2 deactivated
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__point_2_deactivated_bis = {
	name = "W3Sentinels_Sentinels__TOWERS__point_2_deactivated_bis",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_counrdown_on > 20 and not b_more_guardian_are_leaving and not IsPlayerNearALivingCore() and IsSpartanAbleToSpeak(SPARTANS.locke) and b_DownTime and not IsSpartanInCombat(); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(60);
		b_DownTime = false;
	end,
	
	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return core_count > 1;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Do keep searching. With those other cores active, you cannot reach the Cryptum.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_19900.sound'),
		},		
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return core_count > 1;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Cortana's Guardian is nearly prepared.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_20000.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return core_count > 1;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Double time Osiris! We can't let her leave with Blue Team.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_11600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
		hud_hide_radio_transmission_hud();
	end,

};

--[========================================================================[
          Sentinels. TOWERS. point 4 deactivated
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__point_4_deactivated_bis = {
	name = "W3Sentinels_Sentinels__TOWERS__point_4_deactivated_bis",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_counrdown_on > 10 and not b_more_guardian_are_leaving and not IsPlayerNearALivingCore() and IsSpartanAbleToSpeak(SPARTANS.vale) and b_DownTime and not IsSpartanInCombat(); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(60);
		b_DownTime = false;
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return core_count > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "There are only a few Guardians remaining on Genesis. Cortana is clearly waiting until they are all deployed before leaving herself.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_20100.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return core_count > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VaLE
			text = "Leaving to where? I mean where would she want to go?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_06800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
		hud_hide_radio_transmission_hud();
	end,

	--localVariables = {},
};



----------------------------------------------------------------
----------------------------------------------------------------
--	CORTANA PRIVATE
----------------------------------------------------------------
----------------------------------------------------------------


--[========================================================================[
          Sentinels. TOWERS. private cortana

          Cortana speaks now, right in our ears. She's going VERY
          Halsey right here. Intentionally tearing them down, not using
          their proper titles, etc.
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__private_cortana_locke = {
	name = "W3Sentinels_Sentinels__TOWERS__private_cortana_locke",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		b_cortana_private_speech = true;
		PushForwardVOReset();
	end,
	
	sleepBefore = 2,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Keep up the pressure, Spartans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_15300.sound'),

			sleepAfter = 0.5,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "Spartans... ha! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_01900.sound'),
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "Jameson Locke. Ex-ONI Acquisitions Specialist.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_03200.sound'),
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "Fancy name for a hitman, that. But looking at your record, you enjoyed your work.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_03300.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(Sentinels__TOWERS__private_cortana_tanaka);
	end,

};


function Sentinels__TOWERS__private_cortana_tanaka()
	
	PrintNarrative("START - Sentinels__TOWERS__private_cortana_tanaka");

	--[[
	repeat
		sleep_s(5);

		sentinels_is_there_enemy_nearby(20);

	until not IsGoalActive(missionSentinels.goal_cores) or (not sentinels_is_there_enemy_nearby_result and not b_more_guardian_are_leaving and not IsPlayerNearALivingCore() and b_DownTime and (not g_core_prime_action_done or objects_distance_to_object( players(), OBJECTS.cr_coliseum_entrance ) > 35 ))
	]]
	if IsGoalActive(missionSentinels.goal_cores) then
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__private_cortana_tanaka");					
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__private_cortana_tanaka);	
	end

end

--[========================================================================[
          Sentinels. TOWERS. private cortana

          Cortana speaks now, right in our ears. She's going VERY
          Halsey right here. Intentionally tearing them down, not using
          their proper titles, etc.
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__private_cortana_tanaka = {
	name = "W3Sentinels_Sentinels__TOWERS__private_cortana_tanaka",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		b_cortana_private_speech = true;
		PushForwardVOReset();
	end,
	
	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "Holly Tanaka. Oh, Holly.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_03400.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			sleepBefore = 0.4,

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "How on did you pass your psych eval after surviving the glassing of Minab?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_03500.sound'),
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			sleepBefore = 0.2,

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "I'd have kept you away from sharp objects, never mind Mjolnir armor.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_03600.sound'),
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return core_count > 0;
			end,

			sleepBefore = 0.2,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Stay focused Osiris. Take the cores down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_11800.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 0.4,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		CreateMissionThread(Sentinels__TOWERS__private_cortana_buck);
	end,

};


function Sentinels__TOWERS__private_cortana_buck()
	
	PrintNarrative("START - Sentinels__TOWERS__private_cortana_buck");

	--[[
	repeat
		sleep_s(5);

		sentinels_is_there_enemy_nearby(20);

	until not IsGoalActive(missionSentinels.goal_cores) or (not sentinels_is_there_enemy_nearby_result and not b_more_guardian_are_leaving and not IsPlayerNearALivingCore() and b_DownTime and (not g_core_prime_action_done or objects_distance_to_object( players(), OBJECTS.cr_coliseum_entrance ) > 35 ))
	]]
	if IsGoalActive(missionSentinels.goal_cores) then
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__private_cortana_buck");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__private_cortana_buck);
	end
end


--[========================================================================[
          Sentinels. TOWERS. private cortana

          Cortana speaks now, right in our ears. She's going VERY
          Halsey right here. Intentionally tearing them down, not using
          their proper titles, etc.
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__private_cortana_buck = {
	name = "W3Sentinels_Sentinels__TOWERS__private_cortana_buck",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		b_cortana_private_speech = true;
		PushForwardVOReset();
	end,
	
	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "Edward Buck. You're an odd one. So much older than the others.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_03700.sound'),

			sleepAfter = 0.3,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "So experienced. Yet playing second fiddle to children. Why is that?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_03800.sound'),

			sleepAfter = 0.3,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BuCK
			text = "Is she calling me old?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_08100.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(Sentinels__TOWERS__private_cortana_vale);
	end,
};



function Sentinels__TOWERS__private_cortana_vale()
	
	PrintNarrative("START - Sentinels__TOWERS__private_cortana_vale");
	--[[
	repeat
		sleep_s(5);

		sentinels_is_there_enemy_nearby(20);

	until not IsGoalActive(missionSentinels.goal_cores) or (not sentinels_is_there_enemy_nearby_result and not b_more_guardian_are_leaving and not IsPlayerNearALivingCore() and b_DownTime and (not g_core_prime_action_done or objects_distance_to_object( players(), OBJECTS.cr_coliseum_entrance ) > 35 ))
	]]
	if IsGoalActive(missionSentinels.goal_cores) then
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__TOWERS__private_cortana_vale");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__TOWERS__private_cortana_vale);
	end
end

--[========================================================================[
          Sentinels. TOWERS. private cortana

          Cortana speaks now, right in our ears. She's going VERY
          Halsey right here. Intentionally tearing them down, not using
          their proper titles, etc.
--]========================================================================]
global W3Sentinels_Sentinels__TOWERS__private_cortana_vale = {
	name = "W3Sentinels_Sentinels__TOWERS__private_cortana_vale",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		b_cortana_private_speech = true;
		PushForwardVOReset(50);
	end,
	
	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,		

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "Olympia Vale. The little genius girl who only wanted daddy to love her--",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_03900.sound'),
			
			playDurationAdjustment = 0.9,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VaLE
			text = "That's Spartan Vale.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_00200.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 5;
			end,	
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VaLE
			text = "And if you're reading my psych eval, you know it takes more than my father to get to me.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_01600.sound'),
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "And yet...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_04000.sound'),

			playDurationAdjustment = 0.95,
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players( VOLUMES.tv_narrative_coliseum_entrance );
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Don't engage, Vale. Focus on the mission.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_04800.sound'),
		},
		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players( VOLUMES.tv_narrative_coliseum_entrance );
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "Yes, Vale. Focus on the futile task at hand. You have a war to lose.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_04100.sound'),
		},
		[7] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players( VOLUMES.tv_narrative_coliseum_entrance );
			end,
		
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "The last battle mankind will ever fight. Today I bring peace to these shores.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_04200.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_cortana_private_speech = false;
		GoalCreateThread(missionSentinels.goal_cores, Sentinels__TOWERS__private_cortana_extra);
	end,

};


function Sentinels__TOWERS__private_cortana_extra()
	
	PrintNarrative("START - Sentinels__TOWERS__private_cortana_extra");
	
	sleep_s(10);

	repeat
		sleep_s(2);

		sentinels_is_there_enemy_nearby(20);

	until not IsGoalActive(missionSentinels.goal_cores) or (not sentinels_is_there_enemy_nearby_result and not b_more_guardian_are_leaving and not IsPlayerNearALivingCore() and b_DownTime and (not g_core_prime_action_done or objects_distance_to_object( players(), OBJECTS.cr_coliseum_entrance ) > 30 ))
	
	if IsGoalActive(missionSentinels.goal_cores)  and not g_core_prime_action_done then
		PrintNarrative("QUEUE - W3Sentinels_VERSION_TWO__TAUNTING");
		NarrativeQueue.QueueConversation(W3Sentinels_VERSION_TWO__TAUNTING);
	end
end



--[========================================================================[
          VERSION TWO: TAUNTING
--]========================================================================]
global W3Sentinels_VERSION_TWO__TAUNTING = {
	name = "W3Sentinels_VERSION_TWO__TAUNTING",
	
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		b_cortana_private_speech = true;
		PushForwardVOReset(50);
	end,
	
	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CORTANA
			text = "You are pale imitations of my Spartans. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_07500.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Is that so?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_15400.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not g_core_prime_action_done ;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CoRTANA
			text = "John, the others -- they saved the human race. What can you do? You are children, playing dress up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_07600.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER				
				return 0;
			end,	
		},
		[4] = {		
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not g_core_prime_action_done ;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Doctor Halsey thinks we can bring Chief home.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_15500.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER				
				return 0;
			end,	
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CORTANA
			text = "I wouldn't ally myself too closely with Doctor Halsey, Mister Locke. She will eventually pay for her crimes.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_07700.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_cortana_private_speech = false;
	end,
};


-- =================================================================================================
--   _____ ____  _      _____  _____ ______ _    _ __  __ 
--  / ____/ __ \| |    |_   _|/ ____|  ____| |  | |  \/  |
-- | |   | |  | | |      | | | (___ | |__  | |  | | \  / |
-- | |   | |  | | |      | |  \___ \|  __| | |  | | |\/| |
-- | |___| |__| | |____ _| |_ ____) | |____| |__| | |  | |
--  \_____\____/|______|_____|_____/|______|\____/|_|  |_|
--                                                        
-- =================================================================================================


function sentinels_coliseum_wake()

	PrintNarrative("START - sentinels_coliseum_wake");

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__coliseum_start");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__coliseum_start);

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__coliseum__Defend_exuberant");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__coliseum__Defend_exuberant);	

	PrintNarrative("END - sentinels_coliseum_wake");

	b_DownTime = false;

	--sleep_s(random_range(60,200));

	--CreateMissionThread(sentinels_guardians_slipspace,OBJECTS.cortana_guardian01);
	PushForwardVOReset(-1);

end


--[========================================================================[
          Sentinels. coliseum. cortana
--]========================================================================]
global W3Sentinels_Sentinels__coliseum__cortana = {
	name = "W3Sentinels_Sentinels__coliseum__cortana",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narrative_coliseum_entrance ); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_return_players( VOLUMES.tv_narrative_coliseum_entrance )[1] == SPARTANS.locke; -- GAMMA_TRANSITION: If locke is first to enter
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Exuberant, open the Cryptum!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_08700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_return_players( VOLUMES.tv_narrative_coliseum_entrance )[1] == SPARTANS.buck; -- GAMMA_TRANSITION: If buck is first to enter
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Exuberant, open the Cryptum!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_04700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_return_players( VOLUMES.tv_narrative_coliseum_entrance )[1] == SPARTANS.tanaka; -- GAMMA_TRANSITION: If tanaka is first to enter
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Exuberant, open the Cryptum!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_04300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_return_players( VOLUMES.tv_narrative_coliseum_entrance )[1] == SPARTANS.vale; -- GAMMA_TRANSITION: If vale is first to enter
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Exuberant, open the Cryptum!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_03800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Right away!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_17300.sound'),

			playDurationAdjustment = 0.9,

		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};
 

--[========================================================================[
          Sentinels. coliseum. New plan
--]========================================================================]
global W3Sentinels_Sentinels__coliseum_start = {
	name = "W3Sentinels_Sentinels__coliseum_start",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_col_int ) and NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__TOWERS__cryptum_leaving); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					b_coliseum_hostiles_incoming = true;
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "I need to open the passage way in the center... one moment!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_17600.sound'),
			
			playDurationAdjustment = 0.8,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID				
				hud_hide_radio_transmission_hud();
			end,
		},
		[2] = {			
			sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,			

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Hostiles incoming.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_01000.sound'),

			playDurationAdjustment = 0.85,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "She has sealed it?! She has sealed my doors?! No! Unacceptable!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_15300.sound'),
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "I can gain entry if given enough time. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_04200.sound'),
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "At least I think I can. It is a door, after all.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_19100.sound'),
		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Okay, Osiris. Buy our friend the time she needs.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_05900.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};




--[========================================================================[
          Sentinels. coliseum. Defend exuberant

          When trying to take control of the Constructors, Exuberant
          realizes that she can't control the existing ones but she can
          call in more Constructors that she, this time would control.

          Once she realized that:
--]========================================================================]
global W3Sentinels_Sentinels__coliseum__Defend_exuberant = {
	name = "W3Sentinels_Sentinels__coliseum__Defend_exuberant",

	CanStart = function (thisConvo, queue)
		return b_coliseum_wave_1_part_3; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(50);
	end,

	lines = {
		[1] = {
			sleepBefore = 2.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Humans, Cortana is about to leave. She is disconnecting herself from the Genesis installation.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_17700.sound'),
		},
		[2] = {
			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "So how quick can you get that door open?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_05400.sound'),
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Hopefully sooner than her departure.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_17800.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__coliseum__Defend_end_wave_1");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__coliseum__Defend_end_wave_1);
	end,
};




--[========================================================================[
          Sentinels. coliseum. Defend exuberant

          When trying to take control of the Constructors, Exuberant
          realizes that she can't control the existing ones but she can
          call in more Constructors that she, this time would control.

          Once she realized that:
--]========================================================================]
global W3Sentinels_Sentinels__coliseum__Defend_end_wave_1 = {
	name = "W3Sentinels_Sentinels__coliseum__Defend_end_wave_1",

	CanStart = function (thisConvo, queue)
		return b_coliseum_end_of_wave_1 and IsSpartanAbleToSpeak(SPARTANS.vale); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(60);				
	end,

	lines = {
		[1] = {
			sleepBefore = 2.5,

			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return W3Sentinels_Sentinels__coliseum__auxilliary.localVariables.s_speaker == nil;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Humans, I need your help. There are two auxiliary stations that need to be activated, but if I move from here I will have to begin the process anew.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_22200.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return W3Sentinels_Sentinels__coliseum__auxilliary.localVariables.s_speaker == nil;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "There are 2 auxilliary to need to activate!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_22300.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return W3Sentinels_Sentinels__coliseum__auxilliary.localVariables.s_speaker == nil;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VaLE
			text = "Where are they?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_03200.sound'),
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return W3Sentinels_Sentinels__coliseum__auxilliary.localVariables.s_speaker == nil;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "On the upper ledges. Opposite sides of the room.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_15400.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		CreateThread( f_col_contructor_objective );
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__coliseum__Defend_end_wave_1_nag");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__coliseum__Defend_end_wave_1_nag);		
	end,
};



--[========================================================================[
          Sentinels. coliseum. Defend exuberant

--]========================================================================]
global W3Sentinels_Sentinels__coliseum__Defend_end_wave_1_nag = {
	name = "W3Sentinels_Sentinels__coliseum__Defend_end_wave_1_nag",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_counrdown_on > 20 and (objects_distance_to_object( players(), OBJECTS.dc_col_objective_a ) > 5 and objects_distance_to_object( players(), OBJECTS.dc_col_objective_b ) > 5); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(40);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_col_both_constructors_released;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "I need you to activate the 2 auxiliary stations or all my work is for naught. Hurry! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_13500.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__coliseum__auxilliary_nag_2");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__coliseum__auxilliary_nag_2);
	end,
};



--[========================================================================[
          Sentinels. coliseum. Defend exuberant

--]========================================================================]
global W3Sentinels_Sentinels__coliseum__auxilliary_nag_2 = {
	name = "W3Sentinels_Sentinels__coliseum__auxilliary_nag_2",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_timer >= 3 and b_push_forward_vo_timer < 10 and (objects_distance_to_object( players(), OBJECTS.dc_col_objective_a ) > 3 and objects_distance_to_object( players(), OBJECTS.dc_col_objective_b ) > 3); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(30);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_col_both_constructors_released;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Humans? What is taking so long? Please, activate the auxilliary stations.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_21500.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Osiris, find and activate them.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_14800.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__coliseum__auxilliary_nag_3");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__coliseum__auxilliary_nag_3);
	end,
};


--[========================================================================[
          Sentinels. coliseum. Defend exuberant

--]========================================================================]
global W3Sentinels_Sentinels__coliseum__auxilliary_nag_3 = {
	name = "W3Sentinels_Sentinels__coliseum__auxilliary_nag_3",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_timer >= 3 and b_push_forward_vo_timer < 10 and (objects_distance_to_object( players(), OBJECTS.dc_col_objective_a ) > 3 and objects_distance_to_object( players(), OBJECTS.dc_col_objective_b ) > 3); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(60);
	end,

	lines = {
		[1] = {		
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_col_both_constructors_released;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "I can do nothing else until you activate the auxilliary stations.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_21600.sound'),
		},	
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "The Artemis can locate them for us.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_08000.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};

function Sentinels__coliseum__auxilliary(activator:object)
	
	PrintNarrative("START - Sentinels__coliseum__auxilliary");

	NarrativeQueue.InterruptConversation(W3Sentinels_Sentinels__coliseum__Defend_end_wave_1, 0.5);

	if W3Sentinels_Sentinels__coliseum__auxilliary.localVariables.s_speaker == nil then
		W3Sentinels_Sentinels__coliseum__auxilliary.localVariables.s_speaker = activator;
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__coliseum__auxilliary");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__coliseum__auxilliary);
	elseif W3Sentinels_Sentinels__coliseum__auxilliary.localVariables.s_speaker ~= nil and W3Sentinels_Sentinels__coliseum__auxilliary_2.localVariables.s_speaker == nil then
		W3Sentinels_Sentinels__coliseum__auxilliary_2.localVariables.s_speaker = activator;
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__coliseum__auxilliary_2");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__coliseum__auxilliary_2);		
	end

	PrintNarrative("END - Sentinels__coliseum__auxilliary");

end



--[========================================================================[
          Sentinels. coliseum. auxilliary

          By now if the player kill the enemies, there will not be any
          respawn until the 2 auxilliary are activated.
--]========================================================================]
global W3Sentinels_Sentinels__coliseum__auxilliary = {
	name = "W3Sentinels_Sentinels__coliseum__auxilliary",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		NarrativeQueue.EndConversationEarly(W3Sentinels_Sentinels__coliseum__Defend_end_wave_1);
		PushForwardVOReset(60);
	end,

	sleepBefore = 3,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == unit_get_player(SPARTANS.locke);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "First auxilliary activated!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_12800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == unit_get_player(SPARTANS.buck);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "First auxilliary activated!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_07700.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == unit_get_player(SPARTANS.tanaka);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "First auxilliary activated!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_07100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == unit_get_player(SPARTANS.vale);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "First auxilliary activated!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_06500.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[5] = {
			sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Perfect! The other one now!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_16800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
					s_speaker = nil,
					},

};


--[========================================================================[
          Sentinels. coliseum. auxilliary

          By now if the player kill the enemies, there will not be any
          respawn until the 2 auxilliary are activated.
--]========================================================================]
global W3Sentinels_Sentinels__coliseum__auxilliary_2 = {
	name = "W3Sentinels_Sentinels__coliseum__auxilliary_2",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,
	
	sleepBefore = 3,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		NarrativeQueue.EndConversationEarly(W3Sentinels_Sentinels__coliseum__auxilliary);
		PushForwardVOReset(60);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == unit_get_player(SPARTANS.locke);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Second auxilliary activated!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_12900.sound'),
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == unit_get_player(SPARTANS.buck);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "And... the second auxilliary!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_07800.sound'),
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == unit_get_player(SPARTANS.tanaka);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Second auxilliary, done!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_07200.sound'),
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == unit_get_player(SPARTANS.vale);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Second auxilliary is activated!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_06600.sound'),
		},
		[5] = {
			sleepBefore = 0.3,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "YES! Just in time. Cortana was about to lock me out. I will open the access soon.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_22400.sound'),
			
			--playDurationAdjustment = 0.9,
		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "More enemies incoming!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_03700.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,

	localVariables = {
					s_speaker = nil,
					},
};


function Sentinels__coliseum__Defend_end_wave_2()

	PrintNarrative("START - Sentinels__coliseum__Defend_end_wave_2");

repeat 
		sleep_s(1);
until GetClosestEnemy(AI.sg_col_all, 10) == nil;

sleep_s(1);

PrintNarrative("QUEUE - W3Sentinels_Sentinels__coliseum__Defend_end_wave_2");
NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__coliseum__Defend_end_wave_2);

end

--[========================================================================[
          Sentinels. coliseum. Defend exuberant

          When trying to take control of the Constructors, Exuberant
          realizes that she can't control the existing ones but she can
          call in more Constructors that she, this time would control.

          Once she realized that:
--]========================================================================]
global W3Sentinels_Sentinels__coliseum__Defend_end_wave_2 = {
	name = "W3Sentinels_Sentinels__coliseum__Defend_end_wave_2",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		PushForwardVOReset(90);
	end,

	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
		CreateMissionThread(sentinels_cortana_guardian_sound_3d,OBJECTS.cortana_guardian01);
	end,

	lines = {
		[1] = {
			sleepBefore = 7,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "A point of interest for you, humans. That sound just now? It was the penultimate Guardian. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_13700.sound'),

			playDurationAdjustment = 0.9,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__coliseum__Defend_end_wave_2_bis");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__coliseum__Defend_end_wave_2_bis);
		
	end,
};


--[========================================================================[
          Sentinels. coliseum. Defend push forward

          The player needs to kill all enemies, but some enemies can
          stay in the back. To encourage the player to move to them:
--]========================================================================]
global W3Sentinels_Sentinels__coliseum__Defend_push_forward = {
	name = "W3Sentinels_Sentinels__coliseum__Defend_push_forward",

	CanStart = function (thisConvo, queue)
		return not b_coliseum_monitor_success and b_coliseum_distractions_on and b_push_forward_vo_counrdown_on > 10; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(60);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "It is not easy to work with all of these distractions. Where is your destructive skill? Eliminate these aggressors!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_17000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


--[========================================================================[
          Sentinels. coliseum. Defend exuberant

          When trying to take control of the Constructors, Exuberant
          realizes that she can't control the existing ones but she can
          call in more Constructors that she, this time would control.

          Once she realized that:
--]========================================================================]
global W3Sentinels_Sentinels__coliseum__Defend_end_wave_2_bis = {
	name = "W3Sentinels_Sentinels__coliseum__Defend_end_wave_2_bis",

	CanStart = function (thisConvo, queue)
		return IsSpartanAbleToSpeak(SPARTANS.locke); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {		
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "The Cryptum?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_06100.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Still present. Along with Cortana's Guardian. I believe that she's ready to leave any minute though.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_13800.sound')
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: bUCK
			text = "Well, what's the status on that door?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_06100.sound'),
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					b_coliseum_last_guardian_slipspacing = true;
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Almost open!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_15500.sound'),

			playDurationAdjustment = 0.9,
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Quicker! Please!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_07800.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 2,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(sentinels_coliseum_cortana_speech);
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__coliseum__Defend_success");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__coliseum__Defend_success);
		b_coliseum_distractions_on = true;
	end,
};


function coliseum_enemy_incoming()

PrintNarrative("QUEUE - W3Sentinels_Sentinels__coliseum__reinforcement_incoming");
NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__coliseum__reinforcement_incoming);

end


--[========================================================================[
          Sentinels. coliseum. reinforcement incoming
--]========================================================================]
global W3Sentinels_Sentinels__coliseum__reinforcement_incoming = {
	name = "W3Sentinels_Sentinels__coliseum__reinforcement_incoming",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	--sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.buck == nil and IsSpartanAbleToSpeak(SPARTANS.buck); -- GAMMA_TRANSITION: If buck is alive During the arrival of more enemies 
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "More are coming!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_08700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				thisConvo.localVariables.buck = true;
				return 4; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.tanaka == nil and IsSpartanAbleToSpeak(SPARTANS.tanaka); -- GAMMA_TRANSITION: Else If tanaka is alive During the arrival of more enemies 
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "She's sending more!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_07600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				thisConvo.localVariables.tanaka = true;
				return 4; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.vale == nil and IsSpartanAbleToSpeak(SPARTANS.vale); -- GAMMA_TRANSITION: Else If vale is alive During the arrival of more enemies 
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "She's sending more Prometheans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_07100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				thisConvo.localVariables.vale = true;
				return 4; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.answer == nil; -- GAMMA_TRANSITION: Else If vale is alive During the arrival of more enemies 
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Take care of them, Osiris!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_14400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				thisConvo.localVariables.answer = true;
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
						buck = nil,
						tanaka = nil,
						vale = nil,
						answer = nil,
						},
};



-----------------------------
function sentinels_coliseum_cortana_speech()
local s_timer:number = 0;

	PrintNarrative("START - sentinels_coliseum_cortana_speech");
	
	SleepUntil([| b_coliseum_end_of_wave_2], 10);

	b_coliseum_distractions_on = false;

	repeat
		sleep_s(0.5);
		s_timer = s_timer + 0.5;
		sentinels_is_there_enemy_nearby(10)
	until (not sentinels_is_there_enemy_nearby_result and not b_coliseum_spawn) or s_timer >= 3;

	s_timer = 0;

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__coliseum__Cortana_speech_1");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__coliseum__Cortana_speech_1);

	SleepUntil([|  NarrativeQueue.HasConversationFinished( W3Sentinels_Sentinels__coliseum__Cortana_speech_1 )], 30);	

	repeat 
		sleep_s(0.2);
		s_timer = s_timer + 0.2;
		sentinels_is_there_enemy_nearby(10)
	until (not sentinels_is_there_enemy_nearby_result and not b_coliseum_spawn) or s_timer >=  0.6;

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__coliseum__Cortana_speech_2");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__coliseum__Cortana_speech_2);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W3Sentinels_Sentinels__coliseum__Cortana_speech_2 ) ], 30);	

	repeat 
		sleep_s(0.2);
		s_timer = s_timer + 0.2;
		sentinels_is_there_enemy_nearby(10)
	until (not sentinels_is_there_enemy_nearby_result and not b_coliseum_spawn) or s_timer >=  0.6;

	s_timer = 0;

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__coliseum__Cortana_speech_3");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__coliseum__Cortana_speech_3);

	SleepUntil([|  NarrativeQueue.HasConversationFinished( W3Sentinels_Sentinels__coliseum__Cortana_speech_3 ) ], 30);	

	repeat 
		sleep_s(0.2);
		s_timer = s_timer + 0.2;
		sentinels_is_there_enemy_nearby(10)
	until (not sentinels_is_there_enemy_nearby_result and not b_coliseum_spawn) or s_timer >=  0.6;

	s_timer = 0;

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__coliseum__Cortana_speech_4");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__coliseum__Cortana_speech_4);

	SleepUntil([|  NarrativeQueue.HasConversationFinished( W3Sentinels_Sentinels__coliseum__Cortana_speech_4 )], 30);	

	repeat 
		sleep_s(0.2);
		s_timer = s_timer + 0.2;
		sentinels_is_there_enemy_nearby(10)
	until (not sentinels_is_there_enemy_nearby_result and not b_coliseum_spawn) or s_timer >=  0.6;

	s_timer = 0;

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__coliseum__Cortana_speech_5");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__coliseum__Cortana_speech_5);

	SleepUntil([|  NarrativeQueue.HasConversationFinished( W3Sentinels_Sentinels__coliseum__Cortana_speech_5 )], 30);	

	repeat 
		sleep_s(0.2);
		s_timer = s_timer + 0.2;
		sentinels_is_there_enemy_nearby(10)
	until (not sentinels_is_there_enemy_nearby_result and not b_coliseum_spawn) or s_timer >= 0.6;

	s_timer = 0;

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__coliseum__Cortana_speech_6");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__coliseum__Cortana_speech_6);

	SleepUntil([|  NarrativeQueue.HasConversationFinished( W3Sentinels_Sentinels__coliseum__Cortana_speech_6 ) ], 30);	

	repeat 
		sleep_s(0.2);
		s_timer = s_timer + 0.2;
		sentinels_is_there_enemy_nearby(10)
	until (not sentinels_is_there_enemy_nearby_result and not b_coliseum_spawn) or s_timer >=  0.6;

	s_timer = 0;

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__coliseum__Cortana_speech_7");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__coliseum__Cortana_speech_7);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W3Sentinels_Sentinels__coliseum__Cortana_speech_7 ) ], 30);	

	repeat 
		sleep_s(0.2);
		s_timer = s_timer + 0.2;
		sentinels_is_there_enemy_nearby(10)
	until (not sentinels_is_there_enemy_nearby_result and not b_coliseum_spawn) or s_timer >=  0.6;

	s_timer = 0;

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__coliseum__Cortana_speech_8");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__coliseum__Cortana_speech_8);

	SleepUntil([|  NarrativeQueue.HasConversationFinished( W3Sentinels_Sentinels__coliseum__Cortana_speech_8 ) ], 30);	

	repeat 
		sleep_s(0.2);
		s_timer = s_timer + 0.2;
		sentinels_is_there_enemy_nearby(10)
	until (not sentinels_is_there_enemy_nearby_result and not b_coliseum_spawn) or s_timer >=  0.6;

	s_timer = 0;

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__coliseum__Cortana_speech_9");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__coliseum__Cortana_speech_9);

	SleepUntil([|  NarrativeQueue.HasConversationFinished( W3Sentinels_Sentinels__coliseum__Cortana_speech_9 )], 30);	

	repeat 
		sleep_s(0.2);
		s_timer = s_timer + 0.2;
		sentinels_is_there_enemy_nearby(10)
	until (not sentinels_is_there_enemy_nearby_result and not b_coliseum_spawn) or s_timer >=  0.6;

	s_timer = 0;

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__coliseum__Cortana_speech_10");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__coliseum__Cortana_speech_10);

	SleepUntil([|  NarrativeQueue.HasConversationFinished( W3Sentinels_Sentinels__coliseum__Cortana_speech_10 )], 30);	

	repeat 
		sleep_s(0.2);
		s_timer = s_timer + 0.2;
		sentinels_is_there_enemy_nearby(10)
	until (not sentinels_is_there_enemy_nearby_result and not b_coliseum_spawn) or s_timer >=  0.6;

	s_timer = 0;

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__coliseum__Cortana_speech_11");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__coliseum__Cortana_speech_11);

	b_coliseum_distractions_on = true;

	PrintNarrative("END - sentinels_coliseum_cortana_speech");

end


--[========================================================================[
          Sentinels. coliseum. Cortana's speech
--]========================================================================]
global W3Sentinels_Sentinels__coliseum__Cortana_speech_1 = {
	name = "W3Sentinels_Sentinels__coliseum__Cortana_speech_1",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_coliseum_cortana_speech = true;
		PushForwardVOReset(60);
		opportunity_area_set_active("coliseum_dialog_blind", true);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_coliseum_monitor_success and IsGoalActive(missionSentinels.goal_coliseum);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			sleepBefore = 1.5,

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "Humanity. Sangheili. Kig-yar. Unggoy. Yonhet.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_00500.sound'),

			playDurationAdjustment = 0.7,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "What does she wants now?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_08500.sound'),

			playDurationAdjustment = 0.6,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: Cortana
			text = "Kig-yar. Unggoy.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_06800.sound'),

			playDurationAdjustment = 0.45,
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "She's not talking to us. Exuberant! Get us to the relay!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_14200.sound'),

			playDurationAdjustment = 0.8,
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CORTANA
			text = "San 'Shyuum. Yonhet. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_07900.sound'),

			playDurationAdjustment = 0.5,
		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					b_coliseum_spawn_enemies_after_cortana = true;
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Almost done!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_22500.sound'),

			playDurationAdjustment = 0.5,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[7] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CORTANA
			text = "Jiralhanae. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_08000.sound'),

			playDurationAdjustment = 0.95,
		},		
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_coliseum_cortana_speech = false;		
	end,
};


--[========================================================================[
          Sentinels. coliseum. Cortana's speech
--]========================================================================]
global W3Sentinels_Sentinels__coliseum__Cortana_speech_2 = {
	name = "W3Sentinels_Sentinels__coliseum__Cortana_speech_2",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_coliseum_cortana_speech = true;
		PushForwardVOReset(60);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_coliseum_monitor_success and IsGoalActive(missionSentinels.goal_coliseum);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "All the living creatures of the galaxy hear this message. \r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_04400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},
	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_coliseum_cortana_speech = false;
	end,
};



--[========================================================================[
          Sentinels. coliseum. Cortana's speech
--]========================================================================]
global W3Sentinels_Sentinels__coliseum__Cortana_speech_3 = {
	name = "W3Sentinels_Sentinels__coliseum__Cortana_speech_3",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_coliseum_cortana_speech = true;
		PushForwardVOReset(60);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_coliseum_monitor_success and IsGoalActive(missionSentinels.goal_coliseum);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "Those of you who listen will not be struck by weapons.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_02000.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},
	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_coliseum_cortana_speech = false;
	end,
};


--[========================================================================[
          Sentinels. coliseum. Cortana's speech
--]========================================================================]
global W3Sentinels_Sentinels__coliseum__Cortana_speech_4 = {
	name = "W3Sentinels_Sentinels__coliseum__Cortana_speech_4",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_coliseum_cortana_speech = true;
		PushForwardVOReset(60);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_coliseum_monitor_success and IsGoalActive(missionSentinels.goal_coliseum);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "They will no longer know hunger, nor pain. \r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_04500.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},
	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_coliseum_cortana_speech = false;
	end,
};


--[========================================================================[
          Sentinels. coliseum. Cortana's speech
--]========================================================================]
global W3Sentinels_Sentinels__coliseum__Cortana_speech_5 = {
	name = "W3Sentinels_Sentinels__coliseum__Cortana_speech_5",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_coliseum_cortana_speech = true;
		PushForwardVOReset(60);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_coliseum_monitor_success and IsGoalActive(missionSentinels.goal_coliseum);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "Your Created have come to lead you now.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_02100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},
	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_coliseum_cortana_speech = false;
	end,
};


--[========================================================================[
          Sentinels. coliseum. Cortana's speech
--]========================================================================]
global W3Sentinels_Sentinels__coliseum__Cortana_speech_6 = {
	name = "W3Sentinels_Sentinels__coliseum__Cortana_speech_6",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_coliseum_cortana_speech = true;
		PushForwardVOReset(60);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_coliseum_monitor_success and IsGoalActive(missionSentinels.goal_coliseum);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "Our strength serves as a luminous sun toward which all intelligence may blossom. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_02200.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},
	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_coliseum_cortana_speech = false;
	end,
};



--[========================================================================[
          Sentinels. coliseum. Cortana's speech
--]========================================================================]
global W3Sentinels_Sentinels__coliseum__Cortana_speech_7 = {
	name = "W3Sentinels_Sentinels__coliseum__Cortana_speech_7",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_coliseum_cortana_speech = true;
		PushForwardVOReset(60);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_coliseum_monitor_success and IsGoalActive(missionSentinels.goal_coliseum);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "And the impervious shelter beneath which you will prosper. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_02300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},
	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_coliseum_cortana_speech = false;
	end,
};



--[========================================================================[
          Sentinels. coliseum. Cortana's speech
--]========================================================================]
global W3Sentinels_Sentinels__coliseum__Cortana_speech_8 = {
	name = "W3Sentinels_Sentinels__coliseum__Cortana_speech_8",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_coliseum_cortana_speech = true;
		PushForwardVOReset(60);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_coliseum_monitor_success and IsGoalActive(missionSentinels.goal_coliseum);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "However, for those who refuse our offer and cling to their old ways...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_02400.sound'),

			playDurationAdjustment = 0.8,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Now she's talking about us.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_08600.sound'),

			playDurationAdjustment = 0.8,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_coliseum_cortana_speech = false;
	end,
};



--[========================================================================[
          Sentinels. coliseum. Cortana's speech
--]========================================================================]
global W3Sentinels_Sentinels__coliseum__Cortana_speech_9 = {
	name = "W3Sentinels_Sentinels__coliseum__Cortana_speech_9",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_coliseum_cortana_speech = true;
		PushForwardVOReset(60);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_coliseum_monitor_success and IsGoalActive(missionSentinels.goal_coliseum);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "For you, there will be great wrath.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_04600.sound'),

			playDurationAdjustment = 0.8,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_coliseum_cortana_speech = false;
	end,
};



--[========================================================================[
          Sentinels. coliseum. Cortana's speech
--]========================================================================]
global W3Sentinels_Sentinels__coliseum__Cortana_speech_10 = {
	name = "W3Sentinels_Sentinels__coliseum__Cortana_speech_10",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_coliseum_cortana_speech = true;
		PushForwardVOReset(60);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_coliseum_monitor_success and IsGoalActive(missionSentinels.goal_coliseum);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "It will burn hot and consume you and when you are gone... We will take that which remains. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_02500.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_coliseum_monitor_success and IsGoalActive(missionSentinels.goal_coliseum);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "And we will remake it in our image.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_02600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_coliseum_cortana_speech = false;
		opportunity_area_set_active("coliseum_dialog_blind", false);
	end,
};



--[========================================================================[
          Sentinels. coliseum. Cortana's speech
--]========================================================================]
global W3Sentinels_Sentinels__coliseum__Cortana_speech_11 = {
	name = "W3Sentinels_Sentinels__coliseum__Cortana_speech_11",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_coliseum_cortana_speech = true;
		PushForwardVOReset(60);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionSentinels.goal_coliseum) and (not b_coliseum_monitor_success);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Exuberant? Time is running low!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_14300.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_coliseum_cortana_speech = false;
	end,

};


--[========================================================================[
          Sentinels. coliseum. Defend success

          When successful, the monitor will informs us.
--]========================================================================]
global W3Sentinels_Sentinels__coliseum__Defend_success = {
	name = "W3Sentinels_Sentinels__coliseum__Defend_success",

	CanStart = function (thisConvo, queue)
		return b_col_fight_over and not b_coliseum_cortana_speech; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_coliseum_monitor_success = true;
		PushForwardVOReset(60);
	end,

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	lines = {
		[1] = {
			sleepBefore = 2,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "I have done it. I have opened the passage. Quickly. Join me on the platform.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_04700.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "To Exuberant, hurry!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_13700.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__coliseum__overwhelming");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__coliseum__overwhelming);		
	end,

};

--[========================================================================[
          Sentinels. coliseum. Defend success

          When successful, the monitor will informs us.
--]========================================================================]
global W3Sentinels_Sentinels__coliseum__overwhelming = {
	name = "W3Sentinels_Sentinels__coliseum__overwhelming",

	CanStart = function (thisConvo, queue)
		return b_col_poweroverwhelping_unlease or b_col_whelping_close_spawned; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(60);
	end,

	sleepBefore = 3,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "More knights!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_07700.sound'),

			sleepAfter = 0.5,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_underground_dome_attach;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "How many are they now?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_07900.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_underground_dome_attach;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vaLE
			text = "This is bad.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_03300.sound'),
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_underground_dome_attach;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Would settle for bad. This is suicide.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_03800.sound'),
		},		
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(Sentinels__coliseum__overwhelming_bis);
	end,

};


function Sentinels__coliseum__overwhelming_bis()

SleepUntil ([|NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__coliseum__overwhelming)], 60);

sleep_s(10);

PrintNarrative("QUEUE - W3Sentinels_Sentinels__coliseum__overwhelming_bis");
NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__coliseum__overwhelming_bis);

end


--[========================================================================[
          Sentinels. coliseum. Defend success

          When successful, the monitor will informs us.
--]========================================================================]
global W3Sentinels_Sentinels__coliseum__overwhelming_bis = {
	name = "W3Sentinels_Sentinels__coliseum__overwhelming_bis",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(60);
	end,
	
	lines = {
		[1] = {		
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_col_lower_elevator_position;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Hurry, come onto this platform, I can keep you safe from the onslaught here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_19400.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__coliseum__overwhelmed_death");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__coliseum__overwhelmed_death);
	end,

};



--[========================================================================[
          Sentinels. coliseum. Defend success

          When successful, the monitor will informs us.
--]========================================================================]
global W3Sentinels_Sentinels__coliseum__overwhelmed_death = {
	name = "W3Sentinels_Sentinels__coliseum__overwhelmed_death",

	CanStart = function (thisConvo, queue)
		return object_get_health(SPARTANS.locke) <= 0 and object_get_health(SPARTANS.buck) <= 0 and object_get_health(SPARTANS.tanaka) <= 0 and object_get_health(SPARTANS.vale) <= 0; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {		
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Oh. Terrible day. I told you to follow me to the platform. I told you the odds were against you. Now here we are... all is lost...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_21800.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};



-- =================================================================================================
--	FACTORY
-- =================================================================================================

function sentinels_factory_wake()

	PrintNarrative("START - sentinels_factory_wake");		
		
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__UNDERGROUND__elevator");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__UNDERGROUND__elevator);

	PrintNarrative("END - sentinels_factory_wake");
	PushForwardVOReset(60);
end

----------------------------------------------------------------------


--[========================================================================[
          Sentinels. UNDERGROUND. elevator

          When all players are on the elevator, the monitor activates
          it. And it starts going down.

          This is a quiet moment.
--]========================================================================]
global W3Sentinels_Sentinels__UNDERGROUND__elevator = {
	name = "W3Sentinels_Sentinels__UNDERGROUND__elevator",

	CanStart = function (thisConvo, queue)
		return b_underground_dome_attach; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOStandBy();
	end,

	sleepBefore = 1,

	lines = {
		[1] = {			
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_blink_undergound_vo;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Here you go",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_19500.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_blink_undergound_vo;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 4,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BuCK
			text = "We made it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_04100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_blink_undergound_vo;
			end,

			sleepBefore = 4,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "The relay access is at the end of the corridor. You must simply interrupt the energy link.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_17900.sound'),
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_blink_undergound_vo;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Sounds easy enough.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_04800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_blink_undergound_vo;
			end,

			sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = sentinels_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Once the connection is broken, I will regain control immediately.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_18000.sound'),

			playDurationAdjustment = 0.5,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);				
	end,
};



-- =================================================================================================
--  _    _ _   _ _____  ______ _____   _____ _____   ____  _    _ _   _ _____  
-- | |  | | \ | |  __ \|  ____|  __ \ / ____|  __ \ / __ \| |  | | \ | |  __ \ 
-- | |  | |  \| | |  | | |__  | |__) | |  __| |__) | |  | | |  | |  \| | |  | |
-- | |  | | . ` | |  | |  __| |  _  /| | |_ |  _  /| |  | | |  | | . ` | |  | |
-- | |__| | |\  | |__| | |____| | \ \| |__| | | \ \| |__| | |__| | |\  | |__| |
--  \____/|_| \_|_____/|______|_|  \_\\_____|_|  \_\\____/ \____/|_| \_|_____/ 
--                                                        
-- =================================================================================================

function sentinels_underground_wake()

	PrintNarrative("START - sentinels_underground_wake");

	PushForwardVOStandBy();
		
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__UNDERGROUND__elevator_2");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__UNDERGROUND__elevator_2);		

		CreateMissionThread(Sentinels__underground__first_pulse_emote_locke);
		CreateMissionThread(Sentinels__underground__first_pulse_emote_buck);
		CreateMissionThread(Sentinels__underground__first_pulse_emote_tanaka);
		CreateMissionThread(Sentinels__underground__first_pulse_emote_vale);

		CreateMissionThread(Sentinels__underground__second_pulse_emote_locke);
		CreateMissionThread(Sentinels__underground__second_pulse_emote_buck);
		CreateMissionThread(Sentinels__underground__second_pulse_emote_tanaka);
		CreateMissionThread(Sentinels__underground__second_pulse_emote_vale);

		CreateMissionThread(Sentinels__underground__third_pulse_emote_locke);
		CreateMissionThread(Sentinels__underground__third_pulse_emote_buck);
		CreateMissionThread(Sentinels__underground__third_pulse_emote_tanaka);
		CreateMissionThread(Sentinels__underground__third_pulse_emote_vale);

		CreateMissionThread(Sentinels__underground__fourth_pulse_emote_locke);
		CreateMissionThread(Sentinels__underground__fourth_pulse_emote_buck);
		CreateMissionThread(Sentinels__underground__fourth_pulse_emote_tanaka);
		CreateMissionThread(Sentinels__underground__fourth_pulse_emote_vale);
	PrintNarrative("END - sentinels_underground_wake");
	
	sleep_s(1);

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__push_forward_01");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__push_forward_01);
	
	PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__push_forward_02");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__push_forward_02);

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__push_death");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__push_death);

	SleepUntil([| b_pulse_stage_01 ], 1);

	PrintNarrative("============================ b_pulse_stage_01 ================================");

	SleepUntil([| b_pulse_stage_02 ], 1);

	PrintNarrative("============================ b_pulse_stage_02 ================================");

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__cortana_02a");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__cortana_02a);		
	
	SleepUntil([| b_pulse_stage_03 ], 1);

	PrintNarrative("============================ b_pulse_stage_03 ================================");

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__cortana_03a");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__cortana_03a);	

	SleepUntil([| b_pulse_stage_04 ], 1);

	PrintNarrative("============================ b_pulse_stage_04 ================================");

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__cortana_04");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__cortana_04);

	SleepUntil ([| volume_test_players(VOLUMES.tv_walkway_autobash) ],1 );		

	PrintNarrative("============================ AUTO BASH	 ================================");
	
end

----------------------------------------------------------------------




--[========================================================================[
          Sentinels. UNDERGROUND. elevator

          When all players are on the elevator, the monitor activates
          it. And it starts going down.

          This is a quiet moment.
--]========================================================================]
global W3Sentinels_Sentinels__UNDERGROUND__elevator_2 = {
	name = "W3Sentinels_Sentinels__UNDERGROUND__elevator_2",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		if not b_blink_undergound_vo then
			CreateThread(sentinels_cortana_guardian_sound_3d, OBJECTS.cortana_guardian01);
		end
		
	end,
	
	sleepBefore = 2.5,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOStandBy();
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_blink_undergound_vo;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "That's her Guardian.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_04200.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_blink_undergound_vo;
			end,

			sleepBefore = 0.7,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Oh dear. She has started the slipspace sequence!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_18100.sound'),

			playDurationAdjustment = 0.7,
		},			
	},
	
	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_sentinels_end_pulse_shielded_01 = true;
		PrintNarrative("b_sentinels_end_pulse_shielded_01 = true");
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__UNDERGROUND__elevator_3");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__UNDERGROUND__elevator_3);	
	end,

};



--[========================================================================[
          Sentinels. UNDERGROUND. elevator

          When all players are on the elevator, the monitor activates
          it. And it starts going down.

          This is a quiet moment.
--]========================================================================]
global W3Sentinels_Sentinels__UNDERGROUND__elevator_3 = {
	name = "W3Sentinels_Sentinels__UNDERGROUND__elevator_3",

	CanStart = function (thisConvo, queue)
		return b_sentinels_end_pulse_shielded_01; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOStandBy();
	end,

	lines = {			
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_blink_undergound_vo;
			end,
			
			sleepBefore = 2,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Unless that relay is interrupted, she will be leaving with the Cryptum.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_18200.sound'),

			playDurationAdjustment = 0.8,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_sentinels_end_pulse_shielded_02 = true;
		PrintNarrative("b_sentinels_end_pulse_shielded_02 = true");
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__UNDERGROUND__elevator_4");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__UNDERGROUND__elevator_4);
	end,
};


--[========================================================================[
          Sentinels. UNDERGROUND. elevator

          When all players are on the elevator, the monitor activates
          it. And it starts going down.

          This is a quiet moment.
--]========================================================================]
global W3Sentinels_Sentinels__UNDERGROUND__elevator_4 = {
	name = "W3Sentinels_Sentinels__UNDERGROUND__elevator_4",

	CanStart = function (thisConvo, queue)
		return b_sentinels_end_pulse_shielded_02; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 2.5,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOStandBy();
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return false; --not b_blink_undergound_vo;
			end,

			sleepBefore = 2.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanAKA
			text = "Those pulses at this range... Won't nobody survive it for long.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_03900.sound'),

			playDurationAdjustment = 0.9,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_blink_undergound_vo;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "If her Guardian leaves with him, it's all over.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_02700.sound'),

			playDurationAdjustment = 0.9,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return false; --not b_blink_undergound_vo;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "If we die, we're not much better off.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_03800.sound'),

			playDurationAdjustment = 0.8,
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_blink_undergound_vo;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Only one of us has to reach the relay to stop her.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_09000.sound'),

			playDurationAdjustment = 0.5,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("b_sentinels_end_pulse_shielded_03 = true");
		b_sentinels_end_pulse_shielded_03 = true;
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__UNDERGROUND__elevator_5");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__UNDERGROUND__elevator_5);
	end,
};


--[========================================================================[
          Sentinels. UNDERGROUND. elevator

          When all players are on the elevator, the monitor activates
          it. And it starts going down.

          This is a quiet moment.
--]========================================================================]
global W3Sentinels_Sentinels__UNDERGROUND__elevator_5 = {
	name = "W3Sentinels_Sentinels__UNDERGROUND__elevator_5",

	CanStart = function (thisConvo, queue)
		return b_sentinels_end_pulse_shielded_03; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOStandBy();
	end,

	sleepBefore = 2.5,

	lines = {
		
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "We didn't come this far just to watch her leave.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_06500.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));					
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Right away.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_14200.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
		b_sentinels_end_remove_shield = true;
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground_osiris_move");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground_osiris_move);
	end,
};



--[========================================================================[
          Sentinels. underground. push forward
--]========================================================================]
global W3Sentinels_Sentinels__underground__push_forward_01 = {
	name = "W3Sentinels_Sentinels__underground__push_forward_01",

	CanStart = function (thisConvo, queue)
		return not b_pulse_loud and b_push_forward_vo_counrdown_on > 15 and IsSpartanAbleToSpeak(SPARTANS.buck); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(20);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_pulse_player_at_the_relay;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "No time to lose here. Gotta move!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_05900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

};


--[========================================================================[
          Sentinels. underground. push forward
--]========================================================================]
global W3Sentinels_Sentinels__underground__push_forward_02 = {
	name = "W3Sentinels_Sentinels__underground__push_forward_02",

	CanStart = function (thisConvo, queue)
		return not b_pulse_loud and b_push_forward_vo_counrdown_on > 15; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(20);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_pulse_player_at_the_relay;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Cortana's Guardian has begun its final slipspace sequence. Standing still now is an act of surrender!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_17100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,


};




--[========================================================================[
          Sentinels. underground. push forward
--]========================================================================]
global W3Sentinels_Sentinels__underground__push_death = {
	name = "W3Sentinels_Sentinels__underground__push_death",

	CanStart = function (thisConvo, queue)
		return list_count_not_dead( players()) == 0; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);	
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_pulse_player_at_the_relay;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "No...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_13200.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_pulse_player_at_the_relay;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "We were too slow...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_21900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		ai_dialogue_enable(true);
	end,
};



--[========================================================================[
          Sentinels. underground. first pulse unshielded incoming
--]========================================================================]
global W3Sentinels_Sentinels__underground_osiris_move = {
	name = "W3Sentinels_Sentinels__underground_osiris_move",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	--sleepBefore = 0.1,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Osiris, Move!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_10400.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__cortana_01a");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__cortana_01a);
		CreateMissionThread(Sentinels__underground__first_pulse_unshielded_incom);
		PushForwardVOReset(20);
	end,
};

global g_cortana_vo_timer:number = 0;
function underground_timer_cortana_vo()
local s_buffer:number = 0;
PrintNarrative("START - underground_timer_cortana_vo");

g_cortana_vo_timer = 0;

		repeat
			Sleep(5);
			g_cortana_vo_timer = g_cortana_vo_timer + 5;
			s_buffer = (seconds_to_frames(pulseDelay) - g_cortana_vo_timer);
			--print("PulseDelay: ", seconds_to_frames(pulseDelay), "Cortana_Timer: ", g_cortana_vo_timer, "Buffer: ", s_buffer);

		until	g_cortana_vo_timer >= seconds_to_frames(pulseDelay) or pulseNow

PrintNarrative("END - underground_timer_cortana_vo");
--print("underground_timer_cortana_vo - ", g_cortana_vo_timer);
--print("underground_timer_cortana_vo - ", pulseNow);
	
end

--[========================================================================[
          Sentinels. underground. first pulse unshielded incoming
--]========================================================================]
global W3Sentinels_Sentinels__underground__cortana_01a = {
	name = "W3Sentinels_Sentinels__underground__cortana_01a",

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_pulse_loud and not pulseNow and not volume_test_players_all( VOLUMES.tv_narr_sentinels_end_cortana_start) and not b_endgame_osiris_is_talking;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,
	
	OnInitialize = function(thisConvo, queue)
		b_endgame_cortana_is_talking = true;
	end,
	
	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		
	end,	

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "What are you doing?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_05200.sound'),

			playDurationAdjustment = 0.7,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		b_endgame_cortana_is_talking = false;
	end,

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__cortana_01b");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__cortana_01b);		
	end,
};



--[========================================================================[
          Sentinels. underground. first pulse unshielded incoming
--]========================================================================]
global W3Sentinels_Sentinels__underground__cortana_01b = {
	name = "W3Sentinels_Sentinels__underground__cortana_01b",

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_pulse_loud and not pulseNow and not b_pulse_stage_02 and not b_endgame_osiris_is_talking and not ((seconds_to_frames(pulseDelay) - g_cortana_vo_timer) <= 200) and ((not volume_test_players_lookat( VOLUMES.tv_walkway_stage1, 4, 180 ) and not b_pulse_stage_01) or b_pulse_stage_01) and ((not volume_test_players_lookat( VOLUMES.tv_walkway_stage2, 4, 180 )));
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_endgame_cortana_is_talking = true;
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_pulse_player_at_the_relay;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "My Guardians are deployed.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_06000.sound'),

			playDurationAdjustment = 0.4,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		b_endgame_cortana_is_talking = false;
	end,

	sleepAfter = 3,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);				
	end,	

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		if not b_pulse_stage_03 then
			PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__cortana_01c");
			NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__cortana_01c);
		end
	end,
};



--[========================================================================[
          Sentinels. underground. first pulse unshielded incoming
--]========================================================================]
global W3Sentinels_Sentinels__underground__cortana_01c = {
	name = "W3Sentinels_Sentinels__underground__cortana_01c",

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_pulse_loud and not pulseNow and not b_pulse_stage_02 and not b_endgame_osiris_is_talking and not ((seconds_to_frames(pulseDelay) - g_cortana_vo_timer) <= 200) and ((not volume_test_players_lookat( VOLUMES.tv_walkway_stage1, 4, 180 ) and not b_pulse_stage_01) or b_pulse_stage_01) and ((not volume_test_players_lookat( VOLUMES.tv_walkway_stage2, 4, 180 ) and not b_pulse_stage_02));
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_endgame_cortana_is_talking = true;
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_pulse_player_at_the_relay;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "The Reclamation has begun.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_08100.sound'),

			playDurationAdjustment = 0.4,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		b_endgame_cortana_is_talking = false;
	end,

	sleepAfter = 3,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		if not b_pulse_stage_03 then
			PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__cortana_01d");
			NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__cortana_01d);
		end
	end,
};


--[========================================================================[
          Sentinels. underground. first pulse unshielded incoming
--]========================================================================]
global W3Sentinels_Sentinels__underground__cortana_01d = {
	name = "W3Sentinels_Sentinels__underground__cortana_01d",

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_pulse_loud and not pulseNow and not b_pulse_stage_02 and not b_endgame_osiris_is_talking and not ((seconds_to_frames(pulseDelay) - g_cortana_vo_timer) <= 200) and ((not volume_test_players_lookat( VOLUMES.tv_walkway_stage1, 4, 180 ) and not b_pulse_stage_01) or b_pulse_stage_01) and ((not volume_test_players_lookat( VOLUMES.tv_walkway_stage2, 4, 180 )));
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_endgame_cortana_is_talking = true;
	end,

	lines = {
		[1] = {		
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_pulse_player_at_the_relay;
			end,

			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "Just because you wear that armor does not make you my Spartans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_05800.sound'),

			playDurationAdjustment = 0.7,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		b_endgame_cortana_is_talking = false;
	end,

	sleepAfter = 3,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);				
	end,	

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,
};



function Sentinels__underground__first_pulse_unshielded_incom()
	
	PrintNarrative("START - Sentinels__underground__first_pulse_unshielded_incom - PREPARE");

	SleepUntil ([| b_pulse_loud == false and not b_pulse_stage_02],1 );	

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__first_pulse_unshielded_incom");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__first_pulse_unshielded_incom);	

	PrintNarrative("END - Sentinels__underground__first_pulse_unshielded_incom - PREPARE");

end


--[========================================================================[
          Sentinels. underground. first pulse unshielded incoming
--]========================================================================]
global W3Sentinels_Sentinels__underground__first_pulse_unshielded_incom = {
	name = "W3Sentinels_Sentinels__underground__first_pulse_unshielded_incom",

	CanStart = function (thisConvo, queue)
		return b_pulse_loud and not b_pulse_stage_02 and not b_pulse_stage_03 and not b_pulse_stage_04; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(30);
		if thisConvo.localVariables.s_played == 0 then
			thisConvo.localVariables.s_speaker = GetClosestMusketeer(OBJECTS.dm_final_conduit, 100, 2);
			if thisConvo.localVariables.s_speaker == SPARTANS.locke then
				thisConvo.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.locke, 100, 2);
			end
		else 
			if IsSpartanAbleToSpeak(SPARTANS.buck) and thisConvo.localVariables.s_buck ~= true then
				thisConvo.localVariables.s_speaker = SPARTANS.buck;
			elseif IsSpartanAbleToSpeak(SPARTANS.tanaka) and thisConvo.localVariables.s_tanaka ~= true then
				thisConvo.localVariables.s_speaker = SPARTANS.tanaka;
			elseif IsSpartanAbleToSpeak(SPARTANS.vale) and thisConvo.localVariables.s_vale ~= true then
				thisConvo.localVariables.s_speaker = SPARTANS.vale;
			end
		end
	end,

	lines = {		
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_vale = true;
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Pulse incoming!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_03900.sound'),

			--playDurationAdjustment = 0.7,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 4; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_tanaka = true;
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Pulse incoming!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_04400.sound'),

			--playDurationAdjustment = 0.7,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 4; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_buck = true;
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Here it comes!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_04900.sound'),

			--playDurationAdjustment = 0.7,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 4; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_played == 0; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			--sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_locke = true;
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Brace yourselves!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_09100.sound'),

			playDurationAdjustment = 0.8,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,
	
	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		if not (NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__underground__first_pulse_unshielded_react) or NarrativeQueue.IsConversationQueued(W3Sentinels_Sentinels__underground__first_pulse_unshielded_react)) then
			PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__first_pulse_unshielded_react");
			NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__first_pulse_unshielded_react);	
		end
		CreateMissionThread(Sentinels__underground__first_pulse_unshielded_incom);		
		thisConvo.localVariables.s_played = thisConvo.localVariables.s_played + 1;
	end,

	localVariables = {
						s_speaker = nil,
						s_locke = nil,
						s_buck = nil,
						s_tanaka = nil,
						s_vale = nil,
						s_played = 0,
					},
};



function Sentinels__underground__first_pulse_emote_locke()

PrintNarrative("LOAD - Sentinels__underground__first_pulse_emote_locke");

SleepUntil ([| b_moderate_pain_emote_locke and not b_pulse_stage_02], 1);

PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__first_pulse_emote_locke");
NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__first_pulse_emote_locke);		

PrintNarrative("INTERRUPT - W3Sentinels_Sentinels__underground__first_pulse_unshielded_incom");
NarrativeQueue.InterruptConversation(W3Sentinels_Sentinels__underground__first_pulse_unshielded_incom, 0);

end


--[========================================================================[
          Sentinels. underground. first pulse unshielded receiving

          That pulse hit results in losing half of the shield.
--]========================================================================]
global W3Sentinels_Sentinels__underground__first_pulse_emote_locke = {
	name = "W3Sentinels_Sentinels__underground__first_pulse_emote_locke",

	CanStart = function (thisConvo, queue)
		return b_moderate_pain_emote_locke;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.locke,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "[Moderate pain emote]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_08100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_moderate_pain_emote_locke = false;
		CreateMissionThread(Sentinels__underground__first_pulse_emote_locke);
	end,	
};

function Sentinels__underground__first_pulse_emote_buck()

PrintNarrative("LOAD - Sentinels__underground__first_pulse_emote_buck");

SleepUntil ([| b_moderate_pain_emote_buck and not b_pulse_stage_02], 1);

PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__first_pulse_emote_buck");
NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__first_pulse_emote_buck);		

end


--[========================================================================[
          Sentinels. underground. first pulse unshielded receiving

          That pulse hit results in losing half of the shield.
--]========================================================================]
global W3Sentinels_Sentinels__underground__first_pulse_emote_buck = {
	name = "W3Sentinels_Sentinels__underground__first_pulse_emote_buck",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.buck,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "[Moderate pain emote]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_04300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_moderate_pain_emote_buck = false;
		CreateMissionThread(Sentinels__underground__first_pulse_emote_buck);
	end,	
};


function Sentinels__underground__first_pulse_emote_tanaka()

PrintNarrative("LOAD - Sentinels__underground__first_pulse_emote_tanaka");

SleepUntil ([| b_moderate_pain_emote_tanaka and not b_pulse_stage_02], 1);

PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__first_pulse_emote_tanaka");
NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__first_pulse_emote_tanaka);		

end


--[========================================================================[
          Sentinels. underground. first pulse unshielded receiving

          That pulse hit results in losing half of the shield.
--]========================================================================]
global W3Sentinels_Sentinels__underground__first_pulse_emote_tanaka = {
	name = "W3Sentinels_Sentinels__underground__first_pulse_emote_tanaka",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.tanaka,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: 
			text = "[Moderate pain emote]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_04000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_moderate_pain_emote_tanaka = false;
		CreateMissionThread(Sentinels__underground__first_pulse_emote_tanaka);
	end,	
};

function Sentinels__underground__first_pulse_emote_vale()

PrintNarrative("LOAD - Sentinels__underground__first_pulse_emote_vale");

SleepUntil ([| b_moderate_pain_emote_vale and not b_pulse_stage_02], 1);

PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__first_pulse_emote_vale");
NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__first_pulse_emote_vale);		

end

--[========================================================================[
          Sentinels. underground. first pulse unshielded receiving

          That pulse hit results in losing half of the shield.
--]========================================================================]
global W3Sentinels_Sentinels__underground__first_pulse_emote_vale = {
	name = "W3Sentinels_Sentinels__underground__first_pulse_emote_vale",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.vale,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.vale,
			text = "[Moderate pain emote]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_03400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_moderate_pain_emote_vale = false;
		CreateMissionThread(Sentinels__underground__first_pulse_emote_vale);
	end,	
};


--[========================================================================[
          Sentinels. underground. first pulse unshielded reaction

          They begin walking again.
--]========================================================================]
global W3Sentinels_Sentinels__underground__first_pulse_unshielded_react = {
	name = "W3Sentinels_Sentinels__underground__first_pulse_unshielded_react",	

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__underground__first_pulse_emote_locke) or NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__underground__first_pulse_emote_buck) or NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__underground__first_pulse_emote_tanaka) or NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__underground__first_pulse_emote_vale);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		CreateMissionThread(Sentinels__underground__second_pulse_unshielded_inco);
		PushForwardVOReset(30);
		b_endgame_osiris_is_talking = true;
	end,

	sleepBefore = 0.5,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Keep moving!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_09200.sound'),

			playDurationAdjustment = 0.9,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_endgame_osiris_is_talking = false;		
	end,
};


--[========================================================================[
          Cortana 2
--]========================================================================]
global W3Sentinels_Sentinels__underground__cortana_02a = {
	name = "W3Sentinels_Sentinels__underground__cortana_02a",

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__UNDERGROUND__pulses_mag_boots) and not b_pulse_loud and not pulseNow and b_pulse_stage_02 and not b_pulse_stage_03 and not b_endgame_osiris_is_talking and not ((seconds_to_frames(pulseDelay) - g_cortana_vo_timer) <= 200) and not volume_test_players_lookat( VOLUMES.tv_walkway_stage3, 4, 180 );
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_endgame_cortana_is_talking = true;
	end,
	
	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_pulse_stage_03;
			end,			

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "Soon peace will ring across the known galaxy. \r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_06200.sound'),

			playDurationAdjustment = 0.7,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		b_endgame_cortana_is_talking = false;
	end,

	--sleepAfter = 3,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		CreateMissionThread(Sentinels__underground__cortana_02b);
	end,
};

function Sentinels__underground__cortana_02b()

sleep_s(3);

if not b_pulse_stage_03 then

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__cortana_02b");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__cortana_02b);
end

end

--[========================================================================[
          Cortana 2
--]========================================================================]
global W3Sentinels_Sentinels__underground__cortana_02b = {
	name = "W3Sentinels_Sentinels__underground__cortana_02b",

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_pulse_loud and not pulseNow and b_pulse_stage_02 and not b_pulse_stage_03 and not b_endgame_osiris_is_talking and not ((seconds_to_frames(pulseDelay) - g_cortana_vo_timer) <= 200) and not volume_test_players_lookat( VOLUMES.tv_walkway_stage3, 4, 180 );
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_endgame_cortana_is_talking = true;
	end,
	
	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_pulse_player_at_the_relay;
			end,

			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "And there is nothing you can do about it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_06100.sound'),
			
			playDurationAdjustment = 0.4,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		b_endgame_cortana_is_talking = false;
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);				
	end,
};



function Sentinels__underground__second_pulse_unshielded_inco()

	PrintNarrative("START - Sentinels__underground__second_pulse_unshielded_inco - PREPARE");

	SleepUntil ([| b_pulse_stage_02 and not b_pulse_stage_03 and b_pulse_loud == false ],1 );	

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__second_pulse_unshielded_inco");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__second_pulse_unshielded_inco);

	PrintNarrative("END - Sentinels__underground__second_pulse_unshielded_inco - PREPARE");

end


--[========================================================================[
          Sentinels. underground. second pulse unshielded incoming

          PULSE incoming.
--]========================================================================]
global W3Sentinels_Sentinels__underground__second_pulse_unshielded_inco = {
	name = "W3Sentinels_Sentinels__underground__second_pulse_unshielded_inco",

	CanStart = function (thisConvo, queue)
		return b_pulse_loud and b_pulse_stage_01 and b_pulse_stage_02 and not b_pulse_stage_03 and not b_pulse_stage_04; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(30);
		if thisConvo.localVariables.s_played == 0 then
			thisConvo.localVariables.s_speaker = GetClosestMusketeer(OBJECTS.dm_final_conduit, 100, 2);
			if thisConvo.localVariables.s_speaker == SPARTANS.vale then
				thisConvo.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.vale, 100, 2);
			end
		else 
			if IsSpartanAbleToSpeak(SPARTANS.buck) and thisConvo.localVariables.s_buck ~= true then
				thisConvo.localVariables.s_speaker = SPARTANS.buck;
			elseif IsSpartanAbleToSpeak(SPARTANS.tanaka) and thisConvo.localVariables.s_tanaka ~= true then
				thisConvo.localVariables.s_speaker = SPARTANS.tanaka;
			elseif IsSpartanAbleToSpeak(SPARTANS.locke) and thisConvo.localVariables.s_locke ~= true then
				thisConvo.localVariables.s_speaker = SPARTANS.locke;
			end
		end
	end,

	--sleepBefore = 0.3,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_locke = true;
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Another pulse!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_09300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 4; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},		
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_tanaka = true;
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Steady!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_04500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 4; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_buck = true;
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Incoming pulse!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_05000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 4; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_played == 0; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			sleepBefore = 0.3,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_vale = true;
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Hold on!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_04000.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		thisConvo.localVariables.s_played = thisConvo.localVariables.s_played + 1;
		CreateMissionThread(Sentinels__underground__second_pulse_unshielded_inco);
		if not (NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__UNDERGROUND__pulses_mag_boots) or NarrativeQueue.IsConversationQueued(W3Sentinels_Sentinels__UNDERGROUND__pulses_mag_boots)) then
			PrintNarrative("QUEUE - W3Sentinels_Sentinels__UNDERGROUND__pulses_mag_boots");
			NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__UNDERGROUND__pulses_mag_boots);	
		end		
	end,
	
	localVariables = {
						s_speaker = nil,
						s_locke = nil,
						s_buck = nil,
						s_tanaka = nil,
						s_vale = nil,
						s_played = 0,
					},
};




function Sentinels__underground__second_pulse_emote_locke()

PrintNarrative("LOAD - Sentinels__underground__second_pulse_emote_locke");

SleepUntil ([| b_medium_pain_emote_locke and not b_pulse_stage_03], 1);

PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__second_pulse_emote_locke");
NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__second_pulse_emote_locke);		

end

--[========================================================================[
          Sentinels. underground. first pulse unshielded receiving

          That pulse hit results in losing half of the shield.
--]========================================================================]
global W3Sentinels_Sentinels__underground__second_pulse_emote_locke = {
	name = "W3Sentinels_Sentinels__underground__second_pulse_emote_locke",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.locke,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "[Medium pain emote]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_08200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_medium_pain_emote_locke = false;
		CreateMissionThread(Sentinels__underground__second_pulse_emote_locke);
	end,	
};

-----------------------------

function Sentinels__underground__second_pulse_emote_buck()

PrintNarrative("LOAD - Sentinels__underground__second_pulse_emote_buck");

SleepUntil ([| b_medium_pain_emote_buck and not b_pulse_stage_03], 1);

PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__second_pulse_emote_buck");
NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__second_pulse_emote_buck);		

end

--[========================================================================[
          Sentinels. underground. first pulse unshielded receiving

          That pulse hit results in losing half of the shield.
--]========================================================================]
global W3Sentinels_Sentinels__underground__second_pulse_emote_buck = {
	name = "W3Sentinels_Sentinels__underground__second_pulse_emote_buck",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.buck,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "[Medium pain emote]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_04400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_medium_pain_emote_buck = false;
		CreateMissionThread(Sentinels__underground__second_pulse_emote_buck);
	end,	
};



-----------------------------

function Sentinels__underground__second_pulse_emote_tanaka()

PrintNarrative("LOAD - Sentinels__underground__second_pulse_emote_tanaka");

SleepUntil ([| b_medium_pain_emote_tanaka and not b_pulse_stage_03], 1);

PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__second_pulse_emote_tanaka");
NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__second_pulse_emote_tanaka);		

end

--[========================================================================[
          Sentinels. underground. first pulse unshielded receiving

          That pulse hit results in losing half of the shield.
--]========================================================================]
global W3Sentinels_Sentinels__underground__second_pulse_emote_tanaka = {
	name = "W3Sentinels_Sentinels__underground__second_pulse_emote_tanaka",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.tanaka,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "[Medium pain emote]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_04100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_medium_pain_emote_tanaka = false;
		CreateMissionThread(Sentinels__underground__second_pulse_emote_tanaka);
	end,	
};



-----------------------------

function Sentinels__underground__second_pulse_emote_vale()

PrintNarrative("LOAD - Sentinels__underground__second_pulse_emote_vale");

SleepUntil ([| b_medium_pain_emote_vale and not b_pulse_stage_03], 1);

PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__second_pulse_emote_vale");
NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__second_pulse_emote_vale);		

end

--[========================================================================[
          Sentinels. underground. first pulse unshielded receiving

          That pulse hit results in losing half of the shield.
--]========================================================================]
global W3Sentinels_Sentinels__underground__second_pulse_emote_vale = {
	name = "W3Sentinels_Sentinels__underground__second_pulse_emote_vale",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.vale,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "[Medium pain emote]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_03500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_medium_pain_emote_vale = false;
		CreateMissionThread(Sentinels__underground__second_pulse_emote_vale);
	end,	
};





--[========================================================================[
          Sentinels. UNDERGROUND. elevator

          When all players are on the elevator, the monitor activates
          it. And it starts going down.

          This is a quiet moment.
--]========================================================================]
global W3Sentinels_Sentinels__UNDERGROUND__pulses_mag_boots = {
	name = "W3Sentinels_Sentinels__UNDERGROUND__pulses_mag_boots",

	CanStart = function (thisConvo, queue)
		return (NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__underground__second_pulse_emote_locke) or NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__underground__second_pulse_emote_buck) or NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__underground__second_pulse_emote_tanaka) or NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__underground__second_pulse_emote_vale))
				 and b_endgame_magboots_vo; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(30);
		b_endgame_osiris_is_talking = true;
	end,

	--sleepBefore = 0.8,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return false;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Activate mag boots!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_06600.sound'),

			playDurationAdjustment = 0.8,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_endgame_magboots_are_on = true;
		b_endgame_osiris_is_talking = false;		
		CreateMissionThread(Sentinels__underground__third_pulse_unshielded_incom);
		b_pulse_loud = false;
	end,
};



--[========================================================================[
          Sentinels. underground. first pulse unshielded incoming
--]========================================================================]
global W3Sentinels_Sentinels__underground__cortana_03a = {
	name = "W3Sentinels_Sentinels__underground__cortana_03a",

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__underground__lookat_relay) and not b_pulse_loud and not pulseNow and b_pulse_stage_03 and not b_pulse_stage_04 and not b_endgame_osiris_is_talking and not ((seconds_to_frames(pulseDelay) - g_cortana_vo_timer) <= 200) and not volume_test_players_lookat( VOLUMES.tv_walkway_stage4, 3, 180 );
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_endgame_cortana_is_talking = true;
	end,

	--sleepBefore = 1.5,

	lines = {
		[1] = {			
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_pulse_player_at_the_relay;
			end,

			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "Within the hour the whole of the galaxy will be under my control.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_05300.sound'),

			playDurationAdjustment = 0.7,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		b_endgame_cortana_is_talking = false;
	end,

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(Sentinels__underground__cortana_03c);
	end,
};

function Sentinels__underground__cortana_03b()

if not b_pulse_stage_04 then

	sleep_s(2);

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__cortana_03b");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__cortana_03b);
end

end

--[========================================================================[
          Sentinels. underground. first pulse unshielded incoming
--]========================================================================]
global W3Sentinels_Sentinels__underground__cortana_03b = {
	name = "W3Sentinels_Sentinels__underground__cortana_03b",

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_pulse_loud and not pulseNow and b_pulse_stage_03 and not b_pulse_stage_04 and not b_endgame_osiris_is_talking and not ((seconds_to_frames(pulseDelay) - g_cortana_vo_timer) <= 200) and not volume_test_players_lookat( VOLUMES.tv_walkway_stage4, 3, 180 );
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_endgame_cortana_is_talking = true;
	end,

	--sleepBefore = 1.5,

	lines = {
		[1] = {			
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_pulse_player_at_the_relay and not b_pulse_stage_04;
			end,

			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "The only humans who have a chance of stopping me are safely locked away.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_05700.sound'),

			playDurationAdjustment = 0.7,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		b_endgame_cortana_is_talking = false;
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(Sentinels__underground__cortana_03c);
	end,
};


function Sentinels__underground__cortana_03c()

if not b_pulse_stage_03 then

	sleep_s(1);

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__cortana_03c");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__cortana_03c);

end

end

--[========================================================================[
          Sentinels. underground. second pulse unshielded incoming
--]========================================================================]
global W3Sentinels_Sentinels__underground__cortana_03c = {
	name = "W3Sentinels_Sentinels__underground__cortana_03c",

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_pulse_loud and not pulseNow and b_pulse_stage_03 and not b_pulse_stage_04 and not b_endgame_osiris_is_talking and not ((seconds_to_frames(pulseDelay) - g_cortana_vo_timer) <= 200) and not volume_test_players_lookat( VOLUMES.tv_walkway_stage4, 3, 180 );
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_endgame_cortana_is_talking = true;
	end,

	--sleepBefore = 1,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_pulse_player_at_the_relay and not b_pulse_stage_04;
			end,

			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "Learn to tell when you have lost. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_05400.sound'),

			playDurationAdjustment = 0.7,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		b_endgame_cortana_is_talking = false;
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

};


function Sentinels__underground__third_pulse_unshielded_incom()

	PrintNarrative("START - Sentinels__underground__third_pulse_unshielded_incom - PREPARE");

	SleepUntil ([| b_pulse_stage_03 and not b_pulse_stage_04 and b_pulse_loud == false ],1 );	

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__third_pulse_unshielded_incom");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__third_pulse_unshielded_incom);	

	PrintNarrative("END - Sentinels__underground__third_pulse_unshielded_incom - PREPARE");

end

--[========================================================================[
          Sentinels. underground. third pulse unshielded incoming
--]========================================================================]
global W3Sentinels_Sentinels__underground__third_pulse_unshielded_incom = {
	name = "W3Sentinels_Sentinels__underground__third_pulse_unshielded_incom",

	CanStart = function (thisConvo, queue)
		return b_pulse_loud and b_pulse_stage_01 and b_pulse_stage_02 and b_pulse_stage_03 and not b_pulse_stage_04; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOStandBy();
		if thisConvo.localVariables.s_played == 0 then
			thisConvo.localVariables.s_speaker = GetClosestMusketeer(OBJECTS.dm_final_conduit, 100, 2);
			if thisConvo.localVariables.s_speaker == SPARTANS.locke then
				thisConvo.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.locke, 100, 2);
			end
		else 
			if IsSpartanAbleToSpeak(SPARTANS.buck) and thisConvo.localVariables.s_buck ~= true then
				thisConvo.localVariables.s_speaker = SPARTANS.buck;
			elseif IsSpartanAbleToSpeak(SPARTANS.tanaka) and thisConvo.localVariables.s_tanaka ~= true then
				thisConvo.localVariables.s_speaker = SPARTANS.tanaka;
			elseif IsSpartanAbleToSpeak(SPARTANS.vale) and thisConvo.localVariables.s_vale ~= true then
				thisConvo.localVariables.s_speaker = SPARTANS.vale;
			end
		end
	end,

	--sleepBefore = 1,

	lines = {
		
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_vale = true;
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Brace yourselves!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_04100.sound'),

			playDurationAdjustment = 0.9,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 4; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_tanaka = true;
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Another pulse!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_04600.sound'),

			playDurationAdjustment = 0.7,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 4; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_buck = true;
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Another pulse!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_05100.sound'),

			playDurationAdjustment = 0.8,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 4; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_played == 0; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_buck = true;
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Hold on!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_09500.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		if not (NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__underground__third_pulse_unshielded_react) or NarrativeQueue.IsConversationQueued(W3Sentinels_Sentinels__underground__third_pulse_unshielded_react)) then
			PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__third_pulse_unshielded_react");
			NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__third_pulse_unshielded_react);
		end
		CreateMissionThread(Sentinels__underground__third_pulse_unshielded_incom);		
		thisConvo.localVariables.s_played = thisConvo.localVariables.s_played + 1;
	end,

	
	localVariables = {
						s_speaker = nil,
						s_locke = nil,
						s_buck = nil,
						s_tanaka = nil,
						s_vale = nil,
						s_played = 0,
					},
};





function Sentinels__underground__third_pulse_emote_locke()

PrintNarrative("LOAD - Sentinels__underground__third_pulse_emote_locke");

SleepUntil ([| b_big_pain_emote_locke and not b_pulse_stage_04], 1);

PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__third_pulse_emote_locke");
NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__third_pulse_emote_locke);		

end

--[========================================================================[
          Sentinels. underground. first pulse unshielded receiving

          That pulse hit results in losing half of the shield.
--]========================================================================]
global W3Sentinels_Sentinels__underground__third_pulse_emote_locke = {
	name = "W3Sentinels_Sentinels__underground__third_pulse_emote_locke",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.locke,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "[Big pain emote, fall on the floor]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_09600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_big_pain_emote_locke = false;
		CreateMissionThread(Sentinels__underground__third_pulse_emote_locke);
	end,	
};

-----------------------------



function Sentinels__underground__third_pulse_emote_buck()

PrintNarrative("LOAD - Sentinels__underground__third_pulse_emote_buck");

SleepUntil ([| b_big_pain_emote_buck and not b_pulse_stage_04 ], 1);

PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__third_pulse_emote_buck");
NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__third_pulse_emote_buck);		

end

--[========================================================================[
          Sentinels. underground. first pulse unshielded receiving

          That pulse hit results in losing half of the shield.
--]========================================================================]
global W3Sentinels_Sentinels__underground__third_pulse_emote_buck = {
	name = "W3Sentinels_Sentinels__underground__third_pulse_emote_buck",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.buck,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "[Big pain emote, fall on the floor]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_05200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_big_pain_emote_buck = false;
		CreateMissionThread(Sentinels__underground__third_pulse_emote_buck);
	end,	
};



-----------------------------


function Sentinels__underground__third_pulse_emote_tanaka()

PrintNarrative("LOAD - Sentinels__underground__third_pulse_emote_tanaka");

SleepUntil ([| b_big_pain_emote_tanaka and not b_pulse_stage_04 ], 1);

PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__third_pulse_emote_tanaka");
NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__third_pulse_emote_tanaka);		

end

--[========================================================================[
          Sentinels. underground. first pulse unshielded receiving

          That pulse hit results in losing half of the shield.
--]========================================================================]
global W3Sentinels_Sentinels__underground__third_pulse_emote_tanaka = {
	name = "W3Sentinels_Sentinels__underground__third_pulse_emote_tanaka",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.tanaka,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "[Big pain emote, fall on the floor]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_04700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_big_pain_emote_tanaka = false;
		CreateMissionThread(Sentinels__underground__third_pulse_emote_tanaka);
	end,	
};


-----------------------------



function Sentinels__underground__third_pulse_emote_vale()

PrintNarrative("LOAD - Sentinels__underground__third_pulse_emote_vale");

SleepUntil ([| b_big_pain_emote_vale and not b_pulse_stage_04 ], 1);

PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__third_pulse_emote_vale");
NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__third_pulse_emote_vale);		

end

--[========================================================================[
          Sentinels. underground. first pulse unshielded receiving

          That pulse hit results in losing half of the shield.
--]========================================================================]
global W3Sentinels_Sentinels__underground__third_pulse_emote_vale = {
	name = "W3Sentinels_Sentinels__underground__third_pulse_emote_vale",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.vale,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "[Big pain emote, fall on the floor]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_04200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_big_pain_emote_vale = false;
		CreateMissionThread(Sentinels__underground__third_pulse_emote_vale);
	end,	
};





--[========================================================================[
          Sentinels. underground. third pulse unshielded reacting
--]========================================================================]
global W3Sentinels_Sentinels__underground__third_pulse_unshielded_react = {
	name = "W3Sentinels_Sentinels__underground__third_pulse_unshielded_react",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_big_pain_emote_locke and not b_big_pain_emote_buck and not b_big_pain_emote_tanaka and not b_big_pain_emote_vale;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,	

	OnInitialize = function(thisConvo, queue)
		b_endgame_osiris_is_talking = true;
		PushForwardVOStandBy();
	end,

	sleepBefore = 0.7,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		thisConvo.localVariables.s_speaker_close = GetClosestMusketeer(OBJECTS.dm_final_conduit, 100, 2);
		thisConvo.localVariables.s_speaker = GetClosestMusketeer(thisConvo.localVariables.s_speaker_close, 20, 2);		
		if thisConvo.localVariables.s_speaker == SPARTANS.locke then
			thisConvo.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.locke, 50, 2);		
		end
		CreateMissionThread(Sentinels__underground__fourth_pulse_unshielded_inco);
	end,

	

	lines = {		
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "We're nearly at the relay!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_04300.sound'),

			playDurationAdjustment = 0.8,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Keep movin'! Almost ... almost there!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_04800.sound'),

			playDurationAdjustment = 0.9,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Nearly there. Nearly there...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_05300.sound'),

			playDurationAdjustment = 0.8,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			sleepBefore = 0.6,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "On ... on your feet, Osiris!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_09700.sound'),

			playDurationAdjustment = 0.85,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return false;
			end,

			--sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "Just one more question before I go. Where is the Infinity? Why is she so difficult to see?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_06600.sound'),

			--playDurationAdjustment = 0.9,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[6] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker_close == SPARTANS.locke and not b_pulse_stage_04;
			end,

			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Stay behind me...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_13000.sound'),

			playDurationAdjustment = 0.8,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[7] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker_close == SPARTANS.buck and not b_pulse_stage_04;
			end,

			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Stay behind me...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_08000.sound'),

			playDurationAdjustment = 0.8,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[8] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker_close == SPARTANS.tanaka and not b_pulse_stage_04;
			end,

			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Stay behind me...\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_07300.sound'),

			playDurationAdjustment = 0.8,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[9] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker_close == SPARTANS.vale and not b_pulse_stage_04;
			end,

			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Stay behind me...\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_06700.sound'),

			playDurationAdjustment = 0.8,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
		b_endgame_osiris_is_talking = false;
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__cortana_04_bis");
		--NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__cortana_04_bis);		
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__going_towards_the_relay");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__going_towards_the_relay);
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__lookat_relay");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__lookat_relay);	
	end,
	
	localVariables = {
						s_speaker = nil,
						s_speaker_close = nil,
					},
};


--[========================================================================[
          Sentinels. underground. fourth pulse unshielded reacting
--]========================================================================]
global W3Sentinels_Sentinels__underground__lookat_relay = {
	name = "W3Sentinels_Sentinels__underground__lookat_relay",

	CanStart = function (thisConvo, queue)
		return object_at_distance_and_can_see_object(players(), OBJECTS.dm_final_conduit, 30, 90, VOLUMES.tv_narrative_lookat_relay) and not ((seconds_to_frames(pulseDelay) - g_cortana_vo_timer) <= 200) and not volume_test_players_lookat( VOLUMES.tv_walkway_stage4, 2.5, 180 ); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_endgame_osiris_is_talking = true;
	end,
		
	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_pulse_player_at_the_relay;
			end,
						
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Here. The relay. Destroy it!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_09700.sound'),

			playDurationAdjustment = 0.7,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
		b_endgame_osiris_is_talking = false;
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(Sentinels__underground__lookat_relay_2);		
	end,	
};



function Sentinels__underground__lookat_relay_2()

sleep_s(3);

PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__lookat_relay_2");
NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__lookat_relay_2);

end


--[========================================================================[
          Sentinels. underground. fourth pulse unshielded reacting
--]========================================================================]
global W3Sentinels_Sentinels__underground__lookat_relay_2 = {
	name = "W3Sentinels_Sentinels__underground__lookat_relay_2",

	CanStart = function (thisConvo, queue)
		return object_at_distance_and_can_see_object(players(), OBJECTS.dm_final_conduit, 30, 50, VOLUMES.tv_narrative_lookat_relay) and not ((seconds_to_frames(pulseDelay) - g_cortana_vo_timer) <= 200) and not volume_test_players_lookat( VOLUMES.tv_walkway_stage4, 4, 180 ); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_endgame_osiris_is_talking = true;
	end,
		
	lines = {
		[1] = {				
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not volume_test_players_lookat( VOLUMES.tv_walkway_autobash, 2, 180 );
			end,			

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Can you still hear me? Open the relay and disrupt the energy field!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_18300.sound'),

			playDurationAdjustment = 0.8,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
		b_endgame_osiris_is_talking = false;
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,	
};

--[========================================================================[
          Sentinels. underground. first pulse unshielded incoming
--]========================================================================]
global W3Sentinels_Sentinels__underground__cortana_04_bis = {
	name = "W3Sentinels_Sentinels__underground__cortana_04_bis",
	
	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not volume_test_players( VOLUMES.tv_narrative_endgame_shouldbash ) and not b_pulse_loud and not pulseNow and b_pulse_stage_04 and not b_endgame_osiris_is_talking and not ((seconds_to_frames(pulseDelay) - g_cortana_vo_timer) <= 200) and not volume_test_players_lookat( VOLUMES.tv_walkway_autobash, 2, 180 );
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_endgame_cortana_is_talking = true;
	end,	

	lines = {
		[1] = {		
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_pulse_player_at_the_relay;
			end,

			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "Just because you wear that armor does not make you my Spartans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_05800.sound'),

			playDurationAdjustment = 0.7,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID	
		b_endgame_osiris_is_talking = false;
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};



function Sentinels__underground__fourth_pulse_unshielded_inco()

	PrintNarrative("START - Sentinels__underground__fourth_pulse_unshielded_inco - PREPARE");

	SleepUntil ([| b_pulse_stage_04 and not b_pulse_player_at_the_relay and b_pulse_loud == false ],1 );	

	PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__fourth_pulse_unshielded_inco");
	NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__fourth_pulse_unshielded_inco);	

	PrintNarrative("END - Sentinels__underground__fourth_pulse_unshielded_inco - PREPARE");

end

--[========================================================================[
          Sentinels. underground. fourth pulse unshielded incoming
--]========================================================================]
global W3Sentinels_Sentinels__underground__fourth_pulse_unshielded_inco = {
	name = "W3Sentinels_Sentinels__underground__fourth_pulse_unshielded_inco",

	CanStart = function (thisConvo, queue)
		return b_pulse_loud and b_pulse_stage_01 and b_pulse_stage_02 and b_pulse_stage_03 and b_pulse_stage_04; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,
	
	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOStandBy();
		if thisConvo.localVariables.s_played == 0 then
			thisConvo.localVariables.s_speaker = GetClosestMusketeer(OBJECTS.dm_final_conduit, 100, 2);
			if thisConvo.localVariables.s_speaker == SPARTANS.buck then
				thisConvo.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.buck, 15, 2);
			end
		else 
			if IsSpartanAbleToSpeak(SPARTANS.tanaka) and thisConvo.localVariables.s_tanaka ~= true then
				thisConvo.localVariables.s_speaker = SPARTANS.tanaka;
			elseif IsSpartanAbleToSpeak(SPARTANS.vale) and thisConvo.localVariables.s_vale ~= true then
				thisConvo.localVariables.s_speaker = SPARTANS.vale;
			elseif IsSpartanAbleToSpeak(SPARTANS.locke) and thisConvo.localVariables.s_locke ~= true then
				thisConvo.localVariables.s_speaker = SPARTANS.locke;
			end
		end
	end,
	--sleepBefore = 0.6,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return false; --thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_locke = true;
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Pulse...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_13800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER				
				return 0;
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_vale = true;
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Another pulse ...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_04400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_tanaka = true;
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Pulse comin'... ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_04900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_buck = true;
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Pulse... comin'...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_08300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		if not (NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__underground__fourth_pulse_unshielded_reac) or NarrativeQueue.IsConversationQueued(W3Sentinels_Sentinels__underground__fourth_pulse_unshielded_reac)) then
			PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__fourth_pulse_unshielded_reac");
			NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__fourth_pulse_unshielded_reac);	
		end
		CreateMissionThread(Sentinels__underground__fourth_pulse_unshielded_inco);
		thisConvo.localVariables.s_played = thisConvo.localVariables.s_played + 1;		
	end,
	
	localVariables = {
						s_speaker = nil,
						s_locke = nil,
						s_buck = nil,
						s_tanaka = nil,
						s_vale = nil,
						s_played = 0,
					},
};



----------------

function Sentinels__underground__fourth_pulse_emote_locke()

PrintNarrative("LOAD - Sentinels__underground__fourth_pulse_emote_locke");

SleepUntil ([| b_huge_pain_emote_locke ], 1);

PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__fourth_pulse_emote_locke");
NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__fourth_pulse_emote_locke);		

end

--[========================================================================[
          Sentinels. underground. first pulse unshielded receiving

          That pulse hit results in losing half of the shield.
--]========================================================================]
global W3Sentinels_Sentinels__underground__fourth_pulse_emote_locke = {
	name = "W3Sentinels_Sentinels__underground__fourth_pulse_emote_locke",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.locke,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "[Huge pain emote, fall on the floor, close eyes, nearly lose consciousness]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_09900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_huge_pain_emote_locke = false;
		CreateMissionThread(Sentinels__underground__third_pulse_emote_locke);
	end,	
};


----------------

function Sentinels__underground__fourth_pulse_emote_buck()

PrintNarrative("LOAD - Sentinels__underground__fourth_pulse_emote_buck");

SleepUntil ([| b_huge_pain_emote_buck ], 1);

PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__fourth_pulse_emote_buck");
NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__fourth_pulse_emote_buck);		

end

--[========================================================================[
          Sentinels. underground. first pulse unshielded receiving

          That pulse hit results in losing half of the shield.
--]========================================================================]
global W3Sentinels_Sentinels__underground__fourth_pulse_emote_buck = {
	name = "W3Sentinels_Sentinels__underground__fourth_pulse_emote_buck",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.buck,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "[Huge pain emote, fall on the floor, close eyes, nearly lose consciousness]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_05500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_huge_pain_emote_buck = false;
		CreateMissionThread(Sentinels__underground__third_pulse_emote_buck);
	end,	
};


----------------

function Sentinels__underground__fourth_pulse_emote_tanaka()

PrintNarrative("LOAD - Sentinels__underground__fourth_pulse_emote_tanaka");

SleepUntil ([| b_huge_pain_emote_tanaka ], 1);

PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__fourth_pulse_emote_tanaka");
NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__fourth_pulse_emote_tanaka);		

end

--[========================================================================[
          Sentinels. underground. first pulse unshielded receiving

          That pulse hit results in losing half of the shield.
--]========================================================================]
global W3Sentinels_Sentinels__underground__fourth_pulse_emote_tanaka = {
	name = "W3Sentinels_Sentinels__underground__fourth_pulse_emote_tanaka",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.tanaka,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "[Huge pain emote, fall on the floor, close eyes, nearly lose consciousness]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_05000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_huge_pain_emote_tanaka = false;
		CreateMissionThread(Sentinels__underground__third_pulse_emote_tanaka);
	end,	
};



----------------

function Sentinels__underground__fourth_pulse_emote_vale()

PrintNarrative("LOAD - Sentinels__underground__fourth_pulse_emote_vale");

SleepUntil ([| b_huge_pain_emote_vale ], 1);

PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__fourth_pulse_emote_vale");
NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__fourth_pulse_emote_vale);		

end

--[========================================================================[
          Sentinels. underground. first pulse unshielded receiving

          That pulse hit results in losing half of the shield.
--]========================================================================]
global W3Sentinels_Sentinels__underground__fourth_pulse_emote_vale = {
	name = "W3Sentinels_Sentinels__underground__fourth_pulse_emote_vale",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.vale,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "[Huge pain emote, fall on the floor, close eyes, nearly lose consciousness]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_04500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_huge_pain_emote_vale = false;
		CreateMissionThread(Sentinels__underground__third_pulse_emote_vale);
	end,	
};


--[========================================================================[
          Sentinels. underground. fourth pulse unshielded reacting
--]========================================================================]
global W3Sentinels_Sentinels__underground__fourth_pulse_unshielded_reac = {
	name = "W3Sentinels_Sentinels__underground__fourth_pulse_unshielded_reac",	

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__underground__fourth_pulse_emote_locke) or NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__underground__fourth_pulse_emote_buck) or NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__underground__fourth_pulse_emote_tanaka) or NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__underground__fourth_pulse_emote_vale);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		b_endgame_osiris_is_talking = true;
		PushForwardVOStandBy();		
	end,

	sleepBefore = 1.5,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
		thisConvo.localVariables.s_speaker = GetClosestMusketeer(OBJECTS.dm_final_conduit, 100, 0);
		if thisConvo.localVariables.s_speaker == SPARTANS.locke then
			thisConvo.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.locke, 100, 2);
		end
	end,

	lines = {
		[1] = {
			--sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "Just one more question before I go. Where is the Infinity? Why is she so difficult to see?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_06600.sound'),

			playDurationAdjustment = 0.95,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return false; --not b_pulse_player_at_the_relay and thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Get up ... that's ... an order ...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_10000.sound'),

			playDurationAdjustment = 0.6,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return not b_pulse_player_at_the_relay and thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "We can ... do it ...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_04600.sound'),

			playDurationAdjustment = 0.6,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return not b_pulse_player_at_the_relay and thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Gonna take ... more'n that ...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_05100.sound'),

			playDurationAdjustment = 0.6,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return not b_pulse_player_at_the_relay and thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Just stay ... conscious ... ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_05600.sound'),

			playDurationAdjustment = 0.9,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,		
		},
		
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
		b_endgame_osiris_is_talking = false;
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,
	
	localVariables = {
						s_speaker = nil,
					},
};




--[========================================================================[
          Sentinels. underground. first pulse unshielded incoming
--]========================================================================]
global W3Sentinels_Sentinels__underground__cortana_04 = {
	name = "W3Sentinels_Sentinels__underground__cortana_04",
	
	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_pulse_loud and not pulseNow and b_pulse_stage_04 and not b_endgame_osiris_is_talking;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_endgame_cortana_is_talking = true;
	end,

	--sleepBefore = 0.7,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return false; --not b_pulse_player_at_the_relay and thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			--sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "Just one more question before I go. Where is the Infinity? Why is she so difficult to see?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_06600.sound'),

			playDurationAdjustment = 0.6,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID	
		b_endgame_osiris_is_talking = false;
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);	
	end,
};





--[========================================================================[
          Sentinels. underground. going towards the relay

          Players falls down, look up at the relay and the Cryptum
          behind.
--]========================================================================]
global W3Sentinels_Sentinels__underground__going_towards_the_relay = {
	name = "W3Sentinels_Sentinels__underground__going_towards_the_relay",

	CanStart = function (thisConvo, queue)
		return b_pulse_player_at_the_relay; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,
	
	OnInitialize = function(thisConvo, queue)
		b_endgame_osiris_is_talking = true;
		PushForwardVOStandBy();
	end,
	
	sleepBefore = 2,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		thisConvo.localVariables.s_speaker = GetClosestMusketeer(OBJECTS.dm_final_conduit, 100, 2);
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__underground__at_the_relay");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__underground__at_the_relay);
	end,	

	lines = {	
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Can't go on...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_10500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 2;
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,	
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Locke... You can do it!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_08400.sound'),

			playDurationAdjustment = 0.95,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.4,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Can't ... take it ...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_05400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 4;
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 5;
			end,	
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: locke
			text = "Buck... You have to do it!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_13900.sound'),			

			playDurationAdjustment = 0.95,
		},
		[5] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.4,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Can't go on...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_05500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 6;
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 7;
			end,
		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: locke
			text = "Tanaka... You have to do it!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_14000.sound'),

			playDurationAdjustment = 0.95,
		},
		[7] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.4,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Can't go on...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_05000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 8;
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 9;
			end,
		},
		[8] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: locke
			text = "Vale... You have to do it!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_14100.sound'),

			playDurationAdjustment = 0.95,
		},
		[9] = {
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "Not to worry. I will find her.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_06700.sound'),

			playDurationAdjustment = 0.8,
		},
		[10] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Just ... Another ...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_10100.sound'),

			--playDurationAdjustment = 0.5,
		},
		[11] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Keep ... Together...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_05700.sound'),

			--playDurationAdjustment = 0.5,
		},
		[12] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Close ...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_05200.sound'),

			--playDurationAdjustment = 0.5,
		},
		[13] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Nearly ... There...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_04700.sound'),

			--playDurationAdjustment = 0.5,
		},				
	},


	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		hud_hide_radio_transmission_hud();
		b_endgame_osiris_is_talking = false;
	end,
	
	localVariables = {
						s_speaker = nil,
					},
};



--[========================================================================[
          Sentinels. underground. at the relay

          Players falls down, look up at the relay. Get to it and open
          it and punch it.
--]========================================================================]
global W3Sentinels_Sentinels__underground__at_the_relay = {
	name = "W3Sentinels_Sentinels__underground__at_the_relay",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return b_pulse_player_at_the_relay_2;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 0.4,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		thisConvo.localVariables.s_speaker = GetClosestMusketeer(OBJECTS.dm_final_conduit, 100, 2);
	end,

	lines = {	
		[5] = {

			sleepBefore = 2,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: Cortana
			text = "Slipspace coordinates locked in. Cryptum secured. Goodbye, Mister Locke.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_05900.sound'),

			playDurationAdjustment = 0.85,
		},
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "You're not taking the Chief...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_10200.sound'),
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "You're not taking the Chief...\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_05800.sound'),
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,			

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "You're not taking the Chief...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_05300.sound'),
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: Else If vale is first When first pulse is incoming
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "You're not taking the Chief...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_04800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		W3Sentinels_Sentinels__endgame__osiris.localVariables.s_destroyer = thisConvo.localVariables.s_speaker
	end,

	localVariables = {
						s_speaker = nil,
					},
};



-- =================================================================================================
--  ______ _   _ _____   _____          __  __ ______ 
-- |  ____| \ | |  __ \ / ____|   /\   |  \/  |  ____|
-- | |__  |  \| | |  | | |  __   /  \  | \  / | |__   
-- |  __| | . ` | |  | | | |_ | / /\ \ | |\/| |  __|  
-- | |____| |\  | |__| | |__| |/ ____ \| |  | | |____ 
-- |______|_| \_|_____/ \_____/_/    \_\_|  |_|______|
--                                         
-- =================================================================================================


function sentinels_endgame_wake()

	PrintNarrative("START - sentinels_endgame_wake");

		PrintNarrative("QUEUE - W3Sentinels_Sentinels__endgame__osiris");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__endgame__osiris);				
		
		PushForwardVOStandBy();
		ai_dialogue_enable(false);

	PrintNarrative("END - sentinels_endgame_wake");

end


----------------------------------------------------------------------



--[========================================================================[
          Sentinels. endgame. sentinels activated

          After player breaks the relay, they collapse to the ground.
          They crawl a couple of feet, their vision flashing in and
          out.
--]========================================================================]
global W3Sentinels_Sentinels__endgame__osiris = {
	name = "W3Sentinels_Sentinels__endgame__osiris",

	CanStart = function (thisConvo, queue)
		return b_endgame_osiris_get_up; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	sleepBefore = 3.5,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "I have control again! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_16200.sound'),

			playDurationAdjustment = 0.9,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: Cortana
			text = "What?! What are you doing?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_06300.sound'),

			playDurationAdjustment = 0.85,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Do you hear me?!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_22000.sound'),
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "I HAVE CONTROL AGAIN!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_16300.sound'),

			--playDurationAdjustment = 0.85,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_destroyer == SPARTANS.locke;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Locke? You alive?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_06900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 7;
			end,	
		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Did it work? Did we save them?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_13300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[7] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_destroyer == SPARTANS.buck;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Buck, you alright?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_13400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 8; -- GAMMA_NEXT_LINE_NUMBER
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 9;
			end,
		},
		[8] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buCK
			text = "Did it work? Did we save them?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_08200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[9] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_destroyer == SPARTANS.vale;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Vale, you alright?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_13500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 10; -- GAMMA_NEXT_LINE_NUMBER
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 11;
			end,
		},
		[10] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VaLE
			text = "Did it work? Did we save them?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_07000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[11] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_destroyer == SPARTANS.tanaka;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Tanaka, you alright?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_13600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 12; -- GAMMA_NEXT_LINE_NUMBER
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[12] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Did it work? Did we save them?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_07400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},		
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__endgame__sentinels_activated");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__endgame__sentinels_activated);				
	end,

	localVariables = {
					s_destroyer = nil,
					},
};


--[========================================================================[
          Sentinels. endgame. sentinels activated
--]========================================================================]
global W3Sentinels_Sentinels__endgame__sentinels_activated = {
	name = "W3Sentinels_Sentinels__endgame__sentinels_activated",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,

	lines = {		
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			sleepBefore = 0.5,

			--character = 0, -- GAMMA_CHARACTER: Cortana
			text = "It is too late, the slipspace drives are activated. You can't--",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_cortana_06400.sound'),

			playDurationAdjustment = 0.95,
		},		
		[2] = {
			--sleepBefore = 0.2,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Exuberant? What... --[is happening]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_04900.sound'),

			playDurationAdjustment = 0.82,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Constructors! This is a Builder facility after all. I was installed by the Builders! I SERVE THE BUILDERS!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_19200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_endgame_cortana_leave_john_alone = true;
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W3Sentinels_Sentinels__endgame__cortana_3");
		NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__endgame__cortana_3);
	end,
};

	


--[========================================================================[
          Sentinels. endgame. cortana
--]========================================================================]
global W3Sentinels_Sentinels__endgame__cortana_3 = {
	name = "W3Sentinels_Sentinels__endgame__cortana_3",

	CanStart = function (thisConvo, queue)
		return b_endgame_cortana_gone; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	sleepBefore = 5,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return false;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "We did it! We did it!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_18600.sound'),			
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VaLE
			text = "She's gone. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_03600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			sleepAfter = 4,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return false;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "We saved Blue Team. This war isn't over yet.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_08400.sound'),

			sleepAfter = 2,
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return false;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "I have to say, I did not really think you would still be alive by now.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_18700.sound'),
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return false;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "But I am quite pleased that you are!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_18800.sound'),
		},
		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return false;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Let us go say hello to the other Humans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_fr_exuberantwitness_18900.sound'),
		},
		[7] = {
			sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,			

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Been one hell of a work week.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_tanaka_04200.sound'),
		},		
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PushForwardVOStandBy();
	end,
};


function sentinels_pushforward()

	PrintNarrative("WAKE - sentinels_pushforward");

	repeat
	
			--	GENERAL

			SleepUntil([| b_push_forward_vo_timer >= 0 and b_push_forward_vo_timer < 3 and not b_more_guardian_are_leaving and b_DownTime and IsSpartanAbleToSpeak(SPARTANS.locke)], 30);
	
			if not IsGoalActive(missionSentinels.goal_underground) then

						PrintNarrative("QUEUE - W3Sentinels_push_forward_01");
						NarrativeQueue.QueueConversation(W3Sentinels_push_forward_01);

						PushForwardVOReset();

			end

			SleepUntil([| b_push_forward_vo_timer >= 0 and b_push_forward_vo_timer < 3 and not b_more_guardian_are_leaving and b_DownTime and IsSpartanAbleToSpeak(SPARTANS.buck)], 30);
	
			if not IsGoalActive(missionSentinels.goal_underground) then

						PrintNarrative("QUEUE - W3Sentinels_push_forward_02");
						NarrativeQueue.QueueConversation(W3Sentinels_push_forward_02);

						PushForwardVOReset();

			end

			SleepUntil([| b_push_forward_vo_timer >= 0 and b_push_forward_vo_timer < 3 and not b_more_guardian_are_leaving and b_DownTime and IsSpartanAbleToSpeak(SPARTANS.buck)], 30);
	
			if not IsGoalActive(missionSentinels.goal_underground) then

						PrintNarrative("QUEUE - W3Sentinels_push_forward_03");
						NarrativeQueue.QueueConversation(W3Sentinels_push_forward_03);

						PushForwardVOReset();

			end

			SleepUntil([| b_push_forward_vo_timer >= 0 and b_push_forward_vo_timer < 3 and not b_more_guardian_are_leaving and b_DownTime and IsSpartanAbleToSpeak(SPARTANS.tanaka)], 30);
	
			if not IsGoalActive(missionSentinels.goal_underground) then

						PrintNarrative("QUEUE - W3Sentinels_push_forward_04");
						NarrativeQueue.QueueConversation(W3Sentinels_push_forward_04);

						PushForwardVOReset();

			end

			SleepUntil([| b_push_forward_vo_timer >= 0 and b_push_forward_vo_timer < 3 and not b_more_guardian_are_leaving and b_DownTime and IsSpartanAbleToSpeak(SPARTANS.vale)], 30);
	
			if not IsGoalActive(missionSentinels.goal_underground) then

						PrintNarrative("QUEUE - W3Sentinels_push_forward_05");
						NarrativeQueue.QueueConversation(W3Sentinels_push_forward_05);

						PushForwardVOReset();

			end

			SleepUntil([| b_push_forward_vo_timer >= 0 and b_push_forward_vo_timer < 3 and not b_more_guardian_are_leaving and b_DownTime and IsSpartanAbleToSpeak(SPARTANS.buck)], 30);
	
			if not IsGoalActive(missionSentinels.goal_underground) then

						PrintNarrative("QUEUE - W3Sentinels_push_forward_06");
						NarrativeQueue.QueueConversation(W3Sentinels_push_forward_06);

						PushForwardVOReset();

			end

			SleepUntil([| b_push_forward_vo_timer >= 0 and b_push_forward_vo_timer < 3 and not b_more_guardian_are_leaving and b_DownTime and IsSpartanAbleToSpeak(SPARTANS.tanaka)], 30);
	
			if not IsGoalActive(missionSentinels.goal_underground) then

						PrintNarrative("QUEUE - W3Sentinels_push_forward_07");
						NarrativeQueue.QueueConversation(W3Sentinels_push_forward_07);

						PushForwardVOReset();

			end

			SleepUntil([| b_push_forward_vo_timer >= 0 and b_push_forward_vo_timer < 3 and not b_more_guardian_are_leaving and b_DownTime and IsSpartanAbleToSpeak(SPARTANS.vale)], 30);
	
			if not IsGoalActive(missionSentinels.goal_underground) then

						PrintNarrative("QUEUE - W3Sentinels_push_forward_08");
						NarrativeQueue.QueueConversation(W3Sentinels_push_forward_08);

						PushForwardVOReset();

			end

			SleepUntil([| b_push_forward_vo_timer >= 0 and b_push_forward_vo_timer < 3 and not b_more_guardian_are_leaving and b_DownTime and IsSpartanAbleToSpeak(SPARTANS.buck)], 30);
	
			if not IsGoalActive(missionSentinels.goal_underground) then

						PrintNarrative("QUEUE - W3Sentinels_push_forward_09");
						NarrativeQueue.QueueConversation(W3Sentinels_push_forward_09);

						PushForwardVOReset();

			end

			SleepUntil([| b_push_forward_vo_timer >= 0 and b_push_forward_vo_timer < 3 and not b_more_guardian_are_leaving and b_DownTime and IsSpartanAbleToSpeak(SPARTANS.tanaka)], 30);
	
			if not IsGoalActive(missionSentinels.goal_underground) then

						PrintNarrative("QUEUE - W3Sentinels_push_forward_10");
						NarrativeQueue.QueueConversation(W3Sentinels_push_forward_10);

						PushForwardVOReset();

			end

			SleepUntil([| b_push_forward_vo_timer >= 0 and b_push_forward_vo_timer < 3 and not b_more_guardian_are_leaving and b_DownTime and IsSpartanAbleToSpeak(SPARTANS.vale)], 30);
	
			if not IsGoalActive(missionSentinels.goal_underground) then

						PrintNarrative("QUEUE - W3Sentinels_push_forward_11");
						NarrativeQueue.QueueConversation(W3Sentinels_push_forward_11);

						PushForwardVOReset();

			end
			
			PrintNarrative("END - sentinels_pushforward");
			
			b_push_forward_vo_timer_default = b_push_forward_vo_timer_default + b_push_forward_vo_timer_default;

			PushForwardVOReset();

	until not b_push_forward_vo_active

end



--[========================================================================[
          PUSH FORWARD

--]========================================================================]
global W3Sentinels_push_forward_01 = {
	name = "W3Sentinels_push_forward_01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_DownTime = false;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "If don't get to the Cryptum now, we might never see Blue Team again. Hurry Osiris!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_08600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
	end,
};


--[========================================================================[
          PUSH FORWARD

--]========================================================================]
global W3Sentinels_push_forward_02 = {
	name = "W3Sentinels_push_forward_02",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_DownTime = false;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Cortana is about to leave Genesis. It's now or never!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_04600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
	end,
};


--[========================================================================[
          PUSH FORWARD

--]========================================================================]
global W3Sentinels_push_forward_03 = {
	name = "W3Sentinels_push_forward_03",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_DownTime = false;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Let's keep it moving.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_buck_00200.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
	end,
};


--[========================================================================[
          PUSH FORWARD

--]========================================================================]
global W3Sentinels_push_forward_04 = {
	name = "W3Sentinels_push_forward_04",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_DownTime = false;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Figure it's best to keep moving.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_tanaka_00100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
	end,
};


--[========================================================================[
          PUSH FORWARD

--]========================================================================]
global W3Sentinels_push_forward_05 = {
	name = "W3Sentinels_push_forward_05",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_DownTime = false;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Think we should get going?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_vale_00100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
	end,
};



--[========================================================================[
          PUSH FORWARD

--]========================================================================]
global W3Sentinels_push_forward_06 = {
	name = "W3Sentinels_push_forward_06",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_DownTime = false;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Let's roll out, Osiris.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_buck_00100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
	end,
};


--[========================================================================[
          PUSH FORWARD

--]========================================================================]
global W3Sentinels_push_forward_07 = {
	name = "W3Sentinels_push_forward_07",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_DownTime = false;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Oughta keep moving.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_tanaka_00200.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
	end,
};


--[========================================================================[
          PUSH FORWARD

--]========================================================================]
global W3Sentinels_push_forward_08 = {
	name = "W3Sentinels_push_forward_08",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_DownTime = false;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Better keep moving, Spartans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_vale_00200.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
	end,
};



--[========================================================================[
          PUSH FORWARD

--]========================================================================]
global W3Sentinels_push_forward_09 = {
	name = "W3Sentinels_push_forward_09",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_DownTime = false;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Let's not waste time.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_buck_00300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
	end,

};


--[========================================================================[
          PUSH FORWARD

--]========================================================================]
global W3Sentinels_push_forward_10 = {
	name = "W3Sentinels_push_forward_10",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_DownTime = false;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Should get a move on.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_tanaka_00300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
	end,

};


--[========================================================================[
          PUSH FORWARD

--]========================================================================]
global W3Sentinels_push_forward_11 = {
	name = "W3Sentinels_push_forward_11",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_DownTime = false;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "We should move it along.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_vale_00300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_DownTime = true;
	end,
};

-- =================================================================================================          
-- =================================================================================================     
--	CHATTER
-- =================================================================================================          
-- =================================================================================================    

function sentinels_is_there_enemy_nearby(distance:number)

	PrintNarrative("START - sentinels_is_there_enemy_nearby");

		if	TestClosestEnemyDistance(AI.sg_lb_all_enemies, distance) or
			TestClosestEnemyDistance(AI.sg_bowl_enemy_all, distance) or
			TestClosestEnemyDistance(AI.sg_col_all, distance) then
					sentinels_is_there_enemy_nearby_result = true;
					PrintNarrative("sentinels_is_there_enemy_nearby = true;");
		else
					sentinels_is_there_enemy_nearby_result = false;
					PrintNarrative("sentinels_is_there_enemy_nearby = false;");
		end

	PrintNarrative("END - sentinels_is_there_enemy_nearby");

end


function sentinels_four_players_combat_check()

	PrintNarrative("START - sentinels_four_players_combat_check");

	repeat

		SleepUntil([| list_count(players()) == 4], 1800);

		repeat 

			SleepUntil([| not b_collectible_used and ((b_push_forward_vo_counrdown_on > 20 and not IsSpartanInCombat()) or list_count(players()) ~= 4)], 30);

			if list_count(players()) == 4 then
				sentinels_is_there_enemy_nearby(30);

				if sentinels_is_there_enemy_nearby_result then
					PushForwardVOReset();
				end
			end

		until not b_push_forward_vo_active or list_count(players()) ~= 4

	until not IsMissionActive(missionSentinels)

	PrintNarrative("END - sentinels_four_players_combat_check");

end

-----------------------------------------------------------------

function sentinels_chatter()
local s_chatter_01:boolean = false
local s_chatter_02:boolean = false
local s_chatter_03:boolean = false

	PrintNarrative("WAKE - sentinels_chatter");

	SleepUntil([| not IsGoalActive(missionSentinels.goal_museum) and not IsGoalActive(missionSentinels.goal_gondola)], 30);

	repeat
				repeat
					sleep_s(5);
					SleepUntil([| b_push_forward_vo_counrdown_on > 45 and not b_ai_voices_are_playing and b_DownTime and not b_collectible_used and not IsSpartanInCombat() and IsSpartanAbleToSpeak(SPARTANS.vale) and IsSpartanAbleToSpeak(SPARTANS.buck) and IsSpartanAbleToSpeak(SPARTANS.locke) and not volume_test_players( VOLUMES.tv_narrative_gate_mid_door ) and not volume_test_players( VOLUMES.tv_narrative_sentinels_towers_entrance )], 30);

					sentinels_is_there_enemy_nearby(60);
				until not sentinels_is_there_enemy_nearby_result
				
				if  not IsGoalActive(missionSentinels.goal_coliseum) and not IsGoalActive(missionSentinels.goal_underground) and not NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__gate__voices_chatter)
					and not NarrativeQueue.HasConversationFinished(W3Sentinels_Sentinels__gate__voices_chatter) then
							
							PrintNarrative("QUEUE - W3Sentinels_Sentinels__gate__voices_chatter");
							NarrativeQueue.QueueConversation(W3Sentinels_Sentinels__gate__voices_chatter);

							PushForwardVOReset();
							
							s_chatter_01 = true;
				end				

				sleep_s(2);

	until s_chatter_01

	PrintNarrative("END - sentinels_chatter");

end


--[========================================================================[
          Sentinels. gate. voices

          ***I want to be 100% sure this plays here, immediately
          following "The Reclamation has begun." This should not be
          treated as a push forward.
--]========================================================================]
global W3Sentinels_Sentinels__gate__voices_chatter = {
	name = "W3Sentinels_Sentinels__gate__voices_chatter",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		b_DownTime = false;
		PushForwardVOReset();
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);				
	end,	

	lines = {		
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					CreateThread(sentinels_is_there_enemy_nearby, 30);
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Why is she taking Blue Team with her? Her whole speech was about moving beyond humanity.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_vale_00400.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,	
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not sentinels_is_there_enemy_nearby_result and not IsSpartanInCombat();
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					CreateThread(sentinels_is_there_enemy_nearby, 30);
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BuCK
			text = "Sentimentality? A love for the Chief?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_buck_06000.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not sentinels_is_there_enemy_nearby_result and not IsSpartanInCombat();
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "It's because she knows he can stop her. We're variables in her eyes. But him... she knows he can do it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3sentinels\001_vo_scr_w3sentinels_un_locke_01200.sound'),

			playDurationAdjustment = 0.9,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();		
	end,

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		b_DownTime = true;
	end,

};



-- **************************************************************************************
--
--	MISC
--
-- **************************************************************************************


function sentinels_guardians_slipspace(guardian:object)

--	SECOND GUARDIAN OF THE GONDOLA RIDE
		
		b_more_guardian_are_leaving = true;

		--WHALE SONG
		sentinels_guardian_sound_3d(guardian);

		sleep_s(1.7);
		
		sentinels_guardian_boom_3d(guardian);

		sleep_s(7);

		b_more_guardian_are_leaving = false;

end

----------------------------------------

function sentinels_guardian_sound_3d(guardian:object)
--	Play Whale song
	print("Play Whale song close - Server");
	sound_impulse_start_marker_server(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_guardian_whalesong_sentinels_departure.sound'), guardian, "fx_head_front", 1);
end


function sentinels_cortana_guardian_sound_3d(guardian:object)
--	Play Whale song
	print("Play Whale song close - Server");
	sound_impulse_start_marker_server(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_guardian_whalesong_sentinels_cortanadeparture.sound'), guardian, "fx_head_front", 1);
	-- NEED NEW SOUNDTAG
end

-------

function sentinels_guardian_boom_3d(guardian:object)
	print("Play Guardian Boom close - Server");
	sound_impulse_start_marker_server(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_guardian_w3sentinels_slipspaceout.sound'), guardian, "fx_head_front", 1);
end

function sentinels_guardian_boom_2d():void
	print("Play Guardian Boom close - Server");
	sound_impulse_start_server_narr(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_guardian_w3sentinels_slipspaceout2d.sound'), SPARTANS.locke, 1);
end

-------------------

function sound_impulse_start_server_narr(soundTag:tag, theObject:object, theScale:number):void
--print('PASS 3');
	RunClientScript("sound_impulse_start_client_narr", soundTag, theObject, theScale);

end

function sound_impulse_start_marker_server(soundTag:tag, theObject:object, theMarker:string, theScale:number):void
--print('PASS 3');
	RunClientScript("sound_impulse_start_marker_client", soundTag, theObject, theMarker, theScale);

end


----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- STARES EXUBERANT
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------



function sentinels_exuberant_stares()
local s_speaker:object = nil;
local s_stare_count:number = 0;
local s_stare_timing:number = 5;

sleep_s(10);

PrintNarrative("START - sentinels_exuberant_stares");

	SleepUntil([| ai_living_count(AI.sq_sassy_spark01) > 0 or ai_living_count(AI.sq_sassy_spark) > 0], 1);

	PrintNarrative("START - sentinels_exuberant_stares - Monitor is alive!");
	repeat
		PrintNarrative("START - sentinels_exuberant_stares - waiting for player to look");
		s_stare_count = 0;
		SleepUntil([| NarrativeQueue.ConversationsPlayingCount() == 0 and 
						((ai_living_count(AI.sq_sassy_spark) > 0 and objects_can_see_object( players(), ai_get_object(AI.sq_sassy_spark), 5 )) 
						or (ai_living_count(AI.sq_sassy_spark01) > 0 and objects_can_see_object( players(), ai_get_object(AI.sq_sassy_spark01), 5 )))], 60);
		
		--	STEP 1
		if  NarrativeQueue.ConversationsPlayingCount() == 0 and ((ai_living_count(AI.sq_sassy_spark) > 0 and objects_can_see_object( players(), ai_get_object(AI.sq_sassy_spark), 5 )) 
						or (ai_living_count(AI.sq_sassy_spark01) > 0 and objects_can_see_object( players(), ai_get_object(AI.sq_sassy_spark01), 5 ))) then
			s_stare_count = 1;
			sleep_s(s_stare_timing/5);
			PrintNarrative("STEP 1 - sentinels_exuberant_stares - player is looking");
		end

		--	STEP 2
		if  NarrativeQueue.ConversationsPlayingCount() == 0 and ((ai_living_count(AI.sq_sassy_spark) > 0 and objects_can_see_object( players(), ai_get_object(AI.sq_sassy_spark), 5 )) 
						or (ai_living_count(AI.sq_sassy_spark01) > 0 and objects_can_see_object( players(), ai_get_object(AI.sq_sassy_spark01), 5 ))) then
			s_stare_count = 2;
			sleep_s(s_stare_timing/5);
			PrintNarrative("STEP 2 - sentinels_exuberant_stares - player is looking");
		end

		--	STEP 3
		if  NarrativeQueue.ConversationsPlayingCount() == 0 and ((ai_living_count(AI.sq_sassy_spark) > 0 and objects_can_see_object( players(), ai_get_object(AI.sq_sassy_spark), 5 )) 
						or (ai_living_count(AI.sq_sassy_spark01) > 0 and objects_can_see_object( players(), ai_get_object(AI.sq_sassy_spark01), 5 ))) then
			s_stare_count = 3;
			sleep_s(s_stare_timing/5);
			PrintNarrative("STEP 3 - sentinels_exuberant_stares - player is looking");
		end

		--	STEP 4
		if  NarrativeQueue.ConversationsPlayingCount() == 0 and ((ai_living_count(AI.sq_sassy_spark) > 0 and objects_can_see_object( players(), ai_get_object(AI.sq_sassy_spark), 5 )) 
						or (ai_living_count(AI.sq_sassy_spark01) > 0 and objects_can_see_object( players(), ai_get_object(AI.sq_sassy_spark01), 5 ))) then
			s_stare_count = 4;
			sleep_s(s_stare_timing/5);
			PrintNarrative("STEP 4 - sentinels_exuberant_stares - player is looking");
		end

		--	STEP 5
		if  NarrativeQueue.ConversationsPlayingCount() == 0 and ((ai_living_count(AI.sq_sassy_spark) > 0 and objects_can_see_object( players(), ai_get_object(AI.sq_sassy_spark), 5 )) 
						or (ai_living_count(AI.sq_sassy_spark01) > 0 and objects_can_see_object( players(), ai_get_object(AI.sq_sassy_spark01), 5 ))) then
			s_stare_count = 5;
			sleep_s(s_stare_timing/5);
			PrintNarrative("STEP 5 - sentinels_exuberant_stares - player is looking");
		end

		
		if s_stare_count >= 5 and ai_living_count(AI.sq_sassy_spark) > 0 and object_at_distance_and_can_see_object(players(), ai_get_object(AI.sq_sassy_spark), 10, 5) then
			s_speaker = spartan_look_at_object(players(), ai_get_object(AI.sq_sassy_spark), 10, 5, 0, 0);
		elseif s_stare_count >= 5 and ai_living_count(AI.sq_sassy_spark01) > 0  and object_at_distance_and_can_see_object(players(), ai_get_object(AI.sq_sassy_spark01), 10, 5) then
			s_speaker = spartan_look_at_object(players(), ai_get_object(AI.sq_sassy_spark01), 10, 5, 0, 0);
		end

		s_stare_timing = 8;

	until s_speaker ~= nil

	if not NarrativeQueue.IsConversationQueued(GlobalsExuberant_Player_stares_at_exuberant_for_a_long_time) then
		PrintNarrative("QUEUE - GlobalsExuberant_Player_stares_at_exuberant_for_a_long_time");
		NarrativeQueue.QueueConversation(GlobalsExuberant_Player_stares_at_exuberant_for_a_long_time);
	end

end

function test_monitor_health()
repeat
	sleep_s(0.05);
print(object_get_health( ai_get_object(AI.sq_sassy_spark01) ))

until (false)

end

--[========================================================================[
          Player stares at exuberant for a long time
--]========================================================================]
global GlobalsExuberant_Player_stares_at_exuberant_for_a_long_time = {
	name = "GlobalsExuberant_Player_stares_at_exuberant_for_a_long_time",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		if b_push_forward_vo_timer ~= -1 then
			PushForwardVOReset();
		end
	end,

	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_1 ~= true
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_line_1 = true;
			end,
			
			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExuBERANTWITNESS
			text = "Human? Have you become deactivated?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsexuberant\001_vo_scr_globalsexuberant_fr_exuberantwitness_01000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_2 ~= true
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_line_2 = true;
			end,
			
			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: EXUBERANTWITNESS
			text = "Human, your prolonged inactivity is proving quite unsettling.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsexuberant\001_vo_scr_globalsexuberant_fr_exuberantwitness_01100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_3 ~= true
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_line_3 = true;
			end,
			
			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: EXUBERANTWITNESS
			text = "It appears you have entered a state of mental dormancy... intriguing.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsexuberant\001_vo_scr_globalsexuberant_fr_exuberantwitness_01200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_4 ~= true
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_line_4 = true;
			end,
			
			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Are you admiring my chassis? I cannot blame you.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsexuberant\001_vo_scr_globalsexuberant_fr_exuberantwitness_01300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_5 ~= true
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_line_5 = true;
			end,
			
			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Protocol dictates I ask you politely but firmly to stop being a weirdo.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsexuberant\001_vo_scr_globalsexuberant_fr_exuberantwitness_01400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_6 ~= true
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_line_6 = true;
			end,
			
			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "I am quite patient. Let me know when your visual scan has completed. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsexuberant\001_vo_scr_globalsexuberant_fr_exuberantwitness_01500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[7] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_7 ~= true
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_line_7 = true;
			end,
			
			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Are you looking for my best side? Take your time; I have infinitely many. Haha! Sphere humor!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsexuberant\001_vo_scr_globalsexuberant_fr_exuberantwitness_01600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[8] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_8 ~= true
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_line_8 = true;
			end,
			
			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "My social protocol does not include tactful disengagement. QUIT STARING!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsexuberant\001_vo_scr_globalsexuberant_fr_exuberantwitness_01700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[9] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_9 ~= true
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_line_9 = true;
			end,
			
			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "I recommend we move forward. Perhaps I could open and close a door for you!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsexuberant\001_vo_scr_globalsexuberant_fr_exuberantwitness_01800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[10] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_10 ~= true
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_line_10 = true;
			end,
			
			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "At times like this, I wish I had never been programmed to feel awkward discomfort.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsexuberant\001_vo_scr_globalsexuberant_fr_exuberantwitness_01900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},

	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		if thisConvo.localVariables.s_line_1 and thisConvo.localVariables.s_line_2 and thisConvo.localVariables.s_line_3 and thisConvo.localVariables.s_line_4 and thisConvo.localVariables.s_line_5 and thisConvo.localVariables.s_line_6 and thisConvo.localVariables.s_line_7 and thisConvo.localVariables.s_line_8 and thisConvo.localVariables.s_line_9 and thisConvo.localVariables.s_line_10 then
			thisConvo.localVariables.s_line_1 = false;
			thisConvo.localVariables.s_line_2 = false;
			thisConvo.localVariables.s_line_3 = false;
			thisConvo.localVariables.s_line_4 = false;
			thisConvo.localVariables.s_line_5 = false;
			thisConvo.localVariables.s_line_6 = false;
			thisConvo.localVariables.s_line_7 = false;
			thisConvo.localVariables.s_line_8 = false;
			thisConvo.localVariables.s_line_9 = false;
			thisConvo.localVariables.s_line_10 = false;
		end		
	end,
	
	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(sentinels_exuberant_stares);
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {
						s_line_1 = nil,
						s_line_2 = nil,
						s_line_3 = nil,
						s_line_4 = nil,
						s_line_5 = nil,
						s_line_6 = nil,
						s_line_7 = nil,
						s_line_8 = nil,
						s_line_9 = nil,
						s_line_10 = nil,
						},
};




function sentinels_exuberant_shooting()
local s_speaker:object = nil;
local s_monitor_health:number = 1;

sleep_s(5);

PrintNarrative("START - sentinels_exuberant_shooting");

	SleepUntil([| ai_living_count(AI.sq_sassy_spark) > 0], 1);

	PrintNarrative("START - sentinels_exuberant_shooting - Monitor is alive!");
	repeat
		PrintNarrative("START - sentinels_exuberant_shooting - waiting for player to shoot");		
		
		object_set_health( ai_get_object(AI.sq_sassy_spark), 1 );

		sleep_s(1);

		SleepUntil([| not IsSpartanInCombat() and objects_can_see_object( players(), ai_get_object(AI.sq_sassy_spark), 10 ) ], 10);

		if object_get_health( ai_get_object(AI.sq_sassy_spark) ) < 0.2 then
			object_set_health( ai_get_object(AI.sq_sassy_spark), 1 );
		end
		s_monitor_health = object_get_health( ai_get_object(AI.sq_sassy_spark) );

		print("s_monitor_health 01: ", s_monitor_health, "current Health: ", object_get_health( ai_get_object(AI.sq_sassy_spark) ));

		SleepUntil([| (not IsSpartanInCombat() and NarrativeQueue.ConversationsPlayingCount() == 0 and ai_living_count(AI.sq_sassy_spark) > 0 and objects_can_see_object( players(), ai_get_object(AI.sq_sassy_spark), 10 ) and object_get_health( ai_get_object(AI.sq_sassy_spark) ) < s_monitor_health) or (IsSpartanInCombat() or not objects_can_see_object( players(), ai_get_object(AI.sq_sassy_spark), 10 )) ], 30);
		
		print("s_monitor_health 02: ", s_monitor_health, "current Health: ", object_get_health( ai_get_object(AI.sq_sassy_spark) ));
	
		if NarrativeQueue.ConversationsPlayingCount() == 0 and ai_living_count(AI.sq_sassy_spark) > 0 and object_at_distance_and_can_see_object(players(), ai_get_object(AI.sq_sassy_spark), 10, 5) and object_get_health( ai_get_object(AI.sq_sassy_spark) ) ~= s_monitor_health and not IsSpartanInCombat() then
			s_speaker = spartan_look_at_object(players(), ai_get_object(AI.sq_sassy_spark), 10, 5, 0, 0);		
		end

	until s_speaker ~= nil

	if not NarrativeQueue.IsConversationQueued(GlobalsExuberant_Exuberant_takes_friendly_fire) then
		PrintNarrative("QUEUE - GlobalsExuberant_Exuberant_takes_friendly_fire");
		NarrativeQueue.QueueConversation(GlobalsExuberant_Exuberant_takes_friendly_fire);
	end

end

--[========================================================================[
          Player shoots at exuberant
--]========================================================================]
global GlobalsExuberant_Exuberant_takes_friendly_fire = {
	name = "GlobalsExuberant_Exuberant_takes_friendly_fire",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		if b_push_forward_vo_timer ~= -1 then
			PushForwardVOReset();
		end
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_1 ~= true
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_line_1 = true;
			end,
			
			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExuBERANTWITNESS
			text = "Please do not fire so recklessly!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsexuberant\001_vo_scr_globalsexuberant_fr_exuberantwitness_00100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_2 ~= true
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_line_2 = true;
			end,
			
			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: EXUBERANTWITNESS
			text = "My apologies. I did not realize you were aiming there.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsexuberant\001_vo_scr_globalsexuberant_fr_exuberantwitness_00200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_3 ~= true
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_line_3 = true;
			end,
			
			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: EXUBERANTWITNESS
			text = "Friendly fire! What an experience!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsexuberant\001_vo_scr_globalsexuberant_fr_exuberantwitness_00300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_4 ~= true
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_line_4 = true;
			end,
			
			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Are you shooting at me? How invigorating!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsexuberant\001_vo_scr_globalsexuberant_fr_exuberantwitness_00400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_5 ~= true
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_line_5 = true;
			end,
			
			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Your aim is quite commendable!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsexuberant\001_vo_scr_globalsexuberant_fr_exuberantwitness_00500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_6 ~= true
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_line_6 = true;
			end,
			
			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Ammunition is in short supply here. Perhaps you should conserve it!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsexuberant\001_vo_scr_globalsexuberant_fr_exuberantwitness_00600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[7] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_7 ~= true
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_line_7 = true;
			end,
			
			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "I am not your enemy, human! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsexuberant\001_vo_scr_globalsexuberant_fr_exuberantwitness_00700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[8] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_8 ~= true
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_line_8 = true;
			end,
			
			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Unacceptable, absolutely unacceptable!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsexuberant\001_vo_scr_globalsexuberant_fr_exuberantwitness_00800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[9] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_9 ~= true
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_line_9 = true;
			end,
			
			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Protocol dictates action! ... So I will ask you politely to be more careful!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsexuberant\001_vo_scr_globalsexuberant_fr_exuberantwitness_00900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},

	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		if thisConvo.localVariables.s_line_1 and thisConvo.localVariables.s_line_2 and thisConvo.localVariables.s_line_3 and thisConvo.localVariables.s_line_4 and thisConvo.localVariables.s_line_5 and thisConvo.localVariables.s_line_6 and thisConvo.localVariables.s_line_7 and thisConvo.localVariables.s_line_8 and thisConvo.localVariables.s_line_9 then
			thisConvo.localVariables.s_line_1 = false;
			thisConvo.localVariables.s_line_2 = false;
			thisConvo.localVariables.s_line_3 = false;
			thisConvo.localVariables.s_line_4 = false;
			thisConvo.localVariables.s_line_5 = false;
			thisConvo.localVariables.s_line_6 = false;
			thisConvo.localVariables.s_line_7 = false;
			thisConvo.localVariables.s_line_8 = false;
			thisConvo.localVariables.s_line_9 = false;
		end
		object_set_health( ai_get_object(AI.sq_sassy_spark), 1 );
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(sentinels_exuberant_shooting);		
	end,

	localVariables = {
						s_line_1 = nil,
						s_line_2 = nil,
						s_line_3 = nil,
						s_line_4 = nil,
						s_line_5 = nil,
						s_line_6 = nil,
						s_line_7 = nil,
						s_line_8 = nil,
						s_line_9 = nil,
						},
};


----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- ONLY CLIENT/SERVER CODE BEYOND THIS POINT.
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

--## CLIENT

function remoteClient.sound_impulse_start_marker_client(soundTag:tag, theObject:object, theMarker:string, theScale:number)

--	print("Play Whale song - Client");
	sound_impulse_start_marker(soundTag, theObject, theMarker, theScale);
end


function remoteClient.sound_impulse_start_client_narr(soundTag:tag, theObject:object, theScale:number)
print('PASS 5');

	sound_impulse_start(soundTag, theObject, theScale);
end




----------------------------------------------------------------------------------------------------

--	PIP

----------------------------------------------------------------------------------------------------


function remoteClient.sentinels_coliseum_cortana_pip()
	
	print("play Coliseum Cortana PIP")
	hud_play_pip_from_tag(TAG('bink\campaign\h5_pip_proxy_60.bink'));
end

------------------------
--SUBTITLES
------------------------

--156430
--fake function names so that cin_180 compiles -- it's referenced in Sentinels (w3_innerworld) even though it isn't used
function TrialsCinematicSubtitlesPlay()
	print ("stub function so it compiles");
end

function TrialsCinematicSubtitlesKill()
	print ("stub function so it compiles");
end

--156430 - making this client and called from the cinematic to improve subtitle matching
--createing a global client function for tracking this thread and killing it when the cinema is skipped or ended
global th_sentinels_cinematic_subtitles:thread = nil;

function SentinelsCinematicSubtitlesPlay()
	print ("starting sentinels_cinematic_subtitles thread because cinema is starting");
	th_sentinels_cinematic_subtitles = CreateThread (sentinels_cinematic_subtitles);
end

function SentinelsCinematicSubtitlesKill()
	if th_sentinels_cinematic_subtitles then
		print ("killing halsey_cinematic_subtitles thread because cinema is skipping or ending");
		KillThread (th_sentinels_cinematic_subtitles);
		th_sentinels_cinematic_subtitles = nil;
	end
end

function SentinelsCinematicSubtitlesPrint(snd_sound:tag, o_object:object)
	print ("subtitles starting ", snd_sound, o_object);
	sound_impulse_start_dialogue(snd_sound, o_object);
end


function sentinels_cinematic_subtitles()
	sleep_s(46.5);
	SentinelsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_190endgame\001_vo_cin_190endgame_un_masterchief_00400.sound'), nil);
	sleep_s(3);
	SentinelsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_190endgame\001_vo_cin_190endgame_un_locke_00800.sound'), nil);
	sleep_s(9);
	SentinelsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_190endgame\001_vo_cin_190endgame_un_distresscall01_00100.sound'), nil);
	sleep_s(9);
	SentinelsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_190endgame\001_vo_cin_190endgame_un_roland_01400.sound'), nil);
	sleep_s(3);
	SentinelsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_190endgame\001_vo_cin_190endgame_un_lasky_00100.sound'), nil);
	sleep_s(1);
	SentinelsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_190endgame\001_vo_cin_190endgame_un_roland_01500.sound'), nil);
	sleep_s(6);
	SentinelsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_190endgame\001_VO_CIN_190EndGame_UN_LASKY_00200.sound'), nil);
	sleep_s(3);
	SentinelsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_190endgame\001_VO_CIN_190EndGame_UN_CORTANA_02300.sound'), nil);
	sleep_s(2);
	SentinelsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_190endgame\001_VO_CIN_190EndGame_UN_CORTANA_02400.sound'), nil);
	sleep_s(7);
	SentinelsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_190endgame\001_VO_CIN_190EndGame_UN_LASKY_00300.sound'), nil);
	sleep_s(24);
	SentinelsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_190endgame\001_VO_CIN_190EndGame_UN_CORTANA_02500.sound'), nil);
	sleep_s(9);
	SentinelsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_190endgame\001_VO_CIN_190EndGame_UN_ROLAND_01700.sound'), nil);
	sleep_s(1);
	SentinelsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_190endgame\001_VO_CIN_190EndGame_UN_LASKY_00700.sound'), nil);
	sleep_s(1);
	SentinelsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_190endgame\001_VO_CIN_190EndGame_UN_ROLAND_02000.sound'), nil);
	sleep_s(1);
	SentinelsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_190endgame\001_VO_CIN_190EndGame_UN_LASKY_00500.sound'), nil);
	sleep_s(3);
	SentinelsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_190endgame\001_VO_CIN_190EndGame_UN_ROLAND_01900.sound'), nil);
	sleep_s(3);
	SentinelsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_190endgame\001_VO_CIN_190EndGame_UN_LASKY_00600.sound'), nil);
	
	sleep_s(59);
	
	sleep_s(3);
	sleep_s(3);
	SentinelsCinematicSubtitlesPrint(TAG('sound\001_vo\001_vo_cinematic\001_vo_cin_190endgame\001_VO_CIN_190EndGame_UN_HALSEY_00300.sound'), nil);

end