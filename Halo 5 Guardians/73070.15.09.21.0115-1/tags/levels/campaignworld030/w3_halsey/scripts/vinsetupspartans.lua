--## SERVER

global g_ics_player0:object = nil;
global g_ics_player1:object = nil;
global g_ics_player2:object = nil;
global g_ics_player3:object = nil;

print ("REMINDER: You must start the game (Tab key in Faber) before running: vinSetupSpartans(). This is required after every map reset...");

function startup.vinSetupSpartans()
    --Sets up the global ics variables 
    SleepUntil ([| object_get_health (PLAYERS.player0) > 0], 1);
	print ("player alive");
	g_ics_player0 = SPARTANS.locke;
	g_ics_player1 = SPARTANS.vale;
	g_ics_player2 = SPARTANS.tanaka;
	g_ics_player3 = SPARTANS.buck;
 end
