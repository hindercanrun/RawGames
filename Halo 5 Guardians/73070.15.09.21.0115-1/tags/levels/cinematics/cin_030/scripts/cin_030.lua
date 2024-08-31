--## SERVER

--at startup attach the player to an octopus and plays the cinema, then loads the next level
function startup.init_cinema()
	-- Begin loom for next campaign mission
	InfinityCinematicStart ("cin_030_infinity1a", OBJECTS.sc_octopus);
	sys_LoadAssaultOnStation();
end