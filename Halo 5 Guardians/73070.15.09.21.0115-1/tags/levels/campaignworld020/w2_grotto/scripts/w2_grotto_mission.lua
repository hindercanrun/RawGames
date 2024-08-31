--## SERVER

global b_grotto_intro_preload:boolean=false;
global grotto_titles_are_on:boolean=false;

global falls_objcon:number=0;
global pool_objcon:number=0;
global split_objcon:number=0;
global airlock_objcon:number=0;
global courtyard_objcon:number=0;
global hallway_objcon:number=0;
global plaza_objcon:number=0;
global hq_objcon:number=0;
global sinkhole_safety:number=0;

global pool_touchdown:boolean = false;
global split_interior:boolean = false;
global armory_entry:boolean = false;
global elite_door_01_condition_01:boolean = false;
global elite_door_01_condition_02:boolean = false;
global elite_door_02_condition_01:boolean = false;
global elite_door_02_condition_02:boolean = false;
global armory_arbys:boolean = false;
global mantis_dropoff:boolean = false;
global mahkee_despawn:boolean = false;
global armory_door_01_activated:boolean = false;
global armory_door_01_safety_activated:boolean = false;
global armory_door_01_closed:boolean = false;
global armory_door_02_activated:boolean = false;
global armory_door_02_safety_activated:boolean = false;
global airlock_dropship_complete:boolean = false;
global courtyard_entry:boolean = false;
global twin_spirits_spawn:boolean = false;
global alley_hunter_advance_01:boolean = false;
global alley_hunter_flank_01:boolean = false;
global alley_hunter_flank_02:boolean = false;
global alley_ramp_flank_01:boolean = false;
global courtyard_loaded:boolean = false;
global gatehouse_loaded:boolean = false;
global hallway_loaded:boolean = false;
global plaza_loaded:boolean = false;
global hallway_entry:boolean = false;
global plaza_entry:boolean = false;
global hq_entry:boolean = false;
global b_courtyard_done:boolean = false;
global b_mantis_cheevo_failed:boolean = false;

global n_vin_tsunami_fleet_01:number = nil;
global n_vin_keyhole_fleet_01:number = nil;
global n_vin_keyhole_ambient_fx:number = nil;
global n_vin_keyhole_banshee_01:number = nil;
global n_comp_armory_grunts_01:number = nil;
global n_comp_armory_grunts_02:number = nil;
global n_comp_armory_grunts_03:number = nil;
global n_comp_armory_jackals_01:number = nil;

global n_comp_armory_door_01a:number = nil;
global n_comp_armory_door_01b:number = nil;
global n_comp_armory_door_02a:number = nil;
global n_comp_armory_door_02b:number = nil;
global n_courtyard_aa_fx:number = nil;
global n_courtyard_ships_vin:number = nil;
global n_comp_courtyard_grunts_02:number = nil;
global n_comp_courtyard_grunts_03:number = nil;
global n_hq_ambient_fx:number = nil;
global n_vin_hq_ambient:number = nil;
global n_vin_arbiter_melee:number = nil;
global n_vin_cov_takedown_01:number = nil;
global n_vin_cov_takedown_02:number = nil;
global n_grotto_breakable_count:number = 0;

global var_armory_mantis_event_thread:thread = nil;
global var_airlock_spawn_thread:thread = nil;
global var_courtyard_twin_spirits_thread:thread = nil;

global stream_landing:boolean = false;
global switch_landing:boolean = false;


--[[
   _____                   __         ___               __  ____           _                     ___    ___          ______           __  __      
  / ___/____ _____  ____ _/ /_  ___  / (_)___  _____   /  |/  (_)_________(_)___  ____     _    /   |  / ( )_____   / ____/________  / /_/ /_____ 
  \__ \/ __ `/ __ \/ __ `/ __ \/ _ \/ / / __ \/ ___/  / /|_/ / / ___/ ___/ / __ \/ __ \   (_)  / /| | / /|// ___/  / / __/ ___/ __ \/ __/ __/ __ \
 ___/ / /_/ / / / / /_/ / / / /  __/ / / /_/ (__  )  / /  / / (__  |__  ) / /_/ / / / /  _    / ___ |/ /  (__  )  / /_/ / /  / /_/ / /_/ /_/ /_/ /
/____/\__,_/_/ /_/\__, /_/ /_/\___/_/_/\____/____/  /_/  /_/_/____/____/_/\____/_/ /_/  (_)  /_/  |_/_/  /____/   \____/_/   \____/\__/\__/\____/ 
                 /____/                                                                                                                           
--]]

global Grotto:table=
	{
		name = "w2_grotto",
--		description = "World 2 Hub: Grotto, Locke travels through an aincient grotto in search of the next relic...",		-- This is not up to date so I commented it.  Guillaume 9/11
		description = "",
		profiles = {STARTING_PROFILES.profile_default_locke, STARTING_PROFILES.profile_default_tanaka, STARTING_PROFILES.profile_default_thorne, STARTING_PROFILES.profile_default_vale},
		points = POINTS.ps_grotto_entrance,
		startGoals = {"goal_landing"},
		     collectibles = {     
                        {objectName="grotto_skull", collectibleName="collectible_skull_mythic"},
                        {objectName="coll_landing_01", collectibleName="coll_landing_01"},
                        {objectName="coll_landing_02", collectibleName="coll_landing_02"},
                        {objectName="coll_falls_01", collectibleName="coll_falls_01"},
                        {objectName="coll_falls_02", collectibleName="coll_falls_02"},
                        {objectName="coll_falls_03", collectibleName="coll_falls_03"},
                        {objectName="coll_sinkhole_01", collectibleName="coll_sinkhole_01"},
                        {objectName="coll_sinkhole_02", collectibleName="coll_sinkhole_02"},
                        {objectName="coll_keyhole_01", collectibleName="coll_keyhole_01"},
                        {objectName="coll_keyhole_02", collectibleName="coll_keyhole_02"},
                        {objectName="coll_airlock_01", collectibleName="coll_airlock_01"},
                        {objectName="coll_courtyard_01", collectibleName="coll_courtyard_01"},
                        {objectName="coll_plaza_01", collectibleName="coll_plaza_01"},
                        },

		startFadeOut = "no",
		endFadeOut = "no",
	}

--[[
   ________                __               ______          __ 
  / ____/ /_  ____ _____  / /____  _____   /_  __/__  _  __/ /_
 / /   / __ \/ __ `/ __ \/ __/ _ \/ ___/    / / / _ \| |/_/ __/
/ /___/ / / / /_/ / /_/ / /_/  __/ /       / / /  __/>  </ /_  
\____/_/ /_/\__,_/ .___/\__/\___/_/       /_/  \___/_/|_|\__/  
                /_/                                            

--]] 

function ct_grotto_01()
	SleepUntil ([|	grotto_titles_are_on == false], 1);
	grotto_titles_are_on = true;
	print ("Narrative/Ambient/Objective text playing");
	f_chapter_title (TITLES.ct_grotto_01);
	CreateThread(audio_grotto_objective_find_arbiter_start);
	grotto_titles_are_on = false;	
end

function ct_grotto_02()
	SleepUntil ([|	grotto_titles_are_on == false], 1);
	grotto_titles_are_on = true;
	print ("Narrative/Ambient/Objective text playing");  	
	f_chapter_title (TITLES.ct_grotto_03);
	grotto_titles_are_on = false;			
end


--[[
   ____  __      _           __  _               ______          __ 
  / __ \/ /_    (_)__  _____/ /_(_)   _____     /_  __/__  _  __/ /_
 / / / / __ \  / / _ \/ ___/ __/ / | / / _ \     / / / _ \| |/_/ __/
/ /_/ / /_/ / / /  __/ /__/ /_/ /| |/ /  __/    / / /  __/>  </ /_  
\____/_.___/_/ /\___/\___/\__/_/ |___/\___/    /_/  \___/_/|_|\__/  
          /___/                                                     
                                
--]]                                
            
function ct_obj_grotto_01()
	SleepUntil ([|	grotto_titles_are_on == false], 1);
	grotto_titles_are_on = true;
	print ("Narrative/Ambient/Objective text playing");

	ObjectiveShow (TITLES.ct_obj_grotto_01);
			
	print ("Narrative/Ambient/Objective text has ended");	
	grotto_titles_are_on = false;
end

function ct_obj_grotto_02()
	SleepUntil ([|	grotto_titles_are_on == false], 1);
	grotto_titles_are_on = true;
	print ("Narrative/Ambient/Objective text playing");

	ObjectiveShow (TITLES.ct_obj_grotto_02);
			
	print ("Narrative/Ambient/Objective text has ended");	
	grotto_titles_are_on = false;
end

function ct_obj_grotto_03()
	SleepUntil ([|	grotto_titles_are_on == false], 1);
	grotto_titles_are_on = true;
	print ("Narrative/Ambient/Objective text playing");

	ObjectiveShow (TITLES.ct_obj_grotto_03);
			
	print ("Narrative/Ambient/Objective text has ended");	
	grotto_titles_are_on = false;
end

function ct_obj_grotto_04()
	SleepUntil ([|	grotto_titles_are_on == false], 1);
	grotto_titles_are_on = true;
	print ("Narrative/Ambient/Objective text playing");

	ObjectiveShow (TITLES.ct_obj_grotto_04);
			
	print ("Narrative/Ambient/Objective text has ended");	
	grotto_titles_are_on = false;
end

function ct_obj_grotto_05()
	SleepUntil ([|	grotto_titles_are_on == false], 1);
	grotto_titles_are_on = true;
	print ("Narrative/Ambient/Objective text playing");

	ObjectiveShow (TITLES.ct_obj_grotto_05);
			
	print ("Narrative/Ambient/Objective text has ended");	
	grotto_titles_are_on = false;
end


--[[
    ___        __    _                                     __      
   /   | _____/ /_  (_)__ _   _____  ____ ___  ___  ____  / /______
  / /| |/ ___/ __ \/ / _ \ | / / _ \/ __ `__ \/ _ \/ __ \/ __/ ___/
 / ___ / /__/ / / / /  __/ |/ /  __/ / / / / /  __/ / / / /_(__  ) 
/_/  |_\___/_/ /_/_/\___/|___/\___/_/ /_/ /_/\___/_/ /_/\__/____/  
                                                                   
--]]

--"Preying Mantis" Cheevo: Beat level with 2 Manti intact in coop (Heroic and up only)

function cheevo_preyingmantis()
		print("manitttsss");
		if game_difficulty_get_real() == DIFFICULTY.heroic or game_difficulty_get_real() == DIFFICULTY.legendary then
			SleepUntil ( [| volume_test_players(VOLUMES.tv_hq_end_mantis_end) ] , 1 );
				print("Checking Mantis Cheevo...");

						if f_grotto_players_in_the_mantis()  then  -- this should also ensure objects are valid
								if volume_test_objects( VOLUMES.tv_hq_end_mantis_check,OBJECTS.veh_keyhole_mantis_01) and volume_test_objects( VOLUMES.tv_hq_end_mantis_check,OBJECTS.veh_keyhole_mantis_02) then
										CampaignScriptedAchievementUnlocked( 14 ) ;
										print("CHEEVO UNLOCKED"); 
								end
							
						end
				--end

		end
			
end

function cheevo_mantis_check_update():boolean
	--if unit_vehicle
	return true;
end

 
function f_grotto_players_in_the_mantis():boolean

	local n_mantis_count:number = 0;

		if object_valid("veh_keyhole_mantis_01") and object_valid("veh_keyhole_mantis_02") then
				for _, p_player in ipairs ( players() ) do
					if unit_in_vehicle ( p_player ) and unit_get_vehicle( p_player ) == nil then			 ----hax because unit get vehicle returns nil in a mantis even though unit_in_vehicle returns true....hahahahahah, awesomesauce...seriously		
						--print("player in vehicle ",p_player);
						--print( unit_get_vehicle(  p_player  ) , " ", OBJECTS.veh_keyhole_mantis_01);
													   										
							n_mantis_count = n_mantis_count +1;			
							print(		n_mantis_count );	

					end
								
				end
				print(		n_mantis_count );	
				if n_mantis_count == 2 and ( object_get_health( OBJECTS.veh_keyhole_mantis_01 ) > 0 and object_get_health( OBJECTS.veh_keyhole_mantis_02 ) > 0 ) then
					return true;
				else 
					
					b_mantis_cheevo_failed = true;
					return false;
				end
		end
		b_mantis_cheevo_failed = true;	
	return false;
end 
 
-- "No Knock Raid" Cheevo: Destroy 10 or more walls/floors in Grotto (SP, any difficulty) 
function cheevo_wallbreak_setup_all()
	CreateThread( cheevo_wallbreak );
	
	CreateThread( cheevo_wallbreak_setup_piece ,"scn_falls_organic_bash_wall_01");
	CreateThread( cheevo_wallbreak_setup_piece ,"scn_sinkhole_organic_bash_wall_01");
	CreateThread( cheevo_wallbreak_setup_piece ,"scn_sinkhole_organic_bash_wall_02");
	CreateThread( cheevo_wallbreak_setup_piece ,"crate_sinkhole_bashwall_01");	
	CreateThread( cheevo_wallbreak_setup_piece ,"crate_keyhole_bashfloor_01");
	CreateThread( cheevo_wallbreak_setup_piece ,"crate_keyhole_bashwall_01");
	CreateThread( cheevo_wallbreak_setup_piece ,"crate_keyhole_bashwall_02");
	CreateThread( cheevo_wallbreak_setup_piece ,"crate_keyhole_bashwall_03");
	CreateThread( cheevo_wallbreak_setup_piece ,"crate_keyhole_bashwall_04");
	CreateThread( cheevo_wallbreak_setup_piece ,"crate_airlock_bashwall_01");
	CreateThread( cheevo_wallbreak_setup_piece ,"crate_airlock_bashwall_02");
	CreateThread( cheevo_wallbreak_setup_piece ,"crate_courtyard_bashfloor_01");
	CreateThread( cheevo_wallbreak_setup_piece ,"crate_courtyard_bashfloor_02");
	CreateThread( cheevo_wallbreak_setup_piece ,"crate_courtyard_bashfloor_03");	
	
end

function cheevo_wallbreak_setup_piece( obj_name:string)
	
		SleepUntil([| object_valid( obj_name ) ] ,1 );			
			print("breakable death watcher setup for ", obj_name , " ", ObjectFromName( obj_name) );
		SleepUntil([| object_valid( obj_name ) and object_damage_section_get_health(ObjectFromName( obj_name), "base" ) <= 0.0  ] ,1 );
			print("breakable death ",obj_name);
			n_grotto_breakable_count = n_grotto_breakable_count + 1;
end

function cheevo_wallbreak()
		print("Checking Wall Break Cheevo...");
		SleepUntil ( [| n_grotto_breakable_count >= 10 ] , 1 );
			CampaignScriptedAchievementUnlocked( 13 ) ;
			print("CHEEVO UNLOCKED");
end

function cheevo_test()
	CreateThread( cheevo_test_child_02 );
	CreateThread( cheevo_test_child ,"bash_test_01");	
	CreateThread( cheevo_test_child ,"bash_test_02");
	CreateThread( cheevo_test_child ,"bash_test_03");		
end

function cheevo_test_child( obj_name:string)
	
		SleepUntil([| object_valid( obj_name ) ] ,1 );			
			print("breakable death watcher setup for ", obj_name , " ", ObjectFromName( obj_name) );
		SleepUntil([| object_valid( obj_name ) and object_damage_section_get_health(ObjectFromName( obj_name), "base" ) <= 0.0  ] ,1 );
			print("breakable death ",obj_name);
			n_grotto_breakable_count = n_grotto_breakable_count + 1;
end

function cheevo_test_child_02()
		print("Checking Wall Break Cheevo...");
		SleepUntil ( [| n_grotto_breakable_count >= 3 ] , 1 );
			CampaignScriptedAchievementUnlocked( 13 ) ;
			print("CHEEVO UNLOCKED");
end
--[[
   _____ __             __     __                   __   _____           _       __      
  / ___// /_____ ______/ /_   / /   ___ _   _____  / /  / ___/__________(_)___  / /______
  \__ \/ __/ __ `/ ___/ __/  / /   / _ \ | / / _ \/ /   \__ \/ ___/ ___/ / __ \/ __/ ___/
 ___/ / /_/ /_/ / /  / /_   / /___/  __/ |/ /  __/ /   ___/ / /__/ /  / / /_/ / /_(__  ) 
/____/\__/\__,_/_/   \__/  /_____/\___/|___/\___/_/   /____/\___/_/  /_/ .___/\__/____/  
                                                                      /_/                
--]]
function startup.GrottoInit()
	if not editor_mode() then
		CreateThread(audio_cinematic_mute_grotto);
		fade_out(0,0,0,0);
		StartGrotto();
	else
		print ("in editor, not starting, run StartGrotto to start mission");
	end
end

function StartGrotto()
	
	StartMission(Grotto);

end

function Grotto.Start()
	print ("Al's Grotto Starting");
	
	--CreateThread(preload_landing);
	CreateThread(grotto_startup_scripts);
	
	CreateThread( cheevo_wallbreak_setup_all );
	CreateThread( cheevo_preyingmantis );
	--	NARRATIVE
	CreateThread(grotto_narrative_startup);
		
end

function grotto_startup_scripts()
--STUB--
end

--function remoteServer.preload_check():void
--		b_grotto_intro_preload = true;
--		print("bool changed end");
--end

--function preload_landing()
--		SleepUntil(	[|	b_grotto_intro_preload == true	], 1);
--		prepare_to_switch_to_zone_set(ZONE_SETS.w2_grotto_landing);
--		print("preparing zone set change");
--end

function update_weapons_profiles()
	player_set_profile(STARTING_PROFILES.profile_rearm_covenant, PLAYERS.player0);
	player_set_profile(STARTING_PROFILES.profile_rearm_covenant, PLAYERS.player1);
	player_set_profile(STARTING_PROFILES.profile_rearm_covenant, PLAYERS.player2);
	player_set_profile(STARTING_PROFILES.profile_rearm_covenant, PLAYERS.player3);
end


--[[
    ______          __   __                   __   _____           _       __      
   / ____/___  ____/ /  / /   ___ _   _____  / /  / ___/__________(_)___  / /______
  / __/ / __ \/ __  /  / /   / _ \ | / / _ \/ /   \__ \/ ___/ ___/ / __ \/ __/ ___/
 / /___/ / / / /_/ /  / /___/  __/ |/ /  __/ /   ___/ / /__/ /  / / /_/ / /_(__  ) 
/_____/_/ /_/\__,_/  /_____/\___/|___/\___/_/   /____/\___/_/  /_/ .___/\__/____/  
                                                                /_/                
--]]


function Grotto.End()							--will revisit this later for cinematics and loading plateau. AR
	print ("Al's Grotto end");	
	
	stop_valid_composition(n_vin_arbiter_melee);			--kill arbiter ship vignette
			object_destroy(OBJECTS.vin_phantom_scenery);
	CinematicPlay ("cin_132_grotto" ,true);
	
	sys_LoadW2Hub();
end

--[[
   ______            __        __                    ___            
  / ____/___  ____ _/ /  _    / /   ____ _____  ____/ (_)___  ____ _
 / / __/ __ \/ __ `/ /  (_)  / /   / __ `/ __ \/ __  / / __ \/ __ `/
/ /_/ / /_/ / /_/ / /  _    / /___/ /_/ / / / / /_/ / / / / / /_/ / 
\____/\____/\__,_/_/  (_)  /_____/\__,_/_/ /_/\__,_/_/_/ /_/\__, /  
                                                           /____/   
                                                                                                      
--]]                                                       

Grotto.goal_landing = 
{
	description = "",
	gotoVolume = VOLUMES.tv_goal_landing,
	next = {"goal_falls"};
}

function Grotto.goal_landing.Intro():void  
--STUB--
end


function Grotto.goal_landing.Start():void  
	CreateThread(prepare_to_switch_to_landing);
	CreateThread(switch_to_landing);
	print ("play intro cinematic cin_130_sanghelios'");
	CinematicPlay ("cin_130_sanghelios", true);
	Sleep(2);
	switch_zone_set(ZONE_SETS.w2_grotto_landing);
	CreateThread(landing_spawn);
	
	-- NARRATIVE CALL
	CreateThread(grotto_landing_load);
end


function Grotto.goal_landing.End():void  
--STUB--
end

-----Streaming Landing-----
function remoteServer.flip_landing_streaming_boolean()
	print("in here");
	stream_landing = true;

end

function prepare_to_switch_to_landing()
	print("now in here");
	SleepUntil([| stream_landing == true], 1);
	prepare_to_switch_to_zone_set(ZONE_SETS.w2_grotto_intro_to_landing);
	print("PREPARING");

end

function remoteServer.flip_landing_switch_boolean()

	switch_landing = true;

end

function switch_to_landing()
	print("now in here");
	SleepUntil([| switch_landing == true], 1);
	switch_zone_set(ZONE_SETS.w2_grotto_intro_to_landing);
	print("PREPARING");

end

function landing_spawn():void
		CreateThread (landing_vin_start);																				--Tsunami fleet vignette (check vignette script layer for this) AR
		CreateThread(landing_phantom_flock_01_client);													--fake birds flying away from phantom
		CreateThread(landing_phantom_flock_02_client);
		CreateThread(landing_phantom_flock_03_client);
		CreateThread(landing_flock_birds);
		CreateThread(landing_flock_birds_01_spawn_client);
		CreateEffectGroup (EFFECTS.fx_landing_gravlift);												--FAKE grav lift effect
		CreateEffectGroup (EFFECTS.fx_landing_dustoff_01);											--Phantom flight path fx
		--CreateEffectGroup (EFFECTS.fx_landing_dustoff_02);										--  request remove bug OSR-144183 c.f.
		
		sleep_s(3);
		
		StopEffectGroup (EFFECTS.fx_landing_gravlift);													--kill FAKE grav lift effect 

		CreateThread(ct_grotto_01);
		
		game_save_no_timeout();																									--Checkpoint post drop from phantom
		
		ai_place(AI.sq_landing_dropship);
		CreateThread(landing_dropship_fx);
		sleep_s(1.5);
		StopEffectGroup (EFFECTS.fx_landing_dustoff_01);
		--StopEffectGroup (EFFECTS.fx_landing_dustoff_02);
--		n_vin_tsunami_fleet_01 = composer_play_show("vin_tsunami_fleet_01");		--spawn in Tsunami fleet								
												
		
		CreateThread(landing_flock_spawn_client);

		object_create("blip_landing_01");												--objective blips

		SleepUntil(     [|   volume_test_players(VOLUMES.tv_blip_landing_01)
                     or   IsGoalActive(Grotto.goal_landing) == false
                     ], 1);
		object_create("blip_landing_02");
		object_destroy(OBJECTS.blip_landing_01);
    SleepUntil(     [|   IsGoalActive(Grotto.goal_landing) == false], 1);
		object_destroy(OBJECTS.blip_landing_02);

	print("landing spawn");
end

function cs_landing_dropship():void
  	print("phantom dustoff");
    
    ai_dont_do_avoidance(ai_current_actor, true);
    object_cannot_take_damage(ai_vehicle_get(AI.sq_landing_dropship));
    vehicle_load_magic(ai_vehicle_get_from_squad(ai_current_squad), "close_turret_doors",AI.sq_landing_dropship.spawnpoint_02);			--fake squad to close doors

		cs_fly_to(POINTS.ps_landing_dropship.point_01);
		cs_fly_to(POINTS.ps_landing_dropship.point_02);
		cs_fly_to(POINTS.ps_landing_dropship.point_03);
		cs_fly_to(POINTS.ps_landing_dropship.point_04);        

		ai_erase(AI.sq_landing_dropship);  
end

function landing_dropship_fx():void
		SleepUntil([| volume_test_object(VOLUMES.tv_landing_phantom_fx_01, AI.sq_landing_dropship) ], 1);
				CreateEffectGroup (EFFECTS.fx_landing_dust_01);
		SleepUntil([| volume_test_object(VOLUMES.tv_landing_phantom_fx_02, AI.sq_landing_dropship) ], 1);
				StopEffectGroup (EFFECTS.fx_landing_dust_01);
				CreateEffectGroup (EFFECTS.fx_landing_dust_02);
		SleepUntil([| volume_test_object(VOLUMES.tv_landing_phantom_fx_03, AI.sq_landing_dropship) ], 1);
				StopEffectGroup (EFFECTS.fx_landing_dust_02);
				CreateEffectGroup (EFFECTS.fx_landing_dust_03);
				sleep_s(3);
				StopEffectGroup (EFFECTS.fx_landing_dust_03);
end

function landing_flock_birds():void
		SleepUntil([| volume_test_players(VOLUMES.tv_landing_flock_birds_01_despawn) ], 1);
				CreateThread(landing_flock_birds_01_stop_client);
		SleepUntil([| volume_test_players(VOLUMES.tv_landing_flock_birds_02_spawn) ], 1);
				CreateThread(landing_flock_birds_02_spawn_client);
end

function test_landing():void
		flock_create("flock_landing_beetles_06");
		sleep_s(0.1);
		flock_start("flock_landing_beetles_06");
		sleep_s(3);
		flock_stop("flock_landing_beetles_06");
		print("landing test");
end


--[[
   ______            __        ______      ____    
  / ____/___  ____ _/ /  _    / ____/___ _/ / /____
 / / __/ __ \/ __ `/ /  (_)  / /_  / __ `/ / / ___/
/ /_/ / /_/ / /_/ / /  _    / __/ / /_/ / / (__  ) 
\____/\____/\__,_/_/  (_)  /_/    \__,_/_/_/____/  
                                                                                                      
--]]                                                       

Grotto.goal_falls = 
{
	description = "",
	gotoVolume = VOLUMES.tv_goal_falls,

	next = {"goal_sinkhole"};
}

function Grotto.goal_falls.Intro():void  
	-- NARRATIVE CALL
	CreateThread(grotto_falls_load);
end


function Grotto.goal_falls.Start():void  
	CreateThread(falls_spawn);
	CreateThread(falls_blips);
	--tjp 7-30-2015
	CreateThread(bashwall_listener, OBJECTS.scn_falls_organic_bash_wall_01, HINTS.jh_falls_organic_bashwall_01);
	--
end


function Grotto.goal_falls.End():void  
--STUB--
end


function falls_spawn():void
	print("falls spawn");
  			game_save_no_timeout();																									--First checkpoint in fals encounter

	object_create_folder_anew(MODULES.coll_falls);
	object_create_folder_anew(MODULES.crate_falls);
	object_create_folder_anew(MODULES.equip_falls);
	object_create_folder_anew(MODULES.veh_falls);
	object_create_folder_anew(MODULES.wep_falls);
	object_create_folder_anew(MODULES.scn_falls);
	
	CreateThread(musk_falls);	
	CreateThread(falls_flock_spawn_client);
	CreateThread(falls_dropship_01_flock_client);																		--scared birds @dropship 01
		SleepUntil ([| volume_test_players (VOLUMES.tv_falls_spawn) ], 1);
			
			game_save_no_timeout();																											--OSR-58698 Firing checkpoint at this spawn trigger to help get a good checkpoint fired before combat.
		
			--CreateThread(audio_grotto_objective_falls_combat);
			ai_place(AI.sq_falls_rangers_01);
			ai_place(AI.sq_falls_grunts_01);
			
			sleep_s(4);
			
			ai_place(AI.sg_falls_dropship_all);
			ai_place(AI.sq_falls_grunts_02);
			ai_place(AI.sq_falls_elite_01);
			ai_place(AI.sq_falls_elite_02);
			ai_place(AI.sq_falls_elite_03);
			ai_place(AI.sq_falls_rangers_02);
			ai_place(AI.sq_falls_jackals_01);
			ai_place(AI.sq_falls_jackals_02);
	
		SleepUntil ([| volume_test_players (VOLUMES.tv_falls_objcon_10) ], 1);	
	
			falls_objcon = 10;																													--First wave fall back to mid area
			print("objcon 10");
	
		SleepUntil(([| volume_test_players(VOLUMES.tv_falls_objcon_20) or						
							(ai_living_count (AI.sg_falls_wave_02) <= 4)] ), 1);
	
	  	game_save_no_timeout();																											--Mid checkpoint in falls encounter
		
			falls_objcon = 20;																													--First wave fall back to rear area
			print("objcon 20");
	
			ai_place(AI.sg_falls_wave_04);																							--Spawn rear fall back wave
																						
		SleepUntil ([| volume_test_players (VOLUMES.tv_falls_objcon_30) ], 1);
	
	  	game_save_no_timeout();
	  		
			falls_objcon = 30;
			print("objcon 30");

			CreateThread(falls_exit_flock_client);																			--Scared birds in exit
		
		SleepUntil ([| volume_test_players (VOLUMES.tv_falls_objcon_40) or						
							(ai_living_count (AI.sg_falls_wave_04) <= 3)], 1);
		
			falls_objcon = 40;																													--Final objcon, set last wave to seek player
			print("objcon 40");
end

function musk_falls():void
	if	(game_coop_player_count() <= 1)	then
		CreateThread(muskbox, VOLUMES.tv_mx_falls_01, FLAGS.flag_mx_falls_01a, 1, FLAGS.flag_mx_falls_01b, 2, Grotto.goal_falls);
		CreateThread(muskbox, VOLUMES.tv_mx_falls_02, FLAGS.flag_mx_falls_02a, 2, FLAGS.flag_mx_falls_02b, 1, Grotto.goal_falls);
		CreateThread(muskbox, VOLUMES.tv_mx_falls_03, FLAGS.flag_mx_falls_03a, 2, FLAGS.flag_mx_falls_03b, 1, Grotto.goal_falls);
		CreateThread(muskbox, VOLUMES.tv_mx_falls_04, FLAGS.flag_mx_falls_04a, 2, FLAGS.flag_mx_falls_04b, 1, Grotto.goal_falls);
		CreateThread(muskbox, VOLUMES.tv_mx_falls_05, FLAGS.flag_mx_falls_05a, 1, FLAGS.flag_mx_falls_05b, 1, Grotto.goal_falls);
		CreateThread(muskbox, VOLUMES.tv_mx_falls_06, FLAGS.flag_mx_falls_06a, 1, FLAGS.flag_mx_falls_06b, 2, Grotto.goal_falls);
		CreateThread(muskbox, VOLUMES.tv_mx_falls_07, FLAGS.flag_mx_falls_07a, 1, FLAGS.flag_mx_falls_07b, 1, Grotto.goal_falls);
	end
end

function cs_falls_dropship_01():void
  	print("spirit spawn");
    
    ai_dont_do_avoidance(ai_current_actor, true);
    
    f_load_drop_ship(AI.sq_falls_dropship_01, AI.sq_falls_grunts_ds_01, true, false, "right");
    f_load_drop_ship(AI.sq_falls_dropship_01, AI.sq_falls_grunts_ds_02, true, false, "left");

    object_set_scale(ai_vehicle_get_from_squad(ai_current_squad), 0.01, 1);
		sleep_s (0.05);
    object_set_scale(ai_vehicle_get_from_squad(ai_current_squad), 1, seconds_to_frames (1));
   	
		cs_fly_to(POINTS.ps_falls_dropship_01.point_01);
		cs_fly_to(POINTS.ps_falls_dropship_01.point_02);
		cs_fly_to_and_face(POINTS.ps_falls_dropship_01.point_03, POINTS.ps_falls_dropship_01.point_04);

    f_unload_drop_ship(AI.sq_falls_dropship_01);

		cs_fly_to_and_face(POINTS.ps_falls_dropship_01.point_05, POINTS.ps_falls_dropship_01.point_06);      
		cs_fly_to(POINTS.ps_falls_dropship_01.point_07);
		object_set_scale(ai_vehicle_get_from_squad(ai_current_squad), 0.01, seconds_to_frames (2));
		sleep_s (1);    
		ai_erase(AI.sq_falls_dropship_01);  
end

function cs_falls_dropship_02():void	
		ai_dont_do_avoidance(ai_current_actor, true);		
		ai_set_blind(ai_current_actor, true);
    cs_fly_to(POINTS.ps_falls_dropship_02.point_01);
    object_set_scale(ai_vehicle_get_from_squad(ai_current_squad), 0.01, seconds_to_frames (2));
		sleep_s (1);    
		ai_erase(AI.sq_falls_dropship_02);     
end

function falls_blips():void
	object_create("blip_falls_supply_01");
	object_create("blip_falls_supply_02");	
	object_create("blip_falls_supply_03");
	object_create("blip_falls_supply_04");
	object_create("blip_falls_supply_05");
	object_create("blip_falls_supply_06");					
	object_create("blip_falls_01");												--objective blips 
 	SleepUntil(     [|   IsGoalActive(Grotto.goal_falls) == false], 1);
	object_destroy(OBJECTS.blip_falls_01);
	object_destroy(OBJECTS.blip_falls_supply_01);
	object_destroy(OBJECTS.blip_falls_supply_02);
	object_destroy(OBJECTS.blip_falls_supply_03);
	object_destroy(OBJECTS.blip_falls_supply_04);
end

function test_falls():void
--SleepUntil([| volume_test_object(VOLUMES.tv_falls_dropship_birds_01, AI.sq_falls_dropship_01) ], 1);
		flock_create("flock_sinkhole_birds_01");
		sleep_s(0.1);
		flock_start("flock_sinkhole_birds_01");
		sleep_s(10);
		flock_stop("flock_sinkhole_birds_01");
		sleep_s(30);
		flock_delete("flock_sinkhole_birds_01");
		print("falls test");
end


--[[
   ______            __        _____ _       __   __          __   
  / ____/___  ____ _/ /  _    / ___/(_)___  / /__/ /_  ____  / /__ 
 / / __/ __ \/ __ `/ /  (_)   \__ \/ / __ \/ //_/ __ \/ __ \/ / _ \
/ /_/ / /_/ / /_/ / /  _     ___/ / / / / / ,< / / / / /_/ / /  __/
\____/\____/\__,_/_/  (_)   /____/_/_/ /_/_/|_/_/ /_/\____/_/\___/ 
                                                                   
                                                    
--]]                                                       

Grotto.goal_sinkhole = 
{
	description = "",
	gotoVolume = VOLUMES.tv_goal_sinkhole,

	next = {"goal_keyhole"};
}

function Grotto.goal_sinkhole.Intro():void  
	CreateThread(sinkhole_blips);
	CreateThread(landing_flock_despawn_client);
	CreateThread(landing_flock_birds_01_despawn_client);
	CreateThread(body_room_birds_spawn_client);

	sleep_s(5);
		
	-- NARRATIVE CALL
	CreateThread(grotto_sinkhole_load);
end


function Grotto.goal_sinkhole.Start():void  
	--tjp 7-30-2015
	CreateThread(bashwall_listener, OBJECTS.crate_sinkhole_bashwall_01, HINTS.jh_sinkhole_bashwall_01);
	CreateThread(bashwall_listener, OBJECTS.scn_sinkhole_organic_bash_wall_01, HINTS.jh_organic_sinkhole_01);
	CreateThread(bashwall_listener, OBJECTS.scn_sinkhole_organic_bash_wall_02, HINTS.jh_organic_sinkhole_02);
	--
	CreateThread(sinkhole_spawn);
	CreateThread(musk_sinkhole);
	CreateThread(pool_ground_check);

end

	
function Grotto.goal_sinkhole.End():void  
--STUB--
end

function sinkhole_spawn():void
	print("sinkhole spawn");
	CreateThread (update_weapons_profiles);									--Turn on covenant weapon profiles
	CreateThread(sinkhole_flock_spawn_client);
	object_create("scn_sinkhole_ship_01");
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_cp_sinkhole_entry) ], 1);
			game_save_no_timeout();	
  		print("CP: Sinkhole Entry");
		
	SleepUntil ([| volume_test_players (VOLUMES.tv_pool_snipers_spawn) ], 1);
			ai_place(AI.sg_pool_sniper_wave_01);
			CreateThread(audio_grotto_objective_falls_combat);

	SleepUntil ([| volume_test_players (VOLUMES.tv_pool_wave_01_spawn) ], 1);
			ai_place(AI.sg_pool_grunts_01);


	SleepUntil ([| volume_test_players (VOLUMES.tv_pool_objcon_10) ], 1);
			
			pool_objcon = 10;																													
			print("objcon 10");	

			ai_place(AI.sg_pool_grunts_02);
			sleep_s(2);
			ai_place(AI.sg_pool_elite_01);
					--cs_run_command_script(AI.sq_pool_elite_01, "cs_pool_elite_welcome_01");
			ai_place(AI.sg_pool_jackals_01);

	SleepUntil(([| volume_test_players(VOLUMES.tv_pool_objcon_20) or
						(ai_living_count (AI.sg_pool_wave_01) <= 1)] ), 1);

			game_save_no_timeout();	
  		print("CP: Pool Mid");
  		
			pool_objcon = 20;																													
			print("objcon 20");
			
			ai_place(AI.sg_tunnel_all);

			-- NARRATIVE CALL
			CreateThread(grotto_sinkhole_droppods);
			
				CreateThread(pool_pod_01);
						Sleep(20);
				CreateThread(pool_pod_02);
						Sleep(30);
				CreateThread(pool_pod_03);
			
	SleepUntil ([| volume_test_players (VOLUMES.tv_pool_objcon_30) ], 1);
			
			object_destroy_folder("coll_falls");
			object_destroy_folder("crate_falls");
			object_destroy_folder("equip_falls");
			object_destroy_folder("veh_falls");
			object_destroy_folder("wep_falls");
			object_destroy_folder("scn_falls");
			
			--stop_valid_composition(n_vin_tsunami_fleet_01);
			
			CreateThread(sinkhole_backtrack);
			CreateThread(sinkhole_teleport);
			CreateThread(falls_flock_despawn_client);
			
			zone_set_trigger_volume_enable("begin_zone_set:w2_grotto_sinkhole", false);				--OSR-152379: Turn off this zone set trigger
			
			pool_objcon = 30;																													
			print("objcon 30");

			game_save_no_timeout();	
  		print("CP: Tunnel Start");
			
	SleepUntil ([| volume_test_players (VOLUMES.tv_pool_objcon_40) ], 1);
			
			CreateThread(split_spawn);																												--BEGIN SPLIT ENCOUNTER
				
			pool_objcon = 40;																													
			print("objcon 40");

	SleepUntil ([| volume_test_players (VOLUMES.tv_pool_objcon_50) ], 1);

			game_save_no_timeout();	
  		print("CP: Tunnel End");
  						
			pool_objcon = 50;																													
			print("objcon 50");
end

function pool_pod_01()
			OBJECTS.pod_pool_jackals_02:start(AI.sq_pool_jackals_02, 1);
			RunClientScript("start_global_rumble_shake_small",(2));
end

function pool_pod_02()
			OBJECTS.pod_pool_grunts_03:start(AI.sq_pool_grunts_03, 2);
end

function pool_pod_03()
			OBJECTS.pod_pool_elite_01:start(AI.sq_pool_elite_02, 2);
end


function split_spawn():void
	print("sinkhole split spawn");

	CreateThread(split_interior_check);

	SleepUntil ([| volume_test_players (VOLUMES.tv_split_spawn)
							or	volume_test_players (VOLUMES.tv_split_spawn_safety) ], 1);
				ai_place(AI.sq_split_grunts_01);
				ai_place(AI.sq_split_grunts_03);
				ai_place(AI.sg_pool_sniper_wave_02);
	
				object_create_anew("coll_sinkhole_01");
				
				game_save_no_timeout();	
	  		print("CP: Split");
	  						
	SleepUntil(	[|	volume_test_players (VOLUMES.tv_split_dropship_spawn)
							or	volume_test_players (VOLUMES.tv_split_dropship_spawn_safety)], 1);
	
				CreateThread(ct_obj_grotto_02);			
				ai_place(AI.sq_sinkhole_dropship_01);
							
	SleepUntil(	[|	volume_test_players (VOLUMES.tv_split_objcon_10) ], 1);
					
				ai_place(AI.sq_split_grunts_02);
				ai_place(AI.sq_split_elite_01);
				ai_place(AI.sq_split_elite_02);
				ai_place(AI.sq_split_jackals_01);
				ai_place(AI.sq_split_jackals_02);
				ai_place(AI.sq_split_elite_03);
				ai_place(AI.sq_split_grunts_04);
				ai_place(AI.sq_split_plasma_01);
				
				split_objcon = 10;																													
				print("objcon 10");
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_split_objcon_50) ], 1);
	
				game_save_no_timeout();	
	  		print("CP: Mid Split");
	 
	 			ai_place(AI.sq_split_ranger_04);
	 			ai_place(AI.sq_split_plasma_02);
				ai_place(AI.sq_split_plasma_03);		
				
				split_objcon = 50;																													
				print("objcon 50");	
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_split_objcon_75) ], 1);
	
				ai_place(AI.sq_split_ranger_03);		 						
		 						
				split_objcon = 75;																													
				print("objcon 75");	
							
	SleepUntil ([| volume_test_players (VOLUMES.tv_split_objcon_100) ], 1);
	
				game_save_no_timeout();	
	  		print("CP: Top Split");
	
		-- NARRATIVE CALL
		CreateThread(grotto_sinkhole_droppods_up);
	
				CreateThread(doorway_pod_01);
					Sleep(20);
				CreateThread(doorway_pod_02);
					Sleep(30);
				CreateThread(doorway_pod_03);
	
	  		ai_place(AI.sq_doorway_jackals_01);				
	  		ai_place(AI.sq_doorway_jackals_02);	
	  							  						
				split_objcon = 100;																													
				print("objcon 100");
				
	SleepUntil ([| volume_test_players (VOLUMES.tv_split_objcon_125) ], 1);
	
				game_save_no_timeout();	
	  		print("CP: Sinkhole Finale");
	  		
	  		CreateThread(sinkhole_exit_flock_client);
	  		
	  		ai_place(AI.sq_doorway_elite_03);
	  		ai_place(AI.sq_doorway_elite_04);
	  		ai_place(AI.sq_doorway_elite_05);
	  		
				split_objcon = 125;																													
				print("objcon 125");						
	
	SleepUntil(([| volume_test_players(VOLUMES.tv_split_objcon_150) or
							(ai_living_count (AI.sq_doorway_elite_05) <= 0)] ), 1);
				
				game_save_no_timeout();	
	  		print("CP: Sinkhole COMPLETE");
	  						
				split_objcon = 150;																													
				print("objcon 150");						
end

function pool_ground_check():void
		SleepUntil ([| 	volume_test_players (VOLUMES.tv_pool_flank_low) or
										volume_test_players (VOLUMES.tv_pool_objcon_20)	 ], 1);
										
			pool_touchdown = true;
				print("pool touchdown");
end

function split_interior_check():void
		repeat
		SleepUntil ([| 	volume_test_players (VOLUMES.tv_split_interior_flank) ], 30);										
			split_interior = true;
			ai_set_active_camo(AI.sg_split_elite_02, true);
			print("split interior true");
		until IsGoalActive(Grotto.goal_sinkhole) == false;
end

function doorway_pod_01()
			OBJECTS.pod_doorway_elite_01:start(AI.sq_doorway_elite_01, 1);
			RunClientScript("start_global_rumble_shake_small",(2));
end

function doorway_pod_02()
			OBJECTS.pod_doorway_elite_02:start(AI.sq_doorway_elite_02, 1);
end

function doorway_pod_03()
			OBJECTS.pod_doorway_grunts_01:start(AI.sq_doorway_grunts_01, 1);
end

--muskketeer scripting OSR-100106 Function controls the spliting up logic on 2nd floor and rest of sinkhole
function musk_sinkhole():void
	if	(game_coop_player_count() <= 1)	then
		CreateThread(muskbox, VOLUMES.tv_mx_sinkhole_01, FLAGS.flag_mx_sinkhole_01a, 1, FLAGS.flag_mx_sinkhole_01b, 1, Grotto.goal_sinkhole);
		CreateThread(muskbox, VOLUMES.tv_mx_sinkhole_02, FLAGS.flag_mx_sinkhole_02a, 3, FLAGS.flag_mx_sinkhole_02b, 2, Grotto.goal_sinkhole);
		CreateThread(muskbox, VOLUMES.tv_mx_sinkhole_03, FLAGS.flag_mx_sinkhole_03a, 3, FLAGS.flag_mx_sinkhole_03b, 2, Grotto.goal_sinkhole);
		CreateThread(muskbox, VOLUMES.tv_mx_sinkhole_04, FLAGS.flag_mx_sinkhole_04a, 3, FLAGS.flag_mx_sinkhole_04b, 2, Grotto.goal_sinkhole);
		CreateThread(muskbox, VOLUMES.tv_mx_sinkhole_05, FLAGS.flag_mx_sinkhole_05a, 1, FLAGS.flag_mx_sinkhole_05b, 3, Grotto.goal_sinkhole);
		CreateThread(muskbox, VOLUMES.tv_mx_sinkhole_06, FLAGS.flag_mx_sinkhole_06a, 3, FLAGS.flag_mx_sinkhole_06b, 2, Grotto.goal_sinkhole);
		CreateThread(muskbox, VOLUMES.tv_mx_sinkhole_07, FLAGS.flag_mx_sinkhole_07a, 2, FLAGS.flag_mx_sinkhole_07b, 1, Grotto.goal_sinkhole);
		CreateThread(muskbox, VOLUMES.tv_mx_sinkhole_08, FLAGS.flag_mx_sinkhole_08a, 3, FLAGS.flag_mx_sinkhole_08b, 3, Grotto.goal_sinkhole);
		CreateThread(muskbox, VOLUMES.tv_mx_sinkhole_09, FLAGS.flag_mx_sinkhole_09a, 3, FLAGS.flag_mx_sinkhole_09b, 3, Grotto.goal_sinkhole);
		CreateThread(muskbox, VOLUMES.tv_mx_sinkhole_10, FLAGS.flag_mx_sinkhole_10a, 3, FLAGS.flag_mx_sinkhole_10b, 3, Grotto.goal_sinkhole);
		CreateThread(muskbox, VOLUMES.tv_mx_sinkhole_11, FLAGS.flag_mx_sinkhole_11a, 3, FLAGS.flag_mx_sinkhole_11b, 3, Grotto.goal_sinkhole);
		CreateThread(muskbox, VOLUMES.tv_mx_sinkhole_12, FLAGS.flag_mx_sinkhole_12a, 3, FLAGS.flag_mx_sinkhole_12b, 3, Grotto.goal_sinkhole);
		CreateThread(muskbox, VOLUMES.tv_mx_sinkhole_13, FLAGS.flag_mx_sinkhole_13a, 3, FLAGS.flag_mx_sinkhole_13b, 3, Grotto.goal_sinkhole);
		CreateThread(muskbox, VOLUMES.tv_mx_sinkhole_14, FLAGS.flag_mx_sinkhole_14a, 3, FLAGS.flag_mx_sinkhole_14b, 3, Grotto.goal_sinkhole);
	end
end


function cs_sinkhole_dropship_01():void
  	print("phantom spawn");
    
    ai_dont_do_avoidance(ai_current_actor, true);
    
    f_load_drop_ship(AI.sq_sinkhole_dropship_01, AI.sq_split_ranger_01, true, false, "left");
    f_load_drop_ship(AI.sq_sinkhole_dropship_01, AI.sq_split_ranger_02, true, false, "right");
   	object_set_scale(ai_vehicle_get_from_squad(ai_current_squad), 0.01, 1);
		sleep_s (0.05);
    object_set_scale(ai_vehicle_get_from_squad(ai_current_squad), 1, seconds_to_frames (1));
    
		cs_fly_to(POINTS.ps_sinkhole_dropships.point_01);
		cs_fly_to(POINTS.ps_sinkhole_dropships.point_02);
		CreateThread(sinkhole_dropship_01_flock_client);
		cs_fly_to_and_face(POINTS.ps_sinkhole_dropships.point_03, POINTS.ps_sinkhole_dropships.point_04);
		cs_fly_to_and_face(POINTS.ps_sinkhole_dropships.point_05, POINTS.ps_sinkhole_dropships.point_06);

    f_unload_drop_ship(AI.sq_sinkhole_dropship_01);

		cs_fly_to_and_face(POINTS.ps_sinkhole_dropships.point_07, POINTS.ps_sinkhole_dropships.point_08);
		cs_fly_to(POINTS.ps_sinkhole_dropships.point_09);
		cs_fly_to(POINTS.ps_sinkhole_dropships.point_10);
		cs_fly_to(POINTS.ps_sinkhole_dropships.point_11);

		ai_erase(AI.sq_sinkhole_dropship_01);  
end

function cs_doorway_elite_welcome():void
	cs_abort_on_damage(true);
  cs_go_to_and_face(POINTS.ps_pool_general.point_05, POINTS.ps_pool_general.point_06);
	cs_action(ai_current_actor, true, POINTS.ps_pool_general.point_07, 0)
	ai_set_deaf(ai_current_actor, false);
	ai_set_blind(ai_current_actor, false);
end

function sinkhole_blips():void
			object_create("blip_sinkhole_01");
			object_create("blip_sinkhole_supply_01");												--objective blips 

	SleepUntil(     [|   volume_test_players(VOLUMES.tv_blip_sinkhole_01)
                     or   IsGoalActive(Grotto.goal_sinkhole) == false], 1);
			object_destroy(OBJECTS.blip_sinkhole_01);
			object_create("blip_sinkhole_02");
	
	SleepUntil(     [|   volume_test_players(VOLUMES.tv_blip_sinkhole_02)
                     or   IsGoalActive(Grotto.goal_sinkhole) == false], 1);
		  object_destroy(OBJECTS.blip_sinkhole_02);
			object_create("blip_sinkhole_03");
			object_create("blip_sinkhole_supply_02");
			object_create("blip_sinkhole_supply_07");

	SleepUntil(     [|   volume_test_players(VOLUMES.tv_blip_sinkhole_03)
                     or   IsGoalActive(Grotto.goal_sinkhole) == false], 1);	
			object_destroy(OBJECTS.blip_sinkhole_03);
			object_destroy(OBJECTS.blip_sinkhole_supply_01);
			object_create("blip_sinkhole_04");
			object_create("blip_sinkhole_supply_03");
			object_create("blip_sinkhole_supply_04");
			object_create("blip_sinkhole_supply_05");
			object_create("blip_sinkhole_supply_06");

	SleepUntil(     [|   IsGoalActive(Grotto.goal_sinkhole) == false], 1);
			object_destroy(OBJECTS.blip_sinkhole_04);
			object_destroy(OBJECTS.blip_falls_supply_05);
			object_destroy(OBJECTS.blip_falls_supply_06);
			object_destroy(OBJECTS.blip_sinkhole_supply_02);
			object_destroy(OBJECTS.blip_sinkhole_supply_07);
end

function sinkhole_teleport():void
			print("safety teleport location sinkhole 01");
			volume_teleport_players_not_inside(	VOLUMES.tv_sinkhole_safety_01, FLAGS.flag_sinkhole_teleport_01);
end

function sinkhole_backtrack():void
		print("safetynet enabled");
		repeat
				SleepUntil ([| volume_test_players (VOLUMES.tv_sinkhole_safetynet) ], 2);
				if(sinkhole_safety == 0)then
					print("safety teleport location sinkhole 01");
					volume_teleport_players_not_inside(	VOLUMES.tv_sinkhole_safety_01 or 
																							VOLUMES.tv_sinkhole_safety_02 or 
																							VOLUMES.tv_sinkhole_safety_03 or 
																							VOLUMES.tv_sinkhole_safety_04, FLAGS.flag_sinkhole_teleport_01);
				elseif(sinkhole_safety == 1)then
					print("safety teleport location sinkhole 02");
					volume_teleport_players_not_inside(	VOLUMES.tv_sinkhole_safety_02 or 
																							VOLUMES.tv_sinkhole_safety_03 or 
																							VOLUMES.tv_sinkhole_safety_04, FLAGS.flag_sinkhole_teleport_02);
				elseif(sinkhole_safety == 2)then
					print("safety teleport location sinkhole 03");
					volume_teleport_players_not_inside(	VOLUMES.tv_sinkhole_safety_03 or 
																							VOLUMES.tv_sinkhole_safety_04, FLAGS.flag_sinkhole_teleport_03);
				elseif(sinkhole_safety == 3)then
					print("safety teleport location sinkhole 04");
					volume_teleport_players_not_inside(	VOLUMES.tv_sinkhole_safety_04, FLAGS.flag_sinkhole_teleport_04);
				end
		until armory_door_01_closed == true;
		print("end sinkhole safetynet");
end

function sinkhole_test():void
		CreateThread(doorway_pod_01);
			Sleep(20);
		CreateThread(doorway_pod_02);
			Sleep(30);
		CreateThread(doorway_pod_03);
end



--[[
   ______            __        __ __           __          __   
  / ____/___  ____ _/ /  _    / //_/__  __  __/ /_  ____  / /__ 
 / / __/ __ \/ __ `/ /  (_)  / ,< / _ \/ / / / __ \/ __ \/ / _ \
/ /_/ / /_/ / /_/ / /  _    / /| /  __/ /_/ / / / / /_/ / /  __/
\____/\____/\__,_/_/  (_)  /_/ |_\___/\__, /_/ /_/\____/_/\___/ 
                                     /____/                     
                                                                                                             
--]]                                                       

Grotto.goal_keyhole = 
{
	description = "",
	gotoVolume = VOLUMES.tv_goal_keyhole,

	next = {"goal_armory"};
}

function Grotto.goal_keyhole.Intro():void  

	-- NARRATIVE CALL
	CreateThread(grotto_keyhole_load);
	
end


function Grotto.goal_keyhole.Start():void  
	CreateThread(obj_keyhole);
	CreateThread(keyhole_spawn);
	CreateThread(keyhole_blips);
	CreateThread(sinkhole_flock_despawn_client);
end


function Grotto.goal_keyhole.End():void  
  --game_save_no_timeout();																--Save at keyhole side of bridge
end


function keyhole_spawn():void
	sinkhole_safety = 1;																																--Set new teleport point for safety net logic
	
	CreateThread(passage_flock_spawn_client);																						--Create passage way bug flocks
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_keyhole_fleet_spawn) ], 1);
	
		n_vin_keyhole_fleet_01 = composer_play_show("vin_keyhole_fleet_01");							--Create Tsunami Fleet
		n_vin_keyhole_ambient_fx = composer_play_show("vin_keyhole_ambient_fx");					--Create Theatre of War fx
	
	SleepUntil ([| volume_test_players (VOLUMES.tv_keyhole_spawn_01) ], 1);
	
		CreateThread(passage_scared_birds_spawn_client);																	--Scared bird flocks
		CreateEffectGroup (EFFECTS.fx_keyhole_fleet_tracer_01);
		SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w2grotto_bansheekeyhole\018_vin_cp_w2grotto_bansheekeyhole_shipfire.sound'), OBJECTS.keyhole_audio_crate, 1);
		sleep_s(2);
		n_vin_keyhole_banshee_01 = composer_play_show("vin_banshee_keyhold_01");
		CreateEffectGroup (EFFECTS.fx_keyhole_fleet_tracer_02);
		StopEffectGroup (EFFECTS.fx_keyhole_fleet_tracer_01);
		sleep_s(0.5);
		StopEffectGroup (EFFECTS.fx_keyhole_fleet_tracer_02);

	SleepUntil ([| volume_test_players (VOLUMES.tv_keyhole_spawn_02) ], 1);
	
		game_save_no_timeout();
		sinkhole_safety = 2;
		
		CreateThread(keyhole_flock_spawn_client);																					--Create keyhole flocks
		RunClientScript("start_global_rumble_shake_small",(13));
		CreateEffectGroup (EFFECTS.fx_keyhole_fleet_tracer_01);
		composer_play_show("vin_banshee_keyhold_02");
		CreateThread(keyhole_fleet_spawn);
		CreateThread(keyhole_flock_phantom_intro_spawn_client);
		CreateEffectGroup (EFFECTS.fx_keyhole_fleet_dust_04);
		sleep_s(2.7);		
		CreateThread(keyhole_flock_phantom_spawn_client);
		StopEffectGroup (EFFECTS.fx_keyhole_fleet_tracer_01);
		CreateEffectGroup (EFFECTS.fx_keyhole_fleet_dust_01);
		CreateEffectGroup (EFFECTS.fx_keyhole_fleet_dust_03);
		CreateEffectGroup (EFFECTS.fx_keyhole_fleet_dust_02);
		sleep_s(9);
		KillEffectGroup (EFFECTS.fx_keyhole_fleet_tracer_01);
		KillEffectGroup (EFFECTS.fx_keyhole_fleet_tracer_02);
		KillEffectGroup (EFFECTS.fx_keyhole_fleet_dust_01);
		KillEffectGroup (EFFECTS.fx_keyhole_fleet_dust_02);
		KillEffectGroup (EFFECTS.fx_keyhole_fleet_dust_03);
		KillEffectGroup (EFFECTS.fx_keyhole_fleet_dust_04);
	
		-- NARRATIVE
		b_keyhole_end_of_flyby = true;
		
		sleep_s(4);	
		StopEffectGroup (EFFECTS.fx_keyhole_fleet_tracer_03);
		sleep_s(2);
		CreateEffectGroup (EFFECTS.fx_keyhole_fleet_tracer_03);
		sleep_s(4);
		object_damage_damage_section(unit_get_vehicle(AI.sq_keyhole_phantom_01), "body", 10000);
		sleep_s(3);
		StopEffectGroup (EFFECTS.fx_keyhole_fleet_tracer_03);
		sleep_s(3);
		CreateEffectGroup (EFFECTS.fx_keyhole_fleet_tracer_03);
		sleep_s(8);
		StopEffectGroup (EFFECTS.fx_keyhole_fleet_tracer_03);
		sleep_s(7);
		CreateEffectGroup (EFFECTS.fx_keyhole_fleet_tracer_03);
		sleep_s(11);
		StopEffectGroup (EFFECTS.fx_keyhole_fleet_tracer_03);
		sleep_s(3);
		KillEffectGroup (EFFECTS.fx_keyhole_fleet_tracer_03);
		
		CreateThread(keyhole_flock_phantom_intro_despawn_client);
end

function keyhole_fleet_spawn():void		
		ai_place(AI.sq_keyhole_spirit_01);
		sleep_s(2);
		ai_place(AI.sq_keyhole_phantom_01);
		sleep_s(1.5);
		ai_place(AI.sq_keyhole_spirit_02);
		print("spawn keyhole fleet");
end

function cs_keyhole_spirit_01():void
	ai_dont_do_avoidance(ai_current_actor, true);
	ai_set_deaf(ai_current_actor, true);
  ai_set_blind(ai_current_actor, true);
  
 		object_set_scale(ai_vehicle_get_from_squad(ai_current_squad), 0.01, 1);
		sleep_s (0.05);
    object_set_scale(ai_vehicle_get_from_squad(ai_current_squad), 1, seconds_to_frames (3));
	
		cs_fly_to(POINTS.ps_keyhole_spirit_01.point_01);
		cs_fly_to(POINTS.ps_keyhole_spirit_01.point_02);
		cs_fly_to(POINTS.ps_keyhole_spirit_01.point_03);

		ai_erase(AI.sq_keyhole_spirit_01);  
end

function cs_keyhole_spirit_02():void
	ai_dont_do_avoidance(ai_current_actor, true);
	ai_set_deaf(ai_current_actor, true);
  ai_set_blind(ai_current_actor, true);
  
   	object_set_scale(ai_vehicle_get_from_squad(ai_current_squad), 0.01, 1);
		sleep_s (0.05);
    object_set_scale(ai_vehicle_get_from_squad(ai_current_squad), 1, seconds_to_frames (3));
    
		cs_fly_to(POINTS.ps_keyhole_spirit_02.point_01);
		cs_fly_to(POINTS.ps_keyhole_spirit_02.point_02);
		cs_fly_to(POINTS.ps_keyhole_spirit_02.point_03);
	
		ai_erase(AI.sq_keyhole_spirit_02);  
end

function cs_keyhole_phantom_01():void
	ai_dont_do_avoidance(ai_current_actor, true);
	ai_set_deaf(ai_current_actor, true);
  ai_set_blind(ai_current_actor, true);
	vehicle_load_magic(ai_vehicle_get_from_squad(ai_current_squad), "close_turret_doors",AI.sq_keyhole_phantom_01.spawnpoint_02);			--fake squad to close doors

   	object_set_scale(ai_vehicle_get_from_squad(ai_current_squad), 0.01, 1);
		sleep_s (0.05);
    object_set_scale(ai_vehicle_get_from_squad(ai_current_squad), 1, seconds_to_frames (3));
    
		cs_fly_to(POINTS.ps_keyhole_phantom_01.point_01);
		cs_fly_to(POINTS.ps_keyhole_phantom_01.point_02);
		cs_fly_to(POINTS.ps_keyhole_phantom_01.point_03);
	ai_erase(AI.sq_keyhole_phantom_01);  
end

function obj_keyhole():void
 	SleepUntil ([| volume_test_players (VOLUMES.tv_obj_keyhole) ], 1);
	CreateThread(ct_grotto_02);
end

function keyhole_blips():void
			object_create("blip_keyhole_01");												--objective blips
			object_create("blip_keyhole_supply_01");
			object_create("blip_keyhole_supply_02");
			object_create("blip_keyhole_supply_03");
			object_create("blip_keyhole_supply_04");  

	SleepUntil(     [|   volume_test_players(VOLUMES.tv_blip_keyhole_01)
                     or   IsGoalActive(Grotto.goal_keyhole) == false], 1);
			object_destroy(OBJECTS.blip_keyhole_01);
			object_create("blip_keyhole_02");
			object_create("blip_armory_supply_01");
			object_create("blip_armory_supply_02");
			object_create("blip_armory_supply_03");
			object_create("blip_armory_supply_04");

	SleepUntil(     [|   IsGoalActive(Grotto.goal_keyhole) == false], 1);	
		  object_destroy(OBJECTS.blip_keyhole_02);
		  object_destroy(OBJECTS.blip_keyhole_supply_01);
		  object_destroy(OBJECTS.blip_keyhole_supply_02);
		  object_destroy(OBJECTS.blip_keyhole_supply_03);
		  object_destroy(OBJECTS.blip_keyhole_supply_04);
		  object_destroy(OBJECTS.blip_sinkhole_supply_03);
		  object_destroy(OBJECTS.blip_sinkhole_supply_04);
		  object_destroy(OBJECTS.blip_sinkhole_supply_05);
		  object_destroy(OBJECTS.blip_sinkhole_supply_06);
end

function test_keyhole():void
	print("testing bash...");
	CreateThread(bashwall_listener, OBJECTS.crate_keyhole_bashwall_01, HINTS.jh_kh_bashwall_01);
end

--[[
   ______            __        ___                                   
  / ____/___  ____ _/ /  _    /   |  _________ ___  ____  _______  __
 / / __/ __ \/ __ `/ /  (_)  / /| | / ___/ __ `__ \/ __ \/ ___/ / / /
/ /_/ / /_/ / /_/ / /  _    / ___ |/ /  / / / / / / /_/ / /  / /_/ / 
\____/\____/\__,_/_/  (_)  /_/  |_/_/  /_/ /_/ /_/\____/_/   \__, /  
                                                            /____/   
                                                                                                             
--]]                                                       

Grotto.goal_armory = 
{
	description = "",
	gotoVolume = VOLUMES.tv_goal_armory,

	next = {"goal_airlock"};
}

function Grotto.goal_armory.Intro():void  
	--NARRATIVE CALL
	CreateThread(grotto_armory_load);
end


function Grotto.goal_armory.Start():void  
	CreateThread(armory_cleanup);
	CreateThread(armory_spawn);
	CreateThread(armory_blips);
	CreateThread(musk_armory);
		--tjp 7-30-2015:
	CreateThread(bashwall_listener, OBJECTS.crate_keyhole_bashwall_01, HINTS.jh_kh_bashwall_01);
	CreateThread(bashwall_listener, OBJECTS.crate_keyhole_bashwall_02, HINTS.jh_kh_bashwall_02);
	CreateThread(bashwall_listener, OBJECTS.crate_keyhole_bashwall_03, HINTS.jh_kh_bashwall_03);
	CreateThread(bashwall_listener, OBJECTS.crate_keyhole_bashwall_04, HINTS.jh_kh_bashwall_04);
	--
end


function Grotto.goal_armory.End():void  
	SleepUntil(	[|	mantis_dropoff == true	], 1);
end	

function armory_cleanup():void
		volume_teleport_players_not_inside(	VOLUMES.tv_sinkhole_cleanup_01, FLAGS.flag_sinkhole_cleanup_01);								
		ai_erase(AI.sg_sinkhole_all);
		print("cleanup sinkhole");
end

function armory_spawn():void
	sinkhole_safety = 3;
	
		--make armory projected barrier targetable
		ai_object_set_team(OBJECTS.crate_keyhole_projbarrier_01, TEAM.covenant);                            					-- projector
   	ai_object_set_team(object_at_marker(OBJECTS.crate_keyhole_projbarrier_01, "mkr_child"), TEAM.covenant); 			-- shield
   	ai_object_enable_targeting_from_vehicle(OBJECTS.crate_keyhole_projbarrier_01, true);
   	ai_object_enable_targeting_from_vehicle(object_at_marker(OBJECTS.crate_keyhole_projbarrier_01, "mkr_child"), true);

	SleepUntil ([| volume_test_players (VOLUMES.tv_armory_spawn) ], 1);
		ai_place(AI.sg_armory_wave_01);
		
		n_comp_armory_grunts_01 = composer_play_show("comp_prebattle_grunts_armory_01");
		n_comp_armory_grunts_02 = composer_play_show("comp_prebattle_grunts_armory_02");
		n_comp_armory_grunts_03 = composer_play_show("comp_prebattle_grunts_armory_03");
		n_comp_armory_jackals_01 = composer_play_show("comp_prebattle_jackals_armory_01");
		
	SleepUntil ([| volume_test_players (VOLUMES.tv_armory_entry) ], 1);
		
		game_save_no_timeout();	
		
		sleep_s(2);
		
		armory_entry = true;
		
		stop_valid_composition(n_comp_armory_grunts_01);
		stop_valid_composition(n_comp_armory_grunts_02);
		stop_valid_composition(n_comp_armory_grunts_03);
		stop_valid_composition(n_comp_armory_jackals_01);
		
		sleep_s(1);
		
		cs_run_command_script(AI.sq_armory_grunts_01, "cs_ai_undeaf");
		cs_run_command_script(AI.sq_armory_grunts_01.spawn_points_01, "cs_armory_grunts_flee_01a");
		cs_run_command_script(AI.sq_armory_grunts_01.spawn_points_02, "cs_armory_grunts_flee_01b");
		cs_run_command_script(AI.sq_armory_grunts_01.spawn_points_03, "cs_armory_grunts_flee_01c");
		cs_run_command_script(AI.sq_armory_grunts_01.spawn_points_04, "cs_armory_grunts_flee_01d");
		cs_run_command_script(AI.sq_armory_grunts_02, "cs_ai_undeaf");
		cs_run_command_script(AI.sq_armory_grunts_03, "cs_ai_undeaf");
		cs_run_command_script(AI.sq_armory_jrangers_01, "cs_ai_undeaf");
		cs_run_command_script(AI.sq_armory_jrangers_02, "cs_ai_undeaf");

		sleep_s(3);
		CreateThread(ct_obj_grotto_03);
		
	SleepUntil ([|	ai_living_count (AI.sg_armory_wave_01) <= 2], 1);		
		game_save_no_timeout();									--Checkpoint when players defeat all enemies in armory.
		ai_place(AI.sq_armory_spirit_01);


		
	SleepUntil ([|	ai_living_count (AI.sg_armory_wave_02) <= 0], 1);
		
		game_save_no_timeout();									--Checkpoint when players defeat hunters.
		sleep_s(2);
		print("spawn mahkee");
		var_armory_mantis_event_thread = CreateThread(armory_mantis_event);
end

function cs_armory_grunts_flee_01a():void
  --cs_push_stance(ai_current_actor, "flee");							--OSR:148164 Remove flee script
  --cs_go_to(POINTS.ps_armory_general.point_01);
	ai_set_deaf(ai_current_actor, false);
	ai_set_blind(ai_current_actor, false);
end

function cs_armory_grunts_flee_01b():void
  --cs_push_stance(ai_current_actor, "flee");							--OSR:148164 Remove flee script
  --cs_go_to(POINTS.ps_armory_general.point_02);
	ai_set_deaf(ai_current_actor, false);
	ai_set_blind(ai_current_actor, false);
end

function cs_armory_grunts_flee_01c():void
  --cs_push_stance(ai_current_actor, "flee");							--OSR:148164 Remove flee script
  --cs_go_to(POINTS.ps_armory_general.point_03);
	ai_set_deaf(ai_current_actor, false);
	ai_set_blind(ai_current_actor, false);
end

function cs_armory_grunts_flee_01d():void
  --cs_push_stance(ai_current_actor, "flee");							--OSR:148164 Remove flee script
  --cs_go_to(POINTS.ps_armory_general.point_03);
	ai_set_deaf(ai_current_actor, false);
	ai_set_blind(ai_current_actor, false);
end

function cs_armory_spirit_01():void
	 	print("spawn hunter drop");
		--ai_dont_do_avoidance(ai_current_actor, true);
		
   	f_load_drop_ship(ai_current_squad, AI.sq_armory_hunters_01, true, false, "right");
    f_load_drop_ship(ai_current_squad, AI.sq_armory_hunters_02, true, false, "right"); 

    object_set_scale(ai_vehicle_get_from_squad(ai_current_squad), 0.01, 1);
		sleep_s (0.05);
    object_set_scale(ai_vehicle_get_from_squad(ai_current_squad), 1, seconds_to_frames (4));
	 	
	 	cs_fly_to(POINTS.ps_hunter_event.point_01);
	 	cs_fly_to_and_face(POINTS.ps_hunter_event.point_02, POINTS.ps_hunter_event.point_03);    
	 	sleep_s(1.25);
	 	
	 	f_unload_drop_ship(ai_current_squad);

	 	cs_fly_to_and_face(POINTS.ps_hunter_event.point_04, POINTS.ps_hunter_event.point_05);
	 	cs_fly_to(POINTS.ps_hunter_event.point_06);
	 	cs_fly_to(POINTS.ps_hunter_event.point_07);
	 	ai_erase(AI.sg_armory_spirit_01);
end

function armory_mantis_event():void

	--	NARRATIVE CALL
	CreateThread(grotto_armory_palmer);
	CreateThread(armory_door_01_safety);					--safety timer in case elite cannot open door
			sleep_s(2);
		
		ai_place(AI.sg_armory_phantom_01);					--spawn in Mahkee

			sleep_s(2);
			
		CreateThread(audio_grotto_mantis_drop);
	
	SleepUntil([| volume_test_objects(VOLUMES.tv_armory_door_01a , ai_get_object(AI.sq_armory_arby_01.spawn_points_0))], 1);		--wait until elite is in position

			sleep_s(1.5);	

			CreateThread(armory_door_01a);				--begin elite door button press animation				

	SleepUntil([| volume_test_objects(VOLUMES.tv_armory_door_01b , ai_get_object(AI.sq_armory_arby_01.spawn_points_0))], 1);		--wait till elite is actually at switch

			print("Button Pressing...");
			sleep_s(3);

			mantis_dropoff = true;										--goal complete
			armory_door_01_activated = true;					--door 01 is open
			PlayAnimation (OBJECTS.armory_door_01, 0, "device:position");			--open door
			
end

function armory_door_01_safety():void
	sleep_s(40);
	print("safety check");
		if(armory_door_01_activated == false)then
				sleep_s(1);
				mantis_dropoff = true;										--goal complete
				armory_door_01_safety_activated = true;
				ai_cannot_die(AI.sq_armory_arby_01, true);
				PlayAnimation (OBJECTS.armory_door_01, 0, "device:position");			--open door
				print("safety open");
				KillThread(var_armory_mantis_event_thread);
		else
				print("safety abort")
	end
end

function mahkee_phantom_safety():void
	print("mahkee safety check");
	repeat
		SleepUntil ([| volume_test_players (VOLUMES.tv_mahkee_phantom_safety) ], 1);		
			volume_teleport_players_inside (VOLUMES.tv_mahkee_phantom_safety, FLAGS.flag_mahkee_safety_01);					
	until (mahkee_despawn == true);
			print("safety abort");
end


function cs_armory_phantom_01():void
	 	print("spawn mahkee");
	 	
		ai_dont_do_avoidance(ai_current_actor, true);
		object_cannot_take_damage(ai_vehicle_get(AI.sq_armory_phantom_01));
		navpoint_track_object_named(ai_vehicle_get(AI.sq_armory_phantom_01), "ally");
		
		object_create_anew("veh_keyhole_mantis_01");
	 	object_create_anew("veh_keyhole_mantis_02");
	 	objects_attach(ai_vehicle_get(ai_current_actor), "mantis_cargo01", OBJECTS.veh_keyhole_mantis_01, "pedestal");
	 	objects_attach(ai_vehicle_get(ai_current_actor), "mantis_cargo02", OBJECTS.veh_keyhole_mantis_02, "pedestal");
		
   	f_load_drop_ship(ai_current_squad, AI.sq_armory_arby_01, true, false, "left");
    f_load_drop_ship(ai_current_squad, AI.sq_armory_arby_02, true, false, "left");
    f_load_drop_ship(ai_current_squad, AI.sq_armory_arby_03, true, false, "right");
    
    object_set_scale(ai_vehicle_get_from_squad(ai_current_squad), 0.01, 1);
		sleep_s (0.05);
    object_set_scale(ai_vehicle_get_from_squad(ai_current_squad), 1, seconds_to_frames (4));
      
		cs_fly_to(POINTS.ps_armory_event.point_01);
	 	cs_fly_to_and_face(POINTS.ps_armory_event.point_02, POINTS.ps_armory_event.point_03);
	 	sleep_s(1);
	 	
	 	f_unload_drop_ship(ai_current_squad);
	 	
			 	navpoint_track_object_named(AI.sq_armory_arby_01.spawn_points_0, "ally");
				navpoint_track_object_named(AI.sq_armory_arby_02.spawn_points_0, "ally");
				navpoint_track_object_named(AI.sq_armory_arby_03.spawn_points_0, "ally");
				navpoint_track_object_named(AI.sq_armory_arby_03.spawn_points_02, "ally");
	
	 	sleep_s(1.25);
	 	
	 	objects_detach(ai_vehicle_get(ai_current_actor),OBJECTS.veh_keyhole_mantis_01);
	 	objects_detach(ai_vehicle_get(ai_current_actor),OBJECTS.veh_keyhole_mantis_02);
	 	
	 	CreateThread(mahkee_phantom_safety);
		
		sleep_s(0.9);

		CreateEffectGroup (EFFECTS.fx_keyhole_mantis_drop_01);
		CreateEffectGroup (EFFECTS.fx_keyhole_mantis_drop_02);
		
		sleep_s(4);
		
		KillEffectGroup (EFFECTS.fx_keyhole_mantis_drop_01);
		KillEffectGroup (EFFECTS.fx_keyhole_mantis_drop_02); 	

	 	cs_fly_to_and_face(POINTS.ps_armory_event.point_04, POINTS.ps_armory_event.point_05);
	 	
	 	cs_fly_to(POINTS.ps_armory_event.point_06);
	 	cs_fly_to(POINTS.ps_armory_event.point_07);
	 	object_set_scale(ai_vehicle_get_from_squad(ai_current_squad), 0.01, seconds_to_frames (2));
		sleep_s (1);    
	 	ai_erase(AI.sg_armory_phantom_01);
	 	mahkee_despawn = true;
end

function cs_armory_arby_01():void
		ai_cannot_die(ai_current_squad, true);
end

function cs_armory_arby_02():void
		ai_cannot_die(ai_current_squad, true);
end

function cs_armory_arby_03():void
		ai_cannot_die(ai_current_squad, true);
end

function musk_armory():void
	if	(game_coop_player_count() <= 1)	then
		CreateThread(muskbox, VOLUMES.tv_mx_armory_01, FLAGS.flag_mx_armory_01a, 1, FLAGS.flag_mx_armory_01b, 1, Grotto.goal_armory);
		CreateThread(muskbox, VOLUMES.tv_mx_armory_02, FLAGS.flag_mx_armory_02a, 1, FLAGS.flag_mx_armory_02b, 1, Grotto.goal_armory);
		CreateThread(muskbox, VOLUMES.tv_mx_armory_03, FLAGS.flag_mx_armory_03a, 3, FLAGS.flag_mx_armory_03b, 2, Grotto.goal_armory);
		CreateThread(muskbox, VOLUMES.tv_mx_armory_04, FLAGS.flag_mx_armory_04a, 3, FLAGS.flag_mx_armory_04b, 2, Grotto.goal_armory);
		CreateThread(muskbox, VOLUMES.tv_mx_armory_05, FLAGS.flag_mx_armory_05a, 2, FLAGS.flag_mx_armory_05b, 4, Grotto.goal_armory);
		CreateThread(muskbox, VOLUMES.tv_mx_armory_06, FLAGS.flag_mx_armory_06a, 3, FLAGS.flag_mx_armory_06b, 3, Grotto.goal_armory);
		CreateThread(muskbox, VOLUMES.tv_mx_armory_07, FLAGS.flag_mx_armory_07a, 4, FLAGS.flag_mx_armory_07b, 5, Grotto.goal_armory);
	end
end

function armory_blips():void
			object_create("blip_armory_01");												--objective blips
			object_create("blip_armory_supply_01");
			object_create("blip_armory_supply_02");
			object_create("blip_armory_supply_03"); 

	SleepUntil(     [|   IsGoalActive(Grotto.goal_armory) == false], 1);	
		  object_destroy(OBJECTS.blip_armory_01);

end


--[[
   ______            __        ___    _      __           __  
  / ____/___  ____ _/ /  _    /   |  (_)____/ /___  _____/ /__
 / / __/ __ \/ __ `/ /  (_)  / /| | / / ___/ / __ \/ ___/ //_/
/ /_/ / /_/ / /_/ / /  _    / ___ |/ / /  / / /_/ / /__/ ,<   
\____/\____/\__,_/_/  (_)  /_/  |_/_/_/  /_/\____/\___/_/|_|  
                                                              
                                                                                                             
--]]                                                       

Grotto.goal_airlock = 
{
	description = "",
	--gotoVolume = VOLUMES.tv_goal_airlock,

	next = {"goal_courtyard"};
}

function Grotto.goal_airlock.Intro():void  
--STUB--
end


function Grotto.goal_airlock.Start():void  
	var_airlock_spawn_thread = CreateThread(airlock_spawn);
	CreateThread(airlock_blips);
	CreateThread(musk_airlock);
	--tjp 7-30-2015
	CreateThread(bashwall_listener, OBJECTS.crate_airlock_bashwall_01, HINTS.jh_airlock_bashwall_01);
	CreateThread(bashwall_listener, OBJECTS.crate_airlock_bashwall_02, HINTS.jh_airlock_bashwall_02);
	
	--
	GoalCompleteCurrent();
end

function Grotto.goal_airlock.End():void  
	SleepUntil(	[|	courtyard_loaded == true	], 1);
	print("airlock goal end");
end	


function airlock_spawn():void
				print("airlock spawn");	
	
				ai_object_set_team(OBJECTS.crate_airlock_projbarrier_01, TEAM.covenant);                            					-- projector
		   	ai_object_set_team(object_at_marker(OBJECTS.crate_airlock_projbarrier_01, "mkr_child"), TEAM.covenant); 			-- shield
		   	ai_object_enable_targeting_from_vehicle(OBJECTS.crate_airlock_projbarrier_01, true);
		   	ai_object_enable_targeting_from_vehicle(object_at_marker(OBJECTS.crate_airlock_projbarrier_01, "mkr_child"), true);
		   	
		   	ai_object_set_team(OBJECTS.crate_airlock_projbarrier_02, TEAM.covenant);                            					-- projector
		   	ai_object_set_team(object_at_marker(OBJECTS.crate_airlock_projbarrier_02, "mkr_child"), TEAM.covenant); 			-- shield
		   	ai_object_enable_targeting_from_vehicle(OBJECTS.crate_airlock_projbarrier_02, true);
		   	ai_object_enable_targeting_from_vehicle(object_at_marker(OBJECTS.crate_airlock_projbarrier_02, "mkr_child"), true);
				
				ai_place(AI.sg_airlock_wave_01);
				
				cs_run_command_script(AI.sq_airlock_grunts_01, "cs_ai_undeaf");
				cs_run_command_script(AI.sq_airlock_grunts_01.spawnpoint_01, "cs_airlock_grunts_flee_01a");
				cs_run_command_script(AI.sq_airlock_grunts_01.spawnpoint_02, "cs_airlock_grunts_flee_01b");
				cs_run_command_script(AI.sq_airlock_grunts_01.spawnpoint_03, "cs_airlock_grunts_flee_01c");
		
				sleep_s(3);

				airlock_objcon = 5;							--Arby Elites storm into room																												
				print("objcon 5");			
				
	 	SleepUntil ([| volume_test_players (VOLUMES.tv_airlock_objcon_10) or ai_living_count (AI.sg_airlock_wave_01) <= 4], 1);
	 			airlock_objcon = 10;																													
				print("objcon 10");
				game_save_no_timeout();									--Checkpoint when players defeat 1st wave.
				ai_place(AI.sg_airlock_dropship_01);
						
		SleepUntil(	[|	airlock_dropship_complete == true	], 1);						--check to see if dropship completes unload so i can track nested squad group condition below
		SleepUntil ([| volume_test_players (VOLUMES.tv_airlock_objcon_20) or ai_living_count (AI.sg_airlock_all) <= 5], 1);
				airlock_objcon = 20;																													
				print("objcon 20");				
	 	
	 	SleepUntil ([|volume_test_players (VOLUMES.tv_armory_airlock_check) or ai_living_count (AI.sg_airlock_all) <= 2], 1);
				
				airlock_objcon = 25;					--Special objcon for Elite opening 2nd door	
				CreateThread(armory_door_01b);									--Close 1st door
				volume_teleport_players_not_inside_with_vehicles (VOLUMES.tv_armory_airlock_teleport, FLAGS.fl_tp_armory_airlock);			--Get players inside of airlock, begin unloading keyhole
		
		SleepUntil(	[|	DeviceIsLayerDone(OBJECTS.armory_door_01, 1)], 1);
				volume_teleport_players_not_inside_with_vehicles (VOLUMES.tv_armory_airlock_teleport, FLAGS.fl_tp_armory_airlock);			--Teleport again in case players try backtracking through door			

				print("DOOR CLOSED!!!!!!!!!!");
				
				stop_valid_composition(n_vin_keyhole_fleet_01);
				stop_valid_composition(n_vin_keyhole_ambient_fx);
				stop_valid_composition(n_vin_keyhole_banshee_01);
				armory_door_01_closed = true;	
				sleep_s(1);
		
				CreateThread(passage_flock_despawn_client);
				CreateThread(keyhole_flock_despawn_client);
				CreateThread(keyhole_flock_phantom_despawn_client);
			
				prepare_to_switch_to_zone_set(ZONE_SETS.w2_grotto_armory_advance);

				sleep_s(10);																			--HACK, arbitrary time wait for zoneset to finish loading. Need real solution for ship.

				--SleepUntil ([|	PreparingToSwitchZoneSet () == true], 1);
				--SleepUntil ([|	PreparingToSwitchZoneSet () == false], 1);				
		
		SleepUntil ([|ai_living_count (AI.sg_airlock_all) <= 0], 1);
				
				switch_zone_set(ZONE_SETS.w2_grotto_armory_advance);
				airlock_objcon = 30;																													
				print("objcon 30");	
				
				sleep_s(1.5);	
				CreateThread(armory_door_02_safety); 							--!!! Firing safety logic earlier in the event the elite is nowhere to be found
				
				game_save_no_timeout();														--Checkpoint when players defeat all enemies.
							 	
		SleepUntil([| volume_test_objects(VOLUMES.tv_armory_door_02a , ai_get_object(AI.sq_armory_arby_02.spawn_points_0))], 1);		--wait until elite is in position
				
				--	NARRATIVE CALL
				b_airlock_arby_elite_in_place = true;	
				
				sleep_s(1.5);	
				--CreateThread(armory_door_02_safety); 							--door safety logic in case Elite isnt able to get to switch
				CreateThread(armory_door_02a);										--begin elite door button press animation

		SleepUntil([| volume_test_objects(VOLUMES.tv_armory_door_02b , ai_get_object(AI.sq_armory_arby_02.spawn_points_0))], 1);		--elite is at switch

				--SleepUntil([|current_zone_set_fully_active() == ZONE_SETS.w2_grotto_armory_advance], 1);
				sleep_s (3);

				courtyard_loaded = true;
				armory_door_02_activated = true;					--door 02 is open
				PlayAnimation (OBJECTS.dm_courtyard_door_01, 0, "device:position");			--open door

end



function armory_door_02_safety():void
	sleep_s(5);
	print("safety check");
		if(armory_door_02_activated == false)then
				sleep_s(1);
				courtyard_loaded = true;									--goal complete
				armory_door_02_safety_activated = true;
				ai_cannot_die(AI.sq_armory_arby_02, true);
				PlayAnimation (OBJECTS.dm_courtyard_door_01, 0, "device:position");			--open door
				print("safety open");
				KillThread(var_airlock_spawn_thread);
		else
				print("safety abort")
	end
end

function cs_airlock_grunts_flee_01a():void
  cs_push_stance(ai_current_actor, "flee");
  cs_go_to(POINTS.ps_airlock_flee.point_01);
	ai_set_deaf(ai_current_actor, false);
	ai_set_blind(ai_current_actor, false);
end

function cs_airlock_grunts_flee_01b():void
  cs_push_stance(ai_current_actor, "flee");
  cs_go_to(POINTS.ps_airlock_flee.point_02);
	ai_set_deaf(ai_current_actor, false);
	ai_set_blind(ai_current_actor, false);
end

function cs_airlock_grunts_flee_01c():void
  cs_push_stance(ai_current_actor, "flee");
  cs_go_to(POINTS.ps_airlock_flee.point_03);
	ai_set_deaf(ai_current_actor, false);
	ai_set_blind(ai_current_actor, false);
end

function cs_airlock_dropship_01():void
	 	print("spawn airlock drop");

		ai_dont_do_avoidance(ai_current_actor, true);
		
   	f_load_drop_ship(ai_current_squad, AI.sq_airlock_jackals_03, true, false, "right");
    f_load_drop_ship(ai_current_squad, AI.sq_airlock_jackals_04, true, false, "left"); 
		f_load_drop_ship(ai_current_squad, AI.sq_airlock_elite_01, true, false, "right"); 
		f_load_drop_ship(ai_current_squad, AI.sq_airlock_elite_02, true, false, "left"); 
		
    object_set_scale(ai_vehicle_get_from_squad(ai_current_squad), 0.01, 1);
		sleep_s (0.05);
    object_set_scale(ai_vehicle_get_from_squad(ai_current_squad), 1, seconds_to_frames (3));
	 	
	 	cs_fly_to(POINTS.ps_airlock_dropship_01.point_01);
	 	cs_fly_to_and_face(POINTS.ps_airlock_dropship_01.point_02, POINTS.ps_airlock_dropship_01.point_03);    
	 	
	 	f_unload_drop_ship(ai_current_squad);
	 	airlock_dropship_complete = true;	
	 	
		cs_fly_to_and_face(POINTS.ps_airlock_dropship_01.point_04, POINTS.ps_airlock_dropship_01.point_05);
		cs_fly_to(POINTS.ps_airlock_dropship_01.point_06);
		cs_fly_to(POINTS.ps_airlock_dropship_01.point_07);
		cs_fly_to(POINTS.ps_airlock_dropship_01.point_08);
		cs_fly_to(POINTS.ps_airlock_dropship_01.point_09);
		cs_fly_to(POINTS.ps_airlock_dropship_01.point_10);
		object_set_scale(ai_vehicle_get_from_squad(ai_current_squad), 0.01, seconds_to_frames (3));
		sleep_s (1);    
		ai_erase(AI.sq_airlock_dropship_01);  
end

function airlock_blips():void
			object_create("blip_airlock_01");												--objective blips
			object_create("blip_airlock_supply_01");
			object_create("blip_airlock_supply_02");

	SleepUntil(     [|   volume_test_players(VOLUMES.tv_blip_airlock_01)
                     or   IsGoalActive(Grotto.goal_airlock) == false], 1);
			object_destroy(OBJECTS.blip_airlock_01);
			object_create("blip_airlock_02");

	SleepUntil(     [|   IsGoalActive(Grotto.goal_airlock) == false], 1);	
		  object_destroy(OBJECTS.blip_airlock_02);
			object_destroy(OBJECTS.blip_armory_supply_01);
			object_destroy(OBJECTS.blip_armory_supply_02);
			object_destroy(OBJECTS.blip_armory_supply_03);
			object_destroy(OBJECTS.blip_airlock_supply_01);
			object_destroy(OBJECTS.blip_airlock_supply_02);
end

function musk_airlock():void
	if	(game_coop_player_count() <= 1)	then
		CreateThread(muskbox, VOLUMES.tv_mx_airlock_01, FLAGS.flag_mx_airlock_01a, 1, FLAGS.flag_mx_airlock_01b, 1, Grotto.goal_airlock);
		CreateThread(muskbox, VOLUMES.tv_mx_airlock_02, FLAGS.flag_mx_airlock_02a, 1, FLAGS.flag_mx_airlock_02b, 1, Grotto.goal_airlock);
	end
end

function airlock_test():void
		--CreateThread(armory_door_02);
end

--[[
   ______            __        ______                 __                       __   ___ 
  / ____/___  ____ _/ /  _    / ____/___  __  _______/ /___  ______ __________/ /  /   |
 / / __/ __ \/ __ `/ /  (_)  / /   / __ \/ / / / ___/ __/ / / / __ `/ ___/ __  /  / /| |
/ /_/ / /_/ / /_/ / /  _    / /___/ /_/ / /_/ / /  / /_/ /_/ / /_/ / /  / /_/ /  / ___ |
\____/\____/\__,_/_/  (_)   \____/\____/\__,_/_/   \__/\__, /\__,_/_/   \__,_/  /_/  |_|
                                                      /____/                                                                                                        

--]]                                                       

Grotto.goal_courtyard = 
{
	description = "",
	
	next = {"goal_plaza"};
}

function Grotto.goal_courtyard.Intro():void  
--STUB--
end


function Grotto.goal_courtyard.Start():void  
		CreateThread(courtyard_spawn);
		CreateThread(courtyard_blips);
		CreateThread(courtyard_airlock);
		CreateThread( f_courtyard_musketeer_driver );
	--NARRATIVE CALL
	CreateThread(grotto_courtyard_load);

end


function Grotto.goal_courtyard.End():void  
--STUB
	b_courtyard_done = true;
end

function courtyard_spawn():void
--		SleepUntil ([| volume_test_players (VOLUMES.temp) ], 1);
--				PlayAnimation (OBJECTS.dm_courtyard_door_01, 0, "device:position");
		print("BEGIN COURTYARD");
		
				ai_object_set_team(OBJECTS.crate_courtyard_projbarrier_01, TEAM.covenant);                            					-- projector
		   	ai_object_set_team(object_at_marker(OBJECTS.crate_courtyard_projbarrier_01, "mkr_child"), TEAM.covenant); 			-- shield
		   	ai_object_enable_targeting_from_vehicle(OBJECTS.crate_courtyard_projbarrier_01, true);
		   	ai_object_enable_targeting_from_vehicle(object_at_marker(OBJECTS.crate_courtyard_projbarrier_01, "mkr_child"), true);
		   	
		sleep_s(1);

		--place all theatre of war objects
		n_courtyard_aa_fx = composer_play_show("vin_courtyard_aa_fx");
		CreateThread(hq_flock_spawn_client);
		object_create_folder_anew (MODULES.scn_hq_capships);
		object_set_scale (OBJECTS.scn_hq_capitalship_01, 2.2, 2.2);								--Scale capitol ship in skybox
		CreateThread(audio_grotto_mantis_courtyard_door);
		
			--place wave 01 AI
			n_comp_courtyard_grunts_02 = composer_play_show("comp_prebattle_grunts_courtyard_02");			--grunts by cover spawn into a vignette
			ai_place(AI.sq_courtyard_grunts_05);
			ai_place(AI.sq_courtyard_grunts_01);
					CreateThread(courtyard_begin_flee);
--					cs_run_command_script(AI.sq_courtyard_grunts_01.spawnpoint_01, "cs_courtyard_grunts_flee_01a");
--					cs_run_command_script(AI.sq_courtyard_grunts_01.spawnpoint_02, "cs_courtyard_grunts_flee_01b");
--					cs_run_command_script(AI.sq_courtyard_grunts_01.spawnpoint_03, "cs_courtyard_grunts_flee_01c");			
			ai_place(AI.sq_courtyard_grunts_03);
			ai_place(AI.sq_courtyard_elite_01);
					cs_run_command_script(AI.sq_courtyard_elite_01, "cs_courtyard_elite_welcome_01");																	
			ai_place(AI.sq_courtyard_wraith_01);
			ai_place(AI.sq_courtyard_hunter_01);
			ai_place(AI.sq_courtyard_grunts_04);
							
			b_courtyard_a_door_is_opening = true;
		
		sleep_s(0.5);

			n_courtyard_ships_vin = composer_play_show("vin_courtyard_ships");
			courtyard_entry = true;
	
		--	NARRATIVE
		b_courtyard_entrance_grunt_flee = true;
		
		ai_cannot_die(AI.sq_armory_arby_01, false);
		ai_cannot_die(AI.sq_armory_arby_02, false);
		ai_cannot_die(AI.sq_armory_arby_03, false);
		
		ai_place(AI.sq_courtyard_spirit_01);
						
				sleep_s(3);
	
		CreateThread(ct_obj_grotto_04);
				
				cs_run_command_script(AI.sq_courtyard_grunts_02, "cs_ai_undeaf");
				stop_valid_composition(n_comp_courtyard_grunts_02);
				cs_run_command_script(AI.sq_courtyard_grunts_03, "cs_ai_undeaf");

				airlock_objcon = 40;														--Move remaining arby elites into courtyard																												
				print("objcon 40");
						
		--place wave 02 AI
		SleepUntil ([| volume_test_players (VOLUMES.tv_courtyard_objcon_10) ], 1);
				airlock_objcon = 50;
				courtyard_objcon = 10;
				print("objcon 10");
				
				var_courtyard_twin_spirits_thread = CreateThread(twin_spirits);
				garbage_collect_now();
				ai_place(AI.sg_courtyard_wave_02_all);					--spawn in canopy AI
				ai_place(AI.sg_alley_wave_01);									--spawn alley wave 01
				
				game_save_no_timeout();													--Checkpoint when players defeat 1st wave.
				
		SleepUntil ([| volume_test_players (VOLUMES.tv_courtyard_objcon_20) ], 1);
				courtyard_objcon = 20;
				print("objcon 20");
		
				ai_place(AI.sg_alley_wave_02);									--spawn alley wave 02
				ai_place(AI.sg_landing_wave_01);								--spawn landing wave 01
				CreateThread(alley_ramp_flank);									--check to see if players enter lower left ramp
				CreateThread(alley_hunter_flank);								--check to see if players are in lower alley
				CreateThread(alley_hunter_advance);							--check to see if players through structure
				garbage_collect_now();
				game_save_no_timeout();													--Checkpoint when players defeat 2nd wave.

	--begin spawning wave 03 AI
		SleepUntil ([| volume_test_players (VOLUMES.tv_courtyard_objcon_30) ], 1);
				courtyard_objcon = 30;
				airlock_objcon = 60;
				print("objcon 30");
				garbage_collect_now();
				ai_place(AI.sq_courtyard_ghost_01);
				ai_place(AI.sq_courtyard_ghost_02);
				ai_place(AI.sg_landing_wave_02);									--spawn landing wave 01
				ai_place(AI.sq_gatehouse_wraith_01);
	
				game_save_no_timeout();														--Checkpoint when players defeat 3rd wave.
				
	--begin spawning wave 04 AI	
		SleepUntil ([| volume_test_players (VOLUMES.tv_courtyard_objcon_40) ], 1);
				courtyard_objcon = 40;
				airlock_objcon = 70;
				print("objcon 40");
				garbage_collect_now();
				CreateThread(courtyard_objcon_50);

				ai_place(AI.sg_courtyard_gatehouse_all);											--spawn_gatehouse wave
				game_save_no_timeout();															--Checkpoint when players defeat 3rd wave.
				
	SleepUntil ([| volume_test_players (VOLUMES.tv_gatehouse_door_check) and (gatehouse_loaded == true) ], 1);
			--stop_valid_composition(n_courtyard_ships_vin);

			prepare_to_switch_to_zone_set(ZONE_SETS.w2_grotto_courtyard_hallway);
			garbage_collect_now();
			sleep_s(10);
			garbage_collect_now();
			switch_zone_set(ZONE_SETS.w2_grotto_courtyard_hallway);
			hallway_loaded = true;
			print("hallway loaded");
					
	SleepUntil ([| ai_living_count (AI.sg_courtyard_gatehouse_lock)<= 2 and (hallway_loaded == true)], 1);
			
			plaza_loaded = true;
			b_gatehouse_door_opening = true;
			PlayAnimation (OBJECTS.dm_gatehouse_door_01, 0, "device:position");
			GoalCompleteCurrent();			
			print("open gatehouse door");
end

function courtyard_begin_flee()
			SleepUntil ([| volume_test_players (VOLUMES.tv_courtyard_begin_flee) ], 1);
				cs_run_command_script(AI.sq_courtyard_grunts_01.spawnpoint_01, "cs_courtyard_grunts_flee_01a");
				cs_run_command_script(AI.sq_courtyard_grunts_01.spawnpoint_02, "cs_courtyard_grunts_flee_01b");
				cs_run_command_script(AI.sq_courtyard_grunts_01.spawnpoint_03, "cs_courtyard_grunts_flee_01c");			
end	

function courtyard_objcon_50():void
		SleepUntil ([| volume_test_players (VOLUMES.tv_courtyard_objcon_50) ], 1);
				courtyard_objcon = 50;
				print("objcon 50");
				
		CreateThread(twin_spirits_check);
end	

function twin_spirits():void
		SleepUntil ([| volume_test_players (VOLUMES.tv_twin_spirits_spawn) ], 30);
				twin_spirits_spawn = true;
				ai_place(AI.sq_courtyard_spirit_02);
				sleep_s(1);
				ai_place(AI.sq_courtyard_spirit_03);
				print("spawn twin spirits");
end	

function twin_spirits_check():void
		if (twin_spirits_spawn == false) then
				KillThread(var_courtyard_twin_spirits_thread);
				print("kill twin spirit spawn thread");
		else
	end
end	

function courtyard_airlock():void
	SleepUntil ([| volume_test_players (VOLUMES.tv_courtyard_airlock_01) ], 1);	

			print("Closing Armory Door");
			CreateThread(armory_door_02b);
			volume_teleport_players_not_inside_with_vehicles (VOLUMES.tv_courtyard_airlock_check, FLAGS.fl_tp_courtyard_airlock);				--teleport players forward into courtyard
			
	SleepUntil(	[|	DeviceIsLayerDone(OBJECTS.dm_courtyard_door_01, 1)], 1);
			volume_teleport_players_not_inside_with_vehicles (VOLUMES.tv_courtyard_airlock_check, FLAGS.fl_tp_courtyard_airlock);				--teleport again in case players behind door
			
		SleepUntil ([| volume_test_players (VOLUMES.tv_courtyard_delayed_load_courtyard_a) ], 1);	   --- added this to help with object count cf		
			prepare_to_switch_to_zone_set(ZONE_SETS.w2_grotto_courtyard_a);
			print("Prapare Zone Set Switch: Courtyard A");
			
			--killing ai at the beginning and out of sight
			f_ai_garbage_kill6(AI.sg_courtyard_grunts_01, 8, 22.5, 30, -1, false);
			f_ai_garbage_kill6(AI.sg_courtyard_grunts_02, 8, 22.5, 30, -1, false);
			f_ai_garbage_kill6(AI.sg_courtyard_grunts_03, 8, 22.5, 30, -1, false);
			f_ai_garbage_kill6(AI.sg_courtyard_grunts_04, 8, 22.5, 30, -1, false);

			sleep_s(12);
			garbage_collect_now();
			Sleep(2);
			switch_zone_set(ZONE_SETS.w2_grotto_courtyard_a);
			gatehouse_loaded = true;	
			print("Zoneset = Courtyard A");
end

function f_courtyard_musketeer_driver()
	SleepUntil(	[|	DeviceIsLayerDone(OBJECTS.dm_courtyard_door_01, 0)], 1);
		print("musketeers ready for driving duty");
		f_court_musketeer_driver_helper_loop();
end

function alley_ramp_flank():void
		repeat
			SleepUntil ([| volume_test_players (VOLUMES.tv_courtyard_rampbottom_flankleft) ], 30);
				alley_ramp_flank_01 = true;
				print("reposition top alley floor");
		until (IsGoalActive(Grotto.goal_courtyard) == false or (alley_ramp_flank_01) == true);
				print("end ramp flank check");
end	

function alley_hunter_advance():void
		repeat
			SleepUntil ([| volume_test_players (VOLUMES.tv_alley_entrance_flank_04) ], 30);
				alley_hunter_advance_01 = true;
				print("advance alley hunter top floor");
		until (IsGoalActive(Grotto.goal_courtyard) == false or (alley_hunter_advance_01) == true);
				print("end hunter advance check");
end	

function alley_hunter_flank():void
		repeat
			SleepUntil ([| volume_test_players (VOLUMES.tv_hunter_flank_01) ], 1);
				alley_hunter_flank_01 = true;
				print("reposition hunter 01");
		until (IsGoalActive(Grotto.goal_courtyard) == false or (alley_hunter_flank_01) == true);
				print("end hunter flank check");
end	

function landing_hunter_flank():void
		repeat
			SleepUntil ([| volume_test_players (VOLUMES.tv_hunter_flank_02) ], 1);
				alley_hunter_flank_02 = true;
				print("reposition hunter 02");
		until (IsGoalActive(Grotto.goal_courtyard) == false or (alley_hunter_flank_02) == true);
				print("end hunter flank check");
end	

--flee scripts
function cs_courtyard_grunts_flee_01a():void
  cs_push_stance(ai_current_actor, "flee");
  cs_go_to(POINTS.ps_courtyard_wave_01.point_03);
end

function cs_courtyard_grunts_flee_01b():void
	cs_push_stance(ai_current_actor, "flee");
  cs_go_to(POINTS.ps_courtyard_wave_01.point_02);
end

function cs_courtyard_grunts_flee_01c():void
  cs_push_stance(ai_current_actor, "flee");
  cs_go_to(POINTS.ps_courtyard_wave_01.point_01);
end

function cs_courtyard_elite_welcome_01():void
	cs_abort_on_damage(true);
  cs_go_to(POINTS.ps_courtyard_wave_01.point_04);
	cs_action(ai_current_actor, true, POINTS.ps_courtyard_wave_01.point_05, 0)
	ai_set_deaf(ai_current_actor, false);
	ai_set_blind(ai_current_actor, false);
end

--Vehicle command scripts

function cs_courtyard_spirit_01():void
		
		ai_dont_do_avoidance(ai_current_actor, true);
		
		f_load_drop_ship(AI.sq_courtyard_spirit_01, AI.sq_courtyard_jackals_01, true, false, "right");
		f_load_drop_ship(AI.sq_courtyard_spirit_01, AI.sq_courtyard_jackals_02, true, false, "left");
		
			cs_fly_to(POINTS.ps_courtyard_spirit_01.point_01);
			cs_fly_to_and_face(POINTS.ps_courtyard_spirit_01.point_02, POINTS.ps_courtyard_spirit_01.point_03);
		
		f_unload_drop_ship(AI.sq_courtyard_spirit_01);
	
			cs_fly_to(POINTS.ps_courtyard_spirit_01.point_05);
			object_set_scale(ai_vehicle_get_from_squad(ai_current_squad), 0.01, seconds_to_frames (5));
			sleep_s (1);    
			ai_erase(AI.sq_courtyard_spirit_01);  
end

function cs_courtyard_spirit_02():void
		
		ai_dont_do_avoidance(ai_current_actor, true);
		
		f_load_drop_ship(AI.sq_courtyard_spirit_02, AI.sq_landing_grunts_01, true, false, "left");
		f_load_drop_ship(AI.sq_courtyard_spirit_02, AI.sq_landing_jackals_01, true, false, "right");
	
		object_set_scale(ai_vehicle_get_from_squad(ai_current_squad), 0.01, 1);
		sleep_s (0.05);
    object_set_scale(ai_vehicle_get_from_squad(ai_current_squad), 1, seconds_to_frames (3));
    
				cs_fly_to(POINTS.ps_courtyard_spirit_02.point_01);

		f_unload_drop_ship(AI.sq_courtyard_spirit_02);

		sleep_s(2);
				cs_fly_to_and_face(POINTS.ps_courtyard_spirit_02.point_02, POINTS.ps_courtyard_spirit_02.point_03);	
				cs_fly_to(POINTS.ps_courtyard_spirit_02.point_04);
				cs_fly_to(POINTS.ps_courtyard_spirit_02.point_05);
			
			object_set_scale(ai_vehicle_get_from_squad(ai_current_squad), 0.01, seconds_to_frames (3));
			sleep_s (1);    
				ai_erase(AI.sq_courtyard_spirit_02);  
end

function cs_courtyard_spirit_03():void
		
		ai_dont_do_avoidance(ai_current_actor, true);
		
		f_load_drop_ship(AI.sq_courtyard_spirit_03, AI.sq_landing_ranger_01, true, false, "right");
		f_load_drop_ship(AI.sq_courtyard_spirit_03, AI.sq_landing_grunts_02, true, false, "left");
	
		object_set_scale(ai_vehicle_get_from_squad(ai_current_squad), 0.01, 1);
		sleep_s (0.05);
    object_set_scale(ai_vehicle_get_from_squad(ai_current_squad), 1, seconds_to_frames (3));
	
				cs_fly_to(POINTS.ps_courtyard_spirit_03.point_01);
	
		f_unload_drop_ship(AI.sq_courtyard_spirit_03);

		sleep_s(2);
				
				cs_fly_to_and_face(POINTS.ps_courtyard_spirit_03.point_02, POINTS.ps_courtyard_spirit_03.point_03);	
				cs_fly_to(POINTS.ps_courtyard_spirit_03.point_04);
				cs_fly_to(POINTS.ps_courtyard_spirit_03.point_05);
	
			object_set_scale(ai_vehicle_get_from_squad(ai_current_squad), 0.01, seconds_to_frames (3));
			sleep_s (1);    	
				ai_erase(AI.sq_courtyard_spirit_03);  
end

function courtyard_blips():void
			object_create("blip_courtyard_01");												--objective blips
			object_create("blip_courtyard_supply_01");
			object_create("blip_courtyard_supply_02");
			object_create("blip_courtyard_supply_03"); 
			object_create("blip_courtyard_supply_04"); 
			object_create("blip_courtyard_supply_05");
			object_create("blip_courtyard_supply_06"); 
			  
	SleepUntil(     [|   IsGoalActive(Grotto.goal_courtyard) == false], 1);	
		  object_destroy(OBJECTS.blip_courtyard_01);
		  object_destroy(OBJECTS.blip_courtyard_supply_01);
		  object_destroy(OBJECTS.blip_courtyard_supply_02);
		  object_destroy(OBJECTS.blip_courtyard_supply_03);
		  object_destroy(OBJECTS.blip_courtyard_supply_04);
		  object_destroy(OBJECTS.blip_courtyard_supply_05);
		  object_destroy(OBJECTS.blip_courtyard_supply_06);

end

function courtyard_test():void
		object_create_folder_anew (MODULES.scn_hq_capships);
		object_set_scale (OBJECTS.scn_hq_capitalship_01, 2.2, 2.2);								--Scale capitol ship in skybox
end



-- muske



global goal_courtyard_musketeer_drive:flag = nil;
global goal_courtyard_musketeer_point_set:point_set = nil;

function f_court_musketeer_driver_helper_loop() 		
	CreateThread( f_court_musketeer_update_position );
	Sleep(2);
	repeat	
			f_court_musketeer_driving_util( goal_courtyard_musketeer_point_set, goal_courtyard_musketeer_drive, 7  ); 
			
			sleep_s(1);
	until false ;
	print("MUSKETEER DRIVER HELPER DONE");
end

function debug_court_musketeer_driver_helper_loop() 		
				goal_courtyard_musketeer_drive = FLAGS.fl_courtyard_goal_end ; 
				goal_courtyard_musketeer_point_set = 	POINTS.ps_courtyard_musk_pts_03;
	Sleep(2);
	repeat	
			f_court_musketeer_driving_util( goal_courtyard_musketeer_point_set, goal_courtyard_musketeer_drive, 5  ); 
			
			sleep_s(1);
	until false ;
	print("MUSKETEER DRIVER HELPER DONE");
end

function f_court_musketeer_update_position()
				print("Musket Driver: go to fl_courtyard_goal_start" );
				goal_courtyard_musketeer_drive = FLAGS.fl_courtyard_goal_start ; 	
				goal_courtyard_musketeer_point_set = 	POINTS.ps_courtyard_musk_pts_01;
			SleepUntil(     [|   volume_test_players( VOLUMES.tv_courtyard_musketeer_goal_01 ) ], 1);	
				print("Musket Driver: go to fl_courtyard_goal_mid_run_01" );
				goal_courtyard_musketeer_drive = FLAGS.fl_courtyard_goal_mid_run_01 ;  
				goal_courtyard_musketeer_point_set = 	POINTS.ps_courtyard_musk_pts_01;
			SleepUntil(     [|   volume_test_players( VOLUMES.tv_courtyard_musketeer_goal_02 ) ], 1);	
				goal_courtyard_musketeer_drive = FLAGS.fl_courtyard_goal_mid_run_02 ; 
				goal_courtyard_musketeer_point_set = 	POINTS.ps_courtyard_musk_pts_02;
				print("Musket Driver: go to fl_courtyard_goal_mid_run_02" ); 				
			SleepUntil(     [|   volume_test_players( VOLUMES.tv_courtyard_musketeer_goal_03 ) ], 1);	
				print("Musket Driver: go to fl_courtyard_goal_end" ); 	
				goal_courtyard_musketeer_drive = FLAGS.fl_courtyard_goal_end ; 
				goal_courtyard_musketeer_point_set = 	POINTS.ps_courtyard_musk_pts_03; 
end

function f_court_musketeer_driving_util( waypoints:point_set,goal:location, spacing:number )
	local spacing:number = spacing or 5;
--	local nearest_active_core:object = OBJECTS.dm_core_first;
	
	for _, musket in ipairs (ai_actors(GetMusketeerSquad())) do
		
		if( MusketeerIsDrivingPlayer( musket )) then
			--nearest_active_core = f_cores_get_next_core( musket );
		--	if nearest_active_core then
				MusketeerDestSetPoint( musket, goal, spacing );

				for i = 1, #waypoints do
					MusketeerDestAddWayPoint( musket, waypoints[i]);
				end
			--end
		else
			MusketeerDestClear( musket );
		end
	end
end 

--[[
   ______            __        ____  __                 
  / ____/___  ____ _/ /  _    / __ \/ /___ _____  ____ _
 / / __/ __ \/ __ `/ /  (_)  / /_/ / / __ `/_  / / __ `/
/ /_/ / /_/ / /_/ / /  _    / ____/ / /_/ / / /_/ /_/ / 
\____/\____/\__,_/_/  (_)  /_/   /_/\__,_/ /___/\__,_/  
                                                        
                                                                                         
--]]                                                       

Grotto.goal_plaza = 
{
	description = "",
	gotoVolume = VOLUMES.tv_goal_plaza,

	next = {"goal_arbiter"};
}

function Grotto.goal_plaza.Intro():void  
--STUB--
end


function Grotto.goal_plaza.Start():void  
	CreateThread(audio_grotto_finaltemple_start);
	CreateThread (plaza_spawn);
	CreateThread (plaza_blips);
	
	--	NARRATIVE CALL
	CreateThread(grotto_plaza_load);							--Commenting temporarily AR 3/16
end


function Grotto.goal_plaza.End():void
--STUB--
end

function plaza_spawn():void
	
		airlock_objcon = 80;
		
		stop_valid_composition(n_courtyard_ships_vin);
		n_hq_ambient_fx = composer_play_show("vin_hq_ambient_fx");								--spawn in theatre of war assets
		
			ai_place(AI.sq_hallway_grunts_01);
			ai_place(AI.sq_hallway_grunts_02);
			ai_place(AI.sq_hallway_elite_01);
			ai_place(AI.sq_hallway_rangers_01);	
			sleep_s(5);	
			cs_run_command_script(AI.sq_hallway_grunts_02.spawnpoint_01, "cs_hallway_grunts_flee_02a");
			cs_run_command_script(AI.sq_hallway_grunts_02.spawnpoint_02, "cs_hallway_grunts_flee_02b");
			cs_run_command_script(AI.sq_hallway_grunts_02.spawnpoint_03, "cs_hallway_grunts_flee_02c");
	
		hallway_entry = true;

	SleepUntil ([| volume_test_players (VOLUMES.tv_hallway_objcon_10) ], 1);
		print("objcon 10");
		hallway_objcon = 10;
		airlock_objcon = 90;
		

			CreateThread( Gatehouse_close_door_and_load_courtyard_b );
	
		----	print("Closing Gatehouse Door");
		----	PlayAnimation (OBJECTS.dm_gatehouse_door_01, 1, "any:close");

----	SleepUntil(	[|	DeviceIsLayerDone(OBJECTS.dm_gatehouse_door_01, 1)], 1);

----			sleep_s(1);
 
----			volume_teleport_players_not_inside_with_vehicles (VOLUMES.tv_gatehouse_airlock_check, FLAGS.fl_tp_gatehouse_airlock);

----			prepare_to_switch_to_zone_set(ZONE_SETS.w2_grotto_courtyard_b);
			--tjp 7-30-2015 https://entomo:8443/browse/OSR-141876
	---		ObjectSetSpartanTrackingEnabled(OBJECTS.coll_courtyard_01, false);
			--
-----			sleep_s(4);
			
	----		switch_zone_set(ZONE_SETS.w2_grotto_courtyard_b);
----			LoomNextCampaignMission();
----			CreateThread(hq_flock_despawn_client);
---			stop_valid_composition(n_courtyard_aa_fx);
	SleepUntil ([| volume_test_players (VOLUMES.tv_hallway_spawn_courtyard) ], 1);
	
			ai_place(AI.sq_plaza_grunts_01);
			ai_place(AI.sq_plaza_pod_grunts_02);
			ai_place(AI.sq_plaza_pod_grunts_03);
			ai_place(AI.sq_plaza_arbys_01);
			ai_place(AI.sq_plaza_jackals_01);
			
			CreateThread(plaza_jackal_health_loop);

			
			n_vin_cov_takedown_01 = composer_play_show("Vin_cov_takedown_01");
			n_vin_cov_takedown_02 = composer_play_show("Vin_cov_takedown_02");
			
	SleepUntil ([| volume_test_players (VOLUMES.tv_droppod_spawn) ], 1);
	
		n_vin_hq_ambient = composer_play_show("Vin_hq_ambient");  --delayed a bit for object count -cf
		--	NARRATIVE CALL For Drop Pods incoming.
		CreateThread(grotto_plaza_droppods);
	
		plaza_objcon = 5;
		airlock_objcon = 100;
			
		CreateThread(hq_pod_01);							--spawn in droppods front
		sleep_s(0.3);	
		CreateThread(hq_pod_02);
		CreateThread(hq_pod_03);
		sleep_s(0.25);	
		CreateThread(hq_pod_06);

	SleepUntil ([| volume_test_players (VOLUMES.tv_plaza_objcon_10) ], 1);
	
	plaza_objcon = 10;
	airlock_objcon = 110;
	
		CreateThread(hq_pod_08);									--spawn in droppods rear
		sleep_s(0.2);							
		CreateThread(hq_pod_07);

	SleepUntil ([| volume_test_players (VOLUMES.tv_plaza_objcon_20) ], 1);
	
	plaza_objcon = 20;

end

function Gatehouse_close_door_and_load_courtyard_b ()

	
		print("Closing Gatehouse Door");
		PlayAnimation (OBJECTS.dm_gatehouse_door_01, 1, "any:close");


	SleepUntil(	[|	DeviceIsLayerDone(OBJECTS.dm_gatehouse_door_01, 1)], 1);

			sleep_s(1);
 			print("bump forward");
			--tjp 7-30-2015 https://entomo:8443/browse/OSR-143798
			for _, musketeer in pairs( musketeers() ) do
				if volume_test_object (VOLUMES.tv_gatehouse_airlock_check, musketeer) == false then
					object_teleport(musketeer, FLAGS.fl_tp_plaza_musk);
				end
			end

			--
			volume_teleport_players_not_inside_with_vehicles (VOLUMES.tv_gatehouse_airlock_check, FLAGS.fl_tp_gatehouse_airlock);

			prepare_to_switch_to_zone_set(ZONE_SETS.w2_grotto_courtyard_b);
			--tjp 7-30-2015 https://entomo:8443/browse/OSR-141876
			ObjectSetSpartanTrackingEnabled(OBJECTS.coll_courtyard_01, false);
			--
			sleep_s(4);
			print("switch zone set to w2_grotto_courtyard_b ");
			switch_zone_set(ZONE_SETS.w2_grotto_courtyard_b);
			
			Sleep(2);
			--create objects 
			f_hq_create_delayed_objects();
			
			LoomNextCampaignMission();
			CreateThread(hq_flock_despawn_client);
			stop_valid_composition(n_courtyard_aa_fx);
end

function f_hq_create_delayed_objects()

	object_create_folder("grnd_hq");
	object_create_folder("mod_delayed_hq_objects");
	object_create_folder("weps_hq");
	object_create_folder("crates_hq");
	
end

function cs_hallway_grunts_flee_02a():void
  cs_push_stance(ai_current_actor, "flee");
  cs_go_to(POINTS.ps_hallway_grunts_02.point_01);
end

function cs_hallway_grunts_flee_02b():void
  cs_push_stance(ai_current_actor, "flee");
  cs_go_to(POINTS.ps_hallway_grunts_02.point_02);
end

function cs_hallway_grunts_flee_02c():void
  cs_push_stance(ai_current_actor, "flee");
  cs_go_to(POINTS.ps_hallway_grunts_02.point_03);
end

function hq_pod_01()
	OBJECTS.pod_plaza_grunts_01:start(AI.sq_plaza_pod_grunts_01, 1);
end	

function hq_pod_02()
	OBJECTS.pod_plaza_elite_01:start(AI.sq_plaza_pod_elite_01, 1);
end

function hq_pod_03()
	OBJECTS.pod_plaza_jackals_01:start(AI.sq_plaza_pod_jackals_01, 1);
end

function hq_pod_06()
	OBJECTS.pod_plaza_elite_02:start(AI.sq_plaza_pod_elite_02, 1);
end

function hq_pod_07()
	OBJECTS.pod_plaza_elite_03:start(AI.sq_plaza_pod_elite_03, 1);
end

function hq_pod_08()
	OBJECTS.pod_plaza_elite_04:start(AI.sq_plaza_pod_elite_04, 1);
end

--function hq_turret_explode_02()
--	object_damage_damage_section(OBJECTS.veh_plaza_shade_04, "body", 10000);
--end

function plaza_jackal_health_loop():void	
	repeat
		sleep_s (1);
		object_set_health (AI.sq_plaza_jackals_01.spawnpoint_01, 1);						--Replenish Jackal HP so Arby elites cant kill them. But player still can.
		object_set_health (AI.sq_plaza_jackals_01.spawnpoint_02, 1);
		object_set_health (AI.sq_plaza_jackals_01.spawnpoint_03, 1);
		object_set_health (AI.sq_plaza_jackals_01.spawnpoint_04, 1);
		object_set_health (AI.sq_plaza_jackals_01.spawnpoint_05, 1);
		print ("Replenish Jackal HP");

	until (  plaza_objcon == 10 or ai_living_count (AI.sq_plaza_jackals_01) <= 0);

		CreateEffectGroup (EFFECTS.fx_plaza_exp_stairs_01);											--Kill Arby fodder in case players snipe all jackals
		ai_kill(AI.sq_plaza_arbys_01.spawnpoint_01);
		sleep_s(0.15);
		ai_kill(AI.sq_plaza_arbys_01.spawnpoint_02);		
end

function plaza_blips():void
			object_create("blip_plaza_01");												--objective blips
			object_create("blip_plaza_supply_01");								--supply cache blips
			object_create("blip_plaza_supply_02");
			object_create("blip_plaza_supply_03"); 
			object_create("blip_plaza_supply_04"); 
			object_create("blip_plaza_supply_05");
	
	SleepUntil(     [|   volume_test_players(VOLUMES.tv_blip_plaza_01)
                     or   IsGoalActive(Grotto.goal_plaza) == false], 1);  
			
			object_destroy(OBJECTS.blip_plaza_01);
			object_create("blip_plaza_02");
			  
	SleepUntil(     [|   IsGoalActive(Grotto.goal_plaza) == false], 1);	
		  
		  object_destroy(OBJECTS.blip_plaza_02);
		  object_destroy(OBJECTS.blip_plaza_supply_01);
		  object_destroy(OBJECTS.blip_plaza_supply_02);
		  object_destroy(OBJECTS.blip_plaza_supply_03);
		  object_destroy(OBJECTS.blip_plaza_supply_04);
		  object_destroy(OBJECTS.blip_plaza_supply_05);

end

function hq_test():void
		CreateThread(hq_pod_01);							--spawn in droppods front
		sleep_s(0.3);	
		CreateThread(hq_pod_02);
		CreateThread(hq_pod_03);
		sleep_s(0.25);	
		CreateThread(hq_pod_06);
		CreateThread(hq_pod_08);									--spawn in droppods rear
		sleep_s(0.2);							
		CreateThread(hq_pod_07);
end


--[[
   ______            __        ___         __    _ __           
  / ____/___  ____ _/ /  _    /   |  _____/ /_  (_) /____  _____
 / / __/ __ \/ __ `/ /  (_)  / /| | / ___/ __ \/ / __/ _ \/ ___/
/ /_/ / /_/ / /_/ / /  _    / ___ |/ /  / /_/ / / /_/  __/ /    
\____/\____/\__,_/_/  (_)  /_/  |_/_/  /_.___/_/\__/\___/_/     
                                                                
                                                                                                                              

--]]                                                       

Grotto.goal_arbiter = 
{
	description = "",
	gotoVolume = VOLUMES.tv_goal_arbiter,

}

function Grotto.goal_arbiter.Intro():void  

	--NARRATIVE CALL
	CreateThread(grotto_hq_load);
	
end


function Grotto.goal_arbiter.Start():void  
	CreateThread(hq_spawn);
	CreateThread(arbiter_blips);
end


function Grotto.goal_arbiter.End():void  
	
	CreateThread(audio_grotto_thread_up_mission_end);
--	sleep_s(4);								--tjp 7-30-2015 https://entomo:8443/browse/OSR-142005
	fade_out(0,0,0, seconds_to_frames(1));	--tjp 7-30-2015 https://entomo:8443/browse/OSR-142005
	sleep_s(1);								--tjp 7-30-2015 https://entomo:8443/browse/OSR-142005

	EndCurrentMission();
end

function hq_spawn():void		
		CreateThread(ct_obj_grotto_05);											--objective text
		CreateThread(hq_vin_ambient);											--start hq ambient vignettes
		CreateThread(hq_vin_takedown);											--start hq takedown vignettes
		CreateThread(audio_grotto_finaltemple_inside);
		
		SleepUntil ([| volume_test_players (VOLUMES.tv_hq_wave_01_spawn) ], 1);
				
				ai_place(AI.sg_hq_wave_01);
				
		SleepUntil ([| volume_test_players (VOLUMES.tv_hq_cut_fx) ], 1);
				
				stop_valid_composition(n_hq_ambient_fx);						--kill interior weapon FX
	 	
	 	SleepUntil ([| volume_test_players (VOLUMES.tv_hq_wave_02_spawn) ], 1);
	 	
	 			ai_place(AI.sg_hq_wave_02);
	 			ai_place(AI.sg_hq_arbys_all);
	 			
	 			CreateThread(hq_health_loop);
	 			
	 			hq_entry = true;
		
				n_vin_arbiter_melee = composer_play_show("Vin_arbiter_melee");				--start hq arbiter vignette
						ai_cannot_die(AI.vin_arbiter_melee_arb.vin_arb_arbiter_spawnpoint, true);

	 	SleepUntil ([| volume_test_players (VOLUMES.tv_hq_objcon_10) ], 1); 	
				
				sleep_s(3);
				hq_objcon = 10;
				airlock_objcon = 120;
				
		SleepUntil ([| volume_test_players (VOLUMES.tv_hq_objcon_20) ], 1);
		
				hq_objcon = 20;
		
end

function hq_health_loop():void	
	repeat
		sleep_s (1);
		object_set_health (AI.sq_hq_jackals_01.spawnpoint_01, 1);						--Replenish Jackal/Grunt HP so Arby elites cant kill them. But player still can.
		object_set_health (AI.sq_hq_jackals_01.spawnpoint_02, 1);
		object_set_health (AI.sq_hq_jackals_01.spawnpoint_03, 1);
		object_set_health (AI.sq_hq_grunts_01.spawnpoint_01, 1);
		object_set_health (AI.sq_hq_grunts_01.spawnpoint_02, 1);
		object_set_health (AI.sq_hq_grunts_01.spawnpoint_03, 1);
		object_set_health (AI.sq_hq_grunts_01.spawnpoint_04, 1);
		object_set_health (AI.sq_hq_grunts_01.spawnpoint_05, 1);
		print ("Replenish HQ HP");

	until (  hq_objcon >= 10 or ai_living_count (AI.sg_hq_wave_02) <= 3);
	print ("End Replenish HQ HP");
end

function arbiter_blips():void
			object_create("blip_arbiter_01");												--objective blips
			object_create("blip_hq_supply_01");
			object_create("blip_hq_supply_02");
			
	SleepUntil(     [|   volume_test_players(VOLUMES.tv_hq_objcon_10)
                     or   IsGoalActive(Grotto.goal_arbiter) == false], 1);
			object_destroy(OBJECTS.blip_arbiter_01);
			object_create("blip_arbiter_02");

	SleepUntil(     [|   IsGoalActive(Grotto.goal_arbiter) == false], 1);	
		  object_destroy(OBJECTS.blip_arbiter_02);
		  object_destroy(OBJECTS.blip_hq_supply_01);
		  object_destroy(OBJECTS.blip_hq_supply_02);

end
--tjp 7-30-2015 https://entomo:8443/browse/OSR-141419
--function cs_arbiter_post_up()
	--cs_go_to_and_face (AI.vin_arbiter_melee_arb.vin_arb_arbiter_spawnpoint, true, POINTS., POINTS.);
	--cs_enable_looking(ai_current_actor, true);
	--SleepUntil([|false],3);
--end
--


--[[
    ____  ___       __      __                _     
   / __ )/ (_)___  / /__   / /   ____  ____ _(_)____
  / __  / / / __ \/ //_/  / /   / __ \/ __ `/ / ___/
 / /_/ / / / / / / ,<    / /___/ /_/ / /_/ / / /__  
/_____/_/_/_/ /_/_/|_|  /_____/\____/\__, /_/\___/  
                                    /____/          
--]]

function blink_grotto_landing():void
	switch_zone_set(ZONE_SETS.w2_grotto_landing);
	CreateThread(audio_grotto_stopallmusic);
	Sleep (10);
	GoalBlink(Grotto, "goal_landing", FLAGS.fl_tp_landing);
	print ("Teleport: Landing, Grotto");
end

function blink_grotto_falls():void
	switch_zone_set(ZONE_SETS.w2_grotto_falls);
	CreateThread(audio_grotto_stopallmusic);
	Sleep (10);
	GoalBlink(Grotto, "goal_falls", FLAGS.fl_tp_falls);
	print ("Teleport: Falls, Grotto");
end

function blink_grotto_sinkhole():void
	switch_zone_set(ZONE_SETS.w2_grotto_sinkhole);
	CreateThread(audio_grotto_stopallmusic);
	Sleep (10);
	GoalBlink(Grotto, "goal_sinkhole", FLAGS.fl_tp_sinkhole);
	print ("Teleport: Sinkhole, Grotto");
end

function blink_grotto_keyhole():void
	switch_zone_set(ZONE_SETS.w2_grotto_keyhole);
	CreateThread(audio_grotto_stopallmusic);
	Sleep (10);
	GoalBlink(Grotto, "goal_keyhole", FLAGS.fl_tp_keyhole);
	print ("Teleport: Keyhole, Grotto");
end

function blink_grotto_armory():void
	switch_zone_set(ZONE_SETS.w2_grotto_keyhole);
	CreateThread(audio_grotto_stopallmusic);
	Sleep (10);
	GoalBlink(Grotto, "goal_armory", FLAGS.fl_tp_armory);
	print ("Teleport: Armory, Grotto");
end

function blink_grotto_airlock():void
	switch_zone_set(ZONE_SETS.w2_grotto_keyhole);
	CreateThread(audio_grotto_stopallmusic);
	Sleep (10);
	GoalBlink(Grotto, "goal_airlock", FLAGS.fl_tp_airlock);
	CreateThread(armory_mantis_event);
	print ("Teleport: Airlock, Grotto");
end

function blink_grotto_courtyard():void
	composer_stop_all();
	switch_zone_set(ZONE_SETS.w2_grotto_armory_advance);
	CreateThread(audio_grotto_stopallmusic);
	Sleep (10);
	object_create_anew("veh_keyhole_mantis_01");
	object_create_anew("veh_keyhole_mantis_02");				--Spawn in usable vehicles (Same as ones used in Mantis drop off)
	GoalBlink(Grotto, "goal_courtyard", FLAGS.fl_tp_courtyard);
	PlayAnimation (OBJECTS.dm_courtyard_door_01, 0, "device:position");
	print ("Teleport: Courtyard, Grotto");
end

function blink_grotto_plaza():void
	switch_zone_set(ZONE_SETS.w2_grotto_courtyard_hallway);
	CreateThread(audio_grotto_stopallmusic);
	Sleep (10);
	GoalBlink(Grotto, "goal_plaza", FLAGS.fl_tp_plaza);	

			n_courtyard_aa_fx = composer_play_show("vin_courtyard_aa_fx");  --temp fix for an fx bug
			
	print ("Teleport: Plaza Battle, Grotto");
end

function blink_grotto_hq():void
	switch_zone_set(ZONE_SETS.w2_grotto_courtyard_b);
	LoomNextCampaignMission();
	CreateThread(audio_grotto_stopallmusic);
	Sleep (10);
	GoalBlink(Grotto, "goal_arbiter", FLAGS.fl_tp_hq);
			n_hq_ambient_fx = composer_play_show("vin_hq_ambient_fx");  --temp fix for an fx bug
			n_vin_hq_ambient = composer_play_show("Vin_hq_ambient");
			n_vin_cov_takedown_01 = composer_play_show("Vin_cov_takedown_01");
			n_vin_cov_takedown_02 = composer_play_show("Vin_cov_takedown_02");
	print ("Teleport: Arbiters HQ, Grotto");
end



--[[
   ______                                          __   _____           _       __      
  / ____/___  ____ ___  ____ ___  ____ _____  ____/ /  / ___/__________(_)___  / /______
 / /   / __ \/ __ `__ \/ __ `__ \/ __ `/ __ \/ __  /   \__ \/ ___/ ___/ / __ \/ __/ ___/
/ /___/ /_/ / / / / / / / / / / / /_/ / / / / /_/ /   ___/ / /__/ /  / / /_/ / /_(__  ) 
\____/\____/_/ /_/ /_/_/ /_/ /_/\__,_/_/ /_/\__,_/   /____/\___/_/  /_/ .___/\__/____/  
                                                                     /_/                
--]]


--function cs_aa_staging_01():void
--     --print("aa_test");
--     ai_set_deaf(ai_current_actor, true);
--     ai_set_blind(ai_current_actor, true);
--     repeat
--           local dice:number = random_range(1,3);
--           if(dice == 1)then
--           --print("aa_01");     
--                cs_shoot_point(ai_current_actor, true, POINTS.ps_camp_aa.aa_01a);
--           elseif(dice == 2)then
--           --print("aa_02");
--                cs_shoot_point(ai_current_actor, true, POINTS.ps_camp_aa.aa_01b);
--           elseif(dice == 3)then
--           --print("aa_03");
--                cs_shoot_point(ai_current_actor, true, POINTS.ps_camp_aa.aa_01c);
--      end  
--           sleep_s(2);
--     until(volume_test_players(VOLUMES.tv_camp_grunts_03_flee));
--     print("escape aa");
--     ai_vehicle_exit(ai_current_actor);   
--     ai_set_deaf(ai_current_actor, false);
--     ai_set_blind(ai_current_actor, false);
--     cs_go_to(POINTS.ps_camp_general.pt_nav_camp_flee_03);
--          
--end

--function cs_aa_staging_02():void
--     --print("aa_test");
--     ai_set_deaf(ai_current_actor, true);
--     ai_set_blind(ai_current_actor, true);
--     repeat
--           local dice:number = random_range(4,6);
--           if(dice == 4)then
--           --print("aa_04");     
--                cs_shoot_point(ai_current_actor, true, POINTS.ps_camp_aa.aa_02a);
--           elseif(dice == 5)then
--           --print("aa_05");
--                cs_shoot_point(ai_current_actor, true, POINTS.ps_camp_aa.aa_02b);
--           elseif(dice == 6)then
--           --print("aa_06");
--                cs_shoot_point(ai_current_actor, true, POINTS.ps_camp_aa.aa_02c);
--      end  
--           sleep_s(2);
--     until(volume_test_players(VOLUMES.tv_camp_ramp_02));
--     print("aa weps free");
--     --ai_vehicle_exit(ai_current_actor);   
--     cs_aim(true, POINTS.ps_camp_aa.aa_02d);
--     --cs_look(true, POINTS.ps_camp_aa.aa_02d);
--     ai_set_deaf(ai_current_actor, false);
--     ai_set_blind(ai_current_actor, false);
--     --cs_go_to(POINTS.ps_camp_general.pt_nav_camp_flee_03);
--          
--end


--[[
  ______      __             _       __    
 /_  __/_  __/ /_____  _____(_)___ _/ /____
  / / / / / / __/ __ \/ ___/ / __ `/ / ___/
 / / / /_/ / /_/ /_/ / /  / / /_/ / (__  ) 
/_/  \__,_/\__/\____/_/  /_/\__,_/_/____/  

--]]
                                       
global g_TutorialPlayers = {
	{},
	{},
	{},
	{}};

function test()
	if game_difficulty_get_real() ~= DIFFICULTY.easy then
		print ("not easy");
	end
	if game_difficulty_get_real() == DIFFICULTY.heroic then
		print ("heroic");
	end
end

function startup.tutorial()
	--if easy or normal then play tutorials
	if game_difficulty_get_real() == DIFFICULTY.easy or game_difficulty_get_real() == DIFFICULTY.normal then
		print ("tutorials are on");
	else
		print ("game difficulty is not easy or normal, there are no tutorials");
		return
	end
	
	--print ("tutorial");
	local sleepTime:number = 0.5;
	local mantisTimeLimit:number = 22;
	local mantisClimbInTimeLimit:number = 8;
	local wraithClimbInTimeLimit:number = 6;
	local ghostClimbInTimeLimit:number = 3;
	local tutorialTimeLimit:number = 10;
		
	repeat
		--sleepTime is used to determine how long players have been in the mantis and how long to sleep between checks
		
		--for all living players check if the player is in a vehicle 
		for i = 1,4 do
			local player = PLAYERS[i - 1];
			if not g_TutorialPlayers[i].MantisTime then
				g_TutorialPlayers[i].MantisTime = 0;
			end
			
			--make a table key and value for how long it takes to climb in a vehicle
			if not g_TutorialPlayers[i].ClimbInTime then
				g_TutorialPlayers[i].ClimbInTime = sleepTime * (-1);
			end
			
			--if the player is in a vehicle increment the ClimbInTime variable
			if unit_in_vehicle (player) and g_TutorialPlayers[i].ClimbInTime <= mantisClimbInTimeLimit then
				g_TutorialPlayers[i].ClimbInTime = g_TutorialPlayers[i].ClimbInTime + sleepTime;
				--print ("climb in time is ", g_TutorialPlayers[i].ClimbInTime);
			elseif not unit_in_vehicle (player) then
				g_TutorialPlayers[i].ClimbInTime = 0;
			end
			
			if (g_TutorialPlayers[i].ClimbInTime >= ghostClimbInTimeLimit) and (not g_TutorialPlayers[i].SeenGhostBoost) and (unit_in_vehicle_type (player, 26)) then
				--print ("player in ghost");
				-- test for hop-in/hop-out to see if the new functions registers such cases as "done"
				
				-- === TutorialShowIfNotPerformed: Shows the tutorial unless the player has completed that mechanic.
				--		pl - player
				--		text - the stringID to show
				--		mechanic_id - mechanic enum to check if completed
				-- 		max_time - OPTIONAL the number of seconds to show the tutorial string unless stopped by another script or another tutorial overwrites it
				--  Example: TutorialShowIfNotPerformed (PLAYERS.player0, "example", TUTORIAL.example, 10) shows the stringID of Example for 10 seconds to player0 
				--tjp 7-30-2015 https://entomo:8443/browse/OSR-140083
				--TutorialShow (player, "training_ghost_boost", tutorialTimeLimit);
				TutorialShowIfNotPerformed (player, "training_ghost_boost", TUTORIAL.GhostBoost, tutorialTimeLimit);
				g_TutorialPlayers[i].SeenGhostBoost = true;
				g_TutorialPlayers[i].InVehicle = true;
			elseif (g_TutorialPlayers[i].ClimbInTime >= wraithClimbInTimeLimit) and (not g_TutorialPlayers[i].SeenWraithBoost) and (unit_in_vehicle_type (player, 29)) then
				--print ("player in wraith");
				--tjp 7-30-2015 https://entomo:8443/browse/OSR-140083
				--TutorialShow (player, "training_wraith_boost", tutorialTimeLimit);
				TutorialShowIfNotPerformed (player, "training_wraith_boost", TUTORIAL.WraithBoost, tutorialTimeLimit);
				g_TutorialPlayers[i].SeenWraithBoost = true;
				g_TutorialPlayers[i].InVehicle = true;
			elseif (g_TutorialPlayers[i].ClimbInTime >= mantisClimbInTimeLimit) and (not g_TutorialPlayers[i].SeenMantisRockets) and (unit_in_vehicle_type (player, 38)) then
				--print ("player in Mantis");
				--tjp 7-30-2015 https://entomo:8443/browse/OSR-140083
				--TutorialShow (player, "training_mantis_rockets", tutorialTimeLimit);
				TutorialShowIfNotPerformed (player, "training_mantis_rockets", TUTORIAL.MantisRockets, tutorialTimeLimit);
				g_TutorialPlayers[i].SeenMantisRockets = true;
				g_TutorialPlayers[i].InVehicle = true;
			elseif (g_TutorialPlayers[i].ClimbInTime >= mantisClimbInTimeLimit) and (g_TutorialPlayers[i].MantisTime >= mantisTimeLimit) and (not g_TutorialPlayers[i].SeenMantisStomp) and (unit_in_vehicle_type (player, 38)) then
				--print ("player in Mantis");
				--tjp 7-30-2015 https://entomo:8443/browse/OSR-140083
				--TutorialShow (player, "training_mantis_stomp", tutorialTimeLimit);
				TutorialShowIfNotPerformed (player, "training_mantis_stomp", TUTORIAL.MantisStomp, tutorialTimeLimit);
				g_TutorialPlayers[i].SeenMantisStomp = true;
				g_TutorialPlayers[i].InVehicle = true;
			end
			
			--tracks the time in the mantis
			if (g_TutorialPlayers[i].ClimbInTime > mantisClimbInTimeLimit) and (unit_in_vehicle_type (player, 38)) and g_TutorialPlayers[i].MantisTime < mantisTimeLimit then
				g_TutorialPlayers[i].MantisTime = g_TutorialPlayers[i].MantisTime + sleepTime;
				--print ("mantis time is ", g_TutorialPlayers[i].MantisTime);
			end
			
			--stops any tutorial messages if necessary
			if (g_TutorialPlayers[i].InVehicle) and (not unit_in_vehicle (player)) then
				--print ("player not in vehicle ", player);
				TutorialStop (player);
				g_TutorialPlayers[i].InVehicle = false;
			end
		end
		
		sleep_s (sleepTime);
	until false;
end

function TutorialGlobal(obj:object, interactor:object)
	print ("the object is ", obj);
	print ("the interactor is ", interactor);

end


--------------


--[[
   ______                                         _____           _       __      
  / ____/___  ____ ___  ____ ___  ____  ____     / ___/__________(_)___  / /______
 / /   / __ \/ __ `__ \/ __ `__ \/ __ \/ __ \    \__ \/ ___/ ___/ / __ \/ __/ ___/
/ /___/ /_/ / / / / / / / / / / / /_/ / / / /   ___/ / /__/ /  / / /_/ / /_(__  ) 
\____/\____/_/ /_/ /_/_/ /_/ /_/\____/_/ /_/   /____/\___/_/  /_/ .___/\__/____/  
                                                               /_/                
--]]
--tjp 7-20-2015: copy/pasted to help with https://entomo:8443/browse/OSR-141823
function stop_valid_composition(comp:number):void	
	if(comp ~= nil)then
		composer_stop_show (comp);
		comp = nil;
	end
end

--bashwall_listener(OBJECTS.crate_keyhole_bashwall_01, HINTS.jh_bashwall_01);

--tjp 7-20-2015: copy/pasted to help with https://entomo:8443/browse/OSR-140178
--bashwall_listener(OBJECTS.crate_keyhole_bashwall_01, HINTS.jh_kh_bashwall_01);
--bashwall_listener(OBJECTS.crate_keyhole_bashwall_02, HINTS.jh_kh_bashwall_02);
--bashwall_listener(OBJECTS.crate_keyhole_bashwall_03, HINTS.jh_kh_bashwall_03);
--bashwall_listener(OBJECTS.crate_keyhole_bashwall_04, HINTS.jh_kh_bashwall_04);
--bashwall_listener(OBJECTS.crate_airlock_bashwall_01, HINTS.jh_airlock_bashwall_01);
--bashwall_listener(OBJECTS.crate_airlock_bashwall_02, HINTS.jh_airlock_bashwall_02);
--bashwall_listener(OBJECTS.crate_sinkhole_bashwall_01, HINTS.jh_sinkhole_bashwall_01);
function bashwall_listener(wall:object, jumphint:hint):void
	ai_disable_jump_hint(jumphint);
	SleepUntil([| object_get_health(wall) <= 0 ], 20);
	ai_enable_jump_hint(jumphint);
	print("enable jump hint");
end

--Shared command script for setting ai to be deaf and blind
function cs_ai_deaf():void
	cs_abort_on_damage(ai_current_actor, true);
	ai_set_deaf(ai_current_actor, true);
  ai_set_blind(ai_current_actor, true);
end


--shared command script for enabling sight and hearing for ai
function cs_ai_undeaf():void
	ai_set_deaf(ai_current_actor, false);
  ai_set_blind(ai_current_actor, false);
end


--shared command script for enabling friendly carrot and invincibility
function cs_ai_friendly():void
		navpoint_track_object_named(ai_current_actor, "ally");
		ai_cannot_die(ai_current_squad, true);
end

function cs_ai_friendly_marker():void
		navpoint_track_object_named(ai_current_actor, "ally");
end

--muskbox script
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
					or IsGoalActive(goal) == false
					],1);
		print("EXITEXITEXITEXITEXITEXIT");
		MusketeerUtil_SetDestination_Clear_All()
	until (IsGoalActive(goal) == false);
	MusketeerUtil_SetDestination_Clear_All()
end

function audio_cinematic_mute_grotto()
	SoundImpulseStartServer(TAG('sound\031_states\031_st_osiris_campaign_cinematics\031_st_osiris_campaign_cinematic_black_screen.sound'), nil, 1);
end


--[[
   _________            __     _____           _       __      
  / ____/ (_)__  ____  / /_   / ___/__________(_)___  / /______
 / /   / / / _ \/ __ \/ __/   \__ \/ ___/ ___/ / __ \/ __/ ___/
/ /___/ / /  __/ / / / /_    ___/ / /__/ /  / / /_/ / /_(__  ) 
\____/_/_/\___/_/ /_/\__/   /____/\___/_/  /_/ .___/\__/____/  
                                            /_/                
--]]                                        
                                            
--## CLIENT

function startupClient.grotto_flies_fx_01_enabled()
      print ("enable grotto bug fx");
			repeat
			SleepUntil ([| volume_test_object(VOLUMES.tv_fx_flies_01, PLAYERS.local0) ], 1);
                   effect_attached_to_camera_new (TAG('levels\campaignworld020\w2_grotto\fx\ambient_life\cov_ambient_bugs.effect'))
				   print ("starting bug FX");
				   
                   SleepUntil ([| not volume_test_object(VOLUMES.tv_fx_flies_01, PLAYERS.local0) ], 1);
				   effect_attached_to_camera_stop (TAG('levels\campaignworld020\w2_grotto\fx\ambient_life\cov_ambient_bugs.effect'))
				   print ("stopping bug FX");
								
			until false;
end

function startupClient.grotto_flies_fx_02_enabled()
      print ("enable grotto bug fx");

			repeat
				   SleepUntil ([| volume_test_object(VOLUMES.tv_fx_flies_02, PLAYERS.local0) ], 1);
                   effect_attached_to_camera_new (TAG('levels\campaignworld020\w2_grotto\fx\ambient_life\cov_ambient_bugs.effect'))
				   print ("starting bug FX");
				   
                   SleepUntil ([| not volume_test_object(VOLUMES.tv_fx_flies_02, PLAYERS.local0) ], 1);
				   effect_attached_to_camera_stop (TAG('levels\campaignworld020\w2_grotto\fx\ambient_life\cov_ambient_bugs.effect'))
				   print ("stopping bug FX");
								
			until false;  
end


--[[
    __  __      __    ___            
   / / / /___  / /___/ (_)___  ____ _
  / /_/ / __ \/ / __  / / __ \/ __ `/
 / __  / /_/ / / /_/ / / / / / /_/ / 
/_/ /_/\____/_/\__,_/_/_/ /_/\__, /  
                            /____/   
--]]                                        

--PlayAnimation (device:object, layer:number, name:string, rate:number):void
	
--Turret Destruction script
		--object_damage_damage_section (OBJECTS.dm_courtyard_turret_01, "default", 1000);
		--object_damage_damage_section (OBJECTS.dm_courtyard_turret_02, "default", 1000);		
		--CreateThread(turret_explode, OBJECTS.dm_courtyard_turret_01);
		--CreateThread(turret_explode, OBJECTS.dm_courtyard_turret_02);
	

-- Various CS Action Notes

			--0		_ai_atom_action_berserk,			-- works - roar
			--1       _ai_atom_action_surprise_front,	-- works - hop back
			--2       _ai_atom_action_surprise_back,	-- works - flip aroun - translates
			--3       _ai_atom_action_evade_left,
			--4       _ai_atom_action_evade_right,
			--5       _ai_atom_action_dive_forward,
			--6       _ai_atom_action_dive_back,		-- works - roll backward + jump
			--7       _ai_atom_action_dive_left,
			--8       _ai_atom_action_dive_right,
			--9       _ai_atom_action_advance,			-- point (no foot slide)
			--10       _ai_atom_action_cheer,			-- no
			--11       _ai_atom_action_fallback,		-- no
			--12       _ai_atom_action_hold,			-- no
			--13       _ai_atom_action_point,			-- works! elites and grunts (not sure about jax)
			--14       _ai_atom_action_posing,			-- works on grunts, not on elites. Same as 18?
			--15       _ai_atom_action_shakefist,		-- works great
			--16       _ai_atom_action_signal_attack,	-- no
			--17       _ai_atom_action_signal_move,		-- no
			--18       _ai_atom_action_taunt,			-- works on grunts, not on elites. Same as 14?
			--19       _ai_atom_action_warn,			-- works on elites - looks like a point with a foot slide
			--20       _ai_atom_action_wave,			-- no
