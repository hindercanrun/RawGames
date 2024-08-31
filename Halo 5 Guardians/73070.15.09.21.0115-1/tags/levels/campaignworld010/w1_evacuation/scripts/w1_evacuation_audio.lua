--## SERVER
-- ==================================================================
-- ========= EVACUATION AUDIO LUA SCRIPT =======================
-- ==================================================================

--=============================  MUSIC  =========================================



function startup.audio_evacuation_thread_up_drive_start()
	print ("MUSIC drive start");
	music_event(TAG('sound\120_music_campaign\evacuation\120_mus_evacuation_drive_start.music_control'));
end

function audio_evacuation_thread_up_drive_exit_bridge()
	print ("MUSIC exit bridge");
	music_event(TAG('sound\120_music_campaign\evacuation\120_mus_evacuation_drive_exit_bridge.music_control'));
end

function audio_evacuation_thread_up_drive_end()
	print ("MUSIC drive end");
	music_event(TAG('sound\120_music_campaign\evacuation\120_mus_evacuation_drive_end.music_control'));
end

function audio_evacuation_thread_up_outpost_clear()
	print ("MUSIC outpost clear");
	music_event(TAG('sound\120_music_campaign\evacuation\120_mus_evacuation_outpost_end.music_control'));
end

function audio_evacuation_thread_up_door_open()
	print ("MUSIC elevator door open");
	music_event(TAG('sound\120_music_campaign\evacuation\120_mus_evacuation_door_open.music_control'));
end

function audio_evacuation_thread_up_elevator_wave01_start()
	print ("MUSIC elevator wave01 start");
	music_event(TAG('sound\120_music_campaign\evacuation\120_mus_evacuation_elevator_wave01_start.music_control'));
end

function audio_evacuation_thread_up_elevator_wave01_end()
	print ("AUDIO: elevator wave01 end music");
	music_event(TAG('sound\120_music_campaign\evacuation\120_mus_evacuation_elevator_wave01_end.music_control'));
end

function audio_evacuation_thread_up_elevator_wave02_start()
	print ("AUDIO: elevator wave02 start music");
	music_event(TAG('sound\120_music_campaign\evacuation\120_mus_evacuation_elevator_wave02_start.music_control'));
end

function audio_evacuation_thread_up_elevator_wave02_end()
	print ("AUDIO: elevator wave02 end music");
	music_event(TAG('sound\120_music_campaign\evacuation\120_mus_evacuation_elevator_wave02_end.music_control'));
end

function audio_evacuation_thread_up_elevator_wave03_start()
	print ("AUDIO: elevator wave03 start music");
	music_event(TAG('sound\120_music_campaign\evacuation\120_mus_evacuation_elevator_wave03_start.music_control'));
end

function audio_evacuation_thread_up_elevator_wave03_end()
	print ("AUDIO: elevator wave03 end music");
	music_event(TAG('sound\120_music_campaign\evacuation\120_mus_evacuation_elevator_wave03_end.music_control'));
end

function audio_evacuation_thread_up_elevator_after_emp()
	print ("AUDIO: elevator after emp music");
	music_event(TAG('sound\120_music_campaign\evacuation\120_mus_evacuation_elevator_after_emp.music_control'));
end

function audio_evacuation_thread_up_elevator_exit()
	print ("AUDIO: elevator exit music");
	music_event(TAG('sound\120_music_campaign\evacuation\120_mus_evacuation_elevator_exit.music_control'));
end

function audio_evacuation_thread_up_scaffold_start()
	print ("AUDIO: evacuation scaffolding music");
	music_event(TAG('sound\120_music_campaign\evacuation\120_mus_evacuation_scaffolding_start.music_control'));
end

function audio_evacuation_thread_up_scaffolding_climax()
	print ("AUDIO: evacuation mission climax music");
	music_event(TAG('sound\120_music_campaign\evacuation\120_mus_evacuation_scaffolding_climax.music_control'));
end

function audio_evacuation_thread_up_scaffold_end()
	print ("AUDIO: evacuation scaffold end music");
	music_event(TAG('sound\120_music_campaign\evacuation\120_mus_evacuation_scaffolding_end.music_control'));
end

function audio_evacuation_stopallmusic():void
	print("AUDIO_Evacuation_StopAllMusic_Blink");
	music_event(TAG('sound\120_music_campaign\evacuation\120_mus_evacuation_stopallmusic.music_control'));
	-- stopping all music in event of blink
end

--=============================  SFX  =========================================
function audio_guardian_roar()
	SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_guardian_w1evacuation_oceanrise_partb.sound'), OBJECTS.audiocrate_guardian_rising, 1);
end


function airraid_alarm_start()
	sleep_s(42);
	print("AirRaid_Alarm_Start");
	PlaySoundPlacement(SOUNDS.airraid_alarm);
	
end

function airraid_alarm_stop()
	sleep_s(89);
	print("AirRaid_Alarm_Start");
	StopSoundPlacement(SOUNDS.airraid_alarm);
	
end

function firstfloor_alarm_start()
	sleep_s(5);
	print("FirstFloor_Alarm_Start");
	PlaySoundPlacement(SOUNDS.firstfloor_elevator_alarm);
	
end

function firstfloor_alarm_stop()
	print("FirstFloor_Alarm_Stop");
	SoundImpulseStartServer(TAG('sound\031_states\031_st_osiris_campaign\031_st_osiris_campaign_w1_evacuation\031_st_osiris_campaign_evacuation_inelevator_alarm_fadeout.sound'), nil, 1);
	sleep_s(5);
	StopSoundPlacement(SOUNDS.firstfloor_elevator_alarm);
end

function firstfloor_alarm_unfilter()
	SoundImpulseStartServer(TAG('sound\031_states\031_st_osiris_campaign\031_st_osiris_campaign_w1_evacuation\031_st_osiris_campaign_evacuation_lobbyalarm_unfilter.sound'), nil, 1);
	print("FirstFloor_Alarm_Filter");
end

function wave_alarm()
	sleep_s(2);
	SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w1evacuation_spaceelevator\018_vin_cp_spaceelevator_wave_alarm.sound'), nil, 1);
	print("WaveAlarm");
end

function audio_space_elevator_int_door()
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_door\004_dm_door_spaceelevator\004_dm_door_spaceelevator_interior_evacuation_open.sound'), OBJECTS.dm_interior_door, "audio_center", 1);
end

function audio_space_elevator_int_door_close()
	SoundImpulseStartMarkerServer(TAG('sound\004_device_machine\004_dm\004_dm_door\004_dm_door_spaceelevator\004_dm_door_spaceelevator_interior_evacuation_close.sound'), OBJECTS.dm_interior_door, "audio_center", 1);
end

function audio_elevatordrop_alarms_activate()
	PlaySoundPlacement(SOUNDS.elevator_alarm_loop_a1);
	PlaySoundPlacement(SOUNDS.elevator_alarm_loop_a2);
	PlaySoundPlacement(SOUNDS.elevator_alarm_loop_a3);
	PlaySoundPlacement(SOUNDS.elevator_alarm_loop_a4);
end

function audio_elevator_unstable_activate()
	PlaySoundPlacement(SOUNDS.elevator_unstable_metalgroan);
end
	
function audio_guardian_crateslam_charge()
	SoundImpulseStartMarkerServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_guardian_w1evacuation_pulse_charge_close.sound'), OBJECTS.audiocrate_guardian_cratetoss, nil, 1);
end		
	
function audio_guardian_crateslam_pulse()
	SoundImpulseStartMarkerServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_guardian_w1evacuation_pulse_blast_tophallway.sound'), OBJECTS.audiocrate_guardian_cratetoss, nil, 1);
end	

function death_pulse_sound_state()
	--SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_global\018_vin_cp_global_guardian\018_vin_cp_global_guardian_deathpulse_blast.sound'), nil, 1);
	--print("DeathPulseSoundState");
end

function audio_metal_rumble()
	SoundImpulseStartServer(TAG('sound\002_ui\002_ui_hud\002_ui_hud_rumble\002_ui_hud_2d_metal_rumble.sound'), nil, 1);
end

function audio_scaffolding_sweetener()
	SoundImpulseStartServer(TAG('sound\018_vignette\018_vin_campaign\018_vin_campaign_w1evacuation_scaffolding\018_vin_campaign_w1evacuation_scaffolding_unstable.sound'), nil, 1);
end

--## CLIENT

function startupClient.EvacuationMixState():void
	sound_impulse_start(TAG('sound\031_states\031_st_osiris_global\031_st_osiris_global_levelloaded\031_st_osiris_global_levelloaded_w1_evacuation.sound'), nil, 1)
end