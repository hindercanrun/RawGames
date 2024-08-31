--## SERVER
-- ==================================================================
-- ========= TSUNAMI LOCKE AUDIO LUA SCRIPT =======================
-- ==================================================================
	
function audio_mission_start():void
	print ("Starting music for Mission Start");
	music_event(TAG('sound\120_music_campaign\tsunami\120_mus_tsunami_mission_start.music_control'));
end

function audio_turrettown_musicstart():void
	sleep_s(3);
	print ("Starting music for <TURRETTOWN>");
	music_event(TAG('sound\120_music_campaign\tsunami\120_mus_tsunami_turrettown_start.music_control'));
end

--[[function audio_turrettown_outro():void
	print ("Ending music for <TURRETTOWN>");
	music_event(TAG('sound\120_music_campaign\tsunami\120_mus_tsunami_turrettown_outro.music_control'));
end--]]

function audio_underbelly_musicstart():void
	print ("Starting music for UNDERBELLY");
	music_event(TAG('sound\120_music_campaign\tsunami\120_mus_tsunami_underbelly_start.music_control'));
end

function audio_underbelly_firstwave():void
	print ("Changing music for <UNDERBELLY_FIRSTWAVE>");
	music_event(TAG('sound\120_music_campaign\tsunami\120_mus_tsunami_underbelly_firstwave.music_control'));
end

function audio_underbelly_middlewave():void
	sleep_s(2);
	print ("Changing music for <UNDERBELLY_MIDDLEWAVE>");
	music_event(TAG('sound\120_music_campaign\tsunami\120_mus_tsunami_underbelly_middlewave.music_control'));
end

function audio_underbelly_outro():void
	print ("Ending music for <UNDERBELLY_OUTRO>");
	music_event(TAG('sound\120_music_campaign\tsunami\120_mus_tsunami_underbelly_outro.music_control'));
end

function audio_tsunami_destruction_alley_elevator_start():void
	print ("Audio_starting music on elevator start");
	music_event(TAG('sound\120_music_campaign\tsunami\120_mus_tsunami_destruction_alley_elevator_start.music_control'));
end

function audio_tsunami_dead_bodies():void
	print ("Audio_switching music on dead bodies see");
	music_event(TAG('sound\120_music_campaign\tsunami\120_mus_tsunami_dead_people.music_control'));
end

function audio_tsunami_destruction_walkway():void
	print ("Audio_starting music on walkway start");
	music_event(TAG('sound\120_music_campaign\tsunami\120_mus_tsunami_destruction_walkway_start.music_control'));
end

function audio_tsunami_destruction_walkway_end():void
	print ("Audio_starting music on walkway end");
	music_event(TAG('sound\120_music_campaign\tsunami\120_mus_tsunami_destruction_walkway_end.music_control'));
end

function audio_tsunami_warden_fight():void
	print ("Audio_switching music on <WARDENFIGHT_START>t");
	music_event(TAG('sound\120_music_campaign\tsunami\120_mus_tsunami_warden_start.music_control'));
end

function audio_warden_musicend():void
	print ("Ending music for <WARDENFIGHT_COMBATEND>");
	music_event(TAG('sound\120_music_campaign\tsunami\120_mus_tsunami_warden_end.music_control'));
end

function audio_tsunami_stopallmusic():void
	print("AUDIO_Music_Tsunami_StopAllMusic_Blink");
	music_event(TAG('sound\120_music_campaign\tsunami\120_mus_tsunami_stopallmusic.music_control'));
	-- stopping all music in event of blink
end

-- ========= SFX =======================

function audio_grunt_elevator()
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_elevator\004_dm_elevator_tsunami\004_dm_elevator_tsunami_gruntride.sound'), OBJECTS.dm_elev_2, "audio_center", 1);
end

function audio_elevator_buttonpress_a()	-- Elevator control in Turrettown that leads to Underbelly
	sleep_s(0.8);
	SoundImpulseStartServer(TAG('sound\004_device_machine\004_dm\004_dm_elevator\004_dm_elevator_tsunami\004_dm_elevator_tsunami_buttonpress.sound'), OBJECTS.audio_elevator_buttonpress_a, 1);
end

function audio_elevator_buttonpanelloop_start_a()	-- Elevator control in Turrettown that leads to Underbelly
	PlaySoundPlacement(SOUNDS.elevator_panel_loop_a);
end

function audio_elevator_buttonpanelloop_stop_a()	-- Elevator control in Turrettown that leads to Underbelly
	StopSoundPlacement(SOUNDS.elevator_panel_loop_a);
end

function audio_elevator_buttonpanelloop_start_b()	-- Elevator control in Underbelly that leads to Arcade/Destruction Alley
	PlaySoundPlacement(SOUNDS.elevator_panel_loop_b);	-- this might be uncessary since we don't see the panel activate. 
end

function audio_elevator_buttonpanelloop_stop_b()	-- Elevator control in Underbelly that leads to Arcade/Destruction Alley
	StopSoundPlacement(SOUNDS.elevator_panel_loop_b);
end

function audio_elevator_buttonpress_b() -- Elevator control in Underbelly that leads to Arcade/Destruction Alley
	sleep_s(0.8);
	SoundImpulseStartServer(TAG('sound\004_device_machine\004_dm\004_dm_elevator\004_dm_elevator_tsunami\004_dm_elevator_tsunami_buttonpressb.sound'), OBJECTS.audio_elevator_buttonpress_b, 1);
end

function audio_elevator_down()
	SoundImpulseStartServer(TAG('sound\004_device_machine\004_dm\004_dm_elevator\004_dm_elevator_tsunami\004_dm_elevator_tsunami_down_start.sound'), nil, 1);
	SleepUntil([|  device_get_position(OBJECTS.dm_elev_1) >= 0.99 ] , 1);
		SoundImpulseStartServer(TAG('sound\004_device_machine\004_dm\004_dm_elevator\004_dm_elevator_tsunami\004_dm_elevator_tsunami_down_stop.sound'), nil, 1);
end

function audio_elevator_up()
	SoundImpulseStartServer(TAG('sound\004_device_machine\004_dm\004_dm_elevator\004_dm_elevator_tsunami\004_dm_elevator_tsunami_up_start.sound'), nil, 1);
	SleepUntil([|  device_get_position(OBJECTS.dm_elev_2) >= 0.99 ] , 1);
		SoundImpulseStartServer(TAG('sound\004_device_machine\004_dm\004_dm_elevator\004_dm_elevator_tsunami\004_dm_elevator_tsunami_up_stop.sound'), nil, 1);
end

function audio_grunt_chant_stop():void
	print ("Stopping Audio Grunt Chant Loop");
	StopSoundPlacement(SOUNDS.grunt_chant);
	SoundImpulseStartServer(TAG('sound\003_ambience\003_amb_positional\003_amb_positional_level\003_amb_positional_level_tsunami\003_amb_positional_level_tsunami_gruntchantstopped.sound'), nil, 1);
end

function audio_guardian_elevator_reveal()
	SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_guardian_w2tsunami_elevatorreveal.sound'), OBJECTS.audio_guardian_elevator_reveal, 1);
end

function audio_guardian_idle_loop_start()
	print ("guardian_idle_loop_start");
	sound_looping_start(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_guardian_w2tsunami_idle_loop.sound_looping'), OBJECTS.audio_guardian_idle, 1);
end

function audio_guardian_idle_loop_stop()
	print ("guardian_idle_loop_stop");
	sound_looping_stop(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_guardian_w2tsunami_idle_loop.sound_looping'));
end

-- trigger volumes
-- ===========================================================================

function startup.audio_tsunami_thread_up_scenario_startup()
	CreateThread(AudioMissionStart);
end

--## CLIENT

function startupClient.TsunamiMixState():void
	sound_impulse_start(TAG('sound\031_states\031_st_osiris_global\031_st_osiris_global_levelloaded\031_st_osiris_global_levelloaded_w2_tsunami.sound'), nil, 1)
	
	--(wesleyg) PIN OCEAN MATERIALS - for players dropping in mid-mission 
	-- Need to pin these ocean materials for the entire mission so that the texture streamer doesn't cause the ocean mips to pop
	-- Gabe recommended placing these pinning calls here since we need to account for players dropping in mid-mission
	print ("ocean materials pinned");
	streamer_pin_tag(TAG('levels\assets\osiris\prefabs\sangheli\tsunami_station\ts_ocean_patch\materials\tsunami_station_ocean.material'));
	streamer_pin_tag(TAG('levels\assets\osiris\prefabs\sangheli\tsunami_station\ts_ocean_patch\materials\tsunami_station_ocean_cin160.material'));
	streamer_pin_tag(TAG('levels\assets\osiris\prefabs\sangheli\tsunami_station\ts_ocean_patch\materials\tsunami_station_ocean_outer.material'));
end
