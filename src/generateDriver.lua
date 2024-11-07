--[[
    ! Written by Million - million@axisgames.dev (with help from stiven)
    ? Developed with keyboards and pixie dust.
    * Info: Create Driver then upload the driver, then output the Driver asset id
    ? Tasks:
    ?   * Create the driver
    ?   * Use Remodel to publish the driver
    ?   * Output the driver file
    ! Usage:
    !   * Download nodejs!!!!!
    !   * Open a terminal and run ".\ci\dev.bat"
    !   * Open a terminal and run ".\ci\publish.bat"
    !   * Add the asset-id of the driver into the bypass-loader
]]
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------|    Reference    |--------
math.randomseed(os.time())
local temp = remodel.readFile("./build/anims.temp.txt")
--------|    Variables    |--------
local assetArray = json.fromString(temp)


--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------

local function getAssetFromName(name)
    for _, value in pairs(assetArray) do
        if value[1] == name then
            return value[2]
        end
    end
end

local function getRandomString(length)
    if not length or length <= 0 then return '_' end
    return getRandomString(length - 1) .. math.random(1, 9)
end

local game = remodel.readPlaceFile("build/MRFile.rbxl")
local modifiedNames = {
    ["05044883086"] = getAssetFromName("HoldItem"),
    ["5055479378"] = getAssetFromName("Notes"),
    ["9379332901"] = getAssetFromName("Cooking"),
    ["9379348777"] = getAssetFromName("Cooking"),
    ["9379339456"] = getAssetFromName("Menu"),
    ["9379343400"] = getAssetFromName("Eating"),
    ["5199173349"] = getAssetFromName("Statue"),

    ["__FUNCTIONS"] = "SNOITCNUF__",
    ["_L"] = getRandomString(16),
}

local asdfmovie = getRandomString(8)

local find = table.find or function (haystack, needle)
    for i, v in pairs(haystack) do
        if v == needle then
            return i
        end
    end
end

local split = string.split or function (inputstr, sep)
    if sep == nil then
       sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
       table.insert(t, str)
    end
    return t
end

local function isScript(obj)
    return obj.ClassName == "Script" or obj.ClassName == "ModuleScript" or obj.ClassName == "LocalScript"
end

local function obfuscateString(str, pattern)
    local newStr = modifiedNames[pattern]
    if not newStr then return str end

    return str:gsub(pattern, newStr)
end

local function modifySource(obj)
    local source = remodel.getRawProperty(obj, "Source")
    local lines = split(source, "\n")
    local newSource = {}
    for i, line in ipairs(lines) do
        newSource[i] = obfuscateString(line, "__MAP")
        newSource[i] = obfuscateString(newSource[i], "__REPLICATION")
        newSource[i] = obfuscateString(newSource[i], "__CAMERA_ANGLES")
        newSource[i] = obfuscateString(newSource[i], "__DEBRIS")
        newSource[i] = obfuscateString(newSource[i], "__RGB")
        newSource[i] = obfuscateString(newSource[i], "__VARIABLES")
        newSource[i] = obfuscateString(newSource[i], "__THINGS")

        newSource[i] = obfuscateString(newSource[i], "__DOCS")
        newSource[i] = obfuscateString(newSource[i], "__S_SCRIPTS")
        newSource[i] = obfuscateString(newSource[i], "__C_SCRIPTS")
        newSource[i] = obfuscateString(newSource[i], "__MemoryStoreService")

        newSource[i] = obfuscateString(newSource[i], "__FUNCTIONS")
        newSource[i] = obfuscateString(newSource[i], "__DEBUG_UI")
        newSource[i] = obfuscateString(newSource[i], "__MOD_UI")
        newSource[i] = obfuscateString(newSource[i], "__ADMIN_UI")
        newSource[i] = obfuscateString(newSource[i], "__MERCH")
        newSource[i] = obfuscateString(newSource[i], "RedeemCode")

        newSource[i] = obfuscateString(newSource[i], "05044883086")
        newSource[i] = obfuscateString(newSource[i], "5055479378")
        newSource[i] = obfuscateString(newSource[i], "9379332901")
        newSource[i] = obfuscateString(newSource[i], "9379348777")
        newSource[i] = obfuscateString(newSource[i], "9379339456")
        newSource[i] = obfuscateString(newSource[i], "9379343400")
        newSource[i] = obfuscateString(newSource[i], "5199173349")

        newSource[i] = obfuscateString(newSource[i], "_L")
        newSource[i] = obfuscateString(newSource[i], "Framework")
        newSource[i] = obfuscateString(newSource[i], "Library")
        newSource[i] = obfuscateString(newSource[i], "Modules")
        newSource[i] = obfuscateString(newSource[i], "__CLIENT")
        newSource[i] = obfuscateString(newSource[i], "__SERVER")
        newSource[i] = obfuscateString(newSource[i], "__STORAGE")

        newSource[i] = obfuscateString(newSource[i], "SoftShutdownLocalScript")

        if newSource[i]:find("isSecondIter) and") then
            newSource[i] = "		local childName = ((isSecondIter) and child.Name or string.gsub(string.reverse(from_base64(string.reverse(child.Name))), \"" .. asdfmovie .. "_\", \"\"))"
        end
        if newSource[i]:find("parentName = ") then
            newSource[i] = "		local parentName = ((parent ~= nil) and string.gsub(string.reverse(from_base64(string.reverse(parent.Name))), \"" .. asdfmovie .. "_\", \"\") or \"\")"
        end
        if newSource[i]:find("moduleName = module.Name") then
            newSource[i] = "	local moduleName = string.gsub(string.reverse(from_base64(string.reverse(module.Name))), \"" .. asdfmovie .. "_\", \"\")"
        end
        if newSource[i]:find("_G.GameLoaded = true") then
            newSource[i] = ""
        end
    end
    
    remodel.setRawProperty(obj, "Source", "String", table.concat(newSource, "\n"))
end

local function spoofObject(obj)
    if obj.Name == "BIG Analytics [Secure]" or obj.Name == "BIG Analytics Client" then -- analytics is ew, so we're just gonna remove it
        obj:Destroy()
        return
    end

    local spoofedName = getRandomString(16)

    modifiedNames[obj.Name] = spoofedName
    obj.Name = spoofedName
end

local function spoofDescendants(obj, isFirst)
    for _, child in ipairs(obj:GetChildren()) do
        spoofDescendants(child, true)
    end

    if isFirst ~= nil then
        spoofObject(obj)
    end
end

local function modifyDescendants(obj)
    for _, child in ipairs(obj:GetChildren()) do
        modifyDescendants(child)
    end

    if isScript(obj) then
        modifySource(obj)
    end
end

-- this function converts a string to base64
local function to_base64(data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

local function getAllDriverFiles()
    local Files = {}

    -- WORKSPACE
    Files["Workspace"] = {}
    for _, child in pairs(game.Workspace:GetChildren()) do
        if child.ClassName ~= "Camera" and child.ClassName ~= "Terrain" and child.Name ~= "__STUFF" and child.Name ~= "HD Admin" then
            Files["Workspace"][child.Name] = child
        end
    end

    Files["ReplicatedStorage"] = {}
    for _, child in pairs(game.ReplicatedStorage:GetChildren()) do
        Files["ReplicatedStorage"][child.Name] = child
    end

    Files["ServerScriptService"] = {}
    for _, child in pairs(game.ServerScriptService:GetChildren()) do
        if child.Name ~= "__DOCS" then
            Files["ServerScriptService"][child.Name] = child
        end
    end

    Files["ServerStorage"] = {}
    for _, child in pairs(game.ServerStorage:GetChildren()) do
        if child.Name ~= "__MAP" and child.Name ~= "githubLinks" then
            Files["ServerStorage"][string.reverse(child.Name)] = child
        end
    end

    Files["StarterGui"] = {}
    for _, child in pairs(game.StarterGui:GetChildren()) do
        Files["StarterGui"][child.Name] = child
    end

    Files["ReplicatedFirst"] = {}
    for _, child in pairs(game.ReplicatedFirst:GetChildren()) do
        Files["ReplicatedFirst"][child.Name] = child
    end

    Files["Lighting"] = {}
    for _, child in pairs(game.Lighting:GetChildren()) do
        Files["Lighting"][child.Name] = child
    end

    Files["StarterPlayer"] = {
        ["__C_SCRIPTS"] = game.StarterPlayer:FindFirstChild("StarterPlayerScripts"):FindFirstChild("__C_SCRIPTS"),
        ["__C_CHAR_SCRIPTS"] = game.StarterPlayer:FindFirstChild("StarterCharacterScripts"):FindFirstChild("__C_CHAR_SCRIPTS"),
    }

    return Files
end


-- yes this is the pokemon brick bronze bypass.. shhh!!!
local function generateDriverSource()
    return [[
return function()
    local tag = "MODIFIED PBB Bypass - Faithful#0001"
    print(tag, "loading...")
    
    local overallStartTime, startMemory = tick(), collectgarbage('count')
    
    -- destroy game
    local startTime = tick()
    for _,plr in pairs(game:GetService('Players'):GetChildren()) do
        spawn(function()
            local char = plr.Character or plr.CharacterAdded:Wait()
            char.PrimaryPart.Anchored = true
        end)
    end
    pcall(function() workspace:WaitForChild("Terrain"):Clear() end)

    local chatServiceRunner = game:GetService('ServerScriptService'):FindFirstChild('ChatServiceRunner')
    local defaultChatSystemEvents = game:GetService('ReplicatedStorage'):FindFirstChild('DefaultChatSystemChatEvents')
    for _,obj in pairs(game:GetDescendants()) do
        pcall(function()
            local breaklocal = false
            
			if obj:IsDescendantOf(script) or obj == script then
				breaklocal = true
			end
			
            -- Service Whitelist
            for _,service in pairs({'Chat', 'Players', 'StarterPlayer'}) do
                if obj:IsDescendantOf(game:GetService(service)) then
                    breaklocal = true
                end
            end
            -- Obj Whitelist
            for _,obj1 in pairs({chatServiceRunner, defaultChatSystemEvents}) do
               if obj:IsDescendantOf(obj1) or obj == obj1 then
                   breaklocal = true
               end
            end
            if not breaklocal then
                obj:Destroy()
            end
        end)
    end
    warn('[BYPASS] '..string.format('Game Destroyed in %.2f seconds.', tick()-startTime))
    
    -- ! Load in the game Files.
    
    -- SETTINGS:
    local lighting = game:GetService("Lighting")
    lighting.Ambient = Color3.fromRGB(199, 142, 255)
    lighting.Brightness = 3
    lighting.ColorShift_Bottom = Color3.fromRGB(255, 255, 255)
    lighting.ColorShift_Top = Color3.fromRGB(176, 249, 255)
    lighting.EnvironmentDiffuseScale = 0.25
    lighting.EnvironmentSpecularScale = 0.25
    lighting.GlobalShadows = true
    lighting.OutdoorAmbient = Color3.fromRGB(221, 255, 252)
    lighting.ClockTime = 15.2
    lighting.GeographicLatitude = 195
    lighting.ExposureCompensation = -0.45
    lighting.FogColor = Color3.fromRGB(192, 192, 192)
    lighting.FogEnd = 100000
    lighting.FogStart = 0
    
    local starterPlayer = game:GetService("StarterPlayer")
    starterPlayer.HealthDisplayDistance = 0
    starterPlayer.NameDisplayDistance = 100
    starterPlayer.CameraMaxZoomDistance = 100
    starterPlayer.CameraMinZoomDistance = 0.5
    starterPlayer.CameraMode = Enum.CameraMode.Classic
    starterPlayer.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Zoom
    starterPlayer.DevComputerMovementMode = Enum.DevComputerMovementMode.UserChoice
    starterPlayer.DevTouchMovementMode = Enum.DevTouchMovementMode.UserChoice
    starterPlayer.EnableMouseLockOption = true
    starterPlayer.CharacterMaxSlopeAngle = 89
    starterPlayer.CharacterWalkSpeed = 16
    starterPlayer.LoadCharacterAppearance = true
    starterPlayer.UserEmotesEnabled = true
    starterPlayer.CharacterJumpPower = 50
    starterPlayer.CharacterUseJumpPower = true
    starterPlayer.AutoJumpEnabled = true
    
    local soundService = game:GetService("SoundService")
    soundService.AmbientReverb = Enum.ReverbType.NoReverb
    soundService.DistanceFactor = 3.33
    soundService.DopplerScale = 1
    soundService.Name = "SoundService" -- roblox is so awesome
    soundService.RespectFilteringEnabled = true
    soundService.RolloffScale = 1

    local physService = game:GetService("PhysicsService")
	physService:CreateCollisionGroup("CharacterGroup")
	physService:CreateCollisionGroup("EventGroup")
	physService:CreateCollisionGroup("FloorGroup")
	physService:CreateCollisionGroup("FurnitureApplianceGroup")
	physService:CreateCollisionGroup("NPCGroup")
	physService:CreateCollisionGroup("PresentGroup")
	
	-- CharacterGroup
	physService:CollisionGroupSetCollidable("CharacterGroup", "PresentGroup", true)
	physService:CollisionGroupSetCollidable("CharacterGroup", "NPCGroup", false)
	physService:CollisionGroupSetCollidable("CharacterGroup", "FurnitureApplianceGroup", true)
	physService:CollisionGroupSetCollidable("CharacterGroup", "FloorGroup", true)
	physService:CollisionGroupSetCollidable("CharacterGroup", "EventGroup", false)
	physService:CollisionGroupSetCollidable("CharacterGroup", "CharacterGroup", true)
	
	-- EventGroup
	physService:CollisionGroupSetCollidable("EventGroup", "PresentGroup", false)
	physService:CollisionGroupSetCollidable("EventGroup", "NPCGroup", true)
	physService:CollisionGroupSetCollidable("EventGroup", "FurnitureApplianceGroup", true)
	physService:CollisionGroupSetCollidable("EventGroup", "FloorGroup", true)
	physService:CollisionGroupSetCollidable("EventGroup", "EventGroup", true)

	-- EventGroup
	physService:CollisionGroupSetCollidable("FloorGroup", "PresentGroup", true)
	physService:CollisionGroupSetCollidable("FloorGroup", "NPCGroup", true)
	physService:CollisionGroupSetCollidable("FloorGroup", "FurnitureApplianceGroup", true)
	physService:CollisionGroupSetCollidable("FloorGroup", "FloorGroup", true)

	-- FurnitureApplianceGroup
	physService:CollisionGroupSetCollidable("FurnitureApplianceGroup", "PresentGroup", true)
	physService:CollisionGroupSetCollidable("FurnitureApplianceGroup", "NPCGroup", false)
	physService:CollisionGroupSetCollidable("FurnitureApplianceGroup", "FurnitureApplianceGroup", true)

	-- FurnitureApplianceGroup
	physService:CollisionGroupSetCollidable("NPCGroup", "PresentGroup", false)
	physService:CollisionGroupSetCollidable("NPCGroup", "NPCGroup", false)

	-- FurnitureApplianceGroup
	physService:CollisionGroupSetCollidable("PresentGroup", "PresentGroup", true)
    
    local chat = game:GetService("Chat")
    chat.BubbleChatEnabled = true
    
    warn('[BYPASS] '..string.format('Settings Applied in %.2f seconds.', tick()-startTime))
    
    local function from_base64(data)
        local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
        data = string.gsub(data, '[^'..b..'=]', '')
        return (data:gsub('.', function(x)
            if (x == '=') then return '' end
            local r,f='',(b:find(x)-1)
            for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
            return r;
        end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
            if (#x ~= 8) then return '' end
            local c=0
            for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
            return string.char(c)
        end))
    end
    
    for _,service in pairs(script:GetChildren()) do
    	for _,obj in pairs(service:GetChildren()) do
            local serviceName = string.gsub(string.reverse(from_base64(string.reverse(service.Name))), "]] .. asdfmovie .. [[_", "")
    		if serviceName == 'StarterPlayer' then
    			for _,obj1 in pairs(obj:GetChildren()) do
    				obj1.Parent = game:GetService('StarterPlayer'):WaitForChild(obj.Name == "]] .. modifiedNames["__C_SCRIPTS"] .. [[" and "StarterPlayerScripts" or "StarterCharacterScripts")	
    			end
    		else
    			obj.Parent = game:GetService(serviceName)	
    		end
    	end
    end
    warn('[BYPASS] '..string.format('Files loaded in %.2f seconds.', tick()-startTime))
    
    -- Tp all the players in the game back to the game to reload them.
    if game:GetService("RunService"):IsStudio() then
		warn("[BYPASS] Bypass wont load in studio ;c")
	else
		local startTime = tick()
		repeat wait() until #game:GetService('Players'):GetChildren() > 1
		wait(2)
		for _,plr in pairs(game:GetService('Players'):GetChildren()) do
			spawn(function()
				game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId, plr)
			end)
			wait(#game:GetService('Players'):GetChildren() == 2 and 10 or 1)
		end
		warn('[BYPASS] '..string.format('Players tped in %.2f seconds.', tick()-startTime))
	end
    warn('[BYPASS] '..string.format('Players tped in %.2f seconds.', tick()-startTime))

    -- Load the Game.
    print(tag..string.format(' loaded in %.2f seconds; %.2f MB', tick()-overallStartTime, (collectgarbage('count')-startMemory)/1000))
    
    -- tell client we completed
    workspace:SetAttribute("GameLoaded", true)
    _G.GameLoaded = true
    script:Destroy()
end
    ]]
end

-- File to upload
local DriverFile = Instance.new("ModuleScript")
DriverFile.Name = "MainModule"

local driverFiles = getAllDriverFiles()
for folderName, folderValue in pairs(driverFiles) do
    local folder = Instance.new("Model")
    folder.Name = string.reverse(to_base64(string.reverse(asdfmovie .. "_" .. folderName)))
    folder.Parent = DriverFile

    for _, child in pairs(folderValue) do
        child.Parent = folder
    end

    if folderName == "Workspace" then
        for _, child in pairs(folder:GetChildren()) do
            spoofObject(child)
        end
    elseif folderName == "ServerScriptService" then
        spoofDescendants(folder.__S_SCRIPTS.Core, true)
        spoofDescendants(folder.__S_SCRIPTS.Game, true)
        spoofDescendants(folder.__S_SCRIPTS.ThiccCode, true)
    elseif folderName == "StarterPlayer" then
        for _, child in pairs(folder.__C_SCRIPTS:GetDescendants()) do
            if isScript(child) or child.ClassName == "Folder" then
                spoofObject(child)
            end
        end

        spoofObject(folder.__C_SCRIPTS)
        spoofDescendants(folder.__C_CHAR_SCRIPTS, true)
    elseif folderName == "ServerStorage" then
        for _, child in pairs(folder:GetChildren()) do
            spoofObject(child)
        end
    elseif folderName == "StarterGui" then
        for _, child in pairs(folder:GetChildren()) do
            if child.Name == "__FUNCTIONS" then
                child.Name = string.reverse(child.Name)
            else
                child.Name = string.reverse(to_base64(string.reverse(asdfmovie .. "_" .. child.Name)))
            end

            for _, descendant in pairs(child:GetChildren()) do
                descendant.Name = string.reverse(to_base64(string.reverse(asdfmovie .. "_" .. descendant.Name)))
            end
        end
    elseif folderName == "ReplicatedStorage" then
        local framework = folder:FindFirstChild("Framework")
        local modules = framework:FindFirstChild("Modules")
        local serverModules = modules:FindFirstChild("__SERVER")
        
        spoofObject(folder:FindFirstChild("RedeemCode"))

        spoofObject(framework)
        spoofObject(framework:FindFirstChild("Library"))
        spoofObject(modules)
        spoofObject(modules:FindFirstChild("__CLIENT"))
        spoofObject(serverModules)
        spoofObject(serverModules:FindFirstChild("__STORAGE"))

        local descendantBlacklist = { "styles", "Enum", "CharacterUtilities", "ReplicationEvents", "MinHeap" }
        for _, descendant in pairs(modules:GetDescendants()) do
            if descendant.ClassName == "ModuleScript" and find(descendantBlacklist, descendant.Name) == nil then
                descendant.Name = string.reverse(to_base64(string.reverse(asdfmovie .. "_" .. descendant.Name)))
            end
        end
    end
end

for _, folder in pairs(DriverFile:GetChildren()) do
    modifyDescendants(folder)
end

remodel.setRawProperty(DriverFile, "Source", "String", generateDriverSource())

-- for _, folder in pairs(DriverFile:GetChildren()) do
--     -- Save out each child as an rbxmx model
-- 	remodel.writeModelFile("out/MODELS/" .. folder.Name .. ".rbxm", folder)
-- end

remodel.writeModelFile("out/Driver.rbxm", DriverFile)
