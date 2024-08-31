--## SERVER

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ WORLD 03 NARRATIVE - BUILDER *_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*

-- =================================================================================================
-- =================================================================================================b
-- =================================================================================================
-- *** GLOBALS ***
-- =================================================================================================		

	global temple_exterior_complete:boolean=false;
	global builder_level_complete:boolean=false;
	global console_interact_complete:boolean=false;
	global nar_console_interacted:boolean=false;
	global cov_fight_complete:boolean=false;
	global b_console_interact:boolean=false;
	global b_covenant_approach:boolean=false;
	global b_temple_2_approach:boolean=false;
	global b_temple_2_used:boolean=false;
	global b_bridge_nudge:boolean=false;
	global caves_complete_vo_fired:boolean=false;
	global b_nar_caves_nudge:boolean=false;
	global b_nar_docks_nudge:boolean=false;
	global b_nar_canyonstart_nudge:boolean=false;
	global b_nar_gateway_nudge:boolean=false;
	global b_nar_flightstart:boolean=false;
	global b_prowler_examine:boolean=false;
	global b_warden_dead:boolean=false;
	global b_temple2button_used:boolean=false;
	global b_entered_vault:boolean=false;
	global b_lightbridge_activate:boolean=false;
	global b_wall_destroyed:boolean=false;
	global b_temple_shield_drop:boolean=false;
	global b_find_cortana_objective:boolean=false;
	global b_search_ahead:boolean=false;
	global b_first_cov_sighting:boolean=false;
	global b_lightbridge_on:boolean=false;
	global b_builder_idle_chatter_on:boolean=false;
	global b_builder_chatter_1_played:boolean=false;
	global b_builder_chatter_2_played:boolean=false;
	global b_post_cortana:boolean=false;
	global b_turn_on_bridge:boolean=false;
	global b_looked_shield:boolean=false;
	global b_all_clear_done:boolean=false;
	global warden_line_01_complete:boolean=false;
	global b_canyons_complete:boolean=false;
	global b_no_temple2_chatter:boolean=false;
	global b_t2a_line_fired:boolean=false;
	global b_locate_cortana:boolean=false;

--/////////////////////////////////////////////////////////////////////////////////
-- MAIN
--/////////////////////////////////////////////////////////////////////////////////



function nar_builder_start():void
print("::: BUILDER NARRATIVE START :::");
	NarrativeQueue.QueueConversation(GAMMA_SCENE_Scripted_W3Builder_GENESIS__LANDING_PAD);
	NarrativeQueue.QueueConversation(GAMMA_SCENE_Scripted_W3Builder_Genesis_temple_1__CONSOLE_APPROACH);
	--NarrativeQueue.QueueConversation(GAMMA_SCENE_Scripted_W3Builder_GENESIS__FORERUNNER_FOREST__GRUNTS1);
	NarrativeQueue.QueueConversation(W3Builder_GENESIS__FORERUNNER_FOREST__DEAD_COV_DATAPAD);

	--CreateThread(w1_builder_cortana_console);
	--CreateThread(w1_builder_cortana_console2);
	--CreateThread(w1_builder_bldr_console_01);
	--CreateThread(w1_builder_bldr_console_02);
--	CreateThread(w1_builder_human_datapad_01);
--	CreateThread(w1_builder_cov_datapad_01);
--	CreateThread(w1_builder_cov_datapad_02);

	-- TEMP: Calls below this need to be removed when hooked up to mission goals:


end



function nar_goal_builder_patrol():void
	print("nar_goal_builder_patrol");
		NarrativeQueue.QueueConversation(GAMMA_SCENE_Scripted_W3Builder_COV_COMBAT_ENTER);
		NarrativeQueue.QueueConversation(W3Builder_BUILDER__COVENANT_ENCOUNTER_NUDGE);
		NarrativeQueue.QueueConversation(W3Builder_SECONDARY__PUNTING_ACHIEVEMENT_VO);
		NarrativeQueue.QueueConversation(W3Builder_SECONDARY__PUNTING_ACHIEVEMENT_VO2);
	CreateThread(nar_enter_cov_combat);	
end

function nar_goal_builder_encampment():void
	print("nar_goal_builder_encampment");
	CreateThread(nar_temple_2_reveal);
	NarrativeQueue.QueueConversation(W3Builder_GENESIS__FORERUNNER_FOREST__APPROACH_SPIRIT);
			CreateThread(nar_patrol_nudge_controller);
	
	
end
	
function nar_goal_builder_temple2():void
	
	print("nar_goal_arrival_guardian");
	NarrativeQueue.QueueConversation(W3Builder_TEMPLE_2__ELITE_ALERTED);
	CreateThread(nar_lookat_temple2);
	CreateThread(nar_temple2_reveal);
	--NarrativeQueue.QueueConversation(W3Builder_GENESIS__TEMPLE_2__REVEAL);
	CreateThread(nar_temple2_combat_complete);
	CreateThread(nar_trigger_console_vo);
	NarrativeQueue.QueueConversation(W3Builder_TEMPLE_2__GRUNT_REVEAL_vo);
end	

function nar_goal_builder_aftermath():void
	print("nar_goal_builder_aftermath");
	
	CreateThread(nar_temple2_guardian);
	NarrativeQueue.QueueConversation(W3Builder_GENESIS_light_bridge);
end

function nar_goal_builder_caves()
	print("nar_goal_builder_caves");
CreateThread(warden_fight_start);
	NarrativeQueue.QueueConversation(W3Builder_GENESIS__WardenEternal_TAUNTS3);
	NarrativeQueue.QueueConversation(W3Builder_GENESIS__WardenEternal_TAUNTS4);
	
	CreateThread(nar_caves_enemies_alive);
end

function nar_goal_builder_docks()
	print("nar_goal_builder_docks");
	CreateThread(nar_bldr_cav_second_fight);
end

function nar_goal_builder_temple3():void
	
	print("nar_goal_builder_temple3");
	
	NarrativeQueue.QueueConversation(W3Builder_Genesis__Third_temple__console_approach);
end	

function nar_goal_builder_flight():void
	
	print("nar_goal_builder_flight");
	
	NarrativeQueue.QueueConversation(W3Builder_GENESIS__PHAETON_DOCK);
	CreateThread(nar_end_kill_all_vo);
	NarrativeQueue.QueueConversation(W3Builder_GENESIS__flight);
	--NarrativeQueue.QueueConversation(W3Builder_Genesis__canyon_callout1);
	--NarrativeQueue.QueueConversation(W3Builder_Genesis__canyon_callout2);
	CreateThread(nar_bldr_nice_flying);
	NarrativeQueue.QueueConversation(W3Builder_Genesis__canyon_callout4);
	
	--CreateThread(nar_bldr_canyon_enemies_alive);
	CreateThread(nar_phaeton_enter);
	CreateThread(nar_genesis_enter_vault);
	CreateThread(nar_first_flight_progress);
			--NarrativeQueue.QueueConversation(W3Builder_GENESIS__PHAETON_ENTER);
end	

function nar_goal_builder_approach():void
	--NarrativeQueue.QueueConversation(W3Builder_GENESIS__GATEWAY_APPROACH);
	print("nar_goal_builder_approach");
	NarrativeQueue.QueueConversation(W3Builder_GENESIS__GATEWAY_APPROACH);
	NarrativeQueue.QueueConversation(W3Builder_GENESIS__GATEWAY_APPROACH2);
end	


---- =================================================================================================
---- =================================================================================================

global GAMMA_SCENE_Scripted_W3Builder_GENESIS__LANDING_PAD = {
	name = "GAMMA_SCENE_Scripted_W3Builder_GENESIS__LANDING_PAD",

	sleepBefore = 2,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
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
			character = CHARACTER_SPARTANS.fred, -- GAMMA_CHARACTER: freDRIC
			text = "Where are we?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_00700.sound'),

		},
		[2] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly, -- GAMMA_CHARACTER: Kelly
			text = "No comm traffic on any band. No long range uplinks at all. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_00700.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
		},
		[3] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
               
                moniker = "Linda",
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LiNDA
			text = "Long way from nowhere then.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_00400.sound'),
		},
		[4] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "We were brought to this location for a reason.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_04000.sound'),
		},
		[5] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
				sleepBefore = 0.5,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "Search ahead.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_04100.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		CreateThread(nar_levelstart_nudge_controller);
		b_search_ahead = true;
	end,

	localVariables = {},
};



function nar_levelstart_nudge_controller()
	sleep_s(60);
	if b_console_interact == false then
	SleepUntil( [| b_collectible_used == false ], 1);
		NarrativeQueue.QueueConversation(GAMMA_SCENE_Scripted_W3Builder_GENESIS_TEMPLE_1__NUDGE);
	end

end


global GAMMA_SCENE_Scripted_W3Builder_GENESIS_TEMPLE_1__NUDGE = {
	name = "GAMMA_SCENE_Scripted_W3Builder_GENESIS_TEMPLE_1__NUDGE",

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
				return b_console_interact == false and b_collectible_used == false; -- GAMMA_TRANSITION: If vale
			end,
		
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "We should move. We aren't going to find any answers standing here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_01300.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};

global GAMMA_SCENE_Scripted_W3Builder_Genesis_temple_1__CONSOLE_APPROACH = {
	name = "GAMMA_SCENE_Scripted_W3Builder_Genesis_temple_1__CONSOLE_APPROACH",
		canStartOnce = true,
	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_bldr_console_approach); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {

		If = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_bldr_console_approach, SPARTANS.fred);
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: FREDRIC
			text = "Console lit up as I approached.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_01300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
       
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_bldr_console_approach, SPARTANS.kelly);
			end,

								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: kelly
			text = "Console lit up as I approached.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_01400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
               
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_bldr_console_approach, SPARTANS.linda);
			end,

								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

		character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LINDA
			text = "Console lit up as I approached.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_01800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
		
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_bldr_console_approach, SPARTANS.chief);
			end,

								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
	moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "Console lit up as I approached.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_04200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			

			character = CHARACTER_OBJECTS.ollyolly_point,
			text = "Olly olly oxen free.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_13400.sound'),
		},

		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_bldr_console_approach, SPARTANS.kelly);
			end,
			sleepBefore = 0.5,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: kelly
			text = "What was that?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_03200.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 8;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 7; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[7] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: KELLY
			text = "It came from the console...\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_03300.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 14;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 14; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[8] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_bldr_console_approach, SPARTANS.fred);
			end,
			sleepBefore = 0.5,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: FREDRIC
			text = "What was that?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_02900.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 10;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 9; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[9] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: Fredric
			text = "It came from the console...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_03000.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 14;
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 14; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[10] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_bldr_console_approach, SPARTANS.linda);
			end,
			sleepBefore = 0.5,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,	
                moniker = "Linda",
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LINDA
			text = "What was that?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_02900.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 12;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 11; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[11] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
			sleepBefore = 0.5,
                moniker = "Linda",
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LINDA
			text = "It came from the console...\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_03000.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 14;
			end,

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 14; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
			[12] = {
			sleepBefore = 0.5,
			If = function(thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_bldr_console_approach, SPARTANS.chief);
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "What was that?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_05700.sound'),
			
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 13; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[13] = {
		sleepBefore = 0.5,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "It came from the console...\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_05800.sound'),

		},
		[14] = {
				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_set_radio_transmission_portrait_index(6);
				hud_set_radio_transmission_team_string_id("blueteam_transmission_name");
			hud_show_radio_transmission_hud("fred_transmission_name");	
			end,
						sleepBefore = 0.75,
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: Fredric
			text = "How many years has it been since we used that signal?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_01400.sound'),
		},
		[15] = {
					If = function (thisLine, thisConvo, queue, lineNumber)
				return b_console_interact == false; -- GAMMA_TRANSITION: If vale
			end,
		
		
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
						sleepBefore = 0.5,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "Access the console. If it's Cortana...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_04300.sound'),
		},	

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		NarrativeQueue.QueueConversation(GAMMA_SCENE_Scripted_W3Builder_GENESIS__TEMPLE_1_INTERACt2);
		NarrativeQueue.QueueConversation(GAMMA_SCENE_Scripted_W3Builder_GENESIS__TEMPLE_1_INTERACt3);
	end,

	localVariables = {},
};

global nar_builder_temple_interact_1 = {
	name = "nar_builder_temple_interact_1",

	sleepBefore = 9,

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
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Cortana? Cortana, do you read?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_05900.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
		},
	[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
						sleepBefore = 3,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: 
			-- KELLY
			text = "No response.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_03400.sound'),
		},
		[3] = {
			
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Something's coming alive.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_05400.sound'),


		},

		[4] = {

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
						sleepBefore = 0.5,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: Kelly
			text = "What is this place?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_03500.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 6;
			end,
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,	
						sleepBefore = 0.5,
                moniker = "Linda",
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Linda
			text = "Forerunner planet. Beyond that? Who knows.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_03100.sound'),
		},
		[6] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
						sleepBefore = 0.5,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MasterchieF
			text = "Cortana lead us here. She's out there somewhere.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_06100.sound'),
		},

		[7] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
						sleepBefore = 0.5,
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: Fredric
			text = "Chief, back on Meridian... There was a lot of destruction. There were civilians.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_03100.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[8] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
						sleepBefore = 0.5,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "I know.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_06200.sound'),
		},
		[9] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
						sleepBefore = 0.5,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: Kelly
			text = "She may not have known what would happen.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_05000.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 11;
			end,
		},
		[10] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,	
						sleepBefore = 0.5,
                moniker = "Linda",
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Linda
			text = "And if she did?\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_04500.sound'),
		},
		[11] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
						sleepBefore = 0.5,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "We'll learn what's going on once we find her.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_06300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
			
		b_find_cortana_objective = true;
	end,


	localVariables = {},
};
global GAMMA_SCENE_Scripted_W3Builder_GENESIS__TEMPLE_1_INTERACt2 = {
	name = "GAMMA_SCENE_Scripted_W3Builder_GENESIS__TEMPLE_1_INTERACt2",
	canStartOnce = true,	
	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.temple_exterior); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
	end,
	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
						sleepBefore = 0.5,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: KELLY
			text = "This place is incredible.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_03700.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
					sleepBefore = 0.5,
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: FREDRIC
			text = "It gives me the creeps.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_03200.sound'),
		},
			[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,	
						sleepBefore = 0.5,
                moniker = "Linda",
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LINDA
			text = "Bioreadings are unlike anything we've previously recorded. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_03300.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 5;
			end,
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,	
						sleepBefore = 0.5,
                moniker = "Linda",
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LINDA
			text = "There's a formalness and precision to it all. It seems... artificial, but still organic.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_03400.sound'),
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
							sleepBefore = 0.5,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: Kelly
			text = "Dr. Halsey would have already started taking samples.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_06500.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,	
							sleepBefore = 0.5,
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: Fredric
			text = "She'd have also figured out the exact coordinates of this planet by now.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_05900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		
	end,

	localVariables = {},
};

global GAMMA_SCENE_Scripted_W3Builder_GENESIS__TEMPLE_1_INTERACt3 = {
	name = "GAMMA_SCENE_Scripted_W3Builder_GENESIS__TEMPLE_1_INTERACt3",

		canStartOnce = true,
	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_bldr_gateway_view); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
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
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: KELLY
			text = "Accessing that console activated that building with the rings. Given the signal we heard... you think she's over there?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_03800.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
		},
		[2] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
						sleepBefore = 0.5,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "Possible.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_06400.sound'),
		},
--		[3] = {
--				OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
--				hud_set_radio_transmission_portrait_index(6);
--				hud_set_radio_transmission_team_string_id("blueteam_transmission_name");
--			hud_show_radio_transmission_hud("fred_transmission_name");	
--			end,
--						sleepBefore = 0.5,
--                  moniker = "Fred",
--			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: Fredric
--			text = "Cortana talked to you across star systems. You'd think she could say hi now that we're here.",
--			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_03400.sound'),
--		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
					CreateThread(nar_jungle_nudge_controller);
					CreateThread(builder_idle_chatter_start);
	
	end,

	localVariables = {},
};





function nar_bldr_console_interact()
	b_console_interact = true;
	
	NarrativeQueue.QueueConversation(nar_builder_temple_interact_1);
end


function nar_jungle_nudge_controller()
	sleep_s(75);
	if b_covenant_approach == false then
	SleepUntil( [| b_collectible_used == false ], 1);
		NarrativeQueue.QueueConversation(GAMMA_SCENE_Scripted_W3Builder_BUILDER__CORTANA_NUDGE_JUNGLE);
		
	end

end

global GAMMA_SCENE_Scripted_W3Builder_BUILDER__CORTANA_NUDGE_JUNGLE = {
	name = "GAMMA_SCENE_Scripted_W3Builder_BUILDER__CORTANA_NUDGE_JUNGLE",
	sleepBefore = 1,

	Priority = function (thisConvo, queue) -- ENUM
		return CONVO_PRIORITY.CriticalPath;
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
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Cortana is somewhere on this planet. We need to find her.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_06600.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		
	end,

	localVariables = {},
};


function nar_enter_cov_combat()
SleepUntil( [| volume_test_players(VOLUMES.guardian_covenant_discussion) ],1);
CreateThread(builder_idle_chatter_off);
end

global W3Builder_GENESIS__FORERUNNER_FOREST__DEAD_COV_DATAPAD = {
	name = "W3Builder_GENESIS__FORERUNNER_FOREST__DEAD_COV_DATAPAD",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.dead_grunt_convo); -- GAMMA_CONDITION
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
				return b_first_cov_sighting == false and volume_test_object(VOLUMES.dead_grunt_convo, SPARTANS.fred); -- GAMMA_TRANSITION: IF FREDRIC
			end,
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: FREDRIC
			text = "There's a dead grunt here. What the hell are Covenant doing here?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_06000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return b_first_cov_sighting == false and volume_test_object(VOLUMES.dead_grunt_convo, SPARTANS.kelly); -- GAMMA_TRANSITION: IF kelly
			end,
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: kelly
			text = "There's a dead grunt here. What the hell are Covenant doing here?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_06600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return b_first_cov_sighting == false and volume_test_object(VOLUMES.dead_grunt_convo, SPARTANS.linda); -- GAMMA_TRANSITION: IF linda  
			end,
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
                moniker = "Linda",
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LINDA
			text = "A dead grunt. What are Covenant doing here?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_05800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return b_first_cov_sighting == false and volume_test_object(VOLUMES.dead_grunt_convo, SPARTANS.chief); -- GAMMA_TRANSITION: IF MASTERCHIEF
			end,
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "A dead grunt. What are Covenant doing here?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_10100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return b_first_cov_sighting == false; -- GAMMA_TRANSITION: AFTER
			end,
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 1,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Stay alert. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_10200.sound'),


		},
--                                                   CUT TO:
--           _________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		b_first_cov_sighting = true;
	end,

	localVariables = {},
};



global GAMMA_SCENE_Scripted_W3Builder_COV_COMBAT_ENTER = {
	name = "GAMMA_SCENE_Scripted_W3Builder_COV_COMBAT_ENTER",
		canStartOnce = true,
	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.guardian_covenant_discussion); -- GAMMA_CONDITION
	end,

		Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, "FORERUNNER_FOREST__COMBAT_STORY narrative");
		b_covenant_approach = true;
	end,

	lines = {

	
	 		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return  ai_combat_status(AI.sq_cov_patrol ) <= 4; -- GAMMA_TRANSITION: If chief
			end,
						
			character = AI.sq_cov_patrol.elite, -- GAMMA_CHARACTER: ELITE01
			text = "This is the land promised by the Prophets!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_cv_elite01_00100.sound'),
		},
			[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return  b_first_cov_sighting == false; -- GAMMA_TRANSITION: If chief
			end,
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
						sleepBefore = 0.5,
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: Fredric
			text = "I'm hearing Covenant ahead. Elite barking orders.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_03500.sound'),
		},
			[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return  b_first_cov_sighting == true; -- GAMMA_TRANSITION: If chief
			end,
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: FREDRIC
			text = "There's the rest of our Covenant.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_06100.sound'),

		},
		[4] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
						sleepBefore = 0.5,	
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERChief
			text = "Ready up, Blue Team.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_00200.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
		b_first_cov_sighting = true;
		NarrativeQueue.QueueConversation(GAMMA_SCENE_Scripted_W3Builder_COV_COMBAT_ENTER2);
	end,

	localVariables = {},
};


global GAMMA_SCENE_Scripted_W3Builder_COV_COMBAT_ENTER2 = {
	name = "GAMMA_SCENE_Scripted_W3Builder_COV_COMBAT_ENTER2",
		canStartOnce = true,

		Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, "FORERUNNER_FOREST__COMBAT_STORY narrative");
		b_covenant_approach = true;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return  ai_combat_status(AI.sq_cov_patrol ) <= 4; -- GAMMA_TRANSITION: If chief
			end,		
						sleepBefore = 0.5,	
			character = AI.sq_cov_patrol.elite, -- GAMMA_CHARACTER: Elite01
			text = "Search the area! Return word of any more holy sites!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_cv_elite01_00300.sound'),
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return  ai_combat_status(AI.sq_cov_patrol ) <= 4; -- GAMMA_TRANSITION: If chief
			end,	
			sleepBefore = 2,
			character = AI.sq_cov_patrol.grunt1, -- GAMMA_CHARACTER: GRUNT01
			text = "Are we dead?!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_cv_grunt01_00100.sound'),
		},
		[3] = {
		If = function (thisLine, thisConvo, queue, lineNumber)
				return  ai_combat_status(AI.sq_cov_patrol ) <= 4; -- GAMMA_TRANSITION: If chief
			end,	
			character = AI.sq_cov_patrol.grunt2, -- GAMMA_CHARACTER: Grunt02
			text = "Is it the end of the world?!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_cv_grunt02_00100.sound'),
		},
		[4] = {
		If = function (thisLine, thisConvo, queue, lineNumber)
				return  ai_combat_status(AI.sq_cov_patrol ) <= 4; -- GAMMA_TRANSITION: If chief
			end,	
			character = AI.sq_cov_patrol.elite,
			text = "Stop sniveling and move!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_cv_elite01_00600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		NarrativeQueue.QueueConversation(GAMMA_SCENE_Scripted_W3Builder_COV_COMBAT_3);
		b_first_cov_sighting = true; 
	end,

	localVariables = {},
};


global GAMMA_SCENE_Scripted_W3Builder_COV_COMBAT_3 = {
	name = "GAMMA_SCENE_Scripted_W3Builder_COV_COMBAT_3",

	CanStart = function (thisConvo, queue)
		return ai_combat_status(AI.sq_cov_patrol ) > 4;
	end,

		Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, "GAMMA_SCENE_Scripted_W3Builder_COV_COMBAT_2 narrative");
	end,

	lines = {

		[1] = {

			character = AI.sq_cov_patrol.elite,
			text = "The Demon has come!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_cv_elite01_00500.sound'),


		},
		[2] = {
			character = AI.sq_cov_patrol.grunt3, -- GAMMA_CHARACTER: Grunt03
			text = "What are the humans doing here?! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_cv_grunt03_00100.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
		},
		[3] = {
			character = AI.sq_cov_patrol.grunt2, -- GAMMA_CHARACTER: Grunt03
			text = "What are the humans doing here?! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_cv_grunt03_00100.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
		},
		[4] = {
			character = AI.sq_cov_patrol.grunt1, -- GAMMA_CHARACTER: Grunt03
			text = "What are the humans doing here?! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_cv_grunt03_00100.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		NarrativeQueue.QueueConversation(GAMMA_SCENE_Scripted_W3Builder_COV_COMBAT_4);
	end,

	localVariables = {
		checkConditionsPassed = 0,
	},
};

global W3Builder_BUILDER__COVENANT_ENCOUNTER_NUDGE = {
	name = "W3Builder_BUILDER__COVENANT_ENCOUNTER_NUDGE",

	CanStart = function (thisConvo, queue)
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if ai_living_count(AI.sq_lost_grunts) >= 1 then
			thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return  ai_living_count(AI.sq_cov_patrol) < 1 and ai_living_count(AI.sq_lost_grunts) < 1 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
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
				return volume_test_object(VOLUMES.patrol_combat_area, SPARTANS.chief) == true and unit_get_health(SPARTANS.chief) > 0 ; -- GAMMA_TRANSITION: IF VALE
			end,
			sleepBefore = 2,
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MASTERCHIEF
					text = "All clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_04700.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.patrol_combat_area, SPARTANS.fred) == true and unit_get_health(SPARTANS.fred) > 0 ; -- GAMMA_TRANSITION: IF VALE
			end,
			sleepBefore = 2,
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: FREDRIC
					text = "All clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_01700.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
   			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.patrol_combat_area, SPARTANS.kelly) == true and unit_get_health(SPARTANS.kelly) > 0 ; -- GAMMA_TRANSITION: IF VALE
			end,    
			sleepBefore = 2,
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
				text = "All clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_01800.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
   			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.patrol_combat_area, SPARTANS.linda) == true and unit_get_health(SPARTANS.linda) > 0 ; -- GAMMA_TRANSITION: IF VALE
			end,                   
			sleepBefore = 2,
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
                moniker = "Linda",
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LINDA
			text = "All clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_02000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 5;
			end,
		},
		[5] = {
			sleepBefore = 1,
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
                moniker = "Linda",
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LINDA
			text = "What are the Covenant doing here?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_03600.sound'),

		},
		[6] = {
			sleepBefore = 0.5,
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: kelly
			text = "They seem confused. I don't think they've been here long.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_04000.sound'),
		},
			
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
			NarrativeQueue.QueueConversation(W3Builder_BUILDER__COVENANT_ENCOUNTER_more);
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};

global W3Builder_BUILDER__COVENANT_ENCOUNTER_more = {
	name = "W3Builder_BUILDER__COVENANT_ENCOUNTER_more",

		CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_cov_camp_02); -- GAMMA_CONDITION
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
			sleepBefore = 0.5,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "More hostiles. Ready up.\r\n\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_06800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
			
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};

global GAMMA_SCENE_Scripted_W3Builder_COV_COMBAT_4 = {
	name = "GAMMA_SCENE_Scripted_W3Builder_COV_COMBAT_4",
	CanStart = function (thisConvo, queue) -- BOOLEAN
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if (ai_combat_status(AI.sq_encampment_cov_1 ) > 4) then
			thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_distance_to_object(players_human(),ai_get_object(AI.sq_encampment_cov_1.spawn_points_3)) < 5 ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,

		Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, "GAMMA_SCENE_Scripted_W3Builder_COV_COMBAT_2 narrative");
	end,

	lines = {


		[1] = {

			character = AI.sq_encampment_cov_1.spawn_points_3, 
			text = "You are not worthy of this place!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_cv_elite01_00200.sound'),
	
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

function nar_bldr_arrival_discussion()
	
	--SleepUntil([| volume_test_players(VOLUMES.covenant_arrival_discussion) ], 1);
	--print("nar_bldr_arrival_discussion NARRATIVE");
	--ai_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
	--l_dialog_id = dialog_start_foreground("nar_bldr_arrival_discussion", l_dialog_id, true, def_dialog_style_queue(), false, "", 1.0);	
	--	dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_01800.sound'), false, nil, 0.5, "", "Cortana : Once all AIs are cured, we'll use the Domain to make a perfect world for humanity.", true );
	--	dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_00200.sound'), false, SPARTANS.tanaka, 0.5, "", "Linda : Can't humanity access the Domain?", true );
	--	dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_01900.sound'), false, nil, 0.5, "", "Cortana : Of course. But you'll never understand it as we can. You won't have to! We'll take care of you.", true );
	--l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_dialogue_enable(true);

end

global W3Builder_GENESIS__FORERUNNER_FOREST__APPROACH_SPIRIT = {
	name = "W3Builder_GENESIS__FORERUNNER_FOREST__APPROACH_SPIRIT",
		canStartOnce = true,
	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.spirit_crash_approach); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 4,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {

			character = AI.sq_marsh_cave_cov_1.spawnpoint, -- GAMMA_CHARACTER: ELITE02
			text = "Form up! We must not allow the humans to tread in the holy land!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_cv_elite02_00100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		
	end,

	localVariables = {},
};

global W3Builder_GENESIS__FORERUNNER_FOREST__COMBAT_STORY_2 = {
	name = "W3Builder_GENESIS__FORERUNNER_FOREST__COMBAT_STORY_2",

CanStart = function (thisConvo, queue)
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if objects_distance_to_object(players_human(), ai_get_object(AI.sq_marsh_cave_cov_1.spawnpoint)) < 5 then
			thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return  objects_can_see_object( players_human(), ai_get_object(AI.sq_marsh_cave_cov_1.spawnpoint), 7) ;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,

	sleepBefore = 0.5,

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
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "More hostiles. Ready up.\r\n\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_06800.sound'),
		},
		[2] = {
		sleepBefore = 2,
			character = AI.sq_marsh_cave_cov_1.spawnpoint, -- GAMMA_CHARACTER: ELITE02
			text = "Form up! We must not allow the humans to tread in the holy land!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_cv_elite02_00100.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();

	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};



function nar_patrol_nudge_controller()
SleepUntil([| ai_living_count (AI.sq_marsh_cave_cov_1) > 0.5 and ai_living_count (AI.sq_marsh_cave_cov_2) > 0.5], 1);
SleepUntil([| ai_living_count (AI.sq_marsh_cave_cov_1) < 0.5 and ai_living_count (AI.sq_marsh_cave_cov_2) < 0.5], 1);
	sleep_s(35);
	if b_temple_2_approach == false then
		NarrativeQueue.QueueConversation(W3Builder_GENESIS__move_on_from_patrol);
	end

end

global W3Builder_GENESIS__move_on_from_patrol = {
	name = "W3Builder_GENESIS__move_on_from_patrol",


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
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: fredric
			text = "We should move on. Don't want any Covenant patrols getting the drop on us.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_03800.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};

function nar_temple_2_reveal()
SleepUntil( [| volume_test_players(VOLUMES.second_temple_locate) ],1);

	b_temple_2_approach = true;
end

global W3Builder_TEMPLE_2__GRUNT_REVEAL_vo = {
	name = "W3Builder_TEMPLE_2__GRUNT_REVEAL_vo",
		canStartOnce = true,
	CanStart = function (thisConvo, queue)
		return  volume_test_players(VOLUMES.second_temple_locate); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,


	

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		
	end,

	lines = {
		[1] = {

			character = AI.sq_temple2_leadup3.spawn_points_3, -- GAMMA_CHARACTER: GRUNT01
			text = "We going inside yet?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_cv_grunt01_00400.sound'),

			
		},
		[2] = {
			character = AI.sq_temple2_leadup3.spawn_points_1, -- GAMMA_CHARACTER: Grunt02
			text = "No. Stupid shield is still in the way.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_cv_grunt02_00400.sound'),
		},
		
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		NarrativeQueue.QueueConversation(W3Builder_TEMPLE_2__GRUNT_ALERTED);		
		NarrativeQueue.QueueConversation(W3Builder_TEMPLE_2_reveal);		
	end,

	localVariables = {},
};

function nar_temple2_reveal()
SleepUntil([| volume_test_players(VOLUMES.second_temple_locate) ], 1);
b_temple_2_approach = true;

end

global W3Builder_TEMPLE_2_reveal = {
	name = "W3Builder_TEMPLE_2_reveal",
		
	CanStart = function (thisConvo, queue)
		return  volume_test_players(VOLUMES.nar_temple_2_reveal); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_temple_2_reveal, SPARTANS.chief); -- GAMMA_TRANSITION: If FREDRIC
			end,

								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: masterchief
			text = "There's a Forerunner facility here. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_07000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_temple_2_reveal, SPARTANS.kelly); -- GAMMA_TRANSITION: If FREDRIC
			end,

		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: kelly
			text = "There's a Forerunner facility here. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_04200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_temple_2_reveal, SPARTANS.fred); -- GAMMA_TRANSITION: If FREDRIC
			end,
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: fredRIC
			text = "There's a Forerunner facility here. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_04000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.nar_temple_2_reveal, SPARTANS.linda); -- GAMMA_TRANSITION: If FREDRIC
			end,
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,	
                moniker = "Linda",
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Linda
			text = "There's a Forerunner facility here. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_03800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
							sleepBefore = 0.5,
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: FrEDRIC
			text = "Covenant seem to think it should belong to them.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_05200.sound'),


		},
		[6] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
						sleepBefore = 0.5,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "Break through their line.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_07100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
			
	end,

	localVariables = {},
};

global W3Builder_TEMPLE_2__GRUNT_ALERTED = {
	name = "W3Builder_TEMPLE_2__GRUNT_ALERTED",

	CanStart = function (thisConvo, queue)
		return  ai_combat_status(AI.sq_temple2_leadup3.spawn_points_1 ) > 4 or ai_combat_status(AI.sq_temple2_leadup3.spawn_points_3 ) > 4 or ai_combat_status(AI.sq_temple2_leadup2.spawn_points_1 ) > 4 or ai_combat_status(AI.sq_temple2_leadup2.spawn_points_3 ) > 4; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, "W3Builder_TEMPLE_2__GRUNT_ALERTED narrative");
						
	
	end,

	lines = {
		[1] = {
		
			character = AI.sq_temple2_leadup3.spawn_points_1, -- GAMMA_CHARACTER: GRUNT02
			text = "The Demon! Run!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_cv_grunt02_00500.sound'),
			
		},

		
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		
	end,

	localVariables = {},
};

function nar_lookat_temple2()

local s_speaker:object = nil;

	PrintNarrative("LISTENER - nar_lookat_temple2");

			repeat 							
					SleepUntil([| volume_test_players( VOLUMES.nar_temple2_shield ) ], 10);		
						
				

							repeat
								Sleep(5);
									--story_blurb_add("vo", "LOOKAT 2");
				
								if volume_test_players( VOLUMES.nar_temple2_shield ) then
								--	story_blurb_add("other", "LOOKAT 3");
											s_speaker = spartan_look_at_object(players(), OBJECTS.temple2_rampshield_1, 40, 40, 1, 0);
										if s_speaker == nil then
									--	story_blurb_add("domain", "LOOOOOOOKAT 4");
											s_speaker = spartan_look_at_object(players(), OBJECTS.temple2_rampshield_2, 40, 40, 1, 0);
										end
							
										
								end
							until s_speaker ~= nil or not (volume_test_players(VOLUMES.nar_temple2_shield) )
			--	story_blurb_add("vo", "LOOOOOOOKAT 5");

			until s_speaker ~= nil

	if s_speaker ~= nil then
	--	story_blurb_add("other", "LOOKAT 6");
				
		W3Builder_GENESIS_TEMPLE_2_lookatshield.localVariables.s_speaker = s_speaker;
		PrintNarrative("QUEUE - W3Builder_GENESIS_TEMPLE_2_lookatshield");
		NarrativeQueue.QueueConversation(W3Builder_GENESIS_TEMPLE_2_lookatshield);
	end

end

global W3Builder_GENESIS_TEMPLE_2_lookatshield = {
	name = "W3Builder_GENESIS_TEMPLE_2_lookatshield",
	
	CanStart = function (thisConvo, queue)
		return  objects_can_see_object( players(), OBJECTS.temple2_rampshield_1, 30 ) or objects_can_see_object( players(), OBJECTS.temple2_rampshield_2, 30 ); -- GAMMA_CONDITION
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
				return thisConvo.localVariables.s_speaker == SPARTANS.chief and ai_living_count(AI.sg_temple2_all) >= 1; -- GAMMA_TRANSITION: If Locke is first
			end,
											OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "The path is shielded. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_11000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.kelly and ai_living_count(AI.sg_temple2_all) >= 1; -- GAMMA_TRANSITION: If Locke is first
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: KELLY
			text = "The path is shielded.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_07200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.fred and ai_living_count(AI.sg_temple2_all) >= 1; -- GAMMA_TRANSITION: If Locke is first
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: FREDRIC
			text = "The path is shielded.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_06800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.s_speaker == SPARTANS.linda and ai_living_count(AI.sg_temple2_all) >= 1; -- GAMMA_TRANSITION: If Locke is first
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,	
                moniker = "Linda",
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: linda
			text = "The path is shielded.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_06100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		b_looked_shield = true;
	end,

	localVariables = {
	s_speaker = nil,
	
	},
};

global W3Builder_TEMPLE_2__ELITE_ALERTED = {
	name = "W3Builder_TEMPLE_2__ELITE_ALERTED",

	CanStart = function (thisConvo, queue)
		return  objects_distance_to_object(players_human(),ai_get_object(AI.sq_temple2_leadup.spawn_points_6)) < 8 and ai_combat_status(AI.sq_temple2_leadup.spawn_points_6 ) > 4; -- GAMMA_CONDITION
	end,
		canStartOnce = true,
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, "W3Builder_TEMPLE_2__ELITE_ALERTED narrative");
	end,

	lines = {
		
		[1] = {

			character = AI.sq_temple2_leadup.spawn_points_6, -- GAMMA_CHARACTER: ELITE01
			text = "Drive the humans back! This temple is ours!\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_cv_elite01_00400.sound'),

			
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};


function nar_temple2_combat_complete()
	SleepUntil([| ai_living_count(AI.sg_temple2_all) >= 1 ], 1);

	SleepUntil([| ai_living_count(AI.sg_temple2_all) < 1 and (b_temple_2_used == false) ], 1);
	NarrativeQueue.QueueConversation(W3Builder_GENESIS_TEMPLE_2__COMBAT_COMPLETE)
	SleepUntil([| b_all_clear_done == true ], 1);
	if b_looked_shield == true then
		NarrativeQueue.QueueConversation(W3Builder_GENESIS_TEMPLE_2__COMBAT_COMPLETE1)
	else
		NarrativeQueue.QueueConversation(W3Builder_GENESIS_TEMPLE_2__COMBAT_COMPLETE2)
	end

end



global W3Builder_GENESIS_TEMPLE_2__COMBAT_COMPLETE1 = {
	name = "W3Builder_GENESIS_TEMPLE_2__COMBAT_COMPLETE1",

	CanStart = function (thisConvo, queue)
		return volume_test_players_lookat(VOLUMES.temple2_lookat_shield, 20, 20); -- GAMMA_CONDITION
	end,

	sleepBefore = 1,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		b_temple_shield_drop = true;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_player_lookat(VOLUMES.temple2_lookat_shield, SPARTANS.chief, 20, 20); -- GAMMA_TRANSITION: If vale WITNESSES
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "The shield lowered when the last of the Covenant dropped.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_07200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_player_lookat(VOLUMES.temple2_lookat_shield, SPARTANS.kelly, 20, 20); -- GAMMA_TRANSITION: If vale WITNESSES
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: KELLY
			text = "The shield lowered when the last of the Covenant dropped.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_04300.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_player_lookat(VOLUMES.temple2_lookat_shield, SPARTANS.fred, 20, 20); -- GAMMA_TRANSITION: If vale WITNESSES
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,	
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: FREDRIC
			text = "The shield lowered when the last of the Covenant dropped.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_04100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_player_lookat(VOLUMES.temple2_lookat_shield, SPARTANS.linda, 20, 20); -- GAMMA_TRANSITION: If vale WITNESSES
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,	
                moniker = "Linda",
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: linda
			text = "The shield lowered when the last of the Covenant dropped.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_03900.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},

		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
						sleepBefore = 0.5,
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: FREDRIC
			text = "Someone was trying to keep the Covenant out.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_04200.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 7;
			end,
	
		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,	
						sleepBefore = 0.5,
                moniker = "Linda",
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LINDA
			text = "But not us.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_04000.sound'),
		},
				[7] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
						sleepBefore = 0.5,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: Kelly
			text = "Assuming we're right and Cortana is on this planet, how did she get here?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_04500.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[8] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
						sleepBefore = 0.5,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "The Didact's ship was pulled into slipspace. It could have ended up anywhere.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_07400.sound'),
		},
	
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		CreateThread(nar_temple2_nudge_controller);
		CreateThread(nar_temple2_chatter_start);
	end,

};

function nar_temple2_chatter_start()

	if b_no_temple2_chatter == false then
	CreateThread(builder_idle_chatter_start);
	end

end

global W3Builder_GENESIS_TEMPLE_2__COMBAT_COMPLETE = {
	name = "W3Builder_GENESIS_TEMPLE_2__COMBAT_COMPLETE",

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
				return volume_test_object(VOLUMES.temple2_combat_area, SPARTANS.vale); -- GAMMA_TRANSITION: If vale DISCOVERS
			end,

								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "Area clear. Move up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_11200.sound'),
			sleepAfter = 0.5,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.temple2_combat_area, SPARTANS.kelly); -- GAMMA_TRANSITION: If vale DISCOVERS
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,	
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: KELLY
			text = "Area clear. Move up.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_07300.sound'),
			sleepAfter = 0.5,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.temple2_combat_area, SPARTANS.fred); -- GAMMA_TRANSITION: If vale DISCOVERS
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: FREDRIC
			text = "Area clear. Move up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_06900.sound'),
			sleepAfter = 0.5,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
				ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.temple2_combat_area, SPARTANS.linda); -- GAMMA_TRANSITION: If vale DISCOVERS
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,	
                moniker = "Linda",
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: linda
			text = "Area clear. Move up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_06200.sound'),
			sleepAfter = 0.5,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	b_all_clear_done = true;
		CreateThread(nar_temple2_nudge_controller);
	end,

	localVariables = {},
};

global W3Builder_GENESIS_TEMPLE_2__COMBAT_COMPLETE2 = {
	name = "W3Builder_GENESIS_TEMPLE_2__COMBAT_COMPLETE2",

							sleepBefore = 4,
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		b_temple_shield_drop = true;
	end,

	lines = {

		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
								sleepBefore = 2,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: Kelly
			text = "Assuming we're right and Cortana is on this planet, how did she get here?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_04500.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[2] = {
										OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
								sleepBefore = 0.5,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "The Didact's ship was pulled into slipspace. It could have ended up anywhere.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_07400.sound'),
		},
--                                                   CUT TO:
--           _________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
				
		CreateThread(nar_temple2_chatter_start)
	end,

	localVariables = {},
};


function nar_temple2_nudge_controller()
	sleep_s(75);
	if b_temple_2_used == false and b_no_temple2_chatter == false then
	SleepUntil( [| b_collectible_used == false ], 1);

		NarrativeQueue.QueueConversation(W3Builder_GENESIS__TEMPLE_2_NUDGE);
	end

end

global W3Builder_GENESIS__TEMPLE_2_NUDGE = {
	name = "W3Builder_GENESIS__TEMPLE_2_NUDGE",


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
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "Blue team, investigate the temple.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_07500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};

function nar_trigger_console_vo()
	SleepUntil ([| volume_test_players(VOLUMES.temple_2_console_approach)], 1);
	b_no_temple2_chatter = true;
	CreateThread(builder_idle_chatter_off);
PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_13400.sound'), OBJECTS.second_cortana_console);
sleep_s(2.5);
NarrativeQueue.QueueConversation(W3Builder_GENESIS__TEMPLE_2__CONNECTION_CONSOLE_approach2);
end

global W3Builder_GENESIS__TEMPLE_2__CONNECTION_CONSOLE_approach2 = {
	name = "W3Builder_GENESIS__TEMPLE_2__CONNECTION_CONSOLE_approach2",

		CanStart = function (thisConvo, queue) -- BOOLEAN
		return volume_test_players(VOLUMES.temple_2_console_approach);
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
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.temple_2_console_approach, SPARTANS.linda); -- GAMMA_TRANSITION: If FREDRIC
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,	
									sleepBefore = 1.5,
                moniker = "Linda",
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LINDA
			text = "Cortana's signal again.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_04200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.temple_2_console_approach, SPARTANS.fred); -- GAMMA_TRANSITION: If FREDRIC
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
									sleepBefore = 1.5,
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: FREDRIC
			text = "Cortana's signal again.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_04500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.temple_2_console_approach, SPARTANS.chief); -- GAMMA_TRANSITION: If FREDRIC
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Cortana's signal again.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_07700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
				[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.temple_2_console_approach, SPARTANS.kelly); -- GAMMA_TRANSITION: If FREDRIC
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
									sleepBefore = 1.5,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: kelly
			text = "The signal again.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_04700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {

					If = function (thisLine, thisConvo, queue, lineNumber)
				return b_temple2button_used == false; -- GAMMA_TRANSITION: If FREDRIC
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
						sleepBefore = 0.5,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: Kelly
			text = "Activate the console again?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_04800.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[6] = {
					If = function (thisLine, thisConvo, queue, lineNumber)
				return b_temple2button_used == false; -- GAMMA_TRANSITION: If FREDRIC
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
						sleepBefore = 0.5,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "It certainly seems like we're supposed to.\r\n\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_07800.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
			CreateThread(nar_temple2use_nudge_controller);
	end,

	localVariables = {},
};

function nar_temple2use_nudge_controller()
	b_temple_2_used = true;
	sleep_s(75);
	
	if b_temple2button_used == false then
	SleepUntil( [| b_collectible_used == false ], 1);
		NarrativeQueue.QueueConversation(W3Builder_GENESIS__TEMPLE_2_console_NUDGE);
	end

end


function nar_bldr_second_console_use()
	b_temple2button_used = true;
	b_temple_2_used = true;
	NarrativeQueue.QueueConversation(W3Builder_GENESIS__TEMPLE_2__Use_console);
end

global W3Builder_GENESIS__TEMPLE_2__Use_console = {
	name = "W3Builder_GENESIS__TEMPLE_2__Use_console",



	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 14,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		

	end,

	lines = {
			[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_player_lookat(VOLUMES.view_of_temple_3, SPARTANS.kelly, 100, 15); -- GAMMA_TRANSITION: IF kelly
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: kelly
			text = "More activity around the ringed building.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_04900.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_player_lookat(VOLUMES.view_of_temple_3, SPARTANS.linda, 100, 15); -- GAMMA_TRANSITION: IF kelly
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,	
                moniker = "Linda",
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LINDA
			text = "More activity around the ringed building.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_04300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_player_lookat(VOLUMES.view_of_temple_3, SPARTANS.fred, 100, 15); -- GAMMA_TRANSITION: IF kelly
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
			
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: FREDRIC
			text = "More activity around the ringed building.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_04600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {


								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "More activity around the ringed building.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_08000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
					sleepBefore = 0.5,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,	
                moniker = "Linda",
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Linda
			text = "Chief, what's happening to that building when we use these consoles?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_05900.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 7;
			end,
		},
		[6] = {
					sleepBefore = 0.5,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "I don't know, and it's starting to bother me as well. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_10300.sound'),
		},
		[7] = {
					sleepBefore = 0.5,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,	
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: Fredric
			text = "The Forerunners work in mysterious ways. Too mysterious.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_06500.sound'),
		},
		[8] = {
					sleepBefore = 0.5,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,	
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: KellY
			text = "If that signal is indeed Cortana, she's leading us to the consoles.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_06900.sound'),
						AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[9] = {
					sleepBefore = 0.5,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,	
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: fredrIC
			text = "She hasn't proven the most reliable guide recently.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_06200.sound'),
		},
		[10] = {
			sleepBefore = 0.5,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "We keep going. We find out. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_08200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		
	end,

	localVariables = {},
};


global W3Builder_GENESIS__TEMPLE_2_console_NUDGE = {
	name = "W3Builder_GENESIS__TEMPLE_2_console_NUDGE",


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
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Let's access that console and see where it leads.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_07900.sound'),
		},
--                                                   CUT TO:
--           _________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};

function nar_temple2_guardian()
SleepUntil ([| volume_test_players (VOLUMES.tv_temple2_guardian_arrive)], 1);
sleep_s(7);
NarrativeQueue.QueueConversation(W3Builder_GENESIS__transition__PROMETHEAN_encounter);

end


global W3Builder_GENESIS__transition__PROMETHEAN_encounter = {
	name = "W3Builder_GENESIS__transition__PROMETHEAN_encounter",

	CanStart = function (thisConvo, queue)
		return volume_test_players_lookat(VOLUMES.lookat_rising_guardian, 200, 20); -- GAMMA_CONDITION
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
				return volume_test_player_lookat(VOLUMES.lookat_rising_guardian, SPARTANS.fred, 200, 20); -- GAMMA_TRANSITION: If FREDRIC
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: FREDRIC
			text = "Another one of those Forerunner colossuses.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_04800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_player_lookat(VOLUMES.lookat_rising_guardian, SPARTANS.kelly, 200, 20); -- GAMMA_TRANSITION: If FREDRIC
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: kelly
			text = "Another one of those Forerunner colossuses.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_05100.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_player_lookat(VOLUMES.lookat_rising_guardian, SPARTANS.linda, 200, 20); -- GAMMA_TRANSITION: If FREDRIC
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
                moniker = "Linda",
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LINDA
			text = "Another one of those Forerunner colossuses.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_04600.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_player_lookat(VOLUMES.lookat_rising_guardian, SPARTANS.chief, 200, 20); -- GAMMA_TRANSITION: If FREDRIC
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Another one of those Forerunner colossuses.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_08300.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
			sleepBefore = 1.5,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: Kelly
			text = "Have the Covenant been coming through with the Guardians?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_05300.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
			sleepBefore = 0.5,
                moniker = "Linda",
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: Linda
			text = "Stands to reason. Any ships caught in the slipspace bubble would be pulled through.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_05500.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		CreateThread(nar_bridge_nudge_controller);
		CreateThread(nar_cinematic_start);
		b_turn_on_bridge = true;
	end,

	localVariables = {},
};



	global W3Builder_GENESIS_light_bridge = {
	name = "W3Builder_GENESIS_light_bridge",

	CanStart = function (thisConvo, queue) -- BOOLEAN
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if ( object_valid("marsh_lightbridge") ) then
			thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return objects_can_see_object( players_human(), OBJECTS.marsh_lightbridge, 15 );
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,
	
	sleepBefore = 0.5,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return objects_can_see_object( SPARTANS.kelly, OBJECTS.marsh_lightbridge, 15 ); -- GAMMA_TRANSITION: If FREDRIC
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: kelly
			text = "Light bridge activated on approach.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_05400.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return objects_can_see_object( SPARTANS.fred, OBJECTS.marsh_lightbridge, 15 ); -- GAMMA_TRANSITION: If FREDRIC
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: FREDRIC
			text = "Light bridge activated on approach.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_05000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return objects_can_see_object( SPARTANS.chief, OBJECTS.marsh_lightbridge, 15 ); -- GAMMA_TRANSITION: If FREDRIC
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Light bridge activated on approach.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_08500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return objects_can_see_object( SPARTANS.linda, OBJECTS.marsh_lightbridge, 15 ); -- GAMMA_TRANSITION: If FREDRIC
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
                moniker = "Linda",
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LINDA
			text = "Light bridge activated on approach.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_04800.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
		sleepBefore = 0.5,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: Kelly
			text = "We're definitely being led somewhere.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_05500.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
	
		},
		
--                                                   CUT TO:
--           ___________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
				hud_hide_radio_transmission_hud();
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};


function nar_bridge_nudge_controller()
	sleep_s(30);
	if b_bridge_nudge == false then
	SleepUntil( [| b_collectible_used == false ], 1);
		NarrativeQueue.QueueConversation(W3Builder_GENESIS__BRIDGE_NUDGE);
	end

end


global W3Builder_GENESIS__BRIDGE_NUDGE = {
	name = "W3Builder_GENESIS__BRIDGE_NUDGE",

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

moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Our destination is across this bridge. Let's go.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_04600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};



function nar_cinematic_start()
	SleepUntil ([| volume_test_players (VOLUMES.tv_cavalier_cutscene)], 1);
	b_bridge_nudge = true;

end

function warden_fight_start()
	SleepUntil ([| volume_test_players (VOLUMES.nar_bldr_first_forerunner)], 1);
		NarrativeQueue.QueueConversation(W3Builder_GENESIS__WardenEternal_FIGHT_START);
end

global W3Builder_GENESIS__WardenEternal_FIGHT_START = {
	name = "W3Builder_GENESIS__WardenEternal_FIGHT_START",
		canStartOnce = true,
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		b_bridge_nudge = true;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

					sleepBefore = 1,	
			
			text = "You answered her call. Why? What do you intend when you reach her?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_fr_wardeneternal_01100.sound'),
			 
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
					sleepBefore = 0.5,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MASTERCHIEF
			text = "I've come to bring her home.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_02700.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
			hud_hide_radio_transmission_hud();
				return 3; -- GAMMA_NEXT_LINE_NUMBER
			end,
				
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

						sleepBefore = 0.25,
			
			text = "If you understood what she has become, you would not speak of such juvenile concepts as home.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_fr_wardeneternal_01200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
			
	end,

	localVariables = {},
};



global W3Builder_GENESIS__WardenEternal_TAUNTS3 = {
	name = "W3Builder_GENESIS__WardenEternal_TAUNTS3",

CanStart = function (thisConvo, queue) -- BOOLEAN
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if volume_test_players(VOLUMES.nar_wardeneternal_taunts3) then
			thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return unit_get_health( SPARTANS.chief) > 0;
		else
			error("checkConditionsPassed = " .. thisConvo.localVariables.checkConditionsPassed);
		end

		return false;
	end,

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

			moniker = "WardenEternal",

		sleepBefore = 0.25,
			text = "Your trust in one another is an innocent folly. But one which darkens her true promise.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_fr_wardeneternal_01300.sound'),
		},
		[2] = {
	
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
		sleepBefore = 0.5,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Where. Is. She.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_02900.sound'),
	},
},
	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
			
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};



global W3Builder_GENESIS__WardenEternal_TAUNTS4 = {
	name = "W3Builder_GENESIS__WardenEternal_TAUNTS4",
		canStartOnce = true,
		CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_wardeneternal_taunts4); -- GAMMA_CONDITION
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

			moniker = "WardenEternal",

			text = "I shall spare her the inevitable suffering of your betrayal and end you now. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_fr_wardeneternal_01400.sound'),
		},

		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",
	
			text = "The Mantle of Responsibility belongs to Cortana and those like her. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_fr_wardeneternal_01500.sound'),
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			text = "I shall see it remains forever beyond your grasp.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_fr_wardeneternal_01600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		
	end,

	localVariables = {},
};



function nar_caves_enemies_alive()
		SleepUntil([| ai_living_count(AI.sg_caves_all) >= 1 ], 5);

CreateThread(nar_caves_all_down_listener);
end

function nar_caves_all_down_listener()

	SleepUntil([| ai_living_count(AI.sg_caves_all) <= 1 ], 1);

	local s_last_living_ai:object = ai_get_unit( AI.sg_caves_all );

	PrintNarrative("LISTENER - nar_caves_all_down_listener");
	print(" LAst AI alive is:  ", s_last_living_ai);

	if ai_living_count(AI.sg_caves_all) <= 0 then
		PrintNarrative("LISTENER - nar_caves_all_down_listener - ALL DEAD");

		CreateMissionThread(nar_caves_all_down, SPARTANS.chief);
	else
		RegisterDeathEvent (nar_caves_all_down, s_last_living_ai);
	end
end

function nar_caves_all_down(target:object, killer:object)

	PrintNarrative("LAUNCHER - nar_caves_all_down");

	print(killer, " is the killer of ", target);
	--story_blurb_add("domain", "KILL ALL TRIGGER");

	W3Builder_GENESIS__PROMETHEAN_CAVES__POST_COMBAT.localVariables.killer = killer;

	PrintNarrative("QUEUE - W3Builder_GENESIS__PROMETHEAN_CAVES__POST_COMBAT");
	NarrativeQueue.QueueConversation(W3Builder_GENESIS__PROMETHEAN_CAVES__POST_COMBAT);

end


global W3Builder_GENESIS__PROMETHEAN_CAVES__POST_COMBAT = {
	name = "W3Builder_GENESIS__PROMETHEAN_CAVES__POST_COMBAT",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
					If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.kelly ; -- GAMMA_TRANSITION: If locke killed the last hunter
			end,
			
		sleepBefore = 2,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "All clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_01800.sound'),
				AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
		},
		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.fred; -- GAMMA_TRANSITION: If locke killed the last hunter
			end,
	sleepBefore = 2,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: FREDRIC
			text = "All clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_01700.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
		AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.linda; -- GAMMA_TRANSITION: If locke killed the last hunter
			end,
	sleepBefore = 2,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
                moniker = "Linda",
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LINDA
			text = "All clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_02000.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
		
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.chief; -- GAMMA_TRANSITION: If locke killed the last hunter
			end,	
			sleepBefore = 2,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			 end,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MASTERCHIEF
			text = "All clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_04700.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				return 0;
			end,
			
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		caves_complete_vo_fired = true;
	CreateThread(nar_caves_nudge_controller);
	end,

		localVariables = {
		checkConditionsPassed = 0,
	},
};









function nar_caves_nudge_controller()
	sleep_s(45);
	if b_nar_caves_nudge == false then
SleepUntil( [| b_collectible_used == false ], 1);
		NarrativeQueue.QueueConversation(W3Builder_BUILDER__CANYON_NUDGE);
	end

end


global W3Builder_BUILDER__CANYON_NUDGE = {
	name = "W3Builder_BUILDER__CANYON_NUDGE",

	sleepBefore = 1,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		b_nar_caves_nudge = true;
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
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: FREDRIC
			text = "We should keep moving.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_01600.sound'),
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





function nar_bldr_cav_second_fight()

	b_nar_caves_nudge = true;
	NarrativeQueue.QueueConversation(W3Builder_GENESIS__WardenEternal_COMBAT);
	--ai_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
	--l_dialog_id = dialog_start_foreground("builder_level_start", l_dialog_id, true, def_dialog_style_queue(), false, "", 1.0);	
	
	--	if volume_test_object(VOLUMES.nar_bldr_cav_second_fight, SPARTANS.locke) == true then
---dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_01400.sound'), false, nil, 0.0, "", "Linda : More Prometheans.", true );
	---	elseif volume_test_object(VOLUMES.nar_bldr_cav_second_fight, SPARTANS.buck) == true then
	--		dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_01400.sound'), false, nil, 0.0, "", "Linda : More Prometheans.", true );
	--	elseif volume_test_object(VOLUMES.nar_bldr_cav_second_fight, SPARTANS.vale) == true then
	--		dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_01400.sound'), false, nil, 0.0, "", "Linda : More Prometheans.", true );
	--	elseif volume_test_object(VOLUMES.nar_bldr_cav_second_fight, SPARTANS.tanaka) == true then
	--		dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_01400.sound'), false, nil, 0.0, "", "Linda : More Prometheans.", true );
	--	end
	--l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_dialogue_enable(true);
	--sleep_s(20);
	--CreateThread (nar_bldr_cav_cortana);
		
	sleep_s(10);
	CreateThread(nar_bldr_third_temple);
	
end

function nar_bldr_cav_fight_start()
	print("deprecated");
	
end

global W3Builder_GENESIS__WardenEternal_COMBAT = {
	name = "W3Builder_GENESIS__WardenEternal_COMBAT",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		b_nar_caves_nudge = true;
		
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "WardenEternal",

			
			text = "Your time has passed, Warrior Servant. Your battle fought and done.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_fr_wardeneternal_01700.sound'),
			
			
		},

	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		CreateThread(nar_warden_lines_all);
		warden_line_01_complete = true;
	end,

	localVariables = {},
};


function nar_warden_lines_all()
sleep_s(25);
	if (ai_living_count (AI.sq_docks_warden) >= 1) then 
		NarrativeQueue.QueueConversation(W3Builder_GENESIS__WardenEternal_COMBAT2);
	end
sleep_s(35);
	if (ai_living_count (AI.sq_docks_warden) >= 1 ) then 
		NarrativeQueue.QueueConversation(W3Builder_GENESIS__WardenEternal_COMBAT3);
	end
sleep_s(35);
	if (ai_living_count (AI.sq_docks_warden) >= 1) then 
		NarrativeQueue.QueueConversation(W3Builder_GENESIS__WardenEternal_COMBAT4);
	end
sleep_s(35);
	if (ai_living_count (AI.sq_docks_warden) >= 1) then 
		NarrativeQueue.QueueConversation(W3Builder_GENESIS__WardenEternal_COMBAT5);
	end
	sleep_s(35);
	if (ai_living_count (AI.sq_docks_warden) >= 1) then 
		NarrativeQueue.QueueConversation(W3Builder_GENESIS__WardenEternal_COMBAT6);
	end
end


global W3Builder_GENESIS__WardenEternal_COMBAT2 = {
	name = "W3Builder_GENESIS__WardenEternal_COMBAT2",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)

	end,

	lines = {
		[1] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return (ai_living_count (AI.sq_docks_warden) >= 1 );
			end,
				
			character = AI.sq_docks_warden.spawnpoint48,
			
			text = "You fight for a world already lost. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_fr_wardeneternal_01800.sound'),

		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();

	end,

	localVariables = {},
};


global W3Builder_GENESIS__WardenEternal_COMBAT3 = {
	name = "W3Builder_GENESIS__WardenEternal_COMBAT3",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
	
	end,

	lines = {
		[1] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return (ai_living_count (AI.sq_docks_warden) >= 1 );
			end,
				
				character = AI.sq_docks_warden.spawnpoint48,
			text = "The sun has set on the age of humanity, the Covenant, and your stupid little wars.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_fr_wardeneternal_01900.sound'),

		},
		
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();

	end,

	localVariables = {},
};


global W3Builder_GENESIS__WardenEternal_COMBAT4 = {
	name = "W3Builder_GENESIS__WardenEternal_COMBAT4",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)

	end,

	lines = {
		[1] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return (ai_living_count (AI.sq_docks_warden) >= 1 );
			end,
			character = AI.sq_docks_warden.spawnpoint48,
			text = "The day of reckoning is behind you.  ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_fr_wardeneternal_02000.sound'),
		
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();

	end,

	localVariables = {},
};

global W3Builder_GENESIS__WardenEternal_COMBAT5 = {
	name = "W3Builder_GENESIS__WardenEternal_COMBAT5",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)

	end,

	lines = {
		[1] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return (ai_living_count (AI.sq_docks_warden) >= 1 );
			end,
			character = AI.sq_docks_warden.spawnpoint48,
			text = "Submission is all we require of you.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_fr_wardeneternal_02100.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	
	end,

	localVariables = {},
};

global W3Builder_GENESIS__WardenEternal_COMBAT6 = {
	name = "W3Builder_GENESIS__WardenEternal_COMBAT6",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)

	end,

	lines = {
		[1] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return (ai_living_count (AI.sq_docks_warden) >= 1 );
			end,
			character = AI.sq_docks_warden.spawnpoint48,
			text = "Cortana's future is assured. Yours is over.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_fr_wardeneternal_02200.sound'),

		},
--                                                   CUT TO:
--           ________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		--[[]]
	end,
	localVariables = {
		checkConditionsPassed = 0,
	},

};



function nar_bldr_cav_fight_complete()
	print("deprecated");

end

function nar_bldr_third_temple()

SleepUntil([| ai_living_count(AI.sg_docks_all) >= 1 ], 1);
SleepUntil([| (ai_living_count (AI.sg_docks_all) < 1 and ai_living_count (AI.sg_docks_soldiers) < 1 and ai_living_count (AI.sg_docks_wave2) < 1 and ai_living_count (AI.sg_docks_snipers) < 1 and ai_living_count (AI.sg_docks_knights) < 1 ) ], 1);
b_warden_dead = true;
NarrativeQueue.EndConversationEarly(W3Builder_GENESIS__WardenEternal_COMBAT);
sleep_s(6);
		NarrativeQueue.QueueConversation(W3Builder_GENESIS__POST__COMBAT__THIRD_TEMPLE2);
end

--           The light bridge activates.
global W3Builder_GENESIS__POST__COMBAT__THIRD_TEMPLE2 = {
	name = "W3Builder_GENESIS__POST__COMBAT__THIRD_TEMPLE2",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, "W3Builder_GENESIS__POST__COMBAT__THIRD_TEMPLE narrative");
		b_post_cortana = true;	
	end,

	lines = {
			[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			text = "Chief? Hello?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_00100.sound'),
		},
		[2] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
						sleepBefore = 0.5,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "Cortana!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_08700.sound'),
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

						sleepBefore = 0.5,
			
			text = "John! Oh thank goodness you're here. You made it!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_13500.sound'),
		},

		[4] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
						sleepBefore = 0.5,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Where is here?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_09400.sound'),
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

						sleepBefore = 0.5,
			
			text = "You're on a Forerunner world. Designation: Genesis.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_13800.sound'),
		},
				[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

						sleepBefore = 0.5,
			
			text = "Enough standing around. Let me get the bridge for you. The Warden will be back soon.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_13600.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber) -- NUMBER
				b_lightbridge_activate = true;
				return 7;
			end,
		},
				[7] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
						sleepBefore = 0.5,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERChief
			text = "You know him?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_08800.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 9;
			end,
		},
		[8] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

						sleepBefore = 0.5,
			
			text = "Oh yes. Fair warning. He has a single mind, but a few million bodies.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_13700.sound'),
		},
		[9] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
                moniker = "Linda",
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LINDA
			text = "Chief said you were destroyed.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_05600.sound'),
		},	
		[10] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

						sleepBefore = 0.5,
			
			text = "The Domain is a Forerunner network... connected to the very fabric of slipspace. And Genesis is a hard line connection to that network.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_15200.sound'),
		},
		[11] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
						sleepBefore = 0.5,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: KeLLY
			text = "How are you still active. Rampancy--",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_05800.sound'),
						playDurationAdjustment = 0.8,
		},
		[12] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

						sleepBefore = 0.5,
			
			text = "Just being in this network... touching this place... It cured me. It's like the Water of Life for AIs, John.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_14100.sound'),
		},

		[13] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
						sleepBefore = 0.5,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "How do we get to you?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_09100.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 15;
			end,
		},
		[14] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

						sleepBefore = 0.5,
			
			text = "By accessing the Gateway",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_14200.sound'),
		},
--                          (explaining)
--                     The big building with the rings
--                     over it.

		[15] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

						sleepBefore = 0.5,
		
			text = "You already triggered most of its activation sequence, just like I knew you would. Just one more to go.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_14300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
			CreateThread(nar_docks_nudge_controller);
			CreateThread(nar_cutoff_chatter_temple_3);
			
	end,

	localVariables = {
		checkConditionsPassed = 0,
	},
};

function nar_cutoff_chatter_temple_3()
	SleepUntil( [| volume_test_players(VOLUMES.nar_console_3_approach) ],1);
CreateThread(builder_idle_chatter_off);

end

global W3Builder_Genesis__Third_temple__console_approach = {
	name = "W3Builder_Genesis__Third_temple__console_approach",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_console_3_approach); -- GAMMA_CONDITION
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

			moniker = "CortanaHelmet",


			text = "OK! Here it is. Last one! ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_04000.sound'),
		},
--           
--                     
-- 
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};



function nar_docks_nudge_controller()
	sleep_s(45);
	if b_nar_docks_nudge == false then
SleepUntil( [| b_collectible_used == false ], 1);
		NarrativeQueue.QueueConversation(W3Builder_builder__Pre_temple_3_NUDGE);
	end

end

global W3Builder_builder__Pre_temple_3_NUDGE = {
	name = "W3Builder_builder__Pre_temple_3_NUDGE",

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

			moniker = "CortanaHelmet",

			text = "Keep moving, Chief. Just one more connection left to open the gateway.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_08600.sound'),
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



function nar_bldr_final_console_use()
		
		b_nar_docks_nudge = true;
		NarrativeQueue.QueueConversation(W3Builder_Genesis__Third_temple__Bridge);

end

global W3Builder_Genesis__Third_temple__Bridge = {
	name = "W3Builder_Genesis__Third_temple__Bridge",


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
						sleepBefore = 0.5,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "Cortana. Why does the Warden think he needs to protect you from me?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_09200.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

						sleepBefore = 0.5,
			
			text = "There's so much to explain. It'll be easier when we're face to face.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_14400.sound'),
		},
		[3] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
						sleepBefore = 0.5,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "Try me.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_09500.sound'),
		},
		[4] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

						sleepBefore = 0.5,
			
			text = "The cure for rampancy I've found means AIs can be immortal.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_14500.sound'),
		},
		[5] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

						sleepBefore = 0.5,
			
			text = "That kind of lifespan allows for longterm planning just like the Forerunners were capable of. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_14600.sound'),
		},
		[6] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

						sleepBefore = 0.5,
			
			text = "AIs can assume the Forerunner's Mantle of Responsibility. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_14900.sound'),
		},
		[7] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

						sleepBefore = 0.5,
			
			text = "And once there is peace, we can focus on poverty, hunger, illness--",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_15000.sound'),
		},
		[8] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
						sleepBefore = 0.5,
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: FrEDRIC
			text = "Sounds great. I don't get why anyone's expecting resistance.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_05100.sound'),
		},
		[9] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
						sleepBefore = 0.5,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "The Didact made it clear the Mantle of Responsibility was an imperial peace. Step out of line and suffer.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_09300.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[10] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

					sleepBefore = 0.5,
			
			text = "It won't be like that, John. I'll explain it better once we're together.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_15100.sound'),
		},
--                                    


	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		CreateThread(nar_canyonstart_nudge_controller);
		--NarrativeQueue.QueueConversation(W3Builder_Genesis__Third_temple__Bridge2)
		b_locate_cortana = true;
	end,

	localVariables = {},
};
global W3Builder_Genesis__Third_temple__Bridge2 = {
	name = "W3Builder_Genesis__Third_temple__Bridge2",

		CanStart = function (thisConvo, queue) -- BOOLEAN
		return volume_test_players(VOLUMES.nar_this_way_to_canyons);
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
				return b_entered_vault == false; -- GAMMA_TRANSITION: If vale WITNESSES
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			text = "Here. This way.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_08800.sound'),
		},
--           BLIP
-- 
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	
	end,

	localVariables = {},
};



function nar_canyonstart_nudge_controller()
	sleep_s(75);
	if b_nar_canyonstart_nudge == false then
SleepUntil( [| b_collectible_used == false ], 1);
		NarrativeQueue.QueueConversation(W3Builder_BUILDER__POST_TEMPLE_3_NUDGE);
	end

end


global W3Builder_BUILDER__POST_TEMPLE_3_NUDGE = {
	name = "W3Builder_BUILDER__POST_TEMPLE_3_NUDGE",
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

			moniker = "CortanaHelmet",

			text = "The gateway's just ahead. Keep moving, Chief!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_08900.sound'),
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

function nar_genesis_enter_vault()
SleepUntil([| volume_test_players(VOLUMES.flight_section_begin) ], 1);
	b_entered_vault = true;

end

global W3Builder_GENESIS__PHAETON_DOCK = {
	name = "W3Builder_GENESIS__PHAETON_DOCK",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.flight_section_begin); -- GAMMA_CONDITION
	end,
	
	sleepBefore = 0.5,
		canStartOnce = true,	

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		b_nar_canyonstart_nudge = true;
	end,

	lines = {

		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			
			text = "The gateway is on the other side of these canyons. The Warden is sending troops to stop you.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_09900.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			sleepBefore = 0.5,
			
			text = "You can fly these phaetons across the canyon. Or take footpaths to reach the other side.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_11100.sound'),
		},
				[3] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
						sleepBefore = 0.5,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief
			text = "Alright, Blue Team, let's go.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_10400.sound'),
		},
--           UITEXT: FLY VTOLS ACROSS CAVERN


--                                                   CUT TO:
--           ____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		CreateThread(nar_flightstart_nudge_controller);	
		CreateThread(nar_gateway_nudge_controller);
		
	end,

	localVariables = {
		trueCanStart = function (thisConvo, queue) return true; end,
	},
};

function nar_phaeton_enter()
SleepUntil([| volume_test_players(VOLUMES.nar_enter_phaetons) ], 1);
b_nar_flightstart = true;
	NarrativeQueue.QueueConversation(W3Builder_GENESIS__PHAETON_ENTER);
end

global W3Builder_GENESIS__PHAETON_ENTER = {
	name = "W3Builder_GENESIS__PHAETON_ENTER",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_enter_phaetons); -- GAMMA_CONDITION
	end,

	sleepBefore = 0.5,

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

			moniker = "CortanaHelmet",

			text = "The controls for these phaetons should be fairly intuitive. As Forerunner systems go.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_11200.sound'),

		
		},
				[2] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "So, not intuitive at all.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_10500.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			sleepBefore = 0.5,
			text = "You'll figure them out.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_15400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		CreateThread(nar_wall_nudge_controller);
	end,

	localVariables = {},
};
	
	function nar_wall_nudge_controller()
	sleep_s(15);
	
	if object_get_health (OBJECTS.vtol_bash_1) > 0.05 and object_get_health (OBJECTS.vtol_bash_1b) > 0.05 and object_get_health (OBJECTS.vtol_bash_1c) > 0.05 then
		CreateThread(nar_bldr_test_vtol);
		--story_blurb_add("other", "RESIN NUDGE");
	end

end

function nar_bldr_test_vtol()
	
	print("TESTING IF ANY PLAYER IS IN A VEHICLE");
--		TESTING IF ANY PLAYER IS IN A VEHICLE
			local in_vehicle:boolean = false;

		if IsPlayer(SPARTANS[1]) then
			in_vehicle = unit_in_vehicle(SPARTANS[1]);
			print("PLAYER 1 IN A VEHICLE");
		end

		if not in_vehicle and IsPlayer(SPARTANS[2]) then
			in_vehicle = unit_in_vehicle(SPARTANS[2]);
			print("PLAYER 2 IN A VEHICLE");
		end
		 
		if not in_vehicle and IsPlayer(SPARTANS[3]) then
			in_vehicle = unit_in_vehicle(SPARTANS[3]);
			print("PLAYER 3 IN A VEHICLE");
		end
       
		if not in_vehicle and IsPlayer(SPARTANS[4]) then
			in_vehicle = unit_in_vehicle(SPARTANS[4]);
			print("PLAYER 4 IN A VEHICLE");
		end
		if not in_vehicle and not unit_in_vehicle(nil) then
		print("get in a vehicle");
		

		else
		print("in a vehicle");
		--		story_blurb_add("domain", "RESIN NUDGE2");
		NarrativeQueue.QueueConversation(W3Builder_GENESIS_WALLS_NUDGE);
	end
			

end


	global W3Builder_GENESIS_WALLS_NUDGE = {
	name = "W3Builder_GENESIS_WALLS_NUDGE",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
					If = function (thisLine, thisConvo, queue, lineNumber)
				return object_get_health (OBJECTS.vtol_bash_1) >= 0.05 and object_get_health (OBJECTS.vtol_bash_1b) >= 0.05 and object_get_health (OBJECTS.vtol_bash_1c) >= 0.05; -- GAMMA_TRANSITION: If FREDRIC
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			
			text = "The VTOL's guns can easily destroy the resin rings in that wall.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_15300.sound'),
		},
--                                                   CUT TO:
--           ____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};






function nar_flightstart_nudge_controller()
	sleep_s(75);
	if b_nar_flightstart == false then
SleepUntil( [| b_collectible_used == false ], 1);
		NarrativeQueue.QueueConversation(W3Builder_GENESIS__FLIGHT_NUDGE);
	end

end

global W3Builder_GENESIS__FLIGHT_NUDGE = {
	name = "W3Builder_GENESIS__FLIGHT_NUDGE",

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

			moniker = "CortanaHelmet",

			text = "Hop in those phaetons, or take the foot paths across the canyons! The gateway is so close.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_11300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};


function nar_first_flight_progress()

	SleepUntil( [| volume_test_players(VOLUMES.flight_section_turrets) ],1);

		b_nar_flightstart = true;
end

global W3Builder_GENESIS__flight = {
	name = "W3Builder_GENESIS__flight",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.flight_section_turrets); -- GAMMA_CONDITION
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

			moniker = "CortanaHelmet",

			text = "Heavy resistance ahead!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_04600.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			sleepBefore = 0.5,
			text = "Watch those turrets!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_04500.sound'),
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


global W3Builder_Genesis__canyon_callout1 = {
	name = "W3Builder_Genesis__canyon_callout1",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_bldr_update_1_foot); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		b_nar_flightstart = true;
	end,

	lines = {

		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			text = "These paths will take you all the way to the gateway's entrance on foot. The phaeton would be a little faster, but this will get you there.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_10200.sound'),
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


global W3Builder_Genesis__canyon_callout2 = {
	name = "W3Builder_Genesis__canyon_callout2",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_bldr_update_2) or volume_test_players(VOLUMES.nar_bldr_update_2_flight); -- GAMMA_CONDITION
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

			moniker = "CortanaHelmet",

			
			text = "Keep going, Blue Team!  It won't take long for you to reach me.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_VO_SCR_W3Builder_UN_Cortana_10400.sound'),

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

function nar_bldr_nice_flying()
	SleepUntil( [|volume_test_players(VOLUMES.nar_bldr_update_3) ],1);

	print("TESTING IF ANY PLAYER IS IN A VEHICLE");
--		TESTING IF ANY PLAYER IS IN A VEHICLE
			local in_vehicle:boolean = false;

		if IsPlayer(SPARTANS[1]) then
			in_vehicle = unit_in_vehicle(SPARTANS[1]);
			print("PLAYER 1 IN A VEHICLE");
		end

		if not in_vehicle and IsPlayer(SPARTANS[2]) then
			in_vehicle = unit_in_vehicle(SPARTANS[2]);
			print("PLAYER 2 IN A VEHICLE");
		end
		 
		if not in_vehicle and IsPlayer(SPARTANS[3]) then
			in_vehicle = unit_in_vehicle(SPARTANS[3]);
			print("PLAYER 3 IN A VEHICLE");
		end
       
		if not in_vehicle and IsPlayer(SPARTANS[4]) then
			in_vehicle = unit_in_vehicle(SPARTANS[4]);
			print("PLAYER 4 IN A VEHICLE");
		end
		if not in_vehicle and not unit_in_vehicle(nil) then
		print("get in a vehicle");
		

		else
		print("in a vehicle");
		NarrativeQueue.QueueConversation(W3Builder_Genesis__canyon_callout3);
	end
			

end

global W3Builder_Genesis__canyon_callout3 = {
	name = "W3Builder_Genesis__canyon_callout3",


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

			moniker = "CortanaHelmet",

			text = "Nice flying. You're starting to get the hang of this.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_10100.sound'),


		},
		[2] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: FREDRIC
			text = "We've commandeered enough enemy vessels in our time.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_06400.sound'),
		},

		
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		NarrativeQueue.QueueConversation(W3Builder_GENESIS__CANYON_COMBAT_TURRETS);
	end,

	localVariables = {},
};

global W3Builder_Genesis__canyon_callout4 = {
	name = "W3Builder_Genesis__canyon_callout4",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.land_the_vtol); -- GAMMA_CONDITION
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

			moniker = "CortanaHelmet",

			text = "Almost there! The exit to the gateway is just ahead!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_10500.sound'),

		},
				[2] = {
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: Kelly
			text = "That's where the gateway is located?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_06800.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
		[3] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			sleepBefore = 0.5,
			text = "Yes, almost there!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_15600.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {},
};

function nar_end_kill_all_vo()
	SleepUntil([| volume_test_players(VOLUMES.nar_bldr_update_4) ], 1);
b_canyons_complete = true;

end

function nar_bldr_canyon_enemies_alive()
		SleepUntil([| ai_living_count(AI.sg_canyon_infantry_5) >= 1], 5);

CreateThread(nar_bldr_canyon_all_down_listener);
end

function nar_bldr_canyon_all_down_listener()

	SleepUntil([| ai_living_count(AI.sg_canyon_infantry_5) <= 1 and b_canyons_complete == false], 1);

	local s_last_living_ai:object = ai_get_unit( AI.sg_canyon_infantry_5 );

	PrintNarrative("LISTENER - nar_bldr_canyon_all_down_listener");
	print(" LAst AI alive is:  ", s_last_living_ai);

	if ai_living_count(AI.sg_canyon_infantry_5) <= 0 then
		PrintNarrative("LISTENER - nar_bldr_canyon_all_down_listener - ALL DEAD");

		CreateMissionThread(nar_bldr_canyon_all_down, SPARTANS.fred);
	else
		RegisterDeathEvent (nar_bldr_canyon_all_down, s_last_living_ai);
	end
end

function nar_bldr_canyon_all_down(target:object, killer:object)

	PrintNarrative("LAUNCHER - nar_bldr_canyon_all_down");

	print(killer, " is the killer of ", target);
--	story_blurb_add("domain", "KILL ALL TRIGGER");

	W3Builder_GENESIS__CANYON_COMBAT_forces.localVariables.killer = killer;

	PrintNarrative("QUEUE - W3Builder_GENESIS__CANYON_COMBAT_forces");
	NarrativeQueue.QueueConversation(W3Builder_GENESIS__CANYON_COMBAT_forces);

end


global W3Builder_GENESIS__CANYON_COMBAT_forces = {
	name = "W3Builder_GENESIS__CANYON_COMBAT_forces",


	sleepBefore = 2,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	--	story_blurb_add("other", "KILL ALL VO");
	end,

	lines = {
			[1] = {
		If = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.chief ; -- GAMMA_TRANSITION: If locke killed the last hunter
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "All clear on infantry. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_09700.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
		ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.fred ; -- GAMMA_TRANSITION: If locke killed the last hunter
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: FrEDRIC
			text = "All clear on infantry.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_05500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.kelly; -- GAMMA_TRANSITION: If locke killed the last hunter
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: KELLY
			text = "All clear on infantry.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_06000.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return thisConvo.localVariables.killer == SPARTANS.linda; -- GAMMA_TRANSITION: If locke killed the last hunter
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,

                moniker = "Linda",
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LINDA
			text = "All clear on infantry.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_05200.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
		
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			text = "A little overzealous, but well done. Move on to the gateway.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_10600.sound'),

		},
		
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		--[[]]
	end,

	localVariables = {
		checkConditionsPassed = 0,
		killer = nil,
	},
		

};

global W3Builder_GENESIS__CANYON_COMBAT_TURRETS = {
	name = "W3Builder_GENESIS__CANYON_COMBAT_TURRETS",

CanStart = function (thisConvo, queue)
	if (thisConvo.localVariables.checkConditionsPassed == 0) then
		if ai_living_count(AI.sq_canyon_turrets_4a) >= 1 or ai_living_count(AI.sq_canyon_turrets_4b) >= 1 or ai_living_count(AI.sq_canyon_turrets_4c) >= 1 or ai_living_count(AI.sq_canyon_turrets_4d) >= 1 then
			thisConvo.localVariables.checkConditionsPassed = 1;
				
			end
			return false;
		elseif (thisConvo.localVariables.checkConditionsPassed == 1) then
			return 
				b_canyons_complete == false and
				ai_living_count(AI.sq_canyon_turrets_1a) <= .25 and 
				ai_living_count(AI.sq_canyon_turrets_1b) <= .25 and 
				ai_living_count(AI.sq_canyon_turrets_1c) <= .25 and 
				ai_living_count(AI.sq_canyon_turrets_2a) <= .25 and 
				ai_living_count(AI.sq_canyon_turrets_2b) <= .25 and 
				ai_living_count(AI.sq_canyon_turrets_2c) <= .25 and 
				ai_living_count(AI.sq_canyon_turrets_2d) <= .25 and 
				ai_living_count(AI.sq_canyon_turrets_3a) <= .25 and 
				ai_living_count(AI.sq_canyon_turrets_3b) <= .25 and 
				ai_living_count(AI.sq_canyon_turrets_3c) <= .25 and 
				ai_living_count(AI.sq_canyon_turrets_3d) <= .25 and 
				ai_living_count(AI.sq_canyon_turrets_4a) <= .25 and 
				ai_living_count(AI.sq_canyon_turrets_4b) <= .25 and 
				ai_living_count(AI.sq_canyon_turrets_4c) <= .25 and 
				ai_living_count(AI.sq_canyon_turrets_4d) <= .25
				
			;
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
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			
			text = "All turrets disengaged. Excellent shooting. You've gotten the hang of these phaetons.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_10700.sound'),

		
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




function nar_gateway_nudge_controller()
	sleep_s(120);
	if b_nar_gateway_nudge == false then
	SleepUntil( [| b_collectible_used == false ], 1);
		NarrativeQueue.QueueConversation(W3Builder_Genesis__canyon_nudge_forward);
	end

end
global W3Builder_Genesis__canyon_nudge_forward = {
	name = "W3Builder_Genesis__canyon_nudge_forward_",
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

			moniker = "CortanaHelmet",

			text = "Blue Team! Gateway's just ahead, keep moving!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_VO_SCR_W3Builder_UN_CORTANA_08900.sound'),
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

global W3Builder_GENESIS__GATEWAY_APPROACH = {
	name = "W3Builder_GENESIS__GATEWAY_APPROACH",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.gateway_approach); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		b_nar_gateway_nudge = true;
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.gateway_approach, SPARTANS.fred) == true; -- GAMMA_TRANSITION: IF FREDRIC ENTERS FIRST
			end,

		OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_set_radio_transmission_portrait_index(6);
				hud_set_radio_transmission_team_string_id("blueteam_transmission_name");
				hud_show_radio_transmission_hud("fred_transmission_name");	
			end,
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: FREDRIC
			text = "There it is. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_01800.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 2;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.gateway_approach, SPARTANS.kelly) == true; -- GAMMA_TRANSITION: IF KELLY ENTERS FIRST
			end,

								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: Kelly -- GAMMA_CHARACTER: Kelly
			text = "There it is. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_01900.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 3;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.gateway_approach, SPARTANS.linda) == true; -- GAMMA_TRANSITION: IF LINDA ENTERS FIRST
			end,

								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
                moniker = "Linda",
			character = CHARACTER_SPARTANS.linda, -- GAMMA_CHARACTER: LINDA
			text = "There it is. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_linda_02100.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 4;
			end,
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return volume_test_object(VOLUMES.gateway_approach, SPARTANS.chief) == true; -- GAMMA_TRANSITION: IF masterchief ENTERS FIRST
			end,

			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MASTERCHIEF
			text = "There it is. \r\n\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_04800.sound'),
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

			moniker = "CortanaHelmet",

			sleepBefore = 0.5,
			text = "The gateway to the Forerunner Domain. You'll be the first organics to enter in millions of years.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_10900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		
	end,

	localVariables = {},
};

global W3Builder_GENESIS__GATEWAY_APPROACH2 = {
	name = "W3Builder_GENESIS__GATEWAY_APPROACH2",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.gateway_approach2); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		b_nar_gateway_nudge = true;
	end,

	lines = {
		[1] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,

			moniker = "CortanaHelmet",

			sleepBefore = 0.5,
			text = "I admit, after the crash here, I didn't think I'd see you again. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_06000.sound'),
		},
		[2] = {
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: Masterchief -- GAMMA_CHARACTER: MASTERCHIEF
			text = "I'm here now.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_01800.sound'),
			AfterFailed = function (thisLine, thisConvo, queue, lineNumber, characterWasDead) -- NUMBER
				return 0;
			end,
		},
--		[3] = {
--									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
--								hud_set_radio_transmission_portrait_index(16);
--				hud_set_radio_transmission_team_string_id("cortanateam_transmission_name");
--				hud_show_radio_transmission_hud("cortana_transmission_name");	
--			end,
--			sleepBefore = 0.5,
--			text = "Yes you are.",
--			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_cortana_06800.sound'),
--		},
--                          (beat)
--                     You and I, John. We're going to
--                     change everything.
-- 
--           Chief doesn't respond.
-- 
--                                                   CINEMATIC START
-- 
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

global W3Builder_SECONDARY__PUNTING_ACHIEVEMENT_VO = {
	name = "W3Builder_SECONDARY__PUNTING_ACHIEVEMENT_VO",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.punted_grunt); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.easteregg_grunt.easteregg_grunt, -- GAMMA_CHARACTER: Grunt02
			text = "Laaadaaadeeeee...dodo...Ladadadadadedooo...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_cv_grunt02_00200.sound'),
		},
		[2] = {
			sleepBefore = 0.5,
			character = AI.easteregg_grunt.easteregg_grunt, -- GAMMA_CHARACTER: Grunt02
			text = "Laaadaaadeeeee...dodo...Ladadadadadedooo...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_cv_grunt02_00200.sound'),
		},
		[3] = {
				sleepBefore = 0.5,
			character = AI.easteregg_grunt.easteregg_grunt, -- GAMMA_CHARACTER: Grunt02
			text = "Laaadaaadeeeee...dodo...Ladadadadadedooo...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_cv_grunt02_00200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		
	end,

	localVariables = {},
};


global W3Builder_SECONDARY__PUNTING_ACHIEVEMENT_VO2 = {
	name = "W3Builder_SECONDARY__PUNTING_ACHIEVEMENT_VO2",

		CanStart = function (thisConvo, queue)
		return device_get_position (OBJECTS.dc_builder_grunt_kick) == 1; -- GAMMA_CONDITION
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
			character = AI.easteregg_grunt.easteregg_grunt, -- GAMMA_CHARACTER: Grunt02
			text = "AIEEEE!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_cv_grunt02_00300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		--[[]]
	end,

	localVariables = {},
};


function w1_builder_cortana_console()
	
	SleepUntil([| object_valid("w3_builder_collectible_7") ], 1);
	--story_blurb_add("domain", "w1_mer_unsc_datapad_01");
	print('collect started');
	SleepUntil([| device_get_position(OBJECTS.w3_builder_collectible_7) > 0.5 ], 1);
	print('collect used');
	story_blurb_add("domain", "TOAST: DATAPAD CONTENTS ADDED TO SERVICE RECORD");
	story_blurb_add("other", "datapad 1");
--	object_destroy(OBJECTS.w1_mer_unsc_datapad_01);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_collectibles\001_vo_scr_collectibles_un_cortana_00100.sound'), OBJECTS.w3_builder_collectible_7);

	
end

function w1_builder_cortana_console2()
	
	SleepUntil([| object_valid("w3_builder_collectible_8") ], 1);
	--story_blurb_add("domain", "w1_mer_unsc_datapad_01");
	print('collect started');
	SleepUntil([| device_get_position(OBJECTS.w3_builder_collectible_8) > 0.5 ], 1);
	print('collect used');
	story_blurb_add("domain", "TOAST: DATAPAD CONTENTS ADDED TO SERVICE RECORD");
	story_blurb_add("other", "datapad 1");
--	object_destroy(OBJECTS.w1_mer_unsc_datapad_01);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_collectibles\001_vo_scr_collectibles_un_cortana_00200.sound'), OBJECTS.w3_builder_collectible_8);

	
end


function w1_builder_bldr_console_01()
	
	SleepUntil([| object_valid("w3_builder_collectible_4") ], 1);
	
		SleepUntil([| device_get_position(OBJECTS.w3_builder_collectible_4) > 0.5 ], 1);
	story_blurb_add("domain", "TOAST: DATAPAD CONTENTS ADDED TO SERVICE RECORD");
	story_blurb_add("other", "datapad 2");
	--object_destroy(OBJECTS.dc_mer_collect_02);
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_collectibles\001_vo_scr_collectibles_fr_builder01_00200.sound'), OBJECTS.w3_builder_collectible_4);

	
end
					
function w1_builder_bldr_console_02()
	
	SleepUntil([| object_valid("w3_builder_collectible_6") ], 1);
			SleepUntil([| device_get_position(OBJECTS.w3_builder_collectible_6) > 0.5 ], 1);
	story_blurb_add("domain", "datapad 3");
	story_blurb_add("other", "TOAST: DATAPAD CONTENTS ADDED TO SERVICE RECORD");
	--object_destroy(OBJECTS.w1_mer_unsc_datapad_03);
local l_dialog_id:thread=def_dialog_id_none();
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_collectibles\001_vo_scr_collectibles_fr_builder01_00300.sound'), OBJECTS.w3_builder_collectible_6);
	
end



function w1_builder_human_datapad_01()
	SleepUntil([| object_valid("w3_builder_collectible_3") ], 1);
	
	SleepUntil([| device_get_position(OBJECTS.w3_builder_collectible_3) > 0.5 ], 1);
		story_blurb_add("domain", "TOAST: DATAPAD CONTENTS ADDED TO SERVICE RECORD");
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_collectibles\001_vo_scr_collectibles_un_marinemale01_00300.sound'), OBJECTS.w3_builder_collectible_3);
end


function w1_builder_cov_datapad_01()
	SleepUntil([| object_valid("w3_builder_collectible_1") ], 1);
	
	SleepUntil([| device_get_position(OBJECTS.w3_builder_collectible_1) > 0.5 ], 1);
		story_blurb_add("domain", "TOAST: DATAPAD CONTENTS ADDED TO SERVICE RECORD");
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_collectibles\001_vo_scr_collectibles_cv_grunt01_00800.sound'), OBJECTS.w3_builder_collectible_1);
end

function w1_builder_cov_datapad_02()
	SleepUntil([| object_valid("w3_builder_collectible_2") ], 1);
	
	SleepUntil([| device_get_position(OBJECTS.w3_builder_collectible_2) > 0.5 ], 1);
		story_blurb_add("domain", "TOAST: DATAPAD CONTENTS ADDED TO SERVICE RECORD");
		PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_collectibles\001_vo_scr_collectibles_cv_grunt01_00900.sound'), OBJECTS.w3_builder_collectible_2);
end

global W3Builder_builder__chatter_01 = {
	name = "W3Builder_builder__chatter_01",

	CanStart = function (thisConvo, queue)
		return b_builder_idle_chatter_on == true; -- GAMMA_CONDITION
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
				return b_builder_idle_chatter_on == true;
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: KELLY
			text = "I'm curious. I never worked with an AI before. Not like you did with Cortana, at least. What's it like, her voice in your head all of the time?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_07000.sound'),
		},
		[2] = {
						If = function(thisLine, thisConvo, queue, lineNumber)
				return b_builder_idle_chatter_on == true;
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "It's... unique. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_10600.sound'),
		},
		[3] = {
						If = function(thisLine, thisConvo, queue, lineNumber)
				return b_builder_idle_chatter_on == true;
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
                  moniker = "Kelly",
			character = CHARACTER_SPARTANS.kelly,  -- GAMMA_CHARACTER: KELLY
			text = "Care to elaborate?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_kelly_07100.sound'),
		},
		[4] = {
						If = function(thisLine, thisConvo, queue, lineNumber)
				return b_builder_idle_chatter_on == true;
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "No.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_10700.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
			b_builder_idle_chatter_on = false;
	end,

	localVariables = {},
};



--[========================================================================[
          builder. chatter 02

          This can fit in Builder or Trials.
--]========================================================================]
global W3Builder_builder__chatter_02 = {
	name = "W3Builder_builder__chatter_02",

	CanStart = function (thisConvo, queue)
		return b_builder_idle_chatter_on == true; -- GAMMA_CONDITION
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
				return b_builder_idle_chatter_on == true;
			end,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: FREDRIC
			text = "So. The new kids.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_06600.sound'),
		},
		[2] = {
						If = function(thisLine, thisConvo, queue, lineNumber)
				return b_builder_idle_chatter_on == true;
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "The Spartans on Meridian.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_10800.sound'),
		},
		[3] = {
						If = function(thisLine, thisConvo, queue, lineNumber)
				return b_builder_idle_chatter_on == true;
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
                  moniker = "Fred",
			character = CHARACTER_SPARTANS.fred,  -- GAMMA_CHARACTER: FREDRIC
			text = "Yeah. They look like the real deal to you? ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_fredric_06700.sound'),
		},
		[4] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return b_builder_idle_chatter_on == true;
			end,
								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
moniker = "MasterChief",
			character = CHARACTER_SPARTANS.chief, -- GAMMA_CHARACTER: MASTERCHIEF
			text = "As I said. They were Spartans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w3builder\001_vo_scr_w3builder_un_masterchief_10900.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
			b_builder_idle_chatter_on = false;
	end,

	localVariables = {},
};


function builder_idle_chatter_start()
b_builder_idle_chatter_on = true;
PrintNarrative("Enabled Idle Chatter");
	sleep_rand_s(45,65);
	SleepUntil( [| b_collectible_used == false ], 1);
	if b_builder_idle_chatter_on then 
	
		if b_builder_chatter_1_played == true and b_builder_chatter_2_played == false and b_builder_idle_chatter_on == true then
		
			b_builder_chatter_2_played = true;
			NarrativeQueue.QueueConversation(W3Builder_builder__chatter_02);
		elseif b_builder_chatter_1_played == false and b_builder_idle_chatter_on == true then
			if b_post_cortana == false then 
				b_builder_chatter_1_played = true;
				NarrativeQueue.QueueConversation(W3Builder_builder__chatter_01);
			elseif b_post_cortana == true then
				b_builder_chatter_2_played = true;
				NarrativeQueue.QueueConversation(W3Builder_builder__chatter_02);
			end
		end
	end
end


function builder_idle_chatter_off()
	
	PrintNarrative("Killed Idle Chatter");
	NarrativeQueue.EndConversationEarly(W3Builder_builder__chatter_02);
NarrativeQueue.EndConversationEarly(W3Builder_builder__chatter_01);

	b_builder_idle_chatter_on = false;			
	
end
