----## SERVER
--
----\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

---- *** World 2 Hub 2 ***
----\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
global b_TalkedToPalmer:boolean = false;
global b_TalkedToHalsey:boolean = false;
global b_halsey_wave:boolean = false;
global b_halsey_wave2:boolean = false;
global b_palmer_wave:boolean = false;
global b_palmer_wave2:boolean = false;
global prepareToSwitch:boolean = false;
global switchZoneSet:boolean = false;

--this is for compatibility with w2_campsite_vo.lua
--global n_arbiter_advisors:number = 0;
--global n_banshee_scenes:number = 0;
--global locke_banshee_scene:boolean = false;
--global tanaka_banshee_scene:boolean = false;
--global vale_banshee_scene:boolean = false;
--global buck_banshee_scene:boolean = false;
--global n_medic_scenes:number = nil;

global W2Hub2nd:table=
	{
		name = "w2_hub_2nd_visit",
		--description = "World 2 Hub 1st Visit"
		profiles = {STARTING_PROFILES.locke, STARTING_PROFILES.vale, STARTING_PROFILES.tanaka, STARTING_PROFILES.buck},
		
		startGoals = {"goal_starthub"},
		collectibles = {
			{objectName = "collect_banshee", collectibleName = "collect_banshee"},
			{objectName = "collect_tent", collectibleName = "collect_tent"},
			{objectName = "collect_traitor", collectibleName = "collect_traitor"},
			{objectName = "collect_grunt", collectibleName = "collect_grunt"},
			{objectName = "collect_halsey", collectibleName = "collect_halsey"},

		},
	
	};
                                    
-- *** START-UP ***
-- =================================================================================================
function startup.W2Hub2ndInit()
	--CreateThread (Profile);
	ai_allegiance (TEAM.covenant, TEAM.player);
	if not editor_mode() then
		StartW2hub2nd();
		fade_out(0,0,0,0);
	else
		print ("in editor, run StartW2hub2nd to start mission");
	end
end

function StartW2hub2nd()
	StartMission(W2Hub2nd);
end


function W2Hub2nd.Start()
	print(":::Loading Hub2nd Start:::");
end

function W2Hub2nd.End()
	--fade out before the outro
	CreateThread(audio_campsitereturn_mainloop_end);
	local fade_time:number = 2;
	fade_out (0,0,0,seconds_to_frames (fade_time));
	sleep_s (fade_time);
	RemoveBackgroundProps();
	Sleep (2);
	RunClientScript("PrintMeClient");
	switch_zone_set (ZONE_SETS.w2_campsite_return_end);
	Sleep (2);
	CinematicPlay ("cin_150_hubend", true);
	sys_LoadTitanAtTsunami();
end

function remoteServer.FlipStreamingBoolean()
	prepareToSwitch = true;
end

function remoteServer.FlipZoneSetSwitchBoolean()
	switchZoneSet = true;
end

function ServerCommandToPrepareZoneSet()
	print("STREAMING: started thread for prepare switch");
	SleepUntil([| prepareToSwitch == true], 1);
	print("STREAMING: preparing switch");
	prepare_to_switch_to_zone_set(ZONE_SETS.w2_campsite_return_end);
end

function ServerCommandToSwitchZoneSet()
	print("STREAMING: started thread for switch");
	SleepUntil([|switchZoneSet == true], 1);
	print("STREAMING: switching zoneset");
	switch_zone_set(ZONE_SETS.w2_campsite_return_end);
end


-- ===================================
-- Goal: starthub
-- ===================================

W2Hub2nd.goal_starthub = 
{

	zoneSet = ZONE_SETS.w2_campsite_return,
	next = {"goal_tsunami"};
} 

function W2Hub2nd.goal_starthub.Start()
			-- turn off Temp Text
	NarrativeQueue.instance.showBlurbs = false;
	
	--syncing all the clients
	SleepUntil([| AllClientViewsActiveAndStable() ], 1);
	
	--guns down
	CreateThread(w2_hub_guns_down_2);
	
	--intro cinematic
	CinematicPlay ("cin_t00_plateau1b");
	
	cinematic_show_letterbox_immediate(true);
	composer_play_show ("vin_w2_campsite_return_ics_intro");

	CreateThread(w2hub_assault_landingpad);
	-- Scene start threads
	CreateThread(w2_hub_arbiter);
	CreateThread(w2_hub_medical_base);
	CreateThread(w2_hub_datapad_colors);
	CreateThread(w2_phantom_pad_2);
	CreateThread(w2hub_lich);
	CreateThread(ServerCommandToPrepareZoneSet);
	CreateThread(ServerCommandToSwitchZoneSet);

	--audio
	CreateThread(audio_campsitereturn_mainloop_start);
	
	--phantoms
	ai_place (AI.sg_phantoms);
	ai_place (AI.sq_intro_phantom);
	
	--place the constructor
	ai_place (AI.sq_constructor);
	
	GoalCompleteCurrent();	
end
-- ===================================
-- Goal: Tsunami
-- ===================================

W2Hub2nd.goal_tsunami = 
{
	zoneSet = ZONE_SETS.w2_campsite_return,
} 

function W2Hub2nd.goal_tsunami.Start()
	CreateThread (gotoPalmer);
	gotoHalsey();
	GoalCompleteCurrent();	
end

function gotoPalmer()
	composer_play_show ("comp_palmer");
	game_save_no_timeout();
	
	--make Palmer trackable
	ObjectSetSpartanTrackingEnabled (ai_get_object (AI.sq_palmer.sp_palmer), true);
	
	--letterbox intro
	f_chapter_title(TITLES.ch_campsite_return_intro);
	
	--tell players to go to Palmer
	--ShowTempTextNarrative("Report to Palmer VO", 4);
	PrintNarrative("QUEUE - W2Hub2ndVisit_Ext__LANDING_PAD");					
	NarrativeQueue.QueueConversation(W2Hub2ndVisit_Ext__LANDING_PAD);
	--sleep until the titles and/or VO is done (Don't do this with seconds)
	
	SleepUntil([| NarrativeQueue.HasConversationFinished(W2Hub2ndVisit_Ext__LANDING_PAD) ], 15);
	sleep_s (1);
	print ("intro vo done");
	
	--display the objective
	ObjectiveShow(TITLES.ch_report_to_palmer);
	sleep_s (6);
	
	game_save_no_timeout();
		
	CreateThread (TutorialRepeat, "training_tracking_palmer", "b_palmer_wake");
	HubReturnDeviceControl(Palmer2ndObjVO);
	
		--VO lines post Talking to Palmer
	VONearVol (Palmer2ndObjVO.volume, Palmer2ndObjVO.VOAfterObj, "b_TalkedToHalsey");
	--SleepUntil([| Palmer2ndObjVO.VOAfterObj.HasConversationFinished ], 15);
end

function gotoHalsey()
	composer_play_show ("comp_halsey");

	--tell players to go to Palmer
	--ShowTempTextNarrative("Report to Halsey VO", 4);
	VONearVol (Halsey2ndObjVO.volume, Halsey2ndObjVO.VOPre, "b_TalkedToPalmer");
	game_save_no_timeout();
	
	--sleep until Palmer is done talking
	--SleepUntil([| NarrativeQueue.HasConversationFinished(Palmer2ndObj_2) ], 15);
	--ShowTempTextNarrative("PALMER 2ND DONE!!", 4);
	
	--display the objective
	print ("halsey objective");
	sleep_s (1);
	ObjectiveShow(TITLES.ch_report_to_halsey);
	
	--sleep until the titles and/or VO is done (Don't do this with seconds)
	sleep_s (6);
	CreateThread (TutorialRepeat, "training_tracking_halsey", "b_halsey_wake");
	HubReturnDeviceControl(Halsey2ndObjVO);
	
	--sleep until ALL the VO is done
	SleepUntil ([| b_TalkedToHalsey ], 1);
	
	--CreateThread(audio_campsitereturn_constructorpowerup_start);  -- stinger at power up of constructor

	--dramatic pause
	sleep_s (2);
end



function W2Hub2nd.goal_tsunami.End()
	print ("ending mission");
	--ShowTempTextNarrative("Constructor show plays here", 4);

	CreateThread(EndCurrentMission);
end


--
----\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- HELPER FUNCTIONS
--
----\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
function HubReturnDeviceControl(objTable:table)
	local dev = ObjectFromName (objTable.dev);
	local trackedObj = objTable.trackedObj;
	local vol = objTable.volume;
	
--	local state:table = {near = false};
--	composer_play_show (objTable.show, state);
	--turn on tracking and the device
	device_set_power (dev, 1);
	--navpoint_track_object (dev, true);
	SleepUntil ([| object_index_valid (trackedObj())], 1);
	--print ("object valid");
	ObjectSetSpartanTrackingEnabled (trackedObj(), true);
	RegisterSpartanTrackingPingObjectEvent(TrackingOnPing, trackedObj(), trackedObj());
	objects_attach (trackedObj(), "", dev, "");
	game_save_no_timeout();
	
	--check if the player is in volume and play the VO, end once the control is activated
	repeat
		SleepUntil ([| volume_test_players (vol) ], 10);
		if not NarrativeQueue.IsConversationQueued(objTable.VONearby) then
			print ("should play VO nearby");
			NarrativeQueue.QueueConversation(objTable.VONearby);
		else
			print ("not playing VO Nearby because it's already playing");
		end
		--wait until a player presses X or out of volume, if pressed X continue on
		SleepUntil ([| (not volume_test_players (vol) or DeviceUsed(dev) )], 3);
	until DeviceUsed(dev);
	
	--turn off the tracking
	--navpoint_track_object (dev, false);
	ObjectSetSpartanTrackingEnabled (trackedObj(), false);
	UnregisterSpartanTrackingPingObjectEvent(TrackingOnPing, trackedObj());
	
	--turn off the device just in case
	device_set_power (dev, 0);
	
	--turn off any tutorials
	TutorialStopAll();
	
	--state.near = true;
	--play the objective VO	
	NarrativeQueue.QueueConversation(objTable.VOObj);
	SleepUntil([| NarrativeQueue.HasConversationFinished(objTable.VOObj) ], 15);
	sleep_s (0.5);
end

function DeviceUsed(dev:object):boolean
	if device_get_position (dev) > 0 then
		return true;
	end
end

function VONearVol(vol:volume, VO:table, ending:string)
	--tell players to go to next objective
	repeat
		--wait until players are out of volume
		SleepUntil ([| not volume_test_players (vol) or _G[ending]], 10);
		SleepUntil ([| volume_test_players (vol) or _G[ending]], 10);
		if not _G[ending] then
			print ("vo pre or post obj playing");
			NarrativeQueue.QueueConversation(VO);
			SleepUntil([| NarrativeQueue.HasConversationFinished(VO) ], 15);
		end
	until _G[ending];
	print (ending, " is true");
end

--shows the tutorial text to talk to the NPC's on a loop until talking to the NPC
function TutorialRepeat(text:string, ending:string)
	repeat
		TutorialShowAll (text, 15);
		sleep_s (60);
	until _G[ending];
end

--stops the tutorial playing on a client if they ping while the tutorial text is up
function TrackingOnPing(playerUnit:object, PingedObj:object):void
	print(PingedObj, " was pinged by ", playerUnit);
	TutorialStop(unit_get_player(playerUnit));
end

--removes background objects so the end cinema looks good (called from the composition)
function RemoveBackgroundProps()
	print ("deleting background props and flocks");
	object_destroy_folder (MODULES.sc_background_ships);
	flock_delete ("vig_bansh_v1_01");
	flock_delete ("vig_bansh_v1_02");
	flock_delete ("vig_phantom");
	flock_delete ("fly_beetles_01");
end

--
----\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
--------------COMMAND SCRIPTS-----------------
--
----\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

function cs_elite_banshee_1()
	local banshee1 = OBJECTS.ve_banshee_1;
	--object_create_anew (banshee);
	object_wake_physics (banshee1);
	--ai_enter_limbo (ai_current_actor);
	SleepUntil ([| volume_test_players (VOLUMES.tv_elite_banshee01) ], 1);
	ai_braindead (ai_current_actor, false);
	--cs_go_by (POINTS.ps_from_landingpad.p16, POINTS.ps_from_landingpad.p17, 0.9);
	
	--cs_go_to (POINTS.ps_banshees.p01a);
	--ai_exit_limbo (ai_current_actor);
	--ai_vehicle_enter (ai_current_actor, banshee1);
	
--	cs_go_to (POINTS.ps_from_landingpad.p16);
	cs_go_to_vehicle (banshee1);
	--ai_vehicle_enter (ai_current_actor, banshee1);
	print ("at banshee");
	--sleep_s (0.5);
	cs_fly_to (POINTS.ps_banshees.p2a);
	cs_fly_by (POINTS.ps_banshees.p2b);
	cs_fly_by (POINTS.ps_banshees.p2c);
	cs_fly_by (POINTS.ps_banshees.p2d);
	sleep_s (90);
end

function cs_elite_banshee_2()
	local banshee2 = OBJECTS.ve_banshee_2;
	--object_create_anew (banshee);
	object_wake_physics (banshee2);
	--ai_enter_limbo (ai_current_actor);
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_elite_banshee02) ], 1);
	ai_braindead (ai_current_actor, false);
	--ai_exit_limbo (ai_current_actor);
	--ai_vehicle_enter (ai_current_actor,banshee2);
	
--	SleepUntil ([| volume_test_players (VOLUMES.tv_elite_banshee) ], 15);
--	--cs_go_by (POINTS.ps_from_landingpad.p20, POINTS.ps_from_landingpad.p19, 0.9);
--	
--	cs_go_to (POINTS.ps_banshees.p01);
--	--cs_move_towards_point (POINTS.ps_banshees.p01, 2);
--	--cs_go_by (POINTS.ps_banshees.p01, POINTS.ps_banshees.p02);
--	--cs_go_to (POINTS.ps_banshees.p02);
	cs_go_to_vehicle (banshee2);
--	--ai_vehicle_enter (ai_current_actor, OBJECTS.ve_banshee_2);
--	
--	SleepUntil ([| ai_vehicle_get (ai_current_actor) ~= nil ], 15);
	print ("at banshee");
	--sleep_s (0.5);
	cs_fly_to (POINTS.ps_banshees.p1a);
	print ("at point 1");
	cs_fly_by (POINTS.ps_banshees.p1b);
	cs_fly_by (POINTS.ps_banshees.p1c);
	cs_fly_by (POINTS.ps_banshees.p1d);
	cs_fly_by (POINTS.ps_banshees.p1e);

	--cs_fly_to (POINTS.ps_banshee.p2a);
	sleep_s (30);
end

--closes the phantom_pad turret door -- currently a placement script in the phantom spawnpoint
function closephantomdoors()
	local null = ai_place_return (AI.sq_phantom_pad.sp_null_turret);
	local phantom = ai_vehicle_get_from_spawn_point (AI.sq_phantom_pad.sp_phantom);
	if phantom then
		vehicle_load_magic (phantom, "close_turret_doors", null);
	end
--	repeat
--		print ("flying1");
--		cs_fly_to (POINTS.ps_phantom_pad.p1, 0);
--		sleep_s (1);
--		cs_fly_to (POINTS.ps_phantom_pad.p2, 0);
--		sleep_s (1);
--		print ("flying2");
--	until false;
end

function cs_phantom_flying1()
	local null = AI.sq_phantom_flying1.sp_null_turret;
	local phantom = ai_vehicle_get_from_squad (ai_current_squad);
	if phantom then
		vehicle_load_magic (phantom, "close_turret_doors", null);
		vehicle_load_magic (phantom, "phantom_lc", OBJECTS.ve_wraith_01);
	end
	cs_fly_to_and_face (POINTS.ps_phantoms.p0, POINTS.ps_phantoms.p01);
	vehicle_hover (phantom, true);
	sleep_s (10);
	print ("i'm there");
end

function cs_phantom_flying2()
	local null = AI.sq_phantom_flying2.sp_null_turret;
	local phantom = ai_vehicle_get_from_squad (ai_current_squad);
	if phantom then
		vehicle_load_magic (phantom, "close_turret_doors", null);
		vehicle_load_magic (phantom, "phantom_lc", OBJECTS.ve_wraith_02);
	end
	cs_fly_to_and_face (POINTS.ps_phantoms.p02, POINTS.ps_phantoms.p03);
	vehicle_hover (phantom, true);
	print ("i'm there");
end

function cs_intro_phantom()
	local pilot = (ai_current_squad);
	local phantom = ai_vehicle_get_from_squad (pilot);
	if phantom then
		vehicle_load_magic (phantom, "close_turret_doors", AI.sq_intro_phantom.sp_null_turret);
	end
	
	cs_fly_to_and_dock (POINTS.ps_intro_phantom.p01, POINTS.ps_intro_phantom.p02);
--	SleepUntil ([| false ], seconds_to_frames(3));
	
	sleep_s (3);
	cs_fly_by (POINTS.ps_intro_phantom.p02);
	cs_fly_to (POINTS.ps_intro_phantom.p03);
	cs_fly_to (POINTS.ps_intro_phantom.p04);
--	
--	object_set_scale(phantom, 0.01, seconds_to_frames(3));
--	sleep_s (3);
	ai_erase(ai_current_squad);
end

function cs_constructor_start()
	--cs_throttle_set (true, 0.3);
	sleep_s (7);
	cs_fly_to (POINTS.ps_constructor.p_receptacle);
--	repeat
--		cs_throttle_set (false, 0.1);
--		sleep_s (1);
--	until false
end

function cs_contructor_end()
	cs_fly_to (POINTS.ps_constructor.p_receptacle_end);
	sleep_s (10);
end

-- ===================================
-- COMPATIBILITY SCRIPTS
-- ===================================

function W2HubHalseyAfterVO()
	print ("compatibilty with campsite");
	
end

--## CLIENT
function remoteClient.PrintMeClient()
	print ("print me on client");
	print ("switching the zoneset");
end