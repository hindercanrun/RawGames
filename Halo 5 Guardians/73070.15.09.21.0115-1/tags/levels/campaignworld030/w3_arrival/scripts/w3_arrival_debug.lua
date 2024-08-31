-- DEBUG
--## SERVER

function startup.hub_cheats()
--I need to add a check so threads are not always running and this will only start up if the mission says so.
	print("debug");
	--CreateThread(on_startup_cheat_super_player);
	--CreateThread(on_start_up_hide_render_geo);
end

function on_startup_cheat_super_player()
--SleepUntil([|debug_super_player > 0], 1);
	if debug_super_player > 0 then
		cheat_infinite_ammo = true;
		cheat_deathless_player = true;
		cheat_omnipotent = true;
	end
end

function on_start_up_hide_render_geo()
	print("error geo is hidden on startup for reasons.");
	error_geometry_hide_all();
end


