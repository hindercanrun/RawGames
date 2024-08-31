--## SERVER

global b_elite_stairs:boolean = false;
global b_elite_pointing:boolean = false;
global b_arb_melee:boolean = false;
global b_takedown_01:boolean = false;
global b_takedown_02:boolean = false;
global b_takedown_03:boolean = false;


--[[
   ______           __  __             _    ___                  __  __               _____           _       __ 
  / ____/________  / /_/ /_____  _    | |  / (_)___ _____  ___  / /_/ /____  _____   / ___/__________(_)___  / /_
 / / __/ ___/ __ \/ __/ __/ __ \(_)   | | / / / __ `/ __ \/ _ \/ __/ __/ _ \/ ___/   \__ \/ ___/ ___/ / __ \/ __/
/ /_/ / /  / /_/ / /_/ /_/ /_/ /      | |/ / / /_/ / / / /  __/ /_/ /_/  __(__  )   ___/ / /__/ /  / / /_/ / /_  
\____/_/   \____/\__/\__/\____(_)     |___/_/\__, /_/ /_/\___/\__/\__/\___/____/   /____/\___/_/  /_/ .___/\__/  
                                            /____/                                                 /_/           
--]]


--[[
 _    ___                  __  __          _____           _       __      
| |  / (_)___ _____  ___  / /_/ /____     / ___/__________(_)___  / /______
| | / / / __ `/ __ \/ _ \/ __/ __/ _ \    \__ \/ ___/ ___/ / __ \/ __/ ___/
| |/ / / /_/ / / / /  __/ /_/ /_/  __/   ___/ / /__/ /  / / /_/ / /_(__  ) 
|___/_/\__, /_/ /_/\___/\__/\__/\___/   /____/\___/_/  /_/ .___/\__/____/  
      /____/                                            /_/                

--]] 

function landing_vin_start ():void
	print("BEGIN LANDING VIGNETTES");
	composer_play_show("vin_ics_intro");
end

function armory_door_01a ():void
		n_comp_armory_door_01a = composer_play_show("vin_elite_armory_door_01a");
		print("OPEN DOOR 01");
		sleep_s(2);
		b_grotto_armory_door01_open = true;
		ai_cannot_die(AI.sq_armory_arby_01, true);
end

function armory_door_01b ():void
		PlayAnimation (OBJECTS.armory_door_01, 1, "any:close"); 		--close the armory door
		print("CLOSE DOOR 01");
end

function armory_door_02a ():void
		n_comp_armory_door_02a = composer_play_show("vin_elite_armory_door_02a");
		print("OPEN DOOR 02");
		sleep_s(2);
		b_grotto_armory_door02_open = true;
		ai_cannot_die(AI.sq_armory_arby_02, true);
end

function armory_door_02b ():void
		PlayAnimation (OBJECTS.dm_courtyard_door_01, 1, "any:close"); 		--close the airlock door
		print("CLOSE DOOR 02");
end

function hq_vin_ambient ():void
		SleepUntil ([| volume_test_players (VOLUMES.tv_hq_ambient_comp)], 1);			
				print("play hq ambient vignettes");			
				b_elite_stairs = true;
				b_elite_pointing = true;	
end

function hq_vin_takedown ():void
		SleepUntil ([| 	(volume_test_players (VOLUMES.tv_hq_vehicle_check) and unit_in_vehicle(PLAYERS.player0) or volume_test_players (VOLUMES.tv_hq_takedown_comp)) or						--check to see if player is in vehcile, need to play vignette earlier if in vehicle for timing purposes
									 	(volume_test_players (VOLUMES.tv_hq_vehicle_check) and unit_in_vehicle(PLAYERS.player1) or volume_test_players (VOLUMES.tv_hq_takedown_comp)) or
										(volume_test_players (VOLUMES.tv_hq_vehicle_check) and unit_in_vehicle(PLAYERS.player2) or volume_test_players (VOLUMES.tv_hq_takedown_comp)) or
										(volume_test_players (VOLUMES.tv_hq_vehicle_check) and unit_in_vehicle(PLAYERS.player3) or volume_test_players (VOLUMES.tv_hq_takedown_comp)) ], 1);
		
											print("play hq takedown vignettes");							
											b_takedown_01 = true;
											b_takedown_02 = true;				
		SleepUntil ([| volume_test_players (VOLUMES.tv_hq_arbiter_comp) ], 1);	
											b_arb_melee = true;
											
											sleep_s(1);				
											composer_play_show("vin_grotto_phantom_outro");
											object_cannot_take_damage(OBJECTS.vin_phantom_scenery);
end


--[[
    ________           __       
   / ____/ /___  _____/ /_______
  / /_  / / __ \/ ___/ //_/ ___/
 / __/ / / /_/ / /__/ ,< (__  ) 
/_/   /_/\____/\___/_/|_/____/  
                                
--]]                                
            
--landing bugs                             
function landing_flock_spawn_client():void
		flock_create("flock_landing_beetles_01");
		flock_create("flock_landing_beetles_02");
		flock_create("flock_landing_beetles_03");
		flock_create("flock_landing_beetles_04");
		flock_create("flock_landing_beetles_05");
		flock_create("flock_landing_beetles_06");
		sleep_s(0.1);
		flock_start("flock_landing_beetles_01");
		flock_start("flock_landing_beetles_02");
		flock_start("flock_landing_beetles_03");
		flock_start("flock_landing_beetles_04");
		flock_start("flock_landing_beetles_05");
		flock_start("flock_landing_beetles_06");
		sleep_s(3);														
		flock_stop("flock_landing_beetles_01");
		flock_stop("flock_landing_beetles_02");
		flock_stop("flock_landing_beetles_03");
		flock_stop("flock_landing_beetles_04");
		flock_stop("flock_landing_beetles_05");
		flock_stop("flock_landing_beetles_06");

			print("start landing flocks-bugs");
end

function landing_flock_despawn_client():void
		flock_delete("flock_landing_beetles_01");
		flock_delete("flock_landing_beetles_02");	
		flock_delete("flock_landing_beetles_03");
		flock_delete("flock_landing_beetles_04");
		flock_delete("flock_landing_beetles_05");
		flock_delete("flock_landing_beetles_06");
	
			print("delete landing flocks");
end

--landing birds (by Tsunami)
function landing_flock_birds_01_spawn_client():void
		flock_create("flock_landing_birds_04");
		sleep_s(0.1);
		flock_start("flock_landing_birds_04");
			print("start landing flocks-birds");
end

function landing_flock_birds_01_stop_client():void
		flock_stop("flock_landing_birds_04");
			print("stop landing flocks-birds");
end

function landing_flock_birds_01_despawn_client():void
		flock_delete("flock_landing_birds_04");	
			print("delete landing flocks-birds");
end

--landing birds (at turn)
function landing_flock_birds_02_spawn_client():void
		flock_create("flock_landing_birds_05");
		flock_create("flock_landing_birds_06");
		sleep_s(0.1);
		flock_start("flock_landing_birds_05");
		sleep_s(2)
		flock_start("flock_landing_birds_06");
		sleep_s(7);
		flock_stop("flock_landing_birds_05");
		flock_stop("flock_landing_birds_06");
		sleep_s(20);
		flock_delete("flock_landing_birds_05");
		flock_delete("flock_landing_birds_06");	
			print("start landing flocks-birds turn");
end


--Scared phantom birds
function landing_phantom_flock_01_client():void	
	SleepUntil([| volume_test_object(VOLUMES.tv_landing_phantom_fx_01, AI.sq_landing_dropship) ], 1);
		flock_create("flock_landing_birds_01");
		sleep_s(0.1);
		flock_start("flock_landing_birds_01");
		sleep_s(3);														
		flock_stop("flock_landing_birds_01");
		sleep_s(3);														
		flock_delete("flock_landing_birds_01");
end

function landing_phantom_flock_02_client():void	
	SleepUntil([| volume_test_object(VOLUMES.tv_landing_phantom_fx_02, AI.sq_landing_dropship) ], 1);
		flock_create("flock_landing_birds_02");
		sleep_s(0.1);
		flock_start("flock_landing_birds_02");
		sleep_s(3);														
		flock_stop("flock_landing_birds_02");
		sleep_s(3);														
		flock_delete("flock_landing_birds_02");
end

function landing_phantom_flock_03_client():void	
	SleepUntil([| volume_test_object(VOLUMES.tv_landing_phantom_fx_04, AI.sq_landing_dropship) ], 1);
		flock_create("flock_landing_birds_03");
		sleep_s(0.1);
		flock_start("flock_landing_birds_03");
		sleep_s(3);														
		flock_stop("flock_landing_birds_03");
		sleep_s(3);														
		flock_delete("flock_landing_birds_03");
end

--falls bugs
function falls_flock_spawn_client():void
		flock_create("flock_falls_beetles_01");
		flock_create("flock_falls_beetles_02");
		flock_create("flock_falls_beetles_03");
		flock_create("flock_falls_beetles_04");
		flock_create("flock_falls_beetles_05");
		sleep_s(0.1);
		flock_start("flock_falls_beetles_01");
		flock_start("flock_falls_beetles_02");
		flock_start("flock_falls_beetles_03");
		flock_start("flock_falls_beetles_04");
		flock_start("flock_falls_beetles_05");
		sleep_s(3);
		flock_stop("flock_falls_beetles_01");
		flock_stop("flock_falls_beetles_02");
		flock_stop("flock_falls_beetles_03");
		flock_stop("flock_falls_beetles_04");
		flock_stop("flock_falls_beetles_05");
			print("start falls flocks");
end

function falls_flock_despawn_client():void
	flock_delete("aiflock_beetles01");
	flock_delete("aiflock_beetles02");
	flock_delete("aiflock_beetles03");
	flock_delete("aiflock_beetles06");
	flock_delete("aiflock_birds01");
	flock_delete("aiflock_birds02");

	print("delete falls flocks");

end

--scared bird for falls drop ship 01
function falls_dropship_01_flock_client():void	
	SleepUntil([| volume_test_object(VOLUMES.tv_falls_dropship_birds_01, AI.sq_falls_dropship_01) ], 1);
		flock_create("flock_falls_birds_01");
		sleep_s(0.1);
		flock_start("flock_falls_birds_01");
		sleep_s(5);
		flock_stop("flock_falls_birds_01");
		sleep_s(7);
		flock_delete("flock_falls_birds_01");
end

--scared bird for falls rear exit
function falls_exit_flock_client():void	
		flock_create("flock_falls_birds_02");
		sleep_s(0.1);
		flock_start("flock_falls_birds_02");
		sleep_s(5);
		flock_stop("flock_falls_birds_02");
		sleep_s(30);
		flock_delete("flock_falls_birds_02");
end

--sinkhole bugs
function sinkhole_flock_spawn_client():void
	flock_create("flock_sinkhole_beetles_01");
	flock_create("flock_sinkhole_beetles_02");
	flock_create("flock_sinkhole_beetles_03");	
	sleep_s(0.1);	
	flock_start("flock_sinkhole_beetles_01");
	flock_start("flock_sinkhole_beetles_02");
	flock_start("flock_sinkhole_beetles_03");	
	sleep_s(3);														--Stop certain spawners so they dont regen on scatter AR
	flock_stop("flock_sinkhole_beetles_01");
	flock_stop("flock_sinkhole_beetles_02");
	flock_stop("flock_sinkhole_beetles_03");
	print("start sinkhole flocks");

end

function sinkhole_flock_despawn_client():void
	flock_delete("flock_sinkhole_beetles_01");
	flock_delete("flock_sinkhole_beetles_02");
	flock_delete("flock_sinkhole_beetles_03");

	print("delete sinkhole flocks");

end

--dead body room birds
function body_room_birds_spawn_client():void
	SleepUntil([| volume_test_players(VOLUMES.tv_body_room_birds_01) ], 1);
		flock_create("flock_sinkhole_birds_01");
		sleep_s(0.1);
		flock_start("flock_sinkhole_birds_01");
		sleep_s(5);
		flock_stop("flock_sinkhole_birds_01");
		sleep_s(30);
		flock_delete("flock_sinkhole_birds_01");
end

--scared bird for sinkhole drop ship
function sinkhole_dropship_01_flock_client():void	
		flock_create("flock_sinkhole_birds_02");
		sleep_s(0.1);
		flock_start("flock_sinkhole_birds_02");
		sleep_s(3);
		flock_stop("flock_sinkhole_birds_02");
		sleep_s(7);
		flock_delete("flock_sinkhole_birds_02");
end

--scared bird for sinkhole exit
function sinkhole_exit_flock_client():void	
		flock_create("flock_sinkhole_birds_03");
		sleep_s(0.1);
		flock_start("flock_sinkhole_birds_03");
		sleep_s(7);
		flock_stop("flock_sinkhole_birds_03");
		sleep_s(30);
		flock_delete("flock_sinkhole_birds_03");
end


--keyhole fleet scared birds 
function passage_scared_birds_spawn_client():void
		flock_create("flock_keyhole_birds_01");
		flock_create("flock_keyhole_birds_02");
		flock_create("flock_keyhole_birds_03");
		
		sleep_s(1);
		
		flock_start("flock_keyhole_birds_01");
		flock_start("flock_keyhole_birds_02");
		flock_start("flock_keyhole_birds_03");
	
		sleep_s(4);
	
		flock_stop("flock_keyhole_birds_01");
		flock_stop("flock_keyhole_birds_02");
		flock_stop("flock_keyhole_birds_03");
	
		sleep_s(6);
	
		flock_delete("flock_keyhole_birds_01");
		flock_delete("flock_keyhole_birds_02");
		flock_delete("flock_keyhole_birds_03");
end

--keyhole beetles
function passage_flock_spawn_client():void
		flock_create("flock_keyhole_beetles_01");
		flock_create("flock_keyhole_beetles_02");
		flock_create("flock_keyhole_beetles_03");
		
		sleep_s(1);
		
		flock_start("flock_keyhole_beetles_01");
		flock_start("flock_keyhole_beetles_02");
		flock_start("flock_keyhole_beetles_03");
		
		sleep_s(3);
		
		flock_stop("flock_keyhole_beetles_01");
		flock_stop("flock_keyhole_beetles_02");
		flock_stop("flock_keyhole_beetles_03");
		
		print("start passage flocks");
end

function passage_flock_despawn_client():void
		flock_delete("flock_keyhole_beetles_01");
		flock_delete("flock_keyhole_beetles_02");
	
		print("delete passage flocks");
end

--keyhole theatre of war bashee dogfighting
function keyhole_flock_spawn_client():void
		flock_create("flock_keyhole_banshee_01");
		flock_create("flock_keyhole_banshee_02");
	
		sleep_s(4);
	
		flock_start("flock_keyhole_banshee_01");
		flock_start("flock_keyhole_banshee_02");
		
		print("start keyhole flocks");
end

function keyhole_flock_despawn_client():void
		flock_delete("flock_keyhole_banshee_01");
		flock_delete("flock_keyhole_banshee_02");
	
		print("delete keyhole flocks");
end

--keyhole theatre of war phantoms (ones flying towards HQ)
function keyhole_flock_phantom_spawn_client():void
	flock_create("flock_keyhole_phantom_01");
	flock_create("flock_keyhole_phantom_02");
	
	sleep_s(1);
	
	flock_start("flock_keyhole_phantom_01");
	flock_start("flock_keyhole_phantom_02");
	
	print("start keyhole phantom ToW flocks");
end

function keyhole_flock_phantom_despawn_client():void
	flock_delete("flock_keyhole_phantom_01");
	flock_delete("flock_keyhole_phantom_02");

	print("delete keyhole flocks");
end

--keyhole theatre of war phantoms (parallax ones next to Tsunami)
function keyhole_flock_phantom_intro_spawn_client():void
	flock_create("flock_keyhole_phantom_03");
	flock_create("flock_keyhole_phantom_04");
	
	sleep_s(1);
	
	flock_start("flock_keyhole_phantom_03");
	flock_start("flock_keyhole_phantom_04");
	
	sleep_s(3);
	
	flock_stop("flock_keyhole_phantom_03");
	flock_stop("flock_keyhole_phantom_04");
	
	print("start phantom intro flocks");
end

function keyhole_flock_phantom_intro_despawn_client():void
	flock_delete("flock_keyhole_phantom_03");
	flock_delete("flock_keyhole_phantom_04");

	print("delete keyhole phantom intro flocks");
end

--Courtyard theatre of war bashee dogfighting
function hq_flock_spawn_client():void
	flock_create("flock_hq_banshee_01");
	flock_create("flock_hq_banshee_02");

	sleep_s(1);
	
	flock_start("flock_hq_banshee_01");
	flock_start("flock_hq_banshee_02");
	print("start hq flocks");
end

function hq_flock_despawn_client():void
	flock_stop("flock_hq_banshee_01");
	flock_stop("flock_hq_banshee_02");

	sleep_s(1);
	
	flock_delete("flock_hq_banshee_01");
	flock_delete("flock_hq_banshee_02");
	print("delete hq flocks");
end

-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- ONLY CLIENT/SERVER CODE BEYOND THIS POINT, thanks in advance.
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

--## CLIENT

