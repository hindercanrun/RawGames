--## SERVER

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- *** World 1 Hub  ***
--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

---- =================================================================================================       
-- *** GLOBALS ***
---- =================================================================================================
global b_walkup_interrupt:boolean=false;
global b_walkup_finished:boolean=false;
global b_mongeese_start:boolean=false;
global b_quest_turnin:boolean=false;
global b_quest_arrive:boolean=false;
global b_scan_guard:boolean=false;
--global int_clue_progress:number=0;
global int_sidequest_progress:number=0;
global n_medic_tent:number=0;
global n_garage_vo:number=0;
global n_science_tent:number=0;
global b_mhub_sloan_intro_speech_done:boolean = false; -- boolean to set when sloans intro speech is done
global n_gatemain_vo:number=0;
global n_gate_left:number=0;
global n_gate_right:number=0;
global b_first_clue_finished:boolean=false;
global b_second_clue_finished:boolean=false;
global b_mhub_either_clue_pinged:boolean=false;
global b_mhub_terminal_clue_pinged:boolean=false;
global b_mhub_pelican_clue_pinged:boolean=false;
global n_bamf_pad:number = 0;
global n_inventory_miner:number = 0;
global n_rooftop_miners:number = 0;
global b_used_terminal:boolean=false;
global b_sloan_show_all_done:boolean=false;
global n_mhub_the_sloan_show:number = 0;
global n_mhub_ufc_talk:number = nil;
global n_mhub_ufc_trans:number = nil;
global b_chatter_1_played:boolean = false;
global b_chatter_2_played:boolean = false;
global b_chatter_3_played:boolean = false;
global b_miningtown_idle_chatter_on:boolean = nil;
global b_mhub_start_sloan:boolean = nil;
global b_mhub_mongoose_nutz:boolean=false;
global b_whub_terminal_ready_on:boolean=false;
global b_whub_soccer_goal_done:boolean=false;
global b_first_activation:boolean=false;
global b_locke_talk3_line_playing:boolean=false;
global b_locke_talk2_line_playing:boolean=false;
global b_w1hub_obj_reminder_off:boolean=false;
global b_mhub_player_is_close_to_sloan:boolean=false;
global ufc_approach_01:boolean=false;
global ufc_interact_01:boolean=false;
global ufc_interact_01_over:boolean=false;
global ufc_interact_02:boolean=false;
global ufc_interact_ready_02:boolean=false;
global b_entered_town:boolean=false;

global p_w1hub_gen_convo_marine_male_ufc:object = nil;
global p_w1hub_gen_convo_marine_male_medic:object = nil;
global p_w1hub_gen_convo_marine_male_fore:object = nil;

---- =================================================================================================       
-- *** START-UP ***
---- =================================================================================================
function startup.init_miningtown()
	if not editor_mode() then
		StartW1Hub();
	else
		print ("in editor not starting mission run StartW1Hub to start mission");
	end
end
---- =================================================================================================       
-- *** START-UP END ***
---- =================================================================================================


--MISSION TABLE
global W1Hub:table=
	{
		name = "w1_hub_missions",
		--profiles = {STARTING_PROFILES.profile1, STARTING_PROFILES.profile2, STARTING_PROFILES.profile3, STARTING_PROFILES.profile4},
		points = POINTS.ps_w1hub_start,
		startGoals = {"goal_frontgate"},
		--startFadeOut = "no",
		--endFadeOut = "no",
		
		collectibles = {
			{objectName = "collectible_fountain", collectibleName = "collectible_fountain"},
			{objectName = "collectible_garage", collectibleName = "collectible_garage"},
			{objectName = "collectible_medicbase", collectibleName = "collectible_medicbase"},
			{objectName = "collectible_backroom", collectibleName = "collectible_backroom"},
			{objectName = "collectible_watertower", collectibleName = "collectible_watertower"},
			{objectName = "collectible_landingpad", collectibleName = "collectible_landingpad"},
			{objectName = "collectible_rightgate", collectibleName = "collectible_rightgate"},
			{objectName = "collectible_wash", collectibleName = "collectible_wash"},
		};
	}

function StartW1Hub()
	--pup_play_show("vin_drone_flight");
	fade_in(0, 0, 0, 0);
	sleep_s(0.2);
	TeleportNoFX();
	object_teleport(SPARTANS.locke, FLAGS.cf_mhub_locke_start);
	object_teleport(SPARTANS.vale, FLAGS.cf_mhub_vale_start);
	object_teleport(SPARTANS.tanaka, FLAGS.cf_mhub_tanaka_start);
	object_teleport(SPARTANS.buck, FLAGS.cf_mhub_buck_start);
	
	StartMission(W1Hub);
	sleep_s(0.5);
	fade_in(0, 0, 0, 80);
	unit_open(OBJECTS.v_pelican);
end

function W1Hub.Start()
	print(":::Loading W1 Hub Goals Start:::");
	
	-- Sets "Guns Down" mode
	print("w1_hub_guns_down");
	PlayersSetWeaponRelaxed(true);
	CreateMissionThread(nar_frontgate_listener);
	CreateMissionThread(w1hub_scenes_start);
	NarrativeQueue.QueueConversation(W1Station_main_gate);
	NarrativeQueue.QueueConversation(W1Station_roof_miners_01);
	CreateMissionThread(nar_welder_listener);
	CreateMissionThread(w1_station_interactive_console1);
	CreateMissionThread(w1_station_interactive_console2);
	CreateMissionThread(nar_welder2_listener);
	CreateMissionThread(w1_station_interactive_console4);
	CreateMissionThread(w1_station_interactive_console5);
	object_destroy(OBJECTS.w1_station_interactive_console3);
	CreateMissionThread(nar_leftgate_listener);
	CreateMissionThread(nar_fence_listener);
	CreateMissionThread(nar_front_gate_talk2_listener);
	CreateMissionThread(nar_fence2_listener);
	CreateMissionThread(nar_gate3_listener);
	CreateMissionThread(nar_cleaner_listener);
	CreateMissionThread(nar_cleaner2_listener);
	CreateMissionThread(nar_inventory_listener);
	CreateMissionThread(nar_inventory2_listener);
	CreateMissionThread(nar_soccer_listener);
	CreateThread(nar_no_chatter_zone);
	CreateThread(nar_entered_town);
	
	TurnOffVehicleTracking();
	FadeInMission();
	CreateThread(audio_miningtown_start);
end

function W1Hub.End()
	print ("world 1 hub end");
	--CinematicPlay("cin_070_mayor");
	sys_LoadUnconfirmedReports();
	PlayersSetWeaponRelaxed(false);
end


----  =====================================================================================================================
--  **GOALS**  
----  =====================================================================================================================


---- ===================================
-- Goal 1: FrontGate
--- ===================================

W1Hub.goal_frontgate = 
{
	--description = "OBJECTIVE: Enter MineTown",
	gotoVolume = VOLUMES.tv_thru_2nd_gate,
	zoneSet = ZONE_SETS.miningtown,
	checkPoints = POINTS.ps_blink_frontgate,
	next = {"goal_sloan_intro"};
}  


function W1Hub.goal_frontgate.Start():void
	NarrativeQueue.instance.showBlurbs = false;
	CreateThread(f_chapter_title, TITLES.ct_mhub_01);
	--CreateThread(w1hub_vig_pelican_flyover); -- OSR-142529  Taking this thing out altogether KS 8/21/15
	CreateThread(start_hub_vo);
	CreateThread(f_mhub_place_patrol_miners);
	CreateThread(f_mhub_cola_ball);
end

function W1Hub.goal_frontgate.End():void  
	b_mongeese_start=true;
end

function start_hub_vo()
	-- VO for start of Hub "mission"
	sleep_s(2);
	NarrativeQueue.QueueConversation(W1Station_MERIDIAN_HUB);
end

global W1Station_MERIDIAN_HUB = {
	name = "W1Station_MERIDIAN_HUB",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		NarrativeQueue.QueueConversation(W1Station_EXT__merIDIAN_STATION_start);
	end,

	lines = {
		[1] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return 		b_walkup_interrupt == false; -- GAMMA_TRANSITION: If FREDRIC
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Governor Sloan, I was hoping we might have a word?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_00100.sound'),
		},
		[2] = {
					If = function (thisLine, thisConvo, queue, lineNumber)
				return 		b_walkup_interrupt == false; -- GAMMA_TRANSITION: If FREDRIC
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				hud_show_radio_transmission_hud("sloan_transmission_name");
										hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
										hud_set_radio_transmission_portrait_index(15);
		end,
			sleepBefore = 0.5,
			text = "Come into town and we'll talk. I trust you won't cause any trouble. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_sloan_00700.sound'),
		},
		[3] = {
					If = function (thisLine, thisConvo, queue, lineNumber)
				return 		b_walkup_interrupt == false; -- GAMMA_TRANSITION: If FREDRIC
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "We'll be with you shortly.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_01100.sound'),
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				CreateThread(f_w1hub_1st_obj);
			end,
		},
				[4] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return 		b_walkup_interrupt == false; -- GAMMA_TRANSITION: If FREDRIC
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 1,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Tanaka, what kind of welcome can we expect this far out?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_02400.sound'),
		},
		[5] = {
			If = function (thisLine, thisConvo, queue, lineNumber)
				return 		b_walkup_interrupt == false; -- GAMMA_TRANSITION: If FREDRIC
			end,
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Frontier colony like this? Not much. Best suggestion is to keep weapons down and hands off.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_01400.sound'),
			
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		CreateThread(nar_walkup_finished);
		CreateThread(nar_move_to_town_trigger);
		
	end,

	localVariables = {},
};


function nar_move_to_town_trigger()
	sleep_s(45);
if b_entered_town == false then
	NarrativeQueue.QueueConversation(W1Station_MERIDIAN_HUB_nudge);
end
	sleep_s(45);
if b_entered_town == false then
	NarrativeQueue.QueueConversation(W1Station_MERIDIAN_HUB_nudge2)
end
	sleep_s(45);
if b_entered_town == false then
	
	NarrativeQueue.QueueConversation(W1Station_MERIDIAN_HUB_nudge3);
end
end

global W1Station_MERIDIAN_HUB_nudge = {
	name = "W1Station_MERIDIAN_HUB_nudge",

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
			text = "Best not keep the Governor waiting.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_00400.sound'),
		},
	
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		
	end,

	localVariables = {},
};

global W1Station_MERIDIAN_HUB_nudge3 = {
	name = "W1Station_MERIDIAN_HUB_nudge3",

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
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VaLE
			text = "We should get moving.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_vale_00400.sound'),
		},
	
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();

	end,

	localVariables = {},
};

global W1Station_MERIDIAN_HUB_nudge2 = {
	name = "W1Station_MERIDIAN_HUB_nudge2",

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
			text = "Oughta head into town.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_00500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();

	end,

	localVariables = {},
};

global W1Station_main_gate = {
	name = "W1Station_main_gate",

	CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_approach_main_gate); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = AI.sq_inner_gate.sp_innergate_04, -- GAMMA_CHARACTER: Minermale05
			text = "Here come the Spartans Governor Sloan was talking to.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale05_00500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		
	end,

	localVariables = {},
};

function nar_walkup_finished():void
	b_walkup_finished=true;
end

function f_w1hub_1st_obj():void
	sleep_s(0.5);
	-- setting 1st obj, creating tracking breadcrumb
	ObjectiveShow(TITLES.obj01);
	sleep_s(0.25);
	object_create("s_mhub_breadcrumb_01");
	CreateThread(f_mhub_kill_breadcrumb_01);
	MusketeerUtil_SetMusketeerGoal(FLAGS.cf_mhub_front_gate, 3);
end

function f_mhub_place_patrol_miners():void
	SleepUntil([| volume_test_players(VOLUMES.tv_2nd_peli_flyover) ], 10);

	--right side, near fence
	composer_play_show("co_mhub_patrol_welder_01");
	
	--back left corner, behind truck
	composer_play_show("co_mhub_patrol_welder_02");
	
	--landing pad, up top
	composer_play_show("co_mhub_patrol_welder_03");
	
	--left row, near terminal
	composer_play_show("ci_miner_leaner_01");
	
	--mid row
	composer_play_show("ci_miner_windows_01");
	
	--right row
	composer_play_show("ci_miner_windows_02");
	
	--landing pad
	composer_play_show("ci_miner_sweep_01");
	
	--landing pad
	composer_play_show("ci_miner_leaner_lpad");
	composer_play_show("ci_miner_lpad_loader");
	
	--alley between medic and fore 
	composer_play_show("ci_miner_leaner_03");
	
	--place the UFC guy on the roof, get ready for player nearby
	--ai_place(AI.sq_hub_ufc);
	composer_play_show("ci_ufc_convo_01_ufc");
	CreateThread(f_mhub_ufc);
	
	-- start sloan speech
	n_mhub_the_sloan_show = composer_play_show("sloan_addresses_miners");
	b_mhub_start_sloan = true;
	--PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_Sloan_00800.sound'), OBJECTS.cr_wizard_of_oz );
	
	CreateThread(f_mhub_mongoose_guy_goes_nutz);
end

-- UFC thing
function f_mhub_ufc():void
	print("_______________ created UFC thread");
	SleepUntil([| volume_test_players(VOLUMES.tv_whub_ufc) ], 10);
	CreateThread(nar_ufc_listener);
	ufc_approach_01 = true;
	sleep_s(7);
	object_create_anew("nar_ufc_talk");
	device_set_power(OBJECTS.nar_ufc_talk, 1);
	SleepUntil([|device_get_position(OBJECTS.nar_ufc_talk) == 1], 20);

	--Sleep(5);
	--ufc_interact_01 = true;
	--ObjectSetSpartanTrackingEnabled(ai_get_object(AI.sq_hub_ufc.mortalcombat), false);
	Sleep(5);
	print("_____________ ufc 1");
	device_set_power(OBJECTS.nar_ufc_talk, 0);
	print("_____________ ufc 2");
	SleepUntil([| ufc_interact_ready_02 == true ], 10);
	print("_____________ ufc 3");
	ufc_approach_01 = false;
	print("_____________ ufc 4");
	sleep_s(3);
	print("_____________ ufc 5");
	SleepUntil([| volume_test_players(VOLUMES.tv_whub_ufc) ], 10);
	print("_____________ ufc 6");
	CreateThread(nar_ufc_listener);
	print("_____________ ufc 7");
	--sleep_s(1);
	device_set_position_immediate(OBJECTS.nar_ufc_talk, 0);
	print("_____________ ufc 8");
	Sleep(5);
	print("_____________ ufc 9");
	device_set_power(OBJECTS.nar_ufc_talk, 1);
	print("_____________ ufc 10");
	Sleep(5);
	print("_____________ ufc 11");
	SleepUntil([|device_get_position(OBJECTS.nar_ufc_talk) == 1], 20);
	print("_____________ ufc 12");
	--sleep_s(3);
	
	ufc_interact_02 = true;
	print("_____________ ufc 13");
	Sleep(5);
	print("_____________ ufc 14");
	device_set_power(OBJECTS.nar_ufc_talk, 0);
	print("_____________ ufc 15");
end


function f_whub_ufc2():void
	--composer_stop_show(n_mhub_ufc_talk);
	--n_mhub_ufc_trans = composer_play_show("ci_ufc_convo_02_trans");
end

function f_whub_ufc_translator():void
	composer_stop_show(n_mhub_ufc_trans);
end
-- UFC thing end

function f_mhub_mongoose_guy_goes_nutz():void
	SleepUntil([| volume_test_players(VOLUMES.tv_mhub_driver_go_nutz) ], 10);
	b_mhub_mongoose_nutz = true;
end

function cs_mhub_patrol_miner_01():void
	repeat
		cs_stow(true);
		--unit_lower_weapon(ai_current_actor, 1);
		cs_look(true, POINTS.ps_look_at_sloan.p_01);
		sleep_s(1.5);
	until b_mhub_sloan_intro_speech_done == true;
end

function cs_mhub_patrol_sci_01():void
	repeat
		cs_stow(true);
		cs_look(true, POINTS.ps_look_at_sloan.p_01);
		sleep_s(1.5);
	until b_mhub_sloan_intro_speech_done == true;
end

function f_mhub_sball_goal_1():void
	SleepUntil([|volume_test_object(VOLUMES.tv_mhub_sball_goal_1, OBJECTS.cr_mhub_soccer_ball) ], 1);
	CreateEffectGroup(EFFECTS.fx_goal_1_01);
	CreateEffectGroup(EFFECTS.fx_goal_1_02);
	if b_whub_soccer_goal_done == false then
		NarrativeQueue.QueueConversation(W1Station_Soccer_ball_goal);
		b_whub_soccer_goal_done = true;
	end
	SoundImpulseStartServer(TAG('sound\002_ui\002_ui_hud\002_ui_hud_skulls_gruntbirthday.sound'), nil, 1);
	CreateThread(f_mhub_sball_goal_1_fx_off);
	CreateThread(f_mhub_sball_goal_1_reset);
end

function f_mhub_sball_goal_1_reset():void
	SleepUntil([|not volume_test_object(VOLUMES.tv_mhub_sball_goal_1, OBJECTS.cr_mhub_soccer_ball) ], 5);
	sleep_s(3);
	CreateThread(f_mhub_sball_goal_1);
end

function f_mhub_sball_goal_1_fx_off():void
	sleep_s(3);
	StopEffectGroup(EFFECTS.fx_goal_1_01);
	StopEffectGroup(EFFECTS.fx_goal_1_02);
end

function f_mhub_sball_goal_2():void
	SleepUntil([|volume_test_object(VOLUMES.tv_mhub_sball_goal_2, OBJECTS.cr_mhub_soccer_ball) ], 5);
	CreateEffectGroup(EFFECTS.fx_goal_2_01);
	CreateEffectGroup(EFFECTS.fx_goal_2_02);
	if b_whub_soccer_goal_done == false then
		NarrativeQueue.QueueConversation(W1Station_Soccer_ball_goal);
		b_whub_soccer_goal_done = true;
	end
	SoundImpulseStartServer(TAG('sound\002_ui\002_ui_hud\002_ui_hud_skulls_gruntbirthday.sound'), nil, 1);
	CreateThread(f_mhub_sball_goal_2_fx_off);
	CreateThread(f_mhub_sball_goal_2_reset);
end

function f_mhub_sball_goal_2_reset():void
	SleepUntil([|not volume_test_object(VOLUMES.tv_mhub_sball_goal_2, OBJECTS.cr_mhub_soccer_ball) ], 5);
	sleep_s(2);
	CreateThread(f_mhub_sball_goal_2);
end

function f_mhub_sball_goal_2_fx_off():void
	sleep_s(3);
	StopEffectGroup(EFFECTS.fx_goal_2_01);
	StopEffectGroup(EFFECTS.fx_goal_2_02);
end

---- ===================================
-- Goal 2: TALKING TO SLOAN
---- ===================================
W1Hub.goal_sloan_intro = 
{
	zoneSet = ZONE_SETS.miningtown,
	checkPoints = POINTS.ps_sloan_intro,
	next = {"goal_clues"};
} 

function W1Hub.goal_sloan_intro.Start():void
	object_create("s_mhub_breadcrumb_02");
	object_destroy(OBJECTS.s_mhub_breadcrumb_01);
	--CreateThread(f_mhub_kill_breadcrumb_02);
	CreateThread(f_mhub_sloan_speech);
end

function f_mhub_sloan_speech():void
	SleepUntil([| volume_test_players(VOLUMES.tv_mhub_breadcrumb_02) ], 10);
	b_mhub_player_is_close_to_sloan = true;
	--story_blurb_add("domain", "SLOAN: 'Everyone stand down' speech here");
	--CreateThread(f_mhub_sloan_intro_speech);
	--SleepUntil ([|b_mhub_sloan_intro_speech_done == true or not volume_test_players(VOLUMES.tv_mhub_breadcrumb_02)], 30);
end

function nar_entered_town()
	SleepUntil([| volume_test_players(VOLUMES.nar_enter_station2) ], 10);
	b_entered_town = true;
end

global W1Station_EXT__merIDIAN_STATION_start = {
	name = "W1Station_EXT__merIDIAN_STATION_start",
		CanStart = function (thisConvo, queue)
		return volume_test_players(VOLUMES.nar_enter_station2); -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		CreateThread(nar_turn_off_all_interacts);
	end,

	lines = {
			[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return  volume_test_object(VOLUMES.nar_enter_station2, SPARTANS.buck) == true;
			end,
			OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				radio_tag_start(NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
			end,
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BuCK
			text = "Is that Governor Sloan?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_00500.sound'),
			
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
			[2] = {
		ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return  volume_test_object(VOLUMES.nar_enter_station2, SPARTANS.tanaka) == true;
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Is that Governor Sloan?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_00600.sound'),
			
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--           FOLLOWS:

		[3] = {
			ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return  volume_test_object(VOLUMES.nar_enter_station2, SPARTANS.vale) == true;
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: LOCKE
			text = "Is that Governor Sloan?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_vale_00500.sound'),

			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--           IF BUCK


--           IF VALE

		[4] = {
		ElseIf = function(thisLine, thisConvo, queue, lineNumber)
				return  volume_test_object(VOLUMES.nar_enter_station2, SPARTANS.locke) == true;
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Vale
			text = "Is that Governor Sloan?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_01200.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		
	end,

	localVariables = {},
};
global W1Station_EXT__merIDIAN_STATION = {
	name = "W1Station_EXT__merIDIAN_STATION",
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 4,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		CreateThread(nar_turn_off_all_interacts);
	end,

	lines = {

		[1] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: loCKE
			text = "He's an AI.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_01300.sound'),
		},
		[2] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		sleepBefore = 0.25,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VaLE
			text = "What's wrong with him? He looks broken.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_vale_00600.sound'),
		},
		[3] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		sleepBefore = 0.25,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Rampancy onset. Late stage, from the looks. Probably sacrificing resolution for logic cycles.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_00700.sound'),
		},
--           Sloan interrupts the Spartans via PiP. The big Sloan hologram
--           can still be speaking even as Sloan starts in PiP.

		[4] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
													hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,

			text = "I have welcomed you to my home. Do not be so rude as to make my health a point of conversation.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_sloan_01300.sound'),
		},
		[5] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		sleepBefore = 0.25,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Of course, Governor. My apologies.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_01400.sound'),
		},
--                          (down to business)
--                     We're looking for another Spartan
--                     fireteam.

		[6] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
													hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,

			sleepBefore = 0.25,
			text = "Why so many Spartans here? Why now? ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_sloan_01400.sound'),
		},

--           REMINDER
-- 
--           After Sloan's done talking to us and we are not near the
--           Medic tent, wait a few seconds then...

		[7] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "So, where do we start looking?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_00100.sound'),
		},
		[8] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		sleepBefore = 0.25,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: loCKE
			text = "The best intel in a place like this comes from the people. Keep your ears open and let people talk.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_01500.sound'),
			sleepAfter = 1,
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		CreateThread(sloan_convo_complete);
		GoalCompleteCurrent();
		CreateThread(nar_talk_to_people_nudge);
		CreateThread(nar_turn_chatter_on);
		CreateThread(nar_turn_on_all_interacts);
		MusketeerUtil_SetDestination_Clear_All();
	end,

	localVariables = {},
};

function nar_talk_to_people_nudge()
	sleep_s(120);
	if b_first_clue_finished == false then
		NarrativeQueue.QueueConversation(W1Station_OBJECTIVE_NUDGE_01);
	end
	sleep_s(120);
	if b_first_clue_finished == false then
		NarrativeQueue.QueueConversation(W1Station_OBJECTIVE_NUDGE_02);
	end

end



global W1Station_OBJECTIVE_NUDGE_01 = {
	name = "W1Station_OBJECTIVE_NUDGE_01",

	
	CanStart = function (thisConvo, queue) -- BOOLEAN
	return b_miningtown_idle_chatter_on == true;
	
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
				return b_first_clue_finished == false;
			end,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "We should talk to the people of this station. One of them might have seen signs of Blue team.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_03000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global W1Station_OBJECTIVE_NUDGE_02 = {
	name = "W1Station_OBJECTIVE_NUDGE_02",

		CanStart = function (thisConvo, queue) -- BOOLEAN
	return b_miningtown_idle_chatter_on == true;
	
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
				return b_first_clue_finished == false;
			end,
		
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Talking to the people should help us find Blue Team.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_01900.sound'),
			sleepAfter = 1,
		},

	},
	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

function sloan_convo_complete():void
	if b_medic_activated == false and b_forerunner_activated == false then
		b_mhub_either_clue_pinged = false;
		
		RegisterSpartanTrackingPingObjectEvent(f_mhub_clues_pinged, ai_get_object (AI.sq_medic_station_miner.sp_hurt_miner_1));
		RegisterSpartanTrackingPingObjectEvent(f_mhub_clues_pinged, ai_get_object (AI.sq_forerunner_room_miner.sp_fore_miner_01));
	
		sleep_s(3);
		repeat
			sleep_s(8);
			TutorialShowAll("training_tracking_mhub", 5);
			--sleep_s(7);
			--TutorialStopAll();
			sleep_s(15);
		until b_mhub_either_clue_pinged == true
	
	elseif b_medic_activated == true and b_forerunner_activated == false then
		b_mhub_either_clue_pinged = false;
		if b_w1hub_obj_reminder_off == false then
			CreateThread(f_w1hub_obj_reminder);
		end
		
		RegisterSpartanTrackingPingObjectEvent(f_mhub_clues_pinged, ai_get_object (AI.sq_forerunner_room_miner.sp_fore_miner_01));

		sleep_s(3);	
		repeat
			sleep_s(8);
			TutorialShowAll("training_tracking_mhub", 5);
			--sleep_s(7);
			--TutorialStopAll();
			sleep_s(15);
		until b_mhub_either_clue_pinged == true
	
	elseif b_medic_activated == false and b_forerunner_activated == true then
		b_mhub_either_clue_pinged = false;
		if b_w1hub_obj_reminder_off == false then
			CreateThread(f_w1hub_obj_reminder);
		end
		
		RegisterSpartanTrackingPingObjectEvent(f_mhub_clues_pinged, ai_get_object (AI.sq_medic_station_miner.sp_hurt_miner_1));
	
		sleep_s(3);		
		repeat
			sleep_s(8);
			TutorialShowAll("training_tracking_mhub", 5);
			--sleep_s(7);
			--TutorialStopAll();
			sleep_s(15);
		until b_mhub_either_clue_pinged == true
	end
end

function f_mhub_clues_pinged(playerUnit:object, PingedObj:object):void
	b_mhub_either_clue_pinged = true;
	TutorialStop(unit_get_player(playerUnit));
end

--function f_mhub_sloan_intro_speech():void
--	sleep_s(46);
--	NarrativeQueue.QueueConversation(W1Station_citizen_reaction);
--	--sleep_s(4);
--	--NarrativeQueue.QueueConversation(W1Station_EXT__merIDIAN_STATION);
--	--sleep_s(3);
--end

function f_whub_sloan_show_all_done():void
	if b_mhub_player_is_close_to_sloan == true then
		b_mhub_sloan_intro_speech_done = true;
		NarrativeQueue.QueueConversation(W1Station_EXT__merIDIAN_STATION);
		NarrativeQueue.QueueConversation(W1Station_citizen_reaction);
		object_destroy(OBJECTS.s_mhub_breadcrumb_02);
	end
end

function f_mhub_start_sloan_patrols_start():void
	CreateThread(f_mhub_start_sloan_patrols);
end

function f_mhub_start_sloan_patrols():void
	sleep_s(1);
	if b_mhub_player_is_close_to_sloan == true then
		ai_set_blind(AI.sg_sloans_patrols, false);
		ai_set_deaf(AI.sg_sloans_patrols, false);
		ai_braindead(AI.sg_sloans_patrols, false);
		f_mhub_miningtown_patrol_female_1_start();
		f_mhub_miningtown_patrol_male_1_start();
	end
end



--function f_mhub_patrol_f_1_delay():void
--	sleep_s (random_range (1, 4));
--	f_mhub_miningtown_patrol_female_1_start();
--end

--function f_mhub_patrol_f_2_delay():void
--	sleep_s (random_range (1, 4));
--	f_mhub_miningtown_patrol_female_2_start();
--end

--function f_mhub_patrol_m_1_delay():void
--	sleep_s (random_range (1, 4));
--	f_mhub_miningtown_patrol_male_1_start();
--end

--function f_mhub_patrol_m_2_delay():void
--	sleep_s (random_range (1, 4));
--	f_mhub_miningtown_patrol_male_2_start();
--end

---- ===================================
-- Goal 3: SCANNING
---- ===================================
W1Hub.goal_clues = 
{
	--description = "OBJECTIVE: Get access to Network ",
	zoneSet = ZONE_SETS.miningtown,
	checkPoints = POINTS.ps_blink_clues01,
	--useObject = "devcon_clue_01",
	next = {"goal_clues_console"};
}  

function W1Hub.goal_clues.Start():void
	sleep_s(1);
	ObjectiveShow(TITLES.obj02);
	sleep_s(3);
	CreateThread(Clue01Init);
	CreateThread(Clue02Init);
	--ObjectSetSpartanTrackingEnabled(ai_get_object(AI.sq_mhub_miner_window_01.windows_01), true); --nar_cleaner_talk
	--ObjectSetSpartanTrackingEnabled(ai_get_object(AI.sq_mhub_miner_window_01.windows_02), true); -- nar_cleaner2_talk
	--ObjectSetSpartanTrackingEnabled(ai_get_object(AI.sq_right_gate.sp_right_miner_01), true); -- nar_fence_talk
	--ObjectSetSpartanTrackingEnabled(ai_get_object(AI.sq_right_gate.sp_right_miner_04), true); -- nar_fence_talk2
	--ObjectSetSpartanTrackingEnabled(ai_get_object(AI.sq_mhub_miner_leaner_01.leaner_03), true); -- nar_inventory2_talk
	--ObjectSetSpartanTrackingEnabled(ai_get_object(AI.sq_mhub_miner_leaner_01.leaner_01), true); -- nar_inventory_talk
	--ObjectSetSpartanTrackingEnabled(ai_get_object(AI.sq_left_gate.left_civ_01), true); -- nar_leftguard_talk
	--ObjectSetSpartanTrackingEnabled(ai_get_object(AI.sq_hub_ufc.mortalcombat), true); -- nar_ufc_talk  -- turned off later
	--ObjectSetSpartanTrackingEnabled(ai_get_object(AI.sq_mhub_patrol_welder.welder_02), true); -- nar_welder2_talk
	--ObjectSetSpartanTrackingEnabled(ai_get_object(AI.sq_mhub_patrol_welder.welder_01), true); -- nar_welder_talk
	CreateThread(f_w1hub_devcon_1_used);
	CreateThread(f_w1hub_devcon_2_used);
	SleepUntil([| DeviceUsed(OBJECTS.devcon_clue_01) and DeviceUsed(OBJECTS.devcon_clue_02) ], 30);
	GoalCompleteCurrent();
end

function f_w1hub_devcon_1_used():void
	SleepUntil([|DeviceUsed(OBJECTS.devcon_clue_01)], 2);
	device_set_power(OBJECTS.devcon_clue_01, 0);
	b_mhub_either_clue_pinged = true;
	TutorialStopAll();
	--sleep_s(1);
	--ObjectiveShow(TITLES.obj02);
end

function f_w1hub_devcon_2_used():void
	SleepUntil([|DeviceUsed(OBJECTS.devcon_clue_02)], 2);
	device_set_power(OBJECTS.devcon_clue_02, 0);
	b_mhub_either_clue_pinged = true;
	TutorialStopAll();
	--sleep_s(1);
	--ObjectiveShow(TITLES.obj02);
end

function f_w1hub_obj_reminder():void
	sleep_s(1);
	ObjectiveShow(TITLES.obj02);
end

function W1Hub.goal_clues.End():void
	--ObjectSetSpartanTrackingEnabled(ai_get_object(AI.sq_right_gate.sp_right_miner_04), false);
	--ObjectSetSpartanTrackingEnabled(ai_get_object(AI.sq_hub_ufc.mortalcombat), false);
	--put ending VO here if appropriate
	--CreateMissionThread(first_chiefclues_vo);
	b_w1hub_obj_reminder_off = true;
end

---- ===================================
-- Goal 4: SECURITY CONSOLE
---- ===================================

W1Hub.goal_clues_console = 
{
	--description = "OBJECTIVE: Get access to Network ",
	zoneSet = ZONE_SETS.miningtown,
	checkPoints = POINTS.ps_blink_clues01,
	next = {"goal_pelican"};
}  

function W1Hub.goal_clues_console.Start():void
	CreateThread(nar_chatter_off_vo);
	NarrativeQueue.QueueConversation(W1Station_SEARCHING_FOR_INFO);
	sleep_s(3);
	SleepUntil([|b_whub_terminal_ready_on == true], 30);
	--object_create_anew("devcon_clue_03");
	
	--CreateThread(Clue03Init);
	CreateThread(nar_computer_listener);

	sleep_s(3);

	SleepUntil ([| DeviceUsed(OBJECTS.devcon_clue_03) ], 30);
	print("Loom next mission: BEGIN");
	LoomNextCampaignMission();
	sleep_s(15);
	
	GoalCompleteCurrent();
end

global W1Station_SEARCHING_FOR_INFO = {
	name = "W1Station_SEARCHING_FOR_INFO",

	CanStart = function (thisConvo, queue)
		return b_first_clue_finished == true and b_second_clue_finished == true; -- GAMMA_CONDITION
	end,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,
	sleepBefore = 1,
	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		CreateThread(nar_chatter_off_vo);
		CreateThread(nar_turn_off_all_interacts);
	end,

	lines = {
		[1] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "So Apogee came under attack, and then a UNSC ship was seen heading that way.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_vale_00800.sound'),
		},
		[2] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Find a network terminal. I want to know more about Apogee Station.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_01700.sound'),
		},
--           OBJECTIVE: FIND THE SECURITY HUB
-- 
--           
-- 
--           FIND A NETWORK TERMINAL HINT

		[3] = {
					If = function (thisLine, thisConvo, queue, lineNumber)
				return b_used_terminal == false;
			end,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
		sleepBefore = 0.25,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Artemis ought to be able to track down a suitable network terminal. Ping it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_00900.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				CreateThread(f_mhub_terminal_hint);
			end,	
			
			sleepAfter = 0,
		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		CreateThread(nar_turn_chatter_back_on);
		CreateThread(nar_turn_on_all_interacts);
	end,

	localVariables = {},
};
         
function f_mhub_terminal_hint():void
	object_create_anew("devcon_clue_03");
	CreateThread(f_w1hub_devcon_3_used);
	b_whub_terminal_ready_on = true;
	sleep_s(0.25);
	ObjectiveShow(TITLES.obj04);
	--sleep_s(1);
	CreateThread(Clue03Init); -- OSR-146199 - moving this to make the ping available right after tanaka's above line - KS 8/7/15
	RegisterSpartanTrackingPingObjectEvent(f_mhub_clues_terminal_pinged, OBJECTS.devcon_clue_03); -- OSR-146199 - moving this to make the ping available right after tanaka's above line - KS 8/7/15
	sleep_s(3);
	
	repeat 
		sleep_s(8);
		TutorialShowAll("training_tracking_mhub_terminal", 5);
		sleep_s(15);
	until b_mhub_terminal_clue_pinged == true
end

function f_w1hub_devcon_3_used():void
	SleepUntil([|DeviceUsed(OBJECTS.devcon_clue_03)], 2);
	b_mhub_terminal_clue_pinged = true;
	TutorialStopAll();
end

function f_mhub_clues_terminal_pinged(playerUnit:object, PingedObj:object):void
	b_mhub_terminal_clue_pinged = true;
	TutorialStop(unit_get_player(playerUnit));
end

function nar_computer_listener()
	SleepUntil([|object_valid( "devcon_clue_03" )], 60);
	SleepUntil([|device_get_power( OBJECTS.devcon_clue_03) == 1], 60);
	CreateThread(RegisterInteractEvent, nar_computer_launcher, OBJECTS.devcon_clue_03);
end

function nar_computer_launcher(trigger:object, activator:object)
	PrintNarrative("LAUNCHER - nar_computer_launcher");
	print(activator, " is the activator of ", trigger);
	CreateThread(UnregisterInteractEvent, nar_computer_launcher, OBJECTS.devcon_clue_03);
	CreateThread(tracking_computer_used, activator)
end

function tracking_computer_used(activator:object)
CreateThread(nar_chatter_off_vo);
	b_used_terminal = true;
		sleep_s(1.5);
		if activator == SPARTANS.tanaka then
			NarrativeQueue.QueueConversation(W1Station_SEARCHING_FOR_INFO_tanaka);
		elseif activator == SPARTANS.buck then
			NarrativeQueue.QueueConversation(W1Station_SEARCHING_FOR_INFO_buck);
		elseif activator == SPARTANS.locke then
			NarrativeQueue.QueueConversation(W1Station_SEARCHING_FOR_INFO_locke);
		elseif activator == SPARTANS.vale then
			NarrativeQueue.QueueConversation(W1Station_SEARCHING_FOR_INFO_vale);
		end
end

global W1Station_SEARCHING_FOR_INFO_locke = {
	name = "W1Station_SEARCHING_FOR_INFO_locke",
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		CreateThread(nar_chatter_off_vo);
	end,

	lines = {
		[1] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Accessing terminal...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_01800.sound'),
			sleepAfter = 1, 
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
			RunClientScript("nar_download_pip");
			
				return 2; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},

		[2] = {
			sleepBefore = 3,
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					f_mhub_turn_on_sloan_monitor();
											hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,
			
			text = "Did I give you permission to poke about?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_sloan_01500.sound'),
		},
		[3] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Your people saw a UNSC ship out near Apogee Station.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_01900.sound'),
		},
		[4] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,
			sleepBefore = 0.5,
			text = "UNSC... at Apogee? Why are you people all over my planet? ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_sloan_01600.sound'),
		},
		[5] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "With your permission, we'd like to go ask them that ourselves.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_02000.sound'),
		},
		[6] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
											hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,
			sleepBefore = 0.5,
			text = "There's a cargo Pelican on the Meridian Station landing pad. It'll get you out to Apogee the quickest.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_sloan_01700.sound'),
		},
		[7] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "We appreciate it, Governor.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_02100.sound'),
		},
		[8] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
													hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,
			sleepBefore = 0.5,
			text = "I'm sure you do.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_sloan_01800.sound'),
			sleepAfter = 1,
		},
--           OBJECTIVE: BOARD THE PELICAN
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		CreateThread(f_mhub_pelican_hint);
		f_mhub_turn_off_sloan_monitor();
	CreateThread(nar_turn_chatter_back_on);
	end,

	localVariables = {},
};


function f_mhub_turn_on_sloan_monitor():void
	object_set_function_variable(OBJECTS.fx_sloan_monitor_01,"fx_screen_opacity",1,.25);
	object_set_function_variable(OBJECTS.fx_sloan_monitor_02,"fx_screen_opacity",1,.25);
end

function f_mhub_turn_off_sloan_monitor():void
	sleep_s(0.5);
	object_set_function_variable(OBJECTS.fx_sloan_monitor_01,"fx_screen_opacity",0,.25);
	object_set_function_variable(OBJECTS.fx_sloan_monitor_02,"fx_screen_opacity",0,.25);
end

function f_mhub_pelican_hint():void
	TutorialStopAll();
	RegisterSpartanTrackingPingObjectEvent(f_mhub_clues_pelican_pinged, OBJECTS.s_mhub_breadcrumb_pelican);
	
	sleep_s(1);
	ObjectiveShow(TITLES.obj05);
	CreateThread(audio_miningtown_boardpelican);
	sleep_s(3);
		
	repeat
		sleep_s(8);
		TutorialShowAll("training_tracking_mhub_pelican", 5);
		--sleep_s(7);
		--TutorialStopAll();
		sleep_s(15);
	until b_mhub_pelican_clue_pinged == true
end

function f_mhub_clues_pelican_pinged(playerUnit:object, PingedObj:object):void
	b_mhub_pelican_clue_pinged = true;
	TutorialStop(unit_get_player(playerUnit));
end

global W1Station_SEARCHING_FOR_INFO_buck = {
	name = "W1Station_SEARCHING_FOR_INFO_buck",
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
			text = "Accessing terminal...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_00700.sound'),
						AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
			RunClientScript("nar_download_pip");
			
				return 2; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},

		[2] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							f_mhub_turn_on_sloan_monitor();
													hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,
			sleepBefore = 3,
			text = "Did I give you permission to poke about?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_sloan_01500.sound'),
		},
		[3] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Your people saw a UNSC ship out near Apogee Station.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_01900.sound'),
		},
		[4] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
													hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,
			sleepBefore = 0.5,
			text = "UNSC... at Apogee? Why are you people all over my planet? ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_sloan_01600.sound'),
		},
		[5] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "With your permission, we'd like to go ask them that ourselves.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_02000.sound'),
		},
		[6] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
													hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,
			sleepBefore = 0.5,
			text = "There's a cargo Pelican on the Meridian Station landing pad. It'll get you out to Apogee the quickest.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_sloan_01700.sound'),
		},
		[7] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "We appreciate it, Governor.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_02100.sound'),
		},
		[8] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
													hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,
			sleepBefore = 0.5,
			text = "I'm sure you do.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_sloan_01800.sound'),
			sleepAfter = 1,
		},
--           OBJECTIVE: BOARD THE PELICAN

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		f_mhub_turn_off_sloan_monitor();
		CreateThread(f_mhub_pelican_hint);
			CreateThread(nar_turn_chatter_back_on);
	end,

	localVariables = {},
};

global W1Station_SEARCHING_FOR_INFO_vale = {
	name = "W1Station_SEARCHING_FOR_INFO_vale",

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
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Accessing terminal... ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_vale_00900.sound'),
						AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
			RunClientScript("nar_download_pip");
			
				return 2; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},

		[2] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							f_mhub_turn_on_sloan_monitor();
													hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,
			sleepBefore = 3,
			text = "Did I give you permission to poke about?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_sloan_01500.sound'),
		},
		[3] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Your people saw a UNSC ship out near Apogee Station.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_01900.sound'),
		},
		[4] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
													hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,
			sleepBefore = 0.5,
			text = "UNSC... at Apogee? Why are you people all over my planet? ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_sloan_01600.sound'),
		},
		[5] = {
						OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "With your permission, we'd like to go ask them that ourselves.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_02000.sound'),
		},
		[6] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
										hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,
			sleepBefore = 0.5,
			text = "There's a cargo Pelican on the Meridian Station landing pad. It'll get you out to Apogee the quickest.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_sloan_01700.sound'),
		},
		[7] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "We appreciate it, Governor.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_02100.sound'),
		},
		[8] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
										hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,
			sleepBefore = 0.5,
			text = "I'm sure you do.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_sloan_01800.sound'),
			sleepAfter = 1,
		},
--           OBJECTIVE: BOARD THE PELICAN

	},

	OnFinish = function (thisConvo, queue)
					hud_hide_radio_transmission_hud();
				f_mhub_turn_off_sloan_monitor();
				CreateThread(f_mhub_pelican_hint);
					CreateThread(nar_turn_chatter_back_on);
	end,

	localVariables = {},
};

global W1Station_SEARCHING_FOR_INFO_tanaka = {
	name = "W1Station_SEARCHING_FOR_INFO_tanaka",

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
			text = "Accessing terminal... ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_01000.sound'),
						AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)
			RunClientScript("nar_download_pip");
			
				return 2; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[2] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							f_mhub_turn_on_sloan_monitor();
									hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,
			sleepBefore = 3,
			text = "Did I give you permission to poke about?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_sloan_01500.sound'),
		},
		[3] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Your people saw a UNSC ship out near Apogee Station.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_01900.sound'),
		},
		[4] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
									hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,
			sleepBefore = 0.5,
			text = "UNSC... at Apogee? Why are you people all over my planet? ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_sloan_01600.sound'),
		},
		[5] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "With your permission, we'd like to go ask them that ourselves.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_02000.sound'),
		},
		[6] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
								hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,
			sleepBefore = 0.5,
			text = "There's a cargo Pelican on the Meridian Station landing pad. It'll get you out to Apogee the quickest.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_sloan_01700.sound'),
		},
		[7] = {
					OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "We appreciate it, Governor.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_02100.sound'),
		},
		[8] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
							hud_set_radio_transmission_team_string_id("liangdortmundteam_transmission_name");
				hud_show_radio_transmission_hud("sloan_transmission_name");
				hud_set_radio_transmission_portrait_index(15);
			end,

			sleepBefore = 0.5,
			text = "I'm sure you do.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_sloan_01800.sound'),
			sleepAfter = 1,
		},
--           OBJECTIVE: BOARD THE PELICAN

	},

	OnFinish = function (thisConvo, queue)
					hud_hide_radio_transmission_hud();
				f_mhub_turn_off_sloan_monitor();
				CreateThread(f_mhub_pelican_hint);
					CreateThread(nar_turn_chatter_back_on);
	end,

	localVariables = {},
};

---- ===================================
-- Goal 5: Get to Pelican
---- ===================================

W1Hub.goal_pelican = 
{
	--description = "OBJECTIVE: Board Pelican to Next Mission",
	--gotoVolume = VOLUMES.tv_next_mission,
	--make this a device control
	--navPoint = FLAGS.flag_next_mission,
	useObject = "devcon_pelican",
	zoneSet = ZONE_SETS.miningtown,
	--next = {"goal_palmer"};
}  

--function blink_pelican():void
--	--object_create_anew ("devcon_clue_01");
--  GoalBlink(W1Hub, "goal_pelican");
--end

function W1Hub.goal_pelican.Start():void  
	CreateThread(f_whub_end_stuff);
end

function f_whub_end_stuff():void
	sleep_s (2);
	CreateThread(nar_pelican_listener);
	object_create("s_mhub_breadcrumb_pelican");
	CreateThread(f_mhub_kill_breadcrumb_pelican);
end

function W1Hub.goal_pelican.End():void
	CreateThread (f_mhub_goal_end_call);
end

function f_mhub_goal_end_call():void
	sleep_s(3);
	CreateThread (MissionEnded);
	CreateThread(audio_miningtown_stopallmusic);
end

function MissionEnded()
	FadeOutMission();
	EndMission (W1Hub);
end


--###############################################################
--HELPER FUNCTIONS
--###############################################################

--this turns on tracking for the clue
function TurnOnClues(clue:object, trackedobj:object)
	SleepUntil([| object_index_valid (trackedobj())], 1);
	ObjectSetSpartanTrackingEnabled (trackedobj(), true);
	device_set_power (clue, 1);
	--navpoint_track_object (clue, true);
	SleepUntil ([| device_get_position (clue) > 0  ], 1);
	--navpoint_track_object (clue, false);
	ObjectSetSpartanTrackingEnabled (trackedobj(), false);
end

-- HELPER FUNCTIONS
function HubVignetteDeviceControl(objTable:table)
	local dev = ObjectFromName (objTable.dev);
	local trackedObj = objTable.trackedObj;
	local vol = objTable.volume;
	
	if trackedObj() then
		--attach the device control to the tracked object
		objects_attach (trackedObj(), "wall_proximity_front", dev, "");
	else
		print ("the tracked object isn't available");
	end
	--turn on tracking and the device
	device_set_power (dev, 1);
	--navpoint_track_object (dev, true);
	ObjectSetSpartanTrackingEnabled (trackedObj(), true);
	game_save_immediate();
	
	--check if the player is in volume and play the VO, end once the control is activated
	if objTable.vobank then
		repeat
			--play random bank if not playing
			VignettePlayVOBank(objTable);
			sleep_s (0.25);
			--	SleepUntil ([| volume_test_players (vol) ], 10);
			repeat
				if volume_test_players (vol) then 
					print ("should play VO nearby");
					if objTable.VONearby then
						--stop random bank
						VignetteEndVOBank (objTable);
						VignettePlayConversation (objTable.VONearby, vol);
						--NarrativeQueue.QueueConversation(objTable.VONearby);
						
					end
					--wait until a player presses X or out of volume, if pressed X continue on (if 5 seconds go by end the sleep)
					--SleepUntil ([| (not volume_test_players (vol) or DeviceUsed(dev) )], 3, seconds_to_frames (5));
				end
				sleep_s (0.25);
			until not objTable.vobank.currentlyPlaying;
		until DeviceUsed(dev);
	else
		SleepUntil ([| DeviceUsed(dev)], 3);
	end
	
	--turn off tracking
	ObjectSetSpartanTrackingEnabled (trackedObj(), false);
	
	--turn off the device just in case
	device_set_power (dev, 0);
	--state.near = true;
	
	if objTable.VOObj then
		--stop random bank
		VignetteEndVOBank (objTable);
		
		--play the objective VO
		VignettePlayConversation (objTable.VOObj, vol);
		--NarrativeQueue.QueueConversation(objTable.VOObj);
		
		--buffer to let the sound play out before starting random vo again
		sleep_s (3);
	end
	
	if objTable.vobank then
		--check if the player is in volume and play the VO
		repeat
			--play random bank if not playing
			VignettePlayVOBank(objTable);
		
			--	SleepUntil ([| volume_test_players (vol) ], 10);
			repeat
				if volume_test_players (vol) then 
					print ("should play VO afterObj");
					if objTable.VOAfterObj then
						--stop random bank
						VignetteEndVOBank (objTable);
						VignettePlayConversation (objTable.VOAfterObj, vol);
						--NarrativeQueue.QueueConversation(objTable.VONearby);
						
					end
					--SleepUntil ([| not volume_test_players (vol) ], 3, seconds_to_frames (5));
				end
				sleep_s (0.25);
			until not objTable.vobank.currentlyPlaying
		until false;
	end
--	repeat
--		--start random bank if necessary
--		SleepUntil ([| not volume_test_players (vol)], 10);
--		SleepUntil ([| volume_test_players (vol) ], 10);
--		print ("play VO afterObj");
--		if objTable.VOAfterObj then
--			--stop random bank
--			--NarrativeQueue.QueueConversation(objTable.VOAfterObj);
--			VignettePlayConversation (objTable.VOAfterObj, vol);
--		--wait until a player presses X or out of volume, if pressed X continue on
--		end
--	until false;
end

function DeviceUsed(dev:object):boolean
	if device_get_position (dev) > 0 then
		return true;
	end
end

function VignettePlayVOBank(votable:table)
	if votable.vobank then
		print ("playing random VO bank");
		NarrativeLoopBank.PlayNext( votable.vobank);
		--SleepUntil([| not votable.vobank.currentlyPlaying ], 15);
		sleep_s (0.5);
	end
end

function VignetteEndVOBank(votable:table)
	if votable.vobank.currentlyPlaying then
		print ("ending random VO bank");
		NarrativeQueue.EndConversationEarly(votable.vobank.conversation);
		SleepUntil([| NarrativeQueue.HasConversationFinished(votable.vobank.conversation) ], 1);
		--a buffer before the conversation starts so the VO lines aren't back to back
		sleep_s (0.5);
	end
end

function VignettePlayConversation(convo:table, volume:volume)
	--find the speaker

		--play the convo
		NarrativeQueue.QueueConversation(convo);
	
		--sleeping to make sure the conversation is queued
		Sleep (2);
		
		--commenting out exiting the convo based on volume because it's crit path
--		--if speaker leaves kill the convo
--		SleepUntil([| not PlayersNearVignette(volume) or NarrativeQueue.HasConversationFinished(convo) ], seconds_to_frames (0.25));
--		--print ("currently playing is ", NarrativeQueue.HasConversationFinished(votable.convo));
--	
--		--end the conversation if not players are around
--		if not NarrativeQueue.HasConversationFinished(convo) then
--			print ("player left volume before convo finished");
--			NarrativeQueue.EndConversationEarly(convo);
--		end
	
		SleepUntil([| NarrativeQueue.HasConversationFinished(convo) ], 1);
		--a buffer before the conversation starts so the VO lines aren't back to back
		sleep_s (0.5);
end

function VONearVol(vol:volume, VO:table, ending:string)
	--tell players to go to next objective
	repeat
		--wait until players are out of volume
		SleepUntil ([| not volume_test_players (vol) or _G[ending]], 10);
		SleepUntil ([| volume_test_players (vol) or _G[ending]], 10);
		--remove from queue somehow
		if not _G[ending] then
			print ("vo pre or post obj playing");
			NarrativeQueue.QueueConversation(VO);
			SleepUntil([| NarrativeQueue.HasConversationFinished(VO) ], 15);
		end
	until _G[ending];
	print (ending, " is true");
end

function TurnOffVehicleTracking()
	--I wish this was not so hacky...
	for i = 1,5 do
		ObjectSetSpartanTrackingEnabled (OBJECTS["ve_garage_mong_0"..i], false);
	end
	for i = 1,3 do
		ObjectSetSpartanTrackingEnabled (OBJECTS["mantis_"..i], false);
	end
end

---- =================================================================================================================================================       
-- *** SCENES ***
---- =================================================================================================================================================
function w1hub_scenes_start()
	-- start all the Scenes
	--composer_play_show("co_mong_patrols_a");
	composer_play_show("co_medic_station");
	composer_play_show("ci_generic_male_marine_medic");
	composer_play_show("ci_generic_male_marine_fore");
	--ai_place(AI.sq_medic_station_miner);
	composer_play_show("co_inner_gate");
	--ai_place(AI.sq_forerunner_room_miner);
	composer_play_show("co_forerunner_room");
	CreateThread(w1hub_mongoose_garage_scene);
	CreateThread(w1hub_right_gate_scene);
	CreateThread(w1hub_left_gate_scene);
	CreateThread(w1hub_sentries_scene);
	CreateThread(w1hub_big_door_scene);
	CreateThread(w1hub_bamf_pad_scene);
	CreateThread(w1hub_sweep_scene);
	CreateThread(w1hub_inventory_scene);
	object_cannot_take_damage(OBJECTS.c_w1hub_j_barrier);
	--unit_set_enterable_by_player(ai_get_object(AI.sq_mong_patrols_a), false);
end

function w1hub_mongoose_garage_scene()
	-- Mechanics in mongoose garage
	StartVignetteProximity(MongooseGarageVO);
end

function w1hub_right_gate_scene()
	-- Civie wants to get through gate
	StartVignetteProximity(RightGateVO);
end

function w1hub_left_gate_scene()
	-- Civie wants to get through gate
	StartVignetteProximity(LeftGateVO);
end

function w1hub_bamf_pad_scene()
--	 Civie wants to get through gate
	StartVignetteProximity(TeleportPadVO);
end

function w1hub_sweep_scene()
	-- Civie wants to get through gate
	StartVignetteProximity(SweepVO);
end

function w1hub_inventory_scene()
	-- Civie wants to get through gate
	StartVignetteProximity(InventoryMinerVO);
end

function w1hub_big_door_scene()
	-- Guards at big door under ship
	StartVignetteProximity(BigDoorVO);
end

function w1hub_sentries_scene()
	-- Sentries on buildings
	miningtown_guards_start();
end

--function w1hub_vig_pelican_flyover()
--	-- Pelican flies low over player after first gate
--	--RunClientScript("vig_pelican_SpawnEvent_01");
--	
--	--flock_start("flock_vig_pelican_01");
--	--flock_start("flock_vig_pelican_02");
--	print("flock_vig_pelican_01 started");
--	
--	sleep_s(5);
--	flock_stop("flock_vig_pelican_01");
--	flock_stop("flock_vig_pelican_02");
--
--	-- wait to spawn 2nd one until player is closer
--	--SleepUntil([| volume_test_players(VOLUMES.tv_2nd_peli_flyover) ], 1);
--	--RunClientScript("flock_vig_cargo_01");
--	--flock_start("flock_vig_cargo_01");  -- OSR-142529  Taking this thing out altogether KS 8/21/15
--end

function f_mhub_cola_ball():void
	local mhub_push_ball:number = 0;
	repeat
		SleepUntil ([| device_get_position(OBJECTS.devcon_clue_04) >= 1], 3);
		SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_vendingmachine\004_dm_vendingmachine_buttonpress.sound'), OBJECTS.devcon_clue_04, nil, 1);
		mhub_push_ball=mhub_push_ball + 1;
		device_set_position(OBJECTS.devcon_clue_04, 0);
		device_set_power(OBJECTS.devcon_clue_04, 0);
		if mhub_push_ball == 11 then
			
			object_create("cr_mhub_cone_01");
			object_create("cr_mhub_cone_02");
			object_create("cr_mhub_cone_03");
			object_create("cr_mhub_cone_04");
			object_create("cr_mhub_cone_05");
			object_create("cr_mhub_cone_06");
			object_create("cr_mhub_cone_07");
			object_create("cr_mhub_cone_08");
			object_create("cr_mhub_cone_09");
			object_create("cr_mhub_cone_10");
			object_create("cr_mhub_cone_11");
			object_create("cr_mhub_cone_12");
			object_create("cr_mhub_cone_13");
			object_create("cr_mhub_cone_14");
			object_create("cr_mhub_cone_15");
			object_create("cr_mhub_cone_16");
			object_create("cr_mhub_cone_17");
			object_create("cr_mhub_cone_18");
			object_create("cr_mhub_cone_19");
			object_create("cr_mhub_j_barrier_goal_01");
			Sleep(1);
			object_cannot_take_damage(OBJECTS.cr_mhub_j_barrier_goal_01);
			Sleep(2);
			--SoundImpulseStartServer(TAG('sound\004_device_machine\004_dm\004_dm_vendingmachine\004_dm_vendingmachine_scocerballspawn.sound'), nil, 1);
			object_create("cr_mhub_soccer_ball");
			SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_vendingmachine\004_dm_vendingmachine_scocerballspawn.sound'), OBJECTS.cr_mhub_soccer_ball, nil, 1);
			sleep_s(2);
			NarrativeQueue.QueueConversation(W1Station_Soccer_ball_appear);
			CreateThread(f_mhub_sball_goal_1);
			CreateThread(f_mhub_sball_goal_2);
		end
		sleep_s (1);
		device_set_power(OBJECTS.devcon_clue_04, 1);
	until mhub_push_ball == 11
	device_set_power(OBJECTS.devcon_clue_04, 0);
end


---- ============================================================================================================
--  GUARD BUMPS
---- ============================================================================================================
global W1Station_Ext__Garage = {
	name = "W1Station_Ext__Garage",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
	AIDialogManager.DisableAIDialog();
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_garage_vo == 0;
			end,
			character = CHARACTER_OBJECTS.sloan_pa, -- GAMMA_CHARACTER: SLOAN
			text = "I'm assessing the damage now ... scattered fires, but nothing permanent.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_sloan_02000.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_garage_vo == 0;
			end,
			sleepBefore = 0.5,
			character = AI.sq_garage.sp_mechanic_01, -- GAMMA_CHARACTER: MinerMALE01
			text = "Good to hear. What's with the armor jockeys?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale01_00700.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_garage_vo == 0;
			end,
			character = CHARACTER_OBJECTS.sloan_pa, -- GAMMA_CHARACTER: SLOAN
			text = "My concern, not yours. Focus on getting those Mongooses operational.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_sloan_02100.sound'),
		},
--           SLOAN turns off

		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_garage_vo == 0;
			end,
			character = AI.sq_garage.sp_mechanic_02, -- GAMMA_CHARACTER: MINERMALE03
			text = "You got it, Governor Sloan.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_00300.sound'),
		},

--           Chunk 2

		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_garage_vo == 1;
			end,
			character = AI.sq_garage.sp_mechanic_02, -- GAMMA_CHARACTER: Minermale03
			text = "Mongooses?  ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_00400.sound'),
		},
		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_garage_vo == 1;
			end,
			sleepBefore = 0.5,
			character = AI.sq_garage.sp_mechanic_01, -- GAMMA_CHARACTER: Minermale01
			text = "What's that?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale01_00800.sound'),
		},
		[7] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return n_garage_vo == 1;
			end,
			sleepBefore = 0.5,
			character = AI.sq_garage.sp_mechanic_02, -- GAMMA_CHARACTER: MINERMALE03
			text = "Governor said mongooses. Mongeese though, yeah?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_00500.sound'),
		},
		[8] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_garage_vo == 1;
			end,
			sleepBefore = 0.5,
			character = AI.sq_garage.sp_mechanic_01, -- GAMMA_CHARACTER: MINERMALE01
			text = "What? No. Mongooses is the plural of Mongoose.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale01_00900.sound'),
		},
		[9] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_garage_vo == 1;
			end,
			sleepBefore = 0.5,
			character = AI.sq_garage.sp_mechanic_02, -- GAMMA_CHARACTER: MINERMALE03
			text = "But goose, geese. Not gooses.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_00600.sound'),
		},
		[10] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_garage_vo == 1;
			end,
			sleepBefore = 0.5,
			character = AI.sq_garage.sp_mechanic_01, -- GAMMA_CHARACTER: MINERMALE01
			text = "Mongoose is mongooses, man. I don't know what to tell ya.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale01_01000.sound'),
		},
		[11] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_garage_vo == 1;
			end,
			sleepBefore = 0.5,
			character = AI.sq_garage.sp_mechanic_02, -- GAMMA_CHARACTER: MINERMALE03
			text = "That doesn't make sense.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_00700.sound'),
		},
		[12] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_garage_vo == 1;
			end,
			sleepBefore = 0.5,
			character = AI.sq_garage.sp_mechanic_01, -- GAMMA_CHARACTER: MINERMALE01
			text = "Most things don't, but life goes on. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale01_01100.sound'),
		},
--           
-- 
--           Chunk 3

		[13] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_garage_vo == 2;
			end,
			sleepBefore = 0.5,
			character = AI.sq_garage.sp_mechanic_01, -- GAMMA_CHARACTER: MINERMALE01
			text = "UNSC armor stomping around like they belong here.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale01_01200.sound'),
		},
		[14] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_garage_vo == 2;
			end,
			sleepBefore = 0.5,
			character = AI.sq_garage.sp_mechanic_02, -- GAMMA_CHARACTER: MINERMALE03
			text = "Just ignore 'em.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_00900.sound'),
		},
		[15] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_garage_vo == 2;
			end,
			sleepBefore = 0.5,
			character = AI.sq_garage.sp_mechanic_01, -- GAMMA_CHARACTER: MINERMALE01
			text = "Aliens attack and these guys show up not twenty minutes later.  ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale01_01300.sound'),
		},
		[16] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_garage_vo == 2;
			end,
			character = AI.sq_garage.sp_mechanic_02, -- GAMMA_CHARACTER: MINERMALE03
			text = "Is this the start of another conspiracy rant?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_01000.sound'),
		},
		[17] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_garage_vo == 2;
			end,
			sleepBefore = 0.5,
			character = AI.sq_garage.sp_mechanic_01, -- GAMMA_CHARACTER: Minermale01
			text = "Ain't a conspiracy if they're already walking through town.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale01_01400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	AIDialogManager.EnableAIDialog();
		if n_garage_vo == 0 then
			n_garage_vo = 1;
		elseif n_garage_vo == 1 then
			n_garage_vo = 2;
		elseif n_garage_vo == 2 then
			n_garage_vo = 3;
		end;

	end,

	localVariables = {},
};


---- ============================================================================================================
--  MEDIC TENT
---- ============================================================================================================
global W1Station_MEDIC_TENT = {
	name = "W1Station_MEDIC_TENT",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	sleepBefore = 1,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 0;
			end,
			character = AI.sq_medic_station.sp_medic_2, -- GAMMA_CHARACTER: MINERMALE04
			text = "I've done what I can, but we can't offer much in the way of intensive care.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MINERFEMALE07_01400.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 0;
			end,
			sleepBefore = 0.5,
			character = AI.sq_medic_station.sp_medic_1, -- GAMMA_CHARACTER: MINERFEMALE04
			text = "Just get everyone stable. Treat the inhalation injuries first, then the glass burns.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale04_00300.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 0;
			end,
			sleepBefore = 0.5,
			character = AI.sq_medic_station.sp_medic_2, -- GAMMA_CHARACTER: MinerMALE01
			text = "Should we start a distress call? If it gets bad, we might have to contact--",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MINERFEMALE07_01500.sound'),
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 0;
			end,
			sleepBefore = 0.5,
			character = AI.sq_medic_station.sp_medic_1, -- GAMMA_CHARACTER: MINERFEMALE04
			text = "When it gets bad? It's already pretty damn bad. Tend to your patients and let Sloan handle the politics.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale04_00400.sound'),
		},
--           Chunk 2

		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 1;
			end,
			sleepBefore = 0.5,
			character = AI.sq_medic_station.sp_medic_2, -- GAMMA_CHARACTER: MINERmale04
			text = "How are we so low on supplies?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MINERFEMALE07_01600.sound'),
		},
		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 1;
			end,
			sleepBefore = 0.5,
			character = AI.sq_medic_station.sp_medic_1, -- GAMMA_CHARACTER: Minerfemale04
			text = "Liang-Dortmund said their milestones weren't being hit. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale04_00500.sound'),
		},
		[7] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 1;
			end,
			sleepBefore = 0.5,
			character = AI.sq_medic_station.sp_medic_2, -- GAMMA_CHARACTER: MINERMALE04
			text = "Oh, like hell.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MINERFEMALE07_01700.sound'),
		},
		[8] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 1;
			end,
			sleepBefore = 0.5,
			character = AI.sq_medic_station.sp_medic_1, -- GAMMA_CHARACTER: Minerfemale04
			text = "Governor Sloan'll sort it. He always does.", 
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale04_00600.sound'),
		},
		[9] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 1;
			end,
					sleepBefore = 0.5,
			character = AI.sq_medic_station.sp_medic_2, -- GAMMA_CHARACTER: MinerMALE04
			text = "Bean counter's endangering lives, man. All because we didn't chip off as many acres of glass as they think we should have?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MINERFEMALE07_01800.sound'),
		},
		[10] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 1;
			end,
					sleepBefore = 0.5,
			character = AI.sq_medic_station.sp_medic_1, -- GAMMA_CHARACTER: MINERFEMALE04
			text = "Work with what we've got. Let Sloan deal with L-D-C.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale04_00700.sound'),
		},
--           Chunk 3

		[11] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 2;
			end,
					sleepBefore = 0.5,
			character = AI.sq_medic_station.sp_medic_1, -- GAMMA_CHARACTER: Minerfemale04
			text = "Patients stabilized?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale04_00800.sound'),
		},
		[12] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 2;
			end,
					sleepBefore = 0.5,
			character = AI.sq_medic_station.sp_medic_2, -- GAMMA_CHARACTER: Minermale01
			text = "We're actually pretty solid. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MINERFEMALE07_01900.sound'),
		},
		[13] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 2;
			end,
					sleepBefore = 0.5,
			character = AI.sq_medic_station.sp_medic_1, -- GAMMA_CHARACTER: MINERFEMALE04
			text = "You're good at what you do. Supplies or not.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale04_00900.sound'),
		},
		[14] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 2;
			end,
					sleepBefore = 0.5,
			character = AI.sq_medic_station.sp_medic_1, -- GAMMA_CHARACTER: MINERMALE01
			text = "Well... thank you. But we could do more.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MINERFEMALE07_02000.sound'),
		},
		[15] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_medic_tent == 2;
			end,
					sleepBefore = 0.5,
			character = AI.sq_medic_station.sp_medic_1, -- GAMMA_CHARACTER: MINERFEMALE04
			text = "And we will. Enjoy the small victories.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale04_01000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	hud_hide_radio_transmission_hud();
		if n_medic_tent == 0 then
			n_medic_tent = 1;
		elseif n_medic_tent == 1 then
			n_medic_tent = 2;
		elseif n_medic_tent == 2 then
			n_medic_tent = 3;
		end;
	end,

	localVariables = {},
};

---- ============================================================================================================
--  GATES
---- ============================================================================================================
global W1Station_Main_back_gate = {
	name = "W1Station_Main_back_gate",

			sleepBefore = 1,

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {

		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_gatemain_vo == 0;
			end,
					sleepBefore = 0.5,
			character = AI.sq_big_door.sp_bigdoor_02, -- GAMMA_CHARACTER: MINERMALE04 (guard)
			text = "You see any hostiles? Area looks pretty much secure.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale04_02400.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_gatemain_vo == 0;
			end,
					sleepBefore = 0.5,
			character = AI.sq_big_door.sp_bigdoor_01, -- GAMMA_CHARACTER: MINERMALE03 (guard)
			text = "I don't see anything, but Governor Sloan's got more eyes than me. Not liftin' this shutter until he gives the all-clear.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale05_01100.sound'),
		},
--           Chunk 3

		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_gatemain_vo == 1;
			end,
					sleepBefore = 0.5,
			character = AI.sq_big_door.sp_bigdoor_02, -- GAMMA_CHARACTER: MINERMALE04 (GUARD)
			text = "You figure we could crack the shutter open, give the habitation area some fresh air?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale04_02500.sound'),
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_gatemain_vo == 1;
			end,
					sleepBefore = 0.5,
			character = AI.sq_big_door.sp_bigdoor_01, -- GAMMA_CHARACTER: Minermale03 (guard)
			text = "They've got the ventilation fans.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale05_01200.sound'),
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_gatemain_vo == 1;
			end,
					sleepBefore = 0.5,
			character = AI.sq_big_door.sp_bigdoor_02, -- GAMMA_CHARACTER: Minermale04 (GUARD)
			text = "Come on. You know how hot it gets in there with these things closed.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale04_02600.sound'),
		},
		[6] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_gatemain_vo == 1;
			end,
					sleepBefore = 0.5,
			character = AI.sq_big_door.sp_bigdoor_01, -- GAMMA_CHARACTER: Minermale03 (GUARD)
			text = "Do you not see the four heavily armed thugs walking around here, waiting for somethin' to shoot? ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale05_01300.sound'),
		},
		[7] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_gatemain_vo == 1;
			end,
					sleepBefore = 0.5,
			character = AI.sq_big_door.sp_bigdoor_02, -- GAMMA_CHARACTER: MINERMALE04 (GUARD)
			text = "Sloan said they wouldn't start trouble.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale04_02700.sound'),
		},
		[8] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_gatemain_vo == 1;
			end,
					sleepBefore = 0.5,
			character = AI.sq_big_door.sp_bigdoor_01, -- GAMMA_CHARACTER: Minermale03 (guard)
			text = "And he also said to keep the shutter closed. Orders are orders.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale05_01400.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
		if n_gatemain_vo == 0 then
			n_gatemain_vo = 1;
		elseif n_gatemain_vo == 1 then
			n_gatemain_vo = 2;
		elseif n_gatemain_vo == 2 then
			n_gatemain_vo = 3;
		end;
	end,

	localVariables = {},
};


global W1Station_Gate_1 = {
	name = "W1Station_Gate_1",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		AIDialogManager.DisableAIDialog();
	end,

	lines = {
--           Chunk 1

		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_gate_right == 0;
			end,
			character = AI.sq_right_gate.sp_right_guard_01, -- GAMMA_CHARACTER: Minermale03 (guard)
			text = "Don't be alarmed, the fire is being contained.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MinerMale09_00400.sound'),
		},
		[2] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_gate_right == 0;
			end,
					sleepBefore = 0.5,
			character = AI.sq_right_gate.sp_right_civ_02, -- GAMMA_CHARACTER: Minermale01
			text = "It doesn't look very contained.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale01_01500.sound'),
		},
		[3] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_gate_right == 0;
			end,
					sleepBefore = 0.5,
			character = AI.sq_right_gate.sp_right_guard_01, -- GAMMA_CHARACTER: MINERMALE03 (guard)
			text = "We have it limited to the nonessential supplies.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MinerMale09_00500.sound'),
		},
		[4] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_gate_right == 0;
			end,
					sleepBefore = 0.5,
			character = AI.sq_right_gate.sp_right_civ_01, -- GAMMA_CHARACTER: Minerfemale02
			text = "We have nonessential supplies?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale02_01200.sound'),
		},
		[5] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_gate_right == 0;
			end,
					sleepBefore = 0.5,
			character = AI.sq_right_gate.sp_right_guard_01, -- GAMMA_CHARACTER: Minermale03 (guard)
			text = "Just stay back, please.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MinerMale09_01200.sound'),
		},
--           Chunk 2

		[6] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_gate_right == 1;
			end,
					sleepBefore = 0.5,
			character = AI.sq_right_gate.sp_right_guard_01, -- GAMMA_CHARACTER: Minermale03 (guard)
			text = "Those damn things hit everything that can burn. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MinerMale09_00600.sound'),
		},
		[7] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_gate_right == 1;
			end,
					sleepBefore = 0.5,
			character = AI.sq_right_gate.sp_right_civ_01, -- GAMMA_CHARACTER: MINERFEMALE02
			text = "We didn't lose anybody, did we?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale02_01300.sound'),
		},
		[8] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_gate_right == 1;
			end,
					sleepBefore = 0.5,
			character = AI.sq_right_gate.sp_right_guard_01, -- GAMMA_CHARACTER: Minermale03 (GUARD)
			text = "Don't think so. It was a small attack force.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MinerMale09_00700.sound'),
		},
		[9] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return n_gate_right == 1;
			end,
					sleepBefore = 0.5,
			character = AI.sq_right_gate.sp_right_civ_01, -- GAMMA_CHARACTER: Minerfemale02
			text = "Doc Cale says it could have been a lot worse.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale02_01400.sound'),
		},
--           Chunk 3

		[10] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_gate_right == 2;
			end,
					sleepBefore = 0.5,
			character = AI.sq_right_gate.sp_right_guard_01, -- GAMMA_CHARACTER: Minermale03 (GUARD)
			text = "Maintain a safe distance and keep it moving, ma'am.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MinerMale09_00800.sound'),
		},
		[11] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_gate_right == 2;
			end,
					sleepBefore = 0.5,
			character = AI.sq_right_gate.sp_right_civ_01, -- GAMMA_CHARACTER: Minerfemale02
			text = "Don't be a hardass, Bradley.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale02_01500.sound'),
		},
		[12] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_gate_right == 2;
			end,
					sleepBefore = 0.5,
			character = AI.sq_right_gate.sp_right_guard_01, -- GAMMA_CHARACTER: Minermale03 (GUARD)
			text = "Fine! But you gotta disperse if Sloan checks in!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MinerMale09_00900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
		if n_gate_right == 0 then
			n_gate_right = 1;
		elseif n_gate_right == 1 then
			n_gate_right = 2;
		elseif n_gate_right == 2 then
			n_gate_right = 3;
		end;
	end,

	localVariables = {},
};


global W1Station_tower_gate = {
	name = "W1Station_tower_gate",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
	AIDialogManager.DisableAIDialog();
		print(thisConvo.name, " narrative");
			CreateThread(nar_turn_off_all_interacts);
	end,

	lines = {
--           Chunk 1

		[1] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_gate_left == 0;
			end,
					sleepBefore = 0.5,
			character = AI.sq_left_gate.left_civ_01, -- GAMMA_CHARACTER: Minermale04
			text = "What the hell happened?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MinerFemale08_00500.sound'),
		},
		[2] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_gate_left == 0;
			end,
					sleepBefore = 0.5,
			character = AI.sq_left_gate.left_guard_02, -- GAMMA_CHARACTER: Minermale02 (GUARD)
			text = "Tower got hit in the attack.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale02_01200.sound'),
		},
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_gate_left == 0;
			end,
					sleepBefore = 0.5,
			character = AI.sq_left_gate.left_civ_01, -- GAMMA_CHARACTER: Minermale04
			text = "Everyone make it out okay?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MinerFemale08_00600.sound'),
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_gate_left == 0;
			end,
					sleepBefore = 0.5,
			character = AI.sq_left_gate.left_guard_02, -- GAMMA_CHARACTER: MINERMALE02 (GUARD)
			text = "Yeah. It went up slow.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale02_01300.sound'),
		},
		[5] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return n_gate_left == 0;
			end,
					sleepBefore = 0.5,
			character = AI.sq_left_gate.left_civ_01, -- GAMMA_CHARACTER: Minermale04
			text = "Small favors, right?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MinerFemale08_00700.sound'),
		},
	},
	OnFinish = function (thisConvo, queue)
	CreateThread(nar_turn_on_all_interacts);
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();	
		if n_gate_left == 0 then
			n_gate_left = 1;
		elseif n_gate_left == 1 then
			n_gate_left = 2;
		elseif n_gate_left == 2 then
			n_gate_left = 3;
		end;
	end;

	localVariables = {},
};

---- ============================================================================================================
--  GUARD BUMPS
---- ============================================================================================================
global guardbankData = {
    {	-- Sequence 1
		name = "guard seq 1",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				-- character = 0,
				text = "Watch it, UNSC.",
				tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale01_00200.sound'),
				--OnStart = function() end,
				--OnFinish = function() end,
			},
		},
		--OnFinish = function() end,
	},

		{	-- Sequence 2
		name = "guard seq 2",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 2, Line 1
				--character = 0,
			text = "Easy, now.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale01_00300.sound'),
				--OnStart = function() end,
				--OnFinish = function() end,
			},
		},
		--OnFinish = function() end,
	},


};

global guardFemalebankData = {
    {	-- Sequence 1
		name = "guard seq 1",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 1, Line 1
				-- character = 0,
			text = "Watch it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MINERFEMALE02_00300.sound'),
				--OnStart = function() end,
				--OnFinish = function() end,
			},
		},
		--OnFinish = function() end,
	},

		{	-- Sequence 2
		name = "guard seq 2",
		--OnStart = function() end,
		lines = {
			{		-- Sequence 2, Line 1
				--character = 0,
			text = "Hey!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MINERFEMALE02_00400.sound'),
				--OnStart = function() end,
				--OnFinish = function() end,
			},
		},
		--OnFinish = function() end,
	},
};


function nar_pelican_listener()
	SleepUntil([| object_valid( "devcon_pelican" ) ], 60);
	PrintNarrative("LISTENER - nar_pelican_listener THREADED");
	SleepUntil([| device_get_power( OBJECTS.devcon_pelican) == 1 ], 60);
	PrintNarrative("LISTENER - nar_pelican_listener");
	CreateThread(RegisterInteractEvent, nar_pelican_launcher, OBJECTS.devcon_pelican);
end

function nar_pelican_launcher(trigger:object, activator:object)
	PrintNarrative("LAUNCHER - nar_pelican_launcher");
	print(activator, " is the activator of ", trigger);
	CreateThread(UnregisterInteractEvent, nar_pelican_launcher, OBJECTS.devcon_pelican);
	CreateThread(nar_pelican_start, activator)
end

function nar_pelican_start(activator:object)
	if activator == SPARTANS.locke then
		NarrativeQueue.QueueConversation(W1Station_pelican_takeoff_locke);
			
		elseif activator == SPARTANS.buck  then
			NarrativeQueue.QueueConversation(W1Station_pelican_takeoff_buck);
		elseif activator == SPARTANS.tanaka  then
			NarrativeQueue.QueueConversation(W1Station_pelican_takeoff_tanaka);
		elseif activator == SPARTANS.vale  then
			NarrativeQueue.QueueConversation(W1Station_pelican_takeoff_vale);
		end
end

global W1Station_pelican_takeoff_locke = {
	name = "W1Station_pelican_takeoff_locke",

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
			text = "Boarding the pelican.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_03200.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global W1Station_pelican_takeoff_buck = {
	name = "W1Station_pelican_takeoff_buck",

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
			text = "Boarding the pelican.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_01500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
			hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global W1Station_pelican_takeoff_vale = {
	name = "W1Station_pelican_takeoff_vale",

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

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: vale
			text = "Boarding the pelican.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_vale_01700.sound'),
		},

	},
	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};

global W1Station_pelican_takeoff_tanaka = {
	name = "W1Station_pelican_takeoff_tanaka",

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
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: tanaka
			text = "Boarding the pelican.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_02000.sound'),

		},
	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
	end,

	localVariables = {},
};



function nar_ufc_listener()
	SleepUntil([| object_valid( "nar_ufc_talk" ) ], 60);
	PrintNarrative("LISTENER - nar_ufc_listener THREADED");
	SleepUntil([| device_get_power( OBJECTS.nar_ufc_talk) == 1 ], 60);	
	PrintNarrative("LISTENER - nar_ufc_listener");
	CreateThread(RegisterInteractEvent, nar_ufc_launcher, OBJECTS.nar_ufc_talk);
end

function nar_ufc_launcher(trigger:object, activator:object)
	PrintNarrative("LAUNCHER - nar_ufc_launcher");
	print(activator, " is the activator of ", trigger);
	CreateThread(UnregisterInteractEvent, nar_ufc_launcher, OBJECTS.nar_ufc_talk);
	CreateThread(nar_ufc_start, activator)
end

function nar_ufc_start(activator:object)

sleep_s(0.5);
	if activator == SPARTANS.locke and b_first_activation == false then
		NarrativeQueue.QueueConversation(W1Station_roof_miners_locke);
		sleep_s(2);
		NarrativeQueue.QueueConversation(W1Station_roof_miners_02);
		elseif activator == SPARTANS.buck and b_first_activation == false then
			NarrativeQueue.QueueConversation(W1Station_roof_miners_buck);
			sleep_s(2);
		NarrativeQueue.QueueConversation(W1Station_roof_miners_02);
		elseif activator == SPARTANS.tanaka and b_first_activation == false  then
			NarrativeQueue.QueueConversation(W1Station_roof_miners_tanaka);
			sleep_s(2);
		NarrativeQueue.QueueConversation(W1Station_roof_miners_02);
		elseif activator == SPARTANS.vale and b_first_activation == false  then
			NarrativeQueue.QueueConversation(W1Station_roof_miners_vale);
			sleep_s(2);
			NarrativeQueue.QueueConversation(W1Station_roof_miners_02);
		elseif n_rooftop_miners == 1 then
			NarrativeQueue.QueueConversation(W1Station_roof_miners_02);
		elseif n_rooftop_miners == 2 then
			print("done");
		end
		b_first_activation = true;
end

global W1Station_roof_miners_locke = {
	name = "W1Station_roof_miners_locke",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
	AIDialogManager.DisableAIDialog();
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Hello.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_03600.sound'),
			
		},

},
	OnFinish = function (thisConvo, queue)
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
		CreateThread(f_mhub_ufc_interact_1);
	end,

	localVariables = {},
};

global W1Station_roof_miners_vale = {
	name = "W1Station_roof_miners_vale",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
	AIDialogManager.DisableAIDialog();
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Hey.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_vale_02100.sound'),
		},

},
	OnFinish = function (thisConvo, queue)
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
		CreateThread(f_mhub_ufc_interact_1);
	end,

	localVariables = {},
};

global W1Station_roof_miners_buck = {
	name = "W1Station_roof_miners_buck",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
	AIDialogManager.DisableAIDialog();
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Hey.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_01900.sound'),
		},

},
	OnFinish = function (thisConvo, queue)
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
		CreateThread(f_mhub_ufc_interact_1);
	end,

	localVariables = {},
};
global W1Station_roof_miners_tanaka = {
	name = "W1Station_roof_miners_tanaka",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
	AIDialogManager.DisableAIDialog();
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Hello.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_02400.sound'),
		},
},
	OnFinish = function (thisConvo, queue)
		AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
		CreateThread(f_mhub_ufc_interact_1);
	end,

	localVariables = {},
};

function f_mhub_ufc_interact_1():void
	sleep_s(0.5);
	if ufc_interact_01_over == true then
		ufc_interact_02 = true;
		device_set_power(OBJECTS.nar_ufc_talk, 0);
		device_set_position(OBJECTS.nar_ufc_talk, 1);
	end
	Sleep(5);
	if ufc_interact_01 == false then
		ufc_interact_01 = true;
		ufc_interact_01_over = true;
	end
end

global W1Station_roof_miners_01 = {
	name = "W1Station_roof_miners_01",

		CanStart = function (thisConvo, queue) -- BOOLEAN
		return volume_test_players(VOLUMES.tv_whub_ufc);
	end,


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
	AIDialogManager.DisableAIDialog();
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return n_rooftop_miners == 0;
			end,
			character = AI.sq_hub_ufc.translator, -- GAMMA_CHARACTER: Roofminer02
			ufc_approach_01 = true;
--			text = "Hey, Spartan! My friend here has some strange ideas about the aliens who attacked us.",
--			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_roofminer02_00100.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
	AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
	
	end,

	localVariables = {},
};

global W1Station_roof_miners_02 = {
	name = "W1Station_roof_miners_02",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
	AIDialogManager.DisableAIDialog();
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return n_rooftop_miners == 0;
			end,
			
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				--n_mhub_ufc_talk = composer_play_show("ci_ufc_convo_01_ufc");
				cs_look_player(AI.sq_hub_ufc.mortalcombat, true);
			end,
			
			sleepBefore = 1,
			character = AI.sq_hub_ufc.mortalcombat, -- GAMMA_CHARACTER: Roofminer01
			
			--ufc_interact_01 = true;
--			text = "Eles agiam como se estivessem recebendo ordens de uma grande central de intelig^ncia.",
--			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_roofminer01_00100.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				--composer_stop_show(n_mhub_ufc_talk);
			end,
		},
		[2] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
					return n_rooftop_miners == 0;
				end,
				
				OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					--n_mhub_ufc_trans = composer_play_show("ci_ufc_convo_02_trans");
					cs_look_player(AI.sq_hub_ufc.translator, true);
				end,
			
			character = AI.sq_hub_ufc.translator, -- GAMMA_CHARACTER: RoofMINER02
			--text = "Uh huh. Yeah. Ah. He says ... they were very intelligent.",
			--tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_roofminer02_00200.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				--composer_stop_show(n_mhub_ufc_trans);
			end,
			
		},
		[3] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return n_rooftop_miners == 0;
			end,

			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				--n_mhub_ufc_talk = composer_play_show("ci_ufc_convo_01_ufc");
			end,
						
			character = AI.sq_hub_ufc.mortalcombat, -- GAMMA_CHARACTER: RoofMINER01
			--text = "Uma rede neural t^o avan^ada seria capaz de abordar a degrada^^o que ocorre com o envelhecimento de intelig^ncias artificiais.",
			--tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_roofminer01_00200.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				--composer_stop_show(n_mhub_ufc_talk);
			end,
						
		},
		[4] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return n_rooftop_miners == 0;
			end,

				OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					--n_mhub_ufc_trans = composer_play_show("ci_ufc_convo_02_trans");
				end,
							
			character = AI.sq_hub_ufc.translator, -- GAMMA_CHARACTER: RooFMINER02
			--text = "And something about degrading networks?  ",
			--tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_roofminer02_00300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				--composer_stop_show(n_mhub_ufc_trans);
			end,
						
		},
		[5] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return n_rooftop_miners == 0;
			end,

			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				--n_mhub_ufc_talk = composer_play_show("ci_ufc_convo_01_ufc");
			end,
						
			character = AI.sq_hub_ufc.mortalcombat, -- GAMMA_CHARACTER: Roofminer01
			--text = "Voc^ n^o entende? Se as intelig^ncias artificiais pudessem ser hospedadas eternamente em uma matriz de rede, nada  impediria elas de superar a vida biol^gica!",
			--tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_roofminer01_00300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				--composer_stop_show(n_mhub_ufc_talk);
			end,
						
		},
		[6] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return n_rooftop_miners == 0;
			end,

				OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					--n_mhub_ufc_trans = composer_play_show("ci_ufc_convo_02_trans");
				end,
							
			character = AI.sq_hub_ufc.translator, -- GAMMA_CHARACTER: Roofminer02
			--text = "He says ... never mind. Sorry for wasting your time, Spartans.",
			--tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_roofminer02_00400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				--composer_stop_show(n_mhub_ufc_trans);
				ufc_interact_ready_02 = true;
			end,
						
		},
--           Conversation 2

	
		[7] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return n_rooftop_miners == 1;
			end,

			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				--n_mhub_ufc_talk = composer_play_show("ci_ufc_convo_01_ufc");
				device_set_power(OBJECTS.nar_ufc_talk, 0);
				device_set_position(OBJECTS.nar_ufc_talk, 1);
			end,
						
			sleepBefore = 1,
			character = AI.sq_hub_ufc.mortalcombat, -- GAMMA_CHARACTER: Roofminer01
			ufc_interact_02 = true;
			--text = "A gente sabe como derrotar os alien^genas.",
			--tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_roofminer01_00400.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				--composer_stop_show(n_mhub_ufc_talk);
			end,
						
		},
		[8] = {

				If = function(thisLine, thisConvo, queue, lineNumber)
				return n_rooftop_miners == 1;
			end,
				OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					--n_mhub_ufc_trans = composer_play_show("ci_ufc_convo_02_trans");
				end,
							
			character = AI.sq_hub_ufc.translator, -- GAMMA_CHARACTER: Roofminer02
			--text = "The creatures who attacked, they have a terrible weakness.",
			--tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_roofminer02_00600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				--composer_stop_show(n_mhub_ufc_trans);
			end,
						
		},
		[9] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return n_rooftop_miners == 1;
			end,
			
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				--n_mhub_ufc_talk = composer_play_show("ci_ufc_convo_01_ufc");
			end,
						
			character = AI.sq_hub_ufc.mortalcombat, -- GAMMA_CHARACTER: ROOFMINER01
			--text = "Leve eles para o ch^o e est^o perdidos.",
			--tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_roofminer01_00500.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				--composer_stop_show(n_mhub_ufc_talk);
			end,
						
		},
		[10] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return n_rooftop_miners == 1;
			end,

				OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					--n_mhub_ufc_trans = composer_play_show("ci_ufc_convo_02_trans");
				end,
							
			character = AI.sq_hub_ufc.translator, -- GAMMA_CHARACTER: Roofminer02
			--text = "They are heavily armed, but they have no ground game.",
			--tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_roofminer02_00700.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				--composer_stop_show(n_mhub_ufc_trans);
			end,
						
		},
		[11] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return n_rooftop_miners == 1;
			end,

			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				--n_mhub_ufc_talk = composer_play_show("ci_ufc_convo_01_ufc");
			end,
						
			character = AI.sq_hub_ufc.mortalcombat, -- GAMMA_CHARACTER: ROOFMINER01
			--text = "Principalmente os grand^es.",
			--tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_roofminer01_00600.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				--composer_stop_show(n_mhub_ufc_talk);
			end,
						
		},
		[12] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return n_rooftop_miners == 1;
			end,

				OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					--n_mhub_ufc_trans = composer_play_show("ci_ufc_convo_02_trans");
				end,
							
			character = AI.sq_hub_ufc.translator, -- GAMMA_CHARACTER: Roofminer02
			--text = "Throw your guns away and get them in an armbar. Yeah.",
			--tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_roofminer02_00800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				--composer_stop_show(n_mhub_ufc_trans);
			end,
						
		},
		[13] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return n_rooftop_miners == 1;
			end,

			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				--n_mhub_ufc_talk = composer_play_show("ci_ufc_convo_01_ufc");
			end,
						
			character = AI.sq_hub_ufc.mortalcombat, -- GAMMA_CHARACTER: Roofminer01
			--text = "A n^o ser que eles sejam mais fortes do que parecem, os Spartans, com certeza, v^o morrer.",
		--	tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_roofminer01_00700.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				--composer_stop_show(n_mhub_ufc_talk);
			end,
						
		},
		[14] = {
		If = function(thisLine, thisConvo, queue, lineNumber)
				return n_rooftop_miners == 1;
			end,

				OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
					--n_mhub_ufc_trans = composer_play_show("ci_ufc_convo_02_trans");
				end,
							
			character = AI.sq_hub_ufc.translator, -- GAMMA_CHARACTER: Roofminer02
			--text = "You can't lose man!",
			--tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_roofminer02_00900.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				--composer_stop_show(n_mhub_ufc_trans);
			end,
						
		},
	},

	OnFinish = function (thisConvo, queue)
	AIDialogManager.EnableAIDialog();
		hud_hide_radio_transmission_hud();
		if n_rooftop_miners == 0 then
			n_rooftop_miners = 1;
			--CreateThread(f_mhub_ufc_2nd_time);
		elseif n_rooftop_miners == 1 then
			n_rooftop_miners = 2;
		end;
		
	end,

	localVariables = {},
};

---- ============================================================================================================
--  Soccer VO
---- ============================================================================================================


function nar_soccer_listener()
	SleepUntil([| object_valid( "devcon_clue_04" ) ], 60);
	PrintNarrative("LISTENER - nar_soccer_listener THREADED");
	SleepUntil([| device_get_power( OBJECTS.devcon_clue_04) == 1 ], 60);
	PrintNarrative("LISTENER - nar_soccer_listener");
	CreateThread(RegisterInteractEvent, nar_soccer_launcher, OBJECTS.devcon_clue_04);
end

function nar_soccer_launcher(trigger:object, activator:object)
	PrintNarrative("LAUNCHER - nar_soccer_launcher");
	print(activator, " is the activator of ", trigger);
	CreateThread(UnregisterInteractEvent, nar_soccer_launcher , OBJECTS.devcon_clue_04);
	CreateThread(nar_soccer_start, activator)
end


function nar_soccer_start(activator:object)
	sleep_s(1.5);
	if activator == SPARTANS.locke then
		NarrativeQueue.QueueConversation(W1Station_Soccer_ball_machine_locke);
			
		elseif activator == SPARTANS.buck  then
			NarrativeQueue.QueueConversation(W1Station_Soccer_ball_machine_buck);
		elseif activator == SPARTANS.tanaka  then
			NarrativeQueue.QueueConversation(W1Station_Soccer_ball_machine_tanaka);
		elseif activator == SPARTANS.vale  then
			NarrativeQueue.QueueConversation(W1Station_Soccer_ball_machine_vale);
		end
end


global W1Station_Soccer_ball_machine_locke = {
	name = "W1Station_Soccer_ball_machine_locke",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Machine's buttons seems to be in order.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_02500.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		CreateThread(nar_turn_button_vo_back_on);
	end,

	localVariables = {},
};

global W1Station_Soccer_ball_machine_vale = {
	name = "W1Station_Soccer_ball_machine_vale",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Buttons are all working.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_vale_01200.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		CreateThread(nar_turn_button_vo_back_on);
	end,

	localVariables = {},
};

global W1Station_Soccer_ball_machine_tanaka = {
	name = "W1Station_Soccer_ball_machine_tanaka",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
		
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Somebody's done a fine job keeping this operational.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_01500.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		CreateThread(nar_turn_button_vo_back_on);
	end,

	localVariables = {},
};

global W1Station_Soccer_ball_machine_buck = {
	name = "W1Station_Soccer_ball_machine_buck",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
	
		[1] = {
		
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "All I want is a drink. Give me my drink. Where is my drink?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_01100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		CreateThread(nar_turn_button_vo_back_on);
	end,

	localVariables = {},
};

function nar_turn_button_vo_back_on()
sleep_s(5);
CreateThread(nar_soccer_listener);

end

global W1Station_Soccer_ball_appear = {
	name = "W1Station_Soccer_ball_appear",

	CanStart = function (thisConvo, queue)
		return objects_can_see_object( players_human(), OBJECTS.cr_mhub_soccer_ball, 6 ) ; -- GAMMA_CONDITION
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
				return objects_can_see_object( SPARTANS.locke, OBJECTS.cr_mhub_soccer_ball, 6 ); -- GAMMA_TRANSITION: IF LOCKE
			end,

			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Will you look at that...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_02600.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)	
				return 7; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--           If VALE

		[2] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return objects_can_see_object( SPARTANS.vale, OBJECTS.cr_mhub_soccer_ball, 6 ); -- GAMMA_TRANSITION: IF LOCKE
			end,

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VaLE
			text = "Will you look at that...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_vale_01300.sound'),
				AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)	
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--           If TANAKA

		[3] = {
					ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return objects_can_see_object( SPARTANS.tanaka, OBJECTS.cr_mhub_soccer_ball, 6 ); -- GAMMA_TRANSITION: IF LOCKE
			end,

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Will you look at that...",
					tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_01800.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)	
				return 6; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--           If BUCK

		[4] = {
			ElseIf = function (thisLine, thisConvo, queue, lineNumber)
				return objects_can_see_object( SPARTANS.buck, OBJECTS.cr_mhub_soccer_ball, 6 ); -- GAMMA_TRANSITION: IF LOCKE
			end,

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Will you look at that...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_01200.sound'),
						AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)	
				return 7; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[5] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 2,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "Hostile ball on the field!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_vale_01500.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)	
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[6] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 2,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Hell yeah. Space football.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_01600.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)	
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[7] = {

								OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,		sleepBefore = 2,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "I used to play a fair bit of football in my day. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_01300.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)	
				return 8; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[8] = {
							OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Bring it on, old man. Let's see who can score first.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_02700.sound'),
						AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)	
				return 0; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
	},

	OnFinish = function (thisConvo, queue)
		
	end,

	localVariables = {},
};


global W1Station_Soccer_ball_goal = {
	name = "W1Station_Soccer_ball_goal",

	CanStart = function (thisConvo, queue)
		return volume_test_object(VOLUMES.tv_mhub_sball_goal_1, OBJECTS.cr_mhub_soccer_ball) or volume_test_object(VOLUMES.tv_mhub_sball_goal_2, OBJECTS.cr_mhub_soccer_ball); -- GAMMA_CONDITION
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
				return objects_distance_to_object(SPARTANS.buck,OBJECTS.cr_mhub_soccer_ball) < 6 ;
			end,
										OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "Goal! Goal goal goal goooooal!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_01400.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)	
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},		
		[2] = {
								If = function(thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object(SPARTANS.tanaka,OBJECTS.cr_mhub_soccer_ball) < 6 ;
			end,
										OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "And the crowd goes wild.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_01700.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)	
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
		[3] = {
						If = function(thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object(SPARTANS.locke,OBJECTS.cr_mhub_soccer_ball) < 8 ;
			end,
										OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: Locke
			text = "Goal! That's a GOAL, Osiris!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_02800.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)	
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
--           If VALE

		[4] = {
							If = function(thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object(SPARTANS.vale,OBJECTS.cr_mhub_soccer_ball) < 6 ;
			end,
										OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "And that's a goal for Spartan! Olympia! Vaaale!",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_vale_01600.sound'),
			AfterPlayed = function (thisLine, thisConvo, queue, lineNumber)	
				return 5; -- GAMMA_NEXT_LINE_NUMBER
			end,
		},
				[5] = {
											OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
				sleepBefore = 3,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LoCKE
			text = "Alright, Osiris. Play time's over. Let's get on with it.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_02900.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		--[[]]
	end,

	localVariables = {},
};

---- ============================================================================================================
--  Interactive Conversations
---- ============================================================================================================
--function w1_frontgate_button_handler()
--	sleep_s(2);
--	device_set_power (OBJECTS.nar_front_gate_talk, 1);
---	device_set_position_immediate ( OBJECTS.nar_front_gate_talk, 0 );
--Sleep(1);
	--CreateThread(nar_frontgate_listener);
--end

function nar_frontgate_listener()
	SleepUntil([| object_valid( "nar_front_gate_talk" ) ], 60);
	PrintNarrative("LISTENER - nar_frontgate_listener THREADED");
	SleepUntil([| device_get_power( OBJECTS.nar_front_gate_talk) == 1 ], 60);	
	PrintNarrative("LISTENER - nar_frontgate_listener");
	CreateThread(RegisterInteractEvent, nar_frontgate_launcher, OBJECTS.nar_front_gate_talk);
end

function nar_frontgate_launcher(trigger:object, activator:object)
	PrintNarrative("LAUNCHER - nar_frontgate_launcher");
	print(activator, " is the activator of ", trigger);
	CreateThread(UnregisterInteractEvent, nar_frontgate_launcher, OBJECTS.nar_front_gate_talk);
	CreateThread(nar_frontgate_start, activator)
end

function nar_frontgate_start(activator:object)
device_set_power (OBJECTS.nar_front_gate_talk, 0);
CreateThread(nar_turn_off_all_interacts);
sleep_s(0.5);
	if activator == SPARTANS.locke then
		NarrativeQueue.QueueConversation(W1Station_main_gate_locke);
			
		elseif activator == SPARTANS.buck  then
			NarrativeQueue.QueueConversation(W1Station_main_gate_buck);
		elseif activator == SPARTANS.tanaka  then
			NarrativeQueue.QueueConversation(W1Station_main_gate_tanaka);
		elseif activator == SPARTANS.vale  then
			NarrativeQueue.QueueConversation(W1Station_main_gate_vale);
		end
end

global W1Station_main_gate_locke = {
	name = "W1Station_main_gate_locke",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "We're here to help.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_03900.sound'),
		},

		[2] = {
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				cs_look_player(AI.sq_inner_gate.sp_innergate_02, true);
			end,

		sleepBefore = 0.5,
			character = AI.sq_inner_gate.sp_innergate_02, -- GAMMA_CHARACTER: Minermale06
			text = "Too late to be any help. Attack's over, Spartans. Keep those weapons down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale06_00100.sound'),

			
		},
--           IF LOCKE

		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object(SPARTANS.locke,  ai_get_object(AI.sq_inner_gate.sp_innergate_02)) < 5 ;
			end,
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Of course.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_04000.sound'),
		},
		[4] = {
						If = function(thisLine, thisConvo, queue, lineNumber)
				return 	objects_distance_to_object(players_human(),ai_get_object(AI.sq_inner_gate.sp_innergate_02)) < 5 ;
			end,
		sleepBefore = 0.5,
			character = AI.sq_inner_gate.sp_innergate_02, -- GAMMA_CHARACTER: MINERMALE06
			text = "Oh, and welcome to Meridian Station.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale06_00200.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				cs_look_player(AI.sq_inner_gate.sp_innergate_02, false);
			end,
						
		},
	},

	OnFinish = function (thisConvo, queue)
	CreateThread(nar_turn_on_all_interacts);
	end,

	localVariables = {},
};

global W1Station_main_gate_vale = {
	name = "W1Station_main_gate_vale",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
	[1] = {
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "We're here to help.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_vale_02300.sound'),
		},

		[2] = {
		
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				cs_look_player(AI.sq_inner_gate.sp_innergate_02, true);
			end,
					
			sleepBefore = 0.5,
			character = AI.sq_inner_gate.sp_innergate_02, -- GAMMA_CHARACTER: Minermale06
			text = "Too late to be any help. Attack's over, Spartans. Keep those weapons down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale06_00100.sound'),
		},

		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object(SPARTANS.vale,  ai_get_object(AI.sq_inner_gate.sp_innergate_02)) < 5 ;
			end,
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Of course.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_vale_02400.sound'),
		},
		[4] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return 	objects_distance_to_object(players_human(),ai_get_object(AI.sq_inner_gate.sp_innergate_02)) < 5 ;
			end,
		sleepBefore = 0.5,
			character = AI.sq_inner_gate.sp_innergate_02, -- GAMMA_CHARACTER: MINERMALE06
			text = "Oh, and welcome to Meridian Station.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale06_00200.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				cs_look_player(AI.sq_inner_gate.sp_innergate_02, false);
			end,
			
		},
	},

	OnFinish = function (thisConvo, queue)
		CreateThread(nar_turn_on_all_interacts);
	end,

	localVariables = {},
};


global W1Station_main_gate_buck = {
	name = "W1Station_main_gate_buck",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "We're here to help.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_02100.sound'),
		},
		[2] = {
		
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				cs_look_player(AI.sq_inner_gate.sp_innergate_02, true);
			end,		

			sleepBefore = 0.5,
			character = AI.sq_inner_gate.sp_innergate_02, -- GAMMA_CHARACTER: Minermale06
			text = "Too late to be any help. Attack's over, Spartans. Keep those weapons down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale06_00100.sound'),
		},

		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object(SPARTANS.buck,  ai_get_object(AI.sq_inner_gate.sp_innergate_02)) < 5 ;
			end,
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Of course.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_02200.sound'),
		},

		[4] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return 	objects_distance_to_object(players_human(),ai_get_object(AI.sq_inner_gate.sp_innergate_02)) < 5 ;
			end,
		sleepBefore = 0.5,
			character = AI.sq_inner_gate.sp_innergate_02, -- GAMMA_CHARACTER: MINERMALE06
			text = "Oh, and welcome to Meridian Station.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale06_00200.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				cs_look_player(AI.sq_inner_gate.sp_innergate_02, false);
			end,
						
		},
	},

	OnFinish = function (thisConvo, queue)
		CreateThread(nar_turn_on_all_interacts);
	end,

	localVariables = {},
};


global W1Station_main_gate_tanaka = {
	name = "W1Station_main_gate_tanaka",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
	
		[1] = {
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "We're here to help.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_02700.sound'),
		},
		[2] = {
		
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				cs_look_player(AI.sq_inner_gate.sp_innergate_02, true);
			end,		
					
			sleepBefore = 0.5,
			character = AI.sq_inner_gate.sp_innergate_02, -- GAMMA_CHARACTER: Minermale06
			text = "Too late to be any help. Attack's over, Spartans. Keep those weapons down.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale06_00100.sound'),
		},


		[3] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object(SPARTANS.tanaka,  ai_get_object(AI.sq_inner_gate.sp_innergate_02)) < 5 ;
			end,
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Of course.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_02800.sound'),
		},
		[4] = {
					If = function(thisLine, thisConvo, queue, lineNumber)
				return 	objects_distance_to_object(players_human(),ai_get_object(AI.sq_inner_gate.sp_innergate_02)) < 5 ;
			end,
		sleepBefore = 0.5,
			character = AI.sq_inner_gate.sp_innergate_02, -- GAMMA_CHARACTER: MINERMALE06
			text = "Oh, and welcome to Meridian Station.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale06_00200.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				cs_look_player(AI.sq_inner_gate.sp_innergate_02, false);
			end,
						
		},
	},

	OnFinish = function (thisConvo, queue)
			CreateThread(nar_turn_on_all_interacts);
	end,

	localVariables = {},
};

--function w1_frontgate_button2_handler()
--	sleep_s(2);
--	device_set_power (OBJECTS.nar_front_gate_talk2, 1);
--	device_set_position_immediate ( OBJECTS.nar_front_gate_talk2, 0 );
--	Sleep(1);
	--CreateThread(nar_front_gate_talk2_listener);
--end

function nar_front_gate_talk2_listener()
	SleepUntil([| object_valid( "nar_front_gate_talk2" ) ], 60);
	PrintNarrative("LISTENER - nar_front_gate_talk2_listener THREADED");
	SleepUntil([| device_get_power( OBJECTS.nar_front_gate_talk2) == 1 ], 60);
	PrintNarrative("LISTENER - nar_front_gate_talk2_listener");
	CreateThread(RegisterInteractEvent, nar_front_gate_talk2_launcher, OBJECTS.nar_front_gate_talk2);
end

function nar_front_gate_talk2_launcher(trigger:object, activator:object)
	PrintNarrative("LAUNCHER - nar_front_gate_talk2_launcher");
	print(activator, " is the activator of ", trigger);
	CreateThread(UnregisterInteractEvent, nar_front_gate_talk2_launcher, OBJECTS.nar_front_gate_talk2);
	CreateThread(nar_front_gate_talk2_start, activator)
end

function nar_front_gate_talk2_start(activator:object)
--device_set_power (OBJECTS.nar_front_gate_talk2, 0);
CreateThread(nar_turn_off_all_interacts);
sleep_s(0.5);
	if activator == SPARTANS.locke then
		if b_locke_talk2_line_playing == false then
			b_locke_talk2_line_playing = true;
			NarrativeQueue.QueueConversation(W1Station_front_gate_talk2_locke);
		end
			
		elseif activator == SPARTANS.buck  then
			NarrativeQueue.QueueConversation(W1Station_front_gate_talk2_buck);
		elseif activator == SPARTANS.tanaka  then
			NarrativeQueue.QueueConversation(W1Station_front_gate_talk2_tanaka);
		elseif activator == SPARTANS.vale  then
			NarrativeQueue.QueueConversation(W1Station_front_gate_talk2_vale);
		else
		CreateThread(nar_turn_on_all_interacts);
			CreateThread(nar_front_gate_talk2_listener);
		end
end

global W1Station_front_gate_talk2_buck = {
	name = "W1Station_front_gate_talk2_buck",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "I'm sorry we couldn't do more to help. There's a fair bit of damage...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_01800.sound'),
			playDurationAdjustment = 0.8,
		},

		[2] = {
		
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				cs_look_player(AI.sq_inner_gate.sp_innergate_01, true);
			end,		
		
			character = AI.sq_inner_gate.sp_innergate_01, -- GAMMA_CHARACTER: MINERFEMALE02
			text = "Nothing we can do about it now.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale02_02400.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				cs_look_player(AI.sq_inner_gate.sp_innergate_01, false);
			end,			
		},
	},

	OnFinish = function (thisConvo, queue)
	--	CreateThread(w1_frontgate_button2_handler);
			
			CreateThread(nar_turn_on_all_interacts);
			CreateThread(nar_front_gate_talk2_listener);
	end,

	localVariables = {},
};

global W1Station_front_gate_talk2_locke = {
	name = "W1Station_front_gate_talk2_locke",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
	
		[1] = {
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "I'm sorry we couldn't do more to help. There's a fair bit of damage...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_03500.sound'),
			playDurationAdjustment = 0.8,
		},

		[2] = {
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				cs_look_player(AI.sq_inner_gate.sp_innergate_01, true);
			end,			
		
			character = AI.sq_inner_gate.sp_innergate_01, -- GAMMA_CHARACTER: MINERFEMALE02
			text = "Nothing we can do about it now.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale02_02400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				cs_look_player(AI.sq_inner_gate.sp_innergate_01, false);
			end,				
		},
	},

	OnFinish = function (thisConvo, queue)
		--CreateThread(w1_frontgate_button2_handler);
		b_locke_talk2_line_playing = false;
		CreateThread(nar_turn_on_all_interacts);
			CreateThread(nar_front_gate_talk2_listener);
	end,

	localVariables = {},
};

global W1Station_front_gate_talk2_tanaka = {
	name = "W1Station_front_gate_talk2_tanaka",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Sorry couldn't do more to help. There's a fair bit of damage...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_02300.sound'),
			playDurationAdjustment = 0.8,
		},
		[2] = {
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				cs_look_player(AI.sq_inner_gate.sp_innergate_01, true);
			end,			
		
			character = AI.sq_inner_gate.sp_innergate_01, -- GAMMA_CHARACTER: MINERFEMALE02
			text = "Nothing we can do about it now.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale02_02400.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				cs_look_player(AI.sq_inner_gate.sp_innergate_01, false);
			end,				
		},
	},

	OnFinish = function (thisConvo, queue)
	--	CreateThread(w1_frontgate_button2_handler);
	
		CreateThread(nar_turn_on_all_interacts);
			CreateThread(nar_front_gate_talk2_listener);
	end,

	localVariables = {},
};

global W1Station_front_gate_talk2_vale = {
	name = "W1Station_front_gate_talk2_vale",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
	
	
		[1] = {
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "I'm sorry we couldn't do more to help. There's a fair bit of damage...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_vale_02000.sound'),
			playDurationAdjustment = 0.8,
		},

		[2] = {
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				cs_look_player(AI.sq_inner_gate.sp_innergate_01, true);
			end,			

			character = AI.sq_inner_gate.sp_innergate_01, -- GAMMA_CHARACTER: MINERFEMALE02
			text = "Nothing we can do about it now.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale02_02400.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				cs_look_player(AI.sq_inner_gate.sp_innergate_01, false);
			end,				
		},
	},

	OnFinish = function (thisConvo, queue)
		--CreateThread(w1_frontgate_button2_handler);
		
		CreateThread(nar_turn_on_all_interacts);
			CreateThread(nar_front_gate_talk2_listener);
	end,

	localVariables = {},
};

--function w1_leftgate_button_handler()
---	sleep_s(2);
--	device_set_power (OBJECTS.nar_leftguard_talk, 1);
---	device_set_position_immediate ( OBJECTS.nar_leftguard_talk, 0 );
--	Sleep(1);
	--CreateThread(nar_leftgate_listener);
--end

function nar_leftgate_listener()
	SleepUntil([| object_valid( "nar_leftguard_talk" ) ], 60);
	PrintNarrative("LISTENER - nar_leftgate_listener THREADED");
	SleepUntil([| device_get_power( OBJECTS.nar_leftguard_talk) == 1 ], 60);
	PrintNarrative("LISTENER - nar_leftgate_listener");
	CreateThread(RegisterInteractEvent, nar_leftgate_launcher, OBJECTS.nar_leftguard_talk);
end

function nar_leftgate_launcher(trigger:object, activator:object)
	PrintNarrative("LAUNCHER - nar_leftgate_launcher");
	print(activator, " is the activator of ", trigger);
	CreateThread(UnregisterInteractEvent, nar_leftgate_launcher, OBJECTS.nar_leftguard_talk);
	CreateThread(nar_leftguard_start, activator)
end

function nar_leftguard_start(activator:object)
--	device_set_power (OBJECTS.nar_leftguard_talk, 0);
	CreateThread(nar_turn_off_all_interacts);
	ObjectSetSpartanTrackingEnabled(ai_get_object(AI.sq_left_gate.left_civ_01), false);
	sleep_s(0.5);
	if activator == SPARTANS.locke then
		NarrativeQueue.QueueConversation(W1Station_gate_concern_locke);
		elseif activator == SPARTANS.buck  then
			NarrativeQueue.QueueConversation(W1Station_gate_concern_buck);
		elseif activator == SPARTANS.tanaka  then
			NarrativeQueue.QueueConversation(W1Station_gate_concern_tanaka);
		elseif activator == SPARTANS.vale  then
			NarrativeQueue.QueueConversation(W1Station_gate_concern_vale);
		end
end

global W1Station_gate_concern_buck = {
	name = "W1Station_gate_concern_buck",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
	
		[1] = {
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "How is everything?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_01600.sound'),
		},

		[2] = {

			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				cs_look_player(AI.sq_left_gate.left_guard_01, true);
			end,			
						
			sleepBefore = 0.5,
			character = AI.sq_left_gate.left_guard_01, -- GAMMA_CHARACTER: Minerfemale05
			text = "District's on lockdown. Governor Sloan's orders.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale05_01000.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				cs_look_player(AI.sq_left_gate.left_guard_01, false);
			end,	
			
		},
	},

	OnFinish = function (thisConvo, queue)
	--	CreateThread(w1_leftgate_button_handler);
	CreateThread(nar_turn_on_all_interacts);
			CreateThread(nar_leftgate_listener);
	end,

	localVariables = {},
};


global W1Station_gate_concern_locke = {
	name = "W1Station_gate_concern_locke",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
		
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "How is everything?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_03300.sound'),
		},
		[2] = {
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				cs_look_player(AI.sq_left_gate.left_guard_01, true);
			end,			
						
			sleepBefore = 0.5,
			character = AI.sq_left_gate.left_guard_01, -- GAMMA_CHARACTER: Minerfemale05
			text = "District's on lockdown. Governor Sloan's orders.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale05_01000.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				cs_look_player(AI.sq_left_gate.left_guard_01, false);
			end,	
		},
	},

	OnFinish = function (thisConvo, queue)
	--	CreateThread(w1_leftgate_button_handler);
	CreateThread(nar_turn_on_all_interacts);
			CreateThread(nar_leftgate_listener);
	end,

	localVariables = {},
};


global W1Station_gate_concern_vale = {
	name = "W1Station_gate_concern_vale",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
	
		[1] = {
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "How is everything?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_vale_01800.sound'),
		},

		[2] = {
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				cs_look_player(AI.sq_left_gate.left_guard_01, true);
			end,			
						
			sleepBefore = 0.5,
			character = AI.sq_left_gate.left_guard_01, -- GAMMA_CHARACTER: Minerfemale05
			text = "District's on lockdown. Governor Sloan's orders.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale05_01000.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				cs_look_player(AI.sq_left_gate.left_guard_01, false);
			end,	
		},
	},

	OnFinish = function (thisConvo, queue)
		--CreateThread(w1_leftgate_button_handler);
		CreateThread(nar_turn_on_all_interacts);
			CreateThread(nar_leftgate_listener);
	end,

	localVariables = {},
};

global W1Station_gate_concern_tanaka = {
	name = "W1Station_gate_concern_tanaka",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
	
		[1] = {
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "How is everything?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_02100.sound'),
		},
		
		[2] = {
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				cs_look_player(AI.sq_left_gate.left_guard_01, true);
			end,			
						
			sleepBefore = 0.5,
			character = AI.sq_left_gate.left_guard_01, -- GAMMA_CHARACTER: Minerfemale05
			text = "District's on lockdown. Governor Sloan's orders.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale05_01000.sound'),
			
			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				cs_look_player(AI.sq_left_gate.left_guard_01, false);
			end,	
		},
	},

	OnFinish = function (thisConvo, queue)
		--CreateThread(w1_leftgate_button_handler);
		CreateThread(nar_turn_on_all_interacts);
			CreateThread(nar_leftgate_listener);
	end,

	localVariables = {},
};


function nar_fence_listener()

	SleepUntil([| object_valid( "nar_fence_talk" ) ], 60);
	PrintNarrative("LISTENER - nar_fence_listener THREADED");
	SleepUntil([| device_get_power( OBJECTS.nar_fence_talk) == 1 ], 60);
	PrintNarrative("LISTENER - nar_fence_listener");
	CreateThread(RegisterInteractEvent, nar_fence_launcher, OBJECTS.nar_fence_talk);
end

function nar_fence_launcher(trigger:object, activator:object)
	PrintNarrative("LAUNCHER - nar_fence_launcher");
	print(activator, " is the activator of ", trigger);
	CreateThread(UnregisterInteractEvent, nar_fence_launcher, OBJECTS.nar_fence_talk);
	CreateThread(nar_fence_start, activator)
end

--function w1_fence_button_handler()
--	sleep_s(2);
--	device_set_power (OBJECTS.nar_fence_talk, 1);
--	device_set_position_immediate ( OBJECTS.nar_fence_talk, 0 );
--	Sleep(1);
	--CreateThread(nar_fence_listener);
--end

function nar_fence_start(activator:object)
	--device_set_power (OBJECTS.nar_fence_talk, 0);
	CreateThread(nar_turn_off_all_interacts);
	--ObjectSetSpartanTrackingEnabled(ai_get_object(AI.sq_right_gate.sp_right_miner_01), false);
	sleep_s(0.5);
	if activator == SPARTANS.locke then
		NarrativeQueue.QueueConversation(W1Station_gawkervo_locke);
			
		elseif activator == SPARTANS.buck  then
			NarrativeQueue.QueueConversation(W1Station_gawkervo_buck);
		elseif activator == SPARTANS.tanaka  then
			NarrativeQueue.QueueConversation(W1Station_gawkervo_tanaka);
		elseif activator == SPARTANS.vale  then
			NarrativeQueue.QueueConversation(W1Station_gawkervo_vale);
		end
end

global W1Station_gawkervo_tanaka = {
	name = "W1Station_gawkervo_tanaka",
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "You okay?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_02200.sound'),
		},
		[2] = {

			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				cs_look_player(AI.sq_right_gate.sp_right_miner_01, true);
			end,			

			character = AI.sq_right_gate.sp_right_miner_01, -- GAMMA_CHARACTER: Minermale03 (guard)
			text = "Everything's under control.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_03300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				cs_look_player(AI.sq_right_gate.sp_right_miner_01, false);
			end,				
		},
	},

	OnFinish = function (thisConvo, queue)
		--CreateThread(w1_fence_button_handler);

		CreateThread(nar_turn_on_all_interacts);
		CreateThread(nar_fence_listener);
	end,

	localVariables = {},
};

global W1Station_gawkervo_locke = {
	name = "W1Station_gawkervo_locke",



	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "You okay?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_03400.sound'),
		},

		[2] = {
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				cs_look_player(AI.sq_right_gate.sp_right_miner_01, true);
			end,			

			character = AI.sq_right_gate.sp_right_miner_01, -- GAMMA_CHARACTER: Minermale03 (guard)
			text = "Everything's under control.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_03300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				cs_look_player(AI.sq_right_gate.sp_right_miner_01, false);
			end,	
		},
	},

	OnFinish = function (thisConvo, queue)
		--CreateThread(w1_fence_button_handler);

		CreateThread(nar_turn_on_all_interacts);
		CreateThread(nar_fence_listener);
	end,

	localVariables = {},
};

global W1Station_gawkervo_vale = {
	name = "W1Station_gawkervo_vale",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "You okay?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_vale_01900.sound'),
		},

		[2] = {
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				cs_look_player(AI.sq_right_gate.sp_right_miner_01, true);
			end,			

			character = AI.sq_right_gate.sp_right_miner_01, -- GAMMA_CHARACTER: Minermale03 (guard)
			text = "Everything's under control.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_03300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				cs_look_player(AI.sq_right_gate.sp_right_miner_01, false);
			end,	
		},
	},

	OnFinish = function (thisConvo, queue)
		--CreateThread(w1_fence_button_handler);
		
		CreateThread(nar_turn_on_all_interacts);
		CreateThread(nar_fence_listener);
	end,

	localVariables = {},
};

global W1Station_gawkervo_buck = {
	name = "W1Station_gawkervo_buck",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		
		[1] = {
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "You okay?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_01700.sound'),
		},

		[2] = {
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				cs_look_player(AI.sq_right_gate.sp_right_miner_01, true);
			end,			

			character = AI.sq_right_gate.sp_right_miner_01, -- GAMMA_CHARACTER: Minermale03 (guard)
			text = "Everything's under control.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_03300.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				cs_look_player(AI.sq_right_gate.sp_right_miner_01, false);
			end,	
		},
	},

	OnFinish = function (thisConvo, queue)
		--CreateThread(w1_fence_button_handler);		
CreateThread(nar_turn_on_all_interacts);
		CreateThread(nar_fence_listener);
	end,

	localVariables = {},
};
--function w1_fence2_button_handler()
--	sleep_s(2);
--	device_set_power (OBJECTS.nar_fence_talk2, 1);
--	device_set_position_immediate ( OBJECTS.nar_fence_talk2, 0 );
--	Sleep(1);
	--CreateThread(nar_fence2_listener);
--end

function nar_fence2_listener()
	SleepUntil([| object_valid( "nar_fence_talk2" ) ], 60);
	PrintNarrative("LISTENER - nar_fence2_listener THREADED");
	SleepUntil([| device_get_power( OBJECTS.nar_fence_talk2) == 1 ], 60);
	PrintNarrative("LISTENER - nar_fence2_listener");
	CreateThread(RegisterInteractEvent, nar_fence2_launcher, OBJECTS.nar_fence_talk2);
end

function nar_fence2_launcher(trigger:object, activator:object)
	PrintNarrative("LAUNCHER - nar_fence2_launcher");
	print(activator, " is the activator of ", trigger);
	CreateThread(UnregisterInteractEvent, nar_fence2_launcher, OBJECTS.nar_fence_talk2);
	CreateThread(nar_fence2_start, activator)
end

function nar_fence2_start(activator:object)
	device_set_power (OBJECTS.nar_fence_talk2, 0);
	CreateThread(nar_turn_off_all_interacts);
	--ObjectSetSpartanTrackingEnabled(ai_get_object(AI.sq_right_gate.sp_right_miner_04), false);
	sleep_s(0.5);
	if activator == SPARTANS.locke then
		NarrativeQueue.QueueConversation(W1Station_fence2_locke);
			
		elseif activator == SPARTANS.buck  then
			NarrativeQueue.QueueConversation(W1Station_fence2_buck);
		elseif activator == SPARTANS.tanaka  then
			NarrativeQueue.QueueConversation(W1Station_fence2_tanaka);
		elseif activator == SPARTANS.vale  then
			NarrativeQueue.QueueConversation(W1Station_fence2_vale);
		end
end

global W1Station_fence2_locke = {
	name = "W1Station_fence2_locke",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Hello.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_03600.sound'),
		},
		[2] = {
		
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				cs_look_player(AI.sq_right_gate.sp_right_miner_04, true);
			end,			
			
		sleepBefore = 0.5,
			character = AI.sq_right_gate.sp_right_miner_04, -- GAMMA_CHARACTER: Minermale04
			text = "Hey, UNSC! Heard you helped some of our boys on the way in. Thank you.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale04_00800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				cs_look_player(AI.sq_right_gate.sp_right_miner_04, false);
			end,				
		},

	[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object(SPARTANS.locke,  ai_get_object(AI.sq_right_gate.sp_right_miner_04)) < 5 ;
			end,
	
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "You're welcome.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_03700.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		NarrativeQueue.QueueConversation(W1Station_fence2_post);
	
	end,

	localVariables = {},
};

global W1Station_fence2_vale = {
	name = "W1Station_fence2_vale",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Hello.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_vale_02100.sound'),
		},

		[2] = {
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				cs_look_player(AI.sq_right_gate.sp_right_miner_04, true);
			end,			
			
		sleepBefore = 0.5,
			character = AI.sq_right_gate.sp_right_miner_04, -- GAMMA_CHARACTER: Minermale04
			text = "Hey, UNSC! Heard you helped some of our boys on the way in. Thank you.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale04_00800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				cs_look_player(AI.sq_right_gate.sp_right_miner_04, false);
			end,		
		},

		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object(SPARTANS.vale,  ai_get_object(AI.sq_right_gate.sp_right_miner_04)) < 5 ;
			end,
	
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "You're welcome.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_vale_02200.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		NarrativeQueue.QueueConversation(W1Station_fence2_post);
	
	end,

	localVariables = {},
};

global W1Station_fence2_buck = {
	name = "W1Station_fence2_buck",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Hello.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_01900.sound'),
		},

		[2] = {
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				cs_look_player(AI.sq_right_gate.sp_right_miner_04, true);
			end,			
			
		sleepBefore = 0.5,
			character = AI.sq_right_gate.sp_right_miner_04, -- GAMMA_CHARACTER: Minermale04
			text = "Hey, UNSC! Heard you helped some of our boys on the way in. Thank you.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale04_00800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				cs_look_player(AI.sq_right_gate.sp_right_miner_04, false);
			end,		
		},

		[3] = {
				If = function(thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object(SPARTANS.buck,  ai_get_object(AI.sq_right_gate.sp_right_miner_04)) < 5 ;
			end,
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "You're welcome.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_02000.sound'),
		},

	},

	OnFinish = function (thisConvo, queue)
		NarrativeQueue.QueueConversation(W1Station_fence2_post);
	
	end,

	localVariables = {},
};

global W1Station_fence2_tanaka = {
	name = "W1Station_fence2_tanaka",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
	[1] = {
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Hello.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_02400.sound'),
		},
		[2] = {
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				cs_look_player(AI.sq_right_gate.sp_right_miner_04, true);
			end,			
			
		sleepBefore = 0.5,
			character = AI.sq_right_gate.sp_right_miner_04, -- GAMMA_CHARACTER: Minermale04
			text = "Hey, UNSC! Heard you helped some of our boys on the way in. Thank you.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale04_00800.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				cs_look_player(AI.sq_right_gate.sp_right_miner_04, false);
			end,		
		},
 
		[3] = {
			If = function(thisLine, thisConvo, queue, lineNumber)
				return objects_distance_to_object(SPARTANS.tanaka,  ai_get_object(AI.sq_right_gate.sp_right_miner_04)) < 5 ;
			end,
		sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "You're welcome.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_02500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		NarrativeQueue.QueueConversation(W1Station_fence2_post);
		
	end,

	localVariables = {},
};


global W1Station_fence2_post = {
	name = "W1Station_fence2_post",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.NPC; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
		sleepBefore = 1,
			character =  AI.sq_right_gate.sp_right_miner_05, -- GAMMA_CHARACTER: Minermale02 (GUARD)
			text = "Yeah, see how thankful you are when they have us payin' taxes to 'em.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale02_01400.sound'),
		},
		[2] = {
		sleepBefore = 0.5,
			character =  AI.sq_right_gate.sp_right_miner_04, -- GAMMA_CHARACTER: Minermale04
			text = "Hey now. Sloan said to treat 'em nice.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale04_00900.sound'),
		},
		[3] = {
		sleepBefore = 0.5,
			character =  AI.sq_right_gate.sp_right_miner_05, -- GAMMA_CHARACTER: MINERMALE02 (guard)
			text = "You pat 'em on the back, and the next thing you feel's a hand in your pocket.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale02_01500.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	--	CreateThread(w1_fence2_button_handler);
	CreateThread(nar_turn_on_all_interacts);
		
	end,

	localVariables = {},
};

--function w1_welder2_button_handler()
--	sleep_s(2);
--	device_set_power (OBJECTS.nar_welder2_talk, 1);
--	device_set_position_immediate ( OBJECTS.nar_welder2_talk, 0 );
--	Sleep(1);
	--CreateThread(nar_welder2_listener);
--end

function nar_welder2_listener()
	SleepUntil([| object_valid( "nar_welder2_talk" ) ], 60);
	PrintNarrative("LISTENER - nar_welder2_listener THREADED");
	SleepUntil([| device_get_power( OBJECTS.nar_welder2_talk) == 1 ], 60);	
	PrintNarrative("LISTENER - nar_welder2_listener");
	CreateThread(RegisterInteractEvent, nar_welder2_launcher, OBJECTS.nar_welder2_talk);
end

function nar_welder2_launcher(trigger:object, activator:object)
	PrintNarrative("LAUNCHER - nar_welder2_launcher");
	print(activator, " is the activator of ", trigger);
	CreateThread(UnregisterInteractEvent, nar_welder2_launcher, OBJECTS.nar_welder2_talk);
	CreateThread(nar_welder2_start, activator)
end

function nar_welder2_start(activator:object)
	--device_set_power (OBJECTS.nar_welder2_talk, 0);
	CreateThread(nar_turn_off_all_interacts);
	ObjectSetSpartanTrackingEnabled(ai_get_object(AI.sq_mhub_patrol_welder.welder_02), false);
	sleep_s(0.5);
	if activator == SPARTANS.locke then
		NarrativeQueue.QueueConversation(W1Station_welder2_locke);
			
		elseif activator == SPARTANS.buck  then
			NarrativeQueue.QueueConversation(W1Station_welder2_buck);
		elseif activator == SPARTANS.tanaka  then
			NarrativeQueue.QueueConversation(W1Station_welder2_tanaka);
		elseif activator == SPARTANS.vale  then
			NarrativeQueue.QueueConversation(W1Station_welder2_vale);
		end
end

global W1Station_welder2_locke = {
	name = "W1Station_welder2_locke",



	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Everything good here?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_04100.sound'),
		},
		[2] = {
		sleepBefore = 0.5,
			character = AI.sq_mhub_patrol_welder.welder_02, -- GAMMA_CHARACTER: Minermale03
			text = "Too much to do, too little time to do it in.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_05000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		--CreateThread(w1_welder2_button_handler);
		CreateThread(nar_turn_on_all_interacts);
		CreateThread(nar_welder2_listener);
	end,

	localVariables = {},
};

global W1Station_welder2_vale = {
	name = "W1Station_welder2_vale",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Everything good here?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_vale_02500.sound'),
		},

		[2] = {
		sleepBefore = 0.5,
			character = AI.sq_mhub_patrol_welder.welder_02, -- GAMMA_CHARACTER: Minermale03
			text = "Too much to do, too little time to do it in.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_05000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		--CreateThread(w1_welder2_button_handler);
		CreateThread(nar_turn_on_all_interacts);
		CreateThread(nar_welder2_listener);
	end,

	localVariables = {},
};

global W1Station_welder2_buck = {
	name = "W1Station_welder2_buck",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
	
		[1] = {
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Everything good here?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_02300.sound'),
		},

		[2] = {
		sleepBefore = 0.5,
			character = AI.sq_mhub_patrol_welder.welder_02, -- GAMMA_CHARACTER: Minermale03
			text = "Too much to do, too little time to do it in.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_05000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		--CreateThread(w1_welder2_button_handler);
		CreateThread(nar_turn_on_all_interacts);
		CreateThread(nar_welder2_listener);
	end,

	localVariables = {},
};

global W1Station_welder2_tanaka = {
	name = "W1Station_welder2_tanaka",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
	
		[1] = {
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Everything good here?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_02900.sound'),
		},
		[2] = {
		sleepBefore = 0.5,
			character = AI.sq_mhub_patrol_welder.welder_02, -- GAMMA_CHARACTER: Minermale03
			text = "Too much to do, too little time to do it in.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_05000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		--CreateThread(w1_welder2_button_handler);
		CreateThread(nar_turn_on_all_interacts);
		CreateThread(nar_welder2_listener);
	end,

	localVariables = {},
};

--function w1_welder_button_handler()
--	sleep_s(2);
--	device_set_power (OBJECTS.nar_welder_talk, 1);
--	device_set_position_immediate ( OBJECTS.nar_welder_talk, 0 );
--	Sleep(1);
	--CreateThread(nar_welder_listener);
--end

function nar_welder_listener()
	SleepUntil([| object_valid( "nar_welder_talk" ) ], 60);
	PrintNarrative("LISTENER - nar_welder_listener THREADED");
	SleepUntil([| device_get_power( OBJECTS.nar_welder_talk) == 1 ], 60);
	PrintNarrative("LISTENER - nar_welder_listener");
	CreateThread(RegisterInteractEvent, nar_welder_launcher, OBJECTS.nar_welder_talk);
end

function nar_welder_launcher(trigger:object, activator:object)
	PrintNarrative("LAUNCHER - nar_welder_launcher");
	print(activator, " is the activator of ", trigger);
	CreateThread(UnregisterInteractEvent, nar_welder_launcher, OBJECTS.nar_welder_talk);	
	CreateThread(nar_welder_start, activator)
end

function nar_welder_start(activator:object)
	--device_set_power (OBJECTS.nar_welder_talk, 0);
	CreateThread(nar_turn_off_all_interacts);
	ObjectSetSpartanTrackingEnabled(ai_get_object(AI.sq_mhub_patrol_welder.welder_01), false);
	sleep_s(0.5);
	if activator == SPARTANS.locke then
		NarrativeQueue.QueueConversation(W1Station_Welding_miners_locke);
		elseif activator == SPARTANS.buck  then
			NarrativeQueue.QueueConversation(W1Station_Welding_miners_buck);
		elseif activator == SPARTANS.tanaka  then
			NarrativeQueue.QueueConversation(W1Station_Welding_miners_tanaka);
		elseif activator == SPARTANS.vale  then
			NarrativeQueue.QueueConversation(W1Station_Welding_miners_vale);
		end
end

global W1Station_Welding_miners_locke = {
	name = "W1Station_Welding_miners_locke",
	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
		
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "How's it looking?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_04400.sound'),
		},

		[2] = {
		sleepBefore = 0.5,
			character = AI.sq_mhub_patrol_welder.welder_01, -- GAMMA_CHARACTER: Minermale03
			text = "It's not so bad. Nothing we can't patch up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_04300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		--CreateThread(w1_welder_button_handler);
		CreateThread(nar_welder_listener);
		CreateThread(nar_turn_on_all_interacts);
	end,

	
};

global W1Station_Welding_miners_vale = {
	name = "W1Station_Welding_miners_vale",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
	
		[1] = {

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "How's it looking?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_vale_02800.sound'),
		},

		[2] = {
		sleepBefore = 0.5,
			character = AI.sq_mhub_patrol_welder.welder_01, -- GAMMA_CHARACTER: Minermale03
			text = "It's not so bad. Nothing we can't patch up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_04300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		--CreateThread(w1_welder_button_handler);
		CreateThread(nar_welder_listener);
		CreateThread(nar_turn_on_all_interacts);	
	end,

	
};


global W1Station_Welding_miners_tanaka = {
	name = "W1Station_Welding_miners_tanaka",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "How's it looking?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_03200.sound'),
		},
		[2] = {
		sleepBefore = 0.5,
			character = AI.sq_mhub_patrol_welder.welder_01, -- GAMMA_CHARACTER: Minermale03
			text = "It's not so bad. Nothing we can't patch up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_04300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		--CreateThread(w1_welder_button_handler);
		CreateThread(nar_turn_on_all_interacts);
		CreateThread(nar_welder_listener);
	end,

	
};

global W1Station_Welding_miners_buck = {
	name = "W1Station_Welding_miners_buck",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "How's it looking?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_02600.sound'),
		},
--           IF TANAKA

	
		[2] = {
		sleepBefore = 0.5,
			character = AI.sq_mhub_patrol_welder.welder_01, -- GAMMA_CHARACTER: Minermale03
			text = "It's not so bad. Nothing we can't patch up.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale03_04300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		--CreateThread(w1_welder_button_handler);
		CreateThread(nar_turn_on_all_interacts);
		CreateThread(nar_welder_listener);
	end,

	
};


--function w1_gate3_button_handler()
--sleep_s(2);
--		device_set_power (OBJECTS.nar_gate3_talk, 1);
--		device_set_position_immediate ( OBJECTS.nar_gate3_talk, 0 );
--	Sleep(1);
--	CreateThread(nar_gate3_listener);

--end


function nar_gate3_listener()
	
       SleepUntil([| object_valid( "nar_gate3_talk" ) ], 60);
	   PrintNarrative("LISTENER - nar_gate3_listener THREADED");
       SleepUntil([| device_get_power( OBJECTS.nar_gate3_talk) == 1 ], 60);


			
       PrintNarrative("LISTENER - nar_gate3_listener");

       CreateThread(RegisterInteractEvent, nar_gate3_launcher, OBJECTS.nar_gate3_talk);
			

end

function nar_gate3_launcher(trigger:object, activator:object)

       PrintNarrative("LAUNCHER - nar_gate3_launcher");

       print(activator, " is the activator of ", trigger);

       CreateThread(UnregisterInteractEvent, nar_gate3_launcher, OBJECTS.nar_gate3_talk);

       CreateThread(nar_gate3_start, activator)
end


function nar_gate3_start(activator:object)
--device_set_power (OBJECTS.nar_gate3_talk, 0);
CreateThread(nar_turn_off_all_interacts);
sleep_s(0.5);
	if activator == SPARTANS.locke then
		if b_locke_talk3_line_playing == false then
			b_locke_talk3_line_playing = true;
			NarrativeQueue.QueueConversation(W1Station_gate3_miners_locke);
		end
		elseif activator == SPARTANS.buck  then
			NarrativeQueue.QueueConversation(W1Station_gate3_miners_buck);
		elseif activator == SPARTANS.tanaka  then
			NarrativeQueue.QueueConversation(W1Station_gate3_miners_tanaka);
		elseif activator == SPARTANS.vale  then

			NarrativeQueue.QueueConversation(W1Station_gate3_miners_vale);
		else
			CreateThread(nar_turn_on_all_interacts);
			CreateThread(nar_gate3_listener);
		end
end


global W1Station_gate3_miners_locke = {
	name = "W1Station_gate3_miners_locke",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
		
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Looks like a lot of work ahead.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_04500.sound'),
		},

		[2] = {
		
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				cs_look_player(AI.sq_inner_gate.sp_innergate_04, true);
			end,			
						
			sleepBefore = 0.5,
			character = AI.sq_inner_gate.sp_innergate_04, -- GAMMA_CHARACTER: Minermale03
			text = "Total glassed area still about 22%. Whole lot of work ahead of us.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale05_00100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				cs_look_player(AI.sq_inner_gate.sp_innergate_04, false);
			end,					
		},
	},
	
	OnFinish = function (thisConvo, queue)
		--CreateThread(w1_gate3_button_handler);
			CreateThread(nar_turn_on_all_interacts);
			CreateThread(nar_gate3_listener);
			b_locke_talk3_line_playing = false;
	end,

	
};

global W1Station_gate3_miners_vale = {
	name = "W1Station_gate3_miners_vale",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
	
		[1] = {

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Looks like a lot of work ahead.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_vale_02900.sound'),
		},

		[2] = {
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				cs_look_player(AI.sq_inner_gate.sp_innergate_04, true);
			end,			
						
			sleepBefore = 0.5,
			character = AI.sq_inner_gate.sp_innergate_04, -- GAMMA_CHARACTER: Minermale03
			text = "Total glassed area still about 22%. Whole lot of work ahead of us.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale05_00100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				cs_look_player(AI.sq_inner_gate.sp_innergate_04, false);
			end,		
		},
	},

	OnFinish = function (thisConvo, queue)
		--CreateThread(w1_gate3_button_handler);
		CreateThread(nar_turn_on_all_interacts);
			CreateThread(nar_gate3_listener);
	end,

	
};


global W1Station_gate3_miners_tanaka = {
	name = "W1Station_gate3_miners_tanaka",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Looks like a lot of work ahead.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_03300.sound'),
		},
		[2] = {
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				cs_look_player(AI.sq_inner_gate.sp_innergate_04, true);
			end,			
						
			sleepBefore = 0.5,
			character = AI.sq_inner_gate.sp_innergate_04, -- GAMMA_CHARACTER: Minermale03
			text = "Total glassed area still about 22%. Whole lot of work ahead of us.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale05_00100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				cs_look_player(AI.sq_inner_gate.sp_innergate_04, false);
			end,		
		},
	},

	OnFinish = function (thisConvo, queue)
		--CreateThread(w1_gate3_button_handler);
		CreateThread(nar_turn_on_all_interacts);
			CreateThread(nar_gate3_listener);
	end,

	
};

global W1Station_gate3_miners_buck = {
	name = "W1Station_gate3_miners_buck",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Looks like a lot of work ahead.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_02700.sound'),
		},
--           IF TANAKA

	
		[2] = {
			OnStart = function (thisLine, thisConvo, queue, lineNumber) -- VOID
				cs_look_player(AI.sq_inner_gate.sp_innergate_04, true);
			end,			
						
			sleepBefore = 0.5,
			character = AI.sq_inner_gate.sp_innergate_04, -- GAMMA_CHARACTER: Minermale03
			text = "Total glassed area still about 22%. Whole lot of work ahead of us.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minerfemale05_00100.sound'),

			OnTagFinish = function(thisLine, thisConvo, queue, lineNumber)
				cs_look_player(AI.sq_inner_gate.sp_innergate_04, false);
			end,		
		},
	},

	OnFinish = function (thisConvo, queue)
		--CreateThread(w1_gate3_button_handler);	
		CreateThread(nar_turn_on_all_interacts);
			CreateThread(nar_gate3_listener);
	end,
};

--function w1_cleaning_button_handler()
--	sleep_s(2);
--	device_set_power (OBJECTS.nar_cleaner_talk, 1);
--	device_set_position_immediate ( OBJECTS.nar_cleaner_talk, 0 );
--	Sleep(1);
--	CreateThread(nar_cleaner_listener);
--end

function nar_cleaner_listener()
	SleepUntil([| object_valid( "nar_cleaner_talk" ) ], 60);
	PrintNarrative("LISTENER - nar_cleaner_listener THREADED");
	SleepUntil([| device_get_power( OBJECTS.nar_cleaner_talk) == 1 ], 60);	
	PrintNarrative("LISTENER - nar_cleaner_listener");
	CreateThread(RegisterInteractEvent, nar_cleaner_launcher, OBJECTS.nar_cleaner_talk);
end

function nar_cleaner_launcher(trigger:object, activator:object)
	PrintNarrative("LAUNCHER - nar_cleaner_launcher");
	print(activator, " is the activator of ", trigger);
	CreateThread(UnregisterInteractEvent, nar_cleaner_launcher , OBJECTS.nar_cleaner_talk);
	CreateThread(nar_cleaner_start, activator)
end

function nar_cleaner_start(activator:object)
	--device_set_power (OBJECTS.nar_cleaner_talk, 0);
	CreateThread(nar_turn_off_all_interacts);
	ObjectSetSpartanTrackingEnabled(ai_get_object(AI.sq_mhub_miner_window_01.windows_01), false);
	sleep_s(0.5);
	if activator == SPARTANS.locke then
		NarrativeQueue.QueueConversation(W1Station_cleaning_miners_locke);
			
		elseif activator == SPARTANS.buck  then
			NarrativeQueue.QueueConversation(W1Station_cleaning_miners_buck);
		elseif activator == SPARTANS.tanaka  then
			NarrativeQueue.QueueConversation(W1Station_cleaning_miners_tanaka);
		elseif activator == SPARTANS.vale  then
			NarrativeQueue.QueueConversation(W1Station_cleaning_miners_vale);
		end
end



global W1Station_cleaning_miners_locke = {
	name = "W1Station_cleaning_miners_locke",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
		
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "How's it looking?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_04400.sound'),
		},

		[2] = {
		sleepBefore = 0.5,
			character = AI.sq_mhub_miner_window_01.windows_01, -- GAMMA_CHARACTER: Minermale03
			text = "Keeping things nice is good for morale.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale05_03100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		--CreateThread(w1_cleaning_button_handler);
		CreateThread(nar_turn_on_all_interacts);
			CreateThread(nar_cleaner_listener);
	end,

	
};

global W1Station_cleaning_miners_vale = {
	name = "W1Station_cleaning_miners_vale",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
	
		[1] = {

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "How's it looking?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_vale_02800.sound'),
		},

		[2] = {
		sleepBefore = 0.5,
			character = AI.sq_mhub_miner_window_01.windows_01, -- GAMMA_CHARACTER: Minermale03
			text = "Keeping things nice is good for morale.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale05_03100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		--CreateThread(w1_cleaning_button_handler);
		CreateThread(nar_turn_on_all_interacts);
			CreateThread(nar_cleaner_listener);
	end,

	
};


global W1Station_cleaning_miners_tanaka = {
	name = "W1Station_cleaning_miners_tanaka",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "How's it looking?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_03200.sound'),
		},
		[2] = {
		sleepBefore = 0.5,
			character = AI.sq_mhub_miner_window_01.windows_01, -- GAMMA_CHARACTER: Minermale03
			text = "Keeping things nice is good for morale.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale05_03100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	--	CreateThread(w1_cleaning_button_handler);
	CreateThread(nar_turn_on_all_interacts);
			CreateThread(nar_cleaner_listener);
	end,

	
};

global W1Station_cleaning_miners_buck = {
	name = "W1Station_cleaning_miners_buck",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "How's it looking?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_02600.sound'),
		},
--           IF TANAKA

	
		[2] = {
		sleepBefore = 0.5,
			character = AI.sq_mhub_miner_window_01.windows_01, -- GAMMA_CHARACTER: Minermale03
			text = "Keeping things nice is good for morale.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale05_03100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	--	CreateThread(w1_cleaning_button_handler);
	CreateThread(nar_turn_on_all_interacts);
			CreateThread(nar_cleaner_listener);
	end,

	
};

--function w1_cleaning2_button_handler()
--	sleep_s(2);
--	device_set_power (OBJECTS.nar_cleaner2_talk, 1);
--	device_set_position_immediate ( OBJECTS.nar_cleaner2_talk, 0 );
--	Sleep(1);
--	CreateThread(nar_cleaner2_listener);
--end

function nar_cleaner2_listener()
	SleepUntil([| object_valid( "nar_cleaner2_talk" ) ], 60);
	PrintNarrative("LISTENER - nar_cleaner2_listener THREADED");
	SleepUntil([| device_get_power( OBJECTS.nar_cleaner2_talk) == 1 ], 60);
	PrintNarrative("LISTENER - nar_cleaner2_listener");
	CreateThread(RegisterInteractEvent, nar_cleaner2_launcher, OBJECTS.nar_cleaner2_talk);
end

function nar_cleaner2_launcher(trigger:object, activator:object)
	PrintNarrative("LAUNCHER - nar_cleaner2_launcher");
	print(activator, " is the activator of ", trigger);
	CreateThread(UnregisterInteractEvent, nar_cleaner2_launcher , OBJECTS.nar_cleaner2_talk);
	CreateThread(nar_cleaner2_start, activator)
end

function nar_cleaner2_start(activator:object)
--	device_set_power (OBJECTS.nar_cleaner2_talk, 0);
CreateThread(nar_turn_off_all_interacts);
	ObjectSetSpartanTrackingEnabled(ai_get_object(AI.sq_mhub_miner_window_01.windows_02), false);
	sleep_s(0.5);
	if activator == SPARTANS.locke then
		NarrativeQueue.QueueConversation(W1Station_cleaning2_miners_locke);
	elseif activator == SPARTANS.buck  then
			NarrativeQueue.QueueConversation(W1Station_cleaning2_miners_buck);
	elseif activator == SPARTANS.tanaka  then
			NarrativeQueue.QueueConversation(W1Station_cleaning2_miners_tanaka);
	elseif activator == SPARTANS.vale  then
			NarrativeQueue.QueueConversation(W1Station_cleaning2_miners_vale);
	end
end



global W1Station_cleaning2_miners_locke = {
	name = "W1Station_cleaning2_miners_locke",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
		
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Hello.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_03600.sound'),
		},

		[2] = {
		sleepBefore = 0.5,
			character = AI.sq_mhub_miner_window_01.windows_02, -- GAMMA_CHARACTER: Minermale03
			text = "Seems we've got Spartans in town! Meridian should look its best for our guests.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MinerMale09_01100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	--	CreateThread(w1_cleaning2_button_handler);
	CreateThread(nar_turn_on_all_interacts);
		CreateThread(nar_cleaner2_listener);
	end,

	
};

global W1Station_cleaning2_miners_vale = {
	name = "W1Station_cleaning2_miners_vale",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
	
		[1] = {

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Hello.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_vale_02100.sound'),
		},

		[2] = {
		sleepBefore = 0.5,
			character = AI.sq_mhub_miner_window_01.windows_02, -- GAMMA_CHARACTER: Minermale03
			text = "Seems we've got Spartans in town! Meridian should look its best for our guests.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MinerMale09_01100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		--CreateThread(w1_cleaning2_button_handler);
		CreateThread(nar_turn_on_all_interacts);
		CreateThread(nar_cleaner2_listener);
	end,

	
};


global W1Station_cleaning2_miners_tanaka = {
	name = "W1Station_cleaning2_miners_tanaka",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Hello.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_02400.sound'),
		},
		[2] = {
		sleepBefore = 0.5,
			character = AI.sq_mhub_miner_window_01.windows_02, -- GAMMA_CHARACTER: Minermale03
			text = "Seems we've got Spartans in town! Meridian should look its best for our guests.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MinerMale09_01100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	--CreateThread(w1_cleaning2_button_handler);
	CreateThread(nar_turn_on_all_interacts);
	CreateThread(nar_cleaner2_listener);
	end,

	
};

global W1Station_cleaning2_miners_buck = {
	name = "W1Station_cleaning2_miners_buck",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Hello.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_01900.sound'),
		},
--           IF TANAKA

	
		[2] = {
		sleepBefore = 0.5,
			character = AI.sq_mhub_miner_window_01.windows_02, -- GAMMA_CHARACTER: Minermale03
			text = "Seems we've got Spartans in town! Meridian should look its best for our guests.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MinerMale09_01100.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	--CreateThread(w1_cleaning2_button_handler);
	CreateThread(nar_turn_on_all_interacts);
	CreateThread(nar_cleaner2_listener);
	end,
};

--function w1_inventory_button_handler()
--	sleep_s(2);
--	device_set_power (OBJECTS.nar_inventory_talk, 1);
--	device_set_position_immediate ( OBJECTS.nar_inventory_talk, 0 );
--	Sleep(1);
--	CreateThread(nar_inventory_listener);
--end

function nar_inventory_listener()
	SleepUntil([| object_valid( "nar_inventory_talk" ) ], 60);
	PrintNarrative("LISTENER - nar_inventory_listener THREADED");
	SleepUntil([| device_get_power( OBJECTS.nar_inventory_talk) == 1 ], 60);	
	PrintNarrative("LISTENER - nar_inventory_listener");
	CreateThread(RegisterInteractEvent, nar_inventory_launcher, OBJECTS.nar_inventory_talk);
end

function nar_inventory_launcher(trigger:object, activator:object)
	PrintNarrative("LAUNCHER - nar_inventory_launcher");
	print(activator, " is the activator of ", trigger);
	CreateThread(UnregisterInteractEvent, nar_inventory_launcher , OBJECTS.nar_inventory_talk);
	CreateThread(nar_inventory_start, activator)
end


function nar_inventory_start(activator:object)
CreateThread(nar_turn_off_all_interacts);
	--device_set_power (OBJECTS.nar_inventory_talk, 0);
ObjectSetSpartanTrackingEnabled(ai_get_object(AI.sq_mhub_miner_leaner_01.leaner_01), false);
	sleep_s(0.5);
	if activator == SPARTANS.locke then
		NarrativeQueue.QueueConversation(W1Station_inventory_miners_locke);
			
		elseif activator == SPARTANS.buck  then
			NarrativeQueue.QueueConversation(W1Station_inventory_miners_buck);
		elseif activator == SPARTANS.tanaka  then
			NarrativeQueue.QueueConversation(W1Station_inventory_miners_tanaka);
		elseif activator == SPARTANS.vale  then
			NarrativeQueue.QueueConversation(W1Station_inventory_miners_vale);
		end
end



global W1Station_inventory_miners_locke = {
	name = "W1Station_inventory_miners_locke",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
		
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "How is everything?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_03300.sound'),
		},

		[2] = {
		sleepBefore = 0.5,
			character = AI.sq_mhub_miner_leaner_01.leaner_01, -- GAMMA_CHARACTER: Minermale03
			text = "Nothing freer than the frontier, and there's plenty of honest work ... but I didn't think I'd miss trees so much.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale06_01300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		CreateThread(nar_inventory_listener);
		--CreateThread(w1_inventory_button_handler);
		CreateThread(nar_turn_on_all_interacts);
	end,

	
};

global W1Station_inventory_miners_vale = {
	name = "W1Station_inventory_miners_vale",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
	
		[1] = {

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "How is everything?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_vale_01800.sound'),
		},

		[2] = {
		sleepBefore = 0.5,
			character = AI.sq_mhub_miner_leaner_01.leaner_01, -- GAMMA_CHARACTER: Minermale03
			text = "Nothing freer than the frontier, and there's plenty of honest work ... but I didn't think I'd miss trees so much.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale06_01300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		CreateThread(nar_inventory_listener);
		--CreateThread(w1_inventory_button_handler);
		CreateThread(nar_turn_on_all_interacts);
	end,

	
};


global W1Station_inventory_miners_tanaka = {
	name = "W1Station_inventory_miners_tanaka",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "How is everything?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_02100.sound'),
		},
		[2] = {
		sleepBefore = 0.5,
			character = AI.sq_mhub_miner_leaner_01.leaner_01, -- GAMMA_CHARACTER: Minermale03
			text = "Nothing freer than the frontier, and there's plenty of honest work ... but I didn't think I'd miss trees so much.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale06_01300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	CreateThread(nar_inventory_listener);
	--CreateThread(w1_inventory_button_handler);
	CreateThread(nar_turn_on_all_interacts);
	end,

	
};

global W1Station_inventory_miners_buck = {
	name = "W1Station_inventory_miners_buck",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "How is everything?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_01600.sound'),
		},
--           IF TANAKA

	
		[2] = {
		sleepBefore = 0.5,
			character = AI.sq_mhub_miner_leaner_01.leaner_01, -- GAMMA_CHARACTER: Minermale03
			text = "Nothing freer than the frontier, and there's plenty of honest work ... but I didn't think I'd miss trees so much.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_minermale06_01300.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		CreateThread(nar_inventory_listener);
		--CreateThread(w1_inventory_button_handler);
		CreateThread(nar_turn_on_all_interacts);
	end,
};

--function nar_inventory2_button_back_on()
--	sleep_s(2);
--	device_set_power (OBJECTS.nar_inventory2_talk, 1);
--	device_set_position_immediate ( OBJECTS.nar_inventory2_talk, 0 );
--	Sleep(1);
--	CreateThread(nar_inventory2_listener);
--end

function nar_inventory2_listener()
	SleepUntil([| object_valid( "nar_inventory2_talk" ) ], 60);
	PrintNarrative("LISTENER - nar_inventory2_listener THREADED");
	SleepUntil([| device_get_power( OBJECTS.nar_inventory2_talk) == 1 ], 60);		
	PrintNarrative("LISTENER - nar_inventory_listener");
	CreateThread(RegisterInteractEvent, nar_inventory2_launcher, OBJECTS.nar_inventory2_talk);
end

function nar_inventory2_launcher(trigger:object, activator:object)
	PrintNarrative("LAUNCHER - nar_inventory2_launcher");
	print(activator, " is the activator of ", trigger);
	CreateThread(UnregisterInteractEvent, nar_inventory2_launcher , OBJECTS.nar_inventory2_talk);
	CreateThread(nar_inventory2_start, activator)
end

function nar_inventory2_start(activator:object)
CreateThread(nar_turn_off_all_interacts);
	--device_set_power (OBJECTS.nar_inventory2_talk, 0);
	ObjectSetSpartanTrackingEnabled(ai_get_object(AI.sq_mhub_miner_leaner_01.leaner_03), false);
	sleep_s(0.5);
	if activator == SPARTANS.locke then
		NarrativeQueue.QueueConversation(W1Station_inventory2_miners_locke);
			
		elseif activator == SPARTANS.buck  then
			NarrativeQueue.QueueConversation(W1Station_inventory2_miners_buck);
		elseif activator == SPARTANS.tanaka  then
			NarrativeQueue.QueueConversation(W1Station_inventory2_miners_tanaka);
		elseif activator == SPARTANS.vale  then
			NarrativeQueue.QueueConversation(W1Station_inventory2_miners_vale);
		end
end



global W1Station_inventory2_miners_locke = {
	name = "W1Station_inventory2_miners_locke",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
		[1] = {
		
			character = CHARACTER_SPARTANS.locke, -- GAMMA_CHARACTER: LOCKE
			text = "Hello.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_locke_03600.sound'),
		},

		[2] = {
		sleepBefore = 1,
			character = AI.sq_mhub_miner_leaner_01.leaner_03, -- GAMMA_CHARACTER: Minermale03
			text = "Uh, you mind givin' me some space here?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MinerMale09_01000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		--CreateThread(nar_inventory2_button_back_on);
		CreateThread(nar_turn_on_all_interacts);
		CreateThread(nar_inventory2_listener);
	end,

	
};

global W1Station_inventory2_miners_vale = {
	name = "W1Station_inventory2_miners_vale",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {
	
		[1] = {

			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: VALE
			text = "Hello.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_vale_02100.sound'),
		},

		[2] = {
		sleepBefore = 0.5,
			character = AI.sq_mhub_miner_leaner_01.leaner_03, -- GAMMA_CHARACTER: Minermale03
			text = "Uh, you mind givin' me some space here?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MinerMale09_01000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
		--CreateThread(nar_inventory2_button_back_on);
		CreateThread(nar_turn_on_all_interacts);
		CreateThread(nar_inventory2_listener);
	end,

	
};


global W1Station_inventory2_miners_tanaka = {
	name = "W1Station_inventory2_miners_tanaka",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.MainCharacter; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {

			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Hello.\r\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_02400.sound'),
		},
		[2] = {
		sleepBefore = 0.5,
			character = AI.sq_mhub_miner_leaner_01.leaner_03, -- GAMMA_CHARACTER: Minermale03
			text = "Uh, you mind givin' me some space here?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MinerMale09_01000.sound'),
		},
	},

	OnFinish = function (thisConvo, queue)
	--	CreateThread(nar_inventory2_button_back_on);
	CreateThread(nar_turn_on_all_interacts);
		CreateThread(nar_inventory2_listener);
	end,

	
};

global W1Station_inventory2_miners_buck = {
	name = "W1Station_inventory2_miners_buck",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; --[[ CONVO_PRIORITY.CriticalPath, CONVO_PRIORITY.MainCharacter, CONVO_PRIORITY.NPC ]]
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
	end,

	lines = {

		[1] = {

			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
	text = "Hello.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_01900.sound'),
		},
--           IF TANAKA

	
		[2] = {
		sleepBefore = 0.5,
			character = AI.sq_mhub_miner_leaner_01.leaner_03, -- GAMMA_CHARACTER: Minermale03
			text = "Uh, you mind givin' me some space here?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_VO_SCR_W1Station_UN_MinerMale09_01000.sound'),
		
		},
	},

	OnFinish = function (thisConvo, queue)
		--CreateThread(nar_inventory2_button_back_on);
		CreateThread(nar_turn_on_all_interacts);
		CreateThread(nar_inventory2_listener);
	end,

	
};

function nar_turn_off_all_interacts()
device_set_power (OBJECTS.nar_inventory2_talk, 0);
	device_set_power (OBJECTS.nar_inventory_talk, 0);
	device_set_power (OBJECTS.nar_cleaner2_talk, 0);
	device_set_power (OBJECTS.nar_cleaner_talk, 0);
	device_set_power (OBJECTS.nar_gate3_talk, 0);
	device_set_power (OBJECTS.nar_welder_talk, 0);
	device_set_power (OBJECTS.nar_welder2_talk, 0);
	--device_set_power (OBJECTS.nar_fence_talk2, 0);
	device_set_power (OBJECTS.nar_fence_talk, 0);
	device_set_power (OBJECTS.nar_leftguard_talk, 0);
	device_set_power (OBJECTS.nar_front_gate_talk2, 0);
	device_set_power (OBJECTS.nar_inventory2_talk, 0);
	
end

function nar_turn_on_all_interacts()
sleep_s(1);
	device_set_position_immediate ( OBJECTS.nar_inventory2_talk, 0 );
	device_set_power (OBJECTS.nar_inventory2_talk, 1);
	device_set_position_immediate ( OBJECTS.nar_inventory_talk, 0 );
	device_set_power (OBJECTS.nar_inventory_talk, 1);
	device_set_position_immediate ( OBJECTS.nar_cleaner2_talk, 0 );
	device_set_power (OBJECTS.nar_cleaner2_talk, 1);
	device_set_position_immediate ( OBJECTS.nar_cleaner_talk, 0 );
	device_set_power (OBJECTS.nar_cleaner_talk, 1);
	device_set_position_immediate ( OBJECTS.nar_gate3_talk, 0 );
	device_set_power (OBJECTS.nar_gate3_talk, 1);
	device_set_position_immediate ( OBJECTS.nar_welder_talk, 0 );
	device_set_power (OBJECTS.nar_welder_talk, 1);
	device_set_position_immediate ( OBJECTS.nar_welder2_talk, 0 );
	device_set_power (OBJECTS.nar_welder2_talk, 1);
	--device_set_position_immediate ( OBJECTS.nar_fence_talk2, 0 );
	--device_set_power (OBJECTS.nar_fence_talk2, 1);
	device_set_position_immediate ( OBJECTS.nar_fence_talk, 0 );
	device_set_power (OBJECTS.nar_fence_talk, 1);
	device_set_position_immediate ( OBJECTS.nar_leftguard_talk, 0 );
	device_set_power (OBJECTS.nar_leftguard_talk, 1);
	device_set_position_immediate ( OBJECTS.nar_front_gate_talk2, 0 );
	device_set_power (OBJECTS.nar_front_gate_talk2, 1);

end


---- ============================================================================================================
--  Chatter
---- ============================================================================================================


function nar_turn_chatter_on()

	print("CHATTER ON");
		b_miningtown_idle_chatter_on = true;
	sleep_rand_s(60,75);
		print("CHECKING if i am in a chatter zone or if I am in a crit path convo")
			SleepUntil( [| b_collectible_used == false ], 1);
		if b_miningtown_idle_chatter_on == true then
		print("YAY CHATTER")
			if b_chatter_2_played == true and b_chatter_3_played == false and b_miningtown_idle_chatter_on == true then
				NarrativeQueue.QueueConversation(W1Station_Team_chatter_03);
				b_chatter_3_played = true;
			elseif b_chatter_1_played == true and b_chatter_2_played == false and b_miningtown_idle_chatter_on == true then
				NarrativeQueue.QueueConversation(W1Station_TEAM_CHATTER_02);
				b_chatter_2_played = true;
			elseif b_chatter_1_played == false and b_miningtown_idle_chatter_on == true then
				NarrativeQueue.QueueConversation(W1Station_TEAM_CHATTER_01);
				b_chatter_1_played = true;
			end
		else 
		print("NO CHATTER, try next time again")
	end
	CreateThread(nar_turn_chatter_on);

end

function nar_turn_chatter_back_on()
	sleep_s(5);
	b_miningtown_idle_chatter_on = false;
end

function nar_no_chatter_zone()

SleepUntil( [| volume_test_players(VOLUMES.no_chatter01) or volume_test_players(VOLUMES.no_chatter02) or volume_test_players(VOLUMES.no_chatter03) or volume_test_players(VOLUMES.nochatter_04) or volume_test_players(VOLUMES.nochatter_05)],1);
	print("CHATTER OFF");
		b_miningtown_idle_chatter_on = false;
		
		NarrativeQueue.EndConversationEarly(W1Station_TEAM_CHATTER_01);
		NarrativeQueue.EndConversationEarly(W1Station_TEAM_CHATTER_02);
		NarrativeQueue.EndConversationEarly(W1Station_Team_chatter_03);
		sleep_s(5);
		CreateThread(nar_no_chatter_zone);
end

function nar_chatter_off_vo()

		b_miningtown_idle_chatter_on = false;
		
		NarrativeQueue.EndConversationEarly(W1Station_TEAM_CHATTER_01);
		NarrativeQueue.EndConversationEarly(W1Station_TEAM_CHATTER_02);
		NarrativeQueue.EndConversationEarly(W1Station_Team_chatter_03);
end



global W1Station_TEAM_CHATTER_01 = {
	name = "W1Station_TEAM_CHATTER_01",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; 
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		CreateThread(nar_turn_off_all_interacts);
	end,

	lines = {
		[1] = {
							If = function(thisLine, thisConvo, queue, lineNumber)
				return b_miningtown_idle_chatter_on == true and b_collectible_used ~= true;
			end,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.vale, -- GAMMA_CHARACTER: Vale
			text = "I've never seen a glassed planet in person before. It's kind of... pretty?",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_vale_03000.sound'),
		},
		[2] = {
								If = function(thisLine, thisConvo, queue, lineNumber)
				return b_miningtown_idle_chatter_on == true and b_collectible_used ~= true;
			end,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BuCK
			text = "You've got a weird idea of pretty, Vale.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_02800.sound'),
		},
		[3] = {
								If = function(thisLine, thisConvo, queue, lineNumber)
				return b_miningtown_idle_chatter_on == true and b_collectible_used ~= true;
			end,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 1,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TaNAKA
			text = "Home world got glassed. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_03400.sound'),
		},
		
		[4] = {
								If = function(thisLine, thisConvo, queue, lineNumber)
				return b_miningtown_idle_chatter_on == true and b_collectible_used ~= true;
			end,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: TANAKA
			text = "Was on the other side of Minab when the Covies hit the capital city. Survived the blast easy. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_03500.sound'),
		},
		[5] = {
								If = function(thisLine, thisConvo, queue, lineNumber)
				return b_miningtown_idle_chatter_on == true and b_collectible_used ~= true;
			end,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "But when the ground melts... debris gets thrown into the atmosphere. Blocks out the sun. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_03600.sound'),
		},
		[6] = {
								If = function(thisLine, thisConvo, queue, lineNumber)
				return b_miningtown_idle_chatter_on == true and b_collectible_used ~= true;
			end,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "Instant ice age for the whole world. Surviving that's a bit less easy.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_03700.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		b_miningtown_idle_chatter_on = false;
		CreateThread(nar_turn_on_all_interacts);
	end,

	localVariables = {},
};



global W1Station_TEAM_CHATTER_02 = {
	name = "W1Station_TEAM_CHATTER_02",

	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath;
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		CreateThread(nar_turn_off_all_interacts);
	end,

	lines = {
		[1] = {
								If = function(thisLine, thisConvo, queue, lineNumber)
				return b_miningtown_idle_chatter_on == true and b_collectible_used ~= true;
			end,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Never could wrap my head around the independent colony types. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_02900.sound'),
		},
		[2] = {
								If = function(thisLine, thisConvo, queue, lineNumber)
				return b_miningtown_idle_chatter_on == true and b_collectible_used ~= true;
			end,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: taNAKA
			text = "What's to understand? People like their freedom.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_03800.sound'),
		},
		[3] = {
								If = function(thisLine, thisConvo, queue, lineNumber)
				return b_miningtown_idle_chatter_on == true and b_collectible_used ~= true;
			end,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: buCK
			text = "UNSC ain't exactly a totalitarian state. ",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_03000.sound'),
		},
		[4] = {
								If = function(thisLine, thisConvo, queue, lineNumber)
				return b_miningtown_idle_chatter_on == true and b_collectible_used ~= true;
			end,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: taNAKA
			text = "It's still a state. A state who says where a body can settle and where it can't. That kinda oversight ain't needed on the frontier.\n",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_03900.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		b_miningtown_idle_chatter_on = false;
		CreateThread(nar_turn_on_all_interacts);
	end,

	localVariables = {},
};



global W1Station_Team_chatter_03 = {
	name = "W1Station_Team_chatter_03",


	Priority = function (thisConvo, queue)
		return CONVO_PRIORITY.CriticalPath; 
	end,

	OnStart = function (thisConvo, queue)
		print(thisConvo.name, " narrative");
		CreateThread(nar_turn_off_all_interacts);
	end,

	lines = {
		[1] = {
								If = function(thisLine, thisConvo, queue, lineNumber)
				return b_miningtown_idle_chatter_on == true and b_collectible_used ~= true;
			end,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: BUCK
			text = "Gotta wonder if it's even possible to resettle this mess.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_03100.sound'),
		},
		[2] = {
								If = function(thisLine, thisConvo, queue, lineNumber)
				return b_miningtown_idle_chatter_on == true and b_collectible_used ~= true;
			end,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "There's sense to the plan. Chip off the glass, hope the soil below's still viable.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_04000.sound'),
		},
		[3] = {
								If = function(thisLine, thisConvo, queue, lineNumber)
				return b_miningtown_idle_chatter_on == true and b_collectible_used ~= true;
			end,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 1,
			character = CHARACTER_SPARTANS.buck, -- GAMMA_CHARACTER: Buck
			text = "A quarter mile deep sea of slag, across most the globe...",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_buck_03200.sound'),
		},
		[4] = {
								If = function(thisLine, thisConvo, queue, lineNumber)
				return b_miningtown_idle_chatter_on == true and b_collectible_used ~= true;
			end,
									OnPlay = function (thisLine, thisConvo, queue, lineNumber) -- VOID
                    radio_tag_start(thisLine.moniker or NarrativeQueue.ResolveLineCharacter(thisLine, thisConvo, queue, lineNumber));
          end,
			sleepBefore = 0.5,
			character = CHARACTER_SPARTANS.tanaka, -- GAMMA_CHARACTER: Tanaka
			text = "That's where the hope figures in.",
			tag = TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_tanaka_04100.sound'),
		},
--                                                   CUT TO:
--           _____________________________________________________________

	},

	OnFinish = function (thisConvo, queue)
		hud_hide_radio_transmission_hud();
		b_miningtown_idle_chatter_on = false;
		CreateThread(nar_turn_on_all_interacts);
	end,

	localVariables = {},
}; 


---- ============================================================================================================
--  Interactive Consoles
---- ============================================================================================================
function w1_station_interactive_console1()
	SleepUntil([| device_get_position(OBJECTS.w1_station_interactive_console1) == 1 ], 1);
	device_set_power (OBJECTS.w1_station_interactive_console1, 0);
	sleep_s(2);
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_consolevoice_00100.sound'), OBJECTS.w1_station_interactive_console1);
	sleep_s(10);
	device_set_power (OBJECTS.w1_station_interactive_console1, 1);
	device_set_position_immediate ( OBJECTS.w1_station_interactive_console1, 0 );
	
	SleepUntil([| device_get_position(OBJECTS.w1_station_interactive_console1) == 1 ], 1);	
	device_set_power (OBJECTS.w1_station_interactive_console1, 0);
	sleep_s(2);
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_consolevoice_00800.sound'), OBJECTS.w1_station_interactive_console1);
	sleep_s(10);
	device_set_power (OBJECTS.w1_station_interactive_console1, 1);
	device_set_position_immediate ( OBJECTS.w1_station_interactive_console1, 0 );
	sleep_s(0.5);
	CreateThread(w1_station_interactive_console1);
end
function w1_station_interactive_console2()
	SleepUntil([| device_get_position(OBJECTS.w1_station_interactive_console2) == 1 ], 1);
	device_set_power (OBJECTS.w1_station_interactive_console2, 0);
	sleep_s(2);
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_consolevoice_00200.sound'), OBJECTS.w1_station_interactive_console2);
	sleep_s(10);
	device_set_power (OBJECTS.w1_station_interactive_console2, 1);
	device_set_position_immediate ( OBJECTS.w1_station_interactive_console2, 0 );	
	sleep_s(0.5);
	
	SleepUntil([| device_get_position(OBJECTS.w1_station_interactive_console2) == 1 ], 1);
	device_set_power (OBJECTS.w1_station_interactive_console2, 0);
	sleep_s(2);
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_consolevoice_00900.sound'), OBJECTS.w1_station_interactive_console2);
	sleep_s(10);
	device_set_power (OBJECTS.w1_station_interactive_console2, 1);
	device_set_position_immediate ( OBJECTS.w1_station_interactive_console2, 0 );
	sleep_s(0.5);
	CreateThread(w1_station_interactive_console2);
end

function w1_station_interactive_console3()
	SleepUntil([| device_get_position(OBJECTS.w1_station_interactive_console3) == 1 ], 1);
	device_set_power (OBJECTS.w1_station_interactive_console3, 0);		
	sleep_s(2);
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_consolevoice_00300.sound'), OBJECTS.w1_station_interactive_console3);
	sleep_s(10);
	device_set_power (OBJECTS.w1_station_interactive_console3, 1);
	device_set_position_immediate ( OBJECTS.w1_station_interactive_console3, 0 );
	sleep_s(0.5);
	
	SleepUntil([| device_get_position(OBJECTS.w1_station_interactive_console3) == 1 ], 1);
	device_set_power (OBJECTS.w1_station_interactive_console3, 0);
	sleep_s(2);
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_consolevoice_01000.sound'), OBJECTS.w1_station_interactive_console3);
	sleep_s(10);
	device_set_power (OBJECTS.w1_station_interactive_console3, 1);
	device_set_position_immediate ( OBJECTS.w1_station_interactive_console3, 0 );
	sleep_s(0.5);
	CreateThread(w1_station_interactive_console3);
end

function w1_station_interactive_console4()
	SleepUntil([| device_get_position(OBJECTS.w1_station_interactive_console4) == 1 ], 1);
	device_set_power (OBJECTS.w1_station_interactive_console4, 0);
	sleep_s(2);
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_consolevoice_00400.sound'), OBJECTS.w1_station_interactive_console4);
	sleep_s(10);
	device_set_power (OBJECTS.w1_station_interactive_console4, 1);
	device_set_position_immediate ( OBJECTS.w1_station_interactive_console4, 0 );	
	sleep_s(0.5);
	
	SleepUntil([| device_get_position(OBJECTS.w1_station_interactive_console4) == 1 ], 1);
	device_set_power (OBJECTS.w1_station_interactive_console4,0);
	sleep_s(2);
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_consolevoice_00700.sound'), OBJECTS.w1_station_interactive_console4);
	sleep_s(10);
	device_set_power (OBJECTS.w1_station_interactive_console4, 1);
	device_set_position_immediate ( OBJECTS.w1_station_interactive_console4, 0 );
	sleep_s(0.5);
	CreateThread(w1_station_interactive_console4);
end

function w1_station_interactive_console5()
	SleepUntil([| device_get_position(OBJECTS.w1_station_interactive_console5) == 1 ], 1);
	device_set_power (OBJECTS.w1_station_interactive_console5, 0);
	sleep_s(2);
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_consolevoice_00500.sound'), OBJECTS.w1_station_interactive_console5);
	sleep_s(10);
	device_set_power (OBJECTS.w1_station_interactive_console5, 1);
	device_set_position_immediate ( OBJECTS.w1_station_interactive_console5, 0 );
	sleep_s(0.5);
	
	SleepUntil([| device_get_position(OBJECTS.w1_station_interactive_console5) == 1 ], 1);
	device_set_power (OBJECTS.w1_station_interactive_console5, 0);
	sleep_s(2);
	PlayDialogOnClients(TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w1station\001_vo_scr_w1station_un_consolevoice_00600.sound'), OBJECTS.w1_station_interactive_console5);
	sleep_s(10);
	device_set_power (OBJECTS.w1_station_interactive_console5, 1);
	device_set_position_immediate ( OBJECTS.w1_station_interactive_console5, 0 );
	sleep_s(0.5);
	CreateThread(w1_station_interactive_console5);
end

---- ============================================================================================================
--  Tracking Breadcrumbs
---- ============================================================================================================

function f_mhub_kill_breadcrumb_01():void
	SleepUntil([| volume_test_players(VOLUMES.tv_mhub_breadcrumb_01) ], 10);
	object_destroy(OBJECTS.s_mhub_breadcrumb_01);
	MusketeerUtil_SetDestination_Clear_All();
	MusketeerUtil_SetMusketeerGoal(FLAGS.cf_mhub_sloan, 3);
end

function f_mhub_kill_breadcrumb_02():void
	SleepUntil([| volume_test_players(VOLUMES.tv_mhub_breadcrumb_02) ], 10);
	object_destroy(OBJECTS.s_mhub_breadcrumb_02);
end

function f_mhub_kill_breadcrumb_pelican():void
	SleepUntil([| volume_test_players(VOLUMES.tv_mhub_breadcrumb_pelican) ], 10);
	object_destroy(OBJECTS.s_mhub_breadcrumb_pelican);
	device_set_power(OBJECTS.devcon_pelican, 1);
	SleepUntil([| not volume_test_players(VOLUMES.tv_mhub_breadcrumb_pelican) ], 10);
	if device_get_position(OBJECTS.devcon_pelican) == 0 then
		CreateThread(f_mhub_kill_breadcrumb_pelican);
		device_set_power(OBJECTS.devcon_pelican, 0);
		TutorialStopAll();
	end
end

---- =======================================================================================================
-- Client Scripts
--- =======================================================================================================
                                                        
--## CLIENT
function remoteClient.vig_pelican_SpawnEvent_01()
	flock_start("flock_vig_pelican_01");
	flock_start("flock_vig_pelican_02");
	print("flock_vig_pelican_01 started");
	
	sleep_s(5);
	flock_stop("flock_vig_pelican_01");
	flock_stop("flock_vig_pelican_02");
--	print("flock_vig_pelican_01 stopped");
end

function remoteClient.flock_vig_cargo_01()
	flock_start("flock_vig_cargo_01");
	print("flock_vig_cargo_01 started");
--	sleep_s(5);
--	flock_stop("flock_vig_pelican_02");
--	print("flock_vig_pelican_02 stopped");
end

function remoteClient.vig_quest_SpawnEvent_quest()
	flock_start("flock_quest_turnin");
	print("flock_quest_turnin started");
	sleep_s(5);
	flock_stop("flock_quest_turnin");
	print("flock_quest_turnin stopped");
end

function remoteClient.nar_download_pip()

	hud_play_pip_from_tag(TAG('bink\campaign\pip_genereic_datadownload_60.bink'));
end