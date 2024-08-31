--## SERVER
-- ==================================================================
-- ========= BUILDER AUDIO LUA SCRIPT =======================
-- ==================================================================

-- MUSIC
-- ===================================================================

function audio_builder_thread_up_mission_start():void
	print("MUSIC_Builder_Mission_Start");
	music_event(TAG('sound\120_music_campaign\builder\120_mus_builder_mission_start.music_control'));
end

function audio_builder_thread_up_patrol_start():void
	print("MUSIC_Builder_Patrol_Start");
	music_event(TAG('sound\120_music_campaign\builder\120_mus_builder_patrol_start.music_control'));
end

function audio_builder_thread_up_patrol_outro():void
	print("AUDIO_Music_Builder_Patrol_Outro");
	music_event(TAG('sound\120_music_campaign\builder\120_mus_builder_patrol_outro.music_control'));
end

function audio_builder_thread_up_caves_start():void
	print("MUSIC caves start")
	music_event(TAG('sound\120_music_campaign\builder\120_mus_builder_caves.music_control'));
end

function audio_builder_thread_up_caves_warden():void
	print("MUSIC Caves Warden");
	music_event(TAG('sound\120_music_campaign\builder\120_mus_builder_caves_warden.music_control'));
end

function audio_builder_thread_up_caves_outro():void
	print("MUSIC Caves Outro");
	music_event(TAG('sound\120_music_campaign\builder\120_mus_builder_caves_outro.music_control'));
end

--[[function audio_builder_thread_up_elevator_start():void
	print("MUSIC_Builder_Elevator_Start");
	music_event(TAG('sound\120_music_campaign\builder\120_mus_builder_elevator_start.music_control'));
end--]]

function audio_builder_thread_up_vtol_start():void
	print("AUDIO_Music_Builder_vtol_Start");
	music_event(TAG('sound\120_music_campaign\builder\120_mus_builder_vtol_start.music_control'));
end

function audio_builder_thread_up_vtol_end():void
	print("AUDIO_Music_Builder_vtol_End");
	music_event(TAG('sound\120_music_campaign\builder\120_mus_builder_vtol_stop.music_control'));
end

function audio_builder_stopallmusic():void
	print("AUDIO_Music_Builder_StopAllMusic_Blink");
	music_event(TAG('sound\120_music_campaign\builder\120_mus_builder_stopallmusic.music_control'));
	-- stopping all music in event of blink
end

-- trigger volumes
-- ===========================================================================

function startup.audio_builder_thread_up_scenario_startup()
	CreateThread(AudioMissionStart);
end
	
--[[t_audioLevelOneoffMusicTable[ZONE_SETS.zn_canyon] =
	{
		[VOLUMES.tv_audio_vtol_combat_start] = TAG('sound\120_music_campaign\builder\120_mus_builder_vtol_combat.music_control'),
	};--]]

function audio_enter_vtol_canyon():void 
    SleepUntil( [| volume_test_players( VOLUMES.tv_audio_enter_vtol_canyon) ] , 1 );     
		StopSoundPlacement(SOUNDS.gateway_source_level_3)
end
	
function audio_gateway_final_reveal():void 
    SleepUntil( [| volume_test_players( VOLUMES.tv_audio_final_gateway_activate) ] , 1 );     
		PlaySoundPlacement(SOUNDS.gateway_source_level_4)
		SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_gateway\004_dm_gateway_builder_storyfocus_a.sound'), OBJECTS.audio_crate_gateway, nil, 1);
end
	
-- SFX
-- ===========================================================================

function audio_cinematic_mute_builder()
	SoundImpulseStartServer(TAG('sound\031_states\031_st_osiris_campaign_cinematics\031_st_osiris_campaign_cinematic_black_screen.sound'), nil, 1);
end

--[[function audio_builder_gateway_a_trigger_up()
	sleep_s(1)
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_gateway\004_dm_gateway_builder_trigger_activate.sound'), OBJECTS.dc_builder_investigate, "front", 1);
end]]

	
function audio_builder_thread_up_vtol_door_open()
	sleep_s (0.5);
	SoundImpulseStartServer(TAG('sound\004_device_machine\004_dm\004_dm_door\004_dm_door_builder_vtol_reveal\004_dm_door_builder_vtol_reveal.sound'), nil, 1);
	--sound_impulse_start_client(TAG('sound\004_device_machine\004_dm\004_dm_door\004_dm_door_builder_vtol_reveal\004_dm_door_builder_vtol_reveal.sound'), nil, 1);
end

function audio_builder_lightbridge_activate_a():void
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_lightbridge\004_dm_lightbridge_activate_builder.sound'), OBJECTS.marsh_lightbridge, nil, 1);
	PlaySoundPlacement(SOUNDS.lightbridge_a_left);
	PlaySoundPlacement(SOUNDS.lightbridge_a_right);
end

function audio_builder_lightbridge_activate_b():void
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_lightbridge\004_dm_lightbridge_activate_builder.sound'), OBJECTS.docks_front_bridge, nil, 1);
	PlaySoundPlacement(SOUNDS.lightbridge_b_left);
	PlaySoundPlacement(SOUNDS.lightbridge_b_right);
end

function audio_builder_lightbridge_activate_c():void
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_lightbridge\004_dm_lightbridge_activate_builder.sound'), OBJECTS.docks_side_bridge, nil, 1);
	PlaySoundPlacement(SOUNDS.lightbridge_c_left);
	PlaySoundPlacement(SOUNDS.lightbridge_c_right);
end

function audio_gateway_deactivate_a():void 
    SleepUntil( [| volume_test_players( VOLUMES.tv_audio_gateway_deactivate_a) ] , 1 );     
		StopSoundPlacement(SOUNDS.gateway_source_level_1)
end

--## CLIENT

function startupClient.BuilderMixState():void
	sound_impulse_start(TAG('sound\031_states\031_st_osiris_global\031_st_osiris_global_levelloaded\031_st_osiris_global_levelloaded_w3_builder.sound'), nil, 1)
end