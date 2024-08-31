--## SERVER
-- ==================================================================
-- ========= SENTINELS AUDIO LUA SCRIPT =======================
-- ==================================================================

function audio_unconfirmedreports_thread_up_uppermines_blank():void
	sleep_s(12)
	print("MUSIC UR UPPERMINES BLANK");
	music_event(TAG('sound\120_music_campaign\unconfirmedreports\120_mus_unconfirmedreports_landing_blank.music_control'));

end

function audio_unconfirmedreports_thread_up_landing_start():void
	print("MUSIC UR LANDING START");
	music_event(TAG('sound\120_music_campaign\unconfirmedreports\120_mus_unconfirmedreports_landing_start.music_control'));

end

function audio_unconfirmedreports_thread_up_landing_waves():void
	print("MUSIC UR LANDING WAVES START");
	music_event(TAG('sound\120_music_campaign\unconfirmedreports\120_mus_unconfirmedreports_landing_waves_start.music_control'));	
	
end

function audio_unconfirmedreports_thread_up_landing_waves_outro():void
	print("MUSIC UR LANDING WAVES OUTRO");
	music_event(TAG('sound\120_music_campaign\unconfirmedreports\120_mus_unconfirmedreports_landing_waves_outro.music_control'));	
	
end

function audio_unconfirmedreports_thread_up_upper_mines():void
	print("MUSIC UR UPPER MINES START");
	music_event(TAG('sound\120_music_campaign\unconfirmedreports\120_mus_unconfirmedreports_uppermines_start.music_control'));

end

function audio_unconfirmedreports_thread_up_waves_start():void
	print("MUSIC UR WAVES START");
	music_event(TAG('sound\120_music_campaign\unconfirmedreports\120_mus_unconfirmedreports_waves_start.music_control'));	
	
end

function audio_unconfirmedreports_thread_up_waves_outro():void
	print("MUSIC UR WAVES OUTRO");
	music_event(TAG('sound\120_music_campaign\unconfirmedreports\120_mus_unconfirmedreports_waves_outro.music_control'));	
	
end

function audio_unconfirmedreports_thread_up_reveal_start():void
	print("MUSIC UR REVEAL START");
	music_event(TAG('sound\120_music_campaign\unconfirmedreports\120_mus_unconfirmedreports_reveal_start.music_control'));	
	
end

function audio_unconfirmedreports_thread_up_elevator_start():void
	print("MUSIC UR ELEVATOR START");
	music_event(TAG('sound\120_music_campaign\unconfirmedreports\120_mus_unconfirmedreports_elevator_start.music_control'));	
	
end

function audio_unconfirmedreports_thread_up_elevator_outro():void
	print("MUSIC UR ELEVATOR OUTRO");
	music_event(TAG('sound\120_music_campaign\unconfirmedreports\120_mus_unconfirmedreports_elevator_outro.music_control'));	
	
end

function audio_unconfirmedreports_thread_up_wardenfight_start():void
	sleep_s(2)
	print("MUSIC UR WARDEN FIGHT START");
	music_event(TAG('sound\120_music_campaign\unconfirmedreports\120_mus_unconfirmedreports_wardenfight_start.music_control'));	
	
end

function audio_unconfirmedreports_thread_up_wardenfight_outro():void
	print("MUSIC UR WARDEN FIGHT OUTRO");
	music_event(TAG('sound\120_music_campaign\unconfirmedreports\120_mus_unconfirmedreports_wardenfight_outro.music_control'));	
	
end

function audio_unconfirmedreports_thread_up_mission_end():void
	print("MUSIC UR MISSION END");
	music_event(TAG('sound\120_music_campaign\unconfirmedreports\120_mus_unconfirmedreports_missionend.music_control'));	
	
end

function audio_unconfirmedreports_stopallmusic():void
	print("AUDIO_Music_UnconfirmedReports_StopAllMusic_Blink");
	music_event(TAG('sound\120_music_campaign\unconfirmedreports\120_mus_unconfirmedreports_stopallmusic.music_control'));
	-- stopping all music in event of blink
end

-- trigger volumes for music
-- ===========================================================================

function startup.audio_arrival_thread_up_scenario_startup()
	CreateThread(AudioMissionStart);
end

t_audioLevelOneoffMusicTable[ZONE_SETS.zs010_chiefship] =
{
	[VOLUMES.tv_audio_landing_safety] = TAG('sound\120_music_campaign\unconfirmedreports\120_mus_unconfirmedreports_landing_start.music_control'),
};

t_audioLevelOneoffMusicTable[ZONE_SETS.zs020_cave] =
{
	[VOLUMES.tv_audio_quarry_door] = TAG('sound\120_music_campaign\unconfirmedreports\120_mus_unconfirmedreports_landing_outro.music_control'),
};

t_audioLevelOneoffMusicTable[ZONE_SETS.zs030_lava_elevator] =
{
	[VOLUMES.tv_audio_elevator] = TAG('sound\120_music_campaign\unconfirmedreports\120_mus_unconfirmedreports_dig_site_elevator.music_control'),
};

-- sfx =============== bleeps =============== bloops =========================
function audio_unconfirmedreports_start_distant_battle()
	SleepUntil( [| volume_test_players( VOLUMES.tv_audio_battle_minerfight_start) ] , 1 );     
		SoundImpulseStartMarkerServer(TAG('sound\003_ambience\003_amb_positional\003_amb_positional_battle\003_amb_positional_battle_minerforerunnerfight_unconfirmed.sound'), OBJECTS.audio_crate_battle_minerfight, nil, 1);
end


function audio_activate_hologram()
	sleep_s(1.5)
	SoundImpulseStartMarkerServer(TAG('sound\003_ambience\003_amb_positional\003_amb_positional_computer\003_amb_positional_computer_keypad\003_amb_positional_computer_keypad_hologram_press_unconfirmed.sound'), OBJECTS.audio_crate_buttonpress_prowler, nil, 1);
	sleep_s(1.5)
	SoundImpulseStartMarkerServer(TAG('sound\003_ambience\003_amb_positional\003_amb_positional_computer\003_amb_positional_computer_keypad\003_amb_positional_computer_keypad_hologram_activate_unconfirmed.sound'), OBJECTS.audio_crate_buttonpress_prowler, nil, 1);
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_devicecontrols\004_dm_accessgranted\004_dm_accessgranted_unconfirmedreports.sound'), OBJECTS.audio_crate_buttonpress_prowler, nil, 1);
end

function audio_activate_turret_a()
	sleep_s(1.2)
	SoundImpulseStartMarkerServer(TAG('sound\003_ambience\003_amb_positional\003_amb_positional_computer\003_amb_positional_computer_keypad\003_amb_positional_computer_keypad_turret_press_unconfirmed.sound'), OBJECTS.audio_crate_buttonpress_turret_a, nil, 1);
	sleep_s(0.7)
	 SoundImpulseStartMarkerServer(TAG('sound\003_ambience\003_amb_positional\003_amb_positional_computer\003_amb_positional_computer_keypad\003_amb_positional_computer_keypad_turret_activate_unconfirmed.sound'), OBJECTS.audio_crate_buttonpress_turret_a, nil, 1);
end

function audio_activate_turret_b()
	sleep_s(1.2)
	SoundImpulseStartMarkerServer(TAG('sound\003_ambience\003_amb_positional\003_amb_positional_computer\003_amb_positional_computer_keypad\003_amb_positional_computer_keypad_turret_press_unconfirmed.sound'), OBJECTS.audio_crate_buttonpress_turret_b, nil, 1);
	sleep_s(0.7)
	SoundImpulseStartMarkerServer(TAG('sound\003_ambience\003_amb_positional\003_amb_positional_computer\003_amb_positional_computer_keypad\003_amb_positional_computer_keypad_turret_activate_unconfirmed.sound'), OBJECTS.audio_crate_buttonpress_turret_b, nil, 1);
end

function audio_airlock_enter_door()
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_door\004_dm_door_spaceelevator\004_dm_door_spaceelevator_interior_unconfirmed_door1open.sound'), OBJECTS.quarry_door_airlock_enter, "audio_center", 1);
end

function audio_airlock_enter_door_close()
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_door\004_dm_door_spaceelevator\004_dm_door_spaceelevator_interior_unconfirmed_door1close.sound'), OBJECTS.quarry_door_airlock_enter, "audio_center", 1);
end

function audio_airlock_exit_door()
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_door\004_dm_door_spaceelevator\004_dm_door_spaceelevator_interior_unconfirmed_door2open.sound'), OBJECTS.quarry_door_airlock_exit, "audio_center", 1);
end

function audio_earthquake()
	SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w1unconfirmedreports_earthquake\018_vin_campaign_w1unconfirmedreports_earthquake.sound'), nil, 1); 
end

function audio_cinematic_mute_unconfirmedreports()
	SoundImpulseStartServer(TAG('sound\031_states\031_st_osiris_campaign_cinematics\031_st_osiris_campaign_cinematic_black_screen.sound'), nil, 1);
end

--## CLIENT

function startupClient.UnconfirmedReportsMixState():void
	sound_impulse_start(TAG('sound\031_states\031_st_osiris_global\031_st_osiris_global_levelloaded\031_st_osiris_global_levelloaded_w1_unconfirmedreports.sound'), nil, 1)
end
