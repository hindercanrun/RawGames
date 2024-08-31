--## SERVER

-- =====================================================================================================================================
--  _____  _            _______ ______         _    _     _   _          _____  _____         _______ _______      ________ 
-- |  __ \| |        /\|__   __|  ____|   /\  | |  | |   | \ | |   /\   |  __ \|  __ \     /\|__   __|_   _\ \    / /  ____|
-- | |__) | |       /  \  | |  | |__     /  \ | |  | |   |  \| |  /  \  | |__) | |__) |   /  \  | |    | |  \ \  / /| |__   
-- |  ___/| |      / /\ \ | |  |  __|   / /\ \| |  | |   | . ` | / /\ \ |  _  /|  _  /   / /\ \ | |    | |   \ \/ / |  __|  
-- | |    | |____ / ____ \| |  | |____ / ____ \ |__| |   | |\  |/ ____ \| | \ \| | \ \  / ____ \| |   _| |_   \  /  | |____ 
-- |_|    |______/_/    \_\_|  |______/_/    \_\____/    |_| \_/_/    \_\_|  \_\_|  \_\/_/    \_\_|  |_____|   \/   |______|
--
-- =====================================================================================================================================                                                                                                                          
                                                                                   
																				                                         
-- =================================================================================================
-- *** GLOBALS ***
-- =================================================================================================

	global g_screentext_plateau_stub:thread = nil;

	global b_sentry_horn_1:boolean=false;
	global b_sentry_horn_2:boolean=false;

	global b_sentry_is_rising:boolean=false;
	global b_sentry_has_risen:boolean=false;
	global b_critical_dialogue_on:boolean=false;
	global b_arbiter_is_attacking:boolean=false;
	
	
	global b_hollow_player_saw_shield_gen:boolean=false;
	global b_hollow_player_saw_shield:boolean=false;
	global b_hollow_shield_is_down:boolean=false;
	global b_hollow_shield_killer:object=nil;

	global b_bowl_who_saw_the_plasma_battery:object=nil;
	global b_bowl_player_saw_the_shield:boolean=false;
	global b_bowl_player_behind_the_shield:boolean=false;
	global b_bowl_palmer_proceed_with_mission:boolean=false;
	
	global b_bowl_player_came_from_breakable_wall:boolean=false;

	global b_player_saw_mechanism:boolean=false;
	global b_vale_talked_about_murals:boolean=false;
	global n_mural_looked_at:number=0;

	global b_vtols_are_present:boolean=false;
	
	global b_locke_on_board_sentry_ship:boolean=false;
	global b_tanaka_on_board_sentry_ship:boolean=false;
	global b_vale_on_board_sentry_ship:boolean=false;
	global b_buck_on_board_sentry_ship:boolean=false;

	global b_player_saw_the_kraken_core:boolean=false;
	global b_player_destroyed_the_kraken_core:boolean=false;

	global b_locke_heard_enemy_panicking:boolean=false;
	
	global b_player_in_vtol1:boolean=false;
	global b_player_in_vtol2:boolean=false;
	global b_player_in_vtol1b:boolean=false;
	global b_player_in_vtol2b:boolean=false;
		
	global b_constructor_activator:object=nil;

	global b_player_near_dropdown_grunts:boolean=false;

	global b_arbiter_chatter_commence:boolean=false;

	global b_arbiter_banshee_crash:boolean=false;
	
	global b_ramp_kraken_going_away:boolean=false;

	global b_vale_described_the_murals:boolean=false;

	global b_mural_left_translate:boolean=false;
	global b_mural_right_translate:boolean=false;

	global b_plateau_getting_constructor:boolean=false;

	global b_kraken_destroyed_cheering:boolean=false;

	global b_player_entered_bowl:boolean=false;
	
	global b_locke_looked_at_mural:boolean=false;
	global b_buck_looked_at_mural:boolean=false;
	global b_tanaka_looked_at_mural:boolean=false;
	global b_vale_looked_at_mural:boolean=false;
	
	global b_temple_mural_listener:boolean=true;

	global b_kraken_going_down:boolean = false;
	
	global b_kraken_reveal_banshee_crash:boolean = false;

	global b_temple_activated:boolean = false;
		
	global plateau_is_there_enemy_nearby_result:boolean = false;
	
	global b_chatter_is_permitted:boolean = true;
	
	global b_ramp_player_saw_kraken:boolean = false;
	
	global b_reveal_horn:boolean = false;
	
	global b_kraken_destroyed_end:boolean = false;
	
	global b_temple_switch_has_been_pinged:boolean = false;
	
	global b_soldier_switch_has_been_pinged:boolean = false;

	global b_bowl_plasma_battery_enabled:boolean = false;
	
	global b_kraken_foot_post_impact:boolean = false;

	global b_kraken_flying_away:boolean = false;

	global b_kraken_in_ramp:boolean = false;
	
	global b_plateau_constructor_sounds:boolean = false;
	
	

-- =================================================================================================
-- *** MAIN ***
-- =================================================================================================



function plateau_narrative_startup()
	
	print("*************  PLATEAU NARRATIVE LOADED ******************");
	g_display_narrative_debug_info = true;

	PrintNarrative("Killing Narrative Queue");
	NarrativeQueue.Kill();

	SleepUntil([| list_count(players()) ~= 0], 10);

	b_push_forward_vo_timer_default = 60;

	--	Force display Temp Text from TTS (Subtitles)
	--	dialog_line_temp_blurb_force_set(true);

	CreateMissionThread(plateau_pushforward);
	CreateMissionThread(PushForwardVO);
	CreateMissionThread(PushForwardVOStandBy);
	CreateMissionThread(plateau_chatter);
	CreateMissionThread(plateau_four_players_combat_check);

end



-- =================================================================================================          
-- =================================================================================================     
--		TEMP TEXT SCREEN - START AND END MISSION
-- =================================================================================================          
-- =================================================================================================     

--[[
function textscreen_plateau_start()

			print("SCREENTEXT STUB TSUNAMI START : START");

			local NumberOfLines:number = 5;
			local StartScreenTextDisplayTime:number = 16;

			CreateThread(ShowTempTextNarrativeUR, "Osiris recovered a Constructor in Plateau.", 20 , -1);	--	16
						
			sleep_s(StartScreenTextDisplayTime/NumberOfLines);	--	4

						
			CreateThread(ShowTempTextNarrativeUR, "While Arbiter is getting his troops ready to attack Sunaion, Halsey is reconfiguring the Construtor.", 20 , 0); --	12
						
			sleep_s(StartScreenTextDisplayTime/NumberOfLines);	--	4

						
			CreateThread(ShowTempTextNarrativeUR, "The Constructor suddenly flies in direction of Suanion. Time to leave!", 20 , 1);	--	8

			sleep_s(StartScreenTextDisplayTime/NumberOfLines);	--	4


			CreateThread(ShowTempTextNarrativeUR, "Osiris leaves with Arbiter on a Lich. Arbiter troops are gathering at Sunaion for a major attack.", 20 , 2);	--	4
	
			sleep_s(StartScreenTextDisplayTime/NumberOfLines);

			CreateThread(ShowTempTextNarrativeUR, "Arbiter and Osiris decides to board Sunaion on foot, while the cruiser are attacking the station.", 20 , 3);	--	4
	
			sleep_s(StartScreenTextDisplayTime/NumberOfLines);
			
			print("SCREENTEXT STUB TSUNAMI START : END");

end
]]

-- =================================================================================================
--  __  __ _____  _____ _____ _____ ____  _   _    _____ _______       _____ _______ 
-- |  \/  |_   _|/ ____/ ____|_   _/ __ \| \ | |  / ____|__   __|/\   |  __ \__   __|
-- | \  / | | | | (___| (___   | || |  | |  \| | | (___    | |  /  \  | |__) | | |   
-- | |\/| | | |  \___ \\___ \  | || |  | | . ` |  \___ \   | | / /\ \ |  _  /  | |   
-- | |  | |_| |_ ____) |___) |_| || |__| | |\  |  ____) |  | |/ ____ \| | \ \  | |   
-- |_|  |_|_____|_____/_____/|_____\____/|_| \_| |_____/   |_/_/    \_\_|  \_\ |_|   
--                              
-- =================================================================================================

--PLATEAU. PELICAN RIDE. PALMER BRIEFING


function plateau_breach_load()

	PrintNarrative("LOAD - plateau_breach_load");

		CreateMissionThread(plateau_dropdown_briefing);	

end

---------------------------------------------------------------------------------------------------------------------------------------------------

function plateau_dropdown_briefing()

	PrintNarrative("WAKE - plateau_dropdown_briefing");

	sleep_s(2.5);

	if IsGoalActive(missionPlateau.goal_Breach) then

			PrintNarrative("START - plateau_dropdown_briefing");

			PrintNarrative("QUEUE - W2HubPlateau_Plateau__breach__briefing");
			NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__breach__briefing);

			SleepUntil([| NarrativeQueue.HasConversationFinished(W2HubPlateau_Plateau__breach__briefing)], 30);
				
	end	

	PrintNarrative("END - plateau_dropdown_briefing");

	sleep_s(2);

	--	OBJECTIVE TEXT
	print("objective_text_goal_cave");
	CreateThread(objective_text_goal_caves);
	
	sleep_s(6);

	CreateMissionThread(plateau_breach_arbiter_battle_net);	

end


--[========================================================================[
          Plateau. breach. briefing
--]========================================================================]
global W2HubPlateau_Plateau__breach__briefing = {
	name = "W2HubPlateau_Plateau__breach__briefing",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
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
			
			moniker = "SarahPalmer",

			--character = 0, -- GAMMA_CHARACTER: Palmer
			text = "Osiris, Halsey's Constructor is in a Forerunner facility north of here, but the Covies have a Kraken parked between you and it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_palmer_00100.sound'),

			sleepAfter = 0.5,
		},
		[2] = {

			--character = 0, -- GAMMA_CHARACTER: Palmer
			text = "Arbiter's people are set to hit the Kraken from the air while you handle ground support.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_palmer_00500.sound'),

			sleepAfter = 0.5,
		},
		[3] = {
			--character = 0, -- GAMMA_CHARACTER: Palmer
			text = "Once you've reached the rally point, Arbiter give the green light.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_palmer_01100.sound'),

			sleepAfter = 0.7,
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Understood, Commander.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_04300.sound'),

			sleepAfter = 0.6,
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "SarahPalmer",

			--character = 0, -- GAMMA_CHARACTER: Palmer
			text = "Patching you into Arbiter's battle net now. Good luck out there, Spartans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_palmer_00600.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PushForwardVOReset(50);
	end,
};



---------------------------------------------------------------------------------------------------------------------------------------------------


function plateau_breach_arbiter_battle_net()

PrintNarrative("START - plateau_breach_arbiter_battle_net");

	PrintNarrative("QUEUE - W2HubPlateau_Plateau__breach__arbiter_radio_1");
	NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__breach__arbiter_radio_1);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_Plateau__breach__arbiter_radio_1 )
				and not b_collectible_used and (not b_player_near_dropdown_grunts or (b_player_near_dropdown_grunts and ai_living_count(AI.sq_ward_scouts) == 0) ) and (IsGoalActive(missionPlateau.goal_Breach) or IsGoalActive(missionPlateau.goal_Caves) ) and not IsSpartanInCombat() ], 10);

	sleep_s(1);

	PrintNarrative("QUEUE - W2HubPlateau_Plateau__breach__arbiter_radio_1b");
	NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__breach__arbiter_radio_1b);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_Plateau__breach__arbiter_radio_1b )
				and not b_collectible_used and (not b_player_near_dropdown_grunts or (b_player_near_dropdown_grunts and ai_living_count(AI.sq_ward_scouts) == 0) ) and (IsGoalActive(missionPlateau.goal_Breach) or IsGoalActive(missionPlateau.goal_Caves) ) and not IsSpartanInCombat() ], 10);

	PrintNarrative("QUEUE - W2HubPlateau_Plateau__breach__arbiter_radio_2");
	NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__breach__arbiter_radio_2);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_Plateau__breach__arbiter_radio_2 )
				and not b_collectible_used and (not b_player_near_dropdown_grunts or (b_player_near_dropdown_grunts and ai_living_count(AI.sq_ward_scouts) == 0) ) and (IsGoalActive(missionPlateau.goal_Breach) or IsGoalActive(missionPlateau.goal_Caves) ) and not IsSpartanInCombat() ], 10);
	
	PrintNarrative("QUEUE - W2HubPlateau_Plateau__breach__arbiter_radio_3");
	NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__breach__arbiter_radio_3);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_Plateau__breach__arbiter_radio_3 )
				and not b_collectible_used and (not b_player_near_dropdown_grunts or (b_player_near_dropdown_grunts and ai_living_count(AI.sq_ward_scouts) == 0) ) and (IsGoalActive(missionPlateau.goal_Breach) or IsGoalActive(missionPlateau.goal_Caves)) and not IsSpartanInCombat() ], 10);

	PrintNarrative("QUEUE - W2HubPlateau_Plateau__breach__arbiter_radio_4");
	NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__breach__arbiter_radio_4);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_Plateau__breach__arbiter_radio_4 ) 
					and not b_collectible_used and (not b_player_near_dropdown_grunts or (b_player_near_dropdown_grunts and ai_living_count(AI.sq_ward_scouts) == 0) ) and (IsGoalActive(missionPlateau.goal_Breach) or IsGoalActive(missionPlateau.goal_Caves) ) and not IsSpartanInCombat() ], 10);

	PrintNarrative("QUEUE - W2HubPlateau_Plateau__breach__arbiter_radio_5");
	NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__breach__arbiter_radio_5);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_Plateau__breach__arbiter_radio_5 )
				and not b_collectible_used and (not b_player_near_dropdown_grunts or (b_player_near_dropdown_grunts and ai_living_count(AI.sq_ward_scouts) == 0) ) and (IsGoalActive(missionPlateau.goal_Breach) or IsGoalActive(missionPlateau.goal_Caves)  ) and not IsSpartanInCombat() ], 10);

	PrintNarrative("QUEUE - W2HubPlateau_Plateau__breach__arbiter_radio_6");
	NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__breach__arbiter_radio_6);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_Plateau__breach__arbiter_radio_6 )], 10);
end




--[========================================================================[
          Plateau. breach. arbiter radio
--]========================================================================]
global W2HubPlateau_Plateau__breach__arbiter_radio_1 = {
	name = "W2HubPlateau_Plateau__breach__arbiter_radio_1",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {	
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionPlateau.goal_Breach) or IsGoalActive(missionPlateau.goal_Caves);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "FlightLeader",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "... Sanghelios, visual on Kraken. Stand by.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend01_01500.sound'),
			
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
          Plateau. breach. arbiter radio
--]========================================================================]
global W2HubPlateau_Plateau__breach__arbiter_radio_1b = {
	name = "W2HubPlateau_Plateau__breach__arbiter_radio_1b",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOAdd(3);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "FlightLeader",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "All wings report.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend01_00100.sound'),
			
			playDurationAdjustment = 0.9,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	hud_hide_radio_transmission_hud();
	end,

	
};



--[========================================================================[
          Plateau. breach. arbiter radio
--]========================================================================]
global W2HubPlateau_Plateau__breach__arbiter_radio_2 = {
	name = "W2HubPlateau_Plateau__breach__arbiter_radio_2",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOAdd(3);
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingSiqtarOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend02
			text = "Attack wing Siqtar in position.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend02_00100.sound'),

			playDurationAdjustment = 0.9,
		},

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	hud_hide_radio_transmission_hud();
	end,

	
};


--[========================================================================[
          Plateau. breach. arbiter radio
--]========================================================================]
global W2HubPlateau_Plateau__breach__arbiter_radio_3 = {
	name = "W2HubPlateau_Plateau__breach__arbiter_radio_3",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOAdd(3);
	end,

	lines = {
		
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingLarOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend03
			text = "Attack wing Lar in position.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend03_00100.sound'),

			playDurationAdjustment = 0.8,
		},

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	
};


--[========================================================================[
          Plateau. breach. arbiter radio
--]========================================================================]
global W2HubPlateau_Plateau__breach__arbiter_radio_4 = {
	name = "W2HubPlateau_Plateau__breach__arbiter_radio_4",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOAdd(3);
	end,

	lines = {
		
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingJardamOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend04
			text = "Attack wing Jardam in position",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend04_00900.sound'),

			playDurationAdjustment = 0.8,
		},
		
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	hud_hide_radio_transmission_hud();
	end,

	
};


--[========================================================================[
          Plateau. breach. arbiter radio
--]========================================================================]
global W2HubPlateau_Plateau__breach__arbiter_radio_5 = {
	name = "W2HubPlateau_Plateau__breach__arbiter_radio_5",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOAdd(3);
	end,

	lines = {
		
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "FlightLeader",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "All wings hold here until Arbiter signals our attack run.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend01_00200.sound'),

			playDurationAdjustment = 1,
		},

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

	
};


--[========================================================================[
          Plateau. breach. arbiter radio
--]========================================================================]
global W2HubPlateau_Plateau__breach__arbiter_radio_6 = {
	name = "W2HubPlateau_Plateau__breach__arbiter_radio_6",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOAdd(3);
	end,

	lines = {
		
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingSiqtarOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend02
			text = "Confirmed. Holding steady. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend02_00200.sound'),

			playDurationAdjustment = 0.9,
		},

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};


-- =================================================================================================
--  _____  _____   ____  _____  _____   ______          ___   _ 
-- |  __ \|  __ \ / __ \|  __ \|  __ \ / __ \ \        / / \ | |
-- | |  | | |__) | |  | | |__) | |  | | |  | \ \  /\  / /|  \| |
-- | |  | |  _  /| |  | |  ___/| |  | | |  | |\ \/  \/ / | . ` |
-- | |__| | | \ \| |__| | |    | |__| | |__| | \  /\  /  | |\  |
-- |_____/|_|  \_\\____/|_|    |_____/ \____/   \/  \/   |_| \_|
--                                                              
-- =================================================================================================


----------------------------------------------------------------------------------------------------

function plateau_dropdown_load()

	PrintNarrative("LOAD - plateau_dropdown_load");

		--CreateThread(plateau_dropdown_3_grunts);
		PrintNarrative("QUEUE - W2HubPlateau_Plateau__dropdown__3_grunts");
		NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__dropdown__3_grunts);
		--CreateThread(plateau_dropdown_osiris_pre_encounter);
		PrintNarrative("QUEUE - W2HubPlateau_Plateau__dropdown__osiris_pre_encounter");
		NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__dropdown__osiris_pre_encounter);

		CreateMissionThread(plateau_dropdown_arbiter_battle_net);

		PushForwardVOReset();

end

---------------------------------------------------------------------------------------------------------------------------------------------------



function plateau_dropdown_arbiter_battle_net()

PrintNarrative("START - plateau_dropdown_arbiter_battle_net");

	SleepUntil([| b_player_near_dropdown_grunts], 10);

	SleepUntil([| ai_living_count(AI.sq_ward_scouts) == 0 and ai_combat_status(AI.sq_ward_vanguard) < 4 and b_push_forward_vo_timer > 3 and b_push_forward_vo_timer <= 50], 10);

	SleepUntil([| (( not b_collectible_used and IsGoalActive(missionPlateau.goal_SentryShipEncounter) or ai_living_count(AI.sq_ward_scouts) == 0) ) and (IsGoalActive(missionPlateau.goal_Breach) or IsGoalActive(missionPlateau.goal_Caves) or IsGoalActive(missionPlateau.goal_SentryShipEncounter) ) and ai_combat_status(AI.sq_ward_vanguard) < 4 and b_push_forward_vo_timer > 3 and b_push_forward_vo_timer <= 55 and not b_arbiter_is_attacking and not b_critical_dialogue_on], 10);

	PrintNarrative("QUEUE - W2HubPlateau_Plateau__breach__arbiter_radio_8");
	NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__breach__arbiter_radio_8);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_Plateau__breach__arbiter_radio_8 ) 
					and (( not b_collectible_used and IsGoalActive(missionPlateau.goal_SentryShipEncounter) or ai_living_count(AI.sq_ward_scouts) == 0) ) and (IsGoalActive(missionPlateau.goal_Breach) or IsGoalActive(missionPlateau.goal_Caves) or IsGoalActive(missionPlateau.goal_SentryShipEncounter) ) and ai_combat_status(AI.sq_ward_vanguard) < 4 and b_push_forward_vo_timer > 3 and b_push_forward_vo_timer <= 55 and not b_arbiter_is_attacking and not b_critical_dialogue_on], 10);

	PrintNarrative("QUEUE - W2HubPlateau_Plateau__breach__arbiter_radio_9");
	NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__breach__arbiter_radio_9);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_Plateau__breach__arbiter_radio_9 )], 10);

	sleep_s(5);

	SleepUntil([| (( not b_collectible_used and IsGoalActive(missionPlateau.goal_SentryShipEncounter) or ai_living_count(AI.sq_ward_scouts) == 0) ) and (IsGoalActive(missionPlateau.goal_Breach) or IsGoalActive(missionPlateau.goal_Caves) or IsGoalActive(missionPlateau.goal_SentryShipEncounter) ) and ai_combat_status(AI.sq_ward_vanguard) < 4 and b_push_forward_vo_timer > 3 and b_push_forward_vo_timer <= 55 and not b_arbiter_is_attacking and not b_critical_dialogue_on], 10);
	
	PrintNarrative("QUEUE - W2HubPlateau_Plateau__breach__arbiter_radio_7");
	NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__breach__arbiter_radio_7);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_Plateau__breach__arbiter_radio_7 ) 
					and (( not b_collectible_used and IsGoalActive(missionPlateau.goal_SentryShipEncounter) or ai_living_count(AI.sq_ward_scouts) == 0) ) and (IsGoalActive(missionPlateau.goal_Breach) or IsGoalActive(missionPlateau.goal_Caves) or IsGoalActive(missionPlateau.goal_SentryShipEncounter) ) and ai_combat_status(AI.sq_ward_vanguard) < 4 and b_push_forward_vo_timer > 3 and b_push_forward_vo_timer <= 55 and not b_arbiter_is_attacking and not b_critical_dialogue_on], 10);

	PrintNarrative("QUEUE - W2HubPlateau_Plateau__breach__arbiter_radio_10");
	NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__breach__arbiter_radio_10);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_Plateau__breach__arbiter_radio_10 ) ], 10);
		
	sleep_s(7);

	SleepUntil([| (( not b_collectible_used and IsGoalActive(missionPlateau.goal_SentryShipEncounter) or ai_living_count(AI.sq_ward_scouts) == 0) ) and (IsGoalActive(missionPlateau.goal_Breach) or IsGoalActive(missionPlateau.goal_Caves) or IsGoalActive(missionPlateau.goal_SentryShipEncounter) ) and ai_combat_status(AI.sq_ward_vanguard) < 4 and b_push_forward_vo_timer > 3 and b_push_forward_vo_timer <= 55 and not b_arbiter_is_attacking and not b_critical_dialogue_on], 10);

	PrintNarrative("QUEUE - W2HubPlateau_Plateau__breach__arbiter_radio_11");
	NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__breach__arbiter_radio_11);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_Plateau__breach__arbiter_radio_11 ) 
					and ((not b_collectible_used and IsGoalActive(missionPlateau.goal_SentryShipEncounter) or ai_living_count(AI.sq_ward_scouts) == 0) ) and (IsGoalActive(missionPlateau.goal_Breach) or IsGoalActive(missionPlateau.goal_Caves) or IsGoalActive(missionPlateau.goal_SentryShipEncounter) ) and ai_combat_status(AI.sq_ward_vanguard) < 4 and b_push_forward_vo_timer > 3 and b_push_forward_vo_timer <= 55 and not b_arbiter_is_attacking and not b_critical_dialogue_on], 10);

	PrintNarrative("QUEUE - W2HubPlateau_Plateau__breach__arbiter_radio_12");
	NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__breach__arbiter_radio_12);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_Plateau__breach__arbiter_radio_12 ) 
					and ((not b_collectible_used and IsGoalActive(missionPlateau.goal_SentryShipEncounter) or ai_living_count(AI.sq_ward_scouts) == 0) ) and (IsGoalActive(missionPlateau.goal_Breach) or IsGoalActive(missionPlateau.goal_Caves) or IsGoalActive(missionPlateau.goal_SentryShipEncounter) ) and ai_combat_status(AI.sq_ward_vanguard) < 4 and b_push_forward_vo_timer > 3 and b_push_forward_vo_timer <= 55 and not b_arbiter_is_attacking and not b_critical_dialogue_on], 10);

	PrintNarrative("QUEUE - W2HubPlateau_Plateau__breach__arbiter_radio_13");
	NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__breach__arbiter_radio_13);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_Plateau__breach__arbiter_radio_13 ) 
					and ((not b_collectible_used and IsGoalActive(missionPlateau.goal_SentryShipEncounter) or ai_living_count(AI.sq_ward_scouts) == 0) ) and (IsGoalActive(missionPlateau.goal_Breach) or IsGoalActive(missionPlateau.goal_Caves) or IsGoalActive(missionPlateau.goal_SentryShipEncounter) ) and ai_combat_status(AI.sq_ward_vanguard) < 4 and b_push_forward_vo_timer > 3 and b_push_forward_vo_timer <= 55 and not b_arbiter_is_attacking and not b_critical_dialogue_on], 10);

	PrintNarrative("QUEUE - W2HubPlateau_Plateau__breach__arbiter_radio_14");
	NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__breach__arbiter_radio_14);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_Plateau__breach__arbiter_radio_14 ) 
					and ((not b_collectible_used and IsGoalActive(missionPlateau.goal_SentryShipEncounter) or ai_living_count(AI.sq_ward_scouts) == 0) ) and (IsGoalActive(missionPlateau.goal_Breach) or IsGoalActive(missionPlateau.goal_Caves) or IsGoalActive(missionPlateau.goal_SentryShipEncounter) ) and ai_combat_status(AI.sq_ward_vanguard) < 4 and b_push_forward_vo_timer > 3 and b_push_forward_vo_timer <= 55 and not b_arbiter_is_attacking and not b_critical_dialogue_on], 10);

end


-- **************************************************

--[========================================================================[
          Plateau. breach. arbiter radio
--]========================================================================]
global W2HubPlateau_Plateau__breach__arbiter_radio_7 = {
	name = "W2HubPlateau_Plateau__breach__arbiter_radio_7",

	CanStart = function (thisConvo, queue)
		return (( IsGoalActive(missionPlateau.goal_SentryShipEncounter) or ai_living_count(AI.sq_ward_scouts) == 0) ) and (IsGoalActive(missionPlateau.goal_Breach) or IsGoalActive(missionPlateau.goal_Caves) or IsGoalActive(missionPlateau.goal_SentryShipEncounter) ) and b_push_forward_vo_timer > 3 and b_push_forward_vo_timer <= 20 and not b_arbiter_is_attacking and not b_critical_dialogue_on; -- GAMMA_CONDITION
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
			
			moniker = "WingLarOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend03
			text = "Siqtar Three, pull up to match Five's altitude.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend03_00200.sound'),

			--playDurationAdjustment = 0.9,
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
          Plateau. breach. arbiter radio
--]========================================================================]
global W2HubPlateau_Plateau__breach__arbiter_radio_8 = {
	name = "W2HubPlateau_Plateau__breach__arbiter_radio_8",

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
			
			moniker = "WingJardamOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend04
			text = "Status on Kraken?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend04_00100.sound'),

			--playDurationAdjustment = 0.9,
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
          Plateau. breach. arbiter radio
--]========================================================================]
global W2HubPlateau_Plateau__breach__arbiter_radio_9 = {
	name = "W2HubPlateau_Plateau__breach__arbiter_radio_9",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOAdd(5);
	end,

	lines = {
		
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "FlightLeader",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "Covenant forces are is as yet unaware of our presence. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend01_00300.sound'),
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
          Plateau. breach. arbiter radio
--]========================================================================]
global W2HubPlateau_Plateau__breach__arbiter_radio_10 = {
	name = "W2HubPlateau_Plateau__breach__arbiter_radio_10",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOAdd(5);
	end,

	lines = {
		
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingSiqtarOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend02
			text = "Flight Leader, Phantoms have been spotted on Kraken deck. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend02_00400.sound'),
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
          Plateau. breach. arbiter radio
--]========================================================================]
global W2HubPlateau_Plateau__breach__arbiter_radio_11 = {
	name = "W2HubPlateau_Plateau__breach__arbiter_radio_11",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOAdd(5);
	end,

	lines = {
		
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingLarOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend03
			text = "All wings, final weapons check.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend03_00300.sound'),
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
          Plateau. breach. arbiter radio
--]========================================================================]
global W2HubPlateau_Plateau__breach__arbiter_radio_12 = {
	name = "W2HubPlateau_Plateau__breach__arbiter_radio_12",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOAdd(2);
	end,

	lines = {
		
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingJardamOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend04
			text = "Plasma genrators operating at full.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend04_00200.sound'),
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
          Plateau. breach. arbiter radio
--]========================================================================]
global W2HubPlateau_Plateau__breach__arbiter_radio_13 = {
	name = "W2HubPlateau_Plateau__breach__arbiter_radio_13",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOAdd(2);
	end,

	lines = {
		
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingLarTwo",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "Flight Leader, I am experiencing a power fluctuation. Compensating.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend01_00400.sound'),
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
          Plateau. breach. arbiter radio
--]========================================================================]
global W2HubPlateau_Plateau__breach__arbiter_radio_14 = {
	name = "W2HubPlateau_Plateau__breach__arbiter_radio_14",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOAdd(2);
	end,

	lines = {
		
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingSiqtarOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend02
			text = "Weapons at full power. We are prepared.\r\n\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend02_00500.sound'),
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
          Plateau. dropdown. 3 grunts
--]========================================================================]
global W2HubPlateau_Plateau__dropdown__3_grunts = {
	name = "W2HubPlateau_Plateau__dropdown__3_grunts",

	CanStart = function (thisConvo, queue)
		return  ai_living_count(AI.sq_ward_scouts) > 1 and volume_test_players( VOLUMES.tv_narrative_plateau_dropdown_grunts_vo_start );
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC;
	end,

	OnStart = function (thisConvo, queue)
		b_player_near_dropdown_grunts = true;
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(90);
		CreateMissionThread(PLATEAU__dropdown__3_grunts_interrupt_grunt_01);
		--AIDialogManager.EnableAIDialog();
		AIDialogManager.DisableAIDialog(AI.sq_ward_scouts);
	end,

	

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_combat_status( AI.sq_ward_scouts ) < 4;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			character = AI.sq_ward_scouts.spawn_points_0, -- GAMMA_CHARACTER: Grunt01
			text = "We should be attacking the Arbiter right now. You know he sent the humans to kill Jul 'Mdama, right?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt01_00900.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_combat_status( AI.sq_ward_scouts ) < 4;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			character = AI.sq_ward_scouts.spawn_points_2, -- GAMMA_CHARACTER: Grunt02
			text = "The Arbiter ordered that?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_02500.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_combat_status( AI.sq_ward_scouts ) < 4;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			character = AI.sq_ward_scouts.spawn_points_0, -- GAMMA_CHARACTER: Grunt01
			text = "The humans do whatever the Arbiter says now! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt01_01600.sound'),
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_combat_status( AI.sq_ward_scouts ) < 4;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			character = AI.sq_ward_scouts.spawn_points_2, -- GAMMA_CHARACTER: Grunt02
			text = "He has to be stopped. If it was me in charge, this whole thing would be over in a week.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_02100.sound'),
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_combat_status( AI.sq_ward_scouts ) < 4;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			character = AI.sq_ward_scouts.spawn_points_0, -- GAMMA_CHARACTER: Grunt01
			text = "Right? Assassinate the Arbiter. The  Swords of Sanghelios cut each other down. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt01_01100.sound'),
		},
		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_combat_status( AI.sq_ward_scouts ) < 4;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			character = AI.sq_ward_scouts.spawn_points_0, -- GAMMA_CHARACTER: Grunt01
			text = "Then we move in and clean up. The End.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt01_01200.sound'),
		},
		[7] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_combat_status( AI.sq_ward_scouts ) < 4;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			character = AI.sq_ward_scouts.spawn_points_2, -- GAMMA_CHARACTER: Grunt02
			text = "That's right, my brother. The. End.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_02200.sound'),
		},
		[8] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_combat_status( AI.sq_ward_scouts ) < 4;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			character = AI.sq_ward_scouts.spawn_points_0, -- GAMMA_CHARACTER: Grunt01
			text = "Instead they have us taking over some lame old ruins. Why?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt01_01700.sound'),
		},
		[9] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_combat_status( AI.sq_ward_scouts ) < 4;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			character = AI.sq_ward_scouts.spawn_points_2, -- GAMMA_CHARACTER: Grunt02
			text = "Why? Because they don't know what they're doing that's why! It's crazy.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_02600.sound'),
		},
		[10] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_combat_status( AI.sq_ward_scouts ) < 4;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			character = AI.sq_ward_scouts.spawn_points_2, -- GAMMA_CHARACTER: Grunt02
			text = "It's just go here, go there, no reason for nothing. I'm not cannon fodder. I KNOW SOME THINGS.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_02400.sound'),
		},
		[11] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_combat_status( AI.sq_ward_scouts ) < 4;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			character = AI.sq_ward_scouts.spawn_points_0, -- GAMMA_CHARACTER: Grunt01
			text = "I know you do, brother! I know you do. And someday? You'll prove it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt01_01800.sound'),

			sleepAfter = 7,
		},
		[12] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_combat_status( AI.sq_ward_scouts ) < 4;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			character = AI.sq_ward_scouts.spawn_points_2, -- GAMMA_CHARACTER: Grunt02
			text = "I feel like we're gonna die.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_00100.sound'),
		},
		[13] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_combat_status( AI.sq_ward_scouts ) < 4;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			character = AI.sq_ward_scouts.spawn_points_0, -- GAMMA_CHARACTER: Grunt01
			text = "Of course we're gonna die. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt01_00100.sound'),
		},
		[14] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return ai_combat_status( AI.sq_ward_scouts ) < 4;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			character = AI.sq_ward_scouts.spawn_points_2, -- GAMMA_CHARACTER: Grunt02
			text = "No, I mean soon. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_00200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		AIDialogManager.EnableAIDialog(AI.sq_ward_scouts);
	end,	
};


-------------------------------

function PLATEAU__dropdown__3_grunts_interrupt_grunt_01()

	PrintNarrative("START - PLATEAU__dropdown__3_grunts_interrupt_grunt_01");
	
	SleepUntil([| ai_combat_status( AI.sq_ward_scouts ) >= 4], 1);

	NarrativeQueue.InterruptConversation(W2HubPlateau_Plateau__dropdown__3_grunts);
	
	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__dropdown__3_grunts_interrupt_grunt_01, AI.sq_ward_scouts, ACTOR_TYPE.grunt, "enemy_in_range", missionPlateau.goal_SentryShipEncounter, 20 );

end

--[========================================================================[
          PLATEAU. BOWL. bowl covies pre COMBAT interrupted
--]========================================================================]
global W2HubPlateau_PLATEAU__dropdown__3_grunts_interrupt_grunt_01 = {
	name = "W2HubPlateau_PLATEAU__dropdown__3_grunts_interrupt_grunt_01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.enemy_in_range ~= nil;
			end,
			--character = 0 -- GAMMA_CHARACTER: Grunt02
			text = "Ahhh! Humans! Humans here!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_00300.sound'),

			playDurationAdjustment = 0.5,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(PLATEAU__dropdown__3_grunts_interrupt_grunt_02);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};


-------------------------------

function PLATEAU__dropdown__3_grunts_interrupt_grunt_02()

	PrintNarrative("START - PLATEAU__dropdown__3_grunts_interrupt_grunt_02");
	
	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__dropdown__3_grunts_interrupt_grunt_02, AI.sq_ward_scouts, ACTOR_TYPE.grunt, "enemy_in_range", missionPlateau.goal_SentryShipEncounter, 20 );

end

--[========================================================================[
          PLATEAU. BOWL. bowl covies pre COMBAT interrupted
--]========================================================================]
global W2HubPlateau_PLATEAU__dropdown__3_grunts_interrupt_grunt_02 = {
	name = "W2HubPlateau_PLATEAU__dropdown__3_grunts_interrupt_grunt_02",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_critical_dialogue_on;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.enemy_in_range ~= nil;
			end,
			--character = 0 -- GAMMA_CHARACTER: Grunt02
			text = "Here? Impossible!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt03_00100.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(PLATEAU__dropdown__3_grunts_interrupt_grunt_03);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};



-------------------------------

function PLATEAU__dropdown__3_grunts_interrupt_grunt_03()

	PrintNarrative("START - PLATEAU__dropdown__3_grunts_interrupt_grunt_03");
	
	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__dropdown__3_grunts_interrupt_grunt_03, AI.sq_ward_scouts, ACTOR_TYPE.grunt, "enemy_in_range", missionPlateau.goal_SentryShipEncounter, 20 );

end

--[========================================================================[
          PLATEAU. BOWL. bowl covies pre COMBAT interrupted
--]========================================================================]
global W2HubPlateau_PLATEAU__dropdown__3_grunts_interrupt_grunt_03 = {
	name = "W2HubPlateau_PLATEAU__dropdown__3_grunts_interrupt_grunt_03",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_critical_dialogue_on;

	end,
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.enemy_in_range ~= nil;
			end,
			--character = 0 -- GAMMA_CHARACTER: Grunt02
			text = "Humans are attacking us!!! Alert!!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_03000.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(PLATEAU__dropdown__3_grunts_interrupt_grunt_04);
	end,

	localVariables = {
						enemy_in_range = nil,
						},

};


-------------------------------

function PLATEAU__dropdown__3_grunts_interrupt_grunt_04()

	PrintNarrative("START - PLATEAU__dropdown__3_grunts_interrupt_grunt_04");
	
	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__dropdown__3_grunts_interrupt_grunt_04, AI.sq_ward_scouts, ACTOR_TYPE.grunt, "enemy_in_range", missionPlateau.goal_SentryShipEncounter, 20 );

end

--[========================================================================[
          PLATEAU. BOWL. bowl covies pre COMBAT interrupted
--]========================================================================]
global W2HubPlateau_PLATEAU__dropdown__3_grunts_interrupt_grunt_04 = {
	name = "W2HubPlateau_PLATEAU__dropdown__3_grunts_interrupt_grunt_04",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_critical_dialogue_on;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.enemy_in_range ~= nil;
			end,
			--character = 0 -- GAMMA_CHARACTER: Grunt02
			text = "We! Are under! Attaaaaaack!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt01_00400.sound'),
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
          Plateau. dropdown. osiris pre encounter

          Osiris, is going through a cave and start hearing some
          covenant speaking.

          Osiris will react.
--]========================================================================]
global W2HubPlateau_Plateau__dropdown__osiris_pre_encounter = {
	name = "W2HubPlateau_Plateau__dropdown__osiris_pre_encounter",

	CanStart = function (thisConvo, queue)
		return (ai_living_count(AI.sq_ward_scouts) > 0 and not volume_test_objects_all( VOLUMES.tv_narrative_plateau_dropdown_grunts_in_sight, AI.sq_ward_scouts )
				and object_at_distance_and_can_see_object(players(), ai_get_object( AI.sq_ward_scouts.spawn_points_0), 15, 30, VOLUMES.tv_narrative_plateau_dropdown_grunts))
				or ai_combat_status(AI.sq_ward_scouts) > 4;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(60);
		if not object_at_distance_and_can_see_object(players(), ai_get_object( AI.sq_ward_scouts.spawn_points_0), 15, 30, VOLUMES.tv_narrative_plateau_dropdown_grunts) then
			thisConvo.localVariables.s_speaker = GetClosestMusketeer(AI.sq_ward_scouts, 20, 2)
		end
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return object_at_distance_and_can_see_object(SPARTANS.locke, ai_get_object( AI.sq_ward_scouts.spawn_points_0), 15, 30) or thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If locke is first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Covenant ahead. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_00400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return object_at_distance_and_can_see_object(SPARTANS.buck, ai_get_object( AI.sq_ward_scouts.spawn_points_0), 15, 30) or thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: If buck is first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "We got Covenant ahead.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_00100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return object_at_distance_and_can_see_object(SPARTANS.tanaka, ai_get_object( AI.sq_ward_scouts.spawn_points_0), 15, 30) or thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: If tanaka is first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Heads up. Covenant.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_00100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return object_at_distance_and_can_see_object(SPARTANS.vale, ai_get_object( AI.sq_ward_scouts.spawn_points_0), 15, 30) or thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: If vale is first
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Covenant forces ahead.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_00100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__covies_pre_encounter");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__covies_pre_encounter);
	end,	

	
	localVariables = {
					s_speaker = nil,
					},

};


--[========================================================================[
          PLATEAU. sentry reveal. covies pre encounter

          We move further into the caverns. Ahead of us we see the
          cavern exit. In front of the exit are a small group of
          Covenant.
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__covies_pre_encounter = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__covies_pre_encounter",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narrative_plateau_sentryreveal_covies_pre_encounter) and ai_living_count(AI.sq_ward_scouts) == 0 ; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
		CreateMissionThread(sentry_reveal_covies_interrupted_grunt_01);
		PushForwardVOReset();
	end,

	sleepBefore = 2,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not (ai_combat_status(AI.sq_ward_vanguard) >= 6 ); -- GAMMA_TRANSITION: When going down the stairs if enemies are not alerted
			end,

			character = function (thisLine, thisConvo, queue, lineNumber)
				if ai_living_count(AI.sq_ward_vanguard.e) ~= 0 then
					return AI.sq_ward_vanguard.e
				elseif ai_living_count(AI.sq_ward_vanguard.e) == 0 then
					return OBJECTS.sentryreveal_covenant_fake_speaker
				end;				
			end,
			
			text = "What was that?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_00600.sound'),
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not (ai_combat_status(AI.sq_ward_vanguard) >= 6 ); -- GAMMA_TRANSITION: When going down the stairs if enemies are not alerted
			end,

			character = function (thisLine, thisConvo, queue, lineNumber)
				if ai_living_count(AI.sq_ward_vanguard.g2) ~= 0 then
					return AI.sq_ward_vanguard.g2
				elseif ai_living_count(AI.sq_ward_vanguard.g2) == 0 then
					return OBJECTS.sentryreveal_covenant_fake_speaker
				end;				
			end,

			sleepBefore = 0.4,

			text = "It sounded like... ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_02000.sound'),

			playDurationAdjustment = 0.5,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not (ai_combat_status(AI.sq_ward_vanguard) >= 6 ); -- GAMMA_TRANSITION: When going down the stairs if enemies are not alerted
			end,

			character = function (thisLine, thisConvo, queue, lineNumber)
				if ai_living_count(AI.sq_ward_vanguard.e) ~= 0 then
					return AI.sq_ward_vanguard.e
				elseif ai_living_count(AI.sq_ward_vanguard.e) == 0 then
					return OBJECTS.sentryreveal_covenant_fake_speaker
				end;				
			end,

			sleepBefore = 0.2,

			text = "You go see what it is.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_01600.sound'),
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not (ai_combat_status(AI.sq_ward_vanguard) >= 6 ); -- GAMMA_TRANSITION: When going down the stairs if enemies are not alerted
			end,

			character = function (thisLine, thisConvo, queue, lineNumber)
				if ai_living_count(AI.sq_ward_vanguard.g2) ~= 0 then
					return AI.sq_ward_vanguard.g2
				elseif ai_living_count(AI.sq_ward_vanguard.g2) == 0 then
					return OBJECTS.sentryreveal_covenant_fake_speaker
				end;				
			end,
			text = "Me? But... why not him?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_02300.sound'),
		},
		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not (ai_combat_status(AI.sq_ward_vanguard) >= 6 ); -- GAMMA_TRANSITION: When going down the stairs if enemies are not alerted
			end,

			character = function (thisLine, thisConvo, queue, lineNumber)
				if ai_living_count(AI.sq_ward_vanguard.e) ~= 0 then
					return AI.sq_ward_vanguard.e
				elseif ai_living_count(AI.sq_ward_vanguard.e) == 0 then
					return OBJECTS.sentryreveal_covenant_fake_speaker
				end;				
			end,

			sleepBefore = 0.4,

			text = "Grrrr...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_01700.sound'),
		},
		[6] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not (ai_combat_status(AI.sq_ward_vanguard) >= 6 ); -- GAMMA_TRANSITION: When going down the stairs if enemies are not alerted
			end,

			character = function (thisLine, thisConvo, queue, lineNumber)
				if ai_living_count(AI.sq_ward_vanguard.g2) ~= 0 then
					return AI.sq_ward_vanguard.g2
				elseif ai_living_count(AI.sq_ward_vanguard.g2) == 0 then
					return OBJECTS.sentryreveal_covenant_fake_speaker
				end;				
			end,

			sleepBefore = 0.5,

			text = "Ok, ok!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_02700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


-- =================================================================================================
--   _____ ______ _   _ _______ _______     __  _____  ________      ________          _      
--  / ____|  ____| \ | |__   __|  __ \ \   / / |  __ \|  ____\ \    / /  ____|   /\   | |     
-- | (___ | |__  |  \| |  | |  | |__) \ \_/ /  | |__) | |__   \ \  / /| |__     /  \  | |     
--  \___ \|  __| | . ` |  | |  |  _  / \   /   |  _  /|  __|   \ \/ / |  __|   / /\ \ | |     
--  ____) | |____| |\  |  | |  | | \ \  | |    | | \ \| |____   \  /  | |____ / ____ \| |____ 
-- |_____/|______|_| \_|  |_|  |_|  \_\ |_|    |_|  \_\______|   \/   |______/_/    \_\______|
--                                                                                            
-- =================================================================================================



--PLATEAU. SENTRY REVEAL. OSIRIS PRE ENCOUNTER--------------------------------------------------------------------------------------------------
function plateau_sentryreveal_load()

	PrintNarrative("LOAD - plateau_sentryreveal_load");		
	
		PrintNarrative("QUEUE - W2HubPlateau_Plateau__sENTRY_REVEAL__visual_on_Kraken_base");
		NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__sENTRY_REVEAL__visual_on_Kraken_base);

		PushForwardVOReset(60);

end

-------------------------------

function sentry_reveal_covies_interrupted_grunt_01()

	SleepUntil([| ai_combat_status(AI.sq_ward_vanguard) >= 5], 30);

	NarrativeQueue.InterruptConversation(W2HubPlateau_PLATEAU__sentry_reveal__covies_pre_encounter);

	PrintNarrative("START - sentry_reveal_covies_interrupted_grunt_01");
	
	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__sentry_reveal_covies_interrupted_grunt_01, AI.sg_reveal_all, ACTOR_TYPE.grunt, "enemy_in_range", missionPlateau.goal_SentryShipEncounter, 30 );

	CreateMissionThread(sentry_reveal_covies_interrupted_elite_00);	

end

--[========================================================================[
          PLATEAU. BOWL. bowl covies pre COMBAT interrupted
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal_covies_interrupted_grunt_01 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal_covies_interrupted_grunt_01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.enemy_in_range ~= nil;
			end,
			--character = 0 -- GAMMA_CHARACTER: Grunt02
			text = "Gah! Humans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_01100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(sentry_reveal_covies_interrupted_grunt_02);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};



-------------------------------

function sentry_reveal_covies_interrupted_grunt_02()

	PrintNarrative("START - sentry_reveal_covies_interrupted_grunt_02");	

	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__sentry_reveal_covies_interrupted_grunt_02, AI.sg_reveal_all, ACTOR_TYPE.grunt, "enemy_in_range", missionPlateau.goal_SentryShipEncounter, 20, true );

end

--[========================================================================[
          PLATEAU. BOWL. bowl covies pre COMBAT interrupted
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal_covies_interrupted_grunt_02 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal_covies_interrupted_grunt_02",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_critical_dialogue_on;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.enemy_in_range ~= nil;
			end,
			--character = 0 -- GAMMA_CHARACTER: Grunt02
			text = "Where? Where??",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt01_02200.sound'),
		},
	},

	sleepAfter = 3,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(sentry_reveal_covies_interrupted_grunt_04_kraken);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};




----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	COVENANT SCRIPTED CHATTER
----------------------------------------------------------------------------------------------------------------------------------------------------------------------


function sentry_reveal_covies_interrupted_grunt_04_kraken()

	PrintNarrative("START - sentry_reveal_covies_interrupted_grunt_04_kraken");
	
	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__sentry_reveal_covies_interrupted_grunt_04_kraken, AI.sg_reveal_all, ACTOR_TYPE.grunt, "enemy_in_range", missionPlateau.goal_SentryShipEncounter, 20 );

end

--[========================================================================[
          PLATEAU. BOWL. bowl covies pre COMBAT interrupted
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal_covies_interrupted_grunt_04_kraken = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal_covies_interrupted_grunt_04_kraken",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_critical_dialogue_on ;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.enemy_in_range ~= nil and random_range( 1, 7 ) == 1 and not b_sentry_is_rising and not b_sentry_has_risen;
			end,
			--character = 0 -- GAMMA_CHARACTER: Grunt02
			text = "Release the Kraken!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt01_00700.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				PrintNarrative("FAILED - Random. Not this time -  "..thisConvo.name);
			end,	
		},
	},

	sleepAfter = 5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(sentry_reveal_covies_interrupted_grunt_05_kraken);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};


-------------------------------

function sentry_reveal_covies_interrupted_grunt_05_kraken()

	PrintNarrative("START - sentry_reveal_covies_interrupted_grunt_05_kraken");

	SleepUntil([| b_sentry_is_rising or b_sentry_has_risen and not b_critical_dialogue_on], 100);
	
	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__sentry_reveal_covies_interrupted_grunt_05_kraken, AI.sg_reveal_all, ACTOR_TYPE.grunt, "enemy_in_range", missionPlateau.goal_SentryShipEncounter, 15 );

end

--[========================================================================[
          PLATEAU. BOWL. bowl covies pre COMBAT interrupted
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal_covies_interrupted_grunt_05_kraken = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal_covies_interrupted_grunt_05_kraken",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_critical_dialogue_on ;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.enemy_in_range ~= nil;
			end,
			--character = 0 -- GAMMA_CHARACTER: Grunt02
			text = "The Kraken is invincible! We will crush you!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_00500.sound'),
		},
	},

	sleepAfter = 5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(sentry_reveal_covies_interrupted_grunt_06_kraken);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};



-------------------------------

function sentry_reveal_covies_interrupted_grunt_06_kraken()

	PrintNarrative("START - sentry_reveal_covies_interrupted_grunt_06_kraken");

	SleepUntil([| b_sentry_is_rising or b_sentry_has_risen and not b_critical_dialogue_on], 30);
	
	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__sentry_reveal_covies_interrupted_grunt_06_kraken, AI.sg_reveal_all, ACTOR_TYPE.grunt, "enemy_in_range", missionPlateau.goal_SentryShipEncounter, 15 );

end

--[========================================================================[
          PLATEAU. BOWL. bowl covies pre COMBAT interrupted
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal_covies_interrupted_grunt_06_kraken = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal_covies_interrupted_grunt_06_kraken",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_critical_dialogue_on ;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.enemy_in_range ~= nil;
			end,
			--character = 0 -- GAMMA_CHARACTER: Grunt02
			text = "The Kraken will punish the infidels!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_01400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};



-------------------------------

function sentry_reveal_covies_interrupted_elite_00()

	PrintNarrative("START - sentry_reveal_covies_interrupted_elite_00");
	
	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__sentry_reveal_covies_interrupted_elite_00, AI.sq_ward_vanguard, ACTOR_TYPE.elite, "enemy_in_range", missionPlateau.goal_SentryShipEncounter, 15 );

end

--[========================================================================[
          PLATEAU. BOWL. bowl covies pre COMBAT interrupted
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal_covies_interrupted_elite_00 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal_covies_interrupted_elite_00",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_critical_dialogue_on;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.enemy_in_range ~= nil;
			end,
			--character = 0 -- GAMMA_CHARACTER: Grunt02
			text = "We're under attack!!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_03200.sound'),
		},
	},

	sleepAfter = 5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(sentry_reveal_covies_interrupted_elite_01);		
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};



---------------------------------------



function sentry_reveal_covies_interrupted_elite_01()

	PrintNarrative("START - sentry_reveal_covies_interrupted_elite_01");
	
	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__sentry_reveal_covies_interrupted_elite_01, AI.sq_ward_vanguard, ACTOR_TYPE.elite, "enemy_in_range", missionPlateau.goal_SentryShipEncounter, 10 );

end

--[========================================================================[
          PLATEAU. BOWL. bowl covies pre COMBAT interrupted
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal_covies_interrupted_elite_01 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal_covies_interrupted_elite_01",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_sentry_is_rising and not b_critical_dialogue_on;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.enemy_in_range ~= nil;
			end,
			--character = 0 -- GAMMA_CHARACTER: Elite01
			text = "Humans desecrate Sanghelios soil!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_00100.sound'),
		},
	},

	sleepAfter = 5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(sentry_reveal_covies_interrupted_elite_02);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};


---------------------------------------



function sentry_reveal_covies_interrupted_elite_02()

	PrintNarrative("START - sentry_reveal_covies_interrupted_elite_02");
	
	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__sentry_reveal_covies_interrupted_elite_02, AI.sq_ward_vanguard, ACTOR_TYPE.elite, "enemy_in_range", missionPlateau.goal_SentryShipEncounter, 20 );

end

--[========================================================================[
          PLATEAU. BOWL. bowl covies pre COMBAT interrupted
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal_covies_interrupted_elite_02 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal_covies_interrupted_elite_02",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_sentry_is_rising and not b_critical_dialogue_on;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.enemy_in_range ~= nil;
			end,
			--character = 0 -- GAMMA_CHARACTER: Elite01
			text = "Sanghelios belongs to the Covenant!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_00300.sound'),
		},
	},

	sleepAfter = 5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};



---------------------------------------



function sentry_reveal_covies_interrupted_elite_03()

	PrintNarrative("START - sentry_reveal_covies_interrupted_elite_03");

	SleepUntil([| b_arbiter_is_attacking ], 10);
	
	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__sentry_reveal_covies_interrupted_elite_03, AI.sq_ward_vanguard, ACTOR_TYPE.elite, "enemy_in_range", missionPlateau.goal_SentryShipEncounter, 15 );

end

--[========================================================================[
          PLATEAU. BOWL. bowl covies pre COMBAT interrupted
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal_covies_interrupted_elite_03 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal_covies_interrupted_elite_03",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_critical_dialogue_on;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.enemy_in_range ~= nil;
			end,
			--character = 0 -- GAMMA_CHARACTER: Elite01
			text = "The false Arbiter's forces approach!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_00400.sound'),
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
          Plateau. sENTRY REVEAL. visual on Kraken base

          As we exit the cavern, before us is a Kraken docked, From
          here, it looks like a covenant base.

          Player thinks it's a regular covenant base of operation, it
          will have the surprise of the rise and the real reveal of the
          Kraken soon after.
--]========================================================================]
global W2HubPlateau_Plateau__sENTRY_REVEAL__visual_on_Kraken_base = {
	name = "W2HubPlateau_Plateau__sENTRY_REVEAL__visual_on_Kraken_base",

	CanStart = function (thisConvo, queue)
		return volume_test_players_lookat( VOLUMES.tv_narrative_plateau_sentryreveal_visual_on_kraken, 41, 40 ); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOStandBy();
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_player_lookat( VOLUMES.tv_narrative_plateau_sentryreveal_visual_on_kraken, unit_get_player( SPARTANS.locke ), 41, 40 ); -- GAMMA_TRANSITION: If LOCKE is first to look at the Kraken
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Commander Palmer, We're in position.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_00600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_player_lookat( VOLUMES.tv_narrative_plateau_sentryreveal_visual_on_kraken, unit_get_player( SPARTANS.buck ), 41, 40 ); -- GAMMA_TRANSITION: If LOCKE is first to look at the Kraken
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Found our dance partners.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_00800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_player_lookat( VOLUMES.tv_narrative_plateau_sentryreveal_visual_on_kraken, unit_get_player( SPARTANS.tanaka ), 41, 40 ); -- GAMMA_TRANSITION: If LOCKE is first to look at the Kraken
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "In position!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_01300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_player_lookat( VOLUMES.tv_narrative_plateau_sentryreveal_visual_on_kraken, unit_get_player( SPARTANS.vale ), 41, 40 ); -- GAMMA_TRANSITION: If LOCKE is first to look at the Kraken
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "There's the Kraken.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_01200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "SarahPalmer",
			
			--character = 0, -- GAMMA_CHARACTER: Palmer
			text = "Copy that. Arbiter, you're up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_palmer_01200.sound'),

		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Arbiter",

			--character = 0, -- GAMMA_CHARACTER: ARBITER
			text = "Affirmative. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_arbiter_00200.sound'),

			playDurationAdjustment = 0.9,

		},
		[7] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingLarTwo",

			sleepBefore = 0.5,

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "Affirmative.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend01_01900.sound'),			

		},		
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		--	!!	CRITICAL DIALOGUE Off	!!
		b_critical_dialogue_on = false;
		b_arbiter_is_attacking = true;
		CreateMissionThread(plateau_sentryreveal_pre_rise_push_forward);
		CreateMissionThread(plateau_reveal_arbiter_battle_net);
		CreateMissionThread(sentry_reveal_covies_interrupted_elite_03);
	end,
};



function plateau_reveal_arbiter_battle_net()

PrintNarrative("START - plateau_reveal_arbiter_battle_net");
	
	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_4");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_4);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_4 )
				and not b_collectible_used and not b_critical_dialogue_on and not b_sentry_is_rising and not b_sentry_has_risen], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_1");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_1);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_1 )
				and not b_collectible_used and not b_critical_dialogue_on and not b_sentry_is_rising and not b_sentry_has_risen], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_2");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_2);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_2 )
				and not b_collectible_used and not b_critical_dialogue_on and not b_sentry_is_rising and not b_sentry_has_risen], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_3");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_3);				
end


--[========================================================================[
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_1 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_1",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_collectible_used and not b_critical_dialogue_on and not b_sentry_is_rising and not b_sentry_has_risen;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingLarTwo",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "Commencing attack.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend01_00500.sound'),

			playDurationAdjustment = 0.8,
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
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_2 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_2",

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
				return not b_collectible_used and not b_critical_dialogue_on and not b_sentry_is_rising and not b_sentry_has_risen;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingSiqtarOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend02
			text = "All wings watch the turrets. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend02_00700.sound'),

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
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_3 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_3",

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
				return not b_collectible_used and not b_critical_dialogue_on and not b_sentry_is_rising and not b_sentry_has_risen;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingLarOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend03
			text = "Stay above their angle of fire.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend03_00800.sound'),

			
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
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_4 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_4",

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
				return not b_collectible_used and not b_critical_dialogue_on and not b_sentry_is_rising and not b_sentry_has_risen;
			end,
		
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					print("played");
			end,
			
			moniker = "WingLarTwo",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "Visual on target, engaging in 5.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend01_01600.sound'),

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
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_pre_rise = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_pre_rise",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_sentry_is_rising;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "FlightLeader",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "Kraken is going to lift off. All wings, stay back.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend01_01700.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_pre_rise_2");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_pre_rise_2);
	end,
};


--[========================================================================[
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_pre_rise_2 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_pre_rise_2",

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
				return not b_sentry_is_rising;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingLarTwo",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "Going up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend01_01800.sound'),

			playDurationAdjustment = 0.8,

					},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


-------------------------------------------------------------------------------------------------------------------------------------------------------

function plateau_sentryreveal_pre_rise_push_forward()

	PrintNarrative("WAKE - plateau_sentryreveal_pre_rise_push_forward");

	PrintNarrative("TIMER - plateau_sentryreveal_pre_rise_push_forward");

	sleep_s(20);
	
	SleepUntil([|  ai_living_count(AI.sq_ward_vanguard) <= 0 and ai_living_count(AI.sq_ward_scouts) <= 0 and ai_living_count(AI.sq_ward_vangrunts) <= 0 ], 100);

	PrintNarrative("START - plateau_sentryreveal_pre_rise_push_forward");
			
	PrintNarrative("QUEUE - W2HubPlateau_Plateau__sentry_reveal__pre_rise_push_forward");
	NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__sentry_reveal__pre_rise_push_forward);	

	PrintNarrative("END - plateau_sentryreveal_pre_rise_push_forward");
end


--[========================================================================[
          Plateau. sentry reveal. pre rise push forward
--]========================================================================]
global W2HubPlateau_Plateau__sentry_reveal__pre_rise_push_forward = {
	name = "W2HubPlateau_Plateau__sentry_reveal__pre_rise_push_forward",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return b_arbiter_is_attacking and not b_sentry_is_rising and not b_sentry_has_risen;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					PushForwardVOReset();
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Arbiter's attacking the Kraken. We're supposed to be helping, aren't we?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_00300.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};


--PLATEAU. SENTRY REVEAL. KRAKEN RISE----------------------------------------------------------------------------------------------------
function plateau_sentryreveal_kraken_rise_lead_in()

--	SOUND OF THE KRAKEN			BUUUUUUUUUUUUUUUUHHHH

	PrintNarrative("START - plateau_sentryreveal_kraken_rise_lead_in");

	PushForwardVOStandBy();
	b_chatter_is_permitted = false;

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_pre_rise");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_pre_rise);	

	PrintNarrative("QUEUE - W2HubPlateau_Plateau__sENTRY_REVEAL__Kraken_rise");
	NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__sENTRY_REVEAL__Kraken_rise);	

	SleepUntil([|  NarrativeQueue.HasConversationFinished(W2HubPlateau_Plateau__sENTRY_REVEAL__Kraken_rise) ], 1);

	PrintNarrative("END - plateau_sentryreveal_kraken_rise_lead_in");

end


--PLATEAU. SENTRY REVEAL. KRAKEN RISE----------------------------------------------------------------------------------------------------
function plateau_sentryreveal_kraken_rise_launch()

	PrintNarrative("START - plateau_sentryreveal_kraken_rise_launch");

	--	!!	CRITICAL DIALOGUE ON	!!
	b_critical_dialogue_on = true;

	CreateMissionThread(Plateau__sENTRY_REVEAL__elite_on_stairs_elite_01);

	PrintNarrative("QUEUE - W2HubPlateau_Plateau__sENTRY_REVEAL__Kraken_rise_buck");
	NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__sENTRY_REVEAL__Kraken_rise_buck);

	SleepUntil([|  NarrativeQueue.HasConversationFinished(W2HubPlateau_Plateau__sENTRY_REVEAL__Kraken_rise_buck) ], 1);	

	sleep_s(15);

			PrintNarrative("QUEUE - W2HubPlateau_Plateau__sENTRY_REVEAL__arbiter_and_kraken");
			NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__sENTRY_REVEAL__arbiter_and_kraken);

			SleepUntil([|  NarrativeQueue.HasConversationFinished(W2HubPlateau_Plateau__sENTRY_REVEAL__arbiter_and_kraken) ], 1);
	
	CreateMissionThread(PLATEAU_sentry_reveal__COMBAT_RADIO_CHATTER_crash_interrupt);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_crash_a");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_crash_a);	

	SleepUntil([|  b_sentry_has_risen and not b_reveal_horn], 10);

	--	!!	CRITICAL DIALOGUE OFF	!!
	b_critical_dialogue_on = false;
	
	sleep_s(20);

	CreateMissionThread(plateau_reveal_arbiter_battle_net_2);

	PrintNarrative("QUEUE - W2HubPlateau_Plateau__sENTRY_REVEAL__post_rising_1");
	NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__sENTRY_REVEAL__post_rising_1);

	PrintNarrative("END - plateau_sentryreveal_kraken_rise_launch");

end




--[========================================================================[
          Plateau. sENTRY REVEAL. Kraken rise

          As we draw closer the Kraken pulls away from the cliff side
          and rises into the air. 

          The Kraken makes its big deep horn sound (Buuuuuhh!)

          Soon after the Kraken starts moving.
--]========================================================================]
global W2HubPlateau_Plateau__sENTRY_REVEAL__Kraken_rise_buck = {
	name = "W2HubPlateau_Plateau__sENTRY_REVEAL__Kraken_rise_buck",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_reveal_horn;
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
				return not b_reveal_horn;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buCK
			text = "Kraken's on the move!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_00200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};


--[========================================================================[
          Plateau. sENTRY REVEAL. Kraken rise

          As we draw closer the Kraken pulls away from the cliff side
          and rises into the air. 

          The Kraken makes its big deep horn sound (Buuuuuhh!)

          Soon after the Kraken starts moving.
--]========================================================================]
global W2HubPlateau_Plateau__sENTRY_REVEAL__Kraken_rise = {
	name = "W2HubPlateau_Plateau__sENTRY_REVEAL__Kraken_rise",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_reveal_horn;
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
				return not b_sentry_is_rising;
			end,		

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "SarahPalmer",

			--character = 0, -- GAMMA_CHARACTER: Palmer
			text = "Friendlies in the air, Osiris. Focus fire on ground forces.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_palmer_01300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};


--[========================================================================[
          Plateau. sENTRY REVEAL. arbiter and kraken
--]========================================================================]
global W2HubPlateau_Plateau__sENTRY_REVEAL__arbiter_and_kraken = {
	name = "W2HubPlateau_Plateau__sENTRY_REVEAL__arbiter_and_kraken",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_reveal_horn;
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
			
			moniker = "Arbiter",

			--character = 0, -- GAMMA_CHARACTER: ARBITER
			text = "All banshee wings, engage the kraken.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_arbiter_00300.sound'),			
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2HubPlateau_Plateau__sENTRY_REVEAL__arbiter_and_kraken_2");
		NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__sENTRY_REVEAL__arbiter_and_kraken_2);
	end,
};




--[========================================================================[
          Plateau. sENTRY REVEAL. arbiter and kraken
--]========================================================================]
global W2HubPlateau_Plateau__sENTRY_REVEAL__arbiter_and_kraken_2 = {
	name = "W2HubPlateau_Plateau__sENTRY_REVEAL__arbiter_and_kraken_2",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_reveal_horn and IsGoalActive(missionPlateau.goal_SentryShipEncounter);
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
			
			moniker = "SarahPalmer",

			--character = 0, -- GAMMA_CHARACTER: Palmer
			text = "Arbiter's people have the Kraken distracted. You're clear to advance on the Constructor's coordinates.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_palmer_01400.sound'),

			sleepAfter = 0.8,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Affirmative, Commander.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_19100.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};

---------------------------------------------------------------------------------------------------------------------------------------------------


function plateau_reveal_arbiter_battle_net_2()

PrintNarrative("START - plateau_reveal_arbiter_battle_net_2");

	SleepUntil([| not b_collectible_used and not b_critical_dialogue_on and not IsSpartanInCombat() and IsGoalActive(missionPlateau.goal_SentryShipEncounter) ], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_5");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_5);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_5 )
				and not b_collectible_used and not b_critical_dialogue_on and not IsSpartanInCombat() and IsGoalActive(missionPlateau.goal_SentryShipEncounter) ], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_6");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_6);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_6 )
				and not b_collectible_used and not b_critical_dialogue_on and not IsSpartanInCombat() and IsGoalActive(missionPlateau.goal_SentryShipEncounter) ], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_7");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_7);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_7 )
				and not b_collectible_used and not b_critical_dialogue_on and not IsSpartanInCombat() and IsGoalActive(missionPlateau.goal_SentryShipEncounter) ], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_8");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_8);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_8 )], 10);

	sleep_s(5);

	SleepUntil([| not b_collectible_used and not b_critical_dialogue_on and not IsSpartanInCombat() and IsGoalActive(missionPlateau.goal_SentryShipEncounter) ], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_9");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_9);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_9 )], 10);

	sleep_s(3);

	SleepUntil([| not b_collectible_used and not b_critical_dialogue_on and not IsSpartanInCombat() and IsGoalActive(missionPlateau.goal_SentryShipEncounter) ], 10);	

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_10");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_10);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_10 )], 10);
	
	sleep_s(3);
	
	SleepUntil([| not b_collectible_used and not b_critical_dialogue_on and not IsSpartanInCombat() and IsGoalActive(missionPlateau.goal_SentryShipEncounter) ], 10);	
				
	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_11");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_11);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_11 )], 10);

	sleep_s(5);

	SleepUntil([| not b_collectible_used and not b_critical_dialogue_on and not IsSpartanInCombat() and IsGoalActive(missionPlateau.goal_SentryShipEncounter) ], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_12");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_12);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_12 )], 10);

	sleep_s(7);

	SleepUntil([| not b_collectible_used and not b_critical_dialogue_on and not IsSpartanInCombat() and IsGoalActive(missionPlateau.goal_SentryShipEncounter) ], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_13");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_13);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_13 )], 10);

	sleep_s(5);

	SleepUntil([| not b_collectible_used and not b_critical_dialogue_on and not IsSpartanInCombat() and IsGoalActive(missionPlateau.goal_SentryShipEncounter) ], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_14");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_14);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_14 )], 10);

	sleep_s(4);

	SleepUntil([| not b_collectible_used and not b_critical_dialogue_on and not IsSpartanInCombat() and IsGoalActive(missionPlateau.goal_SentryShipEncounter) ], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_15");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_15);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_15 )], 10);

	sleep_s(4);

	SleepUntil([| not b_collectible_used and not b_critical_dialogue_on and not IsSpartanInCombat() and IsGoalActive(missionPlateau.goal_SentryShipEncounter) ], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_16");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_16);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_16 )
				and not b_collectible_used and not b_critical_dialogue_on and not IsSpartanInCombat() and IsGoalActive(missionPlateau.goal_SentryShipEncounter) ], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_17");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_17);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_17 )
				and not b_collectible_used and not b_critical_dialogue_on and not IsSpartanInCombat() and IsGoalActive(missionPlateau.goal_SentryShipEncounter) ], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_21");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_21);
end



--[========================================================================[
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_5 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_5",

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
				return IsGoalActive(missionPlateau.goal_SentryShipEncounter);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingSiqtarOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend02
			text = "Attack wing Siqtar, focus fire on the deck.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend02_00600.sound'),

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
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_6 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_6",

	CanStart = function (thisConvo, queue)
		return true;
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
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionPlateau.goal_SentryShipEncounter);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingJardamOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend04
			text = "Attack wing Jardam flank. Target Covenant aircraft.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend04_00300.sound'),

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
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_7 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_7",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	sleepBefore = 0.4,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionPlateau.goal_SentryShipEncounter);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingLarOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend03
			text = "Attack wing Lar target propulsion control.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend03_00500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	hud_hide_radio_transmission_hud();
	end,
};


--[========================================================================[
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_8 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_8",

	CanStart = function (thisConvo, queue)
		return true;
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
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionPlateau.goal_SentryShipEncounter);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingLarTwo",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "Kraken returning fire.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend01_00600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	hud_hide_radio_transmission_hud();
	end,
};


--[========================================================================[
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_9 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_9",

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
				return IsGoalActive(missionPlateau.goal_SentryShipEncounter);
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingLarOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend03
			text = "Heavy enemy fire. Difficult to evade.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend03_00600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	hud_hide_radio_transmission_hud();
	end,
};


--[========================================================================[
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_10 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_10",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	sleepBefore = 0.5,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionPlateau.goal_SentryShipEncounter);
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingJardamOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend04
			text = "Keep shields facing forward.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend04_00400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};



--[========================================================================[
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_11 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_11",

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
				return IsGoalActive(missionPlateau.goal_SentryShipEncounter);
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "FlightLeader",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "Stay clear of those legs.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend01_00800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};


--[========================================================================[
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_12 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_12",

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
				return IsGoalActive(missionPlateau.goal_SentryShipEncounter);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingSiqtarOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend02
			text = "Phantoms returning fire.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend02_00800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};


--[========================================================================[
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_13 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_13",

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
				return IsGoalActive(missionPlateau.goal_SentryShipEncounter);
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingLarOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend03
			text = "Incoming banshees!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend03_00700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};


--[========================================================================[
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_14 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_14",

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
				return IsGoalActive(missionPlateau.goal_SentryShipEncounter);
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingJardamOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend04
			text = "Siqtar Leader you are too low. Pull up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend04_00500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};


--[========================================================================[
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_15 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_15",

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
				return IsGoalActive(missionPlateau.goal_SentryShipEncounter);
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingLarTwo",
			
			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "Phantom down. Repeat - Phantom down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend01_01000.sound'),

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
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_16 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_16",

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
				return IsGoalActive(missionPlateau.goal_SentryShipEncounter);
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingJardamOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend04
			text = "Today the Covenant falls!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend04_00700.sound'),

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
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_17 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_17",

	CanStart = function (thisConvo, queue)
		return true;
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
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionPlateau.goal_SentryShipEncounter);
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingJardamOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend04
			text = "Siqtar Leader! Pull. Up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend04_00600.sound'),

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
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_21 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_21",

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
				return IsGoalActive(missionPlateau.goal_SentryShipEncounter);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingSiqtarOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend04
			text = "Targeting structural supports. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend02_00900.sound'),			

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
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER CRASH
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_crash_a = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_crash_a",

	CanStart = function (thisConvo, queue)
		return b_kraken_reveal_banshee_crash;
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 2;
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
				return false; --not b_arbiter_banshee_crash and IsGoalActive(missionPlateau.goal_SentryShipEncounter);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingLarThree",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend03
			text = "I'm being hit! Need backup.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend03_01200.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return false; --not b_arbiter_banshee_crash and IsGoalActive(missionPlateau.goal_SentryShipEncounter);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "FlightLeader",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "Jardam, pull out, pull out!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend01_02100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};




--[========================================================================[
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER CRASH
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_crash = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_crash",

	CanStart = function (thisConvo, queue)
		return b_arbiter_banshee_crash;
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 1;
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
				return false; --IsGoalActive(missionPlateau.goal_SentryShipEncounter);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));					
			end,
			
			moniker = "WingLarThree",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend03
			text = "I'm hit! I'm down! I'M DOWN! --",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend03_01300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_kraken_reveal_banshee_crash = false;
		hud_hide_radio_transmission_hud();
	end,
};


function PLATEAU_sentry_reveal__COMBAT_RADIO_CHATTER_crash_interrupt()

	PrintNarrative("WAKE - PLATEAU_sentry_reveal__COMBAT_RADIO_CHATTER_crash_interrupt");

	SleepUntil([| b_arbiter_banshee_crash ], 1);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_crash");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_crash);

	SleepUntil([| not object_valid("vin_banshcrash_rev1") ], 1);

	PrintNarrative("START - PLATEAU_sentry_reveal__COMBAT_RADIO_CHATTER_crash_interrupt");

	NarrativeQueue.InterruptConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_crash);

	PrintNarrative("END - PLATEAU_sentry_reveal__COMBAT_RADIO_CHATTER_crash_interrupt");
	
end



--[========================================================================[
          Plateau. sENTRY REVEAL. post rising
--]========================================================================]
global W2HubPlateau_Plateau__sENTRY_REVEAL__post_rising_1 = {
	name = "W2HubPlateau_Plateau__sENTRY_REVEAL__post_rising_1",

	CanStart = function (thisConvo, queue)
		return IsSpartanAbleToSpeak(SPARTANS.buck);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionPlateau.goal_SentryShipEncounter) and volume_test_players( VOLUMES.tv_narrative_plateau_sentryreveal_post_rising);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Arbiter's taking that thing on in Banshees? That's brave.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_10700.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		PushForwardVOReset(90);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;
	end,

	sleepAfter = 3,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		PrintNarrative("QUEUE - W2HubPlateau_Plateau__sENTRY_REVEAL__post_rising_2");
		NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__sENTRY_REVEAL__post_rising_2);
	end,
};


--[========================================================================[
          Plateau. sENTRY REVEAL. post rising
--]========================================================================]
global W2HubPlateau_Plateau__sENTRY_REVEAL__post_rising_2 = {
	name = "W2HubPlateau_Plateau__sENTRY_REVEAL__post_rising_2",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_timer == 5; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionPlateau.goal_SentryShipEncounter) and volume_test_players( VOLUMES.tv_narrative_plateau_sentryreveal_post_rising);
			end,

			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				PushForwardVOReset();		
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Arbiter's got the Kraken tied up. Time to move towards the Constructor's coordinates.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_00400.sound'),			

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;
		b_chatter_is_permitted = true;
		PrintNarrative("QUEUE - W2HubPlateau_Plateau__sENTRY_REVEAL__push_forward");
		NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__sENTRY_REVEAL__push_forward);	
	end,
};

--[========================================================================[
          Plateau. sENTRY REVEAL. push forward
--]========================================================================]
global W2HubPlateau_Plateau__sENTRY_REVEAL__push_forward = {
	name = "W2HubPlateau_Plateau__sENTRY_REVEAL__push_forward",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_timer == 5; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return IsGoalActive(missionPlateau.goal_SentryShipEncounter);
			end,			

			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				PushForwardVOReset();		
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Not sure how long Arbiter will be able to hold the Kraken off.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_12100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;
	end,
};



---------------------------------------

function Plateau__sENTRY_REVEAL__elite_on_stairs_elite_01()

	PrintNarrative("START - Plateau__sENTRY_REVEAL__elite_on_stairs_elite_01");
	
	SleepUntil([| ai_living_count(AI.sq_ward_boss_1) > 0 or ai_living_count(AI.sq_ward_rooks) > 0	], 30);

	SleepUntil([| not b_critical_dialogue_on and not b_critical_dialogue_on and IsGoalActive(missionPlateau.goal_SentryShipEncounter)
						and (	(ai_living_count(AI.sq_ward_boss_1) > 0 and objects_distance_to_object( players(), ai_get_object(AI.sq_ward_boss_1 )) < 11 )
								or (ai_living_count(AI.sq_ward_rooks) > 0 and objects_distance_to_object( players(), ai_get_object(AI.sq_ward_rooks )) < 11 ))	], 30);

	PrintNarrative("QUEUE - W2HubPlateau_Plateau__sENTRY_REVEAL__elite_on_stairs_elite_01");
	NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__sENTRY_REVEAL__elite_on_stairs_elite_01);

	PrintNarrative("QUEUE - W2HubPlateau_Plateau__sENTRY_REVEAL__to_the_stairs");
	NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__sENTRY_REVEAL__to_the_stairs);	

end



--[========================================================================[
          Plateau. sENTRY REVEAL. to the stairs
--]========================================================================]
global W2HubPlateau_Plateau__sENTRY_REVEAL__to_the_stairs = {
	name = "W2HubPlateau_Plateau__sENTRY_REVEAL__to_the_stairs",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_ward_rooks) > 0 and (IsPlayer(SPARTANS.tanaka) and object_at_distance_and_can_see_object(SPARTANS.tanaka, ai_get_object(AI.sq_ward_rooks), 15, 30))
															or (not IsPlayer(SPARTANS.tanaka) and objects_distance_to_object(SPARTANS.tanaka, ai_get_object(AI.sq_ward_rooks )) < 25 );
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Jackals coming down the stairs!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_13500.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;
	end,
};

--[========================================================================[
          PLATEAU. BOWL. bowl covies pre COMBAT interrupted
--]========================================================================]
global W2HubPlateau_Plateau__sENTRY_REVEAL__elite_on_stairs_elite_01 = {
	name = "W2HubPlateau_Plateau__sENTRY_REVEAL__elite_on_stairs_elite_01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			character = AI.sq_ward_boss_1.spawn_points_0, -- GAMMA_CHARACTER: Elite01
			text = "Victory to the Covenant!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_01200.sound'),
		},
		[2] = {
			character = AI.sq_ward_boss_1.spawn_points_1, -- GAMMA_CHARACTER: Jackal01
			text = "[Battle cry of acknowledgement]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_jackal01_00200.sound'),
		},
		[3] = {
			character = AI.sq_ward_boss_1.spawn_points_2, -- GAMMA_CHARACTER: Jackal01
			text = "Victory!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_jackal01_00300.sound'),
		},
		[4] = {
			character = AI.sq_ward_rooks.spawn_points_1, -- GAMMA_CHARACTER: Jackal01
			text = "Victory for pay masters!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_jackal01_00400.sound'),
		},
		[5] = {
			character = AI.sq_ward_boss_1.spawn_points_0, -- GAMMA_CHARACTER: Elite01
			text = "Kill the False Arbiter's lackeys!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_00200.sound'),
		},
	},

	sleepAfter = 5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(Plateau__sENTRY_REVEAL__elite_on_stairs_elite_02);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};

---------------------------------------

function Plateau__sENTRY_REVEAL__elite_on_stairs_elite_02()

	PrintNarrative("START - Plateau__sENTRY_REVEAL__elite_on_stairs_elite_02");
	
	IsThereAnEnemyInRangeLauncher(W2HubPlateau_Plateau__sENTRY_REVEAL__elite_on_stairs_elite_02, AI.sg_reveal_all, ACTOR_TYPE.elite, "enemy_in_range", missionPlateau.goal_SentryShipEncounter, 15 );

end

--[========================================================================[
          PLATEAU. BOWL. bowl covies pre COMBAT interrupted
--]========================================================================]
global W2HubPlateau_Plateau__sENTRY_REVEAL__elite_on_stairs_elite_02 = {
	name = "W2HubPlateau_Plateau__sENTRY_REVEAL__elite_on_stairs_elite_02",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_critical_dialogue_on;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.enemy_in_range ~= nil;
			end,
			--character = 0 -- GAMMA_CHARACTER: Elite01
			text = "This is a Covenant world!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_00500.sound'),
		},
	},

	sleepAfter = 5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(Plateau__sENTRY_REVEAL__elite_on_stairs_elite_03);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};



---------------------------------------

function Plateau__sENTRY_REVEAL__elite_on_stairs_elite_03()

	PrintNarrative("START - Plateau__sENTRY_REVEAL__elite_on_stairs_elite_03");
	
	IsThereAnEnemyInRangeLauncher(W2HubPlateau_Plateau__sENTRY_REVEAL__elite_on_stairs_elite_03, AI.sg_reveal_all, ACTOR_TYPE.elite, "enemy_in_range", missionPlateau.goal_SentryShipEncounter, 15 );

end

--[========================================================================[
          PLATEAU. BOWL. bowl covies pre COMBAT interrupted
--]========================================================================]
global W2HubPlateau_Plateau__sENTRY_REVEAL__elite_on_stairs_elite_03 = {
	name = "W2HubPlateau_Plateau__sENTRY_REVEAL__elite_on_stairs_elite_03",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_critical_dialogue_on;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.enemy_in_range ~= nil;
			end,
			--character = 0 -- GAMMA_CHARACTER: Elite01
			text = "Break the Swords of Sanghelios!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_01300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};

-- =================================================================================================
--  _    _  ____  _      _      ______          __
-- | |  | |/ __ \| |    | |    / __ \ \        / /
-- | |__| | |  | | |    | |   | |  | \ \  /\  / / 
-- |  __  | |  | | |    | |   | |  | |\ \/  \/ /  
-- | |  | | |__| | |____| |___| |__| | \  /\  /   
-- |_|  |_|\____/|______|______\____/   \/  \/    
--                                                
-- =================================================================================================




-------------------------------------------------------------------------------------------------------------------------------------------------
function plateau_hollow_load()

	PrintNarrative("LOAD - plateau_hollow_load");
	
		PushForwardVOReset();
		b_chatter_is_permitted = true;

		CreateMissionThread(plateau_hollow_covies_pre_encounter_interrupted);		
		CreateMissionThread(plateau_hollow_shield_look_at);
		CreateMissionThread(plateau_hollow_all_dead_listener);
		CreateMissionThread(plateau_hollow_shield_destroyed_listener);
		CreateMissionThread(plateau_hollow_grunt_behind_shield);
		CreateMissionThread(plateau_hollow_shield_generator);
		CreateMissionThread(plateau_hollow_grunt_behind_shield_destroyed);

		CreateMissionThread(plateau_hollow_shield_damaged);
		CreateMissionThread(plateau_hollow_shield_buckle);
		
end


-------------------------------------------------------------------------------------------------------------------------------------------------
function plateau_hollow_objective()

	PrintNarrative("WAKE - plateau_hollow_objective");
	PrintNarrative("START - plateau_hollow_objective");

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__HOLLOW__objective");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__HOLLOW__objective);	

	PrintNarrative("END - plateau_hollow_objective");

end

--[========================================================================[
          PLATEAU. HOLLOW. objective

          That line should remind the player of his current objective.
--]========================================================================]
global W2HubPlateau_PLATEAU__HOLLOW__objective = {
	name = "W2HubPlateau_PLATEAU__HOLLOW__objective",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "SarahPalmer",

			--character = 0, -- GAMMA_CHARACTER: Palmer
			text = "Keep moving, Spartans. Covenant are bringing in reinforcements.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_palmer_02900.sound'),

			playDurationAdjustment = 0.7,

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;
	end,
};

-----------------------

function plateau_hollow_covies_pre_encounter_interrupted()

	PrintNarrative("START - sentry_reveal_covies_interrupted_grunt_06_kraken");

	SleepUntil([| ai_combat_status(AI.sg_hollow_all) > 3 and not b_critical_dialogue_on ], 30);
	
	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__HOLLOW__covies_pre_encounter_interrupted_grunt_01, AI.sg_hollow_bulwark, ACTOR_TYPE.grunt, "enemy_in_range", missionPlateau.goal_Hollow, 25 );

end

--[========================================================================[
          PLATEAU. BOWL. bowl covies pre COMBAT interrupted
--]========================================================================]
global W2HubPlateau_PLATEAU__HOLLOW__covies_pre_encounter_interrupted_grunt_01 = {
	name = "W2HubPlateau_PLATEAU__HOLLOW__covies_pre_encounter_interrupted_grunt_01",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_critical_dialogue_on ;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.enemy_in_range ~= nil;
			end,
			--character = 0 -- GAMMA_CHARACTER: Grunt02
			text = "They're here! They're here!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt01_01300.sound'),
		},
	},

	sleepAfter = 3,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(plateau_hollow_covies_pre_encounter_interrupted_2);		
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};



-------------------------------

function plateau_hollow_covies_pre_encounter_interrupted_2()

	PrintNarrative("START - plateau_hollow_covies_pre_encounter_interrupted_2");

	SleepUntil([| ai_combat_status(AI.sg_hollow_all) > 3 and not b_critical_dialogue_on ], 30);
	
	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__HOLLOW__covies_pre_encounter_interrupted_grunt_02, AI.sg_hollow_bulwark, ACTOR_TYPE.grunt, "enemy_in_range", missionPlateau.goal_Hollow, 25 );

end

--[========================================================================[
          PLATEAU. BOWL. bowl covies pre COMBAT interrupted
--]========================================================================]
global W2HubPlateau_PLATEAU__HOLLOW__covies_pre_encounter_interrupted_grunt_02 = {
	name = "W2HubPlateau_PLATEAU__HOLLOW__covies_pre_encounter_interrupted_grunt_02",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_critical_dialogue_on ;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.enemy_in_range ~= nil;
			end,
			--character = 0 -- GAMMA_CHARACTER: Grunt02
			text = "Surrender to me, infidels! I might let you live!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_00400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(plateau_hollow_elite_taunt);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};



-------------------------------

function plateau_hollow_elite_taunt()

	PrintNarrative("START - plateau_hollow_elite_taunt");
	
	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__HOLLOW__elite_taunt, AI.sg_hollow_all, ACTOR_TYPE.elite, "enemy_in_range", missionPlateau.goal_Hollow, 9 );

end

--[========================================================================[
          PLATEAU. BOWL. bowl covies pre COMBAT interrupted
--]========================================================================]
global W2HubPlateau_PLATEAU__HOLLOW__elite_taunt = {
	name = "W2HubPlateau_PLATEAU__HOLLOW__elite_taunt",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_critical_dialogue_on ;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.enemy_in_range ~= nil;
			end,
			--character = 0 -- GAMMA_CHARACTER: Grunt02
			text = "The Swords of Sanghelios enlist humans to fight their war?!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite02_00500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};



------------------------------------------------------------------------------------------------------------------------------------------------------
function plateau_hollow_shield_health()

	local shield_health:number = -1;

	if object_valid("hollow_projected_barrier") and object_list_children (OBJECTS.hollow_projected_barrier, TAG ('levels\assets\osiris\props\generic_covenant\cov_projector_barrier\cov_projector_barrier_shield\cov_projector_barrier_shield.crate')) ~= nil then

		shield_health = object_get_health (object_list_children (OBJECTS.hollow_projected_barrier, TAG ('levels\assets\osiris\props\generic_covenant\cov_projector_barrier\cov_projector_barrier_shield\cov_projector_barrier_shield.crate'))[1]);
		--print("Shield's Health: ", shield_health);
	else
		shield_health = -1;
	end

	return shield_health
end


--PLATEAU. HOLLOW. SHIELD LOOK AT----------------------------------------------------------------------------------------------------
function plateau_hollow_shield_look_at()

local s_shield_lookat_angle:number = 20;
local s_shield_lookat_distance:number = 18;
--volume_test_player_lookat(VOLUMES.tv_narrative_plateau_hollow_forcefield, unit_get_player( SPARTANS.buck ), 19, 16)
	PrintNarrative("WAKE - plateau_hollow_shield_look_at");
	
	SleepUntil([|  object_valid( "hollow_projected_barrier") and var_cov_projector_barrier == 1 ], 60);

	--object_get_health( OBJECTS.hollow_projected_barrier)
	sleep_s(1);

	repeat
		
		SleepUntil([|  (object_valid( "hollow_projected_barrier") and objects_can_see_object( players(), OBJECTS.hollow_projected_barrier, s_shield_lookat_angle )) or IsGoalActive(missionPlateau.goal_Ramp) ], 10);

		W2HubPlateau_PLATEAU__HOLLOW__shield_look_at.localVariables.s_speaker = spartan_look_at_object(players(), OBJECTS.hollow_projected_barrier, s_shield_lookat_distance, s_shield_lookat_angle, 0.3, 2)

	until W2HubPlateau_PLATEAU__HOLLOW__shield_look_at.localVariables.s_speaker ~= nil 
			and (volume_test_object(VOLUMES.tv_narrative_plateau_hollow_shield_look_at, W2HubPlateau_PLATEAU__HOLLOW__shield_look_at.localVariables.s_speaker) or volume_test_object(VOLUMES.tv_narrative_plateau_hollow_shield_generator_window, W2HubPlateau_PLATEAU__HOLLOW__shield_look_at.localVariables.s_speaker))
			or plateau_hollow_shield_health() <= 0
			or IsGoalActive(missionPlateau.goal_Ramp)

	

	PrintNarrative("START - plateau_hollow_shield_look_at");
	
	if plateau_hollow_shield_health() > 0.1 and W2HubPlateau_PLATEAU__HOLLOW__shield_look_at.localVariables.s_speaker ~= nil 
		and (volume_test_object(VOLUMES.tv_narrative_plateau_hollow_shield_look_at, W2HubPlateau_PLATEAU__HOLLOW__shield_look_at.localVariables.s_speaker) or volume_test_object(VOLUMES.tv_narrative_plateau_hollow_shield_generator_window, W2HubPlateau_PLATEAU__HOLLOW__shield_look_at.localVariables.s_speaker)) then
	
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__HOLLOW__shield_look_at");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__HOLLOW__shield_look_at);	

	elseif IsGoalActive(missionPlateau.goal_Ramp) then

		PrintNarrative("SKIPPED - plateau_hollow_shield_look_at - Goal Advance");

	elseif plateau_hollow_shield_health() <= 0 then
		
		PrintNarrative("SKIPPED - plateau_hollow_shield_look_at - Shield health = 0, skip VO lines");
	end

	PrintNarrative("END - plateau_hollow_shield_look_at");


end


--[========================================================================[
          PLATEAU. HOLLOW. shield look at
--]========================================================================]
global W2HubPlateau_PLATEAU__HOLLOW__shield_look_at = {
	name = "W2HubPlateau_PLATEAU__HOLLOW__shield_look_at",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
		b_hollow_player_saw_shield = true;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke and not b_hollow_player_saw_shield_gen;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));					
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Shield in the way. Take it down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_02900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale and not b_hollow_player_saw_shield_gen;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Shield in the way. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_01900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka and not b_hollow_player_saw_shield_gen;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Shield in the way. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_01700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck and not b_hollow_player_saw_shield_gen;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Shield in the way. \r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_01300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return plateau_hollow_shield_health() > 0 and not b_hollow_player_saw_shield_gen;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					b_hollow_player_saw_shield = true;
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Take it down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03000.sound'),

			sleepAfter = 1,
		},
		[6] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return plateau_hollow_shield_health() > 0 and not b_hollow_player_saw_shield_gen;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Shield's gotta have a weak spot.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_01800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {
					s_speaker = nil,
					},
};



--PLATEAU. HOLLOW. SHIELD DAMAGED----------------------------------------------------------------------------------------------------
function plateau_hollow_shield_damaged()

	PrintNarrative("WAKE - plateau_hollow_shield_damaged");

	SleepUntil([| object_valid( "hollow_projected_barrier" ) and b_hollow_player_saw_shield], 100);

	sleep_s(5);

			PrintNarrative("REPEAT - plateau_hollow_shield_damaged");
			SleepUntil([| not b_critical_dialogue_on and plateau_hollow_shield_health() < 0.999 and objects_can_see_object( players(), OBJECTS.hollow_projected_barrier, 20 )  ], 1);
			PrintNarrative("PASS 1 - plateau_hollow_shield_damaged");
			Sleep(20);
			SleepUntil([| not b_critical_dialogue_on and plateau_hollow_shield_health() < 0.999 and objects_can_see_object( players(), OBJECTS.hollow_projected_barrier, 20 )  ], 1);
			PrintNarrative("PASS 2 - plateau_hollow_shield_damaged");
			Sleep(20);
			SleepUntil([| not b_critical_dialogue_on and plateau_hollow_shield_health() < 0.999 and objects_can_see_object( players(), OBJECTS.hollow_projected_barrier, 20 )  ], 1);
			PrintNarrative("PASS 3 - plateau_hollow_shield_damaged");
			Sleep(20);
			SleepUntil([| not b_critical_dialogue_on and plateau_hollow_shield_health() < 0.999 and objects_can_see_object( players(), OBJECTS.hollow_projected_barrier, 20 )  ], 1);
			PrintNarrative("PASS 4 - plateau_hollow_shield_damaged");

	PrintNarrative("START - plateau_hollow_shield_damaged");

	print("1 - Shield's Health: ", plateau_hollow_shield_health());			

	sleep_s(1);

	if plateau_hollow_shield_health() > 0.5  then			
				
			PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__HOLLOW__shield_damaged");
			NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__HOLLOW__shield_damaged);

	end
	
	PrintNarrative("END - plateau_hollow_shield_damaged");

	

end



--[========================================================================[
          PLATEAU. HOLLOW. shield damaged
--]========================================================================]
global W2HubPlateau_PLATEAU__HOLLOW__shield_damaged = {
	name = "W2HubPlateau_PLATEAU__HOLLOW__shield_damaged",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
		PushForwardVOReset();
		print("2 - Shield's Health: ", plateau_hollow_shield_health());
	end,


	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return plateau_hollow_shield_health() > 0.5 and ((not IsPlayer(SPARTANS.tanaka) and objects_distance_to_object( SPARTANS.tanaka, OBJECTS.hollow_projected_barrier) < 15) or (IsPlayer(SPARTANS.tanaka and objects_can_see_object( SPARTANS.tanaka, OBJECTS.hollow_projected_barrier, 20 )))); -- GAMMA_TRANSITION: Else IF tanaka first look at the shield and shield is being damaged
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "The shield's self-repairing.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_02000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return objects_can_see_object( SPARTANS.locke, OBJECTS.hollow_projected_barrier, 20 ) and plateau_hollow_shield_health() > 0.5; -- GAMMA_TRANSITION: IF LOCKE first look at the shield and shield is being damaged
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Shield's stronger than I thought. Focus fire!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return objects_can_see_object( SPARTANS.buck, OBJECTS.hollow_projected_barrier, 20 ) and plateau_hollow_shield_health() > 0.5; -- GAMMA_TRANSITION: Else If BUCK first look at the shield and shield is being damaged
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Shield's too strong.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_01400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return objects_can_see_object( SPARTANS.vale, OBJECTS.hollow_projected_barrier, 20 ) and plateau_hollow_shield_health() > 0.5; -- GAMMA_TRANSITION: Else IF Vale first look at the shield and shield is being damaged
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "The shield's absorbing everything I've got!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_02000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER				
				return 0;
			end,
		},
		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return plateau_hollow_shield_health() > 0.5; -- GAMMA_TRANSITION: Else IF Vale first look at the shield and shield is being damaged
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Focus fire.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_13200.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;
		hud_hide_radio_transmission_hud();
	end,
};


--PLATEAU. HOLLOW. SHIELD BUCKLE----------------------------------------------------------------------------------------------------
function plateau_hollow_shield_buckle()

	PrintNarrative("WAKE - plateau_hollow_shield_buckle");
	
	--	object_get_health (object_list_children (OBJECTS.hollow_projected_barrier, TAG ('levels\assets\osiris\props\generic_covenant\cov_projector_barrier\cov_projector_barrier_shield\cov_projector_barrier_shield.crate'))[1])

	SleepUntil([| object_valid( "hollow_projected_barrier" ) and b_hollow_player_saw_shield], 60);
	
	repeat

		SleepUntil([| plateau_hollow_shield_health() < 0.4 ], 5);

		W2HubPlateau_PLATEAU__HOLLOW__shield_buckle.localVariables.speaker = spartan_look_at_object(players(), OBJECTS.hollow_projected_barrier, 13, 15, 0.2, 2);

		if W2HubPlateau_PLATEAU__HOLLOW__shield_buckle.localVariables.speaker == nil then
			W2HubPlateau_PLATEAU__HOLLOW__shield_buckle.localVariables.speaker = GetClosestMusketeer(OBJECTS.hollow_projected_barrier, 7, 0);
			if W2HubPlateau_PLATEAU__HOLLOW__shield_buckle.localVariables.speaker == OBJECTS.hollow_projected_barrier then
				W2HubPlateau_PLATEAU__HOLLOW__shield_buckle.localVariables.speaker = nil;
			end
		end

	until W2HubPlateau_PLATEAU__HOLLOW__shield_buckle.localVariables.speaker ~= nil

	PrintNarrative("START - plateau_hollow_shield_buckle");
	print("Shield's Health: ", plateau_hollow_shield_health());

	if IsPlayer(W2HubPlateau_PLATEAU__HOLLOW__shield_buckle.localVariables.speaker) then
		W2HubPlateau_PLATEAU__HOLLOW__shield_buckle.localVariables.speaker = GetClosestMusketeer(W2HubPlateau_PLATEAU__HOLLOW__shield_buckle.localVariables.speaker, 7, 0);
	end

	if plateau_hollow_shield_health() > 0.2  then

			--	!!	CRITICAL DIALOGUE ON	!!
			b_critical_dialogue_on = true;

			if not IsGoalActive(missionPlateau.goal_Ramp) then
				PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__HOLLOW__shield_buckle");
				NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__HOLLOW__shield_buckle);	
			end
	
			--	!!	CRITICAL DIALOGUE OFF	!!
			b_critical_dialogue_on = false;

	else
		PrintNarrative("Narrative CANCELED - plateau_hollow_shield_buckle");
	end

	PrintNarrative("END - plateau_hollow_shield_buckle");

end



--[========================================================================[
          PLATEAU. HOLLOW. shield buckle

          When the player shoots at the shield.
--]========================================================================]
global W2HubPlateau_PLATEAU__HOLLOW__shield_buckle = {
	name = "W2HubPlateau_PLATEAU__HOLLOW__shield_buckle",

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
				return thisConvo.localVariables.speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If locke look at the shield and shield health is less than 50%
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Shield's starting to buckle! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03300.sound'),
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.speaker == SPARTANS.buck; -- GAMMA_TRANSITION: Else If BUCK look at the shield and shield health is less than 50%
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Shield's losing power! Concentrate heavy fire!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_01500.sound'),
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: Else If tanaka look at the shield and shield health is less than 50%
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Hit the shield with heavy weapons. It'll fall soon enough.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_02100.sound'),
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.speaker == SPARTANS.vale and  plateau_hollow_shield_health() > 0.2; -- GAMMA_TRANSITION: Else If vale look at the shield and shield health is less than 50%
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Shield's losing power! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_02100.sound'),

			},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
					speaker = nil,
					},
};


--PLATEAU. HOLLOW. GRUNT BEHIND SHIELD----------------------------------------------------------------------------------------------------
function plateau_hollow_grunt_behind_shield()

	PrintNarrative("WAKE - plateau_hollow_grunt_behind_shield");

	SleepUntil([| ai_living_count(AI.sq_hollow_porch_grunts.spawn_points_0) == 1 and objects_distance_to_object( players(), ai_get_object(AI.sq_hollow_porch_grunts.spawn_points_0) ) < 10], 100);
	
	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__HOLLOW__grunt_behind_shield");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__HOLLOW__grunt_behind_shield);
	
	CreateMissionThread(plateau_hollow_grunt_behind_shield_interrupted);
		
	PrintNarrative("END - plateau_hollow_grunt_behind_shield");

end



--[========================================================================[
          PLATEAU. HOLLOW. grunt behind shield
--]========================================================================]
global W2HubPlateau_PLATEAU__HOLLOW__grunt_behind_shield = {
	name = "W2HubPlateau_PLATEAU__HOLLOW__grunt_behind_shield",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not IsSpartanInCombat() and plateau_hollow_shield_health() > 0 and not b_hollow_player_saw_shield and objects_distance_to_object( players(), ai_get_object(AI.sq_hollow_porch_grunts.spawn_points_0) ) > 5 and  ai_combat_status(AI.sq_hollow_porch_grunts.spawn_points_0) <= 7;
			end,

			character = AI.sq_hollow_porch_grunts.spawn_points_0, -- GAMMA_CHARACTER: Grunt02(Gruntklaroo)
			text = "Why it's not starting? Energy systems online? Check. Magnetic field activation... ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_00600.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER		
				return 0;
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not IsSpartanInCombat() and plateau_hollow_shield_health() > 0 and not b_hollow_player_saw_shield and objects_distance_to_object( players(), ai_get_object(AI.sq_hollow_porch_grunts.spawn_points_0) ) > 5 and  ai_combat_status(AI.sq_hollow_porch_grunts.spawn_points_0) <= 7;
			end,

			character = AI.sq_hollow_porch_grunts.spawn_points_0, -- GAMMA_CHARACTER: Grunt02(Gruntklaroo)
			text = "or wait no, ionized plasma drive? I think? Or the other one first... ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_00700.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER		
				return 0;
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not IsSpartanInCombat() and plateau_hollow_shield_health() > 0 and not b_hollow_player_saw_shield and objects_distance_to_object( players(), ai_get_object(AI.sq_hollow_porch_grunts.spawn_points_0) ) > 5 and  ai_combat_status(AI.sq_hollow_porch_grunts.spawn_points_0) <= 7;
			end,

			character = AI.sq_hollow_porch_grunts.spawn_points_0, -- GAMMA_CHARACTER: Grunt02(Gruntklaroo)
			text = "Which one first, Klaroo? Think, Klaroo. Think. Maybe it's... ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_00800.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER		
				return 0;
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not IsSpartanInCombat() and plateau_hollow_shield_health() > 0 and not b_hollow_player_saw_shield and objects_distance_to_object( players(), ai_get_object(AI.sq_hollow_porch_grunts.spawn_points_0) ) > 5 and  ai_combat_status(AI.sq_hollow_porch_grunts.spawn_points_0) <= 7;
			end,

			character = AI.sq_hollow_porch_grunts.spawn_points_0, -- GAMMA_CHARACTER: Grunt02(Gruntklaroo)
			text = "Except but what if... Why you always so stupid, Klaroo? Stupid.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_00900.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER		
				return 0;
			end,
		},
		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not IsSpartanInCombat() and plateau_hollow_shield_health() > 0 and not b_hollow_player_saw_shield and objects_distance_to_object( players(), ai_get_object(AI.sq_hollow_porch_grunts.spawn_points_0) ) > 5 and  ai_combat_status(AI.sq_hollow_porch_grunts.spawn_points_0) <= 7;
			end,
			character = AI.sq_hollow_porch_grunts.spawn_points_0, -- GAMMA_CHARACTER: Grunt02(Gruntklaroo)
			text = "Stupid stupid me. Stupid me.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_01000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};



--PLATEAU. HOLLOW. GRUNT BEHIND SHIELD----------------------------------------------------------------------------------------------------
function plateau_hollow_grunt_behind_shield_interrupted()

	PrintNarrative("WAKE - plateau_hollow_grunt_behind_shield_interrupted");

	SleepUntil([| ai_living_count(AI.sq_hollow_flipside.spawn_points_0) == 1 and ai_combat_status(AI.sq_hollow_flipside.spawn_points_0) >= 5 and ((object_get_health(ai_get_object(AI.sq_hollow_flipside.spawn_points_0)) < 1) or (object_get_health(ai_get_object(AI.sq_hollow_flipside.spawn_points_1)) < 1)) ], 10);

	PrintNarrative("START - plateau_hollow_grunt_behind_shield_interrupted");

				

	PrintNarrative("END - plateau_hollow_grunt_behind_shield_interrupted");

end


-------------------------------

function plateau_hollow_grunt_behind_shield_destroyed()

	PrintNarrative("START - plateau_hollow_grunt_behind_shield_destroyed");

	SleepUntil([| plateau_hollow_shield_health() <= 0 ], 10);
	
	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__HOLLOW__grunts_behind_shield_destroyed_grunt_01, AI.sg_hollow_all, ACTOR_TYPE.grunt, "enemy_in_range", missionPlateau.goal_Hollow, 50 );

end

--[========================================================================[
          PLATEAU. BOWL. bowl covies pre COMBAT interrupted
--]========================================================================]
global W2HubPlateau_PLATEAU__HOLLOW__grunts_behind_shield_destroyed_grunt_01 = {
	name = "W2HubPlateau_PLATEAU__HOLLOW__grunts_behind_shield_destroyed_grunt_01",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_critical_dialogue_on ;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.enemy_in_range ~= nil;
			end,
			--character = 0 -- GAMMA_CHARACTER: Grunt02
			text = "The shield is down! We're all gonna diiiiiie!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_01500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(plateau_hollow_grunt_behind_shield_destroyed_2);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};


-------------------------------

function plateau_hollow_grunt_behind_shield_destroyed_2()

	PrintNarrative("START - plateau_hollow_grunt_behind_shield_destroyed_2");
	
	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__HOLLOW__grunts_behind_shield_destroyed_grunt_02, AI.sg_hollow_all, ACTOR_TYPE.grunt, "enemy_in_range", missionPlateau.goal_Hollow, 35 );

end

--[========================================================================[
          PLATEAU. BOWL. bowl covies pre COMBAT interrupted
--]========================================================================]
global W2HubPlateau_PLATEAU__HOLLOW__grunts_behind_shield_destroyed_grunt_02 = {
	name = "W2HubPlateau_PLATEAU__HOLLOW__grunts_behind_shield_destroyed_grunt_02",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return not b_critical_dialogue_on ;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.enemy_in_range ~= nil;
			end,
			--character = 0 -- GAMMA_CHARACTER: Grunt02
			text = "Get out of my way! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt01_00500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};



--PLATEAU. HOLLOW. SHIELD GENERATOR----------------------------------------------------------------------------------------------------
function plateau_hollow_shield_generator()
local s_speaker:object = nil;

	PrintNarrative("WAKE - plateau_hollow_shield_generator");

	SleepUntil([|	object_valid( "hollow_projected_barrier")], 1)

	repeat
		PrintNarrative("plateau_hollow_shield_generator repeat: start")
		SleepUntil([|	IsGoalActive(missionPlateau.goal_Ramp) or (volume_test_players(VOLUMES.tv_narrative_plateau_hollow_shield_generator_window) and objects_can_see_object( players(), OBJECTS.hollow_projected_barrier, 10 ) )], 10);		
		
		s_speaker = spartan_look_at_object(players(), OBJECTS.hollow_projected_barrier, 10, 7, 0.5, 1);

		if not volume_test_object(VOLUMES.tv_narrative_plateau_hollow_shield_generator_window, s_speaker ) then
			s_speaker = nil;
		end

	until b_hollow_player_saw_shield and (IsGoalActive(missionPlateau.goal_Ramp) or s_speaker ~= nil)

	PrintNarrative("START - plateau_hollow_shield_generator");
	
	if plateau_hollow_shield_health() > 0 and s_speaker ~= nil then

				PushForwardVOReset();
				
				W2HubPlateau_PLATEAU__HOLLOW__shield_generator.localVariables.s_speaker = s_speaker;
				PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__HOLLOW__shield_generator");
				NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__HOLLOW__shield_generator);
				PrintNarrative("INTERRUPT - W2HubPlateau_PLATEAU__HOLLOW__shield_look_at");
				NarrativeQueue.InterruptConversation(W2HubPlateau_PLATEAU__HOLLOW__shield_look_at);
				

	else
	
	PrintNarrative("SKIPPED - plateau_hollow_shield_generator");

	end

	PrintNarrative("END - plateau_hollow_shield_generator");

end

	

--[========================================================================[
          PLATEAU. HOLLOW. shield generator
--]========================================================================]
global W2HubPlateau_PLATEAU__HOLLOW__shield_generator = {
	name = "W2HubPlateau_PLATEAU__HOLLOW__shield_generator",
		
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
		b_hollow_player_saw_shield_gen = true;
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
			text = "I have a shot on the shield generator.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03400.sound'),
			
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 2; -- GAMMA_NEXT_LINE_NUMBER
			end,
			
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER			
				return 3;
			end,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return plateau_hollow_shield_health()>0.2;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Pop that and the whole thing'll go.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_02200.sound'),
			
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER			
				return 0;
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "I got a shot at the shield generator.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_01600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 4; -- GAMMA_NEXT_LINE_NUMBER
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return plateau_hollow_shield_health()>0.2;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Take the shot Buck!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER			
				return 0;
			end,
		},
		[5] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Got a shot on the shield generator.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_02300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber)
				return 7; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return plateau_hollow_shield_health()>0.2;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Take the shot Tanaka!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER			
				return 0;
			end,
		},
		[7] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "I have a shot on the shield generator.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_02200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 8; -- GAMMA_NEXT_LINE_NUMBER
			end,
			
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[8] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return plateau_hollow_shield_health()>0.2;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Take the shot Vale!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER			
				return 0;
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;
		hud_hide_radio_transmission_hud();
	end,
	
	localVariables = {
					s_speaker = nil,
					},
};


-------------------------------------------------------------------------------------------------------------------------------------------------------


function plateau_hollow_shield_destroyed_listener()

	SleepUntil([| object_valid( "hollow_projected_barrier" ) ], 200);

	PrintNarrative("LISTENER - plateau_hollow_shield_destroyed_listener");

	RegisterDeathEvent (plateau_hollow_shield_destroyed_launcher, OBJECTS.hollow_projected_barrier);

	SleepUntil([| plateau_hollow_shield_health() <= 0 ], 1);

	UnregisterDeathEvent (plateau_hollow_shield_destroyed_launcher, OBJECTS.hollow_projected_barrier);
	b_hollow_shield_is_down = true;
	
	PrintNarrative("UnregisterDeathEvent - plateau_hollow_shield_destroyed_listener");

end


function plateau_hollow_shield_destroyed_launcher(target:object, killer:object)

	PrintNarrative("LAUNCHER - plateau_hollow_shield_destroyed_launcher");

	print(killer, " is the killer of ", target);
	b_hollow_shield_killer = killer;

	b_hollow_shield_is_down = true;

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__hollow__shield_is_down");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__hollow__shield_is_down);
	NarrativeQueue.InterruptConversation(W2HubPlateau_PLATEAU__HOLLOW__shield_generator);
	NarrativeQueue.InterruptConversation(W2HubPlateau_PLATEAU__HOLLOW__shield_buckle);
	NarrativeQueue.InterruptConversation(W2HubPlateau_PLATEAU__HOLLOW__shield_damaged);

end


--[========================================================================[
          PLATEAU. hollow. shield is down
--]========================================================================]
global W2HubPlateau_PLATEAU__hollow__shield_is_down = {
	name = "W2HubPlateau_PLATEAU__hollow__shield_is_down",

	CanStart = function (thisConvo, queue)
		return  b_hollow_shield_is_down and var_cov_projector_barrier == 1; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,
	
	OnInitialize = function(thisConvo, queue)
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
		PushForwardVOReset();
	end,

	sleepBefore = 2,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,


	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return b_hollow_player_saw_shield and b_hollow_shield_killer == SPARTANS.locke; -- GAMMA_TRANSITION: IF LOCKE first destroyed the shield
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Shield's down. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_09800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return b_hollow_player_saw_shield and b_hollow_shield_killer == SPARTANS.buck; -- GAMMA_TRANSITION: If BUCK first destroyed the shield
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Shield's down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_05600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return b_hollow_player_saw_shield and b_hollow_shield_killer == SPARTANS.tanaka; -- GAMMA_TRANSITION: If tanaka first destroyed the shield
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Shield's down. \r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_09200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return b_hollow_player_saw_shield and b_hollow_shield_killer == SPARTANS.vale; -- GAMMA_TRANSITION: If vale first destroyed the shield
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Shield's down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_04200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;		
	end,
};



---------------------------------------------------------------------------------


function plateau_hollow_all_dead_listener()

	SleepUntil([| ai_living_count(AI.sg_hollow_all) > 0 ], 100);
	SleepUntil([| ai_living_count(AI.sg_hollow_all) <= 1 ], 1);

	local s_last_living_ai:object = ai_get_unit( AI.sg_hollow_all );

	PrintNarrative("LISTENER - plateau_hollow_all_dead_listener");
	print(" Last AI alive is:  ", s_last_living_ai);

	if ai_living_count(AI.sg_hollow_all) <= 0 then
		
		PrintNarrative("LISTENER - plateau_hollow_all_dead_listener - ALL DEAD");
				
		if IsSpartanAbleToSpeak(SPARTANS.buck) then
			CreateMissionThread(plateau_hollow_all_dead_launcher, s_last_living_ai, SPARTANS.buck);
		elseif IsSpartanAbleToSpeak(SPARTANS.vale) then
			CreateMissionThread(plateau_hollow_all_dead_launcher, s_last_living_ai, SPARTANS.vale);
		elseif IsSpartanAbleToSpeak(SPARTANS.tanaka) then
			CreateMissionThread(plateau_hollow_all_dead_launcher, s_last_living_ai, SPARTANS.tanaka);
		else
			CreateMissionThread(plateau_hollow_all_dead_launcher, s_last_living_ai, SPARTANS.locke);
		end
	else
		RegisterDeathEvent (plateau_hollow_all_dead_launcher, s_last_living_ai);
	end
end

function plateau_hollow_all_dead_launcher(target:object, killer:object)

	PrintNarrative("LAUNCHER - plateau_hollow_all_dead_launcher");

	print(killer, " is the killer of ", target);

	W2HubPlateau_PLATEAU__HOLLOW__all_dead.localVariables.speaker = killer;
	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__HOLLOW__all_dead");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__HOLLOW__all_dead);	
	CreateThread(audio_plateau_sentryreveal_outro);
end



--[========================================================================[
          PLATEAU. HOLLOW. all dead
--]========================================================================]
global W2HubPlateau_PLATEAU__HOLLOW__all_dead = {
	name = "W2HubPlateau_PLATEAU__HOLLOW__all_dead",

	CanStart = function (thisConvo, queue)
		return IsGoalActive(missionPlateau.goal_Hollow); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 2,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.speaker == SPARTANS.locke;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "All clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_10100.sound'),
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.speaker == SPARTANS.buck;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "All clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_06200.sound'),
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.speaker == SPARTANS.tanaka;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "All clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_09400.sound'),
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.speaker == SPARTANS.vale;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "All clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_05100.sound'),
		},
		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return plateau_hollow_shield_health() > 0 and (b_hollow_player_saw_shield or b_hollow_player_saw_shield_gen); -- GAMMA_TRANSITION: If shield is still up
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Get that shield down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_10200.sound'),
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


-- =================================================================================================
--  _____            __  __ _____  
-- |  __ \     /\   |  \/  |  __ \ 
-- | |__) |   /  \  | \  / | |__) |
-- |  _  /   / /\ \ | |\/| |  ___/ 
-- | | \ \  / ____ \| |  | | |     
-- |_|  \_\/_/    \_\_|  |_|_|     
--                                 
-- =================================================================================================


function plateau_ramp_load()

	PrintNarrative("LOAD - plateau_ramp_load");
	
	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__cave__to_the_temple");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__cave__to_the_temple);

	GoalCreateThread(missionPlateau.goal_Ramp, plateau_ramp_kraken_foot_post_impact)

	SleepUntil([| NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__cave__to_the_temple) ], 30);
		
	PrintNarrative("QUEUE - W2HubPlateau_Plateau__CAVE__Travel_on_Foot");
	NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__CAVE__Travel_on_Foot);	

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__ramp__kraken_foot");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__ramp__kraken_foot);	
	
	CreateMissionThread(plateau_ramp_kraken_flying_away_launcher);

	PushForwardVOReset();				
end




function plateau_ramp_arbiter_battle_net()

PrintNarrative("START - plateau_ramp_arbiter_battle_net");

	SleepUntil([| not b_collectible_used and not b_critical_dialogue_on and not b_ramp_kraken_going_away and IsGoalActive(missionPlateau.goal_Ramp)], 10);

	sleep_s(1);
	
	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_01");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_01);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_01 )
				and not b_collectible_used and not b_critical_dialogue_on and not b_ramp_kraken_going_away and IsGoalActive(missionPlateau.goal_Ramp)], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_02");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_02);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_02 )
				and not b_collectible_used and not b_critical_dialogue_on and not b_ramp_kraken_going_away and IsGoalActive(missionPlateau.goal_Ramp)], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_03");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_03);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_03 )], 10);

	sleep_s(2);

	SleepUntil([| b_kraken_foot_post_impact 
					and not b_collectible_used and not b_critical_dialogue_on and not b_ramp_kraken_going_away and (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl))], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_04");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_04);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_04 )], 10);

	sleep_s(1);

	SleepUntil([| not b_collectible_used and not b_critical_dialogue_on and not b_ramp_kraken_going_away and  (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl))], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_05");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_05);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_05 )], 10);

	sleep_s(2);

	SleepUntil([| not b_collectible_used and not b_critical_dialogue_on and not b_ramp_kraken_going_away and  (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl))], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_06");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_06);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_06 )], 10);

	sleep_s(6);

	SleepUntil([| not b_collectible_used and not b_critical_dialogue_on and not b_ramp_kraken_going_away and  (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl))], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_07");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_07);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_07 )], 10);	

	sleep_s(3);

	SleepUntil([| not b_collectible_used and not b_critical_dialogue_on and not b_ramp_kraken_going_away and  (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl))], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_09");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_09);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_09 )], 10);

	sleep_s(4);

	SleepUntil([| not b_collectible_used and not b_critical_dialogue_on and not b_ramp_kraken_going_away and  (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl))], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_10");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_10);

	SleepUntil([| not b_collectible_used and NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_10 ) and  not b_critical_dialogue_on and not b_ramp_kraken_going_away and (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl))], 10);

	sleep_s(2);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_15");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_15);
	
	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_15 )], 10);

	sleep_s(2);

	SleepUntil([| not b_collectible_used and not b_critical_dialogue_on and not b_ramp_kraken_going_away and  (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl))], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_11");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_11);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_11 )
				and not b_collectible_used and not b_critical_dialogue_on and not b_ramp_kraken_going_away and  (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl))], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_12");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_12);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_12 )], 10);

	sleep_s(5);

	SleepUntil([| not b_collectible_used and not b_critical_dialogue_on and not b_ramp_kraken_going_away and  (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl))], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_13");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_13);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_13 )
				and not b_collectible_used and not b_critical_dialogue_on and not b_ramp_kraken_going_away and  (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl))], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_14");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_14);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_14 )], 10);

	sleep_s(3);

	SleepUntil([| not b_collectible_used and not b_critical_dialogue_on and not b_ramp_kraken_going_away and (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl))], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_15b");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_15b);
end


--[========================================================================[
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_01 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionPlateau.goal_Ramp) and not b_ramp_player_saw_kraken;
			end,
				
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingSiqtarOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend02
			text = "Kraken's moving back.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend02_01200.sound'),

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
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_02 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_02",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	sleepBefore = 1,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionPlateau.goal_Ramp);
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "FlightLeader",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "Keep it out of range from the Spartans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend01_02200.sound'),

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
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_03 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_03",

	CanStart = function (thisConvo, queue)
		return true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	sleepBefore = 0.5,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsGoalActive(missionPlateau.goal_Ramp) and not b_ramp_player_saw_kraken;
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "FlightLeader",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "It's changing trajectory.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend01_02300.sound'),

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
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_04 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_04",

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
				return (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl)) and not (volume_test_players(VOLUMES.tv_narrative_plateau_ramp_oreo_bowl_set_up_linger) or  volume_test_players(VOLUMES.tv_narrative_plateau_ramp_kraken_flying_away));
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingLarTwo",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "Two on the left! Engaging! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend01_01200.sound'),

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
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_05 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_05",

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
				return (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl)) and not (volume_test_players(VOLUMES.tv_narrative_plateau_ramp_oreo_bowl_set_up_linger) or  volume_test_players(VOLUMES.tv_narrative_plateau_ramp_kraken_flying_away));
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingSiqtarOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend02
			text = "Incoming! Watch out! Watch out!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend02_01100.sound'),

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
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_06 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_06",

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
				return (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl)) and not (volume_test_players(VOLUMES.tv_narrative_plateau_ramp_oreo_bowl_set_up_linger) or  volume_test_players(VOLUMES.tv_narrative_plateau_ramp_kraken_flying_away));
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingLarOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend03
			text = "Taking heavy fire!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend03_01000.sound'),

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
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_07 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_07",

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
				return (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl)) and not (volume_test_players(VOLUMES.tv_narrative_plateau_ramp_oreo_bowl_set_up_linger) or  volume_test_players(VOLUMES.tv_narrative_plateau_ramp_kraken_flying_away));
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingJardamOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend04
			text = "Watch the legs!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend04_01000.sound'),

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
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_09 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_09",

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
				return (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl)) and not (volume_test_players(VOLUMES.tv_narrative_plateau_ramp_oreo_bowl_set_up_linger) or volume_test_players(VOLUMES.tv_narrative_plateau_ramp_kraken_flying_away));
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "FlightLeader",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "Sig Tar, do not attack below the deck, watch for the Kraken's legs",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend01_02400.sound'),

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
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_10 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_10",

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
				return (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl)) and not (volume_test_players(VOLUMES.tv_narrative_plateau_ramp_oreo_bowl_set_up_linger) or volume_test_players(VOLUMES.tv_narrative_plateau_ramp_kraken_flying_away));
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingSiqtarOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend02
			text = "Attacking Pulse Generator room.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend02_01300.sound'),

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
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_11 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_11",

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
				return (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl)) and not (volume_test_players(VOLUMES.tv_narrative_plateau_ramp_oreo_bowl_set_up_linger) or volume_test_players(VOLUMES.tv_narrative_plateau_ramp_kraken_flying_away));
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "FlightLeader",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "Sig Tar. Pull up, Kraken is on you.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend01_02500.sound'),

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
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_12 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_12",

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
				return (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl)) and not (volume_test_players(VOLUMES.tv_narrative_plateau_ramp_oreo_bowl_set_up_linger) or volume_test_players(VOLUMES.tv_narrative_plateau_ramp_kraken_flying_away));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingSiqtarOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend02
			text = "Just a little longer, Wing leader.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend02_01400.sound'),

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
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_13 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_13",

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
				return (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl)) and not (volume_test_players(VOLUMES.tv_narrative_plateau_ramp_oreo_bowl_set_up_linger) or volume_test_players(VOLUMES.tv_narrative_plateau_ramp_kraken_flying_away));
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "FlightLeader",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "Sig Tar. Sig tar! Look at the Leg ! PULL UP!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend01_02600.sound'),

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
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_14 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_14",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl)) and not (volume_test_players(VOLUMES.tv_narrative_plateau_ramp_oreo_bowl_set_up_linger) or volume_test_players(VOLUMES.tv_narrative_plateau_ramp_kraken_flying_away));
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingSiqtarOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend02
			text = "Pulling out!! Pulling...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend02_01500.sound'),

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
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_15 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_15",

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
				return (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl)) and not (volume_test_players(VOLUMES.tv_narrative_plateau_ramp_oreo_bowl_set_up_linger) or volume_test_players(VOLUMES.tv_narrative_plateau_ramp_kraken_flying_away));
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "FlightLeader",
			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "All Wings, do not approach the Kraken below deck.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend01_02700.sound'),

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
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_15b = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_15b",

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
				return (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl)) and not (volume_test_players(VOLUMES.tv_narrative_plateau_ramp_oreo_bowl_set_up_linger) or volume_test_players(VOLUMES.tv_narrative_plateau_ramp_kraken_flying_away));
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "FlightLeader",
			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "All wings, attract the Kraken away from the Spartans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend01_02800.sound'),

			},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};

function plateau_ramp_arbiter_battle_net_2()

PrintNarrative("START - plateau_ramp_arbiter_battle_net_2");

	--SleepUntil([| volume_test_object( VOLUMES.tv_narrative_plateau_ramp_kraken_middle, OBJECTS.vin_sent_machine ) ], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_16");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_16);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_16 )
				and not b_collectible_used and not b_critical_dialogue_on and not IsSpartanInCombat() and not b_ramp_kraken_going_away and  (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl))], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_17");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_17);

	SleepUntil([| NarrativeQueue.HasConversationFinished( W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_17 )], 10);

	sleep_s(4);

	SleepUntil([| not b_collectible_used and not b_critical_dialogue_on and not IsSpartanInCombat() and not b_ramp_kraken_going_away and  (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl))], 10);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_18");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_18);


end

--[========================================================================[
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_16 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_16",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl)) and not (volume_test_players(VOLUMES.tv_narrative_plateau_ramp_oreo_bowl_set_up_linger) or volume_test_players(VOLUMES.tv_narrative_plateau_ramp_kraken_flying_away));
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "FlightLeader",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "They are falling back!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend01_00700.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__RAMP__kraken_flying_away");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__RAMP__kraken_flying_away);
	end,
};


--[========================================================================[
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_17 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_17",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	sleepBefore = 2,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl)) and not (volume_test_players(VOLUMES.tv_narrative_plateau_ramp_oreo_bowl_set_up_linger) or volume_test_players(VOLUMES.tv_narrative_plateau_ramp_kraken_flying_away));
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingJardamOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend04
			text = "Kraken is on me.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend04_01100.sound'),

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
          PLATEAU. sentry reveal. COMBAT RADIO CHATTER
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_18 = {
	name = "W2HubPlateau_PLATEAU__sentry_reveal__COMBAT_RADIO_CHATTER_ramp_18",

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
				return (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl)) and not (volume_test_players(VOLUMES.tv_narrative_plateau_ramp_oreo_bowl_set_up_linger) or volume_test_players(VOLUMES.tv_narrative_plateau_ramp_kraken_flying_away));
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "FlightLeader",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "Keep pushing it away, focus on one side.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend01_02900.sound'),

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
          PLATEAU. cave. to the temple
--]========================================================================]
global W2HubPlateau_PLATEAU__cave__to_the_temple = {
	name = "W2HubPlateau_PLATEAU__cave__to_the_temple",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narrative_plateau_cave_to_the_temple); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;		
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return (IsGoalActive(missionPlateau.goal_Hollow) or IsGoalActive(missionPlateau.goal_Ramp));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "FlightLeader",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "They abandon their ground forces!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend01_03400.sound'),

			playDurationAdjustment = 0.9,

		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return (IsGoalActive(missionPlateau.goal_Hollow) or IsGoalActive(missionPlateau.goal_Ramp));
			end,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingSiqtarOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend02
			text = "Press the attack!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend02_01000.sound'),

			--playDurationAdjustment = 0.85,
			},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Arbiter",
			
			--character = 0, -- GAMMA_CHARACTER: ARBITER
			text = "Spartan. The enemy is retreating into the Temple grounds.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_arbiter_01800.sound'),
		},
		[4] = {
			--character = 0, -- GAMMA_CHARACTER: ARBITER
			text = "That location is between Osiris and their destination.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_arbiter_01900.sound'),
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					CreateMissionThread(PLATEAU__ramp__kraken_foot);
			end,
			
			moniker = "SarahPalmer",

			--character = 0, -- GAMMA_CHARACTER: Palmer
			text = "Copy, Arbiter. Spartans, keep the pressure on. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_palmer_01700.sound'),

			playDurationAdjustment = 0.9,		
		},
		[6] = {
			sleepBefore = 0.7,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Affirmative, Commander.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_01700.sound'),

			playDurationAdjustment = 0.85,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;
		hud_hide_radio_transmission_hud();
		CreateMissionThread(plateau_ramp_arbiter_battle_net);
	end,
};



--[========================================================================[
          Plateau. CAVE. Travel on Foot
--]========================================================================]
global W2HubPlateau_Plateau__CAVE__Travel_on_Foot = {
	name = "W2HubPlateau_Plateau__CAVE__Travel_on_Foot",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narrative_plateau_cave_travel_on_foot) and ( not AreAnyPlayersInVehicle() and not unit_in_vehicle(SPARTANS.tanaka) and not unit_in_vehicle(SPARTANS.buck)); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
	end,

	sleepBefore = 1,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return (not AreAnyPlayersInVehicle() and not unit_in_vehicle(SPARTANS.tanaka) and not unit_in_vehicle(SPARTANS.buck)); -- GAMMA_TRANSITION: If all 4 players on foot and in the cave
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Never gonna catch up on foot.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_02400.sound'),

		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return (not AreAnyPlayersInVehicle() and not unit_in_vehicle(SPARTANS.tanaka) and not unit_in_vehicle(SPARTANS.buck)); -- GAMMA_TRANSITION: If all 4 players on foot and in the cave
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "You don't like jogging Tanaka?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_01700.sound'),

		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return (not AreAnyPlayersInVehicle() and not unit_in_vehicle(SPARTANS.tanaka) and not unit_in_vehicle(SPARTANS.buck)); -- GAMMA_TRANSITION: If all 4 players on foot and in the cave
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Like it fine. Just rather have a ride.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_02500.sound'),

		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;		
	end,
};

function PLATEAU__ramp__kraken_foot()

SleepUntil([| volume_test_players(VOLUMES.tv_narrative_plateau_ramp_kraken_foot) and not b_ramp_kraken_going_away ], 1);

NarrativeQueue.InterruptConversation(W2HubPlateau_PLATEAU__cave__to_the_temple, 0.4);
NarrativeQueue.InterruptConversation(W2HubPlateau_Plateau__CAVE__Travel_on_Foot, 0.4);

end


--[========================================================================[
          PLATEAU. ramp. kraken foot
--]========================================================================]
global W2HubPlateau_PLATEAU__ramp__kraken_foot = {
	name = "W2HubPlateau_PLATEAU__ramp__kraken_foot",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.tv_narrative_plateau_ramp_kraken_foot) and not b_ramp_kraken_going_away; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
		b_ramp_player_saw_kraken = true;
		thisConvo.localVariables.speaker = GetClosestMusketeer(OBJECTS.cr_kraken_foot_attack, 50, 2);
		thisConvo.localVariables.speaker = GetClosestMusketeer(thisConvo.localVariables.speaker, 30, 2);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.speaker == SPARTANS.vale;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Kraken's back. Watch out!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_01700.sound'),
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.speaker == SPARTANS.buck;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Kraken's back. Watch out!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_08700.sound'),

		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.speaker == SPARTANS.tanaka;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Kraken's back. Watch out!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_09500.sound'),

		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.speaker == SPARTANS.locke;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Kraken's back. Watch out!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_15600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__ramp__kraken_foot_locke");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__ramp__kraken_foot_locke);
	end,

	localVariables = {
					s_speaker = nil,
					},
};


--[========================================================================[
          PLATEAU. ramp. kraken foot
--]========================================================================]
global W2HubPlateau_PLATEAU__ramp__kraken_foot_locke = {
	name = "W2HubPlateau_PLATEAU__ramp__kraken_foot_locke",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
	end,

	lines = {
		[1] = {
			sleepBefore = 0.6,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Keep your distance! Get to the temple grounds.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_19500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;
		hud_hide_radio_transmission_hud();
	end,
};
--------------------------------------------------------------------------------------------------------------------------------------------------------------
function plateau_ramp_kraken_foot_post_impact()

	PrintNarrative("WAKE - plateau_ramp_kraken_foot_post_impact");

	SleepUntil(	[|	b_kraken_foot_post_impact], 3);

	PrintNarrative("START - plateau_ramp_kraken_foot_post_impact");
	
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__ramp__kraken_foot_post_impact_buck");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__ramp__kraken_foot_post_impact_buck);
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__ramp__kraken_foot_post_impact_vale");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__ramp__kraken_foot_post_impact_vale);
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__ramp__kraken_foot_post_impact_tanaka");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__ramp__kraken_foot_post_impact_tanaka);	
	
	PrintNarrative("END - plateau_ramp_kraken_foot_post_impact");

end


--[========================================================================[
          PLATEAU. ramp. kraken foot post impact
--]========================================================================]
global W2HubPlateau_PLATEAU__ramp__kraken_foot_post_impact_buck = {
	name = "W2HubPlateau_PLATEAU__ramp__kraken_foot_post_impact_buck",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.tv_narrative_plateau_ramp_kraken_foot_post_impact, SPARTANS.buck); -- GAMMA_TRANSITION: If buck was damaged by the foot
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Sonuva!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_09800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};




--[========================================================================[
          PLATEAU. ramp. kraken foot post impact
--]========================================================================]
global W2HubPlateau_PLATEAU__ramp__kraken_foot_post_impact_vale = {
	name = "W2HubPlateau_PLATEAU__ramp__kraken_foot_post_impact_vale",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return  volume_test_object(VOLUMES.tv_narrative_plateau_ramp_kraken_foot_post_impact, SPARTANS.vale); -- GAMMA_TRANSITION: If vale was damaged by the foot
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Whoa!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_12300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};



--[========================================================================[
          PLATEAU. ramp. kraken foot post impact
--]========================================================================]
global W2HubPlateau_PLATEAU__ramp__kraken_foot_post_impact_tanaka = {
	name = "W2HubPlateau_PLATEAU__ramp__kraken_foot_post_impact_tanaka",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return  volume_test_object(VOLUMES.tv_narrative_plateau_ramp_kraken_foot_post_impact, SPARTANS.tanaka) ; -- GAMMA_TRANSITION: If tanaka was damaged by the foot
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Damn!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_10000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,



};
function plateau_ramp_kraken_flying_away_launcher()

	PrintNarrative("WAKE - plateau_ramp_kraken_flying_away_launcher");

	SleepUntil(	[|	b_kraken_flying_away], 10);

	PrintNarrative("START - plateau_ramp_kraken_flying_away_launcher");

	CreateMissionThread(plateau_ramp_arbiter_battle_net_2);

	PrintNarrative("END - plateau_ramp_kraken_flying_away_launcher");

end


--[========================================================================[
          PLATEAU. RAMP. kraken flying away
--]========================================================================]
global W2HubPlateau_PLATEAU__RAMP__kraken_flying_away = {
	name = "W2HubPlateau_PLATEAU__RAMP__kraken_flying_away",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
		b_ramp_kraken_going_away = true;
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return (not volume_test_players(VOLUMES.tv_narrative_plateau_ramp_kraken_flying_away)) and (IsGoalActive(missionPlateau.goal_PreBowl) or IsGoalActive(missionPlateau.goal_Ramp));																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					PushForwardVOReset(30);
			end,
			
			moniker = "Arbiter",

			--character = 0, -- GAMMA_CHARACTER: ARBITER
			text = "Spartans, the Kraken is pulling away. We move to pursue.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_arbiter_00700.sound'),

		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return (not volume_test_players(VOLUMES.tv_narrative_plateau_ramp_kraken_flying_away)) and (IsGoalActive(missionPlateau.goal_PreBowl) or IsGoalActive(missionPlateau.goal_Ramp));																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			
			sleepBefore = 0.4,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "SarahPalmer",				

			--character = 0, -- GAMMA_CHARACTER: Palmer
			text = "Copy, Arbiter. Good hunting.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_palmer_01800.sound'),

		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return (not volume_test_players(VOLUMES.tv_narrative_plateau_ramp_kraken_flying_away)) and (IsGoalActive(missionPlateau.goal_PreBowl) or IsGoalActive(missionPlateau.goal_Ramp));																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			sleepBefore = 0.8,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "SarahPalmer",
			
			--character = 0, -- GAMMA_CHARACTER: Palmer
			text = "Osiris, Kraken's out of the picture, keep moving!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_palmer_03300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__RAMP__push_forward");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__RAMP__push_forward);
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__RAMP__on_foot_at_the_end");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__RAMP__on_foot_at_the_end);
	end,
};


--[========================================================================[
          PLATEAU. RAMP. on foot at the end
--]========================================================================]
global W2HubPlateau_PLATEAU__RAMP__on_foot_at_the_end = {
	name = "W2HubPlateau_PLATEAU__RAMP__on_foot_at_the_end",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.tv_narrative_plateau_ramp_on_foot_at_the_end) and IsSpartanAbleToSpeak(SPARTANS.vale) and IsSpartanAbleToSpeak(SPARTANS.tanaka) and not AreAnyPlayersInVehicle() and not IsSpartanInCombat(); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 2,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);		
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return (not volume_test_players(VOLUMES.tv_narrative_plateau_ramp_kraken_flying_away)) and (IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					PushForwardVOReset();
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "All that running in basic training is Finally paying off.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_02400.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Had a drill sergeant in basic who made the whole squad jog backwards if anybody questioned orders.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_08600.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Why? What did that do?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_02500.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Taught you not to question orders.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_08700.sound'),

		},
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};


--[========================================================================[
          PLATEAU. RAMP. push forward
--]========================================================================]
global W2HubPlateau_PLATEAU__RAMP__push_forward = {
	name = "W2HubPlateau_PLATEAU__RAMP__push_forward",

	CanStart = function (thisConvo, queue)
		return (b_push_forward_vo_timer == 3 and not volume_test_players(VOLUMES.tv_narrative_plateau_ramp_oreo_bowl_set_up_linger)) or (not IsGoalActive(missionPlateau.goal_Ramp) and not IsGoalActive(missionPlateau.goal_PreBowl)); -- GAMMA_CONDITION
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
				return IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl); -- GAMMA_TRANSITION: If player is in ramp after X time after kraken went away
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					PushForwardVOReset();
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "The Kraken's gone. We can move forward.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_05600.sound'),

			},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};



function plateau_prebowl_load()

	PrintNarrative("LOAD - plateau_prebowl_load");

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__BOWL__bowl_osiris_pre_COMBAT");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__BOWL__bowl_osiris_pre_COMBAT);
	
	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__RAMP__OREO_BOWL_Set_Up");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__RAMP__OREO_BOWL_Set_Up);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__RAMP__OREO_BOWL_Set_Up_linger_2");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__RAMP__OREO_BOWL_Set_Up_linger_2);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__BOWL__bowl_covies_pre_COMBAT");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__BOWL__bowl_covies_pre_COMBAT);
	
	PushForwardVOReset(40);
		
end

--[========================================================================[
          PLATEAU. RAMP. OREO BOWL Set Up
--]========================================================================]
global W2HubPlateau_PLATEAU__RAMP__OREO_BOWL_Set_Up = {
	name = "W2HubPlateau_PLATEAU__RAMP__OREO_BOWL_Set_Up",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.tv_narrative_plateau_ramp_oreo_bowl_set_up); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(40);
		--	!!	CRITICAL DIALOGUE On	!!
		b_critical_dialogue_on = true;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "SarahPalmer",

			--character = 0, -- GAMMA_CHARACTER: Palmer
			text = "Osiris, there's an old Temple facility dead ahead of your location. Halsey says you'll find the Constructor on the other side of that.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_palmer_03200.sound'),

			sleepAfter = 0.5,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Any other way around?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_07700.sound'),

			sleepAfter = 0.3,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "SarahPalmer",

			--character = 0, -- GAMMA_CHARACTER: Palmer
			text = "None. Ammo up if you can. They're ready for you in there.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_palmer_00800.sound'),

			sleepAfter = 0.5,
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Understood, Commander. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_08600.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;
		hud_hide_radio_transmission_hud();
		PushForwardVOReset(40);
	end,
};


--PLATEAU. RAMP. OREO BOWL SET UP LINGER----------------------------------------------------------------------------------------------------
function plateau_ramp_oreo_bowl_set_up_linger()

--	to delete

end



--[========================================================================[
          PLATEAU. RAMP. OREO BOWL Set Up linger
--]========================================================================]
global W2HubPlateau_PLATEAU__RAMP__OREO_BOWL_Set_Up_linger_2 = {
	name = "W2HubPlateau_PLATEAU__RAMP__OREO_BOWL_Set_Up_linger_2",

	CanStart = function (thisConvo, queue)
		return (b_push_forward_vo_timer == 3 and IsSpartanAbleToSpeak(SPARTANS.buck) and volume_test_players(VOLUMES.tv_narrative_plateau_ramp_oreo_bowl_set_up_linger)) or not IsGoalActive(missionPlateau.goal_PreBowl) ; -- GAMMA_CONDITION
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
				return volume_test_players(VOLUMES.tv_narrative_plateau_ramp_oreo_bowl_set_up_linger) and IsGoalActive(missionPlateau.goal_PreBowl) and IsSpartanAbleToSpeak(SPARTANS.buck); -- GAMMA_TRANSITION: If player lingers before entering the bowl
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "The floor has collapsed inside, but we should be able to climb up on the right.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_06900.sound'),

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
--   ____  _____  ______ ____    ____   ______          ___      
--  / __ \|  __ \|  ____/ __ \  |  _ \ / __ \ \        / / |     
-- | |  | | |__) | |__ | |  | | | |_) | |  | \ \  /\  / /| |     
-- | |  | |  _  /|  __|| |  | | |  _ <| |  | |\ \/  \/ / | |     
-- | |__| | | \ \| |___| |__| | | |_) | |__| | \  /\  /  | |____ 
--  \____/|_|  \_\______\____/  |____/ \____/   \/  \/   |______|
--                                                               
-- =================================================================================================

function plateau_bowl_load()

	PrintNarrative("LOAD - plateau_bowl_load");
	
	CreateMissionThread(plateau_bowl_in_combat_phantoms_reinforcement);
	
	GoalCreateThread(missionPlateau.goal_Bowl, plateau_bowl_in_combat_shield_is_down_listener);
	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__BOWL__in_combat__eyes_on_ghost");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__BOWL__in_combat__eyes_on_ghost);	
	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__BOWL__in_combat__secret_passage");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__BOWL__in_combat__secret_passage);	
	
	CreateMissionThread(PLATEAU__BOWL__in_combat__plasma_battery);

	CreateMissionThread(plateau_bowl_in_combat_plasma_battery_destruction_listener);
	CreateMissionThread(plateau_bowl_in_combat_left_breakable_wall_listener);
	CreateMissionThread(plateau_bowl_in_combat_right_breakable_wall_listener);

	CreateMissionThread(plateau_bowl_in_combat_covies_at_balcony);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__BOWL__in_combat__behind_shield");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__BOWL__in_combat__behind_shield);	
	
	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__BOWL__in_combat__plasma_battery_destructio");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__BOWL__in_combat__plasma_battery_destructio);	

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__BOWL__they_go_in_the_temple");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__BOWL__they_go_in_the_temple);	
	
	CreateMissionThread(plateau_bowl_no_combat_shield_nag);
	CreateMissionThread(plateau_bowl_they_go_in_the_temple);
	CreateMissionThread(plateau_bowl_covies_in_front_of_the_temple);
	
	AIDialogManager.DisableAIDialog(AI.sq_dp_struc_1_grunts);
	AIDialogManager.DisableAIDialog(AI.sq_dp_struc_1);

	PushForwardVOReset();

	SleepUntil([| volume_test_players(VOLUMES.tv_narrative_plateau_bowl_player_entered)], 30);
	
	b_player_entered_bowl = true;

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__BOWL__in_combat__objective_call_out");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__BOWL__in_combat__objective_call_out);
	
				

end


--[========================================================================[
          PLATEAU. BOWL. bowl osiris pre COMBAT
--]========================================================================]
global W2HubPlateau_PLATEAU__BOWL__bowl_osiris_pre_COMBAT = {
	name = "W2HubPlateau_PLATEAU__BOWL__bowl_osiris_pre_COMBAT",

	CanStart = function (thisConvo, queue)
		return  volume_test_players(VOLUMES.tv_narrative_plateau_bowl_osiris_pre_combat) ; -- GAMMA_CONDITION
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
				return false;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "SarahPalmer",

			--character = 0, -- GAMMA_CHARACTER: Palmer
			text = "Osiris, there's an old Temple facility dead ahead of your location. Halsey says you'll find the Constructor on the other side of that.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_palmer_03200.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateThread(plateau_bowl_in_combat_objective_call_out);
		CreateThread(prebowl_objective);				--tjp
	end,
};


--[========================================================================[
          PLATEAU. BOWL. bowl covies pre COMBAT
--]========================================================================]
global W2HubPlateau_PLATEAU__BOWL__bowl_covies_pre_COMBAT = {
	name = "W2HubPlateau_PLATEAU__BOWL__bowl_covies_pre_COMBAT",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_dp_struc_1) > 0 and volume_test_players(VOLUMES.tv_narrative_plateau_bowl_covies_pre_combat); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,


	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
		CreateMissionThread(plateau_bowl_covies_pre_combat_interrupted_grunt);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return ai_combat_status(AI.sq_dp_struc_1) <= 3; -- GAMMA_TRANSITION: When player approach the bowl
			end,

			character = AI.sq_dp_struc_1_grunts.spawn_points_0, -- GAMMA_CHARACTER: Grunt02
			text = "I heard they killed Jul 'Mdama.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_01600.sound'),
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return ai_combat_status(AI.sq_dp_struc_1) <= 3; -- GAMMA_TRANSITION: When player approach the bowl
			end,
			character = AI.sq_dp_struc_1_grunts.spawn_points_2, -- GAMMA_CHARACTER: Grunt03
			text = "They did! My friend's shipmate was there. He said --",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt03_00200.sound'),

			playDurationAdjustment = 0.8,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return ai_combat_status(AI.sq_dp_struc_1) <= 3; -- GAMMA_TRANSITION: When player approach the bowl
			end,
			character = AI.sq_dp_struc_1.spawn_points_2, -- GAMMA_CHARACTER: Elite03
			text = "Silence! Pay attention, fools.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite02_00600.sound'),
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return ai_combat_status(AI.sq_dp_struc_1) <= 3; -- GAMMA_TRANSITION: When player approach the bowl
			end,
			character = AI.sq_dp_struc_1.spawn_points_2, -- GAMMA_CHARACTER: Elite03
			text = "The false Arbiter is weak.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite02_00700.sound'),


		},
		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return ai_combat_status(AI.sq_dp_struc_1) <= 3; -- GAMMA_TRANSITION: When player approach the bowl
			end,
			character = AI.sq_dp_struc_1.spawn_points_2, -- GAMMA_CHARACTER: Elite03
			text = "He requires humans to fight his battles.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite02_00800.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--AIDialogManager.EnableAIDialog(AI.sq_dp_struc_1_grunts);
		--AIDialogManager.EnableAIDialog(AI.sq_dp_struc_1);
	end,
};

function plateau_bowl_covies_pre_combat_interrupted_grunt()

	PrintNarrative("START - plateau_bowl_covies_pre_combat_interrupted_grunt");

	SleepUntil([| ai_combat_status(AI.sq_dp_struc_1_grunts) > 3], 10);

	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__BOWL__bowl_covies_pre_COMBAT_interrupted_grunt, AI.sq_dp_struc_1_grunts, ACTOR_TYPE.grunt, "enemy_in_range", missionPlateau.goal_Bowl, 20 );
	PrintNarrative("INTERRUPT COVIES PRE BOWL CONVO bis");
	NarrativeQueue.InterruptConversation(W2HubPlateau_PLATEAU__BOWL__bowl_covies_pre_COMBAT);

	sleep_s(0.7);
	CreateMissionThread(plateau_bowl_covies_pre_combat_interrupted_elite);
	
end

--[========================================================================[
          PLATEAU. BOWL. bowl covies pre COMBAT interrupted
--]========================================================================]
global W2HubPlateau_PLATEAU__BOWL__bowl_covies_pre_COMBAT_interrupted_grunt = {
	name = "W2HubPlateau_PLATEAU__BOWL__bowl_covies_pre_COMBAT_interrupted_grunt",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	sleepBefore = 0.3,

	lines = {
		[1] = {
			--character = 0 -- GAMMA_CHARACTER: Grunt01
			text = "The humans are here!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt01_00600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};

-------------------------------

function plateau_bowl_covies_pre_combat_interrupted_elite()

	PrintNarrative("START - plateau_bowl_covies_pre_combat_interrupted_grunt");
	
	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__BOWL__bowl_covies_pre_COMBAT_interrupted_elite, AI.sq_dp_struc_1, ACTOR_TYPE.elite, "enemy_in_range", missionPlateau.goal_Bowl, 20 );
	PrintNarrative("INTERRUPT COVIES PRE BOWL CONVO");
	NarrativeQueue.InterruptConversation(W2HubPlateau_PLATEAU__BOWL__bowl_covies_pre_COMBAT);
end

--[========================================================================[
          PLATEAU. BOWL. bowl covies pre COMBAT interrupted
--]========================================================================]
global W2HubPlateau_PLATEAU__BOWL__bowl_covies_pre_COMBAT_interrupted_elite = {
	name = "W2HubPlateau_PLATEAU__BOWL__bowl_covies_pre_COMBAT_interrupted_elite",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.enemy_in_range ~= nil;
			end,
			--character = 0 -- GAMMA_CHARACTER: Elite01
			text = "The infidels! Kill them!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_01500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};
------------------------------------------------------------------------------------------------------------------------------------------------------
function plateau_bowl_shield_health()

	local shield_health:number = -1;

	if object_valid("dp_powersupply_1") and object_list_children (OBJECTS.dp_powersupply_1, TAG ('levels\assets\osiris\props\generic_covenant\cov_projector_barrier\cov_projector_barrier_shield\cov_projector_barrier_shield.crate')) ~= nil then

		shield_health = object_get_health (object_list_children (OBJECTS.dp_powersupply_1, TAG ('levels\assets\osiris\props\generic_covenant\cov_projector_barrier\cov_projector_barrier_shield\cov_projector_barrier_shield.crate'))[1]);
		--print("Shield's Health: ", shield_health);
	else
		shield_health = -1;
	end

	return shield_health
end


--PLATEAU. BOWL. IN COMBAT. OBJECTIVE CALL OUT----------------------------------------------------------------------------------------------------
function plateau_bowl_in_combat_objective_call_out()

	PrintNarrative("WAKE - plateau_bowl_in_combat_objective_call_out");

	PrintNarrative("START - plateau_bowl_in_combat_objective_call_out");

		if plateau_bowl_shield_health() > 0 and not b_bowl_player_behind_the_shield then

			PushForwardVOReset();

		end

	PrintNarrative("END - plateau_bowl_in_combat_objective_call_out");

end


--[========================================================================[
          PLATEAU. BOWL. in combat. objective call out

          When the Players are far enough into the bowl
--]========================================================================]
global W2HubPlateau_PLATEAU__BOWL__in_combat__objective_call_out = {
	name = "W2HubPlateau_PLATEAU__BOWL__in_combat__objective_call_out",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return b_player_entered_bowl and IsSpartanAbleToSpeak(SPARTANS.buck) and IsSpartanAbleToSpeak(SPARTANS.locke) and ((IsPlayer(SPARTANS.buck) and objects_distance_to_object( SPARTANS.buck, OBJECTS.dp_powersupply_1 ) < 100) or not IsPlayer(SPARTANS.buck) ) and plateau_bowl_shield_health() > 0;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE ON	!!
			b_critical_dialogue_on = true;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return plateau_bowl_shield_health() > 0; -- GAMMA_TRANSITION: When player look at the shield or halfway through the bowl
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "I notice there's another shield in the way.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_02600.sound'),

			sleepAfter = 0.5,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return plateau_bowl_shield_health() > 0; -- GAMMA_TRANSITION: When player look at the shield or halfway through the bowl
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Let's find a way past.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_02800.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_bowl_player_saw_the_shield = true;
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;
		hud_hide_radio_transmission_hud();
	end,
};


--PLATEAU. BOWL. IN COMBAT. PHANTOMS REINFORCEMENT----------------------------------------------------------------------------------------------------
function plateau_bowl_in_combat_phantoms_reinforcement()

	PrintNarrative("WAKE - plateau_bowl_in_combat_phantoms_reinforcement");
	
	repeat
		PrintNarrative("plateau_bowl_in_combat_phantoms_reinforcement repeat: start")
		SleepUntil([| objects_can_see_object( players(), ai_get_object( AI.sq_dp_phantom_3_w.spawn_points_1), 60 )
				 ], 20);
		PrintNarrative("plateau_bowl_in_combat_phantoms_reinforcement repeat: passed first Sleepuntil")
		PrintNarrative("plateau_bowl_in_combat_phantoms_reinforcement repeat: start sleep")
		sleep_s(0.5);
		PrintNarrative("plateau_bowl_in_combat_phantoms_reinforcement repeat: end sleep")
	until	IsGoalActive(missionPlateau.goal_Tomb)
			or (not b_critical_dialogue_on and objects_can_see_object( players(), ai_get_object( AI.sq_dp_phantom_3_w.spawn_points_1), 60 ))
			or	ai_living_count(AI.sq_dp_phantom_3_w.spawn_points_1) == 0

	PrintNarrative("START - plateau_bowl_in_combat_phantoms_reinforcement");				

	if (not IsGoalActive(missionPlateau.goal_Tomb)) and objects_can_see_object( players(), ai_get_object( AI.sq_dp_phantom_3_w.spawn_points_1), 60 ) and IsSpartanAbleToSpeak(SPARTANS.tanaka) and not b_bowl_player_behind_the_shield then

			PushForwardVOReset();			

			PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__BOWL__In_combat__phantoms_reinforcement");
			NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__BOWL__In_combat__phantoms_reinforcement);		

			
	else

	PrintNarrative("SKIPPED - plateau_bowl_in_combat_phantoms_reinforcement");

	end
	
	PrintNarrative("END - plateau_bowl_in_combat_phantoms_reinforcement");

end


--[========================================================================[
          PLATEAU. BOWL. In combat. phantoms reinforcement

          Beyond them, we see the Phantoms glimpsed earlier dropping
          off Covenant troops throughout the bowl.
--]========================================================================]
global W2HubPlateau_PLATEAU__BOWL__In_combat__phantoms_reinforcement = {
	name = "W2HubPlateau_PLATEAU__BOWL__In_combat__phantoms_reinforcement",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Heads up! Incoming reinforcements!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_01200.sound'),

		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Must've seen their buddies getting their asses kicked and decided to get some too.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_02700.sound'),

		},

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
			b_critical_dialogue_on = false;
			hud_hide_radio_transmission_hud();
	end,
};


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function plateau_bowl_in_combat_left_breakable_wall_listener()

	SleepUntil([| object_valid("bashwall4") ], 100);

	PrintNarrative("LISTENER - plateau_bowl_in_combat_left_breakable_wall_listener");

	--RegisterDeathEvent (plateau_bowl_in_combat_left_breakable_wall_launcher, OBJECTS.bashwall4);

	SleepUntil([| volume_test_players( VOLUMES.plateau_bowl_bashwall4 )  ], 1);

	plateau_bowl_in_combat_left_breakable_wall_launcher(OBJECTS.bashwall4, GetClosestMusketeer(OBJECTS.bashwall4, 4, 2))

end

function plateau_bowl_in_combat_left_breakable_wall_launcher(target:object, killer:object)

	PrintNarrative("LAUNCHER - plateau_bowl_in_combat_left_breakable_wall_launcher");

	print(killer, " is the killer of ", target);

	CreateMissionThread(plateau_bowl_in_combat_left_breakable_wall, killer);
end



-------------------------------

function plateau_bowl_in_combat_left_breakable_wall(killer:object)

	PrintNarrative("WAKE - plateau_bowl_in_combat_left_breakable_wall");

	SleepUntil([| volume_test_players( VOLUMES.tv_narrative_plateau_bowl_in_combat_covies_at_balcony )], 10);

	PrintNarrative("START - plateau_bowl_in_combat_left_breakable_wall");

		PushForwardVOReset();	

		--sleep_s(0.1);
		W2HubPlateau_PLATEAU__BOWL__in_combat__left_breakable_wall.localVariables.speaker = killer;
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__BOWL__in_combat__left_breakable_wall");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__BOWL__in_combat__left_breakable_wall);
				
		

	PrintNarrative("END - plateau_bowl_in_combat_left_breakable_wall");

end


--[========================================================================[
          PLATEAU. BOWL. in combat. left breakable wall

          On the left side, there is a breakable wall that leads to the
          balcony.
--]========================================================================]
global W2HubPlateau_PLATEAU__BOWL__in_combat__left_breakable_wall = {
	name = "W2HubPlateau_PLATEAU__BOWL__in_combat__left_breakable_wall",

	CanStart = function (thisConvo, queue)
		return thisConvo.localVariables.speaker ~= nil and volume_test_players( VOLUMES.tv_narrative_plateau_bowl_in_combat_covies_at_balcony); -- GAMMA_CONDITION
	end,

	Timeout = function (thisConvo, queue) -- NUMBER
		return 8;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.speaker == SPARTANS.locke and volume_test_object( VOLUMES.tv_narrative_plateau_bowl_in_combat_covies_at_balcony, SPARTANS.locke ); -- GAMMA_TRANSITION: If locke first breaks the wall on the left side
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Left building. Broke through a wall to get in.  ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03900.sound'),

			playDurationAdjustment = 0.8,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.speaker == SPARTANS.buck and volume_test_object( VOLUMES.tv_narrative_plateau_bowl_in_combat_covies_at_balcony, SPARTANS.buck ) ; -- GAMMA_TRANSITION: If BUCK first breaks the wall on the left side
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Left building! Broke through a wall to get in. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_01000.sound'),

			playDurationAdjustment = 0.8,
			
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.speaker == SPARTANS.tanaka and volume_test_object( VOLUMES.tv_narrative_plateau_bowl_in_combat_covies_at_balcony, SPARTANS.tanaka ); -- GAMMA_TRANSITION: If tanaka first breaks the wall on the left side
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			playDurationAdjustment = 0.8,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Left building! Broke through a wall to get in. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_01400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.speaker == SPARTANS.vale and volume_test_object( VOLUMES.tv_narrative_plateau_bowl_in_combat_covies_at_balcony, SPARTANS.vale ); -- GAMMA_TRANSITION: If vale first breaks the wall on the left side
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			playDurationAdjustment = 0.8,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Left building! Broke through a wall to get in. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_00900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {
						speaker = nil,
						},
};



--PLATEAU. BOWL. IN COMBAT. COVIES AT BALCONY----------------------------------------------------------------------------------------------------
function plateau_bowl_in_combat_covies_at_balcony()

	PrintNarrative("WAKE - plateau_bowl_in_combat_covies_at_balcony");

	SleepUntil([| object_get_health( OBJECTS.bashwall4) < 0.3 or volume_test_players(VOLUMES.tv_narrative_plateau_bowl_in_combat_covies_at_balcony) ], 20);
	
	if object_get_health( OBJECTS.bashwall4) < 0.3 then
	
				PrintNarrative("START - plateau_bowl_in_combat_covies_at_balcony - line 1");

				sleep_s(1);
				
				CreateMissionThread(plateau_bowl_in_combat_covies_at_balcony_grunt01);				
	end

	SleepUntil([| volume_test_players(VOLUMES.tv_narrative_plateau_bowl_in_combat_covies_at_balcony) ], 20);

				sleep_s(1);								

				PrintNarrative("START - plateau_bowl_in_combat_covies_at_balcony  - line 2");
				
				CreateMissionThread(plateau_bowl_in_combat_covies_at_balcony_grunt02);

	PrintNarrative("END - plateau_bowl_in_combat_covies_at_balcony");

end


function plateau_bowl_in_combat_covies_at_balcony_grunt01()

	PrintNarrative("START - plateau_bowl_covies_pre_combat_interrupted_grunt");
	
	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__BOWL__in_combat__covies_at_balcony_grunt01, AI.sq_dp_leftcave, ACTOR_TYPE.grunt, "enemy_in_range", missionPlateau.goal_Bowl, 20 );	

end

--[========================================================================[
          PLATEAU. BOWL. in combat. covies at balcony

          Up the stairs in that building we come face to face with
          grunts.
--]========================================================================]
global W2HubPlateau_PLATEAU__BOWL__in_combat__covies_at_balcony_grunt01 = {
	name = "W2HubPlateau_PLATEAU__BOWL__in_combat__covies_at_balcony_grunt01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			--character = 0 -- GAMMA_CHARACTER: Grunt01
			text = "What was that!!!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt01_02100.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};



function plateau_bowl_in_combat_covies_at_balcony_grunt02()

	PrintNarrative("START - plateau_bowl_covies_pre_combat_interrupted_grunt");
	
	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__BOWL__in_combat__covies_at_balcony_grunt02, AI.sq_dp_leftcave, ACTOR_TYPE.grunt, "enemy_in_range", missionPlateau.goal_Bowl, 20 );
end

--[========================================================================[
          PLATEAU. BOWL. in combat. covies at balcony

          Up the stairs in that building we come face to face with
          grunts.
--]========================================================================]
global W2HubPlateau_PLATEAU__BOWL__in_combat__covies_at_balcony_grunt02 = {
	name = "W2HubPlateau_PLATEAU__BOWL__in_combat__covies_at_balcony_grunt02",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			--character = 0 -- GAMMA_CHARACTER: Grunt01
			text = "How did they get in here?!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt01_01400.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(plateau_bowl_in_combat_covies_at_balcony_grunt03);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};


function plateau_bowl_in_combat_covies_at_balcony_grunt03()

	PrintNarrative("START - plateau_bowl_covies_pre_combat_interrupted_grunt");
	
	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__BOWL__in_combat__covies_at_balcony_grunt03, AI.sq_dp_leftcave, ACTOR_TYPE.grunt, "enemy_in_range", missionPlateau.goal_Bowl, 20 );
end

--[========================================================================[
          PLATEAU. BOWL. in combat. covies at balcony

          Up the stairs in that building we come face to face with
          grunts.
--]========================================================================]
global W2HubPlateau_PLATEAU__BOWL__in_combat__covies_at_balcony_grunt03 = {
	name = "W2HubPlateau_PLATEAU__BOWL__in_combat__covies_at_balcony_grunt03",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			--character = 0 -- GAMMA_CHARACTER: Grunt01
			text = "Run away! Run awayyyy!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt01_01500.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
						enemy_in_range = nil,
						},
};


----------------------------------------------------------------------------------------------------------------------------------------------------------

function plateau_bowl_in_combat_right_breakable_wall_listener()

	SleepUntil([| object_valid("bashwall5") ], 100);

	PrintNarrative("LISTENER - plateau_bowl_in_combat_right_breakable_wall_listener");

	--RegisterDeathEvent (plateau_bowl_in_combat_right_breakable_wall_launcher, OBJECTS.bashwall5);

	SleepUntil([| volume_test_players( VOLUMES.plateau_bowl_bashwall5 )  ], 1);

	plateau_bowl_in_combat_right_breakable_wall_launcher(OBJECTS.bashwall5, GetClosestMusketeer(OBJECTS.bashwall5, 4, 2))
end

function plateau_bowl_in_combat_right_breakable_wall_launcher(target:object, killer:object)

	PrintNarrative("LAUNCHER - plateau_bowl_in_combat_right_breakable_wall_launcher");

	print(killer, " is the killer of ", target);
	
	W2HubPlateau_PLATEAU__BOWL__right_breakable_wall.localVariables.s_speaker = killer
	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__BOWL__right_breakable_wall");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__BOWL__right_breakable_wall);	
end


--[========================================================================[
          PLATEAU. BOWL. right breakable wall

          On the right side, near the shield there is a breakable wall
          that leads to the behind the shield.
--]========================================================================]
global W2HubPlateau_PLATEAU__BOWL__right_breakable_wall = {
	name = "W2HubPlateau_PLATEAU__BOWL__right_breakable_wall",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.tv_narrative_plateau_bowl_in_combat_right_breakable_wall) and volume_test_players_lookat(VOLUMES.tv_narrative_plateau_oreobowl_behind_shield, 9, 50 ); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
		b_bowl_player_came_from_breakable_wall = true;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke and plateau_bowl_shield_health() > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Found a way behind the shield. Breakable wall, right hand side.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_10800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck and plateau_bowl_shield_health() > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Found a way behind the shield. Breakable wall, right hand side.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_07200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka and plateau_bowl_shield_health() > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Found a way behind the shield. Breakable wall, right hand side.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_09800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale and plateau_bowl_shield_health() > 0;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Found a way behind the shield. Breakable wall, right hand side.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_05800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {
					s_speaker = nil,
					},
};

function PLATEAU__BOWL__in_combat__plasma_battery()
local s_speaker:object = nil;

PrintNarrative("START - PLATEAU__BOWL__in_combat__plasma_battery");

repeat
	SleepUntil ( [| object_at_distance_and_can_see_object(players(), OBJECTS.dc_scan_shieldgenerator, 8, 20) ], 60 );

	s_speaker = spartan_look_at_object(players(), OBJECTS.dc_scan_shieldgenerator, 8, 20, 0.5, 2);

until s_speaker	~= nil or plateau_bowl_shield_health() <= 0

if plateau_bowl_shield_health() > 0 then
	W2HubPlateau_PLATEAU__BOWL__in_combat__plasma_battery.localVariables.s_speaker = s_speaker
	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__BOWL__in_combat__plasma_battery");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__BOWL__in_combat__plasma_battery);
end

end

--[========================================================================[
          PLATEAU. BOWL. in combat. plasma battery
--]========================================================================]
global W2HubPlateau_PLATEAU__BOWL__in_combat__plasma_battery = {
	name = "W2HubPlateau_PLATEAU__BOWL__in_combat__plasma_battery",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not b_bowl_plasma_battery_enabled and thisConvo.localVariables.s_speaker == SPARTANS.locke;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Plasma battery here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_05000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				b_bowl_who_saw_the_plasma_battery = SPARTANS.locke;				
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return not b_bowl_plasma_battery_enabled and thisConvo.localVariables.s_speaker == SPARTANS.tanaka;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Found a plasma battery. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_03300.sound'),

			sleepAfter = 0.4,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				b_bowl_who_saw_the_plasma_battery = SPARTANS.tanaka;
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return not b_bowl_plasma_battery_enabled and thisConvo.localVariables.s_speaker == SPARTANS.vale;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "There's a plasma battery here!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_03400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				b_bowl_who_saw_the_plasma_battery = SPARTANS.vale;
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return not b_bowl_plasma_battery_enabled and thisConvo.localVariables.s_speaker == SPARTANS.buck;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Got eyes on a plasma battery. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_02900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				b_bowl_who_saw_the_plasma_battery = SPARTANS.buck;
			end,
		},
--           The discussion continues.

		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return false; -- GAMMA_TRANSITION: Tanaka answers all
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Could bust that thing and cause some havoc.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_03400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[6] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not b_bowl_plasma_battery_enabled;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Could hack that thing, cause some havoc.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_03500.sound'),

		},
		[7] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not b_bowl_plasma_battery_enabled;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "I like the way you think Tanaka.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_05100.sound'),

			sleepAfter = 0.6,
		},
		[8] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not b_bowl_plasma_battery_enabled and b_bowl_who_saw_the_plasma_battery == SPARTANS.buck; -- GAMMA_TRANSITION: IF TANAKA FOUND THE plasma battery:
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Hack it Buck.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_05800.sound'),

		},
		[9] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return not b_bowl_plasma_battery_enabled and b_bowl_who_saw_the_plasma_battery == SPARTANS.tanaka; -- GAMMA_TRANSITION: IF TANAKA FOUND THE plasma battery:
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Do it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_05400.sound'),

		},
		[10] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return not b_bowl_plasma_battery_enabled and b_bowl_who_saw_the_plasma_battery == SPARTANS.vale; -- GAMMA_TRANSITION: IF TANAKA FOUND THE plasma battery:
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Hack it Vale.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_05300.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {
					s_speaker = nil,
					},
};



--PLATEAU. BOWL. IN COMBAT. PLASMA BATTERY DESTRUCTION----------------------------------------------------------------------------------------------------
--dc_scan_shieldgenerator



function plateau_bowl_in_combat_plasma_battery_destruction_listener()

	SleepUntil([| object_valid( "dc_scan_shieldgenerator" )  ], 60);

	PrintNarrative("LISTENER - plateau_bowl_in_combat_plasma_battery_destruction_listener");

	CreateMissionThread(RegisterInteractEvent, plateau_bowl_in_combat_plasma_battery_destruction_launcher, OBJECTS.dc_scan_shieldgenerator);

end

function plateau_bowl_in_combat_plasma_battery_destruction_launcher(target:object, killer:object)

	PrintNarrative("LAUNCHER - plateau_bowl_in_combat_plasma_battery_destruction_launcher");

	b_bowl_plasma_battery_enabled = true;

	print(killer, " is the killer of ", target);

	CreateMissionThread(plateau_bowl_in_combat_plasma_battery_destruction, killer);



end

-------------------------------------

function plateau_bowl_in_combat_plasma_battery_destruction(killer:object)

	PrintNarrative("WAKE - plateau_bowl_in_combat_plasma_battery_destruction");
	PrintNarrative("START - plateau_bowl_in_combat_plasma_battery_destruction");

	sleep_s(0.3);

	W2HubPlateau_PLATEAU__BOWL__in_combat__plasma_battery_destructio.localVariables.s_speaker = killer;	

	sleep_s(0.1);

	plateau_bowl_in_combat_shield_is_down(killer);	

	PrintNarrative("END - plateau_bowl_in_combat_plasma_battery_destruction");

end



--[========================================================================[
          PLATEAU. BOWL. in combat. plasma battery destruction

          On Destruction of the Plasma Battery:
--]========================================================================]
global W2HubPlateau_PLATEAU__BOWL__in_combat__plasma_battery_destructio = {
	name = "W2HubPlateau_PLATEAU__BOWL__in_combat__plasma_battery_destructio",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return thisConvo.localVariables.s_speaker ~= nil;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	CheckFrequency = function (thisConvo, queue) -- NUMBER
		return 1;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
	end,

	sleepBefore = 2,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Hell of a light show boss!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_03000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck or thisConvo.localVariables.s_speaker == SPARTANS.tanaka or thisConvo.localVariables.s_speaker == SPARTANS.vale;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Well done!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_05900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {
					s_speaker = nil,
					},
};




--[========================================================================[
          PLATEAU. BOWL. in combat. eyes on ghost

          Whoever first discovers the hidden Ghosts in the cave on the
          right side calls out the discovery to the team.
--]========================================================================]
global W2HubPlateau_PLATEAU__BOWL__in_combat__eyes_on_ghost = {
	name = "W2HubPlateau_PLATEAU__BOWL__in_combat__eyes_on_ghost",

	CanStart = function (thisConvo, queue)
		return not b_critical_dialogue_on and volume_test_players(VOLUMES.tv_narrative_plateau_bowl_in_combat_eye_on_ghost) and plateau_bowl_shield_health() > 0.1; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.tv_narrative_plateau_bowl_in_combat_eye_on_ghost, SPARTANS.locke) ; -- GAMMA_TRANSITION: If locke First look at ghosts
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Visual on Ghosts. Caves by the statues.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_06000.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER				
				return 3;
			end,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Hell yes! Put 'em to good use!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_03600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.tv_narrative_plateau_bowl_in_combat_eye_on_ghost, SPARTANS.buck) ; -- GAMMA_TRANSITION: If BUCK First look at ghosts
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Hey, there's some Ghosts in the caves by the statues.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_03100.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER				
				return 5;
			end,
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Good call Buck. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_06400.sound'),


			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.tv_narrative_plateau_bowl_in_combat_eye_on_ghost, SPARTANS.tanaka); -- GAMMA_TRANSITION: If tanaka First look at ghosts
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Got some Ghosts in the caves beside the statues.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_03700.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER				
				return 7;
			end,
		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Good call Tanaka. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_06100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[7] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.tv_narrative_plateau_bowl_in_combat_eye_on_ghost, SPARTANS.vale); -- GAMMA_TRANSITION: If vale First look at ghosts
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "I see Ghosts by the statues of Mak Vadam.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_03500.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER				
				return 0;
			end,
		},
		[8] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Good call Vale. \r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_06200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[9] = {
			sleepBefore = 0.4,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Grab a ride.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_00100.sound'),

		},

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;
		hud_hide_radio_transmission_hud();
	end,
};




--[========================================================================[
          PLATEAU. BOWL. in combat. secret passage

          Whoever first sees the hidden entrance to the temple
          underneath the bridge calls it out.
--]========================================================================]
global W2HubPlateau_PLATEAU__BOWL__in_combat__secret_passage = {
	name = "W2HubPlateau_PLATEAU__BOWL__in_combat__secret_passage",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.tv_narrative_plateau_bowl_in_combat_secret_passage_lookat) and (object_get_health(OBJECTS.bashwall6) < 0.8); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
	end,

	sleepBefore = 0.5,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.tv_narrative_plateau_bowl_in_combat_secret_passage_lookat, SPARTANS.locke ); -- GAMMA_TRANSITION: If locke first found the passage under shield
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Passageway under the shield.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_07100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.tv_narrative_plateau_bowl_in_combat_secret_passage_lookat, SPARTANS.buck ); -- GAMMA_TRANSITION: If BUCK first found the passage under shield
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "There's a passageway under the shield.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_03300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.tv_narrative_plateau_bowl_in_combat_secret_passage_lookat, SPARTANS.tanaka ); -- GAMMA_TRANSITION: If tanaka first found the passage under shield
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Passageway under the shield.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_04000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.tv_narrative_plateau_bowl_in_combat_secret_passage_lookat, SPARTANS.vale ) ; -- GAMMA_TRANSITION: If vale first found the passage under shield
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "There's a passageway under the shield.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_03800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;
		hud_hide_radio_transmission_hud();
	end,
};


--[========================================================================[
          PLATEAU. BOWL. in combat. behind shield

          The player can jump on top of the ruins and find himself
          behind the shield, while the shield is still up. In that
          case, that character should informs the other players.
--]========================================================================]
global W2HubPlateau_PLATEAU__BOWL__in_combat__behind_shield = {
	name = "W2HubPlateau_PLATEAU__BOWL__in_combat__behind_shield",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.tv_narrative_plateau_oreobowl_behind_shield); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
		PushForwardVOReset();
		b_bowl_player_behind_the_shield = true;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not b_bowl_player_came_from_breakable_wall and volume_test_object(VOLUMES.tv_narrative_plateau_oreobowl_behind_shield, SPARTANS.locke ) and plateau_bowl_shield_health() > 0.1; -- GAMMA_TRANSITION: If locke first get behind the shield while still up
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "I'm on the other side of the shield. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_12000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return not b_bowl_player_came_from_breakable_wall and volume_test_object(VOLUMES.tv_narrative_plateau_oreobowl_behind_shield, SPARTANS.buck ) and plateau_bowl_shield_health() > 0.1; -- GAMMA_TRANSITION: If BUCK first get behind the shield while still up
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "I'm on the other side of the shield.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_07300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return not b_bowl_player_came_from_breakable_wall and volume_test_object(VOLUMES.tv_narrative_plateau_oreobowl_behind_shield, SPARTANS.tanaka ) and plateau_bowl_shield_health() > 0.1; -- GAMMA_TRANSITION: If tanaka first get behind the shield while still up
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Made it to the other side of the shield.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_10300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return not b_bowl_player_came_from_breakable_wall and volume_test_object(VOLUMES.tv_narrative_plateau_oreobowl_behind_shield, SPARTANS.vale ) and plateau_bowl_shield_health() > 0.1; -- GAMMA_TRANSITION: If vale first get behind the shield while still up
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "I'm on the other side of the shield.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_06100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;		
		b_bowl_palmer_proceed_with_mission = true;
		hud_hide_radio_transmission_hud();
	end,
};


--PLATEAU. BOWL. NO COMBAT. SHIELD NAG----------------------------------------------------------------------------------------------------
function plateau_bowl_no_combat_shield_nag()

	--	REPLACE BY REAL SHIELD HEALTH

	PrintNarrative("WAKE - plateau_bowl_no_combat_shield_nag");
	
	SleepUntil([| b_bowl_player_saw_the_shield ], 120);

	PrintNarrative("TIMER - plateau_bowl_no_combat_shield_nag - line 1");

	sleep_s(120);

	repeat
			sleep_s(0.3);
			SleepUntil([| IsSpartanInCombat() and IsSpartanAbleToSpeak(SPARTANS.locke) and not b_critical_dialogue_on and object_at_distance_and_can_see_object(SPARTANS.locke, OBJECTS.dp_powersupply_1, 80, 15, VOLUMES.tv_narrative_plateau_bowl_no_combat_shield_nag_01) ], 30);

	until	spartan_look_at_object(SPARTANS.locke, OBJECTS.dp_powersupply_1, 80, 15, 1, 2) == SPARTANS.locke or b_bowl_player_behind_the_shield or plateau_bowl_shield_health() <= 0
	
	if not b_bowl_player_behind_the_shield and IsGoalActive(missionPlateau.goal_Bowl) and plateau_bowl_shield_health() > 0 then

			PrintNarrative("START - plateau_bowl_no_combat_shield_nag - line 1");
			
			--	!!	CRITICAL DIALOGUE ON	!!
			b_critical_dialogue_on = true;

			PushForwardVOReset();

			PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__BOWL__PUSH_FORWARD");
			NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__BOWL__PUSH_FORWARD);	

			SleepUntil([| NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__BOWL__PUSH_FORWARD)  ], 20);

			--	!!	CRITICAL DIALOGUE OFF	!!
			b_critical_dialogue_on = false;

	end
	
	sleep_s(60);

	repeat
			sleep_s(0.3);
			SleepUntil([| IsSpartanInCombat() and IsSpartanAbleToSpeak(SPARTANS.locke) and not b_critical_dialogue_on and object_at_distance_and_can_see_object(SPARTANS.locke, OBJECTS.dp_powersupply_1, 50, 15, VOLUMES.tv_narrative_plateau_bowl_no_combat_shield_nag_01) ], 30);

	until	spartan_look_at_object(SPARTANS.locke, OBJECTS.dp_powersupply_1, 50, 15, 1, 2) == SPARTANS.locke or b_bowl_player_behind_the_shield	or plateau_bowl_shield_health() <= 0

	if not b_bowl_player_behind_the_shield and IsGoalActive(missionPlateau.goal_Bowl) and plateau_bowl_shield_health() > 0 then
												
					PrintNarrative("START - plateau_bowl_no_combat_shield_nag - line 2");
					
					--	!!	CRITICAL DIALOGUE ON	!!	
					b_critical_dialogue_on = true;

					PushForwardVOReset();

					sleep_s(2);

					PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__BOWL__PUSH_FORWARD_2");
					NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__BOWL__PUSH_FORWARD_2);	
					

					SleepUntil([| NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__BOWL__PUSH_FORWARD_2)  ], 20);
				
					--	!!	CRITICAL DIALOGUE OFF	!!
					b_critical_dialogue_on = false;		
	end

	sleep_s(60);

	PrintNarrative("START - plateau_bowl_no_combat_shield_nag - line 3");

	repeat
			sleep_s(0.3);
			SleepUntil([| IsSpartanAbleToSpeak(SPARTANS.buck) and not b_critical_dialogue_on and object_at_distance_and_can_see_object(SPARTANS.buck, OBJECTS.dp_powersupply_1, 50, 15, VOLUMES.tv_narrative_plateau_bowl_no_combat_shield_nag_01) ], 30);

	until	spartan_look_at_object(SPARTANS.buck, OBJECTS.dp_powersupply_1, 50, 15, 1, 2) == SPARTANS.buck or b_bowl_player_behind_the_shield or plateau_bowl_shield_health() <= 0

	if not b_bowl_player_behind_the_shield and IsGoalActive(missionPlateau.goal_Bowl) and plateau_bowl_shield_health() > 0 then
												
					--	!!	CRITICAL DIALOGUE ON	!!
					b_critical_dialogue_on = true;

					PushForwardVOReset();

					sleep_s(2);

					PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__BOWL__PUSH_FORWARD_3");
					NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__BOWL__PUSH_FORWARD_3);	
					
					SleepUntil([| NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__BOWL__PUSH_FORWARD_3)  ], 20);
				
					--	!!	CRITICAL DIALOGUE OFF	!!
					b_critical_dialogue_on = false;		
	end
	
	
	PrintNarrative("END - plateau_bowl_no_combat_shield_nag");
end




--[========================================================================[
          PLATEAU. BOWL. PUSH FORWARD.

          TO BRIAN: I'm waiting for the player to look at the shield or
          to be half way through the bowl to mention the shield, so
          I've added one line in case the player didn't notice the
          shield yet.
--]========================================================================]
global W2HubPlateau_PLATEAU__BOWL__PUSH_FORWARD = {
	name = "W2HubPlateau_PLATEAU__BOWL__PUSH_FORWARD",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return plateau_bowl_shield_health() > 0 and not b_bowl_player_behind_the_shield;
			end,
		
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Push forward. That shield's in our way.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_15100.sound'),

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
          PLATEAU. BOWL. PUSH FORWARD.

          TO BRIAN: I'm waiting for the player to look at the shield or
          to be half way through the bowl to mention the shield, so
          I've added one line in case the player didn't notice the
          shield yet.
--]========================================================================]
global W2HubPlateau_PLATEAU__BOWL__PUSH_FORWARD_2 = {
	name = "W2HubPlateau_PLATEAU__BOWL__PUSH_FORWARD_2",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {		
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_bowl_player_behind_the_shield;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Push forward. We got to the other side.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_15800.sound'),

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
          PLATEAU. BOWL. PUSH FORWARD.

          TO BRIAN: I'm waiting for the player to look at the shield or
          to be half way through the bowl to mention the shield, so
          I've added one line in case the player didn't notice the
          shield yet.
--]========================================================================]
global W2HubPlateau_PLATEAU__BOWL__PUSH_FORWARD_3 = {
	name = "W2HubPlateau_PLATEAU__BOWL__PUSH_FORWARD_3",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {		
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_bowl_player_behind_the_shield;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Still have to get that shield down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_01800.sound'),

			},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};
--PLATEAU. BOWL. IN COMBAT. SHIELD IS DOWN----------------------------------------------------------------------------------------------------



function plateau_bowl_in_combat_shield_is_down_listener()

	SleepUntil([| object_valid( "dp_powersupply_1" ) ], 60);
		
	PrintNarrative("LISTENER - plateau_bowl_in_combat_shield_is_down_listener");

	sleep_s(1);

	GoalCreateThread(missionPlateau.goal_Bowl, bowl_shield_death_safe);
	RegisterDeathEvent (plateau_bowl_in_combat_shield_is_down_launcher, OBJECTS.dp_powersupply_1);

end


function bowl_shield_death_safe()
local killer:object = nil;

SleepUntil([| plateau_bowl_shield_health() < 0 ], 60);

if W2HubPlateau_PLATEAU__BOWL__in_combat__shield_is_down.localVariables.s_speaker == nil then
	killer = spartan_look_at_object(players(), OBJECTS.dp_powersupply_1, 50, 40, 0, 2);

	if killer == nil then
		killer = GetClosestMusketeer( OBJECTS.dp_powersupply_1, 100, 2);
	end
else 
	killer = W2HubPlateau_PLATEAU__BOWL__in_combat__shield_is_down.localVariables.s_speaker;
end

PrintNarrative("START - bowl_shield_death_safe");
plateau_bowl_in_combat_shield_is_down_launcher(OBJECTS.dp_powersupply_1, killer);

end



function plateau_bowl_in_combat_shield_is_down_launcher(target:object, killer:object)

	PrintNarrative("LAUNCHER - plateau_bowl_in_combat_shield_is_down_launcher");

	print(killer, " is the killer of ", target);

	CreateMissionThread(plateau_bowl_in_combat_shield_is_down, killer)
		
end


function plateau_bowl_in_combat_shield_is_down(killer:object)

	PrintNarrative("START - plateau_bowl_in_combat_shield_is_down");

	W2HubPlateau_PLATEAU__BOWL__in_combat__shield_is_down.localVariables.s_speaker = killer;
	
	if not NarrativeQueue.IsConversationQueued(W2HubPlateau_PLATEAU__BOWL__in_combat__shield_is_down) then
		if not NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__BOWL__in_combat__shield_is_down) then
			PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__BOWL__in_combat__shield_is_down");
			NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__BOWL__in_combat__shield_is_down);
		end
	end

	CreateMissionThread(UnregisterDeathEvent, plateau_bowl_in_combat_plasma_battery_destruction_launcher, OBJECTS.dc_scan_shieldgenerator);	

	PrintNarrative("END - plateau_bowl_in_combat_shield_is_down");

end



--[========================================================================[
          PLATEAU. BOWL. in combat. shield is down
--]========================================================================]
global W2HubPlateau_PLATEAU__BOWL__in_combat__shield_is_down = {
	name = "W2HubPlateau_PLATEAU__BOWL__in_combat__shield_is_down",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
		PushForwardVOReset();
	end,

	sleepBefore = 1,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Shield's down. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_09300.sound'),

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
			text = "Shield's down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_04000.sound'),

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

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Shield's down. \r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_04900.sound'),

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
			text = "Shield's down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_04700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			Else = true,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Shield's down. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_09300.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;
		b_bowl_palmer_proceed_with_mission = true;
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {
					s_speaker = nil,
					},
};


--[========================================================================[
          PLATEAU. BOWL. they go in the temple
--]========================================================================]
global W2HubPlateau_PLATEAU__BOWL__they_go_in_the_temple = {
	name = "W2HubPlateau_PLATEAU__BOWL__they_go_in_the_temple",

	CanStart = function (thisConvo, queue)
		return b_bowl_palmer_proceed_with_mission; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
	end,

	sleepBefore = 1,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "SarahPalmer",

			--character = 0, -- GAMMA_CHARACTER: Palmer
			text = "Nice work Osiris. Move inside.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_palmer_02500.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;
	end,
};


------------------------------------------------------------------------------------------------------------------------------------------------------------
function plateau_bowl_covies_in_front_of_the_temple()

	PrintNarrative("START - plateau_bowl_covies_in_front_of_the_temple");

	SleepUntil([| ai_living_count(AI.sq_dp_left_sweep_bulwark) > 0 ], 100);

	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__BOWL__covies__in_front_of_the_temple, AI.gr_tunneltop2, ACTOR_TYPE.elite, "enemy_in_range", missionPlateau.goal_Bowl, 15 );

	PrintNarrative("END - plateau_bowl_covies_in_front_of_the_temple");

end


--[========================================================================[
          PLATEAU. BOWL. covies. in front of the temple
--]========================================================================]
global W2HubPlateau_PLATEAU__BOWL__covies__in_front_of_the_temple = {
	name = "W2HubPlateau_PLATEAU__BOWL__covies__in_front_of_the_temple",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return ai_living_count(AI.sq_dp_left_sweep_bulwark.spawn_points_0) == 1; -- GAMMA_TRANSITION: When player is in front of the temple
			end,

			--character = AI.sq_dp_left_sweep_bulwark.spawn_points_0, -- GAMMA_CHARACTER: Elite01
			text = "They must not enter the Temple! Kill them!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_04000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};



------------------------------------------------------------------------------------------------------------------------------------------------------------
function plateau_bowl_they_go_in_the_temple()

	PrintNarrative("WAKE - plateau_bowl_they_go_in_the_temple");

	SleepUntil([| b_bowl_player_behind_the_shield ], 10);

	PrintNarrative("START - plateau_bowl_they_go_in_the_temple");

	CreateMissionThread(plateau_bowl_they_go_in_the_temple_grunt_01);

	sleep_s(2);

	CreateMissionThread(plateau_bowl_they_go_in_the_temple_elite_01);

	PrintNarrative("END - plateau_bowl_they_go_in_the_temple");

end


------------------------------------------------------------------------------------------------------------------------------------------------------------
function plateau_bowl_they_go_in_the_temple_grunt_01()
		
	PrintNarrative("WAKE - plateau_bowl_they_go_in_the_temple_grunt_01");
	
	SleepUntil([| ai_living_count(AI.gr_tunneltop2) > 0 ], 100);

	PrintNarrative("START - plateau_bowl_they_go_in_the_temple_grunt_01");

	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__BOWL__covies__they_go_in_the_temple_grunt_01, AI.gr_tunneltop2, ACTOR_TYPE.grunt, "enemy_in_range", missionPlateau.goal_Bowl, 25 );

	PrintNarrative("END - plateau_bowl_they_go_in_the_temple_grunt_01");

end


--[========================================================================[
          PLATEAU. BOWL. covies. they go in the temple
--]========================================================================]
global W2HubPlateau_PLATEAU__BOWL__covies__they_go_in_the_temple_grunt_01 = {
	name = "W2HubPlateau_PLATEAU__BOWL__covies__they_go_in_the_temple_grunt_01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			--character = 0 -- GAMMA_CHARACTER: Elite01
			text = "They're going in there? They'll die!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt01_01000.sound'),
		},
	},

	sleepAfter = 10,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(plateau_bowl_they_go_in_the_temple_grunt_02);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};



------------------------------------------------------------------------------------------------------------------------------------------------------------
function plateau_bowl_they_go_in_the_temple_grunt_02()

	PrintNarrative("START - plateau_bowl_they_go_in_the_temple_grunt_02");

	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__BOWL__covies__they_go_in_the_temple_grunt_02, AI.gr_tunneltop2, ACTOR_TYPE.grunt, "enemy_in_range", missionPlateau.goal_Bowl, 25 );

	PrintNarrative("END - plateau_bowl_they_go_in_the_temple_grunt_02");

end


--[========================================================================[
          PLATEAU. BOWL. covies. they go in the temple
--]========================================================================]
global W2HubPlateau_PLATEAU__BOWL__covies__they_go_in_the_temple_grunt_02 = {
	name = "W2HubPlateau_PLATEAU__BOWL__covies__they_go_in_the_temple_grunt_02",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			--character = 0 -- GAMMA_CHARACTER: Elite01
			text = "Not in there! Nooo! Come back! It's dangerous in there!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_02900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};



------------------------------------------------------------------------------------------------------------------------------------------------------------
function plateau_bowl_they_go_in_the_temple_elite_01()

	PrintNarrative("START - plateau_bowl_they_go_in_the_temple_elite_01");

	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__BOWL__covies__they_go_in_the_temple_elite_01, AI.gr_tunneltop2, ACTOR_TYPE.elite, "enemy_in_range", missionPlateau.goal_Bowl, 10 );

	PrintNarrative("END - plateau_bowl_they_go_in_the_temple_elite_01");

end


--[========================================================================[
          PLATEAU. BOWL. covies. they go in the temple
--]========================================================================]
global W2HubPlateau_PLATEAU__BOWL__covies__they_go_in_the_temple_elite_01 = {
	name = "W2HubPlateau_PLATEAU__BOWL__covies__they_go_in_the_temple_elite_01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			--character = 0 -- GAMMA_CHARACTER: Elite01
			text = "Do not follow them into the Temple!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_04100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};



-- =================================================================================================
--  _______ ______ __  __ _____  _      ______ 
-- |__   __|  ____|  \/  |  __ \| |    |  ____|
--    | |  | |__  | \  / | |__) | |    | |__   
--    | |  |  __| | |\/| |  ___/| |    |  __|  
--    | |  | |____| |  | | |    | |____| |____ 
--    |_|  |______|_|  |_|_|    |______|______|
--                                             
-- =================================================================================================



--PLATEAU. TEMPLE. ENTERING THE TEMPLE----------------------------------------------------------------------------------------------------
function plateau_temple_load()

	PrintNarrative("LOAD - plateau_temple_load");

	PushForwardVOStandBy();	

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__TEMPLE__entering_the_temple");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__TEMPLE__entering_the_temple);

	CreateMissionThread(plateau_temple_in_the_temple);	

	CreateMissionThread(w2plateau_register_tracking_pinged_temple_switch);

end


function w2plateau_register_tracking_pinged_temple_switch()

	RegisterSpartanTrackingPingObjectEvent(w2plateau_tracking_pinged_temple_switch, OBJECTS.dc_temple_switch);

end

function w2plateau_tracking_pinged_temple_switch()

	b_temple_switch_has_been_pinged = true;
	PrintNarrative("Switch has been pinged");

	sleep_s(20);	

	if IsGoalActive(missionPlateau.goal_Temp_Bypass) then
		b_temple_switch_has_been_pinged = false;

		CreateMissionThread(w2plateau_register_tracking_pinged_temple_switch);
	end
end

--[========================================================================[
          PLATEAU. TEMPLE. entering the temple

          If the shield is down, any Spartan can go straight to the
          temple while others are in the bowl.

          The first one to get there, tells the other that he's going
          there.
		  W2HubPlateau_PLATEAU__TEMPLE__entering_the_temple.localVariables.s_speaker
--]========================================================================]
global W2HubPlateau_PLATEAU__TEMPLE__entering_the_temple = {
	name = "W2HubPlateau_PLATEAU__TEMPLE__entering_the_temple",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		thisConvo.localVariables.s_speaker = GetClosestMusketeer(OBJECTS.dm_temple_door, 50, 2);
		thisConvo.localVariables.s_speaker_2 = GetfarthestMusketeer(OBJECTS.dm_temple_door, 1, 1, "distance");
		PushForwardVOReset();
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke and ((list_count(players()) > 1 and thisConvo.localVariables.s_speaker_2 > 70) or list_count(players()) == 1);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "I'm heading into the Temple, Osiris.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_18500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker ==  SPARTANS.buck and (list_count(players()) > 1 and thisConvo.localVariables.s_speaker_2 > 70);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "I'm at the Temple. Gonna head inside.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_10200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker ==  SPARTANS.tanaka and (list_count(players()) > 1 and thisConvo.localVariables.s_speaker_2 > 70);
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Head'n through the Temple.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_12200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale and (list_count(players()) > 1 and thisConvo.localVariables.s_speaker_2 > 70);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "I'm entering the Temple. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_12500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 6;
			end,
		},
		[5] = {
			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Copy.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_17300.sound'),
		},
		[6] = {
			sleepBefore = 0.5,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,			

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Regroup inside Osiris.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_19900.sound'),
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
					s_speaker_2 = nil,
					},
};



--PLATEAU. TEMPLE. ENTERING THE TEMPLE----------------------------------------------------------------------------------------------------
function plateau_temple_in_the_temple()

	PrintNarrative("WAKE - plateau_temple_in_the_temple");

	CreateMissionThread(plateau_temple_look_at_mechanism);	

	sleep_s(4);

	if not volume_test_players_all(VOLUMES.tv_narrative_plateau_temple_in_the_temple) then

			sleep_s(5);
	end
	
	SleepUntil([| volume_test_players(VOLUMES.tv_narrative_plateau_temple_in_the_temple) ], 60);

	PushForwardVOStandBy();
	
	PrintNarrative("START - plateau_temple_in_the_temple");

	--	!!	CRITICAL DIALOGUE ON	!!
	b_critical_dialogue_on = true;

	sleep_s(4);
	
	if device_get_position(OBJECTS.dm_temple_door) == 0 then
				
				PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__TEMPLE__in_the_temple");
				NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__TEMPLE__in_the_temple);
	end

	sleep_s(2);
	
	--	!!	CRITICAL DIALOGUE OFF	!!
	b_critical_dialogue_on = false;

	PrintNarrative("END - plateau_temple_in_the_temple");
	
	CreateMissionThread(plateau_temple_tracking_nag);	

end




--[========================================================================[
          PLATEAU. TEMPLE. in the temple

          Osiris enters a pre-Covenant Sangheili temple.

          The walls are covered in murals. These murals should revolve
          around the Vadam family patriarchs, as this is their burial
          ground.
--]========================================================================]
global W2HubPlateau_PLATEAU__TEMPLE__in_the_temple = {
	name = "W2HubPlateau_PLATEAU__TEMPLE__in_the_temple",

	CanStart = function (thisConvo, queue)
		return true;
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
				return not b_temple_activated and volume_test_object( VOLUMES.tv_narrative_plateau_temple_in_the_temple, SPARTANS.locke ); -- GAMMA_TRANSITION: If locke first to enter
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Dead end. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_18400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return not b_temple_activated and volume_test_object( VOLUMES.tv_narrative_plateau_temple_in_the_temple, SPARTANS.buck ) ; -- GAMMA_TRANSITION: If buck first to enter
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "It's a dead-end. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_04200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return not b_temple_activated and volume_test_object( VOLUMES.tv_narrative_plateau_temple_in_the_temple, SPARTANS.tanaka ); -- GAMMA_TRANSITION: If tanaka first to enter
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "This place is a dead end. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_10100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return not b_temple_activated and volume_test_object( VOLUMES.tv_narrative_plateau_temple_in_the_temple, SPARTANS.vale ) ; -- GAMMA_TRANSITION: If Vale first to enter
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "I don't see a way through.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_12400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not b_temple_activated;
			end,

			sleepBefore = 0.5,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,				

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Commander Palmer. You sure we're headed the right way?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_08700.sound'),

		},
		[6] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not b_temple_activated;
			end,

			sleepBefore = 0.4,
			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "SarahPalmer",			

			--character = 0, -- GAMMA_CHARACTER: Palmer
			text = "Affirmative. That's the only way through.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_palmer_00900.sound'),

		},
		[7] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not b_temple_activated;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Maybe there's a hidden mechanism? A door lock?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_05900.sound'),
		},
		[8] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not b_temple_activated;
			end,

			sleepBefore = 1,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Look around Osiris.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_20000.sound'),
		},
--           UI: OBJECTIVE TEXT - FIND EXIT
--                     
--           ____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(plateau_temple_look_at_murals);
		hud_hide_radio_transmission_hud();
		CreateThread(faux_tracking_sequence);					--tjp
		CreateThread(tracking_refresher);						--tjp
		game_save_no_timeout();									--tjp		
	end,
};


-------------------------------------------------------------------------------------------------------------------------------
function plateau_temple_look_at_mechanism()
	
	PrintNarrative("WAKE - plateau_temple_look_at_mechanism");
	
	SleepUntil([| IsGoalActive(missionPlateau.goal_Temp_Bypass) and NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__TEMPLE__in_the_temple)], 10);

	repeat		
			SleepUntil([|	not IsGoalActive(missionPlateau.goal_Temp_Bypass)
						or (device_get_position(OBJECTS.dm_temple_door) == 0  and volume_test_players(VOLUMES.tv_narrative_plateau_temple_ledge) and volume_test_players_lookat( VOLUMES.tv_narrative_plateau_temple_mechanism, 5, 20 ))
						or (device_get_position(OBJECTS.dm_temple_door) == 0  and b_temple_switch_has_been_pinged and volume_test_players_lookat( VOLUMES.tv_narrative_plateau_temple_ledge, 10, 1 ))], 10);
			sleep_s(0.1);
	until	not IsGoalActive(missionPlateau.goal_Temp_Bypass)
			or (device_get_position(OBJECTS.dm_temple_door) == 0  and volume_test_players(VOLUMES.tv_narrative_plateau_temple_ledge) and volume_test_players_lookat( VOLUMES.tv_narrative_plateau_temple_mechanism, 5, 20 ))
			or (device_get_position(OBJECTS.dm_temple_door) == 0  and b_temple_switch_has_been_pinged and volume_test_players_lookat( VOLUMES.tv_narrative_plateau_temple_ledge, 10, 1 ))

	PrintNarrative("START - plateau_temple_look_at_mechanism");

			PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__TEMPLE__TRACKING");
			NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__TEMPLE__TRACKING);

			b_player_saw_mechanism = true;

	PrintNarrative("END - plateau_temple_look_at_mechanism");
	
end




--[========================================================================[
          PLATEAU. TEMPLE. TRACKING

          When a player see the small statue up on the ledge.

          This should work with the AI chatter and location volumes.
--]========================================================================]
global W2HubPlateau_PLATEAU__TEMPLE__TRACKING = {
	name = "W2HubPlateau_PLATEAU__TEMPLE__TRACKING",

	CanStart = function (thisConvo, queue)
		return not IsGoalActive(missionPlateau.goal_Temp_Bypass)
				or (device_get_position(OBJECTS.dm_temple_door) == 0  and volume_test_players(VOLUMES.tv_narrative_plateau_temple_ledge) and volume_test_players_lookat( VOLUMES.tv_narrative_plateau_temple_mechanism, 5, 20 ))
				or (device_get_position(OBJECTS.dm_temple_door) == 0  and b_temple_switch_has_been_pinged and volume_test_players_lookat( VOLUMES.tv_narrative_plateau_temple_ledge, 10, 10 )); -- GAMMA_CONDITION
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
				return not b_temple_activated and ((device_get_position(OBJECTS.dm_temple_door) == 0 and volume_test_object(VOLUMES.tv_narrative_plateau_temple_in_the_temple, SPARTANS.locke) and volume_test_player_lookat( VOLUMES.tv_narrative_plateau_temple_mechanism, unit_get_player(SPARTANS.locke), 5, 20 ))
						or (device_get_position(OBJECTS.dm_temple_door) == 0  and b_temple_switch_has_been_pinged and volume_test_player_lookat( VOLUMES.tv_narrative_plateau_temple_ledge, unit_get_player(SPARTANS.locke),  10, 10 )));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Found something. Up on the ledge.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_15200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return not b_temple_activated and (device_get_position(OBJECTS.dm_temple_door) == 0 and volume_test_object(VOLUMES.tv_narrative_plateau_temple_in_the_temple, SPARTANS.buck) and volume_test_player_lookat( VOLUMES.tv_narrative_plateau_temple_mechanism, unit_get_player(SPARTANS.buck), 5, 20 )
						or (device_get_position(OBJECTS.dm_temple_door) == 0  and b_temple_switch_has_been_pinged and volume_test_player_lookat( VOLUMES.tv_narrative_plateau_temple_ledge, unit_get_player(SPARTANS.buck),  10, 10 )));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Found something. Up on the ledge.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_08600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return not b_temple_activated and (device_get_position(OBJECTS.dm_temple_door) == 0 and volume_test_object(VOLUMES.tv_narrative_plateau_temple_in_the_temple, SPARTANS.tanaka) and volume_test_player_lookat( VOLUMES.tv_narrative_plateau_temple_mechanism, unit_get_player(SPARTANS.tanaka), 5, 20 )
						or (device_get_position(OBJECTS.dm_temple_door) == 0  and b_temple_switch_has_been_pinged and volume_test_player_lookat( VOLUMES.tv_narrative_plateau_temple_ledge, unit_get_player(SPARTANS.tanaka),  10, 10 )));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Found something. Up on the ledge.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_10900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return not b_temple_activated and (device_get_position(OBJECTS.dm_temple_door) == 0 and volume_test_object(VOLUMES.tv_narrative_plateau_temple_in_the_temple, SPARTANS.vale) and volume_test_player_lookat( VOLUMES.tv_narrative_plateau_temple_mechanism, unit_get_player(SPARTANS.vale), 5, 20 )
						or (device_get_position(OBJECTS.dm_temple_door) == 0  and b_temple_switch_has_been_pinged and volume_test_player_lookat( VOLUMES.tv_narrative_plateau_temple_ledge, unit_get_player(SPARTANS.vale),  10, 10 )));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Found something. Up on the ledge.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_08300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not b_temple_activated and not volume_test_players(VOLUMES.tv_narrative_plateau_temple_ledge); -- GAMMA_TRANSITION: If player is not on the ledge after having pinged the switch
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "How do we go up there?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_13600.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[6] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not b_temple_activated and not volume_test_players(VOLUMES.tv_narrative_plateau_temple_ledge); -- GAMMA_TRANSITION: If player is not on the ledge after having pinged the switch
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "No stairs, we should be able to climb. Look at the sides.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_11100.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};



-------------------------------------------------------------------------------------------------------------------------------
function plateau_temple_tracking_nag()
	
	PrintNarrative("WAKE - plateau_temple_tracking_nag");

	PushForwardVOReset(25);
	
	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__TEMPLE__TRACKING_nag_1");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__TEMPLE__TRACKING_nag_1);
	
	SleepUntil([|	device_get_position(OBJECTS.dm_temple_door) == 1 ], 100);

	SleepUntil([|	b_push_forward_vo_timer <= 5 and b_push_forward_vo_timer > 0 and not volume_test_players( VOLUMES.tv_narrative_plateau_temple_safe_nag) and not volume_test_players( VOLUMES.tv_narrative_plateau_temple_mural_left_front) and not volume_test_players( VOLUMES.tv_narrative_plateau_temple_mural_right_front)], 100);

	PrintNarrative("START - plateau_temple_tracking_nag - line 3");

	PushForwardVOReset(30);

	--	!!	CRITICAL DIALOGUE ON	!!
	b_critical_dialogue_on = true;

	if IsGoalActive(missionPlateau.goal_SoldierTaunt) then

	   		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__TEMPLE__temple_push_forward");
			NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__TEMPLE__temple_push_forward);

			PushForwardVOReset();
	end

	PrintNarrative("END - plateau_temple_tracking_nag");

end


--[========================================================================[
          PLATEAU. TEMPLE. TRACKING nag
--]========================================================================]
global W2HubPlateau_PLATEAU__TEMPLE__TRACKING_nag_1 = {
	name = "W2HubPlateau_PLATEAU__TEMPLE__TRACKING_nag_1",

	CanStart = function (thisConvo, queue)
		return not b_temple_switch_has_been_pinged and b_push_forward_vo_timer <= 3 and b_push_forward_vo_timer > 0 and not volume_test_players( VOLUMES.tv_narrative_plateau_temple_mural_left_front) and not volume_test_players( VOLUMES.tv_narrative_plateau_temple_mural_right_front) and not volume_test_players(VOLUMES.tv_narrative_plateau_temple_ledge);
	end,
	--	ADD A TEST IF THE PLAYER HAS A THE TRACKING DEVICE ON


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset();	
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
	end,


	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return  IsSpartanAbleToSpeak(SPARTANS.buck) and device_get_position(OBJECTS.dm_temple_door) == 0 and IsGoalActive(missionPlateau.goal_Temp_Bypass);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Time to do some tracking, yeah Osiris?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_buck_06100.sound'),
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return  IsSpartanAbleToSpeak(SPARTANS.tanaka) and device_get_position(OBJECTS.dm_temple_door) == 0 and IsGoalActive(missionPlateau.goal_Temp_Bypass);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TanaKA
			text = "See if the Artemis can pick somethin' up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_tanaka_06400.sound'),

		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return  IsSpartanAbleToSpeak(SPARTANS.vale) and device_get_position(OBJECTS.dm_temple_door) == 0 and IsGoalActive(missionPlateau.goal_Temp_Bypass);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Let's see if the Artemis can get a reading.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_vale_06200.sound'),

		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return  IsSpartanAbleToSpeak(SPARTANS.locke) and device_get_position(OBJECTS.dm_temple_door) == 0 and IsGoalActive(missionPlateau.goal_Temp_Bypass);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: locke
			text = "Let's try scanning with the Artemis.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_locke_06800.sound'),

		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;	
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__TEMPLE__TRACKING_nag_2");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__TEMPLE__TRACKING_nag_2);
		CreateThread(tracking_refresher);						--tjp
	end,
};
--[========================================================================[
          PLATEAU. TEMPLE. temple push forward
--]========================================================================]
global W2HubPlateau_PLATEAU__TEMPLE__temple_push_forward = {
	name = "W2HubPlateau_PLATEAU__TEMPLE__temple_push_forward",

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

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "The door is open now, we should get to the Constructor.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_12800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;
	end,
};



--[========================================================================[
          PLATEAU. TEMPLE. TRACKING nag
--]========================================================================]
global W2HubPlateau_PLATEAU__TEMPLE__TRACKING_nag_2 = {
	name = "W2HubPlateau_PLATEAU__TEMPLE__TRACKING_nag_2",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_timer <= 3 and b_push_forward_vo_timer > 0 and not volume_test_players( VOLUMES.tv_narrative_plateau_temple_mural_left_front) and not volume_test_players( VOLUMES.tv_narrative_plateau_temple_mural_right_front) and not volume_test_players(VOLUMES.tv_narrative_plateau_temple_ledge);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(30);

		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return  device_get_position(OBJECTS.dm_temple_door) == 0 and IsGoalActive(missionPlateau.goal_Temp_Bypass) ;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Doctor Halsey said we'd find the Constructor just past here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_12600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;
		CreateThread(tracking_refresher);						--tjp
		CreateThread(tracking_reminder_loop);					--tjp
	end,
};


--------------------------
function plateau_temple_mechanism_launcher(turret:object, killer:object)

	PrintNarrative("LAUNCHER - plateau_temple_mechanism_launcher");

	if not b_temple_activated then

		b_temple_activated = true;

		print(killer, " has interacted with ", turret);

		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__TEMPLE__activating");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__TEMPLE__activating);
		W2HubPlateau_PLATEAU__TEMPLE__activating.localVariables.killer = killer;
	end

end

--[========================================================================[
          PLATEAU. TEMPLE. activating

          When a player interacts with the statue.
--]========================================================================]
global W2HubPlateau_PLATEAU__TEMPLE__activating = {
	name = "W2HubPlateau_PLATEAU__TEMPLE__activating",

	CanStart = function (thisConvo, queue)
		return thisConvo.localVariables.killer ~= nil;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(30);
		NarrativeQueue.EndConversationEarly(W2HubPlateau_PLATEAU__TEMPLE__mural_conclusion);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.locke; -- GAMMA_TRANSITION: If Locke first interacts
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "This has to be it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_18700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.buck; -- GAMMA_TRANSITION: Else If Buck first interacts
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: bUCK
			text = "Might be something here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_globalsosiris\001_vo_scr_globalsosiris_un_buck_05900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.tanaka; -- GAMMA_TRANSITION: Else If Tanaka first interacts
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Let's try this...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_12500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.vale; -- GAMMA_TRANSITION: Else If Vale first interacts
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "This should work.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_13100.sound'),

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
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__TEMPLE__temple_DOOR_opening");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__TEMPLE__temple_DOOR_opening);
	end,

	localVariables = {
						killer = nil,
						},
};



-------------------------------------------------------------------------------------------------------------------------------
function plateau_temple_look_at_murals()
	
	PrintNarrative("WAKE - plateau_temple_look_at_murals");

	CreateMissionThread(PLATEAU__TEMPLE__murals_look_at_listener);
	
	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__TEMPLE__murals_look_at");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__TEMPLE__murals_look_at);

	
	
	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__TEMPLE__murals_look_at_locke");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__TEMPLE__murals_look_at_locke);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__TEMPLE__murals_look_at_buck");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__TEMPLE__murals_look_at_buck);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__TEMPLE__murals_look_at_tanaka");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__TEMPLE__murals_look_at_tanaka);

	
end


function PLATEAU__TEMPLE__murals_look_at_listener()

local s_speaker:object = nil;

	SleepUntil([| object_valid("temple_mural_left")  ], 60);

	PrintNarrative("LISTENER - PLATEAU__TEMPLE__murals_look_at_listener");

	repeat	
			SleepUntil([| b_temple_mural_listener ], 10);
			s_speaker = nil;


			repeat 					
					sleep_s(0.5);

					SleepUntil([| volume_test_players( VOLUMES.tv_narrative_plateau_temple_mural_left_front ) or volume_test_players( VOLUMES.tv_narrative_plateau_temple_mural_right_front ) and not volume_test_players( VOLUMES.tv_narrative_plateau_temple_ledge )  ], 10);

					s_speaker = nil;

					if volume_test_players( VOLUMES.tv_narrative_plateau_temple_mural_left_front ) and not b_mural_left_translate then
				
						s_speaker = spartan_look_at_object(players(), OBJECTS.temple_mural_left, 10, 30, 0.7, 1);

					elseif volume_test_players( VOLUMES.tv_narrative_plateau_temple_mural_right_front ) and not b_mural_right_translate then

						s_speaker = spartan_look_at_object(players(), OBJECTS.temple_mural_right, 10, 30, 0.7, 1);
						
					end					

					print(s_speaker);

			until s_speaker ~= nil
		

			if s_speaker == SPARTANS.locke and (	(IsPlayer(SPARTANS.vale) and (objects_distance_to_object( SPARTANS.vale, OBJECTS.temple_mural_left) > 13 and objects_distance_to_object( SPARTANS.vale, OBJECTS.temple_mural_right) > 13)) or (not IsPlayer(SPARTANS.vale) and (objects_distance_to_object( SPARTANS.vale, OBJECTS.temple_mural_left) > 30 and objects_distance_to_object( SPARTANS.vale, OBJECTS.temple_mural_right) > 30))	) and not b_locke_looked_at_mural then
					b_locke_looked_at_mural = true;
					print("b_locke_looked_at_mural = true;");
			elseif s_speaker == SPARTANS.buck and (	(IsPlayer(SPARTANS.vale) and (objects_distance_to_object( SPARTANS.vale, OBJECTS.temple_mural_left) > 13 and objects_distance_to_object( SPARTANS.vale, OBJECTS.temple_mural_right) > 13)) or (not IsPlayer(SPARTANS.vale) and (objects_distance_to_object( SPARTANS.vale, OBJECTS.temple_mural_left) > 30 and objects_distance_to_object( SPARTANS.vale, OBJECTS.temple_mural_right) > 30)) ) and not b_buck_looked_at_mural then
					b_buck_looked_at_mural = true;
					print("b_buck_looked_at_mural = true;");
			elseif s_speaker == SPARTANS.tanaka and (	(IsPlayer(SPARTANS.vale) and (objects_distance_to_object( SPARTANS.vale, OBJECTS.temple_mural_left) > 13 and objects_distance_to_object( SPARTANS.vale, OBJECTS.temple_mural_right) > 13))
														 or (not IsPlayer(SPARTANS.vale) and (objects_distance_to_object( SPARTANS.vale, OBJECTS.temple_mural_left) > 30 and objects_distance_to_object( SPARTANS.vale, OBJECTS.temple_mural_right) > 30))	) 
												and not b_tanaka_looked_at_mural then
					b_tanaka_looked_at_mural = true;
					print("b_tanaka_looked_at_mural = true;");
			elseif	s_speaker ~= nil and (	(volume_test_object( VOLUMES.tv_narrative_plateau_temple_mural_left_front, s_speaker ) and ((IsPlayer(SPARTANS.vale) and objects_distance_to_object( SPARTANS.vale, OBJECTS.temple_mural_left) <= 13) or (not IsPlayer(SPARTANS.vale) and objects_distance_to_object( SPARTANS.vale, OBJECTS.temple_mural_left) <= 30)))
											 or (volume_test_object( VOLUMES.tv_narrative_plateau_temple_mural_right_front, s_speaker ) and ((IsPlayer(SPARTANS.vale) and objects_distance_to_object( SPARTANS.vale, OBJECTS.temple_mural_right) <= 13) or (not IsPlayer(SPARTANS.vale) and objects_distance_to_object( SPARTANS.vale, OBJECTS.temple_mural_right) <= 30)))
										)	and (s_speaker == SPARTANS.vale or not b_vale_described_the_murals)	 then
					W2HubPlateau_PLATEAU__TEMPLE__murals_look_at.localVariables.s_looker = s_speaker;
					print("1");
			elseif	s_speaker ~= nil and (	(volume_test_object( VOLUMES.tv_narrative_plateau_temple_mural_left_front, s_speaker ) and ((IsPlayer(SPARTANS.vale) and objects_distance_to_object( SPARTANS.vale, OBJECTS.temple_mural_left) <= 13) or (not IsPlayer(SPARTANS.vale) and objects_distance_to_object( SPARTANS.vale, OBJECTS.temple_mural_left) <= 30)))
											 or (volume_test_object( VOLUMES.tv_narrative_plateau_temple_mural_right_front, s_speaker ) and ((IsPlayer(SPARTANS.vale) and objects_distance_to_object( SPARTANS.vale, OBJECTS.temple_mural_right) <= 10) or (not IsPlayer(SPARTANS.vale) and objects_distance_to_object( SPARTANS.vale, OBJECTS.temple_mural_right) <= 30)))
										) and n_mural_looked_at == 0 then
					W2HubPlateau_PLATEAU__TEMPLE__mural_01.localVariables.s_looker = s_speaker;
					print("2");
			elseif	s_speaker ~= nil and (	(volume_test_object( VOLUMES.tv_narrative_plateau_temple_mural_left_front, s_speaker ) and ((IsPlayer(SPARTANS.vale) and objects_distance_to_object( SPARTANS.vale, OBJECTS.temple_mural_left) <= 13) or (not IsPlayer(SPARTANS.vale) and objects_distance_to_object( SPARTANS.vale, OBJECTS.temple_mural_left) <= 30)))
											 or (volume_test_object( VOLUMES.tv_narrative_plateau_temple_mural_right_front, s_speaker ) and ((IsPlayer(SPARTANS.vale) and objects_distance_to_object( SPARTANS.vale, OBJECTS.temple_mural_right) <= 13)  or (not IsPlayer(SPARTANS.vale) and objects_distance_to_object( SPARTANS.vale, OBJECTS.temple_mural_right) <= 30))) 
										) and n_mural_looked_at == 1 then
					W2HubPlateau_PLATEAU__TEMPLE__mural_02.localVariables.s_looker = s_speaker;			
					print("3");
			end	

			

	until not (IsGoalActive(missionPlateau.goal_Temp_Bypass) or IsGoalActive(missionPlateau.goal_SoldierTaunt))
			or (	(b_locke_looked_at_mural) 
					and ((IsPlayer(SPARTANS.buck) and b_buck_looked_at_mural) or not IsPlayer(SPARTANS.buck))
					and ((IsPlayer(SPARTANS.tanaka) and b_tanaka_looked_at_mural) or not IsPlayer(SPARTANS.tanaka))
					and ((IsPlayer(SPARTANS.vale) and b_vale_looked_at_mural) or not IsPlayer(SPARTANS.vale))
					and W2HubPlateau_PLATEAU__TEMPLE__murals_look_at.localVariables.s_looker ~= nil
					and W2HubPlateau_PLATEAU__TEMPLE__mural_01.localVariables.s_looker ~= nil
					and W2HubPlateau_PLATEAU__TEMPLE__mural_02.localVariables.s_looker ~= nil
				)	

	PrintNarrative("END - PLATEAU__TEMPLE__murals_look_at_listener");
end



--[========================================================================[
          PLATEAU. TEMPLE. murals look at

          Who ever is first to look at the murals will trigger this
          line.
--]========================================================================]
global W2HubPlateau_PLATEAU__TEMPLE__murals_look_at = {
	name = "W2HubPlateau_PLATEAU__TEMPLE__murals_look_at",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return thisConvo.localVariables.s_looker ~= nil;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(30);
		b_vale_described_the_murals = true;
		b_temple_mural_listener = false;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return	thisConvo.localVariables.s_looker == SPARTANS.locke;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Vale. What are these murals?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_18600.sound'),

			playDurationAdjustment = 0.8,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,			
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return	thisConvo.localVariables.s_looker == SPARTANS.buck;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Hey Vale, any idea what those murals are saying?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_10300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,

			playDurationAdjustment = 0.8,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return	thisConvo.localVariables.s_looker == SPARTANS.tanaka;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Hey Vale, any idea what those murals are saying?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_12300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,

			playDurationAdjustment = 0.8,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return	thisConvo.localVariables.s_looker == SPARTANS.vale;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.7,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Those murals depict a pre-covenant Sangheili burial ceremony... ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_12700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,

			playDurationAdjustment = 0.8,
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			sleepBefore = 0.7,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Those murals depict a pre-covenant Sangheili burial ceremony... ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_12700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,

			--playDurationAdjustment = 1,
		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "You guys... we're the first humans to see these. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_13200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__TEMPLE__mural_01");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__TEMPLE__mural_01);
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__TEMPLE__mural_02");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__TEMPLE__mural_02);
		b_temple_mural_listener = true;
	end,


	localVariables = {
					s_looker = nil,
					},
};




--[========================================================================[
          PLATEAU. TEMPLE. murals look at
--]========================================================================]
global W2HubPlateau_PLATEAU__TEMPLE__murals_look_at_locke = {
	name = "W2HubPlateau_PLATEAU__TEMPLE__murals_look_at_locke",

	CanStart = function (thisConvo, queue)
		return b_locke_looked_at_mural and not b_critical_dialogue_on;
	end,
		
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_push_forward_vo_timer = b_push_forward_vo_timer + 10;
		b_temple_mural_listener = false;
	end,
	
	PlayOnSpecificPlayer = CHARACTER_SPARTANS.locke,
	
	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Old Sangheili scriptures...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_18800.sound'),

			sleepAfter = 1,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_temple_mural_listener = true;
	end,

};



--[========================================================================[
          PLATEAU. TEMPLE. murals look at
--]========================================================================]
global W2HubPlateau_PLATEAU__TEMPLE__murals_look_at_buck = {
	name = "W2HubPlateau_PLATEAU__TEMPLE__murals_look_at_buck",

	CanStart = function (thisConvo, queue)
		return b_buck_looked_at_mural and not b_critical_dialogue_on;
	end,
	
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_push_forward_vo_timer = b_push_forward_vo_timer + 10;
		b_temple_mural_listener = false;
	end,

	PlayOnSpecificPlayer =  CHARACTER_SPARTANS.buck;

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Old Sangheili scriptures...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_10500.sound'),

			sleepAfter = 1,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_temple_mural_listener = true;
	end,
};



--[========================================================================[
          PLATEAU. TEMPLE. murals look at
--]========================================================================]
global W2HubPlateau_PLATEAU__TEMPLE__murals_look_at_tanaka = {
	name = "W2HubPlateau_PLATEAU__TEMPLE__murals_look_at_tanaka",

	CanStart = function (thisConvo, queue)
		return b_tanaka_looked_at_mural and not b_critical_dialogue_on;
	end,
	
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_push_forward_vo_timer = b_push_forward_vo_timer + 10;
		b_temple_mural_listener = false;
	end,

	PlayOnSpecificPlayer = CHARACTER_SPARTANS.tanaka;

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Old Sangheili scriptures...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_12600.sound'),

			sleepAfter = 1,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		b_temple_mural_listener = true;
	end,
};



--[========================================================================[
          PLATEAU. TEMPLE. mural 01

          This is triggered only if Vale looks at the murals.
--]========================================================================]
global W2HubPlateau_PLATEAU__TEMPLE__mural_01 = {
	name = "W2HubPlateau_PLATEAU__TEMPLE__mural_01",

	CanStart = function (thisConvo, queue)
		return thisConvo.localVariables.s_looker ~= nil and not b_critical_dialogue_on;
	end,

	Priority = function (W2HubPlateau_PLATEAU__TEMPLE__mural_01, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(30);
		b_temple_mural_listener = false;
		if volume_test_objects( VOLUMES.tv_narrative_plateau_temple_mural_left_front, W2HubPlateau_PLATEAU__TEMPLE__mural_01.localVariables.s_looker ) then
			b_mural_left_translate = true;
		elseif volume_test_objects( VOLUMES.tv_narrative_plateau_temple_mural_right_front, W2HubPlateau_PLATEAU__TEMPLE__mural_01.localVariables.s_looker ) then
			b_mural_right_translate = true;
		end
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "This one says:",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_05400.sound'),
			
			playDurationAdjustment = 0.9,

		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Mee-kah-noh nee-toh-moh.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_11600.sound'),

			playDurationAdjustment = 1,

		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Here they serve at the feet of the gods.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_11700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		n_mural_looked_at = n_mural_looked_at + 1;
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__TEMPLE__mural_conclusion");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__TEMPLE__mural_conclusion);
		b_temple_mural_listener = true;
	end,

	localVariables = {	
					s_looker = nil,
					},
};




--[========================================================================[
          PLATEAU. TEMPLE. mural 02

          This is triggered only if Vale looks at the murals.
--]========================================================================]
global W2HubPlateau_PLATEAU__TEMPLE__mural_02 = {
	name = "W2HubPlateau_PLATEAU__TEMPLE__mural_02",

	CanStart = function (thisConvo, queue)
		return thisConvo.localVariables.s_looker ~= nil and not b_critical_dialogue_on;
	end,
	
	Timeout = function (thisConvo, queue) -- NUMBER
		if IsGoalActive(missionPlateau.goal_SentryBoss) then			
			return 0;
		else
		 return 1000;
		end;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(30);
		b_temple_mural_listener = false;
		if volume_test_objects( VOLUMES.tv_narrative_plateau_temple_mural_left_front, W2HubPlateau_PLATEAU__TEMPLE__mural_01.localVariables.s_looker ) then
			b_mural_left_translate = true;
		elseif volume_test_objects( VOLUMES.tv_narrative_plateau_temple_mural_right_front, W2HubPlateau_PLATEAU__TEMPLE__mural_01.localVariables.s_looker ) then
			b_mural_right_translate = true;
		end
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "This one says:",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_05700.sound'),

			playDurationAdjustment = 0.9,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Chee-noh-ee. kyo-ee-say. \r\ngyoo-nn-joo",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_11800.sound'),

			playDurationAdjustment = 1,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Life. Death. Forever vigilant.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_11900.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		n_mural_looked_at = n_mural_looked_at + 1;
		b_temple_mural_listener = true;
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {	
					s_looker = nil,
					},
};



--[========================================================================[
          PLATEAU. TEMPLE. mural conclusion

          No matter in what order the player looked at the mural, vale
          will finish with this line. Like if it was part of the last
          mural.

          Interrupted if a player activate the door.
--]========================================================================]
global W2HubPlateau_PLATEAU__TEMPLE__mural_conclusion = {
	name = "W2HubPlateau_PLATEAU__TEMPLE__mural_conclusion",

	CanStart = function (thisConvo, queue)
		return not b_critical_dialogue_on and n_mural_looked_at == 2 and (IsGoalActive(missionPlateau.goal_Temp_Bypass) or IsGoalActive(missionPlateau.goal_SoldierTaunt));
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(30);
		b_temple_mural_listener = false;
	end,

	sleepBefore = 0.4, 

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Ah. Interesting. There's a question here too. Who is entitled to this honor?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_06000.sound'),

			playDurationAdjustment = 0.95,

		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "No one is entitled to honor. You earn it. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_10900.sound'),

			--playDurationAdjustment = 0.8,

		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Heh. You're starting to understand Sangheili culture.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_06500.sound'),

			--playDurationAdjustment = 0.8,
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "No, I just don't believe anyone is entitled to anything.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_11300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};



--[========================================================================[
          PLATEAU. TEMPLE. temple DOOR opening

          We get loud audio feedback of the mechanisms inside of the
          wall working.
--]========================================================================]
global W2HubPlateau_PLATEAU__TEMPLE__temple_DOOR_opening = {
	name = "W2HubPlateau_PLATEAU__TEMPLE__temple_DOOR_opening",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(40);
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
	end,

	sleepBefore = 0.3, 

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Something's happening.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_11000.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[2] = {
			sleepBefore = 3, 

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "It worked. Doctor Halsey's coordinates are just through that door.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_06400.sound'),
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Move Osiris!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_19600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;
		hud_hide_radio_transmission_hud();
	end,
};



--------------------------------------------------------------------------------------------------------------------------------------------------------------
function plateau_temple_corridor_soldiers()

--	********************	CHECK LATER THE FLOW WHEN SOLDIER WILL BE ABOVE GROUND

	PrintNarrative("WAKE - plateau_temple_corridor_soldiers");

	SleepUntil([| ai_living_count(AI.vin_soldier_taunt) > 0 ], 20);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_battle__corridor_soldiers");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_battle__corridor_soldiers);

	PrintNarrative("START - plateau_temple_corridor_soldiers");

	

	PrintNarrative("END - plateau_temple_corridor_soldiers");

end



--[========================================================================[
          PLATEAU. sentry battle. corridor soldiers

          In the corridor leading to the canyon, Osiris encounters a
          couple Prometheans Soldiers.(You are the first to arrive
          here, so you're setting off FR defenses).
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_battle__corridor_soldiers = {
	name = "W2HubPlateau_PLATEAU__sentry_battle__corridor_soldiers",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__sentry_battle__corridor_soldiers_osiris");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__sentry_battle__corridor_soldiers_osiris);		
		NarrativeQueue.InterruptConversation(W2HubPlateau_PLATEAU__TEMPLE__mural_conclusion);
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
	end,

	lines = {
		[1] = {
			character = AI.vin_soldier_taunt.soldier_sp, -- GAMMA_CHARACTER: Soldier01
			text = "Invaders present.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_fr_soldier01_00100.sound'),

			playDurationAdjustment = 0.8,
		},
		[2] = {
			character = AI.vin_soldier_taunt.soldier_sp_2, -- GAMMA_CHARACTER: SoLDIER02
			text = "Activate security systems.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_fr_soldier02_00100.sound'),

			playDurationAdjustment = 0.8,
		},
		[3] = {
			character = AI.vin_soldier_taunt.soldier_sp, -- GAMMA_CHARACTER: SOLDIER01
			text = "Phaetons online.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_fr_soldier01_00200.sound'),

			playDurationAdjustment = 0.8,
		},
		[4] = {
			character = AI.vin_soldier_taunt.soldier_sp_2, -- GAMMA_CHARACTER: SOLDIER02
			text = "Turrets activated.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_fr_soldier02_00200.sound'),

			playDurationAdjustment = 0.8,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;
	end,
};




--[========================================================================[
          PLATEAU. sentry battle. corridor soldiers

          In the corridor leading to the canyon, Osiris encounters a
          couple Prometheans Soldiers.(You are the first to arrive
          here, so you're setting off FR defenses).
--]========================================================================]
global W2HubPlateau_PLATEAU__sentry_battle__corridor_soldiers_osiris = {
	name = "W2HubPlateau_PLATEAU__sentry_battle__corridor_soldiers_osiris",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnInitialize = function(thisConvo, queue)
		thisConvo.localVariables.s_speaker = GetClosestMusketeer(ai_get_object(AI.vin_soldier_taunt.soldier_sp_2), 20, 2)
		print(thisConvo.localVariables.s_speaker);
	end,

	sleepBefore = 0.2,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;		
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: If Buck is the closest to the player
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Soldiers!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_07500.sound'),

		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: Else If tanaka the closest to the player
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Soldiers!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_08500.sound'),

		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: Else If vale the closest to the player
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Soldiers!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_06700.sound'),

		},
		[4] = {
			Else = true,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Soldiers!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_07500.sound'),

			sleepAfter = 0.5,
		},
		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker ~= SPARTANS.tanaka and objects_distance_to_object( SPARTANS.tanaka, thisConvo.localVariables.s_speaker ) < 5; -- GAMMA_TRANSITION: If Buck is the closest to the player
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Hey, where did they go?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_13600.sound'),

		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;
	end,

	localVariables = {
						s_sspeaker = nil,
						},
};



-- =================================================================================================
--   _____ ______ _   _ _______ _______     __  ____       _______ _______ _      ______ 
--  / ____|  ____| \ | |__   __|  __ \ \   / / |  _ \   /\|__   __|__   __| |    |  ____|
-- | (___ | |__  |  \| |  | |  | |__) \ \_/ /  | |_) | /  \  | |     | |  | |    | |__   
--  \___ \|  __| | . ` |  | |  |  _  / \   /   |  _ < / /\ \ | |     | |  | |    |  __|  
--  ____) | |____| |\  |  | |  | | \ \  | |    | |_) / ____ \| |     | |  | |____| |____ 
-- |_____/|______|_| \_|  |_|  |_|  \_\ |_|    |____/_/    \_\_|     |_|  |______|______|
--                                                                                       
-- =================================================================================================



function plateau_boss_load()

	PrintNarrative("LOAD - plateau_boss_load");

	PushForwardVOStandBy();

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__kraken_arrival");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__kraken_arrival);		
		
	SleepUntil([| b_vtols_are_present], 60);

	PrintNarrative("LOAD - plateau_boss_load - VTOLS are present");

	CreateMissionThread(plateau_sentry_battle_leaving_without_gunner);
	CreateMissionThread(plateau_sentry_battle_vtol_nag);	

	opportunity_area_set_active("countdown_dialog_stim", false);

	SleepUntil([| b_kraken_going_down], 120);

	opportunity_area_set_active("countdown_dialog_stim", false);

end





--[========================================================================[
          PLATEAU. SENTRY BATTLE. kraken arrival

          The Kraken's sound resonates throughout the canyon. Buuuuhhh!
          Loud and terrifying.

          The Kraken descends into the canyon.

          Note: if we need to move this earlier, Palmer's line can play
          over the Soldiers talking.
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__kraken_arrival = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__kraken_arrival",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "SarahPalmer",

			--character = 0, -- GAMMA_CHARACTER: Palmer
			text = "Locke! Heads up. The Kraken's still in play. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_palmer_02600.sound'),

			sleepAfter = 0.2,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_corridor, SPARTANS.locke ); -- GAMMA_TRANSITION: If Locke's in the hallway:
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "I see it, Commander.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_15300.sound'),
		},
		[3] = {
			Else = true,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Understood, commander.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_18900.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__kraken_arrival_2");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__kraken_arrival_2);
	end,
};


--[========================================================================[
          PLATEAU. SENTRY BATTLE. kraken arrival

          The Kraken's sound resonates throughout the canyon. Buuuuhhh!
          Loud and terrifying.

          The Kraken descends into the canyon.

          Note: if we need to move this earlier, Palmer's line can play
          over the Soldiers talking.
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__kraken_arrival_2 = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__kraken_arrival_2",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narrative_plateau_sentry_battle_entrance ); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
	end,

	lines = {
		[1] = {			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Arbiter",

			--character = 0, -- GAMMA_CHARACTER: ARBITER
			text = "Arbiter to all wings! The kraken retreats! Press your attack!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_arbiter_01400.sound'),

		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "That doesn't look like a retreat.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_08500.sound'),

			sleepAfter = 0.5,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Let's help Arbiter finish this.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_15400.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;		
		hud_hide_radio_transmission_hud();
	end,
};


function plateau_sentry_battle_what_vtols():void

	PrintNarrative("START - plateau_sentry_battle_what_vtols");

				b_player_in_vtol1 = false;
				b_player_in_vtol2 = false;
				b_player_in_vtol1b = false;
				b_player_in_vtol2b = false;
	
				if object_valid( "vtol1" ) then
					print("vtol1 present");
					if player_in_vehicle( OBJECTS.vtol1 )
						then b_player_in_vtol1 = true;
						else b_player_in_vtol1 = false;
					end
				end
				if object_valid( "vtol2" ) then
					print("vtol2 present");
					if player_in_vehicle( OBJECTS.vtol2 )
						then b_player_in_vtol2 = true;
						else b_player_in_vtol2 = false;
					end
				end
				if object_valid( "vtol1b" ) then
					print("vtol1b present");
					if player_in_vehicle( OBJECTS.vtol1b )
						then b_player_in_vtol1b = true;
						else b_player_in_vtol1b = false;
					end
				end
				if object_valid( "vtol2b" ) then
					print("vtol2b present");
					if player_in_vehicle( OBJECTS.vtol2b )
						then b_player_in_vtol2b = true;
						else b_player_in_vtol2b = false;
					end
				end
				if g_display_narrative_debug_info then
						print("Player in vtol1", b_player_in_vtol1);
						print("Player in vtol2", b_player_in_vtol2);
						print("Player in vtol1b", b_player_in_vtol1b);
						print("Player in vtol2b", b_player_in_vtol2b);
				end

	PrintNarrative("END - plateau_sentry_battle_what_vtols");

end



--PLATEAU. SENTRY BATTLE. V-TOL NAG----------------------------------------------------------------------------------------------------
function plateau_sentry_battle_vtol_nag()
local speaker_2 = nil;

	PrintNarrative("WAKE - plateau_sentry_battle_vtol_nag");

	PrintNarrative("TIMER - plateau_sentry_battle_vtol_nag");

	--sleep_s(1);

	PrintNarrative("START - plateau_sentry_battle_vtol_nag");

	plateau_sentry_battle_what_vtols();

	if not b_player_in_vtol1 and not b_player_in_vtol2 and not b_player_in_vtol1b and not b_player_in_vtol2b and volume_test_players(VOLUMES.tv_narrative_plateau_sentry_battle_entrance) then

				
				W2HubPlateau_PLATEAU__SENTRY_BATTLE__V_TOL_Nag.localVariables.s_speaker = AlternateSpeakerWhenEnteringVolume(VOLUMES.tv_narrative_plateau_sentry_battle_entrance, 20);
				PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__V_TOL_Nag");
				NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__V_TOL_Nag);

				SleepUntil ([| NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__SENTRY_BATTLE__V_TOL_Nag)], 1);
	end

	sleep_s(15);

	plateau_sentry_battle_what_vtols();

	if not b_player_in_vtol1 and not b_player_in_vtol2 and not b_player_in_vtol1b and not b_player_in_vtol2b and volume_test_players(VOLUMES.tv_narrative_plateau_sentry_battle_entrance) then

		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__vtol_PUSH_FORWARD");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__vtol_PUSH_FORWARD);

	end

	PrintNarrative("END - plateau_sentry_battle_vtol_nag");

end



--[========================================================================[
          PLATEAU. SENTRY BATTLE. V-TOL Nag
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__V_TOL_Nag = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__V_TOL_Nag",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

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
					thisConvo.localVariables.s_locke = true;
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Grab a Phaeton.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_15700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					thisConvo.localVariables.s_buck = true;
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Phaetons!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_02400.sound'),

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
					thisConvo.localVariables.s_tanaka = true;
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Phaetons. Might as well use 'em.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_03200.sound'),

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
					thisConvo.localVariables.s_vale = true;
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Phaetons. Let's go.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_11200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--           Locke orders the gang into Phaetons:

		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker ~= SPARTANS.locke and thisConvo.localVariables.s_first_play ~= true; -- GAMMA_TRANSITION: Locke answers to all but himself
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Get airborne! We're taking the fight to them!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_12400.sound'),
		},
		[6] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.tv_narrative_plateau_sentry_battle_entrance, SPARTANS.tanaka) and thisConvo.localVariables.s_first_play ~= true; -- GAMMA_TRANSITION: Locke answers to all but himself
			end,		

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Affirmative. Saddle up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_06500.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		thisConvo.localVariables.s_first_play = true;
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {
					s_speaker = nil,
					s_locke = nil,
					s_buck = nil,
					s_tanaka = nil,
					s_vale = nil,
					s_first_play = nil,
					},
};




--[========================================================================[
          PLATEAU. vtol PUSH FORWARD

          If Locke is on the ground
--]========================================================================]
global W2HubPlateau_PLATEAU__vtol_PUSH_FORWARD = {
	name = "W2HubPlateau_PLATEAU__vtol_PUSH_FORWARD",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return IsSpartanAbleToSpeak(SPARTANS.locke) and not unit_in_vehicle( SPARTANS.locke);
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Locke, grab a Phaeton and get airborne!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_13300.sound'),
		},
		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return list_count(players()) > 1 and unit_in_vehicle( SPARTANS.locke) and not unit_in_vehicle( PLAYERS.player1);
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Grab a Phaeton and get airborne!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_19400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

};


--PLATEAU. SENTRY BATTLE. LEAVING WITHOUT GUNNER----------------------------------------------------------------------------------------------------
function plateau_sentry_battle_leaving_without_gunner()

	PrintNarrative("WAKE - plateau_sentry_battle_leaving_without_gunner");

--	SleepUntil([|	volume_return_objects_by_type( VOLUMES.tv_narrative_plateau_sentry_battle_leaving_without_gunner_vtol, 0)[1] ~= nil	], 10);
	SleepUntil([|	(object_valid("vtol1") and volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_leaving_without_gunner_vtol, OBJECTS.vtol1 ) and vehicle_test_seat_unit_list( OBJECTS.vtol1, "vtol_d", players() )) or
					(object_valid("vtol2") and volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_leaving_without_gunner_vtol, OBJECTS.vtol2 ) and vehicle_test_seat_unit_list( OBJECTS.vtol2, "vtol_d", players() )) or
					(object_valid("vtol1b") and volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_leaving_without_gunner_vtol, OBJECTS.vtol1b ) and vehicle_test_seat_unit_list( OBJECTS.vtol1b, "vtol_d", players() )) or
					(object_valid("vtol2b") and volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_leaving_without_gunner_vtol, OBJECTS.vtol2b ) and vehicle_test_seat_unit_list( OBJECTS.vtol2b, "vtol_d", players() ))
				], 10);
		

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__in_a_vtol");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__in_a_vtol);

	CreateMissionThread(plateau_sentry_battle_found_the_core);

end


--[========================================================================[
          PLATEAU. SENTRY BATTLE. in a vtol
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__in_a_vtol = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__in_a_vtol",

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

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Arbiter. We are airborne in Forerunner Phaetons.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_15500.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Arbiter",

			--character = 0, -- GAMMA_CHARACTER: ARBITER
			text = "Excellent. Bring fire upon the Covenant, Spartans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_arbiter_01700.sound'),
		},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 0.7,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(plateau_sentry_battle_kraken_landing);		
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__Kraken_attack_hint_01");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__Kraken_attack_hint_01);
	end,
};




--[========================================================================[
          PLATEAU. SENTRY BATTLE. Kraken attack hint 01

          While in a vehicle, most likely in combat, dogfight in the
          air.
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__Kraken_attack_hint_01 = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__Kraken_attack_hint_01",

	CanStart = function (thisConvo, queue)
		return IsSpartanAbleToSpeak(SPARTANS.tanaka) and (IsGoalActive(missionPlateau.goal_Awakening) or IsGoalActive(missionPlateau.goal_SentryBoss)) ; -- GAMMA_CONDITION
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
				return not plateau_sentrybattle_ship_who_is_onboard_sentryship();																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "SarahPalmer",

			--character = 0, -- GAMMA_CHARACTER: Palmer
			text = "Spartans, I appreciate the bravery, but what's the plan?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_palmer_02700.sound'),

			sleepAfter = 0.6,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not plateau_sentrybattle_ship_who_is_onboard_sentryship();																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Kraken's too well armored to knock down. Best bet's get inside. Destroy the generator.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_06900.sound'),

			sleepAfter = 0.5,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not plateau_sentrybattle_ship_who_is_onboard_sentryship();																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "SarahPalmer",

			--character = 0, -- GAMMA_CHARACTER: Palmer
			text = "Make it happen, folks.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_palmer_02800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("tracking_sentryboss");
		hud_hide_radio_transmission_hud();
		CreateMissionThread(tracking_sentryboss);
		CreateMissionThread(plateau_sentry_battle_kraken_attack_hint_02);
	end,
};



--PLATEAU. SENTRY BATTLE. KRAKEN ATTACK HINT 02----------------------------------------------------------------------------------------------------
function plateau_sentry_battle_kraken_attack_hint_02()

	PrintNarrative("WAKE - plateau_sentry_battle_kraken_attack_hint_02");

	PrintNarrative("TIMER - plateau_sentry_battle_kraken_attack_hint_02 - line 1");

	sleep_s(40);

	SleepUntil([| IsSpartanAbleToSpeak(SPARTANS.buck) ], 100);

	PrintNarrative("START - plateau_sentry_battle_kraken_attack_hint_02");

	if object_valid("vin_sent_machine_2") and object_get_health( object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1")) == 1 and not plateau_sentrybattle_ship_who_is_onboard_sentryship() then
				
				PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__Kraken_attack_hint_02_a");
				NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__Kraken_attack_hint_02_a);

				SleepUntil([| NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__SENTRY_BATTLE__Kraken_attack_hint_02_a) ], 30);
	end

	PrintNarrative("TIMER - plateau_sentry_battle_kraken_attack_hint_02 - line 2");

	sleep_s(60);

	SleepUntil([| IsSpartanAbleToSpeak(SPARTANS.tanaka) ], 100);

	PrintNarrative("START - plateau_sentry_battle_kraken_attack_hint_02");

	if object_valid("vin_sent_machine_2") and object_get_health( object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1")) == 1 and not plateau_sentrybattle_ship_who_is_onboard_sentryship() then
				

				PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__Kraken_attack_hint_02_b");
				NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__Kraken_attack_hint_02_b);

				SleepUntil([| NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__SENTRY_BATTLE__Kraken_attack_hint_02_b) ], 30);
	end

	PrintNarrative("TIMER - plateau_sentry_battle_kraken_attack_hint_02 - line 3");

	sleep_s(90);

	SleepUntil([| IsSpartanAbleToSpeak(SPARTANS.tanaka) ], 100);

	PrintNarrative("START - plateau_sentry_battle_kraken_attack_hint_02");

	if object_valid("vin_sent_machine_2") and object_get_health( object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1")) == 1 and not plateau_sentrybattle_ship_who_is_onboard_sentryship() then
				
				PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__Kraken_attack_hint_02_c");
				NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__Kraken_attack_hint_02_c);

				SleepUntil([| NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__SENTRY_BATTLE__Kraken_attack_hint_02_c) ], 30);			
	end

	PrintNarrative("END - plateau_sentry_battle_kraken_attack_hint_02");

end




--[========================================================================[
          PLATEAU. SENTRY BATTLE. Kraken attack hint 02

          If the player stay in the air and doesn't land on the Kraken,
          those are reminders that he has to land on the Kraken to
          destroy it.
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__Kraken_attack_hint_02_a = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__Kraken_attack_hint_02_a",

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
			text = "Focus fire on the deck. Clear some space and we can land on the Kraken.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_04100.sound'),

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
          PLATEAU. SENTRY BATTLE. Kraken attack hint 02

          If the player stay in the air and doesn't land on the Kraken,
          those are reminders that he has to land on the Kraken to
          destroy it.
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__Kraken_attack_hint_02_b = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__Kraken_attack_hint_02_b",

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
			text = "Get onboard the Kraken. Only way to get a shot at the Pulse generator.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_11000.sound'),

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
          PLATEAU. SENTRY BATTLE. Kraken attack hint 02

          If the player stay in the air and doesn't land on the Kraken,
          those are reminders that he has to land on the Kraken to
          destroy it.
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__Kraken_attack_hint_02_c = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__Kraken_attack_hint_02_c",

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
			text = "Spartans, land on the Kraken. Now!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_11100.sound'),

			},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


--------------------------------------------------------------------------------------------------------------------------------------------------
function plateau_sentry_battle_kraken_landing()

	PrintNarrative("WAKE - plateau_sentry_battle_kraken_landing");

	SleepUntil([|	plateau_sentrybattle_ship_who_is_onboard_sentryship()	], 30);

	PrintNarrative("START - plateau_sentry_battle_kraken_landing");

	
	if object_valid("vin_sent_machine_2") and object_get_health( object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1")) == 1 then

		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__Kraken_landing");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__Kraken_landing);
					
	end

	PrintNarrative("END - plateau_sentry_battle_kraken_landing");

	CreateMissionThread(PLATEAU__SENTRY_BATTLE__covies_on_the_kraken_grunt_01);
	CreateMissionThread(PLATEAU__SENTRY_BATTLE__covies_on_the_kraken_elite_01);

end



--[========================================================================[
          PLATEAU. SENTRY BATTLE. Kraken landing

          When a player lands on the Kraken, he should informs his
          teammates. We could keep that info for co-op only.

          In combat.
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__Kraken_landing = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__Kraken_landing",

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
				return b_locke_on_board_sentry_ship; -- GAMMA_TRANSITION: If locke first land on the `Kraken
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "I'm onboard the Kraken.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_13700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return b_buck_on_board_sentry_ship; -- GAMMA_TRANSITION: If buck first land on the Kraken
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "I'm onboard the Kraken.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_07400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return b_tanaka_on_board_sentry_ship; -- GAMMA_TRANSITION: If tanaka first land on the Kraken
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "I'm onboard the Kraken. Generator should be on the lowest level.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_10400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return b_vale_on_board_sentry_ship; -- GAMMA_TRANSITION: If vale first land on the Kraken
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "I'm onboard the Kraken.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_07200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Generator will be in the bottom. Find a path, follow it down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_07000.sound'),
		},
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(plateau_sentry_battle_where_is_the_core);
		hud_hide_radio_transmission_hud();		
	end,
};






------------------------------------------------------------------------------------------------------------------------------------------------------------
function PLATEAU__SENTRY_BATTLE__covies_on_the_kraken_grunt_01()

	PrintNarrative("START - PLATEAU__SENTRY_BATTLE__covies_on_the_kraken_grunt_01");

	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__SENTRY_BATTLE__covies_on_the_kraken_grunt_01, AI.gr_sentry_all, ACTOR_TYPE.grunt, "enemy_in_range", missionPlateau.goal_SentryBoss, 10 );

	PrintNarrative("END - PLATEAU__SENTRY_BATTLE__covies_on_the_kraken_grunt_01");

end

--[========================================================================[
          PLATEAU. SENTRY BATTLE. covies on the kraken
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__covies_on_the_kraken_grunt_01 = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__covies_on_the_kraken_grunt_01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			--character = 0 -- GAMMA_CHARACTER: grunt01
			text = "Humans on board!! Alert! Alert!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt01_01900.sound'),
		},
	},

	sleepAfter = 5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(PLATEAU__SENTRY_BATTLE__covies_on_the_kraken_grunt_02);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};



------------------------------------------------------------------------------------------------------------------------------------------------------------
function PLATEAU__SENTRY_BATTLE__covies_on_the_kraken_grunt_02()

	PrintNarrative("START - PLATEAU__SENTRY_BATTLE__covies_on_the_kraken_grunt_02");

	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__SENTRY_BATTLE__covies_on_the_kraken_grunt_02, AI.gr_sentry_all, ACTOR_TYPE.grunt, "enemy_in_range", missionPlateau.goal_SentryBoss, 10 );

	PrintNarrative("END - PLATEAU__SENTRY_BATTLE__covies_on_the_kraken_grunt_02");

end

--[========================================================================[
          PLATEAU. SENTRY BATTLE. covies on the kraken
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__covies_on_the_kraken_grunt_02 = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__covies_on_the_kraken_grunt_02",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	sleepAfter = 5,

	lines = {
		[1] = {
			--character = 0 -- GAMMA_CHARACTER: grunt01
			text = "You can not be on the Kraken!!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt01_02500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};


------------------------------------------------------------------------------------------------------------------------------------------------------------
function PLATEAU__SENTRY_BATTLE__covies_on_the_kraken_elite_01()

	PrintNarrative("START - PLATEAU__SENTRY_BATTLE__covies_on_the_kraken_elite_01");

	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__SENTRY_BATTLE__covies_on_the_kraken_elite_01, AI.gr_sentry_all, ACTOR_TYPE.elite, "enemy_in_range", missionPlateau.goal_SentryBoss, 10 );

	PrintNarrative("END - PLATEAU__SENTRY_BATTLE__covies_on_the_kraken_elite_01");

end

--[========================================================================[
          PLATEAU. SENTRY BATTLE. covies on the kraken
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__covies_on_the_kraken_elite_01 = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__covies_on_the_kraken_elite_01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,
	
	lines = {
		[1] = {
			--character = 0 -- GAMMA_CHARACTER: grunt01
			text = "Take the humans off the Kraken!!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_03700.sound'),
		},
	},

	sleepAfter = 5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(PLATEAU__SENTRY_BATTLE__covies_on_the_kraken_elite_02);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};



------------------------------------------------------------------------------------------------------------------------------------------------------------
function PLATEAU__SENTRY_BATTLE__covies_on_the_kraken_elite_02()

	PrintNarrative("START - PLATEAU__SENTRY_BATTLE__covies_on_the_kraken_elite_02");

	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__SENTRY_BATTLE__covies_on_the_kraken_elite_02, AI.gr_sentry_all, ACTOR_TYPE.elite, "enemy_in_range", missionPlateau.goal_SentryBoss, 10 );

	PrintNarrative("END - PLATEAU__SENTRY_BATTLE__covies_on_the_kraken_elite_02");

end

--[========================================================================[
          PLATEAU. SENTRY BATTLE. covies on the kraken
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__covies_on_the_kraken_elite_02 = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__covies_on_the_kraken_elite_02",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			--character = 0 -- GAMMA_CHARACTER: Elite01
			text = "I will throw you off the Kraken!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_01900.sound'),
		},
	},

	sleepAfter = 5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};



--PLATEAU. SENTRY BATTLE. WHERE IS THE CORE----------------------------------------------------------------------------------------------------
function plateau_sentry_battle_where_is_the_core()

	PrintNarrative("WAKE - plateau_sentry_battle_where_is_the_core");

	PrintNarrative("TIMER - plateau_sentry_battle_where_is_the_core - 20 - line 1");

	sleep_s(20);
	
	SleepUntil([| IsSpartanAbleToSpeak(SPARTANS.tanaka)	], 100);

	PrintNarrative("START - plateau_sentry_battle_where_is_the_core");

		if	not b_player_saw_the_kraken_core and plateau_sentrybattle_ship_who_is_onboard_sentryship() then

				
				PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__where_is_the_core_a");
				NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__where_is_the_core_a);

				SleepUntil([| NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__SENTRY_BATTLE__where_is_the_core_a)	], 30);

		end

	PrintNarrative("TIMER - plateau_sentry_battle_where_is_the_core - 20 - line 2");
		
	sleep_s(20);
	
	SleepUntil([| IsSpartanAbleToSpeak(SPARTANS.tanaka)	], 100);

	PrintNarrative("START - plateau_sentry_battle_where_is_the_core");

		if	not b_player_saw_the_kraken_core and plateau_sentrybattle_ship_who_is_onboard_sentryship() then
				
				
				PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__where_is_the_core_b");
				NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__where_is_the_core_b);

				SleepUntil([| NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__SENTRY_BATTLE__where_is_the_core_b)	], 30);			

		end

	PrintNarrative("TIMER - plateau_sentry_battle_where_is_the_core - 20 - line 3");

	sleep_s(20);
	
	SleepUntil([| IsSpartanAbleToSpeak(SPARTANS.tanaka)	], 100);

	PrintNarrative("START - plateau_sentry_battle_where_is_the_core");

		if	not b_player_saw_the_kraken_core and plateau_sentrybattle_ship_who_is_onboard_sentryship() then

				PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__where_is_the_core_c");
				NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__where_is_the_core_c);

				SleepUntil([| NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__SENTRY_BATTLE__where_is_the_core_c)	], 30);						

		end

	PrintNarrative("END - plateau_sentry_battle_where_is_the_core");

end



--[========================================================================[
          PLATEAU. SENTRY BATTLE. where is the core

          If any team member boards the Kraken and X time passes before
          they make it down into the hull X distance, that teammate
          will ask where to find the engine and Tanaka will explain.

          In combat.
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__where_is_the_core_a = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__where_is_the_core_a",

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

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Generator's on the lowest level. Move down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_06700.sound'),
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
          PLATEAU. SENTRY BATTLE. where is the core
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__where_is_the_core_b = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__where_is_the_core_b",

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

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Keep going down! Generator should be just below the hangar.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_11200.sound'),

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
          PLATEAU. SENTRY BATTLE. where is the core
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__where_is_the_core_c = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__where_is_the_core_c",

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

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Kraken can be confusing, keep going down for the Pulse Generator.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_11300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PushForwardVOReset();
	end,
};

--PLATEAU. SENTRY BATTLE. FOUND THE CORE----------------------------------------------------------------------------------------------------
function plateau_sentry_battle_found_the_core()

	PrintNarrative("WAKE - plateau_sentry_battle_found_the_core");

	
	SleepUntil([| object_valid("vin_sent_machine_2") and object_get_health( object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1") ) > 0.7 and 
					(
						(volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_found_the_core, SPARTANS.locke ) and objects_can_see_object( SPARTANS.locke, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 60 )) or 
						(volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_found_the_core_02, SPARTANS.locke ) and objects_can_see_object( SPARTANS.locke, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 45 )) or
						(volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_found_the_core_03, SPARTANS.locke ) and objects_can_see_object( SPARTANS.locke, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 45 ))
					) or 
					(
						(volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_found_the_core, SPARTANS.buck ) and objects_can_see_object( SPARTANS.buck, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 60 )) or 
						(volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_found_the_core_02, SPARTANS.buck ) and objects_can_see_object( SPARTANS.buck, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 45 )) or
						(volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_found_the_core_03, SPARTANS.buck ) and objects_can_see_object( SPARTANS.buck, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 45 ))
					) or 
					(
						(volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_found_the_core, SPARTANS.tanaka ) and objects_can_see_object( SPARTANS.tanaka, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 60 )) or 
						(volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_found_the_core_02, SPARTANS.tanaka ) and objects_can_see_object( SPARTANS.tanaka, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 45 )) or
						(volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_found_the_core_03, SPARTANS.tanaka ) and objects_can_see_object( SPARTANS.tanaka, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 45 ))
					) or 
					(
						(volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_found_the_core, SPARTANS.vale ) and objects_can_see_object( SPARTANS.vale, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 60 )) or 
						(volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_found_the_core_02, SPARTANS.vale ) and objects_can_see_object( SPARTANS.vale, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 45 )) or
						(volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_found_the_core_03, SPARTANS.vale ) and objects_can_see_object( SPARTANS.vale, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 45 ))
					)
					], 10);
	
	PrintNarrative("START - plateau_sentry_battle_found_the_core");

	b_player_saw_the_kraken_core = true;
				
	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__found_the_Core");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__found_the_Core);

	SleepUntil([| NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__SENTRY_BATTLE__found_the_Core)	], 1);

	PrintNarrative("END - plateau_sentry_battle_found_the_core");

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__Shooting_the_Core");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__Shooting_the_Core);	
end


--[========================================================================[
          PLATEAU. SENTRY BATTLE. found the Core
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__found_the_Core = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__found_the_Core",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return object_valid("vin_sent_machine_2") and (volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_found_the_core, SPARTANS.locke ) and objects_can_see_object( SPARTANS.locke, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 60 )) or 
						(volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_found_the_core_02, SPARTANS.locke ) and objects_can_see_object( SPARTANS.locke, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 45 )) or
						(volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_found_the_core_03, SPARTANS.locke ) and objects_can_see_object( SPARTANS.locke, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 45 ));						
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "I found the generator.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_10000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return object_valid("vin_sent_machine_2") and IsPlayer(SPARTANS.buck) and
						(volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_found_the_core, SPARTANS.buck ) and objects_can_see_object( SPARTANS.buck, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 60 )) or 
						(volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_found_the_core_02, SPARTANS.buck ) and objects_can_see_object( SPARTANS.buck, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 45 )) or
						(volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_found_the_core_03, SPARTANS.buck ) and objects_can_see_object( SPARTANS.buck, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 45 ));
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Found the generator.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_05500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return object_valid("vin_sent_machine_2") and not b_player_destroyed_the_kraken_core and IsPlayer(SPARTANS.tanaka) and 
						(volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_found_the_core, SPARTANS.tanaka ) and objects_can_see_object( SPARTANS.tanaka, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 60 )) or 
						(volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_found_the_core_02, SPARTANS.tanaka ) and objects_can_see_object( SPARTANS.tanaka, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 45 )) or
						(volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_found_the_core_03, SPARTANS.tanaka ) and objects_can_see_object( SPARTANS.tanaka, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 45 ));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Found the pulse generator. Gonna hit her with a few rounds and then get the hell out of here!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_07600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return object_valid("vin_sent_machine_2") and IsPlayer(SPARTANS.vale) and
						(volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_found_the_core, SPARTANS.vale ) and objects_can_see_object( SPARTANS.vale, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 60 )) or 
						(volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_found_the_core_02, SPARTANS.vale ) and objects_can_see_object( SPARTANS.vale, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 45 )) or
						(volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_found_the_core_03, SPARTANS.vale ) and objects_can_see_object( SPARTANS.vale, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 45 )) ;
			end,
								
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Found the pulse generator.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_04900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return not b_player_destroyed_the_kraken_core;
			end,		

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Hit her with a few rounds - then get the hell out of there.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_08000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		CreateMissionThread(PLATEAU__SENTRY_BATTLE__Shooting_the_Core_elite_01);
		CreateMissionThread(PLATEAU__SENTRY_BATTLE__Shooting_the_Core_grunt_01);
	end,
};



--[========================================================================[
          PLATEAU. SENTRY BATTLE. Shooting the Core

          When player shoots the pulse generator, it will begin to
          smoke, spark, and throw off mini-explosions.
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__Shooting_the_Core = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__Shooting_the_Core",

	CanStart = function (thisConvo, queue)
		return object_valid("vin_sent_machine_2") and object_get_health( object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1") ) < 1 
				and (	(list_count(players()) > 1 and object_get_health( object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1") ) > 0.2) 
						or (list_count(players()) == 1 and object_get_health( object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1") ) > 0.5)) 
				and objects_can_see_object( players(), object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 40 ) and objects_distance_to_object( players(), object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1") ) < 17; -- GAMMA_CONDITION
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
				return object_valid("vin_sent_machine_2") and not (object_get_health(object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1")) <= 0.05 or b_ship_destroyed == true)
						 and objects_distance_to_object( SPARTANS.locke, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1") ) < 17 and objects_can_see_object( SPARTANS.locke, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 41 ); -- GAMMA_TRANSITION: If Locke first hits the Core
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Direct hit on the pulse generator.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_13000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return object_valid("vin_sent_machine_2") and not (object_get_health(object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1")) <= 0.05 or	b_ship_destroyed == true)
						 and objects_distance_to_object( SPARTANS.buck, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1") ) < 17 and objects_can_see_object( SPARTANS.buck, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 41 ); -- GAMMA_TRANSITION: If BUCK first hits the Core
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Pulse generator's taking a beating. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_06500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return object_valid("vin_sent_machine_2") and not (object_get_health(object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1")) <= 0.05 or	b_ship_destroyed == true)
						and objects_distance_to_object( SPARTANS.tanaka, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1") ) < 17 and objects_can_see_object( SPARTANS.tanaka, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 41 ); -- GAMMA_TRANSITION: If Tanaka first hits the Core
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Pulse generator direct hit. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_07200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return object_valid("vin_sent_machine_2") and not (object_get_health(object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1")) <= 0.05 or	b_ship_destroyed == true)
						 and objects_distance_to_object( SPARTANS.vale, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1") ) < 17 and objects_can_see_object( SPARTANS.vale, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 41 ); -- GAMMA_TRANSITION: If Vale first hits the Core
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "I hit the pulse generator! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_08100.sound'),

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
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_almost_destroyed");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_almost_destroyed);
	end,	
};


------------------------------------------------------------------------------------------------------------------------------------------------------------
function PLATEAU__SENTRY_BATTLE__Shooting_the_Core_elite_01()

	PrintNarrative("START - PLATEAU__SENTRY_BATTLE__Shooting_the_Core_elite_01");

	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__SENTRY_BATTLE__Shooting_the_Core_elite_01, AI.gr_sentry_all, ACTOR_TYPE.elite, "enemy_in_range", missionPlateau.goal_SentryBoss, 10 );

	plateau_sentrybattle_ship_who_is_onboard_sentryship();

	if b_locke_on_board_sentry_ship then
		b_locke_heard_enemy_panicking = true;
	end

	PrintNarrative("END - PLATEAU__SENTRY_BATTLE__Shooting_the_Core_elite_01");

end

--[========================================================================[
          PLATEAU. SENTRY BATTLE. covies on the kraken
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__Shooting_the_Core_elite_01 = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__Shooting_the_Core_elite_01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return object_valid("vin_sent_machine_2") and object_get_health( object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1") ) > 0;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
					
			--character = 0 -- GAMMA_CHARACTER: elite01
			text = "Humans have breached the generator room! Stop them!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite02_00400.sound'),
		},
	},

	sleepAfter = 5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(PLATEAU__SENTRY_BATTLE__Shooting_the_Core_elite_02);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};


------------------------------------------------------------------------------------------------------------------------------------------------------------
function PLATEAU__SENTRY_BATTLE__Shooting_the_Core_elite_02()

	PrintNarrative("START - PLATEAU__SENTRY_BATTLE__Shooting_the_Core_elite_02");

	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__SENTRY_BATTLE__Shooting_the_Core_elite_02, AI.gr_sentry_all, ACTOR_TYPE.elite, "enemy_in_range", missionPlateau.goal_SentryBoss, 10 );

	plateau_sentrybattle_ship_who_is_onboard_sentryship();

	if b_locke_on_board_sentry_ship then
		b_locke_heard_enemy_panicking = true;
	end

	PrintNarrative("END - PLATEAU__SENTRY_BATTLE__Shooting_the_Core_elite_02");

end

--[========================================================================[
          PLATEAU. SENTRY BATTLE. covies on the kraken
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__Shooting_the_Core_elite_02 = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__Shooting_the_Core_elite_02",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return object_valid("vin_sent_machine_2") and object_get_health( object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1") ) > 0;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			--character = 0 -- GAMMA_CHARACTER: grunt01
			text = "Do not let the Humans destroy the Generator!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite02_00100.sound'),
		},
	},

	sleepAfter = 5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};


------------------------------------------------------------------------------------------------------------------------------------------------------------
function PLATEAU__SENTRY_BATTLE__Shooting_the_Core_grunt_01()

	PrintNarrative("START - PLATEAU__SENTRY_BATTLE__Shooting_the_Core_grunt_01");

	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__SENTRY_BATTLE__Shooting_the_Core_grunt_01, AI.gr_sentry_all, ACTOR_TYPE.grunt, "enemy_in_range", missionPlateau.goal_SentryBoss, 10 );

	plateau_sentrybattle_ship_who_is_onboard_sentryship();

	if b_locke_on_board_sentry_ship then
		b_locke_heard_enemy_panicking = true;
	end

	PrintNarrative("END - PLATEAU__SENTRY_BATTLE__Shooting_the_Core_grunt_01");

end

--[========================================================================[
          PLATEAU. SENTRY BATTLE. covies on the kraken
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__Shooting_the_Core_grunt_01 = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__Shooting_the_Core_grunt_01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return volume_test_players( VOLUMES.tv_narrative_plateau_sentry_battle_found_the_core);																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
		

			--character = 0 -- GAMMA_CHARACTER: grunt01
			text = "Humans are in the Generator room!!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt01_02600.sound'),
		},
	},

	sleepAfter = 5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(PLATEAU__SENTRY_BATTLE__Shooting_the_Core_grunt_02);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};


------------------------------------------------------------------------------------------------------------------------------------------------------------
function PLATEAU__SENTRY_BATTLE__Shooting_the_Core_grunt_02()

	PrintNarrative("START - PLATEAU__SENTRY_BATTLE__Shooting_the_Core_grunt_02");

	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__SENTRY_BATTLE__Shooting_the_Core_grunt_02, AI.gr_sentry_all, ACTOR_TYPE.grunt, "enemy_in_range", missionPlateau.goal_SentryBoss, 10 );

	plateau_sentrybattle_ship_who_is_onboard_sentryship();

	if b_locke_on_board_sentry_ship then
		b_locke_heard_enemy_panicking = true;
	end

	PrintNarrative("END - PLATEAU__SENTRY_BATTLE__Shooting_the_Core_grunt_02");

end

--[========================================================================[
          PLATEAU. SENTRY BATTLE. covies on the kraken
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__Shooting_the_Core_grunt_02 = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__Shooting_the_Core_grunt_02",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return object_valid("vin_sent_machine_2") and object_get_health( object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1") ) > 0;																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,
			--character = 0 -- GAMMA_CHARACTER: grunt01
			text = "They're breaking the generator! We're doomed!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt01_00200.sound'),
		},
	},

	sleepAfter = 5,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};



--[========================================================================[
          PLATEAU. SENTRY BATTLE. Core almost destroyed

          This line give the info to the player that they are doing the
          right thing and should keep doing it.

          Only triggers if Locke is not the one shooting at the Pulse
          generator.
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_almost_destroyed = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_almost_destroyed",

	CanStart = function (thisConvo, queue)
		return b_locke_heard_enemy_panicking and object_valid("vin_sent_machine_2") and object_get_health( object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1") ) > 0; -- GAMMA_CONDITION
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
				return object_valid("vin_sent_machine_2") and objects_distance_to_object( SPARTANS.locke, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1") ) > 5; -- GAMMA_TRANSITION: When players start to shoot the generator and Locke heard covenant panicking
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "It's working. The crew's panicking. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_13400.sound'),

			},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};




function plateau_sentry_battle_core_destroyed_launcher()

	PrintNarrative("LAUNCHER - plateau_sentry_battle_core_destroyed_launcher");
	-- From mission script

	--print(killer, " is the killer of ", turret);
	b_player_destroyed_the_kraken_core = true;
	local killer:object = GetClosestMusketeer(object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 50, 2);

	CreateMissionThread(plateau_sentry_battle_core_destroyed, killer);
end

function plateau_sentry_battle_core_destroyed(killer:object)

	PrintNarrative("WAKE - plateau_sentry_battle_core_destroyed");

	PrintNarrative("START - plateau_sentry_battle_core_destroyed");
	
	PushForwardVOStandBy();
		 
	W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed.localVariables.s_speaker = killer;
	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed);
	
	SleepUntil ([| NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed) ], 10);

	CreateMissionThread(plateau_sentry_battle_countdown_on);

	sleep_s(1);

	PrintNarrative("END - plateau_sentry_battle_core_destroyed");

	CreateMissionThread(plateau_sentry_battle_escape_covies_grunt_01);
	CreateMissionThread(plateau_sentry_battle_escape_covies_elite_01);
end



--[========================================================================[
          PLATEAU. SENTRY BATTLE. Core destroyed

          When a Player destroys the core...
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_loudspeaker");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_loudspeaker);
		CreateMissionThread(PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_grunt_01);
		CreateMissionThread(PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_elite_01);
		CreateMissionThread(PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_jackal_01);
	end,

	sleepBefore = 0.8,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Generator offline.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_08400.sound'),

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
			text = "Yeah! Generator destroyed!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_04600.sound'),

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

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Generator's busted.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_08100.sound'),

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

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Generator's offline!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_04100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,

			sleepAfter = 2,
		},	
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Get the hell out of there! Kraken's going down!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_11400.sound'),
		},

	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	sleepAfter = 3,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		opportunity_area_set_active("countdown_dialog_stim", true);
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_split");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_split);
	end,

	localVariables = {
					s_speaker = nil,
					},
};

function kraken_abandon_ship_loudspeaker()

	sleep_s(10);

	if not b_kraken_destroyed_cheering and IsGoalActive(missionPlateau.goal_SentryBoss) then

		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_loudspeaker");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_loudspeaker);
	end

end


--[========================================================================[
          PLATEAU. SENTRY BATTLE. Core destroyed

          When a Player destroys the core...
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_loudspeaker = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_loudspeaker",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		
	end,

	sleepBefore = 3,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_kraken_destroyed_cheering and IsGoalActive(missionPlateau.goal_SentryBoss);
			end,

			character = CHARACTER_OBJECTS.kraken_loudspeaker_01, -- GAMMA_CHARACTER: ElITE01
			text = "All hands! Abandon ship! Abandon ship!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_03100.sound'),

			playDurationAdjustment = 0,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_kraken_destroyed_cheering and IsGoalActive(missionPlateau.goal_SentryBoss);
			end,
			character = CHARACTER_OBJECTS.kraken_loudspeaker_02, -- GAMMA_CHARACTER: ElITE01
			text = "All hands! Abandon ship! Abandon ship!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_03100.sound'),

			sleepAfter = 5,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_kraken_destroyed_cheering and IsGoalActive(missionPlateau.goal_SentryBoss);
			end,
			character = CHARACTER_OBJECTS.kraken_loudspeaker_01, -- GAMMA_CHARACTER: ElITE01
			text = "All hands! Abandon ship! Abandon ship!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_03100.sound'),

			playDurationAdjustment = 0,
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_kraken_destroyed_cheering and IsGoalActive(missionPlateau.goal_SentryBoss);
			end,
			character = CHARACTER_OBJECTS.kraken_loudspeaker_02, -- GAMMA_CHARACTER: ElITE01
			text = "All hands! Abandon ship! Abandon ship!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_03100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(kraken_abandon_ship_loudspeaker);
	end,
};



--[========================================================================[
          PLATEAU. SENTRY BATTLE. Core destroyed

          When a Player destroys the core...
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_split = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_split",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return list_count(volume_return_players( VOLUMES.tv_narrative_plateau_sentry_kraken )) > 2; -- GAMMA_TRANSITION: If there is at least 3 players are on the Kraken
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Split up! There's another hangar with more banshees on the other side. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_11700.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__to_the_next_hangar");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__to_the_next_hangar);
	end,
};




------------------------------------------------------------------------------------------------------------------------------------------------------------
function PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_grunt_01()

	PrintNarrative("START - PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_grunt_01");

	sleep_s(3);

	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_grunt_01, AI.gr_sentry_all, ACTOR_TYPE.grunt, "enemy_in_range", missionPlateau.goal_SentryBoss, 10, true );

	PrintNarrative("END - PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_grunt_01");

end

--[========================================================================[
          PLATEAU. SENTRY BATTLE. covies on the kraken
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_grunt_01 = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_grunt_01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			--character = 0 -- GAMMA_CHARACTER: grunt01
			text = "Open the hangar door! Quick!!!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt01_02300.sound'),
		},
	},

	sleepAfter = 1,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_grunt_02);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};


------------------------------------------------------------------------------------------------------------------------------------------------------------
function PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_grunt_02()

	PrintNarrative("START - PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_grunt_02");

	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_grunt_02, AI.gr_sentry_all, ACTOR_TYPE.grunt, "enemy_in_range", missionPlateau.goal_SentryBoss, 10, true );

	PrintNarrative("END - PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_grunt_02");

end

--[========================================================================[
          PLATEAU. SENTRY BATTLE. covies on the kraken
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_grunt_02 = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_grunt_02",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			--character = 0 -- GAMMA_CHARACTER: grunt01
			text = "Abandon ship! ABANDON SHIP!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt01_02000.sound'),
		},
	},

	sleepAfter = 2,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_grunt_03);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};


------------------------------------------------------------------------------------------------------------------------------------------------------------
function PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_grunt_03()

	PrintNarrative("START - PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_grunt_03");

	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_grunt_03, AI.gr_sentry_all, ACTOR_TYPE.grunt, "enemy_in_range", missionPlateau.goal_SentryBoss, 10, true );

	PrintNarrative("END - PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_grunt_03");

end

--[========================================================================[
          PLATEAU. SENTRY BATTLE. covies on the kraken
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_grunt_03 = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_grunt_03",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			--character = 0 -- GAMMA_CHARACTER: grunt01
			text = "Banshee! Banshee! I need a Banshee! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_01800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};


------------------------------------------------------------------------------------------------------------------------------------------------------------
function PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_elite_01()

	PrintNarrative("START - PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_elite_01");

	sleep_s(2);

	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_elite_01, AI.gr_sentry_all, ACTOR_TYPE.elite, "enemy_in_range", missionPlateau.goal_SentryBoss, 10, true );

	PrintNarrative("END - PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_elite_01");

end

--[========================================================================[
          PLATEAU. SENTRY BATTLE. covies on the kraken
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_elite_01 = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_elite_01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			--character = 0 -- GAMMA_CHARACTER: grunt01
			text = "Human have destroyed the Pulse Generator!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_03800.sound'),
		},
	},

	sleepAfter = 2,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_elite_02);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};

------------------------------------------------------------------------------------------------------------------------------------------------------------
function PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_elite_02()

	PrintNarrative("START - PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_elite_01");

	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_elite_02, AI.gr_sentry_all, ACTOR_TYPE.elite, "enemy_in_range", missionPlateau.goal_SentryBoss, 10, true );

	PrintNarrative("END - PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_elite_01");

end

--[========================================================================[
          PLATEAU. SENTRY BATTLE. covies on the kraken
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_elite_02 = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_elite_02",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			--character = 0 -- GAMMA_CHARACTER: grunt01
			text = "The kraken will be destroyed! Go to the Banshees!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_02000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_elite_03);
	end,

	sleepAfter = 2,

	localVariables = {
					enemy_in_range = nil,
					},
};


------------------------------------------------------------------------------------------------------------------------------------------------------------
function PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_elite_03()

	PrintNarrative("START - PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_elite_03");

	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_elite_03, AI.gr_sentry_all, ACTOR_TYPE.elite, "enemy_in_range", missionPlateau.goal_SentryBoss, 10, true);

	PrintNarrative("END - PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_elite_03");

end

--[========================================================================[
          PLATEAU. SENTRY BATTLE. covies on the kraken
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_elite_03 = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_elite_03",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			--character = 0 -- GAMMA_CHARACTER: Elite01
			text = "To the banshees brothers! Open the hangar gate!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_02100.sound'),
		},
	},

	sleepAfter = 3,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_elite_04);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};


------------------------------------------------------------------------------------------------------------------------------------------------------------
function PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_elite_04()

	PrintNarrative("START - PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_elite_04");

	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_elite_04, AI.gr_sentry_all, ACTOR_TYPE.elite, "enemy_in_range", missionPlateau.goal_SentryBoss, 10 );

	PrintNarrative("END - PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_elite_04");

end

--[========================================================================[
          PLATEAU. SENTRY BATTLE. covies on the kraken
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_elite_04 = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_elite_04",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			--character = 0 -- GAMMA_CHARACTER: grunt01
			text = "Human! You will die with me!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_03900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};


------------------------------------------------------------------------------------------------------------------------------------------------------------
function PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_jackal_01()

	PrintNarrative("START - PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_jackal_01");

	sleep_s(3);

	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_jackal_01, AI.gr_sentry_all, ACTOR_TYPE.jackal, "enemy_in_range", missionPlateau.goal_SentryBoss, 10, true );

	PrintNarrative("END - PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_jackal_01");

end

--[========================================================================[
          PLATEAU. SENTRY BATTLE. covies on the kraken
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_jackal_01 = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_jackal_01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			--character = 0 -- GAMMA_CHARACTER: grunt01
			text = "Banshee! Banshee!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_jackal01_00500.sound'),
		},
	},

	sleepAfter = 7,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_jackal_02);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};


------------------------------------------------------------------------------------------------------------------------------------------------------------
function PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_jackal_02()

	PrintNarrative("START - PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_jackal_02");

	IsThereAnEnemyInRangeLauncher(W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_jackal_02, AI.gr_sentry_all, ACTOR_TYPE.jackal, "enemy_in_range", missionPlateau.goal_SentryBoss, 15, true );

	PrintNarrative("END - PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_jackal_02");

end

--[========================================================================[
          PLATEAU. SENTRY BATTLE. covies on the kraken
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_jackal_02 = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__Core_destroyed_covies_jackal_02",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			--character = 0 -- GAMMA_CHARACTER: grunt01
			text = "Escape!!! Escape!!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_jackal01_00600.sound'),
		},
	},

	sleepAfter = 7,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};

--[========================================================================[
          PLATEAU. SENTRY BATTLE. to the next hangar
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__to_the_next_hangar = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__to_the_next_hangar",

	CanStart = function (thisConvo, queue)
		return	list_count( volume_return_players( VOLUMES.tv_narrative_plateau_sentry_battle_hanger_left )) > 2 or 
				list_count( volume_return_players( VOLUMES.tv_narrative_plateau_sentry_battle_hanger_right )) > 2 or
				b_ship_destroyed; -- GAMMA_CONDITION
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
				return b_tanaka_on_board_sentry_ship and not b_ship_destroyed;
			end,

			--POLISH:  COULD CHECK CONDITIN IF BANSHEE ARE ALIVE

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "There's more banshees on the other side of the ship! Hurry!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_11800.sound'),

			},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


--PLATEAU. SENTRY BATTLE. COUNTDOWN ON----------------------------------------------------------------------------------------------------
function plateau_sentry_battle_countdown_on()

	PrintNarrative("WAKE - plateau_sentry_battle_countdown_on");

	SleepUntil([| object_valid("vin_sent_machine_2") and object_get_health( object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1") ) <= 0 ], 30);

	PrintNarrative("START - plateau_sentry_battle_countdown_on");

	sleep_s(4);
				
				plateau_sentrybattle_ship_who_is_onboard_sentryship();
				
				CreateMissionThread(plateau_sentry_battle_escape_the_kraken);

				--  IF LOCKE IS ON THE SHIP	
				if b_locke_on_board_sentry_ship then
					PrintNarrative("locke is on the ship")					

							PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__countdown_on_1");
							NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__countdown_on_1);
							SleepUntil([| NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__SENTRY_BATTLE__countdown_on_1) ], 30);

						sleep_s(10);
						plateau_sentrybattle_ship_who_is_onboard_sentryship();
					if b_locke_on_board_sentry_ship then

							PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__countdown_on_2");
							NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__countdown_on_2);
							SleepUntil([| NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__SENTRY_BATTLE__countdown_on_2) ], 30);
					end
			--    IF LOCKE IN VTOL AND ANY OTHER STILL ON THE SHIP
				elseif	b_tanaka_on_board_sentry_ship or b_vale_on_board_sentry_ship or b_buck_on_board_sentry_ship then
					PrintNarrative("Vale, tanaka or buck is on the Ship but not Locke")
					
							PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__countdown_on_3");
							NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__countdown_on_3);
							SleepUntil([| NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__SENTRY_BATTLE__countdown_on_3) ], 30);

						sleep_s(10);
						plateau_sentrybattle_ship_who_is_onboard_sentryship();
					if	b_tanaka_on_board_sentry_ship or b_vale_on_board_sentry_ship or b_buck_on_board_sentry_ship and not b_locke_on_board_sentry_ship then
							
							PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__countdown_on_4");
							NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__countdown_on_4);
							SleepUntil([| NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__SENTRY_BATTLE__countdown_on_4) ], 30);
					end

				end	
	
	PrintNarrative("END - plateau_sentry_battle_countdown_on");

end



--[========================================================================[
          PLATEAU. SENTRY BATTLE. countdown on
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__countdown_on_1 = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__countdown_on_1",

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
			text = "Locke! Evac now!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_07800.sound'),

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
          PLATEAU. SENTRY BATTLE. countdown on
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__countdown_on_2 = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__countdown_on_2",

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
			text = "Locke! Get off the Kraken, NOW!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_07000.sound'),

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
          PLATEAU. SENTRY BATTLE. countdown on
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__countdown_on_3 = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__countdown_on_3",

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
			text = "Evac! Now!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_14000.sound'),

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
          PLATEAU. SENTRY BATTLE. countdown on
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__countdown_on_4 = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__countdown_on_4",

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
			text = "Get off the Kraken NOW Spartans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_14100.sound'),

			},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function plateau_sentrybattle_ship_who_is_onboard_sentryship()
	--PrintNarrative("Narrative START - plateau_sentrybattle_ship_who_is_onboard_sentryship");
	
	b_locke_on_board_sentry_ship = false;		
	b_buck_on_board_sentry_ship = false;
	b_tanaka_on_board_sentry_ship = false;
	b_vale_on_board_sentry_ship = false;					

	if (volume_test_object(VOLUMES.tv_narrative_plateau_sentry_kraken, SPARTANS.locke) and not unit_in_vehicle(SPARTANS.locke)) then
			b_locke_on_board_sentry_ship = true;		
			PrintNarrative("Locke is on board the Kraken");
	end
	if 	(volume_test_object(VOLUMES.tv_narrative_plateau_sentry_kraken, SPARTANS.buck) and not unit_in_vehicle(SPARTANS.buck) and IsPlayer(SPARTANS.buck)) then
			b_buck_on_board_sentry_ship = true;		
			PrintNarrative("buck is on board the Kraken");
	end
	if	(volume_test_object(VOLUMES.tv_narrative_plateau_sentry_kraken, SPARTANS.tanaka) and not unit_in_vehicle(SPARTANS.tanaka) and IsPlayer(SPARTANS.tanaka)) then
			b_tanaka_on_board_sentry_ship = true;
			PrintNarrative("Tanaka is on board the Kraken");
	end
	if 	(volume_test_object(VOLUMES.tv_narrative_plateau_sentry_kraken, SPARTANS.vale) and not unit_in_vehicle(SPARTANS.vale) and IsPlayer(SPARTANS.vale)) then
			b_vale_on_board_sentry_ship = true;
			PrintNarrative("Vale is on board the Kraken");
	end
	
	--PrintNarrative("Narrative END - plateau_sentrybattle_ship_who_is_onboard_sentryship");

	return (b_locke_on_board_sentry_ship or b_buck_on_board_sentry_ship or b_tanaka_on_board_sentry_ship or b_vale_on_board_sentry_ship)
end


------------------------------------------------------------------------------------------------------------------------------------------------------------
function plateau_sentry_battle_escape_covies_grunt_01()

local closePlayer:object = nil;
local closeEnemy:object = nil;

	PrintNarrative("START - plateau_sentry_battle_escape_covies_grunt_01");

	repeat
		sleep_s(1);

		closePlayer, closeEnemy = GetClosestEnemy(AI.gr_sentry_all, 15);
		
	until	closePlayer ~= nil and closeEnemy ~= nil and unit_in_vehicle( closePlayer ) and ai_get_actor_type(object_get_ai(closeEnemy)) == ACTOR_TYPE.grunt and (volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_hanger_right, closePlayer) or volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_hanger_left, closePlayer))
			or list_count(AI.gr_sentry_all) <= 0
			or not IsGoalActive(missionPlateau.goal_SentryBoss)

	IsThereAnEnemyInRangeLauncher(W2HubPlateau_plateau_sentry_battle_escape_covies_grunt_01, AI.gr_sentry_all, ACTOR_TYPE.grunt, "enemy_in_range", missionPlateau.goal_SentryBoss, 15 );

	PrintNarrative("END - plateau_sentry_battle_escape_covies_grunt_01");

end

--[========================================================================[
          PLATEAU. SENTRY BATTLE. covies on the kraken
--]========================================================================]
global W2HubPlateau_plateau_sentry_battle_escape_covies_grunt_01 = {
	name = "W2HubPlateau_plateau_sentry_battle_escape_covies_grunt_01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			--character = 0 -- GAMMA_CHARACTER: grunt01
			text = "No, no Come back! It's my banshee!!!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt01_02400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};


------------------------------------------------------------------------------------------------------------------------------------------------------------
function plateau_sentry_battle_escape_covies_elite_01()

local closePlayer:object = nil;
local closeEnemy:object = nil;

	PrintNarrative("START - plateau_sentry_battle_escape_covies_elite_01");

	repeat
		sleep_s(1);

		closePlayer, closeEnemy = GetClosestEnemy(AI.gr_sentry_all, 15);
		
	until	closePlayer ~= nil and closeEnemy ~= nil and ai_get_actor_type(object_get_ai(closeEnemy)) == ACTOR_TYPE.elite and unit_in_vehicle( closePlayer ) and (volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_hanger_right, closePlayer) or volume_test_object( VOLUMES.tv_narrative_plateau_sentry_battle_hanger_left, closePlayer))
			or list_count(AI.gr_sentry_all) <= 0
			or not IsGoalActive(missionPlateau.goal_SentryBoss)

	IsThereAnEnemyInRangeLauncher(W2HubPlateau_plateau_sentry_battle_escape_covies_elite_01, AI.gr_sentry_all, ACTOR_TYPE.elite, "enemy_in_range", missionPlateau.goal_SentryBoss, 15 );

	PrintNarrative("END - plateau_sentry_battle_escape_covies_elite_01");

end

--[========================================================================[
          PLATEAU. SENTRY BATTLE. covies on the kraken
--]========================================================================]
global W2HubPlateau_plateau_sentry_battle_escape_covies_elite_01 = {
	name = "W2HubPlateau_plateau_sentry_battle_escape_covies_elite_01",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			--character = 0 -- GAMMA_CHARACTER: grunt01
			text = "Human is stealing our banshee!!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_03300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
					enemy_in_range = nil,
					},
};


--PLATEAU. SENTRY BATTLE. ESCAPE THE KRAKEN----------------------------------------------------------------------------------------------------
function plateau_sentry_battle_escape_the_kraken()

	PrintNarrative("WAKE - plateau_sentry_battle_escape_the_kraken");

	--[[
	SleepUntil([| 	( not volume_test_object(VOLUMES.tv_narrative_plateau_sentry_kraken, SPARTANS.locke) and b_locke_on_board_sentry_ship and unit_in_vehicle(SPARTANS.locke) ) or 				--		IF LOCKE WAS ON BOARD AND IS NOW OUTSIDE THE KRAKEN AND IN A VEHICLE
					( not volume_test_object(VOLUMES.tv_narrative_plateau_sentry_kraken, SPARTANS.buck) and b_buck_on_board_sentry_ship and unit_in_vehicle(SPARTANS.buck) ) or					--		IF BUCK WAS ON BOARD AND IS NOW OUTSIDE THE KRAKEN AND IN A VEHICLE
					( not volume_test_object(VOLUMES.tv_narrative_plateau_sentry_kraken, SPARTANS.tanaka) and b_tanaka_on_board_sentry_ship and unit_in_vehicle(SPARTANS.tanaka) ) or 			--		IF TANAKA WAS ON BOARD AND IS NOW OUTSIDE THE KRAKEN AND IN A VEHICLE
					( not volume_test_object(VOLUMES.tv_narrative_plateau_sentry_kraken, SPARTANS.vale) and b_vale_on_board_sentry_ship and unit_in_vehicle(SPARTANS.vale) )	 				--		IF VALE WAS ON BOARD AND IS NOW OUTSIDE THE KRAKEN AND IN A VEHICLE
				], 60);
	]]
	PrintNarrative("START - plateau_sentry_battle_escape_the_kraken");

	plateau_sentrybattle_ship_who_is_onboard_sentryship();
	
	if b_locke_on_board_sentry_ship then
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__escape_the_Kraken_locke");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__escape_the_Kraken_locke);		
	end
	if b_buck_on_board_sentry_ship then
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__escape_the_Kraken_buck");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__escape_the_Kraken_buck);
	end
	if b_tanaka_on_board_sentry_ship then
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__escape_the_Kraken_tanaka");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__escape_the_Kraken_tanaka);		
	end
	if b_vale_on_board_sentry_ship then
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__escape_the_Kraken_vale");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__escape_the_Kraken_vale);
	end	
	
	sleep_s(3);

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__kraken_destroyed_arbiters");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__kraken_destroyed_arbiters);

	PrintNarrative("END - plateau_sentry_battle_escape_the_kraken");

end

--[========================================================================[
          PLATEAU. SENTRY BATTLE. escape the Kraken
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__escape_the_Kraken_locke = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__escape_the_Kraken_locke",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return (not volume_test_object( VOLUMES.tv_narrative_plateau_sentry_kraken, SPARTANS.locke ) and unit_in_vehicle( SPARTANS.locke ) );
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
			text = "I'm clear of the Kraken!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_14200.sound'),

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
          PLATEAU. SENTRY BATTLE. escape the Kraken
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__escape_the_Kraken_buck = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__escape_the_Kraken_buck",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return (not volume_test_object( VOLUMES.tv_narrative_plateau_sentry_kraken, SPARTANS.buck ) and unit_in_vehicle( SPARTANS.buck ) );
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

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "[rebel yell or war whoop]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_05900.sound'),

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
          PLATEAU. SENTRY BATTLE. escape the Kraken
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__escape_the_Kraken_tanaka = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__escape_the_Kraken_tanaka",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return (not volume_test_object( VOLUMES.tv_narrative_plateau_sentry_kraken, SPARTANS.tanaka ) and unit_in_vehicle( SPARTANS.tanaka ) ) ;
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
			text = "Clear of the Kraken!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_07900.sound'),

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
          PLATEAU. SENTRY BATTLE. escape the Kraken
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__escape_the_Kraken_vale = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__escape_the_Kraken_vale",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return (not volume_test_object( VOLUMES.tv_narrative_plateau_sentry_kraken, SPARTANS.vale ) and unit_in_vehicle( SPARTANS.vale ) );
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

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "I'm clear of the Kraken!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_08700.sound'),

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
          PLATEAU. SENTRY BATTLE. kraken destroyed arbiters radio

          In the background of Arbiter's radio, we can hear Elite
          cheering. Kraken is down, we won this battle.
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__kraken_destroyed_arbiters = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__kraken_destroyed_arbiters",

	CanStart = function (thisConvo, queue)
		return b_kraken_destroyed_cheering; -- GAMMA_CONDITION
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
			
			moniker = "FlightLeader",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "Victory!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend01_00900.sound'),

			playDurationAdjustment = 0.8,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return false;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingSiqtarOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend02
			text = "Woop! Woop!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend02_00300.sound'),

			playDurationAdjustment = 0.1,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingLarOne",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend03
			text = "[Elite victory cheering]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend03_00400.sound'),

			playDurationAdjustment = 0.3,
		},		
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players( VOLUMES.tv_narrative_plateau_foreruner_gate);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingJardamThree",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "[Elite victory cheering]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend01_01400.sound'),

			playDurationAdjustment = 0.7,
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players( VOLUMES.tv_narrative_plateau_foreruner_gate);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingJardamTwo",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend03
			text = "[Elite victory cheering]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend03_01100.sound'),

			playDurationAdjustment = 0.2,
		},
		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players( VOLUMES.tv_narrative_plateau_foreruner_gate);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "WingLarTwo",

			--character = 0, -- GAMMA_CHARACTER: EliteFriend01
			text = "[Elite victory cheering]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elitefriend01_01300.sound'),

			playDurationAdjustment = 0.7,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__forerunner_gate_opening");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__forerunner_gate_opening);						
	end,
};


--[========================================================================[
          PLATEAU. SENTRY BATTLE. forerunner gate opening

          The Forerunner gate is opening.
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__forerunner_gate_opening = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__forerunner_gate_opening",

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
			
			moniker = "Arbiter",

			--character = 0, -- GAMMA_CHARACTER: ArBITER
			text = "Victory! Well done, Spartans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_arbiter_01500.sound'),

			playDurationAdjustment = 0.95,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "SarahPalmer",

			--character = 0, -- GAMMA_CHARACTER: Palmer
			text = "Hot damn, Osiris! That is beautiful work. Kraken's down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_palmer_00200.sound'),
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "SarahPalmer",

			--character = 0, -- GAMMA_CHARACTER: Palmer
			text = "Time to grab that Constructor. Halsey's coordinates are inside that Forerunner site.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_palmer_00700.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		CreateMissionThread(plateau_sentry_battle_push_forward);
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__OBELISK__LANDING_AREA");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__OBELISK__LANDING_AREA);
	end,
};					




------------------------------------------------------------------------------------------------------------------------------------------------------------
function plateau_sentry_battle_push_forward()

	PrintNarrative("WAKE - plateau_sentry_battle_push_forward");

	PrintNarrative("TIMER - plateau_sentry_battle_push_forward - line 1");

	sleep_s(30);

	PrintNarrative("START - plateau_sentry_battle_push_forward - line 1");

	if IsGoalActive(missionPlateau.goal_Return) then
	
				PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__push_forward_1");
				NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__push_forward_1);						
	end

	PrintNarrative("TIMER - plateau_sentry_battle_push_forward - line 2");

	sleep_s(30);

	PrintNarrative("START - plateau_sentry_battle_push_forward - line 2");

	if IsGoalActive(missionPlateau.goal_Return) then
	
				PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__SENTRY_BATTLE__push_forward_2");
				NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__SENTRY_BATTLE__push_forward_2);	
	
	PushForwardVOReset();

	end

	PrintNarrative("END - plateau_sentry_battle_push_forward");

	

end

--[========================================================================[
          PLATEAU. SENTRY BATTLE. push forward
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__push_forward_1 = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__push_forward_1",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players( VOLUMES.tv_narrative_plateau_foreruner_gate );																											--(not this.lines[lineNumber - 1].If(this, queue, lineNumber - 1));
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "SarahPalmer",

			--character = 0, -- GAMMA_CHARACTER: Palmer
			text = "Constructor should be right inside the Forerunner site.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_palmer_00300.sound'),

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
          PLATEAU. SENTRY BATTLE. push forward
--]========================================================================]
global W2HubPlateau_PLATEAU__SENTRY_BATTLE__push_forward_2 = {
	name = "W2HubPlateau_PLATEAU__SENTRY_BATTLE__push_forward_2",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not volume_test_players( VOLUMES.tv_narrative_plateau_foreruner_gate);
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "SarahPalmer",

			--character = 0, -- GAMMA_CHARACTER: Palmer
			text = "Halsey's coordinates point inside that Forerunner structure. Get in there.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_palmer_00400.sound'),

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
          PLATEAU. OBELISK. LANDING AREA

          Osiris lands the Phaetons in the Obelisk and they are
          reabsorbed in Forerunner fashion.
--]========================================================================]
global W2HubPlateau_PLATEAU__OBELISK__LANDING_AREA = {
	name = "W2HubPlateau_PLATEAU__OBELISK__LANDING_AREA",

	CanStart = function (thisConvo, queue)
		return volume_test_object( VOLUMES.tv_narrative_plateau_foreruner_gate, SPARTANS.locke ) and (not unit_in_vehicle( SPARTANS.locke ) and GetClosestMusketeer(SPARTANS.locke, 15, 2) ~= SPARTANS.locke); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 2,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return  list_count( players()) > 1 and volume_test_object( VOLUMES.tv_narrative_plateau_foreruner_gate, SPARTANS.locke ) and GetClosestMusketeer(SPARTANS.locke, 15, 2) ~= SPARTANS.locke;
			end,
		
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Osiris. On me. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_14600.sound'),
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
--   _____  ____  _      _____ _____ ______ _____  
--  / ____|/ __ \| |    |  __ \_   _|  ____|  __ \ 
-- | (___ | |  | | |    | |  | || | | |__  | |__) |
--  \___ \| |  | | |    | |  | || | |  __| |  _  / 
--  ____) | |__| | |____| |__| || |_| |____| | \ \ 
-- |_____/ \____/|______|_____/_____|______|_|  \_\
--                                                 
-- =================================================================================================


function plateau_soldier_load()

	PrintNarrative("LOAD - plateau_soldier_load");

	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__OBELISK__door_opening");					
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__OBELISK__door_opening);
	
	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__OBELISK__map");					
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__OBELISK__map);	

	PushForwardVOReset(100);

	CreateMissionThread(w2plateau_register_tracking_pinged_soldier_switch);

end


function w2plateau_register_tracking_pinged_soldier_switch()

	RegisterSpartanTrackingPingObjectEvent(w2plateau_tracking_pinged_soldier_switch, OBJECTS.dc_temple_switch);

end

function w2plateau_tracking_pinged_soldier_switch()

	b_soldier_switch_has_been_pinged = true;
	PrintNarrative("Soldier Switch has been pinged");

	sleep_s(30);

	b_soldier_switch_has_been_pinged = false;

	if not NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__OBELISK__break_something_hint_ping) then
		CreateMissionThread(w2plateau_register_tracking_pinged_soldier_switch);
	end
end


--[========================================================================[
          PLATEAU. OBELISK. door opening

          When the door is opening, we refocus the player on his
          objective. No combat.
--]========================================================================]
global W2HubPlateau_PLATEAU__OBELISK__door_opening = {
	name = "W2HubPlateau_PLATEAU__OBELISK__door_opening",

	CanStart = function (thisConvo, queue)
		return device_get_position( OBJECTS.dm_obelisk_entry_door ) > 0.05 and device_get_position( OBJECTS.dm_obelisk_entry_door ) < 0.8 and volume_test_object( VOLUMES.tv_narrative_plateau_foreruner_gate, SPARTANS.tanaka ) and IsSpartanAbleToSpeak(SPARTANS.tanaka); -- GAMMA_CONDITION
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

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Door's opening...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_09600.sound'),

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
          PLATEAU. OBELISK. map

          As the player enters the space. No enemy, no threat.
--]========================================================================]
global W2HubPlateau_PLATEAU__OBELISK__map = {
	name = "W2HubPlateau_PLATEAU__OBELISK__map",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.tv_narrative_soldier_room_entrance) ; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(45);
	end,

	sleepBefore = 1,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Alright. Where's this Constructor we're after?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_05000.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			sleepAfter = 1,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return false;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Constructors maintain and repair Forerunner installations. according to Halsey, one should be in here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_13400.sound'),
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Search the area.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_12700.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__OBELISK__break_something_hint");					
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__OBELISK__break_something_hint);
	end,
};



---------------------------------------------------------------------------------------------------------------------------------------
function plateau_obelisk_map()

	PrintNarrative("WAKE - plateau_obelisk_map");

	local looker:object = nil;
	local looker_2:object = nil;

	SleepUntil ([| volume_test_players(VOLUMES.tv_objcon_ob_20)  ], 30);

	sleep_s(1);

	repeat 
		sleep_s(0.1);
		looker = spartan_look_at_object(players(), OBJECTS.soldier_hologram, 12, 60, 0.1, 2)
	until looker ~= nil
	
	local looker_2:object = GetClosestMusketeer(looker, 20, 2);

	PrintNarrative("START - plateau_obelisk_map");
			
				
				W2HubPlateau_PLATEAU__OBELISK__map_2.localVariables.s_speaker = looker;
				PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__OBELISK__map_2");					
				NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__OBELISK__map_2);
										
	SleepUntil ([| objects_distance_to_object( players(), OBJECTS.soldier_hologram ) < 10 ], 10);

						looker_2 = GetClosestMusketeer(looker, 20, 2);
						print(looker_2);
						if looker_2 == SPARTANS.locke then
							 looker_2 = looker;
						end
						if looker_2 == SPARTANS.buck then
							 looker_2 = SPARTANS.locke;
						end

				W2HubPlateau_PLATEAU__OBELISK__map_3.localVariables.s_speaker = looker_2;
				PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__OBELISK__map_3");					
				NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__OBELISK__map_3);												

	PrintNarrative("END - plateau_obelisk_map");


end


--[========================================================================[
          PLATEAU. OBELISK. map

          As the player enters the space. No enemy, no threat.
--]========================================================================]
global W2HubPlateau_PLATEAU__OBELISK__map_2 = {
	name = "W2HubPlateau_PLATEAU__OBELISK__map_2",

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
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If locke is near
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Something woke up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_15900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: If buck is near
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Something woke up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_09200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: If tanaka is near
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Something woke up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_08900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: If vale is near
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Something woke up.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_09100.sound'),

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




--[========================================================================[
          PLATEAU. OBELISK. map

          As the player enters the space. No enemy, no threat.
--]========================================================================]
global W2HubPlateau_PLATEAU__OBELISK__map_3 = {
	name = "W2HubPlateau_PLATEAU__OBELISK__map_3",

	CanStart = function (thisConvo, queue)
		return true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(30);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If vale is close and alive
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "It's a map of this region. See? That's the Guardian there. Not sure what it's connected to...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_16200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 4; -- GAMMA_NEXT_LINE_NUMBER
			end,

			--playDurationAdjustment = 0.8,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: Else if tanaka is close and alive
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "It's a map of this region. See? That's the Guardian there. Not sure what it's connected to, though.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_11500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 4; -- GAMMA_NEXT_LINE_NUMBER
			end,

			--playDurationAdjustment = 0.8,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: Else if locke is close and alive
			end,

			
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "It's a map of this region. See? That's the Guardian there. Not sure what it's connected to, though.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_07400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 4; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Yeah, real pretty light show. Where's the Constructor?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_05100.sound'),
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Constructors repair things, right? So let's break something.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_09100.sound'),
		},
--           UI: OBJECTIVE TEXT - RETRIEVE CONSTRUCTOR

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		CreateMissionThread(plateau_obelisk_map_look_at);
		CreateMissionThread(plateau_obelisk_glass_look_at);		
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__OBELISK__break_something_hint_ping");		
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__OBELISK__break_something_hint_ping);
	end,

	localVariables = {
					s_speaker = nil
					},
};


--[========================================================================[
          PLATEAU. OBELISK. break something hint

          If the player doesn't know what to do after X time, we can
          help him focusing on the hologram.
--]========================================================================]
global W2HubPlateau_PLATEAU__OBELISK__break_something_hint_ping = {
	name = "W2HubPlateau_PLATEAU__OBELISK__break_something_hint_ping",

	CanStart = function (thisConvo, queue)
		return b_soldier_switch_has_been_pinged and device_get_power(OBJECTS.dc_punchbox) == 1 and not b_plateau_getting_constructor
				and ((not IsPlayer(SPARTANS.tanaka) and object_at_distance_and_can_see_object(players(), OBJECTS.soldier_glass, 20, 30))
						or	(object_at_distance_and_can_see_object(SPARTANS.tanaka, OBJECTS.soldier_glass, 20, 30))); -- GAMMA_CONDITION
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
			text = "Something came up on the hologram base",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_13500.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,

};




--[========================================================================[
          PLATEAU. OBELISK. break something hint

          If the player doesn't know what to do after X time, we can
          help him focusing on the hologram.
--]========================================================================]
global W2HubPlateau_PLATEAU__OBELISK__break_something_hint = {
	name = "W2HubPlateau_PLATEAU__OBELISK__break_something_hint",

	CanStart = function (thisConvo, queue)
		if b_push_forward_vo_timer == 4 and not IsSpartanAbleToSpeak(SPARTANS.tanaka) then
			b_push_forward_vo_timer = 10;
		end
		return b_push_forward_vo_timer == 3 and IsSpartanAbleToSpeak(SPARTANS.tanaka);
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
				return not b_plateau_getting_constructor;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					PushForwardVOReset(30);
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Maybe we should scan the area.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_00300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__OBELISK__break_something_hint_2");		
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__OBELISK__break_something_hint_2);
	end,

};


--[========================================================================[
          PLATEAU. OBELISK. break something hint

          If the player doesn't know what to do after X time, we can
          help him focusing on the hologram.
--]========================================================================]
global W2HubPlateau_PLATEAU__OBELISK__break_something_hint_2 = {
	name = "W2HubPlateau_PLATEAU__OBELISK__break_something_hint_2",

	CanStart = function (thisConvo, queue)
		if b_push_forward_vo_timer == 4 and not IsSpartanAbleToSpeak(SPARTANS.tanaka) then
			b_push_forward_vo_timer = 10;
		end
		return b_push_forward_vo_timer == 3 and IsSpartanAbleToSpeak(SPARTANS.tanaka) and W2HubPlateau_PLATEAU__OBELISK__map_3.localVariables.s_speaker ~= nil;
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
				return not b_plateau_getting_constructor;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					PushForwardVOReset(30);
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "There should be something at the hologram base.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_10700.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__OBELISK__break_something_hint_3");					
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__OBELISK__break_something_hint_3);
	end,

};


--[========================================================================[
          PLATEAU. OBELISK. break something hint

          If the player doesn't know what to do after X time, we can
          help him focusing on the hologram.
--]========================================================================]
global W2HubPlateau_PLATEAU__OBELISK__break_something_hint_3 = {
	name = "W2HubPlateau_PLATEAU__OBELISK__break_something_hint_3",

	CanStart = function (thisConvo, queue)
		if b_push_forward_vo_timer == 3 and not IsSpartanAbleToSpeak(SPARTANS.tanaka) then
			b_push_forward_vo_timer = 5;
		end
		return b_push_forward_vo_timer == 3 and IsSpartanAbleToSpeak(SPARTANS.tanaka);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(45);
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not b_plateau_getting_constructor;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "How about the hologram? Break it? Constructor should show up...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_12900.sound'),

			},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

};

---------------------------------------------------------------------------------------------------------------------------------------
function plateau_obelisk_map_look_at()

	PrintNarrative("WAKE - plateau_obelisk_map_look_at");

	sleep_s(5);

	repeat
		SleepUntil([|	(IsGoalActive(missionPlateau.goal_Map) or IsGoalActive(missionPlateau.goal_Artifact)) and 
						volume_test_players_lookat(VOLUMES.tv_narrative_soldier_room_hologram, 10, 5) ], 10);
				sleep_s(0.5);				
	until	not (IsGoalActive(missionPlateau.goal_Map) or IsGoalActive(missionPlateau.goal_Artifact)) or
			volume_test_players_lookat(VOLUMES.tv_narrative_soldier_room_hologram, 10, 5) 

	
	
	PrintNarrative("START - plateau_obelisk_map_look_at");

				PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__OBELISK__bunker_hologram");
				NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__OBELISK__bunker_hologram);

	PrintNarrative("END - plateau_obelisk_map_look_at");

end


--[========================================================================[
          PLATEAU. OBELISK. bunker hologram

          If a player looks more closely to the hologram, it triggers
          another VO. It gives more insight in the place and the
          Guardian.
--]========================================================================]
global W2HubPlateau_PLATEAU__OBELISK__bunker_hologram = {
	name = "W2HubPlateau_PLATEAU__OBELISK__bunker_hologram",

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
				return (not b_plateau_getting_constructor) and volume_test_player_lookat( VOLUMES.tv_narrative_soldier_room_hologram, unit_get_player(SPARTANS.locke), 10, 6 ) ; -- GAMMA_TRANSITION: If locke first look at the hologram
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "This facility is massive.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_14800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (not b_plateau_getting_constructor) and volume_test_player_lookat( VOLUMES.tv_narrative_soldier_room_hologram, unit_get_player(SPARTANS.buck), 10, 6 )  ; -- GAMMA_TRANSITION: If Buck first look at the hologram
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "This facility is massive.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_08000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (not b_plateau_getting_constructor) and volume_test_player_lookat( VOLUMES.tv_narrative_soldier_room_hologram, unit_get_player(SPARTANS.tanaka), 10, 6 ) ; -- GAMMA_TRANSITION: If tanaka first look at the hologram
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "This facility is massive.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_10800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (not b_plateau_getting_constructor) and volume_test_player_lookat( VOLUMES.tv_narrative_soldier_room_hologram, unit_get_player(SPARTANS.vale), 10, 6 )  ; -- GAMMA_TRANSITION: If vale first look at the hologram
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "This facility is massive.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_07500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return (not b_plateau_getting_constructor) and (volume_test_player_lookat( VOLUMES.tv_narrative_soldier_room_hologram, unit_get_player(SPARTANS.tanaka), 15, 20 ) or not IsPlayer(SPARTANS.tanaka))  ; -- GAMMA_TRANSITION: If vale first look at the hologram
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Few hundred square miles from the look of it. \r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_00200.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};



function plateau_obelisk_glass_look_at()

local s_speaker:object = nil;

	SleepUntil([| object_valid( "dc_punchbox" )  ], 60);
	
	PrintNarrative("LISTENER - plateau_obelisk_glass_look_at");

	repeat 
		
		SleepUntil([| volume_test_players(VOLUMES.plateau_obelisk_glass_look_at)], 10);		

			repeat
				Sleep(10);
				s_speaker = spartan_look_at_object(players(), OBJECTS.soldier_glass, 4, 30, 0.3, 0);
			until s_speaker ~= nil or not volume_test_players(VOLUMES.plateau_obelisk_glass_look_at) or IsGoalActive(missionPlateau.goal_Soldiers) 

	until s_speaker ~= nil or IsGoalActive(missionPlateau.goal_Soldiers) 

	if s_speaker ~= nil then
		W2HubPlateau_PLATEAU__OBELISK__when_looking_down_at_the_hologram.localVariables.s_speaker = s_speaker;
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__OBELISK__when_looking_down_at_the_hologram");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__OBELISK__when_looking_down_at_the_hologram);		
	end

end



--[========================================================================[
          PLATEAU. OBELISK. when looking down at the hologram base
--]========================================================================]
global W2HubPlateau_PLATEAU__OBELISK__when_looking_down_at_the_hologram = {
	name = "W2HubPlateau_PLATEAU__OBELISK__when_looking_down_at_the_hologram",

	CanStart = function (thisConvo, queue)		
		return thisConvo.localVariables.s_speaker ~= nil;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
	end,

	PlayOnSpecificPlayer = function(thisConvo, queue)	-- OBJECT (target all clients if unused)
		return thisConvo.localVariables.s_speaker;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke and device_get_power(OBJECTS.dc_punchbox) == 1;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    --radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "This looks like glass...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_19000.sound'),

		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck and device_get_power(OBJECTS.dc_punchbox) == 1;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    --radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "This looks like glass...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_10600.sound'),

		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka and device_get_power(OBJECTS.dc_punchbox) == 1;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    --radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "This looks like glass...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_13000.sound'),

		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale and device_get_power(OBJECTS.dc_punchbox) == 1;
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    --radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "This looks like glass...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_13300.sound'),

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


---------------------------------------------------------------------------------------------------------------------------------------
function plateau_obelisk_constructor(s_speaker:object)

	PrintNarrative("WAKE - plateau_obelisk_constructor");		
	
	if not b_plateau_getting_constructor then
				
				b_plateau_getting_constructor = true;

				CreateThread(audio_soldierroom_hologram_deactivate);

				b_constructor_activator = s_speaker;
			
				PushForwardVOReset();

				PrintNarrative("START - plateau_obelisk_constructor");	

				sleep_s(1);

				if not NarrativeQueue.IsConversationQueued(W2HubPlateau_PLATEAU__OBELISK__getting_the_constructor) then
					W2HubPlateau_PLATEAU__OBELISK__getting_the_constructor.localVariables.s_speaker = GetClosestMusketeer(s_speaker, 5, 2);
					PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__OBELISK__getting_the_constructor");					
					NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__OBELISK__getting_the_constructor);
					NarrativeQueue.InterruptConversation(W2HubPlateau_PLATEAU__OBELISK__map_3);
				end
	end

	PrintNarrative("END - plateau_obelisk_constructor");

end


--[========================================================================[
          PLATEAU. OBELISK. getting the constructor

          Player slams its rifle butt against something two or three
          times.
--]========================================================================]
global W2HubPlateau_PLATEAU__OBELISK__getting_the_constructor = {
	name = "W2HubPlateau_PLATEAU__OBELISK__getting_the_constructor",

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

	sleepBefore = 1.5,

	lines = {
		[1] = {
			character = AI.sq_fore_artifact_001.aisquadspawnpoint, -- GAMMA_CHARACTER: Constructor
			text = "[The Constructor makes an QUESTIONING SOUND.]",
			tag = TAG('sound\006_character\006_charactermove\006_cfx_fr_constructor\006_cfx_fr_constructor_question.sound'),

			playDurationAdjustment = 1,

			sleepAfter = 1.5,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: When The Constructor appears.
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "There it is. Do you suppose it will follow us?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_14900.sound'),

			playDurationAdjustment = 0.8,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: If Locke first broke the glass
			end,

			playDurationAdjustment = 0.8,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Hey little guy, we got work for you.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_08100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: If buck first broke the glass
			end,

			playDurationAdjustment = 0.8,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Come on. Got work for you.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_08200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: If tanaka first broke the glass
			end,

			playDurationAdjustment = 0.8,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Hi, ready to work?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_07900.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[6] = {
			character = AI.sq_fore_artifact_001.aisquadspawnpoint, -- GAMMA_CHARACTER: Constructor
			text = "[The Constructor makes an ACKNOWLEDGEMENT SOUND.]",
			tag = TAG('sound\006_character\006_charactermove\006_cfx_fr_constructor\006_cfx_fr_constructor_confirmed.sound'),

			playDurationAdjustment = 1,			
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);		
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__OBELISK__getting_the_constructor_soldiers");					
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__OBELISK__getting_the_constructor_soldiers);
		CreateMissionThread(plateau_constructor_sounds);
		b_plateau_constructor_sounds = true;
	end,

	localVariables = {
					s_speaker = nil
					},
};



--[========================================================================[
          PLATEAU. OBELISK. getting the constructor

          Player slams its rifle butt against something two or three
          times.
--]========================================================================]
global W2HubPlateau_PLATEAU__OBELISK__getting_the_constructor_soldiers = {
	name = "W2HubPlateau_PLATEAU__OBELISK__getting_the_constructor_soldiers",

	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sq_ob_sold_pair_1) > 0; -- GAMMA_CONDITION
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
			character = AI.sq_ob_sold_pair_1.spawn_points_0, -- GAMMA_CHARACTER: buck
			text = "Ambush. Humans.",
			tag = TAG('sound\001_vo\001_vo_ai\001_vo_ai_soldier01\001_vo_ai_fr_soldier01_01contact_ambush.sound'),
		},
		[2] = {
			character = AI.sq_ob_sold_pair_1.spawn_points_0, -- GAMMA_CHARACTER: buck
			text = "Ambush. Humans.",
			tag = TAG('sound\001_vo\001_vo_ai\001_vo_ai_soldier01\001_vo_ai_fr_soldier01_02combat_chargelongsdresponse.sound'),

			sleepAfter = 0.5,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "I think they're mad we're stealing their Constructor.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_10800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			sleepAfter = 0.5,
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Clear the area.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_19200.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		CreateMissionThread(plateau_obelisk_locked_door);
		hud_hide_radio_transmission_hud();
		CreateMissionThread(plateau_obelisk_post_encounter_listener);
	end,

	localVariables = {
					s_speaker = nil
					},
};

function plateau_obelisk_locked_door()

local s_speaker:object = nil;

	SleepUntil([| object_valid( "soldier_exit_door" )  ], 60);

	PrintNarrative("LISTENER - plateau_obelisk_locked_door");

	repeat 
		
		SleepUntil([| volume_test_players(VOLUMES.tv_narrative_plateau_soldier_exit_lookat)], 20);		
	
		s_speaker = spartan_look_at_object(players(), OBJECTS.soldier_exit_door, 13, 30, 0.2, 2);

	until s_speaker ~= nil or device_get_position( OBJECTS.dm_obelisk_entry_door ) > 0 	

	if s_speaker ~= nil and  ai_living_count(AI.sg_obelisk_all) > 0 then

		W2HubPlateau_obelisk_locked_door.localVariables.s_speaker = s_speaker;
		PrintNarrative("QUEUE - W2HubPlateau_obelisk_locked_door");
		NarrativeQueue.QueueConversation(W2HubPlateau_obelisk_locked_door);		
	end

end



--[========================================================================[
          


          PLATEAU. OBELISK. LOCKED DOOR

          If you get near the door before all the Prometheans are dead
--]========================================================================]
global W2HubPlateau_obelisk_locked_door = {
	name = "W2HubPlateau_obelisk_locked_door",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		b_plateau_constructor_sounds = false;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If lOCKE
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Door's sealed. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_19300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: If BUCK
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Door's sealed. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_10900.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: If vALE
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Door's sealed. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_13400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: If taNAKA
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Door's sealed. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_13100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			character = AI.sq_fore_artifact_001.aisquadspawnpoint, -- GAMMA_CHARACTER: Constructor
			text = "[The Constructor makes an ACKNOWLEDGEMENT SOUND.]",
			tag = TAG('sound\006_character\006_charactermove\006_cfx_fr_constructor\006_cfx_fr_constructor_confirmed.sound'),
		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Target the Prometheans. Give the little guy room to work.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_13200.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
		[7] = {
			character = AI.sq_fore_artifact_001.aisquadspawnpoint, -- GAMMA_CHARACTER: Constructor
			text = "[The Constructor makes an QUESTIONING SOUND.]",
			tag = TAG('sound\006_character\006_charactermove\006_cfx_fr_constructor\006_cfx_fr_constructor_question.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		b_plateau_constructor_sounds = true;
	end,

	localVariables = {
					s_speaker = nil
					},
};


---------------------------------------------------------------------------------------------------------------------------------------

function plateau_obelisk_post_encounter_listener()

	SleepUntil([| ai_living_count(AI.sg_obelisk_all) > 0 ], 60);
	SleepUntil([| ai_living_count(AI.sg_obelisk_all) <= 1 ], 10);

	local s_last_living_ai:object = ai_get_unit( AI.sg_obelisk_all );

	PrintNarrative("LISTENER - plateau_obelisk_post_encounter_listener");
	print(" LAst AI alive is:  ", s_last_living_ai);

	if ai_living_count(AI.sg_obelisk_all) <= 0 then
		PrintNarrative("LISTENER - plateau_obelisk_post_encounter_listener - ALL DEAD");

		if IsSpartanAbleToSpeak(SPARTANS.buck) then
			CreateMissionThread(plateau_obelisk_post_encounter_launcher, s_last_living_ai, SPARTANS.buck);
		elseif IsSpartanAbleToSpeak(SPARTANS.vale) then
			CreateMissionThread(plateau_obelisk_post_encounter_launcher, s_last_living_ai, SPARTANS.vale);
		elseif IsSpartanAbleToSpeak(SPARTANS.tanaka) then
			CreateMissionThread(plateau_obelisk_post_encounter_launcher, s_last_living_ai, SPARTANS.tanaka);
		else
			CreateMissionThread(plateau_obelisk_post_encounter_launcher, s_last_living_ai, SPARTANS.locke);
		end
	else
		RegisterDeathEvent (plateau_obelisk_post_encounter_launcher, s_last_living_ai);
	end

end

function plateau_obelisk_post_encounter_launcher(target:object, killer:object)

	PrintNarrative("LAUNCHER - plateau_obelisk_post_encounter_launcher");

	print(killer, " is the killer of ", target);
		
	W2HubPlateau_PLATEAU__OBELISK__post_encounter.localVariables.s_speaker = killer;
	PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__OBELISK__post_encounter");
	NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__OBELISK__post_encounter);

end


--[========================================================================[
          PLATEAU. OBELISK. post encounter
--]========================================================================]
global W2HubPlateau_PLATEAU__OBELISK__post_encounter = {
	name = "W2HubPlateau_PLATEAU__OBELISK__post_encounter",

	CanStart = function (thisConvo, queue)
		return IsSpartanAbleToSpeak(SPARTANS.locke); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		PushForwardVOReset(50);
		b_plateau_constructor_sounds = false;
	end,

	sleepBefore = 2,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.locke; -- GAMMA_TRANSITION: If locke first kill the last one
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "All clear!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_16300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.buck; -- GAMMA_TRANSITION: If buck first kill the last one
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "All clear!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_09100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.tanaka; -- GAMMA_TRANSITION: If tanaka first kill the last one
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "All clear!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_11600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.vale; -- GAMMA_TRANSITION: If vale first kill the last one
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "All clear!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_09000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return b_constructor_activator == SPARTANS.tanaka; -- GAMMA_TRANSITION: If tanaka first broke the glass
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Little fella seems to like you, Tanaka.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_09300.sound'),

		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Commander Palmer, we have the Constructor. Ready for extraction.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_12900.sound'),

		},
		[7] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "SarahPalmer",

			--character = 0, -- GAMMA_CHARACTER: Palmer
			text = "Nice work, Spartans. Arbiter? Ready for pickup.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_palmer_01000.sound'),

		},
		[8] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
			
			moniker = "Arbiter",

			--character = 0, -- GAMMA_CHARACTER: ARBITER
			text = "I am sending a ship your way, Spartans. \r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_arbiter_01600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__OBELISK__post_encounter_nag");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__OBELISK__post_encounter_nag);
		b_plateau_constructor_sounds = true;
	end,

	localVariables = {
					s_speaker = nil,
					},
};



--[========================================================================[
          PLATEAU. OBELISK. post encounter nag
--]========================================================================]
global W2HubPlateau_PLATEAU__OBELISK__post_encounter_nag = {
	name = "W2HubPlateau_PLATEAU__OBELISK__post_encounter_nag",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_timer == 3 and volume_test_players_all( VOLUMES.tv_narrative_plateau_obelisk_room ); -- GAMMA_CONDITION
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

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Arbiter's waiting outside.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_04100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_hide_radio_transmission_hud();
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__OBELISK__post_encounter_nag_2");
		NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__OBELISK__post_encounter_nag_2);
	end,
};



--[========================================================================[
          PLATEAU. OBELISK. post encounter nag
--]========================================================================]
global W2HubPlateau_PLATEAU__OBELISK__post_encounter_nag_2 = {
	name = "W2HubPlateau_PLATEAU__OBELISK__post_encounter_nag_2",

	CanStart = function (thisConvo, queue)
		return b_push_forward_vo_timer == 3 and volume_test_players_all( VOLUMES.tv_narrative_plateau_obelisk_room ); -- GAMMA_CONDITION
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

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "The ride home is back where we came in.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_01500.sound'),

			},
	},

	OnLinesComplete = function(thisConvo, queue) -- VOID
		hud_hide_radio_transmission_hud();
	end,

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,
};


function plateau_constructor_sounds()

sleep_s(10);

repeat
	SleepUntil([| b_plateau_constructor_sounds and objects_distance_to_object( players(), ai_get_object(AI.sq_fore_artifact_001.aisquadspawnpoint) ) < 12], 60);

	PrintNarrative("QUEUE - Plateau_constructor_sounds");
	NarrativeQueue.QueueConversation(Plateau_constructor_sounds);

	SleepUntil([| NarrativeQueue.HasConversationFinished(Plateau_constructor_sounds)], 10);

	sleep_s(random_range(5,20));

until not b_plateau_constructor_sounds

end


--[========================================================================[
          Ext. LANDING PAD

          The Constructor flies off to toward HALSEY.
--]========================================================================]
global Plateau_constructor_sounds = {
	name = "Plateau_constructor_sounds",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		thisConvo.localVariables.s_line_play = random_range(1,6)
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_play == 1;
			end,

			character = AI.sq_fore_artifact_001.aisquadspawnpoint, -- GAMMA_CHARACTER: Constructor
			text = "[The Constructor makes an QUESTIONING SOUND.]",
			tag = TAG('sound\006_character\006_charactermove\006_cfx_fr_constructor\006_cfx_fr_constructor_confirmed.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_play == 2;
			end,
			
			character = AI.sq_fore_artifact_001.aisquadspawnpoint, -- GAMMA_CHARACTER: Constructor
			text = "[The Constructor makes an QUESTIONING SOUND.]",
			tag = TAG('sound\006_character\006_charactermove\006_cfx_fr_constructor\006_cfx_fr_constructor_lookatdevice.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_play == 3;
			end,

			character = AI.sq_fore_artifact_001.aisquadspawnpoint, -- GAMMA_CHARACTER: Constructor
			text = "[The Constructor makes an QUESTIONING SOUND.]",
			tag = TAG('sound\006_character\006_charactermove\006_cfx_fr_constructor\006_cfx_fr_constructor_lookatguardian.sound'),
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_play == 4;
			end,

			character = AI.sq_fore_artifact_001.aisquadspawnpoint, -- GAMMA_CHARACTER: Constructor
			text = "[The Constructor makes an QUESTIONING SOUND.]",
			tag = TAG('sound\006_character\006_charactermove\006_cfx_fr_constructor\006_cfx_fr_constructor_question.sound'),
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_play == 5;
			end,

			character = AI.sq_fore_artifact_001.aisquadspawnpoint, -- GAMMA_CHARACTER: Constructor
			text = "[The Constructor makes an QUESTIONING SOUND.]",
			tag = TAG('sound\006_character\006_charactermove\006_cfx_fr_constructor\006_cfx_fr_constructor_travelstart.sound'),
		},
		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return thisConvo.localVariables.s_line_play == 6;
			end,

			character = AI.sq_fore_artifact_001.aisquadspawnpoint, -- GAMMA_CHARACTER: Constructor
			text = "[The Constructor makes an QUESTIONING SOUND.]",
			tag = TAG('sound\006_character\006_charactermove\006_cfx_fr_constructor\006_cfx_fr_constructor_trysomething.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
	end,

	localVariables = {
						s_line_play = nil,
						},
};

-- ===================================================================================================

function blink_fixer_narrative()
	
	print("*************  PLATEAU NARRATIVE BLINK FIXERLOADED ******************");

	b_push_forward_vo_active = false;

	--PrintNarrative("PushForward VO Reset");
	PushForwardVOStandBy();

	PrintNarrative("Killing Narrative Queue");
	--NarrativeQueue.Kill();

	CreateMissionThread(plateau_pushforward);
	CreateMissionThread(PushForwardVO);
	CreateMissionThread(plateau_chatter);

end


------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------


function plateau_pushforward()

PrintNarrative("WAKE - plateau_pushforward");

repeat
	
			PrintNarrative("START - plateau_pushforward");

			SleepUntil([| b_push_forward_vo_timer == 0], 30);

			if not b_arbiter_is_attacking and (IsGoalActive(missionPlateau.goal_Breach) or IsGoalActive(missionPlateau.goal_Caves)  or IsGoalActive(missionPlateau.goal_SentryShipEncounter) or IsGoalActive(missionPlateau.goal_Exit)) then
						
						PrintNarrative("START - plateau_pushforward - line 1");						
				
						PrintNarrative("QUEUE - W2HubPlateau_Plateau__dropdown__push_forward");
						NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__dropdown__push_forward);						
			end
	
			SleepUntil([| b_push_forward_vo_timer == 0], 30);

			if  IsGoalActive(missionPlateau.goal_SentryShipEncounter) or IsGoalActive(missionPlateau.goal_Hollow) or IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_PreBowl) then

						PrintNarrative("START - plateau_pushforward - line 4");

						PrintNarrative("QUEUE - W2HubPlateau_Plateau__general__push_forward");
						NarrativeQueue.QueueConversation(W2HubPlateau_Plateau__general__push_forward);
			end

			--	GENERAL		
						
			SleepUntil([| b_push_forward_vo_timer >= 0 and b_push_forward_vo_timer < 2], 30);			

			if  NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__BOWL__push_forward_01) and NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__RAMP__OREO_BOWL_Set_Up_linger_1) and NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__BOWL__push_forward_02_a) then

						PrintNarrative("QUEUE - W2Plateau_push_forward_03");
						NarrativeQueue.QueueConversation(W2Plateau_push_forward_03);

						PushForwardVOReset();
			end
			
			SleepUntil([| b_push_forward_vo_timer >= 0 and b_push_forward_vo_timer < 2], 30);			

			if  NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__BOWL__push_forward_01) and NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__RAMP__OREO_BOWL_Set_Up_linger_1) and NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__BOWL__push_forward_02_a) then

						PrintNarrative("QUEUE - W2Plateau_push_forward_04");
						NarrativeQueue.QueueConversation(W2Plateau_push_forward_04);

						PushForwardVOReset();
			end

			SleepUntil([| b_push_forward_vo_timer >= 0 and b_push_forward_vo_timer < 2], 30);			

			if  NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__BOWL__push_forward_01) and NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__RAMP__OREO_BOWL_Set_Up_linger_1) and NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__BOWL__push_forward_02_a) then
			
						PrintNarrative("QUEUE - W2Plateau_push_forward_05");
						NarrativeQueue.QueueConversation(W2Plateau_push_forward_05);

						PushForwardVOReset();
			end

			SleepUntil([| b_push_forward_vo_timer >= 0 and b_push_forward_vo_timer < 2], 30);			

			if  NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__BOWL__push_forward_01) and NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__RAMP__OREO_BOWL_Set_Up_linger_1) and NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__BOWL__push_forward_02_a) then
						
						PrintNarrative("QUEUE - W2Plateau_push_forward_06");
						NarrativeQueue.QueueConversation(W2Plateau_push_forward_06);

						PushForwardVOReset();
			end

			SleepUntil([| b_push_forward_vo_timer >= 0 and b_push_forward_vo_timer < 2], 30);			

			if  NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__BOWL__push_forward_01) and NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__RAMP__OREO_BOWL_Set_Up_linger_1) and NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__BOWL__push_forward_02_a) then
			
						PrintNarrative("QUEUE - W2Plateau_push_forward_07");
						NarrativeQueue.QueueConversation(W2Plateau_push_forward_07);

						PushForwardVOReset();			
			end

			SleepUntil([| b_push_forward_vo_timer >= 0 and b_push_forward_vo_timer < 2], 30);			

			if  NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__BOWL__push_forward_01) and NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__RAMP__OREO_BOWL_Set_Up_linger_1) and NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__BOWL__push_forward_02_a) then
						
						PrintNarrative("QUEUE - W2Plateau_push_forward_08");
						NarrativeQueue.QueueConversation(W2Plateau_push_forward_08);

						PushForwardVOReset();
			end
			
			SleepUntil([| b_push_forward_vo_timer >= 0 and b_push_forward_vo_timer < 2], 30);			
			
			if  NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__BOWL__push_forward_01) and NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__RAMP__OREO_BOWL_Set_Up_linger_1) and NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__BOWL__push_forward_02_a) then

						PrintNarrative("QUEUE - W2Plateau_push_forward_09");
						NarrativeQueue.QueueConversation(W2Plateau_push_forward_09);

						PushForwardVOReset();
			end

			SleepUntil([| b_push_forward_vo_timer >= 0 and b_push_forward_vo_timer < 2], 30);			

			if  NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__BOWL__push_forward_01) and NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__RAMP__OREO_BOWL_Set_Up_linger_1) and NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__BOWL__push_forward_02_a) then

						PrintNarrative("QUEUE - W2Plateau_push_forward_10");
						NarrativeQueue.QueueConversation(W2Plateau_push_forward_10);

						PushForwardVOReset();
			end

			SleepUntil([| b_push_forward_vo_timer >= 0 and b_push_forward_vo_timer < 2], 30);			

			if  NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__BOWL__push_forward_01) and NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__RAMP__OREO_BOWL_Set_Up_linger_1) and NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__BOWL__push_forward_02_a) then
				
						PrintNarrative("QUEUE - W2Plateau_push_forward_11");
						NarrativeQueue.QueueConversation(W2Plateau_push_forward_11);

						PushForwardVOReset();
			end			

			PrintNarrative("END - plateau_pushforward");

			b_push_forward_vo_timer_default = b_push_forward_vo_timer_default + b_push_forward_vo_timer_default;

			PushForwardVOReset();

until not b_push_forward_vo_active

	
end



--[========================================================================[
          Plateau. dropdown. push forward
--]========================================================================]
global W2HubPlateau_Plateau__dropdown__push_forward = {
	name = "W2HubPlateau_Plateau__dropdown__push_forward",


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
			text = "Arbiter is ready to move, we should  go!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_09900.sound'),

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
          Plateau. general. push forward

          Those lines can be triggered anywhere in the mission, when
          the player is not in combat.

          Should be generic enough to work in any area.
--]========================================================================]
global W2HubPlateau_Plateau__general__push_forward = {
	name = "W2HubPlateau_Plateau__general__push_forward",

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
			
			moniker = "SarahPalmer",

			--character = 0, -- GAMMA_CHARACTER: Palmer
			text = "Osiris, Covenant have deployed reinforcement between you and the Constructor. Best get moving.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_palmer_03000.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Aye, Commander. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_15000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
	end,
};





--[========================================================================[
          PUSH FORWARD

--]========================================================================]
global W2Plateau_push_forward_03 = {
	name = "W2Plateau_push_forward_03",

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
global W2Plateau_push_forward_04 = {
	name = "W2Plateau_push_forward_04",

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
global W2Plateau_push_forward_05 = {
	name = "W2Plateau_push_forward_05",

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
global W2Plateau_push_forward_06 = {
	name = "W2Plateau_push_forward_06",

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
global W2Plateau_push_forward_07 = {
	name = "W2Plateau_push_forward_07",

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
global W2Plateau_push_forward_08 = {
	name = "W2Plateau_push_forward_08",

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
global W2Plateau_push_forward_09 = {
	name = "W2Plateau_push_forward_09",

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
global W2Plateau_push_forward_10 = {
	name = "W2Plateau_push_forward_10",

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
global W2Plateau_push_forward_11 = {
	name = "W2Plateau_push_forward_11",

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

function plateau_is_there_enemy_nearby(distance:number)

	PrintNarrative("WAKE - plateau_is_there_enemy_nearby");

	if	TestClosestEnemyDistance(AI.sg_reveal_all, distance) or
		TestClosestEnemyDistance(AI.sg_hollow_all, distance) or
		TestClosestEnemyDistance(AI.sg_obelisk_all, distance) or
		TestClosestEnemyDistance(AI.sg_ramp_all, distance) or
		TestClosestEnemyDistance(AI.gr_plat_all, distance) then
				plateau_is_there_enemy_nearby_result = true;
				PrintNarrative("plateau_is_there_enemy_nearby_result = true");
	else
				plateau_is_there_enemy_nearby_result = false;
				PrintNarrative("plateau_is_there_enemy_nearby_result = false");
	end

	PrintNarrative("END - plateau_is_there_enemy_nearby");

end


function plateau_four_players_combat_check()

	PrintNarrative("START - plateau_four_players_combat_check");

	repeat

		SleepUntil([| list_count(players()) == 4], 1800);

		repeat 

			SleepUntil([| not b_collectible_used and ((b_push_forward_vo_counrdown_on > 20 and not IsSpartanInCombat()) or list_count(players()) ~= 4)], 30);

			if list_count(players()) == 4 then
				plateau_is_there_enemy_nearby(30);

				if plateau_is_there_enemy_nearby_result then
					PushForwardVOReset();
				end
			end

		until not b_push_forward_vo_active or list_count(players()) ~= 4

	until not IsMissionActive(missionPlateau)

	PrintNarrative("END - plateau_four_players_combat_check");

end


-----------------------------------------------------------------

function plateau_chatter()

local s_chatter_02:boolean = false;
local s_chatter_03:boolean = false;
local s_chatter_04:boolean = false;

	PrintNarrative("WAKE - plateau_chatter");

	repeat					
				
				repeat
					sleep_s(5);
					SleepUntil([| b_chatter_is_permitted and not b_critical_dialogue_on and b_push_forward_vo_counrdown_on > 45 and not b_collectible_used and not IsSpartanInCombat() and not b_kraken_in_ramp
								and not volume_test_players( VOLUMES.tv_narrative_plateau_temple_ledge )], 30);

					plateau_is_there_enemy_nearby(30);

				until not plateau_is_there_enemy_nearby_result
				
				if not NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__BOWL__push_forward_01) and not IsGoalActive(missionPlateau.goal_Map) and not IsGoalActive(missionPlateau.goal_Artifact) and not IsGoalActive(missionPlateau.goal_Soldiers) and not IsGoalActive(missionPlateau.goal_Exit) then
				
							PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__BOWL__push_forward_01");
							NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__BOWL__push_forward_01);	

							PushForwardVOReset(50);

							s_chatter_02 = true;
				end		
				
				repeat
					sleep_s(5);
					SleepUntil([| b_chatter_is_permitted and not b_critical_dialogue_on and b_push_forward_vo_counrdown_on > 45 and not b_collectible_used and not IsSpartanInCombat() and not b_kraken_in_ramp
								and not volume_test_players( VOLUMES.tv_narrative_plateau_temple_ledge )], 30);

					plateau_is_there_enemy_nearby(30);

				until not plateau_is_there_enemy_nearby_result
				
				if not NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__BOWL__push_forward_02_a)
					and not IsGoalActive(missionPlateau.goal_Map) and not IsGoalActive(missionPlateau.goal_Artifact) and not IsGoalActive(missionPlateau.goal_Soldiers) and not IsGoalActive(missionPlateau.goal_Exit) then
				
							PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__BOWL__push_forward_02_a");
							NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__BOWL__push_forward_02_a);	

							PushForwardVOReset(50);

							s_chatter_03 = true;
				end		

				repeat
					sleep_s(5);
					SleepUntil([| b_chatter_is_permitted and not b_critical_dialogue_on and b_push_forward_vo_counrdown_on > 45 and not b_collectible_used and not IsSpartanInCombat() and not b_kraken_in_ramp
								and not volume_test_players( VOLUMES.tv_narrative_plateau_temple_ledge )], 30);

					plateau_is_there_enemy_nearby(30);

				until not plateau_is_there_enemy_nearby_result
				
				if not NarrativeQueue.HasConversationFinished(W2HubPlateau_PLATEAU__RAMP__OREO_BOWL_Set_Up_linger_1)
					and (IsGoalActive(missionPlateau.goal_Tomb) or IsGoalActive(missionPlateau.goal_Temp_Bypass) or IsGoalActive(missionPlateau.goal_Hollow) or IsGoalActive(missionPlateau.goal_Ramp) or IsGoalActive(missionPlateau.goal_Bowl) or IsGoalActive(missionPlateau.goal_PreBowl)) then
				
							PrintNarrative("QUEUE - W2HubPlateau_PLATEAU__RAMP__OREO_BOWL_Set_Up_linger_1");
							NarrativeQueue.QueueConversation(W2HubPlateau_PLATEAU__RAMP__OREO_BOWL_Set_Up_linger_1);	

							PushForwardVOReset(50);

							s_chatter_04 = true;
				end	

				sleep_s(2);

	until s_chatter_02 and s_chatter_03 and s_chatter_04

	PrintNarrative("END - plateau_chatter");

end


--[========================================================================[
          PLATEAU. BOWL. push forward 01

          If all the enemies in the bowl have been killed, or if the
          closest enemy is too far, and yet Osiris lingers in the area
          (to collect ammo, weapons, etc.)
--]========================================================================]
global W2HubPlateau_PLATEAU__BOWL__push_forward_01 = {
	name = "W2HubPlateau_PLATEAU__BOWL__push_forward_01",
	

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					CreateMissionThread(plateau_is_there_enemy_nearby, 30);
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "This architecture, this history, it's irreplaceable. And the Covenant are willing to sacrifice it all to their ambitions.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_04300.sound'),

		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not plateau_is_there_enemy_nearby_result and not IsSpartanInCombat();
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Speaking of ambition, that Constructor isn't going to come to us. We ought to get moving.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_08300.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;
		hud_hide_radio_transmission_hud();
	end,
};




--[========================================================================[
          PLATEAU. BOWL. push forward 02
--]========================================================================]
global W2HubPlateau_PLATEAU__BOWL__push_forward_02_a = {
	name = "W2HubPlateau_PLATEAU__BOWL__push_forward_02_a",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		PrintNarrative("START - "..thisConvo.name);
		--	!!	CRITICAL DIALOGUE ON	!!
		b_critical_dialogue_on = true;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
					CreateMissionThread(plateau_is_there_enemy_nearby, 30);
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buck
			text = "Vale, what is this place? ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_03800.sound'),

			sleepAfter = 0.7,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER			
				return 0;
			end,
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not plateau_is_there_enemy_nearby_result and not IsSpartanInCombat();
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));					
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "It's the Vadam clan's burial grounds. Pre-Covenant. Hasn't been used for centuries.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_01400.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber) -- VOID
				CreateMissionThread(plateau_is_there_enemy_nearby, 30);
			end,

			sleepAfter = 1,

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER			
				return 0;
			end,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber) -- BOOLEAN
				return not plateau_is_there_enemy_nearby_result and not IsSpartanInCombat();
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "We should get moving. We're close to where Doctor Halsey said we'd find the Constructor.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_08000.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		--	!!	CRITICAL DIALOGUE OFF	!!
		b_critical_dialogue_on = false;
	end,
};




--[========================================================================[
          PLATEAU. RAMP. OREO BOWL Set Up linger
--]========================================================================]
global W2HubPlateau_PLATEAU__RAMP__OREO_BOWL_Set_Up_linger_1 = {
	name = "W2HubPlateau_PLATEAU__RAMP__OREO_BOWL_Set_Up_linger_1",

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
				return volume_test_players(VOLUMES.tv_narrative_plateau_ramp_oreo_bowl_set_up_linger) and not IsGoalActive(missionPlateau.goal_Bowl); -- GAMMA_TRANSITION: If player lingers before entering the bowl
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "We're walking the same path pre-Covenant Sangheili walked to bury their dead.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_00600.sound'),

		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_players(VOLUMES.tv_narrative_plateau_ramp_oreo_bowl_set_up_linger) and not IsGoalActive(missionPlateau.goal_Bowl); -- GAMMA_TRANSITION: If player lingers before entering the bowl
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Graveyard, eh? They retreated to the right place.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_00800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		PrintNarrative("END - "..thisConvo.name);
		hud_hide_radio_transmission_hud();
		
	end,
};



-- =================================================================================================          
-- =================================================================================================     


-- =================================================================================================
--  _____  _____       __          __  _______ ________   _________ 
-- |  __ \|  __ \     /\ \        / / |__   __|  ____\ \ / /__   __|
-- | |  | | |__) |   /  \ \  /\  / /     | |  | |__   \ V /   | |   
-- | |  | |  _  /   / /\ \ \/  \/ /      | |  |  __|   > <    | |   
-- | |__| | | \ \  / ____ \  /\  /       | |  | |____ / . \   | |   
-- |_____/|_|  \_\/_/    \_\/  \/        |_|  |______/_/ \_\  |_|   
--                                                                  
-- =================================================================================================                                                                  
--	Old Function from CVS still used
-- =================================================================================================                                                                  





function missing_content_text(text:string, ticks:number):void
	
	clear_all_text();

-- ==== handle text formatting
	if (text ~= nil) then
--		set_text_defaults();
		set_text_color(1, 1, 0.270588, 0); -- orangered http://www.avatar.se/molscript/doc/colour_names.html
		if(ticks ~= nil)then
			set_text_lifespan(ticks);
		else
			set_text_lifespan(120);
		end
		set_text_wrap(true, true);
		set_text_font(FONT_ID.terminal);
		set_text_justification(TEXT_JUSTIFICATION.center);
		set_text_alignment(TEXT_ALIGNMENT.center);
		set_text_scale(1);
		set_text_indents(50, 50);
--		set_text_margins(50, 75, 0, 0);
		set_text_shadow_style(TEXT_DROP_SHADOW.drop);


		show_text("[MISSING] ", text, " [MISSING]");
	end

	if (ticks ~= nil)then
		Sleep(ticks);
	end

end
--function faux_mission_objective_text (text:title):void

global t_obj_titles:table = 
	{
		["REPORT TO PALMER"]	= TITLES.ch_report_to_palmer,
		["BOARD THE PELICAN"]	= TITLES.ch_board_the_pelican,
		["Enter the Holy Site"] = TITLES.ch_enter_site,
		["CAPTURE THE CONSTRUCTOR AT TOJINOK"] = TITLES.ch_capture_constructor,
		["TRACK THE TEMPLE"] = TITLES.ch_track_temple,
		["CONTINUE TRACKING"] = TITLES.ch_continue_tracking,
		["DESTROY THE KRAKEN"] = TITLES.ch_destroy_kraken,
		["RETRIEVE THE CONSTRUCTOR"] = TITLES.ch_retrieve_constructor,
		["RETURN TO BASECAMP"] = TITLES.ch_return_camp,
		["Gather Your Team"] = TITLES.ch_gather_team,
		
	}
	
--displays a string or a cutscene title (strings are good for iteration, but are not shown in release_internal)
--cutscene titles are localized and displayed always
function faux_mission_objective_text (text:string):void
	--local x:number = 0;
	if (text == nil) then
		print ("no mission objective text");
		return;
	end

	local var:title = t_obj_titles[text];
	
	--if the string has a matching cutscene title then play the title, else display the string
	if var then
		cinematic_set_title(var);
--		CreateThread(audio_newobjective_beep);		--play new objective sfx
		--Sleep(300);
		sleep_s (5);
		cinematic_clear_title (var);
	else
		print ("faux temp text called, will not display on release_internal");
		set_text_defaults();
		set_text_color(1, 0.9764706, 0.9764706, 0.9764706);
		set_text_lifespan(210);
		set_text_font(FONT_ID.terminal);
		set_text_justification(TEXT_JUSTIFICATION.center);
		set_text_alignment(TEXT_ALIGNMENT.top);
		set_text_scale(1);
		set_text_margins(0, 0.25, 0, 0);
		set_text_shadow_style(TEXT_DROP_SHADOW.drop);
		show_text(text);
		
		CreateThread(audio_newobjective_beep);		--play new objective sfx
		sleep_s (5);
		clear_all_text();
	end
				
end


function warning_text (text:string, ticks:number, color:number):void
	local x:number = 0;

	repeat
		if (text ~= nil) then
--			set_text_defaults();
			if(color == 1)then
				set_text_color(1, 0, 1, 1);							-- cyan 
			else
				set_text_color(1, 1, 0, 0);							-- red http://www.avatar.se/molscript/doc/colour_names.html
			end
			set_text_lifespan(20);
			set_text_wrap(true, true);
			set_text_font(FONT_ID.terminal);
			set_text_justification(TEXT_JUSTIFICATION.center);
			set_text_alignment(TEXT_ALIGNMENT.top);
			set_text_scale(1);
			set_text_indents(10, 10);
--			set_text_margins(500, 500, 500, 500);				-- does this do anything? (no)
			set_text_shadow_style(TEXT_DROP_SHADOW.drop);
		
			show_text(text);
--			show_text(text);
		end

		Sleep(20);
--		clear_all_text();
--		Sleep(20);
	
	x = x + 40;

	until(x >= ticks)
	
end










-- =================================================================================================          
-- =================================================================================================     

--## CLIENT

--[[
function textscreen_client_skip(valid_volume:string)

	print( "SCREENTEXT STUB SKIP CLIENT: Listener for Skip Screen Text ");

	player_action_test_reset();

	if valid_volume == "no_volume" then
		SleepUntil([| player_action_test_context_primary() ], 10);
	else
		SleepUntil([| player_action_test_context_primary() or not volume_test_players(VOLUMES[valid_volume]) ], 10);
	end
	
		if player_action_test_context_primary() then

			print("SCREENTEXT STUB SKIP CLIENT: Player pressed a button - Skip Text Screen");
				
		elseif valid_volume ~= "no_volume" and not volume_test_players(VOLUMES[valid_volume]) then

			print("SCREENTEXT STUB SKIP CLIENT: Player out of valid VOLUME");
				
		end
	
	
		RunServerScript( "textscreen_server_skip" );

	
end



function textscreen_client_clean()

	
		player_disable_movement( false);
		
		clear_all_text();
		
	
end

]]




--## CLIENT


function remoteClient.plateau_intro_pip()
	
	print("play test bink_2")
	hud_play_pip_from_tag(TAG('bink\campaign\h5_pip_proxy_60.bink'));
end

