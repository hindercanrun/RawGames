--## SERVER

-- ///==========// Plateau Sentry Ship, nee Kraken //======////


global b_engine_breach:boolean = false;
global b_ship_start_listing:boolean = false;
global b_deathstroke:boolean = false
global b_ship_destroyed:boolean = false;
global b_ss_goal_complete:boolean = false
global var_warning_shot_target:object = nil;
global var_warning_shot_flag:flag = nil;
global var_deck_shuffle:number = 0;
global var_boss_objcon: number = 0;
global b_ss_spawn_hack: boolean = false;								-- search on


global b_tramp_10:boolean = false;										-- ramp warning shots
global b_tramp_20:boolean = false;										-- ramp warning shots
global b_tramp_30:boolean = false;										-- ramp warning shots
global b_tramp_40:boolean = false;										-- ramp warning shots
global b_tramp_50:boolean = false;										-- ramp warning shots
global b_tramp_60:boolean = false;										-- ramp warning shots

global b_shouldOptimizeKraken:boolean = false;

function sentry_destruction_listener():void											-- boss encounter control function
	print ("begin sentry encounter");
	f_core_destroy_listener();													-- wait til core destroyed
	kraken_destruction_sequence()												-- destroy ship
end

--/////////////////////////////////////////////////////////////--
--FUNCTIONS!!
--/////////////////////////////////////////////////////////////--

function f_sentry_stasis():void											-- called from composition, when ship reaches resting state
	print("---== stasis ==---");
	print("---== stasis ==---");
	print("---== stasis ==---");
	print("---== stasis ==---");
	print("---== stasis ==---");
	kill_volume_enable(VOLUMES.kill_core_room);
	kill_volume_disable(VOLUMES.kill_back_left_claw);
	kill_volume_disable(VOLUMES.kill_front_claw);
	kill_volume_disable(VOLUMES.kill_back_right_claw);
	CreateThread(left_hangar_gunner_ejection_listener);
	CreateThread(right_hangar_gunner_ejection_listener);
	CreateThread(rescuebox);
	CreateThread(start_boss_fight_v2);
	CreateThread(sentry_deck_shuffle);
	CreateThread(beach_head);
	CreateThread(hangar_door_listener);
--	CreateThread(f_sentry_spawn);										-- replaced by f_sentry_spawn_hack
	Sleep(2);
--	RunClientScript("fx_initiate_lightning_on_core_rings_clients");
	CreateThread(boss_objcon_1);
	CreateThread(boss_objcon_2);
	CreateThread(boss_objcon_3);
	CreateThread(boss_objcon_4);
	CreateThread(boss_objcon_5);
	--	object_create_anew("w2_plat_collectible_12");		DELETED
	object_create_anew("w2_plat_skull");
	object_wake_physics(object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"));
	object_wake_physics(object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_2"));
	ai_object_set_team(object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), TEAM.covenant);
	ai_object_enable_targeting_from_vehicle(object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), true);
	b_shouldOptimizeKraken = true;
	CreateThread(UpdateKrakenOptimizations);
	CreateThread(sentry_destruction_listener);
	CreateThread(keyhole_shield_listener);
end

function kraken_destruction_sequence():void
--seqeunce:
-- start listing once everyone out of engine room
-- smoke
	print("DESTRUCTION SEQUENCE");
	CreateThread(kraken_destruction_effects_interior);					-- interior effects
	-- add function that arms interior damage events here
	CreateThread(backup_banshee_spawner);								-- replace missing or misplaced escape banshees
	CreateThread(audio_plateau_countdownstarted);						-- audio
	CreateThread(kraken_ongoing_shake);									-- shake
--	CreateThread(listing_listener);										-- start kraken listing once players leave engine room area
--	f_countdown_timer();												-- old countdown
	f_countdown_conditions();											-- new countdown based on conditions
	CreateThread(kraken_lackin);										-- evaluate for achievement
	Sleep(30);															-- give player time to get clear of ship
	CreateThread(interior_player_killer);								-- make explosions on player head then fades out
	Sleep(22);
	CreateThread(f_sentry_clean_up);									-- delete AI and turrets (NEED MORE GRACEFUL WAY TODO THIS GAWD IT LOOKS AWFUL)					
	Sleep(8);
	CreateThread(audio_plateau_sentrydestroyed);
	b_shouldOptimizeKraken = false;
	b_ship_destroyed = true;
end

function UpdateKrakenOptimizations():void
	repeat
		device_machine_opt_out_from_matrix_updates(OBJECTS.vin_sent_machine_2, true);
		no_antigrav_on_kraken = true;
		air_fp_min_spacing = 2;
		Sleep(1);
	until (b_shouldOptimizeKraken == false)
	device_machine_opt_out_from_matrix_updates(OBJECTS.vin_sent_machine_2, false);
	no_antigrav_on_kraken = false;
	air_fp_min_spacing = 0.5;
end
function hangar_door_listener():void
	SleepUntil(	[|	var_boss_objcon >= 30
				or	object_get_health(object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1")) <= 0.05
				], 30);
	CreateThread(f_right_hangar_door_listener);							-- open right hangar door if players approach
	CreateThread(f_left_hangar_door_listener);							-- open left hangar door if players approach
end
function sentry_deck_shuffle():void
	repeat
		sleep_s(10);
		var_deck_shuffle = var_deck_shuffle + 1;
		if(var_deck_shuffle >= 5)then
			var_deck_shuffle = 0;
		end
	until(var_boss_objcon == 10);
end
global beachhead:boolean = false;
function beach_head():void
	local b:boolean = false;
	repeat
		sleep_s(.5);
--		print("bh");
		local f:object_list = volume_return_players(VOLUMES.tv_beach_head);
		for _,obj in ipairs(f) do
			print(obj);
			if(unit_in_vehicle(obj) == false)then
				game_save_no_timeout();
				print("============================beach head save");
				b = true;
				beachhead = true;
			end
		end
	until(b == true);
end
function boss_objcon_1():void
	SleepUntil([| volume_test_players(VOLUMES.tv_upper_decker)]);
	if (var_boss_objcon <= 10) then
		var_boss_objcon = 10;
	end
end
function boss_objcon_2():void
	SleepUntil([| volume_test_players(VOLUMES.tv_deck_stairs)]);	
	if (var_boss_objcon <= 20) then
		var_boss_objcon = 20;
	end
end
function boss_objcon_3():void
	SleepUntil([| volume_test_players(VOLUMES.tv_armory)]);	
	if (var_boss_objcon <= 30) then
		var_boss_objcon = 30;
	end
end
function boss_objcon_4():void
	SleepUntil([| volume_test_players(VOLUMES.tv_hangar_floor)]);	
	if (var_boss_objcon <= 40) then
		var_boss_objcon = 40;
	end
end
function boss_objcon_5():void
	SleepUntil([|		volume_test_players(VOLUMES.tv_engine_hall) 
					or	volume_test_players(VOLUMES.tv_engine_room)], 3);
	if (var_boss_objcon <= 50) then
		var_boss_objcon = 50;
	end
	CreateThread(muskbox_kraken);
end
function muskbox_kraken():void
	if	(game_coop_player_count() <= 1)	then
		muskboss(VOLUMES.tv_engine_hall, FLAGS.mt_hall_1a, 2, FLAGS.mt_hall_1b, 2);
	end
end
function muskboss(vol:volume, flag1:flag, dist1:number, flag2:flag, dist2:number):void
	local b_pos_1_set:boolean = false;
	local b_pos_2_set:boolean = false;
	
	repeat
		b_pos_1_set = false;
		b_pos_2_set = false;
		SleepUntil( [| volume_test_players(vol)
					or IsGoalActive(missionPlateau.goal_SentryBoss) == false
					],20);
			for _, obj in ipairs ( ai_actors(GetMusketeerSquad()) ) do
				if not b_pos_1_set then
					b_pos_1_set = true;                                                                                                                       
					print("my buddy");
				elseif not b_pos_2_set then
					b_pos_2_set = true;
					print("pos 2");
					MusketeerDestSetPoint(obj, flag1, dist1);
				else
					print("pos 3");
					MusketeerDestSetPoint(obj, flag2, dist2);
				end
			end
		SleepUntil( [| volume_test_players(vol) == false
					or	object_get_health(object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1")) <= 0.05 
					or IsGoalActive(missionPlateau.goal_SentryBoss) == false
					],1);
		MusketeerUtil_SetDestination_Clear_All()
	until	(		IsGoalActive(missionPlateau.goal_SentryBoss) == false
			or		object_get_health(object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1")) <= 0.05 
			);
	MusketeerUtil_SetDestination_Clear_All()
end	
function sentry_baffle_cycler():void
	local baffle_number:number = 0;
	repeat
		sleep_s(4);
		baffle_number = baffle_number + 1;
		if(baffle_number >= 3)then
			baffle_number = 0;
		end
		if(baffle_number == 0)then
			CreateThread(ss_baffle_1);
		elseif(baffle_number == 1)then
			CreateThread(ss_baffle_2);
		else
			CreateThread(ss_baffle_3);
		end
	until(var_boss_objcon == 20);

	ss_give_all_gunners_sight();

end
function ss_baffle_1():void
	ai_set_blind(AI.squads_deck_01_turret_01, true);
--	ai_set_blind(AI.squads_deck_02_turret_01, true);
--	ai_set_blind(AI.squads_mid_turrets_02, true);
	ai_set_blind(AI.squads_mid_turrets_04, true);
	
--	ai_set_blind(AI.squads_deck_03_turret_02, false);
	ai_set_blind(AI.squads_mid_turrets_01, false);
	ai_set_blind(AI.squads_mid_turrets_05, false);
	ai_set_blind(AI.squads_mid_turrets_07, false);

--	ai_set_blind(AI.squads_deck_02_turret_02, false);
	ai_set_blind(AI.squads_mid_turrets_06, false);
	ai_set_blind(AI.squads_mid_turrets_08, false);	
	ai_set_blind(AI.squads_mid_turrets_03, false);
end
function ss_baffle_2():void
	ai_set_blind(AI.squads_deck_01_turret_01, false);
--	ai_set_blind(AI.squads_deck_02_turret_01, false);
--	ai_set_blind(AI.squads_mid_turrets_02, false);
	ai_set_blind(AI.squads_mid_turrets_04, false);
	
--	ai_set_blind(AI.squads_deck_03_turret_02, true);
	ai_set_blind(AI.squads_mid_turrets_01, true);
	ai_set_blind(AI.squads_mid_turrets_05, true);
	ai_set_blind(AI.squads_mid_turrets_07, true);

--	ai_set_blind(AI.squads_deck_02_turret_02, false);
	ai_set_blind(AI.squads_mid_turrets_06, false);
	ai_set_blind(AI.squads_mid_turrets_08, false);	
	ai_set_blind(AI.squads_mid_turrets_03, false);
end
function ss_baffle_3():void
	ai_set_blind(AI.squads_deck_01_turret_01, false);
--	ai_set_blind(AI.squads_deck_02_turret_01, false);
--	ai_set_blind(AI.squads_mid_turrets_02, false);
	ai_set_blind(AI.squads_mid_turrets_04, false);
	
--	ai_set_blind(AI.squads_deck_03_turret_02, false);
	ai_set_blind(AI.squads_mid_turrets_01, false);
	ai_set_blind(AI.squads_mid_turrets_05, false);
	ai_set_blind(AI.squads_mid_turrets_07, false);

--	ai_set_blind(AI.squads_deck_02_turret_02, true);
	ai_set_blind(AI.squads_mid_turrets_06, true);
	ai_set_blind(AI.squads_mid_turrets_08, true);	
	ai_set_blind(AI.squads_mid_turrets_03, true);
end
function left_hangar_gunner_ejection_listener():void
	SleepUntil([| volume_test_players(VOLUMES.tv_left_gunner_ejection)], 30);
	if(ai_living_count(AI.squads_mid_turrets_01) > 0)then
		unit_exit_vehicle(AI.squads_mid_turrets_01, 0);
	end
	if(ai_living_count(AI.squads_mid_turrets_08) > 0)then
		unit_exit_vehicle(AI.squads_mid_turrets_08, 0);
	end
	cs_go_to(AI.squads_mid_turrets_01, true, POINTS.ps_kraken.pkl);
	cs_go_to(AI.squads_mid_turrets_08, true, POINTS.ps_kraken.pkl);
end
function right_hangar_gunner_ejection_listener():void
	SleepUntil([| volume_test_players(VOLUMES.tv_right_gunner_ejection)], 30);
	if(ai_living_count(AI.squads_mid_turrets_04) > 0)then
		unit_exit_vehicle(AI.squads_mid_turrets_04, 0);
	end
	if(ai_living_count(AI.squads_mid_turrets_05) > 0)then
		unit_exit_vehicle(AI.squads_mid_turrets_05, 0);
	end
	cs_go_to(AI.squads_mid_turrets_04, true, POINTS.ps_kraken.pkr);
	cs_go_to(AI.squads_mid_turrets_05, true, POINTS.ps_kraken.pkr);
end
	
--==============================================
--==============================================
--======= MUSKETEER EVAC
--==============================================
--==============================================
function musketeers_flee_kraken():void
-- launch at the same time:
		-- if is musketeer
		--		and in kraken
		--		and not in vehicle
		-- then go to marker
		-- iterate through and spread them out
		-- account for which banshees are alive and not occupied?

-- and
	-- if is musketeer
	--		and in volume
				--	tv_left_hangar_platform - escape_banshee_3 escape_banshee_4
				--	tv_right_hangar_platform - escape_banshee_1 escape_banshee_2
	--		and banshee is available
	-- then
	--		open door
	--		enter banshee
-- and
	-- repeat
		-- if in vehicle
		-- and door is open
		--		go to point
		--		exit vehicle
		-- elseif in vehicle 
		--	and in volume
		--		go to point

end
function musketeer_evac_time():void
	local b_pos_1_set:boolean = false;
	local b_pos_2_set:boolean = false;
	MusketeerUtil_SetDestination_Clear_All();
	sleep_s(1);
	for _, musk in ipairs ( ai_actors(GetMusketeerSquad()) ) do
			if	(	in_kraken_and_not_in_vehicle(musk)
					and	not b_pos_1_set
				)	then
			
					b_pos_1_set = true;                                                                                                                       
					musketeer_evac_order(musk, VOLUMES.tv_left_hangar_platform, FLAGS.mt_left_hangar);

		elseif	(	in_kraken_and_not_in_vehicle(musk)
					and	not b_pos_2_set
				)	then
					
					b_pos_2_set = true;
					musketeer_evac_order(musk, VOLUMES.tv_right_hangar_platform, FLAGS.mt_right_hangar);

		else
			local dice:number = random_range(0,1);
			if		(	volume_test_players(VOLUMES.tv_left_hangar_platform)
					or	banshee_counter(true)	<=1)
				then
					musketeer_evac_order(musk, VOLUMES.tv_right_hangar_platform, FLAGS.mt_right_hangar);

			elseif	(	volume_test_players(VOLUMES.tv_right_hangar_platform)
					or	banshee_counter(false)	<=1)
				then
					musketeer_evac_order(musk, VOLUMES.tv_left_hangar_platform, FLAGS.mt_left_hangar);
			elseif(dice == 0)
				then
					musketeer_evac_order(musk, VOLUMES.tv_right_hangar_platform, FLAGS.mt_right_hangar);
			else
					musketeer_evac_order(musk, VOLUMES.tv_left_hangar_platform, FLAGS.mt_left_hangar);
			end
		end
	end
end
function musketeer_evac_order(musk:object, vol:volume, fulg:flag):void
	local left:boolean = true;
	if	(	fulg == FLAGS.mt_right_hangar) then
		left = false;
	end
	
	MusketeerDestSetPoint(musk, fulg, 1);
	
	SleepUntil(	[|	volume_test_object(vol, musk)
				or	IsGoalActive(missionPlateau.goal_SentryBoss) == false
				], 10);

	Sleep(1);
	SleepUntil(	[|	banshee_counter(left) <= 0
				or	unit_in_vehicle(musk) == true
				or	IsGoalActive(missionPlateau.goal_SentryBoss) == false
				], 10);
	
	-- if banshees are all taken, need to go to other hangar
	if		(	banshee_counter(left) <= 0
			and	left == true			) then
			MusketeerDestClear(musk);
			Sleep(1);
			musketeer_evac_order(musk, VOLUMES.tv_right_hangar_platform, FLAGS.mt_right_hangar);
	elseif	(	banshee_counter(left) <= 0
			and	left == false			) then
			MusketeerDestClear(musk);
			Sleep(1);
			musketeer_evac_order(musk, VOLUMES.tv_left_hangar_platform, FLAGS.mt_left_hangar);
	-- otherwise, time to fly!
	elseif	(	left == true)then
		MusketeerDestClear(musk);
		Sleep(1);
		MusketeerDestSetPoint(musk, FLAGS.mt_left_orbit, 6);
	else
		MusketeerDestClear(musk);
		Sleep(1);
		MusketeerDestSetPoint(musk, FLAGS.mt_right_orbit, 6);
	end
end
function in_kraken_and_not_in_vehicle(musk:object):boolean
	if		volume_test_object(VOLUMES.tv_sentry_ship, musk)
		and not unit_in_vehicle(musk)
	then
		return(true);
	else
		return(false);
	end
end
function banshee_counter(left:boolean):number
	local t_banshees:table = nil;
	
	if(left == true)then
	t_banshees =					-- left hangar
		{
			"escape_banshee_3",
			"escape_banshee_4"
		};
	else							
		t_banshees =				-- right hangar
		{
			"escape_banshee_1",
			"escape_banshee_2"
		};
	end
	local count:number = 0
	for _,name  in ipairs(t_banshees) do
		local v: object = ObjectFromName(name);
		if		v 
			and object_get_health (v) > 0
			and not banshee_is_occupied(v)
			then
				count = count + 1;
		else
				print(" ");
		end
	end
	return count;
end
function banshee_is_occupied(bansh:object):boolean
	if bansh ~= nil then
		for _, spartan in ipairs (spartans()) do
			if(unit_get_vehicle(spartan) == bansh)then
				print(spartan, " in banshee", bansh);
				return(true);
			end
		end
	end
	return(false);
end
global b_all_players_evacuated:boolean = false;
function all_players_are_out_listener():void
-- once players are out of kraken
-- teleport musketeers into available banshees
-- and send them on their way
	SleepUntil([|	volume_test_players(VOLUMES.tv_sentry_ship) == false], 20);
	doomed_musketeers_teleport_into_escape_banshees();
end
function doomed_musketeers_teleport_into_escape_banshees():void				-- tested, solid!
	for _, musketeer in ipairs (ai_actors(GetMusketeerSquad())) do
		if	(	volume_test_object(VOLUMES.tv_sentry_ship, musketeer)
			and	unit_in_vehicle(musketeer) == false
			)
		then
			print("musketeer in kraken");
			local bansh:object = nil;
			MusketeerDestClear(musketeer);
			Sleep(2);
			bansh = find_available_escape_banshee();
			if(bansh ~= nil)then
				print("banshee ", bansh, " available");
				vehicle_load_magic(bansh, "", ai_actors(object_get_ai(musketeer)));
				sleep_s(1);
				MusketeerDestSetPoint(musketeer, FLAGS.tpf_vtol, 5);
			else
				print("BANSHEES UNAVAILABLE");
			end
			Sleep(2);
		end
	end
end
function find_available_escape_banshee():object
	local t_banshees:table =
		{
			"escape_banshee_1",
			"escape_banshee_2",
			"escape_banshee_3",
			"escape_banshee_4",
		};
	for _,name  in ipairs(t_banshees) do
		local v: object = ObjectFromName(name);
		if		v 
			and object_get_health (v) > 0
			and not banshee_is_occupied(v)
			then
				return(v);
		else
			print("banshee occupied");
		end
	end
end


--[[
function all_players_are_in_vehicles_listener():boolean					-- not in use.
	repeat

		local pilot_count:number = 0;
	
		for _,spartan in ipairs (players()) do
			if	(	unit_in_vehicle_type(spartan, 30)	-- banshee
			or		unit_in_vehicle_type(spartan, 40)	-- vtol 
				)
			then
				pilot_count = pilot_count + 1;
			end
			if(pilot_count == game_coop_player_count() )then
				b_all_players_evacuated = true;
			end
		end
		sleep_s(1);
	until(	b_all_players_evacuated == true
		or	b_ss_goal_complete == true
		)
end
--]]
--			/==============================================
--			/==============================================
--			/======= MUSKETEER EVAC
--			/==============================================
--			/==============================================
function f_sentry_spawn_hack():void													-- adding this because of double-spawns.
	SleepUntil([| b_ss_spawn_hack == true ]);										-- f_sentry_spawn is called from a function that is called by the composition.
	f_sentry_spawn();																-- I suspect its running this script once on the server and again on the clients
end																					-- or something like that, resulting in multiple spawn events.
																					-- So I'm setting a bool instead of calling the function directly.
--activate sentry assets in section													-- If you're reading this, there's a high likelihood that this worked
function f_sentry_spawn():void														-- so I just left it in. -tjp 5/28/2014
	print ("sentry assets activate");
	CreateThread(f_armory_start);
	CreateThread(f_hangar_start);
	CreateThread(f_engine_breach);
--	CreateThread(sentry_baffle_cycler);

--	ai_place(AI.squads_deck_01_grunts);
--	ai_place(AI.squads_deck_01_elites);
--	ai_place(AI.squads_deck_02_grunts);
--	ai_place(AI.squads_deck_02_elites);
--	ai_place(AI.squads_deck_03_grunts);
--	ai_place(AI.squads_deck_03_elites);
--	ai_place(AI.gr_deck_ctr);
end
function end_sentry_start_soldier():void														-- called from function that originates in the composition. Also called from cheats.
	b_ss_goal_complete = true;
end
function f_sentry_clean_up():void
	ai_erase(AI.gr_sentry_all);
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "top_turret_1"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "top_turret_2"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "top_turret_3"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "mid_turret_1"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "mid_turret_2"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "mid_turret_3"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "mid_turret_4"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "mid_turret_5"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "mid_turret_6"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "low_turret_1"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "low_turret_2"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "low_turret_3"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "low_turret_4"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "low_turret_5"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "low_turret_6"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "low_turret_7"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "low_turret_8"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "hallway_weapon_1"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "hallway_weapon_2"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "hangar_weapon_1"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "hangar_weapon_2"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "hangar_weapon_3"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "hangar_weapon_4"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "mid_weapon_1"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "mid_weapon_2"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "mid_weapon_3"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "mid_weapon_4"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "top_weapon_1"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "top_weapon_2"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "top_weapon_3"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "top_weapon_4"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "top_weapon_5"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "top_weapon_6"));
	--	object_destroy(OBJECTS.w2_plat_collectible_12);		DELETED
	object_destroy(OBJECTS.w2_plat_skull);
	garbage_collect_now();
	if(vehicle_test_seat(OBJECTS.escape_banshee_1, "banshee_d") == false)then
		object_destroy(OBJECTS.escape_banshee_1);
	end
	if(vehicle_test_seat(OBJECTS.escape_banshee_2, "banshee_d") == false)then
		object_destroy(OBJECTS.escape_banshee_2);
	end
	if(vehicle_test_seat(OBJECTS.escape_banshee_3, "banshee_d") == false)then
		object_destroy(OBJECTS.escape_banshee_3);
	end
	if(vehicle_test_seat(OBJECTS.escape_banshee_4, "banshee_d") == false)then
		object_destroy(OBJECTS.escape_banshee_4);
	end
	CreateThread(sentry_ship_erase_all_by_volume);
	ai_erase(AI.gr_v2_banshee);
	Sleep(8);
	kill_volume_enable(VOLUMES.kill_tv_sentry_ship);
	sleep_s(2);
	kill_volume_disable(VOLUMES.kill_tv_sentry_ship);
	kill_volume_disable(VOLUMES.kill_core_room);
	kill_volume_disable(VOLUMES.playerkill_core);
	Sleep(8);
	kill_volume_disable(VOLUMES.kill_tv_sentry_ship);
	kill_volume_disable(VOLUMES.kill_core_room);
	kill_volume_disable(VOLUMES.playerkill_core);
	garbage_collect_now();
end

function sentry_ship_erase_all_by_volume():void
		for _, obj in pairs (volume_return_objects(VOLUMES.tv_sentry_ship)) do
			ai_erase(object_get_ai(obj));
			object_destroy(obj);
		end
end

function ss_man_the_guns():void

	if(b_gun_t3 == false) then																	-- i.e. was this destroyed during ramp?
		object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "top_turret_3"))
	else
		ss_gunner_spawner_2(AI.squads_deck_turrets_03, "top_turret_3");
	end
--[[		-- backside turrets; removed to create the rear path
	if(b_gun_m3 == false) then
		object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "mid_turret_3"))
	else
		ss_gunner_spawner(AI.squads_deck_03_turret_01, "mid_turret_3");			-- remove
	end
	if(b_gun_m4 == false) then
		object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "mid_turret_4"))
	else
		ss_gunner_spawner(AI.squads_deck_01_turret_02, "mid_turret_4");			-- remove
	end
--]]
	if(b_gun_l3 == false) then																	-- i.e. was this destroyed during ramp?
		object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "low_turret_3"))
	else
		ss_gunner_spawner_2(AI.squads_mid_turrets_03, "low_turret_3");
	end
	if(b_gun_l4 == false) then																	-- i.e. was this destroyed during ramp?
		object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "low_turret_4"))
	else
		ss_gunner_spawner_2(AI.squads_mid_turrets_04, "low_turret_4");
	end
	if(b_gun_l5 == false) then																	-- i.e. was this destroyed during ramp?
		object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "low_turret_5"))
	else
		ss_gunner_spawner_2(AI.squads_mid_turrets_05, "low_turret_5");
	end
	ss_gunner_spawner_2(AI.squads_deck_01_turret_01, "mid_turret_5");
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "mid_turret_4"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "mid_turret_3"));
	ss_gunner_spawner_2(AI.squads_deck_03_turret_02, "mid_turret_2");
	ss_gunner_spawner_2(AI.squads_deck_02_turret_01, "mid_turret_1");
	ss_gunner_spawner_2(AI.squads_deck_02_turret_02, "mid_turret_6");

	ss_gunner_spawner_2(AI.squads_deck_turrets_01, "top_turret_1");
	ss_gunner_spawner_2(AI.squads_deck_turrets_02, "top_turret_2");

	ss_gunner_spawner_2(AI.squads_mid_turrets_01, "low_turret_1");
	ss_gunner_spawner_2(AI.squads_mid_turrets_02, "low_turret_2");
	ss_gunner_spawner_2(AI.squads_mid_turrets_06, "low_turret_6");
	ss_gunner_spawner_2(AI.squads_mid_turrets_07, "low_turret_7");
	ss_gunner_spawner_2(AI.squads_mid_turrets_08, "low_turret_8");
--[[
	sleep_s(1);

	ai_set_blind(AI.squads_deck_01_turret_01, true);
	ai_set_blind(AI.squads_deck_03_turret_02, true);
	ai_set_blind(AI.squads_deck_02_turret_01, true);
	ai_set_blind(AI.squads_deck_02_turret_02, true);

	ai_set_blind(AI.squads_deck_turrets_01, true);
	ai_set_blind(AI.squads_deck_turrets_02, true);
	ai_set_blind(AI.squads_deck_turrets_03, true);

	ai_set_blind(AI.squads_mid_turrets_01, true);
	ai_set_blind(AI.squads_mid_turrets_02, true);
	ai_set_blind(AI.squads_mid_turrets_03, true);
	ai_set_blind(AI.squads_mid_turrets_04, true);
	ai_set_blind(AI.squads_mid_turrets_05, true);
	ai_set_blind(AI.squads_mid_turrets_06, true);
	ai_set_blind(AI.squads_mid_turrets_07, true);
	ai_set_blind(AI.squads_mid_turrets_08, true);
--]]
end
function delay_then_give_all_gunners_sight():void
	sleep_s(.5);
	CreateThread(ss_give_all_gunners_sight);
end
function ss_give_all_gunners_sight():void
	ai_set_blind(AI.squads_deck_01_turret_01, false);
	ai_set_blind(AI.squads_deck_03_turret_02, false);
	ai_set_blind(AI.squads_deck_02_turret_01, false);
	ai_set_blind(AI.squads_deck_02_turret_02, false);

	ai_set_blind(AI.squads_deck_turrets_01, false);
	ai_set_blind(AI.squads_deck_turrets_02, false);
	ai_set_blind(AI.squads_deck_turrets_03, false);

	ai_set_blind(AI.squads_mid_turrets_01, false);
	ai_set_blind(AI.squads_mid_turrets_02, false);
	ai_set_blind(AI.squads_mid_turrets_03, false);
	ai_set_blind(AI.squads_mid_turrets_04, false);
	ai_set_blind(AI.squads_mid_turrets_05, false);
	ai_set_blind(AI.squads_mid_turrets_06, false);
	ai_set_blind(AI.squads_mid_turrets_07, false);
	ai_set_blind(AI.squads_mid_turrets_08, false);
end
function ss_limit_all_firing_arcs():void
	cs_run_command_script(AI.squads_deck_01_turret_01, "cs_ss_gunner");
--	cs_run_command_script(AI.squads_deck_01_turret_02, "cs_ss_gunner");
--	cs_run_command_script(AI.squads_deck_03_turret_01, "cs_ss_gunner");
	cs_run_command_script(AI.squads_deck_03_turret_02, "cs_ss_gunner");
	cs_run_command_script(AI.squads_deck_02_turret_01, "cs_ss_gunner");
	cs_run_command_script(AI.squads_deck_02_turret_02, "cs_ss_gunner");

--	cs_run_command_script(AI.squads_deck_turrets_01, "cs_ss_gunner");
--	cs_run_command_script(AI.squads_deck_turrets_02, "cs_ss_gunner");
--	cs_run_command_script(AI.squads_deck_turrets_03, "cs_ss_gunner");

	cs_run_command_script(AI.squads_mid_turrets_01, "cs_ss_gunner");
	cs_run_command_script(AI.squads_mid_turrets_02, "cs_ss_gunner");
	cs_run_command_script(AI.squads_mid_turrets_03, "cs_ss_gunner");
--	cs_run_command_script(AI.squads_mid_turrets_04, "cs_ss_gunner");
--	cs_run_command_script(AI.squads_mid_turrets_05, "cs_ss_gunner");
	cs_run_command_script(AI.squads_mid_turrets_06, "cs_ss_gunner");
	cs_run_command_script(AI.squads_mid_turrets_07, "cs_ss_gunner");
	cs_run_command_script(AI.squads_mid_turrets_08, "cs_ss_gunner");
end
function f_armory_start():void
	SleepUntil([|		volume_test_players(VOLUMES.tv_hangar_floor) 
					or	volume_test_players(VOLUMES.tv_armory) 
					or	b_engine_breach == true
				], 1);

	if(	volume_test_objects(VOLUMES.tv_ss_all, ai_actors(AI.reinforcement_banshees_1) ) == false)then	-- make sure reinforcement pilots aren't present
		object_create_folder (MODULES.sentry_hangar);
	end
	if(volume_test_players(VOLUMES.tv_hangar_floor))	then
		sleep_s(.2);				-- let hangar spawn first
	end
	if(ai_living_count(AI.gr_sentry_all) <= 17)	then		-- a bit lower than hangar reqs, to err on side of hangar hostiles
		ai_place(AI.gr_armory_01);
	end
	AllowVehicleTeleportOnCheckpoint(false)
	game_save_no_timeout();
end

function f_engine_breach():void
	SleepUntil([|		volume_test_players(VOLUMES.tv_engine_hall) 
					or	volume_test_players(VOLUMES.tv_engine_room)], 3);
	b_engine_breach = true
	CreateThread(muskore_listener);
	game_save_no_timeout();
end

function f_hangar_start():void
	SleepUntil(	[|		volume_test_players(VOLUMES.tv_hangar_floor) 
					or	volume_test_players(VOLUMES.tv_ducts) 
					or	b_engine_breach == true
				], 1);
	CreateThread(hangar_3_spawn_listener);
	CreateThread(hangar_9_spawn_listener);
	CreateThread(ss_recall_banshees);																			-- bring banshee pilots back to SS
end
function hangar_3_spawn_listener():void
	SleepUntil(	[|		volume_test_players(VOLUMES.tv_hangar_3_spawn) 
					or	volume_test_players(VOLUMES.tv_ducts) 
					or	b_engine_breach == true
				], 1);
--	if(ai_living_count(AI.gr_sentry_all) <= 19)	then
		ai_place(AI.sq_hangar3_boss);
--	end
	Sleep(2);
	if(ai_living_count(AI.gr_sentry_all) <= 18)	then
		ai_place(AI.sq_hangar3_lowbies);
		Sleep(2);
	end
	if(ai_living_count(AI.gr_sentry_all) <= 18)	then
		ai_place(AI.sq_hangar3_lowbie_elite);
	end

end
function hangar_9_spawn_listener():void
	SleepUntil(	[|		volume_test_players(VOLUMES.tv_hangar_9_spawn) 
					or	volume_test_players(VOLUMES.tv_ducts) 
					or	b_engine_breach == true
				], 1);
	Sleep(1);
--	if(ai_living_count(ai_living_count(AI.gr_sentry_all) <= 19))	then
		ai_place(AI.sq_hangar9_lowbies_e);
--	end
	Sleep(2);
	if(ai_living_count(AI.gr_sentry_all) <= 17)	then
		ai_place(AI.sq_hangar3_lowbies);
	end
end
function f_right_hangar_door_listener():void
	local door_open:boolean = false;
	local osiris:object_list = spartans();
		
	repeat
		if	(	(	volume_test_objects(VOLUMES.tv_right_hangar_platform, osiris)
				or	volume_test_players(VOLUMES.tv_right_hangar_platform)
				)
			and
				door_open == false
			) 
		then
			print("======= open 11 o' clock hangar bay =======");
			CreateThread(open_right_hangar_door);
			door_open = true;
			sleep_s(4);
		end

		sleep_s(.5);
	until(b_ship_destroyed == true)
end
function f_left_hangar_door_listener():void
	local door_open:boolean = false;
	local osiris:object_list = musketeers();
	repeat
		if	(	(	volume_test_objects(VOLUMES.tv_left_hangar_platform, osiris)
				or	volume_test_players(VOLUMES.tv_left_hangar_platform)
				)
			and
				door_open == false
			) 
		then
			print("======= open 5 o' clock hangar bay =======");
			CreateThread(open_left_hangar_door);
			door_open = true;
			sleep_s(4);
		end
		sleep_s(.5);
	until(b_ship_destroyed == true)
end
function backup_banshee_spawner()
	local t_banshees:table =
		{
			"escape_banshee_1",
			"escape_banshee_2",
			"escape_banshee_3",
			"escape_banshee_4",
		};
	local v_count:number = 0;
	repeat
		for _,name  in ipairs(t_banshees) do
			if  bansheeAvailable(ObjectFromName(name)) then					-- is banshee "available to spawn"?
				object_create_anew(name);									-- if so, create it
				Sleep(2);
				ObjectSetSpartanTrackingEnabled(ObjectFromName(name), true);-- blip for tracking
			end
		end
		v_count = v_count + 1;
	until(v_count >= 3);
end

--check to see if a banshee is available to be created (or created anew)
function bansheeAvailable (vtol:object):boolean
	if not vtol then														-- if banshee is missing
		return true;														-- return yes, banshee is available to spawn
	end
	if banshee_checker (vtol) then											-- if banshee is occupied
		return false;														-- return no, banshee is NOT available to spawn
	end
	
	if object_get_health (vtol) == 0 then									-- 
		return true;
	end
	
	if volume_test_object(VOLUMES.tv_hangar_floor, vtol) then
		--print (vtol, " is in tv_vtol_pad");
		return false;
	end
	print (vtol, "is available and returning true");
	return true;
end

--check to see if a spartan is inside a banshee
function banshee_checker(vtol:object):boolean									
	if vtol ~= nil then
		for _, spartan in ipairs (spartans()) do
			if(unit_get_vehicle(spartan) == vtol)then
				print(spartan, " in vtol", vtol);
				ObjectSetSpartanTrackingEnabled(vtol, false);				-- occupied? Remove blip for tracking
				return(true);
			else
				ObjectSetSpartanTrackingEnabled(vtol, true);				-- no one in it? blip it for tracking
			end
		end
	end
	return(false);
end


function open_right_hangar_door():void
	b_shouldOptimizeKraken = false;
	Sleep(3);
	DeviceLayerPlayAnimation( OBJECTS.vin_sent_machine_2, 1, "open_close_doors_2", 30);
	CreateThread(audio_hanger_door_open_2);
	Sleep(90);
	b_shouldOptimizeKraken = true;
end
function open_left_hangar_door():void
	b_shouldOptimizeKraken = false;
	Sleep(3);
	DeviceLayerPlayAnimation( OBJECTS.vin_sent_machine_2, 2, "open_close_doors", 30);
	CreateThread(audio_hanger_door_open);
	Sleep(90);
	b_shouldOptimizeKraken = true;
end
function close_left_hangar_door():void
	b_shouldOptimizeKraken = false;
	Sleep(3);
	DeviceLayerPlayAnimationBackward( OBJECTS.vin_sent_machine_2, 2, "open_close_doors", 30);
	CreateThread(audio_hanger_door_open);
	Sleep(90);
	b_shouldOptimizeKraken = true;
end
function open_hangar_door():void
	CreateThread(open_right_hangar_door);
	CreateThread(open_left_hangar_door);
end
function banshee_reinforcements():void
	object_create_folder(MODULES.reinforcement_banshees_1);
	CreateThread(open_left_hangar_door);
	ai_place(AI.reinforcement_banshees_1);
	SleepUntil([|	volume_test_objects(VOLUMES.tv_ss_all, ai_actors(AI.reinforcement_banshees_1)) == false],5);
	CreateThread(close_left_hangar_door);
end
function cs_reinforcement_banshee_1():void
	cs_go_to_vehicle(ai_current_actor, true, OBJECTS.reinforcement_banshee_1, "banshee_d");
	cs_fly_to (ai_current_actor, true, POINTS.	ps_ss_banshees.REINFORCE1, 3);
end
function cs_reinforcement_banshee_2():void
	cs_go_to_vehicle(ai_current_actor, true, OBJECTS.reinforcement_banshee_2, "banshee_d");
	cs_fly_to (ai_current_actor, true, POINTS.	ps_ss_banshees.REINFORCE2, 3);
end
function close_right_hangar_door():void
--[[	DeviceLayerPlayAnimation( deviceMachine:object, layer:number, name:string, rate:number):void
		DeviceSetLayerAnimation(deviceMachine, layer, name);
		DeviceSetLayerPlaybackStop(deviceMachine, layer);
		DeviceSetLayerRate(deviceMachine, layer, rate);
		DeviceSetLayerDest(deviceMachine, layer, 1);
		DeviceSetLayerPos(deviceMachine, layer, 0);
--]]
		DeviceSetLayerAnimation(OBJECTS.vin_sent_machine_2, 0, "open_close_doors");
		DeviceSetLayerPlaybackStop(OBJECTS.vin_sent_machine_2, 0);
		DeviceSetLayerDest(OBJECTS.vin_sent_machine_2, 0, 0);
		DeviceSetLayerRate(OBJECTS.vin_sent_machine_2, 0, 1);
		DeviceSetLayerPos(OBJECTS.vin_sent_machine_2, 0, 0);
end
--Core destruction logic
function f_core_destroy_listener()
	print ("core destroy started");
	CreateThread(core_save_listener);
	SleepUntil (	[|	object_get_health(object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1")) <= 0.05 or
						b_ship_destroyed == true]	
				, 1);
--		object_set_health(object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 0);				-- 9-2-2015
		damage_object( object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), "default", 2000 );	-- 9-2-2015
		print ("-----------DEREZ ME--------------");
		RunClientScript("fx_derez_sentry_ship_core_clients");
		CreateThread(musketeer_evac_time);
		CreateThread(all_players_are_out_listener);								-- waits for players to be clear of clear, then teleports lagging musketeers into banshees
		CreateThread(vtol_surf_listener);
		--NARRATIVE CALL
		CreateThread(plateau_sentry_battle_core_destroyed_launcher);
	print ("core dead");
end
function core_save_listener():void
	SleepUntil (	[|	object_get_health(object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1")) <= 0.5 or
						b_ship_destroyed == true]	
				, 1);
--	game_save_no_timeout();
	game_save_immediate();		--tjp 7-31-2015 DEFCON 5
	sleep_s(2);
	prepare_to_switch_to_zone_set(ZONE_SETS.plateau_sentry);
end
function core_health():void
	repeat
		Sleep(10);
		print(" core health: "..object_get_health(object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1")).."   ");
	until b_ship_destroyed;
end

function kraken_ongoing_shake():void
	-- todo: increase intensity and frequency as countdown progresses (intensity currently clamped 12/19/2014);
	print ("startup shake");
	repeat
		local dice:number = random_range(0,3);
		if(dice == 0)then
			CreateThread(standard_shake);
		elseif(dice == 1)then
			CreateThread(lighter_shake);
		elseif(dice == 2)then
			CreateThread(lighter_shake);
			sleep_s(.8);
			CreateThread(standard_shake);
		elseif(dice == 3)then
			sleep_s(1);
		end
		sleep_s(random_range(2,6));
	until b_ship_destroyed;
end
function listing_listener():void												
-- need to handle more cases here!
	sleep_s(2);
--[[	SleepUntil([|		volume_test_players(VOLUMES.tv_engine_hall) == false						-- too aggressive
					and	volume_test_players(VOLUMES.tv_engine_room) == false] , 3);
--]]	
	b_ship_start_listing = true;
end
function f_countdown_conditions():void
	for count= 20, 1, -1 do
		if(b_deathstroke == true)then
			print("DESTRUCTION SEQUENCE: BREAK IN COUNTDOWN");
			break
		end

		if	(	volume_test_players(VOLUMES.tv_sentry_ship)
			)then
			print("DESTRUCTION SEQUENCE: COUNTDOWN: "..count);
			sleep_s(2.35);
		elseif	(	test_any_musketeers_in_kraken()
				)then
			print("DESTRUCTION SEQUENCE: COUNTDOWN: "..count);
			sleep_s(1.35);
		end

	end
	CreateThread(deathstroke);
end
function deathstroke():void
	b_deathstroke = true;
end
function f_countdown_timer()
	print ("countdown timer started");
	for count=20,1, -1 do
		if(volume_test_players(VOLUMES.tv_sentry_ship))then
			cinematic_set_title (TITLES["ch_"..count]);
			sleep_s(2.35);																	-- was 2.1, added 5 seconds
		end
	end
end
function test_any_musketeers_in_kraken():boolean
	for _, musketeer in ipairs (ai_actors(GetMusketeerSquad())) do
		if(volume_test_object(VOLUMES.tv_sentry_ship, musketeer))
		then
			print("musketeers on board");
			return true;
		end
	end
	print("musketeers clear of kraken");
	return false;
end
function ss_recall_banshees():void

	local spot_count:number = 0;
	if(ai_living_count(AI.sq_v2_banshee_0) >= 1)then
		spot_count = spot_count + 1;
		Sleep(2);
		ss_recall_air_control(AI.sq_v2_banshee_0, spot_count);
	end
	if(ai_living_count(AI.sq_v2_banshee_1) >= 1)then
		spot_count = spot_count + 1;
		Sleep(2);
		ss_recall_air_control(AI.sq_v2_banshee_1, spot_count);
	end
	if(ai_living_count(AI.sq_v2_banshee_2) >= 1)then
		spot_count = spot_count + 1;
		Sleep(2);
		ss_recall_air_control(AI.sq_v2_banshee_2, spot_count);
	end
	if(ai_living_count(AI.reinforcement_banshees_1.aisquadspawnpoint1) >= 1)then
		spot_count = spot_count + 1;
		Sleep(2);
		ss_recall_air_control(AI.reinforcement_banshees_1.aisquadspawnpoint1, spot_count);
	end
	if(ai_living_count(AI.reinforcement_banshees_1.aisquadspawnpoint2) >= 1)then
		spot_count = spot_count + 1;
		Sleep(2);
		ss_recall_air_control(AI.reinforcement_banshees_1.aisquadspawnpoint2, spot_count);
	end

end
function rescuebox():void
	repeat

	local rescuethread:thread = nil;

		for _, spartan in ipairs (spartans()) do
			if	(need_rescue(spartan)
				)then
					if(rescuethread == nil)then
						print("initiate rescue.");
						rescuethread = CreateThread(rescue_rangers);
						SleepUntil([| need_rescue(spartan) == false], 30)
						if(IsThreadValid(rescuethread))then
							KillThread(rescuethread);
						end
						Sleep(2);
						rescuethread = nil;
						print("rescue complete.");
					end
			end

		end
		sleep_s(3);
	until(b_ship_destroyed == true);
end
function need_rescue(spartan:object):boolean
	if	(		volume_test_object(VOLUMES.tv_rescuebox_1, spartan)
		and		unit_in_vehicle(spartan) == false
		)then
			return true
		else
			return false
	end
end
function rescue_rangers():void
	print("rescue grace period");
	sleep_s(10);
	for _, spartan in ipairs (spartans()) do
		if	(need_rescue(spartan))
		then
				object_teleport(spartan, FLAGS.tpf_vtol_pad);
				Sleep(2);
				game_save_no_timeout();
		end
	end
end
function ss_recall_air_control(pilot:ai, num:number):void
	if(num == 1)then
		cs_run_command_script(pilot, "cs_ss_recall_1");
	elseif(num == 2)then
		cs_run_command_script(pilot, "cs_ss_recall_2");
	elseif(num == 3)then
		cs_run_command_script(pilot, "cs_ss_recall_3");
	elseif(num == 4)then
		cs_run_command_script(pilot, "cs_ss_recall_4");
	elseif(num == 5)then
		cs_run_command_script(pilot, "cs_ss_recall_5");
	elseif(num == 6)then
		cs_run_command_script(pilot, "cs_ss_recall_6");
	end
end
function kraken_destruction_effects_interior():void
	RunClientScript("fx_dmg_steam");
	RunClientScript("fx_dmg_steam_lower");
	RunClientScript("fx_dmg_steam_mid_lower");
	RunClientScript("fx_dmg_steam_mid");
	RunClientScript("fx_dmg_sparks");
	RunClientScript("fx_dmg_sparks_mid");
	RunClientScript("fx_dmg_sparks_lower");
end
function cs_ss_recall_1():void
	cs_fly_to(POINTS.ps_ss_landing_zones.approach1, 5);
	cs_fly_to(POINTS.ps_ss_landing_zones.p1, 5);
	if(unit_get_vehicle(ai_current_actor) ~= nil)then
		unit_exit_vehicle(ai_current_actor, 0);
	end
end
function cs_ss_recall_2():void
	cs_fly_to(POINTS.ps_ss_landing_zones.approach2, 5);
	cs_fly_to(POINTS.ps_ss_landing_zones.p2, 5);
	if(unit_get_vehicle(ai_current_actor) ~= nil)then
		unit_exit_vehicle(ai_current_actor, 0);
	end
end
function cs_ss_recall_3():void
	cs_fly_to(POINTS.ps_ss_landing_zones.approach3, 5);
	cs_fly_to(POINTS.ps_ss_landing_zones.p3, 5);
	if(unit_get_vehicle(ai_current_actor) ~= nil)then
		unit_exit_vehicle(ai_current_actor, 0);
	end
end
function cs_ss_recall_4():void
	cs_fly_to(POINTS.ps_ss_landing_zones.approach3, 5);
	cs_fly_to(POINTS.ps_ss_landing_zones.p4, 5);
	if(unit_get_vehicle(ai_current_actor) ~= nil)then
		unit_exit_vehicle(ai_current_actor, 0);
	end
end
function cs_ss_recall_5():void
	cs_fly_to(POINTS.ps_ss_landing_zones.approach2, 5);
	cs_fly_to(POINTS.ps_ss_landing_zones.p5, 5);
	if(unit_get_vehicle(ai_current_actor) ~= nil)then
		unit_exit_vehicle(ai_current_actor, 0);
	end
end
function cs_ss_recall_6():void
	cs_fly_to(POINTS.ps_ss_landing_zones.approach1, 5);
	cs_fly_to(POINTS.ps_ss_landing_zones.p6, 5);
	if(unit_get_vehicle(ai_current_actor) ~= nil)then
		unit_exit_vehicle(ai_current_actor, 0);
	end
end
function cs_ss_gunner():void
	SleepUntil(	[|	ai_current_actor ~= nil
					and ai_vehicle_get(ai_current_actor) ~= nil
					], 2);
	
	unit_override_seats_yaw_angles(	ai_vehicle_get(ai_current_actor),			--<unit (object)> 
									-90,										--<yaw min degrees> 
									90);										--<yaw max degrees>)
	unit_override_seats_pitch_angles(	ai_vehicle_get(ai_current_actor),		--<unit (object)> 
									-90,										--<pitch min degrees> 
									90);										--<pitch max degrees>)
	CreateThread(reset_seat_settings_listener, ai_vehicle_get(ai_current_actor));
end
function reset_seat_settings_listener(shade:object):void
	Sleep(10);
	SleepUntil(	[|	unit_has_empty_seat(shade)
				or	b_ship_destroyed == true
				], 10);
	unit_override_seats_yaw_angles(shade, 0, 0);
	unit_override_seats_pitch_angles(shade, 0, 0);
end
function cs_banshee_wing_1a():void
--	cs_vehicle_boost(ai_current_actor, true);
	cs_fly_to(POINTS.ps_ss_banshees.p10a);
	cs_fly_to(POINTS.ps_ss_banshees.p11a);
end
function cs_banshee_wing_1b():void
--	cs_vehicle_boost(ai_current_actor, true);
	cs_fly_to(POINTS.ps_ss_banshees.p10b);
	cs_fly_to(POINTS.ps_ss_banshees.p11b);
end
function cs_banshee_wing_1c():void
--	cs_vehicle_boost(ai_current_actor, true);
	cs_fly_to(POINTS.ps_ss_banshees.p10c);
	cs_fly_to(POINTS.ps_ss_banshees.p11c);
	vehicle_start_trick(unit_get_vehicle(ai_get_object(ai_current_actor)), 0);
end
function cs_banshee_wing_2a():void
	cs_vehicle_boost(ai_current_actor, true);
	cs_fly_to(POINTS.ps_ss_banshees.p0a);
	cs_fly_to(POINTS.ps_ss_banshees.p1a);
	cs_fly_to(POINTS.ps_ss_banshees.p2a);
	vehicle_start_trick(unit_get_vehicle(ai_get_object(ai_current_actor)), 0);
end
function cs_banshee_wing_2b():void
	cs_vehicle_boost(ai_current_actor, true);
	cs_fly_to(POINTS.ps_ss_banshees.p0b);
	cs_fly_to(POINTS.ps_ss_banshees.p1b);
	cs_fly_to(POINTS.ps_ss_banshees.p2b);
end
function cs_banshee_wing_2c():void
	cs_vehicle_boost(ai_current_actor, true);
	cs_fly_to(POINTS.ps_ss_banshees.p1c);
	cs_fly_to(POINTS.ps_ss_banshees.p2c);
end
--[[
	ss_gunner_spawner(AI.sq_ss_gunner_1, "top_turret_1");			--top
	ss_gunner_spawner(AI.sq_ss_gunner_2, "mid_turret_1");			--mid
	ss_gunner_spawner(AI.sq_ss_gunner_3, "mid_turret_2");			--mid
	ss_gunner_spawner(AI.sq_ss_gunner_6, "low_turret_6");
	ss_gunner_spawner(AI.sq_ss_gunner_7, "low_turret_7");
--]]
--[[
 _______   ________  __     __  ________   ______   __       
|       \ |        \|  \   |  \|        \ /      \ |  \      
| $$$$$$$\| $$$$$$$$| $$   | $$| $$$$$$$$|  $$$$$$\| $$      
| $$__| $$| $$__    | $$   | $$| $$__    | $$__| $$| $$      
| $$    $$| $$  \    \$$\ /  $$| $$  \   | $$    $$| $$      
| $$$$$$$\| $$$$$     \$$\  $$ | $$$$$   | $$$$$$$$| $$      
| $$  | $$| $$_____    \$$ $$  | $$_____ | $$  | $$| $$_____ 
| $$  | $$| $$     \    \$$$   | $$     \| $$  | $$| $$     \
 \$$   \$$ \$$$$$$$$     \$     \$$$$$$$$ \$$   \$$ \$$$$$$$$
--]]

function ss_man_the_reveal_guns():void
	ss_gunner_spawner(AI.sq_ss_gunner_1, "top_turret_1");			--top	-- action gunner

	ss_gunner_spawner(AI.sq_ss_gunner_2, "mid_turret_2");			-- if facing ss, left
	ss_gunner_spawner(AI.sq_ss_gunner_3, "mid_turret_1");			-- if facing ss, right

	ss_gunner_spawner(AI.sq_ss_gunner_4, "low_turret_6");			-- action gunner
	ss_gunner_spawner(AI.sq_ss_gunner_5, "low_turret_7");			-- action gunner
	ss_gunner_spawner(AI.sq_ss_gunner_6, "low_turret_5");
	ss_gunner_spawner(AI.sq_ss_gunner_7, "low_turret_8");
	ss_gunner_spawner(AI.sq_ss_gunner_8, "low_turret_1");			-- new 3/17/15
end
function f_warning_shot_test():void
	CreateThread(sentry_show_reset);
	CreateThread(ss_man_the_reveal_guns);
	Sleep(2);
	CreateThread(f_reveal_gunners);
end
function f_reveal_gunners():void
	Sleep(2);
	CreateThread(f_reveal_gunners_sequence);
	ai_set_blind(AI.sq_ss_gunner_1, true);
	ai_set_blind(AI.sq_ss_gunner_2, true);
	ai_set_blind(AI.sq_ss_gunner_3, true);
	ai_set_blind(AI.sq_ss_gunner_4, true);
	ai_set_blind(AI.sq_ss_gunner_5, true);
	ai_set_blind(AI.sq_ss_gunner_6, true);
	ai_set_blind(AI.sq_ss_gunner_7, true);
	ai_set_blind(AI.sq_ss_gunner_8, true);
end
function f_reveal_gunners_sequence():void
	SleepUntil([| var_liftoff_events >=  1],3);										-- soon into composition
	cs_run_command_script(AI.sq_ss_gunner_1, "cs_reveal_shooter_shot_4");			-- 9-1-15AI.sq_ss_gunner_1 upper shoot at fl_dummyfire_4 (in gamespace)
	-- 40 frames
	-- AI.sq_ss_gunner_1 upper shoot at fl_dummyfire_5 (above gamespace) --nm - not implemented because turret can't adfaEFEFAEFno time
	-- 70 more frames
	Sleep(110);
	cs_run_command_script(AI.sq_ss_gunner_3, "cs_reveal_shooter_shot_3");			-- 9-1-15AI.sq_ss_gunner_3 mid right shoot at at fl_dummyfire_3(out)
	SleepUntil([| var_liftoff_events >=  10],3);	
	sleep_s(1);
	CreateThread(f_reveal_gunners_sight_all);					
end
function flagg_test():void
	cs_run_command_script(AI.sq_ss_gunner_1, "cs_reveal_shooter_shot_test");
end
function cs_reveal_shooter_shot_test():void
--	ai_set_blind(ai_current_actor, false);
--	Sleep(2);
--	cs_aim(ai_current_actor, true, POINTS.ps_dummyfire.dummyfire_test);
--	sleep_s(.75);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_dummyfire.dummyfire_test);
	sleep_s(3);
--	ai_set_blind(ai_current_actor, true);
end
function reveal_ss_composition_function_0():void									-- 9-1-15: called from vignette
	cs_run_command_script(AI.sq_ss_gunner_4, "cs_reveal_shooter_shot_2");			-- 9-1-15: AI.sq_ss_gunner_4 lower, left shoot at fl_dummyfire_2 (in gamespace)
	CreateThread(reveal_ss_composition_function_0_pt2);
end
function reveal_ss_composition_function_0_pt2():void								-- 9-1-15: split out to allow for a sleep_s
	sleep_s(1);
	cs_run_command_script(AI.sq_ss_gunner_5, "cs_reveal_shooter_shot_3");			-- 9-1-15: AI.sq_ss_gunner_5 lower, right shoot at fl_dummyfire_3 (out of gamespace)
end
function reveal_ss_composition_function_1():void									-- called from vignette
	cs_run_command_script(AI.sq_ss_gunner_2, "cs_reveal_shooter_shot_1");			-- 9-1-15: AI.sq_ss_gunner_2 mid, left shoot at fl_dummyfire_1
	if(IsServer())then
		print("reveal_ss_composition_function_1");
		if(var_liftoff <= 1)then
			var_liftoff = 2;														--shut off flee
		end
		if(var_liftoff_events <= 4)then
			var_liftoff_events = 4;
		end
	end
--	cs_run_command_script(AI.sq_ss_gunner_3, "cs_reveal_dummyshoot_31");			-- 9-1-15
--	cs_run_command_script(AI.sq_ss_gunner_8, "cs_reveal_dummyshoot_81");			-- 9-1-15
	CreateThread(give_gunship_sight);
end
function reveal_ss_composition_function_2():void
	CreateThread(reveal_ss_composition_function_2_pt2);
end
function reveal_ss_composition_function_2_pt2():void									-- called from vignette
	cs_run_command_script(AI.sq_ss_gunner_2, "cs_reveal_shooter_shot_6");			-- 9-1-15: AI.sq_ss_gunner_2 mid, left shoot at fl_dummyfire_6
	Sleep(48);									
	cs_run_command_script(AI.sq_ss_gunner_3, "cs_reveal_shooter_shot_3");			-- 9-1-15: AI.sq_ss_gunner_3 mid, right shoot at fl_dummyfire_3
	cs_run_command_script(AI.sq_ss_gunner_4, "cs_reveal_shooter_shot_7");			-- 9-1-15: AI.sq_ss_gunner_4 lower, left shoot at fl_dummyfire_7 (in gamespace)
	Sleep(48);									
	cs_run_command_script(AI.sq_ss_gunner_5, "cs_reveal_shooter_shot_8");			-- 9-1-15: AI.sq_ss_gunner_5 lower, right shoot at fl_dummyfire_8 (out of gamespace)
	if(IsServer())then
		print("reveal_ss_composition_function_2");
		if(var_liftoff_events <= 10)then
			var_liftoff_events= 10;
		end
		b_stagger_complete = true;
	end
--	cs_run_command_script(AI.sq_ss_gunner_5, "cs_reveal_dummyshoot_52");
end
function reveal_ss_composition_function_3():void
	if(IsServer())then
		print("reveal_ss_composition_function_3");
		if(var_liftoff <= 3)then
			var_liftoff = 3;
		end
	end
	CreateThread(sleep_n_shoot_1);
end

function f_reveal_gunners_sight_all():void
	ai_set_blind(AI.sq_ss_gunner_1, false);
	ai_set_blind(AI.sq_ss_gunner_2, false);
	ai_set_blind(AI.sq_ss_gunner_3, false);
	ai_set_blind(AI.sq_ss_gunner_4, false);
	ai_set_blind(AI.sq_ss_gunner_5, false);
	ai_set_blind(AI.sq_ss_gunner_6, false);
	ai_set_blind(AI.sq_ss_gunner_7, false);
	ai_set_blind(AI.sq_ss_gunner_8, false);
end
function cs_reveal_shooter_shot_1():void
	ai_set_blind(ai_current_actor, false);
	Sleep(2);
	cs_aim(ai_current_actor, true, POINTS.ps_dummyfire.dummyfire_1);
	sleep_s(.75);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_dummyfire.dummyfire_1);
	sleep_s(3);
	ai_set_blind(ai_current_actor, true);
end
function cs_reveal_shooter_shot_2():void
	ai_set_blind(ai_current_actor, false);
	Sleep(2);
	cs_aim(ai_current_actor, true, POINTS.ps_dummyfire.dummyfire_2);
	sleep_s(.75);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_dummyfire.dummyfire_2);
	sleep_s(3);
	ai_set_blind(ai_current_actor, true);
end
function cs_reveal_shooter_shot_3():void
	ai_set_blind(ai_current_actor, false);
	Sleep(2);
	cs_aim(ai_current_actor, true, POINTS.ps_dummyfire.dummyfire_3);
	sleep_s(.75);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_dummyfire.dummyfire_3);
	sleep_s(3);
	ai_set_blind(ai_current_actor, true);
end
function cs_reveal_shooter_shot_4():void
	ai_set_blind(ai_current_actor, false);
	Sleep(2);
	cs_aim(ai_current_actor, true, POINTS.ps_dummyfire.dummyfire_4);
	sleep_s(.75);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_dummyfire.dummyfire_4);
	sleep_s(3);
	ai_set_blind(ai_current_actor, true);
end
function cs_reveal_shooter_shot_5():void
	ai_set_blind(ai_current_actor, false);
	Sleep(2);
	cs_aim(ai_current_actor, true, POINTS.ps_dummyfire.dummyfire_5);
	sleep_s(.75);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_dummyfire.dummyfire_5);
	sleep_s(3);
	ai_set_blind(ai_current_actor, true);
end
function cs_reveal_shooter_shot_6():void
	ai_set_blind(ai_current_actor, false);
	Sleep(2);
	cs_aim(ai_current_actor, true, POINTS.ps_dummyfire.dummyfire_6);
	sleep_s(.75);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_dummyfire.dummyfire_6);
	sleep_s(3);
	ai_set_blind(ai_current_actor, true);
end
function cs_reveal_shooter_shot_7():void
	ai_set_blind(ai_current_actor, false);
	Sleep(2);
	cs_aim(ai_current_actor, true, POINTS.ps_dummyfire.dummyfire_7);
	sleep_s(.75);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_dummyfire.dummyfire_7);
	sleep_s(3);
	ai_set_blind(ai_current_actor, true);
end
function cs_reveal_shooter_shot_8():void
	ai_set_blind(ai_current_actor, false);
	Sleep(2);
	cs_aim(ai_current_actor, true, POINTS.ps_dummyfire.dummyfire_8);
	sleep_s(.75);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_dummyfire.dummyfire_8);
	sleep_s(3);
	ai_set_blind(ai_current_actor, true);
end
function slim_down_ss_for_reveal():void

	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "top_turret_2"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "top_turret_3"));
	
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "mid_turret_5"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "mid_turret_4"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "mid_turret_3"));
--	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "mid_turret_2"));
--	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "mid_turret_1"));

--	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "low_turret_1"));				-- new 3/17/15
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "low_turret_2"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "low_turret_3"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "low_turret_4"));
--	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "low_turret_8"));

	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "front_leg_shield"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "left_leg_shield"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "right_leg_shield"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "top_weapon_1"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "top_weapon_2"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "top_weapon_3"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "top_weapon_4"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "top_weapon_5"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "top_weapon_6"));
	print("ss object count lightened");
end
--[[
 _______    ______   __       __  _______  
|       \  /      \ |  \     /  \|       \ 
| $$$$$$$\|  $$$$$$\| $$\   /  $$| $$$$$$$\
| $$__| $$| $$__| $$| $$$\ /  $$$| $$__/ $$
| $$    $$| $$    $$| $$$$\  $$$$| $$    $$
| $$$$$$$\| $$$$$$$$| $$\$$ $$ $$| $$$$$$$ 
| $$  | $$| $$  | $$| $$ \$$$| $$| $$      
| $$  | $$| $$  | $$| $$  \$ | $$| $$      
 \$$   \$$ \$$   \$$ \$$      \$$ \$$      
                                                                                  
--]]

function ss_man_the_ramp_guns():void																	
--	ss_gunner_spawner(AI.sq_ss_gunner_1, "top_turret_3");			--top

--	ss_gunner_spawner(AI.sq_ss_gunner_2, "mid_turret_2");			--mid
	ss_gunner_spawner(AI.sq_ss_gunner_3, "mid_turret_3");			--mid
	b_gun_m3 = true;
	ss_gunner_spawner(AI.sq_ss_gunner_4, "mid_turret_4");			--mid
	b_gun_m4 = true;

--	ss_gunner_spawner(AI.sq_ss_gunner_5, "low_turret_2");			--low
	ss_gunner_spawner(AI.sq_ss_gunner_6, "low_turret_3");
	b_gun_l3 = true;
	ss_gunner_spawner(AI.sq_ss_gunner_7, "low_turret_4");
	b_gun_l4 = true;
	ss_gunner_spawner(AI.sq_ss_gunner_8, "low_turret_5");
	b_gun_l5 = true;
	Sleep(2);

	ai_set_blind(AI.sq_ss_gunner_1, true);
	ai_set_blind(AI.sq_ss_gunner_2, true);
	ai_set_blind(AI.sq_ss_gunner_3, true);
	ai_set_blind(AI.sq_ss_gunner_4, true);
	ai_set_blind(AI.sq_ss_gunner_5, true);
	ai_set_blind(AI.sq_ss_gunner_6, true);
--	ai_set_blind(AI.sq_ss_gunner_7, true);
--	ai_set_blind(AI.sq_ss_gunner_8, true);
end
function ramp_gunnersequence_a():void											-- 9-1-15: removed broken rampguard stuff that was more dynamic. Going with hard scripted targets.
	print("gunner action a");
	print("gunner action a");
	print("gunner action a");
	cs_run_command_script(AI.sq_ss_gunner_4, "cs_ramp_shooter_shot_0");
end
function ramp_gunnersequence_b():void											-- 9-1-15: removed broken rampguard stuff that was more dynamic. Going with hard scripted targets.
	print("gunner action b");
	print("gunner action b");
	print("gunner action b");
	cs_run_command_script(AI.sq_ss_gunner_8, "cs_ramp_shooter_shot_1");
	cs_run_command_script(AI.sq_ss_gunner_7, "cs_ramp_shooter_shot_2");
end
function ramp_gunnersequence_c():void											-- 9-1-15: removed broken rampguard stuff that was more dynamic. Going with hard scripted targets.
	print("gunner action c");
	print("gunner action c");
	print("gunner action c");
	cs_run_command_script(AI.sq_ss_gunner_3, "cs_ramp_shooter_shot_3");
	cs_run_command_script(AI.sq_ss_gunner_4, "cs_ramp_shooter_shot_4");
end
function ramp_gunnersequence_d():void											-- 9-1-15: removed broken rampguard stuff that was more dynamic. Going with hard scripted targets.
	print("gunner action d");
	print("gunner action d");
	print("gunner action d");
	cs_run_command_script(AI.sq_ss_gunner_8, "cs_ramp_shooter_shot_5");
	CreateThread(ramp_gunnersequence_d2);
end
function ramp_gunnersequence_d2():void											-- 9-1-15: removed broken rampguard stuff that was more dynamic. Going with hard scripted targets.
	sleep_s(.8);
	print("gunner action d2");
	print("gunner action d2");
	print("gunner action d2");
	cs_run_command_script(AI.sq_ss_gunner_7, "cs_ramp_shooter_shot_6");
	CreateThread(ramp_baffler);
end

-- 1
-- 3 2
-- 5   67   8
function cs_ramp_shooter_shot_0():void
	ai_set_blind(ai_current_actor, false);
	Sleep(2);
	cs_aim(ai_current_actor, true, POINTS.ps_dummyfire.p0);
	sleep_s(.75);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_dummyfire.p0);
	sleep_s(3);
	ai_set_blind(ai_current_actor, true);
end
function cs_ramp_shooter_shot_1():void
	ai_set_blind(ai_current_actor, false);
	Sleep(2);
	cs_aim(ai_current_actor, true, POINTS.ps_dummyfire.p01);
	sleep_s(.75);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_dummyfire.p01);
	sleep_s(3);
--	ai_set_blind(ai_current_actor, true);
end
function cs_ramp_shooter_shot_2():void
	ai_set_blind(ai_current_actor, false);
	Sleep(2);
	cs_aim(ai_current_actor, true, POINTS.ps_dummyfire.p02);
	sleep_s(.75);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_dummyfire.p02);
	sleep_s(3);
--	ai_set_blind(ai_current_actor, true);
end
function cs_ramp_shooter_shot_3():void
	ai_set_blind(ai_current_actor, false);
	Sleep(2);
	cs_aim(ai_current_actor, true, POINTS.ps_dummyfire.p03);
	sleep_s(.75);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_dummyfire.p03);
	sleep_s(3);
	ai_set_blind(ai_current_actor, true);
end
function cs_ramp_shooter_shot_4():void
	ai_set_blind(ai_current_actor, false);
	Sleep(2);
	cs_aim(ai_current_actor, true, POINTS.ps_dummyfire.p04);
	sleep_s(.75);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_dummyfire.p04);
	sleep_s(3);
	ai_set_blind(ai_current_actor, true);
end
function cs_ramp_shooter_shot_5():void
	ai_set_blind(ai_current_actor, false);
	Sleep(2);
	cs_aim(ai_current_actor, true, POINTS.ps_dummyfire.p05);
	sleep_s(.75);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_dummyfire.p05);
	sleep_s(3);
--	ai_set_blind(ai_current_actor, true);
end
function cs_ramp_shooter_shot_6():void
	ai_set_blind(ai_current_actor, false);
	Sleep(2);
	cs_aim(ai_current_actor, true, POINTS.ps_dummyfire.p06);
	sleep_s(.75);
	cs_shoot_at(ai_current_actor, true, POINTS.ps_dummyfire.p06);
	sleep_s(3);
--	ai_set_blind(ai_current_actor, true);
end

function ramp_baffler():void
	CreateThread(ramp_gunner_6);
	repeat
	sleep_s(random_range(2,6));
	
		ai_set_blind(AI.sq_ss_gunner_7, false);
		sleep_s(random_range(2.5,5));
		ai_set_blind(AI.sq_ss_gunner_7, true); -- hangar left
	
	sleep_s(random_range(2,6));

		ai_set_blind(AI.sq_ss_gunner_8, false);
		sleep_s(random_range(2.5,4));
		ai_set_blind(AI.sq_ss_gunner_8, true); -- hangar right

	until(b_ss_out);
	ai_set_blind(AI.sq_ss_gunner_3, true);
	ai_set_blind(AI.sq_ss_gunner_4, true);

	ai_set_blind(AI.sq_ss_gunner_7, true);
	ai_set_blind(AI.sq_ss_gunner_8, true);
end
function ramp_gunner_6():void
	SleepUntil([| 	var_ramp_objcon >= 40],10);
	ai_set_blind(AI.sq_ss_gunner_6, false);
	SleepUntil([| 	b_ss_out ],10);
	ai_set_blind(AI.sq_ss_gunner_6, true);
end

--[[						
function cs_ramp_fire_warning_shot():void
	print("cs_ramp_fire_warning_shot");
	local targetspot:vector = CalculateFirePosition	(								-- <vector>
													var_warning_shot_target,		-- player <object>
													FLAGS.fl_ramp_1,				-- <direction point> 
													3,								-- distance offset <number, wu>
													2								-- target's location in x time <number, seconds>
													);
	
	cs_shoot_at(	ai_current_actor,												--	shooter <object>
					true,															--	<bool>
					targetspot);													--	<vector>
	sleep_s(2);
end

														-- couldn't get this to work. hence the below
function ramp_pick_a_player(vol:volume):void
	local bro:object_list = nil
	bro = volume_return_objects(vol);
	var_warning_shot_target = list_get(bro, 0);
	print(list_get(bro, 0));
end
--]]




-- turret persistence between ramp and boss
global b_gun_t3:boolean = true;
global b_gun_m3:boolean = true;
global b_gun_m4:boolean = true;
global b_gun_l3:boolean = true;
global b_gun_l4:boolean = true;
global b_gun_l5:boolean = true;
global b_ss_out:boolean = false;
function evaluate_guns_at_end_of_ramp():void												-- there's probably a better way to do this
	b_ss_out = true;																		-- turns off guns
	if	(object_get_health(object_at_marker(OBJECTS.vin_sent_machine, "top_turret_3")) <= 0) then
		b_gun_t3 = false;
	end
	if	(object_get_health(object_at_marker(OBJECTS.vin_sent_machine, "mid_turret_3")) <= 0) then
		b_gun_m3 = false;
	end
	if	(object_get_health(object_at_marker(OBJECTS.vin_sent_machine, "mid_turret_4")) <= 0) then
		b_gun_m4 = false;
	end
	if	(object_get_health(object_at_marker(OBJECTS.vin_sent_machine, "low_turret_3")) <= 0) then
		b_gun_l3 = false;
	end
	if	(object_get_health(object_at_marker(OBJECTS.vin_sent_machine, "low_turret_4")) <= 0) then
		b_gun_l4 = false;
	end
	if	(object_get_health(object_at_marker(OBJECTS.vin_sent_machine, "low_turret_5")) <= 0) then
		b_gun_l5 = false;
	end
 end

--	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "top_turret_3"));
--	object_get_health(object_at_marker(OBJECTS.vin_sent_machine, "top_turret_3"));

function slim_down_ss_for_ramp():void
	-- new: keep 3 or 2?
	-- 6/25/15 - removed 3 as well
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "top_turret_1"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "top_turret_2"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "top_turret_3"));
	
	-- new: remove 1, keep 2 3 4
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "mid_turret_1"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "mid_turret_5"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "mid_turret_6"));

	-- keep 3, 4, 5, lose 6+
	-- 6/25/15 - removed 2 as well
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "low_turret_1"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "low_turret_2"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "low_turret_6"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "low_turret_7"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "low_turret_8"));

	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "front_leg_shield"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "left_leg_shield"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "right_leg_shield"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "top_weapon_1"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "top_weapon_2"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "top_weapon_3"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "top_weapon_4"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "top_weapon_5"));
	object_destroy(object_at_marker(OBJECTS.vin_sent_machine, "top_weapon_6"));
	print("ss object count lightened");
end
--[[
  ______    ______   __       __  __       __   ______   __    __ 
 /      \  /      \ |  \     /  \|  \     /  \ /      \ |  \  |  \
|  $$$$$$\|  $$$$$$\| $$\   /  $$| $$\   /  $$|  $$$$$$\| $$\ | $$
| $$   \$$| $$  | $$| $$$\ /  $$$| $$$\ /  $$$| $$  | $$| $$$\| $$
| $$      | $$  | $$| $$$$\  $$$$| $$$$\  $$$$| $$  | $$| $$$$\ $$
| $$   __ | $$  | $$| $$\$$ $$ $$| $$\$$ $$ $$| $$  | $$| $$\$$ $$
| $$__/  \| $$__/ $$| $$ \$$$| $$| $$ \$$$| $$| $$__/ $$| $$ \$$$$
 \$$    $$ \$$    $$| $$  \$ | $$| $$  \$ | $$ \$$    $$| $$  \$$$
  \$$$$$$   \$$$$$$  \$$      \$$ \$$      \$$  \$$$$$$  \$$   \$$
--]]

function ss_gunner_spawner(driver:ai, marker:string):void
	ai_place(driver);
	Sleep(2);
	vehicle_load_magic (object_at_marker(OBJECTS.vin_sent_machine, marker), "", driver);
end
function ss_gunner_spawner_2(driver:ai, marker:string):void
	ai_place(driver);
	Sleep(2);
	vehicle_load_magic (object_at_marker(OBJECTS.vin_sent_machine_2, marker), "", driver);
end

--[[
  ______    ______   __       __  _______    ______    ______   ______  ________  ______   ______   __    __        __    __   ______    ______   __    __   ______  
 /      \  /      \ |  \     /  \|       \  /      \  /      \ |      \|        \|      \ /      \ |  \  |  \      |  \  |  \ /      \  /      \ |  \  /  \ /      \ 
|  $$$$$$\|  $$$$$$\| $$\   /  $$| $$$$$$$\|  $$$$$$\|  $$$$$$\ \$$$$$$ \$$$$$$$$ \$$$$$$|  $$$$$$\| $$\ | $$      | $$  | $$|  $$$$$$\|  $$$$$$\| $$ /  $$|  $$$$$$\
| $$   \$$| $$  | $$| $$$\ /  $$$| $$__/ $$| $$  | $$| $$___\$$  | $$     | $$     | $$  | $$  | $$| $$$\| $$      | $$__| $$| $$  | $$| $$  | $$| $$/  $$ | $$___\$$
| $$      | $$  | $$| $$$$\  $$$$| $$    $$| $$  | $$ \$$    \   | $$     | $$     | $$  | $$  | $$| $$$$\ $$      | $$    $$| $$  | $$| $$  | $$| $$  $$   \$$    \ 
| $$   __ | $$  | $$| $$\$$ $$ $$| $$$$$$$ | $$  | $$ _\$$$$$$\  | $$     | $$     | $$  | $$  | $$| $$\$$ $$      | $$$$$$$$| $$  | $$| $$  | $$| $$$$$\   _\$$$$$$\
| $$__/  \| $$__/ $$| $$ \$$$| $$| $$      | $$__/ $$|  \__| $$ _| $$_    | $$    _| $$_ | $$__/ $$| $$ \$$$$      | $$  | $$| $$__/ $$| $$__/ $$| $$ \$$\ |  \__| $$
 \$$    $$ \$$    $$| $$  \$ | $$| $$       \$$    $$ \$$    $$|   $$ \   | $$   |   $$ \ \$$    $$| $$  \$$$      | $$  | $$ \$$    $$ \$$    $$| $$  \$$\ \$$    $$
  \$$$$$$   \$$$$$$  \$$      \$$ \$$        \$$$$$$   \$$$$$$  \$$$$$$    \$$    \$$$$$$  \$$$$$$  \$$   \$$       \$$   \$$  \$$$$$$   \$$$$$$  \$$   \$$  \$$$$$$ 
--]]

function sentry_end_composition_script_1():void
	print("hook 1");
end
function sentry_end_composition_script_2():void
	print("hook 2");
end
function sentry_end_composition_script_3():void
	print("hook 3");
end
function sentry_end_composition_script_4():void
	print("hook  4");
end
function sentry_end_composition_script_5():void
	print("hook  5");
end
function sentry_end_composition_script_6():void
	print("hook  6");
end
function sentry_end_composition_script_7():void
	print("hook  7");
	CreateThread(scatter_crevice_flock);
end
function sentry_end_composition_script_8():void
	print("hook 8 ");
	if(IsServer())then
		print("man the guns");
		CreateThread(ss_man_the_guns_v2);
		CreateThread(delay_then_give_all_gunners_sight);
		b_ss_spawn_hack = true;																		-- spawn enemies
	end
	Sleep(190);
	ai_place(AI.gr_v2_magic_banshees);
end
function sentry_composition_stasis():void
	print("hook 1 END ");
	if(IsServer())then
		print("stasis");
		if(b_sentry_end_test == false)then
			var_go_time = true;
			f_sentry_stasis();
		end
	end
end
function sentry_end_composition_action_3_1():void
	print("SECAS 1 ");
	CreateThread(faux_start_return_goal);
end
function sentry_end_composition_action_3_6():void
	print("SECAS 6 ");
	CreateThread(end_sentry_start_soldier);
end
function sentry_end_composition_action_3_7():void
	print("SECAS 7 ");
end
function clawkill_1():void
	kill_volume_enable(VOLUMES.kill_back_right_claw);
end
function clawkill_1_end():void
	kill_volume_disable(VOLUMES.kill_back_right_claw);
end
function clawkill_2():void
	kill_volume_enable(VOLUMES.kill_front_claw);
end
function clawkill_2_end():void
	kill_volume_disable(VOLUMES.kill_front_claw);
end
function clawkill_3():void
	kill_volume_enable(VOLUMES.kill_back_left_claw);
end
function clawkill_3_end():void
	kill_volume_disable(VOLUMES.kill_back_left_claw);
end
function interior_player_killer():void
	for _, spartan in ipairs (spartans()) do
		if(volume_test_object(VOLUMES.tv_ss_all, spartan))then
			print(spartan, " in kill zone. Kill them.");
			if(IsPlayer(spartan))then
				RunClientScript("player_explosion", spartan);										-- play fx in the players face
				CreateThread(delayed_fade, unit_get_player(spartan));
			end
		end
	end
end
function delayed_fade(spartan:player)
	Sleep(30);
	fade_out_for_player(spartan);
end

function change_collision():void															-- called from composition
	ObjectSetCollisionLayer(OBJECTS.vin_sent_machine_2, "nothing");
	RunClientScript("client_change_collision");
end
-- old, unused, I think:
function reveal_warning_shot_evaluator	(gunner:ai):void											-- there's actually a reason for doing it this way
	if		(	volume_test_object(VOLUMES.tv_warning_shot_a, PLAYERS.player0) and
				not(var_warning_shot_target == PLAYERS.player0))then
		print("warning shot: player 1, zone a");
		var_warning_shot_target = PLAYERS.player0;													-- there's a reason for this nonsense too!
		var_warning_shot_flag = FLAGS.fl_reveal_direction_1;										-- and this
	elseif	(	volume_test_object(VOLUMES.tv_warning_shot_b, PLAYERS.player0) and
				not(var_warning_shot_target == PLAYERS.player0)) then
		print("warning shot: player 1, zone b");
		var_warning_shot_target = PLAYERS.player0;
		var_warning_shot_flag = FLAGS.fl_reveal_direction_2;
	elseif	(	volume_test_object(VOLUMES.tv_warning_shot_a, PLAYERS.player1) and
				not(var_warning_shot_target == PLAYERS.player1)) then
		print("warning shot: player 2, zone a");
		var_warning_shot_target = PLAYERS.player1;
		var_warning_shot_flag = FLAGS.fl_reveal_direction_1;
	elseif	(	volume_test_object(VOLUMES.tv_warning_shot_b, PLAYERS.player1) and
				not(var_warning_shot_target == PLAYERS.player1)) then
		print("warning shot: player 2, zone b");
		var_warning_shot_target = PLAYERS.player1;
		var_warning_shot_flag = FLAGS.fl_reveal_direction_2;
	elseif	(	volume_test_object(VOLUMES.tv_warning_shot_a, PLAYERS.player2) and
				not(var_warning_shot_target == PLAYERS.player2)) then
		print("warning shot: player 3, zone a");
		var_warning_shot_target = PLAYERS.player2;
		var_warning_shot_flag = FLAGS.fl_reveal_direction_1;
	elseif	(	volume_test_object(VOLUMES.tv_warning_shot_b, PLAYERS.player2) and
				not(var_warning_shot_target == PLAYERS.player2)) then
		print("warning shot: player 3, zone b");
		var_warning_shot_target = PLAYERS.player2;
		var_warning_shot_flag = FLAGS.fl_reveal_direction_2;
	elseif	(	volume_test_object(VOLUMES.tv_warning_shot_a, PLAYERS.player3) and
				not(var_warning_shot_target == PLAYERS.player3)) then
		print("warning shot: player 4, zone a");
		var_warning_shot_target = PLAYERS.player3;
		var_warning_shot_flag = FLAGS.fl_reveal_direction_1;
	elseif	(	volume_test_object(VOLUMES.tv_warning_shot_b, PLAYERS.player3) and
				not(var_warning_shot_target == PLAYERS.player3)) then
		print("warning shot: player 4, zone b");
		var_warning_shot_target = PLAYERS.player3;
		var_warning_shot_flag = FLAGS.fl_reveal_direction_2;
	else
		print("warning shot: no zone, target random player");
		local dice = random_range(1,4);
		if		(dice == 1)then
			var_warning_shot_target = PLAYERS.player0;
		elseif	(dice == 2)then
			var_warning_shot_target = PLAYERS.player1;
		elseif	(dice == 3)then
			var_warning_shot_target = PLAYERS.player2;
		elseif	(dice == 4)then
			var_warning_shot_target = PLAYERS.player3;
		end
		var_warning_shot_flag = FLAGS.fl_reveal_direction_1;
	end
	
	cs_run_command_script(gunner, "cs_fire_warning_shot");
end
function test_warning_shots():void
	var_warning_shot_target = PLAYERS.player0;													-- there's a reason for this nonsense too!
	var_warning_shot_flag = FLAGS.fl_reveal_direction_1;										-- and this
	cs_run_command_script(AI.sq_ss_gunner_1, "cs_fire_warning_shot");
	cs_run_command_script(AI.sq_ss_gunner_3, "cs_fire_warning_shot");
	cs_run_command_script(AI.sq_ss_gunner_8, "cs_fire_warning_shot");
end
function cs_fire_warning_shot():void
	print("cs_fire_warning_shot");
	ai_set_blind(ai_current_actor, false);
	Sleep(2);
	local targetspot:vector = CalculateFirePosition	(								-- <vector>
													var_warning_shot_target,		-- player <object>
													var_warning_shot_flag,			-- <direction point> 
													2,								-- distance offset <number, wu>
													1								-- target's location in x time <number, seconds>
													);
	
--	cs_shoot(ai_current_actor, true, var_warning_shot_target);
	cs_shoot_at(	ai_current_actor,												--	shooter <object>
					true,															--	<bool>
					targetspot);													--	<vector>

--[[
	cs_shoot_at(	var_warning_shot_target,										--	player <object>
					true,															--	<bool>
					targetspot);													--	<vector>
--]]
	sleep_s(2);
	ai_set_blind(ai_current_actor, true);
end


--## CLIENT 
function remoteClient.client_change_collision():void															-- called from composition
	ObjectSetCollisionLayer(OBJECTS.vin_sent_machine_2, "nothing");
end
function remoteClient.player_explosion(deadplayer:object):void
	--play explosions
	effect_new_on_object_marker (TAG('fx\library\sandbox\explosions\covenant_explosion_huge\covenant_explosion_huge.effect'), deadplayer, "drop");
	Sleep(15)
	effect_new_on_object_marker (TAG('fx\library\sandbox\explosions\covenant_explosion_huge\covenant_explosion_huge.effect'), deadplayer, "drop");
	Sleep(15)
	effect_new_on_object_marker (TAG('fx\library\sandbox\explosions\covenant_explosion_huge\covenant_explosion_huge.effect'), deadplayer, "drop");
--	damage_object (deadplayer, "head", 2000);		--	--	--	--	--	--	REPLACE WITH REVIVE BYPASS
end
function remoteClient.crevice_flock_client():void
	flock_destination_set_enabled("crevice_flock", "sink0", false);
	flock_destination_set_enabled("crevice_flock", "sink1", false);
	flock_destination_set_enabled("crevice_flock", "sink2", false);
	print("BIRDS. COME BACK. I DIDNT MEAN IT");
	flock_start("crevice_flock");
	sleep_s(3);
	flock_stop("crevice_flock");
end
function remoteClient.crevice_flock_client_shoo():void
	print("BIRDS. GO HOME BIRDS. YOU'RE DRUNK");
	flock_change_destination("crevice_flock", "circle0", "sink0");
	flock_change_destination("crevice_flock", "circle1", "sink1");
	flock_change_destination("crevice_flock", "circle2", "sink2");
	flock_change_destination("crevice_flock", "circle3", "sink0");
	flock_change_destination("crevice_flock", "circle4", "sink1");
	flock_change_destination("crevice_flock", "circle5", "sink2");
end
