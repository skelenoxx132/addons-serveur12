function ADMINSTICK_GiveStick( ply )
	if ply:IsAdmin() then
		if GAMEMODE.Name == "Trouble in Terrorist Town" then
			ply:Give( "admin_stick_ttt" )
		else
			ply:Give( "admin_stick" )
		end
	end
	if ADMINSTICK_UseULX then
		if table.HasValue( ADMINSTICK_ULXRanks, ply:GetUserGroup() ) then
			if GAMEMODE.Name == "Trouble in Terrorist Town" then
				ply:Give( "admin_stick_ttt" )
			else
				ply:Give( "admin_stick" )
			end
		end
	end
	if ADMINSTICK_UseSteamIDs then
		if table.HasValue( ADMINSTICK_SteamIDs, ply:SteamID() ) then
			if GAMEMODE.Name == "Trouble in Terrorist Town" then
				ply:Give( "admin_stick_ttt" )
			else
				ply:Give( "admin_stick" )
			end
		end
	end
end
hook.Add( "PlayerSpawn", "ADMINSTICK_GiveStick", ADMINSTICK_GiveStick)

function ADMINSTICK_GiveStickCommand( ply )
	if ply:IsAdmin() then
		if GAMEMODE.Name == "Trouble in Terrorist Town" then
			ply:Give( "admin_stick_ttt" )
		else
			ply:Give( "admin_stick" )
		end
	end
	if ADMINSTICK_UseULX then
		if table.HasValue( ADMINSTICK_ULXRanks, ply:GetUserGroup() ) then
			if GAMEMODE.Name == "Trouble in Terrorist Town" then
				ply:Give( "admin_stick_ttt" )
			else
				ply:Give( "admin_stick" )
			end
		end
	end
	if ADMINSTICK_UseSteamIDs then
		if table.HasValue( ADMINSTICK_SteamIDs, ply:SteamID() ) then
			if GAMEMODE.Name == "Trouble in Terrorist Town" then
				ply:Give( "admin_stick_ttt" )
			else
				ply:Give( "admin_stick" )
			end
		end
	end
end
concommand.Add("give_adminstick", ADMINSTICK_GiveStickCommand)

function ADMINSTICK_GiveStickTTT()
	for k, v in pairs( player.GetAll() ) do
		if v:IsAdmin() then
			v:Give( "admin_stick_ttt" )
		end
		if ADMINSTICK_UseULX then
			if table.HasValue( ADMINSTICK_ULXRanks, v:GetUserGroup() ) then
				v:Give( "admin_stick_ttt" )
			end
		end
		if ADMINSTICK_UseSteamIDs then
			if table.HasValue( ADMINSTICK_SteamIDs, ply:SteamID() ) then
				ply:Give( "admin_stick_ttt" )
			end
		end
	end
end
hook.Add( "TTTBeginRound", "ADMINSTICK_GiveStickTTT", ADMINSTICK_GiveStickTTT)