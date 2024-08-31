--## SERVER

global startLooming:boolean = false;

function remoteServer.FlipLoomBoolean()
	startLooming = true;
end

function prepareCinemaLoom()
	SleepUntil([| startLooming == true], 1);
	LoomNextCampaignMission();
end

--at startup attach the player to an octopus and plays the cinema, then loads the next level
function startup.init_cinema()
	CreateThread(prepareCinemaLoom);
	InfinityCinematicStart ("cin_110_infinity2a", OBJECTS.sc_octopus);
	sys_LoadBuilder();
end