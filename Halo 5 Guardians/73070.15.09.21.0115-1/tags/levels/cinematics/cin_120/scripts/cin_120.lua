--## SERVER

--at startup attach the player to an octopus and plays the cinema, then loads the next level
function startup.init_cinema()
	print ("init 120 cinema");
	InfinityCinematicStart ("cin_120_infinity2b", OBJECTS.sc_octopus);
	sys_LoadGrotto();
end