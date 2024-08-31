-- object dm_piston_tiny

--## SERVER

function dm_piston_tiny:init()
	local sleep_time:number = 120;
	repeat
		device_set_power (self, 1);
		print ("setting position to 0");
		device_set_position(self, 0);
		SleepUntil ([| device_get_position(self) == 0 ], 1);
		device_set_power (self, 0);
		print ("sleeping");
		sleep_s (sleep_time);
		device_set_power (self, 1);
		print ("setting position to 1.0");
		device_set_position(self, 1.0);
		SleepUntil ([| device_get_position(self) == 1.0 ], 1);
		device_set_power (self, 0);
		print ("sleeping");
		sleep_s (sleep_time);
	until false;
end