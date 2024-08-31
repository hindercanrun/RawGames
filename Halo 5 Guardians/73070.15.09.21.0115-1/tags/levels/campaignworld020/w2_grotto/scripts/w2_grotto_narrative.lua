--## SERVER
--   _____ _____   ____ _______ _______ ____      _   _          _____  _____        _______ _______      ________ 
--  / ____|  __ \ / __ |__   __|__   __/ __ \    | \ | |   /\   |  __ \|  __ \    /\|__   __|_   _\ \    / |  ____|
-- | |  __| |__) | |  | | | |     | | | |  | |   |  \| |  /  \  | |__) | |__) |  /  \  | |    | |  \ \  / /| |__   
-- | | |_ |  _  /| |  | | | |     | | | |  | |   | . ` | / /\ \ |  _  /|  _  /  / /\ \ | |    | |   \ \/ / |  __|  
-- | |__| | | \ \| |__| | | |     | | | |__| |   | |\  |/ ____ \| | \ \| | \ \ / ____ \| |   _| |_   \  /  | |____ 
--  \_____|_|  \_\\____/  |_|     |_|  \____/    |_| \_/_/    \_|_|  \_|_|  \_/_/    \_|_|  |_____|   \/   |______|



-- =================================================================================================
-- *** GLOBALS ***
-- =================================================================================================

	global b_test_narrative=false;
	global g_grotto_Keyhole_FirstSpartanSeingPhantoms:object = nil;
	global grotto_sinkhole_snipers_squad_name:string = "";

	global b_critical_dialogue_on:boolean = false;

	global grotto_player_in_courtyard:boolean = false;

	global g_screentext_grotto_stub:thread = nil;

	
	global b_player_entered_sinkhole:boolean = false;
	global b_sinkhole_reach_top:boolean = false;
	
	global b_armory_grunt_alerted:boolean = false;
	global b_armory_floor_alerted:boolean = false;

	global b_player_exiting_dead_bodies:boolean = false;

	global b_player_is_in_corridor:boolean = false;

	global b_keyhole_end_of_flyby:boolean = false;

	global b_mantis_01:object = nil;
	global b_mantis_02:object = nil;
	
	global b_courtyard_entrance_grunt_flee:boolean = false;

	global b_found_arbiter:boolean = false;

	global b_vig_elite_onstairs_play:boolean = false;
	global b_vig_elite_pointing_play:boolean = false;

	global b_grotto_falls_grunt_saw_player:boolean = false;

	global b_grotto_player_reached_balcony:boolean = false;

	global b_player_saw_keyhole_phantoms:boolean = false;

	global b_courtyard_a_door_is_opening:boolean = false;

	global b_grotto_armory_door01_open:boolean = false;
	global b_grotto_armory_door02_open:boolean = false;

	global b_armory_grunt_speaking:boolean = false;	
	global b_armory_elite_speaking:boolean = false;	
	
	global b_ghost_armory_was_pinged:boolean = false;	

	global b_courtyard_a_player_passed_half:boolean = false;	

	global b_courtyard_a_player_in_corridor:boolean = false;	
	
	global grotto_is_there_enemy_nearby_result:boolean = false;	
	
	global b_landing_sunaion_safe:boolean = false;	

	global b_gatehouse_door_opening:boolean = false;	
	
	global b_airlock_arby_elite_in_place:boolean = false;	

	global b_first_mural_seen:boolean = false;

	global b_no_arb_emote:boolean = false;

	global g_timer_player_see_arbiter:number = 0;
	
	global b_keyhole_ammo_pinged:boolean = false;
	
	global b_arbiter_melee_end:boolean = false;
	
	
-- =================================================================================================
-- *** MAIN ***
-- =================================================================================================

function grotto_narrative_startup()

	print("*************  GROTTO NARRATIVE LOADED ******************");
	g_display_narrative_debug_info = true;

	PrintNarrative("Killing Narrative Queue");
	NarrativeQueue.Kill();

	SleepUntil([| list_count(players()) ~= 0], 10);

	b_push_forward_vo_timer_default = 90;

--	Force display Temp Text from TTS (Subtitles)
--	dialog_line_temp_blurb_force_set(true);

	CreateMissionThread(PushForwardVO);	
	CreateMissionThread(grotto_pushforward);
	CreateMissionThread(PushForwardVOStandBy);
	CreateMissionThread(grotto_chatter);
	CreateMissionThread(grotto_four_players_combat_check);
end

-- =================================================================================================															 
--  _               _   _ _____ _____ _   _  _____ 
-- | |        /\   | \ | |  __ \_   _| \ | |/ ____|
-- | |       /  \  |  \| | |  | || | |  \| | |  __ 
-- | |      / /\ \ | . ` | |  | || | | . ` | | |_ |
-- | |____ / ____ \| |\  | |__| || |_| |\  | |__| |
-- |______/_/    \_\_| \_|_____/_____|_| \_|\_____|
-- =================================================================================================															                                                  
                                                 
                                       

function grotto_landing_load()
	PrintNarrative("LOAD - grotto_landing_load");	

	CreateMissionThread(grotto_landing_goal_mission_objective);
	CreateMissionThread(plateau_sword_listener_03);

	PushForwardVOStandBy();
end


function grotto_landing_goal_mission_objective()
	PrintNarrative("WAKE - grotto_landing_goal_mission_objective");
	
	PrintNarrative("START - grotto_landing_goal_mission_objective");
	
	PrintNarrative("QUEUE - W2HubGrotto_GROTTO__landing__mission_objective");
	NarrativeQueue.QueueConversation(W2HubGrotto_GROTTO__landing__mission_objective);

	CreateMissionThread(grotto_landing_goal_sunaion);

	SleepUntil( [| volume_test_players( VOLUMES.tv_grotto_landing_sunaion_safe )], 10);	

	b_landing_sunaion_safe = true;

	PrintNarrative("END - grotto_landing_goal_mission_objective");

end



--[========================================================================[
          GROTTO. landing. mission objective

          LETTERBOX CHAPTER TITLE: CIVIL WAR
--]========================================================================]
global W2HubGrotto_GROTTO__landing__mission_objective = {
	name = "W2HubGrotto_GROTTO__landing__mission_objective",

	CanStart = function (thisConvo, queue)
		return list_count(players()) ~= 0; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	sleepBefore = 3,

	lines = {
		[1] = {	
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(Grotto.goal_landing);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Makhee",

			--character = 0, -- GAMMA_CHARACTER: Eliteescort (MAHKEE)
			text = "Arbiter has united the keeps and formed a new alliance, the Swords of Sanghelios.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_eliteescort_00100.sound'),
		},
		[2] = {	
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(Grotto.goal_landing);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			sleepBefore = 0.3,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Makhee",

			--character = 0, -- GAMMA_CHARACTER: Eliteescort (MAHKEE)
			text = "With Arbiter's victories and the death of Jul 'Mdama, the Covenant remnants grow desperate.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_eliteescort_01500.sound'),
		},
		[3] = {	
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(Grotto.goal_landing);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Makhee",

			--character = 0, -- GAMMA_CHARACTER: Eliteescort (MAHKEE)
			text = "They have begun an assault on Vadam lands, targeting Arbiter specifically.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_eliteescort_01600.sound'),
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(Grotto.goal_landing) and not b_landing_sunaion_safe;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.5,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "And Arbiter's location?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_08400.sound'),
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(Grotto.goal_landing);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Makhee",

			sleepBefore = 0.5,

			--character = 0, -- GAMMA_CHARACTER: ELITEESCORT (maHKEE)
			text = "You will find Arbiter at the Elder Council Chambers. Victory to clan and kin, Spartans. Mahkee out.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_eliteescort_01700.sound'),

			playDurationAdjustment = 0.65,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
				CreateMissionThread(ct_obj_grotto_01);
			end,		
		},
	},

	sleepAfter = 3,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		PushForwardVOReset(100);		
		PrintNarrative("QUEUE - W2HubGrotto_GROTTO__landing__mission_objective_2");
		NarrativeQueue.QueueConversation(W2HubGrotto_GROTTO__landing__mission_objective_2);
	end,
};
--[========================================================================[
          GROTTO. landing. mission objective

          LETTERBOX CHAPTER TITLE: CIVIL WAR
--]========================================================================]
global W2HubGrotto_GROTTO__landing__mission_objective_2 = {
	name = "W2HubGrotto_GROTTO__landing__mission_objective_2",

	CanStart = function (thisConvo, queue)
		return IsSpartanAbleToSpeak(SPARTANS.vale); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(100);
	end,

	sleepBefore = 2,

	lines = {
		[1] = {	
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(Grotto.goal_landing);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VaLE
			text = "I'm impressed. Arbiter has women in his ranks. War has traditionally been a man's job on Sanghelios.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_07000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;		
	end,
};


----------------------------------------------------------------------------------------------------

function grotto_landing_goal_sunaion()
	PrintNarrative("WAKE - grotto_landing_goal_sunaion");
	
	SleepUntil([| volume_test_players( VOLUMES.tv_narrative_landing_sunaion_vista)], 10);
	PrintNarrative("START - grotto_landing_goal_sunaion");

	PrintNarrative("QUEUE - W2HubGrotto_GROTTO__landing__SUNAION");
	NarrativeQueue.QueueConversation(W2HubGrotto_GROTTO__landing__SUNAION);

	PrintNarrative("END - grotto_landing_goal_sunaion");
end


--[========================================================================[
          GROTTO. landing. SUNAION

          As they round a short bend, boulders and rocky promontories
          open onto a broad, cliff-top vista. 

          In the distance, SUNAION can be glimpsed. Hovering over it is
          a formidable COVENANT ARMADA.
--]========================================================================]
global W2HubGrotto_GROTTO__landing__SUNAION = {
	name = "W2HubGrotto_GROTTO__landing__SUNAION",

	CanStart = function (thisConvo, queue)
		return IsGoalActive(Grotto.goal_landing) and ((object_valid("falls_sunaion_vista") and object_at_distance_and_can_see_object(players(), OBJECTS.cr_landing_sunaion_vista, 115, 40, VOLUMES.tv_narrative_landing_sunaion_vista)) or b_landing_sunaion_safe); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		PushForwardVOReset();
	end,

	sleepBefore = 0.4,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "What are those buildings over there?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_07300.sound'),

			sleepAfter = 0.4,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Sunaion. That's where the Guardian is located.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_00100.sound'),

			sleepAfter = 0.4,
		},

		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Gonna need serious backup to get anywhere near it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_00100.sound'),
			
			sleepAfter = 0.3, 
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "We need the Swords of Sanghelios. And that means we need Arbiter.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_09700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		CreateMissionThread(grotto_landing_vista);
	end,
};


function grotto_landing_vista()

	local s_speaker:object = nil;
	
	PrintNarrative("WAKE - grotto_landing_vista");
	PrintNarrative("START - grotto_landing_vista");
	
	sleep_s(10);

	repeat
				SleepUntil([| not b_collectible_used and NarrativeQueue.ConversationsPlayingCount() == 0 and not IsSpartanInCombat() and IsGoalActive(Grotto.goal_landing) and playersMovementSpeed() < 3 ], 10);

					if object_at_distance_and_can_see_object(players(), OBJECTS.cr_landing_sunaion_vista, 43, 30, VOLUMES.tv_narrative_landing_sunaion_vista) then
						s_speaker = spartan_look_at_object(players(), OBJECTS.cr_landing_sunaion_vista, 43, 30, 1.5, 0);
					end

	until s_speaker ~= nil or not IsGoalActive(Grotto.goal_landing)

	if IsGoalActive(Grotto.goal_landing) and s_speaker ~= nil then
		W2HubGrotto_GROTTO__landing__sunaion_vista.localVariables.s_speaker = s_speaker;
		PrintNarrative("QUEUE - W2HubGrotto_GROTTO__landing__sunaion_vista");
		NarrativeQueue.QueueConversation(W2HubGrotto_GROTTO__landing__sunaion_vista);
	end

	PrintNarrative("END - grotto_landing_vista");	
end


--[========================================================================[
          GROTTO. FALLS. sunaion vista
--]========================================================================]
global W2HubGrotto_GROTTO__landing__sunaion_vista = {
	name = "W2HubGrotto_GROTTO__landing__sunaion_vista",

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
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka or (not IsPlayer(SPARTANS.tanaka) and objects_distance_to_object( SPARTANS.tanaka, thisConvo.localVariables.s_speaker ) < 15) or (IsPlayer(SPARTANS.tanaka) and object_at_distance_and_can_see_object(SPARTANS.tanaka, OBJECTS.cr_landing_sunaion_vista, 53, 60, VOLUMES.tv_narrative_landing_sunaion_vista))
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "If that's sunaion, where's the Guardian?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_07100.sound'),
			
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER				
				return 0;
			end,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Partially under water. Sangheili built the city around the emerged part of it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_08900.sound'),
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


-- =================================================================================================															 
--  ______      _      _       _____ 
-- |  ____/\   | |    | |     / ____|
-- | |__ /  \  | |    | |    | (___  
-- |  __/ /\ \ | |    | |     \___ \ 
-- | | / ____ \| |____| |____ ____) |
-- |_|/_/    \_|______|______|_____/ 
--
-- =================================================================================================
                     

function grotto_falls_load()
	PrintNarrative("LOAD - grotto_falls_load");
	
--		CreateThread(grotto_landing_goal_mission_objective);		--	Note for Al: I've put that here but idealy we should have this VO then having the objective appear at the end of it.

		PrintNarrative("QUEUE - W2HubGrotto_GROTTO__FALLS__ENCOUNTER_covies_order");
		NarrativeQueue.QueueConversation(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_covies_order);

		CreateThread(grotto_falls_spirit);
		CreateThread(grotto_falls_vista);							--	If you look at the vista towards the Krakens and Guardian
		CreateMissionThread(grotto_sword_listener_01);

end



--[========================================================================[
          GROTTO. FALLS. ENCOUNTER covies order

          Osiris enters an open area with waterfalls, covenant are in
          position, a couple phantoms are dropping troops.

                                                  AT SPAWN
--]========================================================================]
global W2HubGrotto_GROTTO__FALLS__ENCOUNTER_covies_order = {
	name = "W2HubGrotto_GROTTO__FALLS__ENCOUNTER_covies_order",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narrative_grotto_falls_goal_encounter_covies_orders); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(40);
	end,
	
	lines = {
		[1] = {
			character = function (thisLine, thisConvo, queue, lineNumber)
							if ai_living_count(AI.sq_falls_dropship_01.spawn_points_0) == 1 then
								--print("AI");
								return AI.sq_falls_dropship_01
							else
								--print("OBJECT");
								return OBJECTS.falls_spirit_loudspeaker
							end
						end,
			text = "Secure the area! Kill every Sword of Sanghelios that you see!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elite01_00200.sound'),

			--playDurationAdjustment = 0.7,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				PrintNarrative("QUEUE - W2HubGrotto_GROTTO__FALLS__pre_encounter_osiris");
				W2HubGrotto_GROTTO__FALLS__pre_encounter_osiris.localVariables.s_speaker = AlternateSpeakerWhenEnteringVolume(VOLUMES.tv_narrative_grotto_falls_goal_encounter_covies_orders, 10)
				NarrativeQueue.QueueConversation(W2HubGrotto_GROTTO__FALLS__pre_encounter_osiris);
				CreateMissionThread(GROTTO__FALLS__ENCOUNTER_start_covies_grunt_1);
			end,

			sleepAfter = 0.5,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_grotto_falls_grunt_saw_player and objects_distance_to_object( players(), OBJECTS.falls_for_the_covenant01 ) > 23;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			character = function (thisLine, thisConvo, queue, lineNumber)
							if ai_living_count(AI.sq_falls_dropship_01.spawn_points_0) == 1 then
								--print("AI");
								return AI.sq_falls_dropship_01
							else
								--print("OBJECT");
								return OBJECTS.falls_spirit_loudspeaker
							end
						end,
			text = "We will not let the False Arbiter escape this time!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elite01_00800.sound'),

			sleepAfter = 0.3,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_grotto_falls_grunt_saw_player and objects_distance_to_object( players(), OBJECTS.falls_for_the_covenant01 ) > 23;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			character = function (thisLine, thisConvo, queue, lineNumber)
							if ai_living_count(AI.sq_falls_dropship_01.spawn_points_0) == 1 then
								--print("AI");
								return AI.sq_falls_dropship_01
							else
								--print("OBJECT");
								return OBJECTS.falls_spirit_loudspeaker
							end
						end,
			text = "Victory will be ours!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elite01_00500.sound'),
		},	
		[4] = {
			character = function (thisLine, thisConvo, queue, lineNumber)
							if ai_living_count(AI.sq_falls_dropship_01.spawn_points_0) == 1 then
								--print("AI");
								return AI.sq_falls_dropship_01
							else
								--print("OBJECT");
								return OBJECTS.falls_spirit_loudspeaker
							end
						end,
			text = "For the Covenant!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elite01_00900.sound'),

			playDurationAdjustment = 0.7,
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_grotto_falls_grunt_saw_player;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
		
			sleepBefore = 0.5,

			character = function (thisLine, thisConvo, queue, lineNumber)
							if objects_distance_to_object( players(), OBJECTS.falls_for_the_covenant01 ) > 15 then
								return OBJECTS.falls_for_the_covenant01
							else
								return OBJECTS.falls_for_the_covenant02
							end
						end,
			text = "For the Covenant!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt01_01000.sound'),

			playDurationAdjustment = 0.5,
		},
		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_grotto_falls_grunt_saw_player;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			character = function (thisLine, thisConvo, queue, lineNumber)
							if objects_distance_to_object( players(), OBJECTS.falls_for_the_covenant01 ) > 15 then
								return OBJECTS.falls_for_the_covenant01
							else
								return OBJECTS.falls_for_the_covenant02
							end
						end,
			
			text = "Covenant!!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_jackal01_00500.sound'),

			playDurationAdjustment = 0.7,
		},		
		[7] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_grotto_falls_grunt_saw_player;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			character = function (thisLine, thisConvo, queue, lineNumber)
							if objects_distance_to_object( players(), OBJECTS.falls_for_the_covenant01 ) > 15 then
								return OBJECTS.falls_for_the_covenant01
							else
								return OBJECTS.falls_for_the_covenant02
							end
						end,
			text = "For Sanghelios! For Balaho!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt02_00700.sound'),

			playDurationAdjustment = 0.3,
		},
		[8] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_grotto_falls_grunt_saw_player;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			character = function (thisLine, thisConvo, queue, lineNumber)
							if objects_distance_to_object( players(), OBJECTS.falls_for_the_covenant01 ) > 15 then
								return OBJECTS.falls_for_the_covenant01
							else
								return OBJECTS.falls_for_the_covenant02
							end
						end,
			text = "Covenant!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_jackal01_00500.sound'),

			--playDurationAdjustment = 0.2,
		},
		[9] = {
			sleepBefore = 1,

			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_grotto_falls_grunt_saw_player;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			character = function (thisLine, thisConvo, queue, lineNumber)
							if objects_distance_to_object( players(), OBJECTS.falls_for_the_covenant01 ) > 15 then
								return OBJECTS.falls_for_the_covenant01
							else
								return OBJECTS.falls_for_the_covenant02
							end
						end,
			text = "For profit!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_jackal01_00100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);				
	end,
};




--[========================================================================[
          GROTTO. FALLS. pre encounter osiris
--]========================================================================]
global W2HubGrotto_GROTTO__FALLS__pre_encounter_osiris = {
	name = "W2HubGrotto_GROTTO__FALLS__pre_encounter_osiris",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 4;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(40);
	end,

	sleepBefore = 4.2,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If Locke is first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Covenant forces ahead.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_07500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: If Buck is first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Covenant forces ahead.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_05600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: If Tanaka is first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Covenant forces ahead.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_05000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: If Vale is first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Covenant forces ahead.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_06000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();		
		PrintNarrative("QUEUE - W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_grunts_FALL");
		NarrativeQueue.QueueConversation(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_grunts_FALL);
		PrintNarrative("QUEUE - W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_grunts_reception");
		NarrativeQueue.QueueConversation(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_grunts_reception);
		PrintNarrative("QUEUE - W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_grunts_FALL_2");
		NarrativeQueue.QueueConversation(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_grunts_FALL_2);
		PrintNarrative("QUEUE - W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_grunts_reception_2");
		NarrativeQueue.QueueConversation(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_grunts_reception_2);
		PrintNarrative("QUEUE - W2HubGrotto_Grotto__Sinkhole__dead_bodies");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__Sinkhole__dead_bodies);
	end,

	
	localVariables = {
						s_speaker = nil,
						},
};

-----------------------------------------------------

function grotto_falls_spirit()

local s_speaker:object = nil;
local s_timer:number = 0;

	SleepUntil([| ai_living_count(AI.sg_falls_dropship_all) > 0 and volume_test_players( VOLUMES.tv_grotto_falls_spirits ) ], 5);

	PrintNarrative("LISTENER - grotto_falls_spirit");
	
	repeat
		
		sleep_s(0.1);
		s_timer = s_timer + 0.1;

		if object_at_distance_and_can_see_object(players(), ai_get_object(AI.sq_falls_dropship_01), 47, 40) then
			W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start.localVariables.s_speaker = spartan_look_at_object(players(), ai_get_object(AI.sq_falls_dropship_01), 47, 40, 0, 2);
		elseif object_at_distance_and_can_see_object(players(), ai_get_object(AI.sq_falls_dropship_02), 47, 40) then
			W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start.localVariables.s_speaker = spartan_look_at_object(players(), ai_get_object(AI.sq_falls_dropship_01), 47, 40, 0, 2);		
		end

	until W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start.localVariables.s_speaker ~= nil or s_timer >= 3

	if W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start.localVariables.s_speaker == nil then
		W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start.localVariables.s_speaker = GetClosestMusketeer(ai_get_object(AI.sq_courtyard_spirit_02), 40, 0);
	end
		PrintNarrative("QUEUE - W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start");
		NarrativeQueue.QueueConversation(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start);

end
		
--[========================================================================[
          GROTTO. FALLS. ENCOUNTER start

          When Osiris see the spirit deploying troops.
--]========================================================================]
global W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start = {
	name = "W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If Locke sees covies first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Spirit inbound!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_01800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,

			--playDurationAdjustment = 0.8,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: If Buck sees covies first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Spirit inbound!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_00700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: If Tanaka sees covies first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Spirit inbound!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_00500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,

			--playDurationAdjustment = 0.8,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: If Vale sees covies first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Spirit inbound!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_00700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,

			--playDurationAdjustment = 0.9,
		},
		[5] = {
			Else = true,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Spirit inbound!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_00700.sound'),

			sleepAfter = 0.6,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[6] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker ~= nil; -- GAMMA_TRANSITION: If Vale sees covies first
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Nice of 'em to send a welcome wagon.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_00400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		CreateThread(grotto_falls_encounter_ends);
		CreateMissionThread(grotto_turret_listener);
		PrintNarrative("QUEUE - W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_locke");
		NarrativeQueue.QueueConversation(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_locke);
	end,
	
	localVariables = {
					s_speaker = nil,
					},
};


--[========================================================================[
          GROTTO. FALLS. ENCOUNTER start

          When Osiris see the spirit deploying troops.
--]========================================================================]
global W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_locke = {
	name = "W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_locke",

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
			text = "Come on Osiris! Let the guns talk!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_03200.sound'),

			playDurationAdjustment = 0.8,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		CreateMissionThread(grotto_falls_covenants);
	end,	
};


----------------------------------------------------------------------------------------------------


function GROTTO__FALLS__ENCOUNTER_start_covies_grunt_1()

	PrintNarrative("START - GROTTO__FALLS__ENCOUNTER_start_covies_grunt_1");
	
	SleepUntil ([| ai_living_count(AI.sq_falls_grunts_01) > 0 ], 5);	

	SleepUntil ([| volume_test_object( VOLUMES.tv_grotto_falls_grunts_arrival, ai_get_object(AI.sq_falls_grunts_01.spawnpoint_02) )], 5);	

	b_grotto_falls_grunt_saw_player = true;

	IsThereAnEnemyInRangeLauncher(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_grunt_1, AI.sq_falls_grunts_01, ACTOR_TYPE.grunt, "enemy_in_range", Grotto.goal_falls, 20, true );
		
end

--[========================================================================[
          GROTTO. FALLS. ENCOUNTER start covies

          When the Covenant see us, they are interrupted and attack us.

          They are surprised to see us.
--]========================================================================]
global W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_grunt_1 = {
	name = "W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_grunt_1",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		
	end,

	lines = {
		[1] = {
			text = "Who is over there?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt01_01100.sound'),

			playDurationAdjustment = 0.2,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		 
		CreateMissionThread(GROTTO__FALLS__ENCOUNTER_start_covies_grunt_2);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};


function GROTTO__FALLS__ENCOUNTER_start_covies_grunt_2()
	
	SleepUntil ([| ai_combat_status(AI.sq_falls_grunts_01) > 3 ], 1);

	PrintNarrative("START - GROTTO__FALLS__ENCOUNTER_start_covies_grunt_2");

	NarrativeQueue.InterruptConversation(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_grunt_1);
	NarrativeQueue.InterruptConversation(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_covies_order);
	IsThereAnEnemyInRangeLauncher(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_grunt_2, AI.sq_falls_grunts_01, ACTOR_TYPE.grunt, "enemy_in_range", Grotto.goal_falls, 20, true );
		
end

--[========================================================================[
          GROTTO. FALLS. ENCOUNTER start covies

          When the Covenant see us, they are interrupted and attack us.

		  objects_can_see_object( players(), AI.sq_falls_grunt_01, number )

          They are surprised to see us.
--]========================================================================]
global W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_grunt_2 = {
	name = "W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_grunt_2",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,

	lines = {
		[1] = {
				text = "They are Humans!!",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt02_01300.sound'),				

				--playDurationAdjustment = 0.5,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		 
		CreateMissionThread(GROTTO__FALLS__ENCOUNTER_start_covies_grunt_3);		
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};



function GROTTO__FALLS__ENCOUNTER_start_covies_grunt_3()

	PrintNarrative("START - GROTTO__FALLS__ENCOUNTER_start_covies_grunt_3");	

	sleep_s(2);

	IsThereAnEnemyInRangeLauncher(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_grunt_3, AI.sg_falls_all, ACTOR_TYPE.grunt, "enemy_in_range", Grotto.goal_falls, 20 );
		
end

--[========================================================================[
          GROTTO. FALLS. ENCOUNTER start covies

          When the Covenant see us, they are interrupted and attack us.

          They are surprised to see us.
--]========================================================================]
global W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_grunt_3 = {
	name = "W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_grunt_3",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			text = "Humans on Sanghelios!!!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt02_01400.sound'),

			playDurationAdjustment = 0.7,
		},
	},

	sleepAfter = 0.5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(GROTTO__FALLS__ENCOUNTER_start_covies_grunt_4c);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};



function GROTTO__FALLS__ENCOUNTER_start_covies_grunt_4c()

	PrintNarrative("START - GROTTO__FALLS__ENCOUNTER_start_covies_grunt_4c");	

	sleep_s(2);

	IsThereAnEnemyInRangeLauncher(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_grunt_4c, AI.sg_falls_all, ACTOR_TYPE.grunt, "enemy_in_range", Grotto.goal_falls, 15 );
		
end

--[========================================================================[
          GROTTO. FALLS. ENCOUNTER start covies

          When the Covenant see us, they are interrupted and attack us.

          They are surprised to see us.
--]========================================================================]
global W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_grunt_4c = {
	name = "W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_grunt_4c",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			text = "Humans! Warn the troops!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt01_00800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(GROTTO__FALLS__ENCOUNTER_start_covies_grunt_4b);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};



function GROTTO__FALLS__ENCOUNTER_start_covies_grunt_4b()

	PrintNarrative("START - GROTTO__FALLS__ENCOUNTER_start_covies_grunt_4b");

	sleep_s(10);

	SleepUntil ([| ai_combat_status(AI.sg_falls_all) >= 7 ], 100);	

	IsThereAnEnemyInRangeLauncher(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_grunt_4b, AI.sg_falls_all, ACTOR_TYPE.grunt, "enemy_in_range", Grotto.goal_falls, 15 );
		
end


--[========================================================================[
          GROTTO. FALLS. ENCOUNTER start covies

          When the Covenant see us, they are interrupted and attack us.

          They are surprised to see us.
--]========================================================================]
global W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_grunt_4b = {
	name = "W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_grunt_4b",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			text = "Kill the Humans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt01_00700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);				
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};


------------------------------------------------------------------------------------------



		
	

--[========================================================================[
          GROTTO. FALLS. ENCOUNTER start grunts
--]========================================================================]
global W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_grunts_FALL = {
	name = "W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_grunts_FALL",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_falls_grunts_ds_01.spawnpoint_01) == 1; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; 
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {

			--sleepBefore = 0.5,

			character = AI.sq_falls_grunts_02.spawn_points_0, -- GAMMA_CHARACTER: Grunt01
			text = "Aaaaaahhhhhh",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt01_01300.sound'),

			playDurationAdjustment = 0.5,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		 
	end,
};



--[========================================================================[
          GROTTO. FALLS. ENCOUNTER start grunts
--]========================================================================]
global W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_grunts_reception = {
	name = "W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_grunts_reception",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_falls_grunts_ds_01.spawnpoint_01) == 1 and volume_test_object( VOLUMES.tv_narrative_grotto_falls_grunt_reception, ai_get_object(AI.sq_falls_grunts_ds_01.spawnpoint_01) ); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; 
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		NarrativeQueue.InterruptConversation(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_grunts_FALL);
	end,

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	lines = {
		[1] = {
			character = AI.sq_falls_grunts_02.spawn_points_0, -- GAMMA_CHARACTER: Grunt01
			text = "[Umpfff!]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt01_01400.sound'),

			playDurationAdjustment = 0.8,
		},
		[2] = {
			character = AI.sq_falls_grunts_02.spawn_points_0, -- GAMMA_CHARACTER: Grunt02
			text = "Why are there humans here!?!?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt02_00600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		 
	end,
};


--[========================================================================[
          GROTTO. FALLS. ENCOUNTER start grunts
--]========================================================================]
global W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_grunts_FALL_2 = {
	name = "W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_grunts_FALL_2",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_falls_grunts_ds_02.spawnpoint_01) == 1; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; 
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			--character = 0, -- GAMMA_CHARACTER: Grunt02
			text = "Aaaaaahhhhhh",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt02_01500.sound'),

			playDurationAdjustment = 0.5,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		 
	end,
};



--[========================================================================[
          GROTTO. FALLS. ENCOUNTER start grunts
--]========================================================================]
global W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_grunts_reception_2 = {
	name = "W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_grunts_reception_2",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_falls_grunts_ds_02.spawnpoint_01) == 1 and volume_test_object( VOLUMES.tv_narrative_grotto_falls_grunt_reception, ai_get_object(AI.sq_falls_grunts_ds_02.spawnpoint_01) ); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; 
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		NarrativeQueue.InterruptConversation(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_grunts_FALL_2);
	end,

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	lines = {
		[1] = {
			--character = 0, -- GAMMA_CHARACTER: Grunt02
			text = "[Umpfff!]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt02_01600.sound'),
		},
		[2] = {
			character = AI.sq_falls_grunts_02.spawn_points_1, -- GAMMA_CHARACTER: Grunt01
			text = "Humans! Alert!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt01_00900.sound'),

			playDurationAdjustment = 0.8,
		},
		[3] = {
			--character = 0, -- GAMMA_CHARACTER: Grunt02
			text = "Death to Humans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt02_00900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		 
	end,
};





function grotto_falls_covenants()

	SleepUntil ([| ai_living_count(AI.sg_falls_all) > 0 and ai_combat_status(AI.sg_falls_all) > 4 ], 10);

	sleep_s(20);

	CreateMissionThread(GROTTO__FALLS__ENCOUNTER_start_covies_grunt_5);
	CreateMissionThread(GROTTO__FALLS__ENCOUNTER_start_covies_elite_1);	
	CreateMissionThread(GROTTO__FALLS__ENCOUNTER_start_covies_jackal_1);

end



----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------

function GROTTO__FALLS__ENCOUNTER_start_covies_grunt_5()

	PrintNarrative("START - GROTTO__FALLS__ENCOUNTER_start_covies_grunt_5");

	sleep_s(10);

	IsThereAnEnemyInRangeLauncher(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_grunt_5, AI.sg_falls_all, ACTOR_TYPE.grunt, "enemy_in_range", Grotto.goal_falls, 10 );
		
end


--[========================================================================[
          GROTTO. FALLS. ENCOUNTER start covies

          When the Covenant see us, they are interrupted and attack us.

          They are surprised to see us.
--]========================================================================]
global W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_grunt_5 = {
	name = "W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_grunt_5",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			text = "For 'Mdama!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt02_01100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		 
		CreateMissionThread(GROTTO__FALLS__ENCOUNTER_start_covies_grunt_6);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};



function GROTTO__FALLS__ENCOUNTER_start_covies_grunt_6()

	PrintNarrative("START - GROTTO__FALLS__ENCOUNTER_start_covies_grunt_6");

	sleep_s(10);

	IsThereAnEnemyInRangeLauncher(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_grunt_6, AI.sg_falls_all, ACTOR_TYPE.grunt, "enemy_in_range", Grotto.goal_falls, 10 );
		
end

--[========================================================================[
          GROTTO. FALLS. ENCOUNTER start covies

          When the Covenant see us, they are interrupted and attack us.

          They are surprised to see us.
--]========================================================================]
global W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_grunt_6 = {
	name = "W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_grunt_6",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,
	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 100;
	end,
	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {

			text = "Death to the False Arbiter!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt01_01200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		 
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};



----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------


function GROTTO__FALLS__ENCOUNTER_start_covies_elite_1()

	PrintNarrative("START - GROTTO__FALLS__ENCOUNTER_start_covies_elite_1");

	IsThereAnEnemyInRangeLauncher(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_elite_1, AI.sg_falls_all, ACTOR_TYPE.elite, "enemy_in_range", Grotto.goal_falls, 10 );
		
end

--[========================================================================[
          GROTTO. FALLS. ENCOUNTER start covies

          When the Covenant see us, they are interrupted and attack us.

          They are surprised to see us.
--]========================================================================]
global W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_elite_1 = {
	name = "W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_elite_1",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {

			text = "HUMANS?! HERE?! BLASPHEMY! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elite01_00100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		 
		CreateMissionThread(GROTTO__FALLS__ENCOUNTER_start_covies_elite_2);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};


function GROTTO__FALLS__ENCOUNTER_start_covies_elite_2()

	PrintNarrative("START - GROTTO__FALLS__ENCOUNTER_start_covies_elite_2");

	sleep_s(10);

	IsThereAnEnemyInRangeLauncher(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_elite_2, AI.sg_falls_all, ACTOR_TYPE.elite, "enemy_in_range", Grotto.goal_falls, 10 );
		
end

--[========================================================================[
          GROTTO. FALLS. ENCOUNTER start covies

          When the Covenant see us, they are interrupted and attack us.

          They are surprised to see us.
--]========================================================================]
global W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_elite_2 = {
	name = "W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_elite_2",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {

			text = "The rumors were true! Humans serve the False Arbiter!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elite01_02100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		 
		CreateMissionThread(GROTTO__FALLS__ENCOUNTER_start_covies_elite_3);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};


function GROTTO__FALLS__ENCOUNTER_start_covies_elite_3()

	PrintNarrative("START - GROTTO__FALLS__ENCOUNTER_start_covies_elite_3");

	sleep_s(10);

	IsThereAnEnemyInRangeLauncher(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_elite_3, AI.sg_falls_all, ACTOR_TYPE.elite, "enemy_in_range", Grotto.goal_falls, 10 );
		
end


--[========================================================================[
          GROTTO. FALLS. ENCOUNTER start covies

          When the Covenant see us, they are interrupted and attack us.

          They are surprised to see us.
--]========================================================================]
global W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_elite_3 = {
	name = "W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_elite_3",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			text = "Death to the False Arbiter!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elite02_01300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		 
		CreateMissionThread(GROTTO__FALLS__ENCOUNTER_start_covies_elite_4);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};


function GROTTO__FALLS__ENCOUNTER_start_covies_elite_4()

	PrintNarrative("START - GROTTO__FALLS__ENCOUNTER_start_covies_elite_4");

	sleep_s(10);

	IsThereAnEnemyInRangeLauncher(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_elite_4, AI.sg_falls_all, ACTOR_TYPE.elite, "enemy_in_range", Grotto.goal_falls, 10 );
		
end


--[========================================================================[
          GROTTO. FALLS. ENCOUNTER start covies

          When the Covenant see us, they are interrupted and attack us.

          They are surprised to see us.
--]========================================================================]
global W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_elite_4 = {
	name = "W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_elite_4",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			text = "Do not let them reach the Arbiter! Kill them!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elite01_00600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		 
		CreateMissionThread(GROTTO__FALLS__ENCOUNTER_start_covies_elite_5);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};


function GROTTO__FALLS__ENCOUNTER_start_covies_elite_5()

	PrintNarrative("START - GROTTO__FALLS__ENCOUNTER_start_covies_elite_5");

	sleep_s(10);

	IsThereAnEnemyInRangeLauncher(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_elite_5, AI.sg_falls_all, ACTOR_TYPE.elite, "enemy_in_range", Grotto.goal_falls, 10 );
		
end
--[========================================================================[
          GROTTO. FALLS. ENCOUNTER start covies

          When the Covenant see us, they are interrupted and attack us.

          They are surprised to see us.
--]========================================================================]
global W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_elite_5 = {
	name = "W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_elite_5",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			text = "You're too late to save the false Arbiter!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elite02_01100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		 
		CreateMissionThread(GROTTO__FALLS__ENCOUNTER_start_covies_elite_6);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};



function GROTTO__FALLS__ENCOUNTER_start_covies_elite_6()

	PrintNarrative("START - GROTTO__FALLS__ENCOUNTER_start_covies_elite_6");

	sleep_s(10);

	IsThereAnEnemyInRangeLauncher(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_elite_6, AI.sg_falls_all, ACTOR_TYPE.elite, "enemy_in_range", Grotto.goal_falls, 10 );
		
end
--[========================================================================[
          GROTTO. FALLS. ENCOUNTER start covies

          When the Covenant see us, they are interrupted and attack us.

          They are surprised to see us.
--]========================================================================]
global W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_elite_6 = {
	name = "W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_elite_6",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			text = "Call reinforcement! Deploy insertions pods. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elite02_00300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		 
		CreateMissionThread(GROTTO__FALLS__ENCOUNTER_start_covies_elite_7);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};




function GROTTO__FALLS__ENCOUNTER_start_covies_elite_7()

	PrintNarrative("START - GROTTO__FALLS__ENCOUNTER_start_covies_elite_7");

	sleep_s(10);

	IsThereAnEnemyInRangeLauncher(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_elite_7, AI.sg_falls_all, ACTOR_TYPE.elite, "enemy_in_range", Grotto.goal_falls, 10 );
		
end


--[========================================================================[
          GROTTO. FALLS. ENCOUNTER start covies

          When the Covenant see us, they are interrupted and attack us.

          They are surprised to see us.
--]========================================================================]
global W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_elite_7 = {
	name = "W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_elite_7",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			text = "Infidels on Sanghelios! OUR HOME! KILL THEM!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elite02_00500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		 
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};



---------------------------------------------------

function GROTTO__FALLS__ENCOUNTER_start_covies_jackal_1()

	PrintNarrative("START - GROTTO__FALLS__ENCOUNTER_start_covies_jackal_1");

	sleep_s(10);

	IsThereAnEnemyInRangeLauncher(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_jackal_1, AI.sg_falls_all, ACTOR_TYPE.jackal, "enemy_in_range", Grotto.goal_falls, 10 );
		
end

--[========================================================================[
          GROTTO. FALLS. ENCOUNTER start covies

          When the Covenant see us, they are interrupted and attack us.

          They are surprised to see us.
--]========================================================================]
global W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_jackal_1 = {
	name = "W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_jackal_1",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {

			text = "Victory!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_jackal01_00400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		 
		CreateMissionThread(GROTTO__FALLS__ENCOUNTER_start_covies_jackal_2);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};



function GROTTO__FALLS__ENCOUNTER_start_covies_jackal_2()

	PrintNarrative("START - GROTTO__FALLS__ENCOUNTER_start_covies_jackal_2");

	sleep_s(10);

	IsThereAnEnemyInRangeLauncher(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_jackal_2, AI.sg_falls_all, ACTOR_TYPE.jackal, "enemy_in_range", Grotto.goal_falls, 10 );
		
end

--[========================================================================[
          GROTTO. FALLS. ENCOUNTER start covies

          When the Covenant see us, they are interrupted and attack us.

          They are surprised to see us.
--]========================================================================]
global W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_jackal_2 = {
	name = "W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_jackal_2",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			text = "For profit!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_jackal01_00100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(GROTTO__FALLS__ENCOUNTER_start_covies_jackal_3);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};




function GROTTO__FALLS__ENCOUNTER_start_covies_jackal_3()

	PrintNarrative("START - GROTTO__FALLS__ENCOUNTER_start_covies_jackal_3");

	sleep_s(10);

	IsThereAnEnemyInRangeLauncher(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_jackal_3, AI.sg_falls_all, ACTOR_TYPE.jackal, "enemy_in_range", Grotto.goal_falls, 15 );
		
end


--[========================================================================[
          GROTTO. FALLS. ENCOUNTER start covies

          When the Covenant see us, they are interrupted and attack us.

          They are surprised to see us.
--]========================================================================]
global W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_jackal_3 = {
	name = "W2HubGrotto_GROTTO__FALLS__ENCOUNTER_start_covies_jackal_3",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			text = "For the pay masters!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_jackal01_01100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		 
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};


----------------------------------------------------------------------------------------------------
function grotto_falls_encounter_ends()
	PrintNarrative("WAKE - grotto_falls_encounter_ends");
	SleepUntil([|  ai_living_count( AI.sg_falls_all ) < 10 ], 10);		
	PrintNarrative("START - grotto_falls_encounter_ends");

	PushForwardVOReset();

	sleep_s(1);

	if volume_test_players( VOLUMES.tv_narrative_grotto_falls_encounter_ends ) and not volume_test_players( VOLUMES.tv_narrative_grotto_falls_encounter_ends_2 ) and IsGoalActive(Grotto.goal_falls) then
		PrintNarrative("START - grotto_falls_encounter_ends - Almost clear");
		
		PrintNarrative("QUEUE - W2HubGrotto_GROTTO__FALLS__ENCOUNTER_ends_middle");
		NarrativeQueue.QueueConversation(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_ends_middle);

		SleepUntil([|  NarrativeQueue.HasConversationFinished(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_ends_middle) ], 10);	

	else
		PrintNarrative("START - grotto_falls_encounter_ends - slipped almost clear");
	end
	PrintNarrative("END - grotto_falls_encounter_ends");

	SleepUntil([| volume_test_players( VOLUMES.tv_narrative_grotto_falls_encounter_ends_2 ) ], 10);

	SleepUntil([| ai_living_count( AI.sg_falls_all ) <= 1 ], 10);	

	CreateThread(grotto_falls_carved);

	SleepUntil([| ai_living_count( AI.sg_falls_all ) == 0 ], 10);	
	PrintNarrative("START - grotto_falls_encounter_ends_2");

	sleep_s(1.4);

	SleepUntil([| IsSpartanAbleToSpeak(SPARTANS.locke) ], 10);

	if not volume_test_players( VOLUMES.tv_narrative_grotto_falls_dead_bodies ) and IsGoalActive(Grotto.goal_falls) then

		PrintNarrative("QUEUE - W2HubGrotto_GROTTO__FALLS__ENCOUNTER_ends_clear");
		NarrativeQueue.QueueConversation(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_ends_clear);

	end	

	PrintNarrative("END - grotto_falls_encounter_ends_2");
end




--[========================================================================[
          GROTTO. FALLS. ENCOUNTER ends
--]========================================================================]
global W2HubGrotto_GROTTO__FALLS__ENCOUNTER_ends_middle = {
	name = "W2HubGrotto_GROTTO__FALLS__ENCOUNTER_ends_middle",

	CanStart = function (thisConvo, queue)
		return true; 
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
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "We're almost clear, Osiris! Keep moving!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_04300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};

-------------------------------------------------------

function grotto_turret_listener()

local s_speaker:object = nil;

	SleepUntil([| object_valid("veh_falls_shade_01")  ], 60);

	PrintNarrative("LISTENER - grotto_turret_listener");

	repeat 
		
		--print("wait for player be near");
		SleepUntil([| volume_test_players(VOLUMES.tv_narrative_grotto_falls_turret)], 10);		

			repeat
				Sleep(10);
				--print("wait for player to look");
				s_speaker = spartan_look_at_object(players(), OBJECTS.veh_falls_shade_01, 25, 20, 0, 2);
			until s_speaker ~= nil or not volume_test_players(VOLUMES.tv_narrative_grotto_falls_turret)

	until (s_speaker ~= nil and object_valid("veh_falls_shade_01") and vehicle_test_seat( OBJECTS.veh_falls_shade_01, "shade_d") and not vehicle_test_seat_unit_list( OBJECTS.veh_falls_shade_01, "shade_d", spartans() )) or object_get_health( OBJECTS.veh_falls_shade_01 ) == 0 or IsGoalActive(Grotto.goal_sinkhole) 

	print("listening out");
	if s_speaker ~= nil and object_get_health(OBJECTS.veh_falls_shade_01) > 0 then
		W2HubGrotto_GROTTO__FALLS__ENCOUNTER_turret.localVariables.s_speaker = s_speaker;
		PrintNarrative("QUEUE - W2HubGrotto_GROTTO__FALLS__ENCOUNTER_turret");
		NarrativeQueue.QueueConversation(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_turret);		
	end

end



--[========================================================================[
          GROTTO. FALLS. ENCOUNTER turret
--]========================================================================]
global W2HubGrotto_GROTTO__FALLS__ENCOUNTER_turret = {
	name = "W2HubGrotto_GROTTO__FALLS__ENCOUNTER_turret",

	CanStart = function (thisConvo, queue)
		return thisConvo.localVariables.s_speaker ~= nil and volume_test_players( VOLUMES.tv_narrative_grotto_falls_turret );
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	sleepBefore = 2.5,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If Locke sees the turret first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Watch the turret!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_05200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: If Buck sees the turret first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Watch the turret!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_03900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
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
			text = "Watch the turret!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_03500.sound'),

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
			text = "Watch the turret!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_00300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return object_get_health( OBJECTS.veh_falls_shade_01 ) > 0 ;
			end,

			sleepBefore = 0.7,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Could try to flank it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_07000.sound'),
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
          GROTTO. FALLS. ENCOUNTER ends
--]========================================================================]
global W2HubGrotto_GROTTO__FALLS__ENCOUNTER_ends_clear = {
	name = "W2HubGrotto_GROTTO__FALLS__ENCOUNTER_ends_clear",

	CanStart = function (thisConvo, queue)
		return true; 
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
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "All clear. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_05400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);	
	end,
};


-------------------------------------------


function grotto_falls_carved()

local s_speaker:object = nil;


	sleep_s(10);

	SleepUntil([|  not IsSpartanInCombat() ], 10);		

	PrintNarrative("LISTENER - grotto_falls_carved");

			repeat
				sleep_s(0.1);
				s_speaker = spartan_look_at_object(players(), OBJECTS.cr_lookat_falls_exit, 20, 15, 0.3, 2);
			until (not b_collectible_used and not volume_test_players(VOLUMES.tv_grotto_falls_not_carved) and s_speaker ~= nil) or objects_distance_to_object( players(), OBJECTS.cr_lookat_falls_exit ) < 8 or volume_test_players( VOLUMES.tv_narrative_grotto_falls_dead_bodies) or IsGoalActive(Grotto.goal_sinkhole)

	if IsGoalActive(Grotto.goal_falls) then

		if s_speaker ~= nil then
			W2HubGrotto_GROTTO__FALLS__ENCOUNTER_ends.localVariables.s_speaker = s_speaker;
		else
			W2HubGrotto_GROTTO__FALLS__ENCOUNTER_ends.localVariables.s_speaker = GetClosestMusketeer(OBJECTS.cr_lookat_falls_exit, 20, 2);
		end

		PrintNarrative("QUEUE - W2HubGrotto_GROTTO__FALLS__ENCOUNTER_ends");
		NarrativeQueue.QueueConversation(W2HubGrotto_GROTTO__FALLS__ENCOUNTER_ends);
	end

end

--[========================================================================[
          GROTTO. FALLS. ENCOUNTER ends
--]========================================================================]
global W2HubGrotto_GROTTO__FALLS__ENCOUNTER_ends = {
	name = "W2HubGrotto_GROTTO__FALLS__ENCOUNTER_ends",

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
				return IsGoalActive(Grotto.goal_falls) and thisConvo.localVariables.s_speaker == SPARTANS.locke and not volume_test_players( VOLUMES.tv_narrative_grotto_falls_dead_bodies); -- GAMMA_TRANSITION: If Locke sees the exit first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "There's a path carved into the cliffs here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_07600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return IsGoalActive(Grotto.goal_falls) and thisConvo.localVariables.s_speaker == SPARTANS.buck and not volume_test_players( VOLUMES.tv_narrative_grotto_falls_dead_bodies); -- GAMMA_TRANSITION: If Buck sees the exit first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "There's  a path carved into the cliffs here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_05700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return IsGoalActive(Grotto.goal_falls) and thisConvo.localVariables.s_speaker == SPARTANS.tanaka and not volume_test_players( VOLUMES.tv_narrative_grotto_falls_dead_bodies); -- GAMMA_TRANSITION: If Tanaka sees the exit first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "There's a path carved into the cliffs here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_05100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return IsGoalActive(Grotto.goal_falls) and thisConvo.localVariables.s_speaker == SPARTANS.vale and not volume_test_players( VOLUMES.tv_narrative_grotto_falls_dead_bodies); -- GAMMA_TRANSITION: If Vale sees the exit first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "There's a path carved into the cliffs here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_06100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},
	
	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 2,

	localVariables = {
					s_speaker = nil,
					},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,

	
};

----------------------------------------------------------------------------------------------------

function grotto_falls_vista()

	local s_speaker:object = nil;
	
	PrintNarrative("WAKE - grotto_falls_vista");
	PrintNarrative("START - grotto_falls_vista");  -- objects_distance_to_object( players(), OBJECTS.falls_sunaion_vista)

	repeat
				SleepUntil([| NarrativeQueue.ConversationsPlayingCount() == 0 and not IsSpartanInCombat() and (volume_test_players( VOLUMES.tv_narrative_grotto_falls_vista_01 ))  ], 10);

					if object_at_distance_and_can_see_object(players(), OBJECTS.falls_sunaion_vista, 55, 30, VOLUMES.tv_narrative_grotto_falls_vista_01) then
						s_speaker = spartan_look_at_object(players(), OBJECTS.falls_sunaion_vista, 55, 30, 1, 1);							
					end

	until s_speaker ~= nil or not IsGoalActive(Grotto.goal_falls)

	if IsGoalActive(Grotto.goal_falls) and s_speaker ~= nil then
		W2HubGrotto_Grotto_falls_vista.localVariables.s_speaker = s_speaker;
		PrintNarrative("QUEUE - W2HubGrotto_Grotto_falls_vista");					
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto_falls_vista);					
	end


	PrintNarrative("END - grotto_falls_vista");	
end

--[========================================================================[
          Grotto. KEYHOLE. HQ

          In the distant background, we can see the Council Chamber
          under heavy attack. Not in combat.
--]========================================================================]
global W2HubGrotto_Grotto_falls_vista = {
	name = "W2HubGrotto_Grotto_falls_vista",

	CanStart = function (thisConvo, queue)
		return thisConvo.localVariables.s_speaker ~= nil; -- GAMMA_CONDITION
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
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If Locke first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Covenant ships moving this way.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_01900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: If tanaka look at sunaion
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Covenant ships moving this way.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_01400.sound'),
			
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: If tanaka look at sunaion
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Covenant ships moving this way.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_00200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: If tanaka look at sunaion
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Covenant ships moving this way.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_01300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			sleepBefore = 0.3,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Either 'Makhee undersold the situation, or the Arbiter's about to get a big surprise.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_00300.sound'),
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
          Grotto. Sinkhole. dead bodies

          The bodies of several dead Swords of Sanghelios (the
          Arbiter's faction) are laying there, as if patrolling guards
          have been killed.

          Whoever sees it first comment on it.
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__dead_bodies = {
	name = "W2HubGrotto_Grotto__Sinkhole__dead_bodies",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narrative_grotto_falls_dead_bodies) and objects_distance_to_object( players(), OBJECTS.cr_ambush_dead_01 ) < 12;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		thisConvo.localVariables.s_speaker = GetClosestMusketeer(GetClosestMusketeer(OBJECTS.cr_ambush_dead_01, 13, 2), 5, 0);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return 	thisConvo.localVariables.s_speaker == SPARTANS.locke;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Bodies ahead. Swords of Sanghelios. Covenant must've caught 'em by surprise. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_00700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return 	thisConvo.localVariables.s_speaker == SPARTANS.buck;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Dead Elites ahead. Look like they're with the Swords of Sanghelios.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_01800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return 	thisConvo.localVariables.s_speaker == SPARTANS.tanaka;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Dead Elites. Swords of Sanghelios. Covenant killed 'em.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_01300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return 	thisConvo.localVariables.s_speaker == SPARTANS.vale;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Casualties here. They're wearing Swords of Sanghelios armor. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_01700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not b_player_exiting_dead_bodies; -- GAMMA_TRANSITION: If player is still next to the bodies after X time
			end,

			sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Shee-nn-say ray-mah-uu, \r\nshee-nn-say roo-tay-hah-deh",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_02500.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[6] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not b_player_exiting_dead_bodies; -- GAMMA_TRANSITION: If player is still next to the bodies after X time
			end,

			sleepBefore = 0.3,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "What's that, Vale?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_02100.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[7] = {
			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Sangheili burial prayer. A Warrior at birth, a Warrior in death. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_02600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PushForwardVOReset(40);
		--PrintNarrative("QUEUE - W2HubGrotto_Grotto__Sinkhole__dead_bodies_ammoup");
		--NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__Sinkhole__dead_bodies_ammoup);
		CreateMissionThread(grotto_ambush_dead_arbiters_elite);
	end,

	localVariables = {
					s_speaker = nil,
					},
};




function grotto_ambush_dead_arbiters_elite()

local s_speaker:object = nil;

	PrintNarrative("LISTENER - grotto_ambush_dead_arbiters_elite");

			repeat 							
					SleepUntil([| NarrativeQueue.ConversationsPlayingCount() == 0 and (volume_test_players_all( VOLUMES.tv_narrative_grotto_falls_dead_bodies_lookat ) or volume_test_players_all( VOLUMES.tv_narrative_grotto_falls_dead_bodies_lookat01 ) or not IsGoalActive(Grotto.goal_sinkhole)) ], 10);		

					if IsGoalActive(Grotto.goal_sinkhole) then

							repeat
								Sleep(10);

								if volume_test_players_all( VOLUMES.tv_narrative_grotto_falls_dead_bodies_lookat ) then
											s_speaker = spartan_look_at_object(players(), OBJECTS.cr_ambush_dead_01, 2, 10, 0.7, 0);
										if s_speaker == nil then
											s_speaker = spartan_look_at_object(players(), OBJECTS.cr_ambush_dead_02, 2, 10, 0.7, 0);
										end
										if s_speaker == nil then
											s_speaker = spartan_look_at_object(players(), OBJECTS.cr_ambush_dead_03, 2, 10, 0.7, 0);
										end
										if s_speaker == nil then
											s_speaker = spartan_look_at_object(players(), OBJECTS.cr_ambush_dead_04, 2, 10, 0.7, 0);
										end
										if s_speaker == nil then
											s_speaker = spartan_look_at_object(players(), OBJECTS.cr_ambush_dead_05, 2, 10, 0.7, 0);
										end
										if s_speaker == nil then
											s_speaker = spartan_look_at_object(players(), OBJECTS.cr_ambush_dead_06, 2, 10, 0.7, 0);
										end
										if s_speaker == nil then
											s_speaker = spartan_look_at_object(players(), OBJECTS.cr_ambush_dead_07, 2, 15, 0.7, 0);
										end
										if s_speaker == nil then
											s_speaker = spartan_look_at_object(players(), OBJECTS.cr_ambush_dead_08, 2, 10, 0.7, 0);
										end
								end
								if volume_test_players_all( VOLUMES.tv_narrative_grotto_falls_dead_bodies_lookat01 ) then
										if s_speaker == nil then
											s_speaker = spartan_look_at_object(players(), OBJECTS.cr_ambush_dead_09, 2, 10, 0.7, 0);
										end
										if s_speaker == nil then
											s_speaker = spartan_look_at_object(players(), OBJECTS.cr_ambush_dead_10, 2, 10, 0.7, 0);
										end
										if s_speaker == nil then
											s_speaker = spartan_look_at_object(players(), OBJECTS.cr_ambush_dead_11, 2, 10, 0.7, 0);
										end
										if s_speaker == nil then
											s_speaker = spartan_look_at_object(players(), OBJECTS.cr_ambush_dead_12, 2, 10, 0.7, 0);
										end
										if s_speaker == nil then
											s_speaker = spartan_look_at_object(players(), OBJECTS.cr_ambush_dead_13, 2, 10, 0.7, 0);
										end
								end
							until NarrativeQueue.ConversationsPlayingCount() == 0 and (s_speaker ~= nil or not (volume_test_players(VOLUMES.tv_narrative_grotto_falls_dead_bodies_lookat) or volume_test_players_all( VOLUMES.tv_narrative_grotto_falls_dead_bodies_lookat01 )))
					end

			until s_speaker ~= nil or not IsGoalActive(Grotto.goal_sinkhole)

	if s_speaker ~= nil then

		W2HubGrotto_Grotto__Sinkhole__dead_bodies_02.localVariables.s_speaker = s_speaker;
		PrintNarrative("QUEUE - W2HubGrotto_Grotto__Sinkhole__dead_bodies_02");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__Sinkhole__dead_bodies_02);
	end

end


--[========================================================================[
          Grotto. Sinkhole. dead bodies 02

          If player look around and come back to look at them.

          Gives a hint about the fact that maybe those Elites were
          ambushed because of the treason.
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__dead_bodies_02 = {
	name = "W2HubGrotto_Grotto__Sinkhole__dead_bodies_02",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = function(thisConvo, queue)	-- OBJECT (target all clients if unused)
		return thisConvo.localVariables.s_speaker;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOAdd(10);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not b_player_exiting_dead_bodies and thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If Locke look at a body
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    --radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Looks like they were ambushed. No covenant casualties...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_04200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return not b_player_exiting_dead_bodies and thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: If Locke look at a body
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   --radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Why are there no dead Covenant here? ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_03300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return not b_player_exiting_dead_bodies and thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: If Tanaka look at a body
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    --radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "That was a bloody surprise attack. No dead covenant...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_03100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return not b_player_exiting_dead_bodies and thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: If Vale look at a body
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    --radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Only casualties are Swords of Sanghelios... ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_03900.sound'),

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

--[[

--[========================================================================[
          Grotto. Sinkhole. dead bodies

          The bodies of several dead Swords of Sanghelios (the
          Arbiter's faction) are laying there, as if patrolling guards
          have been killed.

          Whoever sees it first comment on it.
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__dead_bodies_ammoup = {
	name = "W2HubGrotto_Grotto__Sinkhole__dead_bodies_ammoup",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_timer <= 20 and b_push_forward_vo_timer > 4 and IsSpartanAbleToSpeak(SPARTANS.locke) and not volume_test_players( VOLUMES.tv_narrative_grotto_falls_dead_bodies_buck);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(40);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not b_player_entered_sinkhole;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.locke,
			text = "Ammo up Osiris.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_06300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PushForwardVOReset(40);
	end,
};
]]

-- =================================================================================================
--   _____ _____ _   _ _  ___    _  ____  _      ______ 
--  / ____|_   _| \ | | |/ / |  | |/ __ \| |    |  ____|
-- | (___   | | |  \| | ' /| |__| | |  | | |    | |__   
--  \___ \  | | | . ` |  < |  __  | |  | | |    |  __|  
--  ____) |_| |_| |\  | . \| |  | | |__| | |____| |____ 
-- |_____/|_____|_| \_|_|\_\_|  |_|\____/|______|______|
-- =================================================================================================                              


function grotto_sinkhole_load()
	PrintNarrative("LOAD - grotto_sinkhole_load");

	PushForwardVOReset(40);

	CreateMissionThread(grotto_sword_listener_02);	
	PrintNarrative("QUEUE - W2HubGrotto_Grotto__Sinkhole__dead_bodies__Pull_forward");
	NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__Sinkhole__dead_bodies__Pull_forward);

	SleepUntil([|	volume_test_players( VOLUMES.tv_narrative_grotto_falls_dead_bodies_buck) ], 10);

	b_player_exiting_dead_bodies = true;

	PrintNarrative("QUEUE - W2HubGrotto_Grotto__Sinkhole__dead_bodies__transition");
	NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__Sinkhole__dead_bodies__transition);
		
	CreateMissionThread(grotto_sinkhole_elite_boss);
	CreateMissionThread(grotto_sinkhole_snipers);		-- Player call out snipers when he enters the Sinkhole

	SleepUntil([|	volume_test_players( VOLUMES.tv_narrative_grotto_falls_sinkhole_entrance) ], 10);
	
	b_player_entered_sinkhole = true;
	
end

----------------------------------------------


--[========================================================================[
          Grotto. Sinkhole. dead bodies. Pull forward
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__dead_bodies__Pull_forward = {
	name = "W2HubGrotto_Grotto__Sinkhole__dead_bodies__Pull_forward",

	CanStart = function (thisConvo, queue)
		return (b_push_forward_vo_counrdown_on > 35 or b_push_forward_vo_timer == 3) and volume_test_players_all( VOLUMES.tv_narrative_grotto_falls_dead_bodies ); -- GAMMA_CONDITION
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
				return not b_player_exiting_dead_bodies;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Makhee",

			--character = 0, -- GAMMA_CHARACTER: Eliteescort (MAHKEE)
			text = "Spartans, the path to the Elder Council Chamber is directly above your current location.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_eliteescort_02100.sound'),
		},
		[2] = {		
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_player_exiting_dead_bodies;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Copy that, Mahkee. Find a way up, Spartans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_09800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};


--[========================================================================[
          Grotto. Sinkhole. dead bodies. transition

          This plays during the tunnel that exit that area to Sinkhole,
          if players took their time looking at bodies and rearming.
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__dead_bodies__transition = {
	name = "W2HubGrotto_Grotto__Sinkhole__dead_bodies__transition",

	CanStart = function (thisConvo, queue)
		return IsSpartanAbleToSpeak(SPARTANS.buck); -- GAMMA_CONDITION
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
				return not b_player_entered_sinkhole;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Arbiter's an ally, so these dead here are our brothers as far as I'm concerned.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_04600.sound'),

			sleepAfter = 0.3,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_player_entered_sinkhole;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Agreed. Time for payback.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_06300.sound'),			
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 0.5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		PrintNarrative("QUEUE - W2HubGrotto_Grotto__Sinkhole__collapsed");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__Sinkhole__collapsed);
		PrintNarrative("QUEUE - W2HubGrotto_Grotto__Sinkhole__SINKHOLE_2nd_floor_split_right");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__Sinkhole__SINKHOLE_2nd_floor_split_right);

		CreateMissionThread(Grotto__Sinkhole__SINKHOLE_covies_talk_elite_1);
		CreateMissionThread(Grotto__Sinkhole__SINKHOLE_covies_talk_grunt_1);
		CreateMissionThread(Grotto__Sinkhole__SINKHOLE_covies_talk_jackal_1);
	end,

	
};


--[========================================================================[
          Grotto. Sinkhole. collapsed

          Pressing forward, Osiris enters a cavernous sinkhole
          containing collapsed Sangheili ruins.
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__collapsed = {
	name = "W2HubGrotto_Grotto__Sinkhole__collapsed",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narrative_grotto_sinkhole_collapsed );
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
				return not IsSpartanInCombat() and volume_test_object( VOLUMES.tv_narrative_grotto_sinkhole_collapsed, SPARTANS.locke); -- GAMMA_TRANSITION: If Locke
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_speaker = SPARTANS.locke;
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "The cavern opens up here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_02500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 2; -- GAMMA_NEXT_LINE_NUMBER
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Find a way up!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_06400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return not IsSpartanInCombat() and volume_test_object( VOLUMES.tv_narrative_grotto_sinkhole_collapsed, SPARTANS.buck); -- GAMMA_TRANSITION: If Buck
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
				   thisConvo.localVariables.s_speaker = SPARTANS.buck;
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Careful, lots of cover ahead.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_01600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 4; -- GAMMA_NEXT_LINE_NUMBER
			end,
			
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 5;
			end,
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Keep your head on a swivel.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_04800.sound'),

			--playDurationAdjustment = 0.8,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return not IsSpartanInCombat() and volume_test_object( VOLUMES.tv_narrative_grotto_sinkhole_collapsed, SPARTANS.tanaka); -- GAMMA_TRANSITION: If Tanaka
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_speaker = SPARTANS.tanaka;
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Got some ruins up here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_02600.sound'),

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

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Watch out. Enemy could be anywhere.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_04200.sound'),

			--playDurationAdjustment = 0.8,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[7] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return not IsSpartanInCombat() and volume_test_object( VOLUMES.tv_narrative_grotto_sinkhole_collapsed, SPARTANS.vale); -- GAMMA_TRANSITION: If Vale
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_speaker = SPARTANS.vale;
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Collapsed ruins coming up. Watch your footing.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_03100.sound'),

			--playDurationAdjustment = 0.8,
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


----------------------------------------------


function grotto_sinkhole_snipers()

local s_speaker:object = nil;
local s_timer:number = 0;

SleepUntil([|  ai_living_count( AI.sg_pool_sniper_wave_01 ) > 1 and objects_distance_to_object( players(), ai_get_object( AI.sq_pool_sniper_03.spawnpoint_01) ) < 35], 10);

	PrintNarrative("LISTENER - grotto_sinkhole_snipers");

			repeat
				sleep_s(0.1);
				s_timer = s_timer + 0.1;
				s_speaker = spartan_look_at_object(players(), ai_get_object( AI.sq_pool_sniper_03.spawnpoint_01), 40, 7, 0.3, 1);
				
			until s_speaker ~= nil or s_timer >= 1

	if s_speaker ~= nil then

		W2HubGrotto_Grotto__Sinkhole__snipers_callout.localVariables.s_speaker = s_speaker;
		PrintNarrative("grotto_sinkhole_snipers: looker: ");

	elseif s_speaker == nil and list_count(players()) == 4 then
		PrintNarrative("grotto_sinkhole_snipers: No looker - time is out - 4 players");
		W2HubGrotto_Grotto__Sinkhole__snipers_callout.localVariables.s_speaker = AlternateSpeakerWhenEnteringVolume(VOLUMES.tv_narrative_grotto_sinkhole_sniper, 20, 2);
	else
		PrintNarrative("grotto_sinkhole_snipers: No looker - time is out - 1 to 3 players");
		W2HubGrotto_Grotto__Sinkhole__snipers_callout.localVariables.s_speaker = AlternateSpeakerWhenEnteringVolume(VOLUMES.tv_narrative_grotto_sinkhole_sniper, 20, 0);
	end

	if W2HubGrotto_Grotto__Sinkhole__collapsed.localVariables.s_speaker == s_speaker then
		W2HubGrotto_Grotto__Sinkhole__snipers_callout.localVariables.s_speaker = GetClosestMusketeer(s_speaker, 10, 2);		
	end

	if W2HubGrotto_Grotto__Sinkhole__collapsed.localVariables.s_speaker ~= s_speaker then
		NarrativeQueue.InterruptConversation(W2HubGrotto_Grotto__Sinkhole__collapsed, 0.8);
	end	

		PrintNarrative("QUEUE - W2HubGrotto_Grotto__Sinkhole__snipers_callout");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__Sinkhole__snipers_callout);
end


--[========================================================================[
          Grotto. Sinkhole. snipers callout

          A winding ridge at the far end of the sinkhole is occupied by
          several JACKAL SNIPERS.
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__snipers_callout = {
	name = "W2HubGrotto_Grotto__Sinkhole__snipers_callout",

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
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If Locke
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Snipers on that ridge ahead.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_03400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
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
			text = "Snipers on that ridge ahead.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_01000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: If Tanaka
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Snipers on that ridge ahead.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_00900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: If Vale
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Snipers on that ridge ahead.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_01200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--           Buck answers.

		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Stick to cover 'til we get 'em in range. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_02700.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);				
		CreateMissionThread(Grotto__Sinkhole__ramp);
		PrintNarrative("QUEUE - W2HubGrotto_Grotto__Sinkhole__SINKHOLE_phantom");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__Sinkhole__SINKHOLE_phantom);
		PrintNarrative("QUEUE - W2HubGrotto_Grotto__Sinkhole__go_up_2");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__Sinkhole__go_up_2);
	end,

	
	localVariables = {
					s_speaker = nil,
					},
	
};




----------------------------------------------------------------------------------------------------
function grotto_sinkhole_droppods()
	PrintNarrative("WAKE - grotto_sinkhole_droppods");

	PrintNarrative("START - grotto_sinkhole_droppods");

	local s_timer:number = 0;

	local s_pod_01:object = nil;
	local s_pod_02:object = nil;
	local s_pod_03:object = nil;	

		s_pod_01 = spartan_look_at_object(players(), OBJECTS.pod_pool_jackals_02, 20, 180, 0, 2);
		s_pod_02 = spartan_look_at_object(players(), OBJECTS.pod_pool_grunts_03, 20, 180, 0, 2);
		s_pod_03 = spartan_look_at_object(players(), OBJECTS.pod_pool_elite_01, 20, 180, 0, 2);

		print(s_pod_01, " , ", s_pod_02, " , ",s_pod_03);		

		if s_pod_01 == SPARTANS.locke or s_pod_02 == SPARTANS.locke or s_pod_03 == SPARTANS.locke then
			if list_count(players()) == 1 then
				W2HubGrotto_Grotto__Sinkhole__drop_pods.localVariables.s_speaker = GetClosestMusketeer(OBJECTS.pod_pool_grunts_03, 50, 0);
			elseif list_count(players()) < 4 then
				W2HubGrotto_Grotto__Sinkhole__drop_pods.localVariables.s_speaker = GetClosestMusketeer(OBJECTS.pod_pool_jackals_02, 20, 2);
			elseif list_count(players()) == 4 then
				W2HubGrotto_Grotto__Sinkhole__drop_pods.localVariables.s_speaker = GetClosestMusketeer(OBJECTS.pod_pool_jackals_02, 5, 2);
			end

		elseif s_pod_01 ~= nil then
			W2HubGrotto_Grotto__Sinkhole__drop_pods.localVariables.s_speaker = s_pod_01;
			sleep_s(0.5);
		elseif s_pod_02 ~= nil then
			W2HubGrotto_Grotto__Sinkhole__drop_pods.localVariables.s_speaker = s_pod_02;
			sleep_s(0.6);
		elseif s_pod_03 ~= nil then
			W2HubGrotto_Grotto__Sinkhole__drop_pods.localVariables.s_speaker = s_pod_03;
			sleep_s(0.7);
		end
			
		--sleep_s(1);

		PrintNarrative("QUEUE - W2HubGrotto_Grotto__Sinkhole__drop_pods");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__Sinkhole__drop_pods);
			
	PrintNarrative("END - grotto_sinkhole_droppods");
end



--[========================================================================[
          Grotto. Sinkhole. drop pods

          We can hear the sound of Drop pod incoming.

          Before they arrive, player call it out!
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__drop_pods = {
	name = "W2HubGrotto_Grotto__Sinkhole__drop_pods",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 2;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
		NarrativeQueue.InterruptConversation(W2HubGrotto_Grotto__Sinkhole__snipers_callout);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return false
				--return thisConvo.localVariables.s_speaker == SPARTANS.locke;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Insertion pods!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_05700.sound'),

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

			sleepBefore = 0.5,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "WHOA!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_buck_06600.sound'),

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

			sleepBefore = 0.5,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "HOLY--!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_tanaka_06600.sound'),

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

			sleepBefore = 0.6,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Whoa!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_vale_06500.sound'),

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

function Grotto__Sinkhole__ramp()

sleep_s(20);

	PrintNarrative("QUEUE - W2HubGrotto_Grotto__Sinkhole__ramp");
	NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__Sinkhole__ramp);

end



--[========================================================================[
          Grotto. Sinkhole. ramp
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__ramp = {
	name = "W2HubGrotto_Grotto__Sinkhole__ramp",

	CanStart = function (thisConvo, queue)
		return IsSpartanAbleToSpeak(SPARTANS.locke) and volume_test_players_all( VOLUMES.tv_narrative_grotto_sinkhole_bottom) and object_at_distance_and_can_see_object(SPARTANS.locke, OBJECTS.cr_sinkhole_ramp_lookat, 30, 25) and ai_living_count(AI.sg_pool_wave_01) <= 2; -- GAMMA_CONDITION
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
			text = "Push forwards Osiris! Ramp on the right!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_12000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		CreateMissionThread(Grotto__Sinkhole__go_up);
	end,
};


function Grotto__Sinkhole__go_up()

		sleep_s(10);

		repeat
				sleep_s(1);
				
				b_push_forward_test_speed = false;

				SleepUntil([| b_push_forward_vo_counrdown_on > 15 and IsSpartanAbleToSpeak(SPARTANS.buck) and IsSpartanAbleToSpeak(SPARTANS.vale) and volume_test_players_all( VOLUMES.tv_narrative_grotto_sinkhole_bottom )], 30);

		until not grotto_is_there_enemy_nearby(15)

		PrintNarrative("QUEUE - W2HubGrotto_Grotto__Sinkhole__go_up");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__Sinkhole__go_up);
end



--[========================================================================[
          Grotto. Sinkhole. go up

          If all the players stay at the bottom for too long, let's
          give them a hint to go up.
          After X sec at the bottom
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__go_up = {
	name = "W2HubGrotto_Grotto__Sinkhole__go_up",

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

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "If the Arbiter's in trouble, we should keep moving.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_02900.sound'),

			sleepAfter = 0.6,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "See the Covenant shields up the right side there? Looks like that's the way out.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_03300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();		
	end,	
};





--[========================================================================[
          Grotto. Sinkhole. go up

          If all the players stay at the bottom for too long, let's
          give them a hint to go up.
          After X sec at the bottom
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__go_up_2 = {
	name = "W2HubGrotto_Grotto__Sinkhole__go_up_2",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_timer == 3 and not b_sinkhole_reach_top and (not volume_test_players( VOLUMES.tv_narrative_grotto_sinkhole_bottom ) or (volume_test_players_all( VOLUMES.tv_narrative_grotto_sinkhole_bottom ) and NarrativeQueue.HasConversationFinished(W2HubGrotto_Grotto__Sinkhole__go_up))); -- GAMMA_CONDITION
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
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Let's find a way up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_09900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,	
};


--[========================================================================[
          Grotto. Sinkhole. SINKHOLE 2nd floor split right

          This dialogue should only play in co-op. It give info to the
          other player but nothing valuable as a single player.
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__SINKHOLE_2nd_floor_split_right = {
	name = "W2HubGrotto_Grotto__Sinkhole__SINKHOLE_2nd_floor_split_right",

	CanStart = function (thisConvo, queue)
		return (volume_test_players( VOLUMES.tv_narrative_grotto_sinkhole_split_path_right) or volume_test_players( VOLUMES.tv_narrative_grotto_sinkhole_split_path_left));
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(30);
		b_push_forward_test_speed = true;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return list_count( players() ) > 1  and volume_test_object( VOLUMES.tv_narrative_grotto_sinkhole_split_path_right, SPARTANS.locke ); -- GAMMA_TRANSITION: If Locke first. in co-op
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: locke
			text = "taking the ramp on the right! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_05500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return list_count( players() ) > 1  and volume_test_object( VOLUMES.tv_narrative_grotto_sinkhole_split_path_right, SPARTANS.buck ); -- GAMMA_TRANSITION: If Buck first. in co-op
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Taking the ramp - right side!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_04000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return list_count( players() ) > 1  and volume_test_object( VOLUMES.tv_narrative_grotto_sinkhole_split_path_right, SPARTANS.tanaka ) ; -- GAMMA_TRANSITION: If Tanaka first. in co-op
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Moving up the ramp - right side! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_03800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return list_count( players() ) > 1  and  volume_test_object( VOLUMES.tv_narrative_grotto_sinkhole_split_path_right, SPARTANS.vale ); -- GAMMA_TRANSITION: If Vale first. in co-op
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "I'm going up the ramp on the right! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_04800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},	
		[5] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return list_count( players() ) > 1  and  volume_test_object( VOLUMES.tv_narrative_grotto_sinkhole_split_path_left, SPARTANS.locke ) ; -- GAMMA_TRANSITION: If Locke first. in co-op
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: locke
			text = "I'm going up the ramp on the left! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_05600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[6] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return list_count( players() ) > 1  and  volume_test_object( VOLUMES.tv_narrative_grotto_sinkhole_split_path_left, SPARTANS.buck ); -- GAMMA_TRANSITION: If Buck first. in co-op
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "I'm on the ramp - left side!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_04100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[7] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return list_count( players() ) > 1  and  volume_test_object( VOLUMES.tv_narrative_grotto_sinkhole_split_path_left, SPARTANS.tanaka ); -- GAMMA_TRANSITION: If Tanaka first. in co-op
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Headed up the ramp - left side!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_03900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[8] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return list_count( players() ) > 1  and volume_test_object( VOLUMES.tv_narrative_grotto_sinkhole_split_path_left, SPARTANS.vale ); -- GAMMA_TRANSITION: If Vale first. in co-op
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "I'm heading up the ramp on the left! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_04900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[9] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Split up Osiris!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_12100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		
		PrintNarrative("QUEUE - W2HubGrotto_Grotto__Sinkhole__second_floor_go_up");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__Sinkhole__second_floor_go_up);

		PrintNarrative("QUEUE - W2HubGrotto_Grotto__Sinkhole__SINKHOLE_exit");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__Sinkhole__SINKHOLE_exit);

		PrintNarrative("QUEUE - W2HubGrotto_Grotto__Sinkhole__moving_out");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__Sinkhole__moving_out);

		CreateMissionThread(Grotto__Sinkhole__all_dead);
	end,
};



--[========================================================================[
          Grotto. Sinkhole. SINKHOLE phantom
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__SINKHOLE_phantom = {
	name = "W2HubGrotto_Grotto__Sinkhole__SINKHOLE_phantom",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_sinkhole_dropship_01.spawnpoint_01) > 0 and volume_test_object( VOLUMES.tv_narrative_grotto_sinkhole_phantom, ai_get_object(AI.sq_sinkhole_dropship_01.spawnpoint_01) ); -- GAMMA_CONDITION
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
				return IsSpartanAbleToSpeak(SPARTANS.buck) and (not IsPlayer(SPARTANS.buck) or objects_can_see_object( SPARTANS.buck, ai_get_object(AI.sq_sinkhole_dropship_01.spawnpoint_01), 40 ))
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "We got a Phantom!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_08100.sound'),
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return IsSpartanAbleToSpeak(SPARTANS.tanaka) and (not IsPlayer(SPARTANS.tanaka) or objects_can_see_object( SPARTANS.tanaka, ai_get_object(AI.sq_sinkhole_dropship_01.spawnpoint_01), 40 ))
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Dropship!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_tanaka_07200.sound'),
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return IsSpartanAbleToSpeak(SPARTANS.vale) and (not IsPlayer(SPARTANS.vale) or objects_can_see_object( SPARTANS.vale, ai_get_object(AI.sq_sinkhole_dropship_01.spawnpoint_01), 40 ))
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Dropship!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_vale_07200.sound'),
		},
		[4] = {
			Else = true,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "We got a Phantom!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_08100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};


---------------------------------------------------

function Grotto__Sinkhole__SINKHOLE_covies_talk_elite_1()

	PrintNarrative("START - Grotto__Sinkhole__SINKHOLE_covies_talk_elite_1");
	
	SleepUntil([| ai_living_count(AI.sg_sinkhole_all) > 0], 60);

	sleep_s(10);
	
	IsThereAnEnemyInRangeLauncher(W2HubGrotto_Grotto__Sinkhole__SINKHOLE_covies_talk_elite_1, AI.sg_sinkhole_all, ACTOR_TYPE.elite, "enemy_in_range", Grotto.goal_sinkhole, 10 );
		
end


--[========================================================================[
          Grotto. Sinkhole. SINKHOLE covies talk
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__SINKHOLE_covies_talk_elite_1 = {
	name = "W2HubGrotto_Grotto__Sinkhole__SINKHOLE_covies_talk_elite_1",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			text = "You will not save the false Arbiter!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elite01_01300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(Grotto__Sinkhole__SINKHOLE_covies_talk_elite_2);
		 
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};


---------------------------------------------------

function Grotto__Sinkhole__SINKHOLE_covies_talk_elite_2()

	PrintNarrative("START - Grotto__Sinkhole__SINKHOLE_covies_talk_elite_2");
	
	sleep_s(30);
	
	IsThereAnEnemyInRangeLauncher(W2HubGrotto_Grotto__Sinkhole__SINKHOLE_covies_talk_elite_2, AI.sg_sinkhole_all, ACTOR_TYPE.elite, "enemy_in_range", Grotto.goal_sinkhole, 10 );
		
end

--[========================================================================[
          Grotto. Sinkhole. SINKHOLE covies talk
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__SINKHOLE_covies_talk_elite_2 = {
	name = "W2HubGrotto_Grotto__Sinkhole__SINKHOLE_covies_talk_elite_2",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			text = "Are you scared Humans?!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elite01_01100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(Grotto__Sinkhole__SINKHOLE_covies_talk_elite_3);
		 
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};


---------------------------------------------------

function Grotto__Sinkhole__SINKHOLE_covies_talk_elite_3()

	sleep_s(30);

	PrintNarrative("START - Grotto__Sinkhole__SINKHOLE_covies_talk_elite_3");
	
	IsThereAnEnemyInRangeLauncher(W2HubGrotto_Grotto__Sinkhole__SINKHOLE_covies_talk_elite_3, AI.sg_sinkhole_all, ACTOR_TYPE.elite, "enemy_in_range", Grotto.goal_sinkhole, 10 );
		
end

--[========================================================================[
          Grotto. Sinkhole. SINKHOLE covies talk
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__SINKHOLE_covies_talk_elite_3 = {
	name = "W2HubGrotto_Grotto__Sinkhole__SINKHOLE_covies_talk_elite_3",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			text = "Come near and I will crush you!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elite01_01200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		 
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};


---------------------------------------------------

function Grotto__Sinkhole__SINKHOLE_covies_talk_grunt_1()

	SleepUntil([| ai_living_count(AI.sg_sinkhole_all) > 0], 60);

	sleep_s(10);

	PrintNarrative("START - Grotto__Sinkhole__SINKHOLE_covies_talk_grunt_1");
	
	IsThereAnEnemyInRangeLauncher(W2HubGrotto_Grotto__Sinkhole__SINKHOLE_covies_talk_grunt_1, AI.sg_sinkhole_all, ACTOR_TYPE.grunt, "enemy_in_range", Grotto.goal_sinkhole, 10 );
		
end

--[========================================================================[
          Grotto. Sinkhole. SINKHOLE covies talk
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__SINKHOLE_covies_talk_grunt_1 = {
	name = "W2HubGrotto_Grotto__Sinkhole__SINKHOLE_covies_talk_grunt_1",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			text = "The Arbiter is dead! The war is over!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt02_00800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		 
		CreateMissionThread(Grotto__Sinkhole__SINKHOLE_covies_talk_grunt_2);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};


---------------------------------------------------

function Grotto__Sinkhole__SINKHOLE_covies_talk_grunt_2()

	sleep_s(30);

	PrintNarrative("START - Grotto__Sinkhole__SINKHOLE_covies_talk_grunt_2");
	
	IsThereAnEnemyInRangeLauncher(W2HubGrotto_Grotto__Sinkhole__SINKHOLE_covies_talk_grunt_2, AI.sg_sinkhole_all, ACTOR_TYPE.grunt, "enemy_in_range", Grotto.goal_sinkhole, 10 );
		
end


--[========================================================================[
          Grotto. Sinkhole. SINKHOLE covies talk
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__SINKHOLE_covies_talk_grunt_2 = {
	name = "W2HubGrotto_Grotto__Sinkhole__SINKHOLE_covies_talk_grunt_2",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {

			text = "Sanghelios is ours! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt01_01500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		 
	end,

	localVariables = {
					s_enemy_in_range = nil,
					},
};


---------------------------------------------------

function Grotto__Sinkhole__SINKHOLE_covies_talk_jackal_1()
	
	SleepUntil([| ai_living_count(AI.sg_sinkhole_all) > 0], 60);

	sleep_s(30);

	PrintNarrative("START - Grotto__Sinkhole__SINKHOLE_covies_talk_jackal_1");
	
	IsThereAnEnemyInRangeLauncher(W2HubGrotto_Grotto__Sinkhole__SINKHOLE_covies_talk_jackal_1, AI.sg_sinkhole_all, ACTOR_TYPE.jackal, "enemy_in_range", Grotto.goal_sinkhole, 10 );
		
end

--[========================================================================[
          Grotto. Sinkhole. SINKHOLE covies talk
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__SINKHOLE_covies_talk_jackal_1 = {
	name = "W2HubGrotto_Grotto__Sinkhole__SINKHOLE_covies_talk_jackal_1",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {

			text = "The Arbiter has lost!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_jackal01_00200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		 
		CreateMissionThread(Grotto__Sinkhole__SINKHOLE_covies_talk_jackal_2);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};


---------------------------------------------------

function Grotto__Sinkhole__SINKHOLE_covies_talk_jackal_2()

	sleep_s(30);

	PrintNarrative("START - Grotto__Sinkhole__SINKHOLE_covies_talk_jackal_2");
	
	IsThereAnEnemyInRangeLauncher(W2HubGrotto_Grotto__Sinkhole__SINKHOLE_covies_talk_jackal_2, AI.sg_sinkhole_all, ACTOR_TYPE.jackal, "enemy_in_range", Grotto.goal_sinkhole, 10 );
		
end

--[========================================================================[
          Grotto. Sinkhole. SINKHOLE covies talk
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__SINKHOLE_covies_talk_jackal_2 = {
	name = "W2HubGrotto_Grotto__Sinkhole__SINKHOLE_covies_talk_jackal_2",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			text = "You're too late! Can't save the Arbiter!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_jackal01_00300.sound'),
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
          Grotto. Sinkhole. second floor go up

          If player spend too much time on the second floor, we remind
          him to keep going up.
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__second_floor_go_up = {
	name = "W2HubGrotto_Grotto__Sinkhole__second_floor_go_up",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_timer == 10 and not b_sinkhole_reach_top; -- GAMMA_CONDITION
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
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not b_sinkhole_reach_top; -- GAMMA_TRANSITION: If player reached the 2nd floor and After x time player not yet to the top
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Exit's above. Keep heading up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_10000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};



----------------------------------------------------------------------------------------------------
function grotto_sinkhole_droppods_up()
	PrintNarrative("WAKE - grotto_sinkhole_droppods_up");

	PrintNarrative("START - grotto_sinkhole_droppods_up");

	local s_timer:number = 0;

	local s_pod_01:object = nil;
	local s_pod_02:object = nil;
	local s_pod_03:object = nil;

	repeat
		s_timer = s_timer + 0.1;
		sleep_s(0.1);

		s_pod_01 = spartan_look_at_object(players(), OBJECTS.pod_doorway_elite_01, 30, 180, 0.1, 2);
		s_pod_02 = spartan_look_at_object(players(), OBJECTS.pod_doorway_elite_02, 30, 180, 0.1, 2);
		s_pod_03 = spartan_look_at_object(players(), OBJECTS.pod_doorway_grunts_01, 30, 180, 0.1, 2);

		print(s_pod_01, " , ", s_pod_02, " , ",s_pod_03);
		print(s_timer);

	until		s_timer >= 1
			or	s_pod_01 ~= nil or s_pod_02 ~= nil or s_pod_03 ~= nil

			if s_timer >= 2 or list_count(players()) == 1 then
				W2HubGrotto_Grotto__Sinkhole__pods_up.localVariables.s_speaker = GetClosestMusketeer(OBJECTS.pod_doorway_elite_01, 35, 0);
			elseif s_pod_01 ~= nil then
				W2HubGrotto_Grotto__Sinkhole__pods_up.localVariables.s_speaker = s_pod_01;
				print("player looked at pod01");
			elseif s_pod_02 ~= nil then
				W2HubGrotto_Grotto__Sinkhole__pods_up.localVariables.s_speaker = s_pod_02;
			elseif s_pod_03 ~= nil then
				W2HubGrotto_Grotto__Sinkhole__pods_up.localVariables.s_speaker = s_pod_03;
			end
				
			PrintNarrative("QUEUE - W2HubGrotto_Grotto__Sinkhole__pods_up");
			NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__Sinkhole__pods_up);

			
	PrintNarrative("END - grotto_sinkhole_droppods");
end


--[========================================================================[
          Grotto. Sinkhole. pods up

          When the player is almost at the top, more Drop pods fall in
          front of him.
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__pods_up = {
	name = "W2HubGrotto_Grotto__Sinkhole__pods_up",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		PushForwardVOReset(50);
	end,
	
	sleepBefore = 0.5,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
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
			text = "More Pods!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_08600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "More Pods!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_06200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "More Pods!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_05700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "More Pods!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_07100.sound'),

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
          Grotto. Sinkhole. SINKHOLE exit

          The first player to reach the Sinkhole exit informs the rest
          of the team.
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__SINKHOLE_exit = {
	name = "W2HubGrotto_Grotto__Sinkhole__SINKHOLE_exit",

	CanStart = function (thisConvo, queue)
		return  volume_test_players( VOLUMES.tv_narrative_grotto_sinkhole_exit) and volume_test_players_lookat( VOLUMES.tv_narrative_grotto_sinkhole_after_boss, 26, 25 ) ; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_sinkhole_reach_top = true;
		PushForwardVOReset(40);	
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object( VOLUMES.tv_narrative_grotto_sinkhole_exit, SPARTANS.locke ) and volume_test_player_lookat( VOLUMES.tv_narrative_grotto_sinkhole_after_boss, unit_get_player( SPARTANS.locke), 27, 26 ) ;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: locke
			text = "I'm at the top of the ridge. There's an exit up here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_02000.sound'),
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object( VOLUMES.tv_narrative_grotto_sinkhole_exit, SPARTANS.buck ) and volume_test_player_lookat( VOLUMES.tv_narrative_grotto_sinkhole_after_boss, unit_get_player(SPARTANS.buck), 27, 26 ) ;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "I'm at the top of the ridge. There's an exit up here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_01500.sound'),
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object( VOLUMES.tv_narrative_grotto_sinkhole_exit, SPARTANS.tanaka ) and volume_test_player_lookat( VOLUMES.tv_narrative_grotto_sinkhole_after_boss, unit_get_player(SPARTANS.tanaka), 27, 26 );
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "See a way out up here. Top of the ridge. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_01100.sound'),
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return  volume_test_object( VOLUMES.tv_narrative_grotto_sinkhole_exit, SPARTANS.vale ) and volume_test_player_lookat( VOLUMES.tv_narrative_grotto_sinkhole_after_boss, unit_get_player(SPARTANS.vale), 27, 26 );
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "I'm at the top of the ridge. There's an exit up here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_01400.sound'),

			sleepAfter = 0.4,
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Makhee",

			--character = 0, -- GAMMA_CHARACTER: Eliteescort (MAHKEE)
			text = "Spartans. Yes. That is the path you seek. Keep moving.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_eliteescort_02200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	
};

----------------------------------------------------------------------------------------------------


function grotto_sinkhole_elite_boss()
	PrintNarrative("WAKE - grotto_sinkhole_elite_boss");

	SleepUntil([|  volume_test_players( VOLUMES.tv_narrative_grotto_sinkhole_boss ) and ai_living_count(AI.sq_doorway_elite_05.spawnpoint_01) == 1], 10);

	PrintNarrative("START - grotto_sinkhole_elite_boss");

	PushForwardVOReset(40);	

	CreateThread(grotto_sinkhole_elite_boss_dead);	-- When Elite Boss is dead

	sleep_s(3);

		if volume_test_players( VOLUMES.tv_narrative_grotto_sinkhole_boss ) then

				PrintNarrative("QUEUE - W2HubGrotto_Grotto__Sinkhole__SINKHOLE_elite_BOSS_1");
				NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__Sinkhole__SINKHOLE_elite_BOSS_1);

				SleepUntil([|   NarrativeQueue.HasConversationFinished(W2HubGrotto_Grotto__Sinkhole__SINKHOLE_elite_BOSS_1)], 10);

				sleep_s(object_get_health(ai_get_object(AI.sq_doorway_elite_05.spawnpoint_01)) * 3);
		end
		
		if volume_test_players( VOLUMES.tv_narrative_grotto_sinkhole_boss ) then
			
				PrintNarrative("QUEUE - W2HubGrotto_Grotto__Sinkhole__SINKHOLE_elite_BOSS_2");
				NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__Sinkhole__SINKHOLE_elite_BOSS_2);

				SleepUntil([|   NarrativeQueue.HasConversationFinished(W2HubGrotto_Grotto__Sinkhole__SINKHOLE_elite_BOSS_2)], 10);

				sleep_s(object_get_health(ai_get_object(AI.sq_doorway_elite_05.spawnpoint_01)) * 2);
		end

		-- WAIT UNTIL THE BOSS SEES A PLAYER
		SleepUntil([|  volume_test_players( VOLUMES.tv_narrative_grotto_sinkhole_exit)], 10);
		
		if not b_player_is_in_corridor and ai_living_count(AI.sq_doorway_elite_05.spawnpoint_01) > 0 then

				PrintNarrative("QUEUE - W2HubGrotto_Grotto__Sinkhole__SINKHOLE_elite_BOSS_3");
				NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__Sinkhole__SINKHOLE_elite_BOSS_3);
		
				SleepUntil([|   NarrativeQueue.HasConversationFinished(W2HubGrotto_Grotto__Sinkhole__SINKHOLE_elite_BOSS_3)], 10);

				sleep_s(object_get_health(ai_get_object(AI.sq_doorway_elite_05.spawnpoint_01)) * 5);
		end
				

		if not b_player_is_in_corridor and ai_living_count(AI.sq_doorway_elite_05.spawnpoint_01) > 0 then
			
					PrintNarrative("QUEUE - W2HubGrotto_Grotto__Sinkhole__SINKHOLE_elite_BOSS_4");
					NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__Sinkhole__SINKHOLE_elite_BOSS_4);
					
					SleepUntil([|   NarrativeQueue.HasConversationFinished(W2HubGrotto_Grotto__Sinkhole__SINKHOLE_elite_BOSS_4)], 10);

					sleep_s(object_get_health(ai_get_object(AI.sq_doorway_elite_05.spawnpoint_01)) * 5);
		end

		if not b_player_is_in_corridor and ai_living_count(AI.sq_doorway_elite_05.spawnpoint_01) > 0 then
		
					PrintNarrative("QUEUE - W2HubGrotto_Grotto__Sinkhole__SINKHOLE_elite_BOSS_5");
					NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__Sinkhole__SINKHOLE_elite_BOSS_5);
		end

	

	PrintNarrative("END - grotto_sinkhole_elite_boss");


end



--[========================================================================[
          Grotto. Sinkhole. SINKHOLE elite BOSS
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__SINKHOLE_elite_BOSS_1 = {
	name = "W2HubGrotto_Grotto__Sinkhole__SINKHOLE_elite_BOSS_1",

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
			character = AI.sq_doorway_elite_05.spawnpoint_01, -- GAMMA_CHARACTER: elite02 (Cave boss)
			text = "Brothers! The humans pollute our home!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elite02_00700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		 
	end,
	
};

--[========================================================================[
          Grotto. Sinkhole. SINKHOLE elite BOSS
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__SINKHOLE_elite_BOSS_2 = {
	name = "W2HubGrotto_Grotto__Sinkhole__SINKHOLE_elite_BOSS_2",

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
			character = AI.sq_doorway_elite_05.spawnpoint_01, -- GAMMA_CHARACTER: elite02 (Cave boss)
			text = "Cleanse our home of these infidels!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elite02_00800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		 
	end,
	
};


--[========================================================================[
          Grotto. Sinkhole. SINKHOLE elite BOSS
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__SINKHOLE_elite_BOSS_3 = {
	name = "W2HubGrotto_Grotto__Sinkhole__SINKHOLE_elite_BOSS_3",

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
			character = AI.sq_doorway_elite_05.spawnpoint_01, -- GAMMA_CHARACTER: elite02 (Cave boss)
			text = "The Arbiter's time has come! Destroy these fools!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elite02_00900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		 
	end,
	
};


--[========================================================================[
          Grotto. Sinkhole. SINKHOLE elite BOSS
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__SINKHOLE_elite_BOSS_4 = {
	name = "W2HubGrotto_Grotto__Sinkhole__SINKHOLE_elite_BOSS_4",

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
			character = AI.sq_doorway_elite_05.spawnpoint_01, -- GAMMA_CHARACTER: elite02 (Cave boss)
			text = "The false Arbiter has paid for his crimes!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elite02_00100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		 
	end,
	
};



--[========================================================================[
          Grotto. Sinkhole. SINKHOLE elite BOSS
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__SINKHOLE_elite_BOSS_5 = {
	name = "W2HubGrotto_Grotto__Sinkhole__SINKHOLE_elite_BOSS_5",

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
			character = AI.sq_doorway_elite_05.spawnpoint_01, -- GAMMA_CHARACTER: elite02 (Cave boss)
			text = "You infidels cannot save the false Arbiter!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elite02_00200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		 
	end,
	
};
----------------------------------------------------------------------------------------------------
function grotto_sinkhole_elite_boss_dead()

	PrintNarrative("WAKE - grotto_sinkhole_elite_boss_dead");


	SleepUntil([|  (ai_living_count(AI.sq_doorway_elite_05.spawnpoint_01) == 0)																										--	Spartans are not in combat anymore
					or volume_test_players( VOLUMES.tv_narrative_grotto_sinkhole_after_boss) ], 60);													--	Reached Limit VOLUME. Make closest Musketeer or Leader speak.
	
	PrintNarrative("START - grotto_sinkhole_elite_boss_dead");
		
	CreateMissionThread(Grotto__Sinkhole__SINKHOLE_elite_BOSS_dead);
	
	PrintNarrative("END - grotto_sinkhole_elite_boss_dead");
end

---------------------------------------------------

function Grotto__Sinkhole__SINKHOLE_elite_BOSS_dead()

	PrintNarrative("START - Grotto__Sinkhole__SINKHOLE_elite_BOSS_dead");
		
	repeat
			sleep_s(0.5);

			SleepUntil([|  (	ai_living_count(AI.sq_doorway_elite_05.spawnpoint_01) == 0 or volume_test_players( VOLUMES.tv_narrative_grotto_sinkhole_after_boss) or b_player_is_in_corridor)
						and (	(list_count(players()) > 1 and not IsUnitDowned( SPARTANS.locke) and not IsUnitDowned( SPARTANS.buck) and not IsUnitDowned( SPARTANS.tanaka) and not IsUnitDowned( SPARTANS.vale))	
									or (list_count(players()) == 1)
							) ], 30);

			grotto_is_there_enemy_nearby(25);

	until NarrativeQueue.ConversationsPlayingCount() == 0 and ((ai_living_count(AI.sq_doorway_elite_05.spawnpoint_01) == 0 and not grotto_is_there_enemy_nearby_result)
				 or volume_test_players( VOLUMES.tv_narrative_grotto_sinkhole_after_boss) or b_player_is_in_corridor)

	PrintNarrative("QUEUE - W2HubGrotto_Grotto__Sinkhole__SINKHOLE_elite_BOSS_dead");
	NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__Sinkhole__SINKHOLE_elite_BOSS_dead);

end


--[========================================================================[
          Grotto. Sinkhole. SINKHOLE elite BOSS dead

          Whoever kills the Elite might comment on what he was saying.
          Combat should be over.
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__SINKHOLE_elite_BOSS_dead = {
	name = "W2HubGrotto_Grotto__Sinkhole__SINKHOLE_elite_BOSS_dead",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(40);
		thisConvo.localVariables.s_speaker = GetClosestMusketeer(OBJECTS.grotto_keyhole_vista, 150, 2);
		if thisConvo.localVariables.s_speaker == SPARTANS.locke then
			thisConvo.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.locke, 20, 2);
		end
	end,

	sleepBefore =  function (thisConvo, queue)
							if not IsSpartanInCombat() or volume_test_players( VOLUMES.tv_narrative_grotto_sinkhole_after_boss) or b_player_is_in_corridor then 
								return 0;
							else
								return 2;
							end;
					end,	

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not grotto_is_there_enemy_nearby_result and not b_player_is_in_corridor and thisConvo.localVariables.s_speaker == SPARTANS.vale and objects_distance_to_object(SPARTANS.vale , OBJECTS.grotto_keyhole_vista);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_vale_02200.sound'),

			sleepAfter = 1.8,
		},
		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not grotto_is_there_enemy_nearby_result and not b_player_is_in_corridor and thisConvo.localVariables.s_speaker == SPARTANS.buck and objects_distance_to_object(SPARTANS.buck , OBJECTS.grotto_keyhole_vista);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Hostiles cleared.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_buck_02500.sound'),

			sleepAfter = 1.8,
		},		
		[3] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not grotto_is_there_enemy_nearby_result and not b_player_is_in_corridor and thisConvo.localVariables.s_speaker == SPARTANS.tanaka and objects_distance_to_object(SPARTANS.tanaka , OBJECTS.grotto_keyhole_vista);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "We're clear!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_07200.sound'),

			sleepAfter = 1.8,
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,			

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "The Covenant are talking like they've already got the Arbiter beat.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_00300.sound'),		
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.5,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "If we lose the Arbiter, reaching the Guardian at Sunaion gets complicated.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_00800.sound'),
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


---------------------------------------------------

function Grotto__Sinkhole__all_dead()

	PrintNarrative("START - Grotto__Sinkhole__all_dead");
		
	repeat
			sleep_s(1);

			SleepUntil([|  IsSpartanAbleToSpeak(SPARTANS.vale)
						and ( b_player_is_in_corridor or (b_push_forward_vo_counrdown_on >= 20 and volume_test_players_all( VOLUMES.tv_narrative_grotto_sinkhole_all_dead))) ], 10);
			
			if b_player_is_in_corridor then
				CreateThread(grotto_is_there_enemy_nearby, 20);
			else
				CreateThread(grotto_is_there_enemy_nearby, 40);
			end

	until not grotto_is_there_enemy_nearby_result

	PrintNarrative("QUEUE - W2HubGrotto_Grotto__Sinkhole__all_dead");
	NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__Sinkhole__all_dead);

end

--[========================================================================[
          Grotto. Sinkhole. all dead

          If everybody is dead, comment about the collapsed ruins.
          Related to the collectibles maybe.
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__all_dead = {
	name = "W2HubGrotto_Grotto__Sinkhole__all_dead",

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
				return not b_player_saw_keyhole_phantoms;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,			

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "These are pre-Covenant Sangheili ruins... They were already ancient history before humanity built the pyramids.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_06900.sound'),

			playDurationAdjustment = 0.9,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};



--[========================================================================[
          Grotto. Sinkhole. moving out

          Only plays in co-op.
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__moving_out = {
	name = "W2HubGrotto_Grotto__Sinkhole__moving_out",

	CanStart = function (thisConvo, queue)
		return b_player_is_in_corridor and not volume_test_players_all( VOLUMES.tv_narrative_grotto_sinkhole_exit ) and list_count(players()) > 1; -- GAMMA_CONDITION
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
				return volume_test_objects( VOLUMES.tv_narrative_grotto_sinkhole_corridor, SPARTANS.locke); -- GAMMA_TRANSITION: If locke leave the sinkhole and enters the corridor and co-op player are still in the sinkhole
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "I'm moving out. On me Osiris!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_08700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_objects( VOLUMES.tv_narrative_grotto_sinkhole_corridor, SPARTANS.buck); -- GAMMA_TRANSITION: If buck leave the sinkhole and enters the corridor and co-op player are still in the sinkhole
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "I'm moving out.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_06300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_objects( VOLUMES.tv_narrative_grotto_sinkhole_corridor, SPARTANS.tanaka); -- GAMMA_TRANSITION: If tanaka leave the sinkhole and enters the corridor and co-op player are still in the sinkhole
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "I'm moving out.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_05800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_objects( VOLUMES.tv_narrative_grotto_sinkhole_corridor, SPARTANS.vale); -- GAMMA_TRANSITION: If vale leave the sinkhole and enters the corridor and co-op player are still in the sinkhole
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "I'm moving out.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_07200.sound'),

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


-- =================================================================================================                              
--  _  __________     ___    _  ____  _      ______ 
-- | |/ /  ____\ \   / / |  | |/ __ \| |    |  ____|
-- | ' /| |__   \ \_/ /| |__| | |  | | |    | |__   
-- |  < |  __|   \   / |  __  | |  | | |    |  __|  
-- | . \| |____   | |  | |  | | |__| | |____| |____ 
-- |_|\_\______|  |_|  |_|  |_|\____/|______|______|
-- =================================================================================================                                                                                
                                                  

function grotto_keyhole_load()
	PrintNarrative("LOAD - grotto_keyhole_load");
	
	PushForwardVOReset(40);	

	PrintNarrative("QUEUE - W2HubGrotto_Grotto__KEYHOLE__rearming");
	NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__KEYHOLE__rearming);

	PrintNarrative("QUEUE - W2HubGrotto_Grotto__murals___first_mural");
	NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__murals___first_mural);	

	CreateMissionThread(Grotto__KEYHOLE__Phantoms);
	CreateMissionThread(grotto_keyhole_register_ammo);	

	PrintNarrative("QUEUE - W2HubGrotto_Grotto__KEYHOLE__Phantoms");
	NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__KEYHOLE__Phantoms);

	SleepUntil([| volume_test_players( VOLUMES.tv_narrative_grotto_sinkhole_corridor)], 10);

	b_player_is_in_corridor = true;

	GoalCreateThread(Grotto.goal_keyhole, grotto_keyhole_groundpound_listener);

	SleepUntil([| volume_test_players( VOLUMES.tv_narrative_grotto_keyhole_view_hq)], 10);
	
	CreateThread(grotto_keyhole_hq_vista);
	
end

-----------------------


function grotto_keyhole_groundpound_listener()

local s_speaker:object = nil;

	SleepUntil([| object_valid( "cr_keyhole_groundpound_wall" )  ], 200);

	PrintNarrative("LISTENER - grotto_keyhole_groundpound_listener");
	if not (Collectibles_keyhole_groundpound_locke.localVariables.s_speaker and Collectibles_keyhole_groundpound_buck.localVariables.s_speaker and Collectibles_keyhole_groundpound_tanaka.localVariables.s_speaker and Collectibles_keyhole_groundpound_vale.localVariables.s_speaker) then

			repeat
					sleep_s(1);
					s_speaker = nil;

					SleepUntil([| volume_test_players(VOLUMES.tv_narrative_grotto_keyhole_groundpound) or not object_valid( "cr_keyhole_groundpound_wall" ) ], 10);

					if object_valid( "cr_keyhole_groundpound_wall") and object_get_health(OBJECTS.crate_keyhole_bashfloor_01) >= 0.9 then

							repeat
								sleep_s(0.1);
								s_speaker = spartan_look_at_object(players(), OBJECTS.cr_keyhole_groundpound_wall, 8, 30, 0.5, 1);
							until s_speaker ~= nil or not volume_test_players(VOLUMES.tv_narrative_grotto_keyhole_groundpound)
					end

					if s_speaker == SPARTANS.locke and not NarrativeQueue.HasConversationFinished(Collectibles_keyhole_groundpound_locke) then
						Collectibles_keyhole_groundpound_locke.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.locke, 10, 0);
						if Collectibles_keyhole_groundpound_locke.localVariables.s_speaker == SPARTANS.locke then
							Collectibles_keyhole_groundpound_locke.localVariables.s_speaker = nil;
						end
							
					end 

			until (NarrativeQueue.ConversationsPlayingCount() == 0 and s_speaker ~= nil) or (not object_valid( "cr_keyhole_groundpound_wall" ) or object_get_health(OBJECTS.crate_keyhole_bashfloor_01) < 0.9)

			if s_speaker == SPARTANS.locke and object_valid( "cr_keyhole_groundpound_wall" ) and not NarrativeQueue.HasConversationFinished(Collectibles_keyhole_groundpound_locke) then
												
					PrintNarrative("QUEUE - Collectibles_keyhole_groundpound_locke");
					NarrativeQueue.QueueConversation(Collectibles_keyhole_groundpound_locke);

			elseif s_speaker == SPARTANS.buck and object_valid( "cr_keyhole_groundpound_wall" ) and not NarrativeQueue.HasConversationFinished(Collectibles_keyhole_groundpound_buck)  then
				
				PrintNarrative("QUEUE - Collectibles_keyhole_groundpound_buck");
				NarrativeQueue.QueueConversation(Collectibles_keyhole_groundpound_buck);

			elseif s_speaker == SPARTANS.tanaka and object_valid( "cr_keyhole_groundpound_wall" ) and not NarrativeQueue.HasConversationFinished(Collectibles_keyhole_groundpound_tanaka)  then
				
				PrintNarrative("QUEUE - Collectibles_keyhole_groundpound_tanaka");
				NarrativeQueue.QueueConversation(Collectibles_keyhole_groundpound_tanaka);

			elseif s_speaker == SPARTANS.vale and object_valid( "cr_keyhole_groundpound_wall" ) and not NarrativeQueue.HasConversationFinished(Collectibles_keyhole_groundpound_vale)  then
				
				PrintNarrative("QUEUE - Collectibles_keyhole_groundpound_vale");
				NarrativeQueue.QueueConversation(Collectibles_keyhole_groundpound_vale);

			end
	end

	PrintNarrative("END - grotto_keyhole_groundpound_listener");
end


--[========================================================================[
          First time player find a sword
--]========================================================================]
global Collectibles_keyhole_groundpound_locke = {
	name = "Collectibles_keyhole_groundpound_locke",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.locke,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_speaker == SPARTANS.buck and not b_collectible_used and object_get_health(OBJECTS.crate_keyhole_bashfloor_01) >= 0.9;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					thisConvo.localVariables.s_speaker = true;
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Got a wall here to bust up. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_buck_06700.sound'),
		},
		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka and not b_collectible_used and object_get_health(OBJECTS.crate_keyhole_bashfloor_01) >= 0.9;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					thisConvo.localVariables.s_speaker = true;
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Wall's looking busted.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_tanaka_06700.sound'),
		},
		[3] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_speaker == SPARTANS.vale and not b_collectible_used and object_get_health(OBJECTS.crate_keyhole_bashfloor_01) >= 0.9;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					thisConvo.localVariables.s_speaker = true;
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "That wall doesn't look stable.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_vale_06700.sound'),	
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
--		CreateMissionThread(plateau_sword_listener);
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {
					s_speaker = nil,
					},
};



--[========================================================================[
          First time player find a sword
--]========================================================================]
global Collectibles_keyhole_groundpound_buck = {
	name = "Collectibles_keyhole_groundpound_buck",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.buck,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_speaker == nil and not b_collectible_used and object_get_health(OBJECTS.crate_keyhole_bashfloor_01) >= 0.9;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					thisConvo.localVariables.s_speaker = true;
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Got a wall here to bust up. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_buck_06700.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
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
          First time player find a sword
--]========================================================================]
global Collectibles_keyhole_groundpound_tanaka = {
	name = "Collectibles_keyhole_groundpound_tanaka",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.tanaka,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_speaker == nil and not b_collectible_used and object_get_health(OBJECTS.crate_keyhole_bashfloor_01) >= 0.9;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					thisConvo.localVariables.s_speaker = true;
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Wall's looking busted.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_tanaka_06700.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
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
          First time player find a sword
--]========================================================================]
global Collectibles_keyhole_groundpound_vale = {
	name = "Collectibles_keyhole_groundpound_vale",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.vale,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_speaker == nil and not b_collectible_used and object_get_health(OBJECTS.crate_keyhole_bashfloor_01) >= 0.9;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					thisConvo.localVariables.s_speaker = true;
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "That wall doesn't look stable.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_vale_06700.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
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

function grotto_keyhole_register_ammo()

PrintNarrative("START - grotto_keyhole_register_ammo");

RegisterSpartanTrackingPingObjectEvent(grotto_keyhole_pinged_ammo, OBJECTS.crate_passage_weplocker_01);
RegisterSpartanTrackingPingObjectEvent(grotto_keyhole_pinged_ammo, OBJECTS.crate_passage_weplocker_02);

end


function grotto_keyhole_pinged_ammo()

PrintNarrative("START - grotto_keyhole_pinged_ammo");
b_keyhole_ammo_pinged = true;

end

--[========================================================================[
          Grotto. KEYHOLE. rearming

          When players enter the long corridor, they have an
          opportunity to rearm there.
--]========================================================================]
global W2HubGrotto_Grotto__KEYHOLE__rearming = {
	name = "W2HubGrotto_Grotto__KEYHOLE__rearming",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narrative_grotto_sinkhole_after_boss ) and not b_player_is_in_corridor and 
					(	
						(b_keyhole_ammo_pinged and (object_at_distance_and_can_see_object(players(), OBJECTS.crate_passage_weplocker_01, 10, 30) or object_at_distance_and_can_see_object(players(), OBJECTS.crate_passage_weplocker_02, 10, 30)  ) )
						or b_push_forward_vo_counrdown_on > 10
					 );
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
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_return_players( VOLUMES.tv_narrative_grotto_sinkhole_after_boss )[1] == SPARTANS.locke; -- GAMMA_TRANSITION: if locke first goes in the corridor
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: locke
			text = "Ammo up, Osiris.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_06600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_return_players( VOLUMES.tv_narrative_grotto_sinkhole_after_boss )[1] == SPARTANS.buck; -- GAMMA_TRANSITION: if buck first goes in the corridor
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Ammo up, Osiris.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_05100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_return_players( VOLUMES.tv_narrative_grotto_sinkhole_after_boss )[1] == SPARTANS.tanaka; -- GAMMA_TRANSITION: if tanaka first goes in the corridor
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Ammo up, Osiris.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_04500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_return_players( VOLUMES.tv_narrative_grotto_sinkhole_after_boss )[1] == SPARTANS.vale; -- GAMMA_TRANSITION: if vale first goes in the corridor
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Ammo up, Osiris.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_05500.sound'),

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


function Grotto__KEYHOLE__Phantoms()

	PrintNarrative("LISTENER - Grotto__KEYHOLE__Phantoms");

	SleepUntil([| (volume_test_object( VOLUMES.tv_narrative_grotto_keyhole_flyby, AI.sq_keyhole_phantom_01 ) or volume_test_object( VOLUMES.tv_narrative_grotto_keyhole_flyby, AI.sq_keyhole_spirit_01 ) or volume_test_object( VOLUMES.tv_narrative_grotto_keyhole_flyby, AI.sq_keyhole_spirit_02 ))], 10);

	b_player_saw_keyhole_phantoms = true;
	--PrintNarrative("INTERRUPT - W2HubGrotto_Grotto__Sinkhole__all_dead");
	--NarrativeQueue.InterruptConversation(W2HubGrotto_Grotto__Sinkhole__all_dead);

end

--[========================================================================[
          Grotto. KEYHOLE. Phantoms

          Two of the Arbiter's banshees fly by, being chased by
          Covenant banshee/phantom.
--]========================================================================]
global W2HubGrotto_Grotto__KEYHOLE__Phantoms = {
	name = "W2HubGrotto_Grotto__KEYHOLE__Phantoms",

	CanStart = function (thisConvo, queue)
		return b_player_saw_keyhole_phantoms;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
		if not volume_test_players_lookat( VOLUMES.tv_narrative_grotto_keyhole_flyby_lookat, 25, 45 ) then
			thisConvo.localVariables.s_speaker = GetClosestMusketeer(OBJECTS.grotto_keyhole_vista, 100, 0);
		end

	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke or volume_test_player_lookat( VOLUMES.tv_narrative_grotto_keyhole_flyby_lookat, unit_get_player(SPARTANS.locke), 25, 45 ); -- GAMMA_TRANSITION: If Locke first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: locke
			text = "Covenant flying in. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_00500.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck or volume_test_player_lookat( VOLUMES.tv_narrative_grotto_keyhole_flyby_lookat, unit_get_player(SPARTANS.buck), 25, 45 ); -- GAMMA_TRANSITION: If Buck first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "The Arbiter's ships are on the run.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_00600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka or volume_test_player_lookat( VOLUMES.tv_narrative_grotto_keyhole_flyby_lookat, unit_get_player(SPARTANS.tanaka), 25, 45 ); -- GAMMA_TRANSITION: If Tanaka first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Looks like Covenant control the skies.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_00400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale or volume_test_player_lookat( VOLUMES.tv_narrative_grotto_keyhole_flyby_lookat, unit_get_player(SPARTANS.vale), 25, 45 ); -- GAMMA_TRANSITION: If Vale first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "The Arbiter's ships are taking heavy fire.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_00500.sound'),			

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			
			sleepBefore = 2,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BuCK
			text = "Act casual, maybe they won't notice us.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_06900.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 6;
			end,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[6] = {
			sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Covies seem convinced they can win this thing.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_06400.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[7] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "If they kill the Arbiter, they'll be well on their way.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_08500.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 1.5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateThread(grotto_keyhole_vista);		
	end,

	localVariables = {
					s_speaker = nil,
					},
};



function grotto_keyhole_vista()

	local s_speaker:object = nil;
	
	PrintNarrative("WAKE - grotto_keyhole_vista");
	
	repeat
			sleep_s(0.3);

			PrintNarrative("START - grotto_keyhole_vista");			
		
					SleepUntil([|	not IsSpartanInCombat() and object_valid("grotto_armory_vista") and not volume_test_players( VOLUMES.tv_grotto_keyhole_collect ) and not b_collectible_used
									and (IsGoalActive(Grotto.goal_keyhole) and b_keyhole_end_of_flyby and object_at_distance_and_can_see_object(players(), OBJECTS.grotto_keyhole_vista, 50, 20))
										or IsGoalActive(Grotto.goal_airlock) or IsGoalActive(Grotto.goal_courtyard) ], 10);
						
					if 	IsGoalActive(Grotto.goal_keyhole) then
							s_speaker = spartan_look_at_object(players(), OBJECTS.grotto_keyhole_vista, 50, 20, 0.5, 1);					
					else
							PrintNarrative("grotto_keyhole_vista - In Courtyard - Cancelled");
					end
													
					if s_speaker == SPARTANS.locke and W2HubGrotto_Grotto__KEYHOLE__sunaion_vista_locke.localVariables.s_speaker == nil and playersMovementSpeed(SPARTANS.locke) < 2.7 then							
							PrintNarrative("QUEUE - W2HubGrotto_Grotto__KEYHOLE__sunaion_vista_locke");
							W2HubGrotto_Grotto__KEYHOLE__sunaion_vista_locke.localVariables.s_speaker = s_speaker;
							NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__KEYHOLE__sunaion_vista_locke);
					elseif s_speaker == SPARTANS.buck and W2HubGrotto_Grotto__KEYHOLE__sunaion_vista_buck.localVariables.s_speaker == nil and playersMovementSpeed(SPARTANS.buck) < 2.7 then							
							PrintNarrative("QUEUE - W2HubGrotto_Grotto__KEYHOLE__sunaion_vista_buck");
							W2HubGrotto_Grotto__KEYHOLE__sunaion_vista_buck.localVariables.s_speaker = s_speaker;
							NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__KEYHOLE__sunaion_vista_buck);
					elseif s_speaker == SPARTANS.tanaka and W2HubGrotto_Grotto__KEYHOLE__sunaion_vista_tanaka.localVariables.s_speaker == nil and playersMovementSpeed(SPARTANS.tanaka) < 2.7 then							
							PrintNarrative("QUEUE - W2HubGrotto_Grotto__KEYHOLE__sunaion_vista_tanaka");
							W2HubGrotto_Grotto__KEYHOLE__sunaion_vista_tanaka.localVariables.s_speaker = s_speaker;
							NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__KEYHOLE__sunaion_vista_tanaka);
					elseif s_speaker == SPARTANS.vale and W2HubGrotto_Grotto__KEYHOLE__sunaion_vista_vale.localVariables.s_speaker == nil and playersMovementSpeed(SPARTANS.vale) < 2.7 then							
							PrintNarrative("QUEUE - W2HubGrotto_Grotto__KEYHOLE__sunaion_vista_vale");
							W2HubGrotto_Grotto__KEYHOLE__sunaion_vista_vale.localVariables.s_speaker = s_speaker;
							NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__KEYHOLE__sunaion_vista_vale);
					end
					
		
	until (W2HubGrotto_Grotto__KEYHOLE__sunaion_vista_locke.localVariables.s_speaker ~= nil and W2HubGrotto_Grotto__KEYHOLE__sunaion_vista_buck.localVariables.s_speaker ~= nil and W2HubGrotto_Grotto__KEYHOLE__sunaion_vista_tanaka.localVariables.s_speaker ~= nil and W2HubGrotto_Grotto__KEYHOLE__sunaion_vista_vale.localVariables.s_speaker ~= nil)
			 or IsGoalActive(Grotto.goal_courtyard)

	PrintNarrative("END - grotto_keyhole_vista");	
end

--[========================================================================[
          Grotto. KEYHOLE. sunaion vista

          As you exit Sinkhole, on the center left, there is Sunaion.
          We can see a covenant fleet coming from there, towards The
          council chamber. They are still far away.
--]========================================================================]
global W2HubGrotto_Grotto__KEYHOLE__sunaion_vista_locke = {
	name = "W2HubGrotto_Grotto__KEYHOLE__sunaion_vista_locke",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.locke,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If locke look at sunaion
			end,
		
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Covenant are sending reinforcements.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_06700.sound'),
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
          Grotto. KEYHOLE. sunaion vista
--]========================================================================]
global W2HubGrotto_Grotto__KEYHOLE__sunaion_vista_buck = {
	name = "W2HubGrotto_Grotto__KEYHOLE__sunaion_vista_buck",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.buck,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: If buck look at sunaion
			end,
			
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Covenant are sending reinforcements.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_05200.sound'),
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
          Grotto. KEYHOLE. sunaion vista

          As you exit Sinkhole, on the center left, there is Sunaion.
          We can see a covenant fleet coming from there, towards The
          council chamber. They are still far away.
--]========================================================================]
global W2HubGrotto_Grotto__KEYHOLE__sunaion_vista_tanaka = {
	name = "W2HubGrotto_Grotto__KEYHOLE__sunaion_vista_tanaka",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.tanaka,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: If tanaka look at sunaion
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Covenant are sending reinforcements.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_04600.sound'),
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
          Grotto. KEYHOLE. sunaion vista

          As you exit Sinkhole, on the center left, there is Sunaion.
          We can see a covenant fleet coming from there, towards The
          council chamber. They are still far away.
--]========================================================================]
global W2HubGrotto_Grotto__KEYHOLE__sunaion_vista_vale = {
	name = "W2HubGrotto_Grotto__KEYHOLE__sunaion_vista_vale",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.vale,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: If vale look at sunaion
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Covenant are sending reinforcements.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_05600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
					s_speaker = nil
					},	
};

---------------------------------------------------------------------


function grotto_keyhole_hq_vista()

	local s_speaker:object = nil;
	
	PrintNarrative("WAKE - grotto_keyhole_hq_vista");
	PrintNarrative("START - grotto_keyhole_hq_vista");
	repeat	
					SleepUntil([| NarrativeQueue.ConversationsPlayingCount() == 0 and object_at_distance_and_can_see_object(players(), OBJECTS.grotto_keyhole_hq_vista, 55, 30, VOLUMES.tv_narrative_grotto_keyhole_view_hq) or volume_test_players( VOLUMES.tv_narrative_grotto_keyhole_view_hq_safe )], 10);

					s_speaker = spartan_look_at_object(players(), OBJECTS.grotto_keyhole_hq_vista, 55, 30, 0.2, 2);
							
					if s_speaker ~= nil then
						PrintNarrative("grotto_keyhole_hq_vista - Someone looked at the vista");
						W2HubGrotto_Grotto__KEYHOLE__HQ.localVariables.s_speaker = s_speaker;
						PrintNarrative("QUEUE - W2HubGrotto_Grotto__KEYHOLE__HQ");					
						NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__KEYHOLE__HQ);					
					elseif s_speaker == nil and volume_test_players( VOLUMES.tv_narrative_grotto_keyhole_view_hq_safe) then
						PrintNarrative("grotto_keyhole_hq_vista - Nobody looked at the vista - entered safe Volume trigger");					
						W2HubGrotto_Grotto__KEYHOLE__HQ.localVariables.s_speaker = AlternateSpeakerWhenEnteringVolume(VOLUMES.tv_narrative_grotto_keyhole_view_hq_safe, 30,  0);
						if W2HubGrotto_Grotto__KEYHOLE__HQ.localVariables.s_speaker == SPARTANS.vale then
							W2HubGrotto_Grotto__KEYHOLE__HQ.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.vale, 20, 0);
						end
						PrintNarrative("QUEUE - W2HubGrotto_Grotto__KEYHOLE__HQ");					
						NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__KEYHOLE__HQ);
					end
					
					
			--else
				--	PrintNarrative("CANCELED - tsunami_turrettown_vista - All player looked at the vista");	
			--end

	until W2HubGrotto_Grotto__KEYHOLE__HQ.localVariables.s_speaker ~= nil or IsGoalActive(Grotto.goal_armory) or volume_test_players( VOLUMES.tv_narrative_grotto_keyhole_view_hq_safe )

	PrintNarrative("END - grotto_keyhole_hq_vista");	
end

--[========================================================================[
          Grotto. KEYHOLE. HQ

          In the distant background, we can see the Council Chamber
          under heavy attack. Not in combat.
--]========================================================================]
global W2HubGrotto_Grotto__KEYHOLE__HQ = {
	name = "W2HubGrotto_Grotto__KEYHOLE__HQ",

	CanStart = function (thisConvo, queue)
		return thisConvo.localVariables.s_speaker ~= nil; -- GAMMA_CONDITION
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
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If Locke first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: locke
			text = "That building's taking a beating. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_01600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: If tanaka look at sunaion
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "That building's taking a beating. \r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_01300.sound'),
			
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: If tanaka look at sunaion
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "That building's taking a beating. \r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_01000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: If tanaka look at sunaion
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "That building's taking a beating.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_00600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			sleepBefore = 0.3,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "That's the Elder Council Chamber. Mahkee said the Arbiter was there.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_02700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		CreateMissionThread(grotto_mural_02_listener);
	end,

	localVariables = {
					s_speaker = nil
					},
	
};

-- =================================================================================================                              
--           _____  __  __  ____  _______     __
--     /\   |  __ \|  \/  |/ __ \|  __ \ \   / /
--    /  \  | |__) | \  / | |  | | |__) \ \_/ / 
--   / /\ \ |  _  /| |\/| | |  | |  _  / \   /  
--  / ____ \| | \ \| |  | | |__| | | \ \  | |   
-- /_/    \_\_|  \_\_|  |_|\____/|_|  \_\ |_|   
-- =================================================================================================                                      


function grotto_armory_load()
	PrintNarrative("LOAD - grotto_armory_load");
	

	SleepUntil([| ai_living_count( AI.sg_armory_all ) > 0], 10);
	
	PrintNarrative("QUEUE - W2HubGrotto_grotto__Armory__GRUNTS_upstairs");
	NarrativeQueue.QueueConversation(W2HubGrotto_grotto__Armory__GRUNTS_upstairs);	

	PrintNarrative("QUEUE - W2HubGrotto_grotto__Armory__Covenant_speech");
	NarrativeQueue.QueueConversation(W2HubGrotto_grotto__Armory__Covenant_speech);

	PrintNarrative("QUEUE - W2HubGrotto_grotto__Armory__Covenant_speech_interrupted");
	NarrativeQueue.QueueConversation(W2HubGrotto_grotto__Armory__Covenant_speech_interrupted);

	PrintNarrative("QUEUE - W2HubGrotto_grotto__Armory__GRUNTS_upstairs_interrupted");
	NarrativeQueue.QueueConversation(W2HubGrotto_grotto__Armory__GRUNTS_upstairs_interrupted);

	PushForwardVOReset(40);
	
	SleepUntil ([|	ai_living_count (AI.sq_armory_spirit_01) > 0 ], 20);

	CreateMissionThread(grotto_armory_spirit);

	SleepUntil ([|	ai_living_count (AI.sq_armory_hunters_01) > 0 or ai_living_count (AI.sq_armory_hunters_02) > 0], 20);

	CreateMissionThread(grotto_armory_hunters_osiris);

end



--[========================================================================[
          grotto. Armory. GRUNTS upstairs
          Vignette

          If the player entered on the left side, the player will see
          two GRUNTS carrying crates.
--]========================================================================]
global W2HubGrotto_grotto__Armory__GRUNTS_upstairs = {
	name = "W2HubGrotto_grotto__Armory__GRUNTS_upstairs",

	CanStart = function (thisConvo, queue)
		return not b_armory_elite_speaking and volume_test_players( VOLUMES.tv_narrative_grotto_armory_grunts_upstairs ) and not b_armory_floor_alerted and ai_living_count(AI.sq_armory_grunts_01) > 0;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
		b_armory_grunt_speaking = true;
	end,

	lines = {
		[1] = {
			character = AI.sq_armory_grunts_01.spawn_points_01, -- GAMMA_CHARACTER: Grunt01
			text = "We could be killing the Arbiter. Instead we're cleaning crates.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt01_00500.sound'),
		},
		[2] = {
			character = AI.sq_armory_grunts_01.spawn_points_02, -- GAMMA_CHARACTER: Grunt02
			text = "Right?! If you and me were out there, he'd be dead by now.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt02_00400.sound'),
		},
		[3] = {
			character = AI.sq_armory_grunts_01.spawn_points_01, -- GAMMA_CHARACTER: Grunt01
			text = "How hard can it be? We ambushed him. We have Krakens. I mean, come ON. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt01_00600.sound'),
		},
		[4] = {
			character = AI.sq_armory_grunts_01.spawn_points_02, -- GAMMA_CHARACTER: Grunt02
			text = "One day me and my plasma pistol will be known from one end of the galaxy to the other. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt02_00500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_armory_grunt_speaking = false;
		 
	end,	
};


--[========================================================================[
          grotto. Armory. Covenant speech
--]========================================================================]
global W2HubGrotto_grotto__Armory__Covenant_speech = {
	name = "W2HubGrotto_grotto__Armory__Covenant_speech",

	CanStart = function (thisConvo, queue)
		return not b_armory_grunt_speaking and (volume_test_players( VOLUMES.tv_narrative_grotto_armory_entrance) or volume_test_players( VOLUMES.tv_grotto_armory_below)) and not b_armory_floor_alerted; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
		PushForwardVOReset();
		b_armory_elite_speaking = true;
	end,

	lines = {
		[1] = {
			character = AI.sq_armory_elite_01.spawnpoint_01, -- GAMMA_CHARACTER: Elite01
			text = "Stay up there! They should arrive soon.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elite01_01400.sound'),
		},
		[2] = {
			character = AI.sq_armory_jrangers_02, -- GAMMA_CHARACTER: Jackal01
			text = "Looking. Nothing!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_jackal01_01500.sound'),
		},
		[3] = {
			character = AI.sq_armory_grunts_02.spawn_points_03, -- GAMMA_CHARACTER: Grunt01
			text = "Are they not supposed to be here already?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt01_01600.sound'),
		},
		[4] = {
			character = AI.sq_armory_elite_01.spawnpoint_01, -- GAMMA_CHARACTER: Elite01
			text = "Yes, the final attack on the False Arbiter is happening right now.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elite01_01500.sound'),
		},
		[5] = {
			character = AI.sq_armory_elite_01.spawnpoint_01, -- GAMMA_CHARACTER: Elite01
			text = "It shouldn't be long now.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elite01_01600.sound'),
		},
		[6] = {
			character = AI.sq_armory_elite_01.spawnpoint_01, -- GAMMA_CHARACTER: Elite01
			text = "You too Unggoy. Look out for any incoming dropship.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elite01_01700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				b_armory_elite_speaking = false;
			end,
		},
	},

	sleepAfter = 10,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2HubGrotto_grotto__Armory__Covenant_speech_2");
		NarrativeQueue.QueueConversation(W2HubGrotto_grotto__Armory__Covenant_speech_2);		
	end,
};




--[========================================================================[
          grotto. Armory. Covenant speech
--]========================================================================]
global W2HubGrotto_grotto__Armory__Covenant_speech_2 = {
	name = "W2HubGrotto_grotto__Armory__Covenant_speech_2",

	CanStart = function (thisConvo, queue)
		return not b_armory_floor_alerted; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
		PushForwardVOReset();
		b_armory_elite_speaking = true;
	end,	

	lines = {
		[1] = {
			character = AI.sq_armory_grunts_02.spawn_points_03, -- GAMMA_CHARACTER: Grunt01
			text = "Still nothing... Should we call them?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt01_01700.sound'),

		},
		[2] = {
			character = AI.sq_armory_elite_01.spawnpoint_01, -- GAMMA_CHARACTER: Elite01
			text = "No! No reason to worry. The Sword of Sanghelios have retreated.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elite01_01800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_armory_elite_speaking = false;	
	end,
};

--[========================================================================[
          grotto. Armory. GRUNTS upstairs interrupted

          If the player get near the grunts.
--]========================================================================]
global W2HubGrotto_grotto__Armory__GRUNTS_upstairs_interrupted = {
	name = "W2HubGrotto_grotto__Armory__GRUNTS_upstairs_interrupted",

	CanStart = function (thisConvo, queue)
		return ai_combat_status(AI.sq_armory_grunts_01) >= 4; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_armory_floor_alerted = true;		
		NarrativeQueue.InterruptConversation(W2HubGrotto_grotto__Armory__GRUNTS_upstairs);
		NarrativeQueue.InterruptConversation(W2HubGrotto_grotto__Armory__Covenant_speech);
		NarrativeQueue.InterruptConversation(W2HubGrotto_grotto__Armory__Covenant_speech_2);
		opportunity_area_set_active("grotto_armory_no_idle", false);
	end,

	lines = {
		[1] = {
			character = AI.sq_armory_grunts_01.spawn_points_01, -- GAMMA_CHARACTER: Grunt01
			text = "AAHHH HUMANS!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt01_00300.sound'),

			playDurationAdjustment = 0.5,
		},
		[2] = {
			character = AI.sq_armory_grunts_01.spawn_points_02, -- GAMMA_CHARACTER: Grunt01
			text = "Alert! Alert!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt01_00400.sound'),

			playDurationAdjustment = 0.5,
		},
		[3] = {
			character = AI.sq_armory_grunts_01.spawn_points_01, -- GAMMA_CHARACTER: Grunt02
			text = "HERE?! WHY??",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt02_00200.sound'),

			playDurationAdjustment = 0.5,
		},
		[4] = {
			character = AI.sq_armory_grunts_01.spawn_points_03, -- GAMMA_CHARACTER: Grunt02
			text = "Help us!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt02_00300.sound'),

			playDurationAdjustment = 0.5,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		 
	end,	
};




--[========================================================================[
          grotto. Armory. Covenant speech interrupted

          When the player is detected, the previous scene is
          interrupted.
--]========================================================================]
global W2HubGrotto_grotto__Armory__Covenant_speech_interrupted = {
	name = "W2HubGrotto_grotto__Armory__Covenant_speech_interrupted",

	CanStart = function (thisConvo, queue)
		return ai_combat_status(AI.sg_armory_elite_01) >= 5 or ai_living_count(AI.sg_armory_elite_01) == 0;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_armory_floor_alerted = true;
		opportunity_area_set_active("grotto_armory_no_idle", false);		
		NarrativeQueue.InterruptConversation(W2HubGrotto_grotto__Armory__Covenant_speech);
		NarrativeQueue.InterruptConversation(W2HubGrotto_grotto__Armory__GRUNTS_upstairs);
	end,

	lines = {
		[1] = {
			character = AI.sq_armory_elite_01.spawnpoint_01, -- GAMMA_CHARACTER: Elite01
			text = "Intruders!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elite01_01900.sound'),

			playDurationAdjustment = 0.8,
		},
		[2] = {
			character = AI.sq_armory_grunts_02.spawn_points_03, -- GAMMA_CHARACTER: Grunt02
			text = "What?? Runaway!!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt02_01700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(grotto_armory_goal_makhee_arrival);
		CreateMissionThread(grotto__Armory__Covenant_speech_interrupted_jackal_1);
	end,
};



---------------------------------------------------

function grotto__Armory__Covenant_speech_interrupted_jackal_1()

	PrintNarrative("START - grotto__Armory__Covenant_speech_interrupted_jackal_1");
	
	IsThereAnEnemyInRangeLauncher(W2HubGrotto_grotto__Armory__Covenant_speech_interrupted_jackal_1, AI.sg_armory_all, ACTOR_TYPE.jackal, "enemy_in_range", Grotto.goal_armory, 15 );
		
end

--[========================================================================[
          grotto. Armory. Covenant speech interrupted

          When the player is detected, the previous scene is
          interrupted.
--]========================================================================]
global W2HubGrotto_grotto__Armory__Covenant_speech_interrupted_jackal_1 = {
	name = "W2HubGrotto_grotto__Armory__Covenant_speech_interrupted_jackal_1",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_armory_floor_alerted = true;		
	end,

	lines = {
		[1] = {
			text = "Attack!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_jackal01_00600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		GoalCreateThread(Grotto.goal_armory, grotto__Armory__Covenant_speech_interrupted_jackal_2)
	end,

	localVariables = {
						enemy_in_range = nil,
						},

};


---------------------------------------------------

function grotto__Armory__Covenant_speech_interrupted_jackal_2()
	
	sleep_s(5);

	PrintNarrative("START - grotto__Armory__Covenant_speech_interrupted_jackal_2");
	
	IsThereAnEnemyInRangeLauncher(W2HubGrotto_grotto__Armory__Covenant_speech_interrupted_jackal_2, AI.sg_armory_all, ACTOR_TYPE.jackal, "enemy_in_range", Grotto.goal_armory, 15 );
		
end

--[========================================================================[
          grotto. Armory. Covenant speech interrupted

          When the player is detected, the previous scene is
          interrupted.
--]========================================================================]
global W2HubGrotto_grotto__Armory__Covenant_speech_interrupted_jackal_2 = {
	name = "W2HubGrotto_grotto__Armory__Covenant_speech_interrupted_jackal_2",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_armory_floor_alerted = true;		
	end,

	lines = {
		[1] = {
			text = "See Human!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_jackal01_01300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		GoalCreateThread(Grotto.goal_armory, grotto__Armory__Covenant_speech_interrupted_jackal_3)
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};




---------------------------------------------------

function grotto__Armory__Covenant_speech_interrupted_jackal_3()

	sleep_s(15);

	PrintNarrative("START - grotto__Armory__Covenant_speech_interrupted_jackal_3");
	
	IsThereAnEnemyInRangeLauncher(W2HubGrotto_grotto__Armory__Covenant_speech_interrupted_jackal_3, AI.sg_armory_all, ACTOR_TYPE.jackal, "enemy_in_range", Grotto.goal_armory, 15 );
		
end

--[========================================================================[
          grotto. Armory. Covenant speech interrupted

          When the player is detected, the previous scene is
          interrupted.
--]========================================================================]
global W2HubGrotto_grotto__Armory__Covenant_speech_interrupted_jackal_3 = {
	name = "W2HubGrotto_grotto__Armory__Covenant_speech_interrupted_jackal_3",
	

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_armory_floor_alerted = true;		
	end,

	lines = {
		[1] = {
			text = "Kill! Kill!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_jackal01_00800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		GoalCreateThread(Grotto.goal_armory, grotto__Armory__Covenant_speech_interrupted_jackal_4)
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};


---------------------------------------------------

function grotto__Armory__Covenant_speech_interrupted_jackal_4()

	sleep_s(10);

	SleepUntil([| ((ai_living_count(AI.sg_armory_jrangers_01) + ai_living_count(AI.sg_armory_jrangers_02) ) < 2) and ai_living_count(AI.sg_armory_all) <= 2  ], 10);
	
	PrintNarrative("START - grotto__Armory__Covenant_speech_interrupted_jackal_4");
	
	IsThereAnEnemyInRangeLauncher(W2HubGrotto_grotto__Armory__Covenant_speech_interrupted_jackal_4, AI.sg_armory_all, ACTOR_TYPE.jackal, "enemy_in_range", Grotto.goal_armory, 25 );
		
end

--[========================================================================[
          grotto. Armory. Covenant speech interrupted

          When the player is detected, the previous scene is
          interrupted.
--]========================================================================]
global W2HubGrotto_grotto__Armory__Covenant_speech_interrupted_jackal_4 = {
	name = "W2HubGrotto_grotto__Armory__Covenant_speech_interrupted_jackal_4",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_armory_floor_alerted = true;		
	end,

	lines = {
		[1] = {
			text = "Can't hide forever.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_jackal01_00900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(grotto__Armory__Covenant_speech_interrupted_jackal_5);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};

---------------------------------------------------

function grotto__Armory__Covenant_speech_interrupted_jackal_5()

	sleep_s(10);
	
	PrintNarrative("START - grotto__Armory__Covenant_speech_interrupted_jackal_5");
	
	IsThereAnEnemyInRangeLauncher(W2HubGrotto_grotto__Armory__Covenant_speech_interrupted_jackal_5, AI.sg_armory_all, ACTOR_TYPE.jackal, "enemy_in_range", Grotto.goal_armory, 25 );
		
end

--[========================================================================[
          grotto. Armory. Covenant speech interrupted

          When the player is detected, the previous scene is
          interrupted.
--]========================================================================]
global W2HubGrotto_grotto__Armory__Covenant_speech_interrupted_jackal_5 = {
	name = "W2HubGrotto_grotto__Armory__Covenant_speech_interrupted_jackal_5",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_armory_floor_alerted = true;		
	end,

	lines = {
		[1] = {
			text = "Can't ! Trapped!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_jackal01_01000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		
	end,

	localVariables = {
						enemy_in_range = nil,
						},

};




-----------------------------------------------------

function grotto_armory_spirit()

local s_speaker:object = nil;
local s_timer:number = 0;

	PrintNarrative("LISTENER - grotto_armory_spirit");
	
	sleep_s(1);

	repeat
		
		sleep_s(0.1);
		s_timer = s_timer + 0.1;

		if object_at_distance_and_can_see_object(players(), ai_get_object(AI.sq_armory_spirit_01), 25, 30) then
			W2HubGrotto_GROTTO__armory__ENCOUNTER_start.localVariables.s_speaker = spartan_look_at_object(players(), ai_get_object(AI.sq_armory_spirit_01), 25, 30, 0.3, 2);
		end

	until W2HubGrotto_GROTTO__armory__ENCOUNTER_start.localVariables.s_speaker ~= nil or s_timer >= 2

	if W2HubGrotto_GROTTO__armory__ENCOUNTER_start.localVariables.s_speaker == nil then
		W2HubGrotto_GROTTO__armory__ENCOUNTER_start.localVariables.s_speaker = GetClosestMusketeer(ai_get_object(AI.sq_courtyard_spirit_02), 30, 0);
	end
		PrintNarrative("QUEUE - W2HubGrotto_GROTTO__armory__ENCOUNTER_start");
		NarrativeQueue.QueueConversation(W2HubGrotto_GROTTO__armory__ENCOUNTER_start);

end
		
--[========================================================================[
          GROTTO. FALLS. ENCOUNTER start

          When Osiris see the spirit deploying troops.
--]========================================================================]
global W2HubGrotto_GROTTO__armory__ENCOUNTER_start = {
	name = "W2HubGrotto_GROTTO__armory__ENCOUNTER_start",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke and ai_living_count(AI.sq_armory_spirit_01) > 0; -- GAMMA_TRANSITION: If Locke sees covies first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Spirit inbound!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_01800.sound'),

			playDurationAdjustment = 0.8,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck and ai_living_count(AI.sq_armory_spirit_01) > 0; -- GAMMA_TRANSITION: If Buck sees covies first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Spirit inbound!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_00700.sound'),
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka and ai_living_count(AI.sq_armory_spirit_01) > 0; -- GAMMA_TRANSITION: If Tanaka sees covies first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Spirit inbound!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_00500.sound'),

			playDurationAdjustment = 0.8,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale and ai_living_count(AI.sq_armory_spirit_01) > 0; -- GAMMA_TRANSITION: If Vale sees covies first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Spirit inbound!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_00700.sound'),

			playDurationAdjustment = 0.9,
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

----------------------------------------------------------------------------------------------------
function grotto_armory_hunters_osiris()
local s_hunter01_looker:object = nil;
local s_hunter02_looker:object = nil;
local s_timer:number = 0;

	PrintNarrative("WAKE - grotto_armory_hunters_osiris");
	PrintNarrative("START - grotto_armory_hunters_osiris - Player sees the Hunters");

	CreateMissionThread(grotto__Armory__HUNTERS);

	repeat 
			sleep_s(0.1);
			s_timer = s_timer + 0.1;
			s_hunter01_looker = spartan_look_at_object(players(), ai_get_object( AI.sq_armory_hunters_01.spawn_points_0), 20, 20, 0, 2);
			s_hunter02_looker = spartan_look_at_object(players(), ai_get_object( AI.sq_armory_hunters_02.spawn_points_1), 20, 20, 0, 2);		

	until s_hunter01_looker ~= nil or s_hunter02_looker ~= nil or ((ai_combat_status(AI.sq_armory_hunters_01) > 3 or ai_combat_status(AI.sq_armory_hunters_02) > 3) and s_timer > 3)
		

	if s_timer >= 3 and s_hunter01_looker == nil and s_hunter02_looker == nil then
		s_hunter01_looker = GetClosestMusketeer(ai_get_object( AI.sq_armory_hunters_01.spawn_points_0), 20, 2);
	end

	W2HubGrotto_grotto__Armory__HUNTERS_osiris.localVariables.s_hunter01_looker = s_hunter01_looker;
	W2HubGrotto_grotto__Armory__HUNTERS_osiris.localVariables.s_hunter02_looker = s_hunter02_looker;
	
	PrintNarrative("QUEUE - W2HubGrotto_grotto__Armory__HUNTERS_osiris");
	NarrativeQueue.QueueConversation(W2HubGrotto_grotto__Armory__HUNTERS_osiris);

	PrintNarrative("END - grotto_armory_hunters_osiris");	
end

---------------------------------------------------

function grotto__Armory__HUNTERS()
	
	PrintNarrative("START - grotto__Armory__HUNTERS");
	
	IsThereAnEnemyInRangeLauncher(W2HubGrotto_grotto__Armory__HUNTERS, AI.sg_armory_all, ACTOR_TYPE.jackal, "enemy_in_range", Grotto.goal_armory, 50 );
		
end

--[========================================================================[
          grotto. Armory. HUNTERS
          ENCOUNTER

          Two HUNTERS enter the armory and attack.
--]========================================================================]
global W2HubGrotto_grotto__Armory__HUNTERS = {
	name = "W2HubGrotto_grotto__Armory__HUNTERS",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			text = "Lekgolo! Kill!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_jackal01_01400.sound'),

			playDurationAdjustment = 0.8,
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
          grotto. Armory. HUNTERS
          ENCOUNTER

          Two HUNTERS enter the armory and attack.
--]========================================================================]
global W2HubGrotto_grotto__Armory__HUNTERS_osiris = {
	name = "W2HubGrotto_grotto__Armory__HUNTERS_osiris",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_hunter01_looker == SPARTANS.locke or thisConvo.localVariables.s_hunter02_looker == SPARTANS.locke;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Hunters!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_02200.sound'),
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_hunter01_looker == SPARTANS.buck or thisConvo.localVariables.s_hunter02_looker == SPARTANS.buck;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Hunters!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_00900.sound'),
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_hunter01_looker == SPARTANS.tanaka or thisConvo.localVariables.s_hunter02_looker == SPARTANS.tanaka;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Hunters!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_01400.sound'),
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_hunter01_looker == SPARTANS.vale or thisConvo.localVariables.s_hunter02_looker == SPARTANS.vale;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Hunters!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_01000.sound'),
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 1,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Clear the area, Osiris!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_06800.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 3,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,

	localVariables = {
					s_hunter01_looker = nil,
					s_hunter02_looker = nil,
					},

	
};


----------------------------------------------------------------------------------------------------

function grotto_armory_goal_makhee_arrival()
	PrintNarrative("WAKE - grotto_armory_goal_makhee_arrival");

	SleepUntil ([|	ai_living_count (AI.sg_armory_wave_01) <= 4], 10);

	PrintNarrative("START - grotto_armory_goal_makhee_arrival");

	if ai_living_count( AI.sg_armory_all ) > 0 then	

		PrintNarrative("QUEUE - W2HubGrotto_grotto__Armory__clear_area");
		NarrativeQueue.QueueConversation(W2HubGrotto_grotto__Armory__clear_area);

	end

	sleep_s(60);

	if  ai_living_count( AI.sg_armory_all ) > 0 then

		PrintNarrative("QUEUE - W2HubGrotto_grotto__Armory__clear_area_2");
		NarrativeQueue.QueueConversation(W2HubGrotto_grotto__Armory__clear_area_2);
	end

	sleep_s(60);

	if  ai_living_count( AI.sg_armory_all ) > 0 then

		--PrintNarrative("QUEUE - W2HubGrotto_grotto__Armory__clear_area_3");
		--NarrativeQueue.QueueConversation(W2HubGrotto_grotto__Armory__clear_area_3);
	end

	PrintNarrative("END - grotto_armory_goal_makhee_arrival");
	
end


--[========================================================================[
          grotto. Armory. clear area
--]========================================================================]
global W2HubGrotto_grotto__Armory__clear_area = {
	name = "W2HubGrotto_grotto__Armory__clear_area",

	CanStart = function (thisConvo, queue)
		return ai_living_count( AI.sg_armory_all ) > 0; -- GAMMA_CONDITION
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
				return ai_living_count( AI.sg_armory_all ) > 0;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Makhee",
			--character = 0, -- GAMMA_CHARACTER: Eliteescort (MAHKEE)
			text = "Spartans, I'm coming to you now.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_eliteescort_01800.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count( AI.sg_armory_all ) > 0;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Got it Makhee. Spartans, clear the Shipmaster a landing zone.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_08900.sound'),
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



--[========================================================================[
          grotto. Armory. clear area
--]========================================================================]
global W2HubGrotto_grotto__Armory__clear_area_2 = {
	name = "W2HubGrotto_grotto__Armory__clear_area_2",

	CanStart = function (thisConvo, queue)
		return ai_living_count( AI.sg_armory_all ) > 0; -- GAMMA_CONDITION
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
				return ai_living_count( AI.sg_armory_all ) > 0;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Makhee",
			--character = 0, -- GAMMA_CHARACTER: Eliteescort (MAHKEE)
			text = "Waiting for your all clear signal, Spartan Locke.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_eliteescort_01900.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count( AI.sg_armory_all ) > 0;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Working on it, Makhee.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_09000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	
};

--[========================================================================[
          grotto. Armory. clear area
--]========================================================================]
global W2HubGrotto_grotto__Armory__clear_area_3 = {
	name = "W2HubGrotto_grotto__Armory__clear_area_3",

	CanStart = function (thisConvo, queue)
		return ai_living_count( AI.sg_armory_all ) > 0; -- GAMMA_CONDITION
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
				return ai_living_count( AI.sg_armory_all ) > 0;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Still seeing movement. Find and eliminate.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_06900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	
};
----------------------------------------------------------------------------------------------------

function grotto_armory_palmer()
	PrintNarrative("WAKE - grotto_armory_palmer");

	PrintNarrative("START - grotto_armory_palmer");

	sleep_s(1);

	PrintNarrative("QUEUE - W2HubGrotto_Grotto__armory__elite_PIP");
	NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__armory__elite_PIP);

	SleepUntil ([| grotto_mantis() ], 30);

	grotto_mantis();

end

----------------------------------------------------------------------------------------------------
function grotto_mantis()

	if object_valid("veh_keyhole_mantis_01") then
		b_mantis_01 = OBJECTS.veh_keyhole_mantis_01
		PrintNarrative("grotto_mantis - Setting up Mantis 01 Object Reference");
--	elseif object_valid("veh_mantis_test_01") then
--		b_mantis_01 = OBJECTS.veh_mantis_test_01
--		PrintNarrative("grotto_mantis - Setting up Mantis 01 Object Reference");
	end

	if object_valid("veh_keyhole_mantis_02") then
		b_mantis_02 = OBJECTS.veh_keyhole_mantis_02
		PrintNarrative("grotto_mantis - Setting up Mantis 02 Object Reference");
--	elseif object_valid("veh_mantis_test_02") then
--		b_mantis_02 = OBJECTS.veh_mantis_test_02
--		PrintNarrative("grotto_mantis - Setting up Mantis 02 Object Reference");
	end
	
	return b_mantis_01 or b_mantis_02
end


--[========================================================================[
          Grotto. armory. elite PIP

          Once everybody is dead in the armory, Mahkee contacts us
          through PIP.
--]========================================================================]
global W2HubGrotto_Grotto__armory__elite_PIP = {
	name = "W2HubGrotto_Grotto__armory__elite_PIP",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PrintNarrative("QUEUE - W2HubGrotto_grotto__Armory__troops_deploying_elite_1");
		NarrativeQueue.QueueConversation(W2HubGrotto_grotto__Armory__troops_deploying_elite_1);	
		PushForwardVOStandBy();
	end,

	sleepBefore = 1.7,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "All clear. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_05400.sound'),

			sleepAfter = 0.4,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Makhee",
			--character = 0, -- GAMMA_CHARACTER: Eliteescort (MAHKEE)
			text = "Spartans, I am approaching your position! Hold your fire! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_eliteescort_00500.sound'),

			sleepAfter = 0.6,
		},

		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Check your fire. Friendly incoming.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_07000.sound'),
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Makhee",

			sleepBefore = 0.5,

			--character = 0, -- GAMMA_CHARACTER: Eliteescort (MAHKEE)
			text = "Your Commander Palmer thought you would find these useful.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_eliteescort_00600.sound'),

			sleepAfter = 0.2,
		},
		[5] = {		
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "I do like the way she thinks.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_03600.sound'),

			sleepAfter = 0.3, 
		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Makhee",
			--character = 0, -- GAMMA_CHARACTER: Eliteescort (MAHKEE)
			text = "Covenant reinforcements move on the Elder Council Chamber.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_eliteescort_00900.sound'),

			sleepAfter = 0.3, 
		},
		[7] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Makhee",
			--character = 0, -- GAMMA_CHARACTER: Eliteescort (MAHKEE)
			text = "Time is running low Spartans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_eliteescort_01000.sound'),

			sleepAfter = 0.3, 
		},
		[8] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "We'll clear a path to the Arbiter. Just be ready for extraction.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_01300.sound'),
		},
		[9] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Makhee",
			--character = 0, -- GAMMA_CHARACTER: Eliteescort (MAHKEE)
			text = "I shall await your signal.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_eliteescort_01100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			sleepAfter = 0.7,
		},
		[10] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not vehicle_test_seat_unit_list( b_mantis_01, "mantis_d", SPARTANS.locke ) and not vehicle_test_seat_unit_list( b_mantis_02, "mantis_d", SPARTANS.locke ) ;				
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Mount up, Osiris!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_02400.sound'),
		},
		[11] = {
			Else = true,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Osiris, let's move!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_05300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PushForwardVOReset();
		-- WAKE MOUNT MANTIS LINES
		CreateMissionThread(grotto_armory_mounting_the_mantis);
		PrintNarrative("QUEUE - W2HubGrotto_grotto__Armory__troops_deploying_3");
		NarrativeQueue.QueueConversation(W2HubGrotto_grotto__Armory__troops_deploying_3);
		PrintNarrative("QUEUE - W2HubGrotto_grotto__Armory__player_in_mantis");
		NarrativeQueue.QueueConversation(W2HubGrotto_grotto__Armory__player_in_mantis);
		CreateMissionThread(grotto_armory_exit_no_mantis);
		CreateMissionThread(grotto__Armory__SeCOND_ROOM);		
		PrintNarrative("QUEUE - W2HubGrotto_grotto__Armory__troops_deploying_1");
		NarrativeQueue.QueueConversation(W2HubGrotto_grotto__Armory__troops_deploying_1);
		PrintNarrative("QUEUE - W2HubGrotto_grotto__Armory__troops_deploying_2");
		NarrativeQueue.QueueConversation(W2HubGrotto_grotto__Armory__troops_deploying_2);		
		PrintNarrative("QUEUE - W2HubGrotto_Grotto__second_room_ghost");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__second_room_ghost);		
		CreateMissionThread(grotto_mural_06_listener);
		PrintNarrative("QUEUE - W2HubGrotto_grotto__Armory_door01_open");
		NarrativeQueue.QueueConversation(W2HubGrotto_grotto__Armory_door01_open);
	end,
};

----------------------------------------------------------------------------------------------------
function grotto_armory_mounting_the_mantis()
	PrintNarrative("WAKE - grotto_armory_mounting_the_mantis");

	PrintNarrative("TIMER - grotto_armory_mounting_the_mantis - line 1");
-- WAIT 30 Sec before the next test and nag
sleep_s(30);

SleepUntil ([| not IsSpartanInCombat() ], 60);

	PrintNarrative("START - grotto_armory_mounting_the_mantis - line 1");

	if not volume_test_players( VOLUMES.tv_narrative_grotto_armory_exit_no_mantis) and not grotto_player_in_courtyard and ((object_get_health(b_mantis_01) > 0 and objects_distance_to_object( players(), b_mantis_01 ) > 5) or (object_get_health(b_mantis_02) > 0 and objects_distance_to_object( players(), b_mantis_02 ) > 5)) and not vehicle_test_seat_unit_list( b_mantis_01, "mantis_d", spartans() ) and not vehicle_test_seat_unit_list( b_mantis_02, "mantis_d", spartans() ) then

		PrintNarrative("QUEUE - W2HubGrotto_grotto__Armory__Mounting_the_mantis_1");
		NarrativeQueue.QueueConversation(W2HubGrotto_grotto__Armory__Mounting_the_mantis_1);

	end

	PrintNarrative("TIMER - grotto_armory_mounting_the_mantis - line 2");

SleepUntil ([| not IsSpartanInCombat() ], 60);

-- WAIT before the next test and nag
sleep_s(50);

	PrintNarrative("START - grotto_armory_mounting_the_mantis - line 2");

	if not volume_test_players( VOLUMES.tv_narrative_grotto_armory_exit_no_mantis) and not grotto_player_in_courtyard and ((object_get_health(b_mantis_01) > 0 and objects_distance_to_object( players(), b_mantis_01 ) > 5) or (object_get_health(b_mantis_02) > 0 and objects_distance_to_object( players(), b_mantis_02 ) > 5)) and not vehicle_test_seat_unit_list( b_mantis_01, "mantis_d", spartans() ) and not vehicle_test_seat_unit_list( b_mantis_02, "mantis_d", spartans() ) then

		PrintNarrative("QUEUE - W2HubGrotto_grotto__Armory__Mounting_the_mantis_3");
		NarrativeQueue.QueueConversation(W2HubGrotto_grotto__Armory__Mounting_the_mantis_3);

	end
	PrintNarrative("END - grotto_armory_mounting_the_mantis");
end



--[========================================================================[
          grotto. Armory. Mounting the mantis

          The player will need to get in the Mantis to continue. If X
          time passes and they don't:
--]========================================================================]
global W2HubGrotto_grotto__Armory__Mounting_the_mantis_1 = {
	name = "W2HubGrotto_grotto__Armory__Mounting_the_mantis_1",

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

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Any reason we're not using the mobile armored death-dealing exoskeletons over there? ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_02500.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Just a question.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_02400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};


--[========================================================================[
          grotto. Armory. Mounting the mantis

          The player will need to get in the Mantis to continue. If X
          time passes and they don't:
--]========================================================================]
global W2HubGrotto_grotto__Armory__Mounting_the_mantis_3 = {
	name = "W2HubGrotto_grotto__Armory__Mounting_the_mantis_3",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
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

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Palmer took the trouble to drop those Mantises. We should put 'em to good use!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_02900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,	
};


--[========================================================================[
          grotto. Armory. player in mantis

          When the player is in a Mantis.
--]========================================================================]
global W2HubGrotto_grotto__Armory__player_in_mantis = {
	name = "W2HubGrotto_grotto__Armory__player_in_mantis",

	CanStart = function (thisConvo, queue)
		return  list_count(players()) > 1 and	(	(object_valid("veh_keyhole_mantis_01") and vehicle_test_seat_unit_list( b_mantis_01, "mantis_d", spartans() )) 
													or ( object_valid("veh_keyhole_mantis_02") and vehicle_test_seat_unit_list( b_mantis_02, "mantis_d", spartans() ))	);
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
			If = function (thisLine, thisConvo, queue, lineNumber)
				return vehicle_test_seat_unit_list( b_mantis_01, "mantis_d", SPARTANS.locke ) or vehicle_test_seat_unit_list( b_mantis_02, "mantis_d", SPARTANS.locke ); -- GAMMA_TRANSITION: If Locke when 2 players or more
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Mounted up and ready to move! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_03500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return vehicle_test_seat_unit_list( b_mantis_01, "mantis_d", SPARTANS.buck ) or vehicle_test_seat_unit_list( b_mantis_02, "mantis_d", SPARTANS.buck ) ; -- GAMMA_TRANSITION: If Buck when 2 players or more
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Mounted up and ready to move!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_01100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return vehicle_test_seat_unit_list( b_mantis_01, "mantis_d", SPARTANS.tanaka ) or vehicle_test_seat_unit_list( b_mantis_02, "mantis_d", SPARTANS.tanaka ) ; -- GAMMA_TRANSITION: If Tanaka when 2 players or more
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Mounted up and ready to move!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_01600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return vehicle_test_seat_unit_list( b_mantis_01, "mantis_d", SPARTANS.vale ) or vehicle_test_seat_unit_list( b_mantis_02, "mantis_d", SPARTANS.vale ); -- GAMMA_TRANSITION: If Vale when 2 players or more
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Mounted up and ready to move!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_01800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Osiris, let's go win the Arbiter's eternal trust and gratitude.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_03000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	
};





--[========================================================================[
          grotto. Armory. troops deploying

          THE ARBITER'S ELITES are deploying from the Phantoms and
          taking up positions around the plaza. As they do:
--]========================================================================]
global W2HubGrotto_grotto__Armory__troops_deploying_elite_1 = {
	name = "W2HubGrotto_grotto__Armory__troops_deploying_elite_1",


	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_armory_arby_03.spawn_points_02) > 0; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(20);
	end,

	lines = {
		[1] = {
			character = AI.sq_armory_arby_02.spawn_points_0, -- GAMMA_CHARACTER: ELITEFRIEND01
			text = "Secure the area!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elitefriend01_00200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		PrintNarrative("QUEUE - W2HubGrotto_grotto__Armory__troops_deploying_elite_2");
		NarrativeQueue.QueueConversation(W2HubGrotto_grotto__Armory__troops_deploying_elite_2);
	end,

	sleepAfter = 0,
};


--[========================================================================[
          grotto. Armory. troops deploying

          THE ARBITER'S ELITES are deploying from the Phantoms and
          taking up positions around the plaza. As they do:
--]========================================================================]
global W2HubGrotto_grotto__Armory__troops_deploying_elite_2 = {
	name = "W2HubGrotto_grotto__Armory__troops_deploying_elite_2",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_armory_arby_02.spawn_points_0); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(20);
	end,

	lines = {
		[1] = {
			character = AI.sq_armory_arby_02.spawn_points_0, -- GAMMA_CHARACTER: ELITEFRIEND01
			text = "Take position near the entrance!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elitefriend02_00200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2HubGrotto_grotto__Armory__troops_deploying_elite_1bis");
		NarrativeQueue.QueueConversation(W2HubGrotto_grotto__Armory__troops_deploying_elite_1bis);
	end,
};


--[========================================================================[
          grotto. Armory. troops deploying

          THE ARBITER'S ELITES are deploying from the Phantoms and
          taking up positions around the plaza. As they do:
--]========================================================================]
global W2HubGrotto_grotto__Armory__troops_deploying_elite_1bis = {
	name = "W2HubGrotto_grotto__Armory__troops_deploying_elite_1bis",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_armory_arby_02.spawn_points_0); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 2,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(20);
	end,

	lines = {
		[1] = {
			character = AI.sq_armory_arby_02.spawn_points_0, -- GAMMA_CHARACTER: ELITEFRIEND01
			text = "You! Open the door for the Humans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elitefriend01_00300.sound'),
		},
	},

	sleepAfter = 3,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,	
};


--[========================================================================[
          grotto. Armory. air lock

          If player is still looking around the Armory, to help me
          focus on what's happening, we can have the Elite opening the
          door, calling it out.
--]========================================================================]
global W2HubGrotto_grotto__Armory__troops_deploying_1 = {
	name = "W2HubGrotto_grotto__Armory__troops_deploying_1",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_armory_arby_02.spawn_points_0) == 1 and objects_distance_to_object( players(), ai_get_object(AI.sq_armory_arby_02.spawn_points_0) ) < 3; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,
	
	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 30;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(20);
	end,

	lines = {
		[1] = {
			character = AI.sq_armory_arby_02.spawn_points_0, -- GAMMA_CHARACTER: ELITEFRIEND02
			text = "Victory to clan and kin!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elitefriend02_00800.sound'),
		},
	},

	sleepAfter = 5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2HubGrotto_grotto__Armory__troops_deploying_2bis");
		NarrativeQueue.QueueConversation(W2HubGrotto_grotto__Armory__troops_deploying_2bis);
	end,
};


--[========================================================================[
          grotto. Armory. air lock

          If player is still looking around the Armory, to help me
          focus on what's happening, we can have the Elite opening the
          door, calling it out.
--]========================================================================]
global W2HubGrotto_grotto__Armory__troops_deploying_2 = {
	name = "W2HubGrotto_grotto__Armory__troops_deploying_2",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_armory_arby_03.spawn_points_0) == 1 and objects_distance_to_object( players(), ai_get_object(AI.sq_armory_arby_03.spawn_points_0) ) < 2 and not IsSpartanInCombat(); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,
	
	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 30;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(20);
	end,

	lines = {
		[1] = {
			character = AI.sq_armory_arby_03.spawn_points_0, -- GAMMA_CHARACTER: ELITEFRIEND01
			text = "The area is clear!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elitefriend01_00400.sound'),
		},
	},

	sleepAfter = 5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		
	end,	
};


--[========================================================================[
          grotto. Armory. air lock

          If player is still looking around the Armory, to help me
          focus on what's happening, we can have the Elite opening the
          door, calling it out.
--]========================================================================]
global W2HubGrotto_grotto__Armory__troops_deploying_2bis = {
	name = "W2HubGrotto_grotto__Armory__troops_deploying_2bis",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_armory_arby_03.spawn_points_0) == 1 and objects_distance_to_object( players(), ai_get_object(AI.sq_armory_arby_03.spawn_points_0) ) < 3; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,
	
	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 30;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(20);
	end,

	lines = {
		[1] = {
			character = AI.sq_armory_arby_03.spawn_points_0, -- GAMMA_CHARACTER: ELITEFRIEND01
			text = "We are in position.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elitefriend01_00100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,	
};

--[========================================================================[
          grotto. Armory. air lock

          If player is still looking around the Armory, to help me
          focus on what's happening, we can have the Elite opening the
          door, calling it out.
--]========================================================================]
global W2HubGrotto_grotto__Armory__troops_deploying_3 = {
	name = "W2HubGrotto_grotto__Armory__troops_deploying_3",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_armory_arby_03.spawn_points_0) == 1 and objects_distance_to_object( players(), ai_get_object(AI.sq_armory_arby_03.spawn_points_0) ) < 10 and not IsSpartanInCombat(); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,
	
	OnInitialize = function(thisConvo, queue)
		PushForwardVOReset(20);
		CreateThread(grotto_is_there_enemy_nearby, 30);
	end,

	sleepBefore = 0.5,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,	

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not grotto_is_there_enemy_nearby_result and not IsSpartanInCombat();
			end,

			character = AI.sq_armory_arby_03.spawn_points_0, -- GAMMA_CHARACTER: ELITEFRIEND01
			text = "No targets in sight.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elitefriend02_00500.sound'),
		},
	},

	sleepAfter = 5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2HubGrotto_grotto__Armory__troops_deploying_3bis");
		NarrativeQueue.QueueConversation(W2HubGrotto_grotto__Armory__troops_deploying_3bis);
	end,	
};


--[========================================================================[
          grotto. Armory. air lock

          If player is still looking around the Armory, to help me
          focus on what's happening, we can have the Elite opening the
          door, calling it out.
--]========================================================================]
global W2HubGrotto_grotto__Armory__troops_deploying_3bis = {
	name = "W2HubGrotto_grotto__Armory__troops_deploying_3bis",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_armory_arby_03.spawn_points_0) == 1 and objects_distance_to_object( players(), ai_get_object(AI.sq_armory_arby_03.spawn_points_0) ) < 3; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,
	
	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 30;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(20);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return objects_distance_to_object( SPARTANS.vale, ai_get_object(AI.sq_armory_arby_03.spawn_points_0) ) <= 3;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			character = AI.sq_armory_arby_03.spawn_points_0, -- GAMMA_CHARACTER: ELITEFRIEND02
			text = "Victory to clan and kin!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elitefriend02_01100.sound'),
			
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[3] = {
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Victory to your clan and kin, Warrior.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_06200.sound'),
		},
	},

	sleepAfter = 5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2HubGrotto_grotto__Armory__troops_deploying_3ter");
		NarrativeQueue.QueueConversation(W2HubGrotto_grotto__Armory__troops_deploying_3ter);
	end,	
};

--[========================================================================[
          grotto. Armory. air lock

          If player is still looking around the Armory, to help me
          focus on what's happening, we can have the Elite opening the
          door, calling it out.
--]========================================================================]
global W2HubGrotto_grotto__Armory__troops_deploying_3ter = {
	name = "W2HubGrotto_grotto__Armory__troops_deploying_3ter",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_armory_arby_03.spawn_points_0) == 1 and objects_distance_to_object( players(), ai_get_object(AI.sq_armory_arby_03.spawn_points_0) ) < 10; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,
	
	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 30;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(20);
	end,

	lines = {
		[1] = {
			character = AI.sq_armory_arby_03.spawn_points_0, -- GAMMA_CHARACTER: ELITEFRIEND01
			text = "Securing the position!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elitefriend02_00400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,	
};



--[========================================================================[
          grotto. Armory. Arbiter ELITES opening the door
--]========================================================================]
global W2HubGrotto_grotto__Armory_door01_open = {
	name = "W2HubGrotto_grotto__Armory_door01_open",

	CanStart = function (thisConvo, queue)
		return (armory_door_01_safety_activated or b_grotto_armory_door01_open) and ai_living_count(AI.sq_armory_arby_01.spawn_points_0) == 1; -- GAMMA_CONDITION
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
			character = AI.sq_armory_arby_01.spawn_points_0, -- GAMMA_CHARACTER: ELITEFRIEND02
			text = "The way is open for you Spartans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elitefriend02_00900.sound'),
		},
	},

	sleepAfter = 15,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2HubGrotto_grotto__Armory__air_lockter");
		NarrativeQueue.QueueConversation(W2HubGrotto_grotto__Armory__air_lockter);
	end,

};

--[========================================================================[
          grotto. Armory. air lock

          If player is still looking around the Armory, to help me
          focus on what's happening, we can have the Elite opening the
          door, calling it out.
--]========================================================================]
global W2HubGrotto_grotto__Armory__air_lockter = {
	name = "W2HubGrotto_grotto__Armory__air_lockter",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_armory_arby_01.spawn_points_0) == 1 and objects_distance_to_object( players(), ai_get_object(AI.sq_armory_arby_01.spawn_points_0) ) < 6; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,
	
	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 30;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			character = AI.sq_armory_arby_01.spawn_points_0, -- GAMMA_CHARACTER: ELITEFRIEND02
			text = "We shall secure this armory, Spartans. The way ahead is clear for you. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elitefriend02_00700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,	
};

----------------------------------------------------------------------------------------------------
function grotto_armory_exit_no_mantis()
	PrintNarrative("WAKE - grotto_armory_exit_no_mantis");
	SleepUntil([| volume_test_players( VOLUMES.tv_narrative_grotto_armory_exit_no_mantis)
					and  (object_get_health(b_mantis_01) > 0 or object_get_health(b_mantis_02) > 0) and (not vehicle_test_seat_unit_list( b_mantis_01, "mantis_d", spartans() ) and not vehicle_test_seat_unit_list( b_mantis_02, "mantis_d", spartans() ))   ], 10);				
	
	PrintNarrative("START - grotto_armory_exit_no_mantis");

	W2HubGrotto_Grotto__armory__exit_no_mantis.localVariables.s_speaker = AlternateSpeakerWhenEnteringVolume(VOLUMES.tv_narrative_grotto_armory_exit_no_mantis, 20, 2)
	PrintNarrative("QUEUE - W2HubGrotto_Grotto__armory__exit_no_mantis");
	NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__armory__exit_no_mantis);

	PrintNarrative("END - grotto_armory_exit_no_mantis");
end



--[========================================================================[
          Grotto. armory. exit no mantis

          If the player leaves the armory (first room) without the
          Mantis, a Spartan next to the player will say something.
--]========================================================================]
global W2HubGrotto_Grotto__armory__exit_no_mantis = {
	name = "W2HubGrotto_Grotto__armory__exit_no_mantis",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If locke is the first leaving
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Let's not leave those Mantises behind.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_05100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: If Buck is the first leaving
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "They brought us Mantises, people. Let's use 'em!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_02600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: If Tanaka is the first leaving
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Got a feeling a Mantis is gonna come in handy.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_02400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: If vale is the first leaving
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Are we sure we want to leave those Mantises behind?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_04200.sound'),

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
					s_speaker = nil
					},
};


function grotto__Armory__SeCOND_ROOM()
local speaker:object = nil;
local s_timer:number = 0;
	SleepUntil([| armory_door_01_activated or armory_door_01_safety_activated], 10);
	
	PrintNarrative("QUEUE - W2HubGrotto_grotto__Armory_door02");
	NarrativeQueue.QueueConversation(W2HubGrotto_grotto__Armory_door02);		

	PrintNarrative("QUEUE - W2HubGrotto_grotto__Armory__SeCOND_ROOM");
	NarrativeQueue.QueueConversation(W2HubGrotto_grotto__Armory__SeCOND_ROOM);

	speaker = spartan_look_at_object(players(), OBJECTS.cr_armory_lookat_covies, 25, 40, 0.2, 2);

	if speaker == nil then
		speaker = GetClosestMusketeer(OBJECTS.cr_armory_lookat_covies, 40, 0);
	end

	if speaker == nil then 
		SleepUntil([| volume_test_players( VOLUMES.tv_narrative_grotto_armory_second_room_entrance )], 10);

		speaker = volume_return_players( VOLUMES.tv_narrative_grotto_armory_second_room_entrance)[1];
	end

	if speaker == nil then
		speaker = GetClosestMusketeer(OBJECTS.cr_armory_lookat_covies, 40, 2);
	end

	W2HubGrotto_grotto__Armory__SeCOND_ROOM.localVariables.s_speaker = speaker;

	speaker = nil;

	SleepUntil([| ai_living_count(AI.sq_airlock_dropship_01.spawnpoint_01) > 0], 10);
	
	PrintNarrative("Dropship Present");

	repeat		
		speaker = spartan_look_at_object(players(), ai_get_object(AI.sg_airlock_dropship_01), 25, 40, 0.2, 2);
		sleep_s(0.1)
		s_timer = s_timer + 0.1;
			
	until speaker ~= nil or s_timer >= 3

	print("01 ", speaker);

	if speaker == nil then
		print("02 ", speaker);
		speaker = GetClosestMusketeer(ai_get_object(AI.sg_airlock_dropship_01), 50, 2);		
	end

	if speaker == SPARTANS.locke then
		speaker = GetClosestMusketeer(SPARTANS.locke, 30, 0);
		print("03 ", speaker);
	end

	print("04 ", speaker);

	if not IsPlayer(speaker) then
			GlobalsOsiris_airlock_dropship.localVariables.s_musketeer = true;
	end

	print("05 ", speaker);

	GlobalsOsiris_airlock_dropship.localVariables.s_speaker = speaker;	

	PrintNarrative("QUEUE - GlobalsOsiris_airlock_dropship");
	NarrativeQueue.QueueConversation(GlobalsOsiris_airlock_dropship);
end


--[========================================================================[
          grotto. Armory. SeCOND ROOM

          When entering the second room, Covenant dropships bring
          troops in the room.
--]========================================================================]
global W2HubGrotto_grotto__Armory__SeCOND_ROOM = {
	name = "W2HubGrotto_grotto__Armory__SeCOND_ROOM",

	CanStart = function (thisConvo, queue)
		return thisConvo.localVariables.s_speaker ~= nil;
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
				return thisConvo.localVariables.s_speaker == SPARTANS.locke;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Incoming! On me Osiris!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_07100.sound'),

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
			text = "Enemy incoming! Let's go Osiris!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_05300.sound'),

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
			text = "Enemy incoming! Let's go Osiris!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_04700.sound'),

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
			text = "Enemy incoming! Let's go Osiris!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_05700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		CreateMissionThread(Grotto__second_room_ghost_listener);
		CreateMissionThread(Grotto__second_room_still_enemies);		
		CreateMissionThread(grotto__Armory__airlock_clear_listener);
	end,
	
	localVariables = {
					s_speaker = nil,
					},
};




--[========================================================================[
          Encourage the player to ammo up.
--]========================================================================]
global GlobalsOsiris_airlock_dropship = {
	name = "GlobalsOsiris_airlock_dropship",

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
				return false
				--return thisConvo.localVariables.s_speaker == SPARTANS.buck and thisConvo.localVariables.s_musketeer == true;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Look up!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_buck_04800.sound'),
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Dropship!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_buck_07900.sound'),
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return false
				--return thisConvo.localVariables.s_speaker == SPARTANS.tanaka and thisConvo.localVariables.s_musketeer == true;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Look up!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_tanaka_04800.sound'),
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Dropship!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_tanaka_07200.sound'),
		},
		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale and thisConvo.localVariables.s_musketeer == true;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Look up!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_vale_04800.sound'),
		},
		[6] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale;
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Dropship!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_vale_07200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {
					s_speaker = nil,
					s_musketeer = nil,
					},
};


function Grotto__second_room_ghost_listener()

PrintNarrative("START - Grotto__second_room_ghost_listener");

RegisterSpartanTrackingPingObjectEvent(Grotto__second_room_ghost_launcher, OBJECTS.veh_airlock_ghost_01);

end

function Grotto__second_room_ghost_launcher(objectpinged:object, pinger:object)

PrintNarrative("START - Grotto__second_room_ghost_launcher");
	if objects_distance_to_object( players(), OBJECTS.veh_airlock_ghost_01 ) < 20 then
		b_ghost_armory_was_pinged = true;
		if pinger == SPARTANS.locke then
			print("locke");
			W2HubGrotto_Grotto__second_room_ghost.localVariables.s_speaker = SPARTANS.locke
		elseif pinger == SPARTANS.buck then
			print("buck");
			W2HubGrotto_Grotto__second_room_ghost.localVariables.s_speaker = SPARTANS.buck
		elseif pinger == SPARTANS.tanaka then
			print("tanaka");
			W2HubGrotto_Grotto__second_room_ghost.localVariables.s_speaker = SPARTANS.tanaka
		elseif pinger == SPARTANS.vale then
			print("Vale");
			W2HubGrotto_Grotto__second_room_ghost.localVariables.s_speaker = SPARTANS.vale
		end
	else
		PrintNarrative("Grotto__second_room_ghost_launcher: too far");
		Grotto__second_room_ghost_listener();
	end
end


--[========================================================================[
         W2HubGrotto_Grotto__second_room_ghost

--]========================================================================]
global W2HubGrotto_Grotto__second_room_ghost = {
	name = "W2HubGrotto_Grotto__second_room_ghost",

	CanStart = function (thisConvo, queue)
		return object_at_distance_and_can_see_object(players(), OBJECTS.veh_airlock_ghost_01, 25, 20, VOLUMES.tv_grotto_armory_ghost) or b_ghost_armory_was_pinged;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
		if b_ghost_armory_was_pinged then
			thisConvo.localVariables.s_speaker = GetClosestMusketeer(OBJECTS.veh_airlock_ghost_01, 27, 0);
		end
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return object_at_distance_and_can_see_object(SPARTANS.locke, OBJECTS.veh_airlock_ghost_01, 15, 30, VOLUMES.tv_grotto_armory_ghost) or (thisConvo.localVariables.s_speaker == SPARTANS.locke and b_ghost_armory_was_pinged);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Ghost here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_03700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 2; -- GAMMA_NEXT_LINE_NUMBER
			end,
			
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,

		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BucK
			text = "Good find.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_07000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return object_at_distance_and_can_see_object(SPARTANS.buck, OBJECTS.veh_airlock_ghost_01, 15, 30, VOLUMES.tv_grotto_armory_ghost) or (thisConvo.localVariables.s_speaker == SPARTANS.buck and b_ghost_armory_was_pinged);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Ghost here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_01900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 4; -- GAMMA_NEXT_LINE_NUMBER
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 5;
			end,
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Good find, Buck.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_10100.sound'),
			
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return object_at_distance_and_can_see_object(SPARTANS.tanaka, OBJECTS.veh_airlock_ghost_01, 15, 30, VOLUMES.tv_grotto_armory_ghost) or (thisConvo.localVariables.s_speaker == SPARTANS.tanaka and b_ghost_armory_was_pinged);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Ghost here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_01800.sound'),

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

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Good find, Tanaka.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_10200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[7] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return object_at_distance_and_can_see_object(SPARTANS.vale, OBJECTS.veh_airlock_ghost_01, 15, 30, VOLUMES.tv_grotto_armory_ghost) or (thisConvo.localVariables.s_speaker == SPARTANS.vale and b_ghost_armory_was_pinged);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Ghost here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_02000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 8; -- GAMMA_NEXT_LINE_NUMBER
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},		
		[8] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Good find, Vale.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_10300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[9] = {			
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Mount up, we gonna need all the fire power we can get.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_12200.sound'),
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


function Grotto__second_room_still_enemies()

PrintNarrative("START - Grotto__second_room_still_enemies");

sleep_s(40);

if ai_living_count(AI.sg_airlock_all) > 0 then

	PrintNarrative("QUEUE - W2HubGrotto_Grotto__second_room_still_enemies");
	NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__second_room_still_enemies);

end

PrintNarrative("END - Grotto__second_room_still_enemies");

end

--[========================================================================[
          Grotto. second room. ghost
--]========================================================================]
global W2HubGrotto_Grotto__second_room_still_enemies = {
	name = "W2HubGrotto_Grotto__second_room_still_enemies",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sg_airlock_all) > 0; -- GAMMA_CONDITION
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
			text = "Clear the area from enemies Osiris.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_11700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};




function grotto__Armory__airlock_clear_listener()

	SleepUntil([| ai_living_count(AI.sg_airlock_wave_02) > 0], 1);

	sleep_s(1);

	print(" PRE ai_living_count(AI.sg_airlock_all) <= 1");

	SleepUntil([| ai_living_count(AI.sg_airlock_all) <= 1 and (ai_living_count(AI.sg_airlock_dropship_01) == 0 or objects_distance_to_object( players(), ai_get_object(AI.sg_airlock_dropship_01) ) > 50 )], 1);

	print(" POST ai_living_count(AI.sg_airlock_all) <= 1");

	local s_last_living_ai:object = ai_get_unit( AI.sg_airlock_all );

	PrintNarrative("LISTENER - grotto__Armory__airlock_clear_listener");
	print(" LAst AI alive is:  ", s_last_living_ai);

	if ai_living_count(AI.sg_airlock_all) <= 0 then
		PrintNarrative("LISTENER - grotto__Armory__airlock_clear_listener - ALL DEAD");

		CreateMissionThread(grotto__Armory__airlock_clear_launcher, s_last_living_ai, SPARTANS.locke);
	else
		RegisterDeathEvent (grotto__Armory__airlock_clear_launcher, s_last_living_ai);
	end
end
---------------------
function grotto__Armory__airlock_clear_launcher(target:object, killer:object)

	PrintNarrative("LAUNCHER - grotto__Armory__airlock_clear_launcher");

	print(killer, " is the killer of ", target);

	PrintNarrative("QUEUE - W2HubGrotto_grotto__Armory__airlock_clear");
	NarrativeQueue.QueueConversation(W2HubGrotto_grotto__Armory__airlock_clear);
	W2HubGrotto_grotto__Armory__airlock_clear.localVariables.s_speaker = killer;
end


--[========================================================================[
          grotto. Armory. air lock

          If player is still looking around the Armory, to help me
          focus on what's happening, we can have the Elite opening the
          door, calling it out.
--]========================================================================]
global W2HubGrotto_grotto__Armory__airlock_clear = {
	name = "W2HubGrotto_grotto__Armory__airlock_clear",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,
	
	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
		if thisConvo.localVariables.s_speaker == SPARTANS.locke or thisConvo.localVariables.s_speaker == nil then
			thisConvo.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.locke, 20, 2)
		end
		
	end,

	sleepBefore = 3,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_speaker == SPARTANS.buck;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "We cleared 'em.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_buck_02700.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "That's all of 'em.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_tanaka_02600.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_speaker == SPARTANS.vale;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "All clear, Spartans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_vale_02600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(grotto_mural_01_listener);
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {
					s_speaker = nil,
				},
};

function grotto__Armory__troops_deploying_1_bis()

	PrintNarrative("START - grotto__Armory__troops_deploying_1_bis");

	SleepUntil(	[|	ai_living_count(AI.sg_airlock_all) == 0], 30);

	IsThereAnEnemyInRangeLauncher(W2HubGrotto_grotto__Armory__troops_deploying_1_bis, AI.sg_armory_arbys_all, ACTOR_TYPE.elite, "enemy_in_range", Grotto.goal_airlock, 9 );
	
end

--[========================================================================[
          grotto. Armory. air lock

          If player is still looking around the Armory, to help me
          focus on what's happening, we can have the Elite opening the
          door, calling it out.
--]========================================================================]
global W2HubGrotto_grotto__Armory__troops_deploying_1_bis = {
	name = "W2HubGrotto_grotto__Armory__troops_deploying_1_bis",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_armory_arby_02.spawn_points_0) == 1 and objects_distance_to_object( players(), ai_get_object(AI.sq_armory_arby_02.spawn_points_0) ) < 3; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,
	
	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 30;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(20);
	end,

	lines = {
		[1] = {
			character = AI.sq_armory_arby_02.spawn_points_0, -- GAMMA_CHARACTER: ELITEFRIEND02
			text = "The Covenant weaklings are gone.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elitefriend02_01000.sound'),
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
          grotto. Armory. air lock

          If player is still looking around the Armory, to help me
          focus on what's happening, we can have the Elite opening the
          door, calling it out.
--]========================================================================]
global W2HubGrotto_grotto__Armory_door02 = {
	name = "W2HubGrotto_grotto__Armory_door02",

	CanStart = function (thisConvo, queue)
		return b_airlock_arby_elite_in_place and ai_living_count(AI.sq_armory_arby_02.spawn_points_0) == 1; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			character = AI.sq_armory_arby_02.spawn_points_0, -- GAMMA_CHARACTER: ELITEFRIEND02
			text = "I'll open the door for you Spartans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elitefriend02_01600.sound'),

			sleepAfter = 2,
		},
		
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2HubGrotto_grotto__Armory_door02_open");
		NarrativeQueue.QueueConversation(W2HubGrotto_grotto__Armory_door02_open);
	end,	
};



--[========================================================================[
          grotto. Armory. Arbiter ELITES opening the door
--]========================================================================]
global W2HubGrotto_grotto__Armory_door02_open = {
	name = "W2HubGrotto_grotto__Armory_door02_open",

	CanStart = function (thisConvo, queue)
		return (armory_door_02_safety_activated or b_grotto_armory_door02_open) and ai_living_count(AI.sq_armory_arby_02.spawn_points_0) == 1; -- GAMMA_CONDITION
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
			character = AI.sq_armory_arby_02.spawn_points_0, -- GAMMA_CHARACTER: ELITEFRIEND02
			text = "Opening the door!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elitefriend01_00600.sound'),
		},
		[2] = {
			character = AI.sq_armory_arby_02.spawn_points_0, -- GAMMA_CHARACTER: ELITEFRIEND02
			text = "The Council Chamber is on the other side of the Courtyard.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elitefriend02_01500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

};


-- =================================================================================================
--   _____ ____  _    _ _____ _________     __      _____  _____  
--  / ____/ __ \| |  | |  __ \__   __\ \   / //\   |  __ \|  __ \ 
-- | |   | |  | | |  | | |__) | | |   \ \_/ //  \  | |__) | |  | |
-- | |   | |  | | |  | |  _  /  | |    \   // /\ \ |  _  /| |  | |
-- | |___| |__| | |__| | | \ \  | |     | |/ ____ \| | \ \| |__| |
--  \_____\____/ \____/|_|  \_\ |_|     |_/_/    \_\_|  \_\_____/ 
-- =================================================================================================



function grotto_courtyard_load()
local s_gatehouse_is_clear:number = 1000;

	PrintNarrative("LOAD - grotto_courtyard_load");

	SleepUntil ([| current_zone_set_fully_active() == ZONE_SETS.w2_grotto_armory_advance ], 10)

	SleepUntil ([| ai_living_count(AI.sg_courtyard_wave_01_all) > 0 ], 10)

	PrintNarrative("AIDialogManager.DisableAIDialog(AI.sg_courtyard_wave_01_all)");
	AIDialogManager.DisableAIDialog(AI.sg_courtyard_wave_01_all);

	SleepUntil ([| b_courtyard_a_door_is_opening ], 10)

	sleep_s(1);

	PrintNarrative("AIDialogManager.DisableAIDialog(AI.sg_courtyard_wave_01_all)");
	AIDialogManager.EnableAIDialog(AI.sg_courtyard_wave_01_all);	

	SleepUntil ([| volume_test_players( VOLUMES.tv_narrative_grotto_courtyard_a_goal_entrance)  ], 10)

	grotto_mantis()

	PushForwardVOReset();

	PrintNarrative("QUEUE - W2HubGrotto_Grotto__courtyard_A__Entrance_covies");
	NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__courtyard_A__Entrance_covies);	

	sleep_s(5);

	PrintNarrative("QUEUE - W2HubGrotto_Grotto__courtyard_A__Entrance");
	NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__courtyard_A__Entrance);

	PrintNarrative("QUEUE - W2HubGrotto_Grotto__courtyard_A__wraith_at_the_door");
	NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__courtyard_A__wraith_at_the_door);		
		
	SleepUntil ([| volume_test_players( VOLUMES.tv_grotto_courtyard_a_half) ], 10);

	b_courtyard_a_player_passed_half = true;
	
	SleepUntil ([| b_gatehouse_door_opening ], 10);

	PrintNarrative("QUEUE - W2HubGrotto_Grotto__courtyard_B__closed_door_opening");
	NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__courtyard_B__closed_door_opening);

end


--[========================================================================[
          Grotto. courtyard A. Entrance

          When Osiris emerges from the armory into the courtyard, all-
          out WAR rages.

          LETTERBOXED CHAPTER TITLE: HORNET'S NEST

          We can see the Council chamber straight ahead. A bunch of
          grunts are fleeing in front of us, surprised by our arrival.

          In the air, a dogfight rages between Covenant and Arbiter-
          loyal Banshees.

          In combat.
--]========================================================================]
global W2HubGrotto_Grotto__courtyard_A__Entrance = {
	name = "W2HubGrotto_Grotto__courtyard_A__Entrance",


	CanStart = function (thisConvo, queue)
		return b_courtyard_a_door_is_opening  ; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		grotto_player_in_courtyard = true;
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Makhee",
			--character = 0, -- GAMMA_CHARACTER: Eliteescort (MAHKEE)
			text = "Spartans, the Elder Council Chambers are on the far side of that courtyard. Hurry. We have lost contact with Arbiter's forces within.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_eliteescort_02300.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));					
					AIDialogManager.EnableAIDialog(AI.sg_courtyard_wave_01_all);
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Copy that, Mahkee. Double time, Spartans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_10400.sound'),
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Let's get the Arbiter out of there!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_02800.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 2,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		PrintNarrative("QUEUE - W2HubGrotto_Grotto__courtyard_A__flanking_statues");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__courtyard_A__flanking_statues);
		PrintNarrative("QUEUE - W2HubGrotto_Grotto__courtyard_A__flanking_gallery");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__courtyard_A__flanking_gallery);
		CreateMissionThread(Grotto__courtyard_A__corvette_listener);
		CreateMissionThread(grotto_spirits_lookat_listener);
		CreateMissionThread(grotto_courtyard_pushforward_incombat);		
	end,
};



--[========================================================================[
          Grotto. courtyard A. Entrance covies

          When opening the door to courtyard, a bunch of enemies are
          surprised and fleeing.
--]========================================================================]
global W2HubGrotto_Grotto__courtyard_A__Entrance_covies = {
	name = "W2HubGrotto_Grotto__courtyard_A__Entrance_covies",

	CanStart = function (thisConvo, queue)
		return b_courtyard_entrance_grunt_flee; -- GAMMA_CONDITION
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
			character = AI.sq_courtyard_grunts_01.spawnpoint_01, -- GAMMA_CHARACTER: Grunt01
			text = "AAaaaaah! Run away!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt01_00100.sound'),

			playDurationAdjustment = 0.5,
		},
		[2] = {
			character = AI.sq_courtyard_grunts_01.spawnpoint_02, -- GAMMA_CHARACTER: Grunt02
			text = "Humans! Humans are here!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt02_01000.sound'),

			playDurationAdjustment = 0.8,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object( VOLUMES.tv_narrative_grotto_courtyard_a_goal_entrance, b_mantis_01) or volume_test_object( VOLUMES.tv_narrative_grotto_courtyard_a_goal_entrance, b_mantis_02); -- GAMMA_TRANSITION: If player is in a mantis
			end,

			character = AI.sq_courtyard_grunts_01.spawnpoint_03, -- GAMMA_CHARACTER: Grunt02
			text = "They have a Walking machine!!!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_grunt02_01200.sound'),

			playDurationAdjustment = 0.8,
		},
		[4] = {
			character = AI.sq_courtyard_elite_01, -- GAMMA_CHARACTER: Elite01
			text = "Do not flee Unggoy! Turn around and fight or I will kill you myself!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elite01_00700.sound'),

			playDurationAdjustment = 0.3,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		 
	end,

	
};


function Grotto__courtyard_A__corvette_listener()


		repeat
			
			SleepUntil([| IsSpartanAbleToSpeak(SPARTANS.buck) and objects_can_see_object(players(), OBJECTS.scn_hq_capitalship_01, 20)], 5);

			if objects_can_see_object(players(), OBJECTS.scn_hq_capitalship_01, 20) then
						W2HubGrotto_Grotto__courtyard_A__corvette.localVariables.looker = spartan_look_at_object(players(), OBJECTS.scn_hq_capitalship_01 , 300, 20, 0.5, 2);
			end

		until W2HubGrotto_Grotto__courtyard_A__corvette.localVariables.looker or IsGoalActive(Grotto.goal_arbiter)

				PrintNarrative("QUEUE - W2HubGrotto_Grotto__courtyard_A__corvette");
				NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__courtyard_A__corvette);

end


--[========================================================================[
          Grotto. courtyard A. cruiser

          Above the council chamber there is a Covenant cruiser
          hovering

          ***After we play the Mahkee bit above, play this:
--]========================================================================]
global W2HubGrotto_Grotto__courtyard_A__corvette = {
	name = "W2HubGrotto_Grotto__courtyard_A__corvette",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	sleepBefore = 0.7,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: bUCK
			text = "Covenant corvette overhead.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_07100.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,		
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: taNAKA
			text = "Locke, that thing can glass this courtyard in a heartbeat.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_06500.sound'),
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "We can't fight it. So let's focus on moving quickly to the Council Chamber.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_10500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	
	localVariables = {
					looker = nil,
					},
};


--[========================================================================[
          Grotto. courtyard A. flanking statues

          If player go on the right, near the statues and the stairs.

          Only in co-op.
--]========================================================================]
global W2HubGrotto_Grotto__courtyard_A__flanking_statues = {
	name = "W2HubGrotto_Grotto__courtyard_A__flanking_statues",

	CanStart = function (thisConvo, queue)
		return  volume_test_players( VOLUMES.tv_narrative_grotto_courtyard_a_flanking_statues); -- GAMMA_CONDITION
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
				return list_count(players()) > 1 and IsPlayer(SPARTANS.locke) and volume_test_object( VOLUMES.tv_narrative_grotto_courtyard_a_flanking_statues, SPARTANS.locke); -- GAMMA_TRANSITION: If Locke first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Flanking on the right, near the statues.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_04000.sound'),
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return list_count(players()) > 1 and IsPlayer(SPARTANS.buck) and volume_test_object( VOLUMES.tv_narrative_grotto_courtyard_a_flanking_statues, SPARTANS.buck); -- GAMMA_TRANSITION: If Buck first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Flanking on the right, near the statues.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_02200.sound'),
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return list_count(players()) > 1 and IsPlayer(SPARTANS.tanaka) and volume_test_object( VOLUMES.tv_narrative_grotto_courtyard_a_flanking_statues, SPARTANS.tanaka) ; -- GAMMA_TRANSITION: If Tanaka first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Flanking on the right, near the statues.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_02100.sound'),
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return list_count(players()) > 1 and IsPlayer(SPARTANS.vale) and volume_test_object( VOLUMES.tv_narrative_grotto_courtyard_a_flanking_statues, SPARTANS.vale) ; -- GAMMA_TRANSITION: If Vale first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Flanking on the right, near the statues.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_02300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	
};


--[========================================================================[
          Grotto. courtyard A. flanking gallery

          If a player goes on this side, he's calling it out to the
          other Spartans.

          Only in co-op.
--]========================================================================]
global W2HubGrotto_Grotto__courtyard_A__flanking_gallery = {
	name = "W2HubGrotto_Grotto__courtyard_A__flanking_gallery",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narrative_grotto_courtyard_a_flanking_gallery); -- GAMMA_CONDITION
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
				return list_count(players()) > 1 and IsPlayer(SPARTANS.locke) and volume_test_object( VOLUMES.tv_narrative_grotto_courtyard_a_flanking_gallery, SPARTANS.locke); -- GAMMA_TRANSITION: If Locke first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Advancing behind the turrets, left side.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_03900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return list_count(players()) > 1 and IsPlayer(SPARTANS.buck) and volume_test_object( VOLUMES.tv_narrative_grotto_courtyard_a_flanking_gallery, SPARTANS.buck) ; -- GAMMA_TRANSITION: If Buck first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Advancing behind the turrets, left side.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_02100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return list_count(players()) > 1 and IsPlayer(SPARTANS.tanaka) and volume_test_object( VOLUMES.tv_narrative_grotto_courtyard_a_flanking_gallery, SPARTANS.tanaka); -- GAMMA_TRANSITION: If Tanaka first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Advancing behind the turrets, left side.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_02000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return  list_count(players()) > 1 and IsPlayer(SPARTANS.vale) and volume_test_object( VOLUMES.tv_narrative_grotto_courtyard_a_flanking_gallery, SPARTANS.vale); -- GAMMA_TRANSITION: If Vale first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Advancing behind the turrets, left side.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_02200.sound'),

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


function grotto_spirits_lookat_listener()
local s_timer:number = 0;

		repeat
			
			sleep_s(0.1);
			s_timer = s_timer + 0.1;

			SleepUntil([| (ai_living_count(AI.sq_courtyard_spirit_02) > 0 or ai_living_count(AI.sq_courtyard_spirit_03) > 0) and volume_test_objects( VOLUMES.tv_narrative_grotto_courtyard_a_spirits_position, ai_get_object(AI.sq_courtyard_spirit_02.spawnpoint_01 ) )], 10);

			if object_at_distance_and_can_see_object(players(), ai_get_object(AI.sq_courtyard_spirit_02), 47, 40, VOLUMES.tv_narrative_grotto_courtyard_a_spirits_position) then
						W2HubGrotto_Grotto__courtyard_a_spirits.localVariables.looker = spartan_look_at_object(players(), ai_get_object(AI.sq_courtyard_spirit_02), 47, 40, 0.1, 2);
			elseif object_at_distance_and_can_see_object(players(), ai_get_object(AI.sq_courtyard_spirit_03), 47, 40, VOLUMES.tv_narrative_grotto_courtyard_a_spirits_position)  then
						W2HubGrotto_Grotto__courtyard_a_spirits.localVariables.looker = spartan_look_at_object(players(), ai_get_object(AI.sq_courtyard_spirit_03), 47, 40, 0.1, 2);
			else
					if list_count(players()) == 4 then
						W2HubGrotto_Grotto__courtyard_a_spirits.localVariables.looker = GetClosestMusketeer(ai_get_object(AI.sq_courtyard_spirit_02), 45, 2);								
					else
						W2HubGrotto_Grotto__courtyard_a_spirits.localVariables.looker = GetClosestMusketeer(ai_get_object(AI.sq_courtyard_spirit_02), 100, 0);								
					end
			end

			if W2HubGrotto_Grotto__courtyard_a_spirits.localVariables.looker == ai_get_object(AI.sq_courtyard_spirit_02) then
				W2HubGrotto_Grotto__courtyard_a_spirits.localVariables.looker = nil;
			end
			
		until W2HubGrotto_Grotto__courtyard_a_spirits.localVariables.looker and (volume_test_object( VOLUMES.tv_narrative_grotto_courtyard_a_spirits_position, ai_get_object(AI.sq_courtyard_spirit_02) ) 
																				or volume_test_object( VOLUMES.tv_narrative_grotto_courtyard_a_spirits_position, ai_get_object(AI.sq_courtyard_spirit_03) ))
				or IsGoalActive(Grotto.goal_plaza)

		if IsGoalActive(Grotto.goal_courtyard) then 
			PrintNarrative("QUEUE - W2HubGrotto_Grotto__courtyard_a_spirits");
			NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__courtyard_a_spirits);
		end
end

--[========================================================================[
          Grotto. courtyard a. spirits
--]========================================================================]
global W2HubGrotto_Grotto__courtyard_a_spirits = {
	name = "W2HubGrotto_Grotto__courtyard_a_spirits",

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
				return thisConvo.localVariables.looker == SPARTANS.locke; -- GAMMA_TRANSITION: If locke sees them
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Spirits reinforcement, 3 O'clock",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_09200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.looker == SPARTANS.buck; -- GAMMA_TRANSITION: Else If buck sees them
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Got Spirits incoming, right side!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_06600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.looker == SPARTANS.tanaka; -- GAMMA_TRANSITION: Else If tanaka sees them
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Spirits incoming, right side!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_06100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.looker == SPARTANS.vale; -- GAMMA_TRANSITION: Else If vale sees them
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Spirits incoming, right side by the Statues!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_07500.sound'),

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
						looker = nil,
						},
};


function grotto_courtyard_pushforward_incombat()

	PrintNarrative("START - grotto_courtyard_pushforward_incombat");

	sleep_s(100);

	if IsGoalActive(Grotto.goal_courtyard) then
		
		PrintNarrative("QUEUE - W2HubGrotto_Grotto__courtyard_a__push_reminder_1");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__courtyard_a__push_reminder_1);

		SleepUntil([| NarrativeQueue.HasConversationFinished(W2HubGrotto_Grotto__courtyard_a__push_reminder_1) ], 15);

		sleep_s(100);
	end	

	if IsGoalActive(Grotto.goal_courtyard) then
		
		PrintNarrative("QUEUE - W2HubGrotto_Grotto__courtyard_a__push_reminder_2");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__courtyard_a__push_reminder_2);
		
		SleepUntil([| NarrativeQueue.HasConversationFinished(W2HubGrotto_Grotto__courtyard_a__push_reminder_2) ], 15);		

		sleep_s(90);
	end	

	if IsGoalActive(Grotto.goal_courtyard) and not b_courtyard_a_player_in_corridor then
		
		PrintNarrative("QUEUE - W2HubGrotto_Grotto__courtyard_a__push_reminder_3");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__courtyard_a__push_reminder_3);
		
		SleepUntil([| NarrativeQueue.HasConversationFinished(W2HubGrotto_Grotto__courtyard_a__push_reminder_3) ], 15);		
	end

	sleep_s(90);

	SleepUntil([| b_courtyard_a_player_passed_half and not b_courtyard_a_player_in_corridor], 15);

	if IsGoalActive(Grotto.goal_courtyard) then

			PrintNarrative("QUEUE - W2HubGrotto_Grotto__courtyard_a__push_reminder_4");
			NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__courtyard_a__push_reminder_4);
	end

	PrintNarrative("END - grotto_courtyard_pushforward_incombat");

end


--[========================================================================[
          Grotto. courtyard a. push reminder

          Those are triggered during combat, to push the player to move
          forward
--]========================================================================]
global W2HubGrotto_Grotto__courtyard_a__push_reminder_1 = {
	name = "W2HubGrotto_Grotto__courtyard_a__push_reminder_1",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	sleepBefore = 2,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Makhee",

			--character = 0, -- GAMMA_CHARACTER: eliteeSCORT (Makhee)
			text = "Spartans, Arbiter's forces are losing this fight. How much longer until you reach the chambers?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_eliteescort_02000.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "We're working on it, Mahkee. I'll notify you when we're ready for extraction.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_09300.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 2,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,

};



--[========================================================================[
          Grotto. courtyard a. push reminder

          Those are triggered during combat, to push the player to move
          forward
--]========================================================================]
global W2HubGrotto_Grotto__courtyard_a__push_reminder_2 = {
	name = "W2HubGrotto_Grotto__courtyard_a__push_reminder_2",

	CanStart = function (thisConvo, queue)
		return IsSpartanInCombat(); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
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
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Keep fighting, Osiris. We have to reach the Council Chamber. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_09400.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 2,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,

};



--[========================================================================[
          Grotto. courtyard a. push reminder

          Those are triggered during combat, to push the player to move
          forward
--]========================================================================]
global W2HubGrotto_Grotto__courtyard_a__push_reminder_3 = {
	name = "W2HubGrotto_Grotto__courtyard_a__push_reminder_3",

	CanStart = function (thisConvo, queue)
		return IsSpartanInCombat(); -- GAMMA_CONDITION
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
			
			moniker = "Makhee",

			--character = 0, -- GAMMA_CHARACTER: eliteeSCORT (Makhee)
			text = "Spartan Locke, Covenant fleet is approaching the Elder Council Chambers.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_eliteescort_02900.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Stand by Makhee. We'll get to The Arbiter soon.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_11200.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 2,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,

};

--[========================================================================[
          Grotto. courtyard a. push reminder

          Those are triggered during combat, to push the player to move
          forward
--]========================================================================]
global W2HubGrotto_Grotto__courtyard_a__push_reminder_4 = {
	name = "W2HubGrotto_Grotto__courtyard_a__push_reminder_4",

	CanStart = function (thisConvo, queue)
		return not IsSpartanInCombat(SPARTANS.buck) and playersMovementSpeed() <= 0.5; -- GAMMA_CONDITION
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

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "We're wasting time. Got to move faster.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_06700.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 2,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,

};



--[========================================================================[
          Grotto. courtyard A. wraith at the door

--]========================================================================]
global W2HubGrotto_Grotto__courtyard_A__wraith_at_the_door = {
	name = "W2HubGrotto_Grotto__courtyard_A__wraith_at_the_door",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_grotto_wraith_courtyard) and object_get_health(AI.sq_courtyard_wraith_01.spawnpoint_01) > 0 and (ai_combat_status(AI.sq_courtyard_wraith_01.spawnpoint_01) >= 6 or objects_distance_to_object( players(), ai_get_object(AI.sq_courtyard_wraith_01.spawnpoint_01)) < 23);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
		if object_at_distance_and_can_see_object(players(), ai_get_object(AI.sq_courtyard_wraith_01.spawnpoint_01), 23, 30, VOLUMES.tv_grotto_wraith_courtyard) then
			thisConvo.localVariables.s_speaker = spartan_look_at_object(players(), ai_get_object(AI.sq_courtyard_wraith_01.spawnpoint_01), 23, 30, 0, 2);
		else
			thisConvo.localVariables.s_speaker = GetClosestMusketeer(ai_get_object(AI.sq_courtyard_wraith_01.spawnpoint_01), 30, 2);
		end
		if (thisConvo.localVariables.s_speaker == SPARTANS.locke and list_count(players()) == 1) or thisConvo.localVariables.s_speaker == ai_get_object(AI.sq_courtyard_wraith_01.spawnpoint_01) then
			thisConvo.localVariables.s_speaker = GetClosestMusketeer(ai_get_object(AI.sq_courtyard_wraith_01.spawnpoint_01), 50, 0);
		end
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_speaker == SPARTANS.locke;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Wraith on the field!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_04100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_speaker == SPARTANS.buck;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Got Wraiths over here!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_02300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_speaker == SPARTANS.vale;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Watch it! Wraith on the warpath!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_02200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			Else = true,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Hostile Wraiths are ready to engage! \r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_02400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 4,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,

	localVariables = {
					s_speaker = nil,
					},
};







--[========================================================================[
          Grotto. courtyard B. closed door

          There is only one way out and the big ancient door is closed.
--]========================================================================]
global W2HubGrotto_Grotto__courtyard_B__closed_door = {
	name = "W2HubGrotto_Grotto__courtyard_B__closed_door",

	CanStart = function (thisConvo, queue)
		return object_at_distance_and_can_see_object(players(), OBJECTS.dm_gatehouse_door_01, 13, 40); -- GAMMA_CONDITION
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
				return false;-- (not b_gatehouse_door_opening and IsPlayer(SPARTANS.buck) and objects_distance_to_object( SPARTANS.buck, OBJECTS.dm_gatehouse_door_01) < 13) or  (not IsPlayer(SPARTANS.buck) and objects_distance_to_object( SPARTANS.buck, OBJECTS.dm_gatehouse_door_01) < 30) or  (list_count(players()) == 1);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Where to now?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_07900.sound'),
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
          Grotto. courtyard B. closed door

          There is only one way out and the big ancient door is closed.
--]========================================================================]
global W2HubGrotto_Grotto__courtyard_B__closed_door_opening = {
	name = "W2HubGrotto_Grotto__courtyard_B__closed_door_opening",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,
	
	Timeout = function (thisConvo, queue) -- NUMBER
		return 4;
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
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return (IsPlayer(SPARTANS.vale) and object_at_distance_and_can_see_object(SPARTANS.vale, OBJECTS.dm_gatehouse_door_01, 30, 20))
						or (not IsPlayer(SPARTANS.vale) and objects_distance_to_object( SPARTANS.vale, OBJECTS.dm_gatehouse_door_01) < 35);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Door's opening!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_08800.sound'),
		},		
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,
	
	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,
};
----------------------------------------------------------------------------
----------------------------------------------------------------------------


function grotto_plaza_load()

	PrintNarrative("LOAD - grotto_plaza_load");

	b_courtyard_a_player_passed_half = true;	

	CreateMissionThread(grotto_mural_05_listener);

	SleepUntil ([| volume_test_players( VOLUMES.tv_grotto_corridor_gatehouse) ], 10)

	PrintNarrative("QUEUE - W2HubGrotto_Grotto__courtyard_a_corridor");
	NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__courtyard_a_corridor);	

	PrintNarrative("QUEUE - W2HubGrotto_Grotto__courtyard_B__entrance");
	NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__courtyard_B__entrance);

	b_courtyard_a_player_in_corridor = true;
	
end



--[========================================================================[
          Grotto. courtyard a. Corridor
--]========================================================================]
global W2HubGrotto_Grotto__courtyard_a_corridor = {
	name = "W2HubGrotto_Grotto__courtyard_a_corridor",

	CanStart = function (thisConvo, queue)
		return b_courtyard_a_player_in_corridor;
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
			text = "Makhee, get in position, we're approaching the council chamber.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_11200.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Makhee",

			--character = 0, -- GAMMA_CHARACTER: EliteescORT (MAKHEE)
			text = "Standing by!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_eliteescort_02700.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2HubGrotto_Grotto__courtyard_B__corridor");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__courtyard_B__corridor);
	end,

};



--[========================================================================[
          Grotto. courtyard B. corridor
--]========================================================================]
global W2HubGrotto_Grotto__courtyard_B__corridor = {
	name = "W2HubGrotto_Grotto__courtyard_B__corridor",

	CanStart = function (thisConvo, queue)
		return IsSpartanAbleToSpeak(SPARTANS.vale) and IsSpartanAbleToSpeak(SPARTANS.buck) and IsSpartanAbleToSpeak(SPARTANS.locke) and volume_test_players_all( VOLUMES.tv_grotto_courtyard_a_corridor) and not IsSpartanInCombat(); -- GAMMA_CONDITION
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
				return volume_test_players_all( VOLUMES.tv_grotto_courtyard_a_corridor);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "We're almost there. Hurry.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_12300.sound'),

			sleepAfter = 0.7,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return volume_test_players_all( VOLUMES.tv_grotto_courtyard_a_corridor);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "If there is one Sword of Sanghelios left, it's the Arbiter.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_08200.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,
};


--[========================================================================[
          Grotto. courtyard B. entrance

          When the player is a certain distance from the Council
          Chamber, we will see some Arbiter's Elites retreating inside.
          (Maybe also setting up a shield behind them).
--]========================================================================]
global W2HubGrotto_Grotto__courtyard_B__entrance = {
	name = "W2HubGrotto_Grotto__courtyard_B__entrance",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narrative_grotto_courtyard_b_goal_retreat) ; -- GAMMA_CONDITION
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
				return  volume_test_object(	VOLUMES.tv_narrative_grotto_courtyard_b_goal_retreat, SPARTANS.locke); -- GAMMA_TRANSITION: If Locke first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Coming up on the council chamber!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_04800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return  volume_test_object(	VOLUMES.tv_narrative_grotto_courtyard_b_goal_retreat, SPARTANS.buck); -- GAMMA_TRANSITION: If Buck first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "The Arbiter's troops are holding up inside council chamber!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_03400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(	VOLUMES.tv_narrative_grotto_courtyard_b_goal_retreat, SPARTANS.tanaka); -- GAMMA_TRANSITION: If Tanaka first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "The Arbiter's troops are retreating into the council chamber!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_03200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(	VOLUMES.tv_narrative_grotto_courtyard_b_goal_retreat, SPARTANS.vale); -- GAMMA_TRANSITION: If Vale first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "The Arbiter's troops are retreating into the Council Chamber!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_04000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Get in there. NOW.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_04900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();		
	end,	
};



function grotto_plaza_droppods()

	PrintNarrative("LOAD - grotto_plaza_load");

	PrintNarrative("QUEUE - W2HubGrotto_Grotto__courtyard_a__droppods");
	W2HubGrotto_Grotto__courtyard_a__droppods.localVariables.s_speaker = GetClosestMusketeer(OBJECTS.pod_plaza_jackals_01, 30, 2);
		if list_count(players()) == 1 and W2HubGrotto_Grotto__courtyard_a__droppods.localVariables.s_speaker == SPARTANS.locke then
			W2HubGrotto_Grotto__courtyard_a__droppods.localVariables.s_speaker = GetClosestMusketeer(SPARTANS.locke, 13, 0);
		end

	NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__courtyard_a__droppods);
	NarrativeQueue.InterruptConversation(W2HubGrotto_Grotto__courtyard_B__entrance, 0.5);
	NarrativeQueue.InterruptConversation(W2HubGrotto_Grotto__courtyard_a_corridor, 0.5);
	NarrativeQueue.InterruptConversation(W2HubGrotto_Grotto__courtyard_a__push_reminder_4, 0.5);
	NarrativeQueue.InterruptConversation(W2HubGrotto_Grotto__courtyard_a__push_reminder_3, 0.5);
	NarrativeQueue.InterruptConversation(W2HubGrotto_Grotto__courtyard_A__corvette, 0.5);
	NarrativeQueue.InterruptConversation(W2HubGrotto_Grotto__courtyard_a__push_reminder_2, 0.5);
	NarrativeQueue.InterruptConversation(W2HubGrotto_Grotto__courtyard_a__push_reminder_1, 0.5);

	sleep_s(60);

	PrintNarrative("QUEUE - W2HubGrotto_Grotto__courtyard_B__pull_forward");
	NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__courtyard_B__pull_forward);
	
end

--[========================================================================[
          Grotto. courtyard a. droppods
--]========================================================================]
global W2HubGrotto_Grotto__courtyard_a__droppods = {
	name = "W2HubGrotto_Grotto__courtyard_a__droppods",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
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
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If Locke see drop pods first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Insertion pods incoming.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_08000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck ; -- GAMMA_TRANSITION: If Buck see drop pods first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Insertion pods incoming.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_05800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: If Tanaka see drop pods first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Insertion pods incoming.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_05300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: If Vale see drop pods first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Insertion pods incoming.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_06400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Push through Osiris!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_11300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2HubGrotto_Grotto__courtyard_B__2nd_podwave");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__courtyard_B__2nd_podwave);
	end,

	localVariables = {
					s_speaker = nil,
					},	
};


--[========================================================================[
          Grotto. courtyard B. pull forward

          Since the end of that mission needs to have a lot of urgency,
          I would suggest to have more and less spaced pull forward
          lines. To encourage the player to not waste time.
--]========================================================================]
global W2HubGrotto_Grotto__courtyard_B__2nd_podwave = {
	name = "W2HubGrotto_Grotto__courtyard_B__2nd_podwave",

	CanStart = function (thisConvo, queue)
		return volume_test_players (VOLUMES.tv_plaza_objcon_10);
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
				return (not IsPlayer(SPARTANS.buck) and objects_distance_to_object( SPARTANS.buck, OBJECTS.pod_plaza_elite_04 ) < 35)
						or (IsPlayer(SPARTANS.buck) and object_at_distance_and_can_see_object(SPARTANS.buck, OBJECTS.pod_plaza_elite_04, 25, 160));
			end,

			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Sonuva! More pods!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_08000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	
};


--[========================================================================[
          Grotto. courtyard B. pull forward

          Since the end of that mission needs to have a lot of urgency,
          I would suggest to have more and less spaced pull forward
          lines. To encourage the player to not waste time.
--]========================================================================]
global W2HubGrotto_Grotto__courtyard_B__pull_forward = {
	name = "W2HubGrotto_Grotto__courtyard_B__pull_forward",

	CanStart = function (thisConvo, queue)
		return IsSpartanAbleToSpeak(SPARTANS.vale) and not b_found_arbiter and IsGoalActive(Grotto.goal_plaza); -- GAMMA_CONDITION
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

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Arbiter's trapped inside. We should hurry",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_06800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	
};

-- =================================================================================================          
--  _    _  ____  
-- | |  | |/ __ \ 
-- | |__| | |  | |
-- |  __  | |  | |
-- | |  | | |__| |
-- |_|  |_|\___\_\
-- =================================================================================================                            




function grotto_hq_load()
	PrintNarrative("LOAD - grotto_hq_load");

	PrintNarrative("QUEUE - W2HubGrotto_Grotto__hq__contact_MAHKEE");
	NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__hq__contact_MAHKEE);

	PrintNarrative("QUEUE - W2HubGrotto_Grotto__hq__dying_elite_onstairs_arbiter_1");
	NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__hq__dying_elite_onstairs_arbiter_1);	
	
	CreateMissionThread(Grotto__hq__first_floor_cleared);

	AIDialogManager.DisableAIDialog(AI.vin_hq_ambient_squad.vin_amb_arb_elite_01_spawnpoint);
	AIDialogManager.DisableAIDialog(AI.vin_hq_ambient_squad.vin_amb_arb_elite_02_spawnpoint);
end



--[========================================================================[
          Grotto. hq. contact MAHKEE

          Vale contacts 'Makhee.
--]========================================================================]
global W2HubGrotto_Grotto__hq__contact_MAHKEE = {
	name = "W2HubGrotto_Grotto__hq__contact_MAHKEE",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_grotto_hq_first_stairs ); -- GAMMA_CONDITION
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
				return volume_test_object( VOLUMES.tv_grotto_hq_first_stairs, SPARTANS.locke ); -- GAMMA_TRANSITION: coming up on the HQ If locke is dead
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "'Makhee, we've reached the Council Chamber!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_11400.sound'),

			playDurationAdjustment = 0.9,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object( VOLUMES.tv_grotto_hq_first_stairs, SPARTANS.buck ); -- GAMMA_TRANSITION: coming up on the HQ If locke is dead
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "I'm in the Council Chamber!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_07600.sound'),

			playDurationAdjustment = 0.9,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object( VOLUMES.tv_grotto_hq_first_stairs, SPARTANS.tanaka ); -- GAMMA_TRANSITION: coming up on the HQ If locke is dead
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Made it inside!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_00600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object( VOLUMES.tv_grotto_hq_first_stairs, SPARTANS.vale ); -- GAMMA_TRANSITION: coming up on the HQ If locke is dead
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "I'm inside the Council Chamber! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_00800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Makhee",

			sleepBefore = 0.4,

			--character = 0, -- GAMMA_CHARACTER: Eliteescort (MAHKEE)
			text = "Understood. On my way.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_eliteescort_02400.sound'),

			sleepAfter = 0.7,
		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Kaidon! we're here to help!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_08000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		CreateMissionThread(grotto_hq_players_advancement);
	end,
};


function Grotto__hq__first_floor_cleared()

PrintNarrative("START - Grotto__hq__first_floor_cleared");

		repeat
				sleep_s(0.3);

				SleepUntil ([| NarrativeQueue.ConversationsPlayingCount() == 0 and IsSpartanAbleToSpeak(SPARTANS.locke) and IsSpartanAbleToSpeak(SPARTANS.buck) and volume_test_object( VOLUMES.tv_narrative_grotto_hq_bottom, SPARTANS.locke ) and volume_test_object( VOLUMES.tv_narrative_grotto_hq_bottom, SPARTANS.buck )  ], 10);

		until (GetClosestEnemy(AI.sg_vin_takedown_01, 10)) == nil and (GetClosestEnemy(AI.sg_vin_takedown_02, 10)) == nil

		PrintNarrative("QUEUE - W2HubGrotto_Grotto__hq__first_floor_cleared");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__hq__first_floor_cleared);

PrintNarrative("END - Grotto__hq__first_floor_cleared");

end

--[========================================================================[
          Grotto. hq. first floor cleared
--]========================================================================]
global W2HubGrotto_Grotto__hq__first_floor_cleared = {
	name = "W2HubGrotto_Grotto__hq__first_floor_cleared",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	sleepBefore = 1,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "He's not here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_07700.sound'),

			sleepAfter = 0.3,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Up the stairs!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_11600.sound'),

			sleepAfter = 1,
		},
	},


	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		CreateMissionThread(grotto_mural_03_listener);
		CreateMissionThread(grotto_mural_04_listener);
	end,

};



function grotto_hq_players_advancement()

CreateMissionThread(grotto_hq_encounter_push_forward_in_combat);

PrintNarrative("QUEUE - W2HubGrotto_Grotto__hq__encounter__push_forward_almost_balcony");
NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__hq__encounter__push_forward_almost_balcony);

SleepUntil([| volume_test_players( VOLUMES.tv_grotto_hq_balcony01 )], 20);
		b_grotto_player_reached_balcony = true;

SleepUntil([| volume_test_players( VOLUMES.tv_grotto_hq_at_balcony )], 1);
		b_found_arbiter = true;

		repeat
			g_timer_player_see_arbiter = g_timer_player_see_arbiter + 1;

		until g_timer_player_see_arbiter > 10
end


--[========================================================================[
          Grotto. hq. encounter. push forward in combat

          During the encounter, Makhee comes on radio to push the
          player forward.
--]========================================================================]
global W2HubGrotto_Grotto__hq__encounter__push_forward_almost_balcony = {
	name = "W2HubGrotto_Grotto__hq__encounter__push_forward_almost_balcony",

	CanStart = function (thisConvo, queue)
		return IsSpartanAbleToSpeak(SPARTANS.locke) and (volume_test_players( VOLUMES.tv_grotto_hq_almost_right ) or volume_test_players( VOLUMES.tv_grotto_hq_almost_left)); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,	

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not (volume_test_players( VOLUMES.tv_grotto_hq_balcony) or volume_test_players( VOLUMES.tv_grotto_hq_at_balcony));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: locke
			text = "We're almost there Makhee, Get ready.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_10900.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[2] = {			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Makhee",

			--character = 0, -- GAMMA_CHARACTER: Eliteescort (MAHKEE)
			text = "I am on my way.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_eliteescort_02800.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();		
	end,

	sleepAfter = 2,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};




--[========================================================================[
          Grotto. hq. dying elite

                                                  VIGNETTE

          A loyalist elite on the floor is pointing at the door.
          Dying...
--]========================================================================]
global W2HubGrotto_Grotto__hq__dying_elite_onstairs_arbiter_1 = {
	name = "W2HubGrotto_Grotto__hq__dying_elite_onstairs_arbiter_1",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_grotto_hq_balcony ); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_found_arbiter;
			end,
			character = CHARACTER_OBJECTS.cr_arbiter_on_balcony, -- GAMMA_CHARACTER: Arbiter
			text = "The Swords of Sanghelios will be victorious!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_arbiter_00200.sound'),
		},		
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2HubGrotto_Grotto__hq__dying_elite_onstairs_arbiter_2");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__hq__dying_elite_onstairs_arbiter_2);
	end,
};

--[========================================================================[
          Grotto. hq. dying elite

                                                  VIGNETTE

          A loyalist elite on the floor is pointing at the door.
          Dying...
--]========================================================================]
global W2HubGrotto_Grotto__hq__dying_elite_onstairs_arbiter_2 = {
	name = "W2HubGrotto_Grotto__hq__dying_elite_onstairs_arbiter_2",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_grotto_hq_balcony ); -- GAMMA_CONDITION
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
				return not b_found_arbiter;
			end,

			character = CHARACTER_OBJECTS.cr_arbiter_on_balcony, -- GAMMA_CHARACTER: Arbiter
			text = "Come close, traitor, and see how a true Sangheili fights!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_arbiter_00300.sound'),
		},		
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2HubGrotto_Grotto__hq__dying_elite_onstairs_arbiter_3");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__hq__dying_elite_onstairs_arbiter_3);
	end,
};



--[========================================================================[
          Grotto. hq. dying elite

                                                  VIGNETTE

          A loyalist elite on the floor is pointing at the door.
          Dying...
--]========================================================================]
global W2HubGrotto_Grotto__hq__dying_elite_onstairs_arbiter_3 = {
	name = "W2HubGrotto_Grotto__hq__dying_elite_onstairs_arbiter_3",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_grotto_hq_balcony ); -- GAMMA_CONDITION
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
				return not b_found_arbiter;
			end,	
		
			character = CHARACTER_OBJECTS.cr_arbiter_on_balcony, -- GAMMA_CHARACTER: Arbiter
			text = "It will be my honor to kill you...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_elite01_02000.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_found_arbiter;
			end,

			character = CHARACTER_OBJECTS.cr_arbiter_on_balcony, -- GAMMA_CHARACTER: Arbiter
			text = "It is your honor to die!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_arbiter_00400.sound'),
		},			
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2HubGrotto_Grotto__hq__dying_elite_onstairs_arbiter_4");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__hq__dying_elite_onstairs_arbiter_4);
	end,
};




--[========================================================================[
          Grotto. hq. dying elite

                                                  VIGNETTE

          A loyalist elite on the floor is pointing at the door.
          Dying...
--]========================================================================]
global W2HubGrotto_Grotto__hq__dying_elite_onstairs_arbiter_4 = {
	name = "W2HubGrotto_Grotto__hq__dying_elite_onstairs_arbiter_4",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_hq_arbiter_comp ) and not b_no_arb_emote; -- GAMMA_CONDITION
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
			character = AI.vin_arbiter_melee_arb.vin_arb_arbiter_spawnpoint, -- GAMMA_CHARACTER: Arbiter
			text = "For Sanghelios!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_arbiter_00700.sound'),

			playDurationAdjustment = 0.9,
		},		
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2HubGrotto_Grotto__hq__entrance_arbiter");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__hq__entrance_arbiter);
	end,
};

--[========================================================================[
          Grotto. hq. entrance Arbiter
--]========================================================================]
global W2HubGrotto_Grotto__hq__entrance_arbiter = {
	name = "W2HubGrotto_Grotto__hq__entrance_arbiter",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,
		sleepBefore = 0.5,
	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();		
		thisConvo.localVariables.s_speaker = GetClosestMusketeer(ai_get_object(AI.vin_arbiter_melee_arb.vin_arb_arbiter_spawnpoint), 20, 2);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If Locke first and more than 1 player
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: locke
			text = "I see Arbiter! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_10600.sound'),

			playDurationAdjustment = 0.8,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: If Locke first and more than 1 player
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "I see Arbiter!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_07200.sound'),

			playDurationAdjustment = 0.8,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: If Locke first and more than 1 player
			end,


			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "I see Arbiter!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_06600.sound'),

			playDurationAdjustment = 0.8,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: If Locke first and more than 1 player
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "I see Arbiter!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_07700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,

			playDurationAdjustment = 0.8,
		},	
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();				
		PrintNarrative("QUEUE - W2HubGrotto_Grotto__hq__balcony");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__hq__balcony);
	end,

	localVariables = {
						speaker = nil,
						},
};


--[========================================================================[
          Grotto. hq. balcony

          When player reach the balcony, a phantom comes down to pick
          them up
--]========================================================================]
global W2HubGrotto_Grotto__hq__balcony = {
	name = "W2HubGrotto_Grotto__hq__balcony",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,
	sleepBefore = 0.5,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
		thisConvo.localVariables.s_speaker = GetClosestMusketeer(ai_get_object(AI.vin_arbiter_melee_arb.vin_arb_arbiter_spawnpoint), 20, 2);
	end,
	
	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If locke is first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Ready for Extraction!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_11000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: If buck is first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Ready for Extraction!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_07400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: If tanaka is first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Ready for Extraction!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_06700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: If vale is first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Ready for Extraction!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_07800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,			
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PushForwardVOStandBy();
		PrintNarrative("QUEUE - W2HubGrotto_Grotto__hq__balcony_2");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__hq__balcony_2);
	end,
	
	localVariables = {
						speaker = nil,
						},
};



--[========================================================================[
          Grotto. hq. balcony

          When player reach the balcony, a phantom comes down to pick
          them up
--]========================================================================]
global W2HubGrotto_Grotto__hq__balcony_2 = {
	name = "W2HubGrotto_Grotto__hq__balcony_2",

	CanStart = function (thisConvo, queue)
		return b_arbiter_melee_end; -- GAMMA_CONDITION
	end,	

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
		thisConvo.localVariables.s_speaker = GetClosestMusketeer(ai_get_object(AI.vin_arbiter_melee_arb.vin_arb_arbiter_spawnpoint), 10, 0);
	end,
	
	lines = {
		[1] = {
			character = AI.vin_arbiter_melee_arb.vin_arb_arbiter_spawnpoint, -- GAMMA_CHARACTER: ARBITER
			text = "Spartans...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_arbiter_00900.sound'),

			playDurationAdjustment = 0.95,
		},	
		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return false;
			end,
						
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Gather up Osiris!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_11100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PushForwardVOStandBy();
		PrintNarrative("QUEUE - W2HubGrotto_Grotto__hq__entrance_arbiter_arbiter");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__hq__entrance_arbiter_arbiter);
	end,
	
	localVariables = {
						speaker = nil,
						},
};
--[========================================================================[
          Grotto. hq. entrance Arbiter
--]========================================================================]
global W2HubGrotto_Grotto__hq__entrance_arbiter_arbiter = {
	name = "W2HubGrotto_Grotto__hq__entrance_arbiter_arbiter",
	
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();		
	end,

	lines = {
		[1] = {					
			character = AI.vin_arbiter_melee_arb.vin_arb_arbiter_spawnpoint, -- GAMMA_CHARACTER: ARBITER
			text = "What is the meaning of this?\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_arbiter_01000.sound'),

			playDurationAdjustment = 0.9,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,

	localVariables = {
						speaker = nil,
						},
};


-------------------------

function grotto_hq_encounter_push_forward_in_combat()

sleep_s(20);

	if not b_grotto_player_reached_balcony then
		PrintNarrative("QUEUE - W2HubGrotto_Grotto__hq__encounter__push_forward_in_combat");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__hq__encounter__push_forward_in_combat);
	end

sleep_s(20);

	if not b_grotto_player_reached_balcony then
		PrintNarrative("QUEUE - W2HubGrotto_Grotto__hq__encounter__push_forward_in_combat_2");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__hq__encounter__push_forward_in_combat_2);
	end


end


--[========================================================================[
          Grotto. hq. encounter. push forward in combat

          During the encounter, Makhee comes on radio to push the
          player forward.
--]========================================================================]
global W2HubGrotto_Grotto__hq__encounter__push_forward_in_combat = {
	name = "W2HubGrotto_Grotto__hq__encounter__push_forward_in_combat",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sg_vin_takedown_01) > 0 and ai_living_count(AI.sg_vin_takedown_02) > 0 and  IsSpartanInCombat(); -- GAMMA_CONDITION
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
				return not b_grotto_player_reached_balcony;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Push forward Osiris!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_10800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};




--[========================================================================[
          Grotto. hq. encounter. push forward in combat

          During the encounter, Makhee comes on radio to push the
          player forward.
--]========================================================================]
global W2HubGrotto_Grotto__hq__encounter__push_forward_in_combat_2 = {
	name = "W2HubGrotto_Grotto__hq__encounter__push_forward_in_combat_2",

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
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_grotto_player_reached_balcony;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Can't stay here much longer, Covies are heading this way!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_07300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};



------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--	MURALS
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------


--[========================================================================[
          Grotto. murals. Comments on look at
--]========================================================================]
global W2HubGrotto_Grotto__murals___first_mural = {
	name = "W2HubGrotto_Grotto__murals___first_mural",

	CanStart = function (thisConvo, queue)
		return b_first_mural_seen; -- GAMMA_CONDITION
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

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "This murals shows the story of the Elites and the Prophets.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_08100.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_first_mural_seen = false;
		PrintNarrative("QUEUE - W2HubGrotto_Grotto__murals___first_mural_bis");
		NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__murals___first_mural_bis);
	end,
};


--[========================================================================[
          Grotto. murals. Comments on look at
--]========================================================================]
global W2HubGrotto_Grotto__murals___first_mural_bis = {
	name = "W2HubGrotto_Grotto__murals___first_mural_bis",

	CanStart = function (thisConvo, queue)
		return b_first_mural_seen; -- GAMMA_CONDITION
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

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale 
			text = "The whole site must have been built in celebration of the prophets. A long time ago.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_08200.sound'),
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



--[========================================================================[
          Grotto. murals. Comments on look at
--]========================================================================]
global W2HubGrotto_Grotto__murals___first_mural_ter = {
	name = "W2HubGrotto_Grotto__murals___first_mural_ter",

	CanStart = function (thisConvo, queue)
		return b_first_mural_seen; -- GAMMA_CONDITION
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

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "This whole site is dedicated to the Covenant and their quest for the \"The Great Journey\".",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_08700.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "The Great Journey. Right. Kill everything and meet the gods. \r\nWell, I hope the Gods weren't too upset the Prophets didn't bring more of us along with 'em.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_07800.sound'),
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

function grotto_mural_01_listener()

local s_speaker:object = nil;
	
	PrintNarrative("WAKE - grotto_mural_01_listener");

	SleepUntil([| object_valid( "cr_mural_01" )  ], 20);

	PrintNarrative("LISTENER - grotto_mural_01_listener");

		repeat

				repeat 							
						SleepUntil([| (IsSpartanAbleToSpeak(SPARTANS.vale) and object_at_distance_and_can_see_object(players(), OBJECTS.cr_mural_01, 30, 10, VOLUMES.tv_narr_grotto_mural_01) and not IsSpartanInCombat()) or not object_valid( "cr_mural_01" )], 10);

						print("grotto_mural_01_listener: vale is alive and someone is looking and not in combat");

						if object_valid( "cr_mural_01") then

								repeat
									sleep_s(0.1);
									s_speaker = spartan_look_at_object(players(), OBJECTS.cr_mural_01, 30, 10, 1.5, 1);
									print("grotto_mural_01_listener: Player is looking");
									print(s_speaker);
								until s_speaker ~= nil or not object_at_distance_and_can_see_object(players(), OBJECTS.cr_mural_01, 30, 10, VOLUMES.tv_narr_grotto_mural_01)
						end						

				until (NarrativeQueue.ConversationsPlayingCount() == 0 and s_speaker ~= nil
							and ( (not IsPlayer(SPARTANS.vale) and objects_distance_to_object(s_speaker, SPARTANS.vale) < 30)
									or (IsPlayer(SPARTANS.vale) and object_at_distance_and_can_see_object(SPARTANS.vale, OBJECTS.cr_mural_01, 40, 60) )
								)
						)
						or not object_valid( "cr_mural_01" ) 

				print("grotto_mural_01_listener: Passed Vale test, testing for enemies");

				grotto_is_there_enemy_nearby(40);

		until (((courtyard_loaded and not grotto_is_there_enemy_nearby_result) or not courtyard_loaded) and not IsSpartanInCombat()) or not object_valid( "cr_mural_01" )
				
				if object_valid( "cr_mural_01") then
					b_first_mural_seen = true;

					sleep_s(0.5);

					if not NarrativeQueue.HasConversationFinished(W2HubGrotto_Grotto__murals___mural_01) then
						PrintNarrative("QUEUE - W2HubGrotto_Grotto__murals___mural_01");
						NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__murals___mural_01);
					end
				end
end


function grotto_mural_06_listener()

local s_speaker:object = nil;
	
	PrintNarrative("WAKE - grotto_mural_06_listener");

	SleepUntil([| object_valid( "cr_mural_06" )  ], 10);

	PrintNarrative("LISTENER - grotto_mural_06_listener");	

		repeat

				repeat 							
						SleepUntil([| (IsSpartanAbleToSpeak(SPARTANS.vale) and object_at_distance_and_can_see_object(players(), OBJECTS.cr_mural_06, 30, 10, VOLUMES.tv_narr_grotto_mural_06) and not IsSpartanInCombat()) or not object_valid( "cr_mural_06" )], 10);

						print("grotto_mural_06_listener: vale is alive and someone is looking and not in combat");

						if object_valid( "cr_mural_06") then

								repeat
									sleep_s(0.1);
									s_speaker = spartan_look_at_object(players(), OBJECTS.cr_mural_06, 30, 10, 1.5, 1);
									print("grotto_mural_06_listener: Player is looking");
									print(s_speaker);
								until s_speaker ~= nil or not object_at_distance_and_can_see_object(players(), OBJECTS.cr_mural_06, 30, 10, VOLUMES.tv_narr_grotto_mural_06)
						end						

				until (NarrativeQueue.ConversationsPlayingCount() == 0 and s_speaker ~= nil
							and ( (not IsPlayer(SPARTANS.vale) and objects_distance_to_object(s_speaker, SPARTANS.vale) < 30)
									or (IsPlayer(SPARTANS.vale) and object_at_distance_and_can_see_object(SPARTANS.vale, OBJECTS.cr_mural_06, 40, 60) )
								)
						)
						or not object_valid( "cr_mural_06" ) 

				print("grotto_mural_06_listener: Passed Vale test, testing for enemies");

				grotto_is_there_enemy_nearby(40);

		until (not grotto_is_there_enemy_nearby_result and not IsSpartanInCombat()) or not object_valid( "cr_mural_06")
				
				if object_valid( "cr_mural_06") then

					b_first_mural_seen = true;

					sleep_s(0.5);

					if not NarrativeQueue.HasConversationFinished(W2HubGrotto_Grotto__murals___mural_01) then
						PrintNarrative("QUEUE - W2HubGrotto_Grotto__murals___mural_01");
						NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__murals___mural_01);
					end
				end	
end

--[========================================================================[
          Grotto. murals. Comments on look at
--]========================================================================]
global W2HubGrotto_Grotto__murals___mural_01 = {
	name = "W2HubGrotto_Grotto__murals___mural_01",

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

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "This is about the creation of the Covenant. Alliance of the Prophets and the Elites.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_08300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
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


function grotto_mural_02_listener()

local s_speaker:object = nil;
	
	PrintNarrative("WAKE - grotto_mural_02_listener");

	SleepUntil([| object_valid( "cr_mural_02" )  ], 20);

	PrintNarrative("LISTENER - grotto_mural_02_listener");	

		repeat

				repeat 							
						SleepUntil([| (IsSpartanAbleToSpeak(SPARTANS.vale) and object_at_distance_and_can_see_object(players(), OBJECTS.cr_mural_02, 30, 20, VOLUMES.tv_narr_grotto_mural_02) and not IsSpartanInCombat()) or not object_valid( "cr_mural_02" )], 10);

						print("grotto_mural_02_listener: vale is alive and someone is looking and not in combat");

						if object_valid( "cr_mural_02") then

								repeat
									sleep_s(0.1);
									s_speaker = spartan_look_at_object(players(), OBJECTS.cr_mural_02, 30, 20, 1.5, 1);
									print("grotto_mural_02_listener: Player is looking");
									print(s_speaker);
								until s_speaker ~= nil or not object_at_distance_and_can_see_object(players(), OBJECTS.cr_mural_02, 30, 20, VOLUMES.tv_narr_grotto_mural_02)
						end						

				until (NarrativeQueue.ConversationsPlayingCount() == 0 and s_speaker ~= nil
							and ( (not IsPlayer(SPARTANS.vale) and objects_distance_to_object(s_speaker, SPARTANS.vale) < 30)
									or (IsPlayer(SPARTANS.vale) and object_at_distance_and_can_see_object(SPARTANS.vale, OBJECTS.cr_mural_02, 40, 60) )
								)
						)
						or not object_valid( "cr_mural_02" ) 

				print("grotto_mural_02_listener: Passed Vale test, testing for enemies");

				grotto_is_there_enemy_nearby(20);

		until (((b_armory_floor_alerted and not grotto_is_there_enemy_nearby_result) or not b_armory_floor_alerted) and not IsSpartanInCombat()) or not object_valid( "cr_mural_02")
				
				if object_valid( "cr_mural_02") then
					b_first_mural_seen = true;

					sleep_s(0.5);

					if not NarrativeQueue.HasConversationFinished(W2HubGrotto_Grotto__murals___mural_01) then
						PrintNarrative("QUEUE - W2HubGrotto_Grotto__murals___mural_01");
						NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__murals___mural_01);
					end
				end
end

--[========================================================================[
          Grotto. murals. Comments on look at
--]========================================================================]
global W2HubGrotto_Grotto__murals___mural_02 = {
	name = "W2HubGrotto_Grotto__murals___mural_02",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
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

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "This is about the creation of the Covenant. Alliance of the Prophets and the Elites.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_08300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
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



function grotto_mural_03_listener()

local s_speaker:object = nil;
	
	PrintNarrative("WAKE - grotto_mural_03_listener");

	SleepUntil([| object_valid( "cr_mural_03" )  ], 20);

	PrintNarrative("LISTENER - grotto_mural_03_listener");	

		repeat

				repeat 							
						SleepUntil([| (IsSpartanAbleToSpeak(SPARTANS.vale) and object_at_distance_and_can_see_object(players(), OBJECTS.cr_mural_03, 30, 10, VOLUMES.tv_narr_grotto_mural_03) and not IsSpartanInCombat() and not b_found_arbiter) or not object_valid( "cr_mural_03" ) ], 10);

						print("grotto_mural_03_listener: vale is alive and someone is looking and not in combat");

						if object_valid( "cr_mural_03") then

								repeat
									sleep_s(0.1);
									s_speaker = spartan_look_at_object(players(), OBJECTS.cr_mural_03, 30, 10, 1.5, 1);
									print("grotto_mural_03_listener: Player is looking");
									print(s_speaker);
								until s_speaker ~= nil or not object_at_distance_and_can_see_object(players(), OBJECTS.cr_mural_03, 30, 10, VOLUMES.tv_narr_grotto_mural_03)
						end						

				until (NarrativeQueue.ConversationsPlayingCount() == 0 and s_speaker ~= nil and not b_found_arbiter
							and ( (not IsPlayer(SPARTANS.vale) and objects_distance_to_object(s_speaker, SPARTANS.vale) < 30)
									or (IsPlayer(SPARTANS.vale) and object_at_distance_and_can_see_object(SPARTANS.vale, OBJECTS.cr_mural_03, 40, 60) )
								)
						)
						or not object_valid( "cr_mural_03" ) 

				print("grotto_mural_03_listener: Passed Vale test, testing for enemies");

				grotto_is_there_enemy_nearby(20);

		until (not grotto_is_there_enemy_nearby_result and not IsSpartanInCombat()) or not object_valid( "cr_mural_03")
				
				if object_valid( "cr_mural_03") then
					b_first_mural_seen = true;

					sleep_s(0.1);

					if not NarrativeQueue.HasConversationFinished(W2HubGrotto_Grotto__murals___mural_03) then
						PrintNarrative("QUEUE - W2HubGrotto_Grotto__murals___mural_03");
						NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__murals___mural_03);
					end
				end
end

--[========================================================================[
          Grotto. murals. Comments on look at
--]========================================================================]
global W2HubGrotto_Grotto__murals___mural_03 = {
	name = "W2HubGrotto_Grotto__murals___mural_03",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
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

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "The famous Forerunner dreadnought, used by the Prophets to travel to Sanghelios",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_08500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
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



function grotto_mural_04_listener()

local s_speaker:object = nil;
	
	PrintNarrative("WAKE - grotto_mural_04_listener");

	SleepUntil([| object_valid( "cr_mural_04" )  ], 20);

	PrintNarrative("LISTENER - grotto_mural_04_listener");	

		repeat

				repeat 							
						SleepUntil([| (IsSpartanAbleToSpeak(SPARTANS.vale) and object_at_distance_and_can_see_object(players(), OBJECTS.cr_mural_04, 30, 10, VOLUMES.tv_narr_grotto_mural_04) and not IsSpartanInCombat() and not b_found_arbiter) or not object_valid( "cr_mural_04" ) ], 10);

						print("grotto_mural_04_listener: vale is alive and someone is looking and not in combat");

						if object_valid( "cr_mural_04") then

								repeat
									sleep_s(0.1);
									s_speaker = spartan_look_at_object(players(), OBJECTS.cr_mural_04, 30, 10, 1.5, 1);
									print("grotto_mural_04_listener: Player is looking");
									print(s_speaker);
								until s_speaker ~= nil or not object_at_distance_and_can_see_object(players(), OBJECTS.cr_mural_04, 30, 10, VOLUMES.tv_narr_grotto_mural_04)
						end						

				until (NarrativeQueue.ConversationsPlayingCount() == 0 and s_speaker ~= nil and not b_found_arbiter
							and ( (not IsPlayer(SPARTANS.vale) and objects_distance_to_object(s_speaker, SPARTANS.vale) < 30)
									or (IsPlayer(SPARTANS.vale) and object_at_distance_and_can_see_object(SPARTANS.vale, OBJECTS.cr_mural_04, 40, 60) )
								)
						)
						or not object_valid( "cr_mural_04" ) 

				print("grotto_mural_04_listener: Passed Vale test, testing for enemies");

				grotto_is_there_enemy_nearby(20);

		until (not grotto_is_there_enemy_nearby_result and not IsSpartanInCombat()) or not object_valid( "cr_mural_04")
				
				if object_valid( "cr_mural_04") then
					b_first_mural_seen = true;

					sleep_s(0.1);

					if not NarrativeQueue.HasConversationFinished(W2HubGrotto_Grotto__murals___mural_04) then
						PrintNarrative("QUEUE - W2HubGrotto_Grotto__murals___mural_04");
						NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__murals___mural_04);
					end
				end
end

--[========================================================================[
          Grotto. murals. Comments on look at
--]========================================================================]
global W2HubGrotto_Grotto__murals___mural_04 = {
	name = "W2HubGrotto_Grotto__murals___mural_04",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
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

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "I believe this represents one of the 7 Halos. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_08600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
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

function grotto_mural_05_listener()

local s_speaker:object = nil;
	
	PrintNarrative("WAKE - grotto_mural_05_listener");

	SleepUntil([| object_valid( "cr_mural_05" )  ], 20);

	PrintNarrative("LISTENER - grotto_mural_05_listener");	

		repeat

				repeat 							
						SleepUntil([| (IsSpartanAbleToSpeak(SPARTANS.vale) and not IsSpartanInCombat() and ( object_at_distance_and_can_see_object(players(), OBJECTS.cr_mural_05quater, 30, 10, VOLUMES.tv_narr_grotto_mural_05) or object_at_distance_and_can_see_object(players(), OBJECTS.cr_mural_05ter, 30, 10, VOLUMES.tv_narr_grotto_mural_05) or object_at_distance_and_can_see_object(players(), OBJECTS.cr_mural_05bis, 30, 10, VOLUMES.tv_narr_grotto_mural_05) or object_at_distance_and_can_see_object(players(), OBJECTS.cr_mural_05, 30, 10, VOLUMES.tv_narr_grotto_mural_05) )) or not object_valid( "cr_mural_05" ) ], 10);

						print("grotto_mural_05_listener: vale is alive and someone is looking and not in combat");

						if object_valid( "cr_mural_05") then

								repeat
									sleep_s(0.1);
									if object_at_distance_and_can_see_object(players(), OBJECTS.cr_mural_05, 30, 30, VOLUMES.tv_narr_grotto_mural_05) then
										s_speaker = spartan_look_at_object(players(), OBJECTS.cr_mural_05, 30, 30, 1.5, 1);
									elseif object_at_distance_and_can_see_object(players(), OBJECTS.cr_mural_05bis, 30, 30, VOLUMES.tv_narr_grotto_mural_05) then
										s_speaker = spartan_look_at_object(players(), OBJECTS.cr_mural_05bis, 30, 30, 1.5, 1);
									elseif object_at_distance_and_can_see_object(players(), OBJECTS.cr_mural_05ter, 30, 30, VOLUMES.tv_narr_grotto_mural_05) then
										s_speaker = spartan_look_at_object(players(), OBJECTS.cr_mural_05ter, 30, 30, 1.5, 1);
									elseif object_at_distance_and_can_see_object(players(), OBJECTS.cr_mural_05quater, 30, 30, VOLUMES.tv_narr_grotto_mural_05) then
										s_speaker = spartan_look_at_object(players(), OBJECTS.cr_mural_05quater, 30, 30, 1.5, 1);
									end

									print("grotto_mural_05_listener: Player is looking");
									print(s_speaker);
								until s_speaker ~= nil or (not object_at_distance_and_can_see_object(players(), OBJECTS.cr_mural_05quater, 30, 30, VOLUMES.tv_narr_grotto_mural_05) and not object_at_distance_and_can_see_object(players(), OBJECTS.cr_mural_05ter, 30, 30, VOLUMES.tv_narr_grotto_mural_05) and not object_at_distance_and_can_see_object(players(), OBJECTS.cr_mural_05, 30, 30, VOLUMES.tv_narr_grotto_mural_05) and not object_at_distance_and_can_see_object(players(), OBJECTS.cr_mural_05bis, 30, 30, VOLUMES.tv_narr_grotto_mural_05))
						end						

				until (NarrativeQueue.ConversationsPlayingCount() == 0 and s_speaker ~= nil
							and ( (not IsPlayer(SPARTANS.vale) and objects_distance_to_object(s_speaker, SPARTANS.vale) < 30)
									or (IsPlayer(SPARTANS.vale) and object_at_distance_and_can_see_object(SPARTANS.vale, s_speaker, 30, 60) )
								)
						)
						or not object_valid( "cr_mural_05" ) 

				print("grotto_mural_05_listener: Passed Vale test, testing for enemies");

				grotto_is_there_enemy_nearby(20);

		until (not grotto_is_there_enemy_nearby_result and not IsSpartanInCombat()) or not object_valid( "cr_mural_05")
				
				if object_valid( "cr_mural_05") then
					b_first_mural_seen = true;

					sleep_s(0.1);
					
					if not NarrativeQueue.HasConversationFinished(W2HubGrotto_Grotto__murals___mural_05) then
						PrintNarrative("QUEUE - W2HubGrotto_Grotto__murals___mural_05");
						NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__murals___mural_05);
					end
				end
end

--[========================================================================[
          Grotto. murals. Comments on look at
--]========================================================================]
global W2HubGrotto_Grotto__murals___mural_05 = {
	name = "W2HubGrotto_Grotto__murals___mural_05",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
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

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "This shows the war between Prophets and Sangheili. The Prophets ultimately won thanks to their use of Forerunner technology.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_08400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
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

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--	PUSH FORWARD
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

function grotto_pushforward()

	PrintNarrative("WAKE - grotto_pushforward");

	repeat
				SleepUntil([| b_push_forward_vo_timer == 0], 30);

				if IsGoalActive(Grotto.goal_landing) and not W2HubGrotto_GROTTO__landing__pull_forward.localVariables.s_played and not IsGoalActive(Grotto.goal_arbiter) then
				
							PrintNarrative("QUEUE - W2HubGrotto_GROTTO__landing__pull_forward");
							NarrativeQueue.QueueConversation(W2HubGrotto_GROTTO__landing__pull_forward);							
				end

				SleepUntil([| b_push_forward_vo_timer == 0], 30);

				if not b_found_arbiter and playersMovementSpeed() < 2 and not IsGoalActive(Grotto.goal_arbiter) then

							PrintNarrative("QUEUE - W2HubGrotto_Grotto__pull_forward_1");
							NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__pull_forward_1);

							PushForwardVOReset();

				end

				SleepUntil([| b_push_forward_vo_timer == 0], 30);

				if playersMovementSpeed() < 1 and not IsGoalActive(Grotto.goal_arbiter) then

							PrintNarrative("QUEUE - W2HubGrotto_Grotto__pull_forward_2");
							NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__pull_forward_2);

							PushForwardVOReset();
				end

				SleepUntil([| b_push_forward_vo_timer == 0], 30);
	
				if IsGoalActive(Grotto.goal_sinkhole) and b_player_entered_sinkhole and not IsGoalActive(Grotto.goal_arbiter) then

							PrintNarrative("QUEUE - W2HubGrotto_Grotto__Sinkhole__pull_forward_1");
							NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__Sinkhole__pull_forward_1);

							PushForwardVOReset();
				end

				SleepUntil([| b_push_forward_vo_timer == 0], 30);
	
				if IsGoalActive(Grotto.goal_sinkhole)  and b_player_entered_sinkhole and not IsGoalActive(Grotto.goal_arbiter) then

							PrintNarrative("QUEUE - W2HubGrotto_Grotto__Sinkhole__pull_forward_2");
							NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__Sinkhole__pull_forward_2);

							PushForwardVOReset();
				end

				SleepUntil([| b_push_forward_vo_timer == 0], 30);
	
				if IsGoalActive(Grotto.goal_sinkhole) and b_player_entered_sinkhole and not IsGoalActive(Grotto.goal_arbiter)  then

							PrintNarrative("QUEUE - W2HubGrotto_Grotto__Sinkhole__pull_forward_3");
							NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__Sinkhole__pull_forward_3);

							PushForwardVOReset();
				end

				SleepUntil([| b_push_forward_vo_timer == 0], 30);
	
				if IsGoalActive(Grotto.goal_sinkhole) and b_player_entered_sinkhole and not IsGoalActive(Grotto.goal_arbiter)  then

							PrintNarrative("QUEUE - W2HubGrotto_Grotto__Sinkhole__pull_forward_4");
							NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__Sinkhole__pull_forward_4);

							PushForwardVOReset();
				end

				SleepUntil([| b_push_forward_vo_timer == 0], 30);

				if not NarrativeQueue.HasConversationFinished(W2HubGrotto_grotto__makhee__pull_forward) and (IsGoalActive(Grotto.goal_courtyard) or IsGoalActive(Grotto.goal_plaza)) and IsSpartanAbleToSpeak(SPARTANS.locke) and not IsGoalActive(Grotto.goal_arbiter) then

							PrintNarrative("QUEUE - W2HubGrotto_grotto__makhee__pull_forward");
							NarrativeQueue.QueueConversation(W2HubGrotto_grotto__makhee__pull_forward);		

							PushForwardVOReset();
				end

				SleepUntil([| b_push_forward_vo_timer == 0], 30);

				if not NarrativeQueue.HasConversationFinished(W2HubGrotto_Grotto__KEYHOLE__push_forward) and not IsGoalActive(Grotto.goal_arbiter) then

				
							PrintNarrative("QUEUE - W2HubGrotto_Grotto__KEYHOLE__push_forward");
							NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__KEYHOLE__push_forward);			

							PushForwardVOReset();

				end

				SleepUntil([| b_push_forward_vo_timer == 0], 30);
	
				if not b_found_arbiter and not IsGoalActive(Grotto.goal_arbiter) then

							PrintNarrative("QUEUE - W2HubGrotto_Grotto__pull_forward_3");
							NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__pull_forward_3);
							
							PushForwardVOReset();			
				end

				SleepUntil([| b_push_forward_vo_timer == 0], 30);

				if not b_found_arbiter and not IsGoalActive(Grotto.goal_arbiter) then

							PrintNarrative("QUEUE - W2HubGrotto_Grotto__pull_forward_4");
							NarrativeQueue.QueueConversation(W2HubGrotto_Grotto__pull_forward_4);
							
							PushForwardVOReset();						

				end

				SleepUntil([| b_push_forward_vo_timer == 0], 30);

				if IsSpartanAbleToSpeak(SPARTANS.vale) and not IsGoalActive(Grotto.goal_arbiter) then

							PrintNarrative("QUEUE - W2HubGrotto_grotto__Armory__pull_forward");
							NarrativeQueue.QueueConversation(W2HubGrotto_grotto__Armory__pull_forward);		

							PushForwardVOReset();
				end						
	
	b_push_forward_vo_timer_default = b_push_forward_vo_timer_default + 60;

	PushForwardVOReset(b_push_forward_vo_timer_default);

	until list_count(players()) == 0;

	PrintNarrative("END - grotto_pushforward");

end






--[========================================================================[
          Grotto. pull forward

          Those lines can potentially play at any moment of the
          mission, if the players are not in combat for a while.
--]========================================================================]
global W2HubGrotto_Grotto__pull_forward_1 = {
	name = "W2HubGrotto_Grotto__pull_forward_1",

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

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "All quiet here. Best get moving.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_04500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,	
};




--[========================================================================[
          Grotto. pull forward
--]========================================================================]
global W2HubGrotto_Grotto__pull_forward_2 = {
	name = "W2HubGrotto_Grotto__pull_forward_2",

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

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Let's keep moving. Arbiter isn't much farther.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_04700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};



--[========================================================================[
          Grotto. pull forward
--]========================================================================]
global W2HubGrotto_Grotto__pull_forward_3 = {
	name = "W2HubGrotto_Grotto__pull_forward_3",

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

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Ought to get moving if helping Arbiter's still on the docket.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_05600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};


--[========================================================================[
          Grotto. pull forward
--]========================================================================]
global W2HubGrotto_Grotto__pull_forward_4 = {
	name = "W2HubGrotto_Grotto__pull_forward_4",

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

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Let's find Arbiter and get the hell out of here, quick.\r\n\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_06000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};

--[========================================================================[
          GROTTO. landing. pull forward
--]========================================================================]
global W2HubGrotto_GROTTO__landing__pull_forward = {
	name = "W2HubGrotto_GROTTO__landing__pull_forward",

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
					thisConvo.localVariables.s_played = true;
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Wasting daylight standing here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_04900.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return  IsGoalActive(Grotto.goal_landing);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Tanaka's right, move down the river Osiris.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_06100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {
					s_played = nil,
					},
};





--[========================================================================[
          Grotto. KEYHOLE. push forward

          If the player spend more time in that area.
--]========================================================================]
global W2HubGrotto_Grotto__KEYHOLE__push_forward = {
	name = "W2HubGrotto_Grotto__KEYHOLE__push_forward",

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

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "If the Arbiter dies, we lose our best shot at the Guardian, and humanity's best ally among the Elites.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_04600.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                   radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "We can always shoot our way to Sunaion.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_03700.sound'),

			sleepAfter = 0.5,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not IsSpartanInCombat();
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "We could. But let's try the strategic approach first.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_02300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	
};

--[========================================================================[
          Grotto. Sinkhole. pull forward

          In case of a player reach the top but is hanging there or is
          going back down. We remind us of the urgency.
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__pull_forward_1 = {
	name = "W2HubGrotto_Grotto__Sinkhole__pull_forward_1",

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

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: locke
			text = "Keep moving up, Osiris.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_06500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};


--[========================================================================[
          Grotto. Sinkhole. pull forward

          In case of a player reach the top but is hanging there or is
          going back down. We remind us of the urgency.
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__pull_forward_2 = {
	name = "W2HubGrotto_Grotto__Sinkhole__pull_forward_2",

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

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Keep moving up, Osiris.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_05000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};



--[========================================================================[
          Grotto. Sinkhole. pull forward

          In case of a player reach the top but is hanging there or is
          going back down. We remind us of the urgency.
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__pull_forward_3 = {
	name = "W2HubGrotto_Grotto__Sinkhole__pull_forward_3",

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

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Keep moving up, Osiris.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_tanaka_04300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};



--[========================================================================[
          Grotto. Sinkhole. pull forward

          In case of a player reach the top but is hanging there or is
          going back down. We remind us of the urgency.
--]========================================================================]
global W2HubGrotto_Grotto__Sinkhole__pull_forward_4 = {
	name = "W2HubGrotto_Grotto__Sinkhole__pull_forward_4",

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

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Keep moving up, Osiris.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_05400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};


--[========================================================================[
          grotto. Armory. pull forward
--]========================================================================]
global W2HubGrotto_grotto__Armory__pull_forward = {
	name = "W2HubGrotto_grotto__Armory__pull_forward",

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

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "The covenant are outnumbering Arbiter forces. They need our help!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_06300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,	
};



--[========================================================================[
          grotto. Armory. pull forward
--]========================================================================]
global W2HubGrotto_grotto__makhee__pull_forward = {
	name = "W2HubGrotto_grotto__makhee__pull_forward",

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
			
			moniker = "Makhee",

			--character = 0, -- GAMMA_CHARACTER: Eliteescort (MAKHEE)
			text = "Spartan Locke? What is your situation?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_cv_eliteescort_03100.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "On our way Makhee.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_11500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};


-- =================================================================================================          
-- =================================================================================================     
--	CHATTER
-- =================================================================================================          
-- =================================================================================================    


function grotto_four_players_combat_check()

	PrintNarrative("START - grotto_four_players_combat_check");

	repeat

		SleepUntil([| list_count(players()) == 4], 1800);

		repeat 

			SleepUntil([| ((b_push_forward_vo_counrdown_on > 20 and not IsSpartanInCombat()) or list_count(players()) ~= 4)], 30);

			if list_count(players()) == 4 then
				grotto_is_there_enemy_nearby(30);

				if grotto_is_there_enemy_nearby_result then
					PushForwardVOReset();
				end
			end

		until not b_push_forward_vo_active or list_count(players()) ~= 4

	until not IsMissionActive(Grotto)

	PrintNarrative("END - grotto_four_players_combat_check");
	
end


function grotto_is_there_enemy_nearby(distance:number)

	PrintNarrative("START - grotto_is_there_enemy_nearby");

	if	TestClosestEnemyDistance(AI.sg_falls_all, distance) or
		TestClosestEnemyDistance(AI.sg_falls_dropship_all, distance) or
		TestClosestEnemyDistance(AI.sg_sinkhole_all, distance)  or
		TestClosestEnemyDistance(AI.sg_armory_all, distance)  or
		TestClosestEnemyDistance(AI.sg_airlock_all, distance)  or
		TestClosestEnemyDistance(AI.sg_courtyard_all, distance)  or		
		TestClosestEnemyDistance(AI.sg_plaza_all, distance)  or		
		TestClosestEnemyDistance(AI.sg_hq_wave_01, distance)  or
		TestClosestEnemyDistance(AI.sg_hq_wave_02, distance)  or
		TestClosestEnemyDistance(AI.sg_doorway_all, distance) then

				grotto_is_there_enemy_nearby_result = true;
				PrintNarrative("grotto_is_there_enemy_nearby_result = true;");
	else
				grotto_is_there_enemy_nearby_result = false;
				PrintNarrative("grotto_is_there_enemy_nearby_result = false;");
	end

	PrintNarrative("END - grotto_is_there_enemy_nearby");

	return grotto_is_there_enemy_nearby_result

end

-----------------------------------------------------------------

function grotto_player_in_chatter_zone()

	PrintNarrative("WAKE - grotto_player_in_chatter_zone");
	--[[
	if volume_test_players_all( volume ) then
		return true
	else
		return false
	end
		]]		
	PrintNarrative("END - grotto_player_in_chatter_zone");

end


function grotto_chatter()
local s_chatter_01:boolean = false;
local s_chatter_02:boolean = false;


	PrintNarrative("WAKE - grotto_chatter");

	repeat
				repeat
					sleep_s(5);
					SleepUntil([| b_push_forward_vo_counrdown_on > 45 and not b_collectible_used and not IsSpartanInCombat() and IsSpartanAbleToSpeak(SPARTANS.buck) and IsSpartanAbleToSpeak(SPARTANS.locke)], 30);
		
					grotto_is_there_enemy_nearby(60);
				until not grotto_is_there_enemy_nearby_result
				
				if  not IsGoalActive(Grotto.goal_arbiter) and not NarrativeQueue.HasConversationFinished(W2HubGrotto_EXTRA_CHATTER) then
				
							PrintNarrative("QUEUE - W2HubGrotto_EXTRA_CHATTER");
							NarrativeQueue.QueueConversation(W2HubGrotto_EXTRA_CHATTER);

							PushForwardVOReset(50);

							s_chatter_01 = true;
				end				

				repeat
					sleep_s(5);
					SleepUntil([| b_push_forward_vo_counrdown_on > 45 and not b_collectible_used and not IsSpartanInCombat() and IsSpartanAbleToSpeak(SPARTANS.buck) and IsSpartanAbleToSpeak(SPARTANS.vale)], 30);

					grotto_is_there_enemy_nearby(60);
				until not grotto_is_there_enemy_nearby_result

				if not IsGoalActive(Grotto.goal_arbiter) and not NarrativeQueue.HasConversationFinished(W2HubGrotto_chatter_civil_war) then
				
							PrintNarrative("QUEUE - W2HubGrotto_chatter_civil_war");
							NarrativeQueue.QueueConversation(W2HubGrotto_chatter_civil_war);

							PushForwardVOReset(70);

							s_chatter_02 = true;
				end

			
				
				sleep_s(2);

	until s_chatter_01 and s_chatter_02 

	PrintNarrative("END - grotto_chatter");

end




--[========================================================================[
          EXTRA CHATTER

          Not sure where this fits, but we need it. 

          Out of combat, conversational:
--]========================================================================]
global W2HubGrotto_EXTRA_CHATTER = {
	name = "W2HubGrotto_EXTRA_CHATTER",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not grotto_is_there_enemy_nearby_result;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					CreateThread(grotto_is_there_enemy_nearby, 20);
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "The elites used to call Chief \"the demon,\" but Arbiter worked with him. Helped Chief win the war even. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_08400.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not grotto_is_there_enemy_nearby_result and not IsSpartanInCombat();
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "War has a habit of making strange allies. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_locke_12400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--CreateMissionThread(plateau_sword_listener);
		hud_hide_radio_transmission_hud();
	end,
};



--[========================================================================[          
          OSIRIS - DISCUSS CIVIL WAR

          This can fit in any Grotto or the Sanghelios hubs.
--]========================================================================]
global W2HubGrotto_chatter_civil_war = {
	name = "W2HubGrotto_chatter_civil_war",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not grotto_is_there_enemy_nearby_result;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					CreateThread(grotto_is_there_enemy_nearby, 30);
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "So Vale, you think Arbiter can win his war?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_buck_08300.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not grotto_is_there_enemy_nearby_result and not IsSpartanInCombat();
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					CreateThread(grotto_is_there_enemy_nearby, 30);
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Easily. Maintaining peace afterwards will be the hard part.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_09100.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not grotto_is_there_enemy_nearby_result and not IsSpartanInCombat();
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					CreateThread(grotto_is_there_enemy_nearby, 30);
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Arbiter built the Swords of Sanghelios from a coalition of bickering clans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_09200.sound'),
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not grotto_is_there_enemy_nearby_result and not IsSpartanInCombat();
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "It will be a heck of a magic trick if he can keep them from turning on one another once they don't have the Covenant to fight.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubgrotto\001_vo_scr_w2hubgrotto_un_vale_09300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};




-- =================================================================================================          
-- =================================================================================================     
--	COLLECTIBLES - SWORD
-- =================================================================================================          
-- =================================================================================================    




function grotto_sword_listener_01()

local s_speaker:object = nil;

	SleepUntil([| object_valid( "coll_falls_01" )  ], 200);

	PrintNarrative("LISTENER - grotto_sword_listener_01");
	if not (Collectibles_First_time_player_find_a_sword_locke.localVariables.s_speaker and Collectibles_First_time_player_find_a_sword_buck.localVariables.s_speaker and Collectibles_First_time_player_find_a_sword_tanaka.localVariables.s_speaker and Collectibles_First_time_player_find_a_sword_vale.localVariables.s_speaker) then

			repeat 							
					SleepUntil([| volume_test_players(VOLUMES.tv_narr_sangblade_01) or not object_valid( "coll_falls_01" ) ], 10);

					if object_valid( "coll_falls_01") then

							repeat
								Sleep(10);
								s_speaker = spartan_look_at_object(players(), OBJECTS.coll_falls_01, 5, 30, 0.2, 2);
							until s_speaker ~= nil or not volume_test_players(VOLUMES.tv_narr_sangblade_01)
					end

			until (NarrativeQueue.ConversationsPlayingCount() == 0 and s_speaker ~= nil) or not object_valid( "coll_falls_01" ) 

			if s_speaker == SPARTANS.locke and object_valid( "coll_falls_01" ) and not NarrativeQueue.HasConversationFinished(Collectibles_First_time_player_find_a_sword_locke) then
				
				PrintNarrative("QUEUE - Collectibles_First_time_player_find_a_sword_locke");
				NarrativeQueue.QueueConversation(Collectibles_First_time_player_find_a_sword_locke);

				RegisterInteractEvent( plateau_sword_launcher_interupt, OBJECTS.coll_falls_01);
			elseif s_speaker == SPARTANS.buck and object_valid( "coll_falls_01" ) and not NarrativeQueue.HasConversationFinished(Collectibles_First_time_player_find_a_sword_buck) then
				
				PrintNarrative("QUEUE - Collectibles_First_time_player_find_a_sword_buck");
				NarrativeQueue.QueueConversation(Collectibles_First_time_player_find_a_sword_buck);

				RegisterInteractEvent( plateau_sword_launcher_interupt, OBJECTS.coll_falls_01);
			elseif s_speaker == SPARTANS.tanaka and object_valid( "coll_falls_01" ) and not NarrativeQueue.HasConversationFinished(Collectibles_First_time_player_find_a_sword_tanaka) then
				
				PrintNarrative("QUEUE - Collectibles_First_time_player_find_a_sword_tanaka");
				NarrativeQueue.QueueConversation(Collectibles_First_time_player_find_a_sword_tanaka);

				RegisterInteractEvent( plateau_sword_launcher_interupt, OBJECTS.coll_falls_01);
			elseif s_speaker == SPARTANS.vale and object_valid( "coll_falls_01" ) and not NarrativeQueue.HasConversationFinished(Collectibles_First_time_player_find_a_sword_vale) then
				
				PrintNarrative("QUEUE - Collectibles_First_time_player_find_a_sword_vale");
				NarrativeQueue.QueueConversation(Collectibles_First_time_player_find_a_sword_vale);

				RegisterInteractEvent( plateau_sword_launcher_interupt, OBJECTS.coll_falls_01);
			end
	end
end



function grotto_sword_listener_02()

local s_speaker:object = nil;

	SleepUntil([| object_valid( "coll_sinkhole_01" )  ], 200);

	PrintNarrative("LISTENER - grotto_sword_listener_02");
	if not (Collectibles_First_time_player_find_a_sword_locke.localVariables.s_speaker and Collectibles_First_time_player_find_a_sword_buck.localVariables.s_speaker and Collectibles_First_time_player_find_a_sword_tanaka.localVariables.s_speaker and Collectibles_First_time_player_find_a_sword_vale.localVariables.s_speaker) then

			repeat 							
					SleepUntil([| volume_test_players(VOLUMES.tv_narr_sangblade_02) or not object_valid( "coll_sinkhole_01" ) ], 10);		

					if object_valid( "coll_sinkhole_01") then

							repeat
								Sleep(10);
								s_speaker = spartan_look_at_object(players(), OBJECTS.coll_sinkhole_01, 5, 30, 0.2, 2);
							until s_speaker ~= nil or not volume_test_players(VOLUMES.tv_narr_sangblade_02)
					end

			until (NarrativeQueue.ConversationsPlayingCount() == 0 and s_speaker ~= nil) or not object_valid( "coll_sinkhole_01" ) 

			if s_speaker == SPARTANS.locke and object_valid( "coll_sinkhole_01" ) and not NarrativeQueue.HasConversationFinished(Collectibles_First_time_player_find_a_sword_locke)  then
				
				PrintNarrative("QUEUE - Collectibles_First_time_player_find_a_sword_locke");
				NarrativeQueue.QueueConversation(Collectibles_First_time_player_find_a_sword_locke);

				RegisterInteractEvent( plateau_sword_launcher_interupt, OBJECTS.coll_sinkhole_01);
			elseif s_speaker == SPARTANS.buck and object_valid( "coll_sinkhole_01" ) and not NarrativeQueue.HasConversationFinished(Collectibles_First_time_player_find_a_sword_buck) then
				
				PrintNarrative("QUEUE - Collectibles_First_time_player_find_a_sword_buck");
				NarrativeQueue.QueueConversation(Collectibles_First_time_player_find_a_sword_buck);

				RegisterInteractEvent( plateau_sword_launcher_interupt, OBJECTS.coll_sinkhole_01);
			elseif s_speaker == SPARTANS.tanaka and object_valid( "coll_sinkhole_01" ) and not NarrativeQueue.HasConversationFinished(Collectibles_First_time_player_find_a_sword_tanaka) then
				
				PrintNarrative("QUEUE - Collectibles_First_time_player_find_a_sword_tanaka");
				NarrativeQueue.QueueConversation(Collectibles_First_time_player_find_a_sword_tanaka);

				RegisterInteractEvent( plateau_sword_launcher_interupt, OBJECTS.coll_sinkhole_01);
			elseif s_speaker == SPARTANS.vale and object_valid( "coll_sinkhole_01" ) and not NarrativeQueue.HasConversationFinished(Collectibles_First_time_player_find_a_sword_vale) then
				
				PrintNarrative("QUEUE - Collectibles_First_time_player_find_a_sword_vale");
				NarrativeQueue.QueueConversation(Collectibles_First_time_player_find_a_sword_vale);

				RegisterInteractEvent( plateau_sword_launcher_interupt, OBJECTS.coll_sinkhole_01);
			end
	end
end


function plateau_sword_listener_03()

local s_speaker:object = nil;

	SleepUntil([| object_valid( "coll_landing_01" )  ], 200);

	PrintNarrative("LISTENER - plateau_sword_listener_03");
	if not (Collectibles_First_time_player_find_a_sword_locke.localVariables.s_speaker and Collectibles_First_time_player_find_a_sword_buck.localVariables.s_speaker and Collectibles_First_time_player_find_a_sword_tanaka.localVariables.s_speaker and Collectibles_First_time_player_find_a_sword_vale.localVariables.s_speaker) then

			repeat 							
					SleepUntil([| volume_test_players(VOLUMES.tv_narr_sangblade_03) or not object_valid( "coll_landing_01" ) ], 10);		

					if object_valid( "coll_landing_01") then

							repeat
								Sleep(10);
								s_speaker = spartan_look_at_object(players(), OBJECTS.coll_landing_01, 5, 30, 0.2, 2);
							until s_speaker ~= nil or not volume_test_players(VOLUMES.tv_narr_sangblade_03)
					end

			until (NarrativeQueue.ConversationsPlayingCount() == 0 and s_speaker ~= nil) or not object_valid( "coll_landing_01" ) 

			if s_speaker == SPARTANS.locke and object_valid( "coll_landing_01" ) and not NarrativeQueue.HasConversationFinished(Collectibles_First_time_player_find_a_sword_locke) then
				
				PrintNarrative("QUEUE - Collectibles_First_time_player_find_a_sword_locke");
				NarrativeQueue.QueueConversation(Collectibles_First_time_player_find_a_sword_locke);

				RegisterInteractEvent( plateau_sword_launcher_interupt, OBJECTS.coll_landing_01);
			elseif s_speaker == SPARTANS.buck and object_valid( "coll_landing_01" ) and not NarrativeQueue.HasConversationFinished(Collectibles_First_time_player_find_a_sword_buck) then
				
				PrintNarrative("QUEUE - Collectibles_First_time_player_find_a_sword_buck");
				NarrativeQueue.QueueConversation(Collectibles_First_time_player_find_a_sword_buck);

				RegisterInteractEvent( plateau_sword_launcher_interupt, OBJECTS.coll_landing_01);
			elseif s_speaker == SPARTANS.tanaka and object_valid( "coll_landing_01" ) and not NarrativeQueue.HasConversationFinished(Collectibles_First_time_player_find_a_sword_tanaka) then
				
				PrintNarrative("QUEUE - Collectibles_First_time_player_find_a_sword_tanaka");
				NarrativeQueue.QueueConversation(Collectibles_First_time_player_find_a_sword_tanaka);

				RegisterInteractEvent( plateau_sword_launcher_interupt, OBJECTS.coll_landing_01);
			elseif s_speaker == SPARTANS.vale and object_valid( "coll_landing_01" ) and not NarrativeQueue.HasConversationFinished(Collectibles_First_time_player_find_a_sword_vale) then
				
				PrintNarrative("QUEUE - Collectibles_First_time_player_find_a_sword_vale");
				NarrativeQueue.QueueConversation(Collectibles_First_time_player_find_a_sword_vale);

				RegisterInteractEvent( plateau_sword_launcher_interupt, OBJECTS.coll_landing_01);
			end
	end
end

function plateau_sword_launcher_interupt(sword:object, player_interacted:object)

	if player_interacted == SPARTANS.locke then
		PrintNarrative("INTERRUPT - Collectibles_First_time_player_find_a_sword_locke");
		NarrativeQueue.InterruptConversation(Collectibles_First_time_player_find_a_sword_locke);
	elseif player_interacted == SPARTANS.buck then
		PrintNarrative("INTERRUPT - Collectibles_First_time_player_find_a_sword_buck");
		NarrativeQueue.InterruptConversation(Collectibles_First_time_player_find_a_sword_buck);
	elseif player_interacted == SPARTANS.tanaka then
		PrintNarrative("INTERRUPT - Collectibles_First_time_player_find_a_sword_tanaka");
		NarrativeQueue.InterruptConversation(Collectibles_First_time_player_find_a_sword_tanaka);
	elseif player_interacted == SPARTANS.vale then
		PrintNarrative("INTERRUPT - Collectibles_First_time_player_find_a_sword_vale");
		NarrativeQueue.InterruptConversation(Collectibles_First_time_player_find_a_sword_vale);
	end

end
	
--[========================================================================[
          First time player find a sword
--]========================================================================]
global Collectibles_First_time_player_find_a_sword_locke = {
	name = "Collectibles_First_time_player_find_a_sword_locke",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.locke,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_speaker == nil and not b_collectible_used;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					thisConvo.localVariables.s_speaker = true;
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "This is an old Sangheili sword. Must have been there for centuries...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_collectibles\001_vo_scr_collectibles_un_locke_00100.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,	
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_collectible_used;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "There is a Sangheili inscription on it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_collectibles\001_vo_scr_collectibles_un_locke_00200.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
--		CreateMissionThread(plateau_sword_listener);
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {
					s_speaker = nil,
					},
};



--[========================================================================[
          First time player find a sword
--]========================================================================]
global Collectibles_First_time_player_find_a_sword_buck = {
	name = "Collectibles_First_time_player_find_a_sword_buck",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.buck,

	lines = {		
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_speaker == nil and not b_collectible_used;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					thisConvo.localVariables.s_speaker = true;
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Locke
			text = "This is an old Sangheili sword. Must have been there for centuries...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_collectibles\001_vo_scr_collectibles_un_buck_00100.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,	
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_collectible_used;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Locke
			text = "There is a Sangheili inscription on it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_collectibles\001_vo_scr_collectibles_un_buck_00200.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--CreateMissionThread(plateau_sword_listener);
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {
					s_speaker = nil,
					},
};


--[========================================================================[
          First time player find a sword
--]========================================================================]
global Collectibles_First_time_player_find_a_sword_tanaka = {
	name = "Collectibles_First_time_player_find_a_sword_tanaka",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.tanaka,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_speaker == nil and not b_collectible_used;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID                    
					thisConvo.localVariables.s_speaker = true;
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Locke
			text = "This is an old Sangheili sword. Must have been there for centuries...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_collectibles\001_vo_scr_collectibles_un_tanaka_00100.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_collectible_used;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Locke
			text = "There is a Sangheili inscription on it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_collectibles\001_vo_scr_collectibles_un_tanaka_00200.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		--CreateMissionThread(plateau_sword_listener);
	end,

	localVariables = {
					s_speaker = nil,
					},
};



--[========================================================================[
          First time player find a sword
--]========================================================================]
global Collectibles_First_time_player_find_a_sword_vale = {
	name = "Collectibles_First_time_player_find_a_sword_vale",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.vale,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_speaker == nil and not b_collectible_used;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID                    
					thisConvo.localVariables.s_speaker = true;
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Locke
			text = "This is an old Sangheili sword. Must have been there for centuries...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_collectibles\001_vo_scr_collectibles_un_vale_01800.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,	
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_collectible_used;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Locke
			text = "There is a Sangheili inscription on it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_collectibles\001_vo_scr_collectibles_un_vale_01900.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--CreateMissionThread(plateau_sword_listener);
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {
					s_speaker = nil,
					},
};
