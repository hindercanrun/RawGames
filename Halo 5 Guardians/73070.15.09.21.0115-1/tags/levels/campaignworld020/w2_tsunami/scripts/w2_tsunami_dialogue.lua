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

		global g_screentext_tsunami_stub:thread = nil;

		global g_TurretIsDestroyed:number = 0;

		global b_PlayerInteractedWithTurret01:boolean = false;
		
		global b_eliminate_first_turret_repeat:number = 0;


		global b_players_saw_burgertown_turret:boolean = false;
		global b_players_saw_tangletown_turret:boolean = false;

		global b_arbiter_is_leaving:boolean = false;

		global b_player_went_on_second_floor:boolean = false;
		global b_player_went_past_shield:boolean = false;
	
		global b_player_saw_elevator_01:boolean = false;

		global b_look_at_vista:object = nil;
		global b_look_at_vista_locke:boolean = false;
		global b_look_at_vista_buck:boolean = false;
		global b_look_at_vista_tanaka:boolean = false;
		global b_look_at_vista_vale:boolean = false;	
		
		
		global b_look_at_vista_guardian:object = nil;

		global b_look_at_guardian_locke:boolean = false;
		global b_look_at_guardian_buck:boolean = false;
		global b_look_at_guardian_tanaka:boolean = false;
		global b_look_at_guardian_vale:boolean = false;

		global b_turrettown_go_down_can_play:boolean = false;

		global b_finalfight_spawning_can_start:boolean = false;
		
		global b_turrettown_got_to_jump:boolean = false;
		
		global b_player_interacted_with_elevator_01:boolean = false;

		global b_wrong_direction_locke:boolean = false;
		global b_wrong_direction_buck:boolean = false;
		global b_wrong_direction_tanaka:boolean = false;
		global b_wrong_direction_vale:boolean = false;

		global b_wrong_direction_b_locke:boolean = false;
		global b_wrong_direction_b_buck:boolean = false;
		global b_wrong_direction_b_tanaka:boolean = false;
		global b_wrong_direction_b_vale:boolean = false;

		global b_swordofsang_reports_in:boolean = false;

		global b_tsunami_look_at_turret_power_core:boolean = false;
		
		global b_buck_memory_played:boolean = false;

		global b_tsunami_electrified:boolean = false;

		global b_destruction_alley_stager:boolean = false;
		
		global b_player_saw_first_turret:boolean = false;

		global s_player_looked_at_generator_turret_tangle_town:boolean = false;
		global s_player_looked_at_generator_all:boolean = false;

		global b_burgertown_lookat_turret:boolean = false;

		global b_finalfight_guardian_singing:boolean = false;
		global b_finalfight_guardian_singing_2:boolean = false;

		global b_tangletown_powercore_lookat:object = nil;
		
		global b_turrettown_last_turret_pinged:boolean = false;
		
		global tsunami_is_there_enemy_nearby_result:boolean = false;
		
		global tsunami_chatter_on:boolean = true;
		
		global b_demo_bamf_playing:boolean = false;

		global b_turret_03_killer:boolean = false;
		global b_turret_04_killer:boolean = false;
		global b_turret_05_killer:boolean = false;
				
		global b_turrettown_elite_talk:boolean = false;

		global b_arbiter_kinght_melee_emote:boolean = false;
		
		
		
-- =================================================================================================
-- *** MAIN ***
-- =================================================================================================



function tsunami_narrative_startup()

	print("*************  TSUNAMI NARRATIVE DIALOGUE LOADED ******************");
	g_display_narrative_debug_info = true;

	PrintNarrative("Killing Narrative Queue");
	NarrativeQueue.Kill();

	SleepUntil([| list_count(players()) ~= 0], 10);

	b_push_forward_vo_timer_default = 60;

--	Force display Temp Text from TTS (Subtitles)
--	dialog_line_temp_blurb_force_set(true);	

	CreateMissionThread(PushForwardVO, w2_tsunami_station.goal_finalfight);	
	CreateMissionThread(tsunami_pushforward);
	CreateMissionThread(PushForwardVOStandBy);
	CreateMissionThread(tsunami_chatter);
	CreateMissionThread(tsunami_four_players_combat_check);

end

-- =================================================================================================
--  __  __ _____  _____ _____ _____ ____  _   _    _____ _______       _____ _______ 
-- |  \/  |_   _|/ ____/ ____|_   _/ __ \| \ | |  / ____|__   __|/\   |  __ \__   __|
-- | \  / | | | | (___| (___   | || |  | |  \| | | (___    | |  /  \  | |__) | | |   
-- | |\/| | | |  \___ \\___ \  | || |  | | . ` |  \___ \   | | / /\ \ |  _  /  | |   
-- | |  | |_| |_ ____) |___) |_| || |__| | |\  |  ____) |  | |/ ____ \| | \ \  | |   
-- |_|  |_|_____|_____/_____/|_____\____/|_| \_| |_____/   |_/_/    \_\_|  \_\ |_|   
--                              
-- =================================================================================================


function tsunami_missionstart_load()

	PrintNarrative("LOAD - tsunami_missionstart_load");
	--CreateMissionThread (tsunami_missionstart_landing);
	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing);
	
	CreateMissionThread (tsunami_missionstart_post_door);
	CreateMissionThread (tsunami_missionstart_landing_end_encounter_listener);
	CreateMissionThread (tsunami_missionstart_turret_destroyed_listener);

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing_see");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing_see);

	CreateMissionThread(tsunami_look_at_turret_power_core);

	tsunami_chatter_on = false;

end

--------------------------



function tsunami_look_at_turret_power_core()

	PrintNarrative("START - tsunami_look_at_turret_power_core");

	if not b_tsunami_look_at_turret_power_core then
		
		b_tsunami_look_at_turret_power_core = true;

		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_generator_locke");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_generator_locke);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_generator_buck");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_generator_buck);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_generator_tanaka");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_generator_tanaka);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_generator_vale");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_generator_vale);

		repeat		
			PrintNarrative("REPEAT LOOP - tsunami_look_at_turret_power_core - Not all players saw it.");
												
							repeat						
								
								PrintNarrative("REPEAT LOOP - tsunami_look_at_turret_power_core - sleepuntil");

								SleepUntil ([|	NarrativeQueue.ConversationsPlayingCount() == 0 and not s_player_looked_at_generator_all
											and ((volume_test_players( VOLUMES.tv_narrative_burgertown_turret_00_power_core ) and object_valid("shrike_power_source_0") and objects_can_see_object(players(), OBJECTS.shrike_power_source_0, 15))
												or (volume_test_players( VOLUMES.tv_narrative_burgertown_turret_01_power_core ) and object_valid("shrike_power_source_1") and  objects_can_see_object(players(), OBJECTS.shrike_power_source_1, 15))
												or (volume_test_players( VOLUMES.tv_narrative_burgertown_turret_02_power_core ) and object_valid("shrike_power_source_2") and  objects_can_see_object(players(), OBJECTS.shrike_power_source_2, 15))
												or (volume_test_players( VOLUMES.tv_narrative_burgertown_turret_03_power_core ) and object_valid("shrike_power_source_3") and  objects_can_see_object(players(), OBJECTS.shrike_power_source_3, 10))
												or (volume_test_players( VOLUMES.tv_narrative_burgertown_turret_04_power_core ) and object_valid("shrike_power_source_4") and  objects_can_see_object(players(), OBJECTS.shrike_power_source_4, 15))
												or (volume_test_players( VOLUMES.tv_narrative_burgertown_turret_05_power_core ) and object_valid("shrike_power_source_5") and  objects_can_see_object(players(), OBJECTS.shrike_power_source_5, 15)))], 10);

								if object_valid("shrike_power_source_0") and object_at_distance_and_can_see_object(players(), OBJECTS.shrike_power_source_0, 15, 15, VOLUMES.tv_narrative_burgertown_turret_00_power_core) and b_shrike_0 then
									W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_speaker = spartan_look_at_object(players(), OBJECTS.shrike_power_source_0, 5, 15, 0.6, 1);
									W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_core = OBJECTS.shrike_power_source_0;
								elseif object_valid("shrike_power_source_1") and object_at_distance_and_can_see_object(players(), OBJECTS.shrike_power_source_1, 15, 15, VOLUMES.tv_narrative_burgertown_turret_01_power_core) and b_shrike_1  then
									W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_speaker = spartan_look_at_object(players(), OBJECTS.shrike_power_source_1, 5, 15, 0.6, 1);
									W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_core = OBJECTS.shrike_power_source_1;
								elseif object_valid("shrike_power_source_2") and object_at_distance_and_can_see_object(players(), OBJECTS.shrike_power_source_2, 15, 15, VOLUMES.tv_narrative_burgertown_turret_02_power_core) and b_shrike_2  then
									W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_speaker = spartan_look_at_object(players(), OBJECTS.shrike_power_source_2, 5, 15, 0.6, 1);
									W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_core = OBJECTS.shrike_power_source_2;
								elseif object_valid("shrike_power_source_3") and object_at_distance_and_can_see_object(players(), OBJECTS.shrike_power_source_3, 15, 10, VOLUMES.tv_narrative_burgertown_turret_03_power_core) and b_shrike_3  then
									W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_speaker = spartan_look_at_object(players(), OBJECTS.shrike_power_source_3, 5, 10, 1, 1);
									W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_core = OBJECTS.shrike_power_source_3;
								elseif object_valid("shrike_power_source_4") and object_at_distance_and_can_see_object(players(), OBJECTS.shrike_power_source_4, 15, 15, VOLUMES.tv_narrative_burgertown_turret_04_power_core) and b_shrike_4  then
									W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_speaker = spartan_look_at_object(players(), OBJECTS.shrike_power_source_4, 5, 15, 1.2, 1);
									W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_core = OBJECTS.shrike_power_source_4;
								elseif object_valid("shrike_power_source_5") and object_at_distance_and_can_see_object(players(), OBJECTS.shrike_power_source_5, 15, 15, VOLUMES.tv_narrative_burgertown_turret_05_power_core) and b_shrike_5  then
									W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_speaker = spartan_look_at_object(players(), OBJECTS.shrike_power_source_5, 5, 15, 0.6, 1);
									W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_core = OBJECTS.shrike_power_source_5;
								else
									PrintNarrative("REPEAT LOOP - tsunami_look_at_turret_power_core - Nobody is looking or Turret is already destroyed");
								end

							until W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_speaker ~= nil

							PrintNarrative("REPEAT LOOP - tsunami_look_at_turret_power_core - post sleepuntil");					

		until ((IsPlayer(SPARTANS.locke) and W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_locke == true)
					and (IsPlayer(SPARTANS.buck) and W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_buck == true)
					and (IsPlayer(SPARTANS.tanaka) and W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_tanaka == true)
					and (IsPlayer(SPARTANS.vale) and W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_vale == true)
				) or 
					not ( IsGoalActive(w2_tsunami_station.goal_start) or IsGoalActive(w2_tsunami_station.goal_burgertown) or  IsGoalActive(w2_tsunami_station.goal_tangletown) or  IsGoalActive(w2_tsunami_station.goal_turrettown))

		b_tsunami_look_at_turret_power_core = false;

	end

	PrintNarrative("END - tsunami_look_at_turret_power_core");
end



--[========================================================================[
          Tsunami. Mission start. landing

          The player is dropped directly into combat. In front of him,
          there is a AA turret, an Elite and a few Grunts.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.gr_turret0_all) > 1 ; -- GAMMA_CONDITION
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

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: ValE
			text = "Here they come!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_05400.sound'),

		},	
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Arbiter",

			character = AI.sq_turr0_arbiter_a.spawnpoint81, -- GAMMA_CHARACTER: Arbiter
			text = "Swords of Sanghelios, with me!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_arbiter_01300.sound'),

		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Arbiter",

			character = AI.sq_turr0_arbiter_a.spawnpoint81, -- GAMMA_CHARACTER: Arbiter
			text = "Target the air defenses! Clear landing zones!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_arbiter_02000.sound'),


			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
					--	OBJECTIVE TEXT
					-- CreateMissionThread(title_objective_disable);		-- moved to post-arbiter
					CreateMissionThread(track_intro_aa);
				return 4; 
			end,
		},					
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Arbiter",

			character = AI.sq_turr0_arbiter_a.spawnpoint81, 
			text = "For Sanghelios!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_arbiter_03900.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[5] = {
			character = AI.sq_turr0_arbiter_b.spawnpoint98, 
			text = "For Sanghelios!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend01_00100.sound'),
						
			playDurationAdjustment = (random_range( 0, 1)/10),
		},
		[6] = {
			character = AI.sq_turr0_arbiter_c.spawnpoint99,
			text = "For Sanghelios!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend02_00100.sound'),
						
			playDurationAdjustment = (random_range( 0, 1)/10),
		},
		[7] = {
			character = AI.sq_turr0_arbiter_c.spawnpoint99,
			text = "For Sanghelios!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend03_00100.sound'),
						
			playDurationAdjustment = (random_range( 0, 1)/10),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread (tsunami_missionstart_landing_covies);
	end,
		
};

------------------------------

function Tsunami__Mission_start__landing__elite()

	PrintNarrative("START - Tsunami__Mission_start__landing__elite");
	
	sleep_s(3);

	IsThereAnEnemyInRangeLauncher(W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__elite, AI.gr_arbiter_turret0, ACTOR_TYPE.elite, "enemy_in_range", w2_tsunami_station.goal_start, 10 );
	
end

--[========================================================================[
          Tsunami. Mission start. landing. Elite
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__elite = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__elite",	

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

		lines = {
			[1] = {
					If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
						return b_shrike_0;
					end,
					--character = AI.sq_turr0_arbiter_c.spawnpoint99,
					text = "The covenant will perish!\r\n",
					tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend01_00300.sound'),
				},
		},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};


------------------------------------------------------------------------------------------------------

function tsunami_missionstart_landing_covies()

	PrintNarrative("WAKE - tsunami_missionstart_landing_covies");

	SleepUntil([| ai_living_count(AI.gr_turret0_all) > 1 ], 30);

	PrintNarrative("START - tsunami_missionstart_landing_covies");
	
	CreateMissionThread(Tsunami__Mission_start__landing__grunt_01);
				
	CreateMissionThread(Tsunami__Mission_start__landing__covies_jackal);	

	PrintNarrative("END - tsunami_missionstart_landing_covies");

end



function Tsunami__Mission_start__landing__grunt_01()

	PrintNarrative("START - Tsunami__Mission_start__landing__grunt_01");

	IsThereAnEnemyInRangeLauncher(W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__grunt_01, AI.gr_turret0_all, ACTOR_TYPE.grunt, "enemy_in_range", w2_tsunami_station.goal_start, 10 );

end

--[========================================================================[
          Tsunami. Mission start. landing. covies

          The Covenants react to the arrival of the player & Arbiter.
          They are surprised to see the Arbiter himself!
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__grunt_01 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__grunt_01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,

	lines = {
		[1] = {							
			text = "The Swords of Sanghelios are here!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt01_00300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(Tsunami__Mission_start__landing__grunt_02);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};



function Tsunami__Mission_start__landing__grunt_02()

	PrintNarrative("START - Tsunami__Mission_start__landing__grunt_02");

	sleep_s(1);

	IsThereAnEnemyInRangeLauncher(W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__grunt_02, AI.gr_turret0_all, ACTOR_TYPE.grunt, "enemy_in_range", w2_tsunami_station.goal_start, 10, true );
	
end

--[========================================================================[
          Tsunami. Mission start. landing. covies

          The Covenants react to the arrival of the player & Arbiter.
          They are surprised to see the Arbiter himself!
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__grunt_02 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__grunt_02",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			text = "Alert! Alert! Warn the others!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt02_00600.sound'),
			
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(Tsunami__Mission_start__landing__grunt_03);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};


function Tsunami__Mission_start__landing__grunt_03()

	PrintNarrative("START - Tsunami__Mission_start__landing__grunt_03");

	sleep_s(5);

	IsThereAnEnemyInRangeLauncher(W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__grunt_03, AI.gr_turret0_all, ACTOR_TYPE.grunt, "enemy_in_range", w2_tsunami_station.goal_start, 10, true );
	
end

--[========================================================================[
          Tsunami. Mission start. landing. covies

          The Covenants react to the arrival of the player & Arbiter.
          They are surprised to see the Arbiter himself!
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__grunt_03 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__grunt_03",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {		
			--character = thisConvo.localVariables.EnemyInRange, -- GAMMA_CHARACTER: grunt02
			text = "Protect the turret!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt02_00400.sound'),

			sleepAfter = 3,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(Tsunami__Mission_start__landing__grunt_04);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};



function Tsunami__Mission_start__landing__grunt_04()

	PrintNarrative("START - Tsunami__Mission_start__landing__grunt_04");

	sleep_s(3);

	IsThereAnEnemyInRangeLauncher(W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__grunt_04, AI.gr_turret0_all, ACTOR_TYPE.grunt, "enemy_in_range", w2_tsunami_station.goal_start, 10, true );
	
end

--[========================================================================[
          Tsunami. Mission start. landing. covies

          The Covenants react to the arrival of the player & Arbiter.
          They are surprised to see the Arbiter himself!
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__grunt_04 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__grunt_04",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,
	
	lines = {
		[1] = {						
			text = "The Arbiter! He's so big!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt02_00100.sound'),

			sleepAfter = 3,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(Tsunami__Mission_start__landing__grunt_05);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};




function Tsunami__Mission_start__landing__grunt_05()

	PrintNarrative("START - Tsunami__Mission_start__landing__grunt_05");

	sleep_s(5);

	IsThereAnEnemyInRangeLauncher(W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__grunt_05, AI.gr_turret0_all, ACTOR_TYPE.grunt, "enemy_in_range", w2_tsunami_station.goal_start, 10, true );
	
end
--[========================================================================[
          Tsunami. Mission start. landing. covies

          The Covenants react to the arrival of the player & Arbiter.
          They are surprised to see the Arbiter himself!
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__grunt_05 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__grunt_05",
	
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {

			text = "I finally get to kill the Arbiter!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt01_00100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};




function Tsunami__Mission_start__landing__covies_jackal()

	PrintNarrative("START - Tsunami__Mission_start__landing__covies_jackal");

	sleep_s(5);

	IsThereAnEnemyInRangeLauncher(W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__covies_jackal, AI.sq_turr0_main, ACTOR_TYPE.jackal, "enemy_in_range", w2_tsunami_station.goal_start, 7, true );
	
end

--[========================================================================[
          Tsunami. Mission start. landing. covies

          The Covenants react to the arrival of the player & Arbiter.
          They are surprised to see the Arbiter himself!
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__covies_jackal = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__covies_jackal",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {		
			text = "False Arbiter! Kill! Kill!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_jackal01_00300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};




--[========================================================================[
          Tsunami. Mission start. landing

          The player is dropped directly into combat. In front of him,
          there is a AA turret and a few Covenants.

          Arbiter is with us with 3 of his Elites.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing_see = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing_see",

	CanStart = function (thisConvo, queue)
		return IsSpartanAbleToSpeak(SPARTANS.locke) and volume_test_players( VOLUMES.tv_narrative_mission_start_landing_see ); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(60);
	end,

	sleepBefore = 1.5,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return b_shrike_0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "There's the first of the air defenses. Push forward. Take it out.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_10800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_player_saw_first_turret = true;
		CreateMissionThread(Tsunami__Mission_start__landing__elite);
		CreateMissionThread(tsunami_missionstart_turret_destroyed_launcher_2);
	end,
};



------------------------------------------------------------------------------------------------------


function tsunami_missionstart_landing_end_encounter_listener()

	SleepUntil([| ai_living_count(AI.gr_turret0_all) <= 1 ], 1);

	local s_last_living_ai:object = ai_get_unit( AI.gr_turret0_all );

	PrintNarrative("LISTENER - tsunami_missionstart_landing_end_encounter_listener");
	print(" LAst AI alive is:  ", s_last_living_ai);

	if ai_living_count(AI.gr_turret0_all) <= 0 then
		PrintNarrative("LISTENER - tsunami_missionstart_landing_end_encounter_listener - ALL DEAD");

		CreateMissionThread(tsunami_missionstart_landing_end_encounter_launcher, s_last_living_ai, ai_get_object(AI.sq_turr0_arbiter_a.spawnpoint81));
	else
		RegisterDeathEvent (tsunami_missionstart_landing_end_encounter_launcher, s_last_living_ai);
	end
end
---------------------
function tsunami_missionstart_landing_end_encounter_launcher(target:object, killer:object)

	PrintNarrative("LAUNCHER - tsunami_missionstart_landing_end_encounter_launcher");

	print(killer, " is the killer of ", target);

	--CreateMissionThread(tsunami_missionstart_landing_end_encounter, killer);

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__End_enc");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__End_enc);
	W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__End_enc.localVariables.killer = killer;
end

--[========================================================================[
          Tsunami. Mission start. landing. End encounter
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__End_enc = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__End_enc",
	
	CanStart = function (thisConvo, queue)
		return true ; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(40);
	end,

	-- Sleep before running the conversation's OnStart()
	sleepBefore = 2,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.locke; -- GAMMA_TRANSITION: If locke kills the last enemy
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "All clear!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_00400.sound'),

		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.buck; -- GAMMA_TRANSITION: If buck kills the last enemy
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "All clear!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_00800.sound'),

		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.tanaka; -- GAMMA_TRANSITION: If tanaka kills the last enemy
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "All clear!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_00200.sound'),

		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.vale; -- GAMMA_TRANSITION: If vale kills the last enemy
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "All clear!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_02100.sound'),

		},
		[5] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return not (thisConvo.localVariables.killer == SPARTANS.locke or W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__End_enc.localVariables.killer == SPARTANS.buck or W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__End_enc.localVariables.killer == SPARTANS.tanaka or W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__End_enc.localVariables.killer == SPARTANS.vale);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Arbiter",

			character = AI.sq_turr0_arbiter_a.spawnpoint81, -- GAMMA_CHARACTER: Arbiter
			text = "All clear!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_arbiter_00700.sound'),

			sleepAfter = 1,
		},
		[6] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return b_shrike_0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Arbiter",

			character = AI.sq_turr0_arbiter_a.spawnpoint81, -- GAMMA_CHARACTER: Arbiter
			text = "Disable the air defenses. Target either the cannon itself or the power supply.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_arbiter_00200.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 0.5,

	OnFinish = function (thisConvo, queue)		
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__turret");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__turret);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__arbiter");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__arbiter);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__split");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__split);
		
		PrintNarrative("END - "..thisConvo.name);		
	end,

	localVariables = {
						killer = nil
					},
};



--[========================================================================[
          Tsunami. Mission start. landing. End encounter
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__turret = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__turret",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_timer <= 5 and b_push_forward_vo_timer > 1; -- GAMMA_CONDITION
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
				return IsGoalActive(w2_tsunami_station.goal_start) and object_valid("shrike_power_source_0") and object_get_health(OBJECTS.shrike_power_source_0) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					PushForwardVOReset();
			end,
			
			moniker = "Arbiter",

			character = AI.sq_turr0_arbiter_a.spawnpoint81, -- GAMMA_CHARACTER: Arbiter
			text = "Spartan Locke, disable the air defense cannon.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_arbiter_03400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
						killer = nil,
					},
};



--[========================================================================[
          Tsunami. Mission start. landing. arbiter
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__arbiter = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__arbiter",

	CanStart = function (thisConvo, queue)
		return IsGoalActive(w2_tsunami_station.goal_start); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		tsu_narrative_is_on = true;
		PushForwardVOReset(90);
	end,

--[[	Timeout = function (thisConvo, queue) -- NUMBER
		if object_get_health(OBJECTS.shrike_power_source_0) <= 0 then 
			tsu_narrative_is_on = false;
			return 0;
		else
			return 30;
		end;
	end,
]]
	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Arbiter",
			
			character = AI.sq_turr0_arbiter_a.spawnpoint81, -- GAMMA_CHARACTER: Arbiter
			text = "The Guardian is at the far end of the city. There are more anti-air emplacements in that direction...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_arbiter_00300.sound'),

		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "We'll clear out turrets as we go.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_07100.sound'),

		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Arbiter",

			character = AI.sq_turr0_arbiter_a.spawnpoint81, -- GAMMA_CHARACTER: Arbiter
			text = "Good luck to you, Spartan. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_arbiter_01500.sound'),

		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "And to you, Arbiter.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_08500.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
		tsu_narrative_is_on = false;
		hud_hide_radio_transmission_hud();
		print ("ARBITER AND LOCKE CONVERSATION IS FINISHED!");
		PrintNarrative("END - "..thisConvo.name);
		b_turr0_explained = true;
	end,

	
};



--[========================================================================[
          Tsunami. Mission start. landing. split

                                                  AFTER ARBITER
                                                  DESTROYS THE AA
                                                  TURRET
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__split = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__Mission_start__landing__split",
	
	CanStart = function (thisConvo, queue)
		return b_arbiter_is_leaving; -- Set in the composition of Arbiter leaving the area.
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(90);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Alright, Spartans. There's ground to cover between here and the Guardian. Move out.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_00500.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		tsunami_chatter_on = true;
	end,

	
};

------------------------------------------------------------------------------------------------------

function tsunami_missionstart_turret_destroyed_listener()
local killer:object = nil;

	SleepUntil([| object_valid( "shrike_power_source_0" ) ], 60);
	SleepUntil([| device_get_power( OBJECTS.dm_shriketurret_00) == 1 ], 60);

	PrintNarrative("LISTENER - tsunami_missionstart_turret_destroyed_listener");

	RegisterDeathEvent( tsunami_missionstart_turret_destroyed_launcher, OBJECTS.shrike_power_source_0);
	RegisterDeathEvent( tsunami_missionstart_turret_destroyed_launcher, OBJECTS.dm_shriketurret_00);

	
	SleepUntil([| b_shrike_0 == false ], 60);

	sleep_s(0.2);

	if W2TsunamiTitanAtTsunami_Tsunami__Mission_start__turret_00_destro.localVariables.killer == nil then
	print("LISTENER - tsunami_missionstart_turret_destroyed_listener - No killer register, need to be use plan B to find one: ");

		killer = spartan_look_at_object(players(), OBJECTS.dm_shriketurret_00, 30, 30, 0.1, 2);
		print("LISTENER - tsunami_missionstart_turret_destroyed_listener - picking player looking at turret: ",killer );

		if killer == nil then
			killer = GetClosestMusketeer(OBJECTS.dm_shriketurret_00, 20, 0);
			print("LISTENER - tsunami_missionstart_turret_destroyed_listener - no player was looking, picking closest musketeer: ",killer );

			if killer == nil then
				killer = GetClosestMusketeer(OBJECTS.dm_shriketurret_00, 50, 2);
				print("LISTENER - tsunami_missionstart_turret_destroyed_listener - no musketeer nearby, picking closest player: ",killer );
			end
		end
			
		if object_get_health(OBJECTS.shrike_power_source_0) <= 0 then
			tsunami_missionstart_turret_destroyed_launcher(OBJECTS.shrike_power_source_0, killer)
		elseif object_get_health(OBJECTS.dm_shriketurret_00) <= turret_shrike_death_health then
			tsunami_missionstart_turret_destroyed_launcher(OBJECTS.dm_shriketurret_00, killer)
		end

	end

end

--------------------------
function tsunami_missionstart_turret_destroyed_launcher(turret:object, killer:object)

		PrintNarrative("LAUNCHER - tsunami_missionstart_turret_destroyed_launcher");

		UnregisterDeathEvent( tsunami_missionstart_turret_destroyed_launcher, OBJECTS.shrike_power_source_0);
		UnregisterDeathEvent( tsunami_missionstart_turret_destroyed_launcher, OBJECTS.dm_shriketurret_00);

		print(killer, " is the killer of ", turret);
		
		W2TsunamiTitanAtTsunami_Tsunami__Mission_start__turret_00_destro.localVariables.killer = killer;
end

function tsunami_missionstart_turret_destroyed_launcher_2()

	SleepUntil([| W2TsunamiTitanAtTsunami_Tsunami__Mission_start__turret_00_destro.localVariables.killer ~= nil ], 10);

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__Mission_start__turret_00_destro");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__Mission_start__turret_00_destro);

end


--[========================================================================[
          Tsunami. Mission start. turret 00 destroyed
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__Mission_start__turret_00_destro = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__Mission_start__turret_00_destro",

	CanStart = function (thisConvo, queue)
		return 	(thisConvo.localVariables.killer == SPARTANS.locke or thisConvo.localVariables.killer == SPARTANS.buck or thisConvo.localVariables.killer == SPARTANS.tanaka or thisConvo.localVariables.killer == SPARTANS.vale); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 0.6,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(90);		
	end,
	
	Timeout = function (thisConvo, queue) -- NUMBER
		return 5;
	end,	

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Arbiter",

			character = AI.sq_turr0_arbiter_a.spawnpoint81, -- GAMMA_CHARACTER: Arbiter
			text = "Excellent.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_arbiter_00900.sound'),

			playDurationAdjustment = 0.9,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

		},
	},

	sleepAfter = 0.5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
						killer = nil
					},
};



------------------------------------------------------------------------------------------------------

function tsunami_missionstart_door_opening_covies()

	SleepUntil(	[|	ai_living_count(AI.sq_door_01) > 0	], 1);
	--	DISABLE GRUNT AI DIALOGUE
	AIDialogManager.DisableAIDialog(AI.sq_door_01);		

	--sleep_s(2);

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__Mission_start__door_opening_grunt");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__Mission_start__door_opening_grunt);


end



--[========================================================================[
          Tsunami. Mission start. door opening grunt

          Grunts are coming through the door.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__Mission_start__door_opening_grunt = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__Mission_start__door_opening_grunt",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_door_01.spawnpoint85) > 0 and ai_living_count(AI.sq_door_01.spawnpoint84) > 0; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(90);
		
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return ai_living_count(AI.sq_door_01.spawnpoint84) == 1; -- GAMMA_TRANSITION: Before the door opens
			end,
			
			character = AI.sq_door_01.spawnpoint84,
			text = "No don't open the door! They're behind!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt01_00700.sound'),
		},
		[2] = {

			If = function (thisLine, thisConvo, queue, lineNumber)
				return ai_living_count(AI.sq_door_01.spawnpoint85) == 1; -- GAMMA_TRANSITION: Before the door opens
			end,
			
			character = AI.sq_door_01.spawnpoint85,
			text = "With me Boo!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt02_00800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__Mission_start__door_opening_grunt_2");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__Mission_start__door_opening_grunt_2);	

	end,

	
};


--[========================================================================[
          Tsunami. Mission start. door opening covies door open

          Elites Covenant taunts.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__Mission_start__door_opening_grunt_2 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__Mission_start__door_opening_grunt_2",
	
	CanStart = function (thisConvo, queue)
		return object_valid("dm_tsu_door_01") and device_get_position(OBJECTS.dm_tsu_door_01) >= 0.8 and ai_living_count(AI.sq_door_01) > 0;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		AIDialogManager.EnableAIDialog(AI.sq_door_01);
	end,

	lines = {
		[1] = {

			If = function (thisLine, thisConvo, queue, lineNumber)
				return ai_living_count(AI.sq_door_01.spawnpoint84) == 1; -- GAMMA_TRANSITION: When the door opens
			end,

			character = AI.sq_door_01.spawnpoint84,
			text = "They're humans!!!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt01_00800.sound'),
		},
		
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return ai_living_count(AI.sq_door_01.spawnpoint85) == 1; -- GAMMA_TRANSITION: When the door opens
			end,

			character = AI.sq_door_01.spawnpoint85,
			text = "Attack!!!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt02_00900.sound'),

		},
		
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,	
};



------------------------------------------------------------------------------------------------------

function tsunami_missionstart_door_opening_osiris()

	PrintNarrative("WAKE - tsunami_missionstart_door_opening_osiris");

	--	From Mission script

	sleep_s(2);

	local lookattimer:number = 0;
	local s_speaker:object = nil;

	repeat
		lookattimer = lookattimer + 0.2
		sleep_s(0.2);
		
	until volume_test_players_lookat( VOLUMES.tv_narrative_tsunami_missionstart_door_opening_osiris, 15, 25 ) or lookattimer >= 3 or IsSpartanInCombat()		
				
	if not volume_test_players_lookat( VOLUMES.tv_narrative_tsunami_missionstart_door_opening_osiris, 15, 25 ) then
		s_speaker = GetClosestMusketeer(ai_get_object(AI.sq_door_01.spawnpoint85));
	end

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__Mission_start__door_opening");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__Mission_start__door_opening);
	W2TsunamiTitanAtTsunami_Tsunami__Mission_start__door_opening.localVariables.s_speaker = s_speaker;

	PrintNarrative("END - tsunami_missionstart_door_opening");

end



--[========================================================================[
          Tsunami. Mission start. door opening
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__Mission_start__door_opening = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__Mission_start__door_opening",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	sleepBefore = 1.4,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke  or ( IsPlayer(SPARTANS.locke) and volume_test_player_lookat( VOLUMES.tv_narrative_tsunami_missionstart_door_opening_osiris, unit_get_player(SPARTANS.locke), 15, 25 ) ) ; -- GAMMA_TRANSITION: If locke player look at elite at the door or next available spartan
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Covies coming through the door!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_00600.sound'),

		},
		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_speaker == SPARTANS.buck  or ( IsPlayer(SPARTANS.locke) and volume_test_player_lookat( VOLUMES.tv_narrative_tsunami_missionstart_door_opening_osiris, unit_get_player(SPARTANS.buck), 15, 25 ) );
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Covies in the doorway!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_05000.sound'),

		},
		[3] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka  or ( IsPlayer(SPARTANS.locke) and volume_test_player_lookat( VOLUMES.tv_narrative_tsunami_missionstart_door_opening_osiris, unit_get_player(SPARTANS.tanaka), 15, 25 ) );
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Covies - doorway ahead!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_04000.sound'),

		},
		[4] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_speaker == SPARTANS.vale  or ( IsPlayer(SPARTANS.locke) and volume_test_player_lookat( VOLUMES.tv_narrative_tsunami_missionstart_door_opening_osiris, unit_get_player(SPARTANS.vale), 15, 25 ) );
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Watch the door! Covies coming through!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_02900.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {
						s_speaker = nil
					},
};


------------------------------------------------------------------------------------------------------

function tsunami_missionstart_post_door()

	PrintNarrative("WAKE - tsunami_missionstart_post_door");

	SleepUntil([| ai_living_count(AI.gr_doorgroup_01) > 0], 1);

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__Mission_start__post_door");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__Mission_start__post_door);

end



--[========================================================================[
          Tsunami. Mission start. post door
          * Prepare the "TICKING CLOCK" of the whale song and the rise
          of the Guardian. 

          After the grunts at the door, there is a brief empty
          plaza/space to cross before reaching the next turret.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__Mission_start__post_door = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__Mission_start__post_door",
	
	CanStart = function (thisConvo, queue)
		return (volume_test_players(VOLUMES.tv_narrative_tsunami_missionstart_post_door) and ai_living_count(AI.sq_door_01) == 0) or volume_test_players(VOLUMES.tv_narrative_tsunami_missionstart_post_door_2); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	sleepBefore = 0.5,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BuCK
			text = "How do we know if Doctor Halsey's plan worked and the Constructor did its job? ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_04600.sound'),
			
			sleepAfter = 0.5,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Guardian'll start moving. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_03500.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players(VOLUMES.tv_narrative_tsunami_missionstart_post_door_3);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VaLE
			text = "Just need to be close enough to jump onboard when it does.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_05500.sound'),

		},

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__Mission_start__vista");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__Mission_start__vista);
	end,

	
};


------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- Burger Town
------------------------------------------------------------------------------------------------------


function tsunami_burgertown_load()

	PrintNarrative("LOAD - tsunami_burgertown_load");

		
		--CreateMissionThread(tsunami_missionstart_vista);				

		CreateMissionThread(Tsunami__burger_town__Look_at);
		
		CreateMissionThread (tsunami_burgertown_turret_destroyed_listener);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__burger_town__exit_door");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__burger_town__exit_door);
		--PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__burger_town__spirit");
		--NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__burger_town__spirit);

		CreateMissionThread(tsunami_look_at_turret_power_core);

		CreateMissionThread(Tsunami__burger_town__covenant_grunt_01);
		
		b_push_forward_vo_timer_default = 40;
		PushForwardVOReset();

end




--[========================================================================[
          Tsunami. Mission start. vista

          As you enter this area:
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__Mission_start__vista = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__Mission_start__vista",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_burgertown_lookat_turret;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOAdd(2);
		b_swordofsang_reports_in = true;
	end,

	lines = {
		[1] = {			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "FlightLeader",

			--character = 0, -- GAMMA_CHARACTER: Elite01
			text = "Swords of Sanghelios! All ships report in!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elite01_02400.sound'),

			playDurationAdjustment = 0.9,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__Mission_start__vista_3");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__Mission_start__vista_3);
	end,
};




--[========================================================================[
          Tsunami. Mission start. vista

          As you enter this area:
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__Mission_start__vista_3 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__Mission_start__vista_3",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_burgertown_lookat_turret;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOAdd(2);
		b_swordofsang_reports_in = true;
	end,

	lines = {
		[1] = {	
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingSiqtarTwo",

			--character = 0, -- GAMMA_CHARACTER: EliTE04
			text = "Havoc on station. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elite04_00200.sound'),

			playDurationAdjustment = 0.9,

		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__Mission_start__vista_4");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__Mission_start__vista_4);
	end,
};



--[========================================================================[
          Tsunami. Mission start. vista

          As you enter this area:
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__Mission_start__vista_4 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__Mission_start__vista_4",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_burgertown_lookat_turret;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_swordofsang_reports_in = true;
		PushForwardVOAdd(2);
	end,

	lines = {
		[1] = {	
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingLarOne",

			--character = 0, -- GAMMA_CHARACTER: EliTEfriend03
			text = "Onslaught on station.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend03_00500.sound'),

			playDurationAdjustment = 0.8,

		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__Mission_start__vista_5");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__Mission_start__vista_5);
	end,
};


--[========================================================================[
          Tsunami. Mission start. vista

          As you enter this area:
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__Mission_start__vista_5 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__Mission_start__vista_5",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_burgertown_lookat_turret;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
		b_swordofsang_reports_in = true;
	end,

	lines = {
		[1] = {	
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingJardamOne",

			--character = 0, -- GAMMA_CHARACTER: EliTEfriend04
			text = "Revolution on station.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend04_00200.sound'),

			playDurationAdjustment = 0.8,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__Mission_start__vista_6");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__Mission_start__vista_6);
	end,
};



--[========================================================================[
          Tsunami. Mission start. vista

          As you enter this area:
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__Mission_start__vista_6 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__Mission_start__vista_6",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_burgertown_lookat_turret;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOAdd(5);
		b_swordofsang_reports_in = true;
	end,

	lines = {
		[1] = {	
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "FlightLeader",

			--character = 0, -- GAMMA_CHARACTER: ElITE01
			text = "All ships, focus fire on Covenant air forces! Send them crashing to a watery grave!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elite01_02500.sound'),

			playDurationAdjustment = 0.95,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__Mission_start__vista_locke");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__Mission_start__vista_locke);
	end,
};

--[========================================================================[
          Tsunami. Mission start. vista

          As you enter this area:
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__Mission_start__vista_locke = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__Mission_start__vista_locke",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOAdd(5);
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 6;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "The Swords of Sanghelios fleet is arriving. Bring down the air defenses so they stand a chance.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_10900.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};



function Tsunami__burger_town__covenant_grunt_01()

	PrintNarrative("START - Tsunami__burger_town__covenant_grunt_01");

	SleepUntil(	[|	ai_living_count(AI.gr_burgertown_all_exterior) > 0], 30);

	IsThereAnEnemyInRangeLauncher(W2TsunamiTitanAtTsunami_Tsunami__burger_town__covenant_grunt_01, AI.gr_burgertown_all_exterior, ACTOR_TYPE.grunt, "enemy_in_range", w2_tsunami_station.goal_burgertown, 12 );
	
end



--[========================================================================[
          Tsunami. burger town. covenant
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__burger_town__covenant_grunt_01 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__burger_town__covenant_grunt_01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			--character = AI.sq_bt_turretguard.spawnpoint116,
			text = "The enemy is there! Hold position!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt02_00500.sound'),
		},
	},
	
	OnFinish = function (thisConvo, queue)
	PrintNarrative("END - "..thisConvo.name);
	CreateMissionThread(Tsunami__burger_town__covenant_grunt_02);
	end,

		localVariables = {
						enemy_in_range = nil,
					},
};



function Tsunami__burger_town__covenant_grunt_02()

	PrintNarrative("START - Tsunami__burger_town__covenant_grunt_02");

	sleep_s(5);

	IsThereAnEnemyInRangeLauncher(W2TsunamiTitanAtTsunami_Tsunami__burger_town__covenant_grunt_02, AI.gr_burgertown_all_exterior, ACTOR_TYPE.grunt, "enemy_in_range", w2_tsunami_station.goal_burgertown, 10 );
	
end

--[========================================================================[
          Tsunami. burger town. covenant
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__burger_town__covenant_grunt_02 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__burger_town__covenant_grunt_02",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			--character = AI.sq_bt_turretguard.spawnpoint01,
			text = "On your knees, humans! Beg for mercy!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt01_00400.sound'),
		},
	},
	
	OnFinish = function (thisConvo, queue)
	PrintNarrative("END - "..thisConvo.name);
	end,

		localVariables = {
					enemy_in_range = nil,
					},
};




--[========================================================================[
          Tsunami. burger town. turret 01 power core

          When player look at the turret's power core, up close.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return thisConvo.localVariables.s_speaker ~= nil;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOAdd(5);
	end,

	PlayOnSpecificPlayer = function(thisConvo, queue)	-- OBJECT (target all clients if unused)
		return thisConvo.localVariables.s_speaker;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return ((IsGoalActive(w2_tsunami_station.goal_tangletown) and b_tangletown_powercore_lookat ~= SPARTANS.locke) or not IsGoalActive(w2_tsunami_station.goal_tangletown))
						 and thisConvo.localVariables.s_speaker == SPARTANS.locke and not thisConvo.localVariables.s_locke and object_get_health(thisConvo.localVariables.s_core) > 0; -- GAMMA_TRANSITION: If locke. client only
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							--radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
							thisConvo.localVariables.s_locke = true;
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "That's the air defense power core. Destroy it to disable the cannon.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_10500.sound'),
			
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return ((IsGoalActive(w2_tsunami_station.goal_tangletown) and b_tangletown_powercore_lookat ~= SPARTANS.buck) or not IsGoalActive(w2_tsunami_station.goal_tangletown))
						 and thisConvo.localVariables.s_speaker == SPARTANS.buck and not thisConvo.localVariables.s_buck and object_get_health(thisConvo.localVariables.s_core) > 0; -- GAMMA_TRANSITION: If locke. client only
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							--radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
							thisConvo.localVariables.s_buck = true;
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "That's the air defense power core. Destroy it to disable the cannon.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_07600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return ((IsGoalActive(w2_tsunami_station.goal_tangletown) and b_tangletown_powercore_lookat ~= SPARTANS.tanaka) or not IsGoalActive(w2_tsunami_station.goal_tangletown))
						 and thisConvo.localVariables.s_speaker == SPARTANS.tanaka and not thisConvo.localVariables.s_tanaka and object_get_health(thisConvo.localVariables.s_core) > 0; -- GAMMA_TRANSITION: If locke. client only
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							--radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
							thisConvo.localVariables.s_tanaka = true;
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "That's the air defense power core. Destroy it to disable the cannon.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_06500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return ((IsGoalActive(w2_tsunami_station.goal_tangletown) and b_tangletown_powercore_lookat ~= SPARTANS.vale) or not IsGoalActive(w2_tsunami_station.goal_tangletown))
						 and thisConvo.localVariables.s_speaker == SPARTANS.vale and not thisConvo.localVariables.s_vale and object_get_health(thisConvo.localVariables.s_core) > 0; -- GAMMA_TRANSITION: If locke. client only
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							--radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
							thisConvo.localVariables.s_vale = true;
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "That's the air defense power core. Destroy it to disable the cannon.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_05100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		thisConvo.localVariables.s_speaker = nil;
		thisConvo.localVariables.s_core = nil;
		s_player_looked_at_generator_all = false;
	end,

	localVariables = {
					s_speaker = nil,
					s_locke = nil,
					s_buck = nil,
					s_tanaka = nil,
					s_vale = nil,
					s_core = nil,
					},
};




--[========================================================================[
          Tsunami. burger town. turret 01 power core

          When player look at the turret's power core, up close.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_generator_locke = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_generator_locke",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_speaker == SPARTANS.locke;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOAdd(5);
		s_player_looked_at_generator_all = true;
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.locke,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return ((IsGoalActive(w2_tsunami_station.goal_tangletown) and b_tangletown_powercore_lookat ~= SPARTANS.locke) or not IsGoalActive(w2_tsunami_station.goal_tangletown))
						 and W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_speaker == SPARTANS.locke and not W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_locke and object_get_health(W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_core) > 0; -- GAMMA_TRANSITION: If locke. client only
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							--radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
							W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_locke = true;
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "That's the air defense power core. Destroy it to disable the cannon.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_10500.sound'),
			
			playDurationAdjustment = 0.85,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_speaker = nil;
		W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_core = nil;
		s_player_looked_at_generator_all = false;
	end,
};



--[========================================================================[
          Tsunami. burger town. turret 01 power core

          When player look at the turret's power core, up close.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_generator_buck = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_generator_buck",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_speaker == SPARTANS.buck;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOAdd(5);
		s_player_looked_at_generator_all = true;
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.buck,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return ((IsGoalActive(w2_tsunami_station.goal_tangletown) and b_tangletown_powercore_lookat ~= SPARTANS.buck) or not IsGoalActive(w2_tsunami_station.goal_tangletown))
						 and W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_speaker == SPARTANS.buck and not W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_buck and object_get_health(W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_core) > 0; -- GAMMA_TRANSITION: If locke. client only
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							--radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
							W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_buck = true;
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "That's the air defense power core. Destroy it to disable the cannon.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_07600.sound'),
			
			playDurationAdjustment = 0.85,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_speaker = nil;
		W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_core = nil;
		s_player_looked_at_generator_all = false;
	end,
};



--[========================================================================[
          Tsunami. burger town. turret 01 power core

          When player look at the turret's power core, up close.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_generator_tanaka = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_generator_tanaka",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_speaker == SPARTANS.tanaka;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOAdd(5);
		s_player_looked_at_generator_all = true;
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.tanaka,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return ((IsGoalActive(w2_tsunami_station.goal_tangletown) and b_tangletown_powercore_lookat ~= SPARTANS.tanaka) or not IsGoalActive(w2_tsunami_station.goal_tangletown))
						 and W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_speaker == SPARTANS.tanaka and not W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_tanaka and object_get_health(W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_core) > 0; -- GAMMA_TRANSITION: If locke. client only
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							--radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
							W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.tanaka = true;
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "That's the air defense power core. Destroy it to disable the cannon.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_06500.sound'),
			
			playDurationAdjustment = 0.85,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_speaker = nil;
		W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_core = nil;
		s_player_looked_at_generator_all = false;
	end,
};


--[========================================================================[
          Tsunami. burger town. turret 01 power core

          When player look at the turret's power core, up close.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_generator_vale = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_generator_vale",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_speaker == SPARTANS.vale;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOAdd(5);
		s_player_looked_at_generator_all = true;
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.vale,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return ((IsGoalActive(w2_tsunami_station.goal_tangletown) and b_tangletown_powercore_lookat ~= SPARTANS.vale) or not IsGoalActive(w2_tsunami_station.goal_tangletown))
						 and W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_speaker == SPARTANS.vale and not W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_vale and object_get_health(W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_core) > 0; -- GAMMA_TRANSITION: If locke. client only
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							--radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
							W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.vale = true;
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "That's the air defense power core. Destroy it to disable the cannon.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_05100.sound'),
			
			playDurationAdjustment = 0.85,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_speaker = nil;
		W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_power_co.localVariables.s_core = nil;
		s_player_looked_at_generator_all = false;
	end,



};
function Tsunami__burger_town__Look_at()

	PrintNarrative("START - Tsunami__burger_town__Look_at");

	repeat

		sleep_s(0.1);
		SleepUntil ([|	volume_test_players (VOLUMES.tv_narrative_tsunami_missionstart_post_door_3)], 10);

		W2TsunamiTitanAtTsunami_Tsunami__burger_town__Look_at.localVariables.s_speaker = spartan_look_at_object(players(), OBJECTS.dm_shriketurret_01, 22, 20, 0, 2);

		if W2TsunamiTitanAtTsunami_Tsunami__burger_town__Look_at.localVariables.s_speaker == nil then
			W2TsunamiTitanAtTsunami_Tsunami__burger_town__Look_at.localVariables.s_speaker = spartan_look_at_object(players(), OBJECTS.dm_shriketurret_01, 17, 50, 0, 2);
		end
		if W2TsunamiTitanAtTsunami_Tsunami__burger_town__Look_at.localVariables.s_speaker == nil and list_count(players()) == 1 then
			W2TsunamiTitanAtTsunami_Tsunami__burger_town__Look_at.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.locke, 20, 0);
		end
	until W2TsunamiTitanAtTsunami_Tsunami__burger_town__Look_at.localVariables.s_speaker ~= nil or volume_test_players( VOLUMES.tv_narrative_burgertown_turret_lookat_safe)

	if volume_test_players( VOLUMES.tv_narrative_burgertown_turret_lookat_safe) then
		W2TsunamiTitanAtTsunami_Tsunami__burger_town__Look_at.localVariables.s_speaker = GetClosestMusketeer(volume_return_players( VOLUMES.tv_narrative_burgertown_turret_lookat_safe)[1], 15, 0);
	else
		W2TsunamiTitanAtTsunami_Tsunami__burger_town__Look_at.localVariables.s_speaker = GetClosestMusketeer(W2TsunamiTitanAtTsunami_Tsunami__burger_town__Look_at.localVariables.s_speaker, 5, 0);
	end

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__burger_town__Look_at");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__burger_town__Look_at);

	PrintNarrative("START - Tsunami__burger_town__Look_at");

end


--[========================================================================[
          Tsunami. burger town. Look at

          When the player sees the first turret.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__burger_town__Look_at = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__burger_town__Look_at",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(30);		
		NarrativeQueue.EndConversationEarly(W2TsunamiTitanAtTsunami_Tsunami__Mission_start__vista);
		b_burgertown_lookat_turret = true;
		tsunami_chatter_on = false;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; 
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke,
			text = "Visual on a anti-air emplacement.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_01000.sound'),			

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5;
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; 
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.buck,
			text = "Eyes on a anti-air emplacement.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_00400.sound'),

			--playDurationAdjustment = 0.95,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5;
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; 
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.tanaka,
			text = " anti-air emplacement there.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_00500.sound'),

			--playDurationAdjustment = 0.95,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5;
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; 
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale,
			text = "I have eyes on an anti-air emplacement.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_00200.sound'),

			--playDurationAdjustment = 0.95,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5;
			end,
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke,
			text = "Shut it down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_01100.sound'),

			playDurationAdjustment = 0.8,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_players_saw_burgertown_turret = true;
		hud_hide_radio_transmission_hud();
		b_burgertown_lookat_turret = false;
	end,

	localVariables = {
					s_speaker = nil,
					},
	
};


------------------------------------------------------------------------------------------------------

--[[
--[========================================================================[
          Tsunami. burger town. spirit

          A spirit is bringing reinforcements
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__burger_town__spirit = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__burger_town__spirit",

	CanStart = function (thisConvo, queue)
		return object_index_valid(ai_get_object(AI.sq_bt_spirit)) and objects_can_see_object( players(), ai_get_object(AI.sq_bt_spirit), 20 ) and objects_distance_to_object( players(), ai_get_object(AI.sq_bt_spirit) ) < 30; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; 
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return IsPlayer(SPARTANS.locke) and objects_can_see_object( SPARTANS.locke, ai_get_object(AI.sq_bt_spirit), 20 ) and objects_distance_to_object( SPARTANS.locke, ai_get_object(AI.sq_bt_spirit) ) < 30; -- GAMMA_TRANSITION: If locke sees the spirit
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Spirit incoming.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_04700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return IsPlayer(SPARTANS.buck) and objects_can_see_object( SPARTANS.buck, ai_get_object(AI.sq_bt_spirit), 20 ) and objects_distance_to_object( SPARTANS.buck, ai_get_object(AI.sq_bt_spirit) ) < 30; -- GAMMA_TRANSITION: If buck sees the spirit
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Spirit incoming.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_03200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return IsPlayer(SPARTANS.tanaka) and objects_can_see_object( SPARTANS.tanaka, ai_get_object(AI.sq_bt_spirit), 20 ) and objects_distance_to_object( SPARTANS.tanaka, ai_get_object(AI.sq_bt_spirit) ) < 30 ; -- GAMMA_TRANSITION: If tanaka sees the spirit
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Spirit incoming.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_02500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return IsPlayer(SPARTANS.vale) and objects_can_see_object( SPARTANS.vale, ai_get_object(AI.sq_bt_spirit), 20 ) and objects_distance_to_object( SPARTANS.vale, ai_get_object(AI.sq_bt_spirit) ) < 30; -- GAMMA_TRANSITION: If vale sees the spirit
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Spirit incoming.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_04100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	
};

]]


------------------------------------------------------------------------------------------------------


--[========================================================================[
          Tsunami. burger town. exit door

          The first player to leave the area signal it to the rest of
          the team.

          It's helpful in co-op to warn the other players that you are
          moving forward with the mission.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__burger_town__exit_door = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__burger_town__exit_door",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narrative_tsunami_burgertown_door) and list_count( players()) > 1;
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
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object( VOLUMES.tv_narrative_tsunami_burgertown_door, SPARTANS.locke) and IsPlayer(SPARTANS.locke);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Heading out. On me Osiris!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_01600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object( VOLUMES.tv_narrative_tsunami_burgertown_door, SPARTANS.buck) and IsPlayer(SPARTANS.buck);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Heading out. Guardian won't wait.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_00900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object( VOLUMES.tv_narrative_tsunami_burgertown_door, SPARTANS.tanaka) and IsPlayer(SPARTANS.tanaka);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Heading out. No time to lose.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_00800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object( VOLUMES.tv_narrative_tsunami_burgertown_door, SPARTANS.vale) and IsPlayer(SPARTANS.vale);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Heading out. We're losing time.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_00400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	
};



------------------------------------------------------------------------------------------------------

function tsunami_burgertown_turret_destroyed_listener()
local killer:object = nil;

	SleepUntil([| object_valid( "shrike_power_source_1" ) and object_valid( "dm_shriketurret_01" ) ], 60);
	SleepUntil([| device_get_power( OBJECTS.dm_shriketurret_01) == 1 ], 60);

	PrintNarrative("LISTENER - tsunami_burgertown_turret_destroyed_listener");

	RegisterDeathEvent( tsunami_burgertown_turret_destroyed_launcher, OBJECTS.shrike_power_source_1);
	RegisterDeathEvent( tsunami_burgertown_turret_destroyed_launcher, OBJECTS.dm_shriketurret_01);

	SleepUntil([| b_shrike_1 == false ], 60);

	sleep_s(0.2);

	if W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_destroye.localVariables.killer == nil then
	print("LISTENER - tsunami_burgertown_turret_destroyed_listener - No killer register, need to be use plan B to find one: ");

		killer = spartan_look_at_object(players(), OBJECTS.dm_shriketurret_01, 30, 30, 0.1, 2);
		print("LISTENER - tsunami_burgertown_turret_destroyed_listener - picking player looking at turret: ",killer );

		if killer == nil then
			killer = GetClosestMusketeer(OBJECTS.dm_shriketurret_01, 20, 0);
			print("LISTENER - tsunami_burgertown_turret_destroyed_listener - no player was looking, picking closest musketeer: ",killer );

			if killer == nil then
				killer = GetClosestMusketeer(OBJECTS.dm_shriketurret_01, 50, 2);
				print("LISTENER - tsunami_burgertown_turret_destroyed_listener - no musketeer nearby, picking closest player: ",killer );
			end
		end
					
		if object_get_health(OBJECTS.dm_shriketurret_01) <= turret_shrike_death_health then
			tsunami_burgertown_turret_destroyed_launcher(OBJECTS.dm_shriketurret_01, killer)
		end

	end
end

--------------------------
function tsunami_burgertown_turret_destroyed_launcher(turret:object, killer:object)

	PrintNarrative("LAUNCHER - tsunami_burgertown_turret_destroyed_launcher");

	print(killer, " is the killer of ", turret);

	UnregisterDeathEvent(tsunami_burgertown_turret_destroyed_launcher, OBJECTS.shrike_power_source_1);
	UnregisterDeathEvent(tsunami_burgertown_turret_destroyed_launcher, OBJECTS.dm_shriketurret_01);
	
	W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_destroye.localVariables.killer = killer;

	CreateMissionThread(Tsunami__burger_town__covenant_turret);
	
	if turret == OBJECTS.dm_shriketurret_01 then
		W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_destroye.localVariables.turret = true;
	elseif turret == OBJECTS.shrike_power_source_1 then
		W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_destroye.localVariables.powersource = true;
	end

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_destroye");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_destroye);	

end




--[========================================================================[
          Tsunami. burger town. turret 01 destroyed

          The player can destroy the turret in 2 ways. Destroy the
          Turret generator or interact with the screen.								

          First if the player blow up the generator, we can have those
          lines:
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_destroye = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__burger_town__turret_01_destroye",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnInitialize = function(thisConvo, queue)
		PushForwardVOReset();
	end,

	sleepBefore = 2,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.locke 
						and thisConvo.localVariables.powersource;
			end,


			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Turret power core destroyed.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_01200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.buck
						and thisConvo.localVariables.powersource;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Turret power core destroyed.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_00600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.tanaka
						and thisConvo.localVariables.powersource;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Turret power core destroyed.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_00600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.vale
						and thisConvo.localVariables.powersource;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Turret power core destroyed.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_00300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.locke
						and thisConvo.localVariables.turret;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Cannon's offline.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_11000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[6] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.vale
						and thisConvo.localVariables.turret;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Cannon's offline.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_05600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[7] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.tanaka
						and thisConvo.localVariables.turret;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tANAKA
			text = "Cannon's offline.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_06800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[8] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.buck
						and thisConvo.localVariables.turret;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Cannon's offline.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_07900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[9] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 1.7,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Spartan Locke to Swords of Sanghelios. Turret down on my position.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_01300.sound'),

			playDurationAdjustment = 0.9,
		},
		[10] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "FlightLeader",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "Confirmed Spartan. Sending air support.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend01_00400.sound'),			

			--playDurationAdjustment = 0.8,
		},
		[11] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Keep moving. There's plenty more to do.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_09000.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		PrintNarrative("END - "..thisConvo.name);		
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__burger_town__push_forward");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__burger_town__push_forward);
		b_push_forward_vo_timer_default = 60;
		tsunami_chatter_on = true;
	end,

	localVariables = {
						killer = nil,
						powersource = nil,
						turret = nil,
					},
};



function Tsunami__burger_town__covenant_turret()

	PrintNarrative("START - Tsunami__burger_town__covenant_turret");

	sleep_s(3);

	IsThereAnEnemyInRangeLauncher(W2TsunamiTitanAtTsunami_Tsunami__burger_town__covenant_turret, AI.gr_burgertown_all_exterior, ACTOR_TYPE.grunt, "enemy_in_range", w2_tsunami_station.goal_burgertown, 10, true );
	
end


--[========================================================================[
          Tsunami. burger town. covenant
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__burger_town__covenant_turret = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__burger_town__covenant_turret",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {

			text = "No! They destroying our defenses!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt01_00900.sound'),
		},
	},


	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};


------------------------------------------------------------------------------------------------------

function tsunami_burgertown_banshees()

	PrintNarrative("WAKE - tsunami_burgertown_banshees");

	PrintNarrative("START - tsunami_burgertown_banshees");

	composer_play_show ("vin_tsunami_banshee_advance");
	sleep_s(1.1);
	composer_play_show ("vin_tsunami_banshee_advance");		

	--RunClientScript("shrike_explosion", OBJECTS.dm_shriketurret_01);

	--RunClientScript("banshee_explosion_01");

	PrintNarrative("END - tsunami_burgertown_banshees");

end


------------------------------------------------------------------------------------------------------

function tsunami_burgertown_droppods()

PrintNarrative("WAKE - tsunami_burgertown_droppods");
PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__burger_to_tangle_town__droppods");
NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__burger_to_tangle_town__droppods);	

end


--[========================================================================[
          Tsunami. burger to tangle town. droppods

          If the player run through this area, the droppods will land
          really close to him. In that case, a reaction from the
          character feels necessary. Then he can call out the Droppods.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__burger_to_tangle_town__droppods = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__burger_to_tangle_town__droppods",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
		if volume_test_object( VOLUMES.tv_narrative_tsunami_burgertown_droppods, SPARTANS.locke ) then
			thisConvo.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.locke, 10);
		end;
	end,

	sleepBefore = 0.6,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object( VOLUMES.tv_narrative_tsunami_burgertown_droppods, SPARTANS.vale ) or thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: If vale is close to the drop pod when they land
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
				thisConvo.localVariables.s_reactions = thisConvo.localVariables.s_reactions + 1;
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Whoa!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_03300.sound'),

			playDurationAdjustment = 0.3,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				thisConvo.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.vale,10);
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object( VOLUMES.tv_narrative_tsunami_burgertown_droppods, SPARTANS.buck ) or thisConvo.localVariables.s_speaker == SPARTANS.buck;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
				thisConvo.localVariables.s_reactions = thisConvo.localVariables.s_reactions + 1;
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Sonuva!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_04300.sound'),

			playDurationAdjustment = 0.1,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				thisConvo.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.buck,10);				
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_reactions < 2 and (volume_test_object( VOLUMES.tv_narrative_tsunami_burgertown_droppods, SPARTANS.tanaka ) or thisConvo.localVariables.s_speaker == SPARTANS.tanaka);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
				thisConvo.localVariables.s_reactions = thisConvo.localVariables.s_reactions + 1;
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Damn!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_03400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				thisConvo.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.tanaka,10);
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke or volume_test_player_lookat( VOLUMES.tv_narrative_tsunami_burgertown_droppods, unit_get_player(SPARTANS.locke), 10, 50); -- GAMMA_TRANSITION: If locke see the drop pods
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.3,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Covenant insertion pods.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_05100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[5] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck or volume_test_player_lookat( VOLUMES.tv_narrative_tsunami_burgertown_droppods, unit_get_player(SPARTANS.buck), 10, 50); -- GAMMA_TRANSITION: If buck see the drop pods
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Insertion pods here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_04400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,	
		},
		[6] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka or volume_test_player_lookat( VOLUMES.tv_narrative_tsunami_burgertown_droppods, unit_get_player(SPARTANS.tanaka), 10, 50); -- GAMMA_TRANSITION: If tanaka see the drop pods
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Insertion pods.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_03600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[7] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale or volume_test_player_lookat( VOLUMES.tv_narrative_tsunami_burgertown_droppods, unit_get_player(SPARTANS.vale), 10, 50); -- GAMMA_TRANSITION: If vale see the drop pods
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Insertion pods.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_03400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {
					s_speaker = nil,
					s_reactions = 0,
					},
};

------------------------------------------------------------------------------------------------------

--[========================================================================[
          Tsunami. burger town. push forward

--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__burger_town__push_forward = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__burger_town__push_forward",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_timer == 3 and IsGoalActive(w2_tsunami_station.goal_burgertown) and object_get_health(OBJECTS.dm_shriketurret_01) <= 0 and not IsSpartanInCombat() and  volume_test_players( VOLUMES.tv_narrative_burgertown_pushforward ) ; -- GAMMA_CONDITION
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
				return IsGoalActive(w2_tsunami_station.goal_burgertown) and object_get_health(OBJECTS.dm_shriketurret_01) <= 0  and not IsSpartanInCombat() and  volume_test_players( VOLUMES.tv_narrative_burgertown_pushforward ) ; -- GAMMA_TRANSITION: After X time if everybody is dead and turret is destroyed
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Arbiter said far end of the city. Dead ahead through that door there.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_04100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,	
};




------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--	Tangle Town
------------------------------------------------------------------------------------------------------

function tsunami_tangletown_load()

	PrintNarrative("LOAD - tsunami_tangletown_load");

		CreateMissionThread(tsunami_tangletown_look_at);		

		CreateMissionThread(tsunami_tangletown_turret_destroyed_listener);		
				
		CreateMissionThread (tsunami_tangletown_door_open);
		--CreateMissionThread (tsunami_tangletown_snipers);
		CreateMissionThread(tsunami_look_at_turret_power_core);
		
		b_push_forward_vo_timer_default = 30;

		PushForwardVOReset();
end


------------------------------------------------------------------------------------------------------

--[========================================================================[
          Tsunami. tangle town. covenant
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__tangle_town__covenant = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__tangle_town__covenant",

	CanStart = function (thisConvo, queue)
		return objects_distance_to_object( players(), OBJECTS.cr_tangletown_elite ) < 19; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			character = CHARACTER_OBJECTS.cr_tangletown_elite, -- GAMMA_CHARACTER: Elite01
			text = "There they are! Hold the line!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elite01_00800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	
};

------------------------------------------------------------------------------------------------------

function tsunami_tangletown_look_at()

	PrintNarrative("WAKE - tsunami_tangletown_look_at");

	SleepUntil([| object_valid( "dm_shriketurret_02" ) ], 30);

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_Look_at");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_Look_at);	


end


--[========================================================================[
          Tsunami. tangle town. Turret 02 Look at

          When a player sees the second turret.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_Look_at = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_Look_at",

	CanStart = function (thisConvo, queue)
		return object_valid("dm_shriketurret_02") and (volume_test_players_lookat( VOLUMES.tv_narrative_tsunami_tangletown_look_at, 22, 19 ) or volume_test_players( VOLUMES.tv_narrative_tsunami_tangletown_entrance )  ); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();

		if volume_test_players( VOLUMES.tv_narrative_tsunami_tangletown_entrance ) then
			thisConvo.localVariables.s_speaker = AlternateSpeakerWhenEnteringVolume(VOLUMES.tv_narrative_tsunami_tangletown_entrance , 5);
		end

	end,

	lines = {
		
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_player_lookat( VOLUMES.tv_narrative_tsunami_tangletown_look_at, unit_get_player(SPARTANS.buck), 24, 20 ) or thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: If buck sees the second turret
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Eyes on another turret.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_01000.sound'),

		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return  volume_test_player_lookat( VOLUMES.tv_narrative_tsunami_tangletown_look_at, unit_get_player(SPARTANS.vale), 24, 20 )  or thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: If vale sees the second turret
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "I have eyes on another turret.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_00500.sound'),

		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_player_lookat( VOLUMES.tv_narrative_tsunami_tangletown_look_at, unit_get_player(SPARTANS.tanaka), 24, 20 )  or thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: If tanaka sees the second turret
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Another turret there.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_00900.sound'),

		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return  volume_test_player_lookat( VOLUMES.tv_narrative_tsunami_tangletown_look_at, unit_get_player(SPARTANS.locke), 24, 20 ) or thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If locke sees the second turret
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Eyes on another turret.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_01700.sound'),

		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__tangle_town__covenant");
					NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__tangle_town__covenant);
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Take it down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_01800.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
		b_players_saw_tangletown_turret = true;
		hud_hide_radio_transmission_hud();
		PushForwardVOReset();
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__tangle_town__push_forward_1");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__tangle_town__push_forward_1);	
		CreateMissionThread(Tsunami__tangle_town__Turret_02_Look_at_generator);
		CreateThread(title_objective_defense);				
		tsunami_chatter_on = false;
	end,

	localVariables = {
						s_speaker = nil;
						},
};




------------------------------------------------------------------------------------------------------



function Tsunami__tangle_town__Turret_02_Look_at_generator()

	PrintNarrative("START - Tsunami__tangle_town__Turret_02_Look_at_generator");	

	repeat
		
		SleepUntil ([|	object_valid("shrike_power_source_2") and objects_can_see_object( players(), OBJECTS.shrike_power_source_2, 5 ) ], 20);

		W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_Look_at_generator.localVariables.s_speaker = spartan_look_at_object(players(), OBJECTS.shrike_power_source_2, 6, 10, 0.4, 2);			

	until W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_Look_at_generator.localVariables.s_speaker ~= nil or not IsGoalActive(w2_tsunami_station.goal_tangletown)

	if IsGoalActive(w2_tsunami_station.goal_tangletown) and object_valid("dm_shriketurret_02") then

		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_Look_at_generator");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_Look_at_generator);

	end

	PrintNarrative("END - Tsunami__tangle_town__Turret_02_Look_at_generator");

end

--[========================================================================[
          Tsunami. tangle town. Turret 02 Look at power core

          When a player sees the second turret Power Core under the
          bridge
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_Look_at_generator = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_Look_at_generator",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		s_player_looked_at_generator_turret_tangle_town = true;
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke and b_shrike_2; -- GAMMA_TRANSITION: If locke first sees the second turret power core
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				b_tangletown_powercore_lookat = SPARTANS.locke;
				radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Eyes on the Canon's Power Core.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_10600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck and b_shrike_2; -- GAMMA_TRANSITION: Else If buck first sees the second turret power core
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				b_tangletown_powercore_lookat = SPARTANS.buck;
				radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Power source is under the archway.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_07700.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka and b_shrike_2; -- GAMMA_TRANSITION: Else If tanaka first sees the second turret power core
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				b_tangletown_powercore_lookat = SPARTANS.tanaka;
				radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Power source is under the archway.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_06600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale and b_shrike_2; -- GAMMA_TRANSITION: Else If vale first sees the second turret power core
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				b_tangletown_powercore_lookat = SPARTANS.vale;
				radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Power source is under the archway.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_05200.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	localVariables = {
					s_speaker = nil,
					},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


--[========================================================================[
          Tsunami. tangle town. push forward 1
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__tangle_town__push_forward_1 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__tangle_town__push_forward_1",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_counrdown_on >= 15 ; -- GAMMA_CONDITION
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
			If = function (thisLine, thisConvo, queue, lineNumber)
				return IsGoalActive(w2_tsunami_station.goal_tangletown) and v_shrike_tally == 1; -- GAMMA_TRANSITION: after X time if player didn't destroy the turret
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					PushForwardVOReset();
			end,
			
			moniker = "FlightLeader",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "Spartans, drop ships await clear airspace.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend01_00600.sound'),
			
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return IsGoalActive(w2_tsunami_station.goal_tangletown) and v_shrike_tally == 1; -- GAMMA_TRANSITION: after X time if player didn't destroy the turret
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Standby. We're working on it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_06100.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 20,

	OnFinish = function (thisConvo, queue)
		PushForwardVOReset();
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__tangle_town__push_forward_2");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__tangle_town__push_forward_2);	
	end,

	
};



--[========================================================================[
          Tsunami. tangle town. push forward 2
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__tangle_town__push_forward_2 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__tangle_town__push_forward_2",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_counrdown_on >= 5 ; -- GAMMA_CONDITION
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
			If = function (thisLine, thisConvo, queue, lineNumber)
				return IsGoalActive(w2_tsunami_station.goal_tangletown) and v_shrike_tally == 1; -- GAMMA_TRANSITION: after X time if player didn't destroy the turret
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "FlightLeader",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "Spartans, the air defenses at your location are still active.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend01_00700.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return IsGoalActive(w2_tsunami_station.goal_tangletown) and v_shrike_tally == 1; -- GAMMA_TRANSITION: after X time if player didn't destroy the turret
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Not for long. Standby.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_02200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	
};


------------------------------------------------------------------------------------------------------

function tsunami_tangletown_turret_destroyed_listener()
local killer:object = nil;

	SleepUntil([| object_valid( "shrike_power_source_2" ) and object_valid( "dm_shriketurret_02" ) ], 60);
	SleepUntil([| device_get_power( OBJECTS.dm_shriketurret_02) == 1 ], 60);

	PrintNarrative("LISTENER - tsunami_tangletown_turret_destroyed_listener");

	RegisterDeathEvent( tsunami_tangletown_turret_destroyed_launcher, OBJECTS.shrike_power_source_2);
	RegisterDeathEvent( tsunami_tangletown_turret_destroyed_launcher, OBJECTS.dm_shriketurret_02);
	
	SleepUntil([| b_shrike_2 == false ], 60);

	sleep_s(0.2);

	if W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_destroye.localVariables.killer == nil then
	print("LISTENER - tsunami_tangletown_turret_destroyed_listener - No killer register, need to be use plan B to find one: ");

		killer = spartan_look_at_object(players(), OBJECTS.dm_shriketurret_02, 30, 30, 0.1, 2);
		print("LISTENER - tsunami_tangletown_turret_destroyed_listener - picking player looking at turret: ",killer );

		if killer == nil then
			killer = GetClosestMusketeer(OBJECTS.dm_shriketurret_02, 20, 0);
			print("LISTENER - tsunami_tangletown_turret_destroyed_listener - no player was looking, picking closest musketeer: ",killer );

			if killer == nil then
				killer = GetClosestMusketeer(OBJECTS.dm_shriketurret_02, 50, 2);
				print("LISTENER - tsunami_tangletown_turret_destroyed_listener - no musketeer nearby, picking closest player: ",killer );
			end
		end
			
		if object_get_health(OBJECTS.shrike_power_source_2) <= 0 then
			tsunami_tangletown_turret_destroyed_launcher(OBJECTS.shrike_power_source_2, killer)
		elseif object_get_health(OBJECTS.dm_shriketurret_02) <= turret_shrike_death_health then
			tsunami_tangletown_turret_destroyed_launcher(OBJECTS.dm_shriketurret_02, killer)
		end

	end
end


function tsunami_tangletown_turret_destroyed_launcher(turret:object, killer:object)

	PrintNarrative("LAUNCHER - tsunami_tangletown_turret_destroyed_launcher");

	print(killer, " is the killer of ", turret);
	b_PlayerInteractedWithTurret01 = true;

	UnregisterDeathEvent(tsunami_tangletown_turret_destroyed_launcher, OBJECTS.shrike_power_source_2);
	UnregisterDeathEvent(tsunami_tangletown_turret_destroyed_launcher, OBJECTS.dm_shriketurret_02);

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_destroye");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_destroye);	
	W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_destroye.localVariables.killer = killer;
end


--[========================================================================[
          Tsunami. tangle town. Turret 02 destroyed

          When a player destroys the second turret.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_destroye = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_destroye",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		PushForwardVOReset();
	end,

	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,

	lines = {
		
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.buck; -- GAMMA_TRANSITION: If buck destroys the second turret
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Turret down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_01200.sound'),

		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.vale; -- GAMMA_TRANSITION: If vale destroys the second turret
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Turret down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_00600.sound'),

		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.tanaka; -- GAMMA_TRANSITION: If tanaka destroys the second turret
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Turret down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_01000.sound'),

		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.locke; -- GAMMA_TRANSITION: If locke destroys the second turret
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Another turret down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_01900.sound'),

		},
		[5] = {
			Else = true, -- GAMMA_TRANSITION: If tanaka destroys the second turret

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Turret down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_01000.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();		
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_destroye_2");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_destroye_2);
		tsunami_chatter_on = true;
	end,

	OnFinish = function (thisConvo, queue)		
		PrintNarrative("END - "..thisConvo.name);
		b_push_forward_vo_timer_default = 60;
	end,

	localVariables = {
						killer = nil
					},
};



--[========================================================================[
          Tsunami. tangle town. Turret 02 destroyed

          When a player destroys the second turret.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_destroye_2 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_destroye_2",

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
			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Swords of Sanghelios, another turret down on my position.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_02000.sound'),			

			playDurationAdjustment = 0.8,
		},
	},

	OnFinish = function (thisConvo, queue)		
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_destroye_3");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_destroye_3);
	end,
};

--[========================================================================[
          Tsunami. tangle town. Turret 02 destroyed

          When a player destroys the second turret.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_destroye_3 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_destroye_3",

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
			
			moniker = "FlightLeader",

			sleepBefore = 0.8,

			--character = nil, -- GAMMA_CHARACTER: EliteFriend01
			text = "Affirmative, Spartan. Ships inbound.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend01_00500.sound'),

			playDurationAdjustment = 0.8,
		},
	},

	OnFinish = function (thisConvo, queue)		
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_destroye_4");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_destroye_4);
	end,
};



--[========================================================================[
          Tsunami. tangle town. Turret 02 destroyed

          When a player destroys the second turret.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_destroye_4 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_destroye_4",

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
			
			sleepBefore = 0.4,

			moniker = "FlightLeader",
			
			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "All ships, the Spartans have opened more airspace.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend01_02800.sound'),

			--playDurationAdjustment = 0.8,
		},
	},

	OnFinish = function (thisConvo, queue)		
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_destroye_5");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_destroye_5);
	end,
};



--[========================================================================[
          Tsunami. tangle town. Turret 02 destroyed

          When a player destroys the second turret.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_destroye_5 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__tangle_town__Turret_02_destroye_5",

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
			
			moniker = "FlightLeader",

			sleepBefore = 0.2,

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "Move in and make your presence felt!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend01_02900.sound'),

			playDurationAdjustment = 0.7,
		},
	},

	OnFinish = function (thisConvo, queue)		
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		CreateMissionThread(Tsunami__tangle_town__reinforcement);
	end,
};

function Tsunami__tangle_town__reinforcement()

SleepUntil( [| ai_living_count(AI.sq_fork_1.a) > 0], 10 );

--PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__tangle_town__reinforcement");
--NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__tangle_town__reinforcement);

end

--[========================================================================[
          Tsunami. tangle town. reinforcement
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__tangle_town__reinforcement = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__tangle_town__reinforcement",

	CanStart = function (thisConvo, queue)
		return not volume_test_object( VOLUMES.tv_narrative_tangle_spirit_no_zone, ai_get_object(AI.sq_fork_1.a) ) and ai_living_count(AI.sq_tangle_snip_jax_1) == 0 and IsSpartanAbleToSpeak(SPARTANS.tanaka) and object_index_valid(ai_get_object(AI.sq_fork_1.a)) and objects_can_see_object( players(), ai_get_object(AI.sq_fork_1.a), 40 ) and objects_distance_to_object( players(), ai_get_object(AI.sq_fork_1.a) ) < 40; -- GAMMA_CONDITION; -- GAMMA_CONDITION
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 4;
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

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Spirit overhead.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_05600.sound'),

			playDurationAdjustment = 0.6,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,	
};


------------------------------------------------------------------------------------------------------

function tsunami_tangletown_snipers()
local s_speaker:object = nil;

	PrintNarrative("WAKE - tsunami_tangletown_snipers");

	SleepUntil([| ai_living_count(AI.sg_tangle_snip1) ~= 0 ], 60);
	SleepUntil([|	volume_test_object( VOLUMES.tv_narrative_tsunami_tangletown_snipers, ai_get_object(AI.sg_tangle_snip1 )) or
					volume_test_object( VOLUMES.tv_narrative_tsunami_tangletown_snipers, ai_get_object(AI.sg_tangle_snip2 )) or 
					volume_test_object( VOLUMES.tv_narrative_tsunami_tangletown_snipers, ai_get_object(AI.sg_tangle_snip3 )) or
					volume_test_object( VOLUMES.tv_narrative_tsunami_tangletown_snipers, ai_get_object(AI.sg_tangle_snip4 ))
				 ], 60);
	
	PushForwardVOReset();

	sleep_s(1);
	
	s_speaker = GetClosestMusketeer(SPARTANS.locke);

	PrintNarrative("START - tsunami_tangletown_snipers");

	print(s_speaker);

end

------------------------------------------------------------------------------------------------------

function tsunami_tangletown_door_open()

	PrintNarrative("WAKE - tsunami_tangletown_door_open");

	SleepUntil([| ai_living_count(AI.sg_tangle_ground_reinforcements) > 0], 20);

	PushForwardVOReset();

	sleep_s(7);

	local lookattimer:number = 0;
	local s_speaker:object = nil;

	repeat
		lookattimer = lookattimer + 0.5;
		sleep_s(0.5);
		
	until objects_can_see_object( players(), AI.sq_tangle_reinforcements.spawn_points_1, 20 ) or lookattimer >= 7

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__tangle_town__door_open_covies");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__tangle_town__door_open_covies);	
	
				if objects_can_see_object( players(), AI.sq_tangle_reinforcements.spawn_points_1, 20 ) then
					s_speaker = GetClosestMusketeer(OBJECTS.dm_tsu_door_02, 7);
				elseif not objects_can_see_object( players(), AI.sq_tangle_reinforcements.spawn_points_1, 20 ) then
					s_speaker = GetClosestMusketeer(OBJECTS.dm_tsu_door_02);
				end

	W2TsunamiTitanAtTsunami_Tsunami__tangle_town__door_open.localVariables.s_speaker = s_speaker;
	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__tangle_town__door_open");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__tangle_town__door_open);
end




--[========================================================================[
          Tsunami

--[========================================================================[
          Tsunami. tangle town. door open

          After destroying the second turret, the door opens and more
          Covenant enter the space.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__tangle_town__door_open = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__tangle_town__door_open",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {

		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale  or objects_can_see_object( SPARTANS.vale, AI.sq_tangle_reinforcements.spawn_points_1, 20 ) ; -- GAMMA_TRANSITION: If vale player first to look at the door or next available spartan
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Reinforcements at the door!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_00800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck  or objects_can_see_object( SPARTANS.buck, AI.sq_tangle_reinforcements.spawn_points_1, 20 ); -- GAMMA_TRANSITION: If buck player first to look at the door or next available spartan
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Doorway - hostiles incoming!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_01400.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka  or objects_can_see_object( SPARTANS.tanaka, AI.sq_tangle_reinforcements.spawn_points_1, 20 ); -- GAMMA_TRANSITION: If tanaka player first to look at the door or next available spartan
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Covenant at the door!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_01100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke  or objects_can_see_object( SPARTANS.locke, AI.sq_tangle_reinforcements.spawn_points_1, 20 ); -- GAMMA_TRANSITION: If locke player first to look at the door or next available spartan
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Reinforcements at the door!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_02300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
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

--------

--[========================================================================[
          Tsunami. tangle town. door open covies
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__tangle_town__door_open_covies = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__tangle_town__door_open_covies",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_tangle_reinforcements.aisquadspawnpoint78) == 1;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; 
	end,

	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = AI.sq_tangle_reinforcements.aisquadspawnpoint78,
			text = "They're here! Kill them!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elite01_00500.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};




------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--	Turrettown
------------------------------------------------------------------------------------------------------



function tsunami_turrettown_load()

	PrintNarrative("LOAD - tsunami_turrettown_load");

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__3_turrets");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__3_turrets);	
	CreateMissionThread (tsunami_turrettown_turret_03_destroyed_listener);
	CreateMissionThread (tsunami_turrettown_turret_04_destroyed_listener);
	CreateMissionThread (tsunami_turrettown_turret_05_destroyed_listener);

	CreateMissionThread(tsunami_turrettown_top_turret_shield);
	CreateMissionThread(tsunami_look_at_turret_power_core);
	CreateMissionThread(Tsunami__turret_town__guardian_look_at);

	CreateMissionThread(Tsunami__tangle_to_turret_town__staircas);

	CreateMissionThread(turrettown_last_turret_ping_register);	

	CreateMissionThread(silence_chantgrunt_aivo);	

	CreateMissionThread(Tsunami__turret_town__plasma_battery);

	PushForwardVOReset();

end


function turrettown_last_turret_ping_register()

	sleep_s(1);

	RegisterSpartanTrackingPingObjectEvent(turrettown_last_turret_pinged, OBJECTS.dm_shriketurret_04);

end



function turrettown_last_turret_pinged()

	b_turrettown_last_turret_pinged = true;

	sleep_s(30);

	b_turrettown_last_turret_pinged = false;

	CreateMissionThread(turrettown_last_turret_ping_register);
end




function Tsunami__tangle_to_turret_town__staircas()

PrintNarrative("START - Tsunami__tangle_to_turret_town__staircas");

SleepUntil ([| volume_test_players(VOLUMES.tv_narrative_tsunami_tangletown_staircase) ], 10);

		repeat				
				SleepUntil ([| NarrativeQueue.ConversationsPlayingCount() == 0], 10);

				tsunami_is_there_enemy_nearby(11);

		until not tsunami_is_there_enemy_nearby_result

		sleep_s(1.2);

		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__tangle_to_turret_town__staircas");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__tangle_to_turret_town__staircas);	

PrintNarrative("END - Tsunami__tangle_to_turret_town__staircas");

end

--[========================================================================[
          Tsunami. tangle to turret town. staircase

          When the player pass the door and is about to go up the
          stairs, we hear the Guardian whale song.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__tangle_to_turret_town__staircas = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__tangle_to_turret_town__staircas",

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
				return objects_distance_to_object( players(), OBJECTS.cr_turrettown_entrance) > 10;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Think the Constructor found its way through this chaos?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_08400.sound'),

			playDurationAdjustment = 0.95,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return objects_distance_to_object( players(), OBJECTS.cr_turrettown_entrance) > 5;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "If it didn't, somebody better come up with another solution real quick. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_09000.sound'),			
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return objects_distance_to_object( players(), OBJECTS.cr_turrettown_entrance) > 6;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: locke
			text = "Doctor Halsey said the plan would work. I trust her.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_13700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	
};



--[========================================================================[
          Tsunami. turret town. 3 turrets

          After killing some enemies, a player that is in the area will
          mention the 3 turrets, that's the final objective of this
          section.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__3_turrets = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__3_turrets",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.tv_narrative_tsunami_turrettown_guardian_03); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		thisConvo.localVariables.s_speaker = GetClosestMusketeer(OBJECTS.dm_shriketurret_03, 20, 2);
		PushForwardVOReset();
		tsunami_chatter_on = false;
	end,

	lines = {
				[1] = {
					If = function (thisLine, thisConvo, queue, lineNumber)
						return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If locke look at the turret first
					end,

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
					text = "Three turrets here.",
					tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_02700.sound'),

				},
				[2] = {
					ElseIf = function (thisLine, thisConvo, queue, lineNumber)
						return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: If buck look at the turret first
					end,

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
					text = "Three turrets here.",
					tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_01700.sound'),

				},
				[3] = {
					ElseIf = function (thisLine, thisConvo, queue, lineNumber)
						return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: If tanaka look at the turret first
					end,

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
					text = "Three turrets here.",
					tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_01300.sound'),

				},
				[4] = {
					ElseIf = function (thisLine, thisConvo, queue, lineNumber)
						return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: If vale look at the turret first
					end,

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
					text = "Three turrets here.",
					tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_01000.sound'),

				},
				[5] = {

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
					text = "Take them down quick, Osiris. Our ride's going to leave without us.",
					tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_02800.sound'),

				},

			},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		CreateMissionThread(tsunami_turrettown_turret_reminder);
		hud_hide_radio_transmission_hud();
		CreateMissionThread(tv_narrative_tsunami_turrettown_shield_building_1);
		CreateMissionThread(tv_narrative_tsunami_turrettown_shield_building_2);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__shield_is_down");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__shield_is_down);
		CreateMissionThread(Tsunami__turrettown_Covenant_grunt_01);
		PushForwardVOReset();
	end,

	localVariables = {
					s_speaker = nil,
					},

};

------------------------------------------------------------------------------------------------------------------------------------------------------

function tv_narrative_tsunami_turrettown_shield_building_1()

	PrintNarrative("WAKE - tv_narrative_tsunami_turrettown_shield_building_1");

	PrintNarrative("START - tv_narrative_tsunami_turrettown_shield_building_1");

	SleepUntil([| volume_test_players( VOLUMES.tv_narrative_tsunami_turrettown_shield_building_1 ) ], 10);

		b_player_went_past_shield = true;

	PrintNarrative("END - tv_narrative_tsunami_turrettown_shield_building_1");
	
end

---------------------------------------------

function tv_narrative_tsunami_turrettown_shield_building_2()

	PrintNarrative("WAKE - tv_narrative_tsunami_turrettown_shield_building_2");

	PrintNarrative("START - tv_narrative_tsunami_turrettown_shield_building_2");

	SleepUntil([| volume_test_players( VOLUMES.tv_narrative_tsunami_turrettown_shield_building_2 ) ], 10);

		b_player_went_on_second_floor = true;

	PrintNarrative("END - tv_narrative_tsunami_turrettown_shield_building_2");

end


------------------------------------------------------------------------------------------------------------------------------------------------------
function tsunami_turrettown_shield_health()

	local shield_health:number = -1;

	if object_list_children (OBJECTS.cr_cpb, TAG ('levels\assets\osiris\props\generic_covenant\cov_projector_barrier\cov_projector_barrier_shield\cov_projector_barrier_shield.crate')) ~= nil then

		shield_health = object_get_health (object_list_children (OBJECTS.cr_cpb, TAG ('levels\assets\osiris\props\generic_covenant\cov_projector_barrier\cov_projector_barrier_shield\cov_projector_barrier_shield.crate'))[1]);
		--print("Shield's Health: ", shield_health);

	end

	return shield_health
end



------------------------------------------------------------------------------------------------------


function tsunami_turrettown_turret_03_destroyed_listener()
local killer:object = nil;

	SleepUntil([| object_valid( "shrike_power_source_3" ) and object_valid( "dm_shriketurret_03" ) ], 60);
	SleepUntil([| device_get_power( OBJECTS.dm_shriketurret_03) == 1 ], 60);

	PrintNarrative("LISTENER - tsunami_turrettown_turret_03_destroyed_listener");
	
	RegisterDeathEvent(tsunami_turrettown_turret_03_destroyed_launcher, OBJECTS.shrike_power_source_3);
	RegisterDeathEvent(tsunami_turrettown_turret_03_destroyed_launcher, OBJECTS.dm_shriketurret_03);
	
	SleepUntil([| b_shrike_3 == false ], 60);

	sleep_s(0.4);

	if not b_turret_03_killer then
	print("LISTENER - tsunami_turrettown_turret_03_destroyed_listener - No killer register, need to be use plan B to find one: ");

		killer = spartan_look_at_object(players(), OBJECTS.dm_shriketurret_03, 30, 30, 0.1, 2);
		print("LISTENER - tsunami_turrettown_turret_03_destroyed_listener - picking player looking at turret: ",killer );

		if killer == nil then
			killer = GetClosestMusketeer(OBJECTS.dm_shriketurret_03, 20, 0);
			print("LISTENER - tsunami_turrettown_turret_03_destroyed_listener - no player was looking, picking closest musketeer: ",killer );

			if killer == nil then
				killer = GetClosestMusketeer(OBJECTS.dm_shriketurret_03, 50, 2);
				print("LISTENER - tsunami_turrettown_turret_03_destroyed_listener - no musketeer nearby, picking closest player: ",killer );
			end
		end
			
		if object_get_health(OBJECTS.shrike_power_source_3) <= 0 then
			tsunami_turrettown_turret_03_destroyed_launcher(OBJECTS.shrike_power_source_3, killer)
		elseif object_get_health(OBJECTS.dm_shriketurret_03) <= turret_shrike_death_health then
			tsunami_turrettown_turret_03_destroyed_launcher(OBJECTS.dm_shriketurret_03, killer)
		end

	end
end

function tsunami_turrettown_turret_03_destroyed_launcher(turret:object, killer:object)

	PrintNarrative("LAUNCHER - tsunami_turrettown_turret_03_destroyed_launcher");

	if not b_turret_03_killer then
		b_turret_03_killer = true;

		print(killer, " is the killer of ", turret);

		UnregisterDeathEvent(tsunami_turrettown_turret_03_destroyed_launcher, OBJECTS.shrike_power_source_3);
		UnregisterDeathEvent(tsunami_turrettown_turret_03_destroyed_launcher, OBJECTS.dm_shriketurret_03);

		CreateMissionThread(tsunami_turrettown_3_turrets_down, killer);
	end
end

------------------------------

function tsunami_turrettown_turret_04_destroyed_listener()
local killer:object = nil;

	SleepUntil([| object_valid( "shrike_power_source_4" ) and object_valid( "dm_shriketurret_04" ) ], 60);
	SleepUntil([| device_get_power( OBJECTS.dm_shriketurret_04) == 1 ], 60);

	PrintNarrative("LISTENER - tsunami_turrettown_turret_04_destroyed_listener");

	RegisterDeathEvent( tsunami_turrettown_turret_04_destroyed_launcher, OBJECTS.shrike_power_source_4);
	RegisterDeathEvent( tsunami_turrettown_turret_04_destroyed_launcher, OBJECTS.dm_shriketurret_04);

	SleepUntil([| b_shrike_4 == false ], 60);

	sleep_s(0.4);

	if not b_turret_04_killer then
	print("LISTENER - tsunami_turrettown_turret_04_destroyed_listener - No killer register, need to be use plan B to find one: ");

		killer = spartan_look_at_object(players(), OBJECTS.dm_shriketurret_04, 30, 30, 0.1, 2);
		print("LISTENER - tsunami_turrettown_turret_04_destroyed_listener - picking player looking at turret: ",killer );

		if killer == nil then
			killer = GetClosestMusketeer(OBJECTS.dm_shriketurret_04, 20, 0);
			print("LISTENER - tsunami_turrettown_turret_04_destroyed_listener - no player was looking, picking closest musketeer: ",killer );

			if killer == nil then
				killer = GetClosestMusketeer(OBJECTS.dm_shriketurret_04, 50, 2);
				print("LISTENER - tsunami_turrettown_turret_04_destroyed_listener - no musketeer nearby, picking closest player: ",killer );
			end
		end
			
		if object_get_health(OBJECTS.shrike_power_source_4) <= 0 then
			tsunami_turrettown_turret_04_destroyed_launcher(OBJECTS.shrike_power_source_4, killer)
		elseif object_get_health(OBJECTS.dm_shriketurret_04) <= turret_shrike_death_health then
			tsunami_turrettown_turret_04_destroyed_launcher(OBJECTS.dm_shriketurret_04, killer)
		end

	end
end


function tsunami_turrettown_turret_04_destroyed_launcher(turret:object, killer:object)

	PrintNarrative("LAUNCHER - tsunami_turrettown_turret_04_destroyed_launcher");

	if not b_turret_04_killer then
		b_turret_04_killer = true;

		print(killer, " is the killer of ", turret);

		UnregisterDeathEvent(tsunami_turrettown_turret_04_destroyed_launcher, OBJECTS.shrike_power_source_4);
		UnregisterDeathEvent(tsunami_turrettown_turret_04_destroyed_launcher, OBJECTS.dm_shriketurret_04);

		CreateMissionThread(tsunami_turrettown_3_turrets_down, killer);
	end
end

------------------------------

function tsunami_turrettown_turret_05_destroyed_listener()
local killer:object = nil;

	SleepUntil([| object_valid( "shrike_power_source_5" ) and object_valid( "dm_shriketurret_05" ) ], 60);
	SleepUntil([| device_get_power( OBJECTS.dm_shriketurret_05) == 1 ], 60);

	PrintNarrative("LISTENER - tsunami_turrettown_turret_05_destroyed_listener");

	RegisterDeathEvent( tsunami_turrettown_turret_05_destroyed_launcher, OBJECTS.shrike_power_source_5);
	RegisterDeathEvent( tsunami_turrettown_turret_05_destroyed_launcher, OBJECTS.dm_shriketurret_05);

	SleepUntil([| b_shrike_5 == false ], 60);

	sleep_s(0.4);

	if not b_turret_05_killer then
	print("LISTENER - tsunami_turrettown_turret_05_destroyed_listener - No killer register, need to be use plan B to find one: ");

		killer = spartan_look_at_object(players(), OBJECTS.dm_shriketurret_05, 30, 30, 0.1, 2);
		print("LISTENER - tsunami_turrettown_turret_05_destroyed_listener - picking player looking at turret: ",killer );

		if killer == nil then
			killer = GetClosestMusketeer(OBJECTS.dm_shriketurret_05, 20, 0);
			print("LISTENER - tsunami_turrettown_turret_05_destroyed_listener - no player was looking, picking closest musketeer: ",killer );

			if killer == nil then
				killer = GetClosestMusketeer(OBJECTS.dm_shriketurret_05, 50, 2);
				print("LISTENER - tsunami_turrettown_turret_05_destroyed_listener - no musketeer nearby, picking closest player: ",killer );
			end
		end
			
		if object_get_health(OBJECTS.shrike_power_source_5) <= 0 then
			tsunami_turrettown_turret_05_destroyed_launcher(OBJECTS.shrike_power_source_5, killer)
		elseif object_get_health(OBJECTS.dm_shriketurret_05) <= turret_shrike_death_health then
			tsunami_turrettown_turret_05_destroyed_launcher(OBJECTS.dm_shriketurret_05, killer)
		end

	end
end

function tsunami_turrettown_turret_05_destroyed_launcher(turret:object, killer:object)

	PrintNarrative("LAUNCHER - tsunami_turrettown_turret_05_destroyed_launcher");

	if not b_turret_05_killer then
		b_turret_05_killer = true;

		print(killer, " is the killer of ", turret);

		UnregisterDeathEvent(tsunami_turrettown_turret_05_destroyed_launcher, OBJECTS.shrike_power_source_5);
		UnregisterDeathEvent(tsunami_turrettown_turret_05_destroyed_launcher, OBJECTS.dm_shriketurret_05);

		CreateMissionThread(tsunami_turrettown_3_turrets_down, killer);
	end
end

------------------------------

function tsunami_turrettown_3_turrets_down(killer:object)

	PrintNarrative("WAKE - tsunami_turrettown_3_turrets_down");
		
	PrintNarrative("START - tsunami_turrettown_3_turrets_down");

	sleep_s(0.2);
			
			if v_shrike_tally == 3 then
						
						PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__3_turrets_01");

						W2TsunamiTitanAtTsunami_Tsunami__turret_town__3_turrets_01.localVariables.s_speaker = killer;						
						NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__3_turrets_01);
						
					
			elseif v_shrike_tally == 4 then
				
						NarrativeQueue.InterruptConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__3_turrets_01);

						PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__3_turrets_02");

						W2TsunamiTitanAtTsunami_Tsunami__turret_town__3_turrets_02.localVariables.s_speaker = killer;
						NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__3_turrets_02);	

							
			elseif v_shrike_tally == 5 and not NarrativeQueue.HasConversationFinished(W2TsunamiTitanAtTsunami_Tsunami__turret_town__3_turrets_03) then

						NarrativeQueue.InterruptConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__3_turrets_02);

						PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__3_turrets_03");

						W2TsunamiTitanAtTsunami_Tsunami__turret_town__3_turrets_03.localVariables.s_speaker = killer;
						NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__3_turrets_03);
						
			end

	PrintNarrative("END - tsunami_turrettown_3_turrets_down");

end


--[========================================================================[
          Tsunami. turret town. 3 turrets down

          When one turret is down.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__3_turrets_01 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__3_turrets_01",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
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
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If locke destroys the first turret
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "One turret down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_02900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 7;
			end,

		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: If buck destroys the first turret
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "One turret down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_01800.sound'),

		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: If tanaka destroys the first turret
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "One turret down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_01400.sound'),
			
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: If vale destroys the first turret
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "One turret down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_01100.sound'),			

		},
		[5] = {
			Else = true, -- GAMMA_TRANSITION: If vale destroys the first turret

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "One turret down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_01800.sound'),

		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Good!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_03000.sound'),

		},
		[7] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Two more to go!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_08200.sound'),

		},

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {
						s_speaker = nil
						},
};




--[========================================================================[
          Tsunami. turret town. 3 turrets down

          When one turret is down.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__3_turrets_02 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__3_turrets_02",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If locke destroys the first turret
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Second turret down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_03100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 6;
			end,

			sleepAfter = 0.3,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: If buck destroys the first turret
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Second turret down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_01900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 6;
			end,

			sleepAfter = 0.3,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: If tanaka destroys the first turret
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Second turret down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_01500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 6;
			end,

			sleepAfter = 0.3,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: If vale destroys the first turret
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Second turret down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_01200.sound'),
			
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 6;
			end,

			sleepAfter = 0.3,
		},
		[5] = {
			Else = true, -- GAMMA_TRANSITION: If vale destroys the first turret

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Second turret down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_01200.sound'),

			sleepAfter = 0.3,
		},		
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Only one left!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_03200.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(tsunami_turrettown_top_turret);
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {
						s_speaker = nil
						},
};



--[========================================================================[
          Tsunami. turret town. 3 turrets down

          When one turret is down.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__3_turrets_03 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__3_turrets_03",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If locke destroys the first turret
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Last turret destroyed!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_03300.sound'),

		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: If buck destroys the first turret
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Last turret destroyed!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_02000.sound'),

		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: If tanaka destroys the first turret
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Last turret destroyed!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_01600.sound'),

		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: If vale destroys the first turret
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Last turret destroyed!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_01300.sound'),

		},
		[5] = {
			Else = true;

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Last turret destroyed!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_01600.sound'),

		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Good work, Spartans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_03400.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__all_turrets_destro");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__all_turrets_destro);		

	end,

	localVariables = {
						s_speaker = nil
						},
};



------------------------------------------------------------------------------------------------------

function tsunami_turrettown_turret_reminder()

	sleep_s(60);
	
	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__turret_reminder");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__turret_reminder);																

	sleep_s(60);
	
	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__turret_reminder_2");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__turret_reminder_2);			

	PrintNarrative("END - tsunami_turrettown_turret_reminder");	
	
end




--[========================================================================[
          Tsunami. turret town. turret reminder
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__turret_reminder = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__turret_reminder",

	CanStart = function (thisConvo, queue)
		return NarrativeQueue.ConversationsPlayingCount() == 0 and v_shrike_tally ~= 5; -- GAMMA_CONDITION

		--	CAN'T USE PUSHFORWARD TIMER HERE IF WE WANT TO PLAY IT WHEN ENEMIES ARE STILL THERE.
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
				return v_shrike_tally ~= 5;
			end,

			sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Take the cannons offline. Find their power source or target the cannons themselves.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_10400.sound'),

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
          Tsunami. turret town. turret reminder
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__turret_reminder_2 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__turret_reminder_2",

	CanStart = function (thisConvo, queue)
		return NarrativeQueue.ConversationsPlayingCount() == 0 and v_shrike_tally ~= 5 and b_push_forward_vo_timer > 10; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		PushForwardVOReset();
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return v_shrike_tally ~= 5;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "FlightLeader",
			
			sleepBefore = 1,

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "Spartans, what is your status clearing the turrets?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend01_00800.sound'),

		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return v_shrike_tally ~= 5;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Standby. We're on it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_09100.sound'),		
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	
};



------------------------------------------------------------------------------------------------------------------------------------------------------

function tsunami_turrettown_top_turret()

	PrintNarrative("WAKE - tsunami_turrettown_top_turret");
	
	sleep_s(20);

	if object_get_health(OBJECTS.dm_shriketurret_04) > 0.2 and b_shrike_4 then
		
				PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__HOW_DO_WE_GET_BEHI");
				NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__HOW_DO_WE_GET_BEHI);	
	end
				
	sleep_s(20);
						
	PushForwardVOReset();

	SleepUntil([| 	b_turrettown_got_to_jump ], 60);

	local s_timer:number = 0;

	repeat

		s_timer = s_timer + 1;
		sleep_s(1);

	until (s_timer >= 30 or volume_test_players_lookat( VOLUMES.tv_narrative_tsunami_turrettown_top_turret_lookat, 17, 20 ))

	SleepUntil([| 	IsSpartanAbleToSpeak(SPARTANS.locke) and IsSpartanAbleToSpeak(SPARTANS.tanaka) ], 10);

	if object_get_health(OBJECTS.dm_shriketurret_04) > 0.2 and b_shrike_4 and not volume_test_players( VOLUMES.tv_narrative_tsunami_turrettown_top_turret_lookat ) and not volume_test_players( VOLUMES.tv_narrative_tsunami_turrettown_shield_building_2 ) and not volume_test_players( VOLUMES.tv_narrative_tsunami_turrettown_shield_building_1 ) then
				
				PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__HOW_DO_WE_GET_BEHI_2");
				NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__HOW_DO_WE_GET_BEHI_2);	
	end
		


	PrintNarrative("END - tsunami_turrettown_top_turret");

end



--[========================================================================[
          Tsunami. turret town. HOW DO WE GET BEHIND THE SHIELD? WTF?

          When a player can't sort how to get into the shielded room,
          we can play these hints.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__HOW_DO_WE_GET_BEHI = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__HOW_DO_WE_GET_BEHI",

	CanStart = function (thisConvo, queue)
		return IsSpartanAbleToSpeak(SPARTANS.buck) and IsSpartanAbleToSpeak(SPARTANS.tanaka); -- GAMMA_CONDITION
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
			If = function (thisLine, thisConvo, queue, lineNumber)
				return object_get_health(OBJECTS.dm_shriketurret_04) > 0.2 and b_shrike_4 and not NarrativeQueue.HasConversationFinished(W2TsunamiTitanAtTsunami_Tsunami__turret_town__top_turret_shield_b); -- GAMMA_TRANSITION: When player destroyed 2 turret and only one left is the one up in the building, when player look at it
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Where's the power source for this last cannon?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_00100.sound'),
		},	
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__HOW_DO_WE_GET_BEHI_pinged");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__HOW_DO_WE_GET_BEHI_pinged);	
	end,

	
};


--[========================================================================[
          Tsunami. turret town. HOW DO WE GET BEHIND THE SHIELD? WTF?

          When a player can't sort how to get into the shielded room,
          we can play these hints.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__HOW_DO_WE_GET_BEHI_pinged = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__HOW_DO_WE_GET_BEHI_pinged",

	CanStart = function (thisConvo, queue)
		return b_turrettown_last_turret_pinged and IsSpartanAbleToSpeak(SPARTANS.tanaka); -- GAMMA_CONDITION
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
			If = function (thisLine, thisConvo, queue, lineNumber)
				return object_get_health(OBJECTS.dm_shriketurret_04) > 0.2 and b_shrike_4; -- GAMMA_TRANSITION: When player destroyed 2 turret and only one left is the one up in the building, when player look at it
			end,

			sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "That building. Top floor.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_00300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	
};


--[========================================================================[
          Tsunami. turret town. HOW DO WE GET BEHIND THE SHIELD? WTF?

          When a player can't sort how to get into the shielded room,
          we can play these hints.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__HOW_DO_WE_GET_BEHI_2 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__HOW_DO_WE_GET_BEHI_2",

	CanStart = function (thisConvo, queue)
		return IsSpartanAbleToSpeak(SPARTANS.tanaka); -- GAMMA_CONDITION
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
			If = function (thisLine, thisConvo, queue, lineNumber)
				return object_get_health(OBJECTS.dm_shriketurret_04) > 0.2 and b_shrike_4 and not b_player_went_past_shield and not b_player_went_on_second_floor; -- GAMMA_TRANSITION: After X time if player still didn't destroy the turret
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Got an idea. Second floor, jump across.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_05300.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,	
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Good suggestion, Tanaka.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_08600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,	
};



------------------------------------------------------------------------------------------------------------------------------------------------------

function tsunami_turrettown_top_turret_shield()

	PrintNarrative("WAKE - tsunami_turrettown_top_turret_shield");

	SleepUntil([| object_valid( "cr_cpb" ) and tsunami_turrettown_shield_health() > 0 and (volume_test_players_lookat( VOLUMES.tv_narrative_tsunami_turrettown_shield_building_1, 5, 20 ) or spartan_look_at_object_no_delay(players(), OBJECTS.cr_cpb, 15, 20, 0, 0))	], 10);
	
	PrintNarrative("START - tsunami_turrettown_top_turret_shield");

	if v_shrike_tally >= 2 or v_shrike_tally < 5 and object_get_health(OBJECTS.dm_shriketurret_04) > 0.2 and b_shrike_4 and tsunami_turrettown_shield_health() > 0 and not volume_test_players( VOLUMES.tv_narrative_tsunami_turrettown_shield_building_1 ) then

				PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__top_turret_shield");
				NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__top_turret_shield);	

				SleepUntil([| NarrativeQueue.HasConversationFinished(W2TsunamiTitanAtTsunami_Tsunami__turret_town__top_turret_shield)], 100);
	end

	sleep_s(1);

	if object_get_health(OBJECTS.dm_shriketurret_04) > 0.2 and b_shrike_4 and tsunami_turrettown_shield_health() > 0 and not volume_test_players( VOLUMES.tv_narrative_tsunami_turrettown_shield_building_1 ) then			

				PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__top_turret_shield_b");
				NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__top_turret_shield_b);

				SleepUntil([| NarrativeQueue.HasConversationFinished(W2TsunamiTitanAtTsunami_Tsunami__turret_town__top_turret_shield_b)], 100);

	end

	sleep_s(60);

	if b_shrike_4 and tsunami_turrettown_shield_health() > 0 and not volume_test_players( VOLUMES.tv_narrative_tsunami_turrettown_shield_building_1 ) then			

				PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__top_turret_shield_2");
				NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__top_turret_shield_2);	

	end
		
	PrintNarrative("END - tsunami_turrettown_top_turret_shield");

end


--[========================================================================[
          Tsunami. turret town. HOW DO WE GET BEHIND THE SHIELD? WTF?

          When a player can't sort how to get into the shielded room,
          we can play these hints.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__top_turret_shield = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__top_turret_shield",

	CanStart = function (thisConvo, queue)
		return  v_shrike_tally >= 2 and v_shrike_tally < 5 and tsunami_turrettown_shield_health() > 0 and not volume_test_players( VOLUMES.tv_narrative_tsunami_turrettown_shield_building_1 ) and not b_player_went_past_shield and not b_player_went_on_second_floor
		 and ((IsPlayer(SPARTANS.vale) and IsSpartanAbleToSpeak(SPARTANS.vale) and object_at_distance_and_can_see_object(SPARTANS.vale, OBJECTS.cr_cpb, 12, 40))
				or (IsPlayer(SPARTANS.tanaka) and IsSpartanAbleToSpeak(SPARTANS.tanaka) and object_at_distance_and_can_see_object(SPARTANS.tanaka, OBJECTS.cr_cpb, 12, 40))
				or (IsPlayer(SPARTANS.buck) and IsSpartanAbleToSpeak(SPARTANS.buck) and object_at_distance_and_can_see_object(SPARTANS.buck, OBJECTS.cr_cpb, 12, 40))
				or (IsPlayer(SPARTANS.locke) and IsSpartanAbleToSpeak(SPARTANS.locke) and object_at_distance_and_can_see_object(SPARTANS.locke, OBJECTS.cr_cpb, 12, 40))
				or spartan_look_at_object_no_delay(players(), OBJECTS.cr_cpb, 15, 20, 0, 0)
				);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; 
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
		if (IsPlayer(SPARTANS.locke) and IsSpartanAbleToSpeak(SPARTANS.locke) and object_at_distance_and_can_see_object(SPARTANS.locke, OBJECTS.cr_cpb, 12, 40)) then
			thisConvo.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.locke, 20, 0);
		end
	end,	

	lines = {	
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not NarrativeQueue.HasConversationFinished(W2TsunamiTitanAtTsunami_Tsunami__turret_town__plasma_battery)
						and ((IsPlayer(SPARTANS.vale) and not IsUnitDowned( SPARTANS.vale ) and IsSpartanAbleToSpeak(SPARTANS.vale) and object_at_distance_and_can_see_object(SPARTANS.vale, OBJECTS.cr_cpb, 12, 40)) 
							or thisConvo.localVariables.s_speaker == SPARTANS.vale or thisConvo.localVariables.s_speaker == SPARTANS.locke);
			end,

			sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Entrance of the building is shielded.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_00700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return not NarrativeQueue.HasConversationFinished(W2TsunamiTitanAtTsunami_Tsunami__turret_town__plasma_battery) 
						and ((IsPlayer(SPARTANS.tanaka) and not IsUnitDowned( SPARTANS.tanaka ) and IsSpartanAbleToSpeak(SPARTANS.tanaka) and object_at_distance_and_can_see_object(SPARTANS.tanaka, OBJECTS.cr_cpb, 12, 40))
								or thisConvo.localVariables.s_speaker == SPARTANS.tanaka);
			end,

			sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Building's shielded!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_08600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return not NarrativeQueue.HasConversationFinished(W2TsunamiTitanAtTsunami_Tsunami__turret_town__plasma_battery) 
						and (IsPlayer(SPARTANS.buck) and not IsUnitDowned( SPARTANS.buck ) and IsSpartanAbleToSpeak(SPARTANS.buck) and object_at_distance_and_can_see_object(SPARTANS.buck, OBJECTS.cr_cpb, 12, 40)
							or thisConvo.localVariables.s_speaker == SPARTANS.buck);
			end,

			sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Shield! Can't get in!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_09100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	localVariables = {
						s_speaker = nil,
					},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();		
	end,
};

function Tsunami__turret_town__plasma_battery()

	PrintNarrative("START - Tsunami__turret_town__plasma_battery");	

	repeat
		
		sleep_s(0.3);

		SleepUntil ([|	object_valid("dc_turr_shield_shutdown") and (object_at_distance_and_can_see_object(players(), OBJECTS.dc_turr_shield_shutdown, 6, 20) or object_at_distance_and_can_see_object(players(), OBJECTS.dc_turr_shield_shutdown, 2, 60))], 2);	

		W2TsunamiTitanAtTsunami_Tsunami__turret_town__plasma_battery.localVariables.s_speaker = spartan_look_at_object(players(), OBJECTS.dc_turr_shield_shutdown, 6, 70, 0.3, 2);

	until W2TsunamiTitanAtTsunami_Tsunami__turret_town__plasma_battery.localVariables.s_speaker ~= nil or not IsGoalActive(w2_tsunami_station.goal_turrettown)

	if IsGoalActive(w2_tsunami_station.goal_turrettown) and object_valid("dc_turr_shield_shutdown") then

		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__plasma_battery");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__plasma_battery);

	end

	PrintNarrative("END - Tsunami__turret_town__plasma_battery");

end



--[========================================================================[
          Tsunami. turret town. plasma battery
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__plasma_battery = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__plasma_battery",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke;
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Plasma battery here!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_12600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 2; -- GAMMA_NEXT_LINE_NUMBER
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
		},
		[2] = {			
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "That should take the shield down! Let's hack it!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_06500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck;
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Plasma battery here!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_08400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka;
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Plasma battery here!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_07900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale;
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Plasma battery here!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_06600.sound'),
		},
		[6] = {
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "That will take care of the shield. Hack it!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_12700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
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
          Tsunami. turret town. shield is down
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__shield_is_down = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__shield_is_down",

	CanStart = function (thisConvo, queue)
		return tsunami_turrettown_shield_health() <= 0 or not IsGoalActive(w2_tsunami_station.goal_turrettown); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 0.5,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
		if not volume_test_players_lookat(VOLUMES.tv_narrative_tsunami_turrettown_shield_building_1, 10, 40 ) then
			thisConvo.localVariables.s_speaker = spartan_look_at_object_no_delay(players(), OBJECTS.cr_cpb, 15, 20, 0, 0) or GetClosestMusketeer(OBJECTS.cr_cpb, 30, 0);			
		end
	end,	

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return IsGoalActive(w2_tsunami_station.goal_turrettown) and b_shrike_4 and ( thisConvo.localVariables.s_speaker == SPARTANS.locke or volume_test_player_lookat(VOLUMES.tv_narrative_tsunami_turrettown_shield_building_1, unit_get_player(SPARTANS.locke), 10, 40 ));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Shield's down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_12800.sound'),

			sleepAfter = 0.7,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return IsGoalActive(w2_tsunami_station.goal_turrettown) and b_shrike_4 and (thisConvo.localVariables.s_speaker == SPARTANS.buck or volume_test_player_lookat(VOLUMES.tv_narrative_tsunami_turrettown_shield_building_1, unit_get_player(SPARTANS.buck), 10, 40 ));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Shield's down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_08500.sound'),

			sleepAfter = 0.7,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return IsGoalActive(w2_tsunami_station.goal_turrettown) and b_shrike_4 and ( thisConvo.localVariables.s_speaker == SPARTANS.tanaka or volume_test_player_lookat(VOLUMES.tv_narrative_tsunami_turrettown_shield_building_1, unit_get_player(SPARTANS.tanaka), 10, 40 ));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Shield's down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_08000.sound'),

			sleepAfter = 0.7,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return IsGoalActive(w2_tsunami_station.goal_turrettown) and b_shrike_4 and ( thisConvo.localVariables.s_speaker == SPARTANS.vale or volume_test_player_lookat(VOLUMES.tv_narrative_tsunami_turrettown_shield_building_1, unit_get_player(SPARTANS.vale), 10, 40 ));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Shield's down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_06700.sound'),

			sleepAfter = 0.7,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return IsGoalActive(w2_tsunami_station.goal_turrettown) and v_shrike_tally == 4 and b_shrike_4; -- GAMMA_TRANSITION: If Canon is still firing
			end,			

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Take that last cannon down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_12900.sound'),
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
          Tsunami. turret town. HOW DO WE GET BEHIND THE SHIELD? WTF?

          When a player can't sort how to get into the shielded room,
          we can play these hints.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__top_turret_shield_b = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__top_turret_shield_b",

	CanStart = function (thisConvo, queue)
		return v_shrike_tally == 4 and volume_test_players_lookat( VOLUMES.tv_narrative_tsunami_turrettown_shield_building_1, 7, 20 ) and b_shrike_4 and tsunami_turrettown_shield_health() > 0 and not volume_test_players( VOLUMES.tv_narrative_tsunami_turrettown_shield_building_1 ) and not b_player_went_past_shield and not b_player_went_on_second_floor and objects_distance_to_object( SPARTANS.vale, OBJECTS.cr_cpb ) < 30 and IsSpartanAbleToSpeak(SPARTANS.vale);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; 
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {	
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return b_shrike_4;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VaLE
			text = "Last power source is behind that shield. How do we get in there?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_04400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_turrettown_got_to_jump = true;
	end,
};




--[========================================================================[
          Tsunami. turret town. HOW DO WE GET BEHIND THE SHIELD? WTF?

          When a player can't sort how to get into the shielded room,
          we can play these hints.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__top_turret_shield_2 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__top_turret_shield_2",

	CanStart = function (thisConvo, queue)
		return not IsGoalActive(w2_tsunami_station.goal_turrettown) or (v_shrike_tally == 4 and b_shrike_4 and not b_player_went_past_shield and not b_player_went_on_second_floor and tsunami_turrettown_shield_health() > 0
																	 and (
																			(IsPlayer(SPARTANS.buck) and volume_test_player_lookat( VOLUMES.tv_narrative_tsunami_turrettown_shield_building_1, unit_get_player(SPARTANS.buck), 5, 10 )) or (not IsPlayer(SPARTANS.buck) and volume_test_players_lookat( VOLUMES.tv_narrative_tsunami_turrettown_shield_building_1, 5, 10 )  ) 
																		));
		end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; 
	end,

	OnInitialize = function(thisConvo, queue)
		PushForwardVOReset();
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(w2_tsunami_station.goal_turrettown) ;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BuCK
			text = "Can't for the life of me figure a way behind that shield.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_06600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},	
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	
};

------------------------------------------------------------------------------------------------------

																				function tsunami_turrettown_all_turrets_destroyed()
																				--[[
																					PrintNarrative("WAKE - tsunami_turrettown_all_turrets_destroyed");
	
																					--PushForwardVOStandBy();
	
																					sleep_s(0.2);
	
																					PrintNarrative("START - tsunami_turrettown_all_turrets_destroyed");
					
																								local l_dialog_id:thread=def_dialog_id_none();
																								l_dialog_id = dialog_start_foreground("tsunami_turrettown_all_turrets_destroyed", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					
																									dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_arbiter_01600.sound'), false, nil, 0.0, "", "Arbiter : Arbiter to Osiris. The Guardian moves.", true );
																									dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_07600.sound'), false, nil, 0.0, "", "Locke : Yes, sir. We'd noticed that.", true );
																									dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_arbiter_01800.sound'), false, nil, 0.0, "", "Arbiter : You have done much for my cause. Now finish your own work and move on the Guardian.", true );
																									dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_arbiter_01100.sound'), false, nil, 0.0, "", "Arbiter : My people will take over at your position.", true );
																									dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_08700.sound'), false, nil, 0.0, "", "Locke : Copy that, sir.", true );
										
																									if ai_living_count (AI.gr_turret_all) > 9 then
																										dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_00700.sound'), false, nil, 0.0, "", "Locke : Osiris, secure this area so the Arbiter's people can land.", true );

																										--	OBJECTIVE TEXT
																										CreateMissionThread(title_objective_clear);

																									end

																								l_dialog_id = dialog_end(l_dialog_id, true, true, "");

	
																					PrintNarrative("END - tsunami_turrettown_all_turrets_destroyed");

																					CreateMissionThread(tsunami_turrettown_friendlies_are_back);
																					CreateMissionThread(tsunami_turrettown_clear_area_nag);
																					]]
																				end





function silence_chantgrunt_aivo()

	PrintNarrative("START - silence_chantgrunt_aivo");

	SleepUntil ([|	ai_living_count (AI.sq_turret_chantgrunts) > 0], 10);
	PrintNarrative("START - silence_chantgrunt_aivo - disable AIVO");

	AIDialogManager.DisableAIDialog(AI.sq_turret_chantgrunts);	

	SleepUntil ([|	b_chantbreak], 1);

	PrintNarrative("START - silence_chantgrunt_aivo - Enable AIVO");
	AIDialogManager.EnableAIDialog(AI.sq_turret_chantgrunts);

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__building__covies_in_building");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__building__covies_in_building);

end


--[========================================================================[
          Tsunami. building. covies in building

          As we enter the building, we hear Prometheans presence and
          see the aftermath of a fight against grunts.

          We hear more fighting on the other sides of the walls
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__building__covies_in_building = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__building__covies_in_building",

	CanStart = function (thisConvo, queue)
		return b_chantbreak; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,

	lines = {
		[1] = {
			character = AI.sq_turret_chantgrunts.a5, -- GAMMA_CHARACTER: Grunt02
			text = "AAAAaaaahhh!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt02_02200.sound'),

			playDurationAdjustment = 0.5,
		},
		[2] = {
			character = AI.sq_turret_chantgrunts.a3, -- GAMMA_CHARACTER: Grunt01
			text = "They're humans!!!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt01_00800.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};

--[========================================================================[
          Tsunami. turret town. all turrets destroyed

          Whether there are still enemies or not, this will play.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__all_turrets_destro = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__all_turrets_destro",

	CanStart = function (thisConvo, queue)
		return IsSpartanAbleToSpeak(SPARTANS.locke);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOStandBy();
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Arbiter, Canons offline on our position.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_07600.sound'),

		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Arbiter",

			--character = 0, -- GAMMA_CHARACTER: Arbiter
			text = "My troops will arrive and secure your position.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_arbiter_04300.sound'),

			sleepAfter = 0.6,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Arbiter",

			--character = nil, -- GAMMA_CHARACTER: Arbiter
			text = "Move on the Guardian. You must reach the Master Chief in time.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_arbiter_01800.sound'),
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Copy that, sir.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_08700.sound'),

			playDurationAdjustment = 0.95,
		},
		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return ai_living_count (AI.gr_turret_all) > b_turrettown_enemy_limit and ai_living_count(AI.sq_turrtown_phantom1) == 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Osiris, secure this area so the Arbiter's people can land.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_00700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
					--	OBJECTIVE TEXT
					CreateMissionThread(title_objective_clear);
				return 0;
			end,

		},

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		CreateMissionThread(tsunami_turrettown_friendlies_are_back);
		CreateMissionThread(tsunami_turrettown_clear_area_nag);
		tsunami_chatter_on = true;
	end,

	
};

------------------------------------------------------------------------------------------------------

function tsunami_turrettown_clear_area_nag()

	PrintNarrative("WAKE - tsunami_turrettown_clear_area_nag");

	sleep_s(30);

	PrintNarrative("START - tsunami_turrettown_clear_area_nag - 01");
	
	if ai_living_count (AI.gr_turret_all) > b_turrettown_enemy_limit and ai_living_count(AI.sq_turrtown_phantom1) == 0 then

				PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__clear_the_area_nag");
				NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__clear_the_area_nag);	
	end

	sleep_s(30);

	PrintNarrative("START - tsunami_turrettown_clear_area_nag - 02");
	
	if ai_living_count (AI.gr_turret_all) > b_turrettown_enemy_limit and ai_living_count(AI.sq_turrtown_phantom1) == 0 then


				PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__clear_the_area_nag_2");
				NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__clear_the_area_nag_2);	

	end

	PrintNarrative("END - tsunami_turrettown_clear_area_nag");	

end


--[========================================================================[
          Tsunami. turret town. clear the area nag
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__clear_the_area_nag = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__clear_the_area_nag",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				PushForwardVOReset();
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Still too many enemies. Clear the LZ, Osiris. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_00800.sound'),
			
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
          Tsunami. turret town. clear the area nag
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__clear_the_area_nag_2 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__clear_the_area_nag_2",

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
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				PushForwardVOReset();
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Keep hunting, Osiris. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_08400.sound'),
						
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	
};



-------------------------

function Tsunami__turrettown_Covenant_grunt_01()

	sleep_s(2);

	PrintNarrative("START - Tsunami__turrettown_Covenant_grunt_01");

	IsThereAnEnemyInRangeLauncher(W2TsunamiTitanAtTsunami_Tsunami__turrettown_Covenant_grunt_01, AI.gr_turret_all, ACTOR_TYPE.grunt, "enemy_in_range", w2_tsunami_station.goal_turrettown, 5 );
	
end

--[========================================================================[
          Tsunami. underbelly. Covenant Panic
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turrettown_Covenant_grunt_01 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turrettown_Covenant_grunt_01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return v_shrike_tally < 5;
			end,

			text = "Do not touch my cannons!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt02_01500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(Tsunami__turrettown_Covenant_elite_01);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};

-------------------------

function Tsunami__turrettown_Covenant_elite_01()

	sleep_s(10);

	PrintNarrative("START - Tsunami__turrettown_Covenant_elite_01");

	IsThereAnEnemyInRangeLauncher(W2TsunamiTitanAtTsunami_Tsunami__turrettown_Covenant_elite_01, AI.gr_turret_all, ACTOR_TYPE.elite, "enemy_in_range", w2_tsunami_station.goal_turrettown, 10 );
	
end

--[========================================================================[
          Tsunami. underbelly. Covenant Panic
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turrettown_Covenant_elite_01 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turrettown_Covenant_elite_01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return v_shrike_tally < 5;
			end,

			text = "Protect the cannons!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elite01_01700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(Tsunami__turrettown_Covenant_elite_02);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};


-------------------------

function Tsunami__turrettown_Covenant_elite_02()

	sleep_s(10);

	PrintNarrative("START - Tsunami__turrettown_Covenant_elite_02");

	IsThereAnEnemyInRangeLauncher(W2TsunamiTitanAtTsunami_Tsunami__turrettown_Covenant_elite_02, AI.gr_turret_all, ACTOR_TYPE.elite, "enemy_in_range", w2_tsunami_station.goal_turrettown, 10 );
	
end

--[========================================================================[
          Tsunami. underbelly. Covenant Panic
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turrettown_Covenant_elite_02 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turrettown_Covenant_elite_02",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			text = "Protect Sunaion!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elite01_01800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};


------------------------------------------------------------------------------------------------------

function tsunami_turrettown_friendlies_are_back()

	PrintNarrative("WAKE - tsunami_turrettown_friendlies_are_back");

	SleepUntil([|  ai_living_count(AI.sq_turrtown_phantom1) >= 1], 10);

	PrintNarrative("START - tsunami_turrettown_friendlies_are_back");
	
	PushForwardVOStandBy();

	local s_lookAtFriendlyTimer:number = 0;
	local s_speaker:object = nil;
	
	repeat
		s_lookAtFriendlyTimer = s_lookAtFriendlyTimer + 0.2;
		--PrintNarrative("tsunami_turrettown_friendlies_are_back repeat: start sleep")
		sleep_s(0.2);
	until (objects_can_see_object( players(), ai_get_object(AI.sq_turrtown_phantom1), 10 ) or objects_can_see_object( players(), ai_get_object(AI.sq_turrtown_phantom2), 10 )) or s_lookAtFriendlyTimer >= 8 or (objects_distance_to_object( players(), ai_get_object(AI.sq_turrtown_phantom1) ) < 30)

	if s_lookAtFriendlyTimer >= 8 then 
		s_speaker = GetClosestMusketeer(SPARTANS.locke);
	elseif (objects_distance_to_object( players(), ai_get_object(AI.sq_turrtown_phantom1) ) < 50 or objects_distance_to_object( players(), ai_get_object(AI.sq_turrtown_phantom2) ) < 50) then
		s_speaker = GetClosestMusketeer(ai_get_object(AI.sq_turrtown_phantom1), 2);
		if s_speaker == nil then
			s_speaker = GetClosestMusketeer(ai_get_object(AI.sq_turrtown_phantom2), 2);
		end
	end	

		W2TsunamiTitanAtTsunami_Tsunami__turret_town__Friendlies_are_bac.localVariables.s_speaker = s_speaker;
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__Friendlies_are_bac");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__Friendlies_are_bac);	
	

	PrintNarrative("END - tsunami_turrettown_friendlies_are_back");
end



--[========================================================================[
          Tsunami. turret town. Friendlies are back
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__Friendlies_are_bac = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__Friendlies_are_bac",
	
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(100);
	end,

	sleepAfter = 1,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke or objects_can_see_object( SPARTANS.locke, ai_get_object(AI.sq_turrtown_phantom1), 10 ); -- GAMMA_TRANSITION: If locke look at  the phantom first or next available spartan
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Friendly phantoms approaching. Watch your fire!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_03600.sound'),
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck or objects_can_see_object( SPARTANS.buck, ai_get_object(AI.sq_turrtown_phantom1), 10 ); -- GAMMA_TRANSITION: If buck look at  the phantom first or next available spartan
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Friendly phantoms approaching. Watch your fire!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_02100.sound'),
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka or objects_can_see_object( SPARTANS.tanaka, ai_get_object(AI.sq_turrtown_phantom1), 10 ); -- GAMMA_TRANSITION: If tanaka look at  the phantom first or next available spartan
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Friendly phantoms approaching. Watch your fire!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_01700.sound'),
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale or objects_can_see_object( SPARTANS.vale, ai_get_object(AI.sq_turrtown_phantom1), 10 ); -- GAMMA_TRANSITION: If vale look at  the phantom first or next available spartan
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Friendly phantoms approaching. Watch your fire!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_01400.sound'),
		},
		[5] = {
			Else = true,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Friendly phantoms approaching. Watch your fire!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_01400.sound'),
		},
		[6] = {
			sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Makhee",

			--character = 0, -- GAMMA_CHARACTER: Eliteescort (MAHKEE)
			text = "Spartan Locke. Come in.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_eliteescort_00100.sound'),
		},			
		[7] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Mahkee. Hello again.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_11200.sound'),
		},				
		[8] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Makhee",

			--character = 0, -- GAMMA_CHARACTER: ELITEESCORT (maHKEE)
			text = "Air defenses still protect the skies between you and the Guardian. Too many for me to ferry you to your destination.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_eliteescort_00200.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__elites_combat");
				NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__elites_combat);	
			end,
		},
		[9] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Makhee",

			--character = 0, -- GAMMA_CHARACTER: Eliteescort (MAHKEE)
			text = "You need another path. At your location there is passage to Sunaion's undercity, which will allow direct access to the Guardian. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_eliteescort_00300.sound'),			
		},
		[10] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));					
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Thank you, Mahkee. We'll move that way.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_11300.sound'),

			sleepAfter = 0.8,
		},
		[11] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Osiris, Mahkee says there's a way down. Find it. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_08800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		CreateMissionThread(tsunami_turrettown_elevator);
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {
						s_speaker = nil
					},
};


--[========================================================================[
          Tsunami. turret town. elites in combat
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__elites_combat = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__elites_combat",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_turrtown_reinforcements_1) > 1;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {

			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count (AI.gr_turret_all) > 0;
			end,

			sleepBefore = 2,

			character = AI.sq_turrtown_reinforcements_1.spawnpoint101,
			text = "Look for any Covenant still alive!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend01_01300.sound'),
			
		},
		[2] = {
		
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count (AI.gr_turret_all) > 0;
			end,

			character = AI.sq_turrtown_reinforcements_1.spawnpoint102,
			text = "Take control of the area!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend02_00800.sound'),
			
			sleepAfter = 2,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__elites");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__elites);	
				
	end,

	
};

--[========================================================================[
          Tsunami. turret town. elites
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__elites = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__elites",

	CanStart = function (thisConvo, queue)
		return (ai_living_count (AI.gr_turret_all) <= 0 or (ai_living_count (AI.gr_turret_all) > 0 and (ai_living_count (AI.gr_turret_all) == ai_living_count(AI.sq_turret_chantgrunts)))) and ai_living_count(AI.sq_turrtown_reinforcements_1) > 1;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOAdd(10);
	end,

	lines = {
		[1] = {	
			character = AI.sq_turrtown_reinforcements_1.spawnpoint103,
			text = "Area is clear!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend03_00300.sound'),
			
		},
		[2] = {
			character = AI.sq_turrtown_reinforcements_1.spawnpoint101,
			text = "In position!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend04_00100.sound'),
			
		},
		[3] = {
			character = AI.sq_turrtown_reinforcements_1.spawnpoint102,
			text = "Position secure!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend01_01700.sound'),
		},
	},

	sleepAfter = 5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__elevator_01__Objective");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__elevator_01__Objective);

		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__elites_1");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__elites_1);	

		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__elites_2");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__elites_2);	

		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__elites_3");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__elites_3);	

		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__elites_4");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__elites_4);		
	end,

	
};

--[========================================================================[
          Tsunami. turret town. elites
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__elites_1 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__elites_1",

	CanStart = function (thisConvo, queue)
		return not b_turrettown_elite_talk and objects_can_see_object( players(), ai_get_object(AI.sq_turrtown_reinforcements_1.spawnpoint102), 20 ) and objects_distance_to_object( players(), ai_get_object(AI.sq_turrtown_reinforcements_1.spawnpoint102) ) < 3 ;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(10);
		b_turrettown_elite_talk = true;
	end,

	lines = {
		[1] = {
			character = AI.sq_turrtown_reinforcements_1.spawnpoint102, -- GAMMA_CHARACTER: ElitefrIEND01
			text = "Good work Spartans, we are holding this position now.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend01_01800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_turrettown_elite_talk = false;

		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__elevator_01__Objective_2");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__elevator_01__Objective_2);	
	end,

	
};



--[========================================================================[
          Tsunami. turret town. elites
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__elites_2 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__elites_2",

	CanStart = function (thisConvo, queue)
		return not b_turrettown_elite_talk and objects_can_see_object( players(), ai_get_object(AI.sq_turrtown_reinforcements_1.spawnpoint152), 20 ) and objects_distance_to_object( players(), ai_get_object(AI.sq_turrtown_reinforcements_1.spawnpoint152) ) < 3 ;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(10);
		b_turrettown_elite_talk = true;
	end,

	lines = {
		[1] = {
			character = AI.sq_turrtown_reinforcements_1.spawnpoint152, -- GAMMA_CHARACTER: ElitefrIEND02
			text = "The guardian will leave soon Spartan, you should go.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend02_00500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_turrettown_elite_talk = false;
	end,

	
};


--[========================================================================[
          Tsunami. turret town. elites
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__elites_3 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__elites_3",

	CanStart = function (thisConvo, queue)
		return not b_turrettown_elite_talk and objects_can_see_object( players(), ai_get_object(AI.sq_turrtown_reinforcements_1.spawnpoint102), 20 ) and objects_distance_to_object( players(), ai_get_object(AI.sq_turrtown_reinforcements_1.spawnpoint102) ) < 5 ;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(10);
		b_turrettown_elite_talk = true;
	end,

	lines = {
		[1] = {
			character = AI.sq_turrtown_reinforcements_1.spawnpoint102, -- GAMMA_CHARACTER: ElitefRIEND03
			text = "Sword of Sanghelios are taking Sunaion. Victory is near!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend03_00200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_turrettown_elite_talk = false;
	end,

	
};


--[========================================================================[
          Tsunami. turret town. elites
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__elites_4 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__elites_4",

	CanStart = function (thisConvo, queue)
		return objects_distance_to_object( players(), ai_get_object(AI.sq_turrtown_reinforcements_1.spawnpoint103) ) > 5 and objects_distance_to_object( players(), ai_get_object(AI.sq_turrtown_reinforcements_1.spawnpoint103) ) < 8;
	end,	

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOAdd(30);
	end,

	lines = {
		[1] = {
			character = AI.sq_turrtown_reinforcements_1.spawnpoint150, -- GAMMA_CHARACTER: ElitefrIEND01
			text = "This is a good day for Sanghelios, Brother.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend01_01900.sound'),
		},
		[2] = {
			character = AI.sq_turrtown_reinforcements_1.spawnpoint103, -- GAMMA_CHARACTER: ElitefrIEND02
			text = "Yes...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend02_00600.sound'),
		},
		[3] = {
			character = AI.sq_turrtown_reinforcements_1.spawnpoint150, -- GAMMA_CHARACTER: ElitefRIEND01
			text = "What is it, I hear worry in your voice, you should rejoice.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend01_02000.sound'),
		},
		[4] = {
			character = AI.sq_turrtown_reinforcements_1.spawnpoint103, -- GAMMA_CHARACTER: ElitefRIEND02
			text = "What will happen when the guardian will leave.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend02_00700.sound'),
		},
		[5] = {
			character = AI.sq_turrtown_reinforcements_1.spawnpoint150, -- GAMMA_CHARACTER: ElitefrIEND01
			text = "Nothing will happen. Do not believe the stories you have heard.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend01_02100.sound'),
		},
		[6] = {
			character = AI.sq_turrtown_reinforcements_1.spawnpoint150, -- GAMMA_CHARACTER: ElitefrIEND01
			text = "It is not our god. It is barely a spaceship.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend01_02200.sound'),
		},
	},

	sleepAfter = 2,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};

--[========================================================================[
          Tsunami. turret town. elevator
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__go_down = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__go_down",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		
		--	NEED TO ADD ELITE CONVERSATION ON RADIO
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	
};



------------------------------------------------------------------------------------------------------

function tsunami_turrettown_elevator()

	PrintNarrative("WAKE - tsunami_turrettown_elevator");

	PrintNarrative("START - tsunami_turrettown_elevator");
				
			--	OBJECTIVE TEXT
			CreateMissionThread(title_objective_proceed);
			CreateThread(audio_guardian_elevator_reveal);

			SleepUntil([|  device_get_power( OBJECTS.dc_elevator1) == 1], 30);

			local s_lookAtElevatorTimer:number = 0;
			local s_speaker:object = nil;

			CreateMissionThread(tsunami_turrettown_linger);

			repeat
				s_lookAtElevatorTimer = s_lookAtElevatorTimer + 0.2;
				--PrintNarrative("tsunami_turrettown_elevator repeat: start sleep")
				sleep_s(0.2);
				s_speaker = spartan_look_at_object(players(), OBJECTS.dc_elevator1, 5, 40, 0.1, 2);
			until  (s_lookAtElevatorTimer >= 20 and objects_distance_to_object( spartans(), OBJECTS.dc_elevator1 ) < 20) or volume_test_players( VOLUMES.tv_narrative_tsunami_turrettown_elevator ) or s_speaker ~= nil

			if s_lookAtElevatorTimer >= 20 then 
				s_speaker = GetClosestMusketeer(OBJECTS.dc_elevator1);
				PrintNarrative("tsunami_turrettown_elevator: Speaker");
				print(s_speaker);
			end

			b_player_saw_elevator_01 = true;

			W2TsunamiTitanAtTsunami_Tsunami__turret_town__elevator_look_at.localVariables.s_speaker = s_speaker;
			PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__elevator_look_at");
			NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__elevator_look_at);	

			

	PrintNarrative("END - tsunami_turrettown_elevator");

end


--[========================================================================[
          Tsunami. turret town. elevator look at
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__elevator_look_at = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__elevator_look_at",

	CanStart = function (thisConvo, queue)
		return not b_turrettown_elite_talk;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return device_get_power( OBJECTS.dc_elevator1) == 1 and (thisConvo.localVariables.s_speaker == SPARTANS.locke or volume_test_object( VOLUMES.tv_narrative_tsunami_turrettown_elevator , SPARTANS.locke ) or (objects_can_see_object( SPARTANS.locke, OBJECTS.dc_elevator1, 20 ) and (objects_distance_to_object( SPARTANS.locke, OBJECTS.dc_elevator1 ) < 5)));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "There's an elevator.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_03800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return device_get_power( OBJECTS.dc_elevator1) == 1 and (thisConvo.localVariables.s_speaker == SPARTANS.buck or volume_test_object( VOLUMES.tv_narrative_tsunami_turrettown_elevator , SPARTANS.buck ) or(objects_can_see_object( SPARTANS.buck, OBJECTS.dc_elevator1, 20 ) and (objects_distance_to_object( SPARTANS.buck, OBJECTS.dc_elevator1 ) < 5)));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Found an elevator.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_02400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return device_get_power( OBJECTS.dc_elevator1) == 1 and (thisConvo.localVariables.s_speaker == SPARTANS.tanaka or volume_test_object( VOLUMES.tv_narrative_tsunami_turrettown_elevator , SPARTANS.tanaka ) or (objects_can_see_object( SPARTANS.tanaka, OBJECTS.dc_elevator1, 20 ) and (objects_distance_to_object( SPARTANS.tanaka, OBJECTS.dc_elevator1 ) < 5)));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Elevator over there.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_01800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return device_get_power( OBJECTS.dc_elevator1) == 1 and (thisConvo.localVariables.s_speaker == SPARTANS.vale or volume_test_object( VOLUMES.tv_narrative_tsunami_turrettown_elevator , SPARTANS.vale ) or (objects_can_see_object( SPARTANS.vale, OBJECTS.dc_elevator1, 20 ) and (objects_distance_to_object( SPARTANS.vale, OBJECTS.dc_elevator1 ) < 5)));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "There's an elevator.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_01600.sound'),

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



------------------------------------------------------------------------------------------------------

function tsunami_turrettown_linger()

	PrintNarrative("WAKE - tsunami_turrettown_linger");
	
	PushForwardVOReset(30);
	b_push_forward_test_combat = false;

	--	ADD CHECK IF PLAYER INTERACTED WITH THE ELEVATOR TO AVOID TIMER COMING AT 0 AT THE SAME TIME

	PrintNarrative("START - tsunami_turrettown_linger");

	SleepUntil([|b_push_forward_vo_timer == 3 ]);

	if device_get_position( OBJECTS.dc_elevator1 ) == 0 and IsGoalActive(w2_tsunami_station.goal_trans_underbelly) then

			PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__elevator__Linger");
			NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__elevator__Linger);	
					
	end

	PrintNarrative("END - tsunami_turrettown_linger");	
end


--[========================================================================[
          Tsunami. turret town. elevator. Linger
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__elevator__Linger = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__elevator__Linger",

	CanStart = function (thisConvo, queue)
		return not b_turrettown_elite_talk;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(30);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_player_interacted_with_elevator_01;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Swords of Sanghelios have this on lock down. Time to move on. Need to get to Chief.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_04400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__elevator__Linger_2");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__elevator__Linger_2);	
	end,
};




--[========================================================================[
          Tsunami. turret town. elevator. Linger
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__elevator__Linger_2 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__elevator__Linger_2",

	CanStart = function (thisConvo, queue)
		return b_player_saw_elevator_01 and b_push_forward_vo_timer == 3 and device_get_position( OBJECTS.dc_elevator1 ) == 0 and IsGoalActive(w2_tsunami_station.goal_trans_underbelly) ; -- GAMMA_CONDITION
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
				return not b_player_interacted_with_elevator_01;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Guardian's won't wait for us. The Elevator will take us to the Uundercity.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_07200.sound'),

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
          Tsunami. elevator 01. Objective

          There is an Arbiter-loyal Elite standing at the elevator to
          draw the player's attention:
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__elevator_01__Objective = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__elevator_01__Objective",

	CanStart = function (thisConvo, queue)
		return not b_turrettown_elite_talk and  ai_get_actor_type(object_get_ai(volume_return_objects( VOLUMES.tv_narrative_elite_on_stairs)[1])) == ACTOR_TYPE.elite and objects_distance_to_object( players(), volume_return_objects( VOLUMES.tv_narrative_elite_on_stairs)[1]) > 6 and objects_distance_to_object( players(), volume_return_objects( VOLUMES.tv_narrative_elite_on_stairs)[1]) < 12 ;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_turrettown_elite_talk = true;
		PushForwardVOAdd(5);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_player_interacted_with_elevator_01;
			end,

			character = AI.sq_turrtown_reinforcements_1.spawnpoint102,
			text = "Humans! Over here!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend01_01000.sound'),
		},

	},

	sleepAfter = 5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_turrettown_elite_talk = false;
	end,

	
};




--[========================================================================[
          Tsunami. elevator 01. Objective

          There is an Arbiter-loyal Elite standing at the elevator to
          draw the player's attention:
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__elevator_01__Objective_2 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__elevator_01__Objective_2",

	CanStart = function (thisConvo, queue)
		return  not b_turrettown_elite_talk and b_player_saw_elevator_01 and (objects_distance_to_object( players(), ai_get_object(AI.sq_turrtown_reinforcements_1.spawnpoint153)) < 2);
		--	COULD REPLACE THAT BY ONE FUNCTION THAT TEST DISTANCE AND LOOK AT FOR SAME OBJECT
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_turrettown_elite_talk = true;
	end,

	lines = {
		[1] = {
			character = AI.sq_turrtown_reinforcements_1.spawnpoint153,
			text = "Here is passage to the Undercity.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend01_01100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_turrettown_elite_talk = false;
	end,

	
};


------------------------------------------------------------------------------------------------------

function tsunami_elevator_01_get_in_listener()

	SleepUntil([| object_valid( "dc_elevator1" ) ], 60);
	SleepUntil([| device_get_power( OBJECTS.dc_elevator1) == 1 ], 60);

	PrintNarrative("LISTENER - tsunami_elevator_01_get_in_listener");

	RegisterInteractEvent( tsunami_elevator_01_get_in_launcher, OBJECTS.dc_elevator1);
end

function tsunami_elevator_01_get_in_launcher(turret:object, killer:object)

	PrintNarrative("LAUNCHER - tsunami_elevator_01_get_in_launcher");

	print(killer, " is the killer of ", turret);

	W2TsunamiTitanAtTsunami_Tsunami__elevator_01__Get_in.localVariables.killer = killer;
	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__elevator_01__Get_in");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__elevator_01__Get_in);
	
	b_player_interacted_with_elevator_01 = true;
end



--[========================================================================[
          Tsunami. elevator 01. Get in
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__elevator_01__Get_in = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__elevator_01__Get_in",

	CanStart = function (thisConvo, queue)
		return true;
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
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.locke; -- GAMMA_TRANSITION: If locke interacted with the elevator
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Everybody on the elevator.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_01500.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.buck; -- GAMMA_TRANSITION: If buck interacted with the elevator
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Everybody on the elevator.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_02600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.tanaka; -- GAMMA_TRANSITION: If tanaka interacted with the elevator
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Everybody on the elevator.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_02000.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return  thisConvo.localVariables.killer == SPARTANS.vale; -- GAMMA_TRANSITION: If vale interacted with the elevator
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Everybody on the elevator.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_02200.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__elevator_01_down");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__elevator_01_down);
	end,

	localVariables = {
						killer = nil,
						},
};



--[========================================================================[
          Tsunami. elevator 01
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__elevator_01_down = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__elevator_01_down",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	sleepBefore = 1,

	lines = {
		[1] = {
			character = AI.sq_turrtown_reinforcements_1.spawnpoint101,
			text = "Good luck down there Spartans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elitefriend01_02300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(tsunami_elevator_01);
	end,
};

------------------------------------------------------------------------------------------------------

function tsunami_elevator_01()

	PrintNarrative("WAKE - tsunami_elevator_01");
	PrintNarrative("START - tsunami_elevator_01");

	sleep_s(0.5);				

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__elevator_01");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__elevator_01);

	PrintNarrative("END - tsunami_elevator_01");

end


--[========================================================================[
          Tsunami. elevator 01
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__elevator_01 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__elevator_01",

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

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Arbiter.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_07700.sound'),		
		},
		[2] = {
			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "We're heading to the lower platform.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_02400.sound'),
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			sleepBefore = 0.3,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: locke
			text = "I want to warn you -- before the Guardian jumps to slipspace, it sets off a series of concussive blasts.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_04100.sound'),
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "If you get your people out of the way in time, the Covenant will take the brunt of it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_07800.sound'),
		},
		[5] = {			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Arbiter",

			--character = 0, -- GAMMA_CHARACTER: Arbiter
			text = "Victory and honor do not grow from timid seeds, Spartan Locke. Your harvest shall be grand.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_arbiter_01700.sound'),
			
			sleepAfter = 1,
		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Arbiter",

			--character = 0, -- GAMMA_CHARACTER: Arbiter
			text = "When you see the Chief again... tell him I send my greetings.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_arbiter_04200.sound'),
		},
		[7] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "I will indeed, sir.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_11400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			sleepAfter = 1.5, 
		},
		[8] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Locke, I've never heard a Sangheili address a human like that.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_02800.sound'),
		},
		[9] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "I'll try not to let it go to my head.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_08900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,	
};


function Tsunami__turret_town__guardian_look_at()
local s_speaker:object = nil;

	SleepUntil([| object_valid( "cr_guardian_hologram" )  ], 200);

	PrintNarrative("LISTENER - Tsunami__turret_town__guardian_look_at");

	repeat
			sleep_s(0.1);

			repeat 							
					SleepUntil([| volume_test_players(VOLUMES.tv_narrative_tsunami_turrettown_shield_building_1) or volume_test_players(VOLUMES.tv_narrative_tsunami_turrettown_shield_building_2) or not object_valid( "cr_guardian_hologram" ) ], 10);					

					if object_valid( "cr_guardian_hologram") then													

							repeat
								s_speaker = nil;
								sleep_s(0.1);
								s_speaker = spartan_look_at_object(players(), OBJECTS.cr_guardian_hologram, 7, 20, 2, 0);
							until s_speaker ~= nil or not (volume_test_players(VOLUMES.tv_narrative_tsunami_turrettown_shield_building_1) or volume_test_players(VOLUMES.tv_narrative_tsunami_turrettown_shield_building_2))
					end

			until (NarrativeQueue.ConversationsPlayingCount() == 0 and s_speaker ~= nil) or not object_valid( "cr_guardian_hologram" ) 

			if not TestClosestEnemyDistance(AI.gr_turret_all, 7) and object_valid( "cr_guardian_hologram" ) then

				if s_speaker == SPARTANS.locke and not IsSpartanInCombat(SPARTANS.locke) then
				
					PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__guardian_look_at_locke");
					NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__guardian_look_at_locke);

				elseif s_speaker == SPARTANS.buck and not IsSpartanInCombat(SPARTANS.buck) then
				
					PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__guardian_look_at_buck");
					NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__guardian_look_at_buck);

				elseif s_speaker == SPARTANS.tanaka and not IsSpartanInCombat(SPARTANS.tanaka) then
				
					PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__guardian_look_at_tanaka");
					NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__guardian_look_at_tanaka);

				elseif s_speaker == SPARTANS.vale and not IsSpartanInCombat(SPARTANS.vale) then
				
					PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__turret_town__guardian_look_at_vale");
					NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__turret_town__guardian_look_at_vale);

				end
			else
				sleep_s(1);
			end

	until (W2TsunamiTitanAtTsunami_Tsunami__turret_town__guardian_look_at_locke.localVariables.s_speaker and 
				((IsPlayer(SPARTANS.buck) and W2TsunamiTitanAtTsunami_Tsunami__turret_town__guardian_look_at_buck.localVariables.s_speaker) or not IsPlayer(SPARTANS.buck))
				 and ((IsPlayer(SPARTANS.tanaka) and W2TsunamiTitanAtTsunami_Tsunami__turret_town__guardian_look_at_tanaka.localVariables.s_speaker) or not IsPlayer(SPARTANS.tanaka))
				 and ((IsPlayer(SPARTANS.vale) and W2TsunamiTitanAtTsunami_Tsunami__turret_town__guardian_look_at_vale.localVariables.s_speaker) or not IsPlayer(SPARTANS.vale))
			)
				 or not IsGoalActive(w2_tsunami_station.goal_turrettown)

	PrintNarrative("LISTENER - Tsunami__turret_town__guardian_look_at - ALL PLAYERS LOOKED");
end

--[========================================================================[
          Tsunami. turret town. guardian look at
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__guardian_look_at_locke = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__guardian_look_at_locke",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.locke,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Guardian's the only way we'll get to the Master Chief in time to help him with Cortana. We should get moving.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_09800.sound'),
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
          Tsunami. turret town. guardian look at
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__guardian_look_at_buck = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__guardian_look_at_buck",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.buck,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Guardian's the only way we'll get to the Master Chief in time to help him with Cortana. We'd better get moving.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_07000.sound'),
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
          Tsunami. turret town. guardian look at
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__guardian_look_at_tanaka = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__guardian_look_at_tanaka",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.tanaka,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Guardian's only way to reach the Master Chief in time to help him with Cortana. Best get mov'n.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_05900.sound'),
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
          Tsunami. turret town. guardian look at
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__turret_town__guardian_look_at_vale = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__turret_town__guardian_look_at_vale",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.vale,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Guardian's the only way we'll get to the Master Chief in time to help him with Cortana. We'd better get moving.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_04600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
						s_speaker = nil,
						},
};



------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--	Underbelly 1
------------------------------------------------------------------------------------------------------


function tsunami_underbelly1_load()

	PrintNarrative("LOAD - tsunami_underbelly1_load");

	b_push_forward_test_combat = true;
	tsunami_chatter_on = true;

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__Start");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__Start);

	sleep_s(0.2);

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__entrance_spirit");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__entrance_spirit);
	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__entrance_spirit_back");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__entrance_spirit_back);
	
	SleepUntil([| ai_living_count(AI.gr_ub_greenplat_all) > 0], 60);

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__Guardian");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__Guardian);
	
	CreateMissionThread(Tsunami__underbelly__Covenant_Panic_elite_a_01);
	CreateMissionThread(Tsunami__underbelly__Covenant_Panic_grunt_a_01);

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami_new_enemy");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami_new_enemy);
	
end



------------------------------------------------------------------------------------------------------



--[========================================================================[
          Tsunami. underbelly 1. Start

          As the Spartans step out of the elevator...
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__Start = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__Start",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narrative_tsunami_underbelly_1 ); -- GAMMA_CONDITION
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

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Mahkee says we'll get direct access to the Guardian from down here. But remember we don't have the Swords of Sanghelios to distract these troops.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_11500.sound'),

			sleepAfter = 0.3,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Whatever gets us to the Guardian quickest.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_05700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__Jump");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__Jump);
	end,
};



--[========================================================================[
          Tsunami. underbelly 1. entrance spirit
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__entrance_spirit = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__entrance_spirit",

	CanStart = function (thisConvo, queue)
		return (ai_living_count(AI.sq_ub_phantom2.driver) > 0 and objects_distance_to_object( players(),  ai_get_object(AI.sq_ub_phantom2.driver) ) < 50
				or (ai_living_count(AI.sq_ub_phantom2.driver) > 0 and objects_distance_to_object( players(),  ai_get_object(AI.sq_ub1_lm1_spirit.spawnpoint152) ) < 50));
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; 
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {		
			character = function (thisLine, thisConvo, queue, lineNumber)
							if ai_living_count(AI.sq_ub_phantom2.driver) > 0 and (objects_distance_to_object( players(), ai_get_object(AI.sq_ub_phantom2.driver) ) < objects_distance_to_object( players(),  ai_get_object(AI.sq_ub1_lm1_spirit.spawnpoint152) ) ) then								
								return AI.sq_ub_phantom2
							else
								return AI.sq_ub1_lm1_spirit 
							end
						end,

			text = "The sword of Sanghelios have breached our sacred city.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elite01_00900.sound'),
			--tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_VO_SCR_W2TsunamiTitanAtTsunami_CV_Elite01_00300.sound'),	-- Shout line
			
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__entrance_spirit_2");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__entrance_spirit_2);
	end,

	
};


--[========================================================================[
          Tsunami. underbelly 1. entrance spirit
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__entrance_spirit_2 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__entrance_spirit_2",

	CanStart = function (thisConvo, queue)
		return (ai_living_count(AI.sq_ub_phantom2.driver) > 0 and objects_distance_to_object( players(),  ai_get_object(AI.sq_ub_phantom2.driver) ) < 50
				or (ai_living_count(AI.sq_ub_phantom2.driver) > 0 and objects_distance_to_object( players(),  ai_get_object(AI.sq_ub1_lm1_spirit.spawnpoint152) ) < 50));
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; 
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {		
			sleepBefore = 1,

			character = function (thisLine, thisConvo, queue, lineNumber)
							if ai_living_count(AI.sq_ub_phantom2.driver) > 0 and (objects_distance_to_object( players(), ai_get_object(AI.sq_ub_phantom2.driver) ) < objects_distance_to_object( players(),  ai_get_object(AI.sq_ub1_lm1_spirit.spawnpoint152) ) ) then
								return AI.sq_ub_phantom2
							else
								return AI.sq_ub1_lm1_spirit 
							end
						end,				
			text = "Do not let the false Arbiter and the Sword of Sanghelios claim Sunaion.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elite01_01000.sound'),

			playDurationAdjustment = 0.7,
		},

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__entrance_spirit_3");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__entrance_spirit_3);
	end,

	
};


--[========================================================================[
          Tsunami. underbelly 1. entrance spirit
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__entrance_spirit_3 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__entrance_spirit_3",

	CanStart = function (thisConvo, queue)
		return (ai_living_count(AI.sq_ub_phantom2.driver) > 0 and objects_distance_to_object( players(),  ai_get_object(AI.sq_ub_phantom2.driver) ) < 50
				or (ai_living_count(AI.sq_ub_phantom2.driver) > 0 and objects_distance_to_object( players(),  ai_get_object(AI.sq_ub1_lm1_spirit.spawnpoint152) ) < 50));
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; 
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {		
			sleepBefore = 1,

			character = function (thisLine, thisConvo, queue, lineNumber)
							if ai_living_count(AI.sq_ub_phantom2.driver) > 0 and (objects_distance_to_object( players(), ai_get_object(AI.sq_ub_phantom2.driver) ) < objects_distance_to_object( players(),  ai_get_object(AI.sq_ub1_lm1_spirit.spawnpoint152) ) ) then
								return AI.sq_ub_phantom2
							else
								return AI.sq_ub1_lm1_spirit 
							end
						end,
			
			text = "Brothers, The Covenant can not fall!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elite01_01400.sound'),

			playDurationAdjustment = 0.7,
		},
	
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__entrance_spirit_4");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__entrance_spirit_4);
	end,

	
};


--[========================================================================[
          Tsunami. underbelly 1. entrance spirit
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__entrance_spirit_4 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__entrance_spirit_4",

	CanStart = function (thisConvo, queue)
		return (ai_living_count(AI.sq_ub_phantom2.driver) > 0 and objects_distance_to_object( players(),  ai_get_object(AI.sq_ub_phantom2.driver) ) < 50
				or (ai_living_count(AI.sq_ub_phantom2.driver) > 0 and objects_distance_to_object( players(),  ai_get_object(AI.sq_ub1_lm1_spirit.spawnpoint152) ) < 50));

	end,
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; 
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {		
			sleepBefore = 1,
		
			character = function (thisLine, thisConvo, queue, lineNumber)
							if ai_living_count(AI.sq_ub_phantom2.driver) > 0 and (objects_distance_to_object( players(), ai_get_object(AI.sq_ub_phantom2.driver) ) < objects_distance_to_object( players(),  ai_get_object(AI.sq_ub1_lm1_spirit.spawnpoint152) ) ) then
								return AI.sq_ub_phantom2.driver
							else
								return AI.sq_ub1_lm1_spirit
							end
						end,

			text = "The Covenant is the only path.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elite01_01500.sound'),

			playDurationAdjustment = 0.6,
		},
	},

	sleepAfter = 5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};



-------------------------------------------------------------------------------------------------------------------------------------------------------


--[========================================================================[
          Tsunami. underbelly 1. Jump

          Players can jump or otherwise fall into the water below and
          die. Just a reminder.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__Jump = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__Jump",

	CanStart = function (thisConvo, queue)
		return NarrativeQueue.ConversationsPlayingCount() == 0 and volume_test_objects( VOLUMES.tv_narrative_player_fall, spartans() ) and IsSpartanAbleToSpeak(SPARTANS.locke) and IsSpartanAbleToSpeak(SPARTANS.tanaka); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	sleepBefore = 2,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Watch your step, Osiris.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_04300.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "It's still a long way down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_04400.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Direct access must have a different meaning on Sanghelios.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_03700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};


--[========================================================================[
          Tsunami. underbelly 1. entrance spirit

          There are a few Spirits in the air, deploying troops. As they
          do so, we can hear through loudspeaker, an Elite, motivating
          the Covenant on the ground.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__entrance_spirit_back = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__entrance_spirit_back",

	CanStart = function (thisConvo, queue)
		return objects_distance_to_object( players(), OBJECTS.cr_underbelly1_back_spirit ) < 28 ; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; 
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {	
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return  objects_distance_to_object( players(), OBJECTS.cr_underbelly1_back_spirit ) > 10;
			end,

			sleepBefore = 1,
			
			character = CHARACTER_OBJECTS.cr_underbelly1_back_spirit,
			text = "They have Humans amongst them.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elite01_01100.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return  objects_distance_to_object( players(), OBJECTS.cr_underbelly1_back_spirit ) > 10;
			end,

			sleepBefore = 1,

			character = CHARACTER_OBJECTS.cr_underbelly1_back_spirit,
			text = "This is a sacrilege!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elite01_01200.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return  objects_distance_to_object( players(), OBJECTS.cr_underbelly1_back_spirit ) > 10;
			end,

			sleepBefore = 1,

			character = CHARACTER_OBJECTS.cr_underbelly1_back_spirit,
			text = "They must be stopped!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elite01_01300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,	
};


-------------------------

function Tsunami__underbelly__Covenant_Panic_grunt_a_01()

	PrintNarrative("START - Tsunami__underbelly__Covenant_Panic_grunt_a_01");

	IsThereAnEnemyInRangeLauncher(W2TsunamiTitanAtTsunami_Tsunami__underbelly__Covenant_Panic_grunt_a_01, AI.gr_underbelly_all, ACTOR_TYPE.grunt, "enemy_in_range", w2_tsunami_station.goal_underbelly_1, 20 );
	
end

--[========================================================================[
          Tsunami. underbelly. Covenant Panic
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__underbelly__Covenant_Panic_grunt_a_01 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__underbelly__Covenant_Panic_grunt_a_01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {

			text = "The humans are here!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt01_00500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(Tsunami__underbelly__Covenant_Panic_grunt_b_01);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};


-------------------------

function Tsunami__underbelly__Covenant_Panic_grunt_b_01()

	PrintNarrative("START - Tsunami__underbelly__Covenant_Panic_grunt_b_01");

	sleep_s(1);

	IsThereAnEnemyInRangeLauncher(W2TsunamiTitanAtTsunami_Tsunami__underbelly__Covenant_Panic_grunt_b_01, AI.gr_underbelly_all, ACTOR_TYPE.grunt, "enemy_in_range", w2_tsunami_station.goal_underbelly_1, 20 );
	
end

--[========================================================================[
          Tsunami. underbelly. Covenant Panic
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__underbelly__Covenant_Panic_grunt_b_01 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__underbelly__Covenant_Panic_grunt_b_01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			text = "With me, Satha!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt01_00600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(Tsunami__underbelly__Covenant_Panic_grunt_c_01);

	end,

	localVariables = {
					enemy_in_range = nil,
					},
};


-------------------------

function Tsunami__underbelly__Covenant_Panic_grunt_c_01()

	PrintNarrative("START - Tsunami__underbelly__Covenant_Panic_grunt_c_01");

	sleep_s(1);

	IsThereAnEnemyInRangeLauncher(W2TsunamiTitanAtTsunami_Tsunami__underbelly__Covenant_Panic_grunt_c_01, AI.gr_underbelly_all, ACTOR_TYPE.grunt, "enemy_in_range", w2_tsunami_station.goal_underbelly_1, 20 );
	
end

--[========================================================================[
          Tsunami. underbelly. Covenant Panic
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__underbelly__Covenant_Panic_grunt_c_01 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__underbelly__Covenant_Panic_grunt_c_01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			text = "The Covenant will destroy youuuuuu!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt02_00300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(Tsunami__underbelly__Covenant_Panic_grunt_01);

	end,

	localVariables = {
					enemy_in_range = nil,
					},
};



-------------------------

function Tsunami__underbelly__Covenant_Panic_grunt_01()

	PrintNarrative("START - Tsunami__underbelly__Covenant_Panic_grunt_01");

	sleep_s(20);

	IsThereAnEnemyInRangeLauncher(W2TsunamiTitanAtTsunami_Tsunami__underbelly__Covenant_Panic_grunt_01, AI.gr_underbelly_all, ACTOR_TYPE.grunt, "enemy_in_range", w2_tsunami_station.goal_underbelly_1, 20 );
	
end

--[========================================================================[
          Tsunami. underbelly. Covenant Panic
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__underbelly__Covenant_Panic_grunt_01 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__underbelly__Covenant_Panic_grunt_01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			--character = 0, -- GAMMA_CHARACTER: Elite01
			text = "Sunaion is falling! I want to go hooooome!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt01_00200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(Tsunami__underbelly__Covenant_Panic_grunt_02);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};



-------------------------

function Tsunami__underbelly__Covenant_Panic_grunt_02()

	PrintNarrative("START - Tsunami__underbelly__Covenant_Panic_grunt_02");

	sleep_s(20);

	IsThereAnEnemyInRangeLauncher(W2TsunamiTitanAtTsunami_Tsunami__underbelly__Covenant_Panic_grunt_02, AI.gr_underbelly_all, ACTOR_TYPE.grunt, "enemy_in_range", w2_tsunami_station.goal_underbelly_1, 20 );
	
end

--[========================================================================[
          Tsunami. underbelly. Covenant Panic
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__underbelly__Covenant_Panic_grunt_02 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__underbelly__Covenant_Panic_grunt_02",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			--character = 0, -- GAMMA_CHARACTER: Elite01
			text = "I don't wanna die in Sunaion! I don't wanna die anywhere! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt02_00200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);	
	end,

	localVariables = {
					enemy_in_range = nil,
					},

};



-------------------------

function Tsunami__underbelly__Covenant_Panic_elite_a_01()

	PrintNarrative("START - Tsunami__underbelly__Covenant_Panic_elite_a_01");

	sleep_s(20);

	IsThereAnEnemyInRangeLauncher(W2TsunamiTitanAtTsunami_Tsunami__underbelly__Covenant_Panic_elite_a_01, AI.gr_underbelly_all, ACTOR_TYPE.elite, "enemy_in_range", w2_tsunami_station.goal_underbelly_1, 10 );
	
end

--[========================================================================[
          Tsunami. underbelly. Covenant Panic
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__underbelly__Covenant_Panic_elite_a_01 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__underbelly__Covenant_Panic_elite_a_01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			--character = 0, -- GAMMA_CHARACTER: Elite01
			text = "You will never pass me!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elite01_02300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(Tsunami__underbelly__Covenant_Panic_elite_01);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};

--------------


function Tsunami__underbelly__Covenant_Panic_elite_01()

	PrintNarrative("START - Tsunami__underbelly__Covenant_Panic_elite_01");

	sleep_s(20);

	IsThereAnEnemyInRangeLauncher(W2TsunamiTitanAtTsunami_Tsunami__underbelly__Covenant_Panic_elite_01, AI.gr_underbelly_all, ACTOR_TYPE.elite, "enemy_in_range", w2_tsunami_station.goal_underbelly_1, 10 );
	
end

--[========================================================================[
          Tsunami. underbelly. Covenant Panic
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__underbelly__Covenant_Panic_elite_01 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__underbelly__Covenant_Panic_elite_01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			--character = 0, -- GAMMA_CHARACTER: Elite01
			text = "If reinforcements do not arrive soon, Sunaion will fall!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elite01_00300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};




--[========================================================================[
          Tsunami. underbelly 1. Guardian
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__Guardian = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__Guardian",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narrative_underbelly_motivate ); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	--sleepBefore = 5,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_return_players( VOLUMES.tv_narrative_underbelly_motivate )[1] == SPARTANS.locke; -- GAMMA_TRANSITION: If locke sees the guardian
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Guardian's still too far. Hurry!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_09500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_return_players( VOLUMES.tv_narrative_underbelly_motivate )[1] == SPARTANS.buck; -- GAMMA_TRANSITION: If buck sees the guardian
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Guardian's still too far. Hurry!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_06900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_return_players( VOLUMES.tv_narrative_underbelly_motivate )[1] == SPARTANS.tanaka; -- GAMMA_TRANSITION: If tanaka sees the guardian
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Guardian's still too far. Hurry!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_05700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_return_players( VOLUMES.tv_narrative_underbelly_motivate )[1] == SPARTANS.vale; -- GAMMA_TRANSITION: If vale sees the guardian
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Guardian's still too far. Hurry!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_04500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};



global W2TsunamiTitanAtTsunami_Tsunami_new_enemy = {
	name = "W2TsunamiTitanAtTsunami_Tsunami_new_enemy",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narrative_underbelly_lost_01 ); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Arbiter",

			--character = 0, -- GAMMA_CHARACTER: Arbiter
			text = "Spartans. Be aware. New enemies join the battle. Armored. Glowing. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_arbiter_02900.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Sounds like Prometheans. We'll be ready, Arbiter.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_06300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
				PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__underbelly_2__Whale_song");
				NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__underbelly_2__Whale_song);
			end,

			sleepAfter = 2,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "The Constructor must have done its work.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_02300.sound'),
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "It means the Guardian will be awake soon. Double time Osiris!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_13000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,	
};


------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--	Underbelly 2
------------------------------------------------------------------------------------------------------



function tsunami_underbelly2_load()

	PrintNarrative("LOAD - tsunami_underbelly2_load");
		

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__underbelly_2__hunters");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__underbelly_2__hunters);	
	
	PushForwardVOReset();

	CreateMissionThread(tsunami_underbelly2_wrong_direction);
	CreateMissionThread(tsunami_underbelly2_wrong_direction_b);

	if IsPlayer(SPARTANS.buck) then
		CreateMissionThread(tsunami_buck_memory);
	end

	SleepUntil([| object_valid("cr_underbelly2_spirit") ], 10);

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__underbelly_2_spirit_01");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__underbelly_2_spirit_01);

end


function tsunami_underbelly2_wrong_direction()

	PrintNarrative("LOAD - tsunami_underbelly2_wrong_direction");

	repeat

		SleepUntil([| volume_test_players( VOLUMES.tv_narrative_underbelly_lost_01 ) ], 10);

			if volume_return_players( VOLUMES.tv_narrative_underbelly_lost_01 )[1] == SPARTANS.locke then 
				b_wrong_direction_locke = true;
			end
			if volume_return_players( VOLUMES.tv_narrative_underbelly_lost_01 )[1] == SPARTANS.buck then 
				b_wrong_direction_buck = true;
			end
			if volume_return_players( VOLUMES.tv_narrative_underbelly_lost_01 )[1] == SPARTANS.tanaka then 
				b_wrong_direction_tanaka = true;
			end
			if volume_return_players( VOLUMES.tv_narrative_underbelly_lost_01 )[1] == SPARTANS.vale then 
				b_wrong_direction_vale = true;
			end

	until not IsGoalActive(w2_tsunami_station.goal_underbelly_2)


end


function tsunami_underbelly2_wrong_direction_b()

	PrintNarrative("LOAD - tsunami_underbelly2_wrong_direction_b");

	repeat

		SleepUntil([| volume_test_players( VOLUMES.tv_narrative_underbelly_lost_02 ) ], 30);

			if volume_return_players( VOLUMES.tv_narrative_underbelly_lost_02 )[1] == SPARTANS.locke and b_wrong_direction_locke and not b_wrong_direction_b_locke then 
				b_wrong_direction_b_locke = true;
				W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__wrong_direction.localVariables.s_speaker = SPARTANS.locke;
				PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__wrong_direction");
				NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__wrong_direction);
			elseif volume_return_players( VOLUMES.tv_narrative_underbelly_lost_02 )[1] == SPARTANS.buck and b_wrong_direction_buck and not b_wrong_direction_b_buck then 
				b_wrong_direction_b_buck = true;
				W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__wrong_direction.localVariables.s_speaker = SPARTANS.buck;
				PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__wrong_direction");
				NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__wrong_direction);
			elseif volume_return_players( VOLUMES.tv_narrative_underbelly_lost_02 )[1] == SPARTANS.tanaka and b_wrong_direction_tanaka and not b_wrong_direction_b_tanaka then 
				b_wrong_direction_b_tanaka = true;
				W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__wrong_direction.localVariables.s_speaker = SPARTANS.tanaka;
				PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__wrong_direction");
				NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__wrong_direction);
			elseif volume_return_players( VOLUMES.tv_narrative_underbelly_lost_02 )[1] == SPARTANS.vale and b_wrong_direction_vale and not b_wrong_direction_b_vale then 
				b_wrong_direction_b_vale = true;
				W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__wrong_direction.localVariables.s_speaker = SPARTANS.vale;
				PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__wrong_direction");
				NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__wrong_direction);
			end

	until not IsGoalActive(w2_tsunami_station.goal_underbelly_2)


end
--[========================================================================[
          Tsunami. underbelly 1. wrong direction

          Player can eventually get lost, a little hint to help them
          move forward.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__wrong_direction = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__underbelly_1__wrong_direction",

	CanStart = function (thisConvo, queue)
		return thisConvo.localVariables.s_speaker ~= nil; -- GAMMA_CONDITION
	end,

	PlayOnSpecificPlayer = function(thisConvo, queue)	-- OBJECT (target all clients if unused)
		return thisConvo.localVariables.s_speaker;
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
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If player is going back to where he came from and locke is in front. client only
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    --radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "I think I just came from there.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_10000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				thisConvo.localVariables.s_speaker = nil;				
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: If player is going back to where he came from and buck is in front. client only
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    --radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "I think I just came from there.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_07200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				thisConvo.localVariables.s_speaker = nil;				
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: If player is going back to where he came from and tanaka is in front. client only
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    --radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "I think I just came from there.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_06200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				thisConvo.localVariables.s_speaker = nil;				
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: If player is going back to where he came from and vale is in front. client only
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    --radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "I think I just came from there.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_04800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				thisConvo.localVariables.s_speaker = nil;				
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {
						s_speaker = nil,
						},
};


function tsunami_buck_memory()

	PrintNarrative("START - tsunami_buck_memory");

	repeat
		
		if IsPlayer(SPARTANS.buck) then
				SleepUntil([| not IsSpartanInCombat(SPARTANS.buck) and ObjectGetSpeed( SPARTANS.buck) < 1
								and (		objects_can_see_object( SPARTANS.buck, OBJECTS.buck_memory_01, 20 )
										or	objects_can_see_object( SPARTANS.buck, OBJECTS.buck_memory_02, 20 )
									)
							], 10);

				sleep_s(0.7);
		
				if ObjectGetSpeed( SPARTANS.buck) < 1 and not IsSpartanInCombat(SPARTANS.buck) 
					and (	objects_can_see_object( SPARTANS.buck, OBJECTS.buck_memory_01, 20 )
						or	objects_can_see_object( SPARTANS.buck, OBJECTS.buck_memory_02, 20 )) then

						sleep_s(0.7);

							if ObjectGetSpeed( SPARTANS.buck) < 1 and not IsSpartanInCombat(SPARTANS.buck) 
								and (	objects_can_see_object( SPARTANS.buck, OBJECTS.buck_memory_01, 20 )
									or	objects_can_see_object( SPARTANS.buck, OBJECTS.buck_memory_02, 20 )) then

									PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__collectibles_07__Memory");
									NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__collectibles_07__Memory);
							
									SleepUntil([| NarrativeQueue.HasConversationFinished(W2TsunamiTitanAtTsunami_Tsunami__collectibles_07__Memory)	], 10);

							end
				end
		end

	until not IsPlayer(SPARTANS.buck) or (b_buck_memory_played or not (IsGoalActive(w2_tsunami_station.goal_underbelly_1) or IsGoalActive(w2_tsunami_station.goal_underbelly_2))) or NarrativeQueue.HasConversationFinished(W2TsunamiTitanAtTsunami_Tsunami__collectibles_07__Memory)

	PrintNarrative("END - tsunami_buck_memory");

end



--[========================================================================[
          Tsunami. collectibles 07. Memory

          Vista + 1 element TBD   memory TBD

          001_VO_SCR_Collectibles_UN_BUCK_00900.wav in collectibles
          script.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__collectibles_07__Memory = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__collectibles_07__Memory",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.buck,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_buck_memory_played = true;
		PushForwardVOReset(30);
		CreateMissionThread(tsunami_buck_memory_interrupt);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Waves crashing below us, plasma burning through the air above us ... one step too far in either direction and we're dead. Hell, Veronica. You know... I didn't used to worry about dying.  ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_08100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};

------------


function tsunami_buck_memory_interrupt()

	PrintNarrative("WAKE - tsunami_buck_memory_interrupt");

	repeat
		sleep_s(0.3);

	until NarrativeQueue.HasConversationFinished(W2TsunamiTitanAtTsunami_Tsunami__collectibles_07__Memory) or object_get_shield( SPARTANS.buck ) < 1
			 or (
					(IsSpartanInCombat(SPARTANS.locke) and objects_distance_to_object( SPARTANS.locke, SPARTANS.buck ) < 3)
					or (IsSpartanInCombat(SPARTANS.tanaka) and objects_distance_to_object( SPARTANS.tanaka, SPARTANS.buck ) < 3)
					or (IsSpartanInCombat(SPARTANS.vale) and objects_distance_to_object( SPARTANS.vale, SPARTANS.buck ) < 3)
				)

	PrintNarrative("START - tsunami_buck_memory_interrupt");

	NarrativeQueue.InterruptConversation(W2TsunamiTitanAtTsunami_Tsunami__collectibles_07__Memory);
	sleep_s(0.2);
	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__collectibles_07__Memory_interrupt");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__collectibles_07__Memory_interrupt);

	PrintNarrative("END - tsunami_buck_memory_interrupt");

end


--[========================================================================[
          Tsunami. collectibles 07. Memory

          Vista + 1 element TBD   memory TBD

          001_VO_SCR_Collectibles_UN_BUCK_00900.wav in collectibles
          script.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__collectibles_07__Memory_interrupt = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__collectibles_07__Memory_interrupt",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.buck,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "[Memory Interrupt!]",
			tag = TAG('sound\001_vo\001_vo_ai\001_vo_ai_buck\001_vo_ai_un_buck_02combat_combatidledanger.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


--[========================================================================[
          Tsunami. underbelly 2. Whale song

          After the first section of the underbelly, Osiris arrives at 
          a section of scaffolding. Suddenly - before the first enemy -
          we hear the whale song!
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__underbelly_2__Whale_song = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__underbelly_2__Whale_song",

	CanStart = function (thisConvo, queue)
		return volume_test_players (VOLUMES.tv_ub2_spawnspirit); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		AIDialogManager.DisableAIDialog(AI.sq_ub2_walkway_greeters);
	end,

	lines = {

		[1] = {			
			sleepBefore = 1,
					
			character = AI.sq_ub2_landmark3_spirit, -- GAMMA_CHARACTER: Elite01
			text = "Sunaion is ours! The Covenant will be victori-- What... That's impossible. Go, Go!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elite01_01600.sound'),

			playDurationAdjustment = 0.7,	
			
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
					PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__underbelly_2__Whale_song_grunts");
					NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__underbelly_2__Whale_song_grunts);
				return 2;
			end,		
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,	
};






--[========================================================================[
   
          Tsunami. underbelly 2. Whale song
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__underbelly_2__Whale_song_grunts = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__underbelly_2__Whale_song_grunts",

	CanStart = function (thisConvo, queue)
		return ai_combat_status(AI.sq_ub2_walkway_greeters) < 5 and ai_living_count(AI.sq_ub2_walkway_greeters.spawnpoint122) == 1 and ai_living_count(AI.sq_ub2_walkway_greeters.spawnpoint123) == 1; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		CreateMissionThread(Tsunami__underbelly_2_Covenant_Panic_grunt_a_01);		
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		if ai_combat_status(AI.sq_ub2_walkway_greeters) >= 5 then
			return 0;
		else
			return 20;
		end;
	end,

	sleepBefore = 1,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return false;
			end,

			character = AI.sq_ub2_walkway_greeters.spawnpoint123, -- GAMMA_CHARACTER: Grunt01
			text = "What is that sound? That's the second time we hear it",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt01_01600.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return false;
			end,

			character = AI.sq_ub2_walkway_greeters.spawnpoint122, -- GAMMA_CHARACTER: Grunt02
			text = "It's our God, the Guardian, he's coming to help us!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt02_01400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		AIDialogManager.EnableAIDialog(AI.sq_ub2_walkway_greeters);
	end,
};


-------------------------

function Tsunami__underbelly_2_Covenant_Panic_grunt_a_01()

	PrintNarrative("START - Tsunami__underbelly_2_Covenant_Panic_grunt_a_01");

	--sleep_s(20);

	SleepUntil([|	ai_combat_status(AI.sq_ub2_walkway_greeters) >= 5 ], 1);

	AIDialogManager.EnableAIDialog(AI.sq_ub2_walkway_greeters);

	IsThereAnEnemyInRangeLauncher(W2TsunamiTitanAtTsunami_Tsunami__underbelly_2_Covenant_Panic_grunt_a_01, AI.sq_ub2_walkway_greeters, ACTOR_TYPE.grunt, "enemy_in_range", w2_tsunami_station.goal_underbelly_2, 15 );
	NarrativeQueue.InterruptConversation(W2TsunamiTitanAtTsunami_Tsunami__underbelly_2__Whale_song_grunts);
		
end

--[========================================================================[
          Tsunami. underbelly. Covenant Panic
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__underbelly_2_Covenant_Panic_grunt_a_01 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__underbelly_2_Covenant_Panic_grunt_a_01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			--character = 0, -- GAMMA_CHARACTER: Elite01
			text = "Here they are! Humans are dirty!!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt01_01700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(Tsunami__underbelly_2_Covenant_Panic_grunt_01);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};


-------------------------

function Tsunami__underbelly_2_Covenant_Panic_grunt_01()

	PrintNarrative("START - Tsunami__underbelly_2_Covenant_Panic_grunt_01");

	sleep_s(20);

	IsThereAnEnemyInRangeLauncher(W2TsunamiTitanAtTsunami_Tsunami__underbelly_2_Covenant_Panic_grunt_01, AI.gr_underbelly2_all, ACTOR_TYPE.grunt, "enemy_in_range", w2_tsunami_station.goal_underbelly_2, 10 );
	
end

--[========================================================================[
          Tsunami. underbelly. Covenant Panic
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__underbelly_2_Covenant_Panic_grunt_01 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__underbelly_2_Covenant_Panic_grunt_01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			--character = 0, -- GAMMA_CHARACTER: Elite01
			text = "They said Sunaion would never fall to the Arbiter! Why did I believe them?!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt03_00100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};


--[========================================================================[
          Tsunami. underbelly. Covenant Panic
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__underbelly_2_spirit_01 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__underbelly_2_Covenant_Panic_elite_01",

	CanStart = function (thisConvo, queue)
		return (object_valid("cr_underbelly2_spirit") and objects_distance_to_object( players(), OBJECTS.cr_underbelly2_spirit ) < 25);
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
				return objects_distance_to_object( players(), OBJECTS.cr_underbelly2_spirit ) > 10;
			end,

			character = CHARACTER_OBJECTS.cr_underbelly2_spirit,
			text = "Sunaion is our last hope!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elite02_00400.sound'),
		},
	},

	sleepAfter = 3,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__underbelly_2_spirit_02");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__underbelly_2_spirit_02);
	end,
};



--[========================================================================[
          Tsunami. underbelly. Covenant Panic
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__underbelly_2_spirit_02 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__underbelly_2_spirit_02",

	CanStart = function (thisConvo, queue)
		return (objects_distance_to_object( players(), OBJECTS.cr_underbelly2_spirit ) < 25);
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
				return objects_distance_to_object( players(), OBJECTS.cr_underbelly2_spirit ) > 10;
			end,

			character = CHARACTER_OBJECTS.cr_underbelly2_spirit,
			text = "We must hold Sunaion or die defending it!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elite02_00500.sound'),
		},
	},

	sleepAfter = 3,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__underbelly_2_spirit_03");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__underbelly_2_spirit_03);
	end,
};




--[========================================================================[
          Tsunami. underbelly. Covenant Panic
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__underbelly_2_spirit_03 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__underbelly_2_spirit_03",

	CanStart = function (thisConvo, queue)
		return (objects_distance_to_object( players(), OBJECTS.cr_underbelly2_spirit ) < 25);
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
				return objects_distance_to_object( players(), OBJECTS.cr_underbelly2_spirit ) > 10;
			end,

			character = CHARACTER_OBJECTS.cr_underbelly2_spirit,
			text = "Do not let the heretics take Sunaion!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elite02_00300.sound'),
		},
	},

	sleepAfter = 3,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__underbelly_2_spirit_04");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__underbelly_2_spirit_04);
	end,
};



--[========================================================================[
          Tsunami. underbelly. Covenant Panic
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__underbelly_2_spirit_04 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__underbelly_2_spirit_04",

	CanStart = function (thisConvo, queue)
		return (objects_distance_to_object( players(), OBJECTS.cr_underbelly2_spirit ) < 25);
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
				return objects_distance_to_object( players(), OBJECTS.cr_underbelly2_spirit ) > 10;
			end,

			character = CHARACTER_OBJECTS.cr_underbelly2_spirit,
			text = "We must hold Sunaion, brothers! \r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_elite02_00200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};

--[========================================================================[
          Tsunami. underbelly 2. hunters

          At the end of this section, in front of the elevator, there
          are two Hunters. We first see the worms on the floor
          squirming and flowing away from us.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__underbelly_2__hunters = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__underbelly_2__hunters",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narrative_tsunami_underbelly_2_hunters ); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 2.5,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
		
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object( VOLUMES.tv_narrative_tsunami_underbelly_2_hunters, SPARTANS.locke ); -- GAMMA_TRANSITION: If locke look at  the hunters first or next available spartan
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Hunters. Get ready.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_11600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object( VOLUMES.tv_narrative_tsunami_underbelly_2_hunters, SPARTANS.buck ); -- GAMMA_TRANSITION: If buck look at  the hunters first or next available spartan
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Hunters!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_02900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return  volume_test_object( VOLUMES.tv_narrative_tsunami_underbelly_2_hunters, SPARTANS.tanaka ); -- GAMMA_TRANSITION: If tanaka look at the hunters first or next available spartan
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Hunters!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_02200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return  volume_test_object( VOLUMES.tv_narrative_tsunami_underbelly_2_hunters, SPARTANS.vale ); -- GAMMA_TRANSITION: If tanaka look at the hunters first or next available spartan
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Hunters!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_07300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		CreateMissionThread(tsunami_underbelly_2_hunters_dead_listener);
	end,

	
};


------------------------------------------------------------------------------------------------------

function tsunami_underbelly_2_hunters_dead_listener()
  SleepUntil([| ai_living_count(AI.hunter_form_squad) >= 1 ], 1);
	SleepUntil([| ai_living_count(AI.hunter_form_squad) <= 1 ], 1);

	local s_last_living_ai:object = ai_get_unit( AI.hunter_form_squad );

	PrintNarrative("LISTENER - tsunami_underbelly_2_hunters_dead_listener");
	print(" LAst AI alive is:  ", s_last_living_ai);

	if ai_living_count(AI.hunter_form_squad) <= 0 then
		PrintNarrative("LISTENER - tsunami_underbelly_2_hunters_dead_listener - ALL DEAD");
		
		if IsSpartanAbleToSpeak(SPARTANS.buck) then			
			CreateMissionThread(tsunami_underbelly_2_hunters_dead_launcher, s_last_living_ai, SPARTANS.buck);
		elseif IsSpartanAbleToSpeak(SPARTANS.vale) then			
			CreateMissionThread(tsunami_underbelly_2_hunters_dead_launcher, s_last_living_ai, SPARTANS.vale);
		elseif IsSpartanAbleToSpeak(SPARTANS.tanaka) then
			CreateMissionThread(tsunami_underbelly_2_hunters_dead_launcher, s_last_living_ai, SPARTANS.tanaka);
		else
			CreateMissionThread(tsunami_underbelly_2_hunters_dead_launcher, s_last_living_ai, SPARTANS.locke);
		end
	else
		RegisterDeathEvent (tsunami_underbelly_2_hunters_dead_launcher, s_last_living_ai);
	end
end

---------------------	

function tsunami_underbelly_2_hunters_dead_launcher(target:object, killer:object)

	PrintNarrative("LAUNCHER - tsunami_underbelly_2_hunters_dead_launcher");

	print(killer, " is the killer of ", target);

	--CreateMissionThread(tsunami_underbelly_2_hunters_dead, killer);
	W2TsunamiTitanAtTsunami_Tsunami__underbelly_2__Hunters_dead.localVariables.killer = killer;

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__underbelly_2__Hunters_dead");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__underbelly_2__Hunters_dead);

end





--[========================================================================[
          Tsunami. underbelly 2. Hunters dead
          * Second beat of "we can't fly there" to set up the danger of
          what we'll have to end up doing. Also sets up palmer and
          halsey in the cinematic.

          Once the Hunters are dead, Osiris can take the elevator.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__underbelly_2__Hunters_dead = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__underbelly_2__Hunters_dead",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(20);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.locke ; -- GAMMA_TRANSITION: If locke killed the last hunter
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Hunters are down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_03500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.buck; -- GAMMA_TRANSITION: If buck killed the last hunter
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Hunters down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_02700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.tanaka; -- GAMMA_TRANSITION: If tanaka killed the last hunter
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Hunters are down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_02100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.vale; -- GAMMA_TRANSITION: If vale killed the last hunter
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Cleared the Hunters.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_02600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		CreateMissionThread(Tsunami__underbelly_2__Hunters_dead);
	end,

	localVariables = {
					killer = nil,
					},
};



function Tsunami__underbelly_2__Hunters_dead()

	repeat
			sleep_s(0.5);

	until GetClosestEnemy(AI.gr_underbelly2_all, 15) == nil or not IsSpartanInCombat()

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__underbelly_2__Hunters_dead_bis");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__underbelly_2__Hunters_dead_bis);		

end


--[========================================================================[
          Tsunami. underbelly 2. Hunters dead
          * Second beat of "we can't fly there" to set up the danger of
          what we'll have to end up doing. Also sets up palmer and
          halsey in the cinematic.

          Once the Hunters are dead, Osiris can take the elevator.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__underbelly_2__Hunters_dead_bis = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__underbelly_2__Hunters_dead_bis",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return IsGoalActive(w2_tsunami_station.goal_trans_arcade);
	end,
	
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(20);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return device_get_position (OBJECTS.dm_elev2_doora) == 0;
			end,			

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "End of the line. We have to go back up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_04200.sound'),

		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return device_get_position (OBJECTS.dm_elev2_doora) == 0;
			end,			

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Better hurry. Can't have too much longer to go.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_03900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__underbelly_2__Hunters_dead_2");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__underbelly_2__Hunters_dead_2);		
	end,

	localVariables = {
					killer = nil,
					},
};



--[========================================================================[
          Tsunami. underbelly 2. Hunters dead
          * Second beat of "we can't fly there" to set up the danger of
          what we'll have to end up doing. Also sets up palmer and
          halsey in the cinematic.

          Once the Hunters are dead, Osiris can take the elevator.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__underbelly_2__Hunters_dead_2 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__underbelly_2__Hunters_dead_2",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_timer == 12 ; -- GAMMA_CONDITION
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
			If = function (thisLine, thisConvo, queue, lineNumber)
				return IsGoalActive(w2_tsunami_station.goal_trans_arcade) and object_valid("dc_elevator2") and device_get_power( OBJECTS.dc_elevator2) == 1; -- GAMMA_TRANSITION: If player not in the elevator after X time
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Look for a way up.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_09600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
					killer = nil,
					},
};



----------------------------------------------------------------------------------------------------------------------------------  
----------------------------------------------------------------------------------------------------------------------------------  
----------------------------------------------------------------------------------------------------------------------------------  

function tsunami_trans_arcade_load()

	PrintNarrative("LOAD - tsunami_trans_arcade_load");

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__elevator_02");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__elevator_02);
	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__elevator_02__grunts_in_elevator");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__elevator_02__grunts_in_elevator);	
	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__elevator_02__grunts_in_elevator_osiris");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__elevator_02__grunts_in_elevator_osiris);	

end


----------------------------------------------------------------------------------------------------------------------------------  




--[========================================================================[
          Tsunami. elevator 02. grunts in elevator

          The elevator is going down. We can hear grunts speaking
          behind the door.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__elevator_02__grunts_in_elevator = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__elevator_02__grunts_in_elevator",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		AIDialogManager.DisableAIDialog(AI.sq_elev2_grunts);
	end,

	sleepBefore = 2,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return device_get_position (OBJECTS.dm_elev2_doora) < 0.5;
			end,

			character = CHARACTER_OBJECTS.elevator_grunts_01, -- GAMMA_CHARACTER: Grunt01
			text = "Do you think we'll be safe down here?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt01_02100.sound'),

			playDurationAdjustment = 0.9,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return device_get_position (OBJECTS.dm_elev2_doora) < 0.5;
			end,

			character = CHARACTER_OBJECTS.elevator_grunts_02, -- GAMMA_CHARACTER: Grunt02
			text = "Of course! They're all killing each other up there.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt02_01900.sound'),

			playDurationAdjustment = 0.9,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return device_get_position (OBJECTS.dm_elev2_doora) < 0.5;
			end,

			character = CHARACTER_OBJECTS.elevator_grunts_03, -- GAMMA_CHARACTER: Grunt01
			text = "I don't know... I feel like we're going to die",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt01_02200.sound'),

			playDurationAdjustment = 0.9,
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_elev2_grunts) > 3;
			end,

			character = CHARACTER_OBJECTS.elevator_grunts_04, -- GAMMA_CHARACTER: Grunt02
			text = "Nonsense!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt02_02000.sound'),

			playDurationAdjustment = 0.8,
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_elev2_grunts) > 3;
			end,

			character = CHARACTER_OBJECTS.elevator_grunts_04, -- GAMMA_CHARACTER: Grunt02
			text = "No I mean soon...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt01_02300.sound'),

			playDurationAdjustment = 0.9,
		},

		
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);	
		AIDialogManager.EnableAIDialog(AI.sq_elev2_grunts);		
	end,

	localVariables = {
					s_speaker = nil,
					},

};



--[========================================================================[
          Tsunami. elevator 02. grunts in elevator

          The elevator is going down. We can hear grunts speaking
          behind the door.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__elevator_02__grunts_in_elevator_osiris = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__elevator_02__grunts_in_elevator_osiris",
	
	CanStart = function (thisConvo, queue) -- BOOLEAN
		return device_get_position (OBJECTS.dm_elev2_doora) > 0;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
			if object_valid("dm_elev2_doora") then
					thisConvo.localVariables.s_speaker = GetClosestMusketeer(OBJECTS.dm_elev2_doora, 20, 2);
					if thisConvo.localVariables.s_speaker == SPARTANS.locke then
						thisConvo.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.locke, 10, 2);
					end
			end
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_speaker == SPARTANS.buck;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "I hear some grunts... Elevator door!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_08600.sound'),
		},		
		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_speaker == SPARTANS.vale;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Watch out, doors are opening!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_06800.sound'),
		},
		[3] = {
			Else = true,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Elevator doors!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_08100.sound'),
		},		
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 2,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(tsunami_underbelly_2_end_encounter_listener);
		CreateMissionThread(Tsunami__elevator_02__grunts_in_elevator_2);		
		CreateMissionThread(tsunami_elevator_02_get_in_launcher);		
	end,

	localVariables = {
					s_speaker = nil,
					},

};



------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--	START OF - REUSE OF ALL CLEAR FROM THE BEGINNING
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------


function tsunami_underbelly_2_end_encounter_listener()

	SleepUntil([| ai_living_count(AI.sq_elev2_grunts) <= 1 ], 1);

	local s_last_living_ai:object = ai_get_unit( AI.sq_elev2_grunts );

	PrintNarrative("LISTENER - tsunami_underbelly_2_end_encounter_listener");
	print(" LAst AI alive is:  ", s_last_living_ai);

	if ai_living_count(AI.sq_elev2_grunts) <= 0 then
		PrintNarrative("LISTENER - tsunami_underbelly_2_end_encounter_listener - ALL DEAD");

		CreateMissionThread(tsunami_underbelly_2_end_encounter_launcher, GetClosestMusketeer(OBJECTS.dc_elevator2, 10, 2));
	else
		RegisterDeathEvent (tsunami_underbelly_2_end_encounter_launcher, s_last_living_ai);
	end
end
---------------------
function tsunami_underbelly_2_end_encounter_launcher(target:object, killer:object)

	PrintNarrative("LAUNCHER - tsunami_underbelly_2_end_encounter_launcher");

	print(killer, " is the killer of ", target);
	
	CreateMissionThread(tsunami_underbelly_2_end_encounter_launcher_2, target, killer);
end


function tsunami_underbelly_2_end_encounter_launcher_2(target:object, killer:object)

	PrintNarrative("LAUNCHER - tsunami_underbelly_2_end_encounter_launcher_2");
	
	if GetClosestEnemy(AI.gr_underbelly2_all, 20) == nil and IsGoalActive(w2_tsunami_station.goal_underbelly_2) then

		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__underbelly_2_End_enc");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__underbelly_2_End_enc);
		W2TsunamiTitanAtTsunami_Tsunami__underbelly_2_End_enc.localVariables.killer = killer;
	end
end

--[========================================================================[
          Tsunami. Mission start. landing. End encounter
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__underbelly_2_End_enc = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__underbelly_2_End_enc",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(40);
	end,

	-- Sleep before running the conversation's OnStart()
	sleepBefore = 1,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.locke and GetClosestEnemy(AI.gr_underbelly2_all, 20) == nil; -- GAMMA_TRANSITION: If locke kills the last enemy
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "All clear!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_00400.sound'),

		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.buck and GetClosestEnemy(AI.gr_underbelly2_all, 20) == nil; -- GAMMA_TRANSITION: If buck kills the last enemy
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "All clear!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_00800.sound'),

		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.tanaka and GetClosestEnemy(AI.gr_underbelly2_all, 20) == nil; -- GAMMA_TRANSITION: If tanaka kills the last enemy
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "All clear!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_00200.sound'),

		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.vale and GetClosestEnemy(AI.gr_underbelly2_all, 20) == nil; -- GAMMA_TRANSITION: If vale kills the last enemy
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "All clear!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_02100.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)		
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {
						killer = nil
					},
};

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--	END OF - REUSE OF ALL CLEAR FROM THE BEGINNING
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------






-------------------------

function Tsunami__elevator_02__grunts_in_elevator_2()

	PrintNarrative("START - Tsunami__elevator_02__grunts_in_elevator_2");

	SleepUntil(	[|	ai_living_count(AI.sq_elev2_grunts) > 0 and ai_combat_status(AI.sq_elev2_grunts) > 4], 10);
	
	IsThereAnEnemyInRangeLauncher(W2TsunamiTitanAtTsunami_Tsunami__elevator_02__grunts_in_elevator_2, AI.sq_elev2_grunts, ACTOR_TYPE.grunt, "enemy_in_range", w2_tsunami_station.goal_trans_arcade, 20, true);
	NarrativeQueue.InterruptConversation(W2TsunamiTitanAtTsunami_Tsunami__elevator_02__grunts_in_elevator);
	
end

--[========================================================================[
          Tsunami. underbelly. Covenant Panic
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__elevator_02__grunts_in_elevator_2 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__elevator_02__grunts_in_elevator_2",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			--character = 0, -- GAMMA_CHARACTER: Elite01
			text = "AAahhhh!!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt01_02400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(Tsunami__elevator_02__grunts_in_elevator_3);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};



-------------------------

function Tsunami__elevator_02__grunts_in_elevator_3()

	PrintNarrative("START - Tsunami__elevator_02__grunts_in_elevator_3");

	IsThereAnEnemyInRangeLauncher(W2TsunamiTitanAtTsunami_Tsunami__elevator_02__grunts_in_elevator_3, AI.sq_elev2_grunts, ACTOR_TYPE.grunt, "enemy_in_range", w2_tsunami_station.goal_trans_arcade, 20, true );
		
end

--[========================================================================[
          Tsunami. underbelly. Covenant Panic
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__elevator_02__grunts_in_elevator_3 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__elevator_02__grunts_in_elevator_3",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			--character = 0, -- GAMMA_CHARACTER: Elite01
			text = "AAahhhh!!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt02_02100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};


function tsunami_elevator_02_get_in_listener()

	SleepUntil([| device_get_power( OBJECTS.dc_elevator2) == 1 ], 60);

	PrintNarrative("LISTENER - tsunami_elevator_02_get_in_listener");

	RegisterInteractEvent(tsunami_elevator_02_get_in_launcher, OBJECTS.dc_elevator2);
end

------------------------------  

function tsunami_elevator_02_get_in_launcher(turret:object, killer:object)

	--[[
	PrintNarrative("LAUNCHER - tsunami_elevator_02_get_in_launcher");

	print(killer, " is the killer of ", turret);

	UnregisterInteractEvent(tsunami_elevator_02_get_in_launcher, OBJECTS.dc_elevator2);
	W2TsunamiTitanAtTsunami_Tsunami__elevator_02__Entrance.localVariables.killer = killer;

	]]
		
	SleepUntil([| ai_living_count(AI.sq_elev2_grunts) == 0], 10);	

	--sleep_s(5);

	SleepUntil([| object_at_distance_and_can_see_object(players(), OBJECTS.dc_elevator2, 6, 180) ], 30);	

	W2TsunamiTitanAtTsunami_Tsunami__elevator_02__Entrance.localVariables.killer = GetClosestMusketeer(OBJECTS.dc_elevator2, 5, 2);
	
	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__elevator_02__Entrance");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__elevator_02__Entrance);
end


--[========================================================================[
          Tsunami. elevator 02. Entrance
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__elevator_02__Entrance = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__elevator_02__Entrance",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(90);
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
			text = "Everybody on the elevator.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_06700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.buck;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Everybody on the elevator.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_05700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.tanaka;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Everybody on the elevator.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_04600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.vale;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Everybody on the elevator.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_03600.sound'),

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
						killer = nil,
						},
};


------------------------------------------------------------------------------------------------------

--[========================================================================[
          Tsunami. elevator 02
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__elevator_02 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__elevator_02",

	CanStart = function (thisConvo, queue)
		return device_get_position (OBJECTS.dm_elev_2) > 0.05;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(90);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: locke
			text = "Arbiter, this is Spartan Locke. Do you copy?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_05300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			sleepAfter = 1.5,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Arbiter",

			--character = 0, -- GAMMA_CHARACTER: ARBITER
			text = "Spartan Locke! (static) --near the Guardian-- (static) --killing everyone-- (static)",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_arbiter_04000.sound'),

			sleepAfter = 0.4,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Arbiter.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_05400.sound'),
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Arbiter",
			
			--character = 0, -- GAMMA_CHARACTER: ARBITER
			text = "...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_arbiter_04100.sound'),
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "That's no good.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_06700.sound'),
		},
		[6] = {
			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "We should be close to the Guardian by now.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_11700.sound'),
		},
		[7] = {
			sleepBefore = 0.2,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VaLE
			text = "If we can help Arbiter...?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_05800.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,	
		},
		[8] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "We do. But not at the risk of missing the Guardian. Reaching the Master Chief is more important.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_11800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	
};


------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--	Arcade
------------------------------------------------------------------------------------------------------


function tsunami_arcade_load()

	PrintNarrative("LOAD - tsunami_arcade_load");

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__Pre_destruct");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__Pre_destruct);

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__arcade__E3_grunt");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__arcade__E3_grunt);	

	AIDialogManager.DisableAIDialog(AI.sq_arcadecomp_cov);
--	AIDialogManager.DisableAIDialog(AI.sq_arcadecomp_arb);
	ai_set_deaf(AI.sq_arcadecomp_cov, true);
	ai_set_blind(AI.sq_arcadecomp_cov, true);	
--	ai_set_deaf(AI.sq_arcadecomp_arb, true);
--	ai_set_blind(AI.sq_arcadecomp_arb, true);

end

------------------------------------------------------------------------------------------------------

--[========================================================================[
          Tsunami. destruction alley. Pre destruction

          After exiting the elevator, the area is empty but for the
          aftermath of a fierce battle. Arbiter-loyal and Covenant
          corpses litter the ground.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__Pre_destruct = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__Pre_destruct",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.tv_narrative_tsunami_arcade_aftermath);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		--CreateMissionThread(ShowTempTextNarrative,"Dead people around, like a battlefield, after the battle.", 5);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Looks like we just missed all the fun.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_04900.sound'),

			playDurationAdjustment = 0.85,
		},		
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PushForwardVOReset();
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__soldiers_2");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__soldiers_2);
	end,

	
};


--[========================================================================[
          Tsunami. destruction alley. soldiers

          A little further, there are 2 soldiers spawning in and
          disappearing soon after.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__soldiers_2 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__soldiers_2",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.tv_narrative_tsunami_arcade_aftermath) and object_at_distance_and_can_see_object(players(), ai_get_object(AI.sq_arcade_pawns.spawnpoint17), 15, 30); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
		thisConvo.localVariables.s_speaker = spartan_look_at_object_no_delay(players(), ai_get_object(AI.sq_arcade_pawns.spawnpoint17), 15, 30, 0, 2);
		if thisConvo.localVariables.s_speaker == nil then
			thisConvo.localVariables.s_speaker = GetClosestMusketeer(volume_return_players( VOLUMES.tv_narrative_tsunami_arcade_aftermath)[1], 10, 0);
		end
		if thisConvo.localVariables.s_speaker == SPARTANS.buck then
			thisConvo.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.buck, 10, 0);
		end
	end,

	--sleepBefore = 0.3,

	lines = {
		
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Prometheans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_04700.sound'),

			playDurationAdjustment = 0.9,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
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
			text = "Prometheans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_07100.sound'),

			playDurationAdjustment = 0.9,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
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
			text = "Prometheans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_06100.sound'),

			playDurationAdjustment = 0.9,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Prometheans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_09900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER				
				return 0;
			end,
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return false;
			end,

			--sleepBefore = 0.6,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "We must be getting close!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_01900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PushForwardVOReset(30);	
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__arcade_push");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__arcade_push);
	end,
	
	localVariables = {	
					s_speaker = nil
					},	
};




--[========================================================================[
          Tsunami. arcade. E3 grunt
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__arcade__E3_grunt = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__arcade__E3_grunt",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.tv_demo_fleebie); -- GAMMA_CONDITION
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
			character = AI.demo_arcade_fleebie.fleebie, -- GAMMA_CHARACTER: GRUNT01
			text = "Help! Helphelp!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt01_02800.sound'),
		},
		[2] = {
			character = AI.demo_arcade_fleebie.fleebie, -- GAMMA_CHARACTER: GRUNT01
			text = "I regret everything!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt01_02900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};

--[========================================================================[
          Tsunami. destruction alley. soldiers

          A little further, there are 2 soldiers spawning in and
          disappearing soon after.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__arcade_push = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__arcade_push",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_counrdown_on > 20 and (IsGoalActive(w2_tsunami_station.goal_arcade) or (IsGoalActive(w2_tsunami_station.goal_destructionalley) and not volume_test_players( VOLUMES.tv_narrative_tsunami_destruction_alley_whale_song) ));
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(30);
	end,

	--sleepBefore = 0.3,

	lines = {
		
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Guardian's straight across from here. Hurry.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_11900.sound'),

			--playDurationAdjustment = 0.9,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
	
	localVariables = {	
					s_speaker = nil
					},
	
};


------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--	Destruction Alley
------------------------------------------------------------------------------------------------------




function tsunami_destructionalley_load()

	PrintNarrative("WAKE - tsunami_destructionalley_load");

		CreateMissionThread(tsunami_destruction_alley_whale_song);
		--CreateMissionThread(tsunami_destruction_alley_guardian_reveal);		
		--CreateMissionThread(tsunami_destruction_alley_pulse);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__pulse");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__pulse);
		CreateMissionThread(tsunami_destruction_alley_wreckage);
		
		PushForwardVOReset();

		AIDialogManager.EnableAIDialog(AI.sq_arcadecomp_cov);
--		AIDialogManager.EnableAIDialog(AI.sq_arcadecomp_arb);		
end


------------------------------------------------------------------------------------------------------

function tsunami_destruction_alley_whale_song()

	PrintNarrative("WAKE - tsunami_destruction_alley_whale_song");

	SleepUntil([| volume_test_players(VOLUMES.tv_narrative_tsunami_destruction_alley_whale_song)], 10);

	PrintNarrative("START - tsunami_destruction_alley_whale_song");

	CreateMissionThread(guardian_whalesong_destruction_alley,OBJECTS.destruction_alley_guardian, "fx_head_front");
	
	CreateMissionThread(Tsunami__destruction_alley__GUARDIAN_REV);

	sleep_s(2.5);
	
	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami_guardian_new_rising");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami_guardian_new_rising);	

	PrintNarrative("END - tsunami_destruction_alley_whale_song");

end



--[========================================================================[
          Tsunami. turret town. Friendlies are back
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami_guardian_new_rising = {
	name = "W2TsunamiTitanAtTsunami_Tsunami_guardian_new_rising",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	--sleepAfter = 2,

	lines = {	
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Guardian's singing!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_07000.sound'),

			sleepAfter = 0.2,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "How much time do we have left?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_02600.sound'),

			sleepAfter = 0.2,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Not enough. Double Time Osiris!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_13100.sound'),
		},	
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();		
	end,

	localVariables = {
						s_speaker = nil
					},
};



function Tsunami__destruction_alley__GUARDIAN_REV()
	
	PrintNarrative("START - Tsunami__destruction_alley__GUARDIAN_REV");

	repeat
		
		sleep_s(0.1);

		SleepUntil([| object_at_distance_and_can_see_object(players(), OBJECTS.destruction_alley_guardian, 60, 20, VOLUMES.tv_narrative_tsunami_destruction_alley_guardian_reveal) or volume_test_players( VOLUMES.tv_narrative_tsunami_destruction_alley_guardian_reveal_safe ) ], 10);
			
		if volume_test_players( VOLUMES.tv_narrative_tsunami_destruction_alley_guardian_reveal_safe ) then
			W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__GUARDIAN_REV.localVariables.s_speaker = AlternateSpeakerWhenEnteringVolume(VOLUMES.tv_narrative_tsunami_destruction_alley_guardian_reveal_safe, 10,  0);
		else
			if object_at_distance_and_can_see_object(SPARTANS.locke, OBJECTS.destruction_alley_guardian, 60, 20, VOLUMES.tv_narrative_tsunami_destruction_alley_guardian_reveal) then
				W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__GUARDIAN_REV.localVariables.s_speaker = SPARTANS.locke;
			elseif object_at_distance_and_can_see_object(SPARTANS.buck, OBJECTS.destruction_alley_guardian, 60, 20, VOLUMES.tv_narrative_tsunami_destruction_alley_guardian_reveal) then
				W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__GUARDIAN_REV.localVariables.s_speaker = SPARTANS.buck;
			elseif object_at_distance_and_can_see_object(SPARTANS.tanaka, OBJECTS.destruction_alley_guardian, 60, 20, VOLUMES.tv_narrative_tsunami_destruction_alley_guardian_reveal) then
				W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__GUARDIAN_REV.localVariables.s_speaker = SPARTANS.tanaka;
			elseif object_at_distance_and_can_see_object(SPARTANS.vale, OBJECTS.destruction_alley_guardian, 60, 20, VOLUMES.tv_narrative_tsunami_destruction_alley_guardian_reveal) then
				W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__GUARDIAN_REV.localVariables.s_speaker = SPARTANS.vale;
			end
		end

	until W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__GUARDIAN_REV.localVariables.s_speaker ~= nil

	NarrativeQueue.InterruptConversation(W2TsunamiTitanAtTsunami_Tsunami_guardian_new_rising, 0.5);

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__GUARDIAN_REV");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__GUARDIAN_REV);

	PrintNarrative("END - Tsunami__destruction_alley__GUARDIAN_REV");
end

--[========================================================================[
          Tsunami. destruction alley. GUARDIAN REVEAL

          As Osiris rounds a corner, they see the Sunaion Guardian for
          the first time as it rises.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__GUARDIAN_REV = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__GUARDIAN_REV",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(30);			
	end,

	lines = {		
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Over there! In the ocean! GUARDIAN'S RISING!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_08000.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				thisConvo.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.buck, 5, 2);
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Over there! In the ocean! GUARDIAN'S RISING!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_12200.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				thisConvo.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.buck, 5, 2);
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
			text = "Over there! In the ocean! GUARDIAN'S RISING!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_07100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				thisConvo.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.tanaka, 5, 2);
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
			text = "Over there! In the ocean! GUARDIAN'S RISING!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_06100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				thisConvo.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.vale, 5, 2);
			end,

		},
		
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PushForwardVOReset(15);
		hud_hide_radio_transmission_hud();
	end,

		localVariables = {
						s_speaker = nil,
						},
};


--[========================================================================[
          Tsunami. destruction alley. pulse

          The Guardian emits its first concussion blast.

          Osiris has just enough time to see it coming before it blows
          apart the floor under their feet.

          The Destruction sequence will need more VO, but the
          experience needs to be more finished to be able to write the
          right lines.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__pulse = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__pulse",

	CanStart = function (thisConvo, queue)
		return b_destruction_start; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		thisConvo.localVariables.s_speaker = GetClosestMusketeer(OBJECTS.destruction_alley_guardian, 1000, 2);
		thisConvo.localVariables.s_speaker = GetClosestMusketeer(thisConvo.localVariables.s_speaker, 30, 0);
		if thisConvo.localVariables.s_speaker == SPARTANS.locke then
			thisConvo.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.locke, 10 ,2);
		end
		PushForwardVOReset(20);
		NarrativeQueue.InterruptConversation(W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__GUARDIAN_REV);		
	end,	

	sleepAfter = 0.5,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Arbiter! The guardian is...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_13200.sound'),

			playDurationAdjustment = 0.7,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If locke is first Just before receiving the pulse
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Look out!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_05600.sound'),

			playDurationAdjustment = 0.5,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: If buck is first Just before receiving the pulse
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Look out!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_05100.sound'),

			playDurationAdjustment = 0.5,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: If tanaka is first Just before receiving the pulse
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Look out!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_04100.sound'),

			playDurationAdjustment = 0.5,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: If vale is first Just before receiving the pulse
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Look out!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_03000.sound'),

			playDurationAdjustment = 0.5,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();		
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__after_phanto");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__after_phanto);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__pulse_electrified_locke");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__pulse_electrified_locke);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__pulse_electrified_buck");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__pulse_electrified_buck);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__pulse_electrified_tanaka");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__pulse_electrified_tanaka);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__pulse_electrified_vale");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__pulse_electrified_vale);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__first_fall");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__first_fall);
		PushForwardVOReset(10);
	end,

	localVariables = {
						s_speaker = nil,
						},
};

function b_tsunami_electrified_test()

repeat
	sleep_s(0.1);
	print(b_tsunami_electrified);

until b_tsunami_electrified == nil
end

--[========================================================================[
          Tsunami. destruction alley. pulse

--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__pulse_electrified_locke = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__pulse_electrified_locke",

	CanStart = function (thisConvo, queue)
		return b_tsunami_electrified; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 2;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = function(thisConvo, queue)	-- OBJECT (target all clients if unused)
		return SPARTANS.locke;
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "[emote, receiving pulse, armor being electrified for 1 sec]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_10700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,
};


--[========================================================================[
          Tsunami. destruction alley. pulse

--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__pulse_electrified_buck = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__pulse_electrified_buck",

	CanStart = function (thisConvo, queue)
		return b_tsunami_electrified; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 2;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = function(thisConvo, queue)	-- OBJECT (target all clients if unused)
		return SPARTANS.buck;
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "[emote, receiving pulse, armor being electrified for 1 sec]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_07800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


--[========================================================================[
          Tsunami. destruction alley. pulse

--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__pulse_electrified_tanaka = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__pulse_electrified_tanaka",

	CanStart = function (thisConvo, queue)
		return  b_tsunami_electrified; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 2;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = function(thisConvo, queue)	-- OBJECT (target all clients if unused)
		return SPARTANS.tanaka;
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "[emote, receiving pulse, armor being electrified for 1 sec]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_06700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};

--[========================================================================[
          Tsunami. destruction alley. pulse

--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__pulse_electrified_vale = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__pulse_electrified_vale",

	CanStart = function (thisConvo, queue)
		return  b_tsunami_electrified; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 2;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = function(thisConvo, queue)	-- OBJECT (target all clients if unused)
		return SPARTANS.vale;
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "[emote, receiving pulse, armor being electrified for 1 sec]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_05300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};

------------------------------------------------------------------------------------------------------

function tsunami_destruction_alley_start()
--[[
	]]
end


--[========================================================================[
          Tsunami. destruction alley. after phantom crashing above
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__after_phanto = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__after_phanto",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	sleepBefore = 4, 

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return false;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Mother Hell..",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_08200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__start");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__start);
	end,

};


--[========================================================================[
          Tsunami. destruction alley. start

          The destruction starts around the players.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__start = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__start",

	CanStart = function (thisConvo, queue)
		return  volume_test_players(VOLUMES.tv_narrative_tsunami_destruction_alley_start);
	end,

	sleepBefore = 1, 

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		thisConvo.localVariables.s_speaker = AlternateSpeakerWhenEnteringVolume(VOLUMES.tv_narrative_tsunami_destruction_alley_start, 15, 2);
		PushForwardVOReset(15);
		b_push_forward_test_combat = false;
		b_push_forward_test_speed = false;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: If locke is first Just before receiving the pulse
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Haven't come this far to let the Guardian slip away now. Hurry, Spartans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_04700.sound'),

		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: If buck is first Just before receiving the pulse
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Guardian's not leaving without us! Hurry Osiris!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_00700.sound'),

		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: If tanaka is first Just before receiving the pulse
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Guardian's not leaving without us! Hurry Osiris!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_02500.sound'),

		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If vale is first Just before receiving the pulse
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Guardian's not leaving without us! Hurry Osiris!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_00300.sound'),
		},
		[5] = {
			
			sleepBefore = 0.7,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Run! Ruuun!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_13300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(tsunami_destruction_alley_pushforward);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__steps");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__steps);
	end,

	localVariables = {
						s_speaker = nil,
						},
};



--[========================================================================[
          Tsunami. destruction alley. steps
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__steps = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__steps",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narrative_destruction_intro ); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	sleepBefore = 0.7,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return objects_distance_to_object( volume_return_players( VOLUMES.tv_narrative_destruction_intro )[1], SPARTANS.locke ) < 20;
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Watch your steps!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_13400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

};

------------------------------------------------------------------------------------------------------

function tsunami_destruction_alley_stagger(spartan:object)

	PrintNarrative("WAKE - tsunami_destruction_alley_stagger");

	PrintNarrative("START - tsunami_destruction_alley_stagger");

	PushForwardVOReset(10);

	if not b_destruction_alley_stager then
		
		b_destruction_alley_stager = true;

		W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__first_fall.localVariables.spartan = spartan;
		
	end
				
	PrintNarrative("END - tsunami_destruction_alley_stagger");

end



--[========================================================================[
          Tsunami. destruction alley. first fall

          The first player going on the scaffolding fall a couple
          meters.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__first_fall = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__first_fall",

	CanStart = function (thisConvo, queue)
		return thisConvo.localVariables.spartan ~= nil; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(10);
	end,

	PlayOnSpecificPlayer = function(thisConvo, queue)	-- OBJECT (target all clients if unused)
		return thisConvo.localVariables.spartan;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.spartan == SPARTANS.locke; -- GAMMA_TRANSITION: If locke falls
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "[Fall emote]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_06900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.spartan == SPARTANS.buck; -- GAMMA_TRANSITION: If buck falls
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Sonuva!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_06000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return  thisConvo.localVariables.spartan == SPARTANS.tanaka; -- GAMMA_TRANSITION: If tanaka falls
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Damn!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_04800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return  thisConvo.localVariables.spartan == SPARTANS.vale; -- GAMMA_TRANSITION: If vale falls
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Whoa!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_03700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__first_fall_2");
		W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__first_fall_2.localVariables.spartan = thisConvo.localVariables.spartan;
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__first_fall_2);
	end,

	localVariables = {
					spartan = nil,
					},
};


--[========================================================================[
          Tsunami. destruction alley. first fall

          The first player going on the scaffolding fall a couple
          meters.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__first_fall_2 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__first_fall_2",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(10);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return  IsSpartanAbleToSpeak(SPARTANS.buck) and objects_distance_to_object( thisConvo.localVariables.spartan, SPARTANS.buck ) < 15; -- GAMMA_TRANSITION: If vale falls
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Up! Up! Up! Move Spartan!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_06100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
					spartan = nil,
					},
};

------------------------------------------------------------------------------------------------------

function tsunami_destruction_alley_slide(spartan:object)

	PrintNarrative("WAKE - tsunami_destruction_alley_slide");

	PrintNarrative("START - tsunami_destruction_alley_slide");

	if	(	W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__second_fall.localVariables.spartan == nil 
			and	isDemo() == false
		)	then

		PushForwardVOReset(20);

		W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__second_fall.localVariables.spartan = spartan;
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__second_fall");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__second_fall);
	end

	PrintNarrative("END - tsunami_destruction_alley_slide");

end

--[========================================================================[
          Tsunami. destruction alley. second fall

          The wreckage the player is walking on starts moving

          NEEDS ADR
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__second_fall = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__second_fall",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.spartan ~= SPARTANS.vale; -- GAMMA_TRANSITION: If locke falls
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Careful, it's going to...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_03800.sound'),

			playDurationAdjustment = 0.8,

		},
--           And it breaks and falls, character is sliding down.

		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.spartan == SPARTANS.locke; -- GAMMA_TRANSITION: If locke falls
			end,

			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "[Fall emote]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_07000.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
				print("DISTANCE:", objects_distance_to_object( thisConvo.localVariables.spartan, SPARTANS.buck ));
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.spartan == SPARTANS.buck; -- GAMMA_TRANSITION: If locke falls
			end,

			--sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Oh boy...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_06200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 7; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.spartan == SPARTANS.tanaka; -- GAMMA_TRANSITION: If locke falls
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Aw hell!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_04900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.spartan == SPARTANS.vale; -- GAMMA_TRANSITION: If locke falls
			end,

			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Oh god...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_03900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--           Then they catch the ledge at the last second, looking down,
--           the ocean is raging. They lift themselves up.
-- 
--           NEEDS ADR FOR PLAYER THAT DON'T SLIDE BUT STAGER
		[6] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return IsSpartanAbleToSpeak(SPARTANS.buck) and objects_distance_to_object( thisConvo.localVariables.spartan, SPARTANS.buck ) < 40 and thisConvo.localVariables.spartan ~= SPARTANS.buck;
			end,

			sleepBefore = 1.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Up! Up! Up! Move Spartan!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_06100.sound'),

			playDurationAdjustment = 0.95,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[7] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return false; --thisConvo.localVariables.spartan == SPARTANS.locke; -- GAMMA_TRANSITION: If locke falls
			end,

			sleepBefore = 2,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "[lift up emote]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_07300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[8] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.spartan == SPARTANS.buck; -- GAMMA_TRANSITION: If locke falls
			end,

			sleepBefore = 1.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Close one...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_06300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[9] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.spartan == SPARTANS.tanaka; -- GAMMA_TRANSITION: If locke falls
			end,

			sleepBefore = 0.3,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Wow... ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_05000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[10] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.spartan == SPARTANS.vale; -- GAMMA_TRANSITION: If locke falls
			end,

			--sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Watch where you're going Vale...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_04000.sound'),

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
					spartan = nil,
					},
};



------------------------------------------------------------------------------------------------------

function tsunami_destruction_alley_wreckage()

	PrintNarrative("WAKE - tsunami_destruction_alley_wreckage");

	SleepUntil([| b_platfall_02], 10);

	PrintNarrative("TIMER - tsunami_destruction_alley_wreckage");

	sleep_s(7);

	PrintNarrative("WAKE 2 - tsunami_destruction_alley_wreckage");

	SleepUntil([| volume_test_players( VOLUMES.tv_narrative_tsunami_destruction_alley_wreckage ) and volume_test_players_lookat( VOLUMES.tv_narrative_tsunami_destruction_alley_wreckage_lookat, 20, 50 )], 10);

	PrintNarrative("START - tsunami_destruction_alley_wreckage");
				
	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__wreckage");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__wreckage);

	PrintNarrative("END - tsunami_destruction_alley_wreckage");

end


--[========================================================================[
          Tsunami. destruction alley. wreckage

          After going through the wreckage outside, the only way in is
          on the right, inside the building.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__wreckage = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__wreckage",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(10);
		thisConvo.localVariables.spartan = GetClosestMusketeer(W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__second_fall.localVariables.spartan, 15, 2);
	end,

	sleepBefore = 1,

	lines = {
		
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.spartan == SPARTANS.buck; -- GAMMA_TRANSITION: If locke falls
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Go to the right!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_05200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},		
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.spartan == SPARTANS.vale; -- GAMMA_TRANSITION: If locke falls
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Building on the right! Go!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_03100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.spartan == SPARTANS.tanaka; -- GAMMA_TRANSITION: If locke falls
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Right! Go right! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_04200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.spartan == SPARTANS.locke; -- GAMMA_TRANSITION: If locke falls
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

						character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "On the right. Get inside!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_05700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__covies_in_bu");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__covies_in_bu);
	end,

	localVariables = {
					spartan = nil,
					},
};



--[========================================================================[
          Tsunami. destruction alley. covies in building

          As we enter the building, we hear prometheans presence and
          see the aftermath of a fight against grunts.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__covies_in_bu = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__covies_in_bu",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC;
	end,

	sleepBefore = 4, 

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(50);
	end,

	lines = {
		[1] = {
			character = CHARACTER_OBJECTS.cr_audio_prometheans_01, -- GAMMA_CHARACTER: Grunt02
			text = "Where are you TukTuk?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt02_01000.sound'),
		},
		[2] = {
			character = CHARACTER_OBJECTS.cr_audio_prometheans_01, -- GAMMA_CHARACTER: Grunt01
			text = "The covenant will not...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt01_01000.sound'),
		},
		[3] = {
			character = CHARACTER_OBJECTS.cr_audio_prometheans_01, -- GAMMA_CHARACTER: Soldier01
			text = "Presence eliminated",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_fr_soldier01_00100.sound'),
		},
		[4] = {
			character = CHARACTER_OBJECTS.cr_audio_prometheans_01, -- GAMMA_CHARACTER: Soldier02
			text = "Move to other location",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_fr_soldier02_00100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		
	end,	
};



------------------------------------------------------------------------------------------------------

function tsunami_destruction_alley_pushforward()

	PrintNarrative("WAKE - tsunami_destruction_alley_pushforward");

	local s_line1_played:number = 0;
	local s_line2_played:number = 0;
	local s_line3_played:number = 0;
	local s_line4_played:number = 0;
	
			PrintNarrative("START - tsunami_destruction_alley_pushforward");

			SleepUntil([| b_push_forward_vo_timer == 2], 60);

			if IsGoalActive(w2_tsunami_station.goal_destructionalley) then

						PushForwardVOReset(10 + (s_line1_played * 10));
						
						PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__push_forward_1");
						NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__push_forward_1);

						s_line1_played = s_line1_played + 1;

			end
	
			SleepUntil([| b_push_forward_vo_timer == 2], 60);
				
			if IsGoalActive(w2_tsunami_station.goal_destructionalley) then
							
						PushForwardVOReset(10 + (s_line2_played * 10));
					
						PrintNarrative("START - tsunami_destruction_alley_pushforward - line 2");

						PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__push_forward_2");
						NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__push_forward_2);

						s_line2_played = s_line2_played + 1;

						
			end

			SleepUntil([| b_push_forward_vo_timer == 2], 60);
			
			if (IsGoalActive(w2_tsunami_station.goal_destructionalley) or IsGoalActive(w2_tsunami_station.goal_bldg_interior)) then

						PushForwardVOReset(10 + (s_line3_played * 10));
						
						PrintNarrative("START - tsunami_destruction_alley_pushforward - line 3");

						PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__push_forward_3");
						NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__push_forward_3);

						s_line3_played = s_line3_played + 1;
			end

	PushForwardVOReset();

	PrintNarrative("END - tsunami_destruction_alley_pushforward");

end


--[========================================================================[
          Tsunami. destruction alley. push forward

          If player hasn't move for a while.

          The contextualisation changed a little. Now a cruise will
          crash behind us, some more focused push forward line could be
          more appropriate. And from different player, to maximize
          changes or not being dead.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__push_forward_1 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__push_forward_1",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: locke
			text = "Cruiser coming down! Move!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_09700.sound'),

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
          Tsunami. destruction alley. push forward

          If player hasn't move for a while.

          The contextualisation changed a little. Now a cruise will
          crash behind us, some more focused push forward line could be
          more appropriate. And from different player, to maximize
          changes or not being dead.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__push_forward_2 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__push_forward_2",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Run! Run!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_05800.sound'),

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
          Tsunami. destruction alley. push forward

          If player hasn't move for a while.

          The contextualisation changed a little. Now a cruise will
          crash behind us, some more focused push forward line could be
          more appropriate. And from different player, to maximize
          changes or not being dead.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__push_forward_3 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__push_forward_3",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Come on Osiris! Keep going!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_05800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	
};

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--	Building interior
------------------------------------------------------------------------------------------------------


function tsunami_buildinginterior_load()

	PrintNarrative("LOAD - tsunami_buildinginterior_load");
	
	CreateThread(tsunami_building_enemies);

	PushForwardVOReset(20);	

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__building__Prometheans");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__building__Prometheans);

	b_push_forward_test_combat = true;
	b_push_forward_test_speed = false;
	
	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__building_pus");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__building_pus);


	SleepUntil([| volume_test_players( VOLUMES.tv_pawnreveal_load)], 10);
	SleepUntil([| volume_test_players( VOLUMES.tv_narrative_building_up) or ai_living_count(AI.grunt_crawler_war) == 0], 10);

	sleep_s(0.5);

	if not volume_test_players( VOLUMES.tv_narrative_building_up) then
		sleep_s(0.5);
	end

	CreateMissionThread(guardian_whalesong_destruction_alley_building,OBJECTS.cr_building_guardian, nil);	
	
	sleep_s(2.5);

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__building__guardian_song");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__building__guardian_song);	

end


function tsunami_building_enemies()

	PrintNarrative("WAKE - tsunami_building_enemies");

	SleepUntil([| volume_test_players(VOLUMES.tv_narrative_tsunami_buildinginterior_prometheans)], 10);
	
	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__covies_in_bu2");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__covies_in_bu2);	
	
	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__building_soldiers");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__building_soldiers);
	
	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__building__crawlers_and_grunt");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__building__crawlers_and_grunt);	
	
	PrintNarrative("END - tsunami_building_enemies");
end




--[========================================================================[
          Tsunami. destruction alley. covies in building

          As we enter the building, we hear prometheans presence and
          see the aftermath of a fight against grunts.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__covies_in_bu2 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__covies_in_bu2",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(50);
	end,

	lines = {
		[1] = {
			character = CHARACTER_OBJECTS.cr_audio_prometheans_03, -- GAMMA_CHARACTER: Soldier02
			text = "AAAAaaaahhh!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt02_02200.sound'),

			playDurationAdjustment = 0.8,
		},
		[2] = {
			character = CHARACTER_OBJECTS.cr_audio_prometheans_03, -- GAMMA_CHARACTER: Soldier02
			text = "Evacuate the room!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt03_00200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,
};


--[========================================================================[
          Tsunami. building. Prometheans
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__building__Prometheans = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__building__Prometheans",

	CanStart = function (thisConvo, queue)
		return b_demo_bamf_playing; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 1.5,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return (IsPlayer(SPARTANS.vale) and object_at_distance_and_can_see_object(SPARTANS.vale, OBJECTS.building_soldiers_placement, 17, 50))
						or (not IsPlayer(SPARTANS.vale) and object_at_distance_and_can_see_object(players(), OBJECTS.building_soldiers_placement, 17, 50))
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Did you see that?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_07200.sound'),
			
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,	
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "You think it's Prometheans?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_09600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};


--[========================================================================[
          Tsunami. destruction alley. covies in building

          Approaching the next room, we can hear grunts being killed by
          crawlers
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__building__crawlers_and_grunt = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__building__crawlers_and_grunt",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narrative_building_crawlers_and_grunt);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(30);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__crawlers");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__crawlers);		
	end,

	lines = {
		[1] = {
			character = CHARACTER_OBJECTS.building_crawlers_and_grunt_02, -- GAMMA_CHARACTER: Grunt01
			text = "Eat him! Eat him! I'm don't taste good!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt01_01100.sound'),

			playDurationAdjustment = 0.7,
		},
		[2] = {
			character = CHARACTER_OBJECTS.building_crawlers_and_grunt_02, -- GAMMA_CHARACTER: Grunt02
			text = "What? NO!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt02_01100.sound'),

			playDurationAdjustment = 0.4,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,	
};


--[========================================================================[
          Tsunami. destruction alley. go up

          The only way is up.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__go_up = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__go_up",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narrative_building_up ); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
		thisConvo.localVariables.s_speaker = GetClosestMusketeer(volume_return_players( VOLUMES.tv_narrative_building_up )[1], 10, 0);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If vale is first entering the room with the ramp up
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Up!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_13500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: If vale is first entering the room with the ramp up
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Up!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_08700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: If vale is first entering the room with the ramp up
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Up!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_08300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: If vale is first entering the room with the ramp up
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Up!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_06900.sound'),

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
					s_speaker = nil,
					},
};



--[========================================================================[
          Tsunami. destruction alley. soldiers

          A little further, there are 2 soldiers spawning in and
          disappearing soon after.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__building_soldiers = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__building_soldiers",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.tv_ripple);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(20);
	end,

	lines = {
		[1] = {
			character = CHARACTER_OBJECTS.building_soldiers_placement,
			text = "Building collapsing",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_fr_soldier02_00200.sound'),

			playDurationAdjustment = 0.2,
		},
		[2] = {
			character = CHARACTER_OBJECTS.building_soldiers_placement,
			text = "Evacuate position",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_fr_soldier01_00200.sound'),
		},		
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,	
};







--[========================================================================[
          Tsunami. destruction alley. crawlers

          In that building, it's the first time in the mission we see
          Prometheans -- namely, crawlers.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__crawlers = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__crawlers",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narrative_building_crawlers ) and ai_living_count(AI.grunt_crawler_war) > 0	 
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; 
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(20);
		thisConvo.localVariables.s_speaker = GetClosestMusketeer(volume_return_objects( VOLUMES.tv_narrative_building_crawlers )[1], 10, 0);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Crawlers!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_03300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Crawlers!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_05800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

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
			text = "Crawlers!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_02700.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

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

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Crawlers!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_02300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,

	localVariables = {
					s_speaker = nil
					},
	
};






--[========================================================================[
          Tsunami. destruction alley. building push forward
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__building_pus = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__building_pus",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_timer == 3; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(35);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Building's gonna collapse, let's get out of here!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_07500.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_push_forward_test_speed = true;
	end,

};



--[========================================================================[
          Tsunami. building. guardian song

          When the pltsunami_destruction_alley_building_whale_songs about to go up the
          stairs, we hear the Guardian whale song.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__building__guardian_song = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__building__guardian_song",

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

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "There's another one.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_03800.sound'),

		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "The clock's ticking. Hurry or we miss our ride to the Master Chief.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_11100.sound'),

			playDurationAdjustment = 0.5,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();		
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__covies_in_bu3");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__covies_in_bu3);
	end,
};



--[========================================================================[
          Tsunami. destruction alley. covies in building

          As we enter the building, we hear prometheans presence and
          see the aftermath of a fight against grunts.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__covies_in_bu3 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__destruction_alley__covies_in_bu3",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(50);
	end,

	sleepBefore = 2,

	lines = {
		[1] = {
			character = CHARACTER_OBJECTS.building_crawlers_and_grunt, -- GAMMA_CHARACTER: Soldier02
			text = "Our Guardian will leave soon! We all gonna diiiiie!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt01_01500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__building__crawlers_and_grunt_2");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__building__crawlers_and_grunt_2);
	end,

	
};




--[========================================================================[
          Tsunami. destruction alley. covies in building

          Approaching the next room, we can hear grunts being killed by
          crawlers
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__building__crawlers_and_grunt_2 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__building__crawlers_and_grunt_2",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narrative_building_crawlers_and_grunt_2);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC;
	end,
	
	OnInitialize = function(thisConvo, queue)
		PushForwardVOReset(90);
		tsunami_chatter_on = false;
	end,

	sleepBefore = 30,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,

	lines = {
		[1] = {
			character = CHARACTER_OBJECTS.building_crawlers_and_grunt,
			text = "Are they gone?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt01_01200.sound'),
		},
		[2] = {
			character = CHARACTER_OBJECTS.building_crawlers_and_grunt,
			text = "Shhh! You're going to get us killed!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt02_01200.sound'),
		},
		[3] = {
			character = CHARACTER_OBJECTS.building_crawlers_and_grunt,
			text = "The building is going down! We can't stay here!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt01_01300.sound'),
		},
		[4] = {
			character = CHARACTER_OBJECTS.building_crawlers_and_grunt,
			text = "You go. I stay here! Under that sink!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt02_01300.sound'),
		},
		[5] = {
			character = CHARACTER_OBJECTS.building_crawlers_and_grunt,
			text = "This is my time, I know it. We can make a different ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt01_01400.sound'),
		},
		[6] = {
			sleepBefore = 1,

			character = CHARACTER_OBJECTS.building_crawlers_and_grunt,
			text = "I have to go... you understand",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt01_02500.sound'),
		},
		[7] = {			
			sleepBefore = 0.5,

			character = CHARACTER_OBJECTS.building_crawlers_and_grunt,
			text = "Yes... go...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt02_02300.sound'),
		},
		[8] = {
			sleepBefore = 1,

			character = CHARACTER_OBJECTS.building_crawlers_and_grunt,
			text = "Pip",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt01_02600.sound'),
		},
		[9] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return false;
			end,

			sleepBefore = 0.5,

			character = CHARACTER_OBJECTS.building_crawlers_and_grunt,
			text = "Yes?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt02_02400.sound'),
		},
		[10] = {
			sleepBefore = 0.5,

			character = CHARACTER_OBJECTS.building_crawlers_and_grunt,
			text = "You're my best friend...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt02_02500.sound'),
		},
		[11] = {
			sleepBefore = 0.5,

			character = CHARACTER_OBJECTS.building_crawlers_and_grunt,
			text = "And you're my best friend Pup.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt01_02700.sound'),
		},
		[12] = {
			sleepBefore = 1,
			character = CHARACTER_OBJECTS.building_crawlers_and_grunt,
			text = "Now go!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_grunt02_02600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		tsunami_chatter_on = true;
	end,
};

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--	Final Fight
------------------------------------------------------------------------------------------------------


function tsunami_finalfight_load()

	PrintNarrative("LOAD - tsunami_finalfight_load");

	b_push_forward_test_speed = true;
		
	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__final_fight__pre_arbiter");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__final_fight__pre_arbiter);

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__final_fight__arbiter");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__final_fight__arbiter);

	SleepUntil ([|	volume_test_players( VOLUMES.tv_narrative_finalfight_whalesong ) ], 10);

	b_finalfight_guardian_singing = true;

end


--[========================================================================[
          Tsunami. final fight. arbiter

          The players arrive in the last section where there is a fight
          underway.

          We can hear Arbiter fighting outside
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__final_fight__pre_arbiter = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__final_fight__pre_arbiter",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(30);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not volume_test_players( VOLUMES.tv_narrative_tsunami_finalfight_arbiter ); -- GAMMA_TRANSITION: If vale looks at Arbiter first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				b_arbiter_kinght_melee_emote = true;
			end,

			character = CHARACTER_OBJECTS.cr_arbiter_finalfight, -- GAMMA_CHARACTER: Arbiter
			text = "[Emote swinging his Energy Sword]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_arbiter_03500.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				b_arbiter_kinght_melee_emote = false;
			end,

			sleepAfter = 1,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not volume_test_players( VOLUMES.tv_narrative_tsunami_finalfight_arbiter ); -- GAMMA_TRANSITION: If vale looks at Arbiter first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				b_arbiter_kinght_melee_emote = true;
			end,

			character = CHARACTER_OBJECTS.cr_arbiter_finalfight, -- GAMMA_CHARACTER: Arbiter
			text = "[Another emote swinging his Energy Sword]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_arbiter_03600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				b_arbiter_kinght_melee_emote = false;
			end,

			sleepAfter = 0.5,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not volume_test_players( VOLUMES.tv_narrative_tsunami_finalfight_arbiter ); -- GAMMA_TRANSITION: If vale looks at Arbiter first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				b_arbiter_kinght_melee_emote = true;
			end,

			character = CHARACTER_OBJECTS.cr_arbiter_finalfight, -- GAMMA_CHARACTER: Arbiter
			text = "[Another emote swinging his Energy Sword]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_arbiter_03700.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				b_arbiter_kinght_melee_emote = false;
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,	
};


--[========================================================================[
          Tsunami. final fight. arbiter

          The players arrive in the last section where there is a fight
          underway.

          Just outside, we see Arbiter killing a knight.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__final_fight__arbiter = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__final_fight__arbiter",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narrative_tsunami_finalfight_arbiter ) and not b_arbiter_kinght_melee_emote;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PrintNarrative("INTERRUPT - W2TsunamiTitanAtTsunami_Tsunami__final_fight__pre_arbiter");
		NarrativeQueue.EndConversationEarly(W2TsunamiTitanAtTsunami_Tsunami__final_fight__pre_arbiter);
		PushForwardVOReset(30);
	end,

	lines = {
		[1] = {
			forcePlayIn3D = true,

			character = AI.sq_ff_arbiter,
			text = "For Sanghelios!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_arbiter_03800.sound'),

			playDurationAdjustment = 0.7,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object( VOLUMES.tv_narrative_tsunami_finalfight_arbiter, SPARTANS.vale ); -- GAMMA_TRANSITION: If vale looks at Arbiter first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Arbiter!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_02400.sound'),

			playDurationAdjustment = 0.5,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object( VOLUMES.tv_narrative_tsunami_finalfight_arbiter, SPARTANS.buck ); -- GAMMA_TRANSITION: If buck looks at Arbiter first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Arbiter!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_03400.sound'),

			playDurationAdjustment = 0.5,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object( VOLUMES.tv_narrative_tsunami_finalfight_arbiter, SPARTANS.tanaka ); -- GAMMA_TRANSITION: If tanaka looks at Arbiter first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Arbiter!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_02800.sound'),

			playDurationAdjustment = 0.5,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object( VOLUMES.tv_narrative_tsunami_finalfight_arbiter, SPARTANS.locke ); -- GAMMA_TRANSITION: If locke looks at Arbiter first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Arbiter!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_05900.sound'),

			playDurationAdjustment = 0.5,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},		
		[6] = {
			sleepBefore = 0.7,

			forcePlayIn3D = true,

			character = AI.sq_ff_arbiter.arbiter,
			text = "Spartans...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_arbiter_03100.sound'),
		},
		[7] = {
			forcePlayIn3D = true,

			character = AI.sq_ff_arbiter,
			text = "The last of the Covenant's defenses have fallen. Sunaion is ours!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_arbiter_00600.sound'),

			playDurationAdjustment = 0.8,

		},
	},

	OnFinish = function (thisConvo, queue)	
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__final_fight__arbiter_2");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__final_fight__arbiter_2);
	end,

	
};



--[========================================================================[
          Tsunami. final fight. arbiter

          The players arrive in the last section where there is a fight
          underway.

          Just outside, we see Arbiter killing a knight.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__final_fight__arbiter_2 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__final_fight__arbiter_2",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.gr_ff_greeters_all) > 0;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(20);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck,
			text = "Prometheans incoming!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_06400.sound'),

			playDurationAdjustment = 0.95,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "We're almost to the Guardian. They can't stop us now.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_12300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[3] = {
			forcePlayIn3D = true,

			character = AI.sq_ff_arbiter,
			text = "Let them come! I fight by your side, Spartans. To the last.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_cv_arbiter_03200.sound'),
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Clear a path. Get onboard the Guardian before it leaves!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_14200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__final_fight__guardian_is_singin");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__final_fight__guardian_is_singin);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__final_fight__push_forward_in_co");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__final_fight__push_forward_in_co);
	end,	
};



--[========================================================================[
          Tsunami. final fight. push forward in combat
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__final_fight__push_forward_in_co = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__final_fight__push_forward_in_co",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narrative_finalfight_push) and IsSpartanAbleToSpeak(SPARTANS.locke); -- GAMMA_CONDITION
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

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Keep pushing Osiris, We're almost the Guardian!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_13800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};


--[========================================================================[
          Tsunami. final fight. guardian is singing
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__final_fight__guardian_is_singin = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__final_fight__guardian_is_singin",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return b_finalfight_guardian_singing and (IsSpartanAbleToSpeak(SPARTANS.tanaka) and IsSpartanAbleToSpeak(SPARTANS.buck) and IsSpartanAbleToSpeak(SPARTANS.locke))
				or (IsSpartanAbleToSpeak(SPARTANS.tanaka) and b_finalfight_guardian_singing_2);
	end,
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		PushForwardVOReset();
		CreateMissionThread(guardian_whalesong_finalfight,OBJECTS.cr_guardian_finalfight_lookat, "fx_head_front");
	end,

	sleepBefore = 3,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Third blast.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_07500.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Guardian's gonna leave any minute now!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_08800.sound'),
		},	
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		CreateThread(Tsunami__final_fight__guardian_look_at);
	end,
};


function Tsunami__final_fight__guardian_look_at()
local speaker:object = nil;
local s_timer:number = 0;

repeat	
	--SleepUntil ([|	], 1);
	sleep_s(0.1);
	s_timer = s_timer + 1;
	speaker = spartan_look_at_object(players(), OBJECTS.cr_guardian_finalfight_lookat, 100, 30, 0.1, 2);

until speaker ~= nil or s_timer > 4

if speaker == nil then
	speaker = GetClosestMusketeer(OBJECTS.cr_guardian_finalfight_lookat, 1000, 2);
elseif speaker == SPARTANS.locke then
	speaker = GetClosestMusketeer(SPARTANS.locke, 50, 2);
end

W2TsunamiTitanAtTsunami_Tsunami__final_fight__guardian_look_at.localVariables.s_speaker = speaker;
PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__final_fight__guardian_look_at");
NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__final_fight__guardian_look_at);

end


--[========================================================================[
          Tsunami. final fight. guardian look at
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__final_fight__guardian_look_at = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__final_fight__guardian_look_at",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return IsSpartanAbleToSpeak(thisConvo.localVariables.s_speaker);
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
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: Answers all
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "How are we going to get all the way over there?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_00500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 4; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: Answers all
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "How are we going to get all the way over there?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_01900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 4; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: Answers all
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VaLE
			text = "How are we going to get all the way over there?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_04300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 4; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.6,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: loCKE
			text = "All that matters is the Guardian hasn't left yet. There's still time.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_12000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {
					s_speaker = nil,
					},
};


------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--	Cavalier
------------------------------------------------------------------------------------------------------


function tsunami_finalfight_cavalier()

	PrintNarrative("LOAD - tsunami_finalfight_cavalier");

	PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_arrival");
	NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_arrival);

	PushForwardVOReset();

end





--[========================================================================[
          Tsunami. final fight. warden arrival

          The last enemy between Osiris and the Guardian is the Warden.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_arrival = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_arrival",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_ww3_cavalier) > 0; -- GAMMA_CONDITION
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
			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_arrival_2");
				NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_arrival_2);
			end,

			forcePlayIn3D = true,

			moniker = "WardenEternal",	

			character = AI.sq_ww3_cavalier, -- GAMMA_CHARACTER: WaRDENeternal
			text = "I am the Warden Eternal. I stand in defense of... Cortana... You again. Here?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_fr_wardeneternal_00600.sound'),

			playDurationAdjustment = 0.8,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "How the hell is that thing here? We killed it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_03700.sound'),
		},		
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Take him out Osiris!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_06400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		--	OBJECTIVE TEXT
		CreateMissionThread(title_objective_warden);

		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_1");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_1);

		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_health_20");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_health_20);

		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_health_0");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_health_0);
		
	end,
};



--[========================================================================[
          Tsunami. final fight. warden arrival

          The last enemy between Osiris and the Guardian is the Warden.
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_arrival_2 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_arrival_2",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			sleepBefore = 4.3,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Impossible.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_03100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,	
};

--[========================================================================[
          Tsunami. final fight. warden

          During the encounter with the Warden, he will say things.

          Let's talk through this one. We should time what he says to
          key stages of the fight. I'd like him to be able to drop
          hints about what's been happening on Genesis w/Chief and
          Cortana. No, I don't have good examples of that right now.
          Just stub in:
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_1 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_1",

	CanStart = function (thisConvo, queue)
		return object_get_health( ai_get_object(AI.sq_ww3_cavalier) ) <= 0.9; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return object_get_health( ai_get_object(AI.sq_ww3_cavalier) ) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			forcePlayIn3D = true,

			moniker = "WardenEternal",	

			character = AI.sq_ww3_cavalier, -- GAMMA_CHARACTER: WaRDENeternal
			text = "You are denied the Guardian and access to Genesis. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_fr_wardeneternal_00700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_2");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_2);
	end,	
};


--[========================================================================[
          Tsunami. final fight. warden
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_2 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_2",

	CanStart = function (thisConvo, queue)
		return object_get_health( ai_get_object(AI.sq_ww3_cavalier) ) <= 0.8; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return object_get_health( ai_get_object(AI.sq_ww3_cavalier) ) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			forcePlayIn3D = true,

			moniker = "WardenEternal",	

			character = AI.sq_ww3_cavalier, -- GAMMA_CHARACTER: WaRDENeternal
			text = "Your conquest ends here, on this fortress world, far from the luminous sun of her strength.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_fr_wardeneternal_00100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_3");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_3);
	end,	
};


--[========================================================================[
          Tsunami. final fight. warden
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_3 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_3",

	CanStart = function (thisConvo, queue)
		return object_get_health( ai_get_object(AI.sq_ww3_cavalier) ) <= 0.6; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return object_get_health( ai_get_object(AI.sq_ww3_cavalier) ) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			forcePlayIn3D = true,

			moniker = "WardenEternal",	

			character = AI.sq_ww3_cavalier, -- GAMMA_CHARACTER: WaRDENeternal
			text = "Humanity stands as the greatest threat in the galaxy and I will do my part to end that threat.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_fr_wardeneternal_00200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__final_fight_osiris");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__final_fight_osiris);
		
	end,	
};



--[========================================================================[
          Tsunami. final fight. warden
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__final_fight_osiris = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__final_fight_osiris",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return IsSpartanAbleToSpeak(SPARTANS.tanaka) and IsSpartanAbleToSpeak(SPARTANS.locke) and ai_living_count(AI.sq_ww3_cavalier) == 1 and object_get_health( ai_get_object(AI.sq_ww3_cavalier) ) > 0.2;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		CreateMissionThread(guardian_whalesong_finalfight,OBJECTS.cr_guardian_finalfight_lookat, "fx_head_front");
		PushForwardVOReset();		
	end,

	sleepBefore = 3,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_ww3_cavalier) == 1;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Damnit! We need to get on that thing!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_08500.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_ww3_cavalier) == 1 and object_get_health( ai_get_object(AI.sq_ww3_cavalier) ) > 0.2;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Deal with the Warden first! Focus fire Osiris!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_13900.sound'),

			playDurationAdjustment = 0.8,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_4");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_4);
	end,	
};


--[========================================================================[
          Tsunami. final fight. warden
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_4 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_4",

	CanStart = function (thisConvo, queue)
		return object_get_health( ai_get_object(AI.sq_ww3_cavalier) ) <= 0.45; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return object_get_health( ai_get_object(AI.sq_ww3_cavalier) ) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			forcePlayIn3D = true,

			moniker = "WardenEternal",	

			character = AI.sq_ww3_cavalier, -- GAMMA_CHARACTER: WaRDENeternal
			text = "You are barbarians, fighting against what? The promise of peace and prosperity. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_fr_wardeneternal_00300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_5");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_5);
	end,	
};


--[========================================================================[
          Tsunami. final fight. warden
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_5 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_5",

	CanStart = function (thisConvo, queue)
		return object_get_health( ai_get_object(AI.sq_ww3_cavalier) ) <= 0.35; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return object_get_health( ai_get_object(AI.sq_ww3_cavalier) ) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			forcePlayIn3D = true,

			moniker = "WardenEternal",	

			character = AI.sq_ww3_cavalier, -- GAMMA_CHARACTER: WaRDENeternal
			text = "117 falls, and you with him. Cortana's plans will not go unfulfilled.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_fr_wardeneternal_00400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,	
};


--[========================================================================[
          Tsunami. final fight. warden
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_health_20 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_health_20",

	CanStart = function (thisConvo, queue)
		return object_get_health( ai_get_object(AI.sq_ww3_cavalier) ) <= 0.2; -- GAMMA_CONDITION
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
				return object_get_health( ai_get_object(AI.sq_ww3_cavalier) ) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			forcePlayIn3D = true,

			moniker = "WardenEternal",	

			character = AI.sq_ww3_cavalier, -- GAMMA_CHARACTER: WaRDENeternal
			text = "You have defeated me now, but I will not let you undo Cortana's plans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_fr_wardeneternal_00800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};


--[========================================================================[
          Tsunami. final fight. warden
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_health_0 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_health_0",

	CanStart = function (thisConvo, queue)
		return object_get_health( ai_get_object(AI.sq_ww3_cavalier) ) <= 0; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		NarrativeQueue.InterruptConversation(W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_1);
		NarrativeQueue.InterruptConversation(W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_2);
		NarrativeQueue.InterruptConversation(W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_3);
		NarrativeQueue.InterruptConversation(W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_4);
		NarrativeQueue.InterruptConversation(W2TsunamiTitanAtTsunami_Tsunami__final_fight__warden_5);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WardenEternal",	

			--character = nil, --AI.sq_ww3_cavalier, -- GAMMA_CHARACTER: WaRDENeternal
			text = "No! You cannot reach Genesis!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_fr_wardeneternal_00900.sound'),

			playDurationAdjustment = 0.95,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__final_fight__after_warden_s_dea");
		NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__final_fight__after_warden_s_dea);
		hud_hide_radio_transmission_hud();
	end,
};




--[========================================================================[
          Tsunami. final fight. after warden's death
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__final_fight__after_warden_s_dea = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__final_fight__after_warden_s_dea",

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

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Locke? Do you know anything about Genesis?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_06300.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: locke
			text = "No. But that's where we're going.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_13600.sound'),
		},		
	},

	sleepAfter = 2,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};




------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------



function tsunami_pushforward()

	PrintNarrative("WAKE - tsunami_pushforward");

	repeat

			--	SPECIFIC

			PrintNarrative("START - tsunami_pushforward");

			SleepUntil([| b_push_forward_vo_timer == 0], 30);

			if not NarrativeQueue.HasConversationFinished(W2TsunamiTitanAtTsunami_Tsunami__push_forward_8) and (((IsSpartanAbleToSpeak(SPARTANS.locke) and IsGoalActive(w2_tsunami_station.goal_burgertown) and b_shrike_1 and b_players_saw_burgertown_turret ) or (IsSpartanAbleToSpeak(SPARTANS.locke) and IsGoalActive(w2_tsunami_station.goal_tangletown) and b_shrike_2 and b_players_saw_tangletown_turret))) then

						PrintNarrative("START - tsunami_pushforward - line 1");
				
						PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__push_forward_8");
						NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__push_forward_8);

						PushForwardVOReset();

			end
	
			SleepUntil([| b_push_forward_vo_timer == 0], 30);

			if not NarrativeQueue.HasConversationFinished(W2TsunamiTitanAtTsunami_Tsunami__push_forward_7) and (((IsSpartanAbleToSpeak(SPARTANS.buck) and IsGoalActive(w2_tsunami_station.goal_burgertown) and  b_shrike_1 and b_players_saw_burgertown_turret) or (IsSpartanAbleToSpeak(SPARTANS.buck) and IsGoalActive(w2_tsunami_station.goal_tangletown) and b_shrike_2 and b_players_saw_tangletown_turret) or (IsGoalActive(w2_tsunami_station.goal_turrettown) and v_shrike_tally < 5) )) then
						
						PushForwardVOReset();

						PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__push_forward_7");
						NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__push_forward_7);						

			end
	
			SleepUntil([| b_push_forward_vo_timer == 0], 30);

			if not NarrativeQueue.HasConversationFinished(W2TsunamiTitanAtTsunami_Tsunami__push_forward_6) and (((IsSpartanAbleToSpeak(SPARTANS.tanaka) and IsGoalActive(w2_tsunami_station.goal_burgertown) and  b_shrike_1 and b_players_saw_burgertown_turret) or (IsSpartanAbleToSpeak(SPARTANS.tanaka) and IsGoalActive(w2_tsunami_station.goal_tangletown) and  b_shrike_2 and b_players_saw_tangletown_turret) or (IsGoalActive(w2_tsunami_station.goal_turrettown) and v_shrike_tally < 5) )) then
				
						PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__push_forward_6");
						NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__push_forward_6);

						PushForwardVOReset();

			end
				
			--	GENERAL

			SleepUntil([| b_push_forward_vo_timer == 0], 30);
	
			if not NarrativeQueue.HasConversationFinished(W2TsunamiTitanAtTsunami_Tsunami__push_forward_1) and (IsSpartanAbleToSpeak(SPARTANS.vale) and not (IsGoalActive(w2_tsunami_station.goal_bldg_interior) or IsGoalActive(w2_tsunami_station.goal_destructionalley))) then

						PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__push_forward_1");
						NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__push_forward_1);

						PushForwardVOReset();
			end			
	
			SleepUntil([| b_push_forward_vo_timer == 0], 30);
	
			if not NarrativeQueue.HasConversationFinished(W2TsunamiTitanAtTsunami_Tsunami__push_forward_2) and (IsSpartanAbleToSpeak(SPARTANS.buck) and not IsGoalActive(w2_tsunami_station.goal_destructionalley)) then
						
						PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__push_forward_2");
						NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__push_forward_2);
						
						PushForwardVOReset();
			end

			SleepUntil([| b_push_forward_vo_timer == 0], 30);
	
			if not NarrativeQueue.HasConversationFinished(W2TsunamiTitanAtTsunami_Tsunami__push_forward_2) and IsSpartanAbleToSpeak(SPARTANS.buck) then

						PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__push_forward_3");
						NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__push_forward_3);

						PushForwardVOReset();

			end
	
			SleepUntil([| b_push_forward_vo_timer == 0], 30);
	
			if not NarrativeQueue.HasConversationFinished(W2TsunamiTitanAtTsunami_Tsunami__push_forward_2) and IsSpartanAbleToSpeak(SPARTANS.vale) then

						PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__push_forward_4");
						NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__push_forward_4);

						PushForwardVOReset();

			end

			SleepUntil([| b_push_forward_vo_timer == 0], 30);
	
			if not NarrativeQueue.HasConversationFinished(W2TsunamiTitanAtTsunami_Tsunami__push_forward_2) and IsSpartanAbleToSpeak(SPARTANS.buck) and (IsGoalActive(w2_tsunami_station.goal_turrettown) or IsGoalActive(w2_tsunami_station.goal_trans_underbelly) or IsGoalActive(w2_tsunami_station.goal_underbelly_1) or IsGoalActive(w2_tsunami_station.goal_underbelly_2) or IsGoalActive(w2_tsunami_station.goal_trans_arcade) or IsGoalActive(w2_tsunami_station.goal_arcade) or IsGoalActive(w2_tsunami_station.goal_trans_final) or IsGoalActive(w2_tsunami_station.goal_finalfight)) then

						PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__push_forward_9");
						NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__push_forward_9);

						PushForwardVOReset();

			end

			PrintNarrative("END - trials_pushforward");

			b_push_forward_vo_timer_default = b_push_forward_vo_timer_default + (b_push_forward_vo_timer_default/2);

			PushForwardVOReset();

	until not b_push_forward_vo_active

end



--[========================================================================[
          Tsunami. push forward
--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__push_forward_1 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__push_forward_1",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vaLE
			text = "We should keep moving. The Guardian could be ready to go any time. Don't want to miss our ride to Chief.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_04200.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	
};



global W2TsunamiTitanAtTsunami_Tsunami__push_forward_2 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__push_forward_2",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "That Guardian's not going to wait for us. We should get moving if we want to get to Chief.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_03100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	
};



global W2TsunamiTitanAtTsunami_Tsunami__push_forward_3 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__push_forward_3",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "That Guardian's not waiting. Let's hurry.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_05600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	
};



global W2TsunamiTitanAtTsunami_Tsunami__push_forward_4 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__push_forward_4",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "We can't miss the Guardian. Let's get going.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_03500.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,	
};

global W2TsunamiTitanAtTsunami_Tsunami__push_forward_6 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__push_forward_6",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Could use the Artemis to find the air defense power source.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_07300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,	
};



global W2TsunamiTitanAtTsunami_Tsunami__push_forward_7 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__push_forward_7",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "We could track the turret's power core.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_05500.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	
};


global W2TsunamiTitanAtTsunami_Tsunami__push_forward_8 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__push_forward_8",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Take those air defenses down, Osiris.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_01400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	
};

global W2TsunamiTitanAtTsunami_Tsunami__push_forward_9 = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__push_forward_9",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Guardian is about to leave, we can't just sit around!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_05900.sound'),

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
-- =================================================================================================     
--	CHATTER
-- =================================================================================================          
-- =================================================================================================    


function tsunami_four_players_combat_check()

	PrintNarrative("START - tsunami_four_players_combat_check");

	repeat

		SleepUntil([| list_count(players()) == 4], 1800);

		repeat 

			SleepUntil([| not b_collectible_used and ((b_push_forward_vo_counrdown_on > 20 and not IsSpartanInCombat()) or list_count(players()) ~= 4)], 30);

			if list_count(players()) == 4 then
				tsunami_is_there_enemy_nearby(30);

				if tsunami_is_there_enemy_nearby_result then
					PushForwardVOReset();
				end
			end

		until not b_push_forward_vo_active or list_count(players()) ~= 4

	until not IsMissionActive(w2_tsunami_station)

	PrintNarrative("END - tsunami_four_players_combat_check");

end

function tsunami_is_there_enemy_nearby(distance:number)

	PrintNarrative("START - tsunami_is_there_enemy_nearby");

	if	TestClosestEnemyDistance(AI.gr_burgertown_all, distance) or	
		TestClosestEnemyDistance(AI.gr_doorgroup_02, distance) or
		TestClosestEnemyDistance(AI.gr_all_finalfight, distance) or
		TestClosestEnemyDistance(AI.gr_arcade_all, distance) or
		TestClosestEnemyDistance(AI.gr_dest_int_all, distance) or
		TestClosestEnemyDistance(AI.gr_tsulocke_all, distance) or
		TestClosestEnemyDistance(AI.gr_turret_all, distance) or		
		TestClosestEnemyDistance(AI.gr_underbelly2_all, distance) or		
		TestClosestEnemyDistance(AI.gr_underbelly_all, distance) or				
		TestClosestEnemyDistance(AI.gr_0_mall_all, distance) or
		TestClosestEnemyDistance(AI.sg_tangle_reinforcements, distance) or
		TestClosestEnemyDistance(AI.gr_turret0_all, distance) then		
				tsunami_is_there_enemy_nearby_result = true;
				PrintNarrative("tsunami_is_there_enemy_nearby_result = true;");
	else
				tsunami_is_there_enemy_nearby_result = false;
				PrintNarrative("tsunami_is_there_enemy_nearby_result = false;");
	end

	PrintNarrative("END - tsunami_is_there_enemy_nearby");

end

-----------------------------------------------------------------


function tsunami_chatter()
local s_chatter_02:boolean = false

	PrintNarrative("WAKE - tsunami_chatter");

	repeat
								
				repeat
					sleep_s(5);
					SleepUntil([| b_push_forward_vo_counrdown_on > 45 and not b_collectible_used and tsunami_chatter_on and not IsSpartanInCombat() and IsSpartanAbleToSpeak(SPARTANS.buck) and IsSpartanAbleToSpeak(SPARTANS.vale) and IsSpartanAbleToSpeak(SPARTANS.locke) and IsSpartanAbleToSpeak(SPARTANS.tanaka)], 30);

					tsunami_is_there_enemy_nearby(40);
				until not tsunami_is_there_enemy_nearby_result

				
				if not ( IsGoalActive(w2_tsunami_station.goal_destructionalley) or IsGoalActive(w2_tsunami_station.goal_bldg_interior) or IsGoalActive(w2_tsunami_station.goal_trans_final) or IsGoalActive(w2_tsunami_station.goal_finalfight) ) 
					and not NarrativeQueue.HasConversationFinished(W2TsunamiTitanAtTsunami_Tsunami__push_forward_4b) then
				
							PrintNarrative("QUEUE - W2TsunamiTitanAtTsunami_Tsunami__push_forward_4b");
							NarrativeQueue.QueueConversation(W2TsunamiTitanAtTsunami_Tsunami__push_forward_4b);

							PushForwardVOReset();

							s_chatter_02 = true;
				end		

				sleep_s(2);

	until s_chatter_02 

	PrintNarrative("END - tsunami_chatter");

end



--[========================================================================[
 	  

--]========================================================================]
global W2TsunamiTitanAtTsunami_Tsunami__push_forward_4b = {
	name = "W2TsunamiTitanAtTsunami_Tsunami__push_forward_4b",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					CreateThread(tsunami_is_there_enemy_nearby, 30);
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "If we miss this Guardian, what's plan B for catching up to Chief?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_buck_02500.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not tsunami_is_there_enemy_nearby_result and not IsSpartanInCombat();
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					CreateThread(tsunami_is_there_enemy_nearby, 30);
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "This is plan B. It's the only Guardian we know of. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_locke_04200.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER				
				return 0;
			end,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not tsunami_is_there_enemy_nearby_result and not IsSpartanInCombat();
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					CreateThread(tsunami_is_there_enemy_nearby, 30);
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "If we miss it, we'll just have to hope the Master Chief can stop Cortana from doing any more harm.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_vale_01800.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER				
				return 0;
			end,
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not tsunami_is_there_enemy_nearby_result and not IsSpartanInCombat();
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					CreateThread(tsunami_is_there_enemy_nearby, 30);
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Less talking and more running then.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2tsunamititanattsunami\001_vo_scr_w2tsunamititanattsunami_un_tanaka_00700.sound'),
		},
--           UI: OBJECTIVE TEXT - Reach the Guardian

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	
};


----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

function guardian_whalesong_destruction_alley(guardian:object, marker:string)
print('PASS 1');
	sound_impulse_start_marker_server(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_guardian_whalesong_tsunami_destructionalley.sound'), guardian, marker, 1);
end

function guardian_whalesong_destruction_alley_building(guardian:object, marker:string)
print('PASS 1');
	sound_impulse_start_marker_server(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_guardian_whalesong_tsunami_destructionalleybuilding.sound'), guardian, marker, 1);
end

function guardian_whalesong_finalfight(guardian:object, marker:string)
print('PASS 1');
	sound_impulse_start_marker_server(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_guardian_whalesong_tsunami_finalfight.sound'), guardian, marker, 1);
end

---------------------------------------

function sound_impulse_start_marker_server(soundTag:tag, theObject:object, theMarker:string, theScale:number):void
print('PASS 2');
	RunClientScript("sound_impulse_start_marker_client", soundTag, theObject, theMarker, theScale);
end



-- =================================================================================================          
-- =================================================================================================     

-- =================================================================================================          
-- =================================================================================================     

--## CLIENT

----------------------------------------------------------------------------------------------------



function remoteClient.sound_impulse_start_marker_client(soundTag:tag, theObject:object, theMarker:string, theScale:number)
print('PASS 4');

	if object_index_valid(theObject) then
		print('PASS 4 - Object present');
		sound_impulse_start_marker(soundTag, theObject, theMarker, theScale);
	else
		print('PASS 4 - Object not present');
		sound_impulse_start( soundTag, nil, theScale );
	end
end

----------------------------------------------------------------------------------------------------





-----------------------------------------------------------

--function remoteClient.tsunami_banshees_shake()
	--if(random_range(1,2)==1)then
		--RunClientScript ("start_global_rumble_shake_small", 1);
	--else
		--RunClientScript ("start_global_rumble_shake_medium", 1);
	--end
--end


function remoteClient.banshee_explosion_01()
	-- play explosions
	print("explosions");
	--effect_new( TAG('fx\library\sandbox\explosions\covenant_explosion_huge\covenant_explosion_huge.effect'), OBJECTS.effectplacement )

end



----------------------------------------------------------------------------------------------------

--	PIP

----------------------------------------------------------------------------------------------------


function remoteClient.tsunami_elevator_pip()
	
	print("play Elevator Arbiter PIP")
	hud_play_pip_from_tag(TAG('bink\campaign\h5_pip_proxy_60.bink'));
end

