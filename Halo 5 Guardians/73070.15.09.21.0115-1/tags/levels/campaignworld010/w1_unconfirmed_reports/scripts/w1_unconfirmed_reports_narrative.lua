--## SERVER

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ WORLD 01 NARRATIVE - UNCONFIRMED REPORTS *_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*

-- =================================================================================================
-- =================================================================================================b
-- =================================================================================================
-- *** GLOBALS ***
-- =================================================================================================		
global shut_down_chatter:boolean=false;
global b_mystery_solved:boolean=false;
global n_tracking_chatter_timer:number=30;
global all_clues_viewed:boolean=false;
global combat_evidence_1_found:boolean=false;
global osiris_movie_on:boolean=false;
global drill_line_fired:boolean=false;
global sniper_battle_complete:boolean=false;
global outpost_battle_complete:boolean=false;
global prowler_battle_complete:boolean=false;
global prowler_ready_to_scan:boolean=false;
global upper_mine_battle_complete:boolean=false;
global warden_combat_complete:boolean=false;
global b_forerunner_door_entered:boolean=false;
global prowler_door_open:boolean=false;
global prowler_door_blip:boolean=false;
global b_prowler_examine:boolean=false;
global b_passed_into_mine:boolean=false;
global b_passed_into_warden:boolean=false;
global prowler_data_complete:boolean=false;
global b_prowler_advance:boolean=false;
global b_passed_into_sniper:boolean=false;
global b_unconfirmed_chatter_1_played:boolean = false;
global b_unconfirmed_chatter_2_played:boolean = false;
global b_unconfirmed_chatter_3_played:boolean = false;
global b_unconfirmed_chatter_4_played:boolean = false;
global b_unconfirmed_chatter_5_played:boolean = false;
global b_unconfirmed_chatter_6_played:boolean = false;
global b_unconfirmed_idle_chatter_on:boolean = false;
global prowler_line_triggered:boolean=false;
global b_miner_online_line:boolean=false;
global b_sniper_miner_hit:boolean=false;
global b_moved_into_structure:boolean=false;
global locke_warden_line_played:boolean=false;
global vale_warden_line_played:boolean=false;
global tanaka_warden_line_played:boolean=false;
global buck_warden_line_played:boolean=false;
global prowler_pinged:boolean=false;
global b_used_console:boolean=false;
global b_mine_complete:boolean=false;
global b_unconfirmed_complete:boolean=false;
global b_ur_warden_chatter_done:boolean=false;
global b_lava_elevator_used:boolean=false;

------------------------
-- DEBUG
------------------------

global keepDebuggingPlayerExists = false;

function TestPlayerObjectsExist()
	local foundMissingPlayer = false;

	keepDebuggingPlayerExists = true;

	while (keepDebuggingPlayerExists) do
		local deadString = "";

		if (not SPARTANS.locke) then
			deadString = deadString .. "LOCKE ";
			foundMissingPlayer = true;
		end

		if (not SPARTANS.buck) then
			deadString = deadString .. "BUCK ";
			foundMissingPlayer = true;
		end

		if (not SPARTANS.vale) then
			deadString = deadString .. "VALE ";
			foundMissingPlayer = true;
		end

		if (not SPARTANS.tanaka) then
			deadString = deadString .. "TANAKA ";
			foundMissingPlayer = true;
		end

		if (foundMissingPlayer) then
			keepDebuggingPlayerExists = false;
			foundMissingPlayer = false;
			print("ERROR : The following characters do not exist this frame - ", deadString);
			error("ERROR : The following characters do not exist this frame - " .. deadString);
		end

		Sleep(1);
	end
end

--/////////////////////////////////////////////////////////////////////////////////
-- MAIN
--/////////////////////////////////////////////////////////////////////////////////
function w1_unconfirmed_nar_startup():void
 	print("::: UNCONFIRMED REPORTS NARRATIVE START :::");
	CreateThread(nar_unconfirmed_cavalier_room);
--CreateThread(nar_unconfirmed_upper_mines);
	CreateThread(nar_unconfirmed_lava_lift);
	CreateThread(nar_unconfirmed_mining_base);

	--	SET THE DISPLAY OF TEMP BLURB ON	
	dialog_line_temp_blurb_force_set(true);
	b_temp_line_display_blurb = true;
end
 
-- =================================================================================================
-- =================================================================================================
-- =================================================================================================
--
--					MINING TOWN
--
-- Covers content in the mining town.
--
-- =================================================================================================
function nar_unconfirmed_mining_town()

end

-- =================================================================================================

-- =================================================================================================
-- =================================================================================================
-- =================================================================================================
--
--					LANDING
--
-- Covers content near Unconfirmed Landing.
--
-- =================================================================================================
function nar_unconfirmed_mining_base()
	--CreateThread(nar_ics_vo);
	CreateThread(nar_levelstart_vo);

	NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_BATTLE_ENTER);
	NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_GLASSLANDS__BUILDING_combat_complete);
	CreateThread(nar_hill_chatter_off);
	--CreateThread(w1_unconfirmed_datapad_01);
	--CreateThread(w1_unconfirmed_datapad_02);
	--CreateThread(w1_unconfirmed_datapad_05);
	--CreateThread(w1_unconfirmed_datapad_04);
--	CreateThread(w1_unconfirmed_radio_01);
--	CreateThread(w1_unconfirmed_radio_02);
	CreateThread(nar_fight_up_hill);
--	CreateThread(nar_prowler_spot_start);
end

-- =================================================================================================
function nar_level_start()
	sleep_s(5);
	ObjectiveShow(TITLES.ch_ur_ob_01);
	CreateThread(nar_landing_nudge_controller);
end

function nar_ics_vo()
	sleep_s(1);
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_minerfemale07_00100.sound'), nil);
	sleep_s(5);
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_minerfemale07_00200.sound'), nil);
end

function nar_levelstart_vo()
	sleep_s(14);	
	NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_GLASSLANDS__PELICAN_LANDING);
end

global W1HubUnconfirmedReports_GLASSLANDS__PELICAN_LANDING = {
	name = "W1HubUnconfirmedReports_GLASSLANDS__PELICAN_LANDING",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return volume_test_players(VOLUMES.unconfirmed_landing);
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		--	[1] = {
--					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
--				hud_show_radio_transmission_hud("minerfemale04_transmission_name");
--			end,
--		
--			text = "This is Juniper Zero on approach to Apogee Station.",
--			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_minerfemale07_00100.sound'),
--		},
--		[2] = {
--					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
--				hud_show_radio_transmission_hud("minerfemale04_transmission_name");
--			end,
			
--			text = "Touching down.",
--			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_minerfemale07_00200.sound'),
--		},

		[1] = {			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Looks like we've got an escort.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_08900.sound'),
		},
		[2] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Be surprised if there weren't. Sloan can't be happy about UNSC marching around out here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_07400.sound'),
			
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,

		},
		[3] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
				end,
			sleepBefore = 0.5,
			
			text = "The lady is correct. My team's there to keep an eye on things while you look around. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_sloan_00600.sound'),
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				hud_hide_radio_transmission_hud();
			end,
		},
				[4] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

							sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "No offense taken, Governor. We'll find our targets and be out of your way shortly.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_09500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		CreateThread(nar_level_start);
			hud_hide_radio_transmission_hud();
			CreateThread(unconfirmed_idle_chatter_start);
			NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_Glasslands__MINING_DOCK_BATTLE);
	end,

	localVariables = {},
};

function nar_landing_nudge_controller()
	sleep_s(90);
	if b_prowler_advance == false then
	SleepUntil( [| b_collectible_used == false ], 1);
		NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_LANDING__NUDGE);
		--story_blurb_add("domain", "NUDGE");
	end
end

global W1HubUnconfirmedReports_LANDING__NUDGE = {
	name = "W1HubUnconfirmedReports_LANDING__NUDGE",

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
				return b_collectible_used == false; -- GAMMA_TRANSITION: If vale
			end,
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
		hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
		end,
			
			text = "Ya flew out all this way, is your plan to just stand around all day?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_sloan_01300.sound'),
		},
--           
-- 
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


global W1HubUnconfirmedReports_Glasslands__MINING_DOCK_BATTLE = {
	name = "W1HubUnconfirmedReports_Glasslands__MINING_DOCK_BATTLE",

CanStart = function (thisConvo, queue) -- BOOLEAN
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if object_index_valid( AI.sq_ur_base_marine_move_01.aisquadspawnpoint47) then
			thisConvo.localVariables.checkConditionsPassed = 1;

				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.sq_ur_base_marine_move_01.aisquadspawnpoint47)) < 5;
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
			character = AI.sq_ur_base_marine_move_01.aisquadspawnpoint47, -- GAMMA_CHARACTER: MinerFEMALE01
			text = "What the hell?! They're out here too?!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_minerfemale01_00400.sound'),
		},
		[2] = {
		sleepBefore = 2,
			character = AI.sq_ur_base_marine_move_02.aisquadspawnpoint47, -- GAMMA_CHARACTER: MiNERMALE02
			text = "Open fire! Shoot anything that moves!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_minermale02_00400.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};

function nar_hill_chatter_off()
	SleepUntil([| volume_test_players( VOLUMES.nar_hill_chatter_off)], 1);
	CreateThread(unconfirmed_idle_chatter_off);
	b_prowler_advance = true;
end

function nar_fight_up_hill()
	SleepUntil([| volume_test_players( VOLUMES.fight_up_hill)], 1);
	b_prowler_advance = true;
end

global W1HubUnconfirmedReports_BATTLE_ENTER = {
	name = "W1HubUnconfirmedReports_BATTLE_ENTER",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.fight_up_hill); -- GAMMA_CONDITION
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
				return volume_test_object(VOLUMES.fight_up_hill, SPARTANS.vale) == true; -- GAMMA_TRANSITION: IF VALE
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "This station is overrun with Prometheans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_05100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},

	
		[2] = {
		If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.fight_up_hill, SPARTANS.buck) == true; -- GAMMA_TRANSITION: IF VALE
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "This station is overrun with Prometheans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_06100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
		If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.fight_up_hill, SPARTANS.tanaka) == true; -- GAMMA_TRANSITION: IF VALE
			end,


							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "This station is overrun with Prometheans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_05600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.fight_up_hill, SPARTANS.locke) == true; -- GAMMA_TRANSITION: IF VALE
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "This station is overrun with Prometheans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_06700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 2,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Clear them out! Sloan's people can fight, but they shouldn't have to.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_07500.sound'),

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


global W1HubUnconfirmedReports_GLASSLANDS__SOLDIER_WAVE_1 = {
	name = "W1HubUnconfirmedReports_GLASSLANDS__SOLDIER_WAVE_1",

	CanStart = function (thisConvo, queue)
		return objects_distance_to_object(players_human(),ai_get_object(AI.sq_ur_ship_view_fore_01b.spawn_points_01)) < 4; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.sq_ur_ship_view_fore_01b.spawn_points_01, -- GAMMA_CHARACTER: SOLDIER01
			text = "These are not the humans approved by Warden Eternal.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_fr_soldier01_00100.sound'),
		},
		[2] = {
		sleepBefore = 3,
			character = AI.sq_ur_ship_view_fore_01b.spawn_points_02, -- GAMMA_CHARACTER: Soldier02
			text = "Destroy them.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_fr_soldier02_00200.sound'),
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

global W1HubUnconfirmedReports_GLASSLANDS__BUILDING_combat_complete = {
	name = "W1HubUnconfirmedReports_GLASSLANDS__BUILDING_combat_complete",

	CanStart = function (thisConvo, queue)
		return outpost_battle_complete == true and b_prowler_examine == false; -- GAMMA_CONDITION
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
				return volume_test_object(VOLUMES.first_big_combat_area, SPARTANS.vale) == true and unit_get_health( SPARTANS.vale) > 0; -- GAMMA_TRANSITION: IF VALE
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Locked this area down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_00700.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
				If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.first_big_combat_area, SPARTANS.tanaka) == true and unit_get_health( SPARTANS.tanaka) > 0; -- GAMMA_TRANSITION: IF VALE
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Locked this area down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_01600.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
				If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.first_big_combat_area, SPARTANS.buck) == true and unit_get_health( SPARTANS.buck) > 0; -- GAMMA_TRANSITION: IF VALE
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Locked this area down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_01600.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
					If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.first_big_combat_area, SPARTANS.locke) == true and unit_get_health( SPARTANS.locke) > 0; -- GAMMA_TRANSITION: IF VALE
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Locked this area down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_01300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 1.5,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Let's move on toward the mine. See if we can find any signs of Blue Team.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_VO_SCR_W1HubUnconfirmedReports_UN_BUCK_08100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		CreateThread(nar_prowler_nudge_controller);
		CreateThread(unconfirmed_idle_chatter_start);
		CreateThread(nar_approach_prowler_off);
	end,

	localVariables = {},
};

function nar_prowler_nudge_controller()
	sleep_s(90);
	if b_prowler_examine == false then
		SleepUntil( [| b_collectible_used == false ], 1);
	NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_Glasslands__move_on_to_prowler);
	--story_blurb_add("domain", "NUDGE");
	end
end

global W1HubUnconfirmedReports_Glasslands__move_on_to_prowler = {
	name = "W1HubUnconfirmedReports_Glasslands__move_on_to_prowler",

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
				return b_prowler_examine == false; -- GAMMA_TRANSITION: IF VALE
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Should move in and look for signs of Blue Team.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_VO_SCR_W1HubUnconfirmedReports_UN_TANAKA_07300.sound'),
		}
		},
	
	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

-- =================================================================================================
-- =================================================================================================
-- =================================================================================================
--
--					SHIP PATH
--
-- Covers content on Ship Path.
-- =================================================================================================
function nar_unconfirmed_ship_path()
	NarrativeQueue.QueueConversation(nar_unconfirmed_miner_fix);
end

-- =================================================================================================
global nar_unconfirmed_miner_fix = {
	name = "nar_unconfirmed_miner_fix",

	CanStart = function (thisConvo, queue) -- BOOLEAN
		return b_miner_online_line == true;
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,
	lines = {
				[1] = {
			character = AI.sq_ur_mid_level_marines.spawnpoint10, -- GAMMA_CHARACTER: Minerfemale01
			text = "Come on! We don't need Spartans to fight our battles!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_minerfemale01_00300.sound'),
		},
		[2] = {
			character = AI.sq_ur_mid_level_marines.spawnpoint11, -- GAMMA_CHARACTER: Minermale01
			text = "Yeah! Show 'em Meridian can take care of its own!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_minermale01_00100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};

-- =================================================================================================
-- =================================================================================================
-- =================================================================================================
--					CHIEF SHIP
--
-- Covers content in Chief Ship area.
-- =================================================================================================
function nar_unconfirmed_ship_area()
	CreateThread(nar_unconfirmed_enter_ship_area);
	NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_GLASSLANDS__PROWLER_AREA__PROMETHEAN_AMB);
	NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_access);
	CreateThread(nar_used_access_point);
	--NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_PROWLER_AREA__MORE_WAVES);
	NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_PROWLER_AREA__MORE_WAVES2);
	
end

-- =================================================================================================

function nar_approach_prowler_off()
	SleepUntil([| volume_test_players(VOLUMES.nar_approach_prowler_off) ], 1);
	CreateThread(unconfirmed_idle_chatter_off);
end

function nar_unconfirmed_enter_ship_area()
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_ship_knight_birth) ], 1);
	b_prowler_examine = true;
	CreateThread(unconfirmed_idle_chatter_off);
end

global W1HubUnconfirmedReports_GLASSLANDS__PROWLER_AREA__PROMETHEAN_AMB = {
	name = "W1HubUnconfirmedReports_GLASSLANDS__PROWLER_AREA__PROMETHEAN_AMB",
			canStartOnce = true,
	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.unconfirmed_ship_area); -- GAMMA_CONDITION
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
				return volume_test_object(VOLUMES.unconfirmed_ship_area, SPARTANS.tanaka) == true; -- GAMMA_TRANSITION: If tanaka
			end,


							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Prometheans all over the prowler.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_01100.sound'),
		AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
						AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.unconfirmed_ship_area, SPARTANS.vale) == true; -- GAMMA_TRANSITION: IF VALE
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Prometheans between us and the prowler. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_00400.sound'),
		AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
						AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.unconfirmed_ship_area, SPARTANS.locke) == true; -- GAMMA_TRANSITION: If locke
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Clear the Prometheans. I want a look at that prowler. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_01500.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
						AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},

		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.unconfirmed_ship_area, SPARTANS.buck) == true; -- GAMMA_TRANSITION: If buck
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Prometheans swarming the prowler.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_00600.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},

--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
	CreateThread(nar_birth_watcher_event);
			
	CreateThread(nar_prowler_com_nudge_controller);
	NarrativeQueue.QueueConversation(nar_unconfirmed_prow_combat_complete);
	end,

	localVariables = {},
};

global nar_unconfirmed_prow_combat_complete = {
	name = "nar_unconfirmed_prow_combat_complete",

	CanStart = function (thisConvo, queue)
		return prowler_battle_complete == true; -- GAMMA_CONDITION
	end,
		canStartOnce = true,
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
				return volume_test_object(VOLUMES.unconfirmed_ship_area, SPARTANS.locke) == true and unit_get_health( SPARTANS.locke) > 0; -- GAMMA_TRANSITION: If locke
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "All clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_05700.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.unconfirmed_ship_area, SPARTANS.vale) == true and unit_get_health( SPARTANS.vale) > 0; -- GAMMA_TRANSITION: If locke
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "I don't see any more hostiles.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_03600.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.unconfirmed_ship_area, SPARTANS.tanaka) == true and unit_get_health( SPARTANS.vale) > 0; -- GAMMA_TRANSITION: If locke
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TanakA
			text = "Last of 'em.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_02000.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.unconfirmed_ship_area, SPARTANS.buck) == true and unit_get_health( SPARTANS.buck) > 0; -- GAMMA_TRANSITION: If locke
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Looks all clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_04200.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 5;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 1.5,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Blue Team left their prowler parked in the middle of everything? ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_02600.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 6;
			end,
		},

		[6] = {

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Must have landed here for a reason. Ship's log might tell us something.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_03300.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 7;
			end,
		},
		[7] = {

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Let's run a scan.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_03300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
			CreateThread(nar_enter_prowler_controller);
			CreateThread(nar_start_prowler_invest);
			NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_access_point_approach);
	end,
	localVariables = {},
};

function nar_start_prowler_invest()
	--sleep_s(1);
	--ObjectiveShow(TITLES.ch_ur_ob_complete);
	--sleep_s(4);
	ObjectiveShow(TITLES.ch_ur_ob_03);
	--sleep_s(3);
	prowler_ready_to_scan = true;
end

function nar_birth_watcher_event()
	SleepUntil([| ai_living_count(AI.sq_ship_bishop_birth) >= 0 ], 60);
	NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_PROWLER_AREA__KNIGHT_BIRTHS_WATCHER);
end

global W1HubUnconfirmedReports_PROWLER_AREA__KNIGHT_BIRTHS_WATCHER = {
	name = "W1HubUnconfirmedReports_PROWLER_AREA__KNIGHT_BIRTHS_WATCHER",
		CanStart = function (thisConvo, queue) -- BOOLEAN
			return (objects_can_see_object( players_human(), ai_get_object(AI.sq_ship_bishop_birth.spawn_points_0), 10)) or (objects_can_see_object( players_human(), ai_get_object(AI.sq_ship_bishop_birth_2.spawn_points_0), 10));

	end,
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
				return ((objects_distance_to_object(SPARTANS.vale,ai_get_object(AI.sq_ship_bishop_birth.spawn_points_0)) < 10 ) or (objects_distance_to_object(SPARTANS.vale,ai_get_object(AI.sq_ship_bishop_birth_2.spawn_points_0)) < 10 )) and volume_test_object(VOLUMES.unconfirmed_ship_area, SPARTANS.vale); -- GAMMA_TRANSITION: IF Tanaka

			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Knight spawned a watcher.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_03400.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return ((objects_distance_to_object(SPARTANS.buck,ai_get_object(AI.sq_ship_bishop_birth.spawn_points_0)) < 10 ) or (objects_distance_to_object(SPARTANS.buck,ai_get_object(AI.sq_ship_bishop_birth_2.spawn_points_0)) < 10 )) and volume_test_object(VOLUMES.unconfirmed_ship_area, SPARTANS.buck); -- GAMMA_TRANSITION: IF Tanaka
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BucK
			text = "Knight spawned a watcher.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_04000.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return ((objects_distance_to_object(SPARTANS.tanaka,ai_get_object(AI.sq_ship_bishop_birth.spawn_points_0)) < 10 ) or (objects_distance_to_object(SPARTANS.tanaka,ai_get_object(AI.sq_ship_bishop_birth_2.spawn_points_0)) < 10 )) and volume_test_object(VOLUMES.unconfirmed_ship_area, SPARTANS.tanaka); -- GAMMA_TRANSITION: IF Tanaka
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Knight spawned a watcher.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_01800.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return ((objects_distance_to_object(SPARTANS.locke,ai_get_object(AI.sq_ship_bishop_birth.spawn_points_0)) <  10 ) or (objects_distance_to_object(SPARTANS.locke,ai_get_object(AI.sq_ship_bishop_birth_2.spawn_points_0)) < 10 )) and volume_test_object(VOLUMES.unconfirmed_ship_area, SPARTANS.locke); -- GAMMA_TRANSITION: IF PLAYER LOOKSAT THE EVENT
				-- IF Locke
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Knight spawned a watcher.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_05500.sound'),

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


};

global W1HubUnconfirmedReports_PROWLER_AREA__WATCHER_HEALS_KNIGHT = {
	name = "W1HubUnconfirmedReports_PROWLER_AREA__WATCHER_HEALS_KNIGHT",

	CanStart = function (thisConvo, queue)
		return false; -- GAMMA_CONDITION
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
		
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Watcher restored the knight!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_05600.sound'),

			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
		
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Watcher restored the knight!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_03500.sound'),
			
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
		
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Watcher restored the knight!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_01900.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
		
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BucK
			text = "Watcher restored the knight!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_04100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--           
-- 
--                                                   CUT TO:
--           
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};


function nar_prowler_com_nudge_controller()
	sleep_s(90);
	if prowler_battle_complete == false then
		SleepUntil( [| b_collectible_used == false ], 1);
	NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_PROWLER_AREA__MORE_TO_KILL);
	--	story_blurb_add("domain", "NUDGE");
	end

end

function nar_enter_prowler_controller()
	sleep_s(45);
	if prowler_data_complete == false then
		SleepUntil( [| b_collectible_used == false ], 1);
	NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_PROWLER_AREA__NUDGE_INTO_PROWLER);
	--	story_blurb_add("domain", "NUDGE");
	end
end

global W1HubUnconfirmedReports_PROWLER_AREA__MORE_WAVES = {
	name = "W1HubUnconfirmedReports_PROWLER_AREA__MORE_WAVES",

	CanStart = function (thisConvo, queue)
		return ai_spawn_count(AI.sq_ship_pawns_02) > 0; -- GAMMA_CONDITION
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
				return volume_test_object(VOLUMES.unconfirmed_ship_area, SPARTANS.buck) and unit_get_health( SPARTANS.buck) > 0; -- GAMMA_TRANSITION: IF Buck
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BucK
			text = "Reinforcements. Look sharp.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_06200.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
				[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.unconfirmed_ship_area, SPARTANS.vale) and unit_get_health( SPARTANS.vale) > 0; -- GAMMA_TRANSITION: IF Vale
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Reinforcements. Look sharp.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_05200.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.unconfirmed_ship_area, SPARTANS.tanaka) and unit_get_health( SPARTANS.tanaka) > 0; -- GAMMA_TRANSITION: WAVE 1
				-- IF Locke
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Reinforcements. Look sharp.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_05700.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.unconfirmed_ship_area, SPARTANS.locke) and unit_get_health( SPARTANS.locke) > 0; -- GAMMA_TRANSITION: WAVE 1
				-- IF Locke
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Reinforcements. Look sharp.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_06800.sound'),

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

global W1HubUnconfirmedReports_PROWLER_AREA__MORE_WAVES2 = {
	name = "W1HubUnconfirmedReports_PROWLER_AREA__MORE_WAVES2",

	CanStart = function (thisConvo, queue)
		return ai_spawn_count(AI.sq_ship_soldier_01) > 0; -- GAMMA_CONDITION
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
				return volume_test_object(VOLUMES.unconfirmed_ship_area, SPARTANS.buck) and unit_get_health( SPARTANS.buck) > 0; -- GAMMA_TRANSITION: IF Buck
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BucK
			text = "Reinforcements. Look sharp.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_06200.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
				[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.unconfirmed_ship_area, SPARTANS.vale) and unit_get_health( SPARTANS.vale) > 0; -- GAMMA_TRANSITION: IF Vale
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Reinforcements. Look sharp.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_05200.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.unconfirmed_ship_area, SPARTANS.tanaka) and unit_get_health( SPARTANS.tanaka) > 0; -- GAMMA_TRANSITION: WAVE 1
				-- IF Locke
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Reinforcements. Look sharp.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_05700.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.unconfirmed_ship_area, SPARTANS.locke) and unit_get_health( SPARTANS.locke) > 0; -- GAMMA_TRANSITION: WAVE 1
				-- IF Locke
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Reinforcements. Look sharp.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_06800.sound'),

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

global W1HubUnconfirmedReports_PROWLER_AREA__MORE_TO_KILL = {
	name = "W1HubUnconfirmedReports_PROWLER_AREA__MORE_TO_KILL",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.unconfirmed_ship_area, SPARTANS.tanaka) == true and unit_get_health( SPARTANS.tanaka) > 0; -- GAMMA_TRANSITION: If locke
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Clear the remaining hostiles.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_05000.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.unconfirmed_ship_area, SPARTANS.locke) == true and unit_get_health( SPARTANS.locke) > 0; -- GAMMA_TRANSITION: If locke
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Clear the remaining hostiles.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_06500.sound'),
				AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.unconfirmed_ship_area, SPARTANS.vale) == true and unit_get_health( SPARTANS.vale) > 0; -- GAMMA_TRANSITION: If locke
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Clear the remaining hostiles.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_04700.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.unconfirmed_ship_area, SPARTANS.buck) == true and unit_get_health( SPARTANS.buck) > 0; -- GAMMA_TRANSITION: If locke
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BucK
			text = "Clear the remaining hostiles.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_05600.sound'),

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

global W1HubUnconfirmedReports_PROWLER_AREA__NUDGE_INTO_PROWLER = {
	name = "W1HubUnconfirmedReports_PROWLER_AREA__NUDGE_INTO_PROWLER",

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
				return b_collectible_used == false; -- GAMMA_TRANSITION: If vale
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "We need to get a look at that prowler's data, right? Should get a move on that.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_VO_SCR_W1HubUnconfirmedReports_UN_BUCK_08600.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};


function nar_prowler_pinged()
	sleep_s(2);
	if prowler_pinged == false then
		NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_PROWLER_PINGED);
		prowler_pinged = true;
	end
end


global W1HubUnconfirmedReports_PROWLER_PINGED = {
	name = "W1HubUnconfirmedReports_PROWLER_PINGED",
	canStartOnce = true,
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return b_used_console == false; -- GAMMA_TRANSITION: If buck WITNESSES
			end,
		
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "There. A console inside the deployment bay.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_08500.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

function nar_used_access_point()
	SleepUntil([| device_get_position(OBJECTS.dc_door_ship_tracking_01) > 0.5 ], 60);
	b_used_console = true;
end

global W1HubUnconfirmedReports_access_point_approach = {
	name = "W1HubUnconfirmedReports_access_point_approach",

	CanStart = function (thisConvo, queue)
		return volume_test_players( VOLUMES.nar_unconfirmed_console_prompt); -- GAMMA_CONDITION
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
				return volume_test_object(VOLUMES.nar_unconfirmed_console_prompt, SPARTANS.vale) == true and prowler_data_complete == false; -- GAMMA_TRANSITION: If vale
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Found an access point.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_03700.sound'),
				AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_unconfirmed_console_prompt, SPARTANS.buck) == true and prowler_data_complete == false; -- GAMMA_TRANSITION: If vale
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Found an access point.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_04300.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
				If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_unconfirmed_console_prompt, SPARTANS.tanaka) == true and prowler_data_complete == false; -- GAMMA_TRANSITION: If vale
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Found an access point.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_03400.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_unconfirmed_console_prompt, SPARTANS.locke) == true and prowler_data_complete == false; -- GAMMA_TRANSITION: If vale
			end,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Found an access point.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_03500.sound'),

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

global W1HubUnconfirmedReports_access = {
	name = "W1HubUnconfirmedReports_access",

	CanStart = function (thisConvo, queue)
		return device_get_position(OBJECTS.dc_door_ship_tracking_01) > 0.5 ; -- GAMMA_CONDITION
	end,
	
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 3,

	OnStart = function (thisConvo, queue)
			prowler_data_complete = true;
			
			RunClientScript("pip_unconfirmed_inteldownload_60");
	end,

	lines = {

		[1] = {
			sleepBefore = 5,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Look at this.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_03500.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
		},
		[2] = {

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 1.5,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Looks like a map of Apogee Station... It leads down inside the mountain.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_09000.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
		},
		[3] = {

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 1.5,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TanakA
			text = "Marked a path through the door outside to the mines.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_04700.sound'),
				
		},
	},

	OnFinish = function (thisConvo, queue)
	prowler_door_blip = true;
	hud_hide_radio_transmission_hud();
		NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_access2);
	end,

	localVariables = {},
};

global W1HubUnconfirmedReports_access2 = {
	name = "W1HubUnconfirmedReports_access2",

	CanStart = function (thisConvo, queue)
		return  unit_get_health( SPARTANS.locke) > 0 ; -- GAMMA_CONDITION
	end,
	
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
	
	end,

	lines = {
		[1] = {
			sleepBefore = 1,

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Governor Sloan. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_04000.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 6;
			end,
		},
		[2] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
end,
sleepBefore = 1,
			text = "Spartan Locke?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_sloan_00800.sound'),
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				hud_hide_radio_transmission_hud();
			end,
		},
		[3] = {

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "We're looking for access to the mine near our position.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_05900.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 6;
			end,
		},
--           After a moment.

		[4] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
end,
sleepBefore = 0.5,
			text = "This soldier you're chasing is down there? Not likely.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_sloan_00900.sound'),
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				hud_hide_radio_transmission_hud();
			end,
		},
		[5] = {

							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "I said we need access to that mine.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_06000.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 6;
			end,
		},
		[6] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
						hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
end,
sleepBefore = 0.5,
			text = "I'll have my people open the door.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_sloan_01000.sound'),
				
		},
--                          (RAMPANT)

		[7] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,
			sleepBefore = 0.5,
			text = "You watch yourselves down there.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_sloan_01100.sound'),
		},
--           DOOR OPENS.
-- 
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
			prowler_door_open = true;
			NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_prowler_area_miners);
	CreateThread(unconfirmed_idle_chatter_start);
	CreateThread(nar_insnipers_nudge_controller);
	CreateThread(sniper_chatter_stop);
	CreateThread(nar_prowler_done_titles);
	end,

	localVariables = {},
};

function sniper_chatter_stop()
	SleepUntil([| volume_test_players( VOLUMES.sniper_chatter_stop)], 1);
	CreateThread(unconfirmed_idle_chatter_off);
end

function nar_prowler_done_titles()
	sleep_s(2);
	--ObjectiveShow(TITLES.ch_ur_ob_complete);
	--sleep_s(4);
	ObjectiveShow(TITLES.ch_ur_ob_04);
end

function nar_insnipers_nudge_controller()
	sleep_s(90);
	if b_passed_into_sniper == false then
	SleepUntil( [| b_collectible_used == false ], 1);

		NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_prowler_area_nudge);
	--	story_blurb_add("domain", "NUDGE");
	end

end
global W1HubUnconfirmedReports_prowler_area_miners = {
	name = "W1HubUnconfirmedReports_prowler_area_miners",

	CanStart = function (thisConvo, queue) -- BOOLEAN
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if (ai_living_count (AI.sq_ur_mid_level_marines) >= 1 ) then
			thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return  objects_distance_to_object(players_human(),ai_get_object(AI.sq_ur_mid_level_marines.spawnpoint10)) < 8 ;
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
		
			character = AI.sq_ur_mid_level_marines.spawnpoint10, -- GAMMA_CHARACTER: Locke
			text = "Let's go.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_VO_SCR_W1HubUnconfirmedReports_UN_MinerFemale01_00500.sound'),

		},
--	[2] = {
--		sleepBefore = 0.5,
--			character = AI.sq_ur_mid_level_marines.spawnpoint11, -- GAMMA_CHARACTER: Locke
--			text = "How about the Spartans go in first.",
--			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_minerfemale02_00300.sound'),

--		},
	[2] = {
		sleepBefore = 0.5,
			character = AI.sq_ur_mid_level_marines.spawnpoint11, -- GAMMA_CHARACTER: Locke
			text = "I survive this, I'm billing for hazard pay.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_minermale02_00500.sound'),

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

global W1HubUnconfirmedReports_prowler_area_nudge = {
	name = "W1HubUnconfirmedReports_prowler_area_nudge",

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
				return b_collectible_used == false; -- GAMMA_TRANSITION: If vale
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Blue Team's already got a head start, Osiris. Double time. Into the mine.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_04100.sound'),

		},

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};

-- =================================================================================================
-- =================================================================================================
-- =================================================================================================
--
--					SNIPER
--
-- Covers content in Sniper area.
--
-- =================================================================================================
function nar_unconfirmed_snipers()
	NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_Mining_shaft_entrance__blue_team_COMBAT);
	CreateThread(nar_moved_into_soldier_area);
--	object_create( "unconfirmed_collect_01" );
--	object_create( "unconfirmed_collect_02" );
--	object_create( "unconfirmed_collect_05" );
--	object_create( "unconfirmed_collect_03" );
--	object_create( "unconfirmed_collect_04" );
--	object_create( "unconfirmed_collect_07" );

--CreateThread(nar_unconfirmed_upper_mines);
end

-- =================================================================================================
function nar_moved_into_soldier_area()
	SleepUntil( [| volume_test_players(VOLUMES.unconfirmed_soldier_encounter_start) ],1);
	NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_soldier_encounter_start);	
	b_passed_into_sniper = true;
	CreateThread(unconfirmed_idle_chatter_off);
end

global W1HubUnconfirmedReports_soldier_encounter_start = {
	name = "W1HubUnconfirmedReports_soldier_encounter_start",
			canStartOnce = true,
	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.unconfirmed_soldier_encounter_start); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");

	end,

	lines = {
		[1] = {
			character = AI.miner_pinned_by_snipers.miner,  -- GAMMA_CHARACTER: Minermale02
			text = "Stand back! Snipers perched ahead.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_minermale02_00300.sound'),
			sleepAfter = 1,
		},
		
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_soldier_encounter_start2);
	end,

	localVariables = {},
};


global W1HubUnconfirmedReports_soldier_encounter_start2 = {
	name = "W1HubUnconfirmedReports_soldier_encounter_start2",
			canStartOnce = true,
	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.unconfirmed_soldier_encounter_start); -- GAMMA_CONDITION
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
				return volume_test_object(VOLUMES.unconfirmed_soldier_encounter_start, SPARTANS.buck); -- GAMMA_TRANSITION: If tanaka
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "The Prometheans have this entrance bottled up. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_VO_SCR_W1HubUnconfirmedReports_UN_BUCK_08700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.unconfirmed_soldier_encounter_start, SPARTANS.tanaka); -- GAMMA_TRANSITION: If tanaka
			end,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "The Prometheans have this entrance bottled up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_08000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.unconfirmed_soldier_encounter_start, SPARTANS.locke); -- GAMMA_TRANSITION: IF LOCKE
			end,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "The Prometheans have this entrance bottled up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_09000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.unconfirmed_soldier_encounter_start, SPARTANS.vale); -- GAMMA_TRANSITION: If vale
			end,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "The Prometheans have this entrance bottled up.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_07400.sound'),

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

function nar_sniper_fight_complete_nudge()
	sleep_s(90);
	SleepUntil( [| b_collectible_used == false ], 1);
	NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_MINING_SHAFT_ENTRANCE__KEEP_FIGHTING);
end

global W1HubUnconfirmedReports_MINING_SHAFT_ENTRANCE__KEEP_FIGHTING = {
	name = "W1HubUnconfirmedReports_MINING_SHAFT_ENTRANCE__KEEP_FIGHTING",

	CanStart = function (thisConvo, queue)
		return sniper_battle_complete == false; -- GAMMA_CONDITION
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
				return volume_test_object(VOLUMES.sniper_whole_area, SPARTANS.tanaka) == true and unit_get_health( SPARTANS.tanaka) > 0; -- GAMMA_TRANSITION: If vale
			end,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "We aren't getting through here until we wipe everything out!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_06700.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
				If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.sniper_whole_area, SPARTANS.vale) == true and unit_get_health( SPARTANS.vale) > 0; -- GAMMA_TRANSITION: If vale
			end,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "We aren't getting through here until we wipe everything out!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_06200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
		},
		[3] = {
				If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.sniper_whole_area, SPARTANS.locke) == true and unit_get_health( SPARTANS.locke) > 0; -- GAMMA_TRANSITION: If vale
			end,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "We aren't getting through here until we wipe everything out!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_08000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
		},
	
		[4] = {
					If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.sniper_whole_area, SPARTANS.buck) == true and unit_get_health( SPARTANS.buck) > 0; -- GAMMA_TRANSITION: If vale
			end,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "We aren't getting through here until we wipe everything out!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_07300.sound'),

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
};

function nar_intomine_nudge_controller()
	sleep_s(90);
	if b_passed_into_mine == false then
		SleepUntil( [| b_collectible_used == false ], 1);

		NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_SNIPER_AREA__NUDGE);
		--story_blurb_add("domain", "NUDGE");
	end
end

global W1HubUnconfirmedReports_SNIPER_AREA__NUDGE = {
	name = "W1HubUnconfirmedReports_SNIPER_AREA__NUDGE",
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
				return b_collectible_used == false; -- GAMMA_TRANSITION: If vale
			end,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Nothing left for us out here. Should move into that mine.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_05900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};


global W1HubUnconfirmedReports_Mining_shaft_entrance__blue_team_COMBAT = {
	name = "W1HubUnconfirmedReports_Mining_shaft_entrance__blue_team_COMBAT",

	CanStart = function (thisConvo, queue)
		return sniper_battle_complete == true; -- GAMMA_CONDITION
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
				return volume_test_object(VOLUMES.sniper_whole_area, SPARTANS.locke) == true and unit_get_health( SPARTANS.locke) > 0; -- GAMMA_TRANSITION: If vale
			end,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "This area's locked down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_08100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
					If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.sniper_whole_area, SPARTANS.vale) == true and unit_get_health( SPARTANS.vale) > 0; -- GAMMA_TRANSITION: If vale
			end,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "This area's locked down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_06300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
					If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.sniper_whole_area, SPARTANS.tanaka) == true and unit_get_health( SPARTANS.tanaka) > 0; -- GAMMA_TRANSITION: If vale
			end,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "This area's locked down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_06800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
					If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.sniper_whole_area, SPARTANS.buck) == true and unit_get_health( SPARTANS.buck) > 0; -- GAMMA_TRANSITION: If vale
			end,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "This area's locked down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_07400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
		
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 1,
	character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Governor Sloan, this area's clear. Open the door to the mine.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_VO_SCR_W1HubUnconfirmedReports_UN_Locke_03800.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 7;
			end,
		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
end,
	sleepBefore = 1,
	text = "Got it, Spartan.",
	tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_sloan_01200.sound'),
	AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
		CreateThread(nar_sloan_open_door);
		hud_hide_radio_transmission_hud();
		return 7; -- GAMMA_NEXT_LINE_NUMBER
	end,
	},
		[7] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 2,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: bUCK
			text = "Don't see any signs Blue Team engaged in combat through here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_05100.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,

		},
		[8] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 1,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Think they found another entrance?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_01700.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,

		},
		[9] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: bUCK
			text = "My money's on the Prometheans never engaging them.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_05200.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,

		},
		[10] = {

					If = function(thisLine, thisConvo, queue, lineNumber)
				return b_passed_into_mine == false;
			end,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 1,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
	text = "That doesn't make any sense.",
	tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_04400.sound'),
				AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,

		},
		[11] = {
		
		If = function(thisLine, thisConvo, queue, lineNumber)
				return b_passed_into_mine == false;
		end,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 1,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Making sense and being a fact aren't always the same thing. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_05300.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		CreateThread(nar_intomine_nudge_controller);
		CreateThread(unconfirmed_idle_chatter_start);
		CreateThread(nar_enter_mine_chatter_off);
	end,

	localVariables = {},
};

function nar_sloan_open_door()
	Sleep(60);
	f_ur_quarry_sloan_opens_door();
	Sleep(60);
end

-- =================================================================================================
-- =================================================================================================
-- =================================================================================================
--
--					UPPER MINES
--
-- Covers content in the upper mines area.
--
-- =================================================================================================

function nar_unconfirmed_upper_mines()
	CreateThread(w1_nar_promethean_saw);
	CreateThread(nar_mine_combat_complete_prep);
	CreateThread(nar_enter_quarry);
	NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_lookat_structure);
--	CreateThread(w1_unconfirmed_datapad_03);
--	CreateThread(w1_unconfirmed_radio_02);
	CreateThread(nar_unconfirmed_turret_listener);
	CreateThread(nar_unconfirmed_turret_listener2);
	CreateThread(unconfirmed_turret_callout);
	object_create( "unconfirmed_collect_06" );
end

-- =================================================================================================

function nar_enter_mine_chatter_off()
SleepUntil( [| volume_test_players(VOLUMES.nar_enter_mine_chatter_off) ],1);
	CreateThread(unconfirmed_idle_chatter_off);
end

function nar_enter_quarry()
	SleepUntil( [| volume_test_players(VOLUMES.tv_mine_open_airlock_2) ],1);
	CreateThread(unconfirmed_idle_chatter_off);
	b_passed_into_mine = true;
end 

global W1HubUnconfirmedReports_unconfirmed_quarry_enter = {
	name = "W1HubUnconfirmedReports_unconfirmed_quarry_enter",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,
	sleepBefore = 2,
	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
					
	end,

	lines = {

		[1] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Earthquake?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_02100.sound'),
		},
		[2] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Watch your heads. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_01800.sound'),
		},

--                                                   CUT TO:
--           ____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		
	end,

	localVariables = {},
};

global W1HubUnconfirmedReports_Forerunner_Waves_01 = {
	name = "W1HubUnconfirmedReports_Forerunner_Waves_01",
	
	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.tv_mt_mine_spawn_02); -- GAMMA_CONDITION
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
				return volume_test_object(VOLUMES.tv_mt_mine_spawn_02, SPARTANS.tanaka) == true; -- GAMMA_TRANSITION: If vale
			end,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Spawn gates bringing in more Prometheans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_06500.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.tv_mt_mine_spawn_02, SPARTANS.buck) == true; -- GAMMA_TRANSITION: If vale
			end,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Spawn gates bringing in more Prometheans!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_07100.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.tv_mt_mine_spawn_02, SPARTANS.locke) == true; -- GAMMA_TRANSITION: If vale
			end,		
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Spawn gates bringing in more Prometheans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_07800.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.tv_mt_mine_spawn_02, SPARTANS.vale) == true; -- GAMMA_TRANSITION: If vale
			end,
		
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Spawn gates bringing in more Prometheans!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_06000.sound'),

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

global W1HubUnconfirmedReports_Forerunner_Waves_02 = {
	name = "W1HubUnconfirmedReports_Forerunner_Waves_02",

		CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.tv_mt_mine_spawn_03); -- GAMMA_CONDITION
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
				return volume_test_object(VOLUMES.tv_mt_mine_spawn_03, SPARTANS.vale) == true; -- GAMMA_TRANSITION: If vale
			end,
		sleepBefore = 2,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "More Prometheans inbound!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_06100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.tv_mt_mine_spawn_03, SPARTANS.tanaka) == true; -- GAMMA_TRANSITION: If vale
			end,		
			sleepBefore = 2,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "More Prometheans inbound!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_06600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.tv_mt_mine_spawn_03, SPARTANS.buck) == true; -- GAMMA_TRANSITION: If vale
			end,			
			sleepBefore = 2,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "More Prometheans inbound!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_07200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.tv_mt_mine_spawn_03, SPARTANS.locke) == true; -- GAMMA_TRANSITION: If vale
			end,		
			sleepBefore = 2,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "More Prometheans inbound!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_07900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--                                                   CUT TO:
--           ____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		
	end,

	localVariables = {},
};


function nar_upper_wave_2()
	NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_Forerunner_Waves_01);
end

function nar_upper_wave_3()
	NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_Forerunner_Waves_02);
	CreateThread(nar_unconfirm_digsite_enemies_alive);
end

global W1HubUnconfirmedReports_MINING_SITE__FORERUNNER_USING_HUMAN_WEAP = {
	name = "W1HubUnconfirmedReports_MINING_SITE__FORERUNNER_USING_HUMAN_WEAP",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return (objects_distance_to_object(SPARTANS.tanaka,ai_get_object(AI.sq_mine_fr_soldier_officer.aisquadspawnpoint03)) < 10 ); -- GAMMA_TRANSITION: IF TANAKA
			end,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "That Promethean just grabbed a SAW!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_06300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return (objects_distance_to_object(SPARTANS.buck,ai_get_object(AI.sq_mine_fr_soldier_officer.aisquadspawnpoint03)) < 10 ); -- GAMMA_TRANSITION: If buck
			end,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "That Promethean just grabbed a SAW!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_06900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return (objects_distance_to_object(SPARTANS.locke,ai_get_object(AI.sq_mine_fr_soldier_officer.aisquadspawnpoint03)) < 10 ); -- GAMMA_TRANSITION: If locke
			end,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "That Promethean just grabbed a SAW!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_07600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return (objects_distance_to_object(SPARTANS.vale,ai_get_object(AI.sq_mine_fr_soldier_officer.aisquadspawnpoint03)) < 10 ); -- GAMMA_TRANSITION: If vale
			end,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "That Promethean just grabbed a SAW!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_05800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--           
-- 
--                                                   CUT TO:
--           ____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};

function w1_nar_promethean_saw()
	SleepUntil([| object_index_valid( AI.cave_soldier.soldier )], 1);
	SleepUntil([| objects_distance_to_object(players_human(),ai_get_object(AI.cave_soldier.soldier)) < 7 ], 1);
	-- Update with vignette

	NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_MINING_SITE_SAW);
	sleep_s(5);
	rumble_shake_large(2.0);
	CreateThread(audio_earthquake);
	--FX for earthquake
	CreateEffectGroup(EFFECTS.earthquake_fx_01);
	CreateEffectGroup(EFFECTS.earthquake_fx_02);
	CreateEffectGroup(EFFECTS.earthquake_fx_03);	
	NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_unconfirmed_quarry_enter);
end	

function nar_call_solider_vo()
	SleepUntil([| ai_combat_status(AI.cave_soldier.soldier ) > 4 ], 1);
	
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_fr_soldier01_00100.sound'), ai_get_object(AI.cave_soldier.soldier));	
end

global W1HubUnconfirmedReports_MINING_SITE_SAW = {
	name = "W1HubUnconfirmedReports_MINING_SITE_SAW",
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.cave_soldier.soldier, -- GAMMA_CHARACTER: SOLDIER01
			text = "Primitive. Yet functional. It will serve our purpose.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_VO_SCR_W1HubUnconfirmedReports_FR_SOLDIER01_00200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
			CreateThread(nar_call_solider_vo);
	end,

	localVariables = {},
};


global W1HubUnconfirmedReports_MINING_SITE__AUTO_TURRET_PROMPT = {
	name = "W1HubUnconfirmedReports_MINING_SITE__AUTO_TURRET_PROMPT",
	
	CanStart = function (thisConvo, queue)
		return ai_living_count(AI.sg_mine_all) > 0.5; -- GAMMA_CONDITION
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
				return ((objects_distance_to_object(SPARTANS.tanaka,OBJECTS.dc_mine_turret_switch_01) < 3 or (objects_distance_to_object(SPARTANS.tanaka,OBJECTS.dc_mine_turret_switch_02) < 3))); -- GAMMA_TRANSITION: IF TANAKA
			end,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Auto-turrets here. Turning 'em back on would be a real big help in this fight.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_06400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return ((objects_distance_to_object(SPARTANS.buck,OBJECTS.dc_mine_turret_switch_01) < 3 or (objects_distance_to_object(SPARTANS.buck,OBJECTS.dc_mine_turret_switch_02) < 3))); -- GAMMA_TRANSITION: If buck
			end,

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Auto-turrets here. They'd make quick work of these Promtheans if we turned them back on.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_07000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return ((objects_distance_to_object(SPARTANS.locke,OBJECTS.dc_mine_turret_switch_01) < 3 or (objects_distance_to_object(SPARTANS.locke,OBJECTS.dc_mine_turret_switch_02) < 3))); -- GAMMA_TRANSITION: If locke
			end,

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Dormant auto-turrets. If we turn these back on, they'll make quick work of the Prometheans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_07700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return ((objects_distance_to_object(SPARTANS.vale,OBJECTS.dc_mine_turret_switch_01) < 3 or (objects_distance_to_object(SPARTANS.vale,OBJECTS.dc_mine_turret_switch_02) < 3))); -- GAMMA_TRANSITION: If vale
			end,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Dormant auto-turrets. If we could get these turned on, they'd be invaluable.\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_05900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--                                                   CUT TO:
--           ____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};


function nar_unconfirmed_turret_listener()
	SleepUntil([| object_valid( "dc_mine_turret_switch_01" ) ], 60);
	PrintNarrative("LISTENER - dc_mine_turret_switch_01 THREADED");
	SleepUntil([| device_get_power( OBJECTS.dc_mine_turret_switch_01) == 1 ], 60);
	PrintNarrative("LISTENER - dc_mine_turret_switch_01");
	CreateThread(RegisterInteractEvent, nar_unconfirmed_turret_launcher, OBJECTS.dc_mine_turret_switch_01);
end

function nar_unconfirmed_turret_listener2()
	SleepUntil([| object_valid( "dc_mine_turret_switch_02" ) ], 60);
	PrintNarrative("LISTENER - dc_mine_turret_switch_02 THREADED");
	SleepUntil([| device_get_power( OBJECTS.dc_mine_turret_switch_02) == 1 ], 60);
	PrintNarrative("LISTENER - dc_mine_turret_switch_02");
	CreateThread(RegisterInteractEvent, nar_unconfirmed_turret_launcher2, OBJECTS.dc_mine_turret_switch_02);
end

function nar_unconfirmed_turret_launcher(trigger:object, activator:object)
	PrintNarrative("LAUNCHER - dc_mine_turret_switch_01");
	print(activator, " is the activator of ", trigger);
	CreateThread(UnregisterInteractEvent, nar_unconfirmed_turret_launcher, OBJECTS.dc_mine_turret_switch_01);
	CreateThread(nar_unconfirmed_turret_used, activator)
end

function nar_unconfirmed_turret_launcher2(trigger:object, activator:object)
	PrintNarrative("LAUNCHER - dc_mine_turret_switch_02");
	print(activator, " is the activator of ", trigger);
	CreateThread(UnregisterInteractEvent, nar_unconfirmed_turret_listener2, OBJECTS.dc_mine_turret_switch_02);
	CreateThread(nar_unconfirmed_turret_used, activator)
end

function nar_unconfirmed_turret_used(activator:object)
	if ai_living_count(AI.sg_mine_all) > 0 then
	sleep_s(1.5);
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_VO_SCR_W1HubUnconfirmedReports_UN_ELEVATORPA_00100.sound'), OBJECTS.dc_mine_turret_switch_01);
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_elevatorpa_00100b.sound'), OBJECTS.dc_mine_turret_switch_02);		
			sleep_s(3);
		if activator == SPARTANS.tanaka then
			NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_turret_used_tanaka);
		elseif activator == SPARTANS.buck then
			NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_turret_used_buck);
		elseif activator == SPARTANS.locke then
			NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_turret_used_locke);
		elseif activator == SPARTANS.vale then
			NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_turret_used_vale);
		end
	end
end

global W1HubUnconfirmedReports_turret_used_tanaka = {
	name = "W1HubUnconfirmedReports_turret_used_tanaka",

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
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Turrets on and firing.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_06900.sound'),

		},

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};

global W1HubUnconfirmedReports_turret_used_buck = {
	name = "W1HubUnconfirmedReports_MINING_SITE__Turrets_on",

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
			text = "Turrets on and firing.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_07500.sound'),

		},

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};

global W1HubUnconfirmedReports_turret_used_locke = {
	name = "W1HubUnconfirmedReports_turret_used_locke",

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
			text = "Turrets on and firing.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_08200.sound'),

		},
	
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};

global W1HubUnconfirmedReports_turret_used_vale = {
	name = "W1HubUnconfirmedReports_turret_used_vale",

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
			text = "Turrets on and firing.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_06400.sound'),

		},

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};


function unconfirmed_turret_callout()
	SleepUntil([| object_index_valid( OBJECTS.dc_mine_turret_switch_01 )], 1);
	SleepUntil([| objects_distance_to_object(players_human(), OBJECTS.dc_mine_turret_switch_01) < 3 or objects_distance_to_object(players_human(),OBJECTS.dc_mine_turret_switch_02) < 3 ], 1);
			--story_blurb_add("domain", "TURRETS!");
	if b_forerunner_door_entered == false then
		NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_MINING_SITE__AUTO_TURRET_PROMPT);
	end
end

function nar_mine_combat_complete_prep()
	SleepUntil([| volume_test_players(VOLUMES.nar_mine_combat_complete_prep) ], 1);
--	CreateThread(nar_unconfirm_digsite_enemies_alive);
	--NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_DIGGING_SITE__combat_complete);
	--CreateThread(audio_unconfirmedreports_thread_up_dig_site_start);
end

function nar_unconfirm_digsite_enemies_alive()
	SleepUntil([| ai_living_count(AI.sg_mine_enemy_all) >= 1 and ai_living_count(AI.sq_mine_rg_knight_01) >= 1], 5);
	CreateThread(nar_digsite_all_down_listener);
end

function nar_digsite_all_down_listener()
	SleepUntil([| ai_living_count(AI.sg_mine_enemy_all) <= 1 ], 1);

	local s_last_living_ai:object = ai_get_unit( AI.sg_mine_enemy_all );
	PrintNarrative("LISTENER - nar_digsite_all_down_listener");
	print(" LAst AI alive is:  ", s_last_living_ai);

	if ai_living_count(AI.sg_mine_enemy_all) <= 0 then
		PrintNarrative("LISTENER - nar_digsite_all_down_listener - ALL DEAD");
		CreateMissionThread(nar_digsite_all_down, SPARTANS.vale);
	else
		RegisterDeathEvent (nar_digsite_all_down, s_last_living_ai);
	end
end

function nar_digsite_all_down(target:object, killer:object)
	PrintNarrative("LAUNCHER - nar_digsite_all_down");
	print(killer, " is the killer of ", target);
	--story_blurb_add("domain", "KILL ALL TRIGGER");
	W1HubUnconfirmedReports_DIGGING_SITE__combat_complete.localVariables.killer = killer;
	PrintNarrative("QUEUE - W1HubUnconfirmedReports_DIGGING_SITE__combat_complete");
	NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_DIGGING_SITE__combat_complete);
end

global W1HubUnconfirmedReports_DIGGING_SITE__combat_complete = {
	name = "W1HubUnconfirmedReports_DIGGING_SITE__combat_complete",
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
				return thisConvo.localVariables.killer == SPARTANS.tanaka ; -- GAMMA_TRANSITION: If locke killed the last hunter
			end,
			
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Nothing else here. Move on that Forerunner structure.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_04500.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
			sleepAfter = 1,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.buck ; -- GAMMA_TRANSITION: If locke killed the last hunter
			end,
			
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Everything's down. Let's move on.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_04700.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
			sleepAfter = 1,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.locke ; -- GAMMA_TRANSITION: If locke killed the last hunter
			end,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Area's clear. Move into the structure.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_06200.sound'),
	
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
			sleepAfter = 1,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.vale ; -- GAMMA_TRANSITION: If locke killed the last hunter
			end,
			
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "All clear. We can move to the structure now.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_04100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,

			sleepAfter = 1,
		},
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
	b_mine_complete = true;
	end,

	localVariables = {
		
		killer = nil,
	},
};

global W1HubUnconfirmedReports_lookat_structure = {
	name = "W1HubUnconfirmedReports_lookat_structure",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.unconfirmed_promethean_question); -- GAMMA_CONDITION
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
				return volume_test_object(VOLUMES.lookat_structure, SPARTANS.tanaka); -- GAMMA_TRANSITION: If vale WITNESSES
			end,
			sleepBefore = 1,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "What is that?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_02800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.lookat_structure, SPARTANS.vale); -- GAMMA_TRANSITION: If vale WITNESSES
			end,
			sleepBefore = 1,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "What is that?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_03800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
					ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.lookat_structure, SPARTANS.locke); -- GAMMA_TRANSITION: If vale WITNESSES
			end,
			sleepBefore = 1,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "What is that?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_03900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	[4]	= {
				ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.lookat_structure, SPARTANS.buck); -- GAMMA_TRANSITION: If vale WITNESSES
			end,
			sleepBefore = 1,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "What is that?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_04400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},

		[5] = {

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 1,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "There's no record of Forerunner artifacts on Meridian. They must have just uncovered this.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_03900.sound'),
	
		},
			[6] = {

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 2,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "You know, we've seen Promethean attacks since Requiem, but no record of any this intense.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_00900.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[7] = {

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: taNAKA
			text = "Something riled 'em up. That's for sure.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_04800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		CreateThread(unconfirmed_idle_chatter_start);
	CreateThread(nar_bunker_chatter_off);
	CreateThread(nar_intobunker_nudge_controller);
	end,

};

global W1HubUnconfirmedReports_BUNKER_ENTRANCE__REVEAL = {
	name = "W1HubUnconfirmedReports_BUNKER_ENTRANCE__REVEAL",
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
				return volume_test_object(VOLUMES.mysterious_bunker_reveal, SPARTANS.locke); -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,
			
	sleepBefore = 1.5,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Something here. Similar design to a Monitor. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_08600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
		ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.mysterious_bunker_reveal, SPARTANS.buck); -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,
			
	sleepBefore = 1.5,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Something here. Similar design to a Monitor.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_09100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
		ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.mysterious_bunker_reveal, SPARTANS.vale); -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 1.5,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Something here. Similar design to a Monitor.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_07000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
		ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.mysterious_bunker_reveal, SPARTANS.tanaka); -- GAMMA_TRANSITION: IF LOCKE DISCOVERS
			end,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		
	sleepBefore = 1.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Something here. Similar design to a Monitor.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_07600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,

		},
--           AS THE CONSTRUCTORS FLY AROUND

		[5] = {

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Non-communicative. And they don't seem interested in us.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_07100.sound'),
		},
		[6] = {

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Move forward. But keep an eye on them.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_08700.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
	
	end,

	localVariables = {},
};

function mysterious_bunker_reveal()
	SleepUntil([| volume_test_players(VOLUMES.mysterious_bunker_reveal) ], 1);
	b_forerunner_door_entered = true;
	b_moved_into_structure = true;
	NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_BUNKER_ENTRANCE__REVEAL);
end

function dormant.unconfirmed_prowler_found()
	print("deprecated");
end

function nar_intobunker_nudge_controller()
	sleep_s(90);
	if b_moved_into_structure == false then
		SleepUntil( [| b_collectible_used == false ], 1);
		NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_UPPER_MINES__NUDGE_INTO_STRUCTURE);
	end
end

global W1HubUnconfirmedReports_UPPER_MINES__NUDGE_INTO_STRUCTURE = {
	name = "W1HubUnconfirmedReports_UPPER_MINES__NUDGE_INTO_STRUCTURE",

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
				return b_collectible_used == false; -- GAMMA_TRANSITION: If vale
			end,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "That Forerunner structure is Blue Team's target. We should move in.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_05400.sound'),
		},
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};

-- =================================================================================================
-- =================================================================================================
-- =================================================================================================
--
--				LAVA LIFT
--
-- Covers content in the lava lift area.
--
-- =================================================================================================

function nar_unconfirmed_lava_lift()
	NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_BUNKER_ENTRANCE__DOMAIN_MURAL_GLYPHS);
	NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_platforms_reveal);
	CreateThread(mysterious_bunker_reveal);
	CreateThread(nar_lava_elevator_start);
	CreateThread(nar_enter_wardenroom);
	CreateThread(nar_descent_bottom_platform);
end

-- =================================================================================================

function nar_bunker_chatter_off()
	SleepUntil([| volume_test_players(VOLUMES.nar_bunker_chatter_off) ], 1);
CreateThread(unconfirmed_idle_chatter_off);
end

global W1HubUnconfirmedReports_platforms_reveal= {
	name = "W1HubUnconfirmedReports_platforms_reveal",
		canStartOnce = true,
	CanStart = function (thisConvo, queue)
		return  volume_test_object(VOLUMES.mysterious_platforms_reveal, SPARTANS.buck); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		CreateThread(unconfirmed_idle_chatter_off);
	end,

	lines = {
		[1] = {

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Forerunners did not lack a sense of style.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_02000.sound'),
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return b_lava_elevator_used == false; -- GAMMA_TRANSITION: If chief
			end,

		
														OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Looks like the only way is down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_09700.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		
	end,

	localVariables = {},
};
global W1HubUnconfirmedReports_BUNKER_ENTRANCE__DOMAIN_MURAL_GLYPHS = {
	name = "W1HubUnconfirmedReports_BUNKER_ENTRANCE__DOMAIN_MURAL_GLYPHS",
		canStartOnce = true,
	CanStart = function (thisConvo, queue)
		return volume_test_object(VOLUMES.mysterious_platforms_reveal, SPARTANS. vale); -- GAMMA_CONDITION
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
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Look at all of this! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_01100.sound'),
		},
		[2] = {

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Record everything, and we can get a good look at it later.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_02800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
	
	end,

	localVariables = {},
};

function nar_towarden_nudge_controller()
	sleep_s(90);
	if b_passed_into_warden == false then
	--story_blurb_add("domain", "NUDGE");
		SleepUntil( [| b_collectible_used == false ], 1);
		NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_Bunker__Nudge);
	end

end

global W1HubUnconfirmedReports_Bunker__Nudge = {
	name = "W1HubUnconfirmedReports_Bunker__Nudge",

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
				return b_collectible_used == false; -- GAMMA_TRANSITION: If vale
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Blue Team's not here. We better keep searching this structure.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_05700.sound'),

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

function nar_lava_elevator_start()
SleepUntil([|  volume_test_players(VOLUMES.tv_ur_elevator_lava_full) ], 1);
NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_Bunker__Lava_descent);
b_lava_elevator_used = true;
CreateThread(unconfirmed_idle_chatter_off);
CreateThread(audio_unconfirmedreports_thread_up_elevator_start);
end

global W1HubUnconfirmedReports_Bunker__Lava_descent = {
	name = "W1HubUnconfirmedReports_Bunker__Lava_descent",
	canStartOnce = true,
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
			hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,
			
			text = "Spartans, I'm losing your signal.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_sloan_01500.sound'),
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				hud_hide_radio_transmission_hud();
			end,
		},
		[2] = {

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 1.5,			
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Governor?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_08800.sound'),
		},
		[3] = {

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 1.5,				
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Privacy at last.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_09200.sound'),
		},
		[4] = {
		
	
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 1.5,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VaLE
			text = "This place is huge. Why wouldn't Sloan report a find of this size?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_07200.sound'),
		},
		
		[5] = {
	
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 1,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Mother hell... ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_07700.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 7;
			end,
		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 1,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Tanaka?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_08900.sound'),
		},
		[7] = {
	
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Just realized-- Buck was saying Blue Team didn't fight Prometheans? Well, they didn't have to sweet talk Sloan either.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_07800.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[8] = {

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
				sleepBefore = 1,				
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VaLE
			text = "You think Sloan let them down here?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_07300.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[9] = {

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Reckon it's a possibility.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_07900.sound'),
		},
		[10] = {

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
				sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "A possibility, yes, but not a certainty. If Sloan's hiding something, we'll draw it out of him after we investigate this structure.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_09100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		CreateThread(nar_towarden_nudge_controller);
		
	end,

	localVariables = {},
};

function nar_descent_bottom_platform()
	SleepUntil( [| volume_test_players(VOLUMES.mysterious_platform_bottom) ],1);
	CreateThread(unconfirmed_idle_chatter_off);
	b_passed_into_warden = true;
end

function nar_enter_wardenroom()
	SleepUntil([| volume_test_players(VOLUMES.nar_enter_wardenroom) ], 1);
	b_passed_into_warden = true;

end

function nar_cinematic_01_start()
		NarrativeQueue.InterruptConversation(W1HubUnconfirmedReports_Bunker__Lava_descent);
	NarrativeQueue.InterruptConversation(W1HubUnconfirmedReports_Bunker__Nudge);
	NarrativeQueue.InterruptConversation(W1HubUnconfirmedReports_team_chatter_1);
	NarrativeQueue.InterruptConversation(W1HubUnconfirmedReports_team_chatter_2);
	NarrativeQueue.InterruptConversation(W1HubUnconfirmedReports_team_chatter_3);
	NarrativeQueue.InterruptConversation(W1HubUnconfirmedReports_team_chatter_4);
end




-- =================================================================================================
-- =================================================================================================
-- =================================================================================================
--
--			CAVALIER ROOM
--
-- Covers content in the Cavalier room.
--
-- =================================================================================================

function nar_unconfirmed_cavalier_room()
	NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_CAVALIER_Room__WARDEN_FIGHT);
	NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_Cavalier_room__FIRST_TIME_G_SYNCS);
	NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_Cavalier_fight_complete);
	--CreateThread(w1_unconfirmed_forerunner_01);
	object_create( "unconfirmed_collect_08" );
end

-- =================================================================================================
global W1HubUnconfirmedReports_CAVALIER_Room__WARDEN_FIGHT = {
	name = "W1HubUnconfirmedReports_CAVALIER_Room__WARDEN_FIGHT",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.tv_cav_fight_begin ) and gb_cav_fight_begin; -- GAMMA_CONDITION
	end,
			canStartOnce = true,
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 3,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
			ObjectiveShow(TITLES.ch_ur_ob_05);
	end,

	lines = {
		[1] = {

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BuCK
			text = "What is this guy? Where'd he come from.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_07700.sound'),
		},
		[2] = {

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Something new. Defend yourselves.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_08400.sound'),
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				hud_hide_radio_transmission_hud();
			end,
		},
		[3] = {

	sleepBefore = 1.5,
	character = AI.sq_cav_cavalier.cav,
			text = "You are not necessary to her plans. Leave now and be spared.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_fr_warden_00700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		CreateThread(warden_nudge_controller);
	end,

	localVariables = {},
};


function nar_warden_combat_taunts()
		--story_blurb_add("domain", "WARDEN rarr");
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_fr_warden_00700.sound'), nil);
		sleep_s(25);
		if (warden_combat_complete == false) then
		--story_blurb_add("domain", "WARDEN rarr");
			PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_fr_warden_00800.sound'), nil);
		else
			KillScript(nar_warden_combat_taunts);
		end
		sleep_s(30);
		if (warden_combat_complete == false) then
		--story_blurb_add("domain", "WARDEN rarr");
			PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_fr_warden_00900.sound'), nil);
		else
			KillScript(nar_warden_combat_taunts);
		end
		sleep_s(25);
		if (warden_combat_complete == false) then
		--story_blurb_add("domain", "WARDEN rarr");
			PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_fr_warden_01000.sound'), nil);
		else
			KillScript(nar_warden_combat_taunts);
		end
end

function warden_nudge_controller()
	sleep_s(90);
	if warden_combat_complete == false then
		CreateThread(w1_warden_nudge);
	end
end
	function w1_warden_nudge()
	
	if warden_combat_complete == false then 	
		NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_CAVALIER_Room__WARDEN_FIGHT_EXTENDED);
	end
	sleep_s(90);
	if warden_combat_complete == false then 
		NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_CAVALIER_Room__WARDEN_FIGHT_EXTENDED);
	end
	sleep_s(90);
	if warden_combat_complete == false then 
		NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_CAVALIER_Room__WARDEN_FIGHT_EXTENDED);
	end
	sleep_s(90);
	if warden_combat_complete == false then 
		NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_CAVALIER_Room__WARDEN_FIGHT_EXTENDED);
	end	
end
global W1HubUnconfirmedReports_CAVALIER_Room__WARDEN_FIGHT_EXTENDED = {
	name = "W1HubUnconfirmedReports_CAVALIER_Room__WARDEN_FIGHT_EXTENDED",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return locke_warden_line_played == false;
			end,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "He's heavily armored. We need to get fire on his back.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_09200.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				locke_warden_line_played = true;
				return 0;
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return vale_warden_line_played == false;
			end,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "His cores are clustered on his back. Get behind him and fire! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_07500.sound'),
							AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				vale_warden_line_played = true;
				return 0;
			end,
		},
		[3] = {

				If = function (thisLine, thisConvo, queue, lineNumber)
				return tanaka_warden_line_played == false;
			end,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TanaKA
			text = "Thing's tough, can't hit its cores from the front. Swing 'round the back and fire.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_08100.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				tanaka_warden_line_played = true;
				return 0;
			end,
		},
		[4] = {

			If = function (thisLine, thisConvo, queue, lineNumber)
				return buck_warden_line_played == false;
			end,
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Head-on attacks don't dent this guy. He must be vulnerable from the back.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_09300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				buck_warden_line_played = true;
				return 0;
			end,
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud(); -- VOID
	end,

	localVariables = {},
};


global W1HubUnconfirmedReports_Cavalier_room__FIRST_TIME_G_SYNCS = {
	name = "W1HubUnconfirmedReports_Cavalier_room__FIRST_TIME_G_SYNCS",
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
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Haven't seen a Forerunner do anything like that before.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_06000.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return false; -- GAMMA_TRANSITION: If buck
			end,

					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Haven't seen a Forerunner do anything like that before.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_06600.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
			
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return false; -- GAMMA_TRANSITION: If locke
			end,
			
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_show_radio_transmission_hud("locke_transmission_name");
end,
	character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "I haven't seen a Forerunner do anything like that before.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_07100.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return false; -- GAMMA_TRANSITION: If vale
			end,

		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_show_radio_transmission_hud("vale_transmission_name");
end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: ValE
			text = "I haven't seen a Forerunner do anything like that before.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_05500.sound'),

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

global W1HubUnconfirmedReports_Cavalier_fight_complete = {
	name = "W1HubUnconfirmedReports_Cavalier_fight_complete",
	CanStart = function (thisConvo, queue)
		return warden_combat_complete == true ; -- GAMMA_CONDITION
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

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "What the hell was that thing?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_08300.sound'),

		},
		[2] = {

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 1,			
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VaLE
			text = "The Warden Eternal... He said he served Cortana. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_01500.sound'),
							AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
							rumble_shake_small();
				
				--FX for earthquake
				CreateEffectGroup(EFFECTS.earthquake_fx_01);
				CreateEffectGroup(EFFECTS.earthquake_fx_02);
				CreateEffectGroup(EFFECTS.earthquake_fx_03);

				return 4;
			end,
		},
		[3] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 1,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Not any more, he doesn't. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_VO_SCR_W1HubUnconfirmedReports_UN_BUCK_08200.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				rumble_shake_large();
				CreateThread(audio_earthquake);
				--FX for earthquake
				CreateEffectGroup(EFFECTS.earthquake_fx_01);
				CreateEffectGroup(EFFECTS.earthquake_fx_02);
				CreateEffectGroup(EFFECTS.earthquake_fx_03);

				return 4; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--           Another earthquake. Energy surges through the room toward the
--           Guardian.

		[4] = {
			sleepBefore = 2.5,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Another quake.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_04500.sound'),
		},
		[5] = {

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Bad news. Should get moving.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_05100.sound'),
		},
		[6] = {

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "The Warden was protecting whatever lies beyond those doors.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_07300.sound'),
							AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[7] = {

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "He called it the Guardian. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_06800.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________
		[8] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return b_unconfirmed_complete == false;
			end,
                 

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 1,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Cortana is connected to this Guardian somehow, and that makes it the Master Chief's most likely target. We find it, we find him. Let's go.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_09300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		CreateThread(unconfirmed_post_warden_combat);
		b_ur_warden_chatter_done = true;
	end,

	localVariables = {},
};

function unconfirmed_post_warden_combat()
	
	sleep_s(2);
	--ObjectiveShow(TITLES.ch_ur_ob_complete);
	CreateThread(nar_intoguardian_nudge_controller);
end

function prowler_tracking_chatter_timer(timervalue:number):void
	PrintNarrative("Narrative START - Reset Chatter Timer");
--	CHATTER TIMER START
		n_tracking_chatter_timer = timervalue;		--	Time buffer until this Chatter
		repeat
			sleep_real_seconds_NOT_QUITE_RELEASE(1);
			n_tracking_chatter_timer = n_tracking_chatter_timer - 1;
			b_temp_line_display_blurb_force = true; print("Chatter Timer: ", n_tracking_chatter_timer);
		until n_tracking_chatter_timer <= 1;
--	CHATTER TIMER END
	PrintNarrative("Narrative END - Reset Chatter Timer");
end

function nar_intoguardian_nudge_controller()
	sleep_s(45);
	SleepUntil( [| b_collectible_used == false and b_unconfirmed_complete == false], 1);
	NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_CAVALIER_ROOM___NUDGE);
		--story_blurb_add("domain", "NUDGE");
end

global W1HubUnconfirmedReports_CAVALIER_ROOM___NUDGE = {
	name = "W1HubUnconfirmedReports_CAVALIER_ROOM___NUDGE",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
				If = function (thisLine, thisConvo, queue, lineNumber)
				return b_collectible_used == false and b_unconfirmed_complete == false; -- GAMMA_TRANSITION: If vale
			end,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "The Warden said Master Chief was authorized to access this Guardian. I'd like to know what that means.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_locke_07500.sound'),
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


-- =================================================================================================
--
--					SECONDARY AUDIO LOGS
--
-- Audio Log Content	
--
-- =================================================================================================


-- =================================================================================================

--==========================================================================
--					CHATTER
--==========================================================================

function unconfirmed_idle_chatter_start()
	b_unconfirmed_idle_chatter_on = true;
	PrintNarrative("Enabled Idle Chatter");
	--story_blurb_add("domain", "chatter on");		
	sleep_rand_s(45, 65);
	SleepUntil( [| b_collectible_used == false ], 1);

	if b_unconfirmed_idle_chatter_on then 
	
		if  b_unconfirmed_chatter_3_played == true and b_unconfirmed_chatter_4_played == false and b_unconfirmed_idle_chatter_on == true then
			NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_team_chatter_4);
			b_unconfirmed_chatter_4_played = true;
		elseif b_unconfirmed_chatter_2_played == true and b_unconfirmed_chatter_3_played == false and b_unconfirmed_idle_chatter_on == true then
			NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_team_chatter_3);
			b_unconfirmed_chatter_3_played = true;
		elseif b_unconfirmed_chatter_1_played == true and b_unconfirmed_chatter_2_played == false and b_unconfirmed_idle_chatter_on == true then
			NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_team_chatter_2);
			b_unconfirmed_chatter_2_played = true;
		elseif b_unconfirmed_chatter_1_played == false and b_unconfirmed_idle_chatter_on == true then
			NarrativeQueue.QueueConversation(W1HubUnconfirmedReports_team_chatter_1);
			b_unconfirmed_chatter_1_played = true;
		end
	end
end

function unconfirmed_idle_chatter_off()
	PrintNarrative("Killed Idle Chatter");
	KillScript(unconfirmed_idle_chatter_start);
	b_unconfirmed_idle_chatter_on = false;	
	NarrativeQueue.EndConversationEarly(W1HubUnconfirmedReports_team_chatter_1);
	NarrativeQueue.EndConversationEarly(W1HubUnconfirmedReports_team_chatter_2);
	NarrativeQueue.EndConversationEarly(W1HubUnconfirmedReports_team_chatter_3);
	NarrativeQueue.EndConversationEarly(W1HubUnconfirmedReports_team_chatter_4);
end

global W1HubUnconfirmedReports_team_chatter_1 = {
	name = "W1HubUnconfirmedReports_team_chatter_1",
	CanStart = function (thisConvo, queue)
		return unit_get_health( SPARTANS.tanaka) > 0 and unit_get_health( SPARTANS.buck) > 0 and unit_get_health( SPARTANS.vale) > 0 and b_collectible_used ~= true; -- GAMMA_CONDITION
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
				return b_unconfirmed_idle_chatter_on == true;
			end,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "A lot of money going into this. Where's the profit?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_04300.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[2] = {
					If = function (self, queue, lineNumber) -- BOOLEAN
				return b_unconfirmed_idle_chatter_on == true;
			end,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BuCK
			text = "Sure your mom was signal intelligence? You sound like a banker's daughter.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_05400.sound'),
		},
		[3] = {
					If = function (self, queue, lineNumber) -- BOOLEAN
				return b_unconfirmed_idle_chatter_on == true;
			end,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Liang Dortmund pays a couple generations of chumps to break off the glass, then has land rights to an entire planet. It's the long con. But it'll pay.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_04900.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		--[[]]
	end,

};


global W1HubUnconfirmedReports_team_chatter_2 = {
	name = "W1HubUnconfirmedReports_team_chatter_2",
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
			If = function (self, queue, lineNumber) -- BOOLEAN
				return b_unconfirmed_idle_chatter_on == true;
			end,


						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Don't make sense Sloan's people going into the mountain. They were supposed to be chipping off the glass, not digging in the dirt.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_05200.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[2] = {
			If = function (self, queue, lineNumber) -- BOOLEAN
				return b_unconfirmed_idle_chatter_on == true;
			end,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Sounds like an object lesson in properly following orders.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_05800.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		b_unconfirmed_idle_chatter_on = false;
	end,

	localVariables = {},
};

--[========================================================================[
          Glasslands. Team chatter #2

          In this scene:

          * PROGRESSIVE CHATTER FOR LINGERING IN AREAS.
--]========================================================================]


--[========================================================================[
          Glasslands. Team chatter #3

          In this scene:

          * PROGRESSIVE CHATTER FOR LINGERING IN AREAS.
--]========================================================================]
global W1HubUnconfirmedReports_team_chatter_3 = {
	name = "W1HubUnconfirmedReports_team_chatter_3",

	CanStart = function (thisConvo, queue)
		return unit_get_health( SPARTANS.buck) > 0 and unit_get_health( SPARTANS.vale) > 0 and b_collectible_used ~= true; -- GAMMA_CONDITION
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
				return b_unconfirmed_idle_chatter_on == true;
			end,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Never been a place with an AI for a Governor. Not sure how I feel about it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_07800.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[2] = {
		If = function (self, queue, lineNumber) -- BOOLEAN
				return b_unconfirmed_idle_chatter_on == true;
			end,
			sleepBefore = 0.5,			

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "It looked like he was holding things together.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_06600.sound'),

		},
		[3] = {
		If = function (self, queue, lineNumber) -- BOOLEAN
				return b_unconfirmed_idle_chatter_on == true;
			end,
			sleepBefore = 0.5,			

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Sure, seems like it would work out most of the time. That is til a call had to be made that I don't think I'd want a machine making.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_07900.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		b_unconfirmed_idle_chatter_on = false;
	end,

	localVariables = {},
};

--[========================================================================[
          Glasslands. TEam chatter #4

          In this scene:

          * PROGRESSIVE CHATTER FOR LINGERING IN AREAS.
--]========================================================================]
global W1HubUnconfirmedReports_team_chatter_4 = {
	name = "W1HubUnconfirmedReports_team_chatter_4",

	CanStart = function (thisConvo, queue)
		return unit_get_health( SPARTANS.tanaka) > 0 and unit_get_health( SPARTANS.buck) > 0 and unit_get_health( SPARTANS.vale) > 0 and b_collectible_used ~= true; -- GAMMA_CONDITION
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
				return b_unconfirmed_idle_chatter_on == true;
			end,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "What do people usually eat way out here?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_06700.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[2] = {
		If = function (self, queue, lineNumber) -- BOOLEAN
				return b_unconfirmed_idle_chatter_on == true;
			end,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
sleepBefore = 0.5,
	character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Similar to military rations. Food that don't go bad too quick.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_07100.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[3] = {
		If = function (self, queue, lineNumber) -- BOOLEAN
				return b_unconfirmed_idle_chatter_on == true;
			end,
		sleepBefore = 0.5,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Taste any better?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_vale_06800.sound'),
				AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[4] = {
		If = function (self, queue, lineNumber) -- BOOLEAN
				return b_unconfirmed_idle_chatter_on == true;
			end,
		sleepBefore = 0.5,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Nope.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_tanaka_07200.sound'),
		},
		[5] = {
		If = function (self, queue, lineNumber) -- BOOLEAN
				return b_unconfirmed_idle_chatter_on == true;
			end,
			sleepBefore = 0.5,

						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "After his many years of human progress, you think we'd have figured out the recipe for the perfect MRE.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1hubunconfirmedreports\001_vo_scr_w1hubunconfirmedreports_un_buck_08000.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		b_unconfirmed_idle_chatter_on = false;
	end,

	localVariables = {},
};


--==========================================================================
--					HUD STUFF
--==========================================================================

function nar_switch_hud_test()
	hud_show_radio_transmission_hud("tanaka_transmission_name");
	sleep_s(3);
	hud_show_radio_transmission_hud("vale_transmission_name");
end

function nar_switch_hud_to_tanaka()
	hud_hide_radio_transmission_hud();
	hud_show_radio_transmission_hud("tanaka_transmission_name");
end

function nar_switch_hud_to_vale()
	hud_hide_radio_transmission_hud();
	hud_show_radio_transmission_hud("vale_transmission_name");
end

function nar_switch_hud_to_buck()
	hud_hide_radio_transmission_hud();
	hud_show_radio_transmission_hud("buck_transmission_name");
end

function nar_switch_hud_to_locke()
	hud_hide_radio_transmission_hud();
	hud_show_radio_transmission_hud("locke_transmission_name");
end

function nar_switch_hud_to_sloan()
	hud_hide_radio_transmission_hud();
	hud_show_radio_transmission_hud("sloan_transmission_name");
end

--==========================================================================
--					CAMERA SHAKES!!!!!
--==========================================================================

--## CLIENT

function remoteClient.pip_unconfirmed_inteldownload_60()
	hud_play_pip_from_tag(TAG('bink\campaign\pip_unconfirmed_inteldownload_60.bink'));
end

function remoteClient.nar_test_bink2()
	hud_play_pip_from_tag(TAG('bink\campaign\pip_unconfirmed_inteldownload_60.bink'));
end

function remoteClient.f_shake_cam()
	camera_shake_all_coop_players_start (0.6, 0.6);
	sleep_s(2);
	camera_shake_all_coop_players_stop(0.2);
end

function camera_shake_all_coop_players_start (attack, intensity):void
	print ("SHAKE START");
	for key,value in pairs(players()) do
		player_shake (value, attack, intensity);
	end
end

function camera_shake_all_coop_players_stop (decay):void
	print ("SHAKE STOP");
	for key,value in pairs(players()) do
		print (value);
		player_shake_stop (value, decay);
	end
end

function player_shake (p_player, attack, intensity):void
	player_effect_set_max_rotation_for_player (p_player, (intensity*3), (intensity*3), (intensity*3));
	player_effect_set_max_rumble_for_player (p_player, 1, 1);
	player_effect_start_for_player (p_player, intensity, attack);
end

function player_shake_stop (p_player, decay):void
	player_effect_set_max_rumble_for_player (p_player, 0, 0);
	player_effect_stop_for_player (p_player, decay);
end