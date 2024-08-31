--## SERVER

--[[
████████╗███████╗██╗   ██╗███╗   ██╗ █████╗ ███╗   ███╗██╗    ███████╗████████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
╚══██╔══╝██╔════╝██║   ██║████╗  ██║██╔══██╗████╗ ████║██║    ██╔════╝╚══██╔══╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
   ██║   ███████╗██║   ██║██╔██╗ ██║███████║██╔████╔██║██║    ███████╗   ██║   ███████║   ██║   ██║██║   ██║██╔██╗ ██║
   ██║   ╚════██║██║   ██║██║╚██╗██║██╔══██║██║╚██╔╝██║██║    ╚════██║   ██║   ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
   ██║   ███████║╚██████╔╝██║ ╚████║██║  ██║██║ ╚═╝ ██║██║    ███████║   ██║   ██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
   ╚═╝   ╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝    ╚══════╝   ╚═╝   ╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
                                                                                                                      
██╗   ██╗██╗ ██████╗ ███╗   ██╗███████╗████████╗████████╗███████╗███████╗                                             
██║   ██║██║██╔════╝ ████╗  ██║██╔════╝╚══██╔══╝╚══██╔══╝██╔════╝██╔════╝                                             
██║   ██║██║██║  ███╗██╔██╗ ██║█████╗     ██║      ██║   █████╗  ███████╗                                             
╚██╗ ██╔╝██║██║   ██║██║╚██╗██║██╔══╝     ██║      ██║   ██╔══╝  ╚════██║                                             
 ╚████╔╝ ██║╚██████╔╝██║ ╚████║███████╗   ██║      ██║   ███████╗███████║                                             
  ╚═══╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝   ╚═╝      ╚═╝   ╚══════╝╚══════╝                                             
Tsunami Station Vignettes
------------------------------------------------------------------------------------
--]]

global var_tsunami_dogfight_01:number=nil;
global var_tsunami_phantom_crash_01:number=nil;
global var_elite_turret_yell:number=nil;
global var_tsunami_phantom_crash_02:number=nil;
global var_cruiser_crash:number=nil;
global var_cruiser_strafe:number=nil;
global var_tsunami_battle_01:number=nil;
global var_tsunami_theater_intro:number=nil;
global var_tsunami_theater_burger:number=nil;
global var_tsunami_theater_turret:number=nil;
global var_tsunami_theater_slip:number=nil;
global var_tsunami_theater_ub1:number=nil;
global var_tsunami_theater_arcade:number=nil;
global var_tsunami_dogfight_03:number=nil;
global var_tsunami_dogfight_04:number=nil;
global var_tsunami_lich_dropoff:number=nil;
global var_arb_v_kni:number=nil;
global var_deadelites:number=nil;
global var_arcade_deathcomp:number=nil;
global b_arcadecomp_idle1end:boolean = false;
global b_arcadecomp_idle2end:boolean = false;
global b_arcadecomp_idle3end:boolean = false;
global var_grunt_v_jackal:number=nil;
global var_soldierbamf:number=nil;
global var_grunt_crawler_war:number=nil;
global var_guardian_bail=0;
global var_dogfight_05=0;
global var_dogfight_06=0;
global var_dogfight_07=0;
global var_dogfight_08=0;
global var_dogfight_09=0;
global var_dogfight_10=0;
global var_dogfight_11=0;
global var_dogfight_12=0;
global var_dogfight_13=0;
global playerstartcollapse:object=nil;
global playersinvolume:object=nil;
global tanakastumble:boolean=false;
global buckstumble:boolean=false;
global valestumble:boolean=false;
global lockestumble:boolean=false;
global bridgeDown:boolean = false;
global stumbleDone:boolean = false;
global grunt_whack_jackal:boolean = false;
global burger_ships_moving = false;
global turret_ships_moving = false;
global theater_slip_reinforements = false;
global var_cruiser_crash_start = false;
global var_lookat_dogfight_05_phantom:boolean = false;


----------------

function lich_dropoff():void
	print ("lich is leaving");
	var_tsunami_lich_dropoff = composer_play_show ("vin_tsunami_lich_dropoff");
end

function dogfight_05():void
	print ("DOGFIGHT_05");
	var_dogfight_05 = composer_play_show ("vin_tsunami_dogfight_05");
	SleepUntil(	[|   volume_test_player_lookat(VOLUMES.tv_lookat_dogfight_05_phantom, SPARTANS.locke, 40, 5)
				or	volume_test_players(VOLUMES.tv_end_missionstart)
				], 5);
	var_lookat_dogfight_05_phantom = true;
end



function grunt_v_jackal():void
	print ("grunt SMASH");
	var_grunt_v_jackal = composer_play_show ("vin_tsu_grunt_v_jackal");
	SleepUntil ([|	volume_test_players (VOLUMES.tv_grunt_whack_jackal)], 3);
	grunt_whack_jackal = true;
end

function tsunami_battle_01():void
	print ("firing up the cruisers");
	var_tsunami_battle_01 = composer_play_show ("vin_tsunami_battle_01");
end

function tsunami_theater_intro():void
	print ("firing up Theater of war in Intro");
	var_tsunami_theater_intro = composer_play_show ("vin_tsunami_theater_intro");
end

function tsunami_theater_burger():void
	print ("firing up Theater of war in Burgertown");
	var_tsunami_theater_burger = composer_play_show ("vin_tsunami_theater_burger");
	CreateThread (tsunami_theater_burger_move_in);
end

function tsunami_theater_burger_move_in():void
	print ("burger ships moving");
	SleepUntil ([|	volume_test_players (VOLUMES.tv_burger_ships)], 3);
	burger_ships_moving = true;
end

function tsunami_theater_turret():void
	print ("firing up Theater of war in Intro");
	var_tsunami_theater_turret = composer_play_show ("vin_tsunami_theater_turret");
	CreateThread (tsunami_theater_turret_move_in);
end

function tsunami_theater_turret_move_in():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_dogfight_01)], 3);
	turret_ships_moving = true;
end

function tsunami_theater_slip():void
--	SleepUntil ([|	volume_test_players (VOLUMES.tv_comp_intro_1)], 2);
	print ("firing up Theater of war - Slip");
	var_tsunami_theater_slip = composer_play_show ("vin_tsunami_theater_slip");
	CreateThread (tsunami_theater_slip_2);
end

function tsunami_theater_slip_2():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_slip_reinforcements)], 2);
	print ("BRING IN THE REINFORCEMENTS");
	theater_slip_reinforements = true;
	end

function elite_yelling():void
	print ("elite yelling");
	var_elite_turret_yell = composer_play_show ("vin_tsunami_elite_turret");
end

function dead_bodies():void
	print ("dead bodies");
	SleepUntil ([|	volume_test_players (VOLUMES.tv_end_trans_arcade)], 3);
	print ("dead bodies trigger hit, playing composition");
--	var_deadelites = composer_play_show ("vin_tsu_dead_bodies");				-- removing, to be replaced by prefabs
end
function corpse_team():void
	ai_object_set_team(pup_current_puppet, TEAM.covenant_player);
end
function arcade_death_compositions():void
	print ("Loading Arcade Death Compositions");
	var_arcade_deathcomp = composer_play_show ("vin_tsu_arcadecomp");
	print ("Arcade Death Compositions loaded");
	SleepUntil ([|	volume_test_players (VOLUMES.tv_arcadecomp_stopidle1)], 3);
	b_arcadecomp_idle1end = true;
	CreateThread(audio_tsunami_dead_bodies);
	print ("Trigger hit, playing out the first idle anims");
	SleepUntil ([|	volume_test_players (VOLUMES.tv_arcadecomp_stopidle2)], 3);
	b_arcadecomp_idle2end = true;
	print ("Trigger hit, playing out the second idle anims");
	SleepUntil ([|	volume_test_players (VOLUMES.tv_arcadecomp_stopidle3)], 3);
	b_arcadecomp_idle3end = true;
	print ("Trigger hit, playing out the third idle anims");
end



function dogfight_06():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_dogfight_06)], 2);
	print ("dogfight_06");
	var_dogfight_06 = composer_play_show ("vin_tsunami_dogfight_06");
	end

function dogfight_07():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_dogfight_07)], 2);
	print ("dogfight_07");
	var_dogfight_07 = composer_play_show ("vin_tsunami_dogfight_07");
end

function dogfight_08():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_dogfight_08)], 2);
	print ("dogfight_08");
	var_dogfight_08 = composer_play_show ("vin_tsunami_dogfight_08");
end

function dogfight_09():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_dogfight_09)], 2);
	print ("dogfight_09");
	var_dogfight_09 = composer_play_show ("vin_tsunami_dogfight_09");
end

function dogfight_10():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_dogfight_10)], 2);
	print ("dogfight_10");
	var_dogfight_10 = composer_play_show ("vin_tsunami_dogfight_10");
end

function dogfight_11():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_dogfight_11)], 2);
	print ("dogfight_11");
	var_dogfight_11 = composer_play_show ("vin_tsunami_dogfight_11");
end

function dogfight_13():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_dogfight_13)], 2);
	print ("dogfight_13");
	var_dogfight_13 = composer_play_show ("vin_tsunami_dogfight_13");
end

function dogfight_01():void
	print ("dogfight_01 playing");
	SleepUntil ([|	volume_test_players (VOLUMES.tv_dogfight_01)], 3);
	var_tsunami_dogfight_01 = composer_play_show ("vin_tsunami_dogfight_01");
end

function dogfight_03():void
	print ("dogfight_03 playing");
	SleepUntil ([|	volume_test_players (VOLUMES.tv_dogfight_03)], 3);
	var_tsunami_dogfight_03 = composer_play_show ("vin_tsunami_dogfight_03");
end

function dogfight_04():void
	print ("dogfight_04 playing");
	SleepUntil ([|	volume_test_players (VOLUMES.tv_dogfight_04)], 3);
	var_tsunami_dogfight_04 = composer_play_show ("vin_tsunami_dogfight_04");
	var_dogfight_12 = composer_play_show ("vin_tsunami_dogfight_12");
end

function cruiser_crash():void
	print ("cruiser_crash loaded");
	var_cruiser_crash = composer_play_show ("vin_tsunami_cruiser_crash");
	CreateThread(cruiser_crash_start);
end

function cruiser_crash_start():void
	print ("cruiser_crash playing");
	SleepUntil ([|	volume_test_players (VOLUMES.tv_cruiser_crash)], 3);
	var_cruiser_crash_start = true;
end

function phantom_crash_01():void
	print ("phantom_crash_01 playing");
	SleepUntil ([|	volume_test_players (VOLUMES.tv_phantom_crash_01)], 3);
	var_tsunami_phantom_crash_01 = composer_play_show ("vin_tsunami_phantom_crash_01");
end

function guardian_rise():void
	SleepUntil([| volume_test_players(VOLUMES.tv_turrettown)], 3);
	CreateThread (audio_turrettown_musicstart);
	print ("play guardian rise show");
--	var_comp_guardian_rise = composer_play_show ("vin_tsunami_guardian_rise");
end


--[[
function phantom_crash_02():void
	print ("phantom_crash_02 playing");
	SleepUntil ([|	volume_test_players (VOLUMES.tv_phantom_crash_02)], 1);
	var_tsunami_phantom_crash_02 = composer_play_show ("vin_tsunami_phantom_crash_02");
end
--]]

function cruiser_strafe():void
	print ("cruiser_strafe is playing");
	SleepUntil ([|	volume_test_players (VOLUMES.tv_cruiser_strafe)], 3);
	var_cruiser_strafe = composer_play_show ("vin_tsunami_cruiser_strafe");
end

function grunt_crawler_war():void
	SleepUntil ([|	volume_test_players (VOLUMES.tv_pawnreveal_load)], 3);
	var_grunt_crawler_war = composer_play_show ("w2_tsunami_grunt_crawler_war");
	print ("pawns gnoshin on gruntmeat");
	AIDialogManager.DisableAIDialog(AI.grunt_crawler_war.grunt);
end

function soldierbamf():void
	print ("SOLDIER SMACK");
	SleepUntil ([|	volume_test_players (VOLUMES.tv_soldierbamf)], 3);
	var_soldierbamf = composer_play_show ("vin_soldierbamf");
end

function arb_v_kni():void
	print("vin_tsu_arb_v_kni");
	print("vin_tsu_arb_v_kni");
	print("vin_tsu_arb_v_kni");
	print("vin_tsu_arb_v_kni");
	print("vin_tsu_arb_v_kni");
	Sleep(2);
	var_arb_v_kni = composer_play_show ("vin_tsu_arb_v_kni");

	
	
	SleepUntil ([|	volume_test_players (VOLUMES.tv_arb_v_kni01)
				or	volume_test_players (VOLUMES.tv_arb_v_kni02)
				or	volume_test_players (VOLUMES.tv_arbitervignette)
				], 3);
	print ("arb_v_kni trigger hit, playing composition");
	b_arb_kills_knight = true;
end

function tsunami_theater_ub1():void
	print ("sleeping for theater of war in Underbelly 1");
	SleepUntil ([|	volume_test_players (VOLUMES.tv_underbelly1_theater)], 3);
	print ("firing up theater of war in Underbelly 1");
	var_tsunami_theater_ub1 = composer_play_show ("vin_tsunami_theater_ub1");
end

function guardian_bail():void
	print ("guardians bailling");
	var_guardian_bail = composer_play_show ("vin_tsunami_guardian_bail");
end


--** Font name is ANSI Shadow.