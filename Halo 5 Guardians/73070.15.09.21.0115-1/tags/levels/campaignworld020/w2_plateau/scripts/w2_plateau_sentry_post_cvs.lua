-- ///==========// Plateau Sentry Ship Boss Battle //======////
--## SERVER
global var_go_time:boolean = false;

function start_boss_fight_v2():void
	game_save_no_timeout();
	CreateThread(v2_populate);
	CreateThread(v2_populate_ongoing);
--	CreateThread(sentry_baffle_cycler);
--	object_create_anew("veh_v2_banshee_1");								-- v2
	Sleep(2);
--	CreateThread(delay_then_give_all_gunners_sight);
end


function ss_man_the_guns_v2():void

	if(b_gun_t3 == false) then																	-- i.e. was this destroyed during ramp?
		object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "top_turret_3"))
	else
		ss_gunner_spawner_2(AI.squads_deck_turrets_03, "top_turret_3");
	end
--[[		-- backside turrets; removed to create the rear path
	if(b_gun_m3 == false) then
		object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "mid_turret_3"))
	else
		ss_gunner_spawner(AI.squads_deck_03_turret_01, "mid_turret_3");			-- remove
	end
	if(b_gun_m4 == false) then
		object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "mid_turret_4"))
	else
		ss_gunner_spawner(AI.squads_deck_01_turret_02, "mid_turret_4");			-- remove
	end
--]]
	if(b_gun_l3 == false) then																	-- i.e. was this destroyed during ramp?
		object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "low_turret_3"))
	else
		ss_gunner_spawner_2(AI.squads_mid_turrets_03, "low_turret_3");
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

	Sleep(10);
	CreateThread(ss_limit_all_firing_arcs);
	SleepUntil([|	volume_test_players(VOLUMES.tv_back_2)
				or	volume_test_players(VOLUMES.tv_back_3)
				], 5);
	if(b_gun_l4 == false) then																	-- i.e. was this destroyed during ramp?
		object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "low_turret_4"));
	else
		ss_gunner_spawner_2(AI.squads_mid_turrets_04, "low_turret_4");
		cs_run_command_script(AI.squads_mid_turrets_04, "cs_ss_gunner");
	end
	if(b_gun_l5 == false) then																	-- i.e. was this destroyed during ramp?
		object_destroy(object_at_marker(OBJECTS.vin_sent_machine_2, "low_turret_5"));
		cs_run_command_script(AI.squads_mid_turrets_05, "cs_ss_gunner");
	else
		ss_gunner_spawner_2(AI.squads_mid_turrets_05, "low_turret_5");
	end
end
function vtol_surf_listener():void									-- not called until core is detroyed
	repeat
		for _,playa in pairs (players()) do		
			if(	volume_test_object(VOLUMES.tv_ss_surf_achievement, playa)	)	-- is player in volume that encompasses kraken?
			then
				vtol_surf_checker(playa);
			end
		end
		Sleep(10);
	until(b_deathstroke == true)									-- destruction sequence complete
end
function vtol_surf_checker(spartan:object):void			-- pass in a spartan that is in the volume that encompasses kraken
	local t_vtols:table =									-- all possible vtols in kraken encounter
		{
			"vtol1",
			"vtol2",
			"vtol1b",
			"vtol2b",
		};

	for _,name  in ipairs(t_vtols) do							-- iterate through vtols
		local v: object = ObjectFromName(name);				
		if	(	v and vehicle_driver (v) ~= nil)				-- is vtol valid and being piloted?
		then
			if (	unit_is_surfing_on_vehicle(spartan, v)		-- is the spartan surfing it?
				and	unit_in_vehicle(spartan) == false			
				)
			then
				print(" DINGDINGDING - VTOL BEING SURFED");
				print(" DINGDINGDING - VTOL BEING SURFED");
				print(" DINGDINGDING - VTOL BEING SURFED");
				CampaignScriptedAchievementUnlocked(16);
				print(" ACHIEVEMENT UNLOCKED - EMERGENCY BOARDING PROCEDURES");
--			else
--				print(" vtol not being surfed");
			end
--		else
--			print(" vtol doesn't meet requirements");
		end
	end
end
function kraken_lackin():void
	if	(	-- phantom landing pads:
			object_get_health(object_at_marker(OBJECTS.vin_sent_machine_2, "top_turret_1")) > 0
		and	object_get_health(object_at_marker(OBJECTS.vin_sent_machine_2, "top_turret_2")) > 0
		and	object_get_health(object_at_marker(OBJECTS.vin_sent_machine_2, "top_turret_3")) > 0
			-- upper deck (note 3 and 4 are excluded intentionally)
		and	object_get_health(object_at_marker(OBJECTS.vin_sent_machine_2, "mid_turret_1")) > 0
		and	object_get_health(object_at_marker(OBJECTS.vin_sent_machine_2, "mid_turret_2")) > 0
		and	object_get_health(object_at_marker(OBJECTS.vin_sent_machine_2, "mid_turret_5")) > 0
		and	object_get_health(object_at_marker(OBJECTS.vin_sent_machine_2, "mid_turret_6")) > 0
			-- body
		and	object_get_health(object_at_marker(OBJECTS.vin_sent_machine_2, "low_turret_1")) > 0
		and	object_get_health(object_at_marker(OBJECTS.vin_sent_machine_2, "low_turret_2")) > 0
		and	object_get_health(object_at_marker(OBJECTS.vin_sent_machine_2, "low_turret_3")) > 0
		and	object_get_health(object_at_marker(OBJECTS.vin_sent_machine_2, "low_turret_4")) > 0
		and	object_get_health(object_at_marker(OBJECTS.vin_sent_machine_2, "low_turret_5")) > 0
		and	object_get_health(object_at_marker(OBJECTS.vin_sent_machine_2, "low_turret_6")) > 0
		and	object_get_health(object_at_marker(OBJECTS.vin_sent_machine_2, "low_turret_7")) > 0
		and	object_get_health(object_at_marker(OBJECTS.vin_sent_machine_2, "low_turret_8")) > 0
		) then
		print("ALLLLLLLLLLL GOOD");
		print("ALLLLLLLLLLL GOOD");
		print("ALLLLLLLLLLL GOOD");
		print("ALLLLLLLLLLL GOOD");
		print("ALLLLLLLLLLL GOOD");
		print("Queue up Achievement");
		CreateThread(kraken_lackin_awarded);
	else
		print("ONE OR MORE DEAD");
		print("ONE OR MORE DEAD");
		print("ONE OR MORE DEAD");
		print("ONE OR MORE DEAD");
		print("ONE OR MORE DEAD");
		print("ONE OR MORE DEAD");
		print("ONE OR MORE DEAD");
	end
end
function kraken_lackin_awarded():void
		SleepUntil([| b_mission_done],20);
		print("Achievement Unlocked:Kraken Lackin");
		print("Achievement Unlocked:Kraken Lackin");
		print("Achievement Unlocked:Kraken Lackin");
		print("Achievement Unlocked:Kraken Lackin");
		print("Achievement Unlocked:Kraken Lackin");
		print("Achievement Unlocked:Kraken Lackin");
		print("Achievement Unlocked:Kraken Lackin");
		print("Achievement Unlocked:Kraken Lackin");
		print("Achievement Unlocked:Kraken Lackin");
		print("Achievement Unlocked:Kraken Lackin");
		print("Achievement Unlocked:Kraken Lackin");
		print("Achievement Unlocked:Kraken Lackin");
		print("Achievement Unlocked:Kraken Lackin");
		CampaignScriptedAchievementUnlocked(15); 								-- Complete Enemy Lines without destroying a Kraken turret.
end
function v2_populate():void
--	ai_place(AI.gr_v2_magic_banshees);
	CreateThread(initial_deck_troops);
end
---------------------------- ======================================================== -----------------------------------
---------------------------- ======================================================== -----------------------------------
---------------------------- ================ The Great Encounter Update ============ -----------------------------------
---------------------------- ======================  8-5-2015  ====================== -----------------------------------
---------------------------- ======================================================== -----------------------------------
function initial_deck_troops():void
	SleepUntil([| volume_test_players(VOLUMES.tv_kraken_approach)
				or	ai_living_count(AI.gr_sentry_all) <= 14	
				],20);
	CreateThread(ongoing_deck_populator);
end
function ongoing_deck_populator():void
	local lets_not_overdo_it:number = 0;

	ai_place(AI.sq_v2_deck_1);										-- initial Squad
	lets_not_overdo_it = lets_not_overdo_it + 1;
	Sleep(5);
	if(ai_living_count(AI.gr_sentry_all) <= 17)then
		ai_place(AI.sq_v2_deck_2);									-- bigger initial squad, if we have room for them
		lets_not_overdo_it = lets_not_overdo_it + 1;
	end

	repeat
		SleepUntil([|ai_living_count(AI.gr_sentry_all) <= 17],5);
			if	(		(ai_living_count(AI.gr_v2_deck) <= 4)
				and		(lets_not_overdo_it <= 5)
				and		(var_boss_objcon <= 0)
				and		(object_get_health(object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1")) >= 0.1)
				)	then
				if		(lets_not_overdo_it <= 1)then
					ai_place(AI.sq_v2_deck_2);
				elseif	(lets_not_overdo_it <= 2)then
					ai_place(AI.sq_v2_deck_3);
				elseif	(lets_not_overdo_it <= 3)then
					ai_place(AI.sq_v2_deck_4);
				elseif	(lets_not_overdo_it <= 4)then
					ai_place(AI.sq_v2_deck_5);
				end
				lets_not_overdo_it = lets_not_overdo_it + 1;
			end
			sleep_s(1);
	until	(	(var_boss_objcon >= 30)	or			-- tv_armory
				(lets_not_overdo_it >= 5) or
				(object_get_health(object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1")) <= 0.05)
			);
end
-- helper stuff:
function ticker_kraken_population():void
	SleepUntil([|	ai_living_count(AI.gr_sentry_all) >= 1], 5);
	sleep_s(5);
	local baseline:number = ai_living_count(AI.gr_sentry_all)
	local countup:number = 0;
	print("baseline == ", baseline);
	repeat
		sleep_s(1);
		print("gr_sentry_all == ", ai_living_count(AI.gr_sentry_all));
		countup = countup + 1;
		if(countup >= 20)then
			print("=====================");
			print("baseline == ", baseline);
			print("deck == ", ai_living_count(AI.gr_v2_deck));
			print("=====================");
			countup = 0;
		end
	until(false);
end

---------------------------- ======================================================== -----------------------------------
---------------------------- ======================================================== -----------------------------------
---------------------------- ======================================================== -----------------------------------

function v2_populate_ongoing():void
	SleepUntil([|	ai_living_count(AI.gr_v2_banshee) <= 1 ]);
	if	(	b_ship_destroyed ==	false
		and	var_boss_objcon	<= 30
		) then
		CreateThread(banshee_reinforcements);
	end
end
function navmesh_prep_plateau():void
	object_destroy(OBJECTS.keyhole_shield_1);				-- kill aperture door
	object_destroy(OBJECTS.dm_obelisk_entry_door);			-- kill soldier room door 1
	object_destroy(OBJECTS.dm_obelisk_entry_door_2);		-- kill soldier room door 2
	CreateThread(put_sentry_in_place);						
	sleep_s(1);
	CreateThread(open_hangar_door);
end
