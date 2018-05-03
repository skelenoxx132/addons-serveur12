if SERVER then
    AddCSLuaFile( "shared.lua" )
end

if CLIENT then
    SWEP.PrintName = "Administration Stick"
    SWEP.Slot = 0
    SWEP.SlotPos = 5
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = true 
end

SWEP.Author         = "Crap-Head"
SWEP.Instructions   = "Right click to bring up tools. Left click to perform selected action."
SWEP.Contact        = ""
SWEP.Purpose        = ""

SWEP.ViewModelFOV   = 62
SWEP.ViewModelFlip  = false
SWEP.UseHands		= true
SWEP.AnimPrefix  	= "stunstick"

SWEP.Spawnable      	= true
SWEP.AdminSpawnable     = true

SWEP.ViewModel = "models/weapons/v_stunstick.mdl"
SWEP.WorldModel = "models/weapons/w_stunbaton.mdl"

SWEP.Primary.ClipSize     	= -1
SWEP.Primary.DefaultClip   	= 0
SWEP.Primary.Automatic    	= false
SWEP.Primary.Ammo 			= ""

SWEP.Secondary.ClipSize  	= -1
SWEP.Secondary.DefaultClip  = 0
SWEP.Secondary.Automatic    = false
SWEP.Secondary.Ammo         = ""

local AdminTools = {}

function SWEP:Initialize()
 	self:SetWeaponHoldType( "normal" )      
end

function SWEP:PrimaryAttack()
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Weapon:EmitSound( Sound( "weapons/stunstick/stunstick_swing1.wav" ) )
	self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
 	self.Weapon:SetNextPrimaryFire( CurTime() + 0.2 )
	
	AccessAllowed = false
	
	if ADMINSTICK_UseULX then
		if table.HasValue( ADMINSTICK_ULXRanks, self.Owner:GetUserGroup() ) then
			AccessAllowed = true
		end
	end
	if ADMINSTICK_UseSteamIDs then
		if table.HasValue( ADMINSTICK_SteamIDs, self.Owner:SteamID() ) then
			AccessAllowed = true
		end
	end	
	if self.Owner:IsAdmin() then
		AccessAllowed = true
	end
	
	if not AccessAllowed then
		if SERVER then
			self.Owner:Kick("Only administrators can use the administration stick!")
			return
		end
	end

	AdminTools[self.Owner:GetTable().CurGear or 1][4](self.Owner, self.Owner:GetEyeTrace())
end

if SERVER then
	util.AddNetworkString( "ADMINSTICK_SelectTool" )
	net.Receive( "ADMINSTICK_SelectTool", function (length, ply )
		local CurrentGear = net.ReadDouble()
		local Message = net.ReadString()

		ply:GetTable().CurGear = tonumber( CurrentGear )
		if GAMEMODE.Name == "DarkRP" then
			DarkRP.notify( ply, 1, 5, Message )
		else
			ply:ChatPrint( Message )
		end
	end)
end

function SWEP:SecondaryAttack()
	if CLIENT then
		local MENU = DermaMenu()
		MENU:AddOption( LocalPlayer():Nick() ):SetIcon( "icon16/user.png" )
		MENU:AddOption( LocalPlayer():SteamID() ):SetIcon( "icon16/information.png" )
		MENU:AddSpacer()

		local CategoryAll = MENU:AddSubMenu( "General Tools" )
		local CategoryDarkRP = MENU:AddSubMenu( "DarkRP Tools" )
		local CategoryTTT = MENU:AddSubMenu( "TTT Tools" )

		for k, v in pairs( AdminTools ) do
			if string.find( v[1], "DARKRP" ) then
				CategoryDarkRP:AddOption( v[1], function()
					net.Start( "ADMINSTICK_SelectTool" )
						net.WriteDouble( k )
						net.WriteString( v[2] )
					net.SendToServer()
				end):SetIcon( v[3] )
			elseif string.find( v[1], "TTT" ) then
				CategoryTTT:AddOption( v[1], function()
					net.Start( "ADMINSTICK_SelectTool" )
						net.WriteDouble( k )
						net.WriteString( v[2] )
					net.SendToServer()
				end):SetIcon( v[3] )
			else
				CategoryAll:AddOption( v[1], function()
					net.Start( "ADMINSTICK_SelectTool" )
						net.WriteDouble( k )
						net.WriteString( v[2] )
					net.SendToServer()
				end):SetIcon( v[3] )
			end
		end
		
		MENU:Open( 100, 100 )
		input.SetCursorPos( 100, 100 )
	end
end

local function AddTool( name, description, icon, func )
	table.insert( AdminTools, {name, description, icon, func} )
end

AddTool( "[ALL] Exit Vehicle", "Kick the driver out of their current vehicle.", "icon16/car.png", function( Player, Trace )
	if IsValid( Trace.Entity ) and Trace.Entity:GetClass() == "prop_vehicle_jeep" then
		if Trace.Entity:IsVehicle() and IsValid( Trace.Entity.GetDriver and Trace.Entity:GetDriver() ) then
			Trace.Entity:GetDriver():ExitVehicle()
			Trace.Entity:ChatPrint( "An administrator has kicked you out of your vehicle!" )
		end
	end
end)

AddTool( "[ALL] Bring", "Aim at a player to bring them in front of you.", "icon16/cart_go.png", function( Player, Trace )
	if IsValid( Trace.Entity ) and Trace.Entity:IsPlayer() then
		Trace.Entity:SetPos( Player:GetPos() + ( (Player:GetForward() * 45) +  Vector( 0, 0, 50 )) )
		Trace.Entity:ChatPrint( "An administrator has brought you to them!" )
	end
end)

AddTool( "[ALL] Player Info", "Gives you a lot of information about the target.", "icon16/information.png", function( Player, Trace )
	if IsValid( Trace.Entity ) and Trace.Entity:IsPlayer() then
		Player:ChatPrint( "Name: "..Trace.Entity:Nick())
		Player:ChatPrint( "SteamID: "..Trace.Entity:SteamID())
		Player:ChatPrint( "Kills: "..Trace.Entity:Frags())
		Player:ChatPrint( "Deaths: "..Trace.Entity:Deaths())
		Player:ChatPrint( "HP: " ..Trace.Entity:Health())

		-- Chat/Console Print
		Player:ChatPrint("Name: "..Trace.Entity:Nick())
		Player:ChatPrint("SteamID: "..Trace.Entity:SteamID())
		Player:ChatPrint("Kills: "..Trace.Entity:Frags())
		Player:ChatPrint("Deaths: "..Trace.Entity:Deaths())
		Player:ChatPrint("HP: " ..Trace.Entity:Health())
	elseif IsValid( Trace.Entity ) and Trace.Entity:IsVehicle() then
		if IsValid( Trace.Entity.GetDriver and Trace.Entity:GetDriver() ) then
			Player:ChatPrint( "Name: "..Trace.Entity:GetDriver():Nick())
			Player:ChatPrint( "SteamID: "..Trace.Entity:GetDriver():SteamID())
			Player:ChatPrint( "Kills: "..Trace.Entity:GetDriver():Frags())
			Player:ChatPrint( "Deaths: "..Trace.Entity:GetDriver():Deaths())
			Player:ChatPrint( "HP: " ..Trace.Entity:GetDriver():Health())

			-- Chat/Console Print
			Player:ChatPrint("Name: "..Trace.Entity:GetDriver():Nick())
			Player:ChatPrint("SteamID: "..Trace.Entity:GetDriver():SteamID())
			Player:ChatPrint("Kills: "..Trace.Entity:GetDriver():Frags())
			Player:ChatPrint("Deaths: "..Trace.Entity:GetDriver():Deaths())
			Player:ChatPrint("HP: " ..Trace.Entity:GetDriver():Health())
		end
	end
end)

AddTool("[ALL] Extinguish (Prop)", "Aim at a burning entity to extinguish it.", "icon16/fire.png", function( Player, Trace )
	if IsValid( Trace.Entity ) then
		Trace.Entity:Extinguish()
		Trace.Entity:SetColor( Color(255,255,255,255) )
		Player:ChatPrint( "You've extinguished the target." )
	end
end)

AddTool("[ALL] Force MOTD", "Force a player to read the message of the day.", "icon16/email_open.png", function( Player, Trace )
	if IsValid( Trace.Entity ) and Trace.Entity:IsPlayer() then
		Trace.Entity:ConCommand("say !motd")
		Player:ChatPrint( "You forced the target to read the message of the day." )
	end
end)

AddTool("[ALL] Freeze/Unfreeze", "Target a player to change his freeze state.", "icon16/bug.png", function( Player, Trace )
	if IsValid( Trace.Entity ) and Trace.Entity:IsPlayer() then
		if Trace.Entity.IsFrozens then
			Trace.Entity:Freeze( false )
			Player:ChatPrint( Trace.Entity:Nick() .." has been unfrozen." )
			Trace.Entity:ChatPrint( "You have been unfrozen by an administrator." )
			Trace.Entity:EmitSound( "npc/metropolice/vo/allrightyoucango.wav" )
			Trace.Entity.IsFrozens = false
		else
			Trace.Entity.IsFrozens = true
			Trace.Entity:Freeze( true )
			Player:ChatPrint( Trace.Entity:Nick() .." has been frozen." )
			Trace.Entity:EmitSound( "npc/metropolice/vo/holdit.wav" )
			Trace.Entity:ChatPrint( "You have been frozen by an administrator." )
		end
	end
end)

AddTool("[ALL] Heal Player", "Aim at a player to heal them. Aim at the world to heal yourself.", "icon16/heart.png", function( Player, Trace )
	if IsValid(Trace.Entity) and Trace.Entity:IsPlayer() then
		Trace.Entity:SetHealth( 100 )
		Trace.Entity:EmitSound( "items/smallmedkit1.wav",110,100 )
		Trace.Entity:ChatPrint( "You have been healed by an administrator." ) 
	elseif Trace.Entity:IsWorld() then
		Player:SetHealth( 100 )
		Player:EmitSound( "items/smallmedkit1.wav",110,100 ) 
		Player:ChatPrint( "You have healed yourself." )
	end
end)

AddTool("[ALL] God Mode", "Aim at a player to god/ungod them. Aim at the world to god/ungod yourself.", "icon16/shield.png", function( Player, Trace )
	if IsValid(Trace.Entity) and Trace.Entity:IsPlayer() then
		if Trace.Entity:HasGodMode() then
			Trace.Entity:GodDisable()
			Trace.Entity:ChatPrint( "Your godmode has been disabled by an administrator." ) 
		else
			Trace.Entity:GodEnable()
			Trace.Entity:ChatPrint( "Your godmode has been enabled by an administrator." ) 
		end
	elseif Trace.Entity:IsWorld() then
		if Player:HasGodMode() then
			Player:GodDisable()
			Player:ChatPrint( "Your godmode has been disabled." ) 
		else
			Player:GodEnable()
			Player:ChatPrint( "Your godmode has been enabled." ) 
		end
	end
end)

AddTool("[ALL] Invisiblity", "Left click to go invisible. Left click again to become visible again.", "icon16/eye.png", function( Player, Trace )
	local c = Player:GetColor()
	local r,g,b,a = c.r, c.g, c.b, c.a
		
	if a == 255 then
		Player:ChatPrint( "You are now invisible." )
		Player:SetColor( Color( 255, 255, 255, 0 ) )
		Player:SetNoDraw( true )
	else
		Player:ChatPrint( "You are now visible again." )
		Player:SetColor( Color( 255, 255, 255, 255 ) )
		Player:SetNoDraw( false )
	end
end)

AddTool("[ALL] Kick Player", "Aim at a player to kick him.", "icon16/cancel.png", function( Player, Trace )
	if IsValid( Trace.Entity ) and Trace.Entity:IsPlayer() then
		Trace.Entity:Kick( "Consider this a warning!" )
		Trace.Entity:EmitSound( "npc/metropolice/vo/finalverdictadministered.wav" )
		Player:ChatPrint( "You kicked " ..Trace.Entity:Nick() )
	end
end)

AddTool("[ALL] Remover", "Aim at any object to remove it.", "icon16/wrench.png", function( Player, Trace )
	if Trace.Entity:IsPlayer() then 
		Player:ChatPrint( "You cannot remove players!" )
		return
	end
			
	if IsValid( Trace.Entity ) then
		--for k, v in pairs( ADMINSTICK_DisallowedEntities ) do
		--	print( v )
			Trace.Entity:Remove()
		--end
	end
end)

AddTool("[ALL] Kill Player", "Aim at a player to kill him.", "icon16/gun.png", function( Player, Trace )
	if IsValid( Trace.Entity ) and Trace.Entity:IsPlayer() then
		Trace.Entity:ChatPrint( "An administrator has killed you." )
		Trace.Entity:Kill()

		Player:ChatPrint( "You killed " ..Trace.Entity:Nick() )
	end
end)

AddTool("[ALL] Teleport", "Teleports you to a targeted location.", "icon16/connect.png", function( Player, Trace )
	local EndPos = Player:GetEyeTrace().HitPos
	local CloserToUs = (Player:GetPos() - EndPos):Angle():Forward()
		
	Player:SetPos( EndPos + ( CloserToUs * 20) )
end)

AddTool("[ALL] Unfreeze (Prop)", "Aim at an entity to unfreeze it.", "icon16/attach.png", function( Player, Trace )
	if IsValid( Trace.Entity ) then
		Trace.Entity:GetPhysicsObject():EnableMotion( true )
		Trace.Entity:GetPhysicsObject():Wake()
		Player:ChatPrint( "You've unfrozen the prop." )
	end
end)

AddTool("[ALL] Warn Player", "Aim at a player to warn him.", "icon16/stop.png", function( Player, Trace )
	if IsValid( Trace.Entity ) and Trace.Entity:IsPlayer() then
		Trace.Entity:ChatPrint( "You are doing something you shouldn't be. Stop." )
		Trace.Entity:EmitSound("npc/metropolice/vo/finalwarning.wav")
	end
end)

AddTool("[ALL] Burn", "Aim at an entity to set it on fire.", "icon16/fire.png", function( Player, Trace )
	if Trace.Entity:IsPlayer() or Trace.Entity:IsNPC() then 
		Player:ChatPrint("You cannot ignite players/npcs.")
		return
	end
	if IsValid( Trace.Entity ) then
		Trace.Entity:Ignite(600,0)
	end
end)

AddTool("[ALL] Slap Player", "Aim at a player to slap him.", "icon16/joystick.png", function( Player, Trace )
	if IsValid( Trace.Entity ) and Trace.Entity:IsPlayer() then
		Trace.Entity:EmitSound( "physics/body/body_medium_impact_hard1.wav" )
		Trace.Entity:SetVelocity( Vector( math.random(5000) - 2500, math.random(5000) - 2500, math.random(5000) - (5000 / 4 ) ) )
	end
end)

AddTool("[ALL] Explode", "Aim at an entity to explode it.", "icon16/bomb.png", function( Player, Trace )
	if IsValid( Trace.Entity ) then
		Trace.Entity:Ignite( 10, 0 )

		local eyetrace = Player:GetEyeTrace()
		local explode = ents.Create( "env_explosion" )
		explode:SetPos( eyetrace.HitPos ) 
		explode:Spawn() 
		explode:SetKeyValue( "iMagnitude","75" ) 
		explode:Fire( "Explode", 0, 0 ) 

		if Trace.Entity:IsPlayer() then
			Trace.Entity:Kill()
		end
	end
end)

AddTool("[ALL] Unlock Door", "Aim at a door to unlock it.", "icon16/key_delete.png", function( Player, Trace )
	if IsValid( Trace.Entity ) and Trace.Entity:IsDoor() then
		Trace.Entity:keysUnLock()
		Player:ChatPrint("Door unlocked.")
	end
end)

AddTool("[DARKRP] Respawn Player", "Use on a player to respawn them.", "icon16/user_gray.png", function( Player, Trace )
	if IsValid( Trace.Entity ) and Trace.Entity:IsDoor() then
		Player:Spawn()
		Player:ChatPrint("The player has been respawned.")
	end
end)

AddTool("[DARKRP] Lock Door", "Aim at a door to lock it.", "icon16/key_add.png", function( Player, Trace )
	if IsValid( Trace.Entity ) and Trace.Entity:IsDoor() then
		Trace.Entity:keysLock()
		Player:ChatPrint("Door locked.")
	end
end)

AddTool( "[DARKRP] Demote Player", "Sets the players job to citizen.", "icon16/user_delete.png", function( Player, Trace )
	if GAMEMODE.Name != "DarkRP" then
		Player:ChatPrint( "This tool only works for DarkRP!" )
		return
	end

	if IsValid( Trace.Entity ) and Trace.Entity:IsPlayer() then
		Trace.Entity:changeTeam( TEAM_CITIZEN )
		DarkRP.notify( Trace.Entity, 1, 5, "An administrator has demoted you!" )
	end
end)

AddTool("[DARKRP] Arrest Player", "Use on a player to arrest them.", "icon16/lock_delete.png", function( Player, Trace )
	if IsValid( Trace.Entity ) and Trace.Entity:IsPlayer() then
		Trace.Entity:onArrestStickUsed( Player )
		Player:ChatPrint( "You have arrested ".. Player:Nick() )
		Trace.Entity:ChatPrint( "An administrator has arrested you!" )
	end
end)

AddTool("[DARKRP] Unarrest Player", "Use on a player to arrest them.", "icon16/lock_open.png", function( Player, Trace )
	if IsValid( Trace.Entity ) and Trace.Entity:IsPlayer() then
		Trace.Entity:onUnArrestStickUsed( Player )
		Player:ChatPrint( "You have unarrested ".. Player:Nick() )
		Trace.Entity:ChatPrint( "An administrator has unarrested you!" )
	end
end)


AddTool("[DARKRP] Abort Hit", "Use on a player to abort any hit on them.", "icon16/stop.png", function( Player, Trace )
	if IsValid( Trace.Entity ) and Trace.Entity:IsPlayer() then
		Trace.Entity:abortHit( "Hit aborted by an administrator." )
		Player:ChatPrint( "The hit has been aborted" )
	end
end)

AddTool( "[DARKRP] Player Info", "Gives you a lot of information about the target.", "icon16/information.png", function( Player, Trace )
	if GAMEMODE.Name != "DarkRP" then
		Player:ChatPrint( "This tool only works for DarkRP!" )
		return
	end

	if IsValid( Trace.Entity ) and Trace.Entity:IsPlayer() then
		DarkRP.notify( Player, 1, 5, "Name: "..Trace.Entity:Nick())
		DarkRP.notify( Player, 1, 5, "SteamID: "..Trace.Entity:SteamID())
		DarkRP.notify( Player, 1, 5, "Team: "..Trace.Entity:Team())
		DarkRP.notify( Player, 1, 5, "Kills: "..Trace.Entity:Frags())
		DarkRP.notify( Player, 1, 5, "Deaths: "..Trace.Entity:Deaths())
		DarkRP.notify( Player, 1, 5, "HP: " ..Trace.Entity:Health())
		DarkRP.notify( Player, 1, 5, "Money: "..Trace.Entity:getDarkRPVar("money"))
		DarkRP.notify( Player, 1, 5, "Has active hit: "..Trace.Entity:GetDriver():hasHit() )

		-- Chat/Console Print
		Player:ChatPrint("Name: "..Trace.Entity:Nick())
		Player:ChatPrint("SteamID: "..Trace.Entity:SteamID())
		Player:ChatPrint("Team: "..Trace.Entity:Team())
		Player:ChatPrint("Kills: "..Trace.Entity:Frags())
		Player:ChatPrint("Deaths: "..Trace.Entity:Deaths())
		Player:ChatPrint("HP: " ..Trace.Entity:Health())
		Player:ChatPrint("Money: "..Trace.Entity:getDarkRPVar("money"))
	elseif IsValid( Trace.Entity ) and Trace.Entity:IsVehicle() then
		if IsValid( Trace.Entity.GetDriver and Trace.Entity:GetDriver() ) then
			DarkRP.notify( Player, 1, 5, "Name: "..Trace.Entity:GetDriver():Nick())
			DarkRP.notify( Player, 1, 5, "SteamID: "..Trace.Entity:GetDriver():SteamID())
			DarkRP.notify( Player, 1, 5, "Kills: "..Trace.Entity:GetDriver():Frags())
			DarkRP.notify( Player, 1, 5, "Deaths: "..Trace.Entity:GetDriver():Deaths())
			DarkRP.notify( Player, 1, 5, "HP: " ..Trace.Entity:GetDriver():Health())
			DarkRP.notify( Player, 1, 5, "Money: "..Trace.Entity:GetDriver():getDarkRPVar("money"))
			DarkRP.notify( Player, 1, 5, "Has active hit: "..Trace.Entity:GetDriver():hasHit() )
			
			-- Chat/Console Print
			Player:ChatPrint("Name: "..Trace.Entity:GetDriver():Nick())
			Player:ChatPrint("SteamID: "..Trace.Entity:GetDriver():SteamID())
			Player:ChatPrint("Kills: "..Trace.Entity:GetDriver():Frags())
			Player:ChatPrint("Deaths: "..Trace.Entity:GetDriver():Deaths())
			Player:ChatPrint("HP: " ..Trace.Entity:GetDriver():Health())
			Player:ChatPrint("Money: "..Trace.Entity:GetDriver():getDarkRPVar("money"))
			Player:ChatPrint("Has active hit: "..Trace.Entity:GetDriver():hasHit() )
		end
	end
end)

AddTool( "[DARKRP - Fire Special] Extinguish (Local)", "Extinguishes the fires near where you aim.", "icon16/fire.png", function( Player, Trace )
	if not timer.Exists( "FIRE_CreateTimer" ) then
		DarkRP.notify( Player, 1, 5, "DarkRP Fire System is required for this tool to work!" )
		return
	end

	if GAMEMODE.Name != "DarkRP" then
		Player:ChatPrint( "This tool only works for DarkRP!" )
		return
	end

	for k, v in pairs( ents.FindInSphere(Trace.HitPos, 250) ) do
		if v:GetClass() == "fire" then
			v:KillFire()
		end
	end

	DarkRP.notify( Player, 1, 5, "All local fire has been removed.")
end)

AddTool("[DARKRP - Fire Special] Extinguish Fires (All)", "Extinguishes all fires on the map.", "icon16/fire.png", function( Player, Trace )
	if not timer.Exists( "FIRE_CreateTimer" ) then
		DarkRP.notify( Player, 1, 5, "DarkRP Fire System is required for this tool to work!" )
		return
	end

	if GAMEMODE.Name != "DarkRP" then
		Player:ChatPrint( "This tool only works for DarkRP!" )
		return
	end

	for k, v in pairs( ents.FindByClass( "fire" ) ) do
		v:KillFire()
	end
	
	DarkRP.notify( Player, 1, 5, "All fires has been removed.")
end)

AddTool("[DARKRP - Fire Special] Create Fire", "Spawns a fire at your target.", "icon16/fire.png", function( Player, Trace )
	if not timer.Exists( "FIRE_CreateTimer" ) then
		DarkRP.notify( Player, 1, 5, "DarkRP Fire System is required for this tool to work!" )
		return
	end

	if GAMEMODE.Name != "DarkRP" then
		Player:ChatPrint( "This tool only works for DarkRP!" )
		return
	end

	local Fire = ents.Create( "fire" )
	Fire:SetPos(Trace.HitPos)
	Fire:Spawn()
end)

AddTool("[TTT] Give Credit", "Give your target 1 credit.", "icon16/coins.png", function( Player, Trace )
	if GAMEMODE.Name != "Trouble In Terrorist Town" then
		Player:ChatPrint( "This tool only works for TTT!" )
		return
	end
	
	if IsValid( Trace.Entity ) and Trace.Entity:IsPlayer() then
		if Trace.Entity:IsActiveDetective() or Trace.Entity:IsActiveTraitor() then
			Trace.Entity:AddCredits( 1 )
			Trace.Entity:ChatPrint( "An administrator has given you 1 credit." )
			Player:ChatPrint( "You have given 1 credit." )
		end
	end
end)

AddTool("[TTT] Reset Karma", "Resets your targets karma to 1000.", "icon16/arrow_undo.png", function( Player, Trace )
	if GAMEMODE.Name != "Trouble In Terrorist Town" then
		Player:ChatPrint( "This tool only works for TTT!" )
		return
	end
	
	if IsValid( Trace.Entity ) and Trace.Entity:IsPlayer() then
		Trace.Entity:SetBaseKarma( 1000 )
		Trace.Entity:ChatPrint( "Your karma has been reset to 1000" )
		Player:ChatPrint( "Karma reset on player!" )
	end
end)