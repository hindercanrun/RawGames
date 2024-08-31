--## SERVER

--Owner: 
--343 industries
-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ UNCOMFIRED REPORTS *_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*

---------------------------------------------------------------
---------------------------------------------------------------
-- QUARRY
---------------------------------------------------------------
---------------------------------------------------------------


---------------------------------------------------------------
---------------------------------------------------------------
--GLOBAL VARS
---------------------------------------------------------------
---------------------------------------------------------------
global b_ur_lead_miner_ready = false;
global b_ur_lead_miner_ready_pause = false;
global b_ur_lead_miner_end_loop = false;
global b_ur_lead_miner_vaporize = false;
global b_ur_quarry_audio_combat_start = false;
global b_ur_quarry_audio_combat_stop = false;
global b_ur_quarry_backup_wave_done = false;
global b_ur_quarry_sniper_backup_done = false;
global b_ur_quarry_sniper_door_open = false;

--[[
   ______            __        ____                             
  / ____/___  ____ _/ /  _    / __ \__  ______ _____________  __
 / / __/ __ \/ __ `/ /  (_)  / / / / / / / __ `/ ___/ ___/ / / /
/ /_/ / /_/ / /_/ / /  _    / /_/ / /_/ / /_/ / /  / /  / /_/ / 
\____/\____/\__,_/_/  (_)   \___\_\__,_/\__,_/_/  /_/   \__, /  
                                                       /____/   
                                                                                                      
--]]            
UnconfirmedReports.goal_quarry = 
{
	--ends the goal
	gotoVolume = VOLUMES.tv_ur_airlock_trans,
	
	--this is the next goal name
	next={"goal_upper_mines"},
	
	-- the zoneset the goal starts in
	zoneSet = ZONE_SETS.zs010_chiefship,
	
	-- checkpoints the player will teleport to in a blink and spawn in if they are all wiped
	checkPoints = POINTS.ps_ur_checkpoint_quarry,
}

-- temp text display
function f_player_area_text(  text:string ):void
	clear_all_text();
	set_text_defaults();
	set_text_color(1, 1, 1, 1);
	set_text_lifespan(150);
	set_text_font(FONT_ID.terminal);
	set_text_justification(TEXT_JUSTIFICATION.center);
	set_text_alignment(TEXT_ALIGNMENT.center);
	set_text_scale(1);
	set_text_margins(0, 0.12, 0, 0);
	set_text_shadow_style(TEXT_DROP_SHADOW.drop);	
	show_text ( text );
end

function UnconfirmedReports.goal_quarry.Start() :void            
	print ("starting goal quarry start");
	GoalCreateThread( UnconfirmedReports.goal_quarry, f_ur_spawn_quarry_01 );
	--GoalCreateThread( UnconfirmedReports.goal_quarry, f_ur_spawn_quarry_02 );
	--GoalCreateThread( UnconfirmedReports.goal_quarry, f_blip_tracking_door );
	--GoalCreateThread (UnconfirmedReports.goal_quarry, VinQuarryPawns);
	--put everything here	
	f_unblip_object ( OBJECTS.dc_door_ship_tracking_01 );
	CreateThread(nar_unconfirmed_snipers);
	CreateThread(f_ur_breadcrumbs_quarry);
	--CreateThread(audio_unconfirmedreports_thread_up_quarry);
	sleep_s(1);
	if object_valid("s_ur_breadcrumb_01") then
		object_destroy(OBJECTS.s_ur_breadcrumb_01);
	end
end

--BLIP TRACKING DOOR
--function f_blip_tracking_door()
--	--f_blip_flag ( FLAGS.flag_ship_door_01 );
--	--SleepUntil([| volume_test_players(VOLUMES.tv_ur_tracking_door) ], 1);	
--	--f_unblip_flag ( FLAGS.flag_ship_door_01 );
--end

--SPAWN QUARRY
function f_ur_spawn_quarry_01()
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_tracking_door) ], 15);
		ai_place(AI.sq_ur_quarry_snipers_general);
		composer_play_show("vin_un_reports_miner_sniper_warning");
		NavpointShowAllServer(AI.miner_pinned_by_snipers, "ally");
		
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_quarry_start) ], 15);
		b_ur_lead_miner_end_loop = true;
		game_save_no_timeout();
		ObjectSetSpartanTrackingEnabled(OBJECTS.sc_ammo_quarry_01, true);
		ObjectSetSpartanTrackingEnabled(OBJECTS.sc_ammo_quarry_02, true);
		CreateThread(muskbox, VOLUMES.tv_q_musk_01, FLAGS.cf_musk_01_01, 3, FLAGS.cf_musk_01_02, 3, UnconfirmedReports.goal_quarry);
		CreateThread(muskbox, VOLUMES.tv_q_musk_02, FLAGS.cf_musk_02_01, 3, FLAGS.cf_musk_02_02, 3, UnconfirmedReports.goal_quarry);
		CreateThread(muskbox, VOLUMES.tv_q_musk_03, FLAGS.cf_musk_03_01, 3, FLAGS.cf_musk_03_02, 3, UnconfirmedReports.goal_quarry);		
		
	-- make the marines from the lower platform vulnerable
	--ai_cannot_die(AI.sq_ur_mid_level_marines, false);
	--ai_cannot_die(AI.sq_ur_mid_level_marines_lead, false);
	
	Sleep(1);
	CreateThread(f_ur_quarry_miner_saved_backup);
	ai_place(AI.sq_ur_q_snipers_l_01);
	ai_place(AI.sq_ur_q_snipers_l_02);
	--CreateThread( SlipSpaceSpawn, AI.sq_ur_q_snipers_l_01 );
	--CreateThread( SlipSpaceSpawn, AI.sq_ur_q_snipers_l_02 );
	sleep_s(3);
	CreateThread( SlipSpaceSpawn, AI.sq_ur_q_snipers_r_01 );
	CreateThread( SlipSpaceSpawn, AI.sq_ur_q_snipers_r_02 );
	
	sleep_s(5);
	game_save_no_timeout();
	CreateThread(f_ur_quarry_pawn_backup_wave);
	CreateThread(f_ur_quarry_sniper_backup);
	
	SleepUntil ([|b_ur_quarry_backup_wave_done == true and b_ur_quarry_sniper_backup_done == true], 30);

	SleepUntil([| ai_living_count( AI.sg_ur_quarry_enemy_all ) <= 0 ], 30);
	game_save_no_timeout();
	sleep_s(2);
	prepare_to_switch_to_zone_set(ZONE_SETS.zs020_cave);
	sleep_s(3);
	game_save_no_timeout();
	sniper_battle_complete = true;
	b_ur_quarry_audio_combat_stop = true;
	sleep_s(4);
	game_save_no_timeout();
	SleepUntil([| volume_test_players(VOLUMES.tv_quarry_open_back_door) ], 30);
	CreateThread(f_ur_upper_mines_airlock);  -- in Uppermines script
end

function f_ur_quarry_sloan_opens_door():void
	device_set_power(OBJECTS.quarry_door_airlock_enter, 1);
	device_set_position(OBJECTS.quarry_door_airlock_enter, 0.57);
	CreateThread(audio_airlock_enter_door);
	SleepUntil([|device_get_position (OBJECTS.quarry_door_airlock_enter) >= .40], 1);
	ObjectOverrideNavMeshCutting(OBJECTS.quarry_door_airlock_enter, false);
	b_ur_quarry_sniper_door_open = true;
end

function f_ur_quarry_pawn_backup_wave():void
	print("back up wave");
	SleepUntil([| ai_living_count( AI.sg_ur_quarry_snipers_main ) <= 4 ], 1);
	print("count 4");
	sleep_s(1);
	CreateThread( SlipSpaceSpawn, AI.sq_ur_q_crawlers_01 );
	sleep_s(3);
	
	SleepUntil([| ai_living_count( AI.sg_ur_quarry_snipers_main ) <= 3 ], 1);
	print("count 3");
	sleep_s(2);
	CreateThread( SlipSpaceSpawn, AI.sq_ur_q_crawlers_02 );
	sleep_s(3);
	
	SleepUntil([| ai_living_count( AI.sg_ur_quarry_snipers_main ) <= 2 ], 1);
	sleep_s(2);
	CreateThread( SlipSpaceSpawn, AI.sq_ur_q_crawlers_03 );
	sleep_s(3.5);
	b_ur_quarry_backup_wave_done = true;
end

function f_ur_quarry_sniper_backup():void
	SleepUntil([| volume_test_players(VOLUMES.tv_quarry_half_way) ], 1);
	CreateThread(f_ur_quarry_teleport);
	CreateThread( SlipSpaceSpawn, AI.sq_ur_q_snipers_l_03_b );
	CreateThread( SlipSpaceSpawn, AI.sq_ur_q_snipers_r_03_b );
	sleep_s(3.5);
	b_ur_quarry_sniper_backup_done = true;
end

function f_ur_quarry_teleport():void
	device_set_power(OBJECTS.quarry_door_temp, 1);
	device_set_position(OBJECTS.quarry_door_temp, 0);
	SleepUntil([|device_get_position (OBJECTS.quarry_door_temp) == 0], 1);
	Sleep(2);
	device_set_power(OBJECTS.quarry_door_temp, 0);
	ObjectOverrideNavMeshCutting(OBJECTS.quarry_door_temp, true);
	sleep_s(2);
	f_volume_teleport_all_inside(VOLUMES.tv_ur_quarry_teleport ,FLAGS.cf_ur_quarry_teleport);
--	if	volume_test_object (VOLUMES.tv_ur_quarry_teleport, SPARTANS.buck)	then
--			object_teleport (SPARTANS.buck, FLAGS.cf_ur_quarry_teleport);
--	end
--	if	volume_test_object (VOLUMES.tv_ur_quarry_teleport, SPARTANS.vale)	then
--			object_teleport (SPARTANS.vale, FLAGS.cf_ur_quarry_teleport);
--	end
--	if	volume_test_object (VOLUMES.tv_ur_quarry_teleport, SPARTANS.tanaka)	then
--			object_teleport (SPARTANS.tanaka, FLAGS.cf_ur_quarry_teleport);
--	end
--	if	volume_test_object (VOLUMES.tv_ur_quarry_teleport, SPARTANS.locke)	then
--			object_teleport (SPARTANS.locke, FLAGS.cf_ur_quarry_teleport);
--	end
end

function f_ur_quarry_cs_lead_sniper():void
	SleepUntil([| b_ur_lead_miner_ready == true or ai_living_count( AI.miner_pinned_by_snipers ) <= 0], 1);
	repeat
		sleep_s(0.167);
		--cs_aim(AI.sq_ur_quarry_snipers_general.sharpshooter, true, POINTS.ps_ur_quarry_move_to.p00);
		cs_shoot(AI.sq_ur_quarry_snipers_general.sharpshooter, true, ai_get_object(AI.miner_pinned_by_snipers));
		sleep_s(0.1);
		if ai_living_count( AI.miner_pinned_by_snipers ) > 0 then
			SleepUntil([| b_ur_lead_miner_vaporize == true or ai_living_count( AI.miner_pinned_by_snipers ) <= 0], 1);
			if ai_living_count( AI.sq_ur_quarry_snipers_general.sharpshooter) > 0 then
				unit_set_current_vitality(ai_get_object(AI.miner_pinned_by_snipers), 0.1, 0);
				sleep_s(1.5);
				RunClientScript("lead_miner_death_fx", ai_get_object(AI.miner_pinned_by_snipers));
				damage_object_effect(TAG('globals\damage_effects\instant_kill_dissolve.damage_effect'), ai_get_object(AI.miner_pinned_by_snipers));
			else
				ai_set_objective(AI.miner_pinned_by_snipers , "obj_intro_sniper_battle");
			end
		end
		sleep_s(0.1);
	until ai_living_count( AI.miner_pinned_by_snipers ) <= 0
	ai_set_objective(AI.sq_ur_quarry_snipers_general.sharpshooter, "obj_ur_quarry");
end

function f_ur_quarry_miner_saved_backup():void
	game_save_no_timeout();
	SleepUntil([| ai_living_count(AI.sq_ur_quarry_snipers_general.sharpshooter) <= 0], 1);
	ai_set_objective(AI.miner_pinned_by_snipers , "obj_intro_sniper_battle");
end

function f_ur_breadcrumbs_quarry():void
	object_create_anew("s_ur_breadcrumb_06");
	SleepUntil([| b_ur_quarry_sniper_door_open == true ], 10);
	
	SleepUntil([| volume_test_players(VOLUMES.tv_ur_breadcrumb_06) ], 10);
	object_destroy(OBJECTS.s_ur_breadcrumb_06);
end

-- ========================================
-- ==== musketeer steering
-- =======================================
function muskbox(vol:volume, flag1:flag, dist1:number, flag2:flag, dist2:number, goal:table):void
	local b_pos_1_set:boolean = false;
	local b_pos_2_set:boolean = false;
	
	repeat
		b_pos_1_set = false;
		b_pos_2_set = false;
		SleepUntil( [| volume_test_players(vol)
					or IsGoalActive(goal) == false
					],20);
			for _, obj in ipairs ( ai_actors(GetMusketeerSquad()) ) do
				if not b_pos_1_set then
					b_pos_1_set = true;                                                                                                                       
					-- stays with player
				elseif not b_pos_2_set then
					b_pos_2_set = true;
					MusketeerDestSetPoint(obj, flag1, dist1);
				else
					MusketeerDestSetPoint(obj, flag2, dist2);
				end
			end
		SleepUntil( [| volume_test_players(vol) == false
					or IsGoalActive(goal) == false
					],1);
		MusketeerUtil_SetDestination_Clear_All()
	until (IsGoalActive(goal) == false);
	MusketeerUtil_SetDestination_Clear_All()
end

---- =======================================================================================================
-- Client Scripts
--- =======================================================================================================
                                                        
--## CLIENT
function remoteClient.lead_miner_death_fx(miner:object):void
	damage_object_effect(TAG('objects\weapons\rifle\binary_rifle\projectiles\binary_rifle_bullet.damage_effect'), miner);
end