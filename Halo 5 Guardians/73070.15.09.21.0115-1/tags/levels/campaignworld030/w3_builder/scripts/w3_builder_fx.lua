
-- fx_target_clean

--## SERVER


--	Temple 1 Console Interact - Touch Pulse //
function fx_temple1_console_interact_touch_pulse()
RunClientScript("fx_temple1_console_interact_touch_pulse");
end

--	Temple 1 Console Interact - Center Pulse Large //
function fx_temple1_console_interact_pulse_lg()
RunClientScript("fx_temple1_console_interact_pulse_lg");
end

--	Temple 1 Console Interact - Icon Slide //
function fx_temple1_console_interact_icon_slide()
RunClientScript("fx_temple1_console_interact_icon_slide");
end


--	Temple 2 Console Interact - Touch Pulse //
function fx_temple2_console_interact_touch_pulse()
RunClientScript("fx_temple2_console_interact_touch_pulse");
end

--	Temple 2 Console Interact - Center Pulse Large //
function fx_temple2_console_interact_pulse_lg()
RunClientScript("fx_temple2_console_interact_pulse_lg");
end

--	Temple 2 Console Interact - Icon Rotate //
function fx_temple2_console_interact_icon_rotate()
RunClientScript("fx_temple2_console_interact_icon_rotate");
end

--	Temple 2 Console Interact - Icon Slide //
function fx_temple2_console_interact_icon_slide()
RunClientScript("fx_temple2_console_interact_icon_slide");
end


--	Temple 3 Console Interact - Touch Pulse //
function fx_temple3_console_interact_touch_pulse()
RunClientScript("fx_temple3_console_interact_touch_pulse");
end

--	Temple 3 Console Interact - Center Pulse Large //
function fx_temple3_console_interact_pulse_lg()
RunClientScript("fx_temple3_console_interact_pulse_lg");
end

--	Temple 3 Console Interact - Icon Rotate //
function fx_temple3_console_interact_icon_rotate()
RunClientScript("fx_temple3_console_interact_icon_rotate");
end


--	Temple 3 Console Interact - Icon Slide //
function fx_temple3_console_interact_icon_slide()
RunClientScript("fx_temple3_console_interact_icon_slide");
end


--	Temple Console Main - Kill Temple 1 Icon //
function fx_temple_console_kill_icon_01()
RunClientScript("fx_temple_console_kill_icon_01");
end

--	Temple Console Main - Kill Temple 2 Icon //
function fx_temple_console_kill_icon_02()
RunClientScript("fx_temple_console_kill_icon_02");
end

--	Temple Console Main - Kill Temple 3 Icon //
function fx_temple_console_kill_icon_03()
RunClientScript("fx_temple_console_kill_icon_03");
end


--	Temple Console Main - Kill Circular Base Energy //
function fx_temple_2_kill_base_energy()
RunClientScript("fx_temple_2_kill_base_energy");
end






--## CLIENT


function startupClient.triggerFXStart()
                print ("starting fx trigger");
		
			repeat
                      
					  SleepUntil ([| volume_test_object(VOLUMES.fx_outcrop_trig_01, PLAYERS.local0) ], 1);
					  print ("spawn bugs fx");
                      effect_attached_to_camera_new(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs.effect'));
					  
					
                      SleepUntil ([| not volume_test_object(VOLUMES.fx_outcrop_trig_01, PLAYERS.local0) ], 1);
					  print ("kill bugs fx");
                      effect_attached_to_camera_stop(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs.effect'));			                              
          until false;

end
function startupClient.triggerFXStart02()
                print ("starting fx trigger02");
		
			repeat
                      
					  SleepUntil ([| volume_test_object(VOLUMES.fx_outcrop_trig_02, PLAYERS.local0) ], 1);
					  print ("spawn bugs fx 02");
                      effect_attached_to_camera_new(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs_02.effect'));
					  
					
                      SleepUntil ([| not volume_test_object(VOLUMES.fx_outcrop_trig_02, PLAYERS.local0) ], 1);
					  print ("kill bugs fx 02");
                      effect_attached_to_camera_stop(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs_02.effect'));			                              
          until false;

end
function startupClient.triggerFXStart03()
                print ("starting fx trigger03");
		
			repeat
                      
					  SleepUntil ([| volume_test_object(VOLUMES.fx_outcrop_trig_03, PLAYERS.local0) ], 1);
					  print ("spawn bugs fx 03");
                      effect_attached_to_camera_new(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs.effect'));
					  
					
                      SleepUntil ([| not volume_test_object(VOLUMES.fx_outcrop_trig_03, PLAYERS.local0) ], 1);
					  print ("kill bugs fx 03");
                      effect_attached_to_camera_stop(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs`.effect'));			                              
          until false;

end
function startupClient.triggerFXStart04()
                print ("starting fx trigger04");
		
			repeat
                      
					  SleepUntil ([| volume_test_object(VOLUMES.fx_outcrop_trig_04, PLAYERS.local0) ], 1);
					  print ("spawn bugs fx 04");
                      effect_attached_to_camera_new(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs_02.effect'));
					  
					
                      SleepUntil ([| not volume_test_object(VOLUMES.fx_outcrop_trig_04, PLAYERS.local0) ], 1);
					  print ("kill bugs fx 04");
                      effect_attached_to_camera_stop(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs_02.effect'));			                              
          until false;

end
function startupClient.triggerFXStart05()
                print ("starting fx trigger05");
		
			repeat
                      
					  SleepUntil ([| volume_test_object(VOLUMES.fx_outcropb_trig_01, PLAYERS.local0) ], 1);
					  print ("spawn bugs fx 05");
                      effect_attached_to_camera_new(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs.effect'));
					  
					
                      SleepUntil ([| not volume_test_object(VOLUMES.fx_outcropb_trig_01, PLAYERS.local0) ], 1);
					  print ("kill bugs fx 05");
                      effect_attached_to_camera_stop(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs`.effect'));			                              
          until false;

end
function startupClient.triggerFXStart06()
                print ("starting fx trigger06");
		
			repeat
                      
					  SleepUntil ([| volume_test_object(VOLUMES.fx_outcropb_trig_02, PLAYERS.local0) ], 1);
					  print ("spawn bugs fx 06");
                      effect_attached_to_camera_new(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs_02.effect'));
					  
					
                      SleepUntil ([| not volume_test_object(VOLUMES.fx_outcropb_trig_02, PLAYERS.local0) ], 1);
					  print ("kill bugs fx 06");
                      effect_attached_to_camera_stop(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs_02.effect'));			                              
          until false;

end
function startupClient.triggerFXStart07()
                print ("starting fx trigger07");
		
			repeat
                      
					  SleepUntil ([| volume_test_object(VOLUMES.fx_marsh_trig_01, PLAYERS.local0) ], 1);
					  print ("spawn bugs fx 07");
                      effect_attached_to_camera_new(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs.effect'));
					  
					
                      SleepUntil ([| not volume_test_object(VOLUMES.fx_marsh_trig_01, PLAYERS.local0) ], 1);
					  print ("kill bugs fx 07");
                      effect_attached_to_camera_stop(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs`.effect'));			                              
          until false;

end
function startupClient.triggerFXStart08()
                print ("starting fx trigger08");
		
			repeat
                      
					  SleepUntil ([| volume_test_object(VOLUMES.fx_marsh_trig_02, PLAYERS.local0) ], 1);
					  print ("spawn bugs fx 08");
                      effect_attached_to_camera_new(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs_02.effect'));
					  
					
                      SleepUntil ([| not volume_test_object(VOLUMES.fx_marsh_trig_02, PLAYERS.local0) ], 1);
					  print ("kill bugs fx 08");
                      effect_attached_to_camera_stop(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs_02.effect'));			                              
          until false;

end
function startupClient.triggerFXStart09()
                print ("starting fx trigger09");
		
			repeat
                      
					  SleepUntil ([| volume_test_object(VOLUMES.fx_marsh_trig_03, PLAYERS.local0) ], 1);
					  print ("spawn bugs fx 09");
                      effect_attached_to_camera_new(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs.effect'));
					  
					
                      SleepUntil ([| not volume_test_object(VOLUMES.fx_marsh_trig_03, PLAYERS.local0) ], 1);
					  print ("kill bugs fx 09");
                      effect_attached_to_camera_stop(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs`.effect'));			                              
          until false;

end
function startupClient.triggerFXStart10()
                print ("starting fx trigger10");
		
			repeat
                      
					  SleepUntil ([| volume_test_object(VOLUMES.fx_cave_trig_01, PLAYERS.local0) ], 1);
					  print ("spawn bugs fx 10");
                      effect_attached_to_camera_new(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs_02.effect'));
					  
					
                      SleepUntil ([| not volume_test_object(VOLUMES.fx_cave_trig_01, PLAYERS.local0) ], 1);
					  print ("kill bugs fx 10");
                      effect_attached_to_camera_stop(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs_02.effect'));			                              
          until false;

end
function startupClient.triggerFXStart11()
                print ("starting fx trigger11");
		
			repeat
                      
					  SleepUntil ([| volume_test_object(VOLUMES.fx_cave_trig_02, PLAYERS.local0) ], 1);
					  print ("spawn bugs fx 11");
                      effect_attached_to_camera_new(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs.effect'));
					  
					
                      SleepUntil ([| not volume_test_object(VOLUMES.fx_cave_trig_02, PLAYERS.local0) ], 1);
					  print ("kill bugs fx 11");
                      effect_attached_to_camera_stop(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs.effect'));			                              
          until false;

end
function startupClient.triggerFXStart12()
                print ("starting fx trigger12");
		
			repeat
                      
					  SleepUntil ([| volume_test_object(VOLUMES.fx_cave_trig_03, PLAYERS.local0) ], 1);
					  print ("spawn bugs fx 12");
                      effect_attached_to_camera_new(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs_02.effect'));
					  
					
                      SleepUntil ([| not volume_test_object(VOLUMES.fx_cave_trig_03, PLAYERS.local0) ], 1);
					  print ("kill bugs fx 12");
                      effect_attached_to_camera_stop(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs_02.effect'));			                              
          until false;

end
function startupClient.triggerFXStart13()
                print ("starting fx trigger13");
		
			repeat
                      
					  SleepUntil ([| volume_test_object(VOLUMES.fx_temple_trig_01, PLAYERS.local0) ], 1);
					  print ("spawn bugs fx 13");
                      effect_attached_to_camera_new(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs.effect'));
					  
					
                      SleepUntil ([| not volume_test_object(VOLUMES.fx_temple_trig_01, PLAYERS.local0) ], 1);
					  print ("kill bugs fx 13");
                      effect_attached_to_camera_stop(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs.effect'));			                              
          until false;

end
function startupClient.triggerFXStart14()
                print ("starting fx trigger14");
		
			repeat
                      
					  SleepUntil ([| volume_test_object(VOLUMES.fx_aftermath_trig_01, PLAYERS.local0) ], 1);
					  print ("spawn bugs fx 14");
                      effect_attached_to_camera_new(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs_02.effect'));
					  
					
                      SleepUntil ([| not volume_test_object(VOLUMES.fx_aftermath_trig_01, PLAYERS.local0) ], 1);
					  print ("kill bugs fx 14");
                      effect_attached_to_camera_stop(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs_02.effect'));			                              
          until false;

end




--	Temple 1 Console Interact - Touch Pulse //
function remoteClient.fx_temple1_console_interact_touch_pulse()
print ("FX - Temple 1 Console Interact - Touch Pulse");
effect_new_on_object_marker(TAG('levels\campaignworld030\w3_builder\fx\vignettes\vin_builder_temple_console\fr_temple_console_ui_center_touch_pulse.effect'), OBJECTS.dm_temple1_console, "fx_console_center_ring_02" );
end

--	Temple 1 Console Interact - Center Pulse Large //
function remoteClient.fx_temple1_console_interact_pulse_lg()
print ("FX - Temple 1 Console Interact - Center Pulse Large");
effect_new_on_object_marker(TAG('levels\campaignworld030\w3_builder\fx\vignettes\vin_builder_temple_console\fr_temple_console_ui_center_pulse_lg.effect'), OBJECTS.dm_temple1_console, "fx_console_center_ring_02" );
end

--	Temple 1 Console Interact - Icon Slide //
function remoteClient.fx_temple1_console_interact_icon_slide()
print ("FX - Temple 1 Console Interact - Icon Slide");
effect_new_on_object_marker(TAG('levels\campaignworld030\w3_builder\fx\vignettes\vin_builder_temple_console\fr_temple_console_main_ui_temple1_slide.effect'), OBJECTS.dm_temple1_console, "fx_console_center_ring_02" );
end



--	Temple 2 Console Interact - Touch Pulse //
function remoteClient.fx_temple2_console_interact_touch_pulse()
print ("FX - Temple 2 Console Interact - Touch Pulse");
effect_new_on_object_marker(TAG('levels\campaignworld030\w3_builder\fx\vignettes\vin_builder_temple_console\fr_temple_console_ui_center_touch_pulse.effect'), OBJECTS.dm_temple2_console, "fx_console_center_ring_02" );
end

--	Temple 2 Console Interact - Center Pulse Large //
function remoteClient.fx_temple2_console_interact_pulse_lg()
print ("FX - Temple 2 Console Interact - Center Pulse Large");
effect_new_on_object_marker(TAG('levels\campaignworld030\w3_builder\fx\vignettes\vin_builder_temple_console\fr_temple_console_ui_center_pulse_lg.effect'), OBJECTS.dm_temple2_console, "fx_console_center_ring_02" );
end

--	Temple 2 Console Interact - Icon Rotate //
function remoteClient.fx_temple2_console_interact_icon_rotate()
print ("FX - Temple 2 Console Interact - Icon Rotate");
effect_new_on_object_marker(TAG('levels\campaignworld030\w3_builder\fx\vignettes\vin_builder_temple_console\fr_temple_console_main_ui_temple2_icon_rotate.effect'), OBJECTS.dm_temple2_console, "fx_console_center_ring_02" );
end

--	Temple 2 Console Interact - Icon Slide //
function remoteClient.fx_temple2_console_interact_icon_slide()
print ("FX - Temple 2 Console Interact - Icon Slide");
effect_new_on_object_marker(TAG('levels\campaignworld030\w3_builder\fx\vignettes\vin_builder_temple_console\fr_temple_console_main_ui_temple1_slide.effect'), OBJECTS.dm_temple2_console, "fx_console_center_ring_02" );
end



--	Temple 3 Console Interact - Touch Pulse //
function remoteClient.fx_temple3_console_interact_touch_pulse()
print ("FX - Temple 3 Console Interact - Touch Pulse");
effect_new_on_object_marker(TAG('levels\campaignworld030\w3_builder\fx\vignettes\vin_builder_temple_console\fr_temple_console_ui_center_touch_pulse.effect'), OBJECTS.dm_temple3_console, "fx_console_center_ring_02" );
end

--	Temple 3 Console Interact - Center Pulse Large //
function remoteClient.fx_temple3_console_interact_pulse_lg()
print ("FX - Temple 3 Console Interact - Center Pulse Large");
effect_new_on_object_marker(TAG('levels\campaignworld030\w3_builder\fx\vignettes\vin_builder_temple_console\fr_temple_console_ui_center_pulse_lg.effect'), OBJECTS.dm_temple3_console, "fx_console_center_ring_02" );
end

--	Temple 3 Console Interact - Icon Rotate //
function remoteClient.fx_temple3_console_interact_icon_rotate()
print ("FX - Temple 3 Console Interact - Icon Rotate");
effect_new_on_object_marker(TAG('levels\campaignworld030\w3_builder\fx\vignettes\vin_builder_temple_console\fr_temple_console_main_ui_temple3_icon_rotate.effect'), OBJECTS.dm_temple3_console, "fx_console_center_ring_02" );
end

--	Temple 3 Console Interact - Icon Slide //
function remoteClient.fx_temple3_console_interact_icon_slide()
print ("FX - Temple 3 Console Interact - Icon Slide");
effect_new_on_object_marker(TAG('levels\campaignworld030\w3_builder\fx\vignettes\vin_builder_temple_console\fr_temple_console_main_ui_temple1_slide.effect'), OBJECTS.dm_temple3_console, "fx_console_center_ring_02" );
end



--	Temple Console Main - Kill Temple 1 Icon //
function remoteClient.fx_temple_console_kill_icon_01()
print ("FX - Temple Console Main - Kill Temple 1 Icon");
effect_kill_object_marker(TAG('levels\campaignworld030\w3_builder\fx\vignettes\vin_builder_temple_console\fr_temple_console_main_ui_temple1_icon_hold.effect'), OBJECTS.dm_temple1_console, "fx_console_center_ring_02" );
effect_kill_object_marker(TAG('levels\campaignworld030\w3_builder\fx\vignettes\vin_builder_temple_console\fr_temple_console_main_ui_temple1_icon_kill.effect'), OBJECTS.dm_temple1_console, "fx_console_center_ring_02" );
end

--	Temple Console Main - Kill Temple 2 Icon //
function remoteClient.fx_temple_console_kill_icon_02()
print ("FX - Temple Console Main - Kill Temple 2 Icon");
effect_kill_object_marker(TAG('levels\campaignworld030\w3_builder\fx\vignettes\vin_builder_temple_console\fr_temple_console_main_ui_temple2_icon_hold.effect'), OBJECTS.dm_temple2_console, "fx_console_center_ring_02" );
effect_kill_object_marker(TAG('levels\campaignworld030\w3_builder\fx\vignettes\vin_builder_temple_console\fr_temple_console_main_ui_temple2_icon_kill.effect'), OBJECTS.dm_temple2_console, "fx_console_center_ring_02" );
end

--	Temple Console Main - Kill Temple 3 Icon //
function remoteClient.fx_temple_console_kill_icon_03()
print ("FX - Temple Console Main - Kill Temple 3 Icon");
effect_kill_object_marker(TAG('levels\campaignworld030\w3_builder\fx\vignettes\vin_builder_temple_console\fr_temple_console_main_ui_temple3_icon_hold.effect'), OBJECTS.dm_temple3_console, "fx_console_center_ring_02" );
effect_kill_object_marker(TAG('levels\campaignworld030\w3_builder\fx\vignettes\vin_builder_temple_console\fr_temple_console_main_ui_temple3_icon_kill.effect'), OBJECTS.dm_temple3_console, "fx_console_center_ring_02" );
end



-- Temple 2 Marsh - Kill Circular Base Energy
function remoteClient.fx_temple_2_kill_base_energy()
print ("FX - Temple 2 - Kill Circular Base Energy");
KillEffectGroup(EFFECTS.fx_marsh_temple_elev_base_energy);
end


