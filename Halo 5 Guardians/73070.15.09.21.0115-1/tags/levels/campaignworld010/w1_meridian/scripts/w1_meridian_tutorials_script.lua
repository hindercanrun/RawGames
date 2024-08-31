--## SERVER
global n_tutorialpoint: number = 0;


-- Meridian Tutorials Script

function meridian_tutorials_start():void
	TutorialShowAllIfNotPerformed("training_ping_sub", TUTORIAL.Tracking, 15);
	for _,playa in ipairs (players()) do
		CreateThread(f_tut_groundpound, playa);
		--CreateThread(f_tut_tracking_outpost, playa)
	end
	CreateThread (meridian_tutorials_10);
	CreateThread (meridian_tutorials_20);
	CreateThread (meridian_tutorials_20_b);
end

--function f_tut_tracking_outpost(liveplayer:player):void
--	TutorialShowStartDelayed(liveplayer, "training_ping_sub", "training_meridian_tracking_01", 10, 10);
--	RegisterSpartanTrackingPingObjectEvent(f_mer_outpost_tracking_tutorial_stop, OBJECTS.dm_exit_door_1);
--end
--
--function f_mer_outpost_tracking_tutorial_stop(tracking_player:player):void
--	TutorialStopAndMark(tracking_player, "training_meridian_tracking_01");
--end

function meridian_tutorials_10():void
	SleepUntil([|n_tutorialpoint == 10], 1);
	CreateThread(f_tut_orderattack);
end

function meridian_tutorials_20():void
	SleepUntil ([|	n_tutorialpoint == 20], 1);
	--for _,playa in ipairs (players()) do
		--CreateThread (f_tut_entervehicle, playa);
	--end
	CreateThread (f_tut_entervehicle);
end

function meridian_tutorials_20_b():void	
	SleepUntil ([|	n_tutorialpoint == 20], 1);
	for _,playa in ipairs (players()) do
		CreateThread (f_tut_drive, playa);
	end
end


-------------------------------------------------------------------------------------------------

function f_tut_groundpound(liveplayer:player):void
	SleepUntil ([| volume_test_object (VOLUMES.tv_tut_groundpound, player_get_unit (liveplayer))], 1);
	if (object_get_health (OBJECTS.groundpound_outpostvent) > 0.0)	then
		TutorialShowIfNotPerformed(unit_get_player(liveplayer), "training_groundpound", TUTORIAL.GroundPound, 10);
	end
end

function f_tut_orderattack():void
	sleep_s (7.5);
	TutorialShowIfNotPerformed(unit_get_player(SPARTANS.locke), "training_orders_target", TUTORIAL.OrdersEnemy, 10);
end

function f_tut_entervehicle(liveplayer:player):void
	SleepUntil([|volume_test_players (VOLUMES.tv_tut_entervehicle)], 1);
	--SleepUntil([|volume_test_object(VOLUMES.tv_tut_entervehicle, player_get_unit (liveplayer))], 1);
	TutorialShowIfNotPerformed(unit_get_player(SPARTANS.locke), "training_orders_use", TUTORIAL.OrdersVehicle, 10);
end

function f_tut_drive (liveplayer:player):void
	print ("Drive Tutorial loaded");
	local v_completed_all_vehicle_tutorials: boolean = false;
	local v_completed_driving_tutorial: boolean = false;
	local v_completed_switching_tutorial: boolean = false;
	local v_completed_brake_tutorial: boolean = false;
	local v_completed_shooting_tutorial: boolean = false;
	local obj_playervehicle: object = nil;
		print ("Waiting for player to enter a vehicle.");
	repeat
		SleepUntil ([|	unit_in_vehicle (player_get_unit (liveplayer)) == true], 1);
--////	Checking to see if player is in a ground vehicle	////--
		obj_playervehicle = unit_get_vehicle (player_get_unit (liveplayer));
		if	(unit_in_vehicle_type (player_get_unit (liveplayer), 17)) or (unit_in_vehicle_type (player_get_unit (liveplayer), 18)) or (unit_in_vehicle_type (player_get_unit (liveplayer), 19))	then
			--print ("Player is in a ground vehicle! Determining which tutorial to play");
--////	How to Drive Forward.	////--
			if game_difficulty_get() == DIFFICULTY.easy or game_difficulty_get() == DIFFICULTY.normal then
				if v_completed_driving_tutorial == false then
					if	(unit_in_vehicle_type(player_get_unit(liveplayer), 17)) or (unit_in_vehicle_type (player_get_unit (liveplayer), 18)) or (unit_in_vehicle_type (player_get_unit (liveplayer), 19)) then
						if vehicle_test_seat_unit (obj_playervehicle, "warthog_d", player_get_unit (liveplayer)) or vehicle_test_seat_unit (obj_playervehicle, "scorpion_d", player_get_unit (liveplayer)) or vehicle_test_seat_unit (obj_playervehicle, "mongoose_d", player_get_unit (liveplayer)) then
							print(" player is in driver seat 1");
							TutorialShowIfNotPerformed(unit_get_player(liveplayer), "training_groundvehicle_drive", TUTORIAL.JeepDrive, 10);
							print(" player is in driver seat 2");
							v_completed_driving_tutorial = true;
							sleep_s(10);
							TutorialStopAll();
							sleep_s(1);
						end
					end
				end
			end
			
			
--////	How to Switch Seats.	////--
			if v_completed_switching_tutorial == false then
				if (unit_in_vehicle_type (player_get_unit (liveplayer), 17))	or (unit_in_vehicle_type (player_get_unit (liveplayer), 18))	or (unit_in_vehicle_type (player_get_unit (liveplayer), 19))	then
					print("switching seats 1");
					TutorialShowIfNotPerformed(unit_get_player(liveplayer), "training_groundvehicle_switch", TUTORIAL.SeatSwitch, 10);
					print("switching seats 2");
					v_completed_switching_tutorial = true;
					sleep_s(10);
					TutorialStopAll();
					sleep_s(1);
				end
			end
			
			
--////	How to Use Hand Brakes.	////--
			if game_difficulty_get() == DIFFICULTY.easy or game_difficulty_get() == DIFFICULTY.normal then
				if v_completed_brake_tutorial == false then
					if	(unit_in_vehicle_type (player_get_unit (liveplayer), 17)) or (unit_in_vehicle_type (player_get_unit (liveplayer), 18)) or (unit_in_vehicle_type (player_get_unit (liveplayer), 19)) then
						if vehicle_test_seat_unit (obj_playervehicle, "warthog_d", player_get_unit (liveplayer)) or vehicle_test_seat_unit (obj_playervehicle, "mongoose_d", player_get_unit (liveplayer)) then
							print("hand brake 1");
							TutorialShowIfNotPerformed(unit_get_player(liveplayer), "training_groundvehicle_brake", TUTORIAL.JeepHandbrake, 10);
							print("hand brake 2");
							v_completed_brake_tutorial = true;
							sleep_s(10);
							TutorialStopAll();
							sleep_s(1);
						end
					end
				end
			end
			
--////	How to Use Vehicle Weapon.	////--
			if v_completed_shooting_tutorial == false then
			--print("_____________ v_completed_shooting_tutorial == false ");
				if	vehicle_test_seat_unit (obj_playervehicle, "warthog_g", player_get_unit (liveplayer))	or vehicle_test_seat_unit (obj_playervehicle, "mongoose_d", player_get_unit (liveplayer)) or vehicle_test_seat_unit (obj_playervehicle, "scorpion_d", player_get_unit (liveplayer)) then
					print("SHOOT 'ER!!!");
					TutorialShowIfNotPerformed(unit_get_player(liveplayer), "training_groundvehicle_shoot", TUTORIAL.JeepShoot, 15);
					print("Clever girl...");
					v_completed_shooting_tutorial = true;
					sleep_s(10);
					TutorialStopAll();
					sleep_s(1);
				end
			end
			
			if game_difficulty_get() == DIFFICULTY.easy or game_difficulty_get() == DIFFICULTY.normal then
				if	v_completed_driving_tutorial == true and v_completed_switching_tutorial == true and	v_completed_brake_tutorial == true and v_completed_shooting_tutorial == true then
					v_completed_all_vehicle_tutorials = true;
					print ("Vehicle Tutorials are complete!");
				end
			end
			
			if game_difficulty_get() == DIFFICULTY.heroic or game_difficulty_get() == DIFFICULTY.legendary then
				if	v_completed_switching_tutorial == true and v_completed_shooting_tutorial == true then
					v_completed_all_vehicle_tutorials = true;
					print ("Vehicle Tutorials are complete!");
				end
			end
			
		end
	until (v_completed_all_vehicle_tutorials == true);
end


function vehicletut_test()
	local obj_playervehicle: object = nil;
	SleepUntil ([|	unit_in_vehicle (player_get_unit (PLAYERS.player0)) == true], 1);
	obj_playervehicle = unit_get_vehicle (player_get_unit (PLAYERS.player0));
	SleepUntil ([|	vehicle_test_seat_unit (object_get_turret (obj_playervehicle, 0), "warthog_g", player_get_unit (PLAYERS.player0))], 1);
	print ("Player is in a weaponized ground vehicle!");
	TutorialShowAll ("training_groundvehicle_shoot");
	print ("Vehicle Shooting Tutorial shown");
	sleep_s (3);
	TutorialStopAll ();
	print ("Vehicle Shooting Tutorial stopped");
end
--                   o( @ ¸ @ )o 

-- 											                       -fin.