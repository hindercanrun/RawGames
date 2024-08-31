--## SERVER

-- Covenant World, Audio Scripts 

-- thread up scripts
-- called from mission script 
-- =============================

function audio_plateau_thread_up():void																-- called from mission script, upon mission start
	print("AUDIO_Thread_Up");
	
	CreateThread(audio_plateau_thread_up_plateau_start);
	CreateThread(audio_plateau_thread_up_plateau_crevice);
	CreateThread(audio_bird_reveal);
	CreateThread(AudioMissionStart);
	CreateThread(audio_sentryreveal_flocking_begin);
	CreateThread(audio_sentryramp_flocking_begin);
	
end

function audio_plateau_thread_up_plateau_start():void
	SleepUntil([|current_zone_set() == ZONE_SETS.plateau_start], 5);
--		print("AUDIO_Zone_Plateau_Start");
		CreateThread(audio_plateau_sentryreveal_start);
end

function audio_plateau_thread_up_plateau_crevice():void
	SleepUntil([|current_zone_set() == ZONE_SETS.plateau_crevice], 5);
--		print("AUDIO_Zone_Plateau_Crevice");
		CreateThread(audio_plateau_playerinvtol);
end


-- music pieces
-- =============================

--sentry reveal start																			--trigger volume
function audio_plateau_sentryreveal_start():void												-- this is the 3D audio chant
	SleepUntil( [| volume_test_players(VOLUMES.tv_audio_sentryreveal_start)] );
	music_event(TAG('sound\120_music_campaign\plateau\120_mus_plateau_lc_sentryreveal_start.music_control'));
	CVSChantHackServer();
end

-- SS horn blast																				-- called from mission script
function audio_plateau_sentrylaunched ():void
	print("AUDIO_SentryLaunched");
	music_event(TAG('sound\120_music_campaign\plateau\120_mus_plateau_ep_sentryreveal_sentrylaunched.music_control'));
end

function audio_plateau_sentryreveal_outro ():void
	print("AUDIO_SentryReveal_Outro");
	music_event(TAG('sound\120_music_campaign\plateau\120_mus_plateau_lc_sentryreveal_stop.music_control'));
end

function audio_plateau_ramp_start ():void
	print("AUDIO_RampStart");
	music_event(TAG('sound\120_music_campaign\plateau\120_mus_plateau_ramp_start.music_control'));
end

function audio_plateau_ramp_outro ():void
	print("AUDIO_RampOutro");
	music_event(TAG('sound\120_music_campaign\plateau\120_mus_plateau_ramp_outro.music_control'));
end

--[[function audio_plateau_bowl_combat2 ():void
	print("AUDIO_BowlCombat2");
	music_event(TAG('sound\120_music_campaign\plateau\120_mus_plateau_lc_bowl_combat_02.music_control'));
end--]]

-- Bowl Outro  																					-- called from mission script
function audio_plateau_bowl_outro ():void
	print("AUDIO_BowlOutro");
	music_event(TAG('sound\120_music_campaign\plateau\120_mus_plateau_lc_bowl_stop.music_control'));
end

--countdown start																				-- called from mission script
function audio_plateau_countdownstarted ():void
	print("AUDIO_CountdownStarted");
	music_event(TAG('sound\120_music_campaign\plateau\120_mus_plateau_ep_sentrybattle_countdownstarted.music_control'));
	--StopSoundPlacement(SOUNDS.sentryship_greenlight_a);											-- hijacking this event to kill positional ambience
	--StopSoundPlacement(SOUNDS.sentryship_greenlight_b);
	--StopSoundPlacement(SOUNDS.sentryship_hiss_a01);
	--StopSoundPlacement(SOUNDS.sentryship_hiss_a02);
	--StopSoundPlacement(SOUNDS.sentryship_hiss_a03);
	--StopSoundPlacement(SOUNDS.sentryship_hiss_b01);
	--StopSoundPlacement(SOUNDS.sentryship_hiss_b02);
	--StopSoundPlacement(SOUNDS.sentryship_hiss_b03);
end

--Sentry Ship Boss Start																			-- called from mission script
function audio_plateau_sentrybattle_start ():void
	print("AUDIO_SentrybattleStart");
	music_event(TAG('sound\120_music_campaign\plateau\120_mus_plateau_lc_sentrybattle_start.music_control'));
	sound_impulse_start_marker_server(TAG('\sound\018_vignette\018_vin_campaign\018_vin_campaign_w2plateau_sentryship\018_vin_cp_sentryshipbattle_horn.sound'), OBJECTS.vin_sent_machine, "mid_weapon_1", 1);
	sleep_s(20);
	b_sentry_horn_2 = true
	--print("Narrative_State_Test");
end

--Enter VTOL 
function audio_plateau_playerinvtol():void
     SleepUntil([| at_least_one_player_is_in_a_vtol() ], 10);
     music_event(TAG('sound\120_music_campaign\plateau\120_mus_plateau_ep_sentrybattle_vtol_enter.music_control'));
end

function at_least_one_player_is_in_a_vtol():boolean
     local var_players:object_list = players();
     for _,obj in ipairs(var_players) do
           if   (         unit_in_vehicle_type(obj, 20)
                     or   unit_in_vehicle_type(obj, 40)
                )then          
                return(true);
           end
     end
     return(false);
end

--Sentry Ship Explosion																			-- called from mission script
function audio_plateau_sentrydestroyed ():void
	print("AUDIO_SentryDestroyed");
	music_event(TAG('sound\120_music_campaign\plateau\120_mus_plateau_ep_sentrybattle_sentrydestroyed.music_control'));
end

--Soldier Room Door Opens																		-- called from mission script
function audio_plateau_soldierroom_start ():void
	print("AUDIO_SoldierRoomStart");
	music_event(TAG('sound\120_music_campaign\plateau\120_mus_plateau_lc_soldier_start.music_control'));
end

--Soldier Room Combat																		-- called from mission script
function audio_plateau_soldierroom_combat ():void
	print("AUDIO_SoldierRoomCombat");
	music_event(TAG('sound\120_music_campaign\plateau\120_mus_plateau_soldier_combat.music_control'));
end

--Cleared Soldier Room																			-- called from mission script
function audio_plateau_soldierroom_end ():void
	print("AUDIO_SoldierRoomEnd");
	music_event(TAG('sound\120_music_campaign\plateau\120_mus_plateau_soldier_end.music_control'));
end

--stop all music on blink																		-- called from mission script
function audio_plateau_stopallmusic ():void
	music_event(TAG('sound\120_music_campaign\plateau\120_mus_plateau_stopallmusic.music_control'));
end



-- trigger volumes
-- ===================================================================

-- one off volumes

--sentry reveal stop
t_audioLevelOneoffMusicTable[ZONE_SETS.plateau_start] =
{
	[VOLUMES.tv_audio_sentryreveal_stop] = TAG('sound\120_music_campaign\plateau\120_mus_plateau_lc_sentryreveal_stop.music_control'),
};

-- ramp outro safety
t_audioLevelOneoffMusicTable[ZONE_SETS.plateau_ramp] =
{
	[VOLUMES.tv_audio_ramp_outro] = TAG('sound\120_music_campaign\plateau\120_mus_plateau_ramp_outro.music_control'),
};

--bowl progress

t_audioLevelOneoffMusicTable[ZONE_SETS.plateau_transition] =
{
	[VOLUMES.tv_audio_bowl_start] = TAG('sound\120_music_campaign\plateau\120_mus_plateau_lc_bowl_start.music_control'),
	[VOLUMES.tv_audio_ramp_outro] = TAG('sound\120_music_campaign\plateau\120_mus_plateau_ramp_outro.music_control'),

};

t_audioLevelOneoffMusicTable[ZONE_SETS.plateau_bowl] =
{
	[VOLUMES.tv_audio_bowl_combat_01] = TAG('sound\120_music_campaign\plateau\120_mus_plateau_lc_bowl_combat_01.music_control'),
	--[VOLUMES.tv_audio_bowl_combat_02] = TAG('sound\120_music_campaign\plateau\120_mus_plateau_lc_bowl_combat_02.music_control'),

};


--[[t_audioOneoffPositionalSoundTable[ZONE_SETS.plateau_start] =
{
	--inside =
	--{
		[VOLUMES.tv_bird] = 
		{
			soundtag = TAG('sound\003_ambience\003_amb_baseair\003_amb_baseair_campaign\003_amb_baseair_campaign_plateau\003_amb_baseair_campaign_plateau_breach_int_birdflyaway_stinger.sound'),
			object = "bird_crate",
		},
	--}, 
};--]]


--dynamic volumes
--sentryship player location check
t_audioLevelDynamicMusicTable[ZONE_SETS.plateau_crevice] =
{
	[VOLUMES.tv_audio_area_sentryship] = TAG('sound\120_music_campaign\plateau\120_mus_plateau_ar_sentryship.music_control'),
	[VOLUMES.tv_audio_area_sentryship_lower] = TAG('sound\120_music_campaign\plateau\120_mus_plateau_ar_sentryship_lower.music_control'),
};

--bowl player location check
--[[t_audioLevelDynamicMusicTable[ZONE_SETS.plateau_bowl] =
{
	--default = TAG('sound\120_music_campaign\plateau\120_mus_plateau_ar_bowl_main.music_control'),
	--[VOLUMES.tv_audio_area_bowl_secretpath] = TAG('sound\120_music_campaign\plateau\120_mus_plateau_ar_bowl_secretpath.music_control'),
	--[VOLUMES.tv_audio_area_bowl_leftpath] = TAG('sound\120_music_campaign\plateau\120_mus_plateau_ar_bowl_leftpath.music_control'),
	--[VOLUMES.tv_audio_area_bowl_rightpath] = TAG('sound\120_music_campaign\plateau\120_mus_plateau_ar_bowl_rightpath.music_control'),
};--]]


-- SFX
-- ============================================================================
function audio_teleport_to_basecamp_in():void
	sound_impulse_start_server(TAG('sound\004_device_machine\004_dm_vfx\004_dm_vfx_artifactroom_teleport\004_dm_vfx_artifactroom_teleport_in.sound'), nil, 1);
end

function audio_teleport_to_basecamp_out():void
	sound_impulse_start_server(TAG('sound\004_device_machine\004_dm_vfx\004_dm_vfx_artifactroom_teleport\004_dm_vfx_artifactroom_teleport_out.sound'), nil, 1);
end

function audio_plateau_temple_tracking_opening():void
	sound_impulse_start_marker_server(TAG('sound\004_device_machine\004_dm_anim\004_dm_anim_large_templedoor\004_dm_anim_large_templedoor_unlock_l.sound'), OBJECTS.dm_temple_door, "fx_door_piece_02", 1);
	sound_impulse_start_marker_server(TAG('sound\004_device_machine\004_dm_anim\004_dm_anim_large_templedoor\004_dm_anim_large_templedoor_unlock_r.sound'), OBJECTS.dm_temple_door, "fx_door_piece_01", 1);
end

function audio_pelican_ride_idle():void
	sound_impulse_start_marker_server(TAG('sound\009_vehicle\009_veh_un_pelican\009_veh_un_pelican_vignette_shared\009_veh_un_pelican_vignette_shared_idle_loop.sound'), OBJECTS.v_pelican_flight, "", 1);
end
function audio_pelican_ride_startup():void
	sound_impulse_start_server(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w2plateau_pelican\018_vin_cp_w2plateau_pelican_rideics_startup.sound'), nil, 1);
end
function audio_pelican_ride():void
	sound_impulse_start_server(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w2plateau_pelican\018_vin_cp_w2plateau_pelican_rideics.sound'), nil, 1);
end
function audio_pelican_ride_winddown():void
--	sound_impulse_start_marker_server(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w2plateau_pelican\018_vin_cp_w2plateau_pelican_rideics_turbine_winddown.sound'), OBJECTS.v_pelican_flight, "", 1);
end
function audio_newobjective_beep():void
	sound_impulse_start_server(TAG('sound\002_ui\002_ui_hud\002_ui_hud_ingame\002_ui_hud_2d_ingame_newobjective.sound'), nil, 1);
end
function audio_emp_blast():void
	sound_impulse_start_marker_server(TAG('sound\004_device_machine\004_dm\004_dm_emp\004_dm_emp_burst.sound'), OBJECTS.dc_scan_shieldgenerator, "front", 1);
end
function audio_sentryreveal_horn_breach():void
	sound_impulse_start_marker_server(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w2plateau_sentryship\018_vin_cp_sentryshipreveal_revealhorn.sound'), OBJECTS.vin_sent_machine, "mid_weapon_1", 1);
	sleep_s(13);
	b_sentry_horn_1 = true;
	print("b_sentry_horn_1 TRUE");
end
function audio_missionstart_countdown():void
	sound_impulse_start_server(TAG('sound\002_ui\002_ui_hud\002_ui_hud_ingame\002_ui_hud_2d_ingame_missionstart_countdown.sound'), nil, 1);
end

function audio_bird_reveal():void 
    SleepUntil( [| volume_test_players( VOLUMES.tv_bird) ] , 1 );     
		SoundImpulseStartMarkerServer(TAG('sound\003_ambience\003_amb_baseair\003_amb_baseair_campaign\003_amb_baseair_campaign_plateau\003_amb_baseair_campaign_plateau_breach_int_birdflyaway_stinger.sound'), OBJECTS.bird_crate, nil, 1);
end;

function audio_sentryreveal_flocking_begin():void
	SleepUntil( [| volume_test_players( VOLUMES.tv_audio_reveal_sentryflockingstart) ] , 1 );
		SoundImpulseStartMarkerServer(TAG('sound\003_ambience\003_amb_positional\003_amb_positional_battle\003_amb_positional_battle_bansheefight_a_begin_plateau.sound'), OBJECTS.audio_crate_sentry_reveal_flocks, nil, 1);
end

function audio_sentryramp_flocking_begin():void
	SleepUntil( [| volume_test_players( VOLUMES.tv_audio_ramp_sentryflockingstart) ] , 1 );
		SoundImpulseStartMarkerServer(TAG('sound\003_ambience\003_amb_positional\003_amb_positional_battle\003_amb_positional_battle_bansheefight_b_begin_plateau.sound'), OBJECTS.audio_crate_sentry_ramp_flocks, nil, 1);
end

--function audio_sentryramp_flocking_end():void
--	SoundImpulseStartMarkerServer(TAG('sound\003_ambience\003_amb_positional\003_amb_positional_battle\003_amb_positional_battle_bansheefight_a_end_plateau.sound'), OBJECTS.audio_crate_sentry_ramp_flocks, 1);
--end

function audio_temple_statue_trigger():void    
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_statue\004_dm_statue_twistdown_plateau.sound'), OBJECTS.audio_crate_temple_statue, nil, 1);
end;

function audio_soldierroom_hologram_activate():void
	PlaySoundPlacement(SOUNDS.hologram);
end;

function audio_soldierroom_hologram_deactivate():void
	StopSoundPlacement(SOUNDS.hologram);
end;

function audio_hanger_door_open():void
	sound_impulse_start_marker_server(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w2plateau_sentryship\018_vin_cp_sentryshipbattle_dooropen.sound'), OBJECTS.vin_sent_machine_2, "audio_door1_mid", 1);
end
function audio_hanger_door_open_2():void
	sound_impulse_start_marker_server(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w2plateau_sentryship\018_vin_cp_sentryshipbattle_dooropen.sound'), OBJECTS.vin_sent_machine_2, "audio_door2_mid", 1);
end

function audio_iris_open():void 
    SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_door\004_dm_door_forerunner_iris\004_dm_door_forerunner_iris_open.sound'), OBJECTS.iris_door_crate, nil, 1);
end;

-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- ONLY CLIENT/SERVER CODE BEYOND THIS POINT, thanks in advance.
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

function CVSChantHackServer():void
	RunClientScript("CVSChantHackClient");
end

function sound_impulse_start_marker_server(soundTag:tag, theObject:object, theMarker:string, theScale:number):void
	RunClientScript("sound_impulse_start_marker_client", soundTag, theObject, theMarker, theScale);
end

function sound_impulse_start_server(soundTag:tag, theObject:object, theScale:number):void
	RunClientScript("sound_impulse_start_client", soundTag, theObject, theScale);
end

--## CLIENT

function remoteClient.CVSChantHackClient()
	music_set_position_object(OBJECTS.audio_crate_covenant_chanting, nil);
end

function remoteClient.sound_impulse_start_marker_client(soundTag:tag, theObject:object, theMarker:string, theScale:number)
	sound_impulse_start_marker(soundTag, theObject, theMarker, theScale);
end

function remoteClient.sound_impulse_start_client(soundTag:tag, theObject:object, theScale:number)
	sound_impulse_start(soundTag, theObject, theScale);
end

function startupClient.PlateauMixState():void
	sound_impulse_start(TAG('sound\031_states\031_st_osiris_global\031_st_osiris_global_levelloaded\031_st_osiris_global_levelloaded_w2_plateau.sound'), nil, 1)
end
