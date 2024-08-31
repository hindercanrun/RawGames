--## SERVER

-- =================================================================================================
-- =================================================================================================b
-- =================================================================================================
-- *** GLOBALS ***
-- =================================================================================================		
global b_hunters_downed = false;
global b_dead_marine_shut_down = false;
global clamp_1_engaged_fred = false;
global clamp_2_engaged_fred = false;
global clamp_1_engaged_kelly = false;
global clamp_2_engaged_kelly = false;
global clamp_1_engaged_linda = false;
global clamp_2_engaged_linda = false;
global clamp_1_engaged_chief = false;
global clamp_2_engaged_chief = false;
global b_meridian_temp_cin_complete = false;
global b_reactor_plan_complete = false;
global b_w4_banshee_intro_done = false;
global data_center_vo_1 = false;
global b_nar_ass_data_center = false;
global b_nar_ass_elevator = false;
global b_nar_ass_lab = false;
global b_nar_ass_reactor = false;
global b_nar_ass_ridedown_nudge = false;
global b_nar_ass_coolanttakeout_nudge = false;
global b_nar_ass_enterhangarnudge_nudge = false;
global b_nar_ass_hangar_nudge = false;
global b_nar_ass_level1 = false;
global b_nar_ass_level2 = false;
global b_nar_ass_level3 = false;
global hangar_progress = 1;
global prowler_launch_started = false;
global reactor_overload_start = false;
global b_nar_ass_shipyard = false;
global b_shipyard_combat_complete = false;
global b_nar_ass_elevatoroff = false;
global station_pa_line_playing = false;
global b_assault_chatter_1_played:boolean = false;
	global b_assault_chatter_2_played:boolean = false;
	global b_assault_chatter_3_played:boolean = false;
	global b_assault_chatter_4_played:boolean = false;
	global b_assault_chatter_5_played:boolean = false;
	global b_assault_chatter_6_played:boolean = false;
		global b_assault_idle_chatter_on:boolean = false;
global b_elevator_started:boolean = false;
global b_reactor_combat_complete:boolean = false;
global b_board_the_reactor:boolean = false;
global b_data_center_line_triggered:boolean = false;
global b_nar_ass_shutters_nudge:boolean = false;
global b_exited_hunter_room:boolean = false;
global b_second_level_complete:boolean = false; 
global b_nar_ass_data_nudge:boolean = false;
global b_room1_vo_played:boolean = false;

-- =================================================================================================
-- *** MAIN *** W4 ASSAULT ON STATION
-- =================================================================================================

-- Switch the PrintNarrative boolean to True so that we can see the PrintNarrative debug log infos
	g_display_narrative_debug_info = true;
	

--function nameofthesection_wake():void
--PrintNarrative("START - nameofthesection_wake");
--end

--  This section currently contains all trigger names. They will need to get split into their own sections.
function dormant.tv_nar_entry_point():void
	print("::: ASSAULT NARRATIVE START :::");
	CreateThread(nar_level_start_vo);
		--NarrativeQueue.QueueConversation(W1StationAssault_APPROACH_COMBAT);
		CreateThread(nar_lookat_dead_body);
	
	CreateThread(nar_grunt_vo_start);
	
	CreateThread(nar_ass_downloading_grunts);
	dialog_line_temp_blurb_force_set(true);
	b_temp_line_display_blurb = true;
	CreateThread(nar_ass_elite_hall);
	CreateThread(nar_idle_chatter_start_hall1);
	

end


function nar_goal_assault_tech():void
	print("nar_goal_assault_tech");
	NarrativeQueue.QueueConversation(W1StationAssault_ARGENT_MOON__DATA_CENTER);
	CreateThread(nar_ass_data_center);
	CreateThread(nar_ass_data_listener);
	CreateThread(nar_ass_elevator_vo);
	CreateThread(nar_turn_off_nudge);
	NarrativeQueue.QueueConversation(W1StationAssault_ARGENT_MOON__ELEVATOR);
	
	CreateThread(nar_ass_elevator_push_button);
	NarrativeQueue.QueueConversation(W1StationAssault_ARGENT_MOON__ELEVATOR_NEAR);
end

function nar_goal_assault_shipyard():void
	print("nar_goal_assault_shipyard");
	NarrativeQueue.QueueConversation(W1StationAssault_ship_yard__contact);
	CreateThread(nar_ass_cov_sighting);
	CreateThread(nar_ass_shoulder_bash);
	NarrativeQueue.QueueConversation(W1StationAssault_ELEVATOR__HYDRA_CALLOUT);
	
		CreateThread(nar_ass_shipyard_encounter1_complete);
	

end

function nar_goal_assault_shipyard2():void
	print("nar_goal_assault_shipyard2");
	CreateThread(nar_ass_bridge_enter);
	
	CreateThread(nar_ass_shipyard_encounter2_complete);
	
end

function nar_goal_assault_tunnels():void
	print("nar_goal_assault_tunnels");
	CreateThread(nar_ass_tunnel_level2);
	NarrativeQueue.QueueConversation(W1StationAssault_BRIDGE_AREA__BRIDGE_COLLAPSE);
	NarrativeQueue.QueueConversation(W1StationAssault_MAINTENANCE_TUNNELS_level2);
	--NarrativeQueue.QueueConversation(W1StationAssault_MAINTENANCE_TUNNELS__TUNNEL_LANDING);
	NarrativeQueue.QueueConversation(W1StationAssault_MAINTENANCE_TUNNELS__CINEMATIC_OUT);
	NarrativeQueue.QueueConversation(W1StationAssault_MAINTENANCE_TUNNELS_HOSTILE_CONTACT);
	--NarrativeQueue.QueueConversation(W1StationAssault_MAINTENANCE_TUNNELS_SLEEPING);
		NarrativeQueue.QueueConversation(W1StationAssault_Maintenance_tunnels__Armada_arrival);
		NarrativeQueue.QueueConversation(W1StationAssault_Maintenance_tunnels__Armada_arrival2);
		NarrativeQueue.QueueConversation(W1StationAssault_TUNNELS_TRANSITION__REACTOR_NOTICE);
	NarrativeQueue.QueueConversation(W1StationAssault_MAINTENANCE_TUNNELS__HUNTER_CALL_AND_RESPONSE);
	
	
	CreateThread(nar_level_three_reached);

end

function nar_goal_assault_hunter():void
	print("nar_goal_assault_hunter");
	NarrativeQueue.QueueConversation(W1StationAssault_RESEARCH_LAB__REACTOR_ENTRY_CALLOUT);
	NarrativeQueue.QueueConversation(W1StationAssault_RESEARCH_LAB_ELEVATOR__HUNTER_ATTACk);
end

function nar_goal_assault_reactor():void
	print("nar_goal_assault_reactor");
	NarrativeQueue.QueueConversation(W1StationAssault_REACTOR_ROOM__COV_CIVIL_WAR);
	NarrativeQueue.QueueConversation(W1StationAssault_REACTOR_ROOM_TRANSITION__COMBAT_PREP);
	CreateThread(nar_ass_reactor_room_cleared);
	CreateThread(nar_ass_reactor_listener);
	
	
	CreateThread(nar_ass_reactor_combat_start);

end

function nar_goal_assault_flight():void
	print("nar_goal_assault_flight");
	CreateThread(nar_ass_shutter2_listener);
	CreateThread(nar_ass_shutter1_listener);
	NarrativeQueue.QueueConversation(W1StationAssault_Reactor_docking__CLAMP_APPROACH);
	NarrativeQueue.QueueConversation(W1StationAssault_REACTOR_DOCKING__EXPLODE_ONE_TARGET);
	
	
	end

function nar_goal_assault_hangar():void
	print("nar_goal_assault_hangar");
	NarrativeQueue.QueueConversation(W1StationAssault_HANGAR__COMBAT_START);
	CreateThread(nar_ass_hangar_entrance_announce);
	CreateThread(nar_ass_airlock);
	CreateThread(w1_nar_elite_hangar);
end

-- =================================================================================================
-- =================================================================================================

-- =================================================================================================
--
--					START SECTION
--
-- Covers content on the start section.
--
-- =================================================================================================

function nar_level_start_vo()
SleepUntil([| volume_test_players(VOLUMES.nar_mission_start) ], 1);

	sleep_s(1.5);
				PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_03000.sound'), OBJECTS.vo_emitter_zs_01_left);
				PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_03000b.sound'), OBJECTS.vo_emitter_zs_01_right);
	sleep_s(6.5);
NarrativeQueue.QueueConversation(W1StationAssault__ASSAULT_ON_STATION_);
end



global W1StationAssault__ASSAULT_ON_STATION_ = {
	name = "W1StationAssault__ASSAULT_ON_STATION_",

	


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	
	end,

	lines = {
	--	[1] = {
	--		character = 0, -- GAMMA_CHARACTER: ARGENTMOONPA
	--		text = "Hull breach contained. Re-pressurization of affected areas completed.",
	--		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_03000.sound'),

--		},
		[1] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "What do we know about Argent Moon?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_00300.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,

		},
		[2] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			sleepBefore = 1,
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Linda
			text = "ONI Research station. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_00200.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
		},
		[3] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			sleepBefore = 0.5,		
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LINDA
			text = "Went dark two years ago. Last week, Covenant scavengers boasted about finding it on an unsecured line.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_00400.sound'),
			
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
		},
		[4] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "Our orders are to scrub the Covenant and return this station to Oni.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_09800.sound'),
						
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 5;
			end,
		},
		[5] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: KELLY
			text = "Fastest route to retrieval is to seize Central Control. Eliminate hostiles between here and there, then deactivate gravity and life support systems.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_00400.sound'),
				
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 6;
			end,
		},
		[6] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Linda
			text = "Ship data center is just ahead. We can pull down Argent Moon's schematics. Find a path to Central Control.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_02400.sound'),
		},
--           Approaching the combat door, we can hear scavengers at work.
-- 
--           SFX: SCAVENGER SOUND. BREAKING AND SHATTERING

		

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		NarrativeQueue.QueueConversation(W1StationAssault_ARGENT_MOON__SHIP_COMMENT);
		CreateThread(nar_ass_hallway_nudge);
		CreateThread( f_intro_halls_mark_tech_center );
	end,

	localVariables = {},
};


global W1StationAssault_ARGENT_MOON__SHIP_COMMENT = {
	name = "W1StationAssault_ARGENT_MOON__SHIP_COMMENT",
	CanStart = function (thisConvo, queue)
		return  volume_test_players(VOLUMES.nar_ass_ship_view); -- GAMMA_CONDITION
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
				return volume_test_object(VOLUMES.nar_ass_ship_view, SPARTANS.fred); 
			end,
			sleepBefore = 2,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: fredric
			text = "Impressive. Looks like they were experimenting with a new prowler class ship.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_04200.sound'),
						AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--                                                   CUT TO:
--           _____________________________________________________________
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_ship_view, SPARTANS.linda); 
			end,
			sleepBefore = 2,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Linda
			text = "Impressive. Looks like they were designing a new stealth class vessel.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_10600.sound'),
	
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_ship_view, SPARTANS.kelly); 
			end,
			sleepBefore = 2,

                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: KELLY
			text = "Impressive. Looks like they were designing a new stealth class vessel.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_10700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_ship_view, SPARTANS.chief); 
			end,
			sleepBefore = 2,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Impressive. Looks like they were designing a new stealth class vessel.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_11400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			sleepBefore = 1,
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly
			text = "They lost years of expenive R&D with this station.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_10800.sound'),

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

function nar_idle_chatter_start_hall1()
	SleepUntil( [| volume_test_players(VOLUMES.nar_ass_ship_view) ],1);
	sleep_s(6);
			CreateThread(assault_idle_chatter_start);
end

-- =================================================================================================
--
--					INTRO SECTION2
--
-- Covers content on the start section.
--
-- =================================================================================================

function nar_lookat_dead_body()

local s_speaker:object = nil;

	PrintNarrative("LISTENER - nar_lookat_dead_body");

			repeat 							
					SleepUntil([| volume_test_players( VOLUMES.nar_ass_frst_dead_body ) ], 10);		
						
				

							repeat
								sleep_s(0.25);
									
				
								if volume_test_players( VOLUMES.nar_ass_frst_dead_body ) then
													
											s_speaker = spartan_look_at_object(players(), OBJECTS.body_01, 5, 20, 2, 0);
										if s_speaker == nil then
													
											s_speaker = spartan_look_at_object(players(), OBJECTS.body_02, 5, 20, 2, 0);
										end
										if s_speaker == nil then
													
											s_speaker = spartan_look_at_object(players(), OBJECTS.body_03, 5, 20, 2, 0);
										end
										if s_speaker == nil then
													
											s_speaker = spartan_look_at_object(players(), OBJECTS.body_04, 5, 20, 2, 0);
										end
										
								end
							until s_speaker ~= nil or not (volume_test_players(VOLUMES.nar_ass_frst_dead_body) )
							

			until s_speaker ~= nil
		
	if s_speaker ~= nil then
		
				
		W1StationAssault_ARGENT_MOON__FIRST_DEAD_BODY.localVariables.s_speaker = s_speaker;
		PrintNarrative("QUEUE - W1StationAssault_ARGENT_MOON__FIRST_DEAD_BODY");
		NarrativeQueue.QueueConversation(W1StationAssault_ARGENT_MOON__FIRST_DEAD_BODY);
	end

end

global W1StationAssault_ARGENT_MOON__FIRST_DEAD_BODY = {
	name = "W1StationAssault_ARGENT_MOON__FIRST_DEAD_BODY",

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

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Linda
			text = "What do we know about the experiments they were doing here?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_01100.sound'),
									
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[2] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: maSTERCHIEF
			text = "We don't. And we don't ask.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_07700.sound'),
									
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[3] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "But I'd keep your helmet on tight just the same.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_01400.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};



global W1StationAssault_APPROACH_COMBAT = {
	name = "W1StationAssault_APPROACH_COMBAT",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_ass_first_combat) ; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		b_dead_marine_shut_down = true;
	end,

	lines = {
		[1] = {
					If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_first_combat, SPARTANS.chief); -- GAMMA_TRANSITION: If chief
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MASTERCHIEF
			text = "I hear movement ahead. Ready up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_00500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_first_combat, SPARTANS.fred); -- GAMMA_TRANSITION: If chief
			end,

                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "I hear movement ahead. Ready up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_11900.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_first_combat, SPARTANS.kelly); -- GAMMA_TRANSITION: If chief
			end,
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: KELLY
			text = "I hear movement ahead. Ready up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_09500.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_first_combat, SPARTANS.linda); -- GAMMA_TRANSITION: If chief
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LINDA
			text = "I hear movement ahead. Ready up.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_09000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		
		
	end,

	localVariables = {},
};

function nar_grunt_vo_start()
SleepUntil( [| volume_test_players( VOLUMES.nar_ass_first_combat ) ] , 1 );
NarrativeQueue.QueueConversation(W1StationAssault_Argent_moon__First_encounter);
CreateThread(assault_idle_chatter_off);
b_nar_ass_data_nudge = true;

NarrativeQueue.EndConversationEarly(W1HubassaultReports_team_chatter_1);
NarrativeQueue.EndConversationEarly(W1HubassaultReports_team_chatter_2);
end

global W1StationAssault_Argent_moon__First_encounter = {
	name = "W1StationAssault_Argent_moon__First_encounter",

	CanStart = function (thisConvo, queue)
		return objects_distance_to_object(players_human(),ai_get_object(AI.sq_intro_grunt_scavenge.aisquadspawnpoint02)) < 10; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return ai_combat_status(AI.sg_intro_all ) <= 4;
			end,
			character = AI.sq_intro_grunt_scavenge.aisquadspawnpoint02, -- GAMMA_CHARACTER: GRUNT01
			text = "Why do we have to do downloading? So boring! It takes FOREVER!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_cv_grunt01_00100.sound'),
						
		},
		[2] = {
							If = function(thisLine, thisConvo, queue, lineNumber)
				return ai_combat_status(AI.sg_intro_all ) <= 4;
			end,
			character = AI.sq_intro_grunt_scavenge.aisquadspawnpoint, -- GAMMA_CHARACTER: Grunt02
			text = "Wish we were breaking glass. I like breaking glass.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_cv_grunt02_00100.sound'),
		},
	[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.grunt_room, SPARTANS.fred); -- GAMMA_TRANSITION: If FREDRIC
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Hostile contact.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_02000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.grunt_room, SPARTANS.linda); -- GAMMA_TRANSITION: If LINDA
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LINDA
			text = "Hostile contact.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_01600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.grunt_room, SPARTANS.kelly); -- GAMMA_TRANSITION: If kelly
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "Hostile contact.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_01700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[6] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.grunt_room, SPARTANS.chief); -- GAMMA_TRANSITION: If masterchief
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Hostile contact.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_01900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();

	end,

	localVariables = {},
};

function nar_ass_downloading_grunts()
	SleepUntil( [| volume_test_players(VOLUMES.nar_ass_downloading_grunts) ],1);
	SleepUntil ( [| ai_combat_status(AI.sg_intro_all ) > 4],1);
	NarrativeQueue.QueueConversation(W1StationAssault_Argent_moon_encounter1started);
	NarrativeQueue.QueueConversation(W1StationAssault_Argent_moon__FIRST_ENCOUNTER_HALL); 
	
end


global W1StationAssault_Argent_moon_encounter1started = {
	name = "W1StationAssault_Argent_moon_encounter1started",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
			character = AI.sq_intro_grunt_scavenge.aisquadspawnpoint, -- GAMMA_CHARACTER: Grunt01
			text = "Humans? How did humans find us?!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_cv_grunt01_00200.sound'),
			
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
				[2] = {
			character = AI.sq_intro_grunt_scavenge.aisquadspawnpoint02, -- GAMMA_CHARACTER: Grunt01
			text = "Humans? How did humans find us?!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_cv_grunt01_00200.sound'),
		},
--           From the hallway:
},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

function nar_ass_elite_hall()
	SleepUntil( [| volume_test_players(VOLUMES.nar_ass_elite_hall) ],1);
		
		NarrativeQueue.QueueConversation(W1StationAssault_Argent_moon_hall_complete);
	
	SleepUntil([| objects_distance_to_object(players_human(),ai_get_object(AI.sq_intro_elite_02.aisquadspawnpoint)) < 6 ], 1);
	SleepUntil([| objects_can_see_object( players_human(), ai_get_object(AI.sq_intro_elite_02.aisquadspawnpoint), 6 )], 1);
	SleepUntil ( [| ai_combat_status(AI.sq_intro_elite_02.aisquadspawnpoint ) > 4],1);
		
		NarrativeQueue.QueueConversation(W1StationAssault_Argent_moon_elitefirstline);
	

end
global W1StationAssault_Argent_moon_elitefirstline = {
	name = "W1StationAssault_Argent_moon_elitefirstline",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		
		[1] = {
			character = AI.sq_intro_elite_02.aisquadspawnpoint, -- GAMMA_CHARACTER: ElITE01
			text = "The Demon walks among us!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_cv_elite01_00400.sound'),
		},
--             
--           From the hallway:
},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global W1StationAssault_Argent_moon__FIRST_ENCOUNTER_HALL = {
	name = "W1StationAssault_Argent_moon__FIRST_ENCOUNTER_HALL",

	CanStart = function (thisConvo, queue)
		return objects_distance_to_object(players_human(),ai_get_object(AI.sq_intro_jackal_01.aisquadspawnpoint)) < 7; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.sq_intro_jackal_01.aisquadspawnpoint, -- GAMMA_CHARACTER: JaCKAL01
			text = "Demon! Big money!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_cv_jackal01_00300.sound'),
									playDurationAdjustment = 0.75,
		},
		[2] = {
			character = AI.sq_intro_jackal_01.aisquadspawnpoint01, -- GAMMA_CHARACTER: JaCKAL01
			text = "Kill it! Collect it's head!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_cv_jackal01_00400.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

function nar_ass_data_center_push()
	SleepUntil ([|	ai_living_count (AI.sg_intro_all) <= 0 ], 1);
	
	data_center_vo_1 = true;	
	
end

global W1StationAssault_Argent_moon_hall_complete= {
	name = "W1StationAssault_Argent_moon_hall_complete",

	CanStart = function (thisConvo, queue)
		return ai_living_count (AI.sg_intro_command) <= 0 and b_nar_ass_data_center == false; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 3,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: JaCKAL01
			text = "Linda : Data center is just ahead. Let's move.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_08000.sound'),
		},
	
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		data_center_vo_1 = true;
			hud_hide_radio_transmission_hud();
		
	end,

	localVariables = {},
};



function nar_ass_hallway_nudge()
	sleep_s(40);
	--story_blurb_add("vo", "5 second warning");
	sleep_s(7);
	if b_nar_ass_data_nudge == false then
SleepUntil( [| b_collectible_used == false ], 1);		
		NarrativeQueue.QueueConversation(W1StationAssault_ARGENT_MOON__PUSH_FORWARD);
	end
end
global W1StationAssault_ARGENT_MOON__PUSH_FORWARD = {
	name = "W1StationAssault_ARGENT_MOON__PUSH_FORWARD",

	

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

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Move toward the data center, Blue Team.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_09900.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


-- =================================================================================================
--
--					DATA CENTER SECTION
--
-- Covers content on the data center section.
--
-- =================================================================================================


global W1StationAssault_ARGENT_MOON__DATA_CENTER = {
	name = "W1StationAssault_ARGENT_MOON__DATA_CENTER",

	CanStart = function (thisConvo, queue)
		return volume_test_object(VOLUMES.nar_ass_data_center, SPARTANS.chief) or volume_test_object(VOLUMES.nar_ass_data_center, SPARTANS.fred) or volume_test_object(VOLUMES.nar_ass_data_center, SPARTANS.linda) or volume_test_object(VOLUMES.nar_ass_data_center, SPARTANS.kelly); -- GAMMA_CONDITION
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
				return volume_test_object(VOLUMES.nar_ass_data_center, SPARTANS.chief); -- GAMMA_TRANSITION: If chief
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Data center.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_00600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_data_center, SPARTANS.fred); -- GAMMA_TRANSITION: If FREDRIC
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Data center.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_00400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_data_center, SPARTANS.kelly); -- GAMMA_TRANSITION: If kelly
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "Data center.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_00500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_data_center, SPARTANS.linda); -- GAMMA_TRANSITION: If linda
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Linda
			text = "Data center.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_00500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LINDA
			text = "We've got a complete set of datasec keys for the station.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_03500.sound'),
			
		
		},
--           And then (IF PREVIOUS LINE DID NOT PLAY BECAUSE WE RUN AHEAD)

		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return b_data_center_line_triggered == false;
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Linda
			text = "We should be able to pull down Argent Moon's schematics and find a path to Central Control.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_00600.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


function nar_ass_data_center()
	SleepUntil( [| volume_test_players(VOLUMES.nar_ass_data_center) ],1);
	b_nar_ass_data_center = true;
	CreateThread(assault_idle_chatter_off);
	NarrativeQueue.EndConversationEarly(W1HubassaultReports_team_chatter_1);
	NarrativeQueue.EndConversationEarly(W1HubassaultReports_team_chatter_2);
end


function nar_ass_data_listener()
	
       SleepUntil([| object_valid( "dc_tech_halogram" ) ], 60);
	   PrintNarrative("LISTENER - nar_ass_data_listener THREADED");
       SleepUntil([| device_get_power( OBJECTS.dc_tech_halogram) == 1 ], 60);

       PrintNarrative("LISTENER - nar_ass_data_listener");

       CreateThread(RegisterInteractEvent, nar_ass_data_launcher, OBJECTS.dc_tech_halogram);


end

function nar_ass_data_launcher(trigger:object, activator:object)

       PrintNarrative("LAUNCHER - assault_data_control_launcher");

       print(activator, " is the activator of ", trigger);

       CreateThread(UnregisterInteractEvent, nar_ass_data_launcher, OBJECTS.dc_tech_halogram);

       CreateThread(nar_ass_data_access, activator)
end


function nar_ass_data_access(activator:object)
b_data_center_line_triggered = true;
	sleep_s(3);
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_01300.sound'), OBJECTS.data_center_pa);
	
	sleep_s(3);
			RunClientScript("pip_assault_argentmoon_controlroom_60");
		if activator == SPARTANS.chief then
			NarrativeQueue.QueueConversation(W1StationAssault_ARGENT_MOON__DATA_USE_chief);
		elseif activator == SPARTANS.fred then 
			NarrativeQueue.QueueConversation(W1StationAssault_ARGENT_MOON__DATA_USE_fred);
		elseif activator == SPARTANS.kelly then
			NarrativeQueue.QueueConversation(W1StationAssault_ARGENT_MOON__DATA_USE_kelly);
		elseif activator == SPARTANS.linda then
			NarrativeQueue.QueueConversation(W1StationAssault_ARGENT_MOON__DATA_USE_linda);
		end	
	sleep_s(25);
	CreateThread(nar_ass_elevator_chatter_off);
	CreateThread(assault_idle_chatter_start);
	CreateThread(nar_ass_datacenter_nudge);
end
global W1StationAssault_ARGENT_MOON__DATA_USE_fred = {
	name = "W1StationAssault_ARGENT_MOON__DATA_USE_fred",


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

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Accessed the databanks.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_00500.sound'),

			
		}, 

		[2] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MaSTERCHIEF
			text = "Grab the layout, manifest, and current population map.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_02200.sound'),
	

		},

		[3] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Should be a straight shot to central control through the assembly bay ahead. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_01000.sound'),

		},
		[4] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
		sleepBefore = 1,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: Fredric
			text = "There are still prowlers in the hangar bays.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_03700.sound'),

		},
		[5] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			sleepBefore = 1,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: Fredric
			text = "Nobody from Oni got out of here alive, did they?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_09100.sound'),

		},
		[6] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LiNDA
			text = "No.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_09100.sound'),

		},
		[7] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Let's get to work.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_00800.sound'),
		},
--           OBJECTIVE: REACH TECH CENTER
-- 
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		CreateThread( f_tech_objective_2 );
		
	end,

	localVariables = {},
};

global W1StationAssault_ARGENT_MOON__DATA_USE_kelly = {
	name = "W1StationAssault_ARGENT_MOON__DATA_USE_kelly",


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

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "Accessed the databanks.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_00600.sound'),

		
		},

		[2] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MaSTERCHIEF
			text = "Grab the layout, manifest, and current population map.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_02200.sound'),
		},

		[3] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Should be a straight shot to central control through the assembly bay ahead. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_01000.sound'),
		},
		[4] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
						sleepBefore = 1,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: Fredric
			text = "There are still prowlers in the hangar bays.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_03700.sound'),

		},
		[5] = {
		sleepBefore = 1,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: Fredric
			text = "Nobody from Oni got out of here alive, did they?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_09100.sound'),
	
		},
		[6] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
					sleepBefore = 1,
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LiNDA
			text = "No.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_09100.sound'),

		},
		[7] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "Let's get to work.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_00800.sound'),
		},
--           OBJECTIVE: REACH TECH CENTER
-- 
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		CreateThread( f_tech_objective_2 );
		
	end,

	localVariables = {},
};

global W1StationAssault_ARGENT_MOON__DATA_USE_linda = {
	name = "W1StationAssault_ARGENT_MOON__DATA_USE_linda",


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

                     moniker = "Linda",
			
					sleepBefore = 1,
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Linda
			text = "Accessed the databanks.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_00700.sound'),

			
		},

		[2] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
						sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MaSTERCHIEF
			text = "Grab the layout, manifest, and current population map.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_02200.sound'),
		},
		[3] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
					sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Should be a straight shot to central control through the assembly bay ahead. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_01000.sound'),
		},
		[4] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
					sleepBefore = 1,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: Fredric
			text = "There are still prowlers in the hangar bays.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_03700.sound'),

		},
		[5] = {
		sleepBefore = 1,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: Fredric
			text = "Nobody from Oni got out of here alive, did they?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_09100.sound'),

		},
		[6] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
						sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LiNDA
			text = "No.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_09100.sound'),

		},
		[7] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
				sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Let's get to work.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_00800.sound'),
		},
--           OBJECTIVE: REACH TECH CENTER
-- 
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		CreateThread( f_tech_objective_2 );
		
	end,

	localVariables = {},
};

global W1StationAssault_ARGENT_MOON__DATA_USE_chief = {
	name = "W1StationAssault_ARGENT_MOON__DATA_USE_chief",


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

                     moniker = "MasterChief",
					sleepBefore = 1,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Accessed the databanks.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_00700.sound'),

		},
		[2] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
				sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MaSTERCHIEF
			text = "Grab the layout, manifest, and current population map.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_02200.sound'),
		},

		[3] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
					sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Should be a straight shot to central control through the assembly bay ahead. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_01000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
					CreateThread( f_tech_objective_2 );
			return 4; -- GAMMA_NEXT_LINE_NUMBER
		  end
	
		},
		
	
		
		
		[4] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
					sleepBefore = 1,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: Fredric
			text = "There are still prowlers in the hangar bays.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_03700.sound'),
			
		},
		[5] = {
			sleepBefore = 1,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: Fredric
			text = "Nobody from Oni got out of here alive, did they?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_09100.sound'),
		},
		[6] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
				sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LiNDA
			text = "No.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_09100.sound'),

		},
		[7] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
				sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Let's get to work.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_00800.sound'),
		},
--           OBJECTIVE: REACH TECH CENTER
-- 
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
					
			CreateThread( f_tech_objective_2 );
	end,

	localVariables = {},
};


function nar_ass_door_destruction()

print("deprecated");
end

function nar_ass_elevator_chatter_off()
	SleepUntil( [| volume_test_players(  VOLUMES.nar_ass_elevator_near ) ], 1);
				CreateThread(assault_idle_chatter_off);
			

end


global W1StationAssault_ARGENT_MOON__ELEVATOR_NEAR = {
	name = "W1StationAssault_ARGENT_MOON__ELEVATOR_NEAR",

	CanStart = function (thisConvo, queue)
		return volume_test_object(VOLUMES.nar_ass_elevator_near, SPARTANS.chief) or volume_test_object(VOLUMES.nar_ass_elevator_near, SPARTANS.fred) or volume_test_object(VOLUMES.nar_ass_elevator_near, SPARTANS.kelly) or volume_test_object(VOLUMES.nar_ass_elevator_near, SPARTANS.linda); -- GAMMA_CONDITION
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
				return volume_test_object(VOLUMES.nar_ass_elevator_near, SPARTANS.chief);
			end,
			                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "Elevator here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_10700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_elevator_near, SPARTANS.fred);
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Elevator here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_12800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_elevator_near, SPARTANS.kelly);
			end,
			                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly
			text = "Elevator here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_10100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_elevator_near, SPARTANS.linda);
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Linda
			text = "Elevator here.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_10100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


function nar_ass_elevator_push_button()
	SleepUntil( [| volume_test_players(  VOLUMES.nar_elevator_cine_start ) ], 1);
						CreateThread(assault_idle_chatter_off);	
				NarrativeQueue.EndConversationEarly(W1HubassaultReports_team_chatter_1);
		NarrativeQueue.EndConversationEarly(W1HubassaultReports_team_chatter_2);
	sleep_s(20);
	if b_elevator_started == false then
		NarrativeQueue.QueueConversation(W1StationAssault_Argent_moon__Elevator_linger);
	end

end

global W1StationAssault_Argent_moon__Elevator_linger = {
	name = "W1StationAssault_Argent_moon__Elevator_linger",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return b_elevator_started == false; -- GAMMA_TRANSITION: If locke
			end,

		
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: Fredric
			text = "Need to get this elevator moving. Find the controls.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_12900.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

function nar_turn_off_nudge()
	SleepUntil([| device_get_position( OBJECTS.dc_tech_elevator ) > 0.1], 10);
b_elevator_started = true;
end

global W1StationAssault_ARGENT_MOON__ELEVATOR = {
	name = "W1StationAssault_ARGENT_MOON__ELEVATOR",

	CanStart = function (thisConvo, queue)
		return device_get_position( OBJECTS.dc_tech_elevator ) > 0.1; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 6,

	OnStart = function (thisConvo, queue)
		b_elevator_started = true;
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Central Control's straight across this bay.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_07500.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
		},
		
		[2] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			sleepBefore = 1,
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Linda
			text = "Everything's ripped up. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_02300.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
		},
		[3] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "They must be stripping that experimental ship for parts.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_04400.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
		},
		[4] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Scavengers. Taking what supplies they can find. The Covenant's war against the Arbiter must not be going well. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_06400.sound'),
					
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[5] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LiNDA
			text = "Jul 'Mdama is a lot of things, but he's no Prophet.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_09300.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		CreateThread(nar_ass_elevator_nudge);
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

function nar_ass_elevator_vo()
	SleepUntil( [| volume_test_players(  VOLUMES.tv_main_elevator ) ], 1);

	b_nar_ass_elevator = true;
	

end

function nar_ass_datacenter_nudge()
	sleep_s(75);
	if b_nar_ass_elevator == false then
		SleepUntil( [| b_collectible_used == false ], 1);
		NarrativeQueue.QueueConversation(W1StationAssault_ARGENT_MOON__DATA_CENTER_NUDGE);

	end


end

global W1StationAssault_ARGENT_MOON__DATA_CENTER_NUDGE = {
	name = "W1StationAssault_ARGENT_MOON__DATA_CENTER_NUDGE",



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

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Linda
			text = "Central Control is across that bay.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_09200.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


-- =================================================================================================
--
--					SHIPYARD SECTION
--
-- Covers content on the shipyard section.
--
-- =================================================================================================


function nar_ass_shoulder_bash()
	SleepUntil( [| volume_test_players(  VOLUMES.nar_ass_shoulder_bash ) ], 1);
	CreateThread(assault_idle_chatter_off);
	NarrativeQueue.EndConversationEarly(W1HubassaultReports_team_chatter_1);
	NarrativeQueue.EndConversationEarly(W1HubassaultReports_team_chatter_2);
	
	NarrativeQueue.QueueConversation(W1StationAssault_ship_yard__SHOULDER_BASH);
	
end

function nar_grunt_chatter()
PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_cv_grunt02_00100.sound'), ai_get_object(AI.sq_yard_cov_grunt_01.norbert));
sleep_s(2);
PlayDialogOnClients(TAG('sound\001_vo\001_vo_ai\001_vo_ai_grunt01\001_vo_ai_cv_grunt01_07idle_idle.sound'), ai_get_object(AI.sq_yard_cov_grunt_01.norbert));
sleep_s(4);
PlayDialogOnClients(TAG('sound\001_vo\001_vo_ai\001_vo_ai_grunt02\001_vo_ai_cv_grunt02_07idle_idlegr.sound'), ai_get_object(AI.sq_yard_cov_grunt_01.norbert));
end

function nar_grunt_chatter2()
PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_cv_grunt02_00100.sound'), OBJECTS.grunt01);


end
function nar_grint_chatter_03()
PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_cv_grunt02_00100.sound'), ai_get_object(AI.sq_yard_cov_grunt_01.norbert));


end

function nar_grint_chatter_04()
PlayDialogOnClients(TAG('sound\001_vo\001_vo_ai\001_vo_ai_grunt01\001_vo_ai_cv_grunt01_07idle_idle.sound'), ai_get_object(AI.sq_yard_cov_grunt_01.norbert));


end


global W1StationAssault_ship_yard__SHOULDER_BASH = {
	name = "W1StationAssault_ship_yard__SHOULDER_BASH",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Most direct route to the shipyard is through that wall ahead.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_13300.sound'),
		},
		[2] = {
			                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "It looks flimsy. Charge through.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_11300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

function nar_ass_elevator_nudge()
	sleep_s(30);
	if b_nar_ass_elevatoroff == false then
		SleepUntil( [| b_collectible_used == false ], 1);
		NarrativeQueue.QueueConversation(W1StationAssault_ELEVATOR__PUSH_FORWARD);
	end
end

global W1StationAssault_ELEVATOR__PUSH_FORWARD = {
	name = "W1StationAssault_ELEVATOR__PUSH_FORWARD",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnPlay = function (thisConvo, queue)
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

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Let's get moving, Blue Team.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_10000.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global W1StationAssault_construction_bay__Covenant_chatter2 = {
	name = "W1StationAssault_construction_bay__Covenant_chatter2",

CanStart = function (thisConvo, queue) -- BOOLEAN
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if (ai_living_count (AI.sq_yard_cov_front_04) >= 1 ) then
			thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return  objects_distance_to_object(players_human(),ai_get_object(AI.sq_yard_cov_front_04.aisquadspawnpoint)) < 5 ;
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
			character = AI.sq_yard_cov_front_04.aisquadspawnpoint, -- GAMMA_CHARACTER: ELITE03
			text = "Fight! For the glory of 'Mdama!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_cv_elite03_00200.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};


global W1StationAssault_ship_yard__contact = {
	name = "W1StationAssault_ship_yard__contact",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_ass_cov_sighting); -- GAMMA_CONDITION
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
				return  volume_test_object(VOLUMES.nar_ass_cov_sighting, SPARTANS.chief); -- GAMMA_TRANSITION: If chief
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Contact. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_01500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return  volume_test_object(VOLUMES.nar_ass_cov_sighting, SPARTANS.fred); -- GAMMA_TRANSITION: If FREDRIC
			end,

                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Contact. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_01200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_cov_sighting, SPARTANS.kelly); -- GAMMA_TRANSITION: If kelly
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "Contact. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_01100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return  volume_test_object(VOLUMES.nar_ass_cov_sighting, SPARTANS.linda); -- GAMMA_TRANSITION: If linda
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Linda
			text = "Contact. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_01000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
	NarrativeQueue.QueueConversation(W1StationAssault_construction_bay__Covenant_chatter2);
		CreateThread(nar_ass_shipyard_combat_shout);
	end,

	localVariables = {},
};


function nar_ass_cov_sighting()

SleepUntil( [| volume_test_players(  VOLUMES.nar_ass_cov_sighting ) ], 1);
b_nar_ass_elevatoroff = true;

		b_nar_ass_elevator = true;

end


function nar_ass_shipyard_encounter1_complete()
SleepUntil ([|	ai_living_count (AI.sg_yard_front_cov) >= 1 ], 1);
	CreateThread(nar_shipyard_all_down_listener);
		
end


function nar_shipyard_all_down_listener()

	SleepUntil([| ai_living_count(AI.sg_yard_front_cov) <= 1 ], 1);

	local s_last_living_ai:object = ai_get_unit( AI.sg_yard_front_cov );

	PrintNarrative("LISTENER - nar_shipyard_all_down_listener");
	print(" LAst AI alive is:  ", s_last_living_ai);

	if ai_living_count(AI.sg_yard_front_cov) <= 0 then
		PrintNarrative("LISTENER - nar_shipyard_all_down_listener - ALL DEAD");

		CreateMissionThread(nar_shipyard_all_down, SPARTANS.chief);
	else
		RegisterDeathEvent (nar_shipyard_all_down, s_last_living_ai);
	end
end

function nar_shipyard_all_down(target:object, killer:object)

	PrintNarrative("LAUNCHER - nar_caves_all_down");

	print(killer, " is the killer of ", target);
	--story_blurb_add("domain", "KILL ALL TRIGGER");

	W1StationAssault_Ship_bay_section_1__All_enemies_dead.localVariables.killer = killer;

	PrintNarrative("QUEUE - W1StationAssault_Ship_bay_section_1__All_enemies_dead");
	NarrativeQueue.QueueConversation(W1StationAssault_Ship_bay_section_1__All_enemies_dead);

end


global W1StationAssault_Ship_bay_section_1__All_enemies_dead = {
	name = "W1StationAssault_Ship_bay_section_1__All_enemies_dead",

	CanStart = function (thisConvo, queue)
		return 	(b_nar_ass_shipyard == false); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 3,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.kelly; -- GAMMA_TRANSITION: If locke killed the last hunter
			end,
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: kelly
			text = "Area's clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_03000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.fred; -- GAMMA_TRANSITION: If locke killed the last hunter
			end,

                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: fredric
			text = "Area's clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_07600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.linda; -- GAMMA_TRANSITION: If locke killed the last hunter
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LINDA
			text = "Area's clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_02600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.chief; -- GAMMA_TRANSITION: If locke killed the last hunter
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Area's clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_03000.sound'),

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


global W1StationAssault_ELEVATOR__HYDRA_CALLOUT = {
	name = "W1StationAssault_ELEVATOR__HYDRA_CALLOUT",

	CanStart = function (thisConvo, queue)
		return volume_test_object(VOLUMES.nar_ass_hydra, SPARTANS.chief) or volume_test_object(VOLUMES.nar_ass_hydra, SPARTANS.fred) or volume_test_object(VOLUMES.nar_ass_hydra, SPARTANS.linda) or volume_test_object(VOLUMES.nar_ass_hydra, SPARTANS.kelly); -- GAMMA_CONDITION
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
				return volume_test_object(VOLUMES.nar_ass_hydra, SPARTANS.fred); -- GAMMA_TRANSITION: If FREDRIC
			end,

                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "There's a Hydra here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_11300.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_hydra, SPARTANS.chief); -- GAMMA_TRANSITION: If chief
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "There's a Hydra here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_10100.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_hydra, SPARTANS.kelly); -- GAMMA_TRANSITION: If kelly
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "There's a Hydra here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_09000.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_hydra, SPARTANS.linda); -- GAMMA_TRANSITION: If linda
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Linda
			text = "There's a Hydra here.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_08500.sound'),

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


function nar_ass_shipyard_combat_shout()
	sleep_s(300);
	if b_shipyard_combat_complete == false then 

		NarrativeQueue.QueueConversation(W1StationAssault_SHIP_BAY__GENERAL_COMBAT_NUDGE);
	end
end

global W1StationAssault_SHIP_BAY__GENERAL_COMBAT_NUDGE = {
	name = "W1StationAssault_SHIP_BAY__GENERAL_COMBAT_NUDGE",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
				If = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.kelly) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,


	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: kelly
			text = "push through this resistance and reach central control!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_08800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.fred) > 0) ; -- GAMMA_TRANSITION: If FREDRIC
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: fredric
			text = "push through this resistance and reach central control!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_11100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.linda) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LINDA
			text = "push through this resistance and reach central control!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_08300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.chief) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
	
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "push through this resistance and reach central control!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_09600.sound'),

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



function nar_ass_shipyard_encounter2_complete()
	SleepUntil ([|	ai_living_count (AI.sg_yard_rear) >= 1 ], 1);
	SleepUntil ([|	ai_living_count (AI.sg_yard_rear) <= 0 ], 1);
	sleep_s(3);
		
		b_shipyard_combat_complete = true;
		if b_nar_ass_shipyard == false then
			NarrativeQueue.QueueConversation(W1StationAssault_Ship_bay_section_2__All_enemies_dead);
		end
	
end

global W1StationAssault_Ship_bay_section_2__All_enemies_dead = {
	name = "W1StationAssault_Ship_bay_section_2__All_enemies_dead",



	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.fred) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FredRIC
			text = "Nobody's left standing. Let's move on to central control.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_07700.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,

		},

		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.kelly) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,

			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: KELLY
			text = "Nobody's left standing. Let's move on to central control.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_09800.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,

		},
		[3] = {
					ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.linda) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,

			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LINDA
			text = "Nobody's left standing. Let's move on to central control.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_09600.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,

		},
		[4] = {
					ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.chief) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Nobody's left standing. Let's move on to central control.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_10600.sound'),


		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
				CreateThread(assault_idle_chatter_start);
				CreateThread(nar_ass_shipyard_nudge);
				CreateThread(nar_ass_shipyard_chatter_off);
	end,

	localVariables = {},
};


function nar_ass_shipyard_nudge()
	sleep_s(120);
	if b_nar_ass_shipyard == false then
SleepUntil( [| b_collectible_used == false ], 1);
		NarrativeQueue.QueueConversation(W1StationAssault_SHIP_BAY__NUDGE_FORWARD_IF_LINGER);

	end


end

global W1StationAssault_SHIP_BAY__NUDGE_FORWARD_IF_LINGER = {
	name = "W1StationAssault_SHIP_BAY__NUDGE_FORWARD_IF_LINGER",


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

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Linda
			text = "Central Control is just beyond this bay. Let's move.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_09400.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};



-- =================================================================================================
--
--					SHIPYARD 2 SECTION
--
-- Covers content on the shipyard section.
--
-- =================================================================================================

global W1StationAssault_BRIDGE_AREA__BRIDGE_COLLAPSE = {
	name = "W1StationAssault_BRIDGE_AREA__BRIDGE_COLLAPSE",

	CanStart = function (thisConvo, queue)
		return volume_test_players(  VOLUMES.nar_ass_bridge_enter ); -- GAMMA_CONDITION
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
				return volume_test_object(VOLUMES.nar_ass_bridge_enter, SPARTANS.fred); -- GAMMA_TRANSITION: If FREDRIC
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Central Control is just beyond those doors.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_07800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_bridge_enter, SPARTANS.kelly); -- GAMMA_TRANSITION: IF KELLY
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "Signage here for Central Control. Through those doors.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_03100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_bridge_enter, SPARTANS.chief); -- GAMMA_TRANSITION: IF MASTERCHIEF
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MASTERChIEF
			text = "Signage here for Central Control. Through those doors.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_03100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_bridge_enter, SPARTANS.linda); -- GAMMA_TRANSITION: IF linda
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LINDA
			text = "Signage here for Central Control. Through those doors.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_08100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		CreateThread(nar_bridge_ai_off);
	end,

	localVariables = {},
};

function nar_bridge_ai_off()
AIDialogManager.DisableAIDialog();
end

function nar_ass_shipyard_chatter_off()
	SleepUntil( [| volume_test_players(  VOLUMES.nar_ass_shipyard_end ) ], 1);
				CreateThread(assault_idle_chatter_off);
			

end

function nar_ass_bridge_enter()
SleepUntil( [| volume_test_players(  VOLUMES.nar_ass_bridge_enter ) ], 1);
	b_nar_ass_shipyard = true;

	CreateThread(assault_idle_chatter_off);
	NarrativeQueue.EndConversationEarly(W1HubassaultReports_team_chatter_1);
	NarrativeQueue.EndConversationEarly(W1HubassaultReports_team_chatter_2);
end

global W1StationAssault_BRIDGE_AREA__BRIDGE_COLLAPSE2 = {
	name = "W1StationAssault_BRIDGE_AREA__BRIDGE_COLLAPSE2",

	

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_bridge_hunters, SPARTANS.chief); -- GAMMA_TRANSITION: If chief
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Hunter!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_01600.sound'),

		sleepAfter = 1,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_bridge_hunters, SPARTANS.fred); -- GAMMA_TRANSITION: If FREDRIC
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Hunter!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_01500.sound'),

			sleepAfter = 1,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_bridge_hunters, SPARTANS.kelly); -- GAMMA_TRANSITION: If kelly
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "Hunter!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_01300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_bridge_hunters, SPARTANS.linda); -- GAMMA_TRANSITION: If linda
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Linda
			text = "Hunter!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_01200.sound'),
			
			sleepAfter = 1,
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		
		
	end,

	localVariables = {},
};



function nar_ass_bridge_hunters()
		NarrativeQueue.QueueConversation(W1StationAssault_BRIDGE_AREA__BRIDGE_COLLAPSE2);
end
		

-- =================================================================================================
--
--					TUNNELS SECTION
--
-- Covers content on the tunnels section.
--
-- =================================================================================================

function nar_temp_cine_vision()
	
	if not editor_mode() then
 player_control_fade_out_all_input (0);
	   --fade_out (0,0,0, 10);
		sleep_s(1);
		CreateThread(ShowTempTextNarrative, "Master Chief has a vision of a distant planet, Meridian. Cortana calls out to him.", 4);
		sleep_s(5);
		CreateThread(ShowTempTextNarrative, "She warns him that the Domain is open, the Reclaimation has begun, and Meridian is next.", 4);
		sleep_s(5);
		CreateThread(ShowTempTextNarrative, "She warns him he has three days. The vision ends.", 4);
		sleep_s(5);
		 CreateThread(ShowTempTextNarrative, "Master Chief is on his knees in Assault. He tells Blue Team Cortana is alive and contacted him.", 4);
		 sleep_s(5);
		 --fade_in (0,0,0, seconds_to_frames (2));
		 player_control_fade_in_all_input (1);
	   b_meridian_temp_cin_complete = true;
	else
		b_meridian_temp_cin_complete = true;
	end

end


global W1StationAssault_MAINTENANCE_TUNNELS__TUNNEL_LANDING = {
	name = "W1StationAssault_MAINTENANCE_TUNNELS__TUNNEL_LANDING",

	CanStart = function (thisConvo, queue)
		return volume_test_object(VOLUMES.nar_ass_landing_in_tunnels, SPARTANS.kelly) or volume_test_object(VOLUMES.nar_ass_landing_in_tunnels, SPARTANS.fred) or volume_test_object(VOLUMES.nar_ass_landing_in_tunnels, SPARTANS.chief); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_landing_in_tunnels, SPARTANS.kelly); -- GAMMA_TRANSITION: If chief
			end,


	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "Landed. Maintenance tunnels.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_09300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_landing_in_tunnels, SPARTANS.chief); -- GAMMA_TRANSITION: If chief
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Landed. Maintenance tunnels.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_10300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_landing_in_tunnels, SPARTANS.fred); -- GAMMA_TRANSITION: If chief
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Landed. Maintenance tunnels.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_11700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 3; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},

		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_landing_in_tunnels, SPARTANS.linda); -- GAMMA_TRANSITION: If chief
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Linda
			text = "Landed. Maintenance tunnels.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_08900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: fredric
			text = "Everyone good?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_09200.sound'),
		},
--           Blue team moves forward and then:
-- 
--                                                   CG START
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		
	end,

	localVariables = {},
};

function nar_turn_ai_back_on()
	AIDialogManager.EnableAIDialog();
end


function nar_lights_on()

	--NarrativeQueue.QueueConversation(W1StationAssault_MAINTENANCE_TUNNELS__LIGHTS_ON);
end

global W1StationAssault_MAINTENANCE_TUNNELS__LIGHTS_ON = {
	name = "W1StationAssault_MAINTENANCE_TUNNELS__LIGHTS_ON",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {


			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "Lights on.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_10800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {


			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Flashlights on.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_13000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {


			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly
			text = "Lights on.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_10200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {

			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Linda
			text = "Lights on.\r\n\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_10200.sound'),

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


global W1StationAssault_MAINTENANCE_TUNNELS__CINEMATIC_OUT = {
	name = "W1StationAssault_MAINTENANCE_TUNNELS__CINEMATIC_OUT",

	CanStart = function (thisConvo, queue)
		return b_meridian_temp_cin_complete == true; -- GAMMA_CONDITION
	end,

	sleepBefore = 3,

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

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "That's not possible.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_01100.sound'),
		},
		[2] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
						sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Linda
			text = "You said she was gone.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_00800.sound'),
		},
		[3] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "I watched her die.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_01300.sound'),
		},
				[4] = {

			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "Lights on.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_10800.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				CreateThread( f_tunnel_lamp_flicker_all );
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--                          (beat)
--                     We have a mission to focus on. We
--                     can talk about this later.

		[5] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",

			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MastercHIEF
			text = "Fredric. Get us back on course for Central Control.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_06800.sound'),
		},
		[6] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Bringing up schematics.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_01700.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				RunClientScript("pip_assault_argentmoon_schematics_60");
				return 7;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				RunClientScript("pip_assault_argentmoon_schematics_60");
				return 7; -- GAMMA_NEXT_LINE_NUMBER
			end,
			
		},
--           PIP: SHIP SCHEMATICS. SHOWS TUNNEL PATHS.

		[7] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			sleepBefore = 1,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "There's an elevator we can use, but access is four levels down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_01800.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[8] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Mark a path.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_06900.sound'),
		},
--           After a short pause:

		
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		CreateThread(nar_ass_tunnel_level1_nudge);
		CreateThread( f_tunnels_mark_path_ahead );
				hud_hide_radio_transmission_hud();
				CreateThread(nar_turn_ai_back_on);
	end,

	localVariables = {},
};


global W1StationAssault_MAINTENANCE_TUNNELS_HOSTILE_CONTACT = {
	name = "W1StationAssault_MAINTENANCE_TUNNELS_HOSTILE_CONTACT",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_ass_tunnel_combat); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 1,

	OnPlay = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_tunnel_combat, SPARTANS.fred); -- GAMMA_TRANSITION: If FREDRIC
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Hostile contact.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_02000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_tunnel_combat, SPARTANS.linda); -- GAMMA_TRANSITION: If LINDA
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LINDA
			text = "Hostile contact.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_01600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_tunnel_combat, SPARTANS.kelly); -- GAMMA_TRANSITION: If kelly
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "Hostile contact.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_01700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_tunnel_combat, SPARTANS.chief); -- GAMMA_TRANSITION: If masterchief
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Hostile contact.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_01900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
				hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


function nar_level_hostile_contact()
SleepUntil( [| volume_test_players(VOLUMES.nar_ass_tunnel_combat) ],1);
	b_nar_ass_level1 = true;
	
end




global W1StationAssault_MAINTENANCE_TUNNELS_SLEEPING = {
	name = "W1StationAssault_MAINTENANCE_TUNNELS_SLEEPING",

	CanStart = function (thisConvo, queue)
		return (volume_test_players(VOLUMES.nar_ass_sleeping) or volume_test_players(VOLUMES.nar_ass_tunnel_combat2) or volume_test_players(VOLUMES.nar_ass_first_combat3) ) and ai_combat_status(AI.sg_intro_all ) == 0; -- GAMMA_CONDITION
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
				return volume_test_object(VOLUMES.nar_ass_sleeping, SPARTANS.fred) or volume_test_object(VOLUMES.nar_ass_tunnel_combat2, SPARTANS.fred) or volume_test_object(VOLUMES.nar_ass_first_combat3, SPARTANS.fred); -- GAMMA_TRANSITION: If masterchief
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: Fredric
			text = "Hostiles sleeping ahead. Sneak in and get the drop on them.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_09300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			
				ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_sleeping, SPARTANS.linda) or volume_test_object(VOLUMES.nar_ass_tunnel_combat2, SPARTANS.linda) or volume_test_object(VOLUMES.nar_ass_first_combat3, SPARTANS.linda); -- GAMMA_TRANSITION: If masterchief
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Linda
			text = "Hostiles sleeping ahead. Sneak in and get the drop on them.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_03600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
				ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_sleeping, SPARTANS.kelly) or volume_test_object(VOLUMES.nar_ass_tunnel_combat2, SPARTANS.kelly) or volume_test_object(VOLUMES.nar_ass_first_combat3, SPARTANS.kelly); -- GAMMA_TRANSITION: If masterchief
			end,
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "Hostiles sleeping ahead. Sneak in and get the drop on them.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_07300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
				ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_sleeping, SPARTANS.chief) or volume_test_object(VOLUMES.nar_ass_tunnel_combat2, SPARTANS.chief) or volume_test_object(VOLUMES.nar_ass_first_combat3, SPARTANS.chief); -- GAMMA_TRANSITION: If masterchief
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Hostiles sleeping ahead. Sneak in and get the drop on them.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_04000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},


	},

	OnFinish = function (thisConvo, queue)
				hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global W1StationAssault_MAINTENANCE_TUNNELS_level2 = {
	name = "W1StationAssault_MAINTENANCE_TUNNELS_level2",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_ass_tunnel_level2) or b_second_level_complete == true; -- GAMMA_CONDITION
	end,
			canStartOnce = true,
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,


	sleepBefore = 1,
	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		b_room1_vo_played = true;
	end,

	lines = {
			[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_tunnel_level2, SPARTANS.fred); -- GAMMA_TRANSITION: If masterchief
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "We've reached level two. Keep moving down.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_08000.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		
		
		},
			[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_tunnel_level2, SPARTANS.chief); -- GAMMA_TRANSITION: If masterchief
			end,
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "We've reached level two. Keep moving down.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_03200.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		
		},

		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_tunnel_level2, SPARTANS.kelly); -- GAMMA_TRANSITION: If masterchief
			end,
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "We've reached level two. Keep moving down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_06500.sound'),

		AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
				},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_tunnel_level2, SPARTANS.linda); -- GAMMA_TRANSITION: If masterchief
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: linda
			text = "We've reached level two. Keep moving down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_05800.sound'),

		AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		
		},
		[5] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
		sleepBefore = 1,
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: KELLY
			text = "Chief. What did Cortana say to you exactly?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_03500.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[6] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
		sleepBefore = 1,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "Not enough. Something about Meridian.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_05700.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[7] = {
		                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Meridian's a backwater. If she's active, what's she doing so far out on the frontier?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_03200.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
				hud_hide_radio_transmission_hud();
				b_tun_meridian_chat_done = true;
	end,

	localVariables = {},
};

function nar_ass_tunnel_level2()
SleepUntil( [| volume_test_players(VOLUMES.nar_ass_sleeping) or volume_test_players(VOLUMES.nar_ass_tunnel_combat2) or volume_test_players(VOLUMES.nar_ass_first_combat3) ],1);
	b_nar_ass_level1 = true;
	
	CreateThread(nar_ass_elite_order);
	NarrativeQueue.QueueConversation(W1StationAssault_MAINTENANCE_TUNNELS__ENCOUNTER_1_PULL_FORWARD);
	

end

global W1StationAssault_MAINTENANCE_TUNNELS__REACHED_LEVEL_THREE = {
	name = "W1StationAssault_MAINTENANCE_TUNNELS__REACHED_LEVEL_THREE",
	CanStart = function (thisConvo, queue) -- BOOLEAN
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if (ai_living_count (AI.sg_tunnels_end_all) >= 1 ) then
			thisConvo.localVariables.checkConditionsPassed = 1;
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return  (ai_living_count (AI.sg_tunnels_end_all) < 1 );
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
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_level_three_reached, SPARTANS.kelly); -- GAMMA_TRANSITION: If kellY
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "Reached level three. One more level down to elevator for Central Control.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_06600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_level_three_reached, SPARTANS.chief); -- GAMMA_TRANSITION: IF FREDRIC
			end,
				                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Reached level three. One more level down to elevator for Central Control.\r\n",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_05300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_level_three_reached, SPARTANS.fred); -- GAMMA_TRANSITION: IF FREDRIC
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Reached level three. One more level down to elevator for Central Control.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_08100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},

		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_level_three_reached, SPARTANS.linda); -- GAMMA_TRANSITION: If linda
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: linda
			text = "Reached level three. One more level down to elevator for Central Control.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_05900.sound'),

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

		localVariables = {
		checkConditionsPassed = 0,
	},
};



function nar_level_three_reached()
SleepUntil( [| volume_test_players(VOLUMES.nar_level_three_reached) ],1);
b_nar_ass_level2 = true;
sleep_s(5);
CreateThread(nar_ass_tunnel_level3_nudge);
CreateThread(nar_ass_zealot_encounter);
NarrativeQueue.QueueConversation(W1StationAssault_MAINTENANCE_TUNNELS__REACHED_LEVEL_THREE);
end


function nar_ass_grunts_mocking()
	AIDialogManager.DisableAIDialog();
	sleep_s(1);
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_cv_grunt01_00300.sound'), OBJECTS.giggle_grunts_vo);
	sleep_s(1.5);
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_cv_grunt02_00200.sound'), OBJECTS.giggle_grunts_vo);
	sleep_s(2.5);
		AIDialogManager.EnableAIDialog();
		
end


global W1StationAssault_MAINTENANCE_TUNNELS__HUNTER_CALL_AND_RESPONSE = {
	name = "W1StationAssault_MAINTENANCE_TUNNELS__HUNTER_CALL_AND_RESPONSE",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_ass_hunter_call_response); -- GAMMA_CONDITION
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
				return volume_test_object(VOLUMES.nar_ass_hunter_call_response, SPARTANS.fred); -- GAMMA_TRANSITION: If fredric
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Hunters. They're keeping pace with us.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_01900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_hunter_call_response, SPARTANS.kelly); -- GAMMA_TRANSITION: If kelly
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "Hunters. They're keeping pace with us.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_09100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_hunter_call_response, SPARTANS.linda); -- GAMMA_TRANSITION: If linda
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Linda
			text = "Hunters. They're keeping pace with us.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_08600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_hunter_call_response, SPARTANS.chief); -- GAMMA_TRANSITION: IF MASTERCHIEF
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Hunters. They're keeping pace with us.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_10200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
				[5] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: Fredric
			text = "The hunters are toying with us.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_11600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global W1StationAssault_MAINTENANCE_TUNNELS__HUNTER_CALL_AND_RESPONSE2 = {
	name = "W1StationAssault_MAINTENANCE_TUNNELS__HUNTER_CALL_AND_RESPONSE2",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_ass_cortana_discuss2); -- GAMMA_CONDITION
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
				return volume_test_object(VOLUMES.nar_ass_cortana_discuss2, SPARTANS.chief); -- GAMMA_TRANSITION: If fredric
			end,


	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Worms. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_02500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_cortana_discuss2, SPARTANS.linda); -- GAMMA_TRANSITION: If linda
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Linda
			text = "Worms.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_08700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_cortana_discuss2, SPARTANS.kelly); -- GAMMA_TRANSITION: If KELLY
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: kelly
			text = "Worms.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_09200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_cortana_discuss2, SPARTANS.fred); -- GAMMA_TRANSITION: If fredric
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: Fredric
			text = "Worms.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_11500.sound'),

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


global W1StationAssault_MAINTENANCE_TUNNELS__Stealth_encounter = {
	name = "W1StationAssault_MAINTENANCE_TUNNELS__Stealth_encounter",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.sq_tun_front_camo_elite_01.spawnpoint14,
			text = "[menacing growl]",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_cv_elite01_00500.sound'),
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object( SPARTANS.kelly, ai_get_object(AI.sq_tun_front_camo_elite_01.spawnpoint14)) < 8 ; -- GAMMA_TRANSITION: IF KELLY
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,
			sleepBefore = 0.5,
                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: KELLY
			text = "Elites. Active camouflage.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_05900.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object( SPARTANS.fred, ai_get_object(AI.sq_tun_front_camo_elite_01.spawnpoint14)) < 8 ; -- GAMMA_TRANSITION: IF LINDA
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,
			sleepBefore = 0.5,
                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LINDA
			text = "Elites. Active camouflage.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_06100.sound'),

		AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object( SPARTANS.linda, ai_get_object(AI.sq_tun_front_camo_elite_01.spawnpoint14)) < 8 ; -- GAMMA_TRANSITION: IF LINDA
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			sleepBefore = 0.5,			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LINDA
			text = "Elites. Active camouflage.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_05500.sound'),

		AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object(SPARTANS.chief, ai_get_object(AI.sq_tun_front_camo_elite_01.spawnpoint14)) < 8 ; -- GAMMA_TRANSITION: If MASTERCHIEF
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,
			sleepBefore = 0.5,
                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Elites. Active camouflage. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_07300.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[6] = {
		sleepBefore = 0.5,
			character = AI.sq_tun_front_camo_elite_01.spawnpoint14, -- GAMMA_CHARACTER: Elite03
			text = "Kill the Demon and his allies! They must not interfere!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_cv_elite03_00300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

function nar_ass_elite_order()
SleepUntil([|ai_living_fraction(AI.sq_tun_front_camo_elite_01) >= 0], 1);
--print("step1");
SleepUntil([| objects_distance_to_object(players_human(),ai_get_object(AI.sq_tun_front_camo_elite_01.spawnpoint14)) < 8 ], 1);

	NarrativeQueue.QueueConversation(W1StationAssault_MAINTENANCE_TUNNELS__Stealth_encounter);
end


	


global W1StationAssault_MAINTENANCE_TUNNELS__ENCOUNTER_1_PULL_FORWARD = {
	name = "W1StationAssault_MAINTENANCE_TUNNELS__ENCOUNTER_1_PULL_FORWARD",

	CanStart = function (thisConvo, queue)
		return ai_living_count (AI.sg_tunnels_front_all) <= 0 and b_room1_vo_played == false; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,


	sleepBefore = 2,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.chief) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MasterchieF
			text = "This area's clear. Move forward.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_08500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.fred) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "This area's clear. Move forward.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_09600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
		
		ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.kelly) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "This area's clear. Move forward.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_07600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.linda) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,		
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: linda
			text = "This area's clear. Move forward.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_06500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
			CreateThread(nar_ass_tunnel_level2_nudge);	
			b_second_level_complete = true;
	end,

	localVariables = {},
};

global W1StationAssault_Maintenance_tunnels__Armada_arrival = {
	name = "W1StationAssault_Maintenance_tunnels__Armada_arrival",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_ass_armada_arrival_start); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		b_nar_ass_level3 = true;
			--	RunClientScript("pip_genereic_radio_intercept_60");
	end,

	lines = {
		[1] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,
					 sleepBefore = 1,
                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "Covenant battlenet just lit up. \r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_02300.sound'),
		},


	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


global W1StationAssault_Maintenance_tunnels__Armada_arrival2 = {
	name = "W1StationAssault_Maintenance_tunnels__Armada_arrival2",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_ass_armada_arrival); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,
	
	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		b_nar_ass_level3 = true;
	end,

	lines = {
	
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_armada_arrival, SPARTANS.fred); -- GAMMA_TRANSITION: If FREDRIC
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Because a pack of Covenant ships just arrived. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_02400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_armada_arrival, SPARTANS.linda); -- GAMMA_TRANSITION: If LINDA
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LINDA
			text = "Because a pack of Covenant ships just arrived. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_02000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_armada_arrival, SPARTANS.kelly); -- GAMMA_TRANSITION: If kelly
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "...and I think I know why. Covenant ships exiting slipspace.  ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_02400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_armada_arrival, SPARTANS.chief); -- GAMMA_TRANSITION: If masterchief
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Covenant ships exiting slipspace.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_02800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--           After:
--                     
-- 
--           PIP: ARMADA VISUALIZATION [HEY, IS THIS ONE ON OUR LIST?]

		[5] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
					 sleepBefore = 1.5,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FreDRIC
			text = "We're outnumbered here, Chief. A few thousand to one.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_06500.sound'),
			
		},
		[6] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Surrendering Argent Moon is not an option. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_07800.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 8;
			end,
		},
		[7] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LINDA
			text = "Neither is fighting half the Covenant in close quarters.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_05700.sound'),
		},
		[8] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			sleepBefore = 1,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Then we scuttle the Argent Moon. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_02900.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global W1StationAssault_TUNNELS_TRANSITION__REACTOR_NOTICE = {
	name = "W1StationAssault_TUNNELS_TRANSITION__REACTOR_NOTICE",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_ass_rendezvous); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		RunClientScript("pip_assault_argentmoon_reactorlocation_60");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_rendezvous, SPARTANS.fred); -- GAMMA_TRANSITION: If FREDRIC
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Ship's reactor core is near here. Same plan as the Perpetual Devotion?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_02800.sound'),
				AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 8; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_rendezvous, SPARTANS.linda); -- GAMMA_TRANSITION: If LINDA
			end,

                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LINDA
			text = "Ship's reactor core is near here. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_02500.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 3; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {

			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Same plan as the Perpetual Devotion?\r\n\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_02900.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 8; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_rendezvous, SPARTANS.kelly); -- GAMMA_TRANSITION: If kelly
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: KELLy
			text = "Ship's reactor core is near here. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_03200.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 6;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Same plan as the Perpetual Devotion?\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_03000.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 8; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[6] = {
	
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_rendezvous, SPARTANS.chief); -- GAMMA_TRANSITION: If kelly
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Ship's reactor core is near here. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_05500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 7; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[7] = {
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Same plan as the Perpetual Devotion?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_03100.sound'),
		},
		[8] = {
		

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Affirmative. We overload the reactor and evac.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_07400.sound'),

		
		},
		[9] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "The reactor is below the lab just ahead. We can use air ducts to travel between them. Marking the access panel.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_03300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
			b_reactor_plan_complete = true;
			CreateThread(nar_ass_lab_nudge);
	end,

	localVariables = {},
};


global W1StationAssault_MAINTENANCE_TUNNELS__ZEALOT_ENCOUNTER = {
	name = "W1StationAssault_MAINTENANCE_TUNNELS__ZEALOT_ENCOUNTER",
	CanStart = function (thisConvo, queue) -- BOOLEAN
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if (ai_living_count (AI.sq_tun_end_zealot) >= 1 ) then
			thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return volume_test_players(VOLUMES.nar_level_three_reached) and objects_distance_to_object(players_human(),ai_get_object(AI.sq_tun_end_zealot.chuck)) < 7 ;
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
			character = AI.sq_tun_end_zealot.chuck, -- GAMMA_CHARACTER: Elite03
			text = "For the glory of 'Mdama!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_VO_SCR_W1StationAssault_CV_ELITE03_00200.sound'),
		},
	
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return (objects_distance_to_object(SPARTANS.fred,ai_get_object(AI.sq_tun_end_zealot.chuck)) < 5 ); -- GAMMA_TRANSITION: If masterchief
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Zealot with an energy sword!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_11200.sound'),
		},
		[3] = {
				ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (objects_distance_to_object(SPARTANS.kelly,ai_get_object(AI.sq_tun_end_zealot.chuck)) < 5 ); -- GAMMA_TRANSITION: If masterchief
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "Zealot with an energy sword!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_08900.sound'),
		},
		[4] = {
				ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (objects_distance_to_object(SPARTANS.linda,ai_get_object(AI.sq_tun_end_zealot.chuck)) < 5 ); -- GAMMA_TRANSITION: If masterchief
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Linda
			text = "Zealot with an energy sword!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_08400.sound'),
		},
			[5] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (objects_distance_to_object(SPARTANS.chief,ai_get_object(AI.sq_tun_end_zealot.chuck)) < 5 ); -- GAMMA_TRANSITION: If masterchief
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Zealot with an energy sword!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_09700.sound'),

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

		localVariables = {
		checkConditionsPassed = 0,
	},
};



function nar_ass_zealot_encounter()
SleepUntil([|ai_living_fraction(AI.sq_tun_end_zealot.chuck) >= 0], 1);
--print("step1");
SleepUntil([| objects_distance_to_object(players_human(),ai_get_object(AI.sq_tun_end_zealot.chuck)) < 5 ], 1);
	NarrativeQueue.QueueConversation(W1StationAssault_MAINTENANCE_TUNNELS__ZEALOT_ENCOUNTER);
end

function nar_ass_tunnel_level1_nudge()
	sleep_s(180);
		SleepUntil( [| ai_combat_status(GetMusketeerSquad()) <= 2 ], 1);
	
	if b_nar_ass_level1 == false then

		NarrativeQueue.QueueConversation(W1StationAssault_MAINTENANCE_TUNNELS__WRONG_WAY);

	end
end

global W1StationAssault_MAINTENANCE_TUNNELS__WRONG_WAY = {
	name = "W1StationAssault_MAINTENANCE_TUNNELS__WRONG_WAY",


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

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Path to Central Command is down. Don't follow ramps up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_12000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
		

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Path to Central Command is down. Don't follow ramps up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_10400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
		

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "Path to Central Command is down. Don't follow ramps up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_09600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
		
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Linda
			text = "Path to Central Command is down. Don't follow ramps up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_09500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--           
-- 
--           
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

function nar_ass_tunnel_level2_nudge()
	sleep_s(90);
	if b_nar_ass_level2 == false then
			NarrativeQueue.QueueConversation(W1StationAssault_MAINTENANCE_TUNNELS__PUSH_AHEAD2);

	end

end

global W1StationAssault_MAINTENANCE_TUNNELS__PUSH_AHEAD2 = {
	name = "W1StationAssault_MAINTENANCE_TUNNELS__PUSH_AHEAD2",

	CanStart = function (thisConvo, queue)
		return ai_combat_status(object_get_ai(SPARTANS.fred)) < 5 or ai_combat_status(object_get_ai(SPARTANS.kelly)) < 5 and ai_combat_status(object_get_ai(SPARTANS.linda)) < 5; -- GAMMA_CONDITION
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
		
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
				character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: fredric
			text = "We've got a lot of ground left to cover. We should keep moving down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_07900.sound'),
			
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

function nar_ass_tunnel_level3_nudge()
	sleep_s(150);
	if b_nar_ass_level3 == false then
		NarrativeQueue.QueueConversation(W1StationAssault_MAINTENANCE_TUNNELS__PUSH_AHEAD);

	end


end

global W1StationAssault_MAINTENANCE_TUNNELS__PUSH_AHEAD = {
	name = "W1StationAssault_MAINTENANCE_TUNNELS__PUSH_AHEAD",

	CanStart = function (thisConvo, queue)
		return ai_combat_status(object_get_ai(SPARTANS.fred)) < 5 or ai_combat_status(object_get_ai(SPARTANS.kelly)) < 5 and ai_combat_status(object_get_ai(SPARTANS.linda)) < 5; -- GAMMA_CONDITION
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
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, 
					text = "Keep moving down. We'll get back on course for Central Command.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_05300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


function nar_ass_lab_nudge()
	sleep_s(30);
	if b_nar_ass_lab == false then
	SleepUntil( [| b_collectible_used == false ], 1);
		NarrativeQueue.QueueConversation(W1StationAssault_lab_nudge);

	end


end
global W1StationAssault_lab_nudge = {
	name = "W1StationAssault_lab_nudge",

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

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Our path to the reactor room is through that lab. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_09700.sound'),
		},
	},
	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

-- =================================================================================================
--
--					HUNTER ROOM
--
-- Covers content on the hunter room.
--
-- =================================================================================================

function nar_ass_elevator_panel_used()
sleep_s(2.5);
	
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_01500.sound'), OBJECTS.hunter_entrance_pa);
	
	sleep_s(2);
	--PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_02600.sound'), nil);
		
	
end

global W1StationAssault_RESEARCH_LAB_ELEVATOR__HUNTER_ATTACk = {
	name = "W1StationAssault_RESEARCH_LAB_ELEVATOR__HUNTER_ATTACk",
		CanStart = function (thisConvo, queue)
		return  volume_test_players(VOLUMES.tv_hunter_blast_shield); -- GAMMA_CONDITION
	end,

	sleepBefore = 1,
			canStartOnce = true,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
			--RunClientScript("pip_genereic_radio_intercept_60");
	end,

	lines = {
		[1] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: KeLLY
			text = "There's chatter about Jul 'Mdama on Covenant Comms. The new arrivals say he's dead. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_06100.sound'),
						
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
		},
		[2] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Somebody cut the head off the Covenant. Bravo.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_06700.sound'),
		},
--           As the elevator proceeds down, worms begin to wiggle down its
--           glass face.

		[3] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			sleepBefore = 3,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Hunters...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_05200.sound'),
		},
		[4] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
					 sleepBefore = 1,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: fredric
			text = "They're strong, but slow. Use the lab equipment to keep above them and out of their reach.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_09800.sound'),
						
		},
--           They join a river of other worms that wiggle toward armor in
--           the middle of the room. 
-- 
--           They come together to stand up and form one of the hunters.

		[5] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,
					 sleepBefore = 0.5,
                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MasterchieF
			text = "Weapons free!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_03300.sound'),
		},
	--	[6] = {
	--		character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
	--		text = "Hit 'em from behind!",
	--		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_03400.sound'),
	--	},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
				NarrativeQueue.QueueConversation(W1StationAssault_RESEARCH_LAB__HUNTER_COMBAT_COMPLETE);
	end,

	localVariables = {},
};
	

function nar_ass_hunter_elevator()

	b_nar_ass_lab = true;
	

			
end

global W1StationAssault_RESEARCH_LAB__REACTOR_ENTRY_CALLOUT = {
	name = "W1StationAssault_RESEARCH_LAB__REACTOR_ENTRY_CALLOUT",

	CanStart = function (thisConvo, queue)
		return  volume_test_players(VOLUMES.nar_ass_lab_exit); -- GAMMA_CONDITION
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
				return volume_test_object(VOLUMES.nar_ass_lab_exit, SPARTANS.fred); -- GAMMA_TRANSITION: If FREDRIC
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Schematics show a path to the reactor through here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_03500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_lab_exit, SPARTANS.linda); -- GAMMA_TRANSITION: If LINDA
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LINDA
			text = "Schematics show a path to the reactor through here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_02700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_lab_exit, SPARTANS.kelly); -- GAMMA_TRANSITION: If kelly
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "Schematics show a path to the reactor through here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_03800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_lab_exit, SPARTANS.chief); -- GAMMA_TRANSITION: If masterchief
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Schematics show a path to the reactor through here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_03400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},
	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};
	

function nar_ass_air_duct_used()
sleep_s(1);
	
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_02500.sound'), OBJECTS.audio_crate_hunter);
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_02500b.sound'), OBJECTS.audio_crate_hunter01);
	
end

global W1StationAssault_RESEARCH_LAB__HUNTER_COMBAT_COMPLETE = {
	name = "W1StationAssault_RESEARCH_LAB__HUNTER_COMBAT_COMPLETE",
	CanStart = function (thisConvo, queue) -- BOOLEAN
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if (ai_living_count (AI.AISquad_hunter_forms) >= 1 ) then
			thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return ai_living_count (AI.AISquad_hunter_forms ) <= 0 and ai_living_count (AI.sq_reac_hunter_2 ) <= 0 and volume_test_players(VOLUMES.nar_ass_lab_inside) ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 2,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {

			If = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.chief) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Hunters down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_08600.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.fred) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Hunters down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_09900.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.linda) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
                 
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LINDA
			text = "Hunters down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_06800.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.kelly) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
                 
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "Hunters down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_07700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,
		sleepBefore = 1,
                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "The reactor core is just below us. Let's go.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_03600.sound'),

		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
			CreateThread(nar_ass_reactor_nudge);
			
			b_hunters_downed = true;
	end,
		localVariables = {
		checkConditionsPassed = 0,
	},
};





function nar_ass_reactor_nudge()
	sleep_s(60);
	if b_nar_ass_reactor == false then
		SleepUntil( [| b_collectible_used == false ], 1);
		NarrativeQueue.QueueConversation(W1StationAssault_HUNTER_LAB__NUDGE_FORWARD);

	end
end

global W1StationAssault_HUNTER_LAB__NUDGE_FORWARD = {
	name = "W1StationAssault_HUNTER_LAB__NUDGE_FORWARD",


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

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Linda
			text = "We can use the air ducts to reach the reactor room.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_07000.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


-- =================================================================================================
--
--					REACTOR ROOM
--
-- Covers content on the reactor room.
--
-- =================================================================================================




global W1StationAssault_REACTOR_ROOM_TRANSITION__COMBAT_PREP = {
	name = "W1StationAssault_REACTOR_ROOM_TRANSITION__COMBAT_PREP",
			canStartOnce = true,

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_ass_prep_for_reactor_room); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
			b_nar_ass_reactor = true;
		
	end,

	lines = {
		[1] = {
		sleepBefore = 1,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Reactor room is just ahead. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_08300.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
				[2] = {
                    OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
				sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LiNDA
			text = "No salvage for the Covenant.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_10400.sound'),
		},
		[3] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "Right, let's go.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_07800.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global W1StationAssault_REACTOR_ROOM__COV_CIVIL_WAR = {
	name = "W1StationAssault_REACTOR_ROOM__COV_CIVIL_WAR",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_ass_cov_overhear_war); -- GAMMA_CONDITION
	end,
			canStartOnce = true,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		--story_blurb_add("domain", "CIVIL WAR STARTED");

	end,

	lines = {
		[1] = {
			character = AI.reactor_jacks_1_front_03.reactor_shield_right, -- GAMMA_CHARACTER: Jackal01
			text = "What is happening? Why has the fleet come?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_cv_jackal01_00100.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return ai_combat_status(AI.sg_intro_all ) < 4;
			end,
		
			character = AI.reactor_jacks_1_front_03.reactor_shield_left, -- GAMMA_CHARACTER: ELITE01
			text = "Jul 'Mdama is dead. Regroup! Attack Sanghelios! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_cv_jackal02_00100.sound'),
		},
--                                                   CUT TO:
--           ____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};



function nar_ass_reactor_combat_start()
	SleepUntil( [| volume_test_players(VOLUMES.nar_ass_reactor_combat_start) ],1);


	CreateThread(nar_ass_reactor_kill_all_nudge);
	sleep_s(1);
	NarrativeQueue.QueueConversation(W1StationAssault_REACTOR_ROOM__ENTRY);

end

global W1StationAssault_REACTOR_ROOM__ENTRY = {
	name = "W1StationAssault_REACTOR_ROOM__ENTRY",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_reactor_combat_start, SPARTANS.chief); -- GAMMA_TRANSITION: If locke
			end,
							                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",


			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Reactor controls are on the far side of the room. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_11000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_reactor_combat_start, SPARTANS.fred); -- GAMMA_TRANSITION: If locke
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Reactor controls are on the far side of the room. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_13200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
				If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_reactor_combat_start, SPARTANS.kelly); -- GAMMA_TRANSITION: If locke
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",


			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: KELLY
			text = "Reactor controls are on the far side of the room. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_10600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_reactor_combat_start, SPARTANS.linda); -- GAMMA_TRANSITION: If locke
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",

			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Reactor controls are on the far side of the room. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_11000.sound'),

			--character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: lINDA
			--text = "Reactor controls are on the far side of the room. ",
			--tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_10500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {

			sleepBefore = 1,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Eliminate the Covenant forces and get to those controls.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_11100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--           
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
				hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


global W1StationAssault_REACTOR_ROOM__A_FEW_MORE_COVENANT_ = {
	name = "W1StationAssault_REACTOR_ROOM__A_FEW_MORE_COVENANT_",



	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.fred) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
                 
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Still seeing hostiles. Clear them out so we can initiate the overload.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_08400.sound'),
				AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
					ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.linda) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
                 
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LINDA
			text = "Still seeing hostiles. Clear them out so we can initiate the   overload.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_06100.sound'),
				AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
					ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.kelly) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
                 
		
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "Still seeing hostiles. Clear them out so we can initiate the   overload.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_06800.sound'),
				AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
				ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.chief) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
                 
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Still seeing hostiles. Clear them out so we can initiate the   overload.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_08000.sound'),

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


function nar_ass_reactor_kill_all_nudge()
sleep_s(120);
if b_reactor_combat_complete == false then
	NarrativeQueue.QueueConversation(W1StationAssault_REACTOR_ROOM__A_FEW_MORE_COVENANT_);
end

end



function nar_ass_reactor_room_cleared()
SleepUntil( [| ai_living_fraction (AI.sg_reactor_all) > 0 ],1);
	SleepUntil( [| ai_living_fraction (AI.sg_reactor_all) <= 0 ],1);
	b_reactor_combat_complete = true;
	NarrativeQueue.QueueConversation(W1StationAssault_REACTOR_ROOM__CLEARED);
end

global W1StationAssault_REACTOR_ROOM__CLEARED = {
	name = "W1StationAssault_REACTOR_ROOM__CLEARED",

	CanStart = function (thisConvo, queue)
		return ai_living_fraction (AI.sg_reactor_all) <= 0; -- GAMMA_CONDITION
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
	
				If = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.kelly) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
                 
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "Area's clear. Initiate the overload.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_03900.sound'),
				AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
					ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.linda) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
                 
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LINDA
			text = "Area's clear. Initiate the overload.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_02800.sound'),
				AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.fred) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
                 
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",		
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Area's clear. Initiate the overload.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_03800.sound'),
				AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
				ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.chief) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
                               OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Area's clear. Initiate the overload.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_03500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		CreateThread(nar_ass_override_nudge);
	end,

	localVariables = {},
};

function nar_ass_reactor_listener()
	
       SleepUntil([| object_valid( "dc_assault_reactor" ) ], 60);
	   PrintNarrative("LISTENER - nar_ass_reactor_listener THREADED");
       SleepUntil([| device_get_power( OBJECTS.dc_assault_reactor) == 1 ], 60);


			if not b_flight_end then
       PrintNarrative("LISTENER - nar_ass_reactor_listener");

       CreateThread(RegisterInteractEvent, nar_ass_reactor_launcher, OBJECTS.dc_assault_reactor);
			end

end

function nar_ass_reactor_launcher(trigger:object, activator:object)

       PrintNarrative("LAUNCHER - nar_ass_reactor_launcher");

       print(activator, " is the activator of ", trigger);

       CreateThread(UnregisterInteractEvent, nar_ass_reactor_launcher, OBJECTS.dc_assault_reactor);

       CreateThread(nar_ass_reactor, activator)
end


function nar_ass_reactor(activator:object)
		
	sleep_s(5.5);
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_00200.sound'), OBJECTS.vo_emitter_zs_04_right);
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_00200b.sound'), OBJECTS.vo_emitter_zs_04_left);
	sleep_s(4);
	if activator == SPARTANS.chief  then
	
		NarrativeQueue.QueueConversation(W1StationAssault_REACTOR_ROOM__OVERLOAD_REACTOR_chief);
			
		elseif activator == SPARTANS.linda  then
			NarrativeQueue.QueueConversation(W1StationAssault_REACTOR_ROOM__OVERLOAD_REACTOR_linda);
		elseif activator == SPARTANS.kelly  then
			NarrativeQueue.QueueConversation(W1StationAssault_REACTOR_ROOM__OVERLOAD_REACTOR_kelly);
		elseif activator == SPARTANS.fred  then
			NarrativeQueue.QueueConversation(W1StationAssault_REACTOR_ROOM__OVERLOAD_REACTOR_fred);
		end
		
	
end

global W1StationAssault_REACTOR_ROOM__OVERLOAD_REACTOR_kelly = {
	name = "W1StationAssault_REACTOR_ROOM__OVERLOAD_REACTOR_kelly",

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

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "Got it. Reactor's overloading.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_04000.sound'),

		
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		NarrativeQueue.QueueConversation(W1StationAssault_REACTOR_ROOM__INITIATE_REACTOR2);
	end,

	localVariables = {},
};
global W1StationAssault_REACTOR_ROOM__OVERLOAD_REACTOR_fred = {
	name = "W1StationAssault_REACTOR_ROOM__OVERLOAD_REACTOR_fred",

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

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Got it. Reactor's overloading.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_03900.sound'),

		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		NarrativeQueue.QueueConversation(W1StationAssault_REACTOR_ROOM__INITIATE_REACTOR2);
	end,

	localVariables = {},
};

global W1StationAssault_REACTOR_ROOM__OVERLOAD_REACTOR_chief = {
	name = "W1StationAssault_REACTOR_ROOM__OVERLOAD_REACTOR_chief",

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

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Got it. Reactor's overloading.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_03600.sound'),

		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		NarrativeQueue.QueueConversation(W1StationAssault_REACTOR_ROOM__INITIATE_REACTOR2);
	end,

	localVariables = {},
};

global W1StationAssault_REACTOR_ROOM__OVERLOAD_REACTOR_linda = {
	name = "W1StationAssault_REACTOR_ROOM__OVERLOAD_REACTOR_linda",

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

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LINDA
			text = "Got it. Reactor's overloading.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_02900.sound'),

			
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		NarrativeQueue.QueueConversation(W1StationAssault_REACTOR_ROOM__INITIATE_REACTOR2);
	end,

	localVariables = {},
};


global W1StationAssault_REACTOR_ROOM__INITIATE_REACTOR2 = {
	name = "W1StationAssault_REACTOR_ROOM__INITIATE_REACTOR2",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		CreateThread(nar_reactor_boarded);
	end,

	lines = {

		[1] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MaSTERCHIEF
			text = "Move for the hangar bay--",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_07900.sound'),
			playDurationAdjustment = 0.8,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_01000.sound'), OBJECTS.vo_emitter_zs_04_right);
				PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_01000b.sound'), OBJECTS.vo_emitter_zs_04_left);
				return 2; -- GAMMA_NEXT_LINE_NUMBER
			end,
	
		},
		[2] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			sleepBefore = 3.5,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Containment protocol?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_06200.sound'),
		},
		[3] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "The station's going to try to cool the reactor. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_06800.sound'),
		},
		[4] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: KeLLY
			text = "I guess the UNSC has better reactor safety protocol than the Covenant.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_06900.sound'),
		},
				[5] = {
								                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MaSTERCHIEF
			text = "We can stop that. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_11500.sound'),
		},
		[6] = {
					If = function (thisLine, thisConvo, queue, lineNumber)
				return b_nar_ass_ridedown_nudge == false; -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,
						                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: maSTERCHIEF
			text = "Board the reactor.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_11600.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},

		[7] = {
		If = function (thisLine, thisConvo, queue, lineNumber)
				return b_nar_ass_ridedown_nudge == false; -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: keLLY
			text = "Board the reactor?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_09700.sound'),
				AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[8] = {
		If = function (thisLine, thisConvo, queue, lineNumber)
				return b_nar_ass_ridedown_nudge == false; -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: masTERCHIEF
			text = "If it's being moved, we should go with it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_10500.sound'),
		},
--           After:
-- 
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		CreateThread(nar_ass_ridedown_nudge);
		
		CreateThread(f_reactor_mark_reactor);
	end,

	localVariables = {},
};



function nar_ass_reactor_hit()
	reactor_overload_start = true;
	
end

function nar_ass_override_nudge()
	sleep_s(30);
	if reactor_overload_start == false then
	SleepUntil( [| b_collectible_used == false ], 1);
		NarrativeQueue.QueueConversation(W1StationAssault_REACTOR_ROOM__INITIATE_REACTOR_NUDGE);
	end
end

global W1StationAssault_REACTOR_ROOM__INITIATE_REACTOR_NUDGE = {
	name = "W1StationAssault_REACTOR_ROOM__INITIATE_REACTOR_NUDGE",

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

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: Fredric
			text = "Controls for the reactor will be nearby. Keep looking.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_11000.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};



function nar_ass_ridedown_nudge()
	sleep_s(30);
	if b_nar_ass_ridedown_nudge == false then
	SleepUntil( [| b_collectible_used == false ], 1);
			NarrativeQueue.QueueConversation(W1StationAssault_REACTOR_ROOM__BOARD_THE_REACTOR);
	end
end

global W1StationAssault_REACTOR_ROOM__BOARD_THE_REACTOR = {
	name = "W1StationAssault_REACTOR_ROOM__BOARD_THE_REACTOR",

	

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

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FreDRIC
			text = "Climb on the reactor before the station ejects it.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_12200.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


-- =================================================================================================
--
--					BANSHEE SECTION
--
-- Covers content on the banshee section.
--
-- =================================================================================================




global W1StationAssault_Reactor_room__Reactor_lowering = {
	name = "W1StationAssault_Reactor_room__Reactor_lowering",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_00300.sound'), OBJECTS.vo_emitter_zs_04_right);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_00300b.sound'), OBJECTS.vo_emitter_zs_04_left);
	end,

	lines = {

		[1] = {
			sleepBefore = 8,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "The safety systems are set to pump coolant to the reactor.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_07000.sound'),
		},
		[2] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			sleepBefore = 1,
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: lINDA
			text = "This whole plan fails if that coolant gets a chance to work.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_08800.sound'),
		},
			[3] = {
 	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			sleepBefore = 2,
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: keLLY
			text = "Shame to lose the Argent Moon, but I'd love to see the look on the Covenant's faces when she goes super nova.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_10500.sound'),
	
		},
	--	[5] = {


	--		character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: fredRIC
	--		text = "There are control sheds located below where we should be able to override the system. ",
	--		tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_07100.sound'),
	--	},
--           (trying to keep us focused on just the next step, rather than
--           the whole plan at once)
--                     
-- 
--           When we reach the bottom:

--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		NarrativeQueue.QueueConversation(W1StationAssault_Reactor_room__Reactor_bottom);
		
	end,

	localVariables = {},
};

global W1StationAssault_Reactor_room__Reactor_bottom = {
	name = "W1StationAssault_Reactor_room__Reactor_bottom",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_ass_reactor_bottom ); -- GAMMA_CONDITION
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
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "How do we stop it?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_06300.sound'),

			
		},
		[2] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
					 			sleepBefore = 1,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: Fredric
			text = "There are sheds located on either side of the cooling chamber.  Those are our targets.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_10000.sound'),
		},
				[3] = {
										                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief", 
					 			sleepBefore = 1,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MaSTERCHIEF
			text = "Reach the control sheds. Get the cooling system offline.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_11200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		
		
		CreateThread(nar_ass_shutters_nudge);
	end,

	localVariables = {},
};

function nar_reactor_boarded()
	SleepUntil( [| volume_test_players(VOLUMES.tv_reactor_goto) ],1);
	b_nar_ass_ridedown_nudge = true;
end

function nar_ass_reactor_start()
	b_nar_ass_ridedown_nudge = true;
	NarrativeQueue.QueueConversation(W1StationAssault_Reactor_room__Reactor_lowering);
	CreateThread(assault_idle_chatter_off);
	NarrativeQueue.EndConversationEarly(W1HubassaultReports_team_chatter_1);
	NarrativeQueue.EndConversationEarly(W1HubassaultReports_team_chatter_2);
end

global W1StationAssault_REACTOR_DOCKING__COVENANT_MISE_EN_SCENE = {
	name = "W1StationAssault_REACTOR_DOCKING__COVENANT_MISE_EN_SCENE",

	CanStart = function (thisConvo, queue)
		return objects_distance_to_object(players_human(),ai_get_object(AI.sq_flight_engine_guards_01.elite)) < 10; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.sq_flight_engine_guards_01.elite, -- GAMMA_CHARACTER: ELITE04
			text = "Get these crates to the cruisers! Glory awaits on Sangheios! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_cv_elite04_00100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		
	end,

	localVariables = {},
};

global W1StationAssault_REACTOR_DOCKING__COVENANT_MISE_EN_SCENE2 = {
	name = "W1StationAssault_REACTOR_DOCKING__COVENANT_MISE_EN_SCENE2",

	CanStart = function (thisConvo, queue)
		return ai_combat_status(AI.sq_flight_engine_guards_01.elite ) > 4; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
	
		[1] = {
			character = AI.sq_flight_engine_guards_01.elite, -- GAMMA_CHARACTER: Elite04
			text = "Jul 'Mdama will be avenged!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_cv_elite04_00200.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global W1StationAssault_Reactor_docking__CLAMP_APPROACH = {
	name = "W1StationAssault_Reactor_docking__CLAMP_APPROACH",

	CanStart = function (thisConvo, queue)
		return  volume_test_players(VOLUMES.nar_ass_reactor_button_approach) or volume_test_players(VOLUMES.nar_ass_reactor_button_approach2); -- GAMMA_CONDITION
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
				return (volume_test_object(VOLUMES.nar_ass_reactor_button_approach, SPARTANS.fred) == true) or (volume_test_object(VOLUMES.nar_ass_reactor_button_approach2, SPARTANS.fred) == true); -- GAMMA_TRANSITION: If fredric
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Located override controls.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_05500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return (volume_test_object(VOLUMES.nar_ass_reactor_button_approach, SPARTANS.linda) == true) or (volume_test_object(VOLUMES.nar_ass_reactor_button_approach2, SPARTANS.linda) == true); -- GAMMA_TRANSITION: If LINDA
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LINDA
			text = "Located override controls.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_04900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return (volume_test_object(VOLUMES.nar_ass_reactor_button_approach, SPARTANS.kelly) == true) or (volume_test_object(VOLUMES.nar_ass_reactor_button_approach2, SPARTANS.kelly) == true); -- GAMMA_TRANSITION: If kelly
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "Located override controls.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_05300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return (volume_test_object(VOLUMES.nar_ass_reactor_button_approach, SPARTANS.chief) == true) or (volume_test_object(VOLUMES.nar_ass_reactor_button_approach2, SPARTANS.chief) == true); -- GAMMA_TRANSITION: If masterchief
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Located override controls.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_06400.sound'),

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




function nar_ass_shutter1_listener()
	
       SleepUntil([| object_valid( "dc_banshee_vent_1" ) ], 60);
	   PrintNarrative("LISTENER - nar_ass_shutter1_listener THREADED");
       SleepUntil([| device_get_power( OBJECTS.dc_banshee_vent_1) == 1 or b_flight_end ], 60);
	

			if not b_flight_end then
       PrintNarrative("LISTENER - nar_ass_shutter1_listener");

       CreateThread(RegisterInteractEvent, nar_ass_shutter1_launcher, OBJECTS.dc_banshee_vent_1);
			end

end

function nar_ass_shutter1_launcher(trigger:object, activator:object)

       PrintNarrative("LAUNCHER - nar_ass_shutter1_launcher");

       print(activator, " is the activator of ", trigger);

       CreateThread(UnregisterInteractEvent, nar_ass_shutter1_launcher, OBJECTS.dc_banshee_vent_1);

       CreateThread(nar_ass_shutter1_access, activator)
end


function nar_ass_shutter1_access(activator:object)
		b_nar_ass_shutters_nudge = true;
		sleep_s(2);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_00400.sound'), OBJECTS.banshee_area_emitter_02);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_00400b.sound'), OBJECTS.banshee_area_emitter_01);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_VO_SCR_W1StationAssault_UN_ARGENTMOONPA_03200b.sound'), OBJECTS.banshee_small_room_01);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_VO_SCR_W1StationAssault_UN_ARGENTMOONPA_03200b.sound'), OBJECTS.banshee_small_room_02);

		
		sleep_s(4);
		
		if activator == SPARTANS.chief and w4_flight_vent_count == 1 then


			NarrativeQueue.QueueConversation(W1StationAssault_Reactor_docking__ENGAGE_CLAMP_ONE_chief);
			
		elseif activator == SPARTANS.linda and w4_flight_vent_count == 1 then
			
			NarrativeQueue.QueueConversation(W1StationAssault_Reactor_docking__ENGAGE_CLAMP_ONE_linda);

		elseif activator == SPARTANS.kelly and w4_flight_vent_count == 1 then
			NarrativeQueue.QueueConversation(W1StationAssault_Reactor_docking__ENGAGE_CLAMP_ONE_kelly);
		elseif activator == SPARTANS.fred and w4_flight_vent_count == 1 then
			NarrativeQueue.QueueConversation(W1StationAssault_Reactor_docking__ENGAGE_CLAMP_ONE_fred);
		end
		
end

global W1StationAssault_Reactor_docking__ENGAGE_CLAMP_ONE_chief = {
	name = "W1StationAssault_Reactor_docking__ENGAGE_CLAMP_ONE_chief",

	
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

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Override activated.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_06600.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_01100.sound'), OBJECTS.banshee_area_emitter_02);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_01100b'), OBJECTS.banshee_area_emitter_01);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_01100b'), OBJECTS.banshee_small_room_01);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_01100b'), OBJECTS.banshee_small_room_02);
				return 2; -- GAMMA_NEXT_LINE_NUMBER
			end,
		

		},
		[2] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			sleepBefore = 5,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Perfect. Coolant system inner workings are exposed. Marking targets.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_08600.sound'),
		},
		[3] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Eliminate the targets, Blue Team. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_06700.sound'),
		},
		[4] = {
	

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: kelly
			text = "Grab banshees. We can target the pipes more easily from the air.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_05600.sound'),


		},
--           Phaetons and reinforcements swoop in.

		[5] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "The armada's been alerted to our presence. Reinforcements inbound. They're sending  phantoms.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_05200.sound'),
		},
--           UITEXT: INITIATE REACTOR EXPLOSION
-- 
--           
--                     
-- 
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		CreateThread(nar_ass_coolanttakeout_nudge);
	end,

	localVariables = {},
};

global W1StationAssault_Reactor_docking__ENGAGE_CLAMP_ONE_kelly = {
	name = "W1StationAssault_Reactor_docking__ENGAGE_CLAMP_ONE_kelly",


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

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "Override activated.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_05500.sound'),

				AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_01100.sound'), OBJECTS.banshee_area_emitter_02);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_01100b'), OBJECTS.banshee_area_emitter_01);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_01100b'), OBJECTS.banshee_small_room_01);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_01100b'), OBJECTS.banshee_small_room_02);
				return 2; -- GAMMA_NEXT_LINE_NUMBER
			end,
		
		},
		
		[2] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			sleepBefore = 5,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Perfect. Coolant system inner workings are exposed. Marking targets.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_08600.sound'),
		},
		[3] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Eliminate the targets, Blue Team. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_06700.sound'),
		},
		[4] = {
	

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: kelly
			text = "Grab banshees. We can target the pipes more easily from the air.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_05600.sound'),

	
		},
--           Phaetons and reinforcements swoop in.

		[5] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "The armada's been alerted to our presence. Reinforcements inbound. They're sending  phantoms.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_05200.sound'),
		},
--           UITEXT: INITIATE REACTOR EXPLOSION
-- 
--           
--                     
-- 
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
				CreateThread(nar_ass_coolanttakeout_nudge);
	end,

};

global W1StationAssault_Reactor_docking__ENGAGE_CLAMP_ONE_linda = {
	name = "W1StationAssault_Reactor_docking__ENGAGE_CLAMP_ONE_linda",


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

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LINDA
			text = "Override activated.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_05200.sound'),
				AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_01100.sound'), OBJECTS.banshee_area_emitter_02);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_01100b'), OBJECTS.banshee_area_emitter_01);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_01100b'), OBJECTS.banshee_small_room_01);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_01100b'), OBJECTS.banshee_small_room_02);
				return 2; -- GAMMA_NEXT_LINE_NUMBER
			end,
		
		
		},
		
		[2] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			sleepBefore = 5,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Perfect. Coolant system inner workings are exposed. Marking targets.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_08600.sound'),
		},
		[3] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Eliminate the targets, Blue Team. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_06700.sound'),
		},
		[4] = {
		

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: kelly
			text = "Grab banshees. We can target the pipes more easily from the air.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_05600.sound'),

			
		},
--           Phaetons and reinforcements swoop in.

		[5] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "The armada's been alerted to our presence. Reinforcements inbound. They're sending  phantoms.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_05200.sound'),
		},
--           UITEXT: INITIATE REACTOR EXPLOSION
-- 
--           
--                     
-- 
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
				CreateThread(nar_ass_coolanttakeout_nudge);
	end,

};

global W1StationAssault_Reactor_docking__ENGAGE_CLAMP_ONE_fred = {
	name = "W1StationAssault_Reactor_docking__ENGAGE_CLAMP_ONE_fred",


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

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Override activated.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_05700.sound'),
				AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_01100.sound'), OBJECTS.banshee_area_emitter_02);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_01100b'), OBJECTS.banshee_area_emitter_01);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_01100b'), OBJECTS.banshee_small_room_01);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_01100b'), OBJECTS.banshee_small_room_02);
				return 2; -- GAMMA_NEXT_LINE_NUMBER
			end,
		
			
		},
		[2] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			sleepBefore = 5,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Perfect. Coolant system inner workings are exposed. Marking targets.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_08600.sound'),
		},
		[3] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Eliminate the targets, Blue Team. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_06700.sound'),
		},
		[4] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: kelly
			text = "Grab banshees. We can target the pipes more easily from the air.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_05600.sound'),

		
		},
--           Phaetons and reinforcements swoop in.

		[5] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "The armada's been alerted to our presence. Reinforcements inbound. They're sending  phantoms.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_05200.sound'),
		},
--           UITEXT: INITIATE REACTOR EXPLOSION
-- 
--           
--                     
-- 
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
				CreateThread(nar_ass_coolanttakeout_nudge);
	end,

	localVariables = {},
};

function nar_ass_shutter2_listener()
	
       SleepUntil([| object_valid( "dc_banshee_vent_2" ) ], 60);
	   PrintNarrative("LISTENER - nar_ass_shutter2_listener THREADED");
       SleepUntil([| device_get_power( OBJECTS.dc_banshee_vent_2) == 1 or b_flight_end], 60);


			if not b_flight_end then
       PrintNarrative("LISTENER - nar_ass_shutter2_listener");

       CreateThread(RegisterInteractEvent, nar_ass_shutter2_launcher, OBJECTS.dc_banshee_vent_2);
			end

end

function nar_ass_shutter2_launcher(trigger:object, activator:object)

       PrintNarrative("LAUNCHER - nar_ass_shutter2_launcher");

       print(activator, " is the activator of ", trigger);

       CreateThread(UnregisterInteractEvent, nar_ass_shutter2_launcher, OBJECTS.dc_banshee_vent_2);

       CreateThread(nar_ass_shutter2_access, activator)
end


function nar_ass_shutter2_access(activator:object)
		b_nar_ass_shutters_nudge = true;
		sleep_s(2);
				PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_00400.sound'), OBJECTS.banshee_area_emitter_02);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_00400b.sound'), OBJECTS.banshee_area_emitter_01);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_VO_SCR_W1StationAssault_UN_ARGENTMOONPA_03200b.sound'), OBJECTS.banshee_small_room_01);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_VO_SCR_W1StationAssault_UN_ARGENTMOONPA_03200b.sound'), OBJECTS.banshee_small_room_02);

		
		sleep_s(3);
	
		if activator == SPARTANS.chief and w4_flight_vent_count == 1 then


			NarrativeQueue.QueueConversation(W1StationAssault_Reactor_docking__ENGAGE_CLAMP_ONE_chief);
			
		elseif activator == SPARTANS.linda and w4_flight_vent_count == 1 then
			
			NarrativeQueue.QueueConversation(W1StationAssault_Reactor_docking__ENGAGE_CLAMP_ONE_linda);

		elseif activator == SPARTANS.kelly and w4_flight_vent_count == 1 then
			NarrativeQueue.QueueConversation(W1StationAssault_Reactor_docking__ENGAGE_CLAMP_ONE_kelly);
		elseif activator == SPARTANS.fred and w4_flight_vent_count == 1 then
			NarrativeQueue.QueueConversation(W1StationAssault_Reactor_docking__ENGAGE_CLAMP_ONE_fred);
		end
		
end







global W1StationAssault_REACTOR_DOCKING__EXPLODE_ONE_TARGET = {
	name = "W1StationAssault_REACTOR_DOCKING__EXPLODE_ONE_TARGET",

	CanStart = function (thisConvo, queue)
		return  w4_flight_engine_dead_count == 2 ; -- GAMMA_CONDITION
	end,

	sleepBefore = 2,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_00500.sound'), OBJECTS.banshee_area_emitter_01);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_00500b.sound'), OBJECTS.banshee_area_emitter_02);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_00500b.sound'), OBJECTS.banshee_small_room_01);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_00500b.sound'), OBJECTS.banshee_small_room_02);
	end,

	lines = {

		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.fred) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
                 
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			sleepBefore = 2.5,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "It's working. Keep firing!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_05000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
					ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.linda) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
                 
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			sleepBefore = 3.5,
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: linda
			text = "It's working. Keep firing!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_04200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.kelly) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
                 
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			sleepBefore = 3.5,
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "It's working. Keep firing!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_05200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.chief) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
                 
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			sleepBefore = 3.5,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: masterchief
			text = "It's working. Keep firing!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_05900.sound'),

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



function nar_ass_reactor_blasted()
b_nar_ass_coolanttakeout_nudge = true;
	NarrativeQueue.QueueConversation(W1StationAssault_REACTOR_DOCKING__COOLANT_SHOTS);
	sleep_s(10);
	CreateThread(nar_ass_enterhangarnudge);
	CreateThread(audio_cooling_system_alarm);
	
end

global W1StationAssault_REACTOR_DOCKING__COOLANT_SHOTS = {
	name = "W1StationAssault_REACTOR_DOCKING__COOLANT_SHOTS",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_00600.sound'), OBJECTS.banshee_area_emitter_01);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_00600b.sound'), OBJECTS.banshee_area_emitter_02);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_00600b.sound'), OBJECTS.banshee_small_room_01);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_00600b.sound'), OBJECTS.banshee_small_room_02);
	end,

	lines = {

		[1] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			sleepBefore = 6,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: masterCHIEF
			text = "Blue Team, immediate evac.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_04100.sound'),
		},
		[2] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Banshees aren't fast enough to get clear of the reactor explosion.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_08700.sound'),
		},
		[3] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: KELLY
			text = "Calling in the pelican.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_04500.sound'),
		},
		[4] = {
			sleepBefore = 2.5,
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "No signal on autopilot retrieval. Armada must have taken it out.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_08200.sound'),
		},
		[5] = {
		                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
						RunClientScript("pip_assault_argentmoon_prowlerlocation_60");
                     end,

                     moniker = "MasterChief",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Fredric, mark a path to the nearest hangar bay. We're taking a prowler. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_04200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		CreateThread( f_flight_mark_hangar_entrance )
		NarrativeQueue.QueueConversation(W1StationAssault_UITEXT__USE_PROWLER_TO_EVACUATE_SHIP);
	end,

	localVariables = {},
};

function nar_ass_shutters_nudge()
	sleep_s(90);
	if b_nar_ass_shutters_nudge == false then
			NarrativeQueue.QueueConversation(W1StationAssault_REACTOR_DOCKING__NUDGE_TOWARD_COTNROLS);
	end
end

global W1StationAssault_REACTOR_DOCKING__NUDGE_TOWARD_COTNROLS = {
	name = "W1StationAssault_REACTOR_DOCKING__NUDGE_TOWARD_COTNROLS",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return b_nar_ass_shutters_nudge == false and (unit_get_health( SPARTANS.fred) > 0); -- GAMMA_TRANSITION: If chief
			end,


                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Shades are still closed on those coolant pipes. Find a way to open them.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_10100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return b_nar_ass_shutters_nudge == false and (unit_get_health( SPARTANS.linda) > 0); -- GAMMA_TRANSITION: If chief
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LINDA
			text = "Shades are still closed on those coolant pipes. Find a way to open them.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_07100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return b_nar_ass_shutters_nudge == false and (unit_get_health( SPARTANS.kelly) > 0); -- GAMMA_TRANSITION: If chief
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "Shades are still closed on those coolant pipes. Find a way to open them.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_08000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return b_nar_ass_shutters_nudge == false and (unit_get_health( SPARTANS.chief) > 0); -- GAMMA_TRANSITION: If chief
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Shades are still closed on those coolant pipes. Find a way to open them.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_08700.sound'),

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

};

function nar_ass_coolanttakeout_nudge()
	sleep_s(90);
	if b_nar_ass_coolanttakeout_nudge == false then
		NarrativeQueue.QueueConversation(W1StationAssault_REACTOR_DOCKING__SHOOT_EM_NUDGE);
	end
end

global W1StationAssault_REACTOR_DOCKING__SHOOT_EM_NUDGE = {
	name = "W1StationAssault_REACTOR_DOCKING__SHOOT_EM_NUDGE",

	

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.fred) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
                 
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Keep firing on those coolant pipes!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_10200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.linda) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
                 
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: linda
			text = "Keep firing on those coolant pipes!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_07200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
				ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.kelly) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
                 
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "Keep firing on those coolant pipes!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_08100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.chief) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
                 
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: masterchief
			text = "Keep firing on those coolant pipes!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_08800.sound'),

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

function nar_ass_enterhangarnudge()
	sleep_s(30);
	if b_nar_ass_enterhangarnudge_nudge == false then
	SleepUntil( [| b_collectible_used == false ], 1);
		NarrativeQueue.QueueConversation(W1StationAssault_REACTOR_DOCKING__MOVE_TO_HANGAR_NUDGE);
	end
end

global W1StationAssault_REACTOR_DOCKING__MOVE_TO_HANGAR_NUDGE = {
	name = "W1StationAssault_REACTOR_DOCKING__MOVE_TO_HANGAR_NUDGE",

	

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

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MASTERCHIEF
			text = "This station is about to be slag. Move to the prowler.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_08900.sound'),
		},
--                                                   CUT TO:
--           __________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


global W1StationAssault_UITEXT__USE_PROWLER_TO_EVACUATE_SHIP = {
	name = "W1StationAssault_UITEXT__USE_PROWLER_TO_EVACUATE_SHIP",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_ass_reactor_landed); -- GAMMA_CONDITION
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
				return volume_test_object(VOLUMES.nar_ass_reactor_landed, SPARTANS.linda); -- GAMMA_TRANSITION: If linda
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Linda
			text = "Hangar entrance here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_06200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_reactor_landed, SPARTANS.chief); -- GAMMA_TRANSITION: If masterchief
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Hangar entrance here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_08100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_reactor_landed, SPARTANS.kelly); -- GAMMA_TRANSITION: If kellY
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "Hangar entrance here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_07000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_reactor_landed, SPARTANS.fred); -- GAMMA_TRANSITION: IF FREDRIC
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Hangar entrance here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_08800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)

				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
					 sleepBefore = 1,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Prowler is just inside, through an airlock.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_10300.sound'),

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

-- =================================================================================================
--
--					HANGAR SECTION
--
-- Covers content on the hangar section.
--
-- =================================================================================================

global W1StationAssault_Hangar_transition__airlock = {
	name = "W1StationAssault_Hangar_transition__airlock",

	

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

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "Chief, a Prowler gets us to Meridian pretty quick.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_04600.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
		},
--           A major explosion rocks the ship, causing everyone to
--           stumble.

		[2] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "We'll talk about this when we are clear of the station.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_04400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		
	end,

	localVariables = {},
};

function nar_ass_airlock()
	SleepUntil( [| volume_test_players(VOLUMES.nar_ass_hangar_enter) ],1);
	b_nar_ass_enterhangarnudge_nudge = true;
	
	CreateThread(assault_idle_chatter_off);
	NarrativeQueue.EndConversationEarly(W1HubassaultReports_team_chatter_1);
	NarrativeQueue.EndConversationEarly(W1HubassaultReports_team_chatter_2);
	sleep_s(5);
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_00700.sound'), OBJECTS.vo_emitter_zs_05_left);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_00700b.sound'), OBJECTS.vo_emitter_zs_05_right);
end

global W1StationAssault_HANGAR__COMBAT_START = {
	name = "W1StationAssault_HANGAR__COMBAT_START",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_ass_airlock ) ; -- GAMMA_CONDITION
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
				return volume_test_object(VOLUMES.nar_ass_airlock2, SPARTANS.fred); -- GAMMA_TRANSITION: If FREDRIC
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: Fredric
			text = "There's the prowler.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_10400.sound'),
			sleepAfter = 1,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_airlock2, SPARTANS.linda); -- GAMMA_TRANSITION: If FREDRIC
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			sleepAfter = 1,
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LINDA
			text = "There's the prowler.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_07300.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},

		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_airlock2, SPARTANS.kelly); -- GAMMA_TRANSITION: If FREDRIC
			end,
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,
			sleepAfter = 1,
                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: KELLY
			text = "There's the prowler.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_08300.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},

		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_airlock2, SPARTANS.chief); -- GAMMA_TRANSITION: If FREDRIC
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,
					sleepAfter = 1,
                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: masterchief
			text = "There's the prowler.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_09000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_airlock2, SPARTANS.linda); -- GAMMA_TRANSITION: If FREDRIC
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
	
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LINDA
			text = "But the hangar's full of Covenant.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_03800.sound'),
			
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[6] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_airlock2, SPARTANS.kelly); -- GAMMA_TRANSITION: If FREDRIC
			end,
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,
	
                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "But the hangar's full of Covenant.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_04800.sound'),
				AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[7] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_airlock2, SPARTANS.fred); -- GAMMA_TRANSITION: If FREDRIC
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "But the hangar's full of Covenant.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_04600.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[8] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_airlock2, SPARTANS.chief); -- GAMMA_TRANSITION: If FREDRIC
			end,
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Hangar's full of Covenant.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_04500.sound'),
		},
--           After:

		[9] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			sleepBefore = 1.5,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Clear them out and prep the prowler for launch.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_08200.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[10] = {
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "And do it quick. I'd rather not be here when the station melts around us.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_08900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		
	CreateThread(nar_ass_announcement_01);
	CreateThread(nar_ass_announcement_02);
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

function nar_ass_hangar_entrance_announce()
SleepUntil( [| volume_test_players(VOLUMES.approaching_hangar_entrance) ],1);

		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_03100.sound'), OBJECTS.vo_emitter_zs_05_left);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_03100b.sound'), OBJECTS.vo_emitter_zs_05_right);
end

function w1_nar_elite_hangar()

	SleepUntil([| object_index_valid( AI.sq_hangar_zealots.dark )], 1);
	SleepUntil([| objects_distance_to_object(players_human(),ai_get_object(AI.sq_hangar_zealots.dark )) < 5 ], 1);
NarrativeQueue.QueueConversation(W1StationAssault_Hangar__PROWLER_LAUNCH_start2);
end	
global W1StationAssault_Hangar__PROWLER_LAUNCH_start2 = {
	name = "W1StationAssault_Hangar__PROWLER_LAUNCH_start2",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
	[1] = {
			character = AI.sq_hangar_zealots.dark, -- GAMMA_CHARACTER: Elite01
			text = "The Demon and his broodmates!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_cv_elite01_00300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};



function nar_ass_launch_startit()

NarrativeQueue.QueueConversation(W1StationAssault_Hangar__PROWLER_LAUNCH_start);
	
	NarrativeQueue.QueueConversation(W1StationAssault_Hangar__PROWLER_approach);
	CreateThread(nar_ass_launch_control_used);
end

global W1StationAssault_Hangar__PROWLER_LAUNCH_start = {
	name = "W1StationAssault_Hangar__PROWLER_LAUNCH_start",


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

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Linda
			text = "Marking the Prowler's control panel.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_07400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	
		hud_hide_radio_transmission_hud();
	end,

};



global W1StationAssault_Hangar__PROWLER_approach= {
	name = "W1StationAssault_Hangar__PROWLER_approach",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_ass_launch_approach ); -- GAMMA_CONDITION
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
				return volume_test_object(VOLUMES.nar_ass_launch_approach, SPARTANS.fred); -- GAMMA_TRANSITION: If FREDRIC
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: Fredric
			text = "Launch controls are here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_10500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_launch_approach, SPARTANS.linda); -- GAMMA_TRANSITION: If LINDA
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LINDA
			text = "Launch controls are here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_07500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_launch_approach, SPARTANS.kelly); -- GAMMA_TRANSITION: If kelly
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: KELLY
			text = "Launch controls are here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_08400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_ass_launch_approach, SPARTANS.chief); -- GAMMA_TRANSITION: If masterchief
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: masterchief
			text = "Launch controls are here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_09100.sound'),

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

function nar_ass_launch_control_used()
		
	SleepUntil([| object_valid("hum_keypad_generator") ], 1);
		SleepUntil([|  device_get_position  (OBJECTS.hum_keypad_generator) >= 0.2 ] , 1 );	
		prowler_launch_started = true;
		sleep_s(1);
		NarrativeQueue.QueueConversation(W1StationAssault_HANGAR_console_used);
end

global W1StationAssault_HANGAR_console_used = {
	name = "W1StationAssault_HANGAR_console_used",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_01600.sound'), OBJECTS.vo_emitter_zs_05_left);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_01600b.sound'), OBJECTS.vo_emitter_zs_05_right);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.fred) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			sleepBefore = 7,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "Hold off the Covenant while the Prowler preps for launch. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_10600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.chief) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			sleepBefore = 6,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Hold off the Covenant while the Prowler preps for launch. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_09200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.kelly) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,	
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			sleepBefore = 6,
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: kelly
			text = "Hold off the Covenant while the Prowler preps for launch. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_08500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.linda) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			sleepBefore = 6,
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LINDA
			text = "Hold off the Covenant while the Prowler preps for launch. \r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_07600.sound'),

		
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

function nar_ass_announcement_01()
sleep_s(120);
		if station_pa_line_playing == false then
			PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_00800.sound'), OBJECTS.vo_emitter_zs_05_left);
			PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_00800b.sound'), OBJECTS.vo_emitter_zs_05_right);
			
		else
		sleep_s(10);
			PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_00800.sound'), OBJECTS.vo_emitter_zs_05_left);
			PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_00800b.sound'), OBJECTS.vo_emitter_zs_05_right);
			
		end
end

function nar_ass_announcement_02()
	sleep_s(300);
		if station_pa_line_playing == false then
			PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_00900.sound'), OBJECTS.vo_emitter_zs_05_left);
			PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_00900b.sound'), OBJECTS.vo_emitter_zs_05_right);
			
		else
		sleep_s(10);
			PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_00900.sound'), OBJECTS.vo_emitter_zs_05_left);
			PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_00900b.sound'), OBJECTS.vo_emitter_zs_05_right);
		end
		
end


function nar_ass_fuel_announcements()
	if prowler_launch_started == true then
		if hangar_progress == 1 then
			sleep_s(20);
			station_pa_line_playing = true;
			PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_01700.sound'), OBJECTS.vo_emitter_zs_05_left);
			PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_01700b.sound'), OBJECTS.vo_emitter_zs_05_right);
			
			hangar_progress = 2;
			sleep_s(5);
			station_pa_line_playing = false;
		elseif hangar_progress == 2 then
			PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_01800.sound'), OBJECTS.vo_emitter_zs_05_left);
			PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_01800b.sound'), OBJECTS.vo_emitter_zs_05_right);
		
			station_pa_line_playing = true;
			hangar_progress = 3;
			sleep_s(5);
			station_pa_line_playing = false;
		elseif hangar_progress == 3 then
		station_pa_line_playing = true;
			PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_01900.sound'), OBJECTS.vo_emitter_zs_05_left);
			PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_01900b.sound'), OBJECTS.vo_emitter_zs_05_right);
			CreateThread(audio_prowlerbaseair_intense);
		sleep_s(5);
		station_pa_line_playing = false;
		end
	end
end

function nar_ass_hangar_hunters()
		
		sleep_s(4);
		NarrativeQueue.QueueConversation(W1StationAssault_HANGAR__WAVE_UPDATE_VO);
		

	
end

function nar_ass_hunters_dead2()
		
	sleep_s(2);
		NarrativeQueue.QueueConversation(W1StationAssault_HANGAR__WAVE_UPDATE_VO2);
	
	
end

function nar_ass_hangar_reinforcements()
		
		sleep_s(2);
--	NarrativeQueue.QueueConversation(W1StationAssault_HANGAR__WAVE_UPDATE_VO2);

	
end
global W1StationAssault_HANGAR__WAVE_UPDATE_VO = {
	name = "W1StationAssault_HANGAR__WAVE_UPDATE_VO",
	
		CanStart = function (thisConvo, queue)
		return objects_can_see_object( players_human(), ai_get_object(AI.sq_hangar_hunters.jumpster), 6 ) or objects_can_see_object( players_human(), ai_get_object(AI.sq_hangar_hunters.shafty), 6 ); -- GAMMA_CONDITION
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
				return objects_can_see_object( SPARTANS.kelly, ai_get_object(AI.sq_hangar_hunters.jumpster), 6 ) or objects_can_see_object( SPARTANS.kelly, ai_get_object(AI.sq_hangar_hunters.shafty), 6 ); -- GAMMA_TRANSITION: IF LOCKE WITNESSES
			end,

			--If = function (thisLine, thisConvo, queue, lineNumber)
			--	return (unit_get_health( SPARTANS.kelly) > 0); -- GAMMA_TRANSITION: If FREDRIC
			--end,
                 

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: KELLY
			text = "More Hunters! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_08700.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return objects_can_see_object( SPARTANS.linda, ai_get_object(AI.sq_hangar_hunters.jumpster), 6 ) or objects_can_see_object( SPARTANS.linda, ai_get_object(AI.sq_hangar_hunters.shafty), 6 ); -- GAMMA_TRANSITION: IF LOCKE WITNESSES
			end,
                 
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LINDA
			text = "More Hunters! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_07900.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},
		[3] = {
		--	ElseIf = function (thisLine, thisConvo, queue, lineNumber)
		--		return (unit_get_health( SPARTANS.fred) > 0); -- GAMMA_TRANSITION: If FREDRIC
		--	end,
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return objects_can_see_object( SPARTANS.fred, ai_get_object(AI.sq_hangar_hunters.jumpster), 6 ) or objects_can_see_object( SPARTANS.fred, ai_get_object(AI.sq_hangar_hunters.shafty), 6 ); -- GAMMA_TRANSITION: IF LOCKE WITNESSES
			end,
                 
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: fredric
			text = "More Hunters! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_10800.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		},

		[4] = {
		--	ElseIf = function (thisLine, thisConvo, queue, lineNumber)
		--		return (unit_get_health( SPARTANS.chief) > 0); -- GAMMA_TRANSITION: If FREDRIC
		--	end,
        	ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return objects_can_see_object( SPARTANS.chief, ai_get_object(AI.sq_hangar_hunters.jumpster), 6 ) or objects_can_see_object( SPARTANS.chief, ai_get_object(AI.sq_hangar_hunters.shafty), 6 ); -- GAMMA_TRANSITION: IF LOCKE WITNESSES
			end,         		
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "More Hunters! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_09500.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,

		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		--NarrativeQueue.QueueConversation(W1StationAssault_HANGAR__WAVE_UPDATE_more);
	end,

	localVariables = {},
};

global W1StationAssault_HANGAR__WAVE_UPDATE_more = {
	name = "W1StationAssault_HANGAR__WAVE_UPDATE_more",
	
	CanStart = function (thisConvo, queue) -- BOOLEAN
	return b_hangar_extra_hunters_active == true;
	
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
			If = function (thisLine, thisConvo, queue, lineNumber)
				return b_hangar_extra_hunters_active == true; -- GAMMA_TRANSITION: If you left lab without killing all hunters and so more show up
				-- If kelly
			end,
							                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly", 
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly
			text = "We shouldn't have left them alive back in the lab.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_10300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return b_hangar_extra_hunters_active == true; -- GAMMA_TRANSITION: If FREDRIC
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "We shouldn't have left them alive back in the lab.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_13100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return b_hangar_extra_hunters_active == true; -- GAMMA_TRANSITION: If LINDA
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LINDA
			text = "We shouldn't have left them alive back in the lab.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_10300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return b_hangar_extra_hunters_active == true; -- GAMMA_TRANSITION: If masterchief
			end,
							                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief", 
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "We shouldn't have left them alive back in the lab.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_10900.sound'),

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
global W1StationAssault_HANGAR__WAVE_UPDATE_VO2 = {
	name = "W1StationAssault_HANGAR__WAVE_UPDATE_VO2",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.fred) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
                 
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: fredric
			text = "Covenant reinforcements inbound!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_10700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.kelly) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
                 
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: KELLY
			text = "Covenant reinforcements inbound!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_08600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},

		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.linda) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
                 
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: LINDA
			text = "Covenant reinforcements inbound!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_07800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},

		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return (unit_get_health( SPARTANS.chief) > 0); -- GAMMA_TRANSITION: If FREDRIC
			end,
                 	

	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Covenant reinforcements inbound!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_09400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};




function nar_ass_combat_complete()
	
	b_nar_ass_hangar_nudge = true;
	sleep_s(2);
		NarrativeQueue.QueueConversation(W1StationAssault_HANGAR_COMPLETE);
		CreateThread(audio_generator_stopfuel);
end
global W1StationAssault_HANGAR_COMPLETE = {
	name = "W1StationAssault_HANGAR_COMPLETE",

	
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_02000.sound'), OBJECTS.vo_emitter_zs_05_left);
			PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_argentmoonpa_02000b.sound'), OBJECTS.vo_emitter_zs_05_right);
	end,

	lines = {
		[1] = {
		sleepBefore = 6,

                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Linda
			text = "Prowler is ready.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_07700.sound'),

		},
		[2] = {
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "MasterChief",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: Masterchief
			text = "Board now, Blue Team.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_masterchief_09300.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


function nar_ass_hangar_nudge()
	sleep_s(180);
	if b_nar_ass_hangar_nudge == false then
		

	end
end





-- =================================================================================================
--
--					SECONDARY AUDIO LOGS
--
-- Audio Log Content	
--
-- =================================================================================================


-- =================================================================================================


function w1_assault_ship_audio()
--story_blurb_add("domain", "ELEVATOR THREADED");
	--SleepUntil([| object_valid("w1_assault_ship_audiolog") ], 1);
	--SleepUntil([|  device_get_position(OBJECTS.w1_assault_ship_audiolog) > 0 ], 1);
	
	--	story_blurb_add("domain", "ELEVATOR LOG HIT");
	--layDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_collectibles\001_vo_scr_collectibles_un_scientistfemale01_00100.sound'), OBJECTS.w1_assault_ship_audiolog);
		--NarrativeQueue.QueueConversation(Collectibles_Evacuation_AUDIO_LOG__CONSOLE_distress_call);
end

function w1_assault_stationlog_01()
	SleepUntil([| object_valid("w1_assault_stationlog_01") ], 1);
	SleepUntil([| device_get_position(OBJECTS.w1_assault_stationlog_01) > 0 ], 1);
	
		
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_collectibles\001_vo_scr_collectibles_un_assaultai_00100.sound'), OBJECTS.w1_assault_stationlog_01);
end

function w1_assault_stationlog_02()
	SleepUntil([| object_valid("w1_assault_stationlog_02") ], 1);
	SleepUntil([| device_get_position(OBJECTS.w1_assault_stationlog_02) > 0 ], 1);
	
		
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_collectibles\001_vo_scr_collectibles_un_assaultai_00200.sound'), OBJECTS.w1_assault_stationlog_02);
end

function w1_assaultunsc_datapad_01()
	
	SleepUntil([| object_valid("w1_assaultunsc_datapad_01") ], 1);
	SleepUntil([| device_get_position(OBJECTS.w1_assaultunsc_datapad_01) > 0 ], 1);
	
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_collectibles\001_vo_scr_collectibles_un_scientistfemale02_00100.sound'), OBJECTS.w1_assaultunsc_datapad_01);

	
end


--==========================================================================
--					HUD STUFF
--==========================================================================


function nar_switch_hud_to_chief()
	hud_hide_radio_transmission_hud();
		sleep_s(0.3);
	hud_show_radio_transmission_hud("chief_transmission_name");
end

function nar_switch_hud_to_kelly()
	hud_hide_radio_transmission_hud();
		sleep_s(0.3);
	hud_show_radio_transmission_hud("kelly_transmission_name");
end

function nar_switch_hud_to_fred()
	hud_hide_radio_transmission_hud();
		sleep_s(0.3);
	hud_show_radio_transmission_hud("fred_transmission_name");
end

function nar_switch_hud_to_linda()
	hud_hide_radio_transmission_hud();
	sleep_s(0.3);
	hud_show_radio_transmission_hud("linda_transmission_name");
end



--==========================================================================
--					CHATTER
--==========================================================================

function assault_idle_chatter_start()
b_assault_idle_chatter_on = true;
PrintNarrative("Enabled Idle Chatter");
	sleep_rand_s(45,65);
	SleepUntil([| b_collectible_used == false ], 1);
	if b_assault_idle_chatter_on and 
	(
	ai_combat_status(GetMusketeerSquad()) <= 2 and										--	SPARTANS ARE NOT IN COMBAT
	(object_get_shield( SPARTANS.chief) == 1 and object_get_shield( SPARTANS.fred) == 1 and object_get_shield( SPARTANS.linda) == 1 and object_get_shield( SPARTANS.kelly) == 1)
						) then 
		
	if b_assault_chatter_1_played == true and b_assault_chatter_2_played == false and b_assault_idle_chatter_on == true then
			
			
				NarrativeQueue.QueueConversation(W1HubassaultReports_team_chatter_2);
				b_assault_chatter_2_played = true;
			
		elseif b_assault_chatter_1_played == false and b_assault_idle_chatter_on == true then

		NarrativeQueue.QueueConversation(W1HubassaultReports_team_chatter_1);
			b_assault_chatter_1_played = true;
		end
	end
end


function assault_idle_chatter_off()
	
	PrintNarrative("Killed Idle Chatter");

	b_assault_idle_chatter_on = false;			
	NarrativeQueue.EndConversationEarly(W1HubassaultReports_team_chatter_1);
		NarrativeQueue.EndConversationEarly(W1HubassaultReports_team_chatter_2);
end

global W1HubassaultReports_team_chatter_2 = {
	name = "W1HubassaultReports_team_chatter_2",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (self, queue, lineNumber) -- BOOLEAN
				return b_assault_idle_chatter_on == true and b_collectible_used == false;
			end,
						                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly", 
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: kelly
			text = "The Covenant seem particularly disorganized lately. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_09900.sound'),
		},
		[2] = {
			If = function (self, queue, lineNumber) -- BOOLEAN
				return b_assault_idle_chatter_on == true and b_collectible_used == false;
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: Fredric
			text = "They're falling apart.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_12600.sound'),
		},
		[3] = {
			If = function (self, queue, lineNumber) -- BOOLEAN
				return b_assault_idle_chatter_on == true and b_collectible_used == false;
			end,
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Linda
			text = "Finally.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_10000.sound'),
		},
		[4] = {
			If = function (self, queue, lineNumber) -- BOOLEAN
				return b_assault_idle_chatter_on == true and b_collectible_used == false;
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			sleepBefore = 1,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "It would be a little weird, wouldn't it? Not to be fighting them, after all these years.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_12700.sound'),
		},
		[5] = {
			If = function (self, queue, lineNumber) -- BOOLEAN
				return b_assault_idle_chatter_on == true and b_collectible_used == false;
			end,
							                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Kelly", 
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly
			text = "I wouldn't miss it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_kelly_10000.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
				hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global W1HubassaultReports_team_chatter_1 = {
	name = "W1HubassaultReports_team_chatter_1",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (self, queue, lineNumber) -- BOOLEAN
				return b_assault_idle_chatter_on == true and b_collectible_used == false;
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: FREDRIC
			text = "So this station was just drifting? For two years?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_12300.sound'),
		},
		[2] = {
			If = function (self, queue, lineNumber) -- BOOLEAN
				return b_assault_idle_chatter_on == true and b_collectible_used == false;
			end,
	                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LINDA
			text = "Apparently.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_09700.sound'),
		},
		[3] = {
			If = function (self, queue, lineNumber) -- BOOLEAN
				return b_assault_idle_chatter_on == true and b_collectible_used == false;
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: Fredric
			text = "How's an asset this big go missing for that long?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_12400.sound'),
		},
		[4] = {
			If = function (self, queue, lineNumber) -- BOOLEAN
				return b_assault_idle_chatter_on == true and b_collectible_used == false;
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Linda
			text = "Its location was not consistent with expected drift patterns. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_09800.sound'),
		},
		[5] = {
			If = function (self, queue, lineNumber) -- BOOLEAN
				return b_assault_idle_chatter_on == true and b_collectible_used == false;
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Fred",
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: Fredric
			text = "Meaning?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_fredric_12500.sound'),
		},
		[6] = {
			If = function (self, queue, lineNumber) -- BOOLEAN
				return b_assault_idle_chatter_on == true and b_collectible_used == false;
			end,
                     OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
                     end,

                     moniker = "Linda",
			
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Linda
			text = "Someone didn't want it to be found and sent it in a direction no one would expect.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1stationassault\001_vo_scr_w1stationassault_un_linda_09900.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
				hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

function nar_assault_collectible_listener()
SleepUntil([| b_collectible_used == true ], 1);

story_blurb_add("vo", "collectible on");
end

--## CLIENT


function remoteClient.nar_test_bink1()
	
	hud_play_pip_from_tag(TAG('ui\wpf\gltest\test.bink'));
end

function remoteClient.nar_test_bink2()

	hud_play_pip_from_tag(TAG('bink\campaign\h5_pip_proxy_60.bink'));
end

function remoteClient.pip_assault_argentmoon_schematics_60()

	hud_play_pip_from_tag(TAG('bink\campaign\pip_assault_argentmoon_schematics_60.bink'));
end


function remoteClient.pip_assault_argentmoon_reactorlocation_60()

	hud_play_pip_from_tag(TAG('bink\campaign\pip_assault_argentmoon_reactorlocation_60.bink'));
end


function remoteClient.pip_assault_argentmoon_prowlerlocation_60()

	hud_play_pip_from_tag(TAG('bink\campaign\pip_assault_argentmoon_prowlerlocation_60.bink'));
end

function remoteClient.pip_assault_argentmoon_lifeforms_60()

	hud_play_pip_from_tag(TAG('bink\campaign\pip_assault_argentmoon_lifeforms_60.bink'));
end


function remoteClient.pip_genereic_radio_intercept_60()

	hud_play_pip_from_tag(TAG('bink\campaign\pip_genereic_radio_intercept_60.bink'));
end

function remoteClient.pip_assault_argentmoon_controlroom_60()

	hud_play_pip_from_tag(TAG('bink\campaign\pip_assault_argentmoon_controlroom_60.bink'));
end





