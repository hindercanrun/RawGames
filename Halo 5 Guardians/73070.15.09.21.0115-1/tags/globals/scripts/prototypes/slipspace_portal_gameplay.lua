-- object slipspace_portal_gameplay

--## SERVER



function slipspace_portal_gameplay:init()

	print ("slipspace gameplay portal");
	
end

function slipspace_portal_gameplay:OpenGameplayPortal()
	RunClientScript("Portal_OpenGameplayPortal",self);
end

function slipspace_portal_gameplay:CloseGameplayPortal()
	RunClientScript("Portal_CloseGameplayPortal",self);
end


--## CLIENT

function remoteClient.Portal_OpenGameplayPortal(portal:object)

	print ("opening slipspace portal");
		object_set_function_variable(portal, "portal_open", 1, 1);
			sleep_s (1);
		object_set_function_variable(portal, "portal_active", 1, 3);
			sleep_s (3);
		object_set_function_variable(portal, "portal_open", 0, 1);
		
 end

function remoteClient.Portal_CloseGameplayPortal(portal:object)

	print ("closing slipspace portal");
		object_set_function_variable(portal, "portal_active", 0, 3);
			sleep_s (1);
		object_set_function_variable(portal, "portal_close", 1, 1);
			sleep_s (3);
		object_set_function_variable(portal, "portal_close", 0, 1);
	
 end

 
