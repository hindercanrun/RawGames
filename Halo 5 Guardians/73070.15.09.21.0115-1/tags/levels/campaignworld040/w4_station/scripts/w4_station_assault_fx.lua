--## SERVER

--Owner: Karl Kohlman
--343 industries

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ ASSAULT ON THE STATION *_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*



---------------------------------------------------------------
---------------------------------------------------------------
--FX SCRIPTS
---------------------------------------------------------------
---------------------------------------------------------------









function startup.callClient()
            print ("calling callClient");
            --RunClientScript ("w4_assualt_camera_dust");
			--RunClientScript ("w4_assualt_kill_reactor_atmo");  -- i moved this to the reactor setup . cf
			RunClientScript ("w4_assualt_hologram_shrink");

end

--## CLIENT

function remoteClient.w4_assualt_camera_dust()
                print ("starting fx trigger");
				effect_attached_to_camera_new (TAG('levels\campaignworld040\w4_station\fx\camera_dust_motes.effect'));
				
--			repeat
--                      SleepUntil ([| volume_test_object(VOLUMES.fx_volume_norain_01, PLAYERS.local0) ], 1);
--                      effect_attached_to_camera_new (TAG('fx\library\weather\rain_light.effect'));
					
--                      SleepUntil ([| not volume_test_object(VOLUMES.fx_volume_norain_01, PLAYERS.local0) ], 1);
--                      effect_attached_to_camera_stop (TAG('fx\library\weather\rain_light.effect'));			                              
--          until false;
		  
end



function remoteClient.w4_assualt_camera_dust_stop()
    print ("starting fx trigger");
    effect_attached_to_camera_stop (TAG('levels\campaignworld040\w4_station\fx\camera_dust_motes.effect'));
				
end

function remoteClient.w4_assualt_kill_reactor_atmo()
				--print ("test_reactor_atmo");
				
		repeat
				SleepUntil ([| volume_test_object(VOLUMES.trigger_exit_reactor_room, PLAYERS.local0) ], 1);
					--KillEffectGroup(EFFECTS.generic_reactor_mist);  
					--print("kill_mist");
					Sleep(2);
		until false;
end

function remoteClient.w4_assualt_hologram_shrink()
		print("argentmoon_hologram_prep");
		object_set_scale(OBJECTS.scenery, .75, 10);
		object_set_scale(OBJECTS.control_room_holo, .001, 1);
end
	