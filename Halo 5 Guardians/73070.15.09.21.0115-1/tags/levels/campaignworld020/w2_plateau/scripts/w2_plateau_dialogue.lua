--## SERVER



--[[

-- =================================================================================================
-- *** PLATEAU DIALOGUE ***
-- =================================================================================================


-- =================================================================================================
-- *** GLOBALS ***
-- =================================================================================================

	global b_ritualIsInterrupted:boolean=false;

	global b_playerIsInDropdown:boolean=false;
	global b_dropdownChat:boolean=false;
	global b_playerIsInHollow:boolean=false;
	global b_playerIsInRamp:boolean=false;
	global b_playerIsInTemple:boolean=false;
	global b_playerIsInBowl:boolean=false;
	global b_playerIsInSentryBattle:boolean=false;
	global b_playerIsInSoldierRoom:boolean=false;

	global wallMeltingDialInterruptIndex:number=0;
	global wallMeltingDialInterrupt:boolean=false;
	
	global b_player_in_vtol1:boolean=false;
	global b_player_in_vtol2:boolean=false;
	global b_player_in_vtol1b:boolean=false;
	global b_player_in_vtol2b:boolean=false;
	global b_temple_shutter_left:boolean=false;
	global b_temple_shutter_right:boolean=false;
	global b_temple_talking_about_a_clue:boolean=false;
	global b_tracking_partial:boolean=false;
	
	global b_nezik_can_speak:boolean=false;
	global b_shield_light_damage=false;
	global b_shield_heavy_damage=false;
	global b_shield_skip_intro=false;
	global b_sentryreveal_kill:boolean=false;
	global kill_forcefieldtraining:boolean=false;
	global b_balcony_killed:boolean=false;
	global sentrybattle_ship_kill:boolean=false;
	global sentryship_vo_kill:boolean=false;
	global sentryship_vo_playing:boolean=false;
	global b_soldier_nag_playing:boolean=false;
	global b_kill_prebowl_vo_playing:boolean=false;
	global b_kill_prebowl_vo:boolean=false;
	global shield_vo_playing:boolean=false;
	global b_locke_on_board_sentry_ship:boolean=false;
	global b_tanaka_on_board_sentry_ship:boolean=false;
	global b_vale_on_board_sentry_ship:boolean=false;
	global b_thorne_on_board_sentry_ship:boolean=false;
	global b_shield_is_down:boolean=false;
	global b_temple_complete:boolean=false;
	global b_temple_chatter_playing:boolean=false;
	global b_wall_melting_vignette_is_playing:boolean=false;
	global n_tracking_chatter_timer:number=30;
	global n_tracking_tracker_equipped_timer:number=30;
	
	global b_grunt_says_break_the_ritual:boolean=false;

	global b_temple_first_ping_enable:boolean=false;
	
	global g_locke_tracker_equiped:boolean=false;
	global g_buck_tracker_equiped:boolean=false;
	global g_tanaka_tracker_equiped:boolean=false;
	global g_vale_tracker_equiped:boolean=false;
	
	global b_reaction_to_kraken:boolean=false;
	
	global b_KrakenLiftOff:boolean=false;
	global b_soldierRoomTeleport:boolean=false;
	
	global b_GotPlateauConstructor:boolean=false;
	
	global b_sentry_horn_1:boolean=false;
	global b_sentry_horn_2:boolean=false;

	global b_warrior_at_birth_played:boolean=false;
	global b_bowl_everybody_is_dead_vo:boolean=false;
	
	
-- =================================================================================================
-- *** MAIN ***
-- =================================================================================================

--   __          __     _  ________       _____  _            _______ ______         _    _        _____  _____ _____  _____ _____ _______ _____ 
--   \ \        / /\   | |/ /  ____|     |  __ \| |        /\|__   __|  ____|   /\  | |  | |      / ____|/ ____|  __ \|_   _|  __ \__   __/ ____|
--    \ \  /\  / /  \  | ' /| |__        | |__) | |       /  \  | |  | |__     /  \ | |  | |     | (___ | |    | |__) | | | | |__) | | | | (___  
--     \ \/  \/ / /\ \ |  < |  __|       |  ___/| |      / /\ \ | |  |  __|   / /\ \| |  | |      \___ \| |    |  _  /  | | |  ___/  | |  \___ \ 
--      \  /\  / ____ \| . \| |____      | |    | |____ / ____ \| |  | |____ / ____ \ |__| |      ____) | |____| | \ \ _| |_| |      | |  ____) |
--       \/  \/_/    \_\_|\_\______|     |_|    |______/_/    \_\_|  |______/_/    \_\____/      |_____/ \_____|_|  \_\_____|_|      |_| |_____/ 

-- =================================================================================================



function plateau_dialogue_main():void
	print("NARRATIVE  -  SANGHELIOS - Plateau - Start ");

--	Wake(dormant.plateau_missionstart);	
	Wake(dormant.plateau_breach_wake);
	Wake(dormant.plateau_dropdown_wake);
	Wake(dormant.plateau_sentryreveal_wake);
	Wake(dormant.plateau_hollow_wake);
	Wake(dormant.plateau_cave_wake);	
	Wake(dormant.plateau_ramp_wake);	
	Wake(dormant.plateau_oreobowl_wake);		
	Wake(dormant.plateau_temple_wake);		
	Wake(dormant.plateau_sentrybattle_wake);			 
	Wake(dormant.plateau_soldier_wake);		

--	SET THE DISPLAY OF TEMP BLURB OFF	
	dialog_line_temp_blurb_force_set(false);
	b_temp_line_display_blurb = false;

--	SET THE NARRATIVE DEBUG INFO ON
	g_display_narrative_debug_info = true;

	

	print("Narrative log display is:", g_display_narrative_debug_info);
	
end



-- =================================================================================================
--    _  _______ _      _            _____  _            _______ ______         _    _        _____  _____ _____  _____ _____ _______ _____ 
--   | |/ /_   _| |    | |          |  __ \| |        /\|__   __|  ____|   /\  | |  | |      / ____|/ ____|  __ \|_   _|  __ \__   __/ ____|
--   | ' /  | | | |    | |          | |__) | |       /  \  | |  | |__     /  \ | |  | |     | (___ | |    | |__) | | | | |__) | | | | (___  
--   |  <   | | | |    | |          |  ___/| |      / /\ \ | |  |  __|   / /\ \| |  | |      \___ \| |    |  _  /  | | |  ___/  | |  \___ \ 
--   | . \ _| |_| |____| |____      | |    | |____ / ____ \| |  | |____ / ____ \ |__| |      ____) | |____| | \ \ _| |_| |      | |  ____) |
--   |_|\_\_____|______|______|     |_|    |______/_/    \_\_|  |______/_/    \_\____/      |_____/ \_____|_|  \_\_____|_|      |_| |_____/ 

-- =================================================================================================

function plateau_mission_end():void
PrintNarrative("Narrative - KILL PLATEAU scenes");

end



-- =================================================================================================
--  __  __ _____  _____ _____ _____ ____  _   _    _____ _______       _____ _______ 
-- |  \/  |_   _|/ ____/ ____|_   _/ __ \| \ | |  / ____|__   __|/\   |  __ \__   __|
-- | \  / | | | | (___| (___   | || |  | |  \| | | (___    | |  /  \  | |__) | | |   
-- | |\/| | | |  \___ \\___ \  | || |  | | . ` |  \___ \   | | / /\ \ |  _  /  | |   
-- | |  | |_| |_ ____) |___) |_| || |__| | |\  |  ____) |  | |/ ____ \| | \ \  | |   
-- |_|  |_|_____|_____/_____/|_____\____/|_| \_| |_____/   |_/_/    \_\_|  \_\ |_|   
--                              
-- =================================================================================================


-- 															WHEN THE MISSION IS ACCEPTED   LOAD PLATEAU FUNCTIONS
function plateau_missionstart():void

PrintNarrative("Narrative LOAD Mission Start scenes");	
	CreateThread(plateau_narrative_blink_fixer);
	Wake(dormant.plateau_missionstart_take_off);	

	
	
	
end



function dormant.plateau_missionstart_take_off()
PrintNarrative("Narrative START - plateau_missionstart_take_off");
sleep_real_seconds_NOT_QUITE_RELEASE(1);
SleepUntil ([| b_hub_dialogue_is_playing == false ], 1);

-- CHATTER SPARTANS OFF
-- ai_actor_dialogue_enable(AI.sq_musketeer, false);
-- ai_player_dialogue_enable(false);

--  Pelican pilot lines first in background
--				local l_dialog_id:thread=def_dialog_id_none();
--				l_dialog_id = dialog_start_background("plateau_missionstart_take_off", l_dialog_id, true, def_dialog_style_play(), false, "", 0);
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_marinemale04_00100.sound'), false, nil, 0.0, "", "MarineMale04 : Two-Six-Niner prepped for liftoff. Osiris is onboard. ", true );
					
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_marinemale04_00200.sound'), false, nil, 0.0, "", "MarineMale04 : Roger that. This bird is flying. ", true );
--				l_dialog_id = dialog_end(l_dialog_id, true, true, "");

				sleep_real_seconds_NOT_QUITE_RELEASE(2);

				PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_marinemale04_00100.sound'), nil );		--  "MarineMale04 : Two-Six-Niner prepped for liftoff. Osiris is onboard. "
				sleep_real_seconds_NOT_QUITE_RELEASE(3);
				
				PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_marinemale03_01000.sound'), ai_get_object(AI.marine_plateau.spawn_points_0) );		-- "Clear for lift Off!"
				sleep_real_seconds_NOT_QUITE_RELEASE(2);
			
				sleep_real_seconds_NOT_QUITE_RELEASE(2);
				
				PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_marinemale04_00200.sound'), nil );		-- "MarineMale04 : Roger that. This bird is flying. "
				sleep_real_seconds_NOT_QUITE_RELEASE(3);
			

Wake(dormant.plateau_missionstart_arbiter_brief);	

			
PrintNarrative("Narrative END - plateau_missionstart_take_off");

end

function dormant.plateau_missionstart_arbiter_brief()
PrintNarrative("Narrative START - plateau_missionstart_arbiter_brief");

				
--  Arbiter Speech in foreground
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_missionstart_arbiter_brief", l_dialog_id, true, def_dialog_style_interrupt_all(), false, "", 0);
				if b_hub_dialogue_is_playing then
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_00600.sound'), false, nil, 0.0, "", "AIGoodwin : Apologies for interrupting, Osiris. Arbiter is online.", true );
				else
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_00700.sound'), false, nil, 0.0, "", "AIGoodwin : Osiris, Arbiter is online.", true );
				end
					
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_01400.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Put him through, Goodwin. Arbiter. We're en route to the Conduit of the Gods.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_arbiter_00100.sound'), false, nil, 0.0, "", "Arbiter : Yes. Our name for it is Tojinok; a Forerunner site overlooking my ancestral burial grounds.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_00600.sound'), false, SPARTANS.vale, 0.0, "", "Vale : We will tread with honor and dignity Kaidon.", true );
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_arbiter_00200.sound'), false, nil, 0.0, "", "Arbiter : Covenant forces violate the sanctity of Tojinok.", true );
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_arbiter_00300.sound'), false, nil, 0.0, "", "Arbiter : Extend to them only the dignity of your blade Spartans.", true );
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_01500.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Understood Arbiter.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_arbiter_00400.sound'), false, nil, 0.0, "", "Arbiter : May your hunt for the Guardian Constructor be effortless. Victory to your clan and kin Osiris.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_01600.sound'), false, SPARTANS.locke, 0.0 , "", "Locke : And to yours Kaidon.", true );
					
					sleep_real_seconds_NOT_QUITE_RELEASE(1);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_00800.sound'), false, nil, 0.1, "", "AIGoodwin : Line is clear, Spartans.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
--	DEPENDING ON WHAT MISSION WE DID BEFORE
--SleepUntil([| not b_wall_melting_vignette_is_playing ], 1);
sleep_real_seconds_NOT_QUITE_RELEASE(4);
				 local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_missionstart_mission_comment", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_00500.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Are we sure the first Constructor's doing... whatever it is it's supposed to be doing?", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_00600.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Looks like it, yeah. Guardian oughta be ready to move once the other Constructors are rounded up.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
PrintNarrative("Narrative END - plateau_missionstart_arbiter_brief");

	Wake(dormant.plateau_missionstart_pelican_pilot_arrival);
	
	
PrintNarrative("Narrative - Switch AI Chatter on");
-- CHATTER SPARTANS ON
ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);

end





-- 															WHEN THE MISSION IS ACCEPTED   LOAD PLATEAU FUNCTIONS
function dormant.plateau_breach_wake()
SleepUntil([| volume_test_players( VOLUMES.plateau_missionstart_landing_zone)], 1);				
PrintNarrative("Narrative LOAD Breach scenes");	
	
--	Wake(dormant.plateau_missionstart_wallmelting);
--	Wake(dormant.plateau_missionstart_pelican_exit);					-- moved to w2_hub.lua for timing  -tjp 6/10/2014

	
end




--  Pelican pilot lines in background when arriving at destination
function dormant.plateau_missionstart_pelican_pilot_arrival()
PrintNarrative("Narrative START - plateau_missionstart_pelican_pilot_arrival");
SleepUntil([| volume_test_object( VOLUMES.plateau_missionstart_pilot_destination, SPARTANS.locke)], 1);				
--				local l_dialog_id:thread=def_dialog_id_none();
--				l_dialog_id = dialog_start_background("plateau_missionstart_pelican_pilot_arrival", l_dialog_id, true, def_dialog_style_play(), false, "", 0);
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_marinemale04_00200.sound'), false, nil, 0.0, "", "MarineMale04 : Two-Six-Niner arriving at destination. Osiris deploying.", true );
--					PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_marinemale04_00300.sound'), nil );
--					sleep_real_seconds_NOT_QUITE_RELEASE(3);
--				l_dialog_id = dialog_end(l_dialog_id, true, true, "");

Wake(dormant.plateau_missionstart_pelican_pilot_arrival_locke);				

PrintNarrative("Narrative END - plateau_missionstart_pelican_pilot_arrival");

end


--  Locke lines when arriving at LZ
function dormant.plateau_missionstart_pelican_pilot_arrival_locke()
PrintNarrative("Narrative START - plateau_missionstart_pelican_pilot_arrival_locke");

				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_missionstart_pelican_pilot_arrival_locke", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_01700.sound'), false, SPARTANS.locke, 0.0, "", "Locke : This is the LZ. Alright, ready up, Osiris.", true );
					
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");

PrintNarrative("Narrative END - plateau_missionstart_pelican_pilot_arrival_locke");

end

--		WHEN PLAYERS EXIT THE PELICAN
function dormant.plateau_missionstart_pelican_exit()

	PrintNarrative("Narrative START - plateau_missionstart_pelican_exit");
	CreateThread(plateau_missionstart_team_chat);



	PrintNarrative("Narrative END - plateau_missionstart_pelican_exit");

end


-- 			OSIRIS DISCUSSION AS WE GET OUT OF THE PELICAN. CAN BE INTERRUPTED BY THE WALL MELTING VIGNETTE.
function plateau_missionstart_team_chat():void
SleepUntil([| volume_test_players(VOLUMES.plateau_missionstart_team_chat)], 1);
PrintNarrative("Narrative START - plateau_missionstart_team_chat");


				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_breach_enter_breach", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);

					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_00600.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : So...did I hear Arbiter say we're going to a grave yard?", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_00700.sound'), false, SPARTANS.vale, 0.5, "", "Vale : The Vadams place their dead below the Conduit to spend eternity serving the gods. It sounds like a beautiful ceremony.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_00700.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Yeah.", true );
			
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
PrintNarrative("Narrative END - plateau_missionstart_team_chat");
end


-- Wall melting vignette
function dormant.plateau_missionstart_wallmelting()
SleepUntil([| volume_test_players(VOLUMES.plateau_missionstart_wallmelting)], 1);
PrintNarrative("Narrative START - plateau_missionstart_wallmelting");
--b_wallmelt_b = true;
--print("Wall Melting vignette - b_wallmelt_b:", b_wallmelt_b);
--wallMeltingDialInterrupt = true;

--b_wall_melting_vignette_is_playing = true;

PrintNarrative("Narrative END - plateau_missionstart_wallmelting");
end


-- 															WHEN THE WALL HAS MELTED
function plateau_breach_enter_breach():void
PrintNarrative("Narrative START - plateau_breach_enter_breach");
		if not b_playerIsInDropdown then
--				local l_dialog_id:thread=def_dialog_id_none();
--				l_dialog_id = dialog_start_background("plateau_breach_enter_breach", l_dialog_id, true, def_dialog_style_play(), false, "", 0);
--						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_00500.sound'), false, ai_get_object(AI.vin_wall_breach_squad.elite1), 0.0, "", "Elite01 : The way is opened for you, Spartans. Do not delay.", true );
--				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
--				PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_00500.sound'), ai_get_object(AI.vin_wall_breach_squad.elite1) );
--				sleep_real_seconds_NOT_QUITE_RELEASE(3);
		end
--b_wall_melting_vignette_is_playing = false;
Wake(dormant.plateau_breach_entry);
Wake(dormant.plateau_breach_enter_breach_2);
PrintNarrative("Narrative END - plateau_breach_enter_breach");
end

function dormant.plateau_breach_enter_breach_2()
PrintNarrative("Narrative START - plateau_breach_enter_breach_2");
sleep_real_seconds_NOT_QUITE_RELEASE(30);
		if not b_playerIsInDropdown then
--				local l_dialog_id:thread=def_dialog_id_none();
--				l_dialog_id = dialog_start_background("plateau_breach_enter_breach_2", l_dialog_id, true, def_dialog_style_play(), false, "", 0);
--						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_00600.sound'), false, ai_get_object(AI.vin_wall_breach_squad.elite1), 0.0, "", "Elite01 : Enter, Spartans.", true );
--						PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_00600.sound'), ai_get_object(AI.vin_wall_breach_squad.elite1) );
--						sleep_real_seconds_NOT_QUITE_RELEASE(3);
--				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
		end
Wake(dormant.plateau_breach_enter_breach_3);
PrintNarrative("Narrative END - plateau_breach_enter_breach_2");
end

function dormant.plateau_breach_enter_breach_3()
sleep_real_seconds_NOT_QUITE_RELEASE(40);
PrintNarrative("Narrative START - plateau_breach_enter_breach_3");
		if not b_playerIsInDropdown then
--				local l_dialog_id:thread=def_dialog_id_none();
--				l_dialog_id = dialog_start_background("plateau_breach_enter_breach_3", l_dialog_id, true, def_dialog_style_play(), false, "", 0);
--						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_00700.sound'), false, ai_get_object(AI.vin_wall_breach_squad.elite2), 0.0, "", "Elite01 : Why do you hesitate?", true );
--						PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite01_00700.sound'), ai_get_object(AI.vin_wall_breach_squad.elite2) );
--						sleep_real_seconds_NOT_QUITE_RELEASE(3);
--				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
		end
PrintNarrative("Narrative END - plateau_breach_enter_breach_3");
end



-- 															WHEN ENTERING A TRIGGER VOLUME AT THE MELTING WALL
function dormant.plateau_breach_entry()
--SleepUntil([| objects_distance_to_object( players_human(), ai_get_object(AI.vin_wall_breach_squad.elite2) ) > 4], 1);

PrintNarrative("Narrative START - plateau_breach_entry");
		
--				local l_dialog_id:thread=def_dialog_id_none();
--				l_dialog_id = dialog_start_background("plateau_breach_entry", l_dialog_id, true, def_dialog_style_play(), false, "", 0);
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite02_00700.sound'), false, ai_get_object(AI.vin_wall_breach_squad.elite2), 0.0, "", "Elite02 : I'll wager my ancestral blade we never see them again.", true );
--					PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite02_00700.sound'), ai_get_object(AI.vin_wall_breach_squad.elite2) );
--					sleep_real_seconds_NOT_QUITE_RELEASE(3);
--				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
		
PrintNarrative("Narrative END - plateau_breach_entry");


PrintNarrative("Narrative - Switch AI Chatter on");
-- CHATTER SPARTANS ON
ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);


end


-- =================================================================================================
--  _____  _____   ____  _____  _____   ______          ___   _ 
-- |  __ \|  __ \ / __ \|  __ \|  __ \ / __ \ \        / / \ | |
-- | |  | | |__) | |  | | |__) | |  | | |  | \ \  /\  / /|  \| |
-- | |  | |  _  /| |  | |  ___/| |  | | |  | |\ \/  \/ / | . ` |
-- | |__| | | \ \| |__| | |    | |__| | |__| | \  /\  /  | |\  |
-- |_____/|_|  \_\\____/|_|    |_____/ \____/   \/  \/   |_| \_|
--                                                              
-- =================================================================================================

function dormant.plateau_dropdown_wake()
-- 															WHEN ENTERING A TRIGGER VOLUME INSIDE THE CAVE
SleepUntil([| volume_test_players(VOLUMES.plateau_dropdown_wake) or volume_test_players(VOLUMES.plateau_dropdown_arguinggrunts)	 ], 1);
PrintNarrative("Narrative LOAD Dropdown Scenes");
b_playerIsInDropdown = true;

--	Wake(dormant.plateau_dropdown_arguinggrunts_spartans);
--	Wake(dormant.plateau_dropdown_arguinggrunts_grunts);
	Wake(dormant.plateau_dropdown_team_chat);
--	CreateThread(plateau_dropdown_arguinggrunts_grunts);
	
	
	
end

-- =================================================================================================



--		AFTER THE DRILL
function dormant.plateau_dropdown_team_chat()
SleepUntil([| volume_test_players( VOLUMES.plateau_missionstart_team_chat) or volume_test_players( VOLUMES.plateau_dropdown_arguinggrunts)], 1);
PrintNarrative("Narrative START - plateau_breach_team_discussion");
sleep_real_seconds_NOT_QUITE_RELEASE(1);
b_dropdownChat = true;
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_breach_team_discussion", l_dialog_id, true, def_dialog_style_queue(), true, "", 0);
				if objects_distance_to_object(players_human(),ai_get_object(AI.sq_ward_scouts.spawn_points_0)) < 15 and not b_dropdownChat then
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_00600.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : Arbiter said we're going to a grave yard?", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_00600.sound'), false, SPARTANS.thorne, 0.3, "", "Buck : I hear Arbiter say we're going to a grave yard?", true );
				end
				if objects_distance_to_object(players_human(),ai_get_object(AI.sq_ward_scouts.spawn_points_0)) < 15 and not b_dropdownChat then
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_01800.sound'), false, SPARTANS.locke, 0.0, "", "Locke : More of a foggy pit really.", true );
				end
				if objects_distance_to_object(players_human(),ai_get_object(AI.sq_ward_scouts.spawn_points_0)) < 15 and not b_dropdownChat then
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_00700.sound'), false, SPARTANS.vale, 0.0, "", "Vale : The Vadams place their dead below the Conduit to spend eternity serving the gods. It sounds like a beautiful ceremony.", true );
				end
				if objects_distance_to_object(players_human(),ai_get_object(AI.sq_ward_scouts.spawn_points_0)) < 15 and not b_dropdownChat then
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_00700.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Uh-huh. ", true );
				end
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");	
b_dropdownChat = false;
PrintNarrative("Narrative END - plateau_breach_team_discussion");
end





-- =================================================================================================
--   _____ ______ _   _ _______ _______     __  _____  ________      ________          _      
--  / ____|  ____| \ | |__   __|  __ \ \   / / |  __ \|  ____\ \    / /  ____|   /\   | |     
-- | (___ | |__  |  \| |  | |  | |__) \ \_/ /  | |__) | |__   \ \  / /| |__     /  \  | |     
--  \___ \|  __| | . ` |  | |  |  _  / \   /   |  _  /|  __|   \ \/ / |  __|   / /\ \ | |     
--  ____) | |____| |\  |  | |  | | \ \  | |    | | \ \| |____   \  /  | |____ / ____ \| |____ 
-- |_____/|______|_| \_|  |_|  |_|  \_\ |_|    |_|  \_\______|   \/   |______/_/    \_\______|
--                                                                                            
-- =================================================================================================

function dormant.plateau_sentryreveal_wake()
-- 															WHEN ENTERING A TRIGGER VOLUME INSIDE THE CAVE
SleepUntil([| volume_test_players(VOLUMES.plateau_sentryreveal_entrancetospaceandsentryship) ], 1);
PrintNarrative("Narrative LOAD Sentry Reveal Scenes");	
	Wake(dormant.plateau_sentryreveal_entrancetospaceandsentryship_alert);
	Wake(dormant.plateau_sentryreveal_entrancetospaceandsentryship_alert_2);
	
--	Wake(dormant.plateau_sentryreveal_entrancetospaceandsentryship_steps);

	Wake(dormant.plateau_sentryreveal_entrancetospaceandsentryship_sunaion);
	
-- CHATTER SPARTANS ON
--ai_actor_dialogue_enable(AI.sq_musketeer, false);
--ai_player_dialogue_enable(false);
	
end

-- =================================================================================================


-- 															WHEN ENTERING A TRIGGER VOLUME AND ALL THE GRUNTS ARE DEAD - OVERHEARING A DISCUSSION BETWEEN A GRUNT AND AN ELITE
function dormant.plateau_sentryreveal_entrancetospaceandsentryship_alert()
SleepUntil([| 	ai_living_count( AI.sq_ward_vanguard.e ) == 1 and ai_living_count( AI.sq_ward_scouts ) == 0 and ai_combat_status( AI.sq_ward_vanguard) < 4
				or volume_test_players(VOLUMES.plateau_sentryreveal_entrancetospaceandsentryship_alert) ], 1);
sleep_real_seconds_NOT_QUITE_RELEASE(3);
PrintNarrative("Narrative START - plateau_sentryreveal_entrancetospaceandsentryship_alert  -  The second group is worried for the scouts");
--				local l_dialog_id:thread=def_dialog_id_none();
--				l_dialog_id = dialog_start_background("plateau_sentryreveal_entrancetospaceandsentryship_alert", l_dialog_id, true, def_dialog_style_play(), false, "", 0);
				if ai_living_count( AI.sq_ward_vanguard )>0 and ai_combat_status( AI.sq_ward_vanguard) < 4 then 
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite03_00100.sound'), false, ai_get_object(AI.sq_ward_vanguard.e), 0.0, "", "Elite03 : What is happening up there? You, go look!", true );
						PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite03_00100.sound'), ai_get_object(AI.sq_ward_vanguard.e) );
						sleep_real_seconds_NOT_QUITE_RELEASE(3);
				end
				if ai_living_count( AI.sq_ward_vanguard )>0 and ai_combat_status( AI.sq_ward_vanguard) < 4 then 
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_00100.sound'), false, ai_get_object(AI.sq_ward_vanguard.g1), 0.0, "", "Grunt02 : Me? Why me?", true );
						PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_00100.sound'), ai_get_object(AI.sq_ward_vanguard.g1) );
						sleep_real_seconds_NOT_QUITE_RELEASE(1);
				end
				if ai_living_count( AI.sq_ward_vanguard )>0 and ai_combat_status( AI.sq_ward_vanguard) < 4 then 	
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite03_00200.sound'), false, ai_get_object(AI.sq_ward_vanguard.e), 0.0, "", "Elite03 : GO!", true );
						PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite03_00200.sound'), ai_get_object(AI.sq_ward_vanguard.e) );
						sleep_real_seconds_NOT_QUITE_RELEASE(1);
				end
				if ai_living_count( AI.sq_ward_vanguard )>0 and ai_combat_status( AI.sq_ward_vanguard) < 4 then 	
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_00200.sound'), false, ai_get_object(AI.sq_ward_vanguard.g1), 0.0, "", "Grunt02 : Okay! Okay!", true );
						PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_00200.sound'), ai_get_object(AI.sq_ward_vanguard.g1) );
						sleep_real_seconds_NOT_QUITE_RELEASE(2);
				end
--				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
		
PrintNarrative("Narrative END - plateau_sentryreveal_entrancetospaceandsentryship_alert  -   The second group is worried for the scouts");
end


function dormant.plateau_sentryreveal_entrancetospaceandsentryship_alert_2()
SleepUntil([| ai_combat_status( AI.sq_ward_vanguard.g1) >= 4 and ai_combat_status( AI.sq_ward_vanguard.e) >= 4 ], 1);
PrintNarrative("Narrative START - plateau_sentryreveal_entrancetospaceandsentryship_alert_2  -  Alert of the 2nd group");
--		story_blurb_add("domain", "The players hear an Elite talking while approaching the exit of the cavern.");

--				local l_dialog_id:thread=def_dialog_id_none();
--				l_dialog_id = dialog_start_background("plateau_sentryreveal_entrancetospaceandsentryship_alert_2", l_dialog_id, true, def_dialog_style_play(), false, "", 0);
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_00300.sound'), false, ai_get_object(AI.sq_ward_vanguard.g1), 0.0, "", "Grunt02 : Oh no! Humans!", true );

						PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_00300.sound'), ai_get_object(AI.sq_ward_vanguard.g1) );
						sleep_real_seconds_NOT_QUITE_RELEASE(0.5);
SleepUntil([| objects_are_within_distance_of_object(players_human(), 6, AI.sq_ward_vanguard.g3) ], 1);
					if not b_grunt_says_break_the_ritual then
						PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt01_00400.sound'), ai_get_object(AI.sq_ward_vanguard.g3) );
						sleep_real_seconds_NOT_QUITE_RELEASE(1);
					end
						
SleepUntil([| objects_are_within_distance_of_object(players_human(), 6, AI.sq_ward_vanguard.e) ], 1);											
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite03_00300.sound'), false, ai_get_object(AI.sq_ward_vanguard.e), 0.0, "", "Elite03 : They must not interrupt the ritual! Do not let them pass!", true );
						PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite03_00300.sound'), ai_get_object(AI.sq_ward_vanguard.e) );
						sleep_real_seconds_NOT_QUITE_RELEASE(3);
--				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
		
PrintNarrative("Narrative END - plateau_sentryreveal_entrancetospaceandsentryship_alert_2  -  Alert of the 2nd group");
end

-- 															WHEN ENTERING A TRIGGER VOLUME, APPROACHING THE SENTRY SHIP AND THE LEADER
--function plateau_sentryreveal_entrancetospaceandsentryship_leader():void
function dormant.plateau_sentryreveal_entrancetospaceandsentryship_leader()
--SleepUntil([| volume_test_players(VOLUMES.plateau_sentryreveal_entrancetospaceandsentryship_leader) ], 1);

sleep_real_seconds_NOT_QUITE_RELEASE(4);
PrintNarrative("Narrative START - plateau_sentryreveal_entrancetospaceandsentryship_leader");
--  NEZIK LINE 1
--					tempSubtitle("The humans desire to open the Domain!",200);
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false);
--				local l_dialog_id:thread=def_dialog_id_none();
--				l_dialog_id = dialog_start_background("plateau_sentryreveal_entrancetospaceandsentryship_leader_1", l_dialog_id, true, def_dialog_style_play(), true, "", 1);
					

--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_00100.sound'), false, object_at_marker(OBJECTS.vin_sent_machine, "mid_weapon_1"), 0.0, "", "Nezik : [The humans desire to open the Domain!]", true );
					
--				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
--print("Test 1!");
				PlayDialogFromMarkerOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_00100.sound'), OBJECTS.vin_sent_machine, "audio_centerupper" );
				
--				tempSubtitle("Nezik 1",200);

				ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);

sleep_real_seconds_NOT_QUITE_RELEASE(random_range( 10, 30 ));
--  NEZIK LINE 2				
SleepUntil([| not b_ritualIsInterrupted ], 1);
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false);
--				local l_dialog_id:thread=def_dialog_id_none();
--				l_dialog_id = dialog_start_background("plateau_sentryreveal_entrancetospaceandsentryship_leader_2", l_dialog_id, true, def_dialog_style_play(), true, "", 1);
--					tempSubtitle("They will destroy us with the help of the false Arbiter unless we stand strong!",200);

--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_00200.sound'), false, OBJECTS.vin_sent_machine, 0.0, "", "Nezik : [They will destroy us with the help of the false Arbiter unless we stand strong!]", true );
--				l_dialog_id = dialog_end(l_dialog_id, true, true, "");

				PlayDialogFromMarkerOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_00200.sound'), OBJECTS.vin_sent_machine, "audio_centerupper" );
--				tempSubtitle("Nezik 2",200);
				
				ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);				
				
sleep_real_seconds_NOT_QUITE_RELEASE(random_range( 10, 30 ));
--  NEZIK LINE 3
SleepUntil([| not b_ritualIsInterrupted ], 1);
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false);
--				local l_dialog_id:thread=def_dialog_id_none();
--				l_dialog_id = dialog_start_background("plateau_sentryreveal_entrancetospaceandsentryship_leader_3", l_dialog_id, true, def_dialog_style_play(), true, "", 1);

--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_00300.sound'), false, object_at_marker(OBJECTS.vin_sent_machine, "mid_weapon_1"), 0.0, "", "Nezik : [They will not succeed so long as our faith is true, brothers!]", true );
--				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
--				tempSubtitle("Nezik 3",200);
				PlayDialogFromMarkerOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_00300.sound'), OBJECTS.vin_sent_machine, "audio_centerupper" );
				
				 ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
sleep_real_seconds_NOT_QUITE_RELEASE(random_range( 10, 30 ));
--  NEZIK LINE 4
SleepUntil([| not b_ritualIsInterrupted ], 1);
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false);
--				local l_dialog_id:thread=def_dialog_id_none();
--				l_dialog_id = dialog_start_background("plateau_sentryreveal_entrancetospaceandsentryship_leader_3", l_dialog_id, true, def_dialog_style_play(), true, "", 1);

--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_00400.sound'), false, object_at_marker(OBJECTS.vin_sent_machine, "mid_weapon_1"), 0.0, "", "Nezik : [Now is the time to rise up! Stand between the humans and the Conduit!]", true );
--				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
				PlayDialogFromMarkerOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_00400.sound'), OBJECTS.vin_sent_machine, "audio_centerupper" );
				ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
sleep_real_seconds_NOT_QUITE_RELEASE(random_range( 10, 30 ));
--  NEZIK LINE 5
SleepUntil([| not b_ritualIsInterrupted ], 1);
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false);
--				local l_dialog_id:thread=def_dialog_id_none();
--				l_dialog_id = dialog_start_background("plateau_sentryreveal_entrancetospaceandsentryship_leader_3", l_dialog_id, true, def_dialog_style_play(), true, "", 1);

--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_00500.sound'), false, object_at_marker(OBJECTS.vin_sent_machine, "mid_weapon_1"), 0.0, "", "Nezik : [The humans would unleash chaos to the galaxy! End them!]", true );
--				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
				PlayDialogFromMarkerOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_00500.sound'), OBJECTS.vin_sent_machine, "audio_centerupper" );
				
				ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
Wake(dormant.plateau_ramp_nezik);				
PrintNarrative("Narrative END - plateau_sentryreveal_entrancetospaceandsentryship_leader");
end


--											WHEN ENTERING A TRIGGER VOLUME, APPROACHING THE SENTRY SHIP AND THE LEADER BUT TEAM AI REACTS THIS TIME
function dormant.plateau_sentryreveal_entrancetospaceandsentryship_sunaion()
SleepUntil([| 	volume_test_players(VOLUMES.plateau_sentryreveal_entrancetospaceandsentryship_sunaion) or 
				object_get_health( ai_get_object( AI.sq_ward_scouts)) <= 0 and volume_test_players(VOLUMES.plateau_sentryreveal_entrancetospaceandsentryship_leader)], 1);
	if  object_get_health( ai_get_object( AI.sq_ward_scouts)) <= 0 then
		sleep_real_seconds_NOT_QUITE_RELEASE(1);
	end
PrintNarrative("Narrative START - plateau_sentryreveal_entrancetospaceandsentryship_sunaion");
--				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); 
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentryreveal_entrancetospaceandsentryship_sunaion", l_dialog_id, true, def_dialog_style_interrupt(), true, "", 0);

					if	(not IsPlayer(SPARTANS.tanaka) and ai_combat_status(object_get_ai(SPARTANS.tanaka)) > 4 ) or 								-- If tanaka is a musketeer and in combat
						(IsPlayer(SPARTANS.tanaka) and objects_distance_to_object( SPARTANS.tanaka, ai_get_object(AI.gr_plat_all)) < 5) then		-- If tanaka is a player and an enemy is near
--	TANAKA IN COMBAT
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_01200.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Domain prayer again.", true );
					else
--	TANAKA NOT IN COMBAT
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_01000.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Domain prayer again..", true );
					end
					
					if	
--  ** IF I PUT BACK THE COMMENTED CONDITION, NEED TO REVERSE THE ORDER.
--						(not IsPlayer(SPARTANS.vale) and ai_combat_status(object_get_ai(SPARTANS.vale)) > 4 ) or 								-- If vale is a musketeer
--						(IsPlayer(SPARTANS.vale) and objects_distance_to_object( SPARTANS.vale, ai_get_object(AI.gr_plat_all)) < 5)				-- If vale is a player
						objects_distance_to_object( players_human(), ai_get_object(AI.gr_plat_all)) < 8											-- If any player is in Combat.
						then
--	VALE NOT IN COMBAT
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_01100.sound'), false, SPARTANS.vale, 0.0, "", "Vale : They're scared we're going to wake the Guardian.", true );
					else
--	VALE IN COMBAT
--						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_01000.sound'), false, SPARTANS.vale, 0.0, "", "Vale : They're scared we're going to wake the Guardian.", true );
					end
					if	
--  ** IF I PUT BACK THE COMMENTED CONDITION, NEED TO REVERSE THE ORDER.
--						(not IsPlayer(SPARTANS.locke) and ai_combat_status(object_get_ai(SPARTANS.locke)) > 4 ) or 								-- If locke is a musketeer
--						(IsPlayer(SPARTANS.locke) and objects_distance_to_object( SPARTANS.locke, ai_get_object(AI.gr_plat_all)) < 5) 			-- If locke is a player
						objects_distance_to_object( players_human(), ai_get_object(AI.gr_plat_all)) < 8											-- If any player is in Combat.
						then
--	LOCKE NOT IN COMBAT
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_02100.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Good. If they're scared, then we're on the right path.", true );
					else
--	LOCKE IN COMBAT
--						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_02000.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Good. If they're scared then we're on the right path.", true );
					end
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);

Wake(dormant.plateau_sentryreveal_entrancetospaceandsentryship_leader);				
PrintNarrative("Narrative END - plateau_sentryreveal_entrancetospaceandsentryship_sunaion");
end



-- =================================================================================================
--  SHIP LIFT OFF
-- =================================================================================================


--***********************************************************************************************************************************************
--***********************************************************************************************************************************************
-- 									WHEN THE SENTRY SHIP MAKES HIS BIG SOUND
function plateau_sentryreveal_entrancetospaceandsentryship_ship_sound():void
-- CHATTER SPARTANS OFF
PrintNarrative("Narrative - Switch AI Chatter off");
ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false);

sleep_real_seconds_NOT_QUITE_RELEASE(0.5);
b_ritualIsInterrupted = true;

PrintNarrative("Narrative  -  Lift off tada");
--SleepUntil([| objects_can_see_object( players_human(), object_at_marker(OBJECTS.vin_sent_machine, "mid_weapon_1"), 30 ) ], 1);
--print("SEE 1 TEST PASSED");
SleepUntil([| objects_are_within_distance_of_object( players_human(), 139, OBJECTS.vin_sent_machine ) ], 1);

PrintNarrative("Narrative START  -  plateau_sentryreveal_entrancetospaceandsentryship_lookat_liftoff  -  A Player look at the Sentry Ship Lift Off");
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentryreveal_entrancetospaceandsentryship_lookat_liftoff_team", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
--	IF VALE, TANAKA or THORNE ARE CLOSE AND PLAYERS AND LOOKING AT THE SENTRY SHIP THEY WILL TALK IN PRIORITY
			-- IF TANAKA
					if objects_are_within_distance_of_object( SPARTANS.tanaka, 140, OBJECTS.vin_sent_machine ) and IsPlayer(SPARTANS.tanaka) and objects_can_see_object( SPARTANS.tanaka, OBJECTS.vin_sent_machine, 30 ) then
						PrintNarrative("Tanaka sees it");
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_01300.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Kraken!", true );
			-- ELSEIF VALE
					elseif objects_are_within_distance_of_object( SPARTANS.vale, 140, OBJECTS.vin_sent_machine ) and IsPlayer(SPARTANS.vale) and objects_can_see_object( SPARTANS.vale, OBJECTS.vin_sent_machine, 30 )then
						PrintNarrative("Vale sees it");
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_01200.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Kraken!", true );
			-- ELSEIF THORNE
					elseif objects_are_within_distance_of_object( SPARTANS.thorne, 140, OBJECTS.vin_sent_machine ) and IsPlayer(SPARTANS.thorne) and objects_can_see_object( SPARTANS.thorne, OBJECTS.vin_sent_machine, 30 ) then
						PrintNarrative("Buck sees it");
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_00800.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Kraken!", true );
--	IF IT'S LOCKE FIRST, HE WILL SHOUT ONLY IF NO MUSKETEER IS NEAR AND CAN'T SHOUT INSTEAD OF HIM.
			-- ELSEIF LOCKE						
					elseif objects_are_within_distance_of_object( SPARTANS.locke, 140, OBJECTS.vin_sent_machine ) and objects_can_see_object( SPARTANS.locke, OBJECTS.vin_sent_machine, 30 ) then
							if not IsPlayer(SPARTANS.thorne) and objects_are_within_distance_of_object( SPARTANS.thorne, 140, OBJECTS.vin_sent_machine ) then
									PrintNarrative("Buck shouts Kraken instead of Locke");
									dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_00800.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Kraken!", true );
							elseif not IsPlayer(SPARTANS.tanaka) and objects_are_within_distance_of_object( SPARTANS.tanaka, 140, OBJECTS.vin_sent_machine ) then
									PrintNarrative("Tanaka shouts Kraken instead of Locke");
									dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_01300.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Kraken!", true );
							elseif not IsPlayer(SPARTANS.vale) and objects_are_within_distance_of_object( SPARTANS.vale, 140, OBJECTS.vin_sent_machine ) then
									PrintNarrative("Vale shouts Kraken instead of Locke");
									dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_01200.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Kraken!", true );
							else
									PrintNarrative("Locke shouts Kraken because no one else is around to do it instead of him.");
									dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_02200.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Kraken!", true );
							end
--	IF IT'S VALE, TANAKA OR BUCK BUT THEY ARE NOT LOOKING AT THE SENTRY SHIP
					elseif objects_are_within_distance_of_object( SPARTANS.tanaka, 160, OBJECTS.vin_sent_machine ) and IsPlayer(SPARTANS.tanaka) then
						PrintNarrative("Tanaka sees it");
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_01300.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Kraken!", true );
			-- ELSEIF VALE
					elseif objects_are_within_distance_of_object( SPARTANS.vale, 160, OBJECTS.vin_sent_machine ) and IsPlayer(SPARTANS.vale) then
						PrintNarrative("Vale sees it");
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_01200.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Kraken!", true );
			-- ELSEIF THORNE
					elseif objects_are_within_distance_of_object( SPARTANS.thorne, 160, OBJECTS.vin_sent_machine ) and IsPlayer(SPARTANS.thorne) then
						PrintNarrative("Buck sees it");
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_00800.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Kraken!", true );

			-- END IF
					end
sleep_real_seconds_NOT_QUITE_RELEASE(0.4);					
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_02400.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Stay back!", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
PrintNarrative("Narrative END  -  plateau_sentryreveal_entrancetospaceandsentryship_lookat_liftoff  -  A Player look at the Sentry Ship Lift Off");



PrintNarrative("Narrative START  -  plateau_sentryreveal_entrancetospaceandsentryship_ship_sound");
--				local l_dialog_id:thread=def_dialog_id_none();
--				l_dialog_id = dialog_start_foreground("plateau_sentryreveal_entrancetospaceandsentryship_ship_sound", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_00900.sound'), false, nil, 0.0, "", "AIGoodwin : What the devil?", true );
--				l_dialog_id = dialog_end(l_dialog_id, true, true, "");

Wake(dormant.plateau_sentryreveal_entrancetospaceandsentryship_leader_interrupt);		
Wake(dormant.plateau_sentryreveal_entrancetospaceandsentryship_fall_back);					

ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);

PrintNarrative("Narrative END  -  plateau_sentryreveal_entrancetospaceandsentryship_ship_sound");
end



-- 							WE INTERRUPT THE CEREMONY, COVIES DECIDE TO LEAVE
function dormant.plateau_sentryreveal_entrancetospaceandsentryship_leader_interrupt()
SleepUntil([| volume_test_players(VOLUMES.plateau_sentryreveal_entrancetospaceandsentryship_leader_interrupt) ], 1);
PrintNarrative("Narrative START - plateau_sentryreveal_entrancetospaceandsentryship_leader_interrupt");
b_ritualIsInterrupted = true;
--				local l_dialog_id:thread=def_dialog_id_none();
--				l_dialog_id = dialog_start_background("plateau_sentryreveal_entrancetospaceandsentryship_leader_interrupt", l_dialog_id, true, def_dialog_style_play(), false, "", 0);
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_00600.sound'), false, OBJECTS.vin_sent_machine, 0.0, "", "Nezik : [The humans are here! Move now to assault the Conduit!]", true );
					
--				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
					PlayDialogFromMarkerOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_00600.sound'), OBJECTS.vin_sent_machine, "audio_centerupper" );
				
PrintNarrative("Narrative END - plateau_sentryreveal_entrancetospaceandsentryship_leader_interrupt");
end


--***********************************************************************************************************************************************
--***********************************************************************************************************************************************

--														  WHEN THE SHIP STARTS LIFTING OFF
-- 															WHEN A SPARTAN LOOK AT THE SENTRY SHIP
function plateau_sentryreveal_entrancetospaceandsentryship_lookat_liftoff():void

sleep_real_seconds_NOT_QUITE_RELEASE(3);

--(dormant.plateau_sentryreveal_entrancetospaceandsentryship_lookat_kraken_locke);
--sleep_real_seconds_NOT_QUITE_RELEASE(0.5);

Wake(dormant.plateau_sentryreveal_entrancetospaceandsentryship_lookat_kraken_vale);
sleep_real_seconds_NOT_QUITE_RELEASE(0.1);
Wake(dormant.plateau_sentryreveal_entrancetospaceandsentryship_lookat_kraken_tanaka);
sleep_real_seconds_NOT_QUITE_RELEASE(0.5);
Wake(dormant.plateau_sentryreveal_entrancetospaceandsentryship_lookat_kraken_thorne);

Wake(dormant.plateau_sentryreveal_entrancetospaceandsentryship_lift_off_leader);




end


function dormant.plateau_sentryreveal_entrancetospaceandsentryship_lookat_kraken_locke()

SleepUntil([| not b_KrakenLiftOff and not b_playerIsInHollow and objects_distance_to_object( SPARTANS.locke, OBJECTS.vin_sent_machine ) < 140 ], 1);
PrintNarrative("Narrative START  -  plateau_sentryreveal_entrancetospaceandsentryship_lookat_kraken_locke");
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentryreveal_entrancetospaceandsentryship_lookat_kraken_locke", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
						dialog_line_npc( l_dialog_id, 0, (not b_KrakenLiftOff), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_02400.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Stay back!", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
PrintNarrative("Narrative END  -  plateau_sentryreveal_entrancetospaceandsentryship_lookat_kraken_locke");

end

function dormant.plateau_sentryreveal_entrancetospaceandsentryship_lookat_kraken_tanaka()

SleepUntil([| 	(not b_KrakenLiftOff and not b_playerIsInHollow and not IsPlayer(SPARTANS.tanaka) ) or
				(not b_KrakenLiftOff and not b_playerIsInHollow and objects_distance_to_object( SPARTANS.tanaka, OBJECTS.vin_sent_machine ) < 140) ], 1);
PrintNarrative("Narrative START  -  plateau_sentryreveal_entrancetospaceandsentryship_lookat_kraken_tanaka");
sleep_real_seconds_NOT_QUITE_RELEASE(0.1);
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentryreveal_entrancetospaceandsentryship_lookat_kraken_tanaka", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, (not b_KrakenLiftOff), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_01500.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Mother hell!", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
PrintNarrative("Narrative END  -  plateau_sentryreveal_entrancetospaceandsentryship_lookat_kraken_tanaka");

end

function dormant.plateau_sentryreveal_entrancetospaceandsentryship_lookat_kraken_vale()

SleepUntil([| 	(not b_KrakenLiftOff and not b_playerIsInHollow and not IsPlayer(SPARTANS.vale) and objects_can_see_object( SPARTANS.locke, OBJECTS.vin_sent_machine, 35 )) or
				(not b_KrakenLiftOff and not b_playerIsInHollow and objects_distance_to_object( SPARTANS.vale, OBJECTS.vin_sent_machine ) < 140) ], 1);
PrintNarrative("Narrative START  -  plateau_sentryreveal_entrancetospaceandsentryship_lookat_kraken_vale");
sleep_real_seconds_NOT_QUITE_RELEASE(2);
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentryreveal_entrancetospaceandsentryship_lookat_kraken_vale", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, (not b_KrakenLiftOff), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_01400.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Look at the size of that thing!", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
PrintNarrative("Narrative END  -  plateau_sentryreveal_entrancetospaceandsentryship_lookat_kraken_vale");

end

function dormant.plateau_sentryreveal_entrancetospaceandsentryship_lookat_kraken_thorne()

SleepUntil([| 	(not b_KrakenLiftOff and not b_playerIsInHollow and not IsPlayer(SPARTANS.thorne) and objects_can_see_object( SPARTANS.locke, OBJECTS.vin_sent_machine, 35 )) or
				(not b_KrakenLiftOff and not b_playerIsInHollow and objects_distance_to_object( SPARTANS.thorne, OBJECTS.vin_sent_machine ) < 140) ], 1);
PrintNarrative("Narrative START  -  plateau_sentryreveal_entrancetospaceandsentryship_lookat_kraken_thorne");
sleep_real_seconds_NOT_QUITE_RELEASE(4);
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentryreveal_entrancetospaceandsentryship_lookat_kraken_thorne", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, (not b_KrakenLiftOff), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_00900.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : They brought an assault platform, they must be serious.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
PrintNarrative("Narrative END  -  plateau_sentryreveal_entrancetospaceandsentryship_lookat_kraken_thorne");

end

--***********************************************************************************************************************************************
--***********************************************************************************************************************************************
-- 									WHEN CLOSE TO THE SHIP, NEEDS TO FALL BACK

function dormant.plateau_sentryreveal_entrancetospaceandsentryship_fall_back()
SleepUntil([| not b_KrakenLiftOff and volume_test_players( VOLUMES.plateau_sentryreveal_entrancetospaceandsentryship_fall_back )], 1);


PrintNarrative("Narrative START  -  plateau_sentryreveal_entrancetospaceandsentryship_fall_back");
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentryreveal_entrancetospaceandsentryship_fall_back", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
	-- IF LOCKE
					if volume_test_object( VOLUMES.plateau_sentryreveal_entrancetospaceandsentryship_fall_back, SPARTANS.locke ) then

						dialog_line_npc( l_dialog_id, 0, (b_sentryreveal_kill == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_02300.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Look out!", true );
					end
	-- ELSEIF TANAKA
					if volume_test_object( VOLUMES.plateau_sentryreveal_entrancetospaceandsentryship_fall_back, SPARTANS.tanaka ) then
						
						dialog_line_npc( l_dialog_id, 0, (b_sentryreveal_kill == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_01400.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Look out!", true );
					end
	-- ELSEIF VALE
					if volume_test_object( VOLUMES.plateau_sentryreveal_entrancetospaceandsentryship_fall_back, SPARTANS.vale ) then
						
						dialog_line_npc( l_dialog_id, 0, (b_sentryreveal_kill == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_01300.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Look out!", true );
					end
	-- ELSEIF THORNE
	-- Thorne has no line

				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
PrintNarrative("Narrative END  -  plateau_sentryreveal_entrancetospaceandsentryship_fall_back");
end
--***********************************************************************************************************************************************
--***********************************************************************************************************************************************


function dormant.plateau_sentryreveal_entrancetospaceandsentryship_lift_off_leader()
sleep_real_seconds_NOT_QUITE_RELEASE(3);
-- KILL THE FALL BACK SCRIPT IF DESTRUCTION IS OVER
b_sentryreveal_kill = true;
--KillScript( dormant.plateau_sentryreveal_entrancetospaceandsentryship_fall_back );
PrintNarrative("Narrative -  KillScript( dormant.plateau_sentryreveal_entrancetospaceandsentryship_fall_back )");
sleep_real_seconds_NOT_QUITE_RELEASE(10);
b_KrakenLiftOff = true;

--KillScript( dormant.plateau_sentryreveal_entrancetospaceandsentryship_lookat_kraken_locke );
--KillScript( dormant.plateau_sentryreveal_entrancetospaceandsentryship_lookat_kraken_tanaka );
--KillScript( dormant.plateau_sentryreveal_entrancetospaceandsentryship_lookat_kraken_vale );
--KillScript( dormant.plateau_sentryreveal_entrancetospaceandsentryship_lookat_kraken_thorne );
PrintNarrative("Narrative START - plateau_sentryreveal_entrancetospaceandsentryship_lift_off_leader");
--		story_blurb_add("domain", "The sentry ship takes off.");
						PlayDialogFromMarkerOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_00700.sound'), OBJECTS.vin_sent_machine, "audio_centerupper" );
						sleep_real_seconds_NOT_QUITE_RELEASE(5);
						PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_00400.sound'), ai_get_object(AI.sq_ward_bulwark_2.spawn_points_2) );
						sleep_real_seconds_NOT_QUITE_RELEASE(1);
						PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_00500.sound'), ai_get_object(AI.sq_ward_bulwark_2.spawn_points_3) );
						sleep_real_seconds_NOT_QUITE_RELEASE(1);
--				local l_dialog_id:thread=def_dialog_id_none();
--				l_dialog_id = dialog_start_background("plateau_sentryreveal_entrancetospaceandsentryship_lift_off_leader", l_dialog_id, true, def_dialog_style_play(), false, "", 0);
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_00700.sound'), false, OBJECTS.vin_sent_machine, 0.0, "", "Nezik : [The humans must not reach Tojinok!]", true );
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_00400.sound'), false, ai_get_object(AI.sq_evac_reserves_2.spawn_points_2), 0.0, "", "Grunt02 : Kill the humans!", true );
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_00500.sound'), false, ai_get_object(AI.sq_evac_reserves_2.spawn_points_0), 0.0, "", "Grunt02 : Death to the demons!", true );
--				l_dialog_id = dialog_end(l_dialog_id, true, true, "");

-- CHATTER SPARTANS ON
PrintNarrative("Narrative - Switch AI Chatter on");
ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
sleep_real_seconds_NOT_QUITE_RELEASE(8);
--sleep_real_seconds_NOT_QUITE_RELEASE(2);
--  TEAM REACTION			
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();

				l_dialog_id = dialog_start_foreground("plateau_sentryreveal_entrancetospaceandsentryship_lift_off_leader_team", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
--			if objects_are_within_distance_of_object(SPARTANS.vale, 150, OBJECTS.vin_sent_machine) then
-- IF VALE is present
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_01500.sound'), false, SPARTANS.vale, 0.0, "", "Vale : They're heading towards the Conduit!", true );
--			else
-- IF not present			
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_01000.sound'), false, nil, 0.0, "", "AIGoodwin : They're heading toward the Conduit!", true );
--			end
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_08000.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : We should probably hurry.", true );
					CreateThread(objective_text_goal_hollow);
-- ******   BUCK NEW LINE
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_08000.sound'), false, nil, 0.0, "", "AIGoodwin : You should probably hurry, Osiris.", true );
					
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_02500.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Double time Osiris! After that ship!", true );
					
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);


Wake(dormant.plateau_sentryreveal_entrancetospaceandsentryship_all_killed);
PrintNarrative("Narrative END - plateau_sentryreveal_entrancetospaceandsentryship_lift_off_leader");
end

-- ai_living_count(AI.sg_reveal_all)

function dormant.plateau_sentryreveal_entrancetospaceandsentryship_all_killed()
-- 															WHEN PLAYERS STAY TOO LONG AFTER ALL AI ARE KILLED
SleepUntil([| ai_living_count(AI.sq_ward_bulwark_1) == 0 and ai_living_count(AI.sq_ward_bulwark_2) == 0 and ai_living_count(AI.sq_ward_boss_1) == 0 and (not b_playerIsInHollow and not volume_test_players( VOLUMES.plateau_sentryreveal_entrancetospaceandsentryship_steps )) or objects_distance_to_object(players_human(),ai_get_object(AI.sg_reveal_all)) > 25 ], 1);
-- ***** ADD OTHER SQUAD IN THE STAIRS
sleep_real_seconds_NOT_QUITE_RELEASE(20);
PrintNarrative("Narrative START  -  plateau_sentryreveal_entrancetospaceandsentryship_all_killed");
		if not b_playerIsInHollow then
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentryreveal_entrancetospaceandsentryship_all_killed", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_01600.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Covies talk respect and honor, then destroy their own history?", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_01100.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : They've wrecked this place better than we could on a good day.", true );
					dialog_line_npc( l_dialog_id, 0, objects_distance_to_object(SPARTANS.vale, ai_get_object(AI.sg_reveal_all)) < 5, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_01700.sound'), false, SPARTANS.vale, 0.0, "", "Vale : They're so scared of the Domain opening they're acting irrationally.", true );
--					dialog_line_npc( l_dialog_id, 0, objects_distance_to_object(SPARTANS.vale, ai_get_object(AI.sg_reveal_all)) < 5, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_01800.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Covenant believe the Domain's opening signifies the end times. They don't care about their history, they care about their future.", true );

				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);				
		end
sleep_real_seconds_NOT_QUITE_RELEASE(4);
SleepUntil([|  ai_living_count( AI.sg_reveal_all ) == 0 or objects_distance_to_object(players_human(),ai_get_object(AI.sg_reveal_all)) > 25 ], 1);
sleep_real_seconds_NOT_QUITE_RELEASE(2);
		if not b_playerIsInHollow then
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentryreveal_entrancetospaceandsentryship_all_killed_2", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);


					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_09600.sound'), false, SPARTANS.tanaka, 0.0, "", "tanaka : Kraken's on the move and we're just standing here.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_02600.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Tanaka's right. Get moving.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);				
		end
PrintNarrative("Narrative END  -  plateau_sentryreveal_entrancetospaceandsentryship_all_killed");
end



-- =================================================================================================
-- =================================================================================================
-- =================================================================================================
--  _    _  ____  _      _      ______          __
-- | |  | |/ __ \| |    | |    / __ \ \        / /
-- | |__| | |  | | |    | |   | |  | \ \  /\  / / 
-- |  __  | |  | | |    | |   | |  | |\ \/  \/ /  
-- | |  | | |__| | |____| |___| |__| | \  /\  /   
-- |_|  |_|\____/|______|______\____/   \/  \/    
--                                                
-- =================================================================================================

function dormant.plateau_hollow_wake()
SleepUntil([| volume_test_players(VOLUMES.plateau_hollow_wake) ], 1);
PrintNarrative("Narrative LOAD Hollow Scenes");
b_playerIsInHollow = true;
b_playerIsInDropdown = true;
	Wake(dormant.plateau_hollow_forcefieldtraining_grunts);
	Wake(dormant.plateau_hollow_forcefieldtraining_lookat);
--	Wake(dormant.plateau_hollow_forcefieldtraining_grunts_behindshield);

	Wake(dormant.plateau_hollow_forcefieldtraining_elitetaunt);	
	Wake(dormant.plateau_hollow_forcefieldtraining_shieldemitter_lookat);	
	Wake(dormant.plateau_hollow_forcefieldtraining_gruntsurprise);
	
SleepUntil([| var_cov_projector_barrier == 1 ], 1);
sleep_real_seconds_NOT_QUITE_RELEASE(3);
PrintNarrative("Narrative LOAD Hollow Scenes for the Shield - waiting for the shield to be ON");
	Wake(dormant.plateau_hollow_forcefieldtraining_light_damage);	
	Wake(dormant.plateau_hollow_forcefieldtraining_heavy_damage);	
	Wake(dormant.plateau_hollow_forcefieldtraining_shield_down);
	
	
end

-- =================================================================================================



-- 															WHEN ENTERING HOLLOW
function dormant.plateau_hollow_forcefieldtraining_grunts()
SleepUntil([| var_cov_projector_barrier < 1 and ai_living_count( AI.sq_hollow_flipside.spawn_points_0 ) == 1 and object_get_health(AI.sq_hollow_flipside.spawn_points_0) > 0 and objects_distance_to_object( players_human(), ai_get_object(AI.sq_hollow_flipside.spawn_points_0) ) < 20 ], 1);
PrintNarrative("Narrative START - plateau_hollow_forcefieldtraining_grunts");
--		story_blurb_add("domain", "The sentry ship takes off.");
--				local l_dialog_id:thread=def_dialog_id_none();
--				l_dialog_id = dialog_start_background("plateau_hollow_forcefieldtraining_grunts", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
				if var_cov_projector_barrier < 1 and object_get_health(AI.sq_hollow_flipside.spawn_points_0) > 0 then
					
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_00600.sound'), false, ai_get_object(AI.sq_hollow_flipside.spawn_points_0), 0.0, "", "Grunt02 : Why it's not starting? Energy systems online? Check. Magnetic field activation...", true );
					PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_00600.sound'), ai_get_object(AI.sq_hollow_flipside.spawn_points_0) );
					sleep_real_seconds_NOT_QUITE_RELEASE(3);
				end
				if var_cov_projector_barrier < 1 and object_get_health(AI.sq_hollow_flipside.spawn_points_0) > 0 then
					
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_00700.sound'), false, ai_get_object(AI.sq_hollow_flipside.spawn_points_0), 0.0, "", "Grunt02 : or wait no, ionized plasma drive? I think? Or the other one first...", true );
					PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_00700.sound'), ai_get_object(AI.sq_hollow_flipside.spawn_points_0) );
					sleep_real_seconds_NOT_QUITE_RELEASE(3);					
				end
				if var_cov_projector_barrier < 1 and object_get_health(AI.sq_hollow_flipside.spawn_points_0) > 0 then
					
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_00800.sound'), false, ai_get_object(AI.sq_hollow_flipside.spawn_points_0), 0.0, "", "Grunt02 : Which one first, Klaroo? Think, Klaroo. Think. Maybe it's...", true );
					PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_00800.sound'), ai_get_object(AI.sq_hollow_flipside.spawn_points_0) );
					sleep_real_seconds_NOT_QUITE_RELEASE(3);
				end
				if var_cov_projector_barrier < 1 and object_get_health(AI.sq_hollow_flipside.spawn_points_0) > 0 then
					
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_00900.sound'), false, ai_get_object(AI.sq_hollow_flipside.spawn_points_0), 0.0, "", "Grunt02 : Except but what if... Why you always so stupid, Klaroo? Stupid", true );
					PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_00900.sound'), ai_get_object(AI.sq_hollow_flipside.spawn_points_0) );
					sleep_real_seconds_NOT_QUITE_RELEASE(3);
				end
				if var_cov_projector_barrier < 1 and object_get_health(AI.sq_hollow_flipside.spawn_points_0) > 0 then
					
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_01000.sound'), false, ai_get_object(AI.sq_hollow_flipside.spawn_points_0), 0.0, "", "Grunt02 : Stupid stupid me. Stupid me.", true );
					PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_01000.sound'), ai_get_object(AI.sq_hollow_flipside.spawn_points_0) );
					sleep_real_seconds_NOT_QUITE_RELEASE(3);
				end
				if var_cov_projector_barrier < 1 and ai_combat_status( AI.sq_hollow_flipside.spawn_points_0 ) >= 4 and object_get_health(AI.sq_hollow_flipside.spawn_points_0) > 0 then
				
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_01100.sound'), false, ai_get_object(AI.sq_hollow_flipside.spawn_points_0), 0.0, "", "Grunt02 : Gah! Humans!", true );
					PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt02_01100.sound'), ai_get_object(AI.sq_hollow_flipside.spawn_points_0) );
					sleep_real_seconds_NOT_QUITE_RELEASE(3);
				end
--				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
		if var_cov_projector_barrier == 1 then
				PrintNarrative("Narrative - plateau_hollow_forcefieldtraining_grunts - Grunt Alert level above 4, monologue interrupted");
		end
PrintNarrative("Narrative END - plateau_hollow_forcefieldtraining_grunts");
end


-- 															WHEN APPROACHING THE FORCE FIELD SHIELD AREA, GRUNTS BEHIND SHIELD ARE TAUNTING US
function dormant.plateau_hollow_forcefieldtraining_grunts_behindshield()
SleepUntil([| object_index_valid( AI.sq_hollow_flipside.spawn_points_0 ) and object_index_valid( OBJECTS.hollow_projected_barrier ) ], 1);

SleepUntil([| (volume_test_players(VOLUMES.plateau_hollow_forcefieldtraining_grunts) and objects_distance_to_object( players_human(), AI.sq_hollow_flipside.spawn_points_0 ) < 15) or not object_index_valid( AI.sq_hollow_flipside.spawn_points_0 )], 1);
PrintNarrative("Narrative START - plateau_hollow_forcefieldtraining_grunts_behindshield");

		if not object_index_valid( AI.sq_hollow_flipside.spawn_points_0 ) or object_get_health(OBJECTS.hollow_projected_barrier) == 0 then
				PrintNarrative("Narrative CANCELED - plateau_hollow_forcefieldtraining_grunts_behindshield - first line");
		else
				PrintNarrative("Narrative - plateau_hollow_forcefieldtraining_grunts_behindshield - first line");
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_background("plateau_hollow_forcefieldtraining_grunts", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_gruntfelda_00100.sound'), false, ai_get_object(AI.sq_hollow_flipside.spawn_points_0), 0.0, "", "GruntFelda : Haha! You can't get past this shield! Brand new! Very top best!", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
		end
Sleep(350);
SleepUntil([| (volume_test_players(VOLUMES.plateau_hollow_forcefieldtraining_grunts) and objects_distance_to_object( players_human(), AI.sq_hollow_flipside.spawn_points_0 ) < 15) or not object_index_valid( AI.sq_hollow_flipside.spawn_points_0 ) ], 1);
		if not object_index_valid( AI.sq_hollow_flipside.spawn_points_0 ) or object_get_health(OBJECTS.hollow_projected_barrier) == 0 then
				PrintNarrative("Narrative CANCELED - plateau_hollow_forcefieldtraining_grunts_behindshield - 2nd line");
		else
				PrintNarrative("Narrative - plateau_hollow_forcefieldtraining_grunts_behindshield - 2nd line");
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_background("plateau_hollow_forcefieldtraining_grunts", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_gruntfelda_00200.sound'), false, ai_get_object(AI.sq_hollow_flipside.spawn_points_0), 0.0, "", "GruntFelda : Look at you! On wrong side of our shield!", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
		end
Sleep(250);
SleepUntil([| (volume_test_players(VOLUMES.plateau_hollow_forcefieldtraining_grunts) and objects_distance_to_object( players_human(), AI.sq_hollow_flipside.spawn_points_0 ) < 15) or not object_index_valid( AI.sq_hollow_flipside.spawn_points_0 ) ], 1);
		if not object_index_valid( AI.sq_hollow_flipside.spawn_points_0 ) or object_get_health(OBJECTS.hollow_projected_barrier) == 0  then
				PrintNarrative("Narrative CANCELED - plateau_hollow_forcefieldtraining_grunts_behindshield - 3rd line");
		else
				PrintNarrative("Narrative - plateau_hollow_forcefieldtraining_grunts_behindshield - 3rd line");
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_background("plateau_hollow_forcefieldtraining_grunts", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_gruntfelda_00300.sound'), false, ai_get_object(AI.sq_hollow_flipside.spawn_points_0), 0.0, "", "GruntFelda : Nasty, stupid humans! The Divine will finish you!", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
		end
Sleep(400);
SleepUntil([| (volume_test_players(VOLUMES.plateau_hollow_forcefieldtraining_grunts) and objects_distance_to_object( players_human(), AI.sq_hollow_flipside.spawn_points_0 ) < 15) or not object_index_valid( AI.sq_hollow_flipside.spawn_points_0 ) ], 1);
		if not object_index_valid( AI.sq_hollow_flipside.spawn_points_0 ) or object_get_health(OBJECTS.hollow_projected_barrier) == 0  then
				PrintNarrative("Narrative CANCELED - plateau_hollow_forcefieldtraining_grunts_behindshield - 4th line");
		else
				PrintNarrative("Narrative - plateau_hollow_forcefieldtraining_grunts_behindshield - 4th line");
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_background("plateau_hollow_forcefieldtraining_grunts", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_gruntfelda_00400.sound'), false, ai_get_object(AI.sq_hollow_flipside.spawn_points_0), 0.0, "", "GruntFelda : The Divine stopped you the first time! Our shield will stop you now!", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
		end

PrintNarrative("Narrative END - plateau_hollow_forcefieldtraining_grunts_behindshield");
end







-- 															WHEN APPROACHING THE FORCE FIELD SHIELD
function dormant.plateau_hollow_forcefieldtraining_lookat()
SleepUntil([|  object_valid( "hollow_projected_barrier") and var_cov_projector_barrier == 1 ], 3);
sleep_real_seconds_NOT_QUITE_RELEASE(2);
SleepUntil([| 	(not object_valid( "hollow_projected_barrier" )) or
				(object_get_health(OBJECTS.hollow_projected_barrier)>0.5 and volume_test_players_lookat(VOLUMES.plateau_hollow_forcefieldtraining_lookat, 18, 5) and volume_test_players(VOLUMES.plateau_hollow_forcefieldtraining_grunts)) ], 1);
PrintNarrative("Narrative START - plateau_hollow_forcefieldtraining_lookat");
--		story_blurb_add("domain", "One player sees the Force Field Shield.");

	if object_valid( "hollow_projected_barrier" ) then
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_hollow_forcefieldtraining_lookat", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
-- IF LOCKE
				if volume_test_player_lookat(VOLUMES.plateau_hollow_forcefieldtraining_lookat, unit_get_player( SPARTANS.locke ), 19, 6) then

					dialog_line_npc( l_dialog_id, 0, ((not b_shield_skip_intro) and (kill_forcefieldtraining == false)), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_02900.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Shield in the way. Low power. Take it down.", true );
					dialog_line_npc( l_dialog_id, 0,  ((not b_shield_skip_intro) and (kill_forcefieldtraining == false)), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_01200.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Affirmative.", true );
-- ELSEIF TANAKA
				elseif volume_test_player_lookat(VOLUMES.plateau_hollow_forcefieldtraining_lookat, unit_get_player( SPARTANS.tanaka ), 19, 6) then
					
					dialog_line_npc( l_dialog_id, 0,  ((not b_shield_skip_intro) and (kill_forcefieldtraining == false)), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_01700.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Shield in the way. Low power.", true );
					dialog_line_npc( l_dialog_id, 0,  ((not b_shield_skip_intro) and (kill_forcefieldtraining == false)), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03000.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Take it down!", true );
					
-- ELSEIF VALE
				elseif volume_test_player_lookat(VOLUMES.plateau_hollow_forcefieldtraining_lookat, unit_get_player( SPARTANS.vale ), 19, 6) then
					
					dialog_line_npc( l_dialog_id, 0,  ((not b_shield_skip_intro) and (kill_forcefieldtraining == false)), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_01900.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Shield in the way. Low power.", true );
					dialog_line_npc( l_dialog_id, 0,  ((not b_shield_skip_intro) and (kill_forcefieldtraining == false)), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03000.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Take it down!", true );
					

-- ELSEIF THORNE
				elseif	volume_test_player_lookat(VOLUMES.plateau_hollow_forcefieldtraining_lookat, unit_get_player( SPARTANS.thorne ), 19, 6) then
					
					dialog_line_npc( l_dialog_id, 0, not  ((not b_shield_skip_intro) and (kill_forcefieldtraining == false)), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_01300.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Shield in the way. Low power.", true );
					dialog_line_npc( l_dialog_id, 0, not  ((not b_shield_skip_intro) and (kill_forcefieldtraining == false)), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03000.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Take it down!", true );
-- END IF
				end
sleep_real_seconds_NOT_QUITE_RELEASE(0.5);
				dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_01800.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Shield's gotta have a weak spot. Or maybe there's a way around it.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
				PrintNarrative("Narrative END - plateau_hollow_forcefieldtraining_lookat");
	elseif not object_valid( "hollow_projected_barrier" ) then
	PrintNarrative("Narrative CANCELED - plateau_hollow_forcefieldtraining_lookat");
	end
end




-- =================================================================================================
--		SHIELD START
-- =================================================================================================

-- 															WHEN SHOOTING WITH GUNS ON THE SHIELD AND NOT MAKING ENOUGH DAMAGE
function dormant.plateau_hollow_forcefieldtraining_light_damage()

SleepUntil([| object_valid( "hollow_projected_barrier" )], 1);
SleepUntil([| 	not object_valid( "hollow_projected_barrier" ) or 
				var_cov_projector_barrier == 1 and object_get_health(OBJECTS.hollow_projected_barrier)<0.98 and volume_test_players_lookat(VOLUMES.plateau_hollow_forcefieldtraining_lookat, 24, 4) ], 1);
PrintNarrative("Narrative START - plateau_hollow_forcefieldtraining_heavy_damage");
	if object_valid( "hollow_projected_barrier" ) and object_get_health(OBJECTS.hollow_projected_barrier)>0.9  then
		PrintNarrative("Narrative - Shield health = " .. object_get_health(OBJECTS.hollow_projected_barrier));
			b_shield_light_damage = true;

--		sleep_real_seconds_NOT_QUITE_RELEASE(1);
		PrintNarrative("Narrative - Shield health = " .. object_get_health(OBJECTS.hollow_projected_barrier));
					 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
					l_dialog_id = dialog_start_foreground("plateau_hollow_forcefieldtraining_light_damage", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
	-- IF LOCKE
					if volume_test_player_lookat(VOLUMES.plateau_hollow_forcefieldtraining_lookat, unit_get_player(SPARTANS.locke), 25, 5) then
						
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03100.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Shield's stronger than I thought. Focus fire!", true );
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_01900.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Roger that.", true );
	-- ELSEIF TANAKA
					elseif volume_test_player_lookat(VOLUMES.plateau_hollow_forcefieldtraining_lookat, unit_get_player(SPARTANS.tanaka), 25, 5) then
						
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_02000.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : The shield's self-repairing.", true );
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03200.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Focus fire Osiris!", true );
	-- ELSEIF VALE
					elseif volume_test_player_lookat(VOLUMES.plateau_hollow_forcefieldtraining_lookat, unit_get_player(SPARTANS.vale), 25, 5) then
						
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_02000.sound'), false, SPARTANS.vale, 0.0, "", "Vale : The shield's absorbing everything I've got!", true );
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03200.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Focus fire Osiris!", true );
	-- ELSEIF THORNE
					elseif	volume_test_player_lookat(VOLUMES.plateau_hollow_forcefieldtraining_lookat, unit_get_player(SPARTANS.thorne), 25, 5) then
						
--						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_01500.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : Shield's too strong.", true );
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_01400.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Shield's too strong.", true );
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03200.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Focus fire Osiris!", true );
	-- END IF
					end
					l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
		PrintNarrative("Narrative END - plateau_hollow_forcefieldtraining_light_damage");
	else
		PrintNarrative("Narrative CANCELED - plateau_hollow_forcefieldtraining_light_damage");
	end

end


function plateau_hollow_forcefieldtraining_health():void

	repeat
		print("Shield Health", object_get_health(OBJECTS.hollow_projected_barrier));
	sleep_s(0.5);
	until object_get_health(OBJECTS.hollow_projected_barrier) <=0

end


function dormant.plateau_hollow_forcefieldtraining_heavy_damage()

--  												SHOOTING ON THE SHIELD WITH heavy firepower
SleepUntil([| object_valid( "hollow_projected_barrier" )], 1);
SleepUntil([| 	not object_valid( "hollow_projected_barrier" ) or 
				var_cov_projector_barrier == 1 and object_get_health(OBJECTS.hollow_projected_barrier)<0.9 and volume_test_players_lookat(VOLUMES.plateau_hollow_forcefieldtraining_lookat, 19, 4) ], 1);
PrintNarrative("Narrative START - plateau_hollow_forcefieldtraining_heavy_damage");
	if object_valid( "hollow_projected_barrier" ) and object_get_health(OBJECTS.hollow_projected_barrier)>0.1  then
		PrintNarrative("Narrative - Shield health = " .. object_get_health(OBJECTS.hollow_projected_barrier));
		b_shield_heavy_damage = true;
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_hollow_forcefieldtraining_heavy_damage", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
-- IF LOCKE
				if volume_test_player_lookat(VOLUMES.plateau_hollow_forcefieldtraining_lookat, unit_get_player(SPARTANS.locke), 20, 5) == true and object_get_health(OBJECTS.hollow_projected_barrier) > 0.2 then
					
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03300.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Shield's starting to buckle!", true );
					
-- ELSEIF TANAKA
				elseif volume_test_player_lookat(VOLUMES.plateau_hollow_forcefieldtraining_lookat, unit_get_player(SPARTANS.tanaka), 20, 5) == true and object_get_health(OBJECTS.hollow_projected_barrier) > 0.2 then
					
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_02100.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : This shield is toast!", true );
					
-- ELSEIF VALE
				elseif volume_test_player_lookat(VOLUMES.plateau_hollow_forcefieldtraining_lookat, unit_get_player(SPARTANS.vale), 20, 5) == true and object_get_health(OBJECTS.hollow_projected_barrier) > 0.2 then
					
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_02100.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Shield's losing power!", true );
					
-- ELSEIF THORNE
				elseif	volume_test_player_lookat(VOLUMES.plateau_hollow_forcefieldtraining_lookat, unit_get_player(SPARTANS.thorne), 20, 5) == true and object_get_health(OBJECTS.hollow_projected_barrier) > 0.2 then
					
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_01600.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : Shield's losing power! Concentrate heavy fire!", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_01500.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Shield's losing power! Concentrate heavy fire!", true );
-- END IF
				end
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
				PrintNarrative("Narrative END - plateau_hollow_forcefieldtraining_heavy_damage");
	else
				PrintNarrative("Narrative CANCELED - plateau_hollow_forcefieldtraining_heavy_damage");
	end
end


function dormant.plateau_hollow_forcefieldtraining_shieldemitter_lookat()
--  ADD THE OTHER GHOST AFTER NAMING IT

--  												LOOKING AT THE EMITTER WEAK POINT
SleepUntil([|  object_valid( "hollow_projected_barrier")], 1)
SleepUntil([| not object_valid( "hollow_projected_barrier") or object_get_health(OBJECTS.hollow_projected_barrier)>0.1 and volume_test_objects(VOLUMES.plateau_hollow_forcefieldtraining_behind, players_human()) and volume_test_players_lookat(VOLUMES.plateau_hollow_forcefieldtraining_shieldemitter_lookat, 17, 2) ], 1);

PrintNarrative("Narrative START - plateau_hollow_forcefieldtraining_shieldemitter_lookat");	
b_shield_skip_intro = true;
	if object_valid( "hollow_projected_barrier") and object_get_health(OBJECTS.hollow_projected_barrier)>0.1 then
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_hollow_forcefieldtraining_shieldemitter_lookat", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
-- IF LOCKE
				if volume_test_objects(VOLUMES.plateau_hollow_forcefieldtraining_behind, SPARTANS.locke) and volume_test_player_lookat(VOLUMES.plateau_hollow_forcefieldtraining_shieldemitter_lookat, unit_get_player( SPARTANS.locke ), 18, 5) == true then
					
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03400.sound'), false, SPARTANS.locke, 0.0, "", "Locke : I have a shot on the shield generator.", true );
					dialog_line_npc( l_dialog_id, 0, object_get_health(OBJECTS.hollow_projected_barrier)>0.2, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_02200.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Pop that the whole thing'll go.", true );
				
-- ELSEIF TANAKA
				elseif volume_test_objects(VOLUMES.plateau_hollow_forcefieldtraining_behind, SPARTANS.tanaka) and volume_test_player_lookat(VOLUMES.plateau_hollow_forcefieldtraining_shieldemitter_lookat, unit_get_player( SPARTANS.tanaka ), 18, 5) == true then
					
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_02300.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Got a shot on the shield generator.", true );
					dialog_line_npc( l_dialog_id, 0, object_get_health(OBJECTS.hollow_projected_barrier)>0.2, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03500.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Take the shot Tanaka! ", true );
-- ELSEIF VALE
				elseif volume_test_objects(VOLUMES.plateau_hollow_forcefieldtraining_behind, SPARTANS.vale) and volume_test_player_lookat(VOLUMES.plateau_hollow_forcefieldtraining_shieldemitter_lookat, unit_get_player( SPARTANS.vale ), 18, 5) == true then
										
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_02200.sound'), false, SPARTANS.vale, 0.0, "", "Vale : I have a shot on the shield generator.", true );
					dialog_line_npc( l_dialog_id, 0, object_get_health(OBJECTS.hollow_projected_barrier)>0.2, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03600.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Take the shot Vale!", true );
-- ELSEIF THORNE
				elseif	volume_test_objects(VOLUMES.plateau_hollow_forcefieldtraining_behind, SPARTANS.thorne) and volume_test_player_lookat(VOLUMES.plateau_hollow_forcefieldtraining_shieldemitter_lookat, unit_get_player( SPARTANS.thorne ), 18, 5) == true then

--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_01700.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : I have a shot on the shield generator.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_01600.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : I got a shot at the shield generator.", true );
					dialog_line_npc( l_dialog_id, 0, object_get_health(OBJECTS.hollow_projected_barrier)>0.2, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03800.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Take the shot Buck!", true );
-- END IF
				end
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
				PrintNarrative("Narrative END - plateau_hollow_forcefieldtraining_shieldemitter_lookat");
	elseif not object_valid( "hollow_projected_barrier") then
				PrintNarrative("Narrative CANCELED - plateau_hollow_forcefieldtraining_shieldemitter_lookat");
	end
end

				

function dormant.plateau_hollow_forcefieldtraining_shield_down()
--  												SHIELD IS DOWN
SleepUntil([|  object_valid( "hollow_projected_barrier")], 1);
SleepUntil([| 	not object_valid( "hollow_projected_barrier") or 
					(object_get_health(OBJECTS.hollow_projected_barrier) <=0 and volume_test_players_lookat(VOLUMES.plateau_hollow_forcefieldtraining_lookat, 30, 14)) ], 1);
PrintNarrative("Narrative START - plateau_hollow_forcefieldtraining_shield_down");
kill_forcefieldtraining = true;
--KillScript( dormant.plateau_hollow_forcefieldtraining_lookat );

	if object_valid( "hollow_projected_barrier") then
				PrintNarrative("Narrative START - plateau_hollow_forcefieldtraining_shield_down - Playing a dialogue");
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_hollow_forcefieldtraining_shield_down", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
-- IF LOCKE
				if volume_test_player_lookat(VOLUMES.plateau_hollow_forcefieldtraining_lookat, unit_get_player( SPARTANS.locke ), 33, 15) == true then

					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_09300.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Shield's down.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_03900.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Fantastic!", true );
					
-- ELSEIF TANAKA
				elseif IsPlayer(SPARTANS.tanaka) and volume_test_player_lookat(VOLUMES.plateau_hollow_forcefieldtraining_lookat, unit_get_player( SPARTANS.tanaka), 33, 15) == true then
					
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_04900.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Shield's down.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_09500.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Perfect, Tanaka. ", true );
					
-- ELSEIF VALE
				elseif IsPlayer(SPARTANS.vale) and volume_test_player_lookat(VOLUMES.plateau_hollow_forcefieldtraining_lookat, unit_get_player( SPARTANS.vale), 33, 15) == true then

					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_04700.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Shield's down!", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_09600.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Perfect, Vale.", true );
					
-- ELSEIF THORNE
				elseif IsPlayer(SPARTANS.thorne) and volume_test_player_lookat(VOLUMES.plateau_hollow_forcefieldtraining_lookat, unit_get_player( SPARTANS.thorne), 33, 15) == true then
					
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_04000.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Shield's down!", true );
	
-- END IF
				end
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
				PrintNarrative("Narrative END - plateau_hollow_forcefieldtraining_shield_down");
	else
				PrintNarrative("Narrative CANCELED - plateau_hollow_forcefieldtraining_shield_down");
	end

end

--		SHIELD END
-- =================================================================================================


function dormant.plateau_hollow_forcefieldtraining_elitetaunt()
-- 															WHEN APPROACHING THE ELITE, HE TAUNTS US
SleepUntil([| ai_living_count( AI.sq_hollow_porch_elite.spawn_points_2 ) == 1 ], 1);
SleepUntil([| ai_living_count( AI.sq_hollow_porch_elite.spawn_points_2 ) == 1 and objects_distance_to_object( players_human(), AI.sq_hollow_porch_elite.spawn_points_2) < 6 and object_get_health( AI.sq_hollow_porch_elite.spawn_points_2) > 0.4 ], 1);
PrintNarrative("Narrative START - plateau_hollow_forcefieldtraining_elitetaunt");
		if object_get_health( AI.sq_hollow_porch_elite.spawn_points_2) > 0.4 then				
--				local l_dialog_id:thread=def_dialog_id_none();
--				l_dialog_id = dialog_start_background("plateau_hollow_forcefieldtraining_elitetaunt", l_dialog_id, true, def_dialog_style_play(), false, "", 0);

--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite03_00400.sound'), false, ai_get_object(AI.sq_hollow_porch_elite.spawn_points_2), 0.0, "", "Elite03 : You will not reach the Conduit!", true );
					PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite03_00400.sound'), ai_get_object(AI.sq_hollow_porch_elite.spawn_points_2) );
--				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
		end
				sleep_real_seconds_NOT_QUITE_RELEASE(5);
		if object_get_health( AI.sq_hollow_porch_elite.spawn_points_2) > 0.4 and objects_distance_to_object( players_human(), AI.sq_hollow_porch_elite.spawn_points_2) < 6 then
--				local l_dialog_id:thread=def_dialog_id_none();
--				l_dialog_id = dialog_start_background("plateau_hollow_forcefieldtraining_elitetaunt_2", l_dialog_id, true, def_dialog_style_play(), false, "", 0);
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite03_00500.sound'), false, ai_get_object(AI.sq_hollow_porch_elite.spawn_points_2), 0.0, "", "Elite03 : Leave the Guardian at peace, Demon! ", true );
					PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite03_00500.sound'), ai_get_object(AI.sq_hollow_porch_elite.spawn_points_2) );
--				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
		end
PrintNarrative("Narrative END - plateau_hollow_forcefieldtraining_elitetaunt");
end


-- ****************************************************************************************************************
-- ADD CONDITION VOLUME
function dormant.plateau_hollow_forcefieldtraining_gruntsurprise()
-- 															WHEN APPROACHING THE ELITE, HE TAUNTS US

SleepUntil	(		[| ai_living_count( AI.sq_hollow_flipside.spawn_points_0 ) == 1 ]	and
					[|  object_valid( "hollow_projected_barrier")]
					, 5);
SleepUntil([| 	ai_living_count( AI.sq_hollow_flipside.spawn_points_0 ) == 0 or 
				(ai_living_count( AI.sq_hollow_flipside.spawn_points_0 ) == 1 and object_get_health(OBJECTS.hollow_projected_barrier) <= 0 and objects_distance_to_object( players_human(), AI.sq_hollow_flipside.spawn_points_0) < 5) ], 1);
PrintNarrative("Narrative START - plateau_hollow_forcefieldtraining_gruntsurprise");

			if ai_living_count( AI.sq_hollow_flipside.spawn_points_0 ) == 1 then 
--				local l_dialog_id:thread=def_dialog_id_none();
--				l_dialog_id = dialog_start_background("plateau_hollow_forcefieldtraining_gruntsurprise", l_dialog_id, true, def_dialog_style_play(), false, "", 0);
					
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt01_00500.sound'), false, ai_get_object(AI.sq_hollow_flipside.spawn_points_0), 0.0, "", "Grunt01 : Get away! Get away! Get away! (panicked cry)", true );
					PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt01_00500.sound'), ai_get_object(AI.sq_hollow_flipside.spawn_points_0) );
--				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
			elseif ai_living_count( AI.sq_hollow_flipside.spawn_points_0 ) == 0 then
				PrintNarrative("Narrative CANCELED - plateau_hollow_forcefieldtraining_gruntsurprise - grunt despawned");
			end
			
PrintNarrative("Narrative END - plateau_hollow_forcefieldtraining_gruntsurprise");
end


-- NEED TO ADD IF PLAYER TOOK NO ACTION AFTER X SECONDS AGAINST THE SHIELD



-- =================================================================================================
--   _____     __      ________ 
--  / ____|   /\ \    / /  ____|
-- | |       /  \ \  / /| |__   
-- | |      / /\ \ \/ / |  __|  
-- | |____ / ____ \  /  | |____ 
--  \_____/_/    \_\/   |______|
--                              
-- =================================================================================================

function dormant.plateau_cave_wake()
SleepUntil([| volume_test_players(VOLUMES.plateau_cave_travelonfoot) ], 1);
PrintNarrative("Narrative LOAD Cave Scenes");
b_playerIsInHollow = true;
b_playerIsInDropdown = true;
	Wake(dormant.plateau_cave_travelonfoot);

	Wake(dormant.plateau_cave_viewoftheship);
	
	
end

-- =================================================================================================


-- 															WHEN NO PLAYERS ARE IN A GHOST AND IN THE CAVE
function dormant.plateau_cave_travelonfoot()

SleepUntil([| volume_test_players( VOLUMES.plateau_cave_travelonfoot)], 1);

PrintNarrative("Narrative START - plateau_cave_travelonfoot");

--		TESTING IF ANY PLAYER IS IN A VEHICLE
		local in_vehicle:boolean = false;

		if IsPlayer(SPARTANS[1]) then
			in_vehicle = unit_in_vehicle(SPARTANS[1]);
		end

		if not in_vehicle and IsPlayer(SPARTANS[2]) then
			in_vehicle = unit_in_vehicle(SPARTANS[2]);
		end

		if not in_vehicle and IsPlayer(SPARTANS[3]) then
			in_vehicle = unit_in_vehicle(SPARTANS[3]);
		end
       
		if not in_vehicle and IsPlayer(SPARTANS[4]) then
			in_vehicle = unit_in_vehicle(SPARTANS[4]);
		end
	   

	if not in_vehicle and not unit_in_vehicle(SPARTANS.tanaka) and not unit_in_vehicle(SPARTANS.buck) then
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_cave_travelonfoot", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);

					
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_02400.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Never gonna catch up on foot.", true );
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_01800.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : You don't like jogging, Tanaka?", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_01700.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : You don't like jogging, Tanaka?", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_02500.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Like it fine. Just rather have a ride.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
		PrintNarrative("Narrative END - plateau_cave_travelonfoot");
	else
		PrintNarrative("Narrative CANCELED - plateau_cave_travelonfoot");
	end
end

-- 

-- 															WHEN PLAYER EXIT THE CAVE AND LOOK AT THE SENTRY SHIP
--   NEED THE SENTRY SHIP OBJECT TO REPLACE THE VOLUME *****************************************************************************************************************
function dormant.plateau_cave_viewoftheship()
SleepUntil([| 	objects_can_see_object( players_human(), OBJECTS.vin_sent_machine, 35 ) and volume_test_players(VOLUMES.plateau_ramp_palacecombat) or			--	If a Spartans see the Kraken and is in the right Volume.
				volume_test_players(VOLUMES.plateau_ramp_palacecombat_2)], 1);				--	OR If player didn't look at the Kraken yet but enter the Second Volume (safe volume to be sure that we are triggering that line.)
PrintNarrative("Narrative START - plateau_cave_viewoftheship");
--		story_blurb_add("domain", "Coming out of the cave, players see the Sentry Ship.");
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_cave_viewoftheship", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);

						if not objects_can_see_object( players_human(), OBJECTS.vin_sent_machine, 17 ) and volume_test_players(VOLUMES.plateau_ramp_palacecombat_2) then		--	If a player is in the second Volume and havn't see the Kraken, we trigger the Big horn from the Kraken
							PrintNarrative("2D/3D Horn");
							RunClientScript("horn_3d_client");
						elseif objects_can_see_object( players_human(), OBJECTS.vin_sent_machine, 17 ) then		--		If a player looked a the Kraken, we trigger another Horn, Robbie wanted to be able to trigger a different sound here.
							RunClientScript("horn_3d_bis_client");
						end
							
--	If a player enters the second Volume without seeing the Kraken, I trigger the line from a musketeer rather than from the player.					
		-- IF LOCKE
						if volume_test_object(VOLUMES.plateau_ramp_palacecombat, SPARTANS.locke) then
							PrintNarrative("Locke sees the Kraken");
							dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03900.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Kraken's right there!", true );
		-- ELSEIF THORNE
						elseif IsPlayer(SPARTANS.thorne) and volume_test_object(VOLUMES.plateau_ramp_palacecombat, SPARTANS.thorne) or
								(not IsPlayer(SPARTANS.thorne) and volume_test_players(VOLUMES.plateau_ramp_palacecombat_2) and objects_distance_to_object( SPARTANS.thorne, OBJECTS.vin_sent_machine ) < 120) then
							if objects_can_see_object( SPARTANS.thorne, OBJECTS.vin_sent_machine, 50 ) then
								PrintNarrative("Buck sees the Kraken");
							end
							dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_01800.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Kraken's back!", true );
							sleep_real_seconds_NOT_QUITE_RELEASE(1.5);
		-- ELSEIF TANAKA
						elseif IsPlayer(SPARTANS.tanaka) and volume_test_object(VOLUMES.plateau_ramp_palacecombat, SPARTANS.tanaka) or		-- If tanaka is a player and look at the Kraken
								(not IsPlayer(SPARTANS.tanaka) and volume_test_players(VOLUMES.plateau_ramp_palacecombat_2) and objects_distance_to_object( SPARTANS.tanaka, OBJECTS.vin_sent_machine ) < 120) then	-- If a player pass the final volume and tanaka is a musketeer near the player
							if objects_can_see_object( SPARTANS.tanaka, OBJECTS.vin_sent_machine, 50 ) then
								PrintNarrative("Tanaka sees the Kraken");
							end
							dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_02600.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Can see the Kraken!", true );
		-- ELSEIF VALE
						elseif IsPlayer(SPARTANS.vale) and volume_test_object(VOLUMES.plateau_ramp_palacecombat, SPARTANS.vale) or
								(not IsPlayer(SPARTANS.vale) and volume_test_players(VOLUMES.plateau_ramp_palacecombat_2) and objects_distance_to_object( SPARTANS.vale, OBJECTS.vin_sent_machine ) < 120) then
							if objects_can_see_object( SPARTANS.vale, OBJECTS.vin_sent_machine, 50 ) then
								PrintNarrative("Vale sees the Kraken");
							end
							dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_02300.sound'), false, SPARTANS.vale, 0.0, "", "Vale : There's the Kraken!", true );
		-- END IF
						end
				
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_08100.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Tenacious SOBs. When that thing get's in range I want the first shot.", true );
				
--				dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_02700.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : They sure act like it.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);


b_ritualIsInterrupted = false;
				
PrintNarrative("Narrative END - plateau_cave_viewoftheship");
end

-- =================================================================================================
--  _____            __  __ _____  
-- |  __ \     /\   |  \/  |  __ \ 
-- | |__) |   /  \  | \  / | |__) |
-- |  _  /   / /\ \ | |\/| |  ___/ 
-- | | \ \  / ____ \| |  | | |     
-- |_|  \_\/_/    \_\_|  |_|_|     
--                                 
-- =================================================================================================



function dormant.plateau_ramp_wake()
SleepUntil([| volume_test_players(VOLUMES.plateau_cave_travelonfoot) ], 1);
PrintNarrative("Narrative LOAD Ramp Scenes");
	b_playerIsInDropdown = true;
	b_playerIsInHollow = true;
	b_playerIsInRamp = true;
	b_ritualIsInterrupted = true;

--	Wake(dormant.plateau_ramp_palacecombat_fast_sentry);
	Wake(dormant.plateau_ramp_stillonfoot);
	Wake(dormant.plateau_ramp_viewofthesentryship_gone);
	Wake(dormant.plateau_ramp_recon_data_1);
	
	if not IsThreadValid( dormant.plateau_ramp_nezik ) then
		Wake(dormant.plateau_ramp_nezik);
	end
	
end


-- 															NEZIK SPEAKS DURING RAMP
--		FUNCTION CALLED AT THE END OF NEZIK LINES IN SENTRY REVEAL
function dormant.plateau_ramp_nezik()
SleepUntil([| b_playerIsInRamp ], 1);

PrintNarrative("Narrative START - plateau_ramp_nezik");
--  NEZIK LINE 1
SleepUntil([| not b_ritualIsInterrupted and not b_playerIsInBowl], 1);
sleep_real_seconds_NOT_QUITE_RELEASE(random_range( 3, 7 ));
--				local l_dialog_id:thread=def_dialog_id_none();
--				l_dialog_id = dialog_start_background("plateau_ramp_nezik_1", l_dialog_id, true, def_dialog_style_play(), true, "", 1);
					
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_00800.sound'), false, OBJECTS.vin_sent_machine, 0.0, "", "Nezik : Continue praying, brothers!", true );
					
--				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
				PlayDialogFromMarkerOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_00800.sound'), OBJECTS.vin_sent_machine, "audio_centerupper" );
					
					sleep_real_seconds_NOT_QUITE_RELEASE(10);
sleep_real_seconds_NOT_QUITE_RELEASE(random_range( 20, 40 ));
--  NEZIK LINE 2				
SleepUntil([| not b_ritualIsInterrupted and not b_playerIsInBowl], 1);
--				local l_dialog_id:thread=def_dialog_id_none();
--				l_dialog_id = dialog_start_background("plateau_ramp_nezik_2", l_dialog_id, true, def_dialog_style_play(), true, "", 1);
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_00900.sound'), false, OBJECTS.vin_sent_machine, 0.0, "", "Nezik : We must not let the humans near the Conduit!", true );
--				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
PlayDialogFromMarkerOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_00900.sound'), OBJECTS.vin_sent_machine, "audio_centerupper" );
					
					sleep_real_seconds_NOT_QUITE_RELEASE(10);
				
PrintNarrative("Narrative END - plateau_ramp_nezik");
end



-- 															WHEN NOT IN A GHOST AND AT THE RAMP
function dormant.plateau_ramp_stillonfoot()
SleepUntil([| volume_test_players(VOLUMES.plateau_ramp_stillonfoot) ], 1);

	Wake(dormant.plateau_ramp_palacecombat_phantom_1);
	Wake(dormant.plateau_ramp_palacecombat_phantom_2);
	Wake(dormant.plateau_ramp_palacecombat_phantom_3);
	Wake(dormant.plateau_ramp_palacecombat_phantom_4);

--		TESTING IF ANY PLAYER IS IN A VEHICLE
		local in_vehicle:boolean = false;

		if IsPlayer(SPARTANS[1]) then
			in_vehicle = unit_in_vehicle(SPARTANS[1]);
		end

		if not in_vehicle and IsPlayer(SPARTANS[2]) then
			in_vehicle = unit_in_vehicle(SPARTANS[2]);
		end

		if not in_vehicle and IsPlayer(SPARTANS[3]) then
			in_vehicle = unit_in_vehicle(SPARTANS[3]);
		end
       
		if not in_vehicle and IsPlayer(SPARTANS[4]) then
			in_vehicle = unit_in_vehicle(SPARTANS[4]);
		end
	if not in_vehicle and not unit_in_vehicle(SPARTANS.vale) then
		PrintNarrative("Narrative START - plateau_ramp_stillonfoot");
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_ramp_stillonfoot", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_02400.sound'), false, SPARTANS.vale, 0.0, "", "Vale : All that running in basic training. finally paying off.", true );
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_02100.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : I had a drill sergeant in basic who made the whole squad jog backwards if anybody questioned orders.", true );
-- ******** Next LINE IS STILL TTS
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_08600.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : I had a drill sergeant back in basic who made our whole squad jog backwards if anybody questioned orders.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_02500.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Why? What did that do?", true );
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_02200.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : Taught us not to question orders.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_08700.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Well, for one thing, it taught us not to question orders.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
		PrintNarrative("Narrative END - plateau_ramp_stillonfoot");
	else
		PrintNarrative("Narrative CANCELED - plateau_ramp_stillonfoot");
	end
end









--                                     WHEN ON RAMP AND SENTRY SHIP STILL THERE
function dormant.plateau_ramp_palacecombat_fast_sentry()
SleepUntil([| volume_test_players(VOLUMES.plateau_ramp_palacecombat_fast_sentry) ], 1);
-- ADD look at the sentry ship when Asset will be ready
PrintNarrative("Narrative START - plateau_ramp_palacecombat_fast_sentry");
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_background("plateau_ramp_palacecombat_fast_sentry", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_00700.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Ship hasn't pulled away yet.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_01900.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Keep on it.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);	
	
PrintNarrative("Narrative END - plateau_ramp_palacecombat_fast_sentry");	
end



-- =================================================================================================
-- PHANTOMS
-- =================================================================================================

function dormant.plateau_ramp_palacecombat_phantom_1()
																					-- disabled - phantoms removed
SleepUntil([| ai_living_count( AI.sq_ramp_phantom_1.spawn_points_0 ) == 1 ], 1);
SleepUntil([| 	ai_living_count( AI.sq_ramp_phantom_1.spawn_points_0 ) == 0 or 
				objects_distance_to_object( players_human(), AI.sq_ramp_phantom_1.spawn_points_0 ) < 60 and objects_can_see_object(players_human(), AI.sq_ramp_phantom_1.spawn_points_0, 5)], 1);
PrintNarrative("Narrative START - plateau_ramp_palacecombat_phantom_1");
KillScript( dormant.plateau_ramp_palacecombat_phantom_2 );
KillScript( dormant.plateau_ramp_palacecombat_phantom_3 );
KillScript( dormant.plateau_ramp_palacecombat_phantom_4 );

	if ai_living_count( AI.sq_ramp_phantom_1.spawn_points_0 ) == 1 then
		CreateThread(plateau_ramp_palacecombat_phantom);
	else
		PrintNarrative("Narrative CANCELED - plateau_ramp_palacecombat_phantom_1");	
	end
--
PrintNarrative("Narrative END - plateau_ramp_palacecombat_phantom_1");	
end

function dormant.plateau_ramp_palacecombat_phantom_2()
																					-- disabled - phantoms removed
SleepUntil([| ai_living_count( AI.sq_ramp_phantom_2.spawn_points_0 ) == 1], 1);
SleepUntil([| 	ai_living_count( AI.sq_ramp_phantom_2.spawn_points_0 ) == 0 or 
				objects_distance_to_object( players_human(), AI.sq_ramp_phantom_2.spawn_points_0 ) < 60 and objects_can_see_object(players_human(), AI.sq_ramp_phantom_2.spawn_points_0, 5)], 1);
PrintNarrative("Narrative START - plateau_ramp_palacecombat_phantom_2");
KillScript( dormant.plateau_ramp_palacecombat_phantom_1 );
KillScript( dormant.plateau_ramp_palacecombat_phantom_3 );
KillScript( dormant.plateau_ramp_palacecombat_phantom_4 );

	if ai_living_count( AI.sq_ramp_phantom_2.spawn_points_0 ) == 1 then
		CreateThread(plateau_ramp_palacecombat_phantom);
	else
		PrintNarrative("Narrative CANCELED - plateau_ramp_palacecombat_phantom_2");	
	end
--
PrintNarrative("Narrative END - plateau_ramp_palacecombat_phantom_2");	
end


function dormant.plateau_ramp_palacecombat_phantom_3()
																					-- disabled - phantoms removed
SleepUntil([| ai_living_count( AI.sq_ramp_phantom_3.spawn_points_0 ) == 1], 1);
SleepUntil([| 	ai_living_count( AI.sq_ramp_phantom_3.spawn_points_0 ) == 0 or 
				objects_distance_to_object( players_human(), AI.sq_ramp_phantom_3.spawn_points_0 ) < 60 and objects_can_see_object(players_human(), AI.sq_ramp_phantom_3.spawn_points_0, 5)], 1);
PrintNarrative("Narrative START - plateau_ramp_palacecombat_phantom_3");
KillScript( dormant.plateau_ramp_palacecombat_phantom_1 );
KillScript( dormant.plateau_ramp_palacecombat_phantom_2 );
KillScript( dormant.plateau_ramp_palacecombat_phantom_4 );

	if ai_living_count( AI.sq_ramp_phantom_3.spawn_points_0 ) == 1 then
		CreateThread(plateau_ramp_palacecombat_phantom);
	else
		PrintNarrative("Narrative CANCELED - plateau_ramp_palacecombat_phantom_3");	
	end
--
PrintNarrative("Narrative END - plateau_ramp_palacecombat_phantom_3");	
end


function dormant.plateau_ramp_palacecombat_phantom_4()
																					-- disabled - phantoms removed
SleepUntil([| ai_living_count( AI.sq_ramp_phantom_4.spawn_points_0 ) == 1], 1);
SleepUntil([| 	ai_living_count( AI.sq_ramp_phantom_4.spawn_points_0 ) == 0 or 
				objects_distance_to_object( players_human(), AI.sq_ramp_phantom_4.spawn_points_0 ) < 60 and objects_can_see_object(players_human(), AI.sq_ramp_phantom_4.spawn_points_0, 5)], 1);
PrintNarrative("Narrative START - plateau_ramp_palacecombat_phantom_4");
KillScript( dormant.plateau_ramp_palacecombat_phantom_1 );
KillScript( dormant.plateau_ramp_palacecombat_phantom_2 );
KillScript( dormant.plateau_ramp_palacecombat_phantom_3 );
	
	if ai_living_count( AI.sq_ramp_phantom_4.spawn_points_0 ) == 1 then
		CreateThread(plateau_ramp_palacecombat_phantom);
	else
		PrintNarrative("Narrative CANCELED - plateau_ramp_palacecombat_phantom_4");	
	end
--
PrintNarrative("Narrative END - plateau_ramp_palacecombat_phantom_4");	
end




function plateau_ramp_palacecombat_phantom():void

PrintNarrative("Narrative START - plateau_ramp_palacecombat_phantom");
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_ramp_palacecombat_phantom", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_01300.sound'), false, nil, 0.0, "", "AIGoodwin : Osiris, there's a rather large number of phantoms in the area.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_04000.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Then we have their attention.", true );
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_02300.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : Sure sounds like it.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_02200.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Sure sounds like it.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);	
PrintNarrative("Narrative END - plateau_ramp_palacecombat_phantom");	
end

-- =================================================================================================


-- NEED TO REPLACE THE CONDITION DEPENDING ON WWHEN EXACTLY THE SENTRY SHIP IS GOING AWAY  ***********************************************************
-- 															WHEN THE SENTRY SHIP IS GOING AWAY BEHIND THE MOUNTAIN



-- 															WHEN THE SENTRY SHIP IS ALREADY GONE
function dormant.plateau_ramp_viewofthesentryship_gone()

SleepUntil([| volume_test_object( VOLUMES.plateau_ramp_viewofthesentryship_gone, OBJECTS.vin_sent_machine ) and not b_playerIsInBowl ], 1);

PrintNarrative("Narrative START - plateau_ramp_viewofthesentryship_gone");
				b_kill_prebowl_vo_playing = true;
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_ramp_viewofthesentryship_gone", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, (b_kill_prebowl_vo == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_01400.sound'), false, nil, 0.0, "", "AIGoodwin : Osiris, the Kraken is on the move.", true );
					dialog_line_npc( l_dialog_id, 0, (b_kill_prebowl_vo == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_02800.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : It's headed for the conduit. We have to beat it there.", true );
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_01500.sound'), false, nil, 0.0, "", "AIGoodwin : Indeed. ", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
				b_kill_prebowl_vo_playing = false;
PrintNarrative("Narrative END - plateau_ramp_viewofthesentryship_gone");

SleepUntil([| not object_index_valid( OBJECTS.vin_sent_machine) ], 1);
KillScript( dormant.plateau_ramp_nezik );

end


-- 															PASSING THE GATE TOWARDS THE BOWL
function dormant.plateau_ramp_recon_data_1()

SleepUntil([| volume_test_players(VOLUMES.plateau_ramp_stillonfoot)], 1);
PrintNarrative("Narrative START  -  plateau_oreobowl_recon_data_1 - wait");
SleepUntil([| ai_living_count( AI.sg_ramp_all ) == 0 and not b_playerIsInBowl ], 1);

PrintNarrative("Narrative START  -  plateau_oreobowl_recon_data_1");
sleep_real_seconds_NOT_QUITE_RELEASE(2);
			if not volume_test_players(VOLUMES.plateau_oreobowl_wake) then
				b_kill_prebowl_vo_playing = true;
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_recon_data_1", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);

						dialog_line_npc( l_dialog_id, 0, (b_kill_prebowl_vo == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_01600.sound'), false, nil, 0.0, "", "AIGoodwin : Looking at recon data, you're heading into the Procession Hall.", true );
					if	(not IsPlayer(SPARTANS.vale) and ai_combat_status(object_get_ai(SPARTANS.vale)) > 4 ) or 								-- If vale is a musketeer
						(IsPlayer(SPARTANS.vale) and objects_distance_to_object( SPARTANS.vale, ai_get_object(AI.gr_plat_all)) < 5) then		-- If vale is a player
--	VALE IN COMBAT
						dialog_line_npc( l_dialog_id, 0, (b_kill_prebowl_vo == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_10400.sound'), false, SPARTANS.vale, 0.0, "", "Vale : That's where the Vadam dead were paraded on their way to Tojinok.", true );
					else
--	VALE NOT IN COMBAT
						dialog_line_npc( l_dialog_id, 0, (b_kill_prebowl_vo == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_10300.sound'), false, SPARTANS.vale, 0.0, "", "Vale : That's where the Vadam dead were paraded on their way to Tojinok.", true );
					end

				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);				
				b_kill_prebowl_vo_playing = false;
			end
PrintNarrative("Narrative END  -  plateau_oreobowl_recon_data_1");
end


-- =================================================================================================
--   ____  _____  ______ ____    ____   ______          ___      
--  / __ \|  __ \|  ____/ __ \  |  _ \ / __ \ \        / / |     
-- | |  | | |__) | |__ | |  | | | |_) | |  | \ \  /\  / /| |     
-- | |  | |  _  /|  __|| |  | | |  _ <| |  | |\ \/  \/ / | |     
-- | |__| | | \ \| |___| |__| | | |_) | |__| | \  /\  /  | |____ 
--  \____/|_|  \_\______\____/  |____/ \____/   \/  \/   |______|
--                                                               
-- =================================================================================================

function dormant.plateau_oreobowl_wake()
SleepUntil([| volume_test_players(VOLUMES.plateau_oreobowl_wake) ], 1);
PrintNarrative("Narrative LOAD Oreo Bowl Scenes");

	b_playerIsInBowl = true;
	b_playerIsInDropdown = true;
	b_playerIsInHollow = true;
	b_playerIsInRamp = true;

KillScript( dormant.plateau_ramp_nezik );
	b_kill_prebowl_vo = true;
	if b_kill_prebowl_vo_playing == false then
		KillScript( dormant.plateau_ramp_recon_data_1 );
		KillScript( dormant.plateau_ramp_viewofthesentryship_gone );
	end
	

	
	Wake(dormant.plateau_oreobowl_recon_data_2);
	Wake(dormant.plateau_oreobowl_vista);
	
	Wake(dormant.plateau_oreobowl_vista_linger);
	

	Wake(dormant.plateau_oreobowl_right_side_caves);
	
	
	Wake(dormant.plateau_oreobowl_bridge_middle);
	Wake(dormant.plateau_oreobowl_secretexit_lookat);
	Wake(dormant.plateau_oreobowl_murder_alley);

	Wake(dormant.plateau_oreobowl_shield_emitter_lookat);
	Wake(dormant.plateau_oreobowl_shield_light_damage);
	Wake(dormant.plateau_oreobowl_shield_heavy_damage);
	Wake(dormant.plateau_oreobowl_shield_down);

	Wake(dormant.plateau_oreobowl_to_temple);
	

	Wake(dormant.plateau_oreobowl_wraith);	
	
	Wake(dormant.plateau_oreobowl_balcony_entrance);	
	Wake(dormant.plateau_oreobowl_balcony_entrance_grunt);	
	Wake(dormant.plateau_oreobowl_shield_button_look_at);	
	
	
SleepUntil([| volume_test_players(VOLUMES.plateau_oreobowl_vista)]);
sleep_real_seconds_NOT_QUITE_RELEASE(10);
	Wake(dormant.plateau_oreobowl_shield_still_up);	
	Wake(dormant.plateau_oreobowl_everybodydead);
	
end
-- =================================================================================================



-- 															PASSING THE GATE TOWARDS THE BOWL
function dormant.plateau_oreobowl_recon_data_2()
SleepUntil([| volume_test_players(VOLUMES.plateau_oreobowl_wake)  ], 1);

PrintNarrative("Narrative START  -  plateau_oreobowl_recon_data_2");
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_recon_data_2", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);

-- *********** We have an Alt with Tanaka, I could add a condition to trigger whoever is the closest.
					if	(not IsPlayer(SPARTANS.thorne) and ai_combat_status(object_get_ai(SPARTANS.thorne)) > 4 ) or 								-- If thorne is a musketeer
						(IsPlayer(SPARTANS.thorne) and objects_distance_to_object( SPARTANS.thorne, ai_get_object(AI.gr_plat_all)) < 5) then		-- If thorne is a player
--	thorne IN COMBAT
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_02500.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : How far past there to our objective?", true );
					else
--	thorne NOT IN COMBAT
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_02400.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : How far past there to our objective?", true );
					end				
					if	(not IsPlayer(SPARTANS.locke) and ai_combat_status(object_get_ai(SPARTANS.locke)) > 4 ) or 								-- If locke is a musketeer
						(IsPlayer(SPARTANS.locke) and objects_distance_to_object( SPARTANS.locke, ai_get_object(AI.gr_plat_all)) < 5) then		-- If locke is a player
--	locke IN COMBAT
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_04300.sound'), false, SPARTANS.locke, 0.0, "", "Locke : It's close. Be ready for this to get harder.", true );
					else
--	locke NOT IN COMBAT
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_04200.sound'), false, SPARTANS.locke, 0.0, "", "Locke : It's close. Be ready for this to get harder.", true );
					end	



				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);				
PrintNarrative("Narrative END  -  plateau_oreobowl_recon_data_2");
end


--CreateThread(dormant.plateau_oreobowl_vista)
-- 															SEEING THE BOWL, AT THE ENTRANCE
function dormant.plateau_oreobowl_vista()
SleepUntil([| volume_test_players(VOLUMES.plateau_oreobowl_vista)  ], 1);
PrintNarrative("Narrative START  -  plateau_oreobowl_vista");
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_vista", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
		if volume_test_object( VOLUMES.plateau_oreobowl_vista, SPARTANS.vale ) then
			dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_02800.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Look!", true );
		end
			dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_02900.sound'), false, SPARTANS.vale, 0.0, "", "Vale : There's the Procession Bridge! And statues of Vadam patriarchs!", true );
			dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_04400.sound'), false, SPARTANS.locke, 0, "", "Locke : Shooting now Vale, please! Sightseeing later?", true );
--			dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_10500.sound'), false, SPARTANS.vale, 0.5, "", "Vale : I can shoot and teach at the same time!", true );
			--dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_04500.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Great!", true );

--			dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_01700.sound'), false, nil, 0.0, "", "AIGoodwin : Osiris, the Conduit is past this valley I believe this is the Procession Bridge where fallen warriors -- (were shown to family.)", true );
--			dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_04600.sound'), false, SPARTANS.locke, 0.0, "", "Locke : The history lesson can wait, Goodwin.", true );
--			dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_01800.sound'), false, nil, 0.0, "", "AIGoodwin : Of course, Spartan Locke. Sorry to distract.", true );
		
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);				
				Wake(dormant.plateau_oreobowl_vista_linger_2);
sleep_real_seconds_NOT_QUITE_RELEASE(2);			
Wake(dormant.plateau_oreobowl_shield);
sleep_real_seconds_NOT_QUITE_RELEASE(5);
Wake(dormant.plateau_oreobowl_phantom_1);
Wake(dormant.plateau_oreobowl_phantom_2);
Wake(dormant.plateau_oreobowl_phantom_3);

PrintNarrative("Narrative END  -  plateau_oreobowl_vista");
end


function dormant.plateau_oreobowl_vista_linger()
SleepUntil([| ai_living_count(AI.sq_dp_struc_1.spawn_points_2) == 1 and volume_test_players(VOLUMES.plateau_oreobowl_vista) ], 5);
PrintNarrative("Narrative START  -  plateau_oreobowl_vista_linger");
sleep_real_seconds_NOT_QUITE_RELEASE(4);
	if ai_combat_status( AI.sq_dp_struc_1.spawn_points_2 ) < 3 then
				PrintNarrative("Narrative  -  plateau_oreobowl_vista_linger - Force the Elite to see the player because he stayed too long.");
				--cs_force_combat_status( AI.sq_dp_struc_1.spawn_points_2, 3 )
	elseif object_get_health(AI.sq_dp_struc_1.spawn_points_2) == 0 then
			PrintNarrative("Narrative CANCELED  -  plateau_oreobowl_vista_linger");
	end
PrintNarrative("Narrative END  -  plateau_oreobowl_vista_linger");
end


function dormant.plateau_oreobowl_vista_linger_2()
SleepUntil([| ai_combat_status( AI.gr_struc ) > 3   ], 10);
PrintNarrative("Narrative START  -  plateau_oreobowl_vista_linger_2");
--				local l_dialog_id:thread=def_dialog_id_none();
--				l_dialog_id = dialog_start_background("plateau_oreobowl_vista_linger", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);

--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite03_00600.sound'), false, ai_get_object(AI.sq_dp_struc_1.spawn_points_2), 0.0, "", "Elite03 : The infidels! Kill them!", true );
					PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_elite03_00600.sound'),  ai_get_object(AI.sq_dp_struc_1.spawn_points_2) );
					sleep_real_seconds_NOT_QUITE_RELEASE(1);
					
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt01_00600.sound'), false, ai_get_object(AI.sq_dp_struc_1_grunts.spawn_points_4), 0.0, "", "Grunt01 : The humans are here!", true );
					PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt01_00600.sound'),  ai_get_object(AI.sq_dp_struc_1_grunts.sleeper) );
					sleep_real_seconds_NOT_QUITE_RELEASE(1);

--				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
PrintNarrative("Narrative END  -  plateau_oreobowl_vista_linger_2");
end



-- 															WHEN LOOKING AT THE SHIELD	
function dormant.plateau_oreobowl_shield()
SleepUntil([| object_valid( "dp_powersupply_1" )], 1);
SleepUntil([| 	not object_valid( "dp_powersupply_1" ) or 
				objects_can_see_object(players_human(), OBJECTS.dp_powersupply_1, 10) or volume_test_players(VOLUMES.plateau_oreobowl_shield_limit)  ], 10);
PrintNarrative("Narrative START  -  plateau_oreobowl_shield");
	if object_valid( "dp_powersupply_1" ) then
				shield_vo_playing = true;
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_shield", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);

-- IF THORNE
--				if objects_can_see_object( SPARTANS.thorne, OBJECTS.dp_powersupply_1, 10 ) then
					
					dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_02600.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : There's a shield at the far end of the bridge.", true );
					dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_04700.sound'), false, SPARTANS.locke, 0.0, "", "Locke : That's where the Conduit is. Clear the way, Osiris!", true );
-- ELSEIF SOMEONE ELSE
--				elseif objects_can_see_object( players_human(), OBJECTS.dp_powersupply_1, 10 ) then
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_01900.sound'), false, nil, 0.0, "", "AIGoodwin : Osiris, there's a shield at the far end of the Procession Bridge.", true );
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_04700.sound'), false, SPARTANS.locke, 0.0, "", "Locke : That's where the Conduit is. Clear the way, Osiris!", true );
-- END IF
--				end
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);				
				shield_vo_playing = false;
		PrintNarrative("Narrative END  -  plateau_oreobowl_shield");
	elseif not object_valid( "dp_powersupply_1" ) then
		PrintNarrative("Narrative CANCELED  -  plateau_oreobowl_shield");
	end
end



-- =================================================================================================
-- PHANTOMS START
-- =================================================================================================

function dormant.plateau_oreobowl_phantom_1()
SleepUntil([| ai_living_count( AI.sq_dp_phantom_1.driver ) == 1], 5);
SleepUntil([| 	ai_living_count( AI.sq_dp_phantom_1.driver ) == 0 or 
				objects_distance_to_object( players_human(), AI.sq_dp_phantom_1.driver ) < 60 ], 10);
PrintNarrative("Narrative START - plateau_oreobowl_phantom_1");
KillScript( dormant.plateau_oreobowl_phantom_2 );
KillScript( dormant.plateau_oreobowl_phantom_3 );


	if ai_living_count( AI.sq_dp_phantom_1.driver ) == 1 then
		CreateThread(plateau_oreobowl_phantom);
	else
		PrintNarrative("Narrative CANCELED - plateau_oreobowl_phantom_1");	
	end

PrintNarrative("Narrative END - plateau_oreobowl_phantom_1");	
end

function dormant.plateau_oreobowl_phantom_2()
SleepUntil([| ai_living_count( AI.sq_dp_phantom_2.driver ) == 1], 1);
SleepUntil([| 	ai_living_count( AI.sq_dp_phantom_2.driver ) == 0 or 
				objects_distance_to_object( players_human(), AI.sq_dp_phantom_2.driver ) < 60 ], 1);
PrintNarrative("Narrative START - plateau_oreobowl_phantom_2");
KillScript( dormant.plateau_oreobowl_phantom_1 );
KillScript( dormant.plateau_oreobowl_phantom_3 );


	if ai_living_count( AI.sq_dp_phantom_2.driver ) == 1 then
		CreateThread(plateau_oreobowl_phantom);
	else
		PrintNarrative("Narrative CANCELED - plateau_oreobowl_phantom_2");	
	end

PrintNarrative("Narrative END - plateau_oreobowl_phantom_2");	
end


function dormant.plateau_oreobowl_phantom_3()
SleepUntil([| ai_living_count( AI.sq_dp_phantom_3.driver ) == 1], 1);
SleepUntil([| 	ai_living_count( AI.sq_dp_phantom_3.driver ) == 0 or 
				objects_distance_to_object( players_human(), AI.sq_dp_phantom_3.driver ) < 60 ], 1);
PrintNarrative("Narrative START - plateau_oreobowl_phantom_3");
KillScript( dormant.plateau_oreobowl_phantom_1 );
KillScript( dormant.plateau_oreobowl_phantom_2 );

	if ai_living_count( AI.sq_dp_phantom_3.driver ) == 1 then
		CreateThread(plateau_oreobowl_phantom);
	else
		PrintNarrative("Narrative CANCELED - plateau_oreobowl_phantom_3");	
	end

PrintNarrative("Narrative END - plateau_oreobowl_phantom_3");	
end

-- 															WHEN A SPARTAN SEES THE PHANTOM DROPING TROOPS IN THE BOWL
function plateau_oreobowl_phantom():void
PrintNarrative("Narrative START - plateau_oreobowl_phantom");
				sleep_real_seconds_NOT_QUITE_RELEASE(2);
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_phantom", l_dialog_id, true, def_dialog_style_queue(), false, "", 2);

					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_02000.sound'), false, nil, 0.0, "", "AIGoodwin : Osiris, I see enemy reinforcements are inbound.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_03100.sound'), false, SPARTANS.vale,-0.1, "", "Vale : More hostiles?", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_02700.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Must've seen their buddies getting their asses kicked, decided to get some too.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_03100.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : There's plenty to go around. ", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);	
PrintNarrative("Narrative END - plateau_oreobowl_phantom");	
end


-- PHANTOMS END
-- =================================================================================================




-- 															WHEN ENTERING THE SIDE CAVES
function dormant.plateau_oreobowl_right_side_caves()

SleepUntil([| volume_test_players(VOLUMES.plateau_oreo_bowl_veh_cave) ], 1);

PrintNarrative("Narrative START - plateau_oreobowl_right_side_caves");
				
-- IF LOCKE
				
				if volume_test_object(VOLUMES.plateau_oreo_bowl_veh_cave, SPARTANS.locke) == true then
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_right_side_caves_1", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_06000.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Visual on Ghosts. Caves by the statues.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_03600.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Hell yes! We can use those!", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);											
-- ELSEIF TANAKA
				elseif volume_test_object(VOLUMES.plateau_oreo_bowl_veh_cave, SPARTANS.tanaka) == true then
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_right_side_caves_2", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_03700.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Got some Ghosts in the caves beside the statues.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_06100.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Great Tanaka.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);											
-- ELSEIF VALE
				elseif volume_test_object(VOLUMES.plateau_oreo_bowl_veh_cave, SPARTANS.vale) == true then
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_right_side_caves_3", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);	
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_03500.sound'), false, SPARTANS.vale, 0.0, "", "Vale : I see Ghosts by the statues of Mak Vadam.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_06200.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Great Vale.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);											
-- ELSEIF THORNE
				elseif	volume_test_object(VOLUMES.plateau_oreo_bowl_veh_cave, SPARTANS.thorne) == true then
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_right_side_caves_4", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);	
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_03100.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Spotted some Ghosts in the caves by the statues.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_06400.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Great Buck.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);						
-- END IF
				end
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_right_side_caves_5", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_06500.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Osiris grab a ride if you want it.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);	
PrintNarrative("Narrative END - plateau_oreobowl_right_side_caves");
end





-- 															WHEN GOING UNDER THE BRIDGE IN THE MIDDLE SECTION
function dormant.plateau_oreobowl_bridge_middle()
SleepUntil([| volume_test_players(VOLUMES.plateau_oreobowl_bridge_middle)]);
PrintNarrative("Narrative START  -  plateau_oreobowl_bridge_middle");
				
-- IF LOCKE
				if volume_test_object(VOLUMES.plateau_oreobowl_bridge_middle, SPARTANS.locke) then
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_bridge_middle_1", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);	
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_06600.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Weapons and ammo where the bridge is collapsed.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_03800.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Good find Locke.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);									
-- ELSEIF TANAKA
				elseif volume_test_object(VOLUMES.plateau_oreobowl_bridge_middle, SPARTANS.tanaka) then
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_bridge_middle_2", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_03900.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Weapons and ammo under busted bridge.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_06700.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Nice find Tanaka.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);									
-- ELSEIF VALE
				elseif volume_test_object(VOLUMES.plateau_oreobowl_bridge_middle, SPARTANS.vale) then
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_bridge_middle_3", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_03600.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Anyone needs ammo there's plenty mid-field under the Procession Bridge.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_06800.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Nice find, Vale.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);									
-- ELSEIF THORNE
				elseif	volume_test_object(VOLUMES.plateau_oreobowl_bridge_middle, SPARTANS.thorne) then
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_bridge_middle_4", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_03300.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : Lots of ammo and gear under the collapsed bridge.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_03200.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Lots of ammo and gear under the collapsed bridge.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_07000.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Nice find Buck.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);								
-- END IF
				end
PrintNarrative("Narrative END  -  plateau_oreobowl_bridge_middle");
end


-- 															WHEN A PLAYER LOOK AT THE SECRET EXIT AND IS NEAR IT
function dormant.plateau_oreobowl_secretexit_lookat()
SleepUntil([| not b_bowl_everybody_is_dead_vo and volume_test_players_lookat(VOLUMES.plateau_oreobowl_secretexit_lookat, 4, 3) and volume_test_players(VOLUMES.plateau_oreobowl_secretexit) ], 1);
PrintNarrative("Narrative START - plateau_oreobowl_secretexit_lookat");
-- story_blurb_add("domain", "One player sees the Force Field Shield.");
				shield_vo_playing = true;
				
-- IF LOCKE
				if volume_test_player_lookat(VOLUMES.plateau_oreobowl_secretexit_lookat, unit_get_player(SPARTANS.locke), 5, 4) == true and volume_test_object(VOLUMES.plateau_oreobowl_secretexit, SPARTANS.locke ) then
					ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
					l_dialog_id = dialog_start_foreground("plateau_oreobowl_secretexit_lookat_1", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
						dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_07100.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Passageway under the shield.", true );
						dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_03700.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Yes! It's like sneaking in the side door.", true );
					l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);						
-- ELSEIF TANAKA
				elseif volume_test_player_lookat(VOLUMES.plateau_oreobowl_secretexit_lookat, unit_get_player(SPARTANS.tanaka), 15, 5) == true and volume_test_object(VOLUMES.plateau_oreobowl_secretexit, SPARTANS.tanaka )then
					ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
					l_dialog_id = dialog_start_foreground("plateau_oreobowl_secretexit_lookat_2", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
						dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_04000.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Passageway under the shield.", true );
						dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_07200.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Good eyes Tanaka.", true );
					l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
-- ELSEIF VALE
				elseif volume_test_player_lookat(VOLUMES.plateau_oreobowl_secretexit_lookat, unit_get_player(SPARTANS.vale), 15, 5) == true and volume_test_object(VOLUMES.plateau_oreobowl_secretexit, SPARTANS.vale )then
					ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
					l_dialog_id = dialog_start_foreground("plateau_oreobowl_secretexit_lookat_3", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
						dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_03800.sound'), false, SPARTANS.vale, 0.0, "", "Vale : There's a passageway under the shield.", true );
						dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_07300.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Good eyes Vale. ", true );
					l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
-- ELSEIF THORNE
				elseif	volume_test_player_lookat(VOLUMES.plateau_oreobowl_secretexit_lookat, unit_get_player(SPARTANS.thorne), 15, 5) == true and volume_test_object(VOLUMES.plateau_oreobowl_secretexit, SPARTANS.thorne )then
					ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
					l_dialog_id = dialog_start_foreground("plateau_oreobowl_secretexit_lookat_4", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
	--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_03400.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : Passageway under the shield.", true );
						dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_03300.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Passageway under the shield.", true );
						dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_07500.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Good eyes Buck.", true );
					l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);						
-- END IF
				end
				shield_vo_playing = false;
PrintNarrative("Narrative END - plateau_oreobowl_secretexit_lookat");
end



-- =================================================================================================
--		SHIELD START
-- =================================================================================================



-- 															WHEN SHOOTING WITH GUNS ON THE SHIELD AND NOT MAKING ENOUGH DAMAGE
function dormant.plateau_oreobowl_shield_light_damage()

SleepUntil([| object_valid( "dp_powersupply_1" )], 1);
SleepUntil([| 	not object_valid( "dp_powersupply_1" ) or
				object_get_health(OBJECTS.dp_powersupply_1) < 0.96 and volume_test_players_lookat(VOLUMES.plateau_oreobowl_shield_lookat, 40, 5) and not b_shield_light_damage], 1);
sleep_real_seconds_NOT_QUITE_RELEASE(0.5);
PrintNarrative("Narrative START - plateau_oreobowl_shield_light_damage");
	if object_valid( "dp_powersupply_1" ) and object_get_health(OBJECTS.dp_powersupply_1) > 0.93 then
		b_shield_light_damage = true;
		PrintNarrative("Narrative - Shield health = " .. object_get_health(OBJECTS.dp_powersupply_1));
				shield_vo_playing = true;
					ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
					l_dialog_id = dialog_start_foreground("plateau_oreobowl_shield_light_damage", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
	-- IF LOCKE
					if volume_test_player_lookat(VOLUMES.plateau_oreobowl_shield_lookat, SPARTANS.locke, 45, 5) then
						
						dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03100.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Shield's stronger than I thought. Focus fire!", true );
						dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_01900.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Roger that.", true );
	-- ELSEIF TANAKA
					elseif volume_test_player_lookat(VOLUMES.plateau_oreobowl_shield_lookat, SPARTANS.tanaka, 45, 5) then
						
						dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_02000.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : The shield's self-repairing.", true );
						dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03200.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Focus fire Osiris!", true );
	-- ELSEIF VALE
					elseif volume_test_player_lookat(VOLUMES.plateau_oreobowl_shield_lookat, SPARTANS.vale, 45, 5) then
						
						dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_02000.sound'), false, SPARTANS.vale, 0.0, "", "Vale : The shield's absorbing everything I've got!", true );
						dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03200.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Focus fire Osiris!", true );
	-- ELSEIF THORNE
					elseif	volume_test_player_lookat(VOLUMES.plateau_oreobowl_shield_lookat, SPARTANS.thorne, 45, 5) then
						
--						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_01500.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : Shield's too strong.", true );
						dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_01400.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Shield's too strong.", true );
						dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03200.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Focus fire Osiris!", true );
	-- END IF
					end
					l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);

			shield_vo_playing = false;
		PrintNarrative("Narrative END - plateau_oreobowl_shield_light_damage");
	else
		PrintNarrative("Narrative CANCELED - plateau_oreobowl_shield_light_damage");
	end

end




--  												SHOOTING ON THE SHIELD WITH heavy firepower
function dormant.plateau_oreobowl_shield_heavy_damage()
SleepUntil([| object_valid( "dp_powersupply_1" )], 1);
SleepUntil([| 	not object_valid( "dp_powersupply_1" ) or 
				object_get_health(OBJECTS.dp_powersupply_1)<0.8 and volume_test_players_lookat(VOLUMES.plateau_oreobowl_shield_lookat, 40, 3) ], 1);
PrintNarrative("Narrative START - plateau_oreobowl_shield_heavy_damage");
	if object_valid( "dp_powersupply_1" ) and object_get_health(OBJECTS.dp_powersupply_1)>0.1 then
		PrintNarrative("Narrative - Shield health = " .. object_get_health(OBJECTS.dp_powersupply_1));
		b_shield_heavy_damage = true;

				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_shield_heavy_damage", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
		-- IF LOCKE
--						if volume_test_player_lookat(VOLUMES.plateau_oreobowl_shield_lookat, SPARTANS.locke, 45, 5) and object_get_health(OBJECTS.dp_powersupply_1) > 0.3 then
							
--							dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03300.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Shield's starting to buckle!", true );
							
		-- ELSEIF TANAKA
--						elseif volume_test_player_lookat(VOLUMES.plateau_oreobowl_shield_lookat, SPARTANS.tanaka, 45, 5) and object_get_health(OBJECTS.dp_powersupply_1) > 0.3 then
							
--							dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_02100.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : This shield is toast!", true );
							
							
		-- ELSEIF VALE
--						elseif volume_test_player_lookat(VOLUMES.plateau_oreobowl_shield_lookat, SPARTANS.vale, 45, 5) and object_get_health(OBJECTS.dp_powersupply_1) > 0.3 then
							
--							dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_02100.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Shield's losing power!", true );

							
		-- ELSEIF THORNE
--						elseif	volume_test_player_lookat(VOLUMES.plateau_oreobowl_shield_lookat, SPARTANS.thorne, 45, 5) and object_get_health(OBJECTS.dp_powersupply_1) > 0.3 then
							
		--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_01600.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : Shield's losing power! Concentrate heavy fire!", true );
--							dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_01500.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Shield's losing power! Concentrate heavy fire!", true );
							
		-- END IF
--						end
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");

				PrintNarrative("Narrative END - plateau_oreobowl_shield_heavy_damage");
	else
				PrintNarrative("Narrative CANCELED - plateau_oreobowl_shield_heavy_damage");
	end
end



function dormant.plateau_oreobowl_shield_emitter_lookat()

--  												LOOKING AT THE EMITTER WEAK POINT
SleepUntil([| object_valid( "dp_powersupply_1" )], 1)
SleepUntil([| 	not object_valid( "dp_powersupply_1" ) or
				object_get_health(OBJECTS.dp_powersupply_1)>0.1 and volume_test_players(VOLUMES.plateau_oreobowl_secret_shield) and volume_test_players_lookat(VOLUMES.plateau_oreobowl_shield_emitter_lookat, 9, 2) ], 1);

PrintNarrative("Narrative START - plateau_oreobowl_shield_emitter_lookat");	
	if object_valid( "dp_powersupply_1" ) and object_get_health(OBJECTS.dp_powersupply_1)>0.1 then
				shield_vo_playing = true;					
				
-- IF LOCKE
				if volume_test_object(VOLUMES.plateau_oreobowl_secret_shield, SPARTANS.locke) and volume_test_player_lookat(VOLUMES.plateau_oreobowl_shield_emitter_lookat, unit_get_player(SPARTANS.locke), 10, 3) == true then
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_shield_emitter_lookat_1", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);	
					dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false) , TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03400.sound'), false, SPARTANS.locke, 0.0, "", "Locke : I have a shot on the shield generator.", true );
					dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false) , TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_02200.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Pop that the whole thing'll go.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);					
-- ELSEIF TANAKA
				elseif volume_test_object(VOLUMES.plateau_oreobowl_secret_shield, SPARTANS.tanaka) and volume_test_player_lookat(VOLUMES.plateau_oreobowl_shield_emitter_lookat,  unit_get_player(SPARTANS.tanaka), 10, 3) == true then
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_shield_emitter_lookat_2", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false) , TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_02300.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Got a shot on the shield generator.", true );
					dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false) , TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03500.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Take the shot Tanaka! ", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);					
-- ELSEIF VALE
				elseif volume_test_object(VOLUMES.plateau_oreobowl_secret_shield, SPARTANS.vale) and volume_test_player_lookat(VOLUMES.plateau_oreobowl_shield_emitter_lookat,  unit_get_player(SPARTANS.vale), 10, 3) == true then
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_shield_emitter_lookat_3", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false) , TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_02200.sound'), false, SPARTANS.vale, 0.0, "", "Vale : I have a shot on the shield generator.", true );
					dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false) , TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03600.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Take the shot Vale!", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);					
-- ELSEIF THORNE
				elseif	volume_test_object(VOLUMES.plateau_oreobowl_secret_shield, SPARTANS.thorne) and volume_test_player_lookat(VOLUMES.plateau_oreobowl_shield_emitter_lookat,  unit_get_player(SPARTANS.thorne), 10, 3) == true then
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_shield_emitter_lookat_4", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_01700.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : I have a shot on the shield generator.", true );
					dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false) , TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_01600.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : I got a shot at the shield generator.", true );
					dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false) , TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_03800.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Take the shot Thorne!", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);					
-- END IF
				end

				shield_vo_playing = false;
				PrintNarrative("Narrative END - plateau_oreobowl_shield_emitter_lookat");
	elseif not object_valid( "dp_powersupply_1" ) then
				PrintNarrative("Narrative CANCELED - plateau_oreobowl_shield_emitter_lookat");
	end
end

-- 															WHEN THE SHIELD IS DOWN
function dormant.plateau_oreobowl_shield_down()

SleepUntil([| object_valid( "dp_powersupply_1" )], 1);
SleepUntil([| object_get_health( OBJECTS.dp_powersupply_1 ) <= 0 ], 1);							--	WHEN the shield is Dead
	b_shield_is_down = true;

	if shield_vo_playing == false then
		KillScript( dormant.plateau_oreobowl_shield_emitter_lookat )
		KillScript( dormant.plateau_oreobowl_shield )
		KillScript( dormant.plateau_oreobowl_secretexit_lookat )
		KillScript( dormant.plateau_oreobowl_shield_light_damage )
		KillScript( dormant.plateau_oreobowl_shield_heavy_damage )
		KillScript( dormant.plateau_oreobowl_shield_still_up )
	end

SleepUntil([| objects_can_see_object( players_human(), OBJECTS.dp_powersupply_1, 20 )], 1);		--  WHEN someone is looking at it

PrintNarrative("Narrative START - plateau_oreobowl_shield_down");

-- IF SOMEONE LOOKS PRECISELY AT THE SHIELD IN PRIORITY, ONLY PLAYERS
		-- IF LOCKE
			if objects_can_see_object( SPARTANS.locke, OBJECTS.dp_powersupply_1, 25 ) then
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_shield_down_1", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
					PrintNarrative("Locke saw the Shield getting down");
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_09300.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Shield's down.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_03900.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Fantastic!", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);										
		-- ELSEIF TANAKA
			elseif IsPlayer( SPARTANS.tanaka ) and objects_can_see_object( SPARTANS.tanaka,OBJECTS.dp_powersupply_1 , 25 ) then
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_shield_down_2", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
					PrintNarrative("Tanaka saw the Shield getting down");
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_04900.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Shield's down.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_09500.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Perfect, Tanaka. ", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);										
		-- ELSEIF VALE
			elseif IsPlayer( SPARTANS.vale ) and objects_can_see_object( SPARTANS.vale,OBJECTS.dp_powersupply_1 , 25 ) then
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_shield_down_3", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
					PrintNarrative("Vale saw the Shield getting down");
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_04700.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Shield's down!", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_09600.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Perfect, Vale.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);										
		-- ELSEIF THORNE
			elseif IsPlayer( SPARTANS.thorne ) and objects_can_see_object( SPARTANS.thorne, OBJECTS.dp_powersupply_1, 25 ) then
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_shield_down_4", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
					PrintNarrative("Thorne saw the Shield getting down");
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_04000.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Shield's down!", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);										
--	**	NO LINES FOR LOCKE TO ANSWER BUCK
--  IF NO ONE IS LOOKING EXACTLY AT THE SHIELD, TEST WITH A WIDER DEGREE
		-- IF LOCKE
			elseif objects_can_see_object( SPARTANS.locke, OBJECTS.dp_powersupply_1, 40 ) then
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_shield_down_5", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
					PrintNarrative("Locke saw the Shield getting down");
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_09300.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Shield's down.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_03900.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Fantastic!", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);										
		-- ELSEIF TANAKA
			elseif objects_can_see_object( SPARTANS.tanaka,OBJECTS.dp_powersupply_1 , 40 ) then
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_shield_down_6", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
					PrintNarrative("Tanaka saw the Shield getting down");
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_04900.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Shield's down.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_09500.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Perfect, Tanaka. ", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);										
		-- ELSEIF VALE
			elseif objects_can_see_object( SPARTANS.vale,OBJECTS.dp_powersupply_1 , 40 ) then
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_shield_down_7", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
					PrintNarrative("Vale saw the Shield getting down");
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_04700.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Shield's down!", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_09600.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Perfect, Vale.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);										
		-- ELSEIF THORNE
			elseif objects_can_see_object( SPARTANS.thorne, OBJECTS.dp_powersupply_1, 40 ) then
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_shield_down_8", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
					PrintNarrative("Thorne saw the Shield getting down");
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_04000.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Shield's down!", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);										
				--	**	NO LINES FOR LOCKE TO ANSWER BUCK
--	IF NO ONE IS LOOKING AT THE SHIELD, A MUSKETEER WILL SAY SOMETHING		
			elseif not IsPlayer(SPARTANS.thorne) then
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_shield_down_9", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_04000.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Shield's down!", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);										
			elseif not IsPlayer(SPARTANS.tanaka) then
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_shield_down_10", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_04900.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Shield's down.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_09500.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Perfect, Tanaka. ", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);										
--	IF IT'S A 4 PLAYER CO OP GAME AND NO ONE IS LOOKING AT THE SHIELD, BUCK WILL SAY IT					
			else
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_shield_down_11", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_04000.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Shield's down!", true );					
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);					
-- END IF		
			end
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_shield_down_12", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_09400.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Move out Osiris!", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
PrintNarrative("Narrative END - plateau_oreobowl_shield_down");
end

--		SHIELD END
-- =================================================================================================


-- 															WHEN A PLAYER IS IN MURDER ALLEY AND LOST HEALTH
function dormant.plateau_oreobowl_murder_alley()
SleepUntil([| volume_test_players(VOLUMES.plateau_oreobowl_murder_alley)], 1);
  PROFILE.core.oreo_murder_alley = true;
SleepUntil([| 	(volume_test_object(VOLUMES.plateau_oreobowl_murder_alley, SPARTANS.locke) and object_get_health( SPARTANS.locke ) < 0.5) or
				(volume_test_object(VOLUMES.plateau_oreobowl_murder_alley, SPARTANS.tanaka) and object_get_health( SPARTANS.tanaka ) < 0.5) or 
				(volume_test_object(VOLUMES.plateau_oreobowl_murder_alley, SPARTANS.vale) and object_get_health( SPARTANS.vale ) < 0.5) or 
				(volume_test_object(VOLUMES.plateau_oreobowl_murder_alley, SPARTANS.thorne) and object_get_health( SPARTANS.thorne ) < 0.5)], 1);

PrintNarrative("Narrative START - plateau_oreobowl_murder_alley");
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_murder_alley", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
-- IF LOCKE
				if volume_test_object(VOLUMES.plateau_oreobowl_murder_alley, SPARTANS.locke) and object_get_health( SPARTANS.locke ) < 0.5 then
					
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_07600.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Need an assist at the bridge stairs!", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_03900.sound'), false, SPARTANS.vale, 0.0, "", "Vale : I'll see what I can do!", true );
					PROFILE.core.oreo_murder_alley_locke = true;
					
-- ELSEIF TANAKA
				elseif volume_test_object(VOLUMES.plateau_oreobowl_murder_alley, SPARTANS.tanaka) and object_get_health( SPARTANS.tanaka ) < 0.5 then
					
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_04100.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Need back up! Bridge stairs!", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_07700.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Hang in there, Tanaka!", true );
					 PROFILE.core.oreo_murder_alley_vale = true;
					
-- ELSEIF VALE
				elseif volume_test_object(VOLUMES.plateau_oreobowl_murder_alley, SPARTANS.vale) and object_get_health( SPARTANS.vale ) < 0.5 then
					
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_04000.sound'), false, SPARTANS.vale, 0.0, "", "Vale : I'm taking a lot of fire - Bridge stairs!", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_07800.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Hang in there, Vale!", true );
					PROFILE.core.oreo_murder_alley_vale = true;
-- ELSEIF THORNE
				elseif	volume_test_object(VOLUMES.plateau_oreobowl_murder_alley, SPARTANS.thorne) and object_get_health( SPARTANS.thorne ) < 0.5 then
					
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_03500.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : Osiris, I need backup - bridge stairs!", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_03400.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Osiris, I need backup - bridge stairs!", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_08000.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Buck! Hang in there!", true );
					PROFILE.core.oreo_murder_alley_buck = true;
-- END IF
				end
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
PrintNarrative("Narrative END - plateau_oreobowl_murder_alley");
end

-- =================================================================================================
--	WRAITH START
-- =================================================================================================


function dormant.plateau_oreobowl_wraith()
SleepUntil([| ai_living_count( AI.sq_dp_topwraith.spawn_points_1 ) == 1 ], 1);

SleepUntil([| 	ai_living_count( AI.sq_dp_topwraith.spawn_points_1 ) == 0 or 
				volume_test_players(VOLUMES.plateau_oreobowl_murder_alley) and (object_get_health(ai_get_object( AI.sq_dp_topwraith.spawn_points_1 )) > 0.2 and objects_distance_to_object( players_human(), ai_get_object( AI.sq_dp_topwraith.spawn_points_1 ) ) < 35 and objects_distance_to_object( players_human(), ai_get_object( AI.sq_dp_topwraith.spawn_points_1 ) ) > 5 and objects_can_see_object( players_human(), ai_get_object( AI.sq_dp_topwraith.spawn_points_1 ), 5 ) )], 1);
PrintNarrative("Narrative START - plateau_oreobowl_wraith");

		if ai_living_count( AI.sq_dp_topwraith.spawn_points_1 ) == 1 then
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_wraith", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
				
		
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_02400.sound'), false, nil, 0.0, "", "AIGoodwin : Osiris, I feel I should warn you about the wraith.", true );
					
					if object_get_health(ai_get_object( AI.sq_dp_topwraith.spawn_points_1 )) > 0.2 then
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_04200.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Could take it out.", true );
					end
					if object_get_health(ai_get_object( AI.sq_dp_topwraith.spawn_points_1 )) > 0.2 then
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_03500.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Or we could commandeer it.", true );
					end
					if object_get_health(ai_get_object( AI.sq_dp_topwraith.spawn_points_1 )) > 0.2 then
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_08200.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Those are both good suggestions.", true );
					end
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
				
				PrintNarrative("Narrative END - plateau_oreobowl_wraith");
		else
				PrintNarrative("Narrative CANCELED - plateau_oreobowl_wraith");
		end
end



--	WRAITH END
-- =================================================================================================


function dormant.plateau_oreobowl_shield_still_up()
SleepUntil([| object_valid( "dp_powersupply_1" )], 1);
sleep_real_seconds_NOT_QUITE_RELEASE(300);
SleepUntil([| 	not object_valid( "dp_powersupply_1" ) or 
				not b_bowl_everybody_is_dead_vo and object_get_health(OBJECTS.dp_powersupply_1)>0.8], 1);
PrintNarrative("Narrative START - plateau_oreobowl_shield_still_up");

		if object_valid( "dp_powersupply_1" ) then
					shield_vo_playing = true;
					ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
					l_dialog_id = dialog_start_foreground("plateau_oreobowl_shield_still_up", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
							if objects_distance_to_object( SPARTANS.tanaka, OBJECTS.dp_powersupply_1 ) < 100 and not b_playerIsInTemple then						-- If Tanaka is in the bowl but not past the shield.
									if  (not IsPlayer(SPARTANS.tanaka) and ai_combat_status(object_get_ai(SPARTANS.tanaka)) > 4 ) or								-- If tanaka is a musketeer
										(IsPlayer(SPARTANS.tanaka) and objects_distance_to_object( SPARTANS.tanaka, ai_get_object(AI.gr_plat_all)) < 15) then		-- If tanaka is a player
											PrintNarrative("	TANAKA IN COMBAT			");
												dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_04400.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Still have to get that shield down.", true );
									else
											PrintNarrative("	TANAKA OUT OF COMBAT		");
												dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_04500.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Still have to get that shield down.", true );
									end
									if 	(not IsPlayer(SPARTANS.thorne) and ai_combat_status(object_get_ai(SPARTANS.thorne)) > 4 ) or 								-- If thorne is a musketeer
										(IsPlayer(SPARTANS.thorne) and objects_distance_to_object( SPARTANS.thorne, ai_get_object(AI.gr_plat_all)) < 15) then		-- If thorne is a player
											PrintNarrative("	THORNE IN COMBAT			");
												dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_03700.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Agreed. But I wouldn't mind clearing the hostiles first.", true );
									else
											PrintNarrative("	LOCKE OUT OF COMBAT			");
												dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_08900.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Tanaka's right.", true );
									end
							elseif 	objects_distance_to_object( SPARTANS.tanaka, OBJECTS.dp_powersupply_1 ) >= 100 and not b_playerIsInTemple then	-- 	IF TANAKA IS NOT IN THE BOWL
									if objects_distance_to_object( SPARTANS.locke, ai_get_object(AI.gr_plat_all)) < 15 then							--  If THERE ARE ENEMIES NEAR LOCKE          We can't test combat status on player
											PrintNarrative("	GOODWIN IN COMBAT			");
												dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_02500.sound'), false, nil, 0.0, "", "AIGoodwin : Osiris, I notice the shield is still active.", true );
											PrintNarrative("	LOCKE IN COMBAT				");
												dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_09000.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Well aware of that, Goodwin. Working on it.", true );
									else
											PrintNarrative("	GOODWIN OUT OF COMBAT		");
												dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_02600.sound'), false, nil, 0.0, "", "AIGoodwin : Osiris, I notice the shield is still active.", true );
											PrintNarrative("	LOCKE OUT OF COMBAT			");																						--  IF NO ENEMIES NEAR LOCKE   therefore he's not in combat, I presume.
												dialog_line_npc( l_dialog_id, 0, (b_shield_is_down == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_09100.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Goodwin's got a point. Let's solve that.", true );
									end
							end
					l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
					shield_vo_playing = false;
		else 
			PrintNarrative("Narrative CANCELED - plateau_oreobowl_shield_still_up - Object not valid");
		end
				
				
PrintNarrative("Narrative END - plateau_oreobowl_shield_still_up");
end




-- 															WHEN ALMOST ALL ENEMIES IN THE BOWL ARE DEAD AND NO PLAYERS ENTERED THE TEMPLE
function dormant.plateau_oreobowl_everybodydead()

SleepUntil([| 	(ai_living_count( AI.gr_plat_all ) <= 0 and not b_playerIsInTemple) or 																									-- If all enemies are dead and player still not in temple
				(ai_living_count( AI.gr_plat_all ) < 5 and not b_playerIsInTemple and objects_distance_to_object( players_human(), ai_get_object(AI.gr_plat_all )) > 30)  ], 1);		-- If the minimum distance between player and enemies is 30 and player still not in temple (means that an enemy is hidden somewhere)
sleep_real_seconds_NOT_QUITE_RELEASE(10);
b_bowl_everybody_is_dead_vo = true;
PrintNarrative("Narrative START - plateau_oreobowl_everybodydead");
		if not b_playerIsInTemple then
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_everybodydead", l_dialog_id, true, def_dialog_style_queue(), true, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_04300.sound'), false, SPARTANS.vale, 0.0, "", "Vale : This place is bigger than I imagined. Vadam funeral processions must have been enormous events involving the entire Keep.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
		end
b_bowl_everybody_is_dead_vo = false;
PrintNarrative("Narrative END - plateau_oreobowl_everybodydead");
sleep_real_seconds_NOT_QUITE_RELEASE(6);
SleepUntil([| 	(ai_living_count( AI.gr_plat_all ) <= 0 and ai_living_count( AI.gr_firstfront ) <= 0 and ai_living_count( AI.gr_undertunnel ) <= 0 and not b_playerIsInTemple) or 																									-- If all enemies are dead and player still not in temple
				(ai_living_count( AI.gr_plat_all ) < 5 and not b_playerIsInTemple and objects_distance_to_object( players_human(), ai_get_object(AI.gr_plat_all )) > 30)  ], 1);		-- If the minimum distance between player and enemies is 30 and player still not in temple (means that an enemy is hidden somewhere)
--  	ai_living_count( AI.gr_firstfront )
sleep_real_seconds_NOT_QUITE_RELEASE(2);
b_bowl_everybody_is_dead_vo = true;
PrintNarrative("Narrative START - plateau_oreobowl_everybodydead_2");
		if not b_playerIsInTemple then
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_everybodydead_2", l_dialog_id, true, def_dialog_style_queue(), true, "", 0);
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_03900.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : Did you have to do anything besides being a warrior to get buried at the Conduit?", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_03800.sound'), false, SPARTANS.thorne, 0.3, "", "Buck : A fella have to do anything special to get buried at the Conduit?", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_04400.sound'), false, SPARTANS.vale, 0.3, "", "Vale : No. All the Vadam men are buried there.", true );
				if not b_playerIsInTemple then
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_04600.sound'), false, SPARTANS.tanaka, 0.3, "", "Tanaka : And the women?", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_04500.sound'), false, SPARTANS.vale, 0.3, "", "Vale : War is a man's job in Sangheili culture.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_04700.sound'), false, SPARTANS.tanaka, 0.3, "", "Tanaka : Well that's bull.", true );
				end
				if not b_playerIsInTemple then
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_04600.sound'), false, SPARTANS.vale, 0.3, "", "Vale : Maybe we'll inspire them Tanaka. Me and you.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_04800.sound'), false, SPARTANS.tanaka, 0.5, "", "Tanaka : (laughs) Rather not inspire anybody else on this planet to try'n kill humans.", true );
				end
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_09200.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Time's wasting, Osiris. Let's get moving for the Conduit.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
		elseif b_playerIsInTemple then
PrintNarrative("Narrative CANCELED - plateau_oreobowl_everybodydead_2 - Player already in Temple");		
		end
PrintNarrative("Narrative END - plateau_oreobowl_everybodydead_2");
b_bowl_everybody_is_dead_vo = false;
end


-- =================================================================================================
--		BALCONY
-- =================================================================================================


function dormant.plateau_oreobowl_balcony_entrance()
SleepUntil([| volume_test_players(VOLUMES.plateau_oreobowl_balcony_entrance) ], 1);
PrintNarrative("Narrative START - plateau_oreobowl_balcony_entrance");
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_balcony_entrance", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
-- IF LOCKE
				if volume_test_object(VOLUMES.plateau_oreobowl_balcony_entrance, SPARTANS.locke) then
					dialog_line_npc( l_dialog_id, 0, (b_balcony_killed == false) , TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_04800.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Found a side door.", true );
					dialog_line_npc( l_dialog_id, 0, (b_balcony_killed == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_02300.sound'), false, nil, 0.0, "", "AIGoodwin : This appears to lead to the balcony.", true );
-- ELSEIF TANAKA
				elseif volume_test_object(VOLUMES.plateau_oreobowl_balcony_entrance, SPARTANS.tanaka) then
					dialog_line_npc( l_dialog_id, 0, (b_balcony_killed == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_03200.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Here's a way up to the balcony.", true );
					dialog_line_npc( l_dialog_id, 0, (b_balcony_killed == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_04900.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Recon the balcony and report.", true );
-- ELSEIF VALE
				elseif volume_test_object(VOLUMES.plateau_oreobowl_balcony_entrance, SPARTANS.vale) then
					dialog_line_npc( l_dialog_id, 0, (b_balcony_killed == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_03200.sound'), false, SPARTANS.vale, 0.0, "", "Vale : I found a way to the balcony on top of the Hall of Mourning!", true );
					dialog_line_npc( l_dialog_id, 0, (b_balcony_killed == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_04900.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Recon the balcony and report.", true );
-- ELSEIF THORNE
				elseif	volume_test_object(VOLUMES.plateau_oreobowl_balcony_entrance, SPARTANS.thorne) then
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_02900.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : Over here! A way up to the balcony!", true );
					dialog_line_npc( l_dialog_id, 0, (b_balcony_killed == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_02800.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Over here! A way up to the balcony!", true );
					dialog_line_npc( l_dialog_id, 0, (b_balcony_killed == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_04900.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Recon the balcony and report.", true );
-- END IF
				end
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
PrintNarrative("Narrative END - plateau_oreobowl_balcony_entrance");
end


function dormant.plateau_oreobowl_balcony_entrance_grunt()
SleepUntil([| volume_test_players(VOLUMES.plateau_oreobowl_balcony_entrance) ], 1);
SleepUntil([| ai_combat_status( AI.sq_dp_leftcave.spawn_points_1 ) >= 3 and objects_can_see_object( players_human(), AI.sq_dp_leftcave.spawn_points_1, 25 ) and objects_distance_to_object( players_human(), AI.sq_dp_leftcave.spawn_points_1 ) < 10 ], 1);

PrintNarrative("Narrative START - plateau_oreobowl_balcony_entrance_grunt");
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_background("plateau_oreobowl_balcony_entrance_grunt", l_dialog_id, true, def_dialog_style_play(), false, "", 0);

--		GRUNT LINE
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_grunt04_00100.sound'), false, ai_get_object(AI.sq_dp_leftcave.spawn_points_1), 0.0, "", "Grunt04 : Get away! This isn't yours!", true );

				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
PrintNarrative("Narrative END - plateau_oreobowl_balcony_entrance_grunt");
end


--				WHEN PLAYER IS LOOKING AT THE PLASMA BATTERY
function dormant.plateau_oreobowl_shield_button_look_at()
SleepUntil([| volume_test_players_lookat(VOLUMES.plateau_oreobowl_shield_button_look_at, 8, 5 ) ], 1);
b_balcony_killed = true;
--KillScript( dormant.plateau_oreobowl_balcony_entrance );
PrintNarrative("Narrative START - plateau_oreobowl_shield_button_look_at");
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_shield_button_look_at", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
-- IF LOCKE
				if volume_test_player_lookat(VOLUMES.plateau_oreobowl_shield_button_look_at, SPARTANS.locke, 10, 5) == true then
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_05000.sound'), false, SPARTANS.locke, 0, "", "Locke : Plasma battery here.", true );
					if object_get_health(OBJECTS.dp_powersupply_1) > 0.2 then
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_03500.sound'), false, SPARTANS.tanaka, 0, "", "Tanaka : Could Hack that thing and cause some havoc.", true );
					end
					if object_get_health(OBJECTS.dp_powersupply_1) > 0.2 then
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_05100.sound'), false, SPARTANS.locke, 0.0, "", "Locke : I like the way you think Tanaka.", true );
					end
-- ELSEIF TANAKA
				elseif volume_test_player_lookat(VOLUMES.plateau_oreobowl_shield_button_look_at, SPARTANS.tanaka, 10, 5) == true then
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_03300.sound'), false, SPARTANS.tanaka, 0, "", "Tanaka : Found a plasma battery.", true );
					if object_get_health(OBJECTS.dp_powersupply_1) > 0.2 then
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_03500.sound'), false, SPARTANS.tanaka, 0, "", "Tanaka : Could Hack that thing and cause some havoc.", true );
					end
					if object_get_health(OBJECTS.dp_powersupply_1) > 0.2 then
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_05100.sound'), false, SPARTANS.locke, 0, "", "Locke : I like the way you think Tanaka.", true );
					end
					if object_get_health(OBJECTS.dp_powersupply_1) > 0.2 then
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_05400.sound'), false, SPARTANS.locke, 0, "", "Locke : Do it.", true );
					end
-- ELSEIF VALE
				elseif volume_test_player_lookat(VOLUMES.plateau_oreobowl_shield_button_look_at, SPARTANS.vale, 10, 5) == true then
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_03400.sound'), false, SPARTANS.vale, 0, "", "Vale : There's a plasma battery here!", true );
					if object_get_health(OBJECTS.dp_powersupply_1) > 0.2 then
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_03500.sound'), false, SPARTANS.tanaka, 0, "", "Tanaka : Could Hack that thing and cause some havoc.", true );
					end
					if object_get_health(OBJECTS.dp_powersupply_1) > 0.2 then
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_05100.sound'), false, SPARTANS.locke, 0, "", "Locke : I like the way you think Tanaka.", true );
					end
					if object_get_health(OBJECTS.dp_powersupply_1) > 0.2 then
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_05300.sound'), false, SPARTANS.locke, 0, "", "Locke : Hack it Vale.", true );
					end
-- ELSEIF THORNE
				elseif	volume_test_player_lookat(VOLUMES.plateau_oreobowl_shield_button_look_at, SPARTANS.thorne, 10, 5) == true then
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_03000.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : Got eyes on a plasma battery.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_02900.sound'), false, SPARTANS.thorne, 0, "", "Buck : Got eyes on a plasma battery.", true );
					if object_get_health(OBJECTS.dp_powersupply_1) > 0.2 then
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_03400.sound'), false, SPARTANS.tanaka, 0, "", "Tanaka : Could bust that thing and cause some havoc.", true );
					end
					if object_get_health(OBJECTS.dp_powersupply_1) > 0.2 then
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_05100.sound'), false, SPARTANS.locke, 0, "", "Locke : I like the way you think Tanaka.", true );
					end
					if object_get_health(OBJECTS.dp_powersupply_1) > 0.2 then
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_05800.sound'), false, SPARTANS.locke,0, "", "Locke : Hack it Buck.", true );
					end
-- END IF
				end
					
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
PrintNarrative("Narrative END - plateau_oreobowl_shield_button_look_at");
end


function plateau_oreobowl_shield_button():void
PrintNarrative("Narrative START - plateau_oreobowl_shield_button");
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_shield_button", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
--	IF LOCKE
				if volume_test_player_lookat(VOLUMES.plateau_oreobowl_shield_button_look_at, SPARTANS.locke, 5, 360 ) then
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_03000.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Hell of a light show boss!", true );
				else
--	IF ANYONE ELSE
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_05900.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Well done!", true );
				end
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
PrintNarrative("Narrative END - plateau_oreobowl_shield_button");
end

--		BALCONY
-- =================================================================================================



-- 															WHEN A PLAYER IS BEHIND THE SHIELD MOVING TOWARDS TEMPLE
function dormant.plateau_oreobowl_to_temple()
SleepUntil([| volume_test_players(VOLUMES.plateau_temple_wake) ], 1);
PrintNarrative("Narrative START - plateau_oreobowl_to_temple");
-- story_blurb_add("domain", "One player sees the Force Field Shield.");
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_oreobowl_to_temple", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
-- IF LOCKE
				if volume_test_object( VOLUMES.plateau_temple_wake, SPARTANS.locke ) then
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_02200.sound'), false, SPARTANS.locke, 0.0, "", "Locke : I've got a clear shot at the shield generator!", true );
-- ELSEIF TANAKA
				elseif volume_test_object( VOLUMES.plateau_temple_wake, SPARTANS.tanaka ) then
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_01100.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Behind the shield - got a shot on the generator!", true );
-- ELSEIF VALE
				elseif volume_test_object( VOLUMES.plateau_temple_wake, SPARTANS.vale ) then
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_01600.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Got eyes on the shield generator! Think I can destroy it.", true );
-- ELSEIF THORNE
				elseif	volume_test_object( VOLUMES.plateau_temple_wake, SPARTANS.thorne )  then
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_01300.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : I'm behind the shield - I can take the generator out!", true );
-- END IF
				end
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
PrintNarrative("Narrative END - plateau_oreobowl_to_temple");
end



-- =================================================================================================
--  _______ ______ __  __ _____  _      ______ 
-- |__   __|  ____|  \/  |  __ \| |    |  ____|
--    | |  | |__  | \  / | |__) | |    | |__   
--    | |  |  __| | |\/| |  ___/| |    |  __|  
--    | |  | |____| |  | | |    | |____| |____ 
--    |_|  |______|_|  |_|_|    |______|______|
--                                             
-- =================================================================================================

function dormant.plateau_temple_wake()
SleepUntil([| volume_test_players(VOLUMES.plateau_temple_wake) ], 1);
PrintNarrative("Narrative LOAD temple Scenes");
	Wake(dormant.plateau_temple_go_inside);
--	Wake(dormant.plateau_temple_entry);
--	Wake(dormant.plateau_temple_blocked);
--	Wake(dormant.plateau_temple_sagawall_vale);
--	Wake(dormant.plateau_temple_tracking);
	Wake(dormant.plateau_temple_tracking_shutter_both);
	
	b_playerIsInDropdown = true;
	b_playerIsInHollow = true;
	b_playerIsInRamp = true;
	b_playerIsInTemple = true;
	
	b_temple_first_ping_enable = true;
	
SleepUntil([| 	objects_distance_to_object( SPARTANS.locke, OBJECTS.dm_temple_door ) < 30 and
				objects_distance_to_object( SPARTANS.tanaka, OBJECTS.dm_temple_door ) < 30 and
				objects_distance_to_object( SPARTANS.vale, OBJECTS.dm_temple_door ) < 30 and
				objects_distance_to_object( SPARTANS.thorne, OBJECTS.dm_temple_door ) < 30 and 
				not b_playerIsInSentryBattle], 1);

-- CHATTER SPARTANS OFF
PrintNarrative("Narrative - Switch AI Chatter off");
ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false);
	 
	 
end

function dormant.plateau_temple_go_inside()
PrintNarrative("Narrative START - plateau_temple_go_inside");
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_temple_go_inside", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);	 
				
					if volume_test_object( VOLUMES.plateau_temple_wake, SPARTANS.thorne ) then
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_08200.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : I'm at the temple, gonna head inside. ", true );
					end
					
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
PrintNarrative("Narrative END - plateau_temple_go_inside");	 
end


--                                                    LOOKING AT THE EXIT DOOR, BLOCKED
function plateau_temple_blocked():void
--SleepUntil([| objects_distance_to_object( SPARTANS.vale, OBJECTS.dm_temple_door ) < 25  ], 1);
--sleep_real_seconds_NOT_QUITE_RELEASE(1);

				
PrintNarrative("Narrative START - plateau_temple_entry_vale");
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_temple_entry_vale", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_04800.sound'), false, SPARTANS.vale, 0.5, "", "Vale : It's a Sangheili lineage hall. ", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");

PrintNarrative("Narrative END - plateau_temple_entry_vale");


PrintNarrative("Narrative START - plateau_temple_blocked");

				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_temple_blocked", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_04900.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Tojinok should be right through here.", true );

--				if objects_distance_to_object( SPARTANS.tanaka, OBJECTS.dm_temple_door ) < 25 then		--	IF TANAKA IS PRESENT
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_05100.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Don't see a door anywhere.", true );
--				elseif objects_distance_to_object( SPARTANS.thorne, OBJECTS.dm_temple_door ) < 25 then	--	IF NOT TANAKA, THEN BUCK SAYS IT
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_04200.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : It's a dead-end. No kind of passage here at all.", true );
--				end
--	LOCKE LINE EVEN IF NOT THERE
					sleep_s(0.5);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_09800.sound'), false, SPARTANS.locke, 0.0, "", "Locke : They had to get to their burial pit somehow. Let's run an analysis of this location.", true );

--	LOCATION FOR TRACKING UI ELEMENT TUTORIAL

				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
				 


Wake(dormant.plateau_temple_entry_others);				

PrintNarrative("Narrative END - plateau_temple_blocked");
end



--                                          WHEN ENTERING THE TEMPLE
function dormant.plateau_temple_entry_others()
PrintNarrative("Narrative START - plateau_temple_entry_others");	
sleep_real_seconds_NOT_QUITE_RELEASE(2);
SleepUntil([| not b_temple_talking_about_a_clue ], 1);
		if b_temple_shutter_left and b_temple_shutter_right then 			-- If we found the 2 side murals, making sure that we are far away from the final mural to start a conversation
			SleepUntil([| not b_temple_talking_about_a_clue and objects_distance_to_object( players_human(), OBJECTS.dc_scan_mural_final ) > 10 ], 1);
		end
plateau_temple_tracking_chatter_timer(5);
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_temple_entry_others", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
				
						if objects_distance_to_object( SPARTANS.thorne, OBJECTS.dm_temple_door ) < 40 and  objects_distance_to_object( players_human(), OBJECTS.dm_temple_door ) > 10 and volume_test_objects_all( VOLUMES.plateau_temple_tracking_stay, players_human() ) then
--	THORNE line
					
							dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_04100.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : It feels somber here. Like you're supposed to whisper.", true );
						end
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
sleep_real_seconds_NOT_QUITE_RELEASE(2);										
SleepUntil([| not b_temple_talking_about_a_clue ], 1);						
plateau_temple_tracking_chatter_timer(17);
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_temple_entry_others_2", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);

						if objects_distance_to_object( SPARTANS.tanaka, OBJECTS.dm_temple_door ) < 40  and  objects_distance_to_object( players_human(), OBJECTS.dm_temple_door ) > 10 and volume_test_objects_all( VOLUMES.plateau_temple_tracking_stay, players_human() )  then
--	TANAKA line
													
							dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_05000.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Reminds me of a church.", true );
						end
				
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");

PrintNarrative("Narrative END - plateau_temple_entry_others");

Wake(dormant.plateau_temple_stay_0);

end



-- ADD WHEN LOOKING AT THE MURALS
function dormant.plateau_temple_stay_0()

plateau_temple_tracking_chatter_timer(30);


SleepUntil([| not b_playerIsInSentryBattle and not b_temple_talking_about_a_clue and volume_test_objects_all( VOLUMES.plateau_temple_tracking_stay, players_human() ) and not volume_test_players( VOLUMES.plateau_temple_tracking_shutter_read) ], 1);
PrintNarrative("Narrative START - plateau_temple_stay_0");
		if b_temple_shutter_left and  b_temple_shutter_right then 			-- If we found the 2 side murals, making sure that we are far away from the final mural to start a conversation
			SleepUntil([| not b_playerIsInSentryBattle and not b_temple_talking_about_a_clue and objects_distance_to_object( players_human(), OBJECTS.dc_scan_mural_final ) > 10 ], 1);
		end


		if not b_playerIsInSentryBattle and not b_playerIsInSentryBattle and objects_distance_to_object( SPARTANS.vale, OBJECTS.dm_temple_door ) < 35 and objects_distance_to_object( SPARTANS.tanaka, OBJECTS.dm_temple_door ) < 35 then
		b_temple_chatter_playing = true;
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_temple_stay_0", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, (b_temple_complete == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_05200.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : What's the artwork anyway?", true );
					dialog_line_npc( l_dialog_id, 0, (b_temple_complete == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_05000.sound'), false, SPARTANS.vale, 0.0, "", "Vale : These murals depict the exploits of the Vadam family patriarchs. This would be the last stop of the deceased before assuming their post below the Conduit.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
				PrintNarrative("Narrative END - plateau_temple_stay_0");
			b_temple_chatter_playing = false;
		elseif b_playerIsInSentryBattle then
				PrintNarrative("Narrative CANCELLED - plateau_temple_stay_0 - Player already in Sentry Battle area");
		end
Wake(dormant.plateau_temple_stay_1);
end
					

--                                  AFTER X TIME PASSES AND PLAYER STILL IN THE TEMPLE
--     ADD CONDITION IF VALE IS IN THE TEMPLE
function dormant.plateau_temple_stay_1()

plateau_temple_tracking_chatter_timer(30);

SleepUntil([| not b_playerIsInSentryBattle and not b_temple_talking_about_a_clue and volume_test_objects_all( VOLUMES.plateau_temple_tracking_stay, players_human() ) and not volume_test_players( VOLUMES.plateau_temple_tracking_shutter_read) ], 1);
PrintNarrative("Narrative START - plateau_temple_stay_1");
		if b_temple_shutter_left and b_temple_shutter_right then 			-- If we found the 2 side murals, making sure that we are far away from the final mural to start a conversation
			SleepUntil([| not b_playerIsInSentryBattle and not b_temple_talking_about_a_clue and objects_distance_to_object( players_human(), OBJECTS.dc_scan_mural_final ) > 10 ], 1);
		end
		
			if not b_playerIsInSentryBattle and not b_playerIsInSentryBattle and objects_distance_to_object( SPARTANS.thorne, OBJECTS.dm_temple_door ) < 35 and objects_distance_to_object( SPARTANS.locke, OBJECTS.dm_temple_door ) < 35 then
				b_temple_chatter_playing = true;
					local l_dialog_id:thread=def_dialog_id_none();
					l_dialog_id = dialog_start_foreground("plateau_temple_stay_1", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
	--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_04400.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : This place feels old.", true );
						dialog_line_npc( l_dialog_id, 0, (b_temple_complete == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_04300.sound'), false, SPARTANS.thorne, 1.1, "", "Buck : This place feels ancient.", true );
						dialog_line_npc( l_dialog_id, 0, (b_temple_complete == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_09900.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Yeah. Easily pre-dates the Sangheili joining the Covenant. ", true );
					l_dialog_id = dialog_end(l_dialog_id, true, true, "");
				b_temple_chatter_playing = false;
					PrintNarrative("Narrative END - plateau_temple_stay_1");
			elseif b_playerIsInSentryBattle then
					PrintNarrative("Narrative CANCELLED - plateau_temple_stay_1 - Player already in Sentry Battle area");
			end
		
Wake(dormant.plateau_temple_chatter_1);
end



function dormant.plateau_temple_chatter_1()

plateau_temple_tracking_chatter_timer(30);

SleepUntil([| not b_playerIsInSentryBattle and not b_temple_talking_about_a_clue and volume_test_objects_all( VOLUMES.plateau_temple_tracking_stay, players_human() ) and not volume_test_players( VOLUMES.plateau_temple_tracking_shutter_read )], 1);
		if b_temple_shutter_left and b_temple_shutter_right then 			-- If we found the 2 side murals, making sure that we are far away from the final mural to start a conversation
			SleepUntil([| not b_playerIsInSentryBattle and not b_temple_talking_about_a_clue and objects_distance_to_object( players_human(), OBJECTS.dc_scan_mural_final ) > 10 ], 1);
		end
PrintNarrative("Narrative START - plateau_temple_chatter_1");
		if not b_playerIsInSentryBattle then
				b_temple_chatter_playing = true;
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_temple_chatter_1a", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, (b_temple_complete == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_06000.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Creepy place.", true );
					dialog_line_npc( l_dialog_id, 0, (b_temple_complete == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_10900.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Vadam consecrated their dead here before tossing them at the base of Tojinok.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
				b_temple_chatter_playing = false;
SleepUntil([| not b_playerIsInSentryBattle and not b_temple_talking_about_a_clue ], 1);
				b_temple_chatter_playing = true;
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_temple_chatter_1b", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_05300.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : What exactly is the Conduit?", true );
					dialog_line_npc( l_dialog_id, 0, (b_temple_complete == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_05100.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : So what is this all-important conduit?", true );
					dialog_line_npc( l_dialog_id, 0, (b_temple_complete == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_11500.sound'), false, SPARTANS.locke, 0.0, "", "Locke : It's a piece of Forerunner architecture over a big open pit full of mist and corpses.", true );
					dialog_line_npc( l_dialog_id, 0, (b_temple_complete == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_07100.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Locke's being xenophobic.", true );
					dialog_line_npc( l_dialog_id, 0, (b_temple_complete == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_11600.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Locke's being a literalist.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
				b_temple_chatter_playing = false;
				PrintNarrative("Narrative END - plateau_temple_chatter_1");
		elseif b_playerIsInSentryBattle then
				PrintNarrative("Narrative CANCELLED - plateau_temple_chatter_1 - Player already in Sentry Battle area");
		end
Wake(dormant.plateau_temple_chatter_2);
end


--                                  AFTER X TIME PASSES AND PLAYER STILL IN THE TEMPLE AGAIN
function dormant.plateau_temple_chatter_2()

plateau_temple_tracking_chatter_timer(30);

SleepUntil([| not b_playerIsInSentryBattle and not b_temple_talking_about_a_clue and volume_test_objects_all( VOLUMES.plateau_temple_tracking_stay, players_human() ) and not volume_test_players( VOLUMES.plateau_temple_tracking_shutter_read ) ], 1);
		if b_temple_shutter_left and b_temple_shutter_right then 			-- If we found the 2 side murals, making sure that we are far away from the final mural to start a conversation
			SleepUntil([| not b_playerIsInSentryBattle and not b_temple_talking_about_a_clue and objects_distance_to_object( players_human(), OBJECTS.dc_scan_mural_final ) > 10 ], 1);
		end
PrintNarrative("Narrative START - plateau_temple_chatter_2");
		if not b_playerIsInSentryBattle and not b_playerIsInSentryBattle then
				b_temple_chatter_playing = true; 
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_temple_chatter_2a", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, (b_temple_complete == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_07200.sound'), false, SPARTANS.vale, 0.0, "", "Vale : So Locke, how do you know about the Conduit?", true );
					dialog_line_npc( l_dialog_id, 0, (b_temple_complete == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_11700.sound'), false, SPARTANS.locke, 0.0, "", "Locke : I compiled a target dossier on Arbiter just before the war ended. Learned everything I could.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
				b_temple_chatter_playing = false;
SleepUntil([| not b_playerIsInSentryBattle and not b_temple_talking_about_a_clue ], 1);					
				b_temple_chatter_playing = true;
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_temple_chatter_2b", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_05400.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : You were hunting him. Now you're helping him.", true );
					dialog_line_npc( l_dialog_id, 0, (b_temple_complete == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_09000.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : You were hunting him. But now you're helping him..", true );
					dialog_line_npc( l_dialog_id, 0, (b_temple_complete == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_11800.sound'), false, SPARTANS.locke, 0.0, "", "Locke : It's war. Things change.", true );
					dialog_line_npc( l_dialog_id, 0, (b_temple_complete == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_05300.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : That is one way of looking at life, yeah.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
				b_temple_chatter_playing = false;
				PrintNarrative("Narrative END - plateau_temple_chatter_2");
		elseif b_playerIsInSentryBattle then
				PrintNarrative("Narrative CANCELLED - plateau_temple_chatter_2 - Player already in Sentry Battle area");
		end
Wake(dormant.plateau_temple_chatter_3);
end


--                                  AFTER X TIME PASSES AND PLAYER STILL IN THE TEMPLE AGAIN
function dormant.plateau_temple_chatter_3()

plateau_temple_tracking_chatter_timer(30);

SleepUntil([| not b_playerIsInSentryBattle and not b_temple_talking_about_a_clue and volume_test_objects_all( VOLUMES.plateau_temple_tracking_stay, players_human() ) and not volume_test_players( VOLUMES.plateau_temple_tracking_shutter_read ) ], 1);
		if b_temple_shutter_left and b_temple_shutter_right then 			-- If we found the 2 side murals, making sure that we are far away from the final mural to start a conversation
			SleepUntil([| not b_playerIsInSentryBattle and not b_temple_talking_about_a_clue and objects_distance_to_object( players_human(), OBJECTS.dc_scan_mural_final ) > 10 ], 1);
		end
PrintNarrative("Narrative START - plateau_temple_chatter_3");
		if not b_playerIsInSentryBattle and not b_playerIsInSentryBattle and objects_distance_to_object( SPARTANS.tanaka, OBJECTS.dm_temple_door ) < 30 then
				b_temple_chatter_playing = true;
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_temple_chatter_2a", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, (b_temple_complete == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_06100.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Is it terrible to say they all look the same?", true );
					dialog_line_npc( l_dialog_id, 0, (b_temple_complete == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_07300.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Not at all. To the untrained human eye, it can be incredibly difficult. ", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
				b_temple_chatter_playing = false;
				PrintNarrative("Narrative END - plateau_temple_chatter_3");
		elseif b_playerIsInSentryBattle then
				PrintNarrative("Narrative CANCELLED - plateau_temple_chatter_3 - Player already in Sentry Battle area");
		end
end






function global_vo_random_found_something(spartan:object):void
PrintNarrative("Narrative START - global_vo_random_found_something");

		local random_VO_line:number = random_range(1,2);

				if g_display_narrative_debug_info then
					print("Random number is:", random_VO_line);
					print("spartan:", spartan );

				end

				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("glob`al_vo_random_found_something", l_dialog_id, true, def_dialog_style_queue(), false, "", 0.5);
		-- LOCKE
						if spartan == SPARTANS.locke then
							if random_VO_line == 1 then
								PrintNarrative("Locke plays lines 1")
								dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_10300.sound'), false, SPARTANS.locke, 0.0, "", "Locke : I found something over here.", true );
							end
							if random_VO_line == 2 then
								PrintNarrative("Locke plays lines 2")
								dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_10400.sound'), false, SPARTANS.locke, 0.0, "", "Locke : There's something over here.", true );
							end
		-- VALE				
						elseif spartan == SPARTANS.vale then
							if random_VO_line == 1 then
								PrintNarrative("vale plays lines 1")
								dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_05200.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Oh. I found something.", true );
							end
							if random_VO_line == 2 then
								PrintNarrative("vale plays lines 2")
								dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_05300.sound'), false, SPARTANS.vale, 0.0, "", "Vale : I found something here.", true );
							end
		-- TANAKA				
						elseif spartan == SPARTANS.tanaka then
							if random_VO_line == 1 then
								PrintNarrative("tanaka plays lines 1")
								dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_05300.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : What is this?", true );
							end
							if random_VO_line == 2 then
								PrintNarrative("tanaka plays lines 2")
								dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_05400.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Found something worth looking at.", true );
							end
		-- THORNE						
						elseif spartan == SPARTANS.thorne then
							if random_VO_line == 1 then
								PrintNarrative("thorne plays lines 1")
		--						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_04500.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : Have a look at this.", true );
								dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_04400.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Get a look at this.", true );
							end
							if random_VO_line == 2 then
								PrintNarrative("thorne plays lines 2")
								dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_04600.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : This might be something.", true );
							end
						end
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");


PrintNarrative("Narrative END - global_vo_random_found_something");
end



function plateau_temple_tracking_chatter_timer(timervalue:number):void
PrintNarrative("Narrative START - Reset Chatter Timer");
		
--	CHATTER TIMER START
		n_tracking_chatter_timer = timervalue;		--	Time buffer until this Chatter
		repeat
			sleep_real_seconds_NOT_QUITE_RELEASE(1);
			n_tracking_chatter_timer = n_tracking_chatter_timer - 1;
			print("Chatter Timer: ", n_tracking_chatter_timer);
		until n_tracking_chatter_timer <= 1;
--	CHATTER TIMER END

PrintNarrative("Narrative END - Reset Chatter Timer");
end



function plateau_temple_tracking_succesful_ping():void

	CreateThread(plateau_temple_tracking_succesful_ping_SleepSafe);
end


function plateau_temple_tracking_succesful_ping_SleepSafe():void

PrintNarrative("Narrative START - plateau_temple_tracking_succesful_ping");

n_tracking_chatter_timer = random_range( 20, 40 );					--		Reset the Chatter timer

		if b_temple_first_ping_enable then

				PrintNarrative("Kill dormant.plateau_temple_entry");
				b_temple_first_ping_enable= false;
				b_temple_talking_about_a_clue = true;

				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_temple_tracking_succesful_ping", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);

					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_02900.sound'), false, nil, 0.0, "", "AIGoodwin : I have spotted two intriguing items. There is a audio detection system and some ancient writing in the murals.", true );
----					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_10100.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Say the magic word.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_05100.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Writing? You think it's hints?", true );
----					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_03000.sound'), false, nil, 0.0, "", "AIGoodwin : One hopes so.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_10200.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Get some scans and translate.", true );
-- *********** THE ALT COMMENTED MAY BE BETTER ONCE THE AUDIO IS IN
----					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_08600.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Get some scans and translate.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");		

				sleep_real_seconds_NOT_QUITE_RELEASE(2);				

				b_temple_talking_about_a_clue = false;
		else
			PrintNarrative("Narrative CANCELED - plateau_temple_tracking_succesful_ping  -  Already Ping");
		end
		
--Wake(dormant.plateau_temple_nag_using_tracker);
		
PrintNarrative("Narrative END - plateau_temple_tracking_succesful_ping");
end



function plateau_temple_tracking_shutter_opening_reaction():void
PrintNarrative("Narrative START - plateau_temple_tracking_shutter_opening_reaction");
n_tracking_chatter_timer = random_range( 30, 40 );					--		Reset the Chatter timer
sleep_real_seconds_NOT_QUITE_RELEASE(2);		-- Delay for the sound of the shutter

		if 	(b_temple_shutter_left and not b_temple_shutter_right) or
			(not b_temple_shutter_left and b_temple_shutter_right) then
			
			if not (volume_test_players_lookat( VOLUMES.plateau_temple_tracking_shutter, 7, 5 ) and volume_test_players(VOLUMES.plateau_temple_tracking_shutter_read)) then
			
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_temple_tracking_shutter_opening_reaction", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_03200.sound'), false, nil, 0.0, "", "AIGoodwin : Your voice definitely activated something.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_10500.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Look around, Osiris.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
			
				b_temple_talking_about_a_clue = false;			
			end
			
		end
sleep_real_seconds_NOT_QUITE_RELEASE(2);				

PrintNarrative("Narrative END - plateau_temple_tracking_shutter_opening_reaction");
end


function plateau_temple_tracking_mural_left():void
PrintNarrative("Narrative START - plateau_temple_tracking_mural_left");
n_tracking_chatter_timer = random_range( 30, 40 );					--		Reset the Chatter timer
b_temple_talking_about_a_clue = true;
b_temple_shutter_left = true;


--	IF LOCKE FOUND THE CLUE WHILE TRACKING
				if IsPlayer( SPARTANS.locke ) and  objects_can_see_object( SPARTANS.locke, OBJECTS.dc_scan_mural_left, 15 ) and objects_are_within_distance_of_object(SPARTANS.locke, 12, OBJECTS.dc_scan_mural_left) then
						global_vo_random_found_something(SPARTANS.locke);
				end
--	IF TANAKA FOUND THE CLUE WHILE TRACKING				
				if IsPlayer( SPARTANS.tanaka ) and objects_can_see_object( SPARTANS.tanaka, OBJECTS.dc_scan_mural_left, 15 ) and objects_are_within_distance_of_object(SPARTANS.tanaka, 12, OBJECTS.dc_scan_mural_left) then
						global_vo_random_found_something(SPARTANS.tanaka);
				end
--	IF VALE FOUND THE CLUE WHILE TRACKING				
				if IsPlayer( SPARTANS.vale ) and objects_can_see_object( SPARTANS.vale, OBJECTS.dc_scan_mural_left, 15 ) and objects_are_within_distance_of_object(SPARTANS.vale, 12, OBJECTS.dc_scan_mural_left) then
						global_vo_random_found_something(SPARTANS.vale);
				end
--	IF BUCK FOUND THE CLUE WHILE TRACKING				
				if IsPlayer( SPARTANS.thorne ) and objects_can_see_object( SPARTANS.thorne, OBJECTS.dc_scan_mural_left, 15 ) and objects_are_within_distance_of_object(SPARTANS.thorne, 12, OBJECTS.dc_scan_mural_left) then
						global_vo_random_found_something(SPARTANS.thorne);
				end				
			

						local l_dialog_id:thread=def_dialog_id_none();
						l_dialog_id = dialog_start_foreground("plateau_temple_tracking_mural_left", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
							dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_05400.sound'), false, SPARTANS.vale, 0.0, "", "Vale : This one says: ", true );
							dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_11600.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Mee-kah-nohnee-toh-mohroo-zoo-hoh.", true );

						l_dialog_id = dialog_end(l_dialog_id, true, true, "");
				
		


Wake(dormant.plateau_temple_tracking_mural_left_english);
PrintNarrative("Narrative END - plateau_temple_tracking_mural_left");
	sleep_real_seconds_NOT_QUITE_RELEASE(4);
	Wake(dormant.plateau_temple_tracking_shutter_left);
	b_temple_talking_about_a_clue = false;
end




function dormant.plateau_temple_tracking_mural_left_english()
PrintNarrative("Narrative START - plateau_temple_tracking_mural_left_english");

				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_temple_tracking_mural_left_english", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
							dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_11700.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Here they serve at the feet of the gods. ", true );				
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
PrintNarrative("Narrative END - plateau_temple_tracking_mural_left_english");

end



--		IF PLAYER LOOK AT THE FINAL MURAL
function dormant.plateau_temple_tracking_shutter_left()
SleepUntil([| volume_test_players_lookat( VOLUMES.plateau_temple_tracking_shutter, 7, 5 ) and volume_test_players(VOLUMES.plateau_temple_tracking_shutter_read) and b_temple_shutter_left and not b_temple_talking_about_a_clue], 1);
b_temple_talking_about_a_clue = true;
n_tracking_chatter_timer = random_range( 30, 40 );					--		Reset the Chatter timer
PrintNarrative("Narrative START - plateau_temple_tracking_shutter_left");
		if b_temple_shutter_right == false then
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_temple_tracking_shutter_left", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);

--NOGOODWIN				if volume_test_player_lookat( VOLUMES.plateau_temple_tracking_shutter, unit_get_player( SPARTANS.vale ), 7, 7 ) then
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_05600.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Here! What is this... This is half a mural.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_10600.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Find a way to uncover the other half.", true );
--NOGOODWIN				else
--NOGOODWIN					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_03300.sound'), false, nil, 0.0, "", "AIGoodwin : Hmmm, this is only half a message.", true );
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_04700.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : If we look we could find a way to uncover the other half.", true );
--NOGOODWIN					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_04600.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : If we look around we might find a way to uncover the other half.", true );
--NOGOODWIN				end
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
		else
				PrintNarrative("Narrative CANCELED - plateau_temple_tracking_shutter_left - right shutter already open - Go to final");
		end
b_temple_talking_about_a_clue = false;
PrintNarrative("Narrative END - plateau_temple_tracking_shutter_left");
end



function plateau_temple_tracking_tracker_equiped_client():void

g_locke_tracker_equiped = false;
g_buck_tracker_equiped = false;
g_tanaka_tracker_equiped = false;
g_vale_tracker_equiped = false;	

		for key,value in pairs(players()) do
			print (key);
			if IsTrackerEquipped(value) then
			
				if key == 1 then 
					print("Locke is Tracker equipped");
					g_locke_tracker_equiped = true;
				end
				if key == 2 then 
					print("Buck is Tracker equipped");
					g_buck_tracker_equiped = true;
				end
				if key == 3 then 
					print("Tanaka is Tracker equipped");
					g_tanaka_tracker_equiped = true;
				end
				if key == 4 then 
					print("Vale is Tracker equipped");
					g_vale_tracker_equiped = true;
				end
			
			else
			
				print("Narr - Not Equipped", value);
				
			end
			
		end

print(g_locke_tracker_equiped);
print(g_buck_tracker_equiped)
print(g_tanaka_tracker_equiped)
print(g_vale_tracker_equiped)

		
end







function plateau_temple_tracking_mural_right():void
PrintNarrative("Narrative START - plateau_temple_tracking_mural_right");
n_tracking_chatter_timer = random_range( 30, 40 );					--		Reset the Chatter timer
b_temple_talking_about_a_clue = true;
b_temple_shutter_right = true;




--	IF LOCKE FOUND THE CLUE WHILE TRACKING
				if IsPlayer( SPARTANS.locke )and objects_can_see_object( SPARTANS.locke, OBJECTS.dc_scan_mural_right, 15 ) and objects_are_within_distance_of_object(SPARTANS.locke, 12, OBJECTS.dc_scan_mural_right) then
						global_vo_random_found_something(SPARTANS.locke);
				end
--	IF TANAKA FOUND THE CLUE WHILE TRACKING				
				if IsPlayer( SPARTANS.tanaka )and objects_can_see_object( SPARTANS.tanaka, OBJECTS.dc_scan_mural_right, 15 ) and objects_are_within_distance_of_object(SPARTANS.tanaka, 12, OBJECTS.dc_scan_mural_right) then
						global_vo_random_found_something(SPARTANS.tanaka);
				end
--	IF VALE FOUND THE CLUE WHILE TRACKING				
				if IsPlayer( SPARTANS.vale ) and objects_can_see_object( SPARTANS.vale, OBJECTS.dc_scan_mural_right, 15 ) and objects_are_within_distance_of_object(SPARTANS.vale, 12, OBJECTS.dc_scan_mural_right) then
						global_vo_random_found_something(SPARTANS.vale);
				end
--	IF BUCK FOUND THE CLUE WHILE TRACKING				
				if IsPlayer( SPARTANS.thorne ) and objects_can_see_object( SPARTANS.thorne, OBJECTS.dc_scan_mural_right, 15 ) and objects_are_within_distance_of_object(SPARTANS.thorne, 12, OBJECTS.dc_scan_mural_right) then
						global_vo_random_found_something(SPARTANS.thorne);
				end			
				

					local l_dialog_id:thread=def_dialog_id_none();
					l_dialog_id = dialog_start_foreground("plateau_temple_tracking_mural_right", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
--						global_vo_random_found_something(SPARTANS.vale);
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_05700.sound'), false, SPARTANS.vale, 0.0, "", "Vale : This one says.", true );
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_11800.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Chee-noh-ee. kyo-ee-say.  nnnoh-ee-eaygyoo-nn-joo.", true );

					l_dialog_id = dialog_end(l_dialog_id, true, true, "");



Wake(dormant.plateau_temple_tracking_mural_right_english);
PrintNarrative("Narrative END - plateau_temple_tracking_mural_right");
end


function dormant.plateau_temple_tracking_mural_right_english()
PrintNarrative("Narrative START - plateau_temple_tracking_mural_right_english");

				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_temple_tracking_mural_right_english", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_11900.sound'), false, SPARTANS.vale, 0.5, "", "Vale : Life. Death. Forever vigilant.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
PrintNarrative("Narrative END - plateau_temple_tracking_mural_right_english");


Wake(dormant.plateau_temple_tracking_shutter_right);
sleep_real_seconds_NOT_QUITE_RELEASE(2);
b_temple_talking_about_a_clue = false;
end


--		IF PLAYER LOOK AT THE FINAL MURAL
function dormant.plateau_temple_tracking_shutter_right()
SleepUntil([| volume_test_players_lookat( VOLUMES.plateau_temple_tracking_shutter, 7, 5 ) and volume_test_players(VOLUMES.plateau_temple_tracking_shutter_read) and b_temple_shutter_right and not b_temple_talking_about_a_clue ], 1);
b_temple_talking_about_a_clue = true;
n_tracking_chatter_timer = random_range( 30, 40 );					--		Reset the Chatter timer
PrintNarrative("Narrative START - plateau_temple_tracking_shutter_right");
		if b_temple_shutter_left == false then
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_temple_tracking_shutter_left", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);

--NOGOODWIN				if volume_test_player_lookat( VOLUMES.plateau_temple_tracking_shutter, unit_get_player( SPARTANS.vale ), 7, 7 ) then
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_05600.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Here! What is this... This is half a mural.", true );
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_10600.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Find a way to uncover the other half.", true );
--NOGOODWIN				else
--NOGOODWIN					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_03300.sound'), false, nil, 0.0, "", "AIGoodwin : Hmmm, this is only half a message.", true );
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_04700.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : If we look we could find a way to uncover the other half.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_04600.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : If we look around, we might find a way to uncover the other half.", true );
--NOGOODWIN				end
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
		else
				PrintNarrative("Narrative CANCELED - plateau_temple_tracking_shutter_right - left shutter already open - Go to final");
		end
sleep_real_seconds_NOT_QUITE_RELEASE(2);		
b_temple_talking_about_a_clue = false;
PrintNarrative("Narrative END - plateau_temple_tracking_shutter_right");
end



--		IF PLAYER LOOK AT THE FINAL MURAL
function dormant.plateau_temple_tracking_shutter_both()
SleepUntil([| volume_test_players_lookat( VOLUMES.plateau_temple_tracking_shutter, 9, 5 ) and volume_test_players(VOLUMES.plateau_temple_tracking_shutter_read) and b_temple_shutter_right and b_temple_shutter_left and not b_temple_talking_about_a_clue], 1);
b_temple_talking_about_a_clue = true;
n_tracking_chatter_timer = random_range( 30, 40 );					--		Reset the Chatter timer
PrintNarrative("Narrative START - plateau_temple_tracking_shutter_both");
		
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_temple_tracking_shutter_both", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);

						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_05900.sound'), false, SPARTANS.vale, 0.4, "", "Vale : Look at that. We're probably the first human beings to see this.", true );

					if volume_test_player_lookat( VOLUMES.plateau_temple_tracking_shutter, unit_get_player( SPARTANS.vale ), 10, 7 ) then
					

						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_10700.sound'), false, SPARTANS.locke, 0, "", "Locke : Vale go ahead and scan it.", true );
					else
--NOGOODWIN						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_03500.sound'), false, nil, 0, "", "AIGoodwin : Look at that. We're likely the first people outside the Vadam's inner circle to see this.", true );
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_10800.sound'), false, SPARTANS.locke, 0, "", "Locke : Let's scan it.", true );
					end
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
		
sleep_real_seconds_NOT_QUITE_RELEASE(2);
b_temple_talking_about_a_clue = false;		
PrintNarrative("Narrative END - plateau_temple_tracking_shutter_both");
end

-- AFTER SCANNING THE FINAL MURAL
function plateau_temple_tracking_mural_final():void
b_temple_talking_about_a_clue = true;
n_tracking_chatter_timer = random_range( 25, 40 );					--		Reset the Chatter timer
PrintNarrative("Narrative START - plateau_temple_tracking_mural_final");


--	IF LOCKE FOUND THE CLUE WHILE TRACKING
				if IsPlayer( SPARTANS.locke ) and IsTrackerEquipped( SPARTANS.locke ) and objects_can_see_object( SPARTANS.locke, OBJECTS.dc_scan_mural_final, 15 ) and objects_are_within_distance_of_object(SPARTANS.locke, 9, OBJECTS.dc_scan_mural_final) then
						global_vo_random_found_something(SPARTANS.locke);
				end
--	IF TANAKA FOUND THE CLUE WHILE TRACKING				
				if IsPlayer( SPARTANS.tanaka ) and IsTrackerEquipped( SPARTANS.tanaka ) and objects_can_see_object( SPARTANS.tanaka, OBJECTS.dc_scan_mural_final, 15 ) and objects_are_within_distance_of_object(SPARTANS.tanaka, 9, OBJECTS.dc_scan_mural_final) then
						global_vo_random_found_something(SPARTANS.tanaka);
				end
--	IF VALE FOUND THE CLUE WHILE TRACKING				
				if IsPlayer( SPARTANS.vale ) and IsTrackerEquipped( SPARTANS.vale ) and objects_can_see_object( SPARTANS.vale, OBJECTS.dc_scan_mural_final, 15 ) and objects_are_within_distance_of_object(SPARTANS.vale, 9, OBJECTS.dc_scan_mural_final) then
						global_vo_random_found_something(SPARTANS.vale);
				end
--	IF BUCK FOUND THE CLUE WHILE TRACKING				
				if IsPlayer( SPARTANS.thorne ) and IsTrackerEquipped( SPARTANS.thorne ) and objects_can_see_object( SPARTANS.thorne, OBJECTS.dc_scan_mural_final, 15 ) and objects_are_within_distance_of_object(SPARTANS.thorne, 9, OBJECTS.dc_scan_mural_final) then
						global_vo_random_found_something(SPARTANS.thorne);
				end			

				
				
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_temple_tracking_mural_final", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
				
--				if  volume_test_player_lookat( VOLUMES.plateau_temple_tracking_shutter, unit_get_player( SPARTANS.vale ), 7, 7 ) then
					
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_06000.sound'), false, SPARTANS.vale, 0.0, "", "Vale : The whole thing reads: Life. Death. Forever vigilant. Here they serve at the feet of the gods. Who is entitled to this honor?", true );
--				else
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_03600.sound'), false, nil, 0.0, "", "AIGoodwin : This entire scene reads as follows: Life. Death. Forever vigilant. Here they serve at the feet of the gods. Who is entitled to this honor? Hmmm. Poetic and intriguing.", true );
--				end
					
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_05500.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : So... who's entitled? You're the expert Vale.", true );
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_06100.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Entitled to honor... Their greatest hero was Ram Vadam founder of the first keep.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_10900.sound'), false, SPARTANS.locke, 0.0, "", "Locke : No. No one is entitled to honor. You earn honor. You aren't entitled to it.", true );
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_04800.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : So how do you say no one in Sangheili?", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_04700.sound'), false, SPARTANS.thorne, -0.0, "", "Buck : So how do you say no one in Sangheili?", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_06200.sound'), false, SPARTANS.vale, -0.0, "", "Vale : [No one.] nn-nee-moo", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
				
CreateThread(plateau_temple_tracking_opening);			

b_temple_talking_about_a_clue = false;		
PrintNarrative("Narrative END - plateau_temple_tracking_mural_final");
end



function plateau_temple_tracking_opening():void
PrintNarrative("Narrative START - plateau_temple_tracking_opening");
CreateThread(audio_plateau_temple_tracking_opening);
b_temple_talking_about_a_clue = true;
n_tracking_chatter_timer = random_range( 20, 40 );					--		Reset the Chatter timer

sleep_real_seconds_NOT_QUITE_RELEASE(1);

		local minimumDistanceFromDoor:number = objects_distance_to_object( spartans(), OBJECTS.dm_temple_door ) + 1;

--	print(minimumDistanceFromDoor);

	   		local l_dialog_id:thread=def_dialog_id_none();
			l_dialog_id = dialog_start_foreground("plateau_temple_tracking_opening", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
				if objects_distance_to_object( SPARTANS.locke, OBJECTS.dm_temple_door ) <= minimumDistanceFromDoor then 
					PrintNarrative("locke is the closest")
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_11000.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Something's happening.", true );
				elseif objects_distance_to_object( SPARTANS.vale, OBJECTS.dm_temple_door ) <= minimumDistanceFromDoor then 
					PrintNarrative("vale is the closest")
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_06300.sound'), false, SPARTANS.vale, 0.0, "", "Vale : It worked!", true );
				elseif objects_distance_to_object( SPARTANS.tanaka, OBJECTS.dm_temple_door ) <= minimumDistanceFromDoor then 
					PrintNarrative("tanaka is the closest")
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_05600.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Movement!", true );
				elseif objects_distance_to_object( SPARTANS.thorne, OBJECTS.dm_temple_door ) <= minimumDistanceFromDoor then 
					PrintNarrative("Buck is the closest")
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_04800.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Something activated.", true );
				end
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
Wake(dormant.plateau_temple_tracking_its_open);		
PrintNarrative("Narrative END - plateau_temple_tracking_opening");
end



function dormant.plateau_temple_tracking_its_open()
sleep_real_seconds_NOT_QUITE_RELEASE(8);
SleepUntil([| volume_test_players_lookat( VOLUMES.plateau_temple_secretdoor, 48, 4 ) ], 1);
PrintNarrative("Narrative START - plateau_temple_tracking_its_open");
--		story_blurb_add("domain", "Coming out of the cave, players see the Sentry Ship.");
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_temple_tracking_its_open", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
	-- IF LOCKE
					if volume_test_player_lookat( VOLUMES.plateau_temple_secretdoor, unit_get_player( SPARTANS.locke ), 50, 5 ) then

						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_11100.sound'), false, SPARTANS.locke, 0.3, "", "Locke : Looks clear.", true );
	-- ELSEIF TANAKA
					elseif volume_test_player_lookat( VOLUMES.plateau_temple_secretdoor, unit_get_player( SPARTANS.tanaka ), 50, 5 ) then

						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_05700.sound'), false, SPARTANS.tanaka, 0.3, "", "Tanaka : It's open.", true );
	-- ELSEIF VALE
					elseif volume_test_player_lookat( VOLUMES.plateau_temple_secretdoor, unit_get_player( SPARTANS.vale ), 50, 5 ) then

						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_06400.sound'), false, SPARTANS.vale, 0.3, "", "Vale : It worked!", true );
	-- ELSEIF THORNE
					elseif	volume_test_player_lookat( VOLUMES.plateau_temple_secretdoor, unit_get_player( SPARTANS.thorne ), 50, 5 ) then
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_04900.sound'), false, SPARTANS.thorne, 0.3, "", "Buck : It opened up!", true );
	-- END IF
					end
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_11200.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Osiris move out!", true );
sleep_real_seconds_NOT_QUITE_RELEASE(2);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_06500.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Locke, I see you're starting to get a hold of Sangheili culture.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_11300.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Or I just don't believe anyone is entitled to anything.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_06600.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Fair enough.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
sleep_real_seconds_NOT_QUITE_RELEASE(2);
b_temple_talking_about_a_clue = false;
PrintNarrative("Narrative END - plateau_temple_tracking_its_open");

SleepUntil([| volume_test_players(VOLUMES.plateau_sentrybattle_wake) ], 1);
PrintNarrative("Narrative - Kill Temple Chatter, player is going out towards the conduit.");
b_temple_complete = true;
sleep_s(3);
	if b_temple_chatter_playing == false then
		KillScript( dormant.plateau_temple_stay_0 );
		KillScript( dormant.plateau_temple_stay_1 );
		KillScript( dormant.plateau_temple_chatter_1 );
		KillScript( dormant.plateau_temple_chatter_2 );
		KillScript( dormant.plateau_temple_chatter_3 );
	end
end

-- =================================================================================================



-- =================================================================================================
--   _____ ______ _   _ _______ _______     __  ____       _______ _______ _      ______ 
--  / ____|  ____| \ | |__   __|  __ \ \   / / |  _ \   /\|__   __|__   __| |    |  ____|
-- | (___ | |__  |  \| |  | |  | |__) \ \_/ /  | |_) | /  \  | |     | |  | |    | |__   
--  \___ \|  __| | . ` |  | |  |  _  / \   /   |  _ < / /\ \ | |     | |  | |    |  __|  
--  ____) | |____| |\  |  | |  | | \ \  | |    | |_) / ____ \| |     | |  | |____| |____ 
-- |_____/|______|_| \_|  |_|  |_|  \_\ |_|    |____/_/    \_\_|     |_|  |______|______|
--                                                                                       
-- =================================================================================================

function dormant.plateau_sentrybattle_wake()
SleepUntil([| volume_test_players(VOLUMES.plateau_sentrybattle_wake) ], 1);
PrintNarrative("Narrative LOAD Sentry Battle Scenes");

	b_playerIsInDropdown = true;
	b_playerIsInHollow = true;
	b_playerIsInRamp = true;
	b_playerIsInTemple = true;
	b_playerIsInSentryBattle = true;
	
	b_nezik_can_speak = true;
	Wake(dormant.plateau_sentrybattle_corridor);
	Wake(dormant.plateau_sentrybattle_go_there);
	

	
	Wake(dormant.plateau_sentrybattle_vtolready);
	Wake(dormant.plateau_sentrybattle_gunner)


SleepUntil([| volume_test_players(VOLUMES.tv_plaza) ], 1);
sleep_real_seconds_NOT_QUITE_RELEASE(10);
	--print("WHAM BAM BAM BAM BAM BAM BAM BAM");
	
	Wake(dormant.plateau_sentrybattle_ship_landing);
	
	Wake(dormant.plateau_sentrybattle_ship_vent);

--	Wake(dormant.plateau_sentrybattle_legs_destroyed);
	Wake(dormant.plateau_sentrybattle_damaged_core);
	Wake(dormant.plateau_sentrybattle_ship_to_the_core);
	
	
	

	
	
end

--             WHEN APPROACHING THE SENTRY BATTLE AREA
function dormant.plateau_sentrybattle_corridor()
SleepUntil([| volume_test_players(VOLUMES.plateau_sentrybattle_wake) ], 1);
sleep_real_seconds_NOT_QUITE_RELEASE(1);
PrintNarrative("Narrative START - plateau_sentrybattle_corridor");
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentrybattle_corridor", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
-- IF VALE
--NOGOODWIN				if volume_test_object( VOLUMES.plateau_sentrybattle_wake, SPARTANS.vale ) then
					
					
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_11100.sound'), false, SPARTANS.vale, 0.0, "", "Vale : There it is: Tojinok. It's incredible isn't it?", true );
--NOGOODWIN					if objects_distance_to_object( SPARTANS.thorne, SPARTANS.vale ) < 15 then
						
						

				--		dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_09100.sound'), false, SPARTANS.tanaka, 0.0, "", "tanaka : It IS kind of beautiful, Vale.", true );
						
--NOGOODWIN					end
--NOGOODWIN					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_11900.sound'), false, SPARTANS.locke, 0.0, "", "Locke : The Guardian Constructor's over there.", true );
-- ELSEIF NOT VALE
--NOGOODWIN				else
--NOGOODWIN					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_03700.sound'), false, nil, 0.0, "", "AIGoodwin : Welcome to the Conduit of the Gods, Osiris. Quite a sight.", true );
--  *********** ADD CONDITION OF DISTANCE FOR THORNE


--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_12000.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Yes.", true );
--NOGOODWIN				end
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
			
				
PrintNarrative("Narrative END - plateau_sentrybattle_corridor");
end



--             WHEN APPROACHING THE SENTRY BATTLE AREA
function dormant.plateau_sentrybattle_go_there()
SleepUntil([| volume_test_players(VOLUMES.plateau_sentrybattle_vtol_start) ], 1);
PrintNarrative("Narrative START - plateau_sentrybattle_go_there");

				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentrybattle_go_there", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_05500.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : The Guardian Constructor's over there?", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_07500.sound'), false, SPARTANS.vale, 0.0, "", "Vale : It'd be a heck of a climb.", true );

					dialog_line_npc( l_dialog_id, 0, (b_reaction_to_kraken == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_12100.sound'), false, SPARTANS.locke, 0.0, "", "Locke : I'd prefer something a bit safer.", true );
					sleep_real_seconds_NOT_QUITE_RELEASE(0.5);
					dialog_line_npc( l_dialog_id, 0, (b_reaction_to_kraken == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_05600.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Right, yeah. Forgot we were safety first today.", true );

				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
sleep_real_seconds_NOT_QUITE_RELEASE(2);
PrintNarrative("Narrative - Force Kraken Reaction from Musketeer");

PrintNarrative("Narrative END - plateau_sentrybattle_go_there");
end


function dormant.plateau_sentrybattle_sentryship_appear_look_at()
SleepUntil([| object_index_valid( OBJECTS.vin_sent_machine_2 ) and objects_distance_to_object( players_human(), OBJECTS.vin_sent_machine_2 ) < 175 or objects_can_see_object( players_human(), OBJECTS.vin_sent_machine_2, 50 ) or b_sentry_horn_2], 1);
PrintNarrative("Narrative START  -  plateau_sentrybattle_sentryship_appear_look_at");
b_reaction_to_kraken = true;
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentryreveal_entrancetospaceandsentryship_lookat_liftoff_team", l_dialog_id, true, def_dialog_style_interrupt_all(), false, "", 0);
	-- IF LOCKE
					if objects_can_see_object( SPARTANS.locke, OBJECTS.vin_sent_machine_2, 50 ) then
						
						dialog_line_npc( l_dialog_id, 0, (sentrybattle_ship_kill == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_02200.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Kraken!", true );
	-- ELSEIF TANAKA
					elseif 	IsPlayer(SPARTANS.tanaka) and objects_can_see_object( SPARTANS.tanaka, OBJECTS.vin_sent_machine_2, 50 ) or
							b_reaction_to_kraken and not IsPlayer(SPARTANS.tanaka) and volume_test_object(VOLUMES.plateau_sentrybattle_vtol_start, SPARTANS.tanaka ) then
						
						dialog_line_npc( l_dialog_id, 0, (sentrybattle_ship_kill == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_01300.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Kraken!", true );
	-- ELSEIF VALE
					elseif IsPlayer(SPARTANS.vale) and objects_can_see_object( SPARTANS.vale, OBJECTS.vin_sent_machine_2, 50 ) or 
							b_reaction_to_kraken and not IsPlayer(SPARTANS.vale) and volume_test_object(VOLUMES.plateau_sentrybattle_vtol_start, SPARTANS.vale ) then
						
						dialog_line_npc( l_dialog_id, 0, (sentrybattle_ship_kill == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_01200.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Kraken!", true );
	-- ELSEIF THORNE
					elseif	IsPlayer(SPARTANS.thorne) and objects_can_see_object( SPARTANS.thorne, OBJECTS.vin_sent_machine_2, 50 ) or
							b_reaction_to_kraken and not IsPlayer(SPARTANS.thorne) and volume_test_object(VOLUMES.plateau_sentrybattle_vtol_start, SPARTANS.thorne ) then

						dialog_line_npc( l_dialog_id, 0, (sentrybattle_ship_kill == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_00800.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Kraken!", true );
	-- END IF
					end
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
RunClientScript("horn_3d_bis_client");
Wake(dormant.plateau_sentrybattle_sentryship_appear);				
				
PrintNarrative("Narrative END  -  plateau_sentrybattle_sentryship_appear_look_at");

end

--             WHEN SENTRY SHIP APPEARS
function dormant.plateau_sentrybattle_sentryship_appear()

PrintNarrative("Narrative START - plateau_sentrybattle_sentryship_appear");

				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentrybattle_sentryship_appear", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_03900.sound'), false, nil, 0.0, "", "AIGoodwin : Osiris! The Kraken!", true );
-- IF LOCKE
				if volume_test_object(VOLUMES.plateau_sentrybattle_vtol_start, SPARTANS.locke) then
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_12200.sound'), false, SPARTANS.locke, -0.2, "", "Locke : Form up!", true );
				end
-- IF THORNE IS PRESENT
				if volume_test_object(VOLUMES.plateau_sentrybattle_vtol_start, SPARTANS.thorne) then
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_05800.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : Ready!", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_05700.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Ready!", true );
				end	
-- IF VALE IS PRESENT
				if volume_test_object(VOLUMES.plateau_sentrybattle_vtol_start, SPARTANS.vale) then
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_07600.sound'), false, SPARTANS.vale, 1, "", "Vale : Here it comes!", true );
				end
-- IF TANAKA IS PRESENT
				if volume_test_object(VOLUMES.plateau_sentrybattle_vtol_start, SPARTANS.tanaka) then
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_06200.sound'), false, SPARTANS.tanaka, 0, "", "Tanaka : This day. I swear.", true );
				end
				
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
PrintNarrative("Narrative END - plateau_sentrybattle_sentryship_appear");

	-- CHATTER SPARTANS ON
	PrintNarrative("Narrative - Switch AI Chatter On");
	ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
	
end




--              WHEN THE VTOLS ARE SPAWNING
function dormant.plateau_sentrybattle_vtolready()
SleepUntil([| 	(object_valid( "vtol1" ) or object_valid( "vtol2" )) or 
				(object_valid( "vtol1b" ) or object_valid( "vtol2b" ))], 1);
				
--KillScript( dormant.plateau_sentrybattle_sentryship_appear);
sentrybattle_ship_kill = true;
sleep_real_seconds_NOT_QUITE_RELEASE(1);
PrintNarrative("Narrative START - plateau_sentrybattle_vtolready");

				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentrybattle_vtolready", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);

--	IF THORNE IS PRESENT
					
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_08600.sound'), false, SPARTANS.locke, 0.0, "", "Buck :Something activated the Forerunner vehicles. I say we take advantage.", true );
					
--	IF TANAKA IS PRESENT
					
						dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_06400.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Forerunners had a knack for planning ahead.", true );
					
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);

Wake(dormant.plateau_sentrybattle_vtolready_lift_off);
Wake(dormant.plateau_sentrybattle_vtolready_nag);
--Wake(dormant.plateau_sentrybattle_gunner);

PrintNarrative("Narrative END - plateau_sentrybattle_vtolready");

end


--               IF PLAYER DIDN'T TOOK THE VTOLS AFTER A WHILE
function dormant.plateau_sentrybattle_vtolready_nag()
	local l_vtolnag_vale:boolean=false;
	local l_vtolnag_locke:boolean=false;
sleep_real_seconds_NOT_QUITE_RELEASE(30);
PrintNarrative("Narrative START - plateau_sentrybattle_vtolready_nag");
plateau_sentrybattle_what_vtols()																					-- Are player in Vtols
		if not b_player_in_vtol1 and not b_player_in_vtol2 and not b_player_in_vtol1b and not b_player_in_vtol2b and volume_test_players(VOLUMES.plateau_sentrybattle_vtol_start) then
						 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
						l_dialog_id = dialog_start_foreground("plateau_sentrybattle_vtolready_nag", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
						if volume_test_object(VOLUMES.plateau_sentrybattle_vtol_start, SPARTANS.locke) then
							dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_15700.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Phaetons here. Let's get airbourne.", true );
							l_vtolnag_locke =true;
						elseif	volume_test_object(VOLUMES.plateau_sentrybattle_vtol_start, SPARTANS.vale) then
							dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_11200.sound'), false, SPARTANS.vale, 0.0, "", "Vale : There's Phaetons here. We can use these to attack the Kraken.", true );
							dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_12400.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Get airborne Osiris! We're taking the fight to them!", true );
							l_vtolnag_vale = true;
						else
							dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_04100.sound'), false, nil, 0.0, "", "AIGoodwin : You'll want to access those Phaetons, Osiris. Soon as possible, one would imagine.", true );
							dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_12400.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Get airborne Osiris! We're taking the fight to them!", true );
						end
						
				if volume_test_object(VOLUMES.plateau_sentrybattle_vtol_start, SPARTANS.tanaka) then
							
							dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_06500.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Affirmative. Saddle up.", true );
				end
						l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
		else
		PrintNarrative("Narrative CANCELLED - plateau_sentrybattle_vtolready_nag  -  Player already in vehicle");
		end 
		PrintNarrative("Narrative END - plateau_sentrybattle_vtolready_nag");
		
sleep_real_seconds_NOT_QUITE_RELEASE(30);
--               IF PLAYER STILL DIDN'T TOOK THE VTOLS AFTER A LONGER WHILE		
PrintNarrative("Narrative START - plateau_sentrybattle_vtolready_nag2");
plateau_sentrybattle_what_vtols()	
		if not b_player_in_vtol1 and not b_player_in_vtol2 and not b_player_in_vtol1b and not b_player_in_vtol2b and volume_test_players(VOLUMES.plateau_sentrybattle_vtol_start) then
						ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
						l_dialog_id = dialog_start_foreground("plateau_sentrybattle_vtolready_nag", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
						if not l_vtolnag_locke and volume_test_object(VOLUMES.plateau_sentrybattle_vtol_start, SPARTANS.locke) then		-- If Locke wasn't the one talking about the VTOLS earlier
							dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_15700.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Phaetons here. Let's get airbourne.", true );
						elseif not l_vtolnag_vale and volume_test_object(VOLUMES.plateau_sentrybattle_vtol_start, SPARTANS.vale) then	-- If Vale wasn't the one talking about the VTOLS earlier
							dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_11200.sound'), false, SPARTANS.vale, 0.0, "", "Vale : There's Phaetons here. We can use these to attack the Kraken.", true );
							if l_vtolnag_locke then		--	If Locke was the one talking about VTOL earlier, then we didn't use his answer yet. we can use it here.
								dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_12400.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Get airborne Osiris! We're taking the fight to them!", true );
							end
						else
							dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_04200.sound'), false, nil, 0.0, "", "AIGoodwin : Spartan Locke? As a tactical suggestion, perhaps Osiris should consider getting airborne?", true );
						end
							
						l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
		elseif player_in_vehicle( OBJECTS.vtol1 ) or player_in_vehicle( OBJECTS.vtol2 ) then
		PrintNarrative("Narrative CANCELLED - plateau_sentrybattle_vtolready_nag2 - Player already in vehicle");
		end
		PrintNarrative("Narrative END - plateau_sentrybattle_vtolready_nag2");
		
end



--               IF PLAYER STILL DIDN'T TOOK THE VTOLS AFTER A LONGER WHILE
function dormant.plateau_sentrybattle_vtolready_lift_off()
SleepUntil([| 	(unit_in_vehicle(SPARTANS[1]) and unit_in_vehicle(SPARTANS[2]) and unit_in_vehicle(SPARTANS[3]) and unit_in_vehicle(SPARTANS[4]) and volume_test_players_all(VOLUMES.plateau_sentrybattle_vtol_start)) or 
				(unit_in_vehicle(SPARTANS[1]) and not IsPlayer(SPARTANS.vale) and not IsPlayer(SPARTANS.thorne) and not IsPlayer(SPARTANS.tanaka) and volume_test_players_all(VOLUMES.plateau_sentrybattle_vtol_start))], 1);
PrintNarrative("Narrative START - plateau_sentrybattle_vtolready_lift_off");
						 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
						l_dialog_id = dialog_start_foreground("plateau_sentrybattle_vtolready_nag", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
							dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_12500.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Here we go Osiris!", true );
						l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);

PrintNarrative("Narrative END - plateau_sentrybattle_vtolready_lift_off");
end




function plateau_sentrybattle_what_vtols():void
PrintNarrative("Narrative START - plateau_sentrybattle_what_vtols");

		b_player_in_vtol1 = false;
		b_player_in_vtol2 = false;
		b_player_in_vtol1b = false;
		b_player_in_vtol2b = false;
	
		if object_valid( "vtol1" ) then
			print("vtol1 present");
			if player_in_vehicle( OBJECTS.vtol1 )
				then b_player_in_vtol1 = true;
				else b_player_in_vtol1 = false;
			end
		end
		if object_valid( "vtol2" ) then
			print("vtol2 present");
			if player_in_vehicle( OBJECTS.vtol2 )
				then b_player_in_vtol2 = true;
				else b_player_in_vtol2 = false;
			end
		end
		if object_valid( "vtol1b" ) then
			print("vtol1b present");
			if player_in_vehicle( OBJECTS.vtol1b )
				then b_player_in_vtol1b = true;
				else b_player_in_vtol1b = false;
			end
		end
		if object_valid( "vtol2b" ) then
			print("vtol2b present");
			if player_in_vehicle( OBJECTS.vtol2b )
				then b_player_in_vtol2b = true;
				else b_player_in_vtol2b = false;
			end
		end
	if g_display_narrative_debug_info then
			print("vtol1", b_player_in_vtol1);
			print("vtol2", b_player_in_vtol2);
			print("vtol1b", b_player_in_vtol1b);
			print("vtol2b", b_player_in_vtol2b);
	end


	   
PrintNarrative("Narrative END - plateau_sentrybattle_what_vtols");
end



--              IF SOMEONE IS LEFT BEHIND WITHOUT A VTOL 
function dormant.plateau_sentrybattle_gunner()


SleepUntil([| volume_test_objects( VOLUMES.plateau_sentrybattle_vtol_left, players_human() ) ], 1);
PrintNarrative("Narrative START - plateau_sentrybattle_gunner");
	local l_need_a_gunner:number = 0;
	if not (volume_return_objects_by_type( VOLUMES.plateau_sentrybattle_vtol_left, 0) == nil) then
	if unit_test_seat( list_get(volume_return_objects_by_type( VOLUMES.plateau_sentrybattle_vtol_left, 0), 0), "shade_d" ) == false then
				
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentrybattle_vtolready_nag", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					print("come back!"); 
						
						if not unit_in_vehicle( SPARTANS.thorne ) and l_need_a_gunner == 0 then 
							dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_06000.sound'), false, nil, 0.0, "", "Buck : Get back here and pick me up! I'll take the gunner's seat.", true );
							l_need_a_gunner = 1;
						end
						if not unit_in_vehicle( SPARTANS.vale ) and l_need_a_gunner == 0 then 
							dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_07800.sound'), false, nil, 0.0, "", "Vale : Hey! Come back! I'll take the gunner position.", true );
							l_need_a_gunner = 1;
						end
						if not unit_in_vehicle( SPARTANS.locke )and l_need_a_gunner == 0  then 
							dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_12600.sound'), false, nil, 0.0, "", "Locke : Hey! Pick me up. I'll man the guns!", true );
							l_need_a_gunner = 1;
						end
						if not unit_in_vehicle( SPARTANS.tanaka )and l_need_a_gunner == 0  then 
							dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_06600.sound'), false, nil, 0.0, "", "Tanaka : Hey! Need a gunner here!", true );
							l_need_a_gunner = 1;
						end
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
			
	else
		print("I have a gunner");
	end
	end
	
	

	unit_test_seat( OBJECTS.vtol2, "shade_d" )
	unit_test_seat( OBJECTS.vtol2, "vtol_d" )
	
vehicle_gunner(list_get(volume_return_objects_by_type( VOLUMES.plateau_sentrybattle_vtol_start, 0 ), 0))
vehicle_driver(list_get(volume_return_objects_by_type( VOLUMES.plateau_sentrybattle_vtol_start, 0 ), 0))
vehicle_driver(list_get(volume_return_objects( VOLUMES.plateau_sentrybattle_vtol_start), 0))
vehicle_gunner(list_get( volume_return_objects_by_type( VOLUMES.plateau_sentrybattle_vtol_start, 2 ), 0 ))
Gunner seat = "shade_d"


				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentrybattle_gunner", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
-- IF LOCKE
				if volume_test_player_lookat(VOLUMES.plateau_soldier_wake, SPARTANS.locke, 300, 25) == true then

-- ELSEIF TANAKA
				elseif volume_test_player_lookat(VOLUMES.plateau_soldier_wake, SPARTANS.tanaka, 300, 25) == true then

-- ELSEIF VALE
				elseif volume_test_player_lookat(VOLUMES.plateau_soldier_wake, SPARTANS.vale, 300, 25) == true then

-- ELSEIF THORNE
				elseif	volume_test_player_lookat(VOLUMES.plateau_soldier_wake, SPARTANS.thorne, 300, 25) == true then

-- END IF
				end
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);











PrintNarrative("Narrative END - plateau_sentrybattle_gunner");
end



--                                  FIRST LOOK AT THE GIANT SHIELD EMITING FROM THE SENTRY SHIP
--  ADD CONDITION THAT SHIELD IS ON    *****************************************************************************************************************************
function plateau_sentrybattle_shield_lookat():void
SleepUntil([| volume_test_players_lookat(VOLUMES.plateau_soldier_wake, 225, 20) ], 1);
PrintNarrative("Narrative START - plateau_sentrybattle_shield_lookat");
						ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
						l_dialog_id = dialog_start_foreground("plateau_sentrybattle_vtolready_nag", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
			-- IF LOCKE
							if volume_test_player_lookat(VOLUMES.plateau_soldier_wake, unit_get_player(SPARTANS.locke), 300, 25) == true then
								if not IsPlayer(SPARTANS.thorne) then
									dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_06100.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : They're shielding the Conduit's entry.", true );
								elseif not IsPlayer(SPARTANS.tanaka) then
									dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_06700.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : They're shielding the Conduit's entry.", true );
								elseif not IsPlayer(SPARTANS.vale) then
									dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_07900.sound'), false, SPARTANS.vale, 0.0, "", "Vale : They're shielding the Conduit's entry.", true );
								else
									dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_12700.sound'), false, SPARTANS.locke, 0.0, "", "Locke : They're shielding the Conduit's entry.", true );
								end
								
			-- ELSEIF TANAKA
							elseif volume_test_player_lookat(VOLUMES.plateau_soldier_wake, unit_get_player(SPARTANS.tanaka), 300, 25) == true then
								
								
								dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_06700.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : They're shielding the Conduit's entry.", true );
			-- ELSEIF VALE
							elseif volume_test_player_lookat(VOLUMES.plateau_soldier_wake, unit_get_player(SPARTANS.vale), 300, 25) == true then
								
								
								dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_07900.sound'), false, SPARTANS.vale, 0.0, "", "Vale : They're shielding the Conduit's entry.", true );
			-- ELSEIF THORNE
							elseif	volume_test_player_lookat(VOLUMES.plateau_soldier_wake, unit_get_player(SPARTANS.thorne), 300, 25) == true then
								
								
--								dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_06200.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : They're shielding the Conduit's entry.", true );
								dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_06100.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : They're shielding the Conduit's entry.", true );
			-- END IF
							end
								
					--			dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_08000.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Can we hit the shield with enough firepower to bring it down?", true );
					--			dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_06800.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : No way. That's not some portable generator powering it.", true );
					--			dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_06200.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Sounds like we ought to hit the Kraken itself.", true );
								dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_12800.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Tanaka, options?", true );
								dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_06900.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Kraken runs on a pulse generator. Only hope is to take it out.", true );
								dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_12900.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Copy. Find the weak point, Osiris!", true );
--								CreateThread(objective_text_goal_boss);
						l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
Wake(dormant.plateau_sentrybattle_loudspeaker);
Wake(dormant.plateau_sentrybattle_legs_tip);
sleep_real_seconds_NOT_QUITE_RELEASE(10);
Wake(dormant.plateau_sentrybattle_we_can_land);
PrintNarrative("Narrative END - plateau_sentrybattle_shield_lookat");
end




-- ******************    NEED CONDITIN WHEN PLAYER SHOOT AT SHIELD
--                                  IF SHOOTING AT THE SHIELD
function dormant.plateau_sentrybattle_shield_shooting()
SleepUntil([| volume_test_players_lookat(VOLUMES.plateau_soldier_wake, 125, 20) ], 1);
PrintNarrative("Narrative START - plateau_sentrybattle_shield_shooting");
					sentryship_vo_playing = true;
						 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
						l_dialog_id = dialog_start_foreground("plateau_sentrybattle_shield_shooting", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
---							dialog_line_npc( l_dialog_id, 0, (sentryship_vo_kill == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_04300.sound'), false, nil, 0.0, "", "AIGoodwin : Tanaka was right. That shield is too powerful to be taken down by shooting at it.", true );
						l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
					sentryship_vo_playing = false;
PrintNarrative("Narrative END - plateau_sentrybattle_shield_shooting");
end



--                                  FIRST ONE TO LAND ON THE SENTRY SHIP
function dormant.plateau_sentrybattle_loudspeaker()

--SleepUntil([| objects_distance_to_object( players_human(), object ) < 50 and b_nezik_can_speak == true ], 1);
SleepUntil([| volume_test_players_lookat( VOLUMES.kill_tv_sentry_ship, 100, 180 ) and b_nezik_can_speak == true ], 1);
PrintNarrative("Narrative START - plateau_sentrybattle_loudspeaker");
--				local l_dialog_id:thread=def_dialog_id_none();
--				l_dialog_id = dialog_start_foreground("plateau_sentrybattle_loudspeaker_1", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_01000.sound'), false, object_at_marker(OBJECTS.vin_sent_machine_2, "audio_centerupper"), 0.0, "", "Nezik : You will never open the Domain, Spartan fools!", true );
--				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
				PlayDialogFromMarkerOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_01000.sound'), OBJECTS.vin_sent_machine_2, "audio_centerupper" );
					
					sleep_real_seconds_NOT_QUITE_RELEASE(10);
sleep_real_seconds_NOT_QUITE_RELEASE(20);
SleepUntil([| volume_test_players_lookat( VOLUMES.kill_tv_sentry_ship, 100, 180 ) and b_nezik_can_speak == true ], 1);
--				local l_dialog_id:thread=def_dialog_id_none();
--				l_dialog_id = dialog_start_foreground("plateau_sentrybattle_loudspeaker_2", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_01100.sound'), false, object_at_marker(OBJECTS.vin_sent_machine_2, "audio_centerupper"), 0.0, "", "Nezik : The Domain will never open! The Guardian will never wake!", true );
--				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
					PlayDialogFromMarkerOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_01100.sound'), OBJECTS.vin_sent_machine_2, "audio_centerupper" );
					sleep_real_seconds_NOT_QUITE_RELEASE(10);
sleep_real_seconds_NOT_QUITE_RELEASE(20);
SleepUntil([| volume_test_players_lookat( VOLUMES.kill_tv_sentry_ship, 100, 180 ) and b_nezik_can_speak == true ], 1);				
--				local l_dialog_id:thread=def_dialog_id_none();
--				l_dialog_id = dialog_start_foreground("plateau_sentrybattle_loudspeaker_3", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_01200.sound'), false, object_at_marker(OBJECTS.vin_sent_machine_2, "audio_centerupper"), 0.0, "", "Nezik : You cannot defeat righteousness! You cannot defy the gods and live!", true );
--				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
					PlayDialogFromMarkerOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_01200.sound'), OBJECTS.vin_sent_machine_2, "audio_centerupper" );
					sleep_real_seconds_NOT_QUITE_RELEASE(10);
sleep_real_seconds_NOT_QUITE_RELEASE(20);				
SleepUntil([| volume_test_players_lookat( VOLUMES.kill_tv_sentry_ship, 100, 180 ) and b_nezik_can_speak == true ], 1);				
--				local l_dialog_id:thread=def_dialog_id_none();
--				l_dialog_id = dialog_start_foreground("plateau_sentrybattle_loudspeaker_4", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_01300.sound'), false, object_at_marker(OBJECTS.vin_sent_machine_2, "audio_centerupper"), 0.0, "", "Nezik : We serve the gods! You serve the false Arbiter! Your best hope is a swift death!", true );
--				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
					PlayDialogFromMarkerOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_01300.sound'), OBJECTS.vin_sent_machine_2, "audio_centerupper" );
					sleep_real_seconds_NOT_QUITE_RELEASE(10);
PrintNarrative("Narrative END - plateau_sentrybattle_loudspeaker");
end



--     ADD CONDITION ON LEGS
function dormant.plateau_sentrybattle_legs_tip()
sleep_real_seconds_NOT_QUITE_RELEASE(100);
PrintNarrative("Narrative START - plateau_sentrybattle_legs_tip");
CreateThread(plateau_sentrybattle_what_vtols);
SleepUntil([|	b_player_in_vtol1 or b_player_in_vtol2 or b_player_in_vtol1b or b_player_in_vtol2b and
				object_get_health( object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1") ) == 1], 1);
--	if object_get_health( LEGS) == 1 then
				sentryship_vo_playing = true;
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentrybattle_legs_tip", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					
					dialog_line_npc( l_dialog_id, 0, (sentryship_vo_kill == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_07000.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Ship's pulse generator should be in the bottom half. Legs could prove a weak spot.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
				sentryship_vo_playing = false;
--	end
PrintNarrative("Narrative END - plateau_sentrybattle_legs_tip");
end



--            WHEN A PLAYER STARTS SHOOTING AT ENEMIES ON THE SENTRY SHIP, HINT THAT WE COULD LAND ON IT
function dormant.plateau_sentrybattle_we_can_land()
SleepUntil([| volume_test_players_lookat(VOLUMES.tv_deck_stairs, 50, 3) ], 1);
PrintNarrative("Narrative START - plateau_sentrybattle_we_can_land");
		if IsPlayer(SPARTANS.thorne) then																						--		IF THORNE IS A PLAYER WE WAIT UNTIL HE LOOKS AT THE DECK
			SleepUntil([| volume_test_player_lookat(VOLUMES.tv_deck_stairs, SPARTANS.thorne, 50, 3) ], 1);						--		IF IT'S NOT A PLAYER, THEN THORNE TALKS RIGHT AWAY
		end
--  *************** WHAT IF THORNE IS NOT THERE

		if	not b_tanaka_on_board_sentry_ship or not b_vale_on_board_sentry_ship or not b_thorne_on_board_sentry_ship and not b_locke_on_board_sentry_ship then
				sentryship_vo_playing = true;
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentrybattle_we_can_land", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, (sentryship_vo_kill == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_06300.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Focus fire on the ship's deck, and we could clear a space to land.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
			sentryship_vo_playing = false;
		end
PrintNarrative("Narrative END - plateau_sentrybattle_we_can_land");
end




function dormant.plateau_sentrybattle_damaged_core()


SleepUntil([| object_get_health( object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1") ) < 1 and objects_can_see_object( players_human(), object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 20 ) ], 1);
PrintNarrative("Narrative START - plateau_sentrybattle_damaged_core");
		PrintNarrative("CORE DAMAGED");
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentrybattle_legs_tip", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
				
					if device_get_position(OBJECTS.core_button) == 0 then
						-- IF LOCKE
							if 	(objects_distance_to_object( SPARTANS.locke, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1") ) < 10 and objects_can_see_object( SPARTANS.locke, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 21 )) or
								(unit_in_vehicle( SPARTANS.locke ) and objects_can_see_object( SPARTANS.locke, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 10 )) then
							PrintNarrative("LOCKE HIT");
								dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_13000.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Direct hit on the pulse generator.", true );
								dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_07100.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Having an effect. Keep it up!", true );
						-- ELSEIF TANAKA
							elseif 	(objects_distance_to_object( SPARTANS.tanaka, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1") ) < 10 and objects_can_see_object( SPARTANS.tanaka, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 21 )) or
									(unit_in_vehicle( SPARTANS.tanaka ) and objects_can_see_object( SPARTANS.tanaka, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 10 )) then
							PrintNarrative("TANAKA HIT");
								dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_07200.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Pulse generator direct hit.", true );
								dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_13100.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Great! Few more should do it.", true );
						-- ELSEIF VALE
							elseif 	(objects_distance_to_object( SPARTANS.vale, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1") ) < 10 and objects_can_see_object( SPARTANS.vale, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 21)) or
									(unit_in_vehicle( SPARTANS.vale ) and objects_can_see_object( SPARTANS.vale, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 10 )) then
							PrintNarrative("VALE HIT");
								dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_08100.sound'), false, SPARTANS.vale, 0.0, "", "Vale : I hit the pulse generator!", true );
								dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_13200.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Focus fire Osiris!", true );
						-- ELSEIF THORNE
							elseif	(objects_distance_to_object( SPARTANS.thorne, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1") ) < 10 and objects_can_see_object( SPARTANS.thorne, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 21)) or
									(unit_in_vehicle( SPARTANS.thorne ) and objects_can_see_object( SPARTANS.thorne, object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1"), 10 )) then
							PrintNarrative("BUCK HIT");
								dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_06500.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Pulse generator's taking a beating.", true );
								dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_13300.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Keep it up Osiris!", true );
						-- END IF
							end
					
					
						SleepUntil([| object_get_health( object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1") ) < 0.2 ], 1);
--								dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_04600.sound'), false, nil, 0.0, "", "AIGoodwin : I've tapped into ship's internal comms. Our Covenant foes are most displeased.", true );
							if object_get_health( object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1") ) > 0 then
										dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_13400.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Finish the job, Osiris.", true );
							end
					
					end
--								dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_01400.sound'), false, OBJECTS.vin_sent_machine_2, 0.0, "", "Nezik : The ship's hull is breached! Repair the damage and continue praying!", true );
								PlayDialogFromMarkerOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_01400.sound'), OBJECTS.vin_sent_machine_2, "audio_centerupper" );
								sleep_real_seconds_NOT_QUITE_RELEASE(3);
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
PrintNarrative("Narrative END - plateau_sentrybattle_damaged_core");
end

--                                  FIRST ONE TO LAND ON THE SENTRY SHIP
function dormant.plateau_sentrybattle_ship_landing()
SleepUntil([|	(volume_test_object( VOLUMES.tv_upper_decker, SPARTANS.locke ) and not unit_in_vehicle( SPARTANS.locke )) or
				(volume_test_object( VOLUMES.tv_upper_decker, SPARTANS.tanaka ) and not unit_in_vehicle( SPARTANS.tanaka )) or
				(volume_test_object( VOLUMES.tv_upper_decker, SPARTANS.vale ) and not unit_in_vehicle( SPARTANS.vale )) or
				(volume_test_object( VOLUMES.tv_upper_decker, SPARTANS.thorne ) and not unit_in_vehicle( SPARTANS.thorne )) ], 1);

plateau_sentrybattle_ship_who_is_onboard_sentryship();

b_nezik_can_speak = false;
sleep_real_seconds_NOT_QUITE_RELEASE(10);
			
PrintNarrative("Narrative START - plateau_sentrybattle_ship_landing");
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); 
				 
					PlayDialogFromMarkerOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_01500.sound'), OBJECTS.vin_sent_machine_2, "audio_centerupper" );	 
					sleep_real_seconds_NOT_QUITE_RELEASE(10);
				
				ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
sleep_real_seconds_NOT_QUITE_RELEASE(10);
b_nezik_can_speak = true;
SleepUntil([| volume_test_players(VOLUMES.tv_hangar_floor) ], 1);
b_nezik_can_speak = false;
sleep_real_seconds_NOT_QUITE_RELEASE(15);
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); 
				
					PlayDialogFromMarkerOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_01600.sound'), OBJECTS.vin_sent_machine_2, "audio_centerupper" );	 
					sleep_real_seconds_NOT_QUITE_RELEASE(10);
					
				ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
sleep_real_seconds_NOT_QUITE_RELEASE(15);
b_nezik_can_speak = true;
PrintNarrative("Narrative END - plateau_sentrybattle_ship_landing");
end



--                                  LOOKING FOR THE PATH TO THE CORE ON THE SENTRY SHIP
--		**********************  Maybe only to client
function dormant.plateau_sentrybattle_ship_to_the_core()
SleepUntil([| volume_test_players(VOLUMES.tv_deck_stairs) ], 1);
PrintNarrative("Narrative START - plateau_sentrybattle_ship_to_the_core");
		print("DIRECTIONS VO START");
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentrybattle_ship_to_the_core", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
-- IF LOCKE
				if volume_test_object(VOLUMES.tv_deck_stairs, SPARTANS.locke) then
				print("LOCKE DIRECTIONS VO START");
sleep_real_seconds_NOT_QUITE_RELEASE(2);					
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_13500.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Goodwin. Which way to the pulse generator?", true );
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_04700.sound'), false, nil, 0.0, "", "AIGoodwin : Marking a path for you, Spartan Locke. ", true );
-- ELSEIF TANAKA
				elseif volume_test_object(VOLUMES.tv_deck_stairs, SPARTANS.vale) then
				print("VALE DIRECTIONS VO START");
sleep_real_seconds_NOT_QUITE_RELEASE(2);					
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_08200.sound'), false, SPARTANS.vale, 0.0, "", "Vale : I'm on board- where's the pulse generator?", true );
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_04800.sound'), false, nil, 0.0, "", "AIGoodwin : Marking a path for you, Spartan Vale.", true );
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_08300.sound'), false, SPARTANS.vale, 0.0, "", "Vale : Thanks Goodwin.", true );
-- ELSEIF VALE
				elseif volume_test_object(VOLUMES.tv_deck_stairs, SPARTANS.thorne) then
				print("BUCK DIRECTIONS VO START");
sleep_real_seconds_NOT_QUITE_RELEASE(2);					
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_06600.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Best route to the pulse generator?", true );
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_04900.sound'), false, nil, 0.0, "", "AIGoodwin : Marking a path for you, Spartan Thorne.", true );
-- ELSEIF THORNE
				elseif	volume_test_object(VOLUMES.tv_deck_stairs, SPARTANS.tanaka) then
				print("TANAKA DIRECTIONS VO START");
sleep_real_seconds_NOT_QUITE_RELEASE(2);						
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_07300.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Can't find the pulse generator.", true );
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_05000.sound'), false, nil, 0.0, "", "AIGoodwin : Marking a path for you, Spartan Tanaka.", true );
-- END IF
				end
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
PrintNarrative("Narrative END - plateau_sentrybattle_ship_to_the_core");
end


--          WHEN A PLAYER IS INSIDE THE SECRET VENT
--  *****************   That should be to Client only
function dormant.plateau_sentrybattle_ship_vent()
SleepUntil([| volume_test_players(VOLUMES.tv_e3) ], 1);
sleep_real_seconds_NOT_QUITE_RELEASE(1);
PrintNarrative("Narrative START - plateau_sentrybattle_ship_vent");
				sentryship_vo_playing = true;
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentrybattle_ship_vent", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, (sentryship_vo_kill == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_05100.sound'), false, nil, 0.0, "", "AIGoodwin : Fantastic. This is the pulse generator ventilation system. You can overload it here.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
				sentryship_vo_playing = false;
PrintNarrative("Narrative END - plateau_sentrybattle_ship_vent");
end


--            WHEN A PLAYER ACTIVATED THE NINJA SWITCH TO OVERHEAT THE CORE ENGINE
function plateau_sentrybattle_ship_ninja_switch():void

PrintNarrative("Narrative START - plateau_sentrybattle_ship_ninja_switch");
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentrybattle_ship_ninja_switch", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
					
-- IF LOCKE
				if objects_distance_to_object( SPARTANS.locke, OBJECTS.core_button ) < 3 then
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_13800.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Osiris, I rigged the ventilation system to overload the pulse generator!", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_07700.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : That should do it, Locke!", true );
-- ELSEIF TANAKA
				elseif	objects_distance_to_object( SPARTANS.tanaka, OBJECTS.core_button ) < 3 then
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_06800.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Found a way to overload the pulse generator. She's gonna blow!", true );					
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_13900.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Fantastic! That should take care of it!", true );
-- ELSEIF VALE
				elseif objects_distance_to_object( SPARTANS.vale, OBJECTS.core_button )  < 3 then
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_08600.sound'), false, SPARTANS.vale, 0.0, "", "Vale : I used the ventilation controls to overload the pulse generator!", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_13900.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Fantastic! That should take care of it!", true );
-- ELSEIF THORNE
				elseif objects_distance_to_object( SPARTANS.thorne, OBJECTS.core_button ) < 3 then
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_06900.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : I set the ventilation controls to overload the pulse generator!", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_13900.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Fantastic! That should take care of it!", true );

				
-- END IF
				end
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);	
PrintNarrative("Narrative END - plateau_sentrybattle_ship_ninja_switch");

-- 	objects_distance_to_object( players_human(), object_at_marker(OBJECTS.vin_sent_machine_2, "core_attach_1") )
end



function plateau_sentrybattle_ship_who_is_onboard_sentryship():void
PrintNarrative("Narrative START - plateau_sentrybattle_ship_who_is_onboard_sentryship");
	if  volume_test_object( VOLUMES.kill_tv_sentry_ship, SPARTANS.locke ) then
			b_locke_on_board_sentry_ship = true;		
			PrintNarrative("Locke is on board the Kraken");
	end
	if	volume_test_object( VOLUMES.kill_tv_sentry_ship, SPARTANS.tanaka ) then
			b_tanaka_on_board_sentry_ship = true;
			PrintNarrative("Tanaka is on board the Kraken");
	end
	if 	volume_test_object( VOLUMES.kill_tv_sentry_ship, SPARTANS.vale ) then
			b_vale_on_board_sentry_ship = true;
			PrintNarrative("Vale is on board the Kraken");
	end
	if 	volume_test_object( VOLUMES.kill_tv_sentry_ship, SPARTANS.thorne ) then
			b_thorne_on_board_sentry_ship = true;		
			PrintNarrative("Thorne is on board the Kraken");
	end
PrintNarrative("Narrative END - plateau_sentrybattle_ship_who_is_onboard_sentryship");
end

--                WHEN THE CORE ENGINE IA ABOUT TO EXPLODE, COUNTDOWN STARTED
function plateau_sentrybattle_ship_escape():void

PrintNarrative("Narrative START - plateau_sentrybattle_ship_escape");
b_nezik_can_speak = false;
--KillScript(dormant.plateau_sentrybattle_we_can_land);
sentryship_vo_kill = true;
Wake(dormant.plateau_sentrybattle_ship_escape_out);
sleep_real_seconds_NOT_QUITE_RELEASE(1);

plateau_sentrybattle_ship_who_is_onboard_sentryship();

		if b_locke_on_board_sentry_ship or b_tanaka_on_board_sentry_ship or b_vale_on_board_sentry_ship or b_thorne_on_board_sentry_ship then
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentrybattle_ship_escape_Covenant", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_05200.sound'), false, nil, 0.0, "", "AIGoodwin : Spartan Locke, the pulse generator will detonate--(shortly). ", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);

				PlayDialogFromMarkerOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_cv_nezik_01700.sound'), OBJECTS.vin_sent_machine_2, "audio_centerupper" );
		end		

--  IF LOCKE IS ON THE SHIP	
	if b_locke_on_board_sentry_ship then
		PrintNarrative("locke is on the ship")
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentrybattle_ship_escape_2a", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_07800.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Locke! Evac now!", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);	
			sleep_real_seconds_NOT_QUITE_RELEASE(10);
		if b_locke_on_board_sentry_ship then
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentrybattle_ship_escape_2b", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_07000.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Locke! Get off that ship NOW!", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);	
		end
--    IF LOCKE IN VTOL AND ANY OTHER STILL ON THE SHIP
	elseif	b_tanaka_on_board_sentry_ship or b_vale_on_board_sentry_ship or b_thorne_on_board_sentry_ship and not b_locke_on_board_sentry_ship then
		PrintNarrative("Vale, tanaka or Thorne is on the Ship but not Locke")
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentrybattle_ship_escape_1a", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_14000.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Evac! Now!", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
			sleep_real_seconds_NOT_QUITE_RELEASE(10);
		if	b_tanaka_on_board_sentry_ship or b_vale_on_board_sentry_ship or b_thorne_on_board_sentry_ship and not b_locke_on_board_sentry_ship then
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentrybattle_ship_escape_1b", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_14100.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Get off there NOW Spartans!", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
		end

	end

end


--        WHEN PLAYER EXIT THE KRAKEN AT THE LAST MINUTE
function dormant.plateau_sentrybattle_ship_escape_out()
SleepUntil([| 	(not volume_test_object( VOLUMES.kill_tv_sentry_ship, SPARTANS.locke ) and b_locke_on_board_sentry_ship and unit_in_vehicle( SPARTANS.locke ) ) or 				--		IF LOCKE WAS ON BOARD AND IS NOW OUTSIDE THE KRAKEN AND IN A VEHICLE
				(not volume_test_object( VOLUMES.kill_tv_sentry_ship, SPARTANS.tanaka ) and b_tanaka_on_board_sentry_ship and unit_in_vehicle( SPARTANS.tanaka )) or 			--		IF TANAKA WAS ON BOARD AND IS NOW OUTSIDE THE KRAKEN AND IN A VEHICLE
				(not volume_test_object( VOLUMES.kill_tv_sentry_ship, SPARTANS.vale ) and b_vale_on_board_sentry_ship and unit_in_vehicle( SPARTANS.vale )) or 					--		IF VALE WAS ON BOARD AND IS NOW OUTSIDE THE KRAKEN AND IN A VEHICLE
				(not volume_test_object( VOLUMES.kill_tv_sentry_ship, SPARTANS.thorne ) and b_thorne_on_board_sentry_ship and unit_in_vehicle( SPARTANS.thorne )) ], 1);		--		IF THORNE WAS ON BOARD AND IS NOW OUTSIDE THE KRAKEN AND IN A VEHICLE
PrintNarrative("Narrative START - plateau_sentrybattle_ship_escape_out");

	Wake(dormant.plateau_sentrybattle_ship_escape_out_locke);
	Wake(dormant.plateau_sentrybattle_ship_escape_out_tanaka);
	Wake(dormant.plateau_sentrybattle_ship_escape_out_thorne);
	Wake(dormant.plateau_sentrybattle_ship_escape_out_vale);

PrintNarrative("Narrative END - plateau_sentrybattle_ship_escape_out");
end

function dormant.plateau_sentrybattle_ship_escape_out_locke()
SleepUntil([| 	(not volume_test_object( VOLUMES.kill_tv_sentry_ship, SPARTANS.locke ) and b_locke_on_board_sentry_ship and unit_in_vehicle( SPARTANS.locke ) ) ], 1); 				--		IF LOCKE WAS ON BOARD AND IS NOW OUTSIDE THE KRAKEN AND IN A VEHICLE
PrintNarrative("Narrative START - plateau_sentrybattle_ship_escape_out_locke");
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentrybattle_ship_escape_out_locke", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
				
				if  not volume_test_object( VOLUMES.kill_tv_sentry_ship, SPARTANS.locke ) and b_locke_on_board_sentry_ship and unit_in_vehicle( SPARTANS.locke ) then
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_14200.sound'), false, SPARTANS.locke, 0.0, "", "Locke : I'm clear of the Kraken!", true );
				end

				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
PrintNarrative("Narrative END - plateau_sentrybattle_ship_escape_out_locke");
end


function dormant.plateau_sentrybattle_ship_escape_out_tanaka()
SleepUntil([| (not volume_test_object( VOLUMES.kill_tv_sentry_ship, SPARTANS.tanaka ) and b_tanaka_on_board_sentry_ship and unit_in_vehicle( SPARTANS.tanaka ) ) ], 1); 				--		IF LOCKE WAS ON BOARD AND IS NOW OUTSIDE THE KRAKEN AND IN A VEHICLE
PrintNarrative("Narrative START - plateau_sentrybattle_ship_escape_out_tanaka");
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentrybattle_ship_escape_out_tanaka", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
				
				if not volume_test_object( VOLUMES.kill_tv_sentry_ship, SPARTANS.tanaka ) and b_tanaka_on_board_sentry_ship and unit_in_vehicle( SPARTANS.tanaka ) then
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_07900.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Flying off the Kraken!", true );
				end

				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
PrintNarrative("Narrative END - plateau_sentrybattle_ship_escape_out_tanaka");
end

function dormant.plateau_sentrybattle_ship_escape_out_thorne()
SleepUntil([| (not volume_test_object( VOLUMES.kill_tv_sentry_ship, SPARTANS.thorne ) and b_thorne_on_board_sentry_ship and unit_in_vehicle( SPARTANS.thorne ) ) ], 1); 				--		IF LOCKE WAS ON BOARD AND IS NOW OUTSIDE THE KRAKEN AND IN A VEHICLE
PrintNarrative("Narrative START - plateau_sentrybattle_ship_escape_out_thorne");
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentrybattle_ship_escape_out_thorne", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
				
				if not volume_test_object( VOLUMES.kill_tv_sentry_ship, SPARTANS.thorne ) and b_thorne_on_board_sentry_ship and unit_in_vehicle( SPARTANS.thorne ) then
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_07100.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Clear of the Kraken!", true );
				end

				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
PrintNarrative("Narrative END - plateau_sentrybattle_ship_escape_out_thorne");
end

function dormant.plateau_sentrybattle_ship_escape_out_vale()
SleepUntil([| (not volume_test_object( VOLUMES.kill_tv_sentry_ship, SPARTANS.vale ) and b_vale_on_board_sentry_ship and unit_in_vehicle( SPARTANS.vale ) ) ], 1); 				--		IF LOCKE WAS ON BOARD AND IS NOW OUTSIDE THE KRAKEN AND IN A VEHICLE
PrintNarrative("Narrative START - plateau_sentrybattle_ship_escape_out_vale");
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentrybattle_ship_escape_out_vale", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
				
				if not volume_test_object( VOLUMES.kill_tv_sentry_ship, SPARTANS.vale ) and b_vale_on_board_sentry_ship and unit_in_vehicle( SPARTANS.vale ) then
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_08700.sound'), false, SPARTANS.vale, 0.0, "", "Vale : I'm clear of the Kraken!", true );
				end

				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
PrintNarrative("Narrative END - plateau_sentrybattle_ship_escape_out_vale");
end




--    WHEN THE SENTRY SHIP EXPLODED
function plateau_sentrybattle_ship_destroyed():void
--    WHEN SENTRY SHIP IS DESTROYED
KillScript( dormant.plateau_sentrybattle_loudspeaker );
sentryship_vo_kill = true;
if sentryship_vo_playing == true then
	KillScript( dormant.plateau_sentrybattle_legs_tip );
	KillScript( dormant.plateau_sentrybattle_shield_shooting );
	KillScript( dormant.plateau_sentrybattle_we_can_land );
	KillScript( dormant.plateau_sentrybattle_ship_vent );
end

PrintNarrative("Narrative START - plateau_sentrybattle_ship_destroyed");
sleep_real_seconds_NOT_QUITE_RELEASE(14);
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentrybattle_ship_destroyed", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_14500.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Good work, Osiris. Everyone head for the Conduit entry.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
				
sleep_real_seconds_NOT_QUITE_RELEASE(19);
				
			if not b_playerIsInSoldierRoom then
				b_warrior_at_birth_played = true;
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentrybattle_ship_destroyed", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_08800.sound'), false, SPARTANS.vale, 0.7, "", "Vale : [A Warrior at birth, a Warrior in death.]  Shee-nn-sayray-mah-uu,  shee-nn-sayroo-tay-hah-deh", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_14400.sound'), false, SPARTANS.locke, 0.3, "", "Locke : What's that, Vale?", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_08900.sound'), false, SPARTANS.vale, 0.0, "", "Vale : A Warrior at birth, a Warrior in death. A Sangheili burial prayer.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
			end	
				
Wake(dormant.plateau_sentrybattle_ship_noshield);
PrintNarrative("Narrative END - plateau_sentrybattle_ship_destroyed");
end


--              WHEN THE PATH IS OPEN, NO MORE SHIELD IS BLOCKING THE PATH
function dormant.plateau_sentrybattle_ship_noshield()
SleepUntil([| volume_test_players_lookat(VOLUMES.plateau_soldier_wake, 360, 30) and not volume_test_players_all( VOLUMES.plateau_soldier_wake )], 1);
PrintNarrative("Narrative START - plateau_sentrybattle_ship_noshield");

				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_sentrybattle_ship_noshield", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					--dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_05300.sound'), false, nil, 0.0, "", "AIGoodwin : Osiris, if I may point out, the Conduit shield is down.", true );
					
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
				
PrintNarrative("Narrative END - plateau_sentrybattle_ship_noshield");
end

-- =================================================================================================


-- =================================================================================================
--   _____  ____  _      _____ _____ ______ _____  
--  / ____|/ __ \| |    |  __ \_   _|  ____|  __ \ 
-- | (___ | |  | | |    | |  | || | | |__  | |__) |
--  \___ \| |  | | |    | |  | || | |  __| |  _  / 
--  ____) | |__| | |____| |__| || |_| |____| | \ \ 
-- |_____/ \____/|______|_____/_____|______|_|  \_\
--                                                 
-- =================================================================================================


function dormant.plateau_soldier_wake()
SleepUntil([| volume_test_players(VOLUMES.plateau_soldier_wake) ], 1);
PrintNarrative("Narrative LOAD Soldier Scenes");

	b_playerIsInDropdown = true;
	b_playerIsInHollow = true;
	b_playerIsInRamp = true;
	b_playerIsInTemple = true;
	b_playerIsInSentryBattle = true;
	b_playerIsInSoldierRoom = true;
	
	Wake(dormant.plateau_soldier_arena_enter);
	Wake(dormant.plateau_soldier_taunt);
--	Wake(dormant.plateau_soldier_wait_for_others);
	
	

end

-- =================================================================================================

--                                    WHEN VTOLS DISAPPEAR
function plateau_soldier_vtols():void
SleepUntil([| volume_test_players(VOLUMES.plateau_soldier_vtols) ], 1);
sleep_real_seconds_NOT_QUITE_RELEASE(1);
PrintNarrative("Narrative START - plateau_soldier_vtols");
				ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_soldier_vtols", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
				
				if not b_warrior_at_birth_played then
					dialog_line_npc( l_dialog_id, 0, not b_warrior_at_birth_played, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_08800.sound'), false, SPARTANS.vale, 0.2, "", "Vale : [A Warrior at birth, a Warrior in death.]  Shee-nn-sayray-mah-uu,  shee-nn-sayroo-tay-hah-deh", true );
					dialog_line_npc( l_dialog_id, 0, not b_warrior_at_birth_played, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_14400.sound'), false, SPARTANS.locke, 0.0, "", "Locke : What's that, Vale?", true );
					dialog_line_npc( l_dialog_id, 0, not b_warrior_at_birth_played, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_08900.sound'), false, SPARTANS.vale, 0.0, "", "Vale : A Warrior at birth, a Warrior in death. A Sangheili burial prayer.", true );
				end
					--dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_08000.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : That is never not weird.", true );
					--dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_09000.sound'), false, SPARTANS.vale, 0.0, "", "Vale : I kind of like it. Tingly all over.", true );
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_07300.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : I'm with Vale on this one.", true );
					--dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_07200.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Gonna say I'm with Vale on this one.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
PrintNarrative("Narrative END - plateau_soldier_vtols");
end


--                                    WHEN PLAYER SEES THE ROOM EXPANDING
-- *********** ADD CONDITION IF PLAYER LOOKED AT THE SAGA WALL
function dormant.plateau_soldier_arena_enter()
SleepUntil([|volume_test_players(VOLUMES.plateau_soldier_arena_enter) ], 1);
PrintNarrative("Narrative START - plateau_soldier_arena_enter");
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_soldier_arena_enter", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_07200.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : This place looks just like Vale's mural.", true );
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_08800.sound'), false, SPARTANS.vale, 0.0, "", "Vale : It is the same. That wasn't just decorative. It was a map.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
PrintNarrative("Narrative END - plateau_soldier_arena_enter");

end




function dormant.plateau_soldier_taunt()

SleepUntil([| ai_living_count( AI.sg_ob_sold_pair_1.spawn_points_0 ) == 1 and ai_living_count( AI.sg_ob_sold_pair_1.spawn_points_1 ) == 1], 1);
PrintNarrative("Narrative START - plateau_soldier_taunt");
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_background("plateau_soldier_taunt", l_dialog_id, true, def_dialog_style_play(), false, "", 0);
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_07600.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : Soldiers!", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_07500.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Soldiers!", true );
--						sleep_real_seconds_NOT_QUITE_RELEASE(3);
--						PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_fr_soldier01_00100.sound'), ai_get_object(AI.sg_ob_sold_pair_1.spawn_points_0));
--						sleep_real_seconds_NOT_QUITE_RELEASE(2);
--						PlayDialogOnClients( TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_fr_soldier01_00200.sound'), ai_get_object(AI.sg_ob_sold_pair_1.spawn_points_1) );
--						sleep_real_seconds_NOT_QUITE_RELEASE(3);
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_fr_soldier01_00100.sound'), false, ai_get_object(AI.sg_ob_sold_pair_1.spawn_points_0), 0.0, "", "Soldier01 : The savages impinge upon our repose.", true );
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_fr_soldier01_00200.sound'), false, ai_get_object(AI.sg_ob_sold_pair_1.spawn_points_1), 0.0, "", "Soldier01 : Put them down quickly.", true );
-- *******************This next line doens't work.
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_14800.sound'), false, SPARTANS.locke, 0.0, "", "Locke : They want a fight Osiris? Give it to them.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
	

Wake(dormant.plateau_soldier_all_dead);
PrintNarrative("Narrative END - plateau_soldier_taunt");

end



function dormant.plateau_soldier_all_dead()
SleepUntil([| ai_living_count( AI.sg_obelisk_all ) == 0], 1);
sleep_real_seconds_NOT_QUITE_RELEASE(8);

	-- CHATTER SPARTANS OFF
	ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false);
	
PrintNarrative("Narrative - Switch AI Chatter off");
PrintNarrative("Narrative START - plateau_soldier_all_dead");
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_soldier_all_dead", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_14900.sound'), false, SPARTANS.locke, 0.0, "", "Locke : So... Where's the Guardian Constructor?", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_08800.sound'), false, SPARTANS.thorne, 0.4, "", "I don't see anything, you sure it's here.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_08100.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Just need to get its attention.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
				CreateThread(objective_text_goal_Soldier_3);
Wake(dormant.plateau_soldier_get_constructor_nag);
Wake(dormant.plateau_soldier_looking_at_light);

PrintNarrative("Narrative END - plateau_soldier_all_dead");
end


function dormant.plateau_soldier_looking_at_light()
--SleepUntil([| volume_test_player_lookat( volume, SPARTANS.thorne, 5, 2 ) ], 1);

PrintNarrative("Narrative START - plateau_soldier_looking_at_light");
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_soldier_all_dead", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_08900.sound'), false, SPARTANS.thorne, 0.0, "", "Have a feeling the it's hiding up there.", true );

				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
				
PrintNarrative("Narrative END - plateau_soldier_looking_at_light");
end


function dormant.plateau_soldier_get_constructor_nag()
sleep_real_seconds_NOT_QUITE_RELEASE(random_range( 10, 30 ));
PrintNarrative("Narrative START - plateau_soldier_get_constructor_nag");
	if  not b_GotPlateauConstructor and not volume_test_players( VOLUMES.plateau_soldier_get_constructor ) then
				b_soldier_nag_playing = true;
				 local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_soldier_get_constructor_nag", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, (b_GotPlateauConstructor == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_15000.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Tanaka? Any idea how to get the Constructor's attention?", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
				b_soldier_nag_playing = false;
	end
PrintNarrative("Narrative END - plateau_soldier_get_constructor_nag");
sleep_real_seconds_NOT_QUITE_RELEASE(random_range( 20, 40 ));
PrintNarrative("Narrative START - plateau_soldier_get_constructor_nag_2");
	if not b_GotPlateauConstructor and not volume_test_players( VOLUMES.plateau_soldier_get_constructor ) then
				b_soldier_nag_playing = true;
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_soldier_get_constructor_nag_2", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, (b_GotPlateauConstructor == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_15100.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Tanaka, any progress on the Constructor? ", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
				b_soldier_nag_playing = false;
	end
PrintNarrative("Narrative END - plateau_soldier_get_constructor_nag_2");
end

-- WHEN TANAKA IS HITTING THE CONSTRUCTOR'S HOME
function plateau_soldier_exit():void
PrintNarrative("Narrative START - plateau_soldier_exit");
b_GotPlateauConstructor = true;
sleep_real_seconds_NOT_QUITE_RELEASE(0.5);
--sleep_real_seconds_NOT_QUITE_RELEASE(1);
	if b_soldier_nag_playing == false then
		KillScript( dormant.plateau_soldier_get_constructor_nag );
	end
			if volume_test_object(VOLUMES.plateau_soldier_punch, SPARTANS.thorne) then
				PrintNarrative("Buck is punching");
			else
			
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_soldier_exit", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_07600.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : What the hell are you doing?", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
			end
sleep_real_seconds_NOT_QUITE_RELEASE(1);
Wake(dormant.plateau_soldier_get_constructor_arrival);
PrintNarrative("Narrative END - plateau_soldier_exit");
end

--	WHEN THE CONSTRUCTOR ARRIVES
function dormant.plateau_soldier_get_constructor_arrival()
PrintNarrative("Narrative START - plateau_soldier_get_constructor_arrival");
sleep_real_seconds_NOT_QUITE_RELEASE(0.8);
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_soldier_get_constructor_arrival", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);

					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_07700.sound'), false, SPARTANS.thorne, 1, "", "Buck : Ah.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_08200.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Come on. Got work for you.", true );
					sleep_real_seconds_NOT_QUITE_RELEASE(0.5);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_08300.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Good to go.", true );
					sleep_real_seconds_NOT_QUITE_RELEASE(0.5);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_15200.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Beautiful job Osiris. Let's get out of here.", true );
					sleep_real_seconds_NOT_QUITE_RELEASE(2);
					CreateThread(objective_text_goal_teleport_a);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_09300.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Little fella seems to like you, Tanaka.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
Wake(dormant.plateau_soldier_teleport_room);
PrintNarrative("Narrative END - plateau_soldier_get_constructor_arrival");
end

function dormant.plateau_soldier_teleport_room()
sleep_real_seconds_NOT_QUITE_RELEASE(1);
SleepUntil([| volume_test_players( VOLUMES.plateau_soldier_teleport_room )], 1);
PrintNarrative("Narrative START - plateau_soldier_teleport_room");
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_soldier_teleport_room", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_05600.sound'), false, nil, 0.0, "", "AIGoodwin : Osiris, this appears to be the way out. A rapid transit system not unlike those we witnessed at the Meridian Guardian station.", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
PrintNarrative("Narrative END - plateau_soldier_teleport_room");
Wake(dormant.plateau_soldier_teleport_room_nag);
end


function dormant.plateau_soldier_teleport_room_nag()
PrintNarrative("Start Teleport Room Nag- 20sec");
sleep_real_seconds_NOT_QUITE_RELEASE(20);
	if not b_soldierRoomTeleport and not (current_zone_set() == ZONE_SETS.campsite_start) and not volume_test_players_all( VOLUMES.plateau_soldier_teleport_room ) then
			PrintNarrative("Narrative START - plateau_soldier_teleport_room_nag");
					b_soldier_nag_playing = true;
					local l_dialog_id:thread=def_dialog_id_none();
					l_dialog_id = dialog_start_foreground("plateau_soldier_teleport_room_nag", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
						dialog_line_npc( l_dialog_id, 0, (b_soldierRoomTeleport == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_05700.sound'), false, nil, 0.0, "", "AIGoodwin : Osiris, I believe the rapid transit station is the only way out of this area.", true );
					l_dialog_id = dialog_end(l_dialog_id, true, true, "");
					b_soldier_nag_playing = false;
			PrintNarrative("Narrative END - plateau_soldier_teleport_room_nag");
	end
PrintNarrative("Start Teleport Room SECOND Nag- 20sec");
sleep_real_seconds_NOT_QUITE_RELEASE(20);
	if not b_soldierRoomTeleport and not (current_zone_set() == ZONE_SETS.campsite_start) and not volume_test_players_all( VOLUMES.plateau_soldier_teleport_room ) then
			PrintNarrative("Narrative START - plateau_soldier_teleport_room_nag_2");
				b_soldier_nag_playing = true;
					local l_dialog_id:thread=def_dialog_id_none();
					l_dialog_id = dialog_start_foreground("plateau_soldier_teleport_room_nag_2", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
						dialog_line_npc( l_dialog_id, 0, (b_soldierRoomTeleport == false), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_aigoodwin_05800.sound'), false, nil, 0.0, "", "AIGoodwin : I have confirmed my hypothesis. The rapid transit station is the only way out of the Conduit.", true );
					l_dialog_id = dialog_end(l_dialog_id, true, true, "");
				b_soldier_nag_playing = false;
			PrintNarrative("Narrative END - plateau_soldier_teleport_room_nag_2");
	end	
end

--                                    WHEN PLAYER GOT THE ARTIFACT AND EXIT THE SOLDIER ROOM
function plateau_soldier_teleport_room_teleport():void
PrintNarrative("Narrative START - plateau_soldier_teleport_room_teleport");
b_soldierRoomTeleport = true;

	if b_soldier_nag_playing == true then
		KillScript(dormant.plateau_soldier_teleport_room_nag);
	end

PrintNarrative("KILL Teleport Room Nag");
				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_soldier_teleport_room_teleport", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_thorne_07900.sound'), false, SPARTANS.thorne, 0.0, "", "Thorne : We're sealed in.", true );
					dialog_line_npc( l_dialog_id, 0, not (current_zone_set() == ZONE_SETS.campsite_start), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_16700.sound'), false, SPARTANS.locke, 0.0, "", "Locke : We've done this before. Get ready..", true );
--					dialog_line_npc( l_dialog_id, 0, not (current_zone_set() == ZONE_SETS.campsite_start), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_07800.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : We're sealed in.", true );
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_09200.sound'), false, SPARTANS.vale, 0.0, "", "Vale : That's normal? Maybe?", true );
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_15300.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Goodwin?", true );
					dialog_line_npc( l_dialog_id, 0, not (current_zone_set() == ZONE_SETS.campsite_start), TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_08400.sound'), false, SPARTANS.tanaka, 0.5, "", "Tanaka : Here we go...", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_09300.sound'), false, SPARTANS.vale, 0.0, "", "Vale : (slight laugh)", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
Wake(dormant.plateau_back_to_hub);
PrintNarrative("Narrative END - plateau_soldier_teleport_room_teleport");
end


--                                    WHEN PLAYERS ARE BACK TO THE HUB
function dormant.plateau_back_to_hub()
print("plateau_back_to_hub WOKEN");
SleepUntil([| volume_test_players( VOLUMES.plateau_back_to_hub )], 1);
PrintNarrative("Narrative START - plateau_back_to_hub");

				local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_back_to_hub", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_09700.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : And here we are!", true );
					dialog_line_npc( l_dialog_id, 1, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_09400.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : Will ya look at that?", true );


				l_dialog_id = dialog_end(l_dialog_id, true, true, "");
Wake(dormant.plateau_back_to_hub_constructor);

	-- CHATTER SPARTANS ON
	ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
	
PrintNarrative("Narrative - Switch AI Chatter On");

PrintNarrative("Narrative END - plateau_back_to_hub");
end

--                                    WHEN CONSTRUCTOR START WORKING
function dormant.plateau_back_to_hub_constructor()

PrintNarrative("Narrative START - plateau_back_to_hub");

				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_back_to_hub", l_dialog_id, true, def_dialog_style_queue(), false, "", 0);
--					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_08500.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Constructor's getting right to work.", true );

				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
PrintNarrative("Narrative END - plateau_back_to_hub");
end



-- *******************************************************************************************************************************************************************


--			FOR DEBUG
function plateau_ai_chatter_vs_scripted():void
PrintNarrative("Triggered Long dialogue that doesn't make sense to test Ai Systemic Chatter on top of it.");
				 ai_actor_dialogue_enable(AI.sq_musketeer, false); ai_player_dialogue_enable(false); local l_dialog_id:thread=def_dialog_id_none();
				l_dialog_id = dialog_start_foreground("plateau_soldier_teleport_room_teleport", l_dialog_id, true, def_dialog_style_interrupt(), false, "", 0);
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_07800.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : We're sealed in.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_09200.sound'), false, SPARTANS.vale, 0.0, "", "Vale : That's normal? Maybe?", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_15300.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Goodwin?", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_08400.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Here we go...", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_09300.sound'), false, SPARTANS.vale, 0.0, "", "Vale : (slight laugh)", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_buck_07800.sound'), false, SPARTANS.thorne, 0.0, "", "Buck : We're sealed in.", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_09200.sound'), false, SPARTANS.vale, 0.0, "", "Vale : That's normal? Maybe?", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_locke_15300.sound'), false, SPARTANS.locke, 0.0, "", "Locke : Goodwin?", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_tanaka_08400.sound'), false, SPARTANS.tanaka, 0.0, "", "Tanaka : Here we go...", true );
					dialog_line_npc( l_dialog_id, 0, true, TAG('sound\001_vo\001_vo_scripted\001_vo_scr_w2hubplateau\001_vo_scr_w2hubplateau_un_vale_09300.sound'), false, SPARTANS.vale, 0.0, "", "Vale : (slight laugh)", true );
				l_dialog_id = dialog_end(l_dialog_id, true, true, ""); ai_actor_dialogue_enable(AI.sq_musketeer, true); ai_player_dialogue_enable(true);
end

]]