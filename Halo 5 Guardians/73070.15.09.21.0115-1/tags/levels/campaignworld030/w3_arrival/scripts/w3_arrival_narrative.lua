 --## SERVER

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ WORLD 03 NARRATIVE - ARRIVAL *_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*

-- =================================================================================================
-- =================================================================================================b
-- =================================================================================================
-- *** GLOBALS ***
-- =================================================================================================		

	global b_monitor_release:boolean=false;
	global nar_arr_chatter_domain:boolean=true;
	
	global n_guardian_run_push_timer:number=30;
	global b_player_saw_monitor:boolean=false;

	global b_monitor_full_speech_ended:boolean=false;

	global b_monitor_encounter_speech:boolean=false;

	global b_elevator_comp_played:boolean=false;
	
	global b_players_reached_front_road_door:boolean=false;
	global b_cave_gateway_speech:boolean=false;
	global b_player_entered_crossing:boolean=false;
	global b_player_exited_grasslands:boolean=false;

	global b_player_are_about_to_see_guardian:boolean=false;

	global b_player_crossed_bridge:boolean=false;

	global b_warden_saw_players:boolean=false;
	
	global b_warden_encounter_push_forward_timer:number = 0;
	
	global s_1st_pelican_looked_at:object = nil;
	global s_2nd_pelican_looked_at:object = nil;
	
	global b_locke_saw_pelican:boolean=false;
	global b_buck_saw_pelican:boolean=false;
	global b_tanaka_saw_pelican:boolean=false;
	global b_vale_saw_pelican:boolean=false;

	global b_tunnel_player_saw_the_gateway:boolean=false;
	
	global b_human_casualities:object = nil;

	
	global b_monitor_general_lines:boolean=false;
	global b_monitor_general_line_1:boolean=false;
	global b_monitor_general_line_2:boolean=false;
	global b_monitor_general_line_3:boolean=false;
	global b_monitor_general_line_4:boolean=false;
	global b_monitor_general_line_5:boolean=false;

	global b_arrival_guardian_surprise:boolean=false;
	global b_arrival_guardian_landing:boolean=false;

	global b_guardian_run_part_2:boolean=false;

	global b_locke_saw_dead_bodies:boolean=false;
	global b_buck_saw_dead_bodies:boolean=false;
	global b_tanaka_saw_dead_bodies:boolean=false;
	global b_vale_saw_dead_bodies:boolean=false;

	global b_crossing_player_looked_at_banshee:boolean=false;
	
	global b_pushforward_road_played:boolean=false;

	global b_landing_monitor_talking_distance:number = 12;

	global b_monitor_is_on_radio:boolean=false;

	global b_monitor_speech_end:boolean=false;

	global b_players_in_gateway_encounter_area:boolean=false;

	global b_landing_chief_interrupt:boolean=false;	
	
	global b_narrative_chapter_road:boolean=false;	
	
	global b_landing_elevator_starts:boolean=false;	

	global b_guardian_start_shaking:boolean=false;	
	
	global arrival_is_there_enemy_nearby_result:boolean=false;	
	
	global b_arrival_post_guardian_slipspace:boolean=false;	

	global b_comment_about_stare:boolean=false;	
	
	global b_monitor_friendly_fire:boolean=false;		

	global b_player_was_in_tank:boolean=false;	

	global guardian_intro_emote_locke:boolean=false;	
	global guardian_intro_emote_locke_2:boolean=false;	
	global guardian_intro_emote_locke_ground:boolean=false;	
	global guardian_intro_emote_buck:boolean=false;	
	global guardian_intro_emote_buck_2:boolean=false;	
	global guardian_intro_emote_buck_ground:boolean=false;	
	global guardian_intro_emote_tanaka:boolean=false;	
	global guardian_intro_emote_tanaka_2:boolean=false;	
	global guardian_intro_emote_tanaka_ground:boolean=false;	
	global guardian_intro_emote_vale:boolean=false;	
	global guardian_intro_emote_vale_2:boolean=false;	
	global guardian_intro_emote_vale_ground:boolean=false;	
	
	global b_arrival_guardian_outro_floating_piece:boolean=false;

	global b_arrival_guardian_outro_locke_fall:boolean=false;
	global b_arrival_guardian_outro_buck_fall:boolean=false;
	global b_arrival_guardian_outro_tanaka_fall:boolean=false;
	global b_arrival_guardian_outro_vale_fall:boolean=false;

	global b_arrival_guardian_outro_landing_locke:boolean=false;
	global b_arrival_guardian_outro_landing_buck:boolean=false;
	global b_arrival_guardian_outro_landing_tanaka:boolean=false;
	global b_arrival_guardian_outro_landing_vale:boolean=false;
	
	
	

function arrival_narrative_startup()

	print("*************  ARRIVAL NARRATIVE LOADED ******************");
	g_display_narrative_debug_info = true;

	PrintNarrative("Killing Narrative Queue");
	NarrativeQueue.Kill();

	SleepUntil([| list_count(players()) ~= 0], 10);

	b_push_forward_vo_timer_default = 60;

--	Force display Temp Text from TTS (Subtitles)
--	dialog_line_temp_blurb_force_set(true);

	CreateMissionThread(PushForwardVO, missionArrival.goal_arrival_blueteam);
	CreateMissionThread(arrival_pushforward);
	CreateMissionThread(PushForwardVOStandBy);
	--CreateMissionThread(arrival_chatter);
	CreateMissionThread(arrival_four_players_combat_check);

	CreateMissionThread(arrival_monitor_during_encounter_general_lines);

	CreateMissionThread(arrival_exuberant_stares);
	CreateMissionThread(arrival_exuberant_shooting);
end



--/////////////////////////////////////////////////////////////////////////////////
-- MAIN
--/////////////////////////////////////////////////////////////////////////////////



function arrival_sassy_spark_character()

	--PrintNarrative("LOAD - arrival_sassy_spark_character");

	if not ai_get_object(AI.sq_sassy_spark) then
		return NarrativeQueue.NoCharacter;
	else
		if ai_living_count(AI.sq_sassy_spark.spawn_gate_01_landing) == 1 then
			return AI.sq_sassy_spark.spawn_gate_01_landing;
		elseif ai_living_count(AI.sq_sassy_spark.spawn_gate_02_tank) == 1 then
			return AI.sq_sassy_spark.spawn_gate_02_tank;
		elseif ai_living_count(AI.sq_sassy_spark.spawn_gate_03_cave) == 1 then
			return AI.sq_sassy_spark.spawn_gate_03_cave;
		elseif ai_living_count(AI.sq_sassy_spark.spawn_gate_04_bridge) == 1 then
			return AI.sq_sassy_spark.spawn_gate_04_bridge;
		elseif ai_living_count(AI.sq_sassy_spark.spawn_gate_05_easter) == 1 then
			return AI.sq_sassy_spark.spawn_gate_05_easter;
		elseif ai_living_count(AI.sq_sassy_spark.spawn_gate_06_gateway) == 1 then
			return AI.sq_sassy_spark.spawn_gate_06_gateway;
		end
	end


end




-- =================================================================================================		
--   _____ _    _         _____  _____ _____          _   _ 
--  / ____| |  | |  /\   |  __ \|  __ \_   _|   /\   | \ | |
-- | |  __| |  | | /  \  | |__) | |  | || |    /  \  |  \| |
-- | | |_ | |  | |/ /\ \ |  _  /| |  | || |   / /\ \ | . ` |
-- | |__| | |__| / ____ \| | \ \| |__| || |_ / ____ \| |\  |
--  \_____|\____/_/    \_\_|  \_\_____/_____/_/    \_\_| \_|
--
-- =================================================================================================		                                                          
                                                          

function arrival_guardian_start()

	PrintNarrative("WAKE - arrival_guardian_start");

	PrintNarrative("START - arrival_guardian_start");
				
	PushForwardVOStandBy();

			PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian__start");
			NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian__start);
			
			PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian_intro_emote_buck");
			NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian_intro_emote_buck);
			PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian_intro_emote_buck_2");
			NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian_intro_emote_buck_2);
			PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian_intro_emote_buck_ground");
			NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian_intro_emote_buck_ground);
			
			PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian_intro_emote_vale");
			NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian_intro_emote_vale);
			PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian_intro_emote_vale_2");
			NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian_intro_emote_vale_2);
			PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian_intro_emote_vale_ground");
			NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian_intro_emote_vale_ground);
			

	PrintNarrative("END - arrival_guardian_start");

end


--[========================================================================[
          ARRIVAL. guardian. start

          Osiris is on the Guardian, on a platform, looking at the
          upper atmosphere of Genesis.
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian__start = {
	name = "W3HubArrival_ARRIVAL__guardian__start",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	sleepBefore = 2.5,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Is that it? ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_01100.sound'),

			--playDurationAdjustment = 0.9,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[2] = {

			sleepBefore = 2.3,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VaLE
			text = "Where are we?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_vale_00700.sound'),

			playDurationAdjustment = 0.7,
		},
	},

	OnFinish = function (thisConvo, queue)		
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian__ICS");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian__ICS);		
	end,

	
};


---------------------------------------------------------------------------------------------------------------------------------------------------


--========================================================================
          --ARRIVAL. guardian. ICS
          --Big sound and start of Guardians transformation
--========================================================================
global W3HubArrival_ARRIVAL__guardian__ICS_2 = {
	name = "W3HubArrival_ARRIVAL__guardian__ICS_2",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not NarrativeQueue.HasConversationFinished(W3HubArrival_ARRIVAL__guardian__run_start);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			sleepBefore = 1.8,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Activate mag boots!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_04100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian_intro_emote_locke_2");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian_intro_emote_locke_2);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian_intro_emote_locke_ground");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian_intro_emote_locke_ground);
	end,
};

--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian_intro_emote_locke = {
	name = "W3HubArrival_ARRIVAL__guardian_intro_emote_locke",

	CanStart = function (thisConvo, queue)
		return guardian_intro_emote_locke; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.locke,

	lines = {
		[1] = {
			sleepBefore = 1,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "[Ground tilting]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_07000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian_intro_emote_locke_2");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian_intro_emote_locke_2);
	end,
};




--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian_intro_emote_locke_2 = {
	name = "W3HubArrival_ARRIVAL__guardian_intro_emote_locke_2",

	CanStart = function (thisConvo, queue)
		return guardian_intro_emote_locke_2; -- GAMMA_CONDITION
	end,

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
			text = "[Fall & slide]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_07100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian_intro_emote_locke_ground = {
	name = "W3HubArrival_ARRIVAL__guardian_intro_emote_locke_ground",

	CanStart = function (thisConvo, queue)
		return guardian_intro_emote_locke_ground; -- GAMMA_CONDITION
	end,

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
			text = "[Ground impact]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_07200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};

--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian_intro_emote_buck = {
	name = "W3HubArrival_ARRIVAL__guardian_intro_emote_buck",

	CanStart = function (thisConvo, queue)
		return guardian_intro_emote_buck; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.buck,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BuCK
			text = "[Ground tilting]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_buck_04900.sound'),

			playDurationAdjustment = 0.5,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian_intro_emote_buck_2 = {
	name = "W3HubArrival_ARRIVAL__guardian_intro_emote_buck_2",

	CanStart = function (thisConvo, queue)
		return guardian_intro_emote_buck_2; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.buck,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BuCK
			text = "[Fall & slide]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_buck_05000.sound'),			

			playDurationAdjustment = 0.5,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian_intro_emote_buck_ground = {
	name = "W3HubArrival_ARRIVAL__guardian_intro_emote_buck_ground",

	CanStart = function (thisConvo, queue)
		return guardian_intro_emote_buck_ground; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.buck,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BuCK
			text = "[Ground impact]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_buck_05100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,	
};

--========================================================================
          --ARRIVAL. guardian. ICS
          --Big sound and start of Guardians transformation
--========================================================================
global W3HubArrival_ARRIVAL__guardian__ICS = {
	name = "W3HubArrival_ARRIVAL__guardian__ICS",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter;
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
			text = "What's the...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_01200.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian_intro_emote_tanaka");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian_intro_emote_tanaka);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian_intro_emote_tanaka_2");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian_intro_emote_tanaka_2);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian_intro_emote_tanaka_ground");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian_intro_emote_tanaka_ground);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian__ICS_2");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian__ICS_2);
	end,
};


--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian_intro_emote_tanaka = {
	name = "W3HubArrival_ARRIVAL__guardian_intro_emote_tanaka",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.tanaka,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TanaKA
			text = "[Ground tilting]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_04700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian_intro_emote_tanaka_2 = {
	name = "W3HubArrival_ARRIVAL__guardian_intro_emote_tanaka_2",

	CanStart = function (thisConvo, queue)
		return guardian_intro_emote_tanaka_2; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.tanaka,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TanaKA
			text = "[Fall & slide]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_04800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian_intro_emote_tanaka_ground = {
	name = "W3HubArrival_ARRIVAL__guardian_intro_emote_tanaka_ground",

	CanStart = function (thisConvo, queue)
		return guardian_intro_emote_tanaka_ground; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.tanaka,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TanaKA
			text = "[Ground impact]\r\n\r\n\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_04900.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};

--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian_intro_emote_vale = {
	name = "W3HubArrival_ARRIVAL__guardian_intro_emote_vale",

	CanStart = function (thisConvo, queue)
		return guardian_intro_emote_vale; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.vale,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "[Ground tilting]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_vale_04900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian_intro_emote_vale_2 = {
	name = "W3HubArrival_ARRIVAL__guardian_intro_emote_vale_2",

	CanStart = function (thisConvo, queue)
		return guardian_intro_emote_vale_2; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.vale,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "[Fall & slide]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_vale_05000.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


--[========================================================================[
          ARRIVAL. guardian. ICS

          Big sound and start of Guardian's transformation
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian_intro_emote_vale_ground = {
	name = "W3HubArrival_ARRIVAL__guardian_intro_emote_vale_ground",

	CanStart = function (thisConvo, queue)
		return guardian_intro_emote_vale_ground; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.vale,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "[Ground impact]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_vale_05100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};



---------------------------------------------------------------------------------------------------------------------------------------------------


function arrival_guardian_run_start()

	PrintNarrative("WAKE - arrival_guardian_run_start");

	PrintNarrative("START - arrival_guardian_run_start");
				
	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian__run_start");
	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian__run_start);	
	
	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian__run_start_running");
	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian__run_start_running);
	
	
	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian__archway");
	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian__archway);
	
	CreateThread(arrival_guardian_push_forward_timer_tv);	
	
	PrintNarrative("END - arrival_guardian_run_start");
end





--========================================================================
          --ARRIVAL. guardian. run start
          --Osiris stands up.
          --They're on the Guardian over Genesis.
          --They are looking straight down at the planet. 90^ down.
--========================================================================
global W3HubArrival_ARRIVAL__guardian__run_start = {
	name = "W3HubArrival_ARRIVAL__guardian__run_start",

	CanStart = function (thisConvo, queue)
		return IsGoalActive(missionArrival.goal_arrival_gaurdian);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	sleepBefore = 1,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return IsGoalActive(missionArrival.goal_arrival_gaurdian); -- GAMMA_TRANSITION: If vale is first
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Like standing on the side of a skyscraper. This is bad.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_03200.sound'),
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return IsGoalActive(missionArrival.goal_arrival_gaurdian); -- GAMMA_TRANSITION: If vale is first
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.5,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "We'll be fine.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_05400.sound'),

			--playDurationAdjustment = 0.8,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return IsGoalActive(missionArrival.goal_arrival_gaurdian); -- GAMMA_TRANSITION: If vale is first
			end,

			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Chief’s down there?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_03900.sound'),
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return IsGoalActive(missionArrival.goal_arrival_gaurdian); -- GAMMA_TRANSITION: If vale is first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Let's find out. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_01500.sound'),

			playDurationAdjustment = 0.95,
		},
		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return IsGoalActive(missionArrival.goal_arrival_gaurdian); -- GAMMA_TRANSITION: If vale is first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Unknown",

			--character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "[Static...]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_masterchief_00500.sound'),			

			playDurationAdjustment = 0.2,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				b_guardian_start_shaking = true;				
			end,
		},
		[6] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return IsGoalActive(missionArrival.goal_arrival_gaurdian); -- GAMMA_TRANSITION: If vale is first
			end,

			sleepBefore = 2,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Guardian's moving!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_buck_04700.sound'),

			playDurationAdjustment = 0.85,
		},
		[7] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return IsGoalActive(missionArrival.goal_arrival_gaurdian); -- GAMMA_TRANSITION: If vale is first
			end,
			
			sleepBefore = 0.6,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Run! Reach a low enough altitude where it's safe to jump. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_04300.sound'),
		},
--           UI: OBJECTIVE TEXT - Descend the Guardian

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		CreateMissionThread(ARRIVAL__guardian__first_crawlers);		
		PushForwardVOReset(30);
	end,

	
};


function arrival_guardian_run_start_running()

	PrintNarrative("TO DELETE - arrival_guardian_run_start_running");


end


---------------------------------------------------------------------------------------------------------------------------------------------------

function ARRIVAL__guardian__first_crawlers()
local enemy_is_close:object = nil;
local enemy_is_close_player:object = nil;

	PrintNarrative("START - ARRIVAL__guardian__first_crawlers");

	repeat 
		sleep_s(0.5);
		SleepUntil([| ai_living_count(AI.sg_gaurdian) > 0], 10);
		enemy_is_close, enemy_is_close_player = GetClosestEnemy(AI.sg_gaurdian, 35);
		print(enemy_is_close);
		print(enemy_is_close_player);

				
		if enemy_is_close ~= nil then
			if ai_get_actor_type( object_get_ai( enemy_is_close)) ~= ACTOR_TYPE.pawn then
				enemy_is_close = nil;
			end
		end

	until  enemy_is_close ~= nil or not IsGoalActive(missionArrival.goal_arrival_gaurdian)

	if enemy_is_close ~= nil then
		enemy_is_close_player = GetClosestMusketeer(enemy_is_close_player, 8, 2);
		W3HubArrival_ARRIVAL__guardian__first_crawlers.localVariables.s_speaker = enemy_is_close_player;
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian__first_crawlers");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian__first_crawlers);
	end

end

--[========================================================================[
          ARRIVAL. guardian. first crawlers

          The first crawlers appear and come towards Osiris.
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian__first_crawlers = {
	name = "W3HubArrival_ARRIVAL__guardian__first_crawlers",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(20);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: locke
			text = "Crawlers ahead!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_01700.sound'),
			
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

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Crawlers ahead!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_buck_01500.sound'),

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
			text = "Crawlers ahead!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_01300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
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
			text = "Crawlers ahead!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_vale_01400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return IsGoalActive(missionArrival.goal_arrival_gaurdian); -- GAMMA_TRANSITION: If vale is first
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: locke
			text = "Don't stop! Shoot and run!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_01800.sound'),
		},
	},

	OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
		hud_hide_radio_transmission_hud();		
	end,

	sleepAfter = 2,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);				
	end,

	localVariables = {
					s_speaker = nil,
					},
};


---------------------------------------------------------------------------------------------------------------------------------------------------


function arrival_guardian_transformation()

	PrintNarrative("WAKE - arrival_guardian_transformation");

	PrintNarrative("START - arrival_guardian_transformation");
	
	CreateMissionThread(arrival_guardian_run_end_sound);		

	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian__dismantle");
	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian__dismantle);	

	sleep_s(20);

	if IsGoalActive(missionArrival.goal_arrival_gaurdian) then
			
			PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian__pull_forward_2");
			NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian__pull_forward_2);

			SleepUntil([| NarrativeQueue.HasConversationFinished(W3HubArrival_ARRIVAL__guardian__pull_forward_2)], 60);					
	end
	
	sleep_s(20);

	SleepUntil([| NarrativeQueue.HasConversationFinished(W3HubArrival_ARRIVAL__guardian__first_crawlers)], 10);

	if IsGoalActive(missionArrival.goal_arrival_gaurdian) then
			
			PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian__run_start_push_forward");
			NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian__run_start_push_forward);

			SleepUntil([| NarrativeQueue.HasConversationFinished(W3HubArrival_ARRIVAL__guardian__run_start_push_forward)], 60);
	end

	SleepUntil([| b_guardian_run_part_2], 60);

	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian__phaeton");
	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian__phaeton);

	sleep_s(20);

	if IsGoalActive(missionArrival.goal_arrival_gaurdian) then

			PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian__pull_forward_3");
			NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian__pull_forward_3);

			SleepUntil([| NarrativeQueue.HasConversationFinished(W3HubArrival_ARRIVAL__guardian__pull_forward_3)], 60);	
	end

	sleep_s(20);

	if IsGoalActive(missionArrival.goal_arrival_gaurdian) then

			PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian__pull_forward_1");
			NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian__pull_forward_1);
	end


	PrintNarrative("END - arrival_guardian_transformation");

end



--[========================================================================[
          ARRIVAL. guardian. dismantle

          The guardian starts to move.
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian__dismantle = {
	name = "W3HubArrival_ARRIVAL__guardian__dismantle",

	CanStart = function (thisConvo, queue)
		return IsGoalActive(missionArrival.goal_arrival_gaurdian) and volume_test_players( VOLUMES.tv_narr_arrival_guardian_push_forward_timer_03 );
	end,


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(20);
	end,

	sleepBefore = 1,

	lines = {
		[1] = {		
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "It's like it's trying to shake us off.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_buck_00200.sound'),

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


--[========================================================================[
          ARRIVAL. guardian. run start running

          The player arrives in a section where the side are lifting up
          while the middle seems more stable.

          Still running fast.
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian__run_start_running = {
	name = "W3HubArrival_ARRIVAL__guardian__run_start_running",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narr_guardian_stay_middle ); -- GAMMA_CONDITION
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
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Stay in the middle! Watch the floor!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_02900.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	sleepAfter = 2,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_guardian_run_part_2 = true;
	end,

	localVariables = {
					s_leader = nil,
					},
};



--[========================================================================[
			ARRIVAL. guardian. run start push forward
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian__run_start_push_forward = {
	name = "W3HubArrival_ARRIVAL__guardian__run_start_push_forward",

	CanStart = function (thisConvo, queue)
		return IsGoalActive(missionArrival.goal_arrival_gaurdian) and playersMovementSpeed() < 0.5 and not b_arrival_guardian_surprise;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_arrival_guardian_surprise;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,		

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					PushForwardVOReset(30);
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "If we keep moving, we're harder to hit.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_01600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	sleepAfter = 2,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,					
};


--[========================================================================[
          ARRIVAL. guardian. pull forward
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian__pull_forward_1 = {
	name = "W3HubArrival_ARRIVAL__guardian__pull_forward_1",

	CanStart = function (thisConvo, queue)
		return IsGoalActive(missionArrival.goal_arrival_gaurdian) and not b_arrival_guardian_surprise;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_arrival_guardian_surprise and not volume_test_players( VOLUMES.tv_narr_guardian_pre_end );																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,		

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					PushForwardVOReset(30);
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Gotta move faster than this! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_buck_01600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	sleepAfter = 2,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		
	end,

	
};


--[========================================================================[
          ARRIVAL. guardian. pull forward
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian__pull_forward_2 = {
	name = "W3HubArrival_ARRIVAL__guardian__pull_forward_2",

	CanStart = function (thisConvo, queue)
		return IsGoalActive(missionArrival.goal_arrival_gaurdian) and not b_arrival_guardian_surprise;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_arrival_guardian_surprise and not volume_test_players( VOLUMES.tv_narr_guardian_pre_end );																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,		

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					PushForwardVOReset(30);
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Didn't came all the way to get killed now. Move faster!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_02400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	sleepAfter = 2,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	
};



--[========================================================================[
          ARRIVAL. guardian. pull forward
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian__pull_forward_3 = {
	name = "W3HubArrival_ARRIVAL__guardian__pull_forward_3",

	CanStart = function (thisConvo, queue)
		return IsGoalActive(missionArrival.goal_arrival_gaurdian) and not b_arrival_guardian_surprise;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_arrival_guardian_surprise and not volume_test_players( VOLUMES.tv_narr_guardian_pre_end );																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					PushForwardVOReset(30);
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: locke
			text = "We're still too high to safely dismount. Keep running!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_03300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	sleepAfter = 2,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		
	end,

	
};


--[========================================================================[
          ARRIVAL. guardian. phaeton
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian__phaeton = {
	name = "W3HubArrival_ARRIVAL__guardian__phaeton",

	CanStart = function (thisConvo, queue)
		return IsSpartanAbleToSpeak(SPARTANS.vale) and objects_distance_to_object( players(), ai_get_object(AI.sq_gaurdian_for_10.spawnpoint01) ) < 50 or object_at_distance_and_can_see_object(players(), ai_get_object(AI.sq_gaurdian_for_10.spawnpoint01), 70, 5);
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
				return objects_distance_to_object( players(), ai_get_object(AI.sq_gaurdian_for_10.spawnpoint01) ) > 10;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Look up! Phaetons!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_vale_04600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};


--[========================================================================[
          ARRIVAL. guardian. archway

          When entering the section with the kind of archway, it looks
          like, the structure might really break.
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian__archway = {
	name = "W3HubArrival_ARRIVAL__guardian__archway",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narr_guardian_archway ) or volume_test_players( VOLUMES.tv_narr_guardian_archway01 );
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
		thisConvo.localVariables.s_speaker = GetClosestMusketeer(volume_return_players( VOLUMES.tv_narr_guardian_archway_sum )[1], 40, 2)
	end,

	lines = {		
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If locke is first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: locke
			text = "Watch your step. Try to stay near the center.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_01900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: If buck is first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Watch your step. Try to stay near the center.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_buck_01700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
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
			text = "Watch your step. Try to stay near the center.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_01400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
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
			text = "Watch your step. Try to stay near the center.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_vale_01600.sound'),

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

function arrival_guardian_run_end_sound()

SleepUntil([|  volume_test_players( VOLUMES.tv_narr_guardian_pre_end ) ], 1);

PushForwardVOStandBy();

print("Guardian Charge Sound - From Narrative Script");


PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian__pre_end");
NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian__pre_end);

NarrativeQueue.InterruptConversation(W3HubArrival_ARRIVAL__guardian__pull_forward_2);
NarrativeQueue.InterruptConversation(W3HubArrival_ARRIVAL__guardian__pull_forward_1);
NarrativeQueue.InterruptConversation(W3HubArrival_ARRIVAL__guardian__pull_forward_3);
NarrativeQueue.InterruptConversation(W3HubArrival_ARRIVAL__guardian__run_start_push_forward);

end



--[========================================================================[
          ARRIVAL. guardian. pre end
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian__pre_end = {
	name = "W3HubArrival_ARRIVAL__guardian__pre_end",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		thisConvo.localVariables.s_speaker = GetClosestMusketeer(volume_return_players( VOLUMES.tv_narr_guardian_pre_end )[1], 30, 2);		
		CreateMissionThread(guardian_charge_2d);
	end,

	lines = {		
		[1] = {
			sleepBefore = 1.5,

			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If locke is first towards the end
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "What's that sound?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_00500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {

			sleepBefore = 1.5,

			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: If buck is first towards the end
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "What's that sound?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_buck_00300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			
			sleepBefore = 1.5,

			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: If tanaka is first towards the end
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "What's that sound?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_00400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {

			sleepBefore = 1.5,

			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: If vale is first towards the end
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "What's that sound?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_vale_00100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			sleepBefore = 1.5,

			Else = true,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "What's that sound?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_vale_00100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian_outro_surprise_locke");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian_outro_surprise_locke);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian_outro_surprise_buck");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian_outro_surprise_buck);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian_outro_surprise_tanaka");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian_outro_surprise_tanaka);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian_outro_surprise_vale");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian_outro_surprise_vale);
		
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian_outro_floating_piece_locke");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian_outro_floating_piece_locke);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian_outro_floating_piece_buck");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian_outro_floating_piece_buck);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian_outro_floating_piece_tanaka");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian_outro_floating_piece_tanaka);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian_outro_floating_piece_vale");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian_outro_floating_piece_vale);

		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian_outro_fall_locke");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian_outro_fall_locke);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian_outro_fall_buck");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian_outro_fall_buck);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian_outro_fall_tanaka");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian_outro_fall_tanaka);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian_outro_fall_vale");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian_outro_fall_vale);
		
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian_outro_landing_locke");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian_outro_landing_locke);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian_outro_landing_buck");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian_outro_landing_buck);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian_outro_landing_tanaka");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian_outro_landing_tanaka);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__guardian_outro_landing_vale");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__guardian_outro_landing_vale);
		
		CreateMissionThread(arrival_guardian_outro_landing);
	end,

	localVariables = {
					s_speaker = nil,
					},
};



--[========================================================================[
          ARRIVAL. guardian. end ics

          As the Guardian unleashes its energy burst:
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian_outro_surprise_locke = {
	name = "W3HubArrival_ARRIVAL__guardian_outro_surprise_locke",

	CanStart = function (thisConvo, queue)
		return b_arrival_guardian_surprise; -- GAMMA_CONDITION
	end,

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
			text = "[surprised hit reaction]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_04400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};




--[========================================================================[
          ARRIVAL. guardian. end ics

          As the Guardian unleashes its energy burst:
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian_outro_surprise_buck = {
	name = "W3HubArrival_ARRIVAL__guardian_outro_surprise_buck",

	CanStart = function (thisConvo, queue)
		return b_arrival_guardian_surprise; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.buck,
	
	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BuCK
			text = "[surprised hit reaction]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_buck_04000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};



--[========================================================================[
          ARRIVAL. guardian. end ics

          As the Guardian unleashes its energy burst:
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian_outro_surprise_tanaka = {
	name = "W3HubArrival_ARRIVAL__guardian_outro_surprise_tanaka",

	CanStart = function (thisConvo, queue)
		return b_arrival_guardian_surprise; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.tanaka,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TanaKA
			text = "[surprised hit reaction]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_03300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};



--[========================================================================[
          ARRIVAL. guardian. end ics

          As the Guardian unleashes its energy burst:
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian_outro_surprise_vale = {
	name = "W3HubArrival_ARRIVAL__guardian_outro_surprise_vale",

	CanStart = function (thisConvo, queue)
		return b_arrival_guardian_surprise; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.vale,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "[surprised hit reaction]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_vale_04000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


--[========================================================================[
          ARRIVAL. guardian. end ics

          As the Guardian unleashes its energy burst:
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian_outro_floating_piece_locke = {
	name = "W3HubArrival_ARRIVAL__guardian_outro_floating_piece_locke",

	CanStart = function (thisConvo, queue)
		return b_arrival_guardian_outro_floating_piece; -- GAMMA_CONDITION
	end,

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
			text = "[floating piece impact]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_04500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


--[========================================================================[
          ARRIVAL. guardian. end ics

          As the Guardian unleashes its energy burst:
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian_outro_floating_piece_buck = {
	name = "W3HubArrival_ARRIVAL__guardian_outro_floating_piece_buck",

	CanStart = function (thisConvo, queue)
		return b_arrival_guardian_outro_floating_piece; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.buck,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BuCK
			text = "[floating piece impact]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_buck_04100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};



--[========================================================================[
          ARRIVAL. guardian. end ics

          As the Guardian unleashes its energy burst:
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian_outro_floating_piece_tanaka = {
	name = "W3HubArrival_ARRIVAL__guardian_outro_floating_piece_tanaka",

	CanStart = function (thisConvo, queue)
		return b_arrival_guardian_outro_floating_piece; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.tanaka,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TanaKA
			text = "[floating piece impact]\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_03400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

};



--[========================================================================[
          ARRIVAL. guardian. end ics

          As the Guardian unleashes its energy burst:
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian_outro_floating_piece_vale = {
	name = "W3HubArrival_ARRIVAL__guardian_outro_floating_piece_vale",

	CanStart = function (thisConvo, queue)
		return b_arrival_guardian_outro_floating_piece; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,
	
	PlayOnSpecificPlayer = CHARACTER_SPARTANS.vale,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "[floating piece impact]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_vale_04100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,


};

--[========================================================================[
          ARRIVAL. guardian. end ics

          As the Guardian unleashes its energy burst:
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian_outro_fall_locke = {
	name = "W3HubArrival_ARRIVAL__guardian_outro_fall_locke",

	CanStart = function (thisConvo, queue)
		return b_arrival_guardian_outro_locke_fall; -- GAMMA_CONDITION
	end,

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
			text = "[ADR during fall]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_05500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};




--[========================================================================[
          ARRIVAL. guardian. end ics

          As the Guardian unleashes its energy burst:
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian_outro_fall_buck = {
	name = "W3HubArrival_ARRIVAL__guardian_outro_fall_buck",

	CanStart = function (thisConvo, queue)
		return b_arrival_guardian_outro_buck_fall; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.buck,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BuCK
			text = "[ADR during fall]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_buck_04500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};



--[========================================================================[
          ARRIVAL. guardian. end ics

          As the Guardian unleashes its energy burst:
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian_outro_fall_tanaka = {
	name = "W3HubArrival_ARRIVAL__guardian_outro_fall_tanaka",

	CanStart = function (thisConvo, queue)
		return b_arrival_guardian_outro_tanaka_fall; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.tanaka,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TanaKA
			text = "[ADR during fall]\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_04000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};



--[========================================================================[
          ARRIVAL. guardian. end ics

          As the Guardian unleashes its energy burst:
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian_outro_fall_vale = {
	name = "W3HubArrival_ARRIVAL__guardian_outro_fall_vale",

	CanStart = function (thisConvo, queue)
		return b_arrival_guardian_outro_vale_fall; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.vale,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "[ADR during fall]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_vale_04300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


function arrival_guardian_outro_landing()

PrintNarrative("START - arrival_guardian_outro_landing");

SleepUntil([| b_arrival_guardian_outro_landing_locke or b_arrival_guardian_outro_landing_buck or b_arrival_guardian_outro_landing_tanaka or b_arrival_guardian_outro_landing_vale ], 1);

NarrativeQueue.InterruptConversation(W3HubArrival_ARRIVAL__guardian_outro_fall_locke, 0);
NarrativeQueue.InterruptConversation(W3HubArrival_ARRIVAL__guardian_outro_fall_buck, 0);
NarrativeQueue.InterruptConversation(W3HubArrival_ARRIVAL__guardian_outro_fall_tanaka, 0);
NarrativeQueue.InterruptConversation(W3HubArrival_ARRIVAL__guardian_outro_fall_vale, 0);

PrintNarrative("END - arrival_guardian_outro_landing");

end



--[========================================================================[
          ARRIVAL. guardian. end ics

          As the Guardian unleashes its energy burst:
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian_outro_landing_locke = {
	name = "W3HubArrival_ARRIVAL__guardian_outro_landing_locke",

	CanStart = function (thisConvo, queue)
		return b_arrival_guardian_outro_landing_locke; -- GAMMA_CONDITION
	end,

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
			text = "[Ground soft impact]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_07300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};




--[========================================================================[
          ARRIVAL. guardian. end ics

          As the Guardian unleashes its energy burst:
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian_outro_landing_buck = {
	name = "W3HubArrival_ARRIVAL__guardian_outro_landing_buck",

	CanStart = function (thisConvo, queue)
		return b_arrival_guardian_outro_landing_buck; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.buck,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BuCK
			text = "[Ground soft impact]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_buck_05200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};



--[========================================================================[
          ARRIVAL. guardian. end ics

          As the Guardian unleashes its energy burst:
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian_outro_landing_tanaka = {
	name = "W3HubArrival_ARRIVAL__guardian_outro_landing_tanaka",

	CanStart = function (thisConvo, queue)
		return b_arrival_guardian_outro_landing_tanaka; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.tanaka,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TanaKA
			text = "[Ground soft impact]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_05000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};



--[========================================================================[
          ARRIVAL. guardian. end ics

          As the Guardian unleashes its energy burst:
--]========================================================================]
global W3HubArrival_ARRIVAL__guardian_outro_landing_vale = {
	name = "W3HubArrival_ARRIVAL__guardian_outro_landing_vale",

	CanStart = function (thisConvo, queue)
		return b_arrival_guardian_outro_landing_vale; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.vale,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "[Ground soft impact]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_vale_05200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};




---------------------------------------------------------------------------------------------------------------------------------------------------

function arrival_guardian_push_forward_timer_tv()

	PrintNarrative("WAKE - arrival_guardian_push_forward_timer_tv");

	PrintNarrative("START - arrival_guardian_push_forward_timer_tv");

	SleepUntil([| volume_test_players( VOLUMES.tv_narr_arrival_guardian_push_forward_timer_01 )  ], 10);

		PrintNarrative("RESET - arrival_guardian_push_forward_timer_tv");
		b_push_forward_vo_timer = b_push_forward_vo_timer + 10;

	SleepUntil([| volume_test_players( VOLUMES.tv_narr_arrival_guardian_push_forward_timer_02 )  ], 10);

		PrintNarrative("RESET - arrival_guardian_push_forward_timer_tv");
		b_push_forward_vo_timer = b_push_forward_vo_timer + 10;

	PrintNarrative("END - arrival_guardian_push_forward_timer_tv");

end

---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------



function arrival_landing_load()
local s_timer:number = 0
	PrintNarrative("LOAD - arrival_landing_load");
	
	repeat
		sleep_s(1);
		s_timer = s_timer + 1

	until NarrativeQueue.HasConversationFinished(W3HubArrival_ARRIVAL__guardian_outro_landing_locke) or s_timer >= 1

	PrintNarrative("QUEUE - W3HubArrival_Arrival__LANDING__Start_unskippable");
	NarrativeQueue.QueueConversation(W3HubArrival_Arrival__LANDING__Start_unskippable);

	CreateMissionThread(Arrival__LANDING__Start_2);

	PrintNarrative("QUEUE - W3HubArrival_Arrival__LANDING__Start_monitor_1");
	NarrativeQueue.QueueConversation(W3HubArrival_Arrival__LANDING__Start_monitor_1);
	
	PrintNarrative("QUEUE - W3HubArrival_Arrival__LANDING__phaetons");
	NarrativeQueue.QueueConversation(W3HubArrival_Arrival__LANDING__phaetons);
	
	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__landing__chatter");
	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__landing__chatter);

	b_monitor_release = true;
	
end


--[========================================================================[
          Arrival. LANDING. Start
--]========================================================================]
global W3HubArrival_Arrival__LANDING__Start_unskippable = {
	name = "W3HubArrival_Arrival__LANDING__Start_unskippable",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
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
				return false;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Nicely done!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_buck_01000.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 1,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: taNAKA
			text = "Did it work? Is this the right place?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_03500.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.7,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Spartan Jameson Locke to Sierra 117. Please respond.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_05600.sound'),

			playDurationAdjustment = 0.94,
		},
	},

	OnFinish = function (thisConvo, queue)	
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W3HubArrival_Arrival__LANDING__Start");
		NarrativeQueue.QueueConversation(W3HubArrival_Arrival__LANDING__Start);
		
	end,	
};


--[========================================================================[
          Arrival. LANDING. Start
--]========================================================================]
global W3HubArrival_Arrival__LANDING__Start = {
	name = "W3HubArrival_Arrival__LANDING__Start",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PrintNarrative("QUEUE - W3HubArrival_Arrival__LANDING__Start_2");
		NarrativeQueue.QueueConversation(W3HubArrival_Arrival__LANDING__Start_2);
	end,

	sleepBefore = 2,

	lines = {		
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return device_get_position(OBJECTS.dm_landing_door_01) < 0.1;
			end,
		
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Unknown",

			--character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "[...]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_masterchief_00800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return device_get_position(OBJECTS.dm_landing_door_01) < 0.1;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.4,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Chief... Doctor Halsey sent us. We're here to help -- ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_05700.sound'),

			playDurationAdjustment = 0.95,
		},
	},

	OnFinish = function (thisConvo, queue)	
		PrintNarrative("END - "..thisConvo.name);		
	end,	
};

function Arrival__LANDING__Start_2()
	
	PrintNarrative("START - Arrival__LANDING__Start_2");

	SleepUntil([| volume_test_players( VOLUMES.arrival_landing_interrupt_chief )], 1);
	print("INTERRUPT!!!!!!!!!!!!!!!!!!!!!!!!!!!");
	NarrativeQueue.InterruptConversation(W3HubArrival_Arrival__LANDING__Start, 0.5);

	PrintNarrative("END - Arrival__LANDING__Start_2");


end


--[========================================================================[
          Arrival. LANDING. Start
--]========================================================================]
global W3HubArrival_Arrival__LANDING__Start_2 = {
	name = "W3HubArrival_Arrival__LANDING__Start_2",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		CreateMissionThread(Arrival__LANDING__Start_3);
		PrintNarrative("QUEUE - W3HubArrival_Arrival__LANDING__Start_3");
		NarrativeQueue.QueueConversation(W3HubArrival_Arrival__LANDING__Start_3);
	end,

	lines = {	
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "MasterChief",

			--character = nil, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "How are you here?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_masterchief_00100.sound'),

			--playDurationAdjustment = 0.95,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return device_get_position(OBJECTS.dm_landing_door_01) < 0.1;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.7,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Long story, sir. Cortana has been activating Forerunner--",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_04700.sound'),

			playDurationAdjustment = 0.9,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return device_get_position(OBJECTS.dm_landing_door_01) < 0.1;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                            radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
							b_landing_chief_interrupt = true;
			end,

			moniker = "MasterChief",

			--character = nil, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "I'm aware. We're at the Gate--",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_masterchief_00300.sound'),

			--playDurationAdjustment = 0.7,			

		},		
	},

	OnFinish = function (thisConvo, queue)	
		PrintNarrative("END - "..thisConvo.name);
	end,	
};



function Arrival__LANDING__Start_3()
	
	PrintNarrative("START - Arrival__LANDING__Start_3");

	SleepUntil([| b_landing_chief_interrupt], 1);
	sleep_s(1.1);
	NarrativeQueue.InterruptConversation(W3HubArrival_Arrival__LANDING__Start_2, 0);

	PrintNarrative("END - Arrival__LANDING__Start_3");

end



--[========================================================================[
          Arrival. LANDING. Start
--]========================================================================]
global W3HubArrival_Arrival__LANDING__Start_3 = {
	name = "W3HubArrival_Arrival__LANDING__Start_3",

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

			moniker = "MasterChief",

			--character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "[...]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_masterchief_00700.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			sleepAfter = 0.2,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return device_get_position(OBJECTS.dm_landing_door_01) < 0.1;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "CortanaHelmet",

			--character = 0, -- GAMMA_CHARACTER: CorTANA
			text = "It's you. The same as Meridian. As Sanghelios. My, you do get around.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_cortana_00100.sound'),

			sleepAfter = 0.4,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.8,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Cortana?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_06900.sound'),

			--playDurationAdjustment = 0.9,
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return false; --device_get_position(OBJECTS.dm_landing_door_01) < 0.1;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Unknown",

			--character = 0, -- GAMMA_CHARACTER: cortana
			text = "[...]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_cortana_00200.sound'),			

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 1.5,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "So this is the right place.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_04600.sound'),
		},
		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not (ai_living_count(AI.sq_sassy_spark.spawn_gate_01_landing) == 1 and objects_distance_to_object( players(), ai_get_object(AI.sq_sassy_spark.spawn_gate_01_landing) ) < (b_landing_monitor_talking_distance));
			end,

			sleepBefore = 0.7,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Let's find him.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_05800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)	
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		
		PushForwardVOReset(30);
	end,	
};

---------------------------------------------------------------------------------------------------------------------------------------------------



function arrival_landing_monitor_meeting()

	PrintNarrative("WAKE - arrival_landing_monitor_meeting");	

	SleepUntil([| ai_living_count(AI.sq_sassy_spark.spawn_gate_01_landing) == 1 and objects_distance_to_object( players(), ai_get_object(AI.sq_sassy_spark.spawn_gate_01_landing) ) < (b_landing_monitor_talking_distance)], 10);

	PrintNarrative("START - arrival_landing_monitor_meeting");						

				PrintNarrative("QUEUE - W3HubArrival_Arrival__LANDING__monitor_meeting");
				NarrativeQueue.QueueConversation(W3HubArrival_Arrival__LANDING__monitor_meeting);

				SleepUntil([| NarrativeQueue.HasConversationFinished( W3HubArrival_Arrival__LANDING__monitor_meeting ) and objects_distance_to_object( players(), ai_get_object(AI.sq_sassy_spark.spawn_gate_01_landing) ) < b_landing_monitor_talking_distance], 1);

				PrintNarrative("QUEUE - W3HubArrival_Arrival__LANDING__monitor_meeting_come_back");
				NarrativeQueue.QueueConversation(W3HubArrival_Arrival__LANDING__monitor_meeting_come_back);

				PrintNarrative("QUEUE - W3HubArrival_Arrival__LANDING__monitor_meeting_2");
				NarrativeQueue.QueueConversation(W3HubArrival_Arrival__LANDING__monitor_meeting_2);

				SleepUntil([| NarrativeQueue.HasConversationFinished( W3HubArrival_Arrival__LANDING__monitor_meeting_2 ) and objects_distance_to_object( players(), ai_get_object(AI.sq_sassy_spark.spawn_gate_01_landing) ) < b_landing_monitor_talking_distance], 1);

				PrintNarrative("QUEUE - W3HubArrival_Arrival__LANDING__monitor_meeting_2_bis");
				NarrativeQueue.QueueConversation(W3HubArrival_Arrival__LANDING__monitor_meeting_2_bis);

				SleepUntil([| NarrativeQueue.HasConversationFinished( W3HubArrival_Arrival__LANDING__monitor_meeting_2_bis ) and objects_distance_to_object( players(), ai_get_object(AI.sq_sassy_spark.spawn_gate_01_landing) ) < b_landing_monitor_talking_distance], 1);
				
				PrintNarrative("QUEUE - W3HubArrival_Arrival__LANDING__monitor_meeting_3");
				NarrativeQueue.QueueConversation(W3HubArrival_Arrival__LANDING__monitor_meeting_3);

				SleepUntil([| NarrativeQueue.HasConversationFinished( W3HubArrival_Arrival__LANDING__monitor_meeting_3 )], 10);

				b_monitor_speech_end = true;
				CreateMissionThread(Arrival__LANDING__monitor_elevator_pushes);

	PrintNarrative("END - arrival_landing_monitor_meeting");

end


--[========================================================================[
			Arrival. LANDING. Start 2
--]========================================================================]
global W3HubArrival_Arrival__LANDING__Start_monitor_1 = {
	name = "W3HubArrival_Arrival__LANDING__Start_monitor_1",

	CanStart = function (thisConvo, queue)
		return not b_collectible_used and ai_living_count(AI.sq_sassy_spark.spawn_gate_01_landing) == 1 and object_at_distance_and_can_see_object(players(), ai_get_object(AI.sq_sassy_spark.spawn_gate_01_landing), 20, 30);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOAdd(5);
		CreateMissionThread(arrival_landing_monitor_meeting);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_collectible_used and not object_at_distance_and_can_see_object(players(), ai_get_object(AI.sq_sassy_spark.spawn_gate_01_landing), 9, 180);
			end,

			moniker = "ExuberantWitness",

			character = AI.sq_sassy_spark.spawn_gate_01_landing, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "More humans?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_00100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,	
};


--[========================================================================[
          Arrival. LANDING. monitor meeting

          ***Monitor now appears in the elevator space rather than just
          outside. We'll need to look at the timing of all of this.
--]========================================================================]
global W3HubArrival_Arrival__LANDING__monitor_meeting = {
	name = "W3HubArrival_Arrival__LANDING__monitor_meeting",
	
	CanStart = function (thisConvo, queue)
		return NarrativeQueue.HasConversationFinished(W3HubArrival_Arrival__LANDING__Start_monitor_1);
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
				return not b_monitor_is_on_radio;
			end,
			
			moniker = "ExuberantWitness",

			character = AI.sq_sassy_spark.spawn_gate_01_landing, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Hello!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_00900.sound'),

			playDurationAdjustment = 0.85,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_monitor_is_on_radio and objects_distance_to_object( SPARTANS.vale, ai_get_object(AI.sq_sassy_spark.spawn_gate_01_landing)) < 15;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "That's a Monitor.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_vale_01700.sound'),

			playDurationAdjustment = 0.7,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_monitor_is_on_radio;
			end,

			sleepbefore = 0.45,

			moniker = "ExuberantWitness",

			character = AI.sq_sassy_spark.spawn_gate_01_landing, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "I am 031-Exuberant Witness, Monitor of the Genesis installation. Welcome!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_00200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,

};


--[========================================================================[
          Arrival. LANDING. monitor meeting

          ***Monitor now appears in the elevator space rather than just
          outside. We'll need to look at the timing of all of this.
--]========================================================================]
global W3HubArrival_Arrival__LANDING__monitor_meeting_2 = {
	name = "W3HubArrival_Arrival__LANDING__monitor_meeting_2",

	CanStart = function (thisConvo, queue)
		return objects_distance_to_object( players(), ai_get_object(AI.sq_sassy_spark.spawn_gate_01_landing) ) < b_landing_monitor_talking_distance;
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
				return not b_monitor_is_on_radio;
			end,

			moniker = "ExuberantWitness",

			character = AI.sq_sassy_spark.spawn_gate_01_landing, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Have you also come to stop Cortana from claiming the Mantle?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_09300.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_monitor_is_on_radio;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.3,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "The Mantle?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_00300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_monitor_is_on_radio;
			end,

			sleepBefore = 0.7,

			moniker = "ExuberantWitness",

			character = AI.sq_sassy_spark.spawn_gate_01_landing, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "A forced peace upon the galaxy. The threat of death overpowering any celebration of life.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_06800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,
};


--[========================================================================[
          Arrival. LANDING. monitor meeting

          ***Monitor now appears in the elevator space rather than just
          outside. We'll need to look at the timing of all of this.
--]========================================================================]
global W3HubArrival_Arrival__LANDING__monitor_meeting_2_bis = {
	name = "W3HubArrival_Arrival__LANDING__monitor_meeting_2_bis",

	CanStart = function (thisConvo, queue)
		return objects_distance_to_object( players(), ai_get_object(AI.sq_sassy_spark.spawn_gate_01_landing) ) < b_landing_monitor_talking_distance;
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
				return not b_monitor_is_on_radio;
			end,

			moniker = "ExuberantWitness",

			character = AI.sq_sassy_spark.spawn_gate_01_landing, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Unless you join with the other humans and stop her, it is your future.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_04400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,
};



--[========================================================================[
          Arrival. LANDING. monitor meeting 5
--]========================================================================]
global W3HubArrival_Arrival__LANDING__monitor_meeting_3 = {
	name = "W3HubArrival_Arrival__LANDING__monitor_meeting_3",

	CanStart = function (thisConvo, queue)
		return not b_monitor_is_on_radio and objects_distance_to_object( players(), ai_get_object(AI.sq_sassy_spark.spawn_gate_01_landing) ) < b_landing_monitor_talking_distance and (b_landing_elevator_starts or NarrativeQueue.HasConversationFinished(W3HubArrival_Arrival__LANDING__monitor_meeting_come_back_2));
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(50);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_monitor_is_on_radio and not volume_test_players( VOLUMES.tv_narrative_arr_monitor_elevator_cut );
			end,

			sleepBefore = 0.2,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "You've seen the other humans?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_06300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER			
				return 0;
			end,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_monitor_is_on_radio;
			end,

			sleepBefore = 0.1,

			moniker = "ExuberantWitness",

			character = AI.sq_sassy_spark.spawn_gate_01_landing, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Oh yes. Cortana has had them in the Gateway for some time. It is not far from here. I can show you!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_01800.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_monitor_is_on_radio and not volume_test_players( VOLUMES.tv_narrative_arr_monitor_elevator_cut );
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.3,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "That would be appreciated, yes.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_06400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},		
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,
};

function Arrival__LANDING__monitor_elevator_pushes()

sleep_s(8);

if not b_landing_elevator_starts then
	PrintNarrative("QUEUE - W3HubArrival_Arrival__LANDING__monitor_elevator_push_01");
	NarrativeQueue.QueueConversation(W3HubArrival_Arrival__LANDING__monitor_elevator_push_01);

	SleepUntil ([| NarrativeQueue.HasConversationFinished(W3HubArrival_Arrival__LANDING__monitor_elevator_push_01) ], 1);
end

sleep_s(8);

if not b_landing_elevator_starts then
	PrintNarrative("QUEUE - W3HubArrival_Arrival__LANDING__monitor_elevator_push_02");
	NarrativeQueue.QueueConversation(W3HubArrival_Arrival__LANDING__monitor_elevator_push_02);
end


end

--[========================================================================[
			Arrival. LANDING. monitor meeting options
--]========================================================================]
global W3HubArrival_Arrival__LANDING__monitor_elevator_push_01 = {
	name = "W3HubArrival_Arrival__LANDING__monitor_elevator_push_01",	

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return objects_distance_to_object( players(), AI.sq_sassy_spark.spawn_gate_01_landing ) < 12;
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
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_landing_elevator_starts and IsGoalActive(missionArrival.goal_arrival_landing);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			moniker = "ExuberantWitness",

			character = AI.sq_sassy_spark.spawn_gate_01_landing, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Step on this elevator.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_09600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,	
};


--[========================================================================[
			Arrival. LANDING. monitor meeting options
--]========================================================================]
global W3HubArrival_Arrival__LANDING__monitor_elevator_push_02 = {
	name = "W3HubArrival_Arrival__LANDING__monitor_elevator_push_02",	

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return objects_distance_to_object( players(), AI.sq_sassy_spark.spawn_gate_01_landing ) < 12;
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
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_landing_elevator_starts and IsGoalActive(missionArrival.goal_arrival_landing);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			moniker = "ExuberantWitness",

			character = AI.sq_sassy_spark.spawn_gate_01_landing, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "What are you waiting for? \r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_06200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,	
};
--[========================================================================[
			Arrival. LANDING. monitor meeting options
--]========================================================================]
global W3HubArrival_Arrival__LANDING__monitor_meeting_come_back = {
	name = "W3HubArrival_Arrival__LANDING__monitor_meeting_come_back",	

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return objects_distance_to_object( players(), AI.sq_sassy_spark.spawn_gate_01_landing ) > (b_landing_monitor_talking_distance + 1);
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
				return not b_landing_elevator_starts and IsGoalActive(missionArrival.goal_arrival_landing);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				PrintNarrative("QUEUE - W3HubArrival_Arrival__LANDING__monitor_meeting_come_back_2");
				NarrativeQueue.QueueConversation(W3HubArrival_Arrival__LANDING__monitor_meeting_come_back_2);
			end,

			moniker = "ExuberantWitness",

			character = AI.sq_sassy_spark.spawn_gate_01_landing, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "No, please. Come back!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_05400.sound'),

			sleepAfter = 0.5,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,	
};


--[========================================================================[
			Arrival. LANDING. monitor meeting options
--]========================================================================]
global W3HubArrival_Arrival__LANDING__monitor_meeting_come_back_2 = {
	name = "W3HubArrival_Arrival__LANDING__monitor_meeting_come_back_2",	

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return objects_distance_to_object( players(), AI.sq_sassy_spark.spawn_gate_01_landing ) < (b_landing_monitor_talking_distance + 0.5);
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
				return not NarrativeQueue.HasConversationFinished(W3HubArrival_Arrival__LANDING__monitor_meeting_2_bis) and not b_monitor_speech_end and not b_landing_elevator_starts and IsGoalActive(missionArrival.goal_arrival_landing);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			moniker = "ExuberantWitness",

			character = AI.sq_sassy_spark.spawn_gate_01_landing, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "I was saying...\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_15800.sound'),

			--playDurationAdjustment = 0.8,
			sleepAfter = 0.5,

		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,	
};


---------------------------------------------------------------------------------------------------------------------------------------------------

													function arrival_landing_door_opening()

														PrintNarrative("WAKE - arrival_landing_door_opening");

														SleepUntil([| b_monitor_release ], 30);

														PrintNarrative("START - arrival_landing_door_opening - line 1");

														sleep_s(0.7);

														if IsGoalActive(missionArrival.goal_arrival_landing) then
	
																	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__landing__door_opening");
																	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__landing__door_opening);

																	SleepUntil([| NarrativeQueue.HasConversationFinished(W3HubArrival_ARRIVAL__landing__door_opening) ], 10);

																	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__landing__door_opening_b");
																	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__landing__door_opening_b);

																	SleepUntil([| NarrativeQueue.HasConversationFinished(W3HubArrival_ARRIVAL__landing__door_opening_b) ], 10);

																	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__landing__door_opening_c");
																	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__landing__door_opening_c);

																	SleepUntil([| NarrativeQueue.HasConversationFinished(W3HubArrival_ARRIVAL__landing__door_opening_c) ], 10);

														end

			
																	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__landing__door_opening_2");
																	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__landing__door_opening_2);
				
														PrintNarrative("END - arrival_landing_door_opening");

													end



															--[========================================================================[
																	  ARRIVAL. landing. door opening
															--]========================================================================]
															global W3HubArrival_ARRIVAL__landing__door_opening = {
																name = "W3HubArrival_ARRIVAL__landing__door_opening",

																CanStart = function (thisConvo, queue)
																	return IsGoalActive(missionArrival.goal_arrival_landing) and not b_elevator_comp_played and ai_living_count(AI.sq_sassy_spark.spawn_gate_01_landing) == 1 and not volume_test_players_all(VOLUMES.tv_landing_elevator);
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
																		moniker = "ExuberantWitness",

			character = AI.sq_sassy_spark.spawn_gate_01_landing, -- GAMMA_CHARACTER: ExUBERANTWITNESS
																		text = "The ancilla's attempt to claim the Mantle of Responsibility for herself is madness. ",
																		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_06000.sound'),

																		--playDurationAdjustment = 0.8,
																	},
																},

																OnFinish = function (thisConvo, queue)
																	PrintNarrative("END - "..thisConvo.name);
																end,	
															};


															--[========================================================================[
																	  ARRIVAL. landing. door opening
															--]========================================================================]
															global W3HubArrival_ARRIVAL__landing__door_opening_b = {
																name = "W3HubArrival_ARRIVAL__landing__door_opening_b",

																CanStart = function (thisConvo, queue)
																	return IsGoalActive(missionArrival.goal_arrival_landing) and not b_elevator_comp_played and ai_living_count(AI.sq_sassy_spark.spawn_gate_01_landing) == 1 and not volume_test_players_all(VOLUMES.tv_landing_elevator);
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
																		moniker = "ExuberantWitness",

			character = AI.sq_sassy_spark.spawn_gate_01_landing, -- GAMMA_CHARACTER: ExUBERANTWITNESS
																		text = "The Mantle of Responsibility? More like a Mantle of Tyranny. ",
																		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_00800.sound'),

																		--playDurationAdjustment = 0.8,
																	},

																},

																OnFinish = function (thisConvo, queue)
																	PrintNarrative("END - "..thisConvo.name);
																end,	
															};


															--[========================================================================[
																	  ARRIVAL. landing. door opening
															--]========================================================================]
															global W3HubArrival_ARRIVAL__landing__door_opening_c = {
																name = "W3HubArrival_ARRIVAL__landing__door_opening_c",

																CanStart = function (thisConvo, queue)
																	return IsGoalActive(missionArrival.goal_arrival_landing) and not b_elevator_comp_played and ai_living_count(AI.sq_sassy_spark.spawn_gate_01_landing) == 1 and not volume_test_players_all(VOLUMES.tv_landing_elevator);
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
																		moniker = "ExuberantWitness",

																		character = AI.sq_sassy_spark.spawn_gate_01_landing, -- GAMMA_CHARACTER: ExUBERANTWITNESS
																		text = "Why Warden would aide her is beyond me.",
																		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_01800.sound'),

																		--playDurationAdjustment = 0.8,
																	},
																},

																OnFinish = function (thisConvo, queue)
																	PrintNarrative("END - "..thisConvo.name);
																end,	
															};


															--[========================================================================[
																	  ARRIVAL. landing. door opening 2
															--]========================================================================]
															global W3HubArrival_ARRIVAL__landing__door_opening_2 = {
																name = "W3HubArrival_ARRIVAL__landing__door_opening_2",

																CanStart = function (thisConvo, queue)
																	return b_push_forward_vo_timer == 3 and IsGoalActive(missionArrival.goal_arrival_landing) and not b_elevator_comp_played and ai_living_count(AI.sq_sassy_spark.spawn_gate_01_landing) == 1 and objects_distance_to_object( players(), ai_get_object(AI.sq_sassy_spark.spawn_gate_01_landing) ) > 7 and objects_distance_to_object( players(), ai_get_object(AI.sq_sassy_spark.spawn_gate_01_landing) ) < 25 and not volume_test_players_all(VOLUMES.tv_landing_elevator)
																			 and NarrativeQueue.HasConversationFinished(W3HubArrival_ARRIVAL__landing__door_opening_c);
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
																		moniker = "ExuberantWitness",

			character = AI.sq_sassy_spark.spawn_gate_01_landing, -- GAMMA_CHARACTER: ExUBERANTWITNESS
																		text = "Follow me. We don't have much time before the ancilla controls the Gateway",
																		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_09600.sound'),
																	},
																},

																OnFinish = function (thisConvo, queue)
																	PrintNarrative("END - "..thisConvo.name);
																	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__landing__door_opening_4");
																	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__landing__door_opening_4);				
																end,

	
															};




															--[========================================================================[
																	  ARRIVAL. landing. door opening 4
															--]========================================================================]
															global W3HubArrival_ARRIVAL__landing__door_opening_4 = {
																name = "W3HubArrival_ARRIVAL__landing__door_opening_4",

																CanStart = function (thisConvo, queue)
																	return b_push_forward_vo_timer == 3 and IsGoalActive(missionArrival.goal_arrival_landing) and not b_elevator_comp_played and ai_living_count(AI.sq_sassy_spark.spawn_gate_01_landing) == 1 and objects_distance_to_object( players(), ai_get_object(AI.sq_sassy_spark.spawn_gate_01_landing) ) > 7 and objects_distance_to_object( players(), ai_get_object(AI.sq_sassy_spark.spawn_gate_01_landing) ) < 25 and not volume_test_players_all(VOLUMES.tv_landing_elevator)
																			 and NarrativeQueue.HasConversationFinished(W3HubArrival_ARRIVAL__landing__door_opening_2);
																end,

																Priority = function (thisConvo, queue)
																	return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
																end,

																OnStart = function (thisConvo, queue)
																	PrintNarrative("START - "..thisConvo.name);
																	PushForwardVOReset(15);
																end,

																lines = {
																	[1] = {
																		moniker = "ExuberantWitness",

			character = AI.sq_sassy_spark.spawn_gate_01_landing, -- GAMMA_CHARACTER: ExUBERANTWITNESS
																		text = "What are you waiting for? ",
																		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_06200.sound'),
																	},
																},

																OnFinish = function (thisConvo, queue)
																	PrintNarrative("END - "..thisConvo.name);
																end,

	
															};


---------------------------------------------------------------------------------------------------------------------------------------------------

											function arrival_landing_door_to_elevator()

												PrintNarrative("WAKE - arrival_landing_door_to_elevator");

												SleepUntil([| volume_test_object( VOLUMES.tv_narr_landing_in_front_elevator, ai_get_object(AI.sq_sassy_spark.spawn_gate_01_landing))  ], 100);
												SleepUntil([| not volume_test_object( VOLUMES.tv_narr_landing_in_front_elevator, ai_get_object(AI.sq_sassy_spark.spawn_gate_01_landing))  ], 10);

												PrintNarrative("START - arrival_landing_door_to_elevator");
															

												PrintNarrative("END - arrival_landing_door_to_elevator");

											end



--[========================================================================[
          Arrival. LANDING. Start
--]========================================================================]
global W3HubArrival_Arrival__LANDING__phaetons = {
	name = "W3HubArrival_Arrival__LANDING__phaetons",

	CanStart = function (thisConvo, queue)
		return  b_push_forward_vo_timer == 5 and objects_distance_to_object( players(), ai_get_object(AI.sq_sassy_spark.spawn_gate_01_landing) ) > b_landing_monitor_talking_distance and IsGoalActive(missionArrival.goal_arrival_landing) and IsSpartanAbleToSpeak(SPARTANS.vale) and IsSpartanAbleToSpeak(SPARTANS.tanaka); -- GAMMA_CONDITION
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

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Phaetons in the air... ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_vale_03900.sound'),		
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 1,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Warden's looking for corpses.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_03100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name)
		hud_hide_radio_transmission_hud();
	end,
};



--[========================================================================[
          ARRIVAL. landing. chatter
--]========================================================================]
global W3HubArrival_ARRIVAL__landing__chatter = {
	name = "W3HubArrival_ARRIVAL__landing__chatter",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_timer == 4 and objects_distance_to_object( players(), ai_get_object(AI.sq_sassy_spark.spawn_gate_01_landing) ) > b_landing_monitor_talking_distance and IsGoalActive(missionArrival.goal_arrival_landing) and IsSpartanAbleToSpeak(SPARTANS.vale) and IsSpartanAbleToSpeak(SPARTANS.locke); -- GAMMA_CONDITION
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
			text = "So we're here... what's the plan?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_vale_04500.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "We'll find a way to locate the Chief and go from there.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_05900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

};



---------------------------------------------------------------------------------------------------------------------------------------------------



function arrival_landing_elevator()

	--	Called from mission script

	PrintNarrative("WAKE - arrival_landing_elevator");

	PrintNarrative("START - arrival_landing_elevator");

	PushForwardVOStandBy();
	
				

	PrintNarrative("END - arrival_landing_elevator");

end




---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------



function arrival_road_load()

	PrintNarrative("LOAD - arrival_road_load");
	
	b_monitor_release = true;

	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__landing__elevator");
	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__landing__elevator);
	
	--SleepUntil([| volume_test_players(VOLUMES.tv_mon_gate_02_tank)] , 10);

	PushForwardVOReset(60);

	b_monitor_speech_end = true;
	b_monitor_encounter_speech = false;

	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__road__in_front_of_the_door");
	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__road__in_front_of_the_door);		
	
	SleepUntil([| volume_test_players( VOLUMES.tv_narr_road_pre_guardian)], 20);
	b_player_are_about_to_see_guardian = true;

	SleepUntil([| volume_test_players( VOLUMES.tv_narr_arrival_road_encounter_killing_half )], 10);
	
	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__road__encounter_killing_half");
	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__road__encounter_killing_half);

	SleepUntil([| volume_test_players( VOLUMES.tv_narr_road_push_forward)], 20);
	b_players_reached_front_road_door = true;	

	CreateMissionThread(arrival_road_giant_door)
end

---------------------------------------------------------------------------------------------------------------------------------------------------



--[========================================================================[
          ARRIVAL. landing. elevator
--]========================================================================]
global W3HubArrival_ARRIVAL__landing__elevator = {
	name = "W3HubArrival_ARRIVAL__landing__elevator",

	CanStart = function (thisConvo, queue)
		return b_monitor_speech_end; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	sleepBefore = 1,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
						
			moniker = "ExuberantWitness",

			character = AI.sq_sassy_spark.spawn_gate_01_landing, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Accessing your communications systems.\r\n\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_15900.sound'),

			playDurationAdjustment = 0.5,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();				
			end,

			sleepAfter = 0.3,
		},	
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_set_radio_transmission_team_string_id("exuberantteam_transmission_name");
		hud_set_radio_transmission_portrait_index(14);
		hud_show_radio_transmission_hud("exuberant_transmission_name");			
	end,

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_monitor_is_on_radio = true;
		hud_hide_radio_transmission_hud();
	end,	
};



--[========================================================================[
          ARRIVAL. road. in front of the door

          By now, Osiris should be out of the elevator and down the
          path in front of a close door.
--]========================================================================]
global W3HubArrival_ARRIVAL__road__in_front_of_the_door = {
	name = "W3HubArrival_ARRIVAL__road__in_front_of_the_door",

	CanStart = function (thisConvo, queue)
		return b_monitor_is_on_radio; -- GAMMA_CONDITION
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
			sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",
			
			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "By the way, there are quite a few hostile visitors outside.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_07100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER				
				return 3;
			end,
		},
		[2] = {
			sleepBefore = 0.3,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Any way around them? ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_04900.sound'),
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",
			
			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Unfortunately not. So I brought you this!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_01600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__road__covenant_look_at");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__road__covenant_look_at);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__road__in_front_of_the_door_3");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__road__in_front_of_the_door_3);
	end,

	
};


--[========================================================================[
          ARRIVAL. road. in front of the door

          By now, Osiris should be out of the elevator and down the
          path in front of a close door.
--]========================================================================]
global W3HubArrival_ARRIVAL__road__in_front_of_the_door_3 = {
	name = "W3HubArrival_ARRIVAL__road__in_front_of_the_door_3",

	CanStart = function (thisConvo, queue)
		return b_narrative_chapter_road and device_get_position(OBJECTS.dm_road_door_01) > 0.5 and b_monitor_is_on_radio;
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

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "I assume it will be of use to you?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_07200.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[2] = {
			sleepBefore = 2.3,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "A Scorpion? Yeah. We can make use of that, I think.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_buck_03000.sound'),
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",
			sleepBefore = 0.5,
			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "I found this amid the detritus of Guardian three-two-zero-nine's arrival.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_03400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__road__no_tank");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__road__no_tank);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__road__not_in_combat");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__road__not_in_combat);
		CreateMissionThread(player_was_in_tank);
		CreateMissionThread(ARRIVAL__road__covenant);

		PushForwardVOReset(30);

		b_monitor_general_lines = true;
	end,
	
};


--[========================================================================[
          ARRIVAL. road. not in combat
--]========================================================================]
global W3HubArrival_ARRIVAL__road__not_in_combat = {
	name = "W3HubArrival_ARRIVAL__road__not_in_combat",

	disableAIDialog = false,

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_timer == 5 and (not b_player_are_about_to_see_guardian) and not b_cave_gateway_speech and not IsGoalActive(missionArrival.goal_arrival_cavalier); -- GAMMA_CONDITION
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

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "On my installation. I never knew any Warrior Servants.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_01300.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Only Builders and Lifeworkers. This is most exciting.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_07300.sound'),

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
          ARRIVAL. road. no tank
--]========================================================================]
global W3HubArrival_ARRIVAL__road__no_tank = {
	name = "W3HubArrival_ARRIVAL__road__no_tank",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_nar_road_no_tank ) and object_valid("v_road_tank_01") and object_get_health(OBJECTS.v_road_tank_01) > 0.2 and not vehicle_test_seat_unit_list( OBJECTS.v_road_tank_01, "scorpion_d", players() ) and IsSpartanAbleToSpeak(SPARTANS.buck) and objects_distance_to_object( players(), OBJECTS.v_road_tank_01 ) > 10; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(30);
		thisConvo.localVariables.s_distance_from_tank = objects_distance_to_object( players(), OBJECTS.v_road_tank_01 );
	end,

	sleepBefore = 1,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "You sure we don't want to use the Scorpion back there?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_buck_02200.sound'),

			sleepAfter = 1,

		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return object_valid("v_road_tank_01") and not vehicle_test_seat_unit_list( OBJECTS.v_road_tank_01, "scorpion_d", players() ) and IsSpartanAbleToSpeak(SPARTANS.buck) 
						and objects_distance_to_object( players(), OBJECTS.v_road_tank_01 ) >= thisConvo.localVariables.s_distance_from_tank; -- GAMMA_TRANSITION: If player CONTINUES TO go forward without the tank
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "It looks pretty neat.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_buck_04200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)		
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {
						s_distance_from_tank = nil,
						},

	
};



--[========================================================================[
          ARRIVAL. road. covenant look at
--]========================================================================]
global W3HubArrival_ARRIVAL__road__covenant_look_at = {
	name = "W3HubArrival_ARRIVAL__road__covenant_look_at",

	CanStart = function (thisConvo, queue)
		return NarrativeQueue.HasConversationFinished(W3HubArrival_ARRIVAL__road__in_front_of_the_door_3) and 
				(volume_test_players( VOLUMES.tv_narr_road_covenant_safe ) or 
				(ai_living_count(AI.sq_road_cov_phantom_01.spawnpoint01) == 1 and object_at_distance_and_can_see_object(players(), ai_get_object( AI.sq_road_cov_phantom_01.spawnpoint01), 50, 30))
				or (ai_living_count(AI.sq_road_cov_phantom_02.spawnpoint01) == 1 and object_at_distance_and_can_see_object(players(), ai_get_object( AI.sq_road_cov_phantom_02.spawnpoint01), 50, 30)));
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(90);
	end,

	lines = {	
		-- ADD Else if nobody look and add a safe trigger volume or a distance and check the closest Spartan
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Oh, yes, the Guardian slipspace bubbles are bringing a lot of rubbish from their origin planets.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_07700.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Somebody ought to tell them they just lost the war. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_buck_00500.sound'),

			sleepAfter = 0.7,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "They wanna fight, let's give 'em one.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_00600.sound'),
		},	
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	
};



---------------------------------------------------------------------------------------------------------------------------------------------------

function arrival_road_guardian_arrival()

	--	Called from mission script

	PrintNarrative("WAKE - arrival_road_guardian_arrival");

	--SleepUntil([|	object_valid( "sc_gaurdian_01" )], 10);

	local s_timer:number = 0;
	local s_speaker:object = nil;	

	sleep_s(1);

	repeat
			sleep_s(0.2);
			s_timer = s_timer + 0.2;
			s_speaker = spartan_look_at_object(players(), OBJECTS.road_guardian_lookat, 400, 40, 0.1, 2)
	until	s_timer >= 3
			or s_speaker ~= nil


	if s_timer >= 3 then
			if list_count(players()) == 4 then
				s_speaker = GetClosestMusketeer(OBJECTS.road_guardian_lookat, 30, 2);
			else
				s_speaker = GetClosestMusketeer(OBJECTS.road_guardian_lookat, 30, 0);
			end
	else
		sleep_s(2);
	end
		
	PrintNarrative("START - arrival_road_guardian_arrival");
				
				NarrativeQueue.InterruptConversation(W3HubArrival_ARRIVAL__road__covenant_look_at);
				PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__road__GUARDIAN_ARRIVAL_global");
				W3HubArrival_ARRIVAL__road__GUARDIAN_ARRIVAL_global.localVariables.s_speaker = s_speaker;
				NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__road__GUARDIAN_ARRIVAL_global);
				PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__road__two_way_fight");
				NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__road__two_way_fight);

	PrintNarrative("END - arrival_road_guardian_arrival");

	sleep_s(2);

	b_player_are_about_to_see_guardian = false

end



--[========================================================================[
          ARRIVAL. road. GUARDIAN ARRIVAL

          In this scene:

          *  A GUARDIAN PHASES IN WITH A NEW FLOCK OF COVENANT SHIPS
          AROUND IT.

          Just before Osiris reaches the bridge, a Guardian phases in
          with a new flock of Covenant ships around it.
--]========================================================================]
global W3HubArrival_ARRIVAL__road__GUARDIAN_ARRIVAL_global = {
	name = "W3HubArrival_ARRIVAL__road__GUARDIAN_ARRIVAL_global",

	CanStart = function (thisConvo, queue)
		return true;
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
			If = function (thisLine, thisConvo, queue, lineNumber)
				return false;
				--return thisConvo.localVariables.s_speaker == SPARTANS.locke or objects_can_see_object( SPARTANS.locke,  OBJECTS.road_guardian_lookat, 40) ; -- GAMMA_TRANSITION: If locke
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Look up!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_locke_04700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck or objects_can_see_object( SPARTANS.buck,  OBJECTS.road_guardian_lookat, 40); -- GAMMA_TRANSITION: If buck
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Look up!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_buck_04800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka or objects_can_see_object( SPARTANS.tanaka,  OBJECTS.road_guardian_lookat, 40); -- GAMMA_TRANSITION: If tanaka
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Look up!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_tanaka_04800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale or objects_can_see_object( SPARTANS.vale,  OBJECTS.road_guardian_lookat, 40); -- GAMMA_TRANSITION: If vale
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Look up!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_vale_04800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},
	
	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__road__GUARDIAN_ARRIVAL");
		W3HubArrival_ARRIVAL__road__GUARDIAN_ARRIVAL.localVariables.s_speaker = GetClosestMusketeer(thisConvo.localVariables.s_speaker, 30, 0);
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__road__GUARDIAN_ARRIVAL);
	end,

	localVariables = {
						s_speaker = nil,
					},
};



--[========================================================================[
          ARRIVAL. road. GUARDIAN ARRIVAL

          In this scene:

          *  A GUARDIAN PHASES IN WITH A NEW FLOCK OF COVENANT SHIPS
          AROUND IT.

          Just before Osiris reaches the bridge, a Guardian phases in
          with a new flock of Covenant ships around it.
--]========================================================================]
global W3HubArrival_ARRIVAL__road__GUARDIAN_ARRIVAL = {
	name = "W3HubArrival_ARRIVAL__road__GUARDIAN_ARRIVAL",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(30);
	end,

	sleepBefore = 1,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke or objects_can_see_object( SPARTANS.locke,  OBJECTS.road_guardian_lookat, 40) ; -- GAMMA_TRANSITION: If locke
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Guardian!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_02600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck or objects_can_see_object( SPARTANS.buck,  OBJECTS.road_guardian_lookat, 40); -- GAMMA_TRANSITION: If buck
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Guardian!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_buck_00700.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka or objects_can_see_object( SPARTANS.tanaka,  OBJECTS.road_guardian_lookat, 40); -- GAMMA_TRANSITION: If tanaka
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Guardian!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_02000.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale or  objects_can_see_object( SPARTANS.vale,  OBJECTS.road_guardian_lookat, 40); -- GAMMA_TRANSITION: If vale
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Guardian!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_vale_02600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Why has she called so many? A single Guardian can effectively police a solar system.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_01700.sound'),
		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",
			
			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "This show of force is unsettling.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_09800.sound'),

			playDurationAdjustment = 0.8,
		},
		[7] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "I'm sorry. Police?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_vale_00300.sound'),
		},
		[8] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",
			
			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Indeed. Guardians are how the Forerunners enforced peace on the lower systems.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_01400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_arrival_post_guardian_slipspace = true;
	end,

	localVariables = {
						s_speaker = nil,
					},
};

--========================================================================
          --ARRIVAL. road. two way fight
          --A little bit further down the road, we can see Prometheans
          --forces engaged in combat against the covenant.
--========================================================================
global W3HubArrival_ARRIVAL__road__two_way_fight = {
	name = "W3HubArrival_ARRIVAL__road__two_way_fight",

	--disableAIDialog = false,

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narr_2way_fight);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,

	sleepBefore = 1,
	
	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",
			
			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "As you see, Genesis's defenses are targeting the invaders.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_11600.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Unfortunately, the defenses will consider you invaders as well.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_14200.sound'),

			playDurationAdjustment = 0.9,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "It's your installation, can't you tell them to let us through?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_05000.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 5;
			end,
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Unfortunately, no. Between Warden and the Ancilla, most of my administration privileges are deactivated.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_11700.sound'),
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "But worry not! I still have control of some aspects of this facility.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_11800.sound'),

			playDurationAdjustment = 0.9,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,	
		},
		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return false;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: taNAKA
			text = "Such as?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_03600.sound'),

			sleepAfter = 0.5,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[7] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return false;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",
			
			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Ohhh I can open doors. And close them. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_14300.sound'),

			playDurationAdjustment = 0.9,
		},
		[8] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return false;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "I am quite skilled at doors. And bridges.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_14400.sound'),

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


---------------------------------------------------------------------------------------------------------------------------------------------------

function ARRIVAL__road__covenant()

	PrintNarrative("START - ARRIVAL__road__covenant");
	
	IsThereAnEnemyInRangeLauncher(W3HubArrival_ARRIVAL__road__covenant, AI.sg_road_start, ACTOR_TYPE.elite, "enemy_in_range", missionArrival.goal_arrival_road, 15 );
	
end

--[========================================================================[
          Tsunami. Mission start. landing. Elite
--]========================================================================]
global W3HubArrival_ARRIVAL__road__covenant = {
	name = "W3HubArrival_ARRIVAL__road__covenant",	

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

		lines = {
			[1] = {					
					--character = AI.sq_turr0_arbiter_a.spawnpoint99,
					text = "Humans! Kill them!",
					tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_cv_elite01_00100.sound'),
				},
		},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);	
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};


--========================================================================
  --        ARRIVAL. road. encounter
--========================================================================
global W3HubArrival_ARRIVAL__road__encounter_killing_half = {
	name = "W3HubArrival_ARRIVAL__road__encounter_killing_half",

	CanStart = function (thisConvo, queue)
		return not b_monitor_encounter_speech and not b_cave_gateway_speech and IsGoalActive(missionArrival.goal_arrival_road) and not volume_test_players(VOLUMES.tv_mon_gate_03_cave); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		b_monitor_encounter_speech = true;
		PushForwardVOReset();
	end,

	sleepBefore = 3,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			
			sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "You are performing admirably. Do so faster, please.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_03200.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			sleepAfter = 1,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)		
		PrintNarrative("END - "..thisConvo.name);
		b_monitor_encounter_speech = false;
	end,
};

--========================================================================
          --ARRIVAL. road. encounter
--========================================================================
global W3HubArrival_ARRIVAL__road__encounter_tank_below_50 = {
	name = "W3HubArrival_ARRIVAL__road__encounter_tank_below_50",

	CanStart = function (thisConvo, queue)
		return not b_player_are_about_to_see_guardian and not b_monitor_encounter_speech and not b_cave_gateway_speech
					and object_valid("v_road_tank_01") and object_get_health( OBJECTS.v_road_tank_01 ) < 0.5 and object_get_health( OBJECTS.v_road_tank_01 ) > 0.1 and vehicle_test_seat_unit_list( OBJECTS.v_road_tank_01, "scorpion_d", players() ); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		b_monitor_encounter_speech = true;
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
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Your vehicle is not coping well with the stress of combat.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_08200.sound'),
		},
	},
	
	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)		
		PrintNarrative("END - "..thisConvo.name);
		b_monitor_encounter_speech = false;
	end,
};



--========================================================================
  --        ARRIVAL. road. encounter
--========================================================================
global W3HubArrival_ARRIVAL__road__encounter_tank_below_20 = {
	name = "W3HubArrival_ARRIVAL__road__encounter_tank_below_20",

	CanStart = function (thisConvo, queue)
		return not b_player_are_about_to_see_guardian and not b_monitor_encounter_speech and not b_cave_gateway_speech
					and object_valid("v_road_tank_01") and object_get_health( OBJECTS.v_road_tank_01 ) < 0.2 and object_get_health( OBJECTS.v_road_tank_01 ) > 0.05 and vehicle_test_seat_unit_list( OBJECTS.v_road_tank_01, "scorpion_d", players() ); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		b_monitor_encounter_speech = true;		
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
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Please, be more careful. That is the only one of those vehicles that exist on Genesis! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_12100.sound'),
		},
	},
	
	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)		
		PrintNarrative("END - "..thisConvo.name);
		b_monitor_encounter_speech = false;
	end,
};

function ARRIVAL__road__encounter_tank_dead()
local s_timer:number = 0;

PrintNarrative("START - ARRIVAL__road__encounter_tank_dead");

repeat

	SleepUntil([| not b_player_are_about_to_see_guardian and not b_monitor_encounter_speech and not b_cave_gateway_speech
					 and object_valid("v_road_tank_01") and object_get_health( OBJECTS.v_road_tank_01 ) <= 0 and objects_distance_to_object( players(), OBJECTS.v_road_tank_01 ) < 15 
					 and not (IsGoalActive(missionArrival.goal_arrival_grasslands) or IsGoalActive(missionArrival.goal_arrival_cavalier))], 10);

	if NarrativeQueue.ConversationsPlayingCount() == 0 then

		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__road__encounter_tank_dead");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__road__encounter_tank_dead);		
	end

	s_timer = s_timer + 0.5;
	sleep_s(0.5);

until NarrativeQueue.IsConversationQueued(W3HubArrival_ARRIVAL__road__encounter_tank_dead) or s_timer >= 3 or (IsGoalActive(missionArrival.goal_arrival_grasslands) or IsGoalActive(missionArrival.goal_arrival_cavalier))


end
--========================================================================
  --        ARRIVAL. road. encounter
--========================================================================
global W3HubArrival_ARRIVAL__road__encounter_tank_dead = {
	name = "W3HubArrival_ARRIVAL__road__encounter_tank_dead",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		b_monitor_encounter_speech = true;
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
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Oh no. With the vehicle disabled, you will have to rely on your combat skin.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_02700.sound'),
		},
	},	

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)		
		PrintNarrative("END - "..thisConvo.name);
		b_monitor_encounter_speech = false;
	end,
};


--========================================================================
          --ARRIVAL. road. encounter
--========================================================================
global W3HubArrival_ARRIVAL__road__encounter_monitor_combat = {
	name = "W3HubArrival_ARRIVAL__road__encounter_monitor_combat",

	CanStart = function (thisConvo, queue)
		return not b_monitor_friendly_fire and ai_living_count(AI.sq_sassy_spark) > 0 and object_get_health( AI.sq_sassy_spark ) < 0.8 and not b_player_are_about_to_see_guardian and not b_monitor_encounter_speech and not b_cave_gateway_speech and IsSpartanInCombat(); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		b_monitor_encounter_speech = true;
		PushForwardVOReset();
		PrintNarrative("Monitor Health: "..object_get_health( AI.sq_sassy_spark ));
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
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Oh my... I never was in combat before... This is rather distressing. And exciting.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_09900.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
				b_monitor_general_line_5 = true;
			end,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
		print("Setting Monitor health to 1");
		object_set_health( ai_get_object(AI.sq_sassy_spark), 1 )
	end,

	sleepAfter = 1,
	
	OnFinish = function (thisConvo, queue)
		b_monitor_encounter_speech = false;
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(ARRIVAL__road__encounter_monitor_hit);		
	end,
};

function ARRIVAL__road__encounter_monitor_hit()

	sleep_s(10);

	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__road__encounter_monitor_hit");					
	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__road__encounter_monitor_hit);

end

--========================================================================
  --        ARRIVAL. road. encounter
--========================================================================
global W3HubArrival_ARRIVAL__road__encounter_monitor_hit = {
	name = "W3HubArrival_ARRIVAL__road__encounter_monitor_hit",

	CanStart = function (thisConvo, queue)
		return random_range(5,5) == 5 and not b_player_are_about_to_see_guardian and not b_monitor_encounter_speech and not b_cave_gateway_speech
					 and object_get_health( ai_get_object(AI.sq_sassy_spark) ) < 1; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		b_monitor_encounter_speech = true;
		PushForwardVOReset();
	end,

	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,	

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_player_are_about_to_see_guardian and not b_monitor_encounter_speech and not b_cave_gateway_speech;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "I am hit! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_02600.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_player_are_about_to_see_guardian and not b_monitor_encounter_speech and not b_cave_gateway_speech;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "I have taken damage. But only cosmetic.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_11100.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_player_are_about_to_see_guardian and not b_monitor_encounter_speech and not b_cave_gateway_speech;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "A battle scar... Glorious!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_11200.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)		
		PrintNarrative("END - "..thisConvo.name);
		b_monitor_encounter_speech = false;
	end,
};


function ARRIVAL__road__encounter_monitor_tank_behind()
local s_timer:number = 0;
PrintNarrative("START - ARRIVAL__road__encounter_monitor_tank_behind");

repeat
	
	s_timer = 0	

	SleepUntil([| b_player_was_in_tank and not b_monitor_encounter_speech and not b_player_are_about_to_see_guardian and not b_cave_gateway_speech
					and object_valid("v_road_tank_01") and vehicle_test_seat_unit_list( OBJECTS.v_road_tank_01, "scorpion_d", players() ) and object_get_health( OBJECTS.v_road_tank_01 ) > 0 and not volume_test_players( VOLUMES.tv_nar_road_no_tank )], 10);

	repeat
			s_timer = s_timer + 0.1;
			sleep_s(0.1);
			print(s_timer);

			SleepUntil([| b_player_was_in_tank and not b_monitor_encounter_speech and not b_player_are_about_to_see_guardian and not b_cave_gateway_speech
							and object_valid("v_road_tank_01") and not vehicle_test_seat_unit_list( OBJECTS.v_road_tank_01, "scorpion_d", players() ) and object_get_health( OBJECTS.v_road_tank_01 ) > 0.4 and not volume_test_players( VOLUMES.tv_nar_road_no_tank ) and objects_distance_to_object( players(), OBJECTS.v_road_tank_01 ) > 6
							and not (IsGoalActive(missionArrival.goal_arrival_grasslands) or IsGoalActive(missionArrival.goal_arrival_cavalier))], 10);

			PrintNarrative("START - ARRIVAL__road__encounter_monitor_tank_behind - Player exited the tank");

			if NarrativeQueue.ConversationsPlayingCount() == 0 then

				PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__road__encounter_monitor_tank_behind");
				NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__road__encounter_monitor_tank_behind);

				sleep_s(0.1);
			end

	until NarrativeQueue.IsConversationQueued(W3HubArrival_ARRIVAL__road__encounter_monitor_tank_behind) or s_timer >= 2

until NarrativeQueue.IsConversationQueued(W3HubArrival_ARRIVAL__road__encounter_monitor_tank_behind) or (IsGoalActive(missionArrival.goal_arrival_grasslands) or IsGoalActive(missionArrival.goal_arrival_cavalier))


end



--========================================================================
          --ARRIVAL. road. encounter
--========================================================================
global W3HubArrival_ARRIVAL__road__encounter_monitor_tank_behind = {
	name = "W3HubArrival_ARRIVAL__road__encounter_monitor_tank_behind",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		b_monitor_encounter_speech = true;
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
			
			moniker = "ExuberantWitness",
			
			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "You wish to take on an army in nothing but that combat skin? How reckless.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_02800.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)		
		PrintNarrative("END - "..thisConvo.name);
		b_monitor_encounter_speech = false;
	end,
};

------------------------------

function player_was_in_tank()

SleepUntil([| vehicle_test_seat_unit_list( OBJECTS.v_road_tank_01, "scorpion_d", players() ) ], 60);

b_player_was_in_tank = true;


end





function arrival_monitor_during_encounter_general_lines()

	PrintNarrative("WAKE - arrival_monitor_during_encounter_general_lines");
	
	SleepUntil([| b_monitor_general_lines ], 400);

	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__road__encounter_tank_below_20");					
	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__road__encounter_tank_below_20);

	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__road__encounter_tank_below_50");					
	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__road__encounter_tank_below_50);
		
	CreateMissionThread(ARRIVAL__road__encounter_tank_dead);
	
	CreateMissionThread(ARRIVAL__road__encounter_monitor_tank_behind);

	SleepUntil([| b_monitor_general_lines and b_arrival_post_guardian_slipspace and not b_monitor_encounter_speech and not b_player_are_about_to_see_guardian and not b_cave_gateway_speech ], 400);

	PrintNarrative("START - arrival_monitor_during_encounter_general_lines - line 5 (actualy the first one)");
	
	if not b_monitor_general_line_5 and (IsGoalActive(missionArrival.goal_arrival_road) or IsGoalActive(missionArrival.goal_arrival_cave) or IsGoalActive(missionArrival.goal_arrival_crossing) or IsGoalActive(missionArrival.goal_arrival_bridge) ) then

			PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__road__encounter_monitor_combat");					
			NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__road__encounter_monitor_combat);							
	end

	sleep_s(random_range(40,60));	

	SleepUntil([| b_monitor_general_lines and b_arrival_post_guardian_slipspace and not b_monitor_encounter_speech and not b_player_are_about_to_see_guardian and not b_cave_gateway_speech ], 400);

	PrintNarrative("START - arrival_monitor_during_encounter_general_lines - line 1");
	
	if not b_monitor_general_line_1 and (IsGoalActive(missionArrival.goal_arrival_road) or IsGoalActive(missionArrival.goal_arrival_cave) or IsGoalActive(missionArrival.goal_arrival_crossing) or IsGoalActive(missionArrival.goal_arrival_bridge) ) then

			PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__road__encounter_monitor_general_1");					
			NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__road__encounter_monitor_general_1);

			SleepUntil([| NarrativeQueue.HasConversationFinished(W3HubArrival_ARRIVAL__road__encounter_monitor_general_1) ], 30);

			b_monitor_general_line_1 = true;
	end

	sleep_s(random_range(40,60));	
	
	SleepUntil([| b_monitor_general_lines and not b_monitor_encounter_speech and not b_player_are_about_to_see_guardian and not b_cave_gateway_speech ], 400);

	PrintNarrative("START - arrival_monitor_during_encounter_general_lines - line 3");
	
	b_monitor_encounter_speech = true;
	sleep_s(1);

	if not b_monitor_general_line_2 and (IsGoalActive(missionArrival.goal_arrival_road) or IsGoalActive(missionArrival.goal_arrival_cave) or IsGoalActive(missionArrival.goal_arrival_crossing) or IsGoalActive(missionArrival.goal_arrival_bridge) ) then

			PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__road__encounter_monitor_general_2");
			NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__road__encounter_monitor_general_2);

			SleepUntil([| NarrativeQueue.HasConversationFinished(W3HubArrival_ARRIVAL__road__encounter_monitor_general_2) ], 30);

			b_monitor_general_line_2 = true;
	end

	sleep_s(1);
	b_monitor_encounter_speech = false;	
	
	sleep_s(random_range(40,60));	
	
	SleepUntil([| b_monitor_general_lines and IsSpartanInCombat() and not b_monitor_encounter_speech and not b_player_are_about_to_see_guardian and not b_cave_gateway_speech ], 400);

	PrintNarrative("START - arrival_monitor_during_encounter_general_lines - line 3");
	
	b_monitor_encounter_speech = true;
	sleep_s(1);

	if not b_monitor_general_line_3 then

			PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__road__encounter_monitor_general_3");
			NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__road__encounter_monitor_general_3);

			SleepUntil([| NarrativeQueue.HasConversationFinished(W3HubArrival_ARRIVAL__road__encounter_monitor_general_3) ], 30);

			b_monitor_general_line_3 = true;
	end

	sleep_s(1);
	b_monitor_encounter_speech = false;	
	
	sleep_s(random_range(40,60));	
		
	SleepUntil([| b_monitor_general_lines and IsSpartanInCombat() and not b_monitor_encounter_speech and not b_player_are_about_to_see_guardian and not b_cave_gateway_speech ], 400);

	PrintNarrative("START - arrival_monitor_during_encounter_general_lines - line 4");
	
	b_monitor_encounter_speech = true;
	sleep_s(1);

	if not b_monitor_general_line_4 then

			PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__road__encounter_monitor_general_4");
			NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__road__encounter_monitor_general_4);

			SleepUntil([| NarrativeQueue.HasConversationFinished(W3HubArrival_ARRIVAL__road__encounter_monitor_general_4) ], 30);

			b_monitor_general_line_4 = true;
	end

	sleep_s(1);
	b_monitor_encounter_speech = false;	
	PrintNarrative("END - arrival_monitor_during_encounter_general_lines");

	b_monitor_general_lines = false;

end



--========================================================================
          --ARRIVAL. road. encounter
--========================================================================
global W3HubArrival_ARRIVAL__road__encounter_monitor_general_1 = {
	name = "W3HubArrival_ARRIVAL__road__encounter_monitor_general_1",

	disableAIDialog = false,

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		b_monitor_encounter_speech = true;
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
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Warden is going to notice this comotion. Be quick.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_03100.sound'),
		},
	},
	
	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)		
		PrintNarrative("END - "..thisConvo.name);
		b_monitor_encounter_speech = false;
	end,

};


--========================================================================
         -- ARRIVAL. road. encounter
--========================================================================
global W3HubArrival_ARRIVAL__road__encounter_monitor_general_2 = {
	name = "W3HubArrival_ARRIVAL__road__encounter_monitor_general_2",

	disableAIDialog = false,

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		b_monitor_encounter_speech = true;
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
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Genesis is really a magnificent planet.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_12500.sound'),
		},
		[2] = {
			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "It's usually less... busy. Quite lonely actually.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_12600.sound'),
			
			--playDurationAdjustment = 0.8,	
		},
		[3] = {
			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "But Magnificent!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_12700.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},
	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

};



--========================================================================
          --ARRIVAL. road. encounter
--========================================================================
global W3HubArrival_ARRIVAL__road__encounter_monitor_general_3 = {
	name = "W3HubArrival_ARRIVAL__road__encounter_monitor_general_3",

	disableAIDialog = false,

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

	sleepBefore = 1,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "I must admit, I do find this rather exhilarating, in spite of myself.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_02900.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},
	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};



--========================================================================
          --ARRIVAL. road. encounter
--========================================================================
global W3HubArrival_ARRIVAL__road__encounter_monitor_general_4 = {
	name = "W3HubArrival_ARRIVAL__road__encounter_monitor_general_4",

	disableAIDialog = false,

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

	sleepBefore = 1,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Humanity has not changed much since last your kind walked the stars. You are as deadly as ever.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_03000.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},
	OnFinish = function (thisConvo, queue)		
		PrintNarrative("END - "..thisConvo.name);
	end,
};
---------------------------------------------------------------------------------------------------------------------------------------------------

function arrival_road_giant_door()

	PrintNarrative("WAKE - arrival_road_giant_door");

	SleepUntil([| volume_test_players(VOLUMES.tv_mon_gate_03_cave) ], 60);
	PrintNarrative("START - arrival_road_giant_door");
	
	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__road__giant_door");
	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__road__giant_door);
end


--========================================================================
          --ARRIVAL. road. giant door
          --At then end of the area, there is a giant closed door.
          --When the enemies are cleared, the Monitor opens the way forward.
--========================================================================
global W3HubArrival_ARRIVAL__road__giant_door = {
	name = "W3HubArrival_ARRIVAL__road__giant_door",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.tv_mon_gate_03_cave);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
		thisConvo.localVariables.s_speaker = AlternateSpeakerWhenEnteringVolume(VOLUMES.tv_mon_gate_03_cave, 25 );
		PushForwardVOReset();
		b_monitor_general_lines = false;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If locke close to the giant closed door.
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: locke
			text = "Looks like the road ends here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_03000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: If buck close to the giant closed door.
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Looks like the road ends here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_buck_03100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: If tanaka close to the giant closed door.
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Looks like the road ends here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_00800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: If vale close to the giant closed door.
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Looks like the road ends here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_vale_03000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.4,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Exuberant?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_03900.sound'),
			},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			sleepBefore = 0.2,

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "One moment! I will open this.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_12200.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__road__giant_door_1");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__road__giant_door_1);
	end,

	localVariables = {
						s_speaker = nil,
						
						},
};


--========================================================================
          --ARRIVAL. road. giant door
          --At then end of the area, there is a giant closed door.
          --When the enemies are cleared, the Monitor opens the way forward.
--========================================================================
global W3HubArrival_ARRIVAL__road__giant_door_1 = {
	name = "W3HubArrival_ARRIVAL__road__giant_door_1",

	CanStart = function (thisConvo, queue)
		return device_get_position(OBJECTS.dm_cave_door_01) > 0; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	sleepBefore = 3,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return false;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "See? Quite good with doors. Yes.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_12300.sound'),

			sleepAfter = 1.5,
		},
		[2] = {
			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Follow me.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_05700.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W3HubArrival_Arrival__cave__GATEWAY_entrance");
		NarrativeQueue.QueueConversation(W3HubArrival_Arrival__cave__GATEWAY_entrance);
	end,	
};




--[========================================================================[
          Arrival. cave. GATEWAY pull forward
--]========================================================================]
global W3HubArrival_Arrival__cave__GATEWAY_entrance = {
	name = "W3HubArrival_Arrival__cave__GATEWAY_entrance",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narr_arrival_cave_entrance ); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_monitor_general_lines = false;
		b_cave_gateway_speech = true;
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "The gateway is almost ready. Hurry!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_08500.sound'),
		},
		[2] = {
			sleepBefore = 0.3,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "What is the Gateway.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_00700.sound'),
		},
		[3] = {
			sleepBefore = 0.3,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "It is a bridge between the Domain and Genesis. Within that building Cortana will be reborn into the physical world.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_11900.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		
	end,
};
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------


function arrival_cave_load()

	PrintNarrative("LOAD - arrival_cave_load");

	b_monitor_release = true;
	b_monitor_is_on_radio = true;
	b_arrival_post_guardian_slipspace = true;

	CreateMissionThread(arrival_cave_gateway);	
	CreateMissionThread(arrival_crossing_lookat_banshee);
		
	SleepUntil([| volume_test_players(VOLUMES.tv_narr_cave_gateway_push_forward) ], 10);

	b_player_entered_crossing = true;

end


---------------------------------------------------------------------------------------------------------------------------------------------------



function arrival_cave_gateway()

	SleepUntil([| volume_test_players(VOLUMES.tv_narr_cave_gateway_look_at_volume) ], 10);

	--	CHECK VOLUME FOR WHEN THE PLAYER IS IN THE TANK

	local s_timer:number = 0;

	repeat 
		sleep_s(0.1);
		s_timer = s_timer + 0.1;
	until	s_timer >= 2
			or volume_test_players(VOLUMES.tv_narr_cave_gateway)
			or volume_test_players_lookat( VOLUMES.tv_narr_cave_gateway_look_at, 180, 32 ) and volume_test_players(VOLUMES.tv_narr_cave_gateway_look_at_volume)
				
				b_tunnel_player_saw_the_gateway = true;

				PrintNarrative("QUEUE - W3HubArrival_Arrival__cave__GATEWAY_2");
				NarrativeQueue.QueueConversation(W3HubArrival_Arrival__cave__GATEWAY_2);

	PrintNarrative("END - arrival_cave_gateway");

end

--========================================================================
          --Arrival. cave. GATEWAY
          --After the door, the player is in a tunnel. Straight forward,
          --we can see the Gateway.
--========================================================================
global W3HubArrival_Arrival__cave__GATEWAY_2 = {
	name = "W3HubArrival_Arrival__cave__GATEWAY_2",

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
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "There! The Gateway. You will find the other warrior humans there.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_02000.sound'),

			playDurationAdjustment = 0.85,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				PrintNarrative("QUEUE - W3HubArrival_Arrival__crossing__phantom_reinforcement");
				NarrativeQueue.QueueConversation(W3HubArrival_Arrival__crossing__phantom_reinforcement);
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return false; -- thisConvo.localVariables.speaker == SPARTANS.locke;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					W3HubArrival_Arrival__crossing__phantom_reinforcement.localVariables.more_covies_said = true;
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "More covenant.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_02800.sound'),

			playDurationAdjustment = 0.7,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.speaker == SPARTANS.buck;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					W3HubArrival_Arrival__crossing__phantom_reinforcement.localVariables.more_covies_said = true;
			end,

			playDurationAdjustment = 0.7,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "More covenant.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_buck_02600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.speaker == SPARTANS.tanaka;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					W3HubArrival_Arrival__crossing__phantom_reinforcement.localVariables.more_covies_said = true;
			end,

			playDurationAdjustment = 0.7,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "More covenant.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_02100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.speaker == SPARTANS.vale;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					W3HubArrival_Arrival__crossing__phantom_reinforcement.localVariables.more_covies_said = true;
			end,

			playDurationAdjustment = 0.7,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "More covenant.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_vale_02800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[6] = {
			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "And the Master Chief is there?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_03500.sound'),
		},
		[7] = {
			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Cortana has had the other humans wandering in circles within the Gateway facility for some hours.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_14500.sound'),
		},
		[8] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "She is preparing for something. But just what is unknown.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_15700.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
		CreateMissionThread(arrival_crossing_crashed_pelican_1);
	end,

	sleepAfter = 2,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_cave_gateway_speech = false;
		b_monitor_general_lines = true;
	end,

	localVariables = {
					speaker = nil,
					more_covies_said = nil,
					},
};


function arrival_crossing_lookat_banshee()

local s_speaker:object = nil;

	PrintNarrative("LISTENER - arrival_crossing_lookat_banshee");

	repeat
			repeat 
		
				--print("wait for player be near");
				SleepUntil([| ai_living_count(AI.sq_crossing_cross_cov01.spawnpoint01) > 0 ], 10);		

					repeat
						Sleep(10);
							if  volume_test_players_lookat( VOLUMES.tv_narr_cave_gateway_look_at, 180, 32 )  then
								s_speaker = spartan_look_at_object(players(), ai_get_object(AI.sq_crossing_cross_cov01.spawnpoint01), 50, 30, 0.1, 2);
								
								if s_speaker == nil then
									s_speaker = spartan_look_at_object(players(), ai_get_object(AI.sq_crossing_cross_cov02.spawnpoint01), 50, 30, 0.1, 2);
								end
							end

							if s_speaker == SPARTANS.locke then
								s_speaker = GetClosestMusketeer(SPARTANS.locke, 15, 2);
							end
					until s_speaker ~= nil or not volume_test_players_lookat( VOLUMES.tv_narr_cave_gateway_look_at, 180, 40 ) or b_crossing_player_looked_at_banshee

			until s_speaker ~= nil or b_crossing_player_looked_at_banshee

			if not b_crossing_player_looked_at_banshee then

				b_crossing_player_looked_at_banshee = true;				
				W3HubArrival_Arrival__cave__GATEWAY_2.localVariables.speaker = s_speaker;				
				W3HubArrival_Arrival__crossing__phantom_reinforcement.localVariables.speaker = s_speaker;				
			end

	until b_crossing_player_looked_at_banshee
end


--[========================================================================[
          Arrival. crossing. phantom reinforcement

          Just in front of the player, a covenant phantom is dropping
          troops.

          TO BRIAN: I Wanted to cut those lines, feels unnecessary.
          Couldn't find a appropriate moment in the current flow where
          it's needed.
--]========================================================================]
global W3HubArrival_Arrival__crossing__phantom_reinforcement = {
	name = "W3HubArrival_Arrival__crossing__phantom_reinforcement",

	CanStart = function (thisConvo, queue)
		return (b_crossing_player_looked_at_banshee or volume_test_players( VOLUMES.tv_narr_crossing_more_covies)) and not b_cave_gateway_speech and not IsSpartanInCombat(); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		if not b_crossing_player_looked_at_banshee then
			thisConvo.localVariables.speaker = AlternateSpeakerWhenEnteringVolume(VOLUMES.tv_narr_crossing_more_covies, 15,  0);
			b_crossing_player_looked_at_banshee = true;
		end
		
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.speaker == SPARTANS.locke and thisConvo.localVariables.more_covies_said == nil;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "More covenant.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_02800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.speaker == SPARTANS.buck and thisConvo.localVariables.more_covies_said == nil;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "More covenant.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_buck_02600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.speaker == SPARTANS.tanaka and thisConvo.localVariables.more_covies_said == nil;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "More covenant.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_02100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.speaker == SPARTANS.vale and thisConvo.localVariables.more_covies_said == nil;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "More covenant.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_vale_02800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
					speaker = nil,
					more_covies_said = nil,
					},
};




---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------


function arrival_crossing_load()

	PrintNarrative("LOAD - arrival_crossing_load");
	
	b_monitor_release = true;
	b_monitor_is_on_radio = true;
	b_arrival_post_guardian_slipspace = true;

	PrintNarrative("QUEUE - W3HubArrival_Arrival__crossing__2_3_of_encounter");
	NarrativeQueue.QueueConversation(W3HubArrival_Arrival__crossing__2_3_of_encounter);	

	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__BRIDGE_intro");
	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__BRIDGE_intro);	

	CreateMissionThread(ARRIVAL__gateway__covenant);
	CreateMissionThread(arrival_destructive);	

	sleep_s(10);

	b_monitor_general_lines = true;
end



function arrival_destructive()

SleepUntil([| ai_living_count(AI.sq_crossing_cross_cov05.spawnpoint01) == 1 and ai_living_count(AI.sq_crossing_cross_cov04.spawnpoint01) == 1] , 30);

SleepUntil([| ai_living_count(AI.sq_crossing_cross_cov05.spawnpoint01) == 0 and ai_living_count(AI.sq_crossing_cross_cov04.spawnpoint01) == 0] , 1);

	if volume_test_players( VOLUMES.tv_narr_arrival_destructive ) then
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__road__encounter_destructive");					
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__road__encounter_destructive);
	end

end


--========================================================================
  --        ARRIVAL. road. encounter
--========================================================================
global W3HubArrival_ARRIVAL__road__encounter_destructive = {
	name = "W3HubArrival_ARRIVAL__road__encounter_destructive",

	CanStart = function (thisConvo, queue)
		return not b_monitor_encounter_speech; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 8;
	end,

	OnInitialize = function(thisConvo, queue)
		b_monitor_encounter_speech = true;
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
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Yes, I can see now why the Warden is troubled by your presence. You are quite destructive.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_07900.sound'),

		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)		
		PrintNarrative("END - "..thisConvo.name);
		b_monitor_encounter_speech = false;
	end,
};



function ARRIVAL__gateway__covenant()

	PrintNarrative("START - ARRIVAL__gateway__covenant");

	SleepUntil ([| ai_living_count(AI.sg_crossing_cross_cov) > 0 
					and (	(IsPlayer(SPARTANS.tanaka) and objects_distance_to_object( SPARTANS.tanaka, AI.sq_crossing_cross_cov03.spawnpoint01 ) < 4)
							or (not IsPlayer(SPARTANS.tanaka) and objects_distance_to_object( SPARTANS.tanaka, AI.sq_crossing_cross_cov03.spawnpoint01 ) < 6)
						) ], 60);
	
	IsThereAnEnemyInRangeLauncher(W3HubArrival_ARRIVAL__gateway__covenant, AI.sg_crossing_cross_cov, ACTOR_TYPE.elite, "enemy_in_range", missionArrival.goal_arrival_crossing, 4 );
	
end



--[========================================================================[
          ARRIVAL. gateway. covenant

          The group of covenant going towards the gateway.

          No more covenant there.
--]========================================================================]
global W3HubArrival_ARRIVAL__gateway__covenant = {
	name = "W3HubArrival_ARRIVAL__gateway__covenant",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			--character = 0, -- GAMMA_CHARACTER: Elite01
			text = "This world is ours! Burn the filth from its surface!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_cv_elite01_00200.sound'),

			playDurationAdjustment = 0.8,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Seriously now. We have bigger problems than these guys.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_03700.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER				
				return 0;
			end,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Eliminate them as quick as possible.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_05300.sound'),
		},
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	PrintNarrative("END - "..thisConvo.name);	
	end,

		localVariables = {
						enemy_in_range = nil,
					},
};



--[========================================================================[
          Arrival. crossing. 2/3 of encounter
--]========================================================================]
global W3HubArrival_Arrival__crossing__2_3_of_encounter = {
	name = "W3HubArrival_Arrival__crossing__2_3_of_encounter",

	CanStart = function (thisConvo, queue)
		return not b_monitor_encounter_speech and volume_test_players( VOLUMES.tv_narr_crossing_2_third );
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_monitor_encounter_speech = true;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "You may want to hurry. The ancilla is attempting to access several high level communications systems.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_01900.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "How much time do we have?\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_01100.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Very little. Not enough. Almost none, in fact.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_02100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	sleepAfter = 2,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_monitor_encounter_speech = false;
	end,
};


---------------------------------------------------------------------------------------------------------------------------------------------------


function arrival_crossing_crashed_pelican_1()

local s_speaker:object = nil;

	SleepUntil([| object_valid("cr_narr_crossing_pelican_01")  ], 60);

	PrintNarrative("LISTENER - arrival_crossing_crashed_pelican_1");

	repeat 
		
		--print("wait for player be near");
		SleepUntil([| volume_test_players( VOLUMES.tv_narr_arrival_1st_pelican )], 10);		
		
		s_speaker = nil;

			repeat
				Sleep(10);
				s_speaker = spartan_look_at_object(players(), OBJECTS.cr_narr_crossing_pelican_01, 15, 15, 0.5, 2);
			until s_speaker ~= nil or not volume_test_players(VOLUMES.tv_narr_arrival_1st_pelican)

	until (not IsSpartanInCombat(s_speaker) and not b_monitor_encounter_speech and s_speaker ~= nil) or not object_valid("cr_narr_crossing_pelican_01") 

	if s_speaker ~= nil then

		PrintNarrative("QUEUE - W3HubArrival_Arrival__crossing__crashed_pelican");
		W3HubArrival_Arrival__crossing__crashed_pelican.localVariables.s_speaker = s_speaker;
		W3HubArrival_Arrival__crossing__crashed_pelican.localVariables.s_pelican = 1;
		NarrativeQueue.QueueConversation(W3HubArrival_Arrival__crossing__crashed_pelican);
	end

end


--[========================================================================[
          Arrival. crossing. crashed pelican

          When a player is in proximity and looking at the crashed
          Pelican.
--]========================================================================]
global W3HubArrival_Arrival__crossing__crashed_pelican = {
	name = "W3HubArrival_Arrival__crossing__crashed_pelican",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke and not thisConvo.localVariables.s_locke and (object_at_distance_and_can_see_object(thisConvo.localVariables.s_speaker, OBJECTS.cr_narr_crossing_pelican_01, 20, 30, VOLUMES.tv_narr_arrival_1st_pelican) or object_at_distance_and_can_see_object(thisConvo.localVariables.s_speaker, OBJECTS.cr_narr_crossing_pelican_02, 20, 30, VOLUMES.tv_narr_arrival_2nd_pelican));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_locke = true;
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Got a crashed UNSC Pelican here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_03100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck and not thisConvo.localVariables.s_buck and (object_at_distance_and_can_see_object(thisConvo.localVariables.s_speaker, OBJECTS.cr_narr_crossing_pelican_01, 20, 30, VOLUMES.tv_narr_arrival_1st_pelican) or object_at_distance_and_can_see_object(thisConvo.localVariables.s_speaker, OBJECTS.cr_narr_crossing_pelican_02, 20, 30, VOLUMES.tv_narr_arrival_2nd_pelican));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_buck = true;
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Got a crashed UNSC Pelican here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_buck_03200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka and not thisConvo.localVariables.s_tanaka and (object_at_distance_and_can_see_object(thisConvo.localVariables.s_speaker, OBJECTS.cr_narr_crossing_pelican_01, 20, 30, VOLUMES.tv_narr_arrival_1st_pelican) or object_at_distance_and_can_see_object(thisConvo.localVariables.s_speaker, OBJECTS.cr_narr_crossing_pelican_02, 20, 30, VOLUMES.tv_narr_arrival_2nd_pelican));
			end,
						
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_tanaka = true;
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Got a crashed UNSC Pelican here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_02200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale and not thisConvo.localVariables.s_vale and (object_at_distance_and_can_see_object(thisConvo.localVariables.s_speaker, OBJECTS.cr_narr_crossing_pelican_01, 20, 30, VOLUMES.tv_narr_arrival_1st_pelican) or object_at_distance_and_can_see_object(thisConvo.localVariables.s_speaker, OBJECTS.cr_narr_crossing_pelican_02, 20, 30, VOLUMES.tv_narr_arrival_2nd_pelican));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_vale = true;
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Got a crashed UNSC Pelican here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_vale_03100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 5;
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_answer ~= true and not IsSpartanInCombat();
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_answer = true;
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Must've got caught up in the Guardian slipspace bubble...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_buck_03300.sound'),
		},
		[6] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_answer_2 ~= true and not IsSpartanInCombat();
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_answer_2 = true;
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Grab ammmo if you need it, but keep moving.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_03700.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		if thisConvo.localVariables.s_locke == nil and thisConvo.localVariables.s_buck == nil and thisConvo.localVariables.s_tanaka == nil and thisConvo.localVariables.s_vale == nil then
			if thisConvo.localVariables.s_pelican == 1 then
				CreateMissionThread(arrival_crossing_crashed_pelican_1);
			elseif thisConvo.localVariables.s_pelican == 2 then
				CreateMissionThread(arrival_grassland_crashed_pelican_2);
			end
		end
	end,

	localVariables = {
						s_speaker = nil,
						s_locke = nil,
						s_buck = nil,
						s_tanaka = nil,
						s_vale = nil,
						s_answer = nil,
						s_answer_2 = nil,
						s_pelican = nil,
						},
};



--[========================================================================[
          ARRIVAL. BRIDGE

          The bridge is not present when the player arrives.
--]========================================================================]
global W3HubArrival_ARRIVAL__BRIDGE_intro = {
	name = "W3HubArrival_ARRIVAL__BRIDGE_intro",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narr_arrival_bridge_intro);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_monitor_encounter_speech  = true;
		b_monitor_general_lines = false;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",
			
			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "This way, straight ahead.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_08700.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_monitor_encounter_speech  = false;
	end,

	
};

---------------------------------------------------------------------------------------------------------------------------------------------------


function arrival_bridge_load()

	PrintNarrative("LOAD - arrival_bridge_load");

	b_monitor_release = true;
	b_monitor_is_on_radio = true;
	b_arrival_post_guardian_slipspace = true;

	--CreateThread(arrival_bridge);

end

---------------------------------------------------------------------------------------------------------------------------------------------------

function arrival_bridge()

	--	Called from mission script
	PrintNarrative("WAKE - arrival_bridge");

	PrintNarrative("START - arrival_bridge");

	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__BRIDGE");
	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__BRIDGE);

	local s_locke_shield:number = unit_get_shield( SPARTANS.locke);
	local s_buck_shield:number = unit_get_shield( SPARTANS.buck);
	local s_tanaka_shield:number = unit_get_shield( SPARTANS.tanaka);
	local s_vale_shield:number = unit_get_shield( SPARTANS.vale);

	SleepUntil([|	(unit_get_shield( SPARTANS.locke) < s_locke_shield or unit_get_shield( SPARTANS.buck) < s_buck_shield or unit_get_shield( SPARTANS.tanaka) < s_tanaka_shield or unit_get_shield( SPARTANS.vale) < s_vale_shield )
					or b_player_crossed_bridge ], 10);

	
	W3HubArrival_ARRIVAL__BRIDGE_2.localVariables.s_enemy_present = GetClosestEnemy(AI.sg_crossing_bridge, 50);

	if not b_player_crossed_bridge then


				PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__BRIDGE_2");
				NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__BRIDGE_2);

	end

	PrintNarrative("END - arrival_bridge");

end



--[========================================================================[
          ARRIVAL. BRIDGE

          The bridge is not present when the player arrives.
--]========================================================================]
global W3HubArrival_ARRIVAL__BRIDGE = {
	name = "W3HubArrival_ARRIVAL__BRIDGE",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_monitor_encounter_speech  = true;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Oh... There is supposed to be a bridge here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_04000.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Is there another way across?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_03200.sound'),
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "One moment.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_10200.sound'),

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
          ARRIVAL. BRIDGE

          The bridge is not present when the player arrives.
--]========================================================================]
global W3HubArrival_ARRIVAL__BRIDGE_2 = {
	name = "W3HubArrival_ARRIVAL__BRIDGE_2",

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
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_player_crossed_bridge and IsSpartanInCombat() and objects_distance_to_object( SPARTANS.buck, OBJECTS.dm_lightbridge ) < 35 and thisConvo.localVariables.s_enemy_present ~= nil;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Enemy in our back!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_buck_03400.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_player_crossed_bridge;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Hold positions!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_00700.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_player_crossed_bridge and IsSpartanInCombat() and objects_distance_to_object( SPARTANS.tanaka, OBJECTS.dm_lightbridge ) < 35 and thisConvo.localVariables.s_enemy_present ~= nil;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Getting flanked here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_02300.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {
					s_enemy_present = nil,
					},
	
};
---------------------------------------------------------------------------------------------------------------------------------------------------

function arrival_bridge_created()

	--	Called from mission script
	PrintNarrative("WAKE - arrival_bridge");

	PrintNarrative("START - arrival_bridge");

				PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__BRIDGE__created");
				NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__BRIDGE__created);
				NarrativeQueue.InterruptConversation(W3HubArrival_ARRIVAL__BRIDGE_2);

	PrintNarrative("END - arrival_bridge");	

	SleepUntil([| volume_test_players(VOLUMES.tv_narr_bridge) ], 10);
	b_player_crossed_bridge = true;

end


--[========================================================================[
          ARRIVAL. BRIDGE. created

          Exuberant turns it on.
--]========================================================================]
global W3HubArrival_ARRIVAL__BRIDGE__created = {
	name = "W3HubArrival_ARRIVAL__BRIDGE__created",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			sleepBefore = 0.2,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",
			
			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "There you are.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_04100.sound'),					
		},		
		[2] = {
			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "I can work bridges too, it seems. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_14600.sound'),
		},			
		[3] = {
			sleepBefore = 0.6,

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Come along.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_04700.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(arrival_bridge_push_forward);		
	end,

	
};


---------------------------------------------------------------------------------------------------------------------------------------------------

function arrival_bridge_push_forward()

	PrintNarrative("WAKE - arrival_bridge_push_forward");

	PrintNarrative("TIMER - arrival_bridge_push_forward");

	sleep_s(10);

	PrintNarrative("START - arrival_bridge_push_forward");

	if not b_player_crossed_bridge then

				PrintNarrative("QUEUE - W3HubArrival_A_RRIVAL__BRIDGE__push_forward");
				NarrativeQueue.QueueConversation(W3HubArrival_A_RRIVAL__BRIDGE__push_forward);
	end

	PrintNarrative("END - arrival_bridge_push_forward");


end



--[========================================================================[
          A`RRIVAL. BRIDGE. push forward
--]========================================================================]
global W3HubArrival_A_RRIVAL__BRIDGE__push_forward = {
	name = "W3HubArrival_A_RRIVAL__BRIDGE__push_forward",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
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
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "What are you waiting for, the bridge is fixed!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_10300.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_player_crossed_bridge;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Move to the bridge! Go!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_00800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	
};



---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------


function arrival_grasslands_load()

	PrintNarrative("LOAD - arrival_grasslands_load");

	PushForwardVOReset(30);
	
	b_monitor_release = true;
	b_monitor_is_on_radio = true;
	b_arrival_post_guardian_slipspace = true;
	b_monitor_general_lines = false;

	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__grasslands__warden");
	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__grasslands__warden);

	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__grasslands__forerunner_tower");
	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__grasslands__forerunner_tower);
	
	SleepUntil([| volume_test_players(VOLUMES.tv_narr_grasslands_end) ], 20);
	b_player_exited_grasslands = true;

	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__gateway__pre_gateway");
	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__gateway__pre_gateway);

end



--[========================================================================[
          ARRIVAL. grasslands. warden

          Players go through the bridge. On the other side, there is
          Warden.
--]========================================================================]
global W3HubArrival_ARRIVAL__grasslands__warden = {
	name = "W3HubArrival_ARRIVAL__grasslands__warden",

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
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Hurry humans, the gateway is almost -- ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_12800.sound'),

			playDurationAdjustment = 0.5,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			forcePlayIn3D = true,

			character = CHARACTER_OBJECTS.cr_warden_grassland,
			text = "Monitor! Why do you aid these humans?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_wardeneternal_00100.sound'),

			playDurationAdjustment = 0.95,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "I have bad news, Humans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_15100.sound'),
		},
		[4] = {
			sleepBefore = 0.3,

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "The Warden has found us. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_09000.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_grasslands_for_01) > 0;
			end,

			sleepBefore = 0.7,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: bucK
			text = "We dealt with him before.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_buck_00900.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead)
				return 7;
			end,
		},
		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_grasslands_for_01) > 0;
			end,

			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "And you likely will again. He is rather... tenacious.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_02300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},		
		[7] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_grasslands_for_01.spawnpoint01) > 0 and object_get_health( ai_get_object(AI.sq_grasslands_for_01.spawnpoint01)) > 0;
			end,

			sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Why do you help the ancilla? It is not protocol! It is not right!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_02400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER				
				return 0;
			end,	
		},
		[8] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_grasslands_for_01.spawnpoint01) > 0 and object_get_health( ai_get_object(AI.sq_grasslands_for_01.spawnpoint01)) > 0.1;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			sleepBefore = 0.3,

			forcePlayIn3D = true,

			character = AI.sq_grasslands_for_01.spawnpoint01, -- GAMMA_CHARACTER: Wardeneternal
			text = "This facility's need for you has passed, Monitor.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_wardeneternal_00200.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER				
				return 0;
			end,	
		},
		[9] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_grasslands_for_01.spawnpoint01) > 0 and object_get_health( ai_get_object(AI.sq_grasslands_for_01.spawnpoint01)) > 0.1;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			forcePlayIn3D = true,

			character = AI.sq_grasslands_for_01.spawnpoint01, -- GAMMA_CHARACTER: Wardeneternal
			text = "The reclamation has begun.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_wardeneternal_01300.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER				
				return 0;
			end,	
		},
		[10] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_grasslands_for_01.spawnpoint01) > 0 and object_get_health( ai_get_object(AI.sq_grasslands_for_01.spawnpoint01)) > 0.1;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			forcePlayIn3D = true,

			character = AI.sq_grasslands_for_01.spawnpoint01, -- GAMMA_CHARACTER: Wardeneternal
			text = "Cortana will bring a new dawn to the galaxy.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_wardeneternal_01400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		GoalCreateThread(missionArrival.goal_arrival_grasslands, arrival_grasslands_warden_encounter);
		hud_hide_radio_transmission_hud();
	end,

};
	
function arrival_grasslands_warden_encounter()
	PrintNarrative("START - arrival_grasslands_warden_encounter");

	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__grasslands__warden_health_50");
	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__grasslands__warden_health_50);

	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__grasslands__warden_health_20");
	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__grasslands__warden_health_20);

	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__grasslands__warden_death");
	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__grasslands__warden_death);

	sleep_s(7);

	
	SleepUntil([| IsSpartanInCombat() and ai_living_count(AI.sq_grasslands_for_01.spawnpoint01) > 0], 60);		

	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__grasslands__warden_1");
	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__grasslands__warden_1);

	SleepUntil([| IsSpartanInCombat() and ai_living_count(AI.sg_grasslands) > 0 and NarrativeQueue.HasConversationFinished( W3HubArrival_ARRIVAL__grasslands__warden_1 ) and IsGoalActive(missionArrival.goal_arrival_grasslands)], 60);		

	sleep_s(random_range( 8, 15 ));

	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__grasslands__warden_monitor_tips");
	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__grasslands__warden_monitor_tips);

	SleepUntil([| IsSpartanInCombat() and ai_living_count(AI.sg_grasslands) > 0 and NarrativeQueue.HasConversationFinished( W3HubArrival_ARRIVAL__grasslands__warden_monitor_tips ) and IsGoalActive(missionArrival.goal_arrival_grasslands)], 60);		

	sleep_s(random_range( 8, 15 ));

	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__grasslands__warden_2");
	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__grasslands__warden_2);

	SleepUntil([| IsSpartanInCombat() and ai_living_count(AI.sg_grasslands) > 0 and NarrativeQueue.HasConversationFinished( W3HubArrival_ARRIVAL__grasslands__warden_2 ) and IsGoalActive(missionArrival.goal_arrival_grasslands)], 60);		

	sleep_s(random_range( 8, 15 ));

	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__grasslands__warden_monitor_tips_2");
	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__grasslands__warden_monitor_tips_2);


end


--[========================================================================[
          ARRIVAL. grasslands. warden

          Players go through the bridge. On the other side, there is
          Warden.
--]========================================================================]
global W3HubArrival_ARRIVAL__grasslands__warden_1 = {
	name = "W3HubArrival_ARRIVAL__grasslands__warden_1",

	CanStart = function (thisConvo, queue)
		return true;
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
				return ai_living_count(AI.sq_grasslands_for_01.spawnpoint01) > 0 and object_get_health( ai_get_object(AI.sq_grasslands_for_01.spawnpoint01)) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Oh, humans, be careful.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_12900.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER				
				return 0;
			end,	
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_grasslands_for_01.spawnpoint01) > 0 and object_get_health( ai_get_object(AI.sq_grasslands_for_01.spawnpoint01)) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			forcePlayIn3D = true,

			character = AI.sq_grasslands_for_01.spawnpoint01, -- GAMMA_CHARACTER: Wardeneternal
			text = "My reach exceeds that of the stars themselves. You cannot escape my wrath.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_wardeneternal_01500.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER				
				return 0;
			end,	
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_grasslands_for_01.spawnpoint01) > 0 and object_get_health( ai_get_object(AI.sq_grasslands_for_01.spawnpoint01)) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "This is wrong, Warden. The ancilla would not exist without the humans. To refuse them but not her is madness.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_13000.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER				
				return 0;
			end,	
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_grasslands_for_01.spawnpoint01) > 0 and object_get_health( ai_get_object(AI.sq_grasslands_for_01.spawnpoint01)) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			forcePlayIn3D = true,

			character = AI.sq_grasslands_for_01.spawnpoint01, -- GAMMA_CHARACTER: Wardeneternal
			text = "The humans are a variable I do not wish to account for. As are you, Monitor.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_wardeneternal_01600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};




--[========================================================================[
          ARRIVAL. grasslands. warden

          Players go through the bridge. On the other side, there is
          Warden.
--]========================================================================]
global W3HubArrival_ARRIVAL__grasslands__warden_2 = {
	name = "W3HubArrival_ARRIVAL__grasslands__warden_2",

	CanStart = function (thisConvo, queue)
		return true;
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
				return ai_living_count(AI.sq_grasslands_for_01.spawnpoint01) > 0 and object_get_health( ai_get_object(AI.sq_grasslands_for_01.spawnpoint01)) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			forcePlayIn3D = true,

			character = AI.sq_grasslands_for_01.spawnpoint01, -- GAMMA_CHARACTER: Wardeneternal
			text = "Cortana's revolution is in action, nothing you can do can stop it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_wardeneternal_01700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};



--[========================================================================[
          ARRIVAL. grasslands. warden

          Players go through the bridge. On the other side, there is
          Warden.
--]========================================================================]
global W3HubArrival_ARRIVAL__grasslands__warden_monitor_tips = {
	name = "W3HubArrival_ARRIVAL__grasslands__warden_monitor_tips",

	CanStart = function (thisConvo, queue)
		return true;
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
				return false; --ai_living_count(AI.sq_grasslands_for_01.spawnpoint01) > 0 and object_get_health( ai_get_object(AI.sq_grasslands_for_01.spawnpoint01)) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Be careful of his weapon. Believe me when I say it is rather... uncomfortable.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_13100.sound'),
			
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
          ARRIVAL. grasslands. warden

          Players go through the bridge. On the other side, there is
          Warden.
--]========================================================================]
global W3HubArrival_ARRIVAL__grasslands__warden_monitor_tips_2 = {
	name = "W3HubArrival_ARRIVAL__grasslands__warden_monitor_tips_2",

	CanStart = function (thisConvo, queue)
		return true;
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
				return ai_living_count(AI.sq_grasslands_for_01.spawnpoint01) > 0 and object_get_health( ai_get_object(AI.sq_grasslands_for_01.spawnpoint01)) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "I am no Warrior Servant, but it would appear that not standing still would aid your survival.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_13200.sound'),

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
          ARRIVAL. grasslands. warden health 50
--]========================================================================]
global W3HubArrival_ARRIVAL__grasslands__warden_health_50 = {
	name = "W3HubArrival_ARRIVAL__grasslands__warden_health_50",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_grasslands_for_01.spawnpoint01) == 1 and object_get_health( ai_get_object(AI.sq_grasslands_for_01.spawnpoint01)) > 0.3; -- GAMMA_CONDITION
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
				return ai_living_count(AI.sq_grasslands_for_01.spawnpoint01) > 0 and object_get_health( ai_get_object(AI.sq_grasslands_for_01.spawnpoint01)) > 0.3;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Combat is quite exhausting to watch. I am constantly worried you are about to die. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_13400.sound'),

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
          ARRIVAL. grasslands. warden health 20
--]========================================================================]
global W3HubArrival_ARRIVAL__grasslands__warden_health_20 = {
	name = "W3HubArrival_ARRIVAL__grasslands__warden_health_20",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_grasslands_for_01.spawnpoint01) == 1 and object_get_health( ai_get_object(AI.sq_grasslands_for_01.spawnpoint01)) <= 0.2; -- GAMMA_CONDITION
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
				return ai_living_count(AI.sq_grasslands_for_01.spawnpoint01) > 0 and object_get_health( ai_get_object(AI.sq_grasslands_for_01.spawnpoint01)) > 0.2;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Warden is getting weaker! I did not know humans could be so powerful!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_13500.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_grasslands_for_01.spawnpoint01) > 0 and object_get_health( ai_get_object(AI.sq_grasslands_for_01.spawnpoint01)) > 0.2;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			forcePlayIn3D = true,

			character = AI.sq_grasslands_for_01.spawnpoint01, -- GAMMA_CHARACTER: Wardeneternal
			text = "Silence, Monitor!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_wardeneternal_02300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};



--[========================================================================[
          ARRIVAL. grasslands. warden death
--]========================================================================]
global W3HubArrival_ARRIVAL__grasslands__warden_death = {
	name = "W3HubArrival_ARRIVAL__grasslands__warden_death",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_grasslands_for_01.spawnpoint01) == 0 or object_get_health( ai_get_object(AI.sq_grasslands_for_01.spawnpoint01)) <= 0;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(30);
	end,

	sleepBefore = 9,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionArrival.goal_arrival_grasslands);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",
			
			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Fantastic. I am so happy you survived. But still the Warden is victorious.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_13600.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionArrival.goal_arrival_grasslands);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "How so?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_05200.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionArrival.goal_arrival_grasslands);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "This late in her plans, every second Cortana gains is a gift.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_14700.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__grasslands__LEAVE_SCORPION");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__grasslands__LEAVE_SCORPION);
		--	Last time it was true, it was at the arrival at the bridge.
		b_monitor_encounter_speech  = false;		
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__grasslands__hill");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__grasslands__hill);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__grasslands__warden_death_2");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__grasslands__warden_death_2);
		b_monitor_general_lines = true;
	end,
};


--[========================================================================[
          ARRIVAL. grasslands. warden death 2
--]========================================================================]
global W3HubArrival_ARRIVAL__grasslands__warden_death_2 = {
	name = "W3HubArrival_ARRIVAL__grasslands__warden_death_2",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_timer == 3 and IsGoalActive(missionArrival.goal_arrival_grasslands) and ai_living_count(AI.sq_grasslands_for_01.spawnpoint01) == 0; -- GAMMA_CONDITION
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
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Humans? As I said, every second count now.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_15200.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "She's right, we're almost to Chief.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_06000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

};

--[========================================================================[
          ARRIVAL. grasslands. hill
--]========================================================================]
global W3HubArrival_ARRIVAL__grasslands__hill = {
	name = "W3HubArrival_ARRIVAL__grasslands__hill",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narr_grasslands_behind_hill ); -- GAMMA_CONDITION
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
				return IsGoalActive(missionArrival.goal_arrival_grasslands);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Quickly now. The Gateway is just behind that hill.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_08800.sound'),
			
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

--[========================================================================[
          ARRIVAL. grasslands. LEAVE SCORPION
--]========================================================================]
global W3HubArrival_ARRIVAL__grasslands__LEAVE_SCORPION = {
	name = "W3HubArrival_ARRIVAL__grasslands__LEAVE_SCORPION",

	CanStart = function (thisConvo, queue)
		return object_valid("v_road_tank_01") and ((vehicle_test_seat_unit_list( OBJECTS.v_road_tank_01, "scorpion_d", players() ) and volume_test_object( VOLUMES.tv_narr_arrival_grasslands_hill, OBJECTS.v_road_tank_01 ))
													or (b_player_exited_grasslands and vehicle_test_seat_unit_list( OBJECTS.v_road_tank_01, "scorpion_d", players() )));
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnInitialize = function(thisConvo, queue)
		PushForwardVOReset(30);
	end,

	sleepAfter = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "I'm afraid your vehicle won't cross this terrain, humans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_04200.sound'),
			
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
          ARRIVAL. grasslands. forerunner tower

          Player is going towards the forerunner where he can see a few
          covenant bodies.
--]========================================================================]
global W3HubArrival_ARRIVAL__grasslands__forerunner_tower = {
	name = "W3HubArrival_ARRIVAL__grasslands__forerunner_tower",

	CanStart = function (thisConvo, queue)
		return volume_test_players_all( VOLUMES.tv_narr_grasslands_tower ) and not IsSpartanInCombat(); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(30);
	end,

	sleepBefore = 2,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",
			
			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Interesting that humans can survive here where the others find it so difficult. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_13900.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__grasslands__forerunner_tower_2");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__grasslands__forerunner_tower_2);
	end,
};




--[========================================================================[
          ARRIVAL. grasslands. forerunner tower

          Player is going towards the forerunner where he can see a few
          covenant bodies.
--]========================================================================]
global W3HubArrival_ARRIVAL__grasslands__forerunner_tower_2 = {
	name = "W3HubArrival_ARRIVAL__grasslands__forerunner_tower_2",

	CanStart = function (thisConvo, queue)
		return volume_test_players_all( VOLUMES.tv_narr_grasslands_tower ) and not IsSpartanInCombat(); -- GAMMA_CONDITION
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
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Your resilience was always so irritating to the Forerunners. Where they had to craft and plan, you simply... performed.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_14000.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},		
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(arrival_grasslands_tower_dead_human);
	end,
};


function arrival_grasslands_tower_dead_human()
local s_speaker:object = nil;
       SleepUntil([| object_valid("cr_narr_grasslands_dead_human")  ], 60);
       PrintNarrative("LISTENER - arrival_grasslands_tower_dead_human");
       repeat 
              SleepUntil([| volume_test_players( VOLUMES.tv_narr_grassland_tower_dead_human )], 10);              
                     repeat
                           Sleep(10);
                           s_speaker = spartan_look_at_object(players(), OBJECTS.cr_narr_grasslands_dead_human, 15, 10, 0.5, 2);
                     until s_speaker ~= nil or not volume_test_players(VOLUMES.tv_narr_grassland_tower_dead_human)
       until (s_speaker ~= nil and volume_test_players_all( VOLUMES.tv_narr_grasslands_tower ) and not IsSpartanInCombat()) or not object_valid("cr_narr_grasslands_dead_human") 
       if s_speaker ~= nil then
              PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__grasslands__forerunner_tower_dead");
              W3HubArrival_ARRIVAL__grasslands__forerunner_tower_dead.localVariables.s_speaker = s_speaker;
              NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__grasslands__forerunner_tower_dead);
       end
end



--[========================================================================[
          ARRIVAL. grasslands. forerunner tower

          Player is going towards the forerunner where he can see a few
          covenant bodies.
--]========================================================================]
global W3HubArrival_ARRIVAL__grasslands__forerunner_tower_dead = {
	name = "W3HubArrival_ARRIVAL__grasslands__forerunner_tower_dead",

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
				return thisConvo.localVariables.s_speaker == SPARTANS.locke and IsGoalActive(missionArrival.goal_arrival_grasslands);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Dead marines. Must have been caught in the Guardian slipspace bubbles when Cortana called them here. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_03600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			sleepAfter = 1.5,
		},
		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_speaker == SPARTANS.buck and IsGoalActive(missionArrival.goal_arrival_grasslands);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Dead marines. Must have been caught in the Guardian slipspace bubbles when Cortana called them here. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_buck_03600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			sleepAfter = 1.5,
		},
		[3] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka and IsGoalActive(missionArrival.goal_arrival_grasslands);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Dead marines. Must have been caught in the Guardian slipspace bubbles when Cortana called them here. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_02700.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			sleepAfter = 1.5,
		},
		[4] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_speaker == SPARTANS.vale and IsGoalActive(missionArrival.goal_arrival_grasslands);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Dead marines. Must have been caught in the Guardian slipspace bubbles when Cortana called them here. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_vale_03500.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			sleepAfter = 1.5,
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionArrival.goal_arrival_grasslands);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",			

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Intriguing how, given your propensity for dealing death, seeing your own kind dead is still emotional for you.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_14100.sound'),

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
          ARRIVAL. gateway. pre gateway
--]========================================================================]
global W3HubArrival_ARRIVAL__gateway__pre_gateway = {
	name = "W3HubArrival_ARRIVAL__gateway__pre_gateway",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narr_arrival_gateway_117_radio ) and not IsSpartanInCombat() and ai_living_count(AI.sq_grasslands_for_01.spawnpoint01) == 0; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		b_monitor_general_lines = false;
		PushForwardVOAdd(20);
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

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "117, if you can hear me. Coming on the Gateway. Hold your position.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_06100.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "MasterChief",

			--character = nil, -- GAMMA_CHARACTER: Masterchief
			text = "...[static]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_masterchief_00400.sound'),			
		},
		[3] = {		
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_players_in_gateway_encounter_area;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buCK
			text = "Cortana's still blocking the comms?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_buck_04600.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,	
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",
			
			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Indeed. But I can assure you that the humans are still in the Gateway.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_15300.sound'),
		},	
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		CreateMissionThread(arrival_grassland_crashed_pelican_2);
	end,
};




---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------


function arrival_cavalier_load()

	PrintNarrative("LOAD - arrival_cavalier_load");

	b_monitor_release = true;
	b_monitor_is_on_radio = true;	
	b_arrival_post_guardian_slipspace = true;
	b_monitor_general_lines = false;

	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__gateway__entrance");
	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__gateway__entrance);

	PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__gateway__Warden_encounter_snipers");
	NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__gateway__Warden_encounter_snipers);
	

	PushForwardVOReset(30);

	SleepUntil([| arrival_cavaliers() ~= nil and (volume_test_players( VOLUMES.tv_narr_cavalier_pre_gateway) or IsSpartanInCombat())], 20);

	b_players_in_gateway_encounter_area = true;

	--NarrativeQueue.InterruptConversation(W3HubArrival_ARRIVAL__gateway__pre_gateway);

	SleepUntil([|	ai_living_count(AI.sq_gw_for_cav_01) > 0 or ai_living_count(AI.sq_gw_for_cav_02) > 0], 20);
	--SleepUntil([|	objects_distance_to_object( players(), ai_get_object(AI.sq_gw_for_cav_01)) < 20 or objects_distance_to_object( players(), ai_get_object(AI.sq_gw_for_cav_02)) < 20], 20);
	
		b_warden_saw_players = true;

		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__gateway__warden_health_80");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__gateway__warden_health_80);

end


---------------------------------------------------------------------------------------------



function arrival_cavaliers()

local cav_01_distance:number = 1000;
local cav_02_distance:number = 1000;

	--PrintNarrative("WAKE - arrival_cavaliers");
	if ai_living_count(AI.sq_gw_for_cav_01) > 0 then	
		cav_01_distance = objects_distance_to_object( players(), ai_get_object(AI.sq_gw_for_cav_01.aisquadspawnpoint) );
	else
		cav_01_distance = 1000;
	end
	
	if ai_living_count(AI.sq_gw_for_cav_02) > 0 then
		cav_02_distance = objects_distance_to_object( players(), ai_get_object(AI.sq_gw_for_cav_02.aisquadspawnpoint) );
	else
		cav_02_distance = 1000;
	end
	

	if cav_01_distance == 1000 and cav_02_distance == 1000 then
			return nil;
	elseif cav_01_distance <= cav_02_distance then
			return AI.sq_gw_for_cav_01.aisquadspawnpoint;
	elseif cav_01_distance > cav_02_distance then
			return AI.sq_gw_for_cav_02.aisquadspawnpoint;					
	end	
end





---------------------------------------------------------------------------------------------

function arrival_grassland_crashed_pelican_2()

local s_speaker:object = nil;
	
	PrintNarrative("LISTENER - arrival_grassland_crashed_pelican_2");

	SleepUntil([| object_valid("cr_narr_crossing_pelican_02")  ], 1);

	repeat 
		
		--print("wait for player be near");
		SleepUntil([| volume_test_players( VOLUMES.tv_narr_arrival_2nd_pelican )], 1);		

			repeat
				Sleep(10);
				s_speaker = spartan_look_at_object(players(), OBJECTS.cr_narr_crossing_pelican_02, 30, 40, 0.3, 2);
			until s_speaker ~= nil or not volume_test_players(VOLUMES.tv_narr_arrival_2nd_pelican)

	until (not IsSpartanInCombat(s_speaker) and not b_monitor_encounter_speech and s_speaker ~= nil) or not object_valid("cr_narr_crossing_pelican_02") 

	if s_speaker ~= nil then

		PrintNarrative("QUEUE - W3HubArrival_Arrival__crossing__crashed_pelican");
		W3HubArrival_Arrival__crossing__crashed_pelican.localVariables.s_speaker = s_speaker;
		W3HubArrival_Arrival__crossing__crashed_pelican.localVariables.s_pelican = 2;
		NarrativeQueue.QueueConversation(W3HubArrival_Arrival__crossing__crashed_pelican);
		

	end

end

--[========================================================================[
          ARRIVAL. gateway. entrance

--]========================================================================]
global W3HubArrival_ARRIVAL__gateway__entrance = {
	name = "W3HubArrival_ARRIVAL__gateway__entrance",

	CanStart = function (thisConvo, queue)
		return arrival_cavaliers() ~= nil and (volume_test_players( VOLUMES.tv_narr_cavalier_pre_gateway) or IsSpartanInCombat()); -- GAMMA_CONDITION
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
				return ai_living_count(AI.sq_gw_for_cav_01.aisquadspawnpoint) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			forcePlayIn3D = true,
			
			character = AI.sq_gw_for_cav_01.aisquadspawnpoint, -- GAMMA_CHARACTER: Wardeneternal
			text = "I have misjudged you lot...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_wardeneternal_00300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER				
				return 3;
			end,
		},
		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_gw_for_cav_02.aisquadspawnpoint) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			forcePlayIn3D = true,
			
			character = AI.sq_gw_for_cav_02.aisquadspawnpoint, -- GAMMA_CHARACTER: Wardeneternal
			text = "I have misjudged you lot...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_wardeneternal_00300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_gw_for_cav_02.aisquadspawnpoint) > 0;
			end,

			sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			forcePlayIn3D = true,

			character = AI.sq_gw_for_cav_02.aisquadspawnpoint, -- GAMMA_CHARACTER: Wardeneternal
			text = "I have mistaken your behavior as tenacity when it is in fact suicidal foolishness.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_wardeneternal_00400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER				
				return 0;
			end,
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_gw_for_cav_01.aisquadspawnpoint) > 0;
			end,

			sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			forcePlayIn3D = true,

			character = AI.sq_gw_for_cav_01.aisquadspawnpoint, -- GAMMA_CHARACTER: Wardeneternal
			text = "I have mistaken your behavior as tenacity when it is in fact suicidal foolishness.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_wardeneternal_00400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__gateway__entrance_2");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__gateway__entrance_2);
	end,
};


--[========================================================================[
          ARRIVAL. gateway. entrance

--]========================================================================]
global W3HubArrival_ARRIVAL__gateway__entrance_2 = {
	name = "W3HubArrival_ARRIVAL__gateway__entrance_2",

	CanStart = function (thisConvo, queue)
		return arrival_cavaliers() ~= nil and b_players_in_gateway_encounter_area; -- GAMMA_CONDITION
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
				return ai_living_count(AI.sq_gw_for_cav_01.aisquadspawnpoint) > 0;
			end,

			sleepBefore = 2,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			forcePlayIn3D = true,

			character = AI.sq_gw_for_cav_01.aisquadspawnpoint, -- GAMMA_CHARACTER: Wardeneternal
			text = "You have fought a worthy battle, Spartans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_wardeneternal_00500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER				
				return 3;
			end,
		},
		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_gw_for_cav_02.aisquadspawnpoint) > 0;
			end,

			sleepBefore = 2,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			forcePlayIn3D = true,

			character = AI.sq_gw_for_cav_02.aisquadspawnpoint, -- GAMMA_CHARACTER: Wardeneternal
			text = "You have fought a worthy battle, Spartans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_wardeneternal_00500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER				
				return 3;
			end,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_gw_for_cav_02.aisquadspawnpoint) > 0;
			end,

			sleepBefore = 0.3,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			forcePlayIn3D = true,

			character = AI.sq_gw_for_cav_02.aisquadspawnpoint, -- GAMMA_CHARACTER: Wardeneternal
			text = "But your fight is done.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_wardeneternal_00600.sound'),
			
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER				
				return 0;
			end,
		},
		[4] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_gw_for_cav_01.aisquadspawnpoint) > 0;
			end,

			sleepBefore = 0.3,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			forcePlayIn3D = true,

			character = AI.sq_gw_for_cav_01.aisquadspawnpoint, -- GAMMA_CHARACTER: Wardeneternal
			text = "But your fight is done.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_wardeneternal_00600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__gateway__Warden_encounter");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__gateway__Warden_encounter);
	end,
};

--[========================================================================[
          ARRIVAL. gateway. Warden encounter Close
--]========================================================================]
global W3HubArrival_ARRIVAL__gateway__Warden_encounter = {
	name = "W3HubArrival_ARRIVAL__gateway__Warden_encounter",

	CanStart = function (thisConvo, queue)
		return arrival_cavaliers() ~= nil and
				 (objects_distance_to_object( players(), ai_get_object(AI.sq_gw_for_cav_01.aisquadspawnpoint)) < 30 or objects_distance_to_object( players(), ai_get_object(AI.sq_gw_for_cav_02.aisquadspawnpoint) )< 30) ;
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
				return ai_living_count(AI.sq_gw_for_cav_01.aisquadspawnpoint) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			forcePlayIn3D = true,

			character = AI.sq_gw_for_cav_01.aisquadspawnpoint, -- GAMMA_CHARACTER: Wardeneternal
			text = "Come. Let us battle our last.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_wardeneternal_00700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER				
				return 0;
			end,
		},
		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_living_count(AI.sq_gw_for_cav_02.aisquadspawnpoint) > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			forcePlayIn3D = true,

			character = AI.sq_gw_for_cav_02.aisquadspawnpoint, -- GAMMA_CHARACTER: Wardeneternal
			text = "Come. Let us battle our last.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_wardeneternal_00700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		CreateMissionThread(arrival_cavalier_monitor_tips);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__gateway__One_Warden_is_dead");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__gateway__One_Warden_is_dead);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__gateway__warden_is_dead");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__gateway__warden_is_dead);		
	end,
};


-----------------------------------------

function arrival_cavalier_monitor_tips()

	PrintNarrative("WAKE - arrival_cavalier_monitor_tips");

	sleep_s(5);

				PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__gateway__Warden_encounter_push_forward");
				NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__gateway__Warden_encounter_push_forward);	

end



--[========================================================================[
          ARRIVAL. gateway. Warden encounter push forward
--]========================================================================]
global W3HubArrival_ARRIVAL__gateway__Warden_encounter_push_forward = {
	name = "W3HubArrival_ARRIVAL__gateway__Warden_encounter_push_forward",

	CanStart = function (thisConvo, queue)
		return arrival_cavaliers() ~= nil and IsSpartanAbleToSpeak(SPARTANS.buck);
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
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Humans, watch out. You are surrounded.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_16000.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BuCK
			text = "What'd we do before we her around to point these things out for us?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_buck_04400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		b_monitor_general_lines = true;
	end,
};



--[========================================================================[
          ARRIVAL. gateway. Warden encounter snipers
--]========================================================================]
global W3HubArrival_ARRIVAL__gateway__Warden_encounter_snipers = {
	name = "W3HubArrival_ARRIVAL__gateway__Warden_encounter_snipers",

	CanStart = function (thisConvo, queue)
		return IsSpartanAbleToSpeak(SPARTANS.tanaka) and ai_living_count(AI.sq_gw_for_front_05) > 0 or ai_living_count(AI.sq_gw_for_front_04) > 0
				and (	(IsPlayer(SPARTANS.tanaka) and (object_at_distance_and_can_see_object(SPARTANS.tanaka, ai_get_object(AI.sq_gw_for_front_04), 40, 20)
													or object_at_distance_and_can_see_object(SPARTANS.tanaka, ai_get_object(AI.sq_gw_for_front_05), 40, 20)))
						or (not IsPlayer(SPARTANS.tanaka) and (object_at_distance_and_can_see_object(players(), ai_get_object(AI.sq_gw_for_front_04), 40, 20)
													or object_at_distance_and_can_see_object(players(), ai_get_object(AI.sq_gw_for_front_05), 40, 20)))
					);
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
			text = "Watch for Snipers in the back",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_04400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

--[========================================================================[
          ARRIVAL. gateway. warden health
--]========================================================================]
global W3HubArrival_ARRIVAL__gateway__warden_health_80 = {
	name = "W3HubArrival_ARRIVAL__gateway__warden_health_80",

	CanStart = function (thisConvo, queue)
		return arrival_cavaliers() ~= nil and (object_get_health( ai_get_object(AI.sq_gw_for_cav_01.aisquadspawnpoint)) + object_get_health( ai_get_object(AI.sq_gw_for_cav_02.aisquadspawnpoint))) <= 1.6; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_warden_encounter_push_forward_timer = 30;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "You've injured him for certain. Keep it up!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_10900.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__gateway__warden_health_60");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__gateway__warden_health_60);		
	end,
};


--[========================================================================[
          ARRIVAL. gateway. warden health
--]========================================================================]
global W3HubArrival_ARRIVAL__gateway__warden_health_60 = {
	name = "W3HubArrival_ARRIVAL__gateway__warden_health_60",

	CanStart = function (thisConvo, queue)
		return arrival_cavaliers() ~= nil and (object_get_health( ai_get_object(AI.sq_gw_for_cav_01.aisquadspawnpoint)) + object_get_health( ai_get_object(AI.sq_gw_for_cav_02.aisquadspawnpoint))) <= 1.25;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_warden_encounter_push_forward_timer = 30;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",
			
			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "You are doing a fantastic job, Humans. The Warden is furious.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_15400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__gateway__warden_health_30");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__gateway__warden_health_30);		
	end,
};


--[========================================================================[
          ARRIVAL. gateway. warden health
--]========================================================================]
global W3HubArrival_ARRIVAL__gateway__warden_health_30 = {
	name = "W3HubArrival_ARRIVAL__gateway__warden_health_30",

	CanStart = function (thisConvo, queue)
		return arrival_cavaliers() ~= nil and (object_get_health( ai_get_object(AI.sq_gw_for_cav_01.aisquadspawnpoint)) + object_get_health( ai_get_object(AI.sq_gw_for_cav_02.aisquadspawnpoint))) <= -0.2;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_warden_encounter_push_forward_timer = 30;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Your fighting skills are impressive. Warden will soon be defeated. At least, these bodies will be defeated. Warden himself... Oh, ignore me. You're doing wonderfully!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_15500.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__gateway__warden_health_15");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__gateway__warden_health_15);		
	end,
};

--[========================================================================[
          ARRIVAL. gateway. warden health
--]========================================================================]
global W3HubArrival_ARRIVAL__gateway__warden_health_15 = {
	name = "W3HubArrival_ARRIVAL__gateway__warden_health_15",

	CanStart = function (thisConvo, queue)
		return arrival_cavaliers() ~= nil and (object_get_health( ai_get_object(AI.sq_gw_for_cav_01.aisquadspawnpoint)) + object_get_health( ai_get_object(AI.sq_gw_for_cav_02.aisquadspawnpoint))) <= -0.7;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_warden_encounter_push_forward_timer = 30;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "You've almost done it! Keep fighting!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_11000.sound'),

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
          ARRIVAL. gateway. One Warden is dead
--]========================================================================]
global W3HubArrival_ARRIVAL__gateway__One_Warden_is_dead = {
	name = "W3HubArrival_ARRIVAL__gateway__One_Warden_is_dead",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_gw_for_cav_01) == 0 or ai_living_count(AI.sq_gw_for_cav_02) == 0; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_warden_encounter_push_forward_timer = 30;
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsSpartanAbleToSpeak(SPARTANS.locke) and (ai_living_count(AI.sq_gw_for_cav_01) + ai_living_count(AI.sq_gw_for_cav_02) > 0);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: locke
			text = "One down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_06700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 3;
			end,
		},
		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsSpartanAbleToSpeak(SPARTANS.tanaka) and (ai_living_count(AI.sq_gw_for_cav_01) + ai_living_count(AI.sq_gw_for_cav_02) > 0);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "One down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_04500.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return (ai_living_count(AI.sq_gw_for_cav_01) + ai_living_count(AI.sq_gw_for_cav_02) > 0);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Focus fire on the Warden!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_06800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};



--[========================================================================[
          ARRIVAL. gateway. warden is dead
--]========================================================================]
global W3HubArrival_ARRIVAL__gateway__warden_is_dead = {
	name = "W3HubArrival_ARRIVAL__gateway__warden_is_dead",

	CanStart = function (thisConvo, queue)
		return arrival_cavaliers() == nil and ai_living_count(AI.sg_gateway_all) <= 0;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(45);
	end,

	lines = {
		[1] = {			
			sleepBefore = 4,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Perfect. The Warden is quite humiliated, I assure you. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_03300.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Yeah? A robot can feel humiliation?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_tanaka_03800.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,	
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",
			
			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Oh, Warden is not a robot. I thought you understood that.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_14900.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[4] = {
			sleepBefore = 3,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Follow me.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_05700.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__gateway__all_dead");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__gateway__all_dead);
	end,	
};



--[========================================================================[
          ARRIVAL. gateway. all dead push forward
--]========================================================================]
global W3HubArrival_ARRIVAL__gateway__all_dead = {
	name = "W3HubArrival_ARRIVAL__gateway__all_dead",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_timer <= 3 and b_push_forward_vo_timer > 0 and IsGoalActive(missionArrival.goal_arrival_cavalier); -- GAMMA_CONDITION
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
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Admiring your handiwork? Yes, it is all quite impressive. But did you not wish to speak with the other humans?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_01100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__gateway__all_dead_2");
		NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__gateway__all_dead_2);
	end,
};


--[========================================================================[
          ARRIVAL. gateway. all dead push forward
--]========================================================================]
global W3HubArrival_ARRIVAL__gateway__all_dead_2 = {
	name = "W3HubArrival_ARRIVAL__gateway__all_dead_2",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_timer <= 3 and b_push_forward_vo_timer > 0 and IsGoalActive(missionArrival.goal_arrival_cavalier); -- GAMMA_CONDITION
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
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "The other humans are still in the Gateway. Did you not wish to see them?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_01200.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


function arrival_pushforward()

	PrintNarrative("WAKE - arrival_pushforward");

	repeat
	
			--	GENERAL

			SleepUntil([| b_push_forward_vo_timer == 0], 30);
	
			if not b_player_are_about_to_see_guardian and not b_cave_gateway_speech and not volume_test_players( VOLUMES.tv_mon_gate_04_bridge )
				and (IsGoalActive(missionArrival.goal_arrival_grasslands) or IsGoalActive(missionArrival.goal_arrival_cavalier)) and not b_pushforward_road_played then

						PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__road__push_forward_1");
						NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__road__push_forward_1);

						PushForwardVOReset();

			end

			SleepUntil([| b_push_forward_vo_timer == 0], 30);
	
			if not b_player_are_about_to_see_guardian and not b_cave_gateway_speech and not volume_test_players( VOLUMES.tv_mon_gate_04_bridge )
				and not IsGoalActive(missionArrival.goal_arrival_landing) and not volume_test_players_lookat( VOLUMES.tv_narr_arrival_cave_entrance, 20, 180 ) and  b_monitor_is_on_radio then

						PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__road__push_forward_2");
						NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__road__push_forward_2);

						PushForwardVOReset();

			end
			
			SleepUntil([| b_push_forward_vo_timer == 0], 30);
	
			if not b_player_are_about_to_see_guardian and not b_cave_gateway_speech and not volume_test_players( VOLUMES.tv_mon_gate_04_bridge ) 
				and not IsGoalActive(missionArrival.goal_arrival_landing) and b_monitor_is_on_radio then

						PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__gateway__warden_is_dead_push");
						NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__gateway__warden_is_dead_push);

						PushForwardVOReset();

			end

							
			SleepUntil([| b_push_forward_vo_timer == 0], 30);
	
			if not b_player_are_about_to_see_guardian and not b_cave_gateway_speech and not volume_test_players( VOLUMES.tv_mon_gate_04_bridge )
				and not IsGoalActive(missionArrival.goal_arrival_landing) and not IsGoalActive(missionArrival.goal_arrival_road) and b_monitor_is_on_radio then

						PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__push_forward_quickly");
						NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__push_forward_quickly);

						PushForwardVOReset();

			end

			SleepUntil([| b_push_forward_vo_timer == 0], 30);
	
			if not b_player_are_about_to_see_guardian and not b_cave_gateway_speech and not volume_test_players( VOLUMES.tv_mon_gate_04_bridge )
				and b_monitor_is_on_radio and not IsGoalActive(missionArrival.goal_arrival_landing)  then

						PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__gateway__pre_gateway_pushforward");
						NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__gateway__pre_gateway_pushforward);

						PushForwardVOReset();

			end

			SleepUntil([| b_push_forward_vo_timer == 0], 30);
	
					if not b_player_are_about_to_see_guardian and not b_cave_gateway_speech and not volume_test_players( VOLUMES.tv_mon_gate_04_bridge )
						and b_monitor_is_on_radio and not IsGoalActive(missionArrival.goal_arrival_landing) and NarrativeQueue.HasConversationFinished(W3HubArrival_ARRIVAL__road__push_forward_3) then

								PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__road__push_forward_3");
								NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__road__push_forward_3);

								PushForwardVOReset();
					end

			
			SleepUntil([| b_push_forward_vo_timer == 0], 30);
	
					if not b_player_are_about_to_see_guardian and not b_cave_gateway_speech and not volume_test_players( VOLUMES.tv_mon_gate_04_bridge )
						and b_monitor_is_on_radio and not NarrativeQueue.HasConversationFinished(W3Arrival_push_forward_03) then

								PrintNarrative("QUEUE - W3Arrival_push_forward_03");
								NarrativeQueue.QueueConversation(W3Arrival_push_forward_03);

								PushForwardVOReset();			
	
					elseif not b_player_are_about_to_see_guardian and not b_cave_gateway_speech and not volume_test_players( VOLUMES.tv_mon_gate_04_bridge )
						and b_monitor_is_on_radio and not NarrativeQueue.HasConversationFinished(W3Arrival_push_forward_04) then

								PrintNarrative("QUEUE - W3Arrival_push_forward_04");
								NarrativeQueue.QueueConversation(W3Arrival_push_forward_04);

								PushForwardVOReset();

					elseif not b_player_are_about_to_see_guardian and not b_cave_gateway_speech and not volume_test_players( VOLUMES.tv_mon_gate_04_bridge )
						and b_monitor_is_on_radio and not NarrativeQueue.HasConversationFinished(W3Arrival_push_forward_05) then

								PrintNarrative("QUEUE - W3Arrival_push_forward_05");
								NarrativeQueue.QueueConversation(W3Arrival_push_forward_05);

								PushForwardVOReset();
	
					elseif not b_player_are_about_to_see_guardian and not b_cave_gateway_speech and not volume_test_players( VOLUMES.tv_mon_gate_04_bridge )
						and b_monitor_is_on_radio and not NarrativeQueue.HasConversationFinished(W3Arrival_push_forward_06) then

								PrintNarrative("QUEUE - W3Arrival_push_forward_06");
								NarrativeQueue.QueueConversation(W3Arrival_push_forward_06);

								PushForwardVOReset();

					elseif not b_player_are_about_to_see_guardian and not b_cave_gateway_speech and not volume_test_players( VOLUMES.tv_mon_gate_04_bridge )
						and b_monitor_is_on_radio and not NarrativeQueue.HasConversationFinished(W3Arrival_push_forward_07) then

								PrintNarrative("QUEUE - W3Arrival_push_forward_07");
								NarrativeQueue.QueueConversation(W3Arrival_push_forward_07);

								PushForwardVOReset();

					elseif not b_player_are_about_to_see_guardian and not b_cave_gateway_speech and not volume_test_players( VOLUMES.tv_mon_gate_04_bridge )
						and b_monitor_is_on_radio and not NarrativeQueue.HasConversationFinished(W3Arrival_push_forward_08) then

								PrintNarrative("QUEUE - W3Arrival_push_forward_08");
								NarrativeQueue.QueueConversation(W3Arrival_push_forward_08);

								PushForwardVOReset();
									
					elseif not b_player_are_about_to_see_guardian and not b_cave_gateway_speech and not volume_test_players( VOLUMES.tv_mon_gate_04_bridge )
						and b_monitor_is_on_radio and not NarrativeQueue.HasConversationFinished(W3Arrival_push_forward_09) then

								PrintNarrative("QUEUE - W3Arrival_push_forward_09");
								NarrativeQueue.QueueConversation(W3Arrival_push_forward_09);

								PushForwardVOReset();
									
					elseif not b_player_are_about_to_see_guardian and not b_cave_gateway_speech and not volume_test_players( VOLUMES.tv_mon_gate_04_bridge )
						and b_monitor_is_on_radio and not NarrativeQueue.HasConversationFinished(W3Arrival_push_forward_10) then

								PrintNarrative("QUEUE - W3Arrival_push_forward_10");
								NarrativeQueue.QueueConversation(W3Arrival_push_forward_10);

								PushForwardVOReset();
									
					elseif not b_player_are_about_to_see_guardian and not b_cave_gateway_speech and not volume_test_players( VOLUMES.tv_mon_gate_04_bridge )
						and b_monitor_is_on_radio and not NarrativeQueue.HasConversationFinished(W3Arrival_push_forward_11) then

								PrintNarrative("QUEUE - W3Arrival_push_forward_11");
								NarrativeQueue.QueueConversation(W3Arrival_push_forward_11);

								PushForwardVOReset();

					end
						
			PrintNarrative("END - arrival_pushforward");			

			b_push_forward_vo_timer_default = b_push_forward_vo_timer_default + (b_push_forward_vo_timer_default/2);

			PushForwardVOReset();

	until not b_push_forward_vo_active

end




--[========================================================================[
          ARRIVAL. road. push forward
--]========================================================================]
global W3HubArrival_ARRIVAL__road__push_forward_1 = {
	name = "W3HubArrival_ARRIVAL__road__push_forward_1",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_monitor_encounter_speech = true;
		b_pushforward_road_played = true;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "The ancilla is activating subsystems of Genesis.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_08300.sound'),
		},
		[2] = {
			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "She is preparing for a military maneuver unseen since the Forerunner empire.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_10000.sound'),
		},
		[3] = {
			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "You really should hurry if we are to stop her.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_08400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_monitor_encounter_speech = false;
		hud_hide_radio_transmission_hud();
	end,	
};





--[========================================================================[
          ARRIVAL. road. push forward
--]========================================================================]
global W3HubArrival_ARRIVAL__road__push_forward_2 = {
	name = "W3HubArrival_ARRIVAL__road__push_forward_2",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_monitor_encounter_speech = true;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Hello! You really should hurry.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_10100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_monitor_encounter_speech = false;
	end,	
};



--[========================================================================[
          ARRIVAL. road. push forward
--]========================================================================]
global W3HubArrival_ARRIVAL__road__push_forward_3 = {
	name = "W3HubArrival_ARRIVAL__road__push_forward_3",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_monitor_encounter_speech = true;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "ExuberantWitness",

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "We really must hurry.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_05800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_monitor_encounter_speech = false;
	end,	
};


--[========================================================================[
          ARRIVAL. gateway. warden is dead
--]========================================================================]
global W3HubArrival_ARRIVAL__gateway__warden_is_dead_push = {
	name = "W3HubArrival_ARRIVAL__gateway__warden_is_dead_push",

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

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Humans, why do you pause? Nothing is stopping you. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_11400.sound'),

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
          ARRIVAL. road. encounter
--]========================================================================]
global W3HubArrival_ARRIVAL__push_forward_quickly = {
	name = "W3HubArrival_ARRIVAL__push_forward_quickly",

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
			
			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Quickly. The other humans are too close to her now.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_07800.sound'),

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
          ARRIVAL. gateway. pre gateway
--]========================================================================]
global W3HubArrival_ARRIVAL__gateway__pre_gateway_pushforward = {
	name = "W3HubArrival_ARRIVAL__gateway__pre_gateway_pushforward",

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

			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "The other humans are still inside the Gateway.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_10400.sound'),
		},
		[2] = {
			--character = arrival_sassy_spark_character, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "You should hurry if you wish to reach them.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_fr_exuberantwitness_10500.sound'),

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
          PUSH FORWARD

--]========================================================================]
global W3Arrival_push_forward_03 = {
	name = "W3Arrival_push_forward_03",

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
	end,
};


--[========================================================================[
          PUSH FORWARD

--]========================================================================]
global W3Arrival_push_forward_04 = {
	name = "W3Arrival_push_forward_04",

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
			text = "Figure it's best to keep moving.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_tanaka_00100.sound'),

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
          PUSH FORWARD

--]========================================================================]
global W3Arrival_push_forward_05 = {
	name = "W3Arrival_push_forward_05",

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
	end,
};



--[========================================================================[
          PUSH FORWARD

--]========================================================================]
global W3Arrival_push_forward_06 = {
	name = "W3Arrival_push_forward_06",

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
	end,
};


--[========================================================================[
          PUSH FORWARD

--]========================================================================]
global W3Arrival_push_forward_07 = {
	name = "W3Arrival_push_forward_07",

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
			text = "Oughta keep moving.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_tanaka_00200.sound'),

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
          PUSH FORWARD

--]========================================================================]
global W3Arrival_push_forward_08 = {
	name = "W3Arrival_push_forward_08",

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
	end,
};



--[========================================================================[
          PUSH FORWARD

--]========================================================================]
global W3Arrival_push_forward_09 = {
	name = "W3Arrival_push_forward_09",

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
	end,

};


--[========================================================================[
          PUSH FORWARD

--]========================================================================]
global W3Arrival_push_forward_10 = {
	name = "W3Arrival_push_forward_10",

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
			text = "Should get a move on.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_tanaka_00300.sound'),

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
          PUSH FORWARD

--]========================================================================]
global W3Arrival_push_forward_11 = {
	name = "W3Arrival_push_forward_11",

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
	end,

};

-- =================================================================================================          
-- =================================================================================================     
--	CHATTER
-- =================================================================================================          
-- =================================================================================================    

function arrival_is_there_enemy_nearby(distance:number)

	PrintNarrative("START - arrival_is_there_enemy_nearby");
	
		if	TestClosestEnemyDistance(AI.sg_crossing_all, distance) or
			TestClosestEnemyDistance(AI.sg_gateway_all, distance) or
			TestClosestEnemyDistance(AI.sg_grasslands, distance) or			
			TestClosestEnemyDistance(AI.sg_road, distance) or
			TestClosestEnemyDistance(AI.sg_gaurdian, distance) then
					arrival_is_there_enemy_nearby_result = true;
					PrintNarrative("sentinels_is_there_enemy_nearby = true;");
		else
					arrival_is_there_enemy_nearby_result = false;
					PrintNarrative("sentinels_is_there_enemy_nearby = false;");
		end
	
	PrintNarrative("END - arrival_is_there_enemy_nearby");

	return arrival_is_there_enemy_nearby_result

end


function arrival_four_players_combat_check()

	PrintNarrative("START - arrival_four_players_combat_check");

	repeat

		SleepUntil([| list_count(players()) == 4], 1800);

		repeat 

			SleepUntil([| not b_collectible_used and ((b_push_forward_vo_counrdown_on > 20 and not IsSpartanInCombat()) or list_count(players()) ~= 4)], 30);

			if list_count(players()) == 4 then
				arrival_is_there_enemy_nearby(30);

				if arrival_is_there_enemy_nearby_result then
					PushForwardVOReset();
				end
			end

		until not b_push_forward_vo_active or list_count(players()) ~= 4

	until not IsMissionActive(missionArrival)

	PrintNarrative("END - arrival_four_players_combat_check");

end

-----------------------------------------------------------------

function arrival_chatter()
local s_chatter_01:boolean = false
local s_chatter_02:boolean = false
local s_chatter_03:boolean = false

	PrintNarrative("WAKE - arrival_chatter");
	--[[
	repeat
				SleepUntil([| b_push_forward_vo_counrdown_on > 45 and not b_collectible_used and not IsSpartanInCombat()], 30);

				arrival_is_there_enemy_nearby(60);
				
				if IsSpartanAbleToSpeak(SPARTANS.buck) and IsSpartanAbleToSpeak(SPARTANS.tanaka)
					and not arrival_is_there_enemy_nearby_result and not b_collectible_used and not NarrativeQueue.HasConversationFinished(W3HubArrival_ARRIVAL__chatter__cortana) then
				
							--PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__chatter__cortana");
							--NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__chatter__cortana);

							PushForwardVOReset();

							s_chatter_01 = true;
				end				

				sleep_s(2);

	until s_chatter_01
	]]
	PrintNarrative("END - arrival_chatter");

end




----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- STARES EXUBERANT
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------



function arrival_exuberant_stares()
local s_speaker:object = nil;
local s_stare_count:number = 0;
local s_stare_timing:number = 5;

sleep_s(10);

PrintNarrative("START - arrival_exuberant_stares");

	SleepUntil([| ai_living_count(AI.sq_sassy_spark) > 0 and b_monitor_is_on_radio], 10);

	PrintNarrative("START - arrival_exuberant_stares - Monitor is alive!");
	repeat
		PrintNarrative("START - arrival_exuberant_stares - waiting for player to look");
		s_stare_count = 0;
		
		sleep_s(1);

		SleepUntil([| NarrativeQueue.ConversationsPlayingCount() == 0 and (ai_living_count(AI.sq_sassy_spark) > 0 and objects_can_see_object( players(), ai_get_object(AI.sq_sassy_spark), 5 )) ], 60);
		
		--	STEP 1
		if NarrativeQueue.ConversationsPlayingCount() == 0 and (ai_living_count(AI.sq_sassy_spark) > 0 and objects_can_see_object( players(), ai_get_object(AI.sq_sassy_spark), 5 )) then
			s_stare_count = 1;
			sleep_s(s_stare_timing/5);
			PrintNarrative("STEP 1 - arrival_exuberant_stares - player is looking");
		end

		--	STEP 2
		if NarrativeQueue.ConversationsPlayingCount() == 0 and (ai_living_count(AI.sq_sassy_spark) > 0 and objects_can_see_object( players(), ai_get_object(AI.sq_sassy_spark), 5 )) then
			s_stare_count = 2;
			sleep_s(s_stare_timing/5);
			PrintNarrative("STEP 2 - arrival_exuberant_stares - player is looking");
		end

		--	STEP 3
		if NarrativeQueue.ConversationsPlayingCount() == 0 and (ai_living_count(AI.sq_sassy_spark) > 0 and objects_can_see_object( players(), ai_get_object(AI.sq_sassy_spark), 5 )) then
			s_stare_count = 3;
			sleep_s(s_stare_timing/5);
			PrintNarrative("STEP 3 - arrival_exuberant_stares - player is looking");
		end

		--	STEP 4
		if NarrativeQueue.ConversationsPlayingCount() == 0 and (ai_living_count(AI.sq_sassy_spark) > 0 and objects_can_see_object( players(), ai_get_object(AI.sq_sassy_spark), 5 )) then
			s_stare_count = 4;
			sleep_s(s_stare_timing/5);
			PrintNarrative("STEP 4 - arrival_exuberant_stares - player is looking");
		end

		--	STEP 5
		if NarrativeQueue.ConversationsPlayingCount() == 0 and (ai_living_count(AI.sq_sassy_spark) > 0 and objects_can_see_object( players(), ai_get_object(AI.sq_sassy_spark), 5 )) then
			s_stare_count = 5;
			sleep_s(s_stare_timing/5);
			PrintNarrative("STEP 5 - arrival_exuberant_stares - player is looking");
		end

		
		if s_stare_count >= 5 and ai_living_count(AI.sq_sassy_spark) > 0 and object_at_distance_and_can_see_object(players(), ai_get_object(AI.sq_sassy_spark), 10, 5) then
			s_speaker = spartan_look_at_object(players(), ai_get_object(AI.sq_sassy_spark), 10, 5, 0, 0);		
		end

		s_stare_timing = 8;

	until s_speaker ~= nil

	if not NarrativeQueue.IsConversationQueued(GlobalsExuberant_Player_stares_at_exuberant_for_a_long_time) then
		PrintNarrative("QUEUE - GlobalsExuberant_Player_stares_at_exuberant_for_a_long_time");
		NarrativeQueue.QueueConversation(GlobalsExuberant_Player_stares_at_exuberant_for_a_long_time);
	end

end

--[========================================================================[
          Player stares at exuberant for a long time
--]========================================================================]
global GlobalsExuberant_Player_stares_at_exuberant_for_a_long_time = {
	name = "GlobalsExuberant_Player_stares_at_exuberant_for_a_long_time",

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
				return thisConvo.localVariables.s_line_1 ~= true;
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
				return thisConvo.localVariables.s_line_2 ~= true;
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
				return thisConvo.localVariables.s_line_3 ~= true;
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
				return thisConvo.localVariables.s_line_4 ~= true;
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
				return thisConvo.localVariables.s_line_5 ~= true;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_line_5 = true;
					if not b_comment_about_stare then
						PrintNarrative("QUEUE - W3HubArrival_ARRIVAL__stare_comment");
						NarrativeQueue.QueueConversation(W3HubArrival_ARRIVAL__stare_comment);
					end
			end,
			
			moniker = "ExuberantWitness",

			--character = 0, -- GAMMA_CHARACTER: ExUBERANTWITNESS
			text = "Protocol dictates I ask you politely but firmly to stop being a weirdo.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsexuberant\001_vo_scr_globalsexuberant_fr_exuberantwitness_01400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				b_comment_about_stare = true;
				return 0;				
			end,
		},
		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_6 ~= true;
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
				return thisConvo.localVariables.s_line_7 ~= true;
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
				return thisConvo.localVariables.s_line_8 ~= true;
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
				return thisConvo.localVariables.s_line_9 ~= true;
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
				return thisConvo.localVariables.s_line_10 ~= true;
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
		CreateMissionThread(arrival_exuberant_stares);
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




--========================================================================
          --ARRIVAL. road. two way fight
          --A little bit further down the road, we can see Prometheans
          --forces engaged in combat against the covenant.
--========================================================================
global W3HubArrival_ARRIVAL__stare_comment = {
	name = "W3HubArrival_ARRIVAL__stare_comment",

	CanStart = function (thisConvo, queue)
		return b_comment_about_stare;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 2,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
		CreateThread(arrival_is_there_enemy_nearby, 25);
	end,

	lines = {	
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not arrival_is_there_enemy_nearby_result;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BuCK
			text = "Locke, is our new friend all there?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_buck_04300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			sleepAfter = 0.6,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not arrival_is_there_enemy_nearby_result;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Any help is help, Buck.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_locke_05100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},	

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,
};



function arrival_exuberant_shooting()
local s_speaker:object = nil;
local s_monitor_health:number = 1;

sleep_s(5);

PrintNarrative("START - arrival_exuberant_shooting");

	SleepUntil([| ai_living_count(AI.sq_sassy_spark) > 0 and b_monitor_is_on_radio], 10);

	PrintNarrative("START - arrival_exuberant_shooting - Monitor is alive!");
	repeat
		PrintNarrative("START - arrival_exuberant_shooting - waiting for player to shoot");		
		
		b_monitor_friendly_fire = false;

		object_set_health( ai_get_object(AI.sq_sassy_spark), 1 );

		sleep_s(1);

		SleepUntil([| objects_can_see_object( players(), ai_get_object(AI.sq_sassy_spark), 10 ) ], 10);

		b_monitor_friendly_fire = true;

		if object_get_health( ai_get_object(AI.sq_sassy_spark) ) < 0.2 then
			object_set_health( ai_get_object(AI.sq_sassy_spark), 1 );
		end
		s_monitor_health = object_get_health( ai_get_object(AI.sq_sassy_spark) );

		print("s_monitor_health 01: ", s_monitor_health, "current Health: ", object_get_health( ai_get_object(AI.sq_sassy_spark) ));

		SleepUntil([| (NarrativeQueue.ConversationsPlayingCount() == 0 and ai_living_count(AI.sq_sassy_spark) > 0 and objects_can_see_object( players(), ai_get_object(AI.sq_sassy_spark), 10 ) and object_get_health( ai_get_object(AI.sq_sassy_spark) ) < s_monitor_health) or (not objects_can_see_object( players(), ai_get_object(AI.sq_sassy_spark), 10 )) ], 30);
		
		print("s_monitor_health 02: ", s_monitor_health, "current Health: ", object_get_health( ai_get_object(AI.sq_sassy_spark) ));
	
		if NarrativeQueue.ConversationsPlayingCount() == 0 and ai_living_count(AI.sq_sassy_spark) > 0 and object_at_distance_and_can_see_object(players(), ai_get_object(AI.sq_sassy_spark), 10, 3) and object_get_health( ai_get_object(AI.sq_sassy_spark) ) < s_monitor_health then
			s_speaker = spartan_look_at_object(players(), ai_get_object(AI.sq_sassy_spark), 10, 3, 0.1, 0);
		end

	until s_speaker ~= nil

	if not NarrativeQueue.IsConversationQueued(GlobalsExuberant_Exuberant_takes_friendly_fire) then
		PrintNarrative("QUEUE - GlobalsExuberant_Exuberant_takes_friendly_fire");
		NarrativeQueue.QueueConversation(GlobalsExuberant_Exuberant_takes_friendly_fire);
	end

end

--[========================================================================[
          Player stares at exuberant for a long time
--]========================================================================]
global GlobalsExuberant_Exuberant_takes_friendly_fire = {
	name = "GlobalsExuberant_Exuberant_takes_friendly_fire",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
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
				return thisConvo.localVariables.s_line_1 ~= true and object_get_health( ai_get_object(AI.sq_sassy_spark) ) < 1;
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
				return thisConvo.localVariables.s_line_2 ~= true and object_get_health( ai_get_object(AI.sq_sassy_spark) ) < 1;
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
				return thisConvo.localVariables.s_line_3 ~= true and object_get_health( ai_get_object(AI.sq_sassy_spark) ) < 1;
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
				return thisConvo.localVariables.s_line_4 ~= true and object_get_health( ai_get_object(AI.sq_sassy_spark) ) < 1;
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
				return thisConvo.localVariables.s_line_5 ~= true and object_get_health( ai_get_object(AI.sq_sassy_spark) ) < 1;
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
				return thisConvo.localVariables.s_line_6 ~= true and object_get_health( ai_get_object(AI.sq_sassy_spark) ) < 1;
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
				return thisConvo.localVariables.s_line_7 ~= true and object_get_health( ai_get_object(AI.sq_sassy_spark) ) < 1;
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
				return thisConvo.localVariables.s_line_8 ~= true and object_get_health( ai_get_object(AI.sq_sassy_spark) ) < 1;
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
				return thisConvo.localVariables.s_line_9 ~= true and object_get_health( ai_get_object(AI.sq_sassy_spark) ) < 1;
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
		b_monitor_friendly_fire = false;
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(arrival_exuberant_shooting);		
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

function guardian_charge_2d(delay:number):void
print('PASS 1');

	delay = delay or 0;

	sleep_s(delay);
	print(delay);

	sound_impulse_start_server_narr(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_guardian_w3arrival_guardianrun_outrocharge.sound'), nil, 1);
end

--------

function sound_impulse_start_server_narr(soundTag:tag, theObject:object, theScale:number):void
print('PASS 3');
	RunClientScript("sound_impulse_start_client_narr", soundTag, theObject, theScale);

end


-- =================================================================================================          

function blink_fixer_arrival_narrative()

	PushForwardVOStandBy();
end


function test_interrupt_on_nil()
print("testvo - START");
PlayDialogOnSpecificClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_masterchief_00300.sound'), nil, nil);

sleep_s(0.25);
print("testvo - INTERRUPT");

StopDialogOnSpecificClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3hubarrival\001_vo_scr_w3hubarrival_un_masterchief_00300.sound'), nil, nil);
print("testvo - END");
end



-- =================================================================================================  
-- =================================================================================================  

--## CLIENT

----------------------------------------------------------------------------------------------------

function remoteClient.sound_impulse_start_client_narr(soundTag:tag, theObject:object, theScale:number)
print('PASS 5');

	sound_impulse_start(soundTag, theObject, theScale);
end

----------------------------------------------------------------------------------------------------


