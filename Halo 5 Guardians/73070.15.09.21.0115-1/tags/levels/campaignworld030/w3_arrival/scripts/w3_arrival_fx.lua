
-- fx_target_clean


--## CLIENT


function startupClient.triggerFXStart()
                print ("starting fx trigger");
		
			repeat
                      
					  SleepUntil ([| volume_test_object(VOLUMES.fx_crossing_trig_01, PLAYERS.local0) ], 1);
					  print ("spawn bugs fx");
                      effect_attached_to_camera_new(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs.effect'));
					  
					
                      SleepUntil ([| not volume_test_object(VOLUMES.fx_crossing_trig_01, PLAYERS.local0) ], 1);
					  print ("kill bugs fx");
                      effect_attached_to_camera_stop(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs.effect'));			                              
          until false;

end
function startupClient.triggerFXStart02()
                print ("starting fx trigger02");
		
			repeat
                      
					  SleepUntil ([| volume_test_object(VOLUMES.fx_crossing_trig_02, PLAYERS.local0) ], 1);
					  print ("spawn bugs fx 02");
                      effect_attached_to_camera_new(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs_02.effect'));
					  
					
                      SleepUntil ([| not volume_test_object(VOLUMES.fx_crossing_trig_02, PLAYERS.local0) ], 1);
					  print ("kill bugs fx 02");
                      effect_attached_to_camera_stop(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs_02.effect'));			                              
          until false;

end
function startupClient.triggerFXStart03()
                print ("starting fx trigger03");
		
			repeat
                      
					  SleepUntil ([| volume_test_object(VOLUMES.fx_crossing_trig_03, PLAYERS.local0) ], 1);
					  print ("spawn bugs fx 03");
                      effect_attached_to_camera_new(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs_02.effect'));
					  
					
                      SleepUntil ([| not volume_test_object(VOLUMES.fx_crossing_trig_03, PLAYERS.local0) ], 1);
					  print ("kill bugs fx 03");
                      effect_attached_to_camera_stop(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs_02.effect'));			                              
          until false;

end
function startupClient.triggerFXStart04()
                print ("starting fx trigger04");
		
			repeat
                      
					  SleepUntil ([| volume_test_object(VOLUMES.fx_crossing_trig_04, PLAYERS.local0) ], 1);
					  print ("spawn bugs fx 04");
                      effect_attached_to_camera_new(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs_02.effect'));
					  
					
                      SleepUntil ([| not volume_test_object(VOLUMES.fx_crossing_trig_04, PLAYERS.local0) ], 1);
					  print ("kill bugs fx 04");
                      effect_attached_to_camera_stop(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs_02.effect'));			                              
          until false;

end
function startupClient.triggerFXStart05()
                print ("starting fx trigger05");
		
			repeat
                      
					  SleepUntil ([| volume_test_object(VOLUMES.fx_crossing_trig_05, PLAYERS.local0) ], 1);
					  print ("spawn bugs fx 05");
                      effect_attached_to_camera_new(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs_02.effect'));
					  
					
                      SleepUntil ([| not volume_test_object(VOLUMES.fx_crossing_trig_05, PLAYERS.local0) ], 1);
					  print ("kill bugs fx 05");
                      effect_attached_to_camera_stop(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs_02.effect'));			                              
          until false;

end
function startupClient.triggerFXStart06()
                print ("starting fx trigger06");
		
			repeat
                      
					  SleepUntil ([| volume_test_object(VOLUMES.fx_crossing_trig_06, PLAYERS.local0) ], 1);
					  print ("spawn bugs fx 06");
                      effect_attached_to_camera_new(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs_02.effect'));
					  
					
                      SleepUntil ([| not volume_test_object(VOLUMES.fx_crossing_trig_06, PLAYERS.local0) ], 1);
					  print ("kill bugs fx 06");
                      effect_attached_to_camera_stop(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs_02.effect'));			                              
          until false;

end
function startupClient.triggerFXStart07()
                print ("starting fx trigger07");
		
			repeat
                      
					  SleepUntil ([| volume_test_object(VOLUMES.fx_grassland_trig_01, PLAYERS.local0) ], 1);
					  print ("spawn bugs fx 07");
                      effect_attached_to_camera_new(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs_02.effect'));
					  
					
                      SleepUntil ([| not volume_test_object(VOLUMES.fx_grassland_trig_01, PLAYERS.local0) ], 1);
					  print ("kill bugs fx 07");
                      effect_attached_to_camera_stop(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs_02.effect'));			                              
          until false;

end
function startupClient.triggerFXStart08()
                print ("starting fx trigger08");
		
			repeat
                      
					  SleepUntil ([| volume_test_object(VOLUMES.fx_road_crossing_trig_01, PLAYERS.local0) ], 1);
					  print ("spawn bugs fx 08");
                      effect_attached_to_camera_new(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs_02.effect'));
					  
					
                      SleepUntil ([| not volume_test_object(VOLUMES.fx_road_crossing_trig_01, PLAYERS.local0) ], 1);
					  print ("kill bugs fx 08");
                      effect_attached_to_camera_stop(TAG('\levels\campaignworld030\w3_builder\fx\ambient_life\builder_amb_bugs_02.effect'));			                              
          until false;

end