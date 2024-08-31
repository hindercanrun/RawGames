-- object assault_oni_door_a

--## SERVER

function assault_oni_door_a:init()
	--print ("giddyup");

	sleep_s(2);
	
	self:pathfindingswitch();
end

function assault_oni_door_a:pathfindingswitch()
	
	local n_power:number = device_get_power( self );
	--print("oni_door_a ", n_power);
	if n_power == 0 then
		--print("oni_door_a ", n_power, self);
		ObjectOverrideNavMeshCutting( self, true );
	else
		ObjectOverrideNavMeshCutting( self, false );
	end 

	repeat
		SleepUntil( 	[| device_get_position( self ) > 0 ] , 5 );
			ObjectOverrideNavMeshCutting( self, false );
			sleep_s(0.1);
		SleepUntil( 	[| device_get_position( self ) == 0 ] , 5 );
			ObjectOverrideNavMeshCutting( self, true );
			--print("override nav mesh " , device_get_position( self ) , " " , self );
			sleep_s(0.1);
	until false;


end