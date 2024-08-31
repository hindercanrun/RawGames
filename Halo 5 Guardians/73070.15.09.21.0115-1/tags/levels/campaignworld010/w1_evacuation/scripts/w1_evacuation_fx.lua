
--## SERVER

--## CLIENT

function startupClient.w1_evacuation_fx_trigger_ember_01()
            print ("starting fx trigger");

			repeat
				   SleepUntil ([| volume_test_object(VOLUMES.fx_volume_ember_01, PLAYERS.local0) ], 1);
                   effect_attached_to_camera_new (TAG('levels\campaignworld010\w1_evacuation\effects\env\camera_ember_windy.effect'))
				   print ("starting ash FX");
				   
                   SleepUntil ([| not volume_test_object(VOLUMES.fx_volume_ember_01, PLAYERS.local0) ], 1);
				   effect_attached_to_camera_stop (TAG('levels\campaignworld010\w1_evacuation\effects\env\camera_ember_windy.effect'))
				   print ("stopping ash FX");
			
                   SleepUntil ([| volume_test_object(VOLUMES.fx_volume_ember_02, PLAYERS.local0) ], 1);
                   effect_attached_to_camera_stop (TAG('levels\campaignworld010\w1_evacuation\effects\env\camera_ember_windy.effect'))
				   effect_attached_to_camera_new (TAG('levels\campaignworld010\w1_evacuation\effects\env\camera_ember_hot.effect'))
				  -- print ("stopping ash FX");
				   print ("starting ember FX");

                   SleepUntil ([| not volume_test_object(VOLUMES.fx_volume_ember_02, PLAYERS.local0) ], 1);
				   effect_attached_to_camera_stop (TAG('levels\campaignworld010\w1_evacuation\effects\env\camera_ember_hot.effect'))
				   print ("stopping ember FX");

					
			until false;

		  
end



