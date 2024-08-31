-- object dm_piston_large

--## SERVER

global sleep_time:number = 10;
global warningTime:number = 5;

function dm_piston_large:LowerPiston()
		print ("setting position to 0");
		interpolator_start ("pistonsemergencylight_on");
--		device_set_power (self, 1);	
		device_set_position(self, 0);
		--SleepUntil ([| device_get_position(self) == 0 ], 1);
end

function dm_piston_large:RaisePiston()
		print ("setting position to 1.0");
		interpolator_start ("pistonsemergencylight_on");
--		device_set_power (self, 1);
		device_set_position(self, 1.0);
		--SleepUntil ([| device_get_position(self) == 1.0 ], 1);
end

function dm_piston_large:PlayWarning()
		interpolator_start ("pistonsemergencylight_on");
		sleep_s(warningTime);
end

function dm_piston_large:SleepUntilWarning()
		print ("sleeping");		
		--device_set_power (self, 0);
		sleep_s(sleep_time - warningTime);
end

function dm_piston_large:init()
	
	-- Start the piston in the low position
	--device_set_position_immediate(self, 0)
	
	repeat
	
		self:SleepUntilWarning();
		
		self:PlayWarning();
		
		self:LowerPiston();
		
		self:SleepUntilWarning();
		
		self:PlayWarning();
	
		self:RaisePiston();
			
	until false;
end