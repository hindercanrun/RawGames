--## SERVER

global n_ur_mongoose_cheevo:number = 0;

--[[
          ___        __  __                       _____                         __   ____                        __      
 _      _|__ \ _    / / / /___  _________  ____  / __(_)________ ___  ___  ____/ /  / __ \___  ____  ____  _____/ /______
| | /| / /_/ /(_)  / / / / __ \/ ___/ __ \/ __ \/ /_/ / ___/ __ `__ \/ _ \/ __  /  / /_/ / _ \/ __ \/ __ \/ ___/ __/ ___/
| |/ |/ / __/_    / /_/ / / / / /__/ /_/ / / / / __/ / /  / / / / / /  __/ /_/ /  / _, _/  __/ /_/ / /_/ / /  / /_(__  ) 
|__/|__/____(_)   \____/_/ /_/\___/\____/_/ /_/_/ /_/_/  /_/ /_/ /_/\___/\__,_/  /_/ |_|\___/ .___/\____/_/   \__/____/  
                                                                                           /_/                           
--]]

global UnconfirmedReports:table=
	{
		name = "w1_unconfirmed_reports",
		--description = "Unconfirmed Reports: Locke continues to investigate unconfirmed reports that the Master Chief is on Meridian",
		--profiles = {STARTING_PROFILES.sp_ur_locke, STARTING_PROFILES.sp_ur_buck, STARTING_PROFILES.sp_ur_tanaka, STARTING_PROFILES.sp_ur_vale},	
		points = POINTS.ps_level_start,
		startGoals = {"goal_mining_base"},
		
--================================================================
-- COLLECTIBLES
--================================================================
collectibles = {
	{objectName = "unconfirmed_collect_01" , collectibleName = "unconfirmed_collect_01"},
	{objectName = "unconfirmed_collect_02" , collectibleName = "unconfirmed_collect_02"},
	{objectName = "unconfirmed_collect_03" , collectibleName = "unconfirmed_collect_03"},
	{objectName = "unconfirmed_collect_04" , collectibleName = "unconfirmed_collect_04"},
	{objectName = "unconfirmed_collect_05" , collectibleName = "unconfirmed_collect_05"},
	{objectName = "unconfirmed_collect_06" , collectibleName = "unconfirmed_collect_06"},
	{objectName = "unconfirmed_collect_07" , collectibleName = "unconfirmed_collect_07"},
	{objectName = "unconfirmed_collect_skull", collectibleName = "collectible_skull_blind"} 
							}
--================================================================
-- COLLECTIBLES END
--================================================================
	}

--[[
   _____ __             __     __                   __   _____           _       __      
  / ___// /_____ ______/ /_   / /   ___ _   _____  / /  / ___/__________(_)___  / /______
  \__ \/ __/ __ `/ ___/ __/  / /   / _ \ | / / _ \/ /   \__ \/ ___/ ___/ / __ \/ __/ ___/
 ___/ / /_/ /_/ / /  / /_   / /___/  __/ |/ /  __/ /   ___/ / /__/ /  / / /_/ / /_(__  ) 
/____/\__/\__,_/_/   \__/  /_____/\___/|___/\___/_/   /____/\___/_/  /_/ .___/\__/____/  
                                                                      /_/                
--]]

function startup.init_UnconfirmedReports()
	if not editor_mode() then
		fade_out(0, 0, 0, 0);
		StartUnconfirmedReports();

	else
		print ("in editor, run StartUnconfirmedReports() to start mission");
	end
	local repairedUnit:object = nil;
	RegisterPrometheanArmorRepairEvent(ArmorRepaired, repairedUnit);
end

--function startup.Profile()
--	SleepUntil ([| PlayersAreAlive()], 1);
--	local sps = 
--						{
--						[SPARTANS.locke]	=	STARTING_PROFILES.sp_ur_start_locke,
--						[SPARTANS.vale] 	= STARTING_PROFILES.sp_ur_start_vale,
--						[SPARTANS.tanaka]	= STARTING_PROFILES.sp_ur_start_tanaka,
--						[SPARTANS.buck] 	= STARTING_PROFILES.sp_ur_start_buck,
--						};
--						
--	for sp, profile in pairs (sps) do
--		SleepUntil ([| object_get_health(sp) > 0], 1);
--		player_set_profile (profile, sp);
--		unit_add_equipment (sp, profile, true, true);
--	end
--end

function StartUnconfirmedReports()
	StartMission(UnconfirmedReports);
	SleepUntil([|object_valid("dc_door_ship_tracking_01")], 1);
	ObjectSetSpartanTrackingEnabled(OBJECTS.dc_door_ship_tracking_01, false);
end

-- #####################################################
-- Achievement stuff start
function ArmorRepaired(repairedUnit:object)
	print("Armor repaired unit:");
	print(repairedUnit);
	RegisterDeathEvent(ArmorRepairDeath, repairedUnit);
end

function ArmorRepairDeath(deadObject:object, killerObject:object, aiSquad:object, damageModifier:number, damageSource:ui64, damageType:ui64)
	print ("Object was killed after armor repair:");
	print(deadObject);
	print("ACHIEVEMENT UNLOCKED");
	CampaignScriptedAchievementUnlocked(7);
end

--function UR_MongooseDeath(ur_dead_unit, ur_killer):void
--	for _, player in pairs(players()) do
--		if player ~= ur_killer then
--			if unit_get_vehicle(ur_killer) == unit_get_vehicle(player) then
--				n_ur_mongoose_cheevo = n_ur_mongoose_cheevo+1;
--				print("______ achievement: goal + 1");
--				if n_ur_mongoose_cheevo == 30 then
--					print("______ achievement unlocked");
--					CampaignScriptedAchievementUnlocked(8);
--				end
--			end
--		end
--	end
--end

function UR_MongooseDeath( ur_dead_unit:object, ur_killer:object)
	local b_found_forerunner:boolean = false;
	local ur_fore_list:object_list = metalabel_filter_objectlist( "forerunner", ur_dead_unit );
	print("_____________ UR_MongooseDeath = ", ur_dead_unit);
	if ur_fore_list then
		for i, forerunner_dude in ipairs ( ur_fore_list ) do
			b_found_forerunner = true;
		end
	end

	if b_found_forerunner then
		for _, player in pairs(players()) do
			if player ~= ur_killer then
				if unit_get_vehicle(ur_killer) ~= nil then
					if unit_get_vehicle(ur_killer) == unit_get_vehicle(player) then
						n_ur_mongoose_cheevo = n_ur_mongoose_cheevo + 1;
						print("______ achievement: goal + 1");
						if n_ur_mongoose_cheevo == 30 then
							print("______________________ achievement unlocked !!!!");
							CampaignScriptedAchievementUnlocked(8);
						end
					end
				end
			end
		end       
	end
end


-- Achievement stuff end
-- #####################################################


--function UnconfirmedReports.Start()
--	print ("start unconfirmed_reports");
	--CreateThread(w1_unconfirmed_nar_startup);
--	if current_zone_set() ~= (ZONE_SETS.zs_030) then
--  	switch_zone_set(ZONE_SETS.zs_030);
--  	SleepUntil ([| current_zone_set_fully_active() == ZONE_SETS.zs_030], 1);
--  end
  --Sys_TeleportPlayers(UnconfirmedReports);
--end

--COMPLETE MISSION

--[[
    ______          __   __                   __   _____           _       __      
   / ____/___  ____/ /  / /   ___ _   _____  / /  / ___/__________(_)___  / /______
  / __/ / __ \/ __  /  / /   / _ \ | / / _ \/ /   \__ \/ ___/ ___/ / __ \/ __/ ___/
 / /___/ / / / /_/ /  / /___/  __/ |/ /  __/ /   ___/ / /__/ /  / / /_/ / /_(__  ) 
/_____/_/ /_/\__,_/  /_____/\___/|___/\___/_/   /____/\___/_/  /_/ .___/\__/____/  
                                                                /_/                
--]]

function UnconfirmedReports.End()
	sys_LoadEvacuation();
end

--[[
    ____  ___       __      __                _     
   / __ )/ (_)___  / /__   / /   ____  ____ _(_)____
  / __  / / / __ \/ //_/  / /   / __ \/ __ `/ / ___/
 / /_/ / / / / / / ,<    / /___/ /_/ / /_/ / / /__  
/_____/_/_/_/ /_/_/|_|  /_____/\____/\__, /_/\___/  
                                    /____/          
--]]

function BlinkMiningBase()
	print ("Blinking to Mining Base");
	GoalBlink (UnconfirmedReports, "goal_mining_base");
	CreateThread(audio_unconfirmedreports_stopallmusic);
end

--function BlinkShipPath()
--	print ("Blinking to Ship Path");
--	GoalBlink (UnconfirmedReports, "goal_chief_ship");
--	CreateThread(audio_unconfirmedreports_stopallmusic);
--end

function BlinkChiefShip()
	print ("Blinking to Chief Ship");
	GoalBlink (UnconfirmedReports, "goal_chief_ship");
	CreateThread(audio_unconfirmedreports_stopallmusic);
end

function BlinkQuarry()
	print ("Blinking to Quarry");
	GoalBlink (UnconfirmedReports, "goal_quarry");
	CreateThread(audio_unconfirmedreports_stopallmusic);
end

function BlinkUpperMines()
	print ("Blinking to Upper Mines");
	GoalBlink (UnconfirmedReports, "goal_upper_mines");
	CreateThread(f_ur_upper_mines_airlock);
	CreateThread(audio_unconfirmedreports_stopallmusic);
end

function BlinkLavaLift()
	print ("Blinking to Lava Lift");
	GoalBlink (UnconfirmedReports, "goal_lava_lift");
	CreateThread(audio_unconfirmedreports_stopallmusic);
end
