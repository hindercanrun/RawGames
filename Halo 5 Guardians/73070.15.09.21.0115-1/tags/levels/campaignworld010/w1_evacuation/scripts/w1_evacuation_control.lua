--## SERVER

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ EVACUATION_SPACE_ELEVATOR *_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*

global startLooming:boolean = false;

global missionEvacuation:table=
	{
		name = "w1_evacuation",
	
		--description = "Evacuation space elevator: With Meridian falling to enemy forces, all seems lost - especially when the Titan begins to rise",
		--breadCrumbs = {FLAGS.fl_breadcrumb_1, FLAGS.fl_breadcrumb_2,FLAGS.fl_breadcrumb_3,FLAGS.fl_breadcrumb_4,FLAGS.fl_breadcrumb_5,},
		profiles = {STARTING_PROFILES.locke_start, STARTING_PROFILES.vale_start, STARTING_PROFILES.tanaka_start, STARTING_PROFILES.buck_start},
		points = POINTS.ps_evacuation_start,
		startGoals = {"goal_WarthogDrive"},
		collectibles = {
										{objectName = "collectible_01", collectibleName = "collectible_01"},
										{objectName = "collectible_02", collectibleName = "collectible_02"},
										{objectName = "collectible_04", collectibleName = "collectible_04"},
										{objectName = "collectible_05", collectibleName = "collectible_05"},
										{objectName = "collectible_06", collectibleName = "collectible_06"},
										{objectName = "collectible_07", collectibleName = "collectible_07"},
										{objectName = "skull_thunderstorm", collectibleName = "collectible_skull_thunderstorm"},
									 },
	}




function startup.check_editor()
	KillVolumesDisable();
	if not editor_mode() then
		--fade_out (255,255,255,0);
		StartEvacuation();
	else
		print ("in editor");
	end
	
end

function StartEvacuation()
	StartMission(missionEvacuation);
	
end

function missionEvacuation.Start()
	CreateThread(f_halokart);
	print ("starting Evacuation space elevator");
end

function remoteServer.FlipLoomBoolean()
	startLooming = true;
end

function prepareCinemaLoom()
	SleepUntil([| startLooming == true], 1);
	LoomNextCampaignMission();
end

function missionEvacuation.End()
	print ("end of evacutation, loading w3_builder");
	--local sec:number = 0.1;
	--fade_out (0,0,0, seconds_to_frames (sec));
	--sleep_s (sec);
	--CinematicPlay ("cin_105_evacend");
	composer_stop_all();
	DestroyObjectsForCinema();
	Sleep (2);
	--check the achievement
	f_achievement_speed_run();
	b_cinematic_evac_start = true;
	CreateThread(prepareCinemaLoom);
	CinematicPlay ("cin_105_evacend", true);
	sys_LoadCin_110();
	
end


--------------------------------Helper functions

function KillVolumesDisable()
	kill_volume_disable (VOLUMES.kill_exterior_door);
	kill_volume_disable (VOLUMES.kill_interior_door);
	kill_volume_disable (VOLUMES.kill_elevator_gate);
end

--Blips AI with the enemy tag (when tracked)
function BlipAI (group:ai, num:number)
	print ("This is where we would Blip Spawning group ", group);
--	num = num or 3;
--	
--	SleepUntil([|ai_living_count(group) <= num], 3);
--	print ("Tracking: Enemy Blip enabled");
--	local squad_list = GetTableFromSquad(group);
--	for _, actor in pairs (squad_list) do
--		print ("set tracking event on ", actor);
--		ObjectSetSpartanTrackingEnabled(actor, true);
--		RegisterSpartanTrackingPingObjectEvent(TrackingShowEnemyNavmarker, actor);
--	end
	
	--NavpointShowAllServer (group, "enemy");
end

--function TrackingShowEnemyNavmarker (player:object, actor:object)
--	print ("BLIPPING ENEMY");
--	print(actor, " was pinged by ", player);
--	navpoint_track_object_named (actor, "enemy");
--end

global obj_list = nil;
--delete all objects in the volume
--the variable is global because of debugging
--we iterate 4 times because of 128 item limit and not always deleting every object
function DeleteObjectsOutsideBSPS(vol:volume)
	for i=1,4 do
		obj_list = volume_return_objects (vol);
		table.dprint (obj_list);
		Sleep (1);
		object_destroy_list (obj_list);
		print (#obj_list);
	end
end

--delete vehicles that aren't in a BSP
function DeleteObjectsNotInBSP(folder)
	-- this is the only way to get the list of objects and is pretty hacky
	local obj_list = object_create_folder (folder);
	for _,obj in pairs (obj_list) do
		print (obj);
		if object_get_bsp(obj) == -1 then
			print (obj);
			object_destroy (obj);
		end
	end
end

--------------------------------achievements and easter eggs
global progress:number = 0;


--gmu 7/31/2015 -- fixing this up so it rewards correctly and not requiring coop
function f_halokart()
	if GetTotalPlayerCount() == 4 then
		sleep_s(117);
		--print("testing function");
		if volume_test_players_all(VOLUMES.tv_racetime) then
			print("STARTING HALOKART");
			HaloKartCountdown();
			HaloKartWinnerAward();
		end
	end
end

function HaloKartCountdown()
	object_create_folder("racing");
	Sleep(5);
	unit_enter_vehicle_immediate(SPARTANS.locke, OBJECTS.racing01, "mongoose_d");
	unit_enter_vehicle_immediate(SPARTANS.vale, OBJECTS.racing02, "mongoose_d");
	unit_enter_vehicle_immediate(SPARTANS.tanaka, OBJECTS.racing03, "mongoose_d");
	unit_enter_vehicle_immediate(SPARTANS.buck, OBJECTS.racing04, "mongoose_d");
	player_control_fade_out_all_input (0); 	 
	--OSR- 142306 --fixing halokart countdown counting down too fast
	sleep_s(2);
	ObjectiveShow(TITLES.countdown_3);
	sleep_s(2);
	ObjectiveShow(TITLES.countdown_2);
	sleep_s(2);
	ObjectiveShow(TITLES.countdown_1);
	sleep_s(2);
	ObjectiveShow(TITLES.race);
	player_control_fade_in_all_input(0);
	print ("HALOKART GOOOOOO!!");
end

function HaloKartWinnerAward()

	--SleepUntil([|volume_return_players(VOLUMES.tv_finish)[1]], 1);
	local winner = nil;
	while winner == nil do
		winner = HaloKartCheckWinner();
		Sleep (2);
	end
	--winner = {vehicles.winner};
	print("HaloKart winner is ",winner);
	
	object_create_anew ("rocket_winner");
	unit_add_weapon(winner, OBJECTS.rocket_winner, 4);
	Sleep (1);
	object_create_anew ("mlrs_winner");
	unit_add_weapon(winner, OBJECTS.mlrs_winner, 6);
end

function HaloKartCheckWinner():object
	local vehicle = nil;
	for key,player in pairs (players()) do
		vehicle = unit_get_vehicle (player);
		--if the player is in a vehicle then test if it's in the finish volume, unload them
		if vehicle ~= nil then
			if volume_test_object (VOLUMES.tv_finish, vehicle) then
				vehicle_unload (vehicle, "");
				SleepUntil ([| unit_get_vehicle(player) == nil ], 1);
				return player;
			end
		elseif volume_test_objects(VOLUMES.tv_finish, player) then
			return player;
		end
	end
end

function test_swap()
	print (unit_add_weapon(PLAYERS.player0, OBJECTS.rocket_winner01, 6));
end


--ACHIEVEMENT SPEED RUN
function f_achievement_speed_run()
	if (game_difficulty_get_real() == DIFFICULTY.heroic or game_difficulty_get_real() == DIFFICULTY.legendary) then
		if campaign_metagame_get_time_seconds() <= (18 * 60 + 2) then
			print ("FIRE DRILL ACHIEVEMENT UNLOCKED");
			-- unlock achievement here.
			CampaignScriptedAchievementUnlocked(10);
		end
	end
end



--SKULLS
--gmu -- osr-142405 -- made the skulls based on a death event
function SkullTrackDestroyed()
	local step_list = object_create_folder_anew (MODULES.mod_skull_steps);
	for _,step in pairs (step_list) do
		RegisterDeathEvent (f_unlock_progress, step);
	end
end

--this is the death event for the skulls
function f_unlock_progress(object:object, interactor:object)
	print ("skull cone destroyed");
	if progress < 5 then
		progress = progress + 1;
		print(progress);
		SoundImpulseStartServer(TAG('sound\002_ui\002_ui_hud\002_ui_hud_skulls_gruntbirthday.sound'), object);
	else
		return;
	end
end

function f_timer()
	SkullTrackDestroyed();
	local time:number = 117;

	repeat
		sleep_s(1);
		time = time - 1;
		print (time);
	until time == 0;

	f_accomplished();
end


function f_accomplished()
	if object_get_health(OBJECTS.step_05) > 0 then
		object_hide(OBJECTS.step_05, true);
		object_cannot_die(OBJECTS.step_05, true);
	end
	
	if progress == 5 then
		unlocked = true;
		print ("skull should now be created at the end of the level");
	end
end

