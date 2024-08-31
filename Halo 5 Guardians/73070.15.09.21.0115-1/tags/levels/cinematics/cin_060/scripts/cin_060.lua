--## SERVER

--at startup attach the player to an octopus and plays the cinema, then loads the next level
function startup.init_cinema()
	InfinityCinematicStart ("cin_060_infinity1b", OBJECTS.sc_octopus);
	sys_LoadMeridian();
end