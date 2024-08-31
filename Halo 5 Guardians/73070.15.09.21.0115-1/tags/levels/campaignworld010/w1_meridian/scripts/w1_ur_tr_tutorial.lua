--## SERVER

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- *_*_*_*_*_*_*_ UNCONFIRMED REPORTS TUTORIAL *_*_*_*_*_*_*_*_*
-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_


--START THE TRACKING TUTORIAL

function TrackingTutorialStart()
	print ("TrackingTutorialStart");
	--RunClientScript ("TrackingTutorialTrackingStart");
	--teleport_player_to_flag (PLAYERS.player0, FLAGS.fl_test, false);
	RunClientScript ("TrackingTutorialTrackingStart");
end

--## CLIENT
function remoteClient.TrackingTutorialTrackingStart()

	print ("Tracking Tutorial wait to enter trigger volume");
--	SleepUntil ([| volume_test_object (VOLUMES.tv_ur_first_dialog, player_get_unit (PLAYERS.local0)) ], 5);
	
	print ("local player entered the trigger volume");
	ShowTempText ("START TRACKING TUTORIAL", 3);
	sleep_s (3);
	TrackingTutorialTeachDpad();
	sleep_s (1);
	TrackingTutorialTeachTrigger();
	sleep_s (1);
	TrackingTutorialEnd();
end

function TrackingTutorialTeachDpad()
-- teach the d_pad
	ShowTempText ("<PRESS DOWN ON D-PAD TO START TRACKING>", 999);
	unit_action_test_reset (PLAYERS.local0)
	SleepUntil ([| unit_action_test_dpad_down (PLAYERS.local0) ], 1);
	clear_all_text();
end

function TrackingTutorialTeachTrigger()
	-- teach the trigger
	ShowTempText ("<PRESS RIGHT TRIGGER TO TRACK>", 999);
	unit_action_test_reset (PLAYERS.local0)
	SleepUntil ([| unit_action_test_primary_trigger (PLAYERS.local0) ], 1);
	clear_all_text();
end

function TrackingTutorialEnd()
	print ("tracking tutorial ended");
	ShowTempText ("<TRACKING TUTORIAL COMPLETE>", 3);
end