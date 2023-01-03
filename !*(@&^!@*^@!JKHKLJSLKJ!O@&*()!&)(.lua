_G.chamsEnabled = true

                        if not LPH_OBFUSCATED then
                        LPH_JIT = function(...) return ... end
                        LPH_JIT_MAX = function(...) return ... end
                        LPH_JIT_ULTRA = function(...) return ... end
                        LPH_NO_VIRTUALIZE = function(...) return ... end
                        LPH_NO_UPVALUES = function(f) return(function(...) return f(...) end) end
                        LPH_ENCSTR = function(...) return ... end
                        LPH_HOOK_FIX = function(...) return ... end
                        LPH_CRASH = function() return print(debug.traceback()) end
                        end;

                        -- // Overrides
                        LPH_NO_VIRTUALIZE(function()
                        local __index; __index = hookmetamethod(game, "__index", function(self, prop)
                            if checkcaller() then
                                if self:IsA("Player") and prop == "Character" and workspace.Players:FindFirstChild(self.Name) then
                                    return workspace.Players[self.Name];
                                end;
                            end;
                            return __index(self, prop);
                        end);
                        end)()

                        if not table_flip then
                            function table_flip(t)local tt={};for i,v in pairs(t) do tt[v]=i;end;return tt;end
                            b91enc={'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '!', '#', '$', '%', '&', '(', ')', '*', '+', ',', '.', '/', ':', ';', '<', '=', '>', '?', '@', '[', ']', '^', '_', '`', '{', '|', '}', '~', '"'}; b91enc[0]='A'; b91dec=table_flip(b91enc)
                            function base91_decode(d)local l,v,o,b,n = #d,-1,"",0,0;for i in d:gmatch(".") do local c=b91dec[i];if not(c) then else if v < 0 then v = c;else v = v+c*91;b = bit.bor(b, bit.lshift(v,n));if bit.band(v,8191) then n = n + 13;else n = n + 14;end;while true do o=o..string.char(bit.band(b,255));b=bit.rshift(b,8);n=n-8;if not (n>7) then break;end;end;v=-1;end;end;end;if v + 1>0 then o=o..string.char(bit.band(bit.bor(b,bit.lshift(v,n)),255));end;return o;end
                            function base91_encode(d)local b,n,o,l=0,0,"",#d;for i in d:gmatch(".") do b=bit.bor(b,bit.lshift(string.byte(i),n));n=n+8;if n>13 then v=bit.band(b,8191);if v>88 then b=bit.rshift(b,13);n=n-13;else v=bit.band(b,16383);b=bit.rshift(b,14);n=n-14;end;o=o..b91enc[v % 91] .. b91enc[math.floor(v / 91)];end;end;if n>0 then o=o..b91enc[b % 91];if n>7 or b>90 then o=o .. b91enc[math.floor(b / 91)];end;end;return o;end
                            function is_lower(c)return c:lower() == c;end
                            function swap_case(s)s = s:gsub(".", function(c)return is_lower(c) and c:upper() or c:lower();end);return s;end    
                        end
                        
                        if not game:IsLoaded() then
                            game.Loaded:Wait()
                        end
                        
                        local Loaded, Running = false, true
                        
                        -- Services
                        local Workspace = game:GetService("Workspace")
                        local Terrain = Workspace:FindFirstChildOfClass("Terrain")
                        local Camera = Workspace.CurrentCamera
                        local Players = game:GetService("Players")
                        local LocalPlayer = Players.LocalPlayer
                        local RunService = game:GetService("RunService")
                        local UserInputService = game:GetService("UserInputService")
                        local HttpService = game:GetService("HttpService")
                        local Lighting = game:GetService("Lighting")
                        local NetworkClient = game:GetService("NetworkClient")
                        local Mouse = LocalPlayer:GetMouse()
                        local ContextActionService = game:GetService("ContextActionService")
                        
                        -- Metatable Hooks
                        local Flags, IsClicking, LastCameraCFrame = nil, false, CFrame.new(0, 0, 0)
                        local Ray_new, Utility, createTracer, Ray_new, __index, __newindex, __namecall
                        local FreeCamera = {
                            Speed = 0.5,
                            CFrame = CFrame.new(0, 0, 0)
                        }
                        local Aimbot = {
                            Player = nil, 
                            Target = nil
                        }
                        local Methods_Debug = {}
                        local Old_Gravity = Workspace.Gravity
                        local Old_Camera = {
                            FieldOfView = Camera.FieldOfView,
                            DiagonalFieldOfView = Camera.DiagonalFieldOfView,
                            MaxAxisFieldOfView = Camera.MaxAxisFieldOfView
                        }
                        local Old_Decoration = gethiddenproperty(Terrain, "Decoration")
                        local Old_Lighting = {
                            Ambient = Lighting.Ambient,
                            Brightness = Lighting.Brightness,
                            ColorShift_Bottom = Lighting.ColorShift_Bottom,
                            ColorShift_Top = Lighting.ColorShift_Top,
                            EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale,
                            EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale,
                            GlobalShadows = Lighting.GlobalShadows,
                            OutdoorAmbient = Lighting.OutdoorAmbient,
                            Technology = gethiddenproperty(Lighting, "Technology"),
                            ClockTime = Lighting.ClockTime,
                            TimeOfDay = Lighting.TimeOfDay,
                            ExposureCompensation = Lighting.ExposureCompensation
                        }
                        for _, connection in pairs(getconnections(Workspace:GetPropertyChangedSignal("Gravity"))) do
                            connection:Disable()
                        end
                        for _, connection in pairs(getconnections(Workspace.Changed)) do
                            connection:Disable()
                        end
                        local Character = LocalPlayer.Character
                        if Character then
                            local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                            if Humanoid then
                                for _, connection in pairs(getconnections(Humanoid.StateChanged)) do
                                    connection:Disable()
                                end
                            end
                        end
                        Character = nil
                        local fakeSignal = {Connected = true}
                        fakeSignal.__index = fakeSignal
                        function fakeSignal:Connect() return self end
                        function fakeSignal:connect() return self end
                        function fakeSignal:Disconnect() end
                        function fakeSignal:disconnect() end
                        function fakeSignal:Wait() return wait() end
                        function fakeSignal:wait() return wait() end
                        LPH_JIT_ULTRA(function()
                            Ray_new = hookfunction(Ray.new, function(Origin, Direction)
                                if not Running or checkcaller() or not Loaded then return Ray_new(Origin, Direction) end
                                if Flags.aimbotEnabled and Flags.aimbotSilent and Aimbot.Target then
                                    if not Flags.aimbotEnabledBind then return Ray_new(Origin, Direction) end
                                    if table.find(Flags.silentProperties, "ray") then
                                        local Script, teleportBullet = getcallingscript(), table.find(Flags.silentExploits, "Teleport Bullet")
                                        if Flags.silentPrintScript then
                                            if Methods_Debug[tostring(Script)] == nil then
                                                Methods_Debug[tostring(Script)] = {}
                                            end
                                            if Methods_Debug[tostring(Script)]["ray"] == nil then
                                                Methods_Debug[tostring(Script)]["ray"] = 0
                                            end
                                            Methods_Debug[tostring(Script)]["ray"] = Methods_Debug[tostring(Script)]["ray"] + 1
                                        end
                                        if Flags.silentScript ~= "" and Flags.silentScript:lower() ~= tostring(Script):lower() then return Ray_new(Origin, Direction) end
                                        Origin = Flags.silentOrigin == "Camera" and Camera.CFrame.p or Flags.silentOrigin == "Head" and LocalPlayer.Character.Head.Position or Flags.silentOrigin == "First Person" and LastCameraCFrame or Origin
                                        local shouldMiss = false
                                        if Flags.silentMissChance >= math.random(1, 100) then
                                            shouldMiss = true
                                        end
                                        local Target = Aimbot.Target
                                        local TargetPos = Target.CFrame
                                        if shouldMiss then
                                            local Where = math.random(1, 4)
                                            if Where == 1 then
                                                TargetPos = TargetPos * CFrame.new(3.5, 4, 0)
                                            elseif Where == 2 then
                                                TargetPos = TargetPos * CFrame.new(-3.5, 4, 0)
                                            elseif Where == 3 then
                                                TargetPos = TargetPos * CFrame.new(3.5, -4, 0)
                                            elseif Where == 4 then
                                                TargetPos = TargetPos * CFrame.new(-3.5, -4, 0)
                                            end
                                        end
                                        TargetPos = TargetPos.Position
                                        if teleportBullet then
                                            local From = (Target.CFrame * CFrame.new(0, 0, -1.5)).p
                                            if Flags.silentVisualizeRays then 
                                                createTracer(TargetPos, From) 
                                            end
                                            return Ray_new(From, (TargetPos - From).unit * 10000)
                                        else
                                            if Flags.silentVisualizeRays then 
                                                createTracer(TargetPos, Origin) 
                                            end
                                            return Ray_new(Origin, (TargetPos - Origin).unit * 10000)
                                        end
                                    end
                                end
                                return Ray_new(Origin, Direction)
                            end)
                            __index = hookmetamethod(game, "__index", newcclosure(function(k, v)
                                if not Running or checkcaller() or not Loaded then return __index(k, v) end
                                if k == Lighting then
                                    if Old_Lighting[v] then return Old_Lighting[v] end
                                end
                                if k == Camera then
                                    if Old_Camera[v] then return Old_Camera[v] end
                                    if v == "CFrame" then
                                        if Flags.lPlayerThirdPerson and Flags.lPlayerThirdPersonBind or Flags.lplayerFreeCamera and Flags.lplayerFreeCameraBind then
                                            return LastCameraCFrame
                                        end
                                    end
                                end
                                if k == Workspace and v == "Gravity" then return Old_Gravity end
                                if tostring(k) == "Humanoid" then
                                    if v == "PlatformStand" then 
                                        return false 
                                    end
                                    if v == "AutoRotate" then
                                        return true
                                    end
                                    if v == "StateChanged" then
                                        return fakeSignal
                                    end
                                end
                                if v == "CanCollide" and k.Parent == LocalPlayer.Character then return true end
                                if v == "Archivable" and k == LocalPlayer.Character then return false end
                                if Flags.aimbotEnabled and Flags.aimbotSilent and Aimbot.Target then
                                    if not Flags.aimbotEnabledBind then return __index(k, v) end
                                    if table.find(Flags.silentProperties, v) then
                                        local Script = getcallingscript()
                                        v = v:lower()
                                        if Flags.silentPrintScript then
                                            if Methods_Debug[tostring(Script)] == nil then
                                                Methods_Debug[tostring(Script)] = {}
                                            end
                                            if Methods_Debug[tostring(Script)][v] == nil then
                                                Methods_Debug[tostring(Script)][v] = 0
                                            end
                                            Methods_Debug[tostring(Script)][v] = Methods_Debug[tostring(Script)][v] + 1
                                        end
                                        if Flags.silentScript ~= "" and Flags.silentScript:lower() ~= tostring(Script):lower() then return __index(k, v) end
                                        local shouldMiss = false
                                        if Flags.silentMissChance >= math.random(1, 100) then
                                            shouldMiss = true
                                        end
                                        if k == Mouse and v == "unitray" then
                                            return shouldMiss and Ray.new(Camera.CFrame.p, (Aimbot.Target.Position + Vector3.new(2, -2, -2) - Camera.CFrame.p).unit * 10000) or Ray.new(Camera.CFrame.p, (Aimbot.Target.Position - Camera.CFrame.p).unit * 10000)
                                        end
                                        if k == Mouse and v == "hit" then
                                            return shouldMiss and CFrame.new(Aimbot.Predicted + Vector3.new(2, -2, 2)) or CFrame.new(Aimbot.Predicted)
                                        end
                                        if v == "targetpoint" then
                                            return shouldMiss and (Aimbot.Predicted + Vector3.new(2, -2, 2)) or Aimbot.Predicted
                                        end
                                        if k == Mouse and v == "target" then
                                            return Aimbot.Target
                                        end
                                    end
                                end
                                return __index(k, v)
                            end))
                            __namecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
                                if not Running or checkcaller() or not Loaded then return __namecall(self, ...) end
                                local Args, Method, Script = {...}, getnamecallmethod(), getcallingscript()
                                if Method == "GetState" then
                                    return Enum.HumanoidStateType.Running
                                end
                                if Flags.aimbotEnabled and Flags.aimbotSilent and Aimbot.Target then
                                    if not Flags.aimbotEnabledBind then return __namecall(self, ...) end
                                    if table.find(Flags.silentFunctions, Method:lower()) then
                                        Method = Method:lower()
                                        if Flags.silentPrintScript then
                                            if Methods_Debug[tostring(Script)] == nil then
                                                Methods_Debug[tostring(Script)] = {}
                                            end
                                            if Methods_Debug[tostring(Script)][Method] == nil then
                                                Methods_Debug[tostring(Script)][Method] = 0
                                            end
                                            Methods_Debug[tostring(Script)][Method] = Methods_Debug[tostring(Script)][Method] + 1
                                        end
                                        if Flags.silentScript ~= "" and Flags.silentScript:lower() ~= tostring(Script):lower() then return __namecall(self, ...) end
                                        local silentIncludes = Flags.silentIncludes
                                        local shouldMiss = false
                                        if Flags.silentMissChance >= math.random(1, 100) then
                                            shouldMiss = true
                                        end
                                        local findCamera, findCharacter, teleportBullet = table.find(silentIncludes, "Camera"), table.find(silentIncludes, "Character"), table.find(Flags.silentExploits, "Teleport Bullet")
                                        if Method == "raycast" then
                                            local Args_3 = Args[3]
                                            local Filter = Args_3.FilterDescendantsInstances
                                            if #Filter < Flags.silentMinIgnored then return __namecall(self, ...) end
                                            if findCamera and not table.find(Filter, Camera) then return __namecall(self, ...) end
                                            if findCharacter and not table.find(Filter, LocalPlayer.Character) then return __namecall(self, ...) end
                                            local Origin = Flags.silentOrigin == "Camera" and Camera.CFrame.p or Flags.silentOrigin == "Head" and LocalPlayer.Character.Head.Position or Flags.silentOrigin == "First Person" and LastCameraCFrame or Args[1]
                                            local Target = Aimbot.Target
                                            local TargetPos = Target.CFrame
                                            if shouldMiss then
                                                local Where = math.random(1, 4)
                                                if Where == 1 then
                                                    TargetPos = TargetPos * CFrame.new(3.5, 4, 0)
                                                elseif Where == 2 then
                                                    TargetPos = TargetPos * CFrame.new(-3.5, 4, 0)
                                                elseif Where == 3 then
                                                    TargetPos = TargetPos * CFrame.new(3.5, -4, 0)
                                                elseif Where == 4 then
                                                    TargetPos = TargetPos * CFrame.new(-3.5, -4, 0)
                                                end
                                            end
                                            TargetPos = TargetPos.Position
                                            if teleportBullet then
                                                local From = (Target.CFrame * CFrame.new(0, 0, -1.5)).p
                                                Args[2] = (TargetPos - From).unit * 10000
                                                if Flags.silentVisualizeRays then 
                                                    createTracer(TargetPos, From) 
                                                end
                                                return __namecall(self, unpack(Args))
                                            else
                                                Args[2] = (TargetPos - Origin).unit * 10000
                                                if Flags.silentVisualizeRays then 
                                                    createTracer(TargetPos, Origin) 
                                                end
                                                return __namecall(self, unpack(Args))
                                            end
                                        end
                                        if Method == "findpartonraywithignorelist" then
                                            local Args_2 = Args[2]
                                            if #Args_2 < Flags.silentMinIgnored then return __namecall(self, ...) end
                                            if findCamera and not table.find(Args_2, Camera) then return __namecall(self, ...) end
                                            if findCharacter and not table.find(Args_2, LocalPlayer.Character) then return __namecall(self, ...) end
                                            local Origin = Flags.silentOrigin == "Camera" and Camera.CFrame.p or Flags.silentOrigin == "Head" and LocalPlayer.Character.Head.Position or Flags.silentOrigin == "First Person" and LastCameraCFrame or Args[1].Origin
                                            local Target = Aimbot.Target
                                            local TargetPos = Target.CFrame
                                            if shouldMiss then
                                                local Where = math.random(1, 4)
                                                if Where == 1 then
                                                    TargetPos = TargetPos * CFrame.new(3.5, 4, 0)
                                                elseif Where == 2 then
                                                    TargetPos = TargetPos * CFrame.new(-3.5, 4, 0)
                                                elseif Where == 3 then
                                                    TargetPos = TargetPos * CFrame.new(3.5, -4, 0)
                                                elseif Where == 4 then
                                                    TargetPos = TargetPos * CFrame.new(-3.5, -4, 0)
                                                end
                                            end
                                            TargetPos = TargetPos.Position
                                            if teleportBullet then
                                                local From = (Target.CFrame * CFrame.new(0, 0, -1.5)).p
                                                Args[1] = Ray.new(From, (TargetPos - From).unit * 10000)
                                                if Flags.silentVisualizeRays then 
                                                    createTracer(TargetPos, From) 
                                                end
                                                return __namecall(self, unpack(Args))
                                            else
                                                Args[1] = Ray.new(Origin, (TargetPos - Origin).unit * 10000)
                                                if Flags.silentVisualizeRays then 
                                                    createTracer(TargetPos, Origin) 
                                                end
                                                return __namecall(self, unpack(Args))
                                            end
                                        end
                                        if Method == "findpartonraywithwhitelist" then
                                            local Args_2 = Args[2]
                                            if #Args_2 < Flags.silentMinIgnored then return __namecall(self, ...) end
                                            if findCamera and not table.find(Args_2, Camera) then return __namecall(self, ...) end
                                            if findCharacter and not table.find(Args_2, LocalPlayer.Character) then return __namecall(self, ...) end
                                            local Origin = Flags.silentOrigin == "Camera" and Camera.CFrame.p or Flags.silentOrigin == "Head" and LocalPlayer.Character.Head.Position or Flags.silentOrigin == "First Person" and LastCameraCFrame or Args[1].Origin
                                            local Target = Aimbot.Target
                                            local TargetPos = Target.CFrame
                                            if shouldMiss then
                                                local Where = math.random(1, 4)
                                                if Where == 1 then
                                                    TargetPos = TargetPos * CFrame.new(3.5, 4, 0)
                                                elseif Where == 2 then
                                                    TargetPos = TargetPos * CFrame.new(-3.5, 4, 0)
                                                elseif Where == 3 then
                                                    TargetPos = TargetPos * CFrame.new(3.5, -4, 0)
                                                elseif Where == 4 then
                                                    TargetPos = TargetPos * CFrame.new(-3.5, -4, 0)
                                                end
                                            end
                                            TargetPos = TargetPos.Position
                                            if teleportBullet then
                                                local From = (Target.CFrame * CFrame.new(0, 0, -1.5)).p
                                                Args[1] = Ray.new(From, (TargetPos - From).unit * 10000)
                                                if Flags.silentVisualizeRays then 
                                                    createTracer(TargetPos, From) 
                                                end
                                                return __namecall(self, unpack(Args))
                                            else
                                                Args[1] = Ray.new(Origin, (TargetPos - Origin).unit * 10000)
                                                if Flags.silentVisualizeRays then 
                                                    createTracer(TargetPos, Origin) 
                                                end
                                                return __namecall(self, unpack(Args))
                                            end
                                        end
                                        if Method == "findpartonray" then
                                            local Origin = Flags.silentOrigin == "Camera" and Camera.CFrame.p or Flags.silentOrigin == "Head" and LocalPlayer.Character.Head.Position or Flags.silentOrigin == "First Person" and LastCameraCFrame or Args[1].Origin
                                            local Target = Aimbot.Target
                                            local TargetPos = Target.CFrame
                                            if shouldMiss then
                                                local Where = math.random(1, 4)
                                                if Where == 1 then
                                                    TargetPos = TargetPos * CFrame.new(3.5, 4, 0)
                                                elseif Where == 2 then
                                                    TargetPos = TargetPos * CFrame.new(-3.5, 4, 0)
                                                elseif Where == 3 then
                                                    TargetPos = TargetPos * CFrame.new(3.5, -4, 0)
                                                elseif Where == 4 then
                                                    TargetPos = TargetPos * CFrame.new(-3.5, -4, 0)
                                                end
                                            end
                                            TargetPos = TargetPos.Position
                                            if teleportBullet then
                                                local From = (Target.CFrame * CFrame.new(0, 0, -1.5)).p
                                                Args[1] = Ray.new(From, (TargetPos - From).unit * 10000)
                                                if Flags.silentVisualizeRays then 
                                                    createTracer(TargetPos, From) 
                                                end
                                                return __namecall(self, unpack(Args))
                                            else
                                                Args[1] = Ray.new(Origin, (TargetPos - Origin).unit * 10000)
                                                if Flags.silentVisualizeRays then 
                                                    createTracer(TargetPos, Origin) 
                                                end
                                                return __namecall(self, unpack(Args))
                                            end
                                        end
                                        if Method == "screenpointtoray" then
                                            local Origin = Flags.silentOrigin == "Camera" and Camera.CFrame.p or Flags.silentOrigin == "Head" and LocalPlayer.Character.Head.Position or Flags.silentOrigin == "First Person" and LastCameraCFrame or Camera.CFrame.p
                                            local Target = Aimbot.Target
                                            local TargetPos = Target.CFrame
                                            if shouldMiss then
                                                local Where = math.random(1, 4)
                                                if Where == 1 then
                                                    TargetPos = TargetPos * CFrame.new(3.5, 4, 0)
                                                elseif Where == 2 then
                                                    TargetPos = TargetPos * CFrame.new(-3.5, 4, 0)
                                                elseif Where == 3 then
                                                    TargetPos = TargetPos * CFrame.new(3.5, -4, 0)
                                                elseif Where == 4 then
                                                    TargetPos = TargetPos * CFrame.new(-3.5, -4, 0)
                                                end
                                            end
                                            TargetPos = TargetPos.Position
                                            if teleportBullet then
                                                local From = (Target.CFrame * CFrame.new(0, 0, -1.5)).p
                                                if Flags.silentVisualizeRays then 
                                                    createTracer(TargetPos, From) 
                                                end
                                                return Ray.new(From, (TargetPos - From).unit * 10000)
                                            else
                                                if Flags.silentVisualizeRays then 
                                                    createTracer(TargetPos, Origin) 
                                                end
                                                return Ray.new(Origin, (TargetPos - Origin).unit * 10000)
                                            end
                                        end
                                        if Method == "viewportpointtoray" then
                                            local Origin = Flags.silentOrigin == "Camera" and Camera.CFrame.p or Flags.silentOrigin == "Head" and LocalPlayer.Character.Head.Position or Flags.silentOrigin == "First Person" and LastCameraCFrame or Camera.CFrame.p
                                            local Target = Aimbot.Target
                                            local TargetPos = Target.CFrame
                                            if shouldMiss then
                                                local Where = math.random(1, 4)
                                                if Where == 1 then
                                                    TargetPos = TargetPos * CFrame.new(3.5, 4, 0)
                                                elseif Where == 2 then
                                                    TargetPos = TargetPos * CFrame.new(-3.5, 4, 0)
                                                elseif Where == 3 then
                                                    TargetPos = TargetPos * CFrame.new(3.5, -4, 0)
                                                elseif Where == 4 then
                                                    TargetPos = TargetPos * CFrame.new(-3.5, -4, 0)
                                                end
                                            end
                                            TargetPos = TargetPos.Position
                                            if teleportBullet then
                                                local From = (Target.CFrame * CFrame.new(0, 0, -1.5)).p
                                                if Flags.silentVisualizeRays then 
                                                    createTracer(TargetPos, From) 
                                                end
                                                return Ray.new(From, (TargetPos - From).unit * 10000)
                                            else
                                                if Flags.silentVisualizeRays then 
                                                    createTracer(TargetPos, Origin) 
                                                end
                                                return Ray.new(Origin, (TargetPos - Origin).unit * 10000)
                                            end
                                        end
                                    end
                                end
                                return __namecall(self, ...)
                            end))
                            __newindex = hookmetamethod(game, "__newindex", function(i, v, n_v)
                                if not Running or checkcaller() or not Loaded then return __newindex(i, v, n_v) end
                        
                                if i == Camera and v == "CFrame" then
                                    LastCameraCFrame = n_v
                                    if Flags.lplayerFreeCamera and Flags.lplayerFreeCameraBind then
                                        return __newindex(i, v, CFrame.lookAt(FreeCamera.CFrame.p, FreeCamera.CFrame.p + n_v.LookVector))
                                    end
                                    if Flags.lPlayerThirdPerson and Flags.lPlayerThirdPersonBind then
                                        return __newindex(i, v, n_v + Camera.CFrame.LookVector * -Flags.lPlayerThirdPersonValue)
                                    end
                                end
                        
                                return __newindex(i, v, n_v)
                            end)
                        end)()
                        
                        -- User Interface
                        local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/killerof9ods/New_Ui_Lib/main/New_Lib_Ui.lua"))({
                            cheatname = 'Decayed',
                            gamename = 'Universal';
                            fileext = '.json'
                        })
                        local Utility = Library.utility
                        Library:init()
                        local ESP, ESP_RenderStepped, Framework = loadstring(game:HttpGet("https://raw.githubusercontent.com/killerof9ods/IonHub_esp_Lib/main/esp_lib.lua"))()
                        local Wheld, Sheld, Aheld, Dheld, Eheld, Qheld = false, false, false, false, false, false
                        local Input, Connection
                        
                        LPH_JIT_ULTRA(function()
                            Input = {}; do
                                function Input:Block()
                                    ContextActionService:BindActionAtPriority("__FC", function(Action, State, Input)
                                        local oldSpeed = FreeCamera.Speed
                                        if Input.KeyCode.Name == "W" or Input.KeyCode.Name == "Up" then
                                            Wheld = State.Name == "Begin" and true or false
                                        end
                                        if Input.KeyCode.Name == "S" or Input.KeyCode.Name == "Down" then
                                            Sheld = State.Name == "Begin" and true or false
                                        end
                                        if Input.KeyCode.Name == "A" or Input.KeyCode.Name == "Left" then
                                            Aheld = State.Name == "Begin" and true or false
                                        end
                                        if Input.KeyCode.Name == "D" or Input.KeyCode.Name == "Right" then
                                            Dheld = State.Name == "Begin" and true or false
                                        end
                                        if Input.KeyCode.Name == "E" or Input.KeyCode.Name == "Space" then
                                            Eheld = State.Name == "Begin" and true or false
                                        end
                                        if Input.KeyCode.Name == "Q" or Input.KeyCode.Name == "LeftControl" then
                                            Qheld = State.Name == "Begin" and true or false
                                        end
                                        return Enum.ContextActionResult.Sink
                                    end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D, Enum.KeyCode.E, Enum.KeyCode.Q, Enum.KeyCode.Up, Enum.KeyCode.Down, Enum.KeyCode.Right, Enum.KeyCode.Left, Enum.KeyCode.Space, Enum.KeyCode.LeftControl, Enum.KeyCode.LeftShift, Enum.KeyCode.LeftAlt)
                                end
                                function Input:Unblock()
                                    ContextActionService:UnbindAction("__FC")
                                    Wheld, Sheld, Aheld, Dheld, Eheld, Qheld = false, false, false, false, false, false
                                end
                                Input.__index = Input
                            end
                        
                            do
                                function FreeCamera:Start()
                                    local Character = LocalPlayer.Character
                                    if Character then
                                        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                                        if Humanoid then
                                            Humanoid.AutoRotate = false
                                        end
                                    end
                                    FreeCamera.CFrame = Camera.CFrame
                                    if Connection ~= nil then Connection:Disconnect() Connection = nil end
                                    Input:Block()
                                    Connection = Utility:Connection(RunService.RenderStepped, function()
                                        local Character = LocalPlayer.Character
                                        if Character then
                                            local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                                            if Humanoid then
                                                Humanoid.AutoRotate = false
                                                local Speed = FreeCamera.Speed
                                                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then
                                                    Speed = Speed * 3
                                                end
                                                if UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) or UserInputService:IsKeyDown(Enum.KeyCode.RightAlt) then
                                                    Speed = Speed / 3
                                                end
                                                local newCFrame = FreeCamera.CFrame * CFrame.new((Aheld and Dheld and 0) or (Aheld and -Speed) or (Dheld and Speed), (Eheld and Qheld and 0) or (Qheld and -Speed) or (Eheld and Speed), (Wheld and Sheld and 0) or (Wheld and -Speed) or (Sheld and Speed))
                                                FreeCamera.CFrame = CFrame.lookAt(newCFrame.p, newCFrame.p + Camera.CFrame.LookVector)
                                                Camera.CFrame = FreeCamera.CFrame
                                            end
                                        end
                                    end)
                                end
                                function FreeCamera:Stop()
                                    if Connection ~= nil then Connection:Disconnect() Connection = nil end
                                    Input:Unblock()
                                    Wheld, Sheld, Aheld, Dheld, Eheld, Qheld = false, false, false, false, false, false
                                    local Character = LocalPlayer.Character
                                    if Character then
                                        local Head, HumanoidRootPart, Humanoid = Character:FindFirstChild("Head"), Character:FindFirstChild("HumanoidRootPart"), Character:FindFirstChildOfClass("Humanoid")
                                        if Head and HumanoidRootPart and Humanoid then
                                            Camera.CFrame = CFrame.lookAt(Camera.CFrame.p, Camera.CFrame.p + HumanoidRootPart.CFrame.LookVector)
                                            Humanoid.AutoRotate = true
                                        end
                                    end
                                end
                                function FreeCamera:Unload()
                                    if Connection ~= nil then Connection:Disconnect() Connection = nil end
                                    Input:Unblock()
                                    local Character = LocalPlayer.Character
                                    if Character then
                                        local HumanoidRootPart, Humanoid = Character:FindFirstChildOfClass("HumanoidRootPart"), Character:FindFirstChildOfClass("Humanoid")
                                        if HumanoidRootPart and Humanoid then
                                            Camera.CFrame = CFrame.lookAt(Camera.CFrame.p, Camera.CFrame.p + HumanoidRootPart.CFrame.LookVector)
                                            Humanoid.AutoRotate = true
                                        end
                                    end
                                    Input, FreeCamera, Wheld, Sheld, Aheld, Dheld, Eheld, Qheld, Workspace, Camera, Players, LocalPlayer, RunService, UserInputService, HttpService, Lighting, NetworkClient, Mouse, ContextActionService = nil
                                end
                                FreeCamera.__index = FreeCamera
                            end
                        end)()
                        local FOV_Circle = Framework:Draw("Circle", {Radius = Camera.ViewportSize.X / 2, Position = Camera.ViewportSize / 2, Thickness = 1, Transparency = 1, Color = Color3.new(1, 1, 1)})
                        Flags = Library.flags
                        local Options = Library.options
                        if not Decayed_User then
                            getgenv().Decayed_User = {
                                UID = 0, 
                                User = "admin"
                            }
                        end
                        local Utility, Window, Tabs, Sections, Settings = Library.utility, nil, {}, {}, nil; do
                            -- Default Size - UDim2.new(0, 525, 0, 650)
                            Window = Library.NewWindow({title = ('Decayed | Universal | User: %s (UID %s)'):format(Decayed_User.User, tostring(Decayed_User.UID)), size = UDim2.new(0, 625, 0, 808)})
                            Tabs = {
                                Settings = Library:CreateSettingsTab(Window),
                                Combat = Window:AddTab("Combat"),
                                Visuals = Window:AddTab("Visuals"),
                                Miscellaneous = Window:AddTab("Miscellaneous"),
                                Players = Window:AddTab("Players")
                            }
                            Sections = {
                                Combat = {
                                    Aimbot = Tabs.Combat:AddSection("Aimbot", 1),
                                    ["Part Expander"] = Tabs.Combat:AddSection("Part Expander", 2),
                                    Silent = Tabs.Combat:AddSection("Silent", 2)
                                },
                                Visuals = {
                                    -- Players = Tabs.Visuals:AddSection("NIG", 1),
                                    Lighting = Tabs.Visuals:AddSection("Lighting", 2),
                                    Camera = Tabs.Visuals:AddSection("Camera", 1),
                                    Other = Tabs.Visuals:AddSection("Other", 2)
                                },
                                Miscellaneous = {
                                    LocalPlayer = Tabs.Miscellaneous:AddSection("LocalPlayer", 1),
                                    Network = Tabs.Miscellaneous:AddSection("Network", 2)
                                },
                                Players = {
                                    Players = Tabs.Players:AddSection("Players", 1),
                                },
                                Settings = {
                                    Other = Tabs.Settings:AddSection("Other", 2)
                                }
                            }
                        end
                        
                        -- Functions
                        local tracerDebounce = false
                        createTracer = LPH_JIT_ULTRA(function(To, From)
                            if not tracerDebounce then
                                tracerDebounce = true
                                spawn(function()
                                    task.wait()
                                    tracerDebounce = false
                                end)
                                local PartTo = Framework:Instance("Part", {Transparency = 1, Position = To, CanCollide = false, Anchored = true, Parent = Camera})
                                local PartFrom = Framework:Instance("Part", {Transparency = 1, Position = From, CanCollide = false, Anchored = true, Parent = Camera})
                                local Attachment0 = Instance.new("Attachment", PartTo)
                                local Attachment1 = Instance.new("Attachment", PartFrom)
                                local RaySize = Flags.silentVisualizeRaysSize
                                local Beam = Framework:Instance("Beam", {FaceCamera = true, Color = ColorSequence.new(Flags.silentVisualizeRaysColor), Width0 = RaySize, Width1 = RaySize, LightEmission = 1, LightInfluence = 0, Attachment0 = Attachment0, Attachment1 = Attachment1, Parent = PartTo})
                                task.spawn(function()
                                    task.wait(2)
                                    for i = 0.5, 0, -0.015 do
                                        Beam.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,1 - i), NumberSequenceKeypoint.new(1,1 - i)})
                                        RunService.Stepped:Wait()
                                    end
                                    PartTo:Destroy()
                                    PartFrom:Destroy()
                                end)
                            end
                        end)
                        
                        getTarget = LPH_JIT_ULTRA(function()
                            if LocalPlayer.Character == nil then return {Predicted = nil, Target = nil, Player = nil} end
                            local Player_, Target, Minimal_Mag = nil, nil, math.huge
                            for _, Player in pairs(Players:GetPlayers()) do
                                if Player == LocalPlayer then continue end
                                if Flags.teamCheck and ESP:Get_Team(LocalPlayer) == ESP:Get_Team(Player) then continue end
                                local Character = ESP:Get_Character(Player)
                                if Character == nil then continue end
                                local Head, HumanoidRootPart, Humanoid = Character:FindFirstChild("Head"), Character:FindFirstChild("HumanoidRootPart"), Character:FindFirstChildOfClass("Humanoid")
                                if not Head or not HumanoidRootPart or not Humanoid or Humanoid.Health <= 0 then continue end
                                local aimTo = Flags.aimbotAimTo == "Head" and "Head" or Flags.aimbotAimTo == "Torso" and "HumanoidRootPart" or Flags.aimbotAimTo == "Random" and (math.random(1, 2) == 1 and "Head" or "HumanoidRootPart")
                                local aimToPart = Character:FindFirstChild(aimTo)
                                if not aimToPart then continue end
                                if Flags.aimbotCheckFriend and LocalPlayer:IsFriendsWith(Player.UserId) then continue end
                                if Flags.aimbotCheckVisible and not ESP:Check_Visible(aimToPart, Flags.visibleCheckMode == "Head") then continue end
                                if Flags.aimbotCheckFF and Character:FindFirstChildOfClass("ForceField") then continue end
                                if Flags.aimbotCheckTransparent and Head.Transparency == 1 then continue end
                                if Flags.aimbotCheckNoclip then if (Humanoid.RigType == "R15" and Character.UpperTorso.CanCollide == false) or (Humanoid.RigType == "R6" and Character.Torso.CanCollide == false) then continue end end
                                if Flags.aimbotCheckMaterial and Head.Material == Enum.Material.ForceField then continue end
                                if Flags.aimbotCheckParent and Character.Parent ~= LocalPlayer.Character.Parent then continue end
                                local Vector, On_Screen = Camera:WorldToViewportPoint(aimToPart.Position)
                                if math.floor(Vector.Z / 3.5714285714 + 0.5) > Flags.aimbotDistance then continue end
                                if Flags.aimbotScanMode == "Field of View" then
                                    local Magnitude = (Vector2.new(Vector.X, Vector.Y) - Camera.ViewportSize / 2).Magnitude
                                    if On_Screen and Magnitude < Flags.aimbotFoV and Magnitude < Minimal_Mag then
                                        Minimal_Mag = Magnitude
                                        Target = aimToPart
                                        Player_ = Player
                                    end
                                else
                                    Target = aimToPart
                                    Player_ = Player
                                end
                            end
                            return {
                                Predicted = Target and Target.Position + Target.Velocity * ((Flags.aimbotPrediction and Flags.aimbotPredictionMultiplier) or 0) or nil,
                                Target = Target,
                                Player = Player_
                            }
                        end)
                        
                        MouseButton1Click = LPH_JIT_ULTRA(function(delay)
                            if not Library.open then
                                IsClicking = true
                                if Library.open == false and Library.opening == false then
                                    if delay ~= nil then
                                        mouse1press()
                                        task.wait(delay)
                                        mouse1release()
                                    else
                                        mouse1press()
                                        mouse1release()
                                    end
                                    IsClicking = false
                                end
                            end
                        end)
                        
                        -- Combat - Aimbot
                        Sections.Combat.Aimbot:AddToggle({text = "Enabled", tooltip = "Enables the aimbot.", flag = "aimbotEnabled", callback = function(State)
                            for _, option in pairs(Sections.Combat.Aimbot.options) do
                                if option.flag == "aimbotEnabled" then continue end
                                if option.flag == "aimbotAutoFireNoLags" then
                                    if Flags.aimbotAutoFire then
                                        if State then
                                            option.enabled = State
                                        else
                                            option.enabled = State
                                        end
                                    else
                                        if not State then
                                            option.enabled = State
                                        end
                                    end
                                    continue
                                end
                                if option.risky ~= nil then
                                    option.enabled = State
                                end
                            end
                            Sections.Combat.Aimbot:UpdateOptions()
                            Tabs.Combat:UpdateSections()
                        end}):AddBind({text = "Aimbot", flag = "aimbotEnabledBind", tooltip = "Enables the aimbot only when this key is held. Select BACKSPACE to make aimbot always aim.", mode = "hold"})
                        
                        Sections.Combat.Aimbot:AddToggle({text = "Silent", flag = "aimbotSilent", tooltip = "Makes it so the aimbot's snapping is invisible. Also changes bullet trajectory if proper Function selected (More accurate aiming).", risky = true, enabled = false, callback = function(State)
                            for _, option in pairs(Sections.Combat.Silent.options) do
                                if option.risky ~= nil then
                                    option.enabled = State
                                end
                            end
                            Sections.Combat.Silent:UpdateOptions()
                            Tabs.Combat:UpdateSections()
                        end})
                        
                        Sections.Combat.Aimbot:AddToggle({text = "Auto Fire", flag = "aimbotAutoFire", tooltip = "Automatically fires the weapon.", enabled = false, callback = function(State)
                            Options.aimbotAutoFireNoLags.enabled = State
                            Options.aimbotAutoFire:UpdateOptions()
                            Tabs.Combat:UpdateSections()
                        end})
                        
                        Sections.Combat.Aimbot:AddToggle({text = "Auto Fire Disable Fake Lag", flag = "aimbotAutoFireNoLags", tooltip = "Disables fake lags on auto firing.", enabled = false})
                        
                        Sections.Combat.Aimbot:AddSlider({text = "Aim Speed", flag = "aimbotSpeed", enabled = false, min = 0.001, max = 1, value = 1, increment = 0.001})
                        
                        Sections.Combat.Aimbot:AddList({text = "Part", flag = "aimbotAimTo", tooltip = "Makes the aimbot target a specific body part.", enabled = false, selected = "Head", values = {"Head", "Torso", "Random"}})
                        
                        Sections.Combat.Aimbot:AddSlider({text = "Field of View", flag = "aimbotFoV", tooltip = "Makes the aimbot only target players who are withing the selected field of view.", enabled = false, min = 0, max = Camera.ViewportSize.X / 2 + 200, value = Camera.ViewportSize.X / 2, callback = function(Value)
                            FOV_Circle.Radius = Value
                        end})
                        
                        Sections.Combat.Aimbot:AddSlider({text = "Distance", flag = "aimbotDistance", tooltip = "Makes the aimbot only target players who are withing the selected distance.", enabled = false, min = 0, max = 5000, value = 1000, suffix = "m"})
                        
                        Sections.Combat.Aimbot:AddToggle({text = "Target Lock", tooltip = "Makes the aimbot aim at one target unless dead.", flag = "aimbotLockTarget", enabled = false})
                        
                        Sections.Combat.Aimbot:AddList({text = "Target Mode", flag = "aimbotScanMode", tooltip = "Changes how aimbot will find a new target. Cycle checks all players, ignores field of view.", enabled = false, selected = "Field of View", values = {"Cycle", "Field of View"}})
                        
                        Sections.Combat.Aimbot:AddList({text = "Aim Mode", flag = "aimbotAimMode", tooltip = "Changes how aimbot will aim (Choose Mouse if Camera doesn't work).", enabled = false, selected = "Camera", values = {"Camera", "Mouse"}})
                        
                        Sections.Combat.Aimbot:AddToggle({text = "Prediction", flag = "aimbotPrediction", tooltip = "Makes the aimbot velocity predict the current target.", enabled = false, callback = function(State)
                            Options.aimbotPredictionMultiplier.enabled = State
                            Options.aimbotPrediction:UpdateOptions()
                            Tabs.Combat:UpdateSections()
                        end}):AddSlider({flag = "aimbotPredictionMultiplier", tooltip = "Changes velocity prediction strength.", min = 0, max = 0.4, increment = 0.001, value = 0.4, enabled = false})
                        
                        Sections.Combat.Aimbot:AddToggle({text = "Friend Check", flag = "aimbotCheckFriend", tooltip = "Makes the aimbot don't target roblox friends.", enabled = false})
                        
                        Sections.Combat.Aimbot:AddToggle({text = "Visible Check", flag = "aimbotCheckVisible", tooltip = "Makes the aimbot don't target invisible players.", enabled = false})
                        
                        Sections.Combat.Aimbot:AddToggle({text = "ForceField Check", flag = "aimbotCheckFF", tooltip = "Makes the aimbot don't target players with forcefield.", enabled = false})
                        
                        Sections.Combat.Aimbot:AddToggle({text = "Transparent Check", flag = "aimbotCheckTransparent", tooltip = "Makes the aimbot don't target transparent players (Most likely admins or invisible).", enabled = false})
                        
                        Sections.Combat.Aimbot:AddToggle({text = "Noclip Check", flag = "aimbotCheckNoclip", tooltip = "Makes the aimbot don't target noclipping players (Most likely admins or spawn protected or dead).", enabled = false})
                        
                        Sections.Combat.Aimbot:AddToggle({text = "Material Check", flag = "aimbotCheckMaterial", tooltip = "Makes the aimbot don't target forcefield material players (Most likely spawn protected).", enabled = false})
                        
                        Sections.Combat.Aimbot:AddToggle({text = "Parent Check", flag = "aimbotCheckParent", tooltip = "Makes the aimbot don't target players that's character parent is not same as localplayer character parent (Most likely dead in some games).", enabled = false})
                        
                        Utility:Connection(Camera:GetPropertyChangedSignal("ViewportSize"), LPH_JIT_ULTRA(function()
                            Options.aimbotFoV.max = Camera.ViewportSize.X / 2 + 200
                            FOV_Circle.Position = Camera.ViewportSize / 2
                        end))
                        
                        Utility:Connection(RunService.RenderStepped, LPH_JIT_ULTRA(function()
                            if not Flags.aimbotEnabled or not Flags.aimbotEnabledBind then
                                ESP.Settings.Highlight.Target = nil
                                return 
                            end
                            if Flags.aimbotLockTarget then
                                if Aimbot.Target ~= nil then
                                    if not Flags.aimbotEnabledBind then
                                        Aimbot = getTarget()
                                    end
                                end
                            else
                                Aimbot = getTarget()
                            end
                            ESP.Settings.Highlight.Target = (Aimbot.Player ~= nil and ESP:Get_Character(Aimbot.Player)) or nil
                            if Flags.aimbotSilent then
                                if not Flags.aimbotEnabledBind then return end
                                if Flags.aimbotAutoFire and Aimbot.Target then
                                    if Flags.aimbotAutoFireNoLags then
                                        NetworkClient:SetOutgoingKBPSLimit(math.huge)
                                    end
                                    IsClicking = true
                                    MouseButton1Click(Flags.betweenClickTime)
                                    IsClicking = false
                                end
                                return
                            end
                            if Aimbot.Target then
                                if Flags.aimbotAimMode == "Camera" then
                                    Camera.CFrame = Flags.aimbotSpeed < 1 and Camera.CFrame:lerp(CFrame.lookAt(Camera.CFrame.p, Aimbot.Predicted), Flags.aimbotSpeed) or CFrame.lookAt(Camera.CFrame.p, Aimbot.Predicted)
                                    if Flags.aimbotAutoFire then
                                        local Vector, On_Screen = Camera:WorldToViewportPoint(Aimbot.Predicted)
                                        local MouseLocation = UserInputService:GetMouseLocation()
                                        local Magnitude = (Vector2.new(Vector.X, Vector.Y) - MouseLocation).Magnitude
                                        if On_Screen and Magnitude <= 2 then
                                            if Flags.aimbotAutoFireNoLags then
                                                NetworkClient:SetOutgoingKBPSLimit(math.huge)
                                            end
                                            IsClicking = true
                                            MouseButton1Click(Flags.betweenClickTime)
                                            IsClicking = false
                                        end
                                    end
                                else
                                    local Vector, On_Screen = Camera:WorldToViewportPoint(Aimbot.Predicted)
                                    local MouseLocation = UserInputService:GetMouseLocation()
                                    mousemoverel((Vector.X - MouseLocation.X) * Flags.aimbotSpeed, (Vector.Y - MouseLocation.Y) * Flags.aimbotSpeed)
                                    if Flags.aimbotAutoFire then
                                        local Magnitude = (Vector2.new(Vector.X, Vector.Y) - MouseLocation).Magnitude
                                        if On_Screen and Magnitude <= 2 then
                                            if Flags.aimbotAutoFireNoLags then
                                                NetworkClient:SetOutgoingKBPSLimit(math.huge)
                                            end
                                            IsClicking = true
                                            MouseButton1Click(Flags.betweenClickTime)
                                            IsClicking = false
                                        end
                                    end
                                end
                            end
                        end))
                        
                        -- Combat - Silent
                        Sections.Combat.Silent:AddList({text = "Functions", flag = "silentFunctions", tooltip = "Choose roblox functions to spoof.", enabled = false, multi = true, values = {"raycast", "findpartonraywithignorelist", "findpartonraywithwhitelist", "findpartonray", "screenpointtoray", "viewportpointtoray"}})
                        
                        Sections.Combat.Silent:AddList({text = "Properties", flag = "silentProperties", tooltip = "Choose roblox properties to spoof.", enabled = false, multi = true, values = {"ray", "unitray", "hit", "targetpoint", "target"}})
                        
                        Sections.Combat.Silent:AddList({text = "Includes", flag = "silentIncludes", tooltip = "Choose what should be ignored in raycast call.", enabled = false, multi = true, values = {"Character", "Camera"}})
                        
                        Sections.Combat.Silent:AddList({text = "Exploits", flag = "silentExploits", enabled = false, multi = true, values = {"Teleport Bullet"}})
                        
                        Sections.Combat.Silent:AddList({text = "Origin", flag = "silentOrigin", tooltip = "Choose from where ray will be casted.", enabled = false, selected = "Called", values = {"Called", "Camera", "Head", "First Person"}})
                        
                        Sections.Combat.Silent:AddSlider({text = "Minimum Ignored", flag = "silentMinIgnored", tooltip = "Choose how much parts should be ignored in raycast call.", enabled = false, min = 0, max = 500})
                        
                        Sections.Combat.Silent:AddSlider({text = "Miss Chance", flag = "silentMissChance", enabled = false, min = 0, max = 100, suffix = "%"})
                        
                        Sections.Combat.Silent:AddBox({text = "Script Lock", flag = "silentScript", enabled = false})
                        
                        Sections.Combat.Silent:AddToggle({text = "Print Calling Script", flag = "silentPrintScript", tooltip = "Prints calling script name in console (F9). Leave script lock blank if don't know.", enabled = false, callback = LPH_JIT_ULTRA(function(State)
                            if State then
                                task.spawn(function()
                                    task.wait(0.2)
                                    repeat
                                        warn("CALLING SCRIPTS:")
                                        for Script, Methods in pairs(Methods_Debug) do
                                            print("  SCRIPT:", Script)
                                            for Method, Count in pairs(Methods) do
                                                print("    METHOD:", Method, "| COUNT:", Count)
                                            end
                                        end
                                        task.wait(0.5)
                                    until not Running or not Flags.silentPrintScript
                                end)
                            end
                        end)})
                        
                        Sections.Combat.Silent:AddToggle({text = "Visualize Rays", flag = "silentVisualizeRays", tooltip = "Visualizes casted rays. May work as bullet tracers.", enabled = false, callback = function(State)
                            Options.silentVisualizeRaysColor.enabled = State
                            Options.silentVisualizeRaysSize.enabled = State
                            Options.silentVisualizeRays:UpdateOptions()
                            Tabs.Combat:UpdateSections()
                        end}):AddColor({text = "Visualized Ray Color", flag = "silentVisualizeRaysColor", enabled = false})
                        Options.silentVisualizeRays:AddSlider({flag = "silentVisualizeRaysSize", tooltip = "Visualized ray thickness.", enabled = false, min = 0.001, max = 0.4, increment = 0.001, value = 0.03})
                        
                        -- -- Combat - Part Expander
                        -- local Old_HumanoidRootPart_Size
                        -- for _, Player in pairs(Players:GetPlayers()) do
                        --     local Character = ESP:Get_Character(Player)
                        --     if Character then
                        --         local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                        --         if HumanoidRootPart then
                        --             Old_HumanoidRootPart_Size = HumanoidRootPart.Size
                        --             break
                        --         end
                        --     end
                        -- end
                        -- Sections.Combat["Part Expander"]:AddToggle({text = "Enabled", flag = "partEnabled", tooltip = "Expands enemies torsos. If game's anti exploit is bad then server will register damage in the expanded part.", risky = true, callback = LPH_JIT_ULTRA(function(State)
                        --     if State then
                        --         task.spawn(function()
                        --             task.wait()
                        --             repeat
                        --                 for _, Player in pairs(Players:GetPlayers()) do
                        --                     if Player == LocalPlayer then continue end
                        --                     local Character = ESP:Get_Character(Player)
                        --                     if Character == nil then continue end
                        --                     local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                        --                     if not HumanoidRootPart then continue end
                        --                     if Flags.partEnabledBind and ((Flags.teamCheck == true and ESP:Get_Team(Player) ~= ESP:Get_Team(LocalPlayer)) or Flags.teamCheck == false) then
                        --                         HumanoidRootPart.Size = Vector3.new(Flags.partX, Flags.partY, Flags.partZ)
                        --                         HumanoidRootPart.Color = Flags.partColor
                        --                         HumanoidRootPart.Transparency = Options.partColor.trans
                        --                         if HumanoidRootPart.Material ~= Enum.Material.Plastic then continue end
                        --                         HumanoidRootPart.Material = Enum.Material.ForceField
                        --                     else
                        --                         if HumanoidRootPart.Material == Enum.Material.Plastic then continue end
                        --                         HumanoidRootPart.Material = Enum.Material.Plastic
                        --                         HumanoidRootPart.Size = Old_HumanoidRootPart_Size
                        --                         HumanoidRootPart.Transparency = 1
                        --                     end
                        --                 end
                        --                 task.wait(.1)
                        --             until not Running or not Flags.partEnabled
                        --         end)
                        --     else
                        --         task.spawn(function()
                        --             task.wait()
                        --             for _, Player in pairs(Players:GetPlayers()) do
                        --                 if Player == LocalPlayer then continue end
                        --                 local Character = ESP:Get_Character(Player)
                        --                 if Character == nil then continue end
                        --                 local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                        --                 if not HumanoidRootPart then continue end
                        --                 if HumanoidRootPart.Material == Enum.Material.Plastic then continue end
                        --                 HumanoidRootPart.Material = Enum.Material.Plastic
                        --                 HumanoidRootPart.Size = Old_HumanoidRootPart_Size
                        --                 HumanoidRootPart.Transparency = 1
                        --             end
                        --         end)
                        --     end
                        --     for _, option in pairs(Sections.Combat["Part Expander"].options) do
                        --         if option.flag == "partEnabled" then continue end
                        --         if option.risky ~= nil then
                        --             option.enabled = State
                        --         end
                        --     end
                        --     Options.partColor.enabled = State
                        --     Options.partEnabled:UpdateOptions()
                        --     Sections.Combat["Part Expander"]:UpdateOptions()
                        --     Tabs.Combat:UpdateSections()
                        -- end)}):AddColor({text = "Expanded Part Color", flag = "partColor", tooltip = "Color of extended part.", enabled = false})
                        
                        -- Options.partEnabled:AddBind({text = "Part Expander", flag = "partEnabledBind", tooltip = "Toggles the part expander when this key was pressed. Select BACKSPACE to make part expander always active."})
                        
                        -- Sections.Combat["Part Expander"]:AddSlider({text = "Part Size X", flag = "partX", tooltip = "Expanded part size coordinate X.", enabled = false, min = 0, max = 200, value = 10})
                        
                        -- Sections.Combat["Part Expander"]:AddSlider({text = "Part Size Y", flag = "partY", tooltip = "Expanded part size coordinate Y.", enabled = false, min = 0, max = 200, value = 10})
                        
                        -- Sections.Combat["Part Expander"]:AddSlider({text = "Part Size Z", flag = "partZ", tooltip = "Expanded part size coordinate Z.", enabled = false, min = 0, max = 200, value = 10})
                        
                        -- Visuals - Players
                        Sections.Visuals.Players:AddToggle({text = "Enabled", flag = "plrEspEnabled", tooltip = "Enables the player ESP.", callback = function(State)
                            for _, option in pairs(Sections.Visuals.Players.options) do
                                if option.flag == "plrEspEnabled" then continue end
                                if option.flag == "plrEspBoxOutline" then
                                    if Flags.plrEspBox then
                                        if State then
                                            option.enabled = State
                                        else
                                            option.enabled = State
                                        end
                                    else
                                        if not State then
                                            option.enabled = State
                                        end
                                    end
                                    continue
                                end
                                if option.risky ~= nil then
                                    option.enabled = State
                                end
                            end
                            Sections.Visuals.Players:UpdateOptions()
                            Tabs.Visuals:UpdateSections()
                            ESP:Toggle(State)
                        end})
                        
                        Sections.Visuals.Players:AddToggle({text = "Highlight Target", flag = "plrEspHighlight", tooltip = "Highlights current aimbot target.", enabled = false, callback = function(State)
                            ESP.Settings.Highlight.Enabled = State
                            Options.plrEspHighlightColor.enabled = State
                            Options.plrEspHighlight:UpdateOptions()
                            Tabs.Visuals:UpdateSections()
                        end}):AddColor({text = "Highlight Color", flag = "plrEspHighlightColor", enabled = false, color = Color3.new(1, 0, 0), callback = function(Color)
                            ESP.Settings.Highlight.Color = Color
                        end})
                        
                        Sections.Visuals.Players:AddToggle({text = "Box", flag = "plrEspBox", tooltip = "Draw a bounding box around the player.", enabled = false, callback = function(State)
                            ESP.Settings.Box.Enabled = State
                            Options.plrEspBoxOutline.enabled = State
                            Options.plrEspBoxColor.enabled = State
                            Options.plrEspBox:UpdateOptions()
                            Sections.Visuals.Players:UpdateOptions()
                            Tabs.Visuals:UpdateSections()
                        end}):AddColor({text = "Box Color", flag = "plrEspBoxColor", enabled = false, callback = function(Color, Transparency)
                            ESP.Settings.Box.Color = Color
                            ESP.Settings.Box.Transparency = Transparency
                        end})
                        
                        Sections.Visuals.Players:AddToggle({text = "Box Outline", flag = "plrEspBoxOutline", tooltip = "Draw outline around box.", enabled = false, callback = function(State)
                            ESP.Settings.Box_Outline.Enabled = State
                            Options.plrEspBoxOutlineColor.enabled = State
                            Options.plrEspBoxOutline:UpdateOptions()
                            Tabs.Visuals:UpdateSections()
                        end}):AddColor({text = "Box Outline Color", flag = "plrEspBoxOutlineColor", enabled = false, color = Color3.new(0, 0, 0), callback = function(Color, Transparency)
                            ESP.Settings.Box_Outline.Color = Color
                            ESP.Settings.Box_Outline.Transparency = Transparency
                        end})
                        
                        Sections.Visuals.Players:AddToggle({text = "Healthbar", flag = "plrEspHpBar", tooltip = "Show player's health amount with a bar on ESP.", enabled = false, callback = function(State)
                            ESP.Settings.Healthbar.Enabled = State
                            Options.plrEspHpBarColor.enabled = State
                            Options.plrEspHpBarPos.enabled = State
                            Options.plrEspHpBar:UpdateOptions()
                            Tabs.Visuals:UpdateSections()
                        end}):AddColor({text = "Healthbar Color", flag = "plrEspHpBarColor", enabled = false, color = Color3.fromRGB(40, 252, 3), callback = function(Color)
                            ESP.Settings.Healthbar.Color_Lerp = Color
                        end})
                        Options.plrEspHpBar:AddList({flag = "plrEspHpBarPos", tooltip = "Position of healthbar towards to the box.", enabled = false, selected = "Left", values = {"Top", "Bottom", "Left", "Right"}, callback = function(Position)
                            ESP.Settings.Healthbar.Position = Position
                        end})
                        
                        Sections.Visuals.Players:AddToggle({text = "Name", flag = "plrEspName", tooltip = "Show player's name on ESP.", enabled = false, callback = function(State)
                            ESP.Settings.Name.Enabled = State
                            Options.plrEspNameColor.enabled = State
                            Options.plrEspNamePos.enabled = State
                            Options.plrEspName:UpdateOptions()
                            Tabs.Visuals:UpdateSections()
                        end}):AddColor({text = "Name Color", flag = "plrEspNameColor", enabled = false, callback = function(Color, Transparency)
                            ESP.Settings.Name.Color = Color
                            ESP.Settings.Name.Transparency = Transparency
                        end})
                        Options.plrEspName:AddList({flag = "plrEspNamePos", tooltip = "Position of name drawing towards to the box.", enabled = false, selected = "Top", values = {"Top", "Bottom", "Left", "Right"}, callback = function(Position)
                            ESP.Settings.Name.Position = Position
                        end})
                        
                        Sections.Visuals.Players:AddToggle({text = "Distance", flag = "plrEspDist", tooltip = "Show player's distance from you on ESP.", enabled = false, callback = function(State)
                            ESP.Settings.Distance.Enabled = State
                            Options.plrEspDistColor.enabled = State
                            Options.plrEspDistPos.enabled = State
                            Options.plrEspDist:UpdateOptions()
                            Tabs.Visuals:UpdateSections()
                        end}):AddColor({text = "Distance Color", flag = "plrEspDistColor", enabled = false, callback = function(Color, Transparency)
                            ESP.Settings.Distance.Color = Color
                            ESP.Settings.Distance.Transparency = Transparency
                        end})
                        Options.plrEspDist:AddList({flag = "plrEspDistPos", tooltip = "Position of distance drawing towards to the box.", enabled = false, selected = "Bottom", values = {"Top", "Bottom", "Left", "Right"}, callback = function(Position)
                            ESP.Settings.Distance.Position = Position
                        end})
                        
                        Sections.Visuals.Players:AddToggle({text = "Tool", flag = "plrEspTool", tooltip = "Show player's held tool on ESP.", enabled = false, callback = function(State)
                            ESP.Settings.Tool.Enabled = State
                            Options.plrEspToolColor.enabled = State
                            Options.plrEspToolPos.enabled = State
                            Options.plrEspTool:UpdateOptions()
                            Tabs.Visuals:UpdateSections()
                        end}):AddColor({text = "Tool Color", flag = "plrEspToolColor", enabled = false, callback = function(Color, Transparency)
                            ESP.Settings.Tool.Color = Color
                            ESP.Settings.Tool.Transparency = Transparency
                        end})
                        Options.plrEspTool:AddList({flag = "plrEspToolPos", tooltip = "Position of tool drawing towards to the box", enabled = false, selected = "Right", values = {"Top", "Bottom", "Left", "Right"}, callback = function(Position)
                            ESP.Settings.Tool.Position = Position
                        end})
                        
                        Sections.Visuals.Players:AddToggle({text = "Health", flag = "plrEspHp", tooltip = "Show player's health amount with text on ESP.", enabled = false, callback = function(State)
                            ESP.Settings.Health.Enabled = State
                            Options.plrEspHpColor.enabled = State
                            Options.plrEspHpPos.enabled = State
                            Options.plrEspHp:UpdateOptions()
                            Tabs.Visuals:UpdateSections()
                        end}):AddColor({text = "Health Color", flag = "plrEspHpColor", enabled = false, callback = function(Color, Transparency)
                            ESP.Settings.Health.Color = Color
                            ESP.Settings.Health.Transparency = Transparency
                        end})
                        Options.plrEspHp:AddList({flag = "plrEspHpPos", tooltip = "Position of health drawing towards to the box.", enabled = false, selected = "Right", values = {"Top", "Bottom", "Left", "Right"}, callback = function(Position)
                            ESP.Settings.Health.Position = Position
                        end})
                        
                        Sections.Visuals.Players:AddToggle({text = "Chams", flag = "plrEspChams", tooltip = "Applies Chams material to the player.", enabled = false, callback = function(State)
                            ESP.Settings.Chams.Enabled = State
                            Options.plrEspChamsOutCol.enabled = State
                            Options.plrEspChamsColor.enabled = State
                            Options.plrEspChamsMode.enabled = State
                            Options.plrEspChams:UpdateOptions()
                            Tabs.Visuals:UpdateSections()
                        end}):AddColor({text = "Chams Color", flag = "plrEspChamsColor", tooltip = "Color of Chams", enabled = false, trans = 0.5, callback = function(Color, Transparency)
                            ESP.Settings.Chams.Color = Color
                            ESP.Settings.Chams.Transparency = Transparency
                        end})
                        Options.plrEspChams:AddColor({text = "Chams Outline Color", flag = "plrEspChamsOutCol", tooltip = "Color of Chams outline", enabled = false, color = Color3.new(0, 0, 0), callback = function(Color, Transparency)
                            ESP.Settings.Chams.OutlineColor = Color
                            ESP.Settings.Chams.OutlineTransparency = Transparency
                        end})
                        Options.plrEspChams:AddList({flag = "plrEspChamsMode", tooltip = "Chams color mode", enabled = false, selected = "Visible", values = {"Standard", "Visible"}, callback = function(Mode)
                            ESP.Settings.Chams.Mode = Mode
                        end})
                        
                        Sections.Visuals.Players:AddList({text = "Image", flag = "plrEspImage", enabled = false, selected = "None", values = {"None", "Taxi", "Gorilla", "Saul Goodman", "Peter Griffin", "John Herbert", "Fortnite"}, callback = function(Value)
                            if Value == "None" then
                                ESP.Settings.Image.Enabled = false
                            else
                                ESP.Settings.Image.Enabled = true
                                ESP.Settings.Image.Image = Value
                                ESP:UpdateImages()
                            end
                        end})
                        
                        Sections.Visuals.Players:AddSlider({text = "Draw Distance", flag = "plrEspDrawDistance", enabled = false, suffix = "m", min = 1, max = 5000, value = 1000, callback = function(Value)
                            ESP.Settings.Maximal_Distance = Value
                        end})
                        
                        -- Sections.Visuals.Players:AddToggle({text = "Bold Text", flag = "plrEspBold", enabled = false, callback = function(State)
                        --     ESP.Settings.Bold_Text = State
                        -- end})
                        
                        LPH_JIT_ULTRA(function()
                            for _, Player in pairs(Players:GetPlayers()) do
                                if Player == LocalPlayer then continue end
                                ESP:Player(Player)
                            end
                        end)()
                        
                        -- Visuals - Lighting
                        local Sky = Lighting:FindFirstChildOfClass("Sky")
                        if not Sky then
                            Sky = Framework:Instance("Sky", {Parent = Lighting})
                        end
                        local SkyBoxes = {
                            ["Standard"] = {
                                ["SkyboxBk"] = Sky.SkyboxBk,
                                ["SkyboxDn"] = Sky.SkyboxDn,
                                ["SkyboxFt"] = Sky.SkyboxFt,
                                ["SkyboxLf"] = Sky.SkyboxLf,
                                ["SkyboxRt"] = Sky.SkyboxRt,
                                ["SkyboxUp"] = Sky.SkyboxUp,
                            },
                            ["Among Us"] = {
                                ["SkyboxBk"] = "rbxassetid://5752463190",
                                ["SkyboxDn"] = "rbxassetid://5752463190",
                                ["SkyboxFt"] = "rbxassetid://5752463190",
                                ["SkyboxLf"] = "rbxassetid://5752463190",
                                ["SkyboxRt"] = "rbxassetid://5752463190",
                                ["SkyboxUp"] = "rbxassetid://5752463190"
                            },
                            ["Neptune"] = {
                                ["SkyboxBk"] = "rbxassetid://218955819",
                                ["SkyboxDn"] = "rbxassetid://218953419",
                                ["SkyboxFt"] = "rbxassetid://218954524",
                                ["SkyboxLf"] = "rbxassetid://218958493",
                                ["SkyboxRt"] = "rbxassetid://218957134",
                                ["SkyboxUp"] = "rbxassetid://218950090"
                            },
                            ["Aesthetic Night"] = {
                                ["SkyboxBk"] = "rbxassetid://1045964490",
                                ["SkyboxDn"] = "rbxassetid://1045964368",
                                ["SkyboxFt"] = "rbxassetid://1045964655",
                                ["SkyboxLf"] = "rbxassetid://1045964655",
                                ["SkyboxRt"] = "rbxassetid://1045964655",
                                ["SkyboxUp"] = "rbxassetid://1045962969"
                            },
                            ["Redshift"] = {
                                ["SkyboxBk"] = "rbxassetid://401664839",
                                ["SkyboxDn"] = "rbxassetid://401664862",
                                ["SkyboxFt"] = "rbxassetid://401664960",
                                ["SkyboxLf"] = "rbxassetid://401664881",
                                ["SkyboxRt"] = "rbxassetid://401664901",
                                ["SkyboxUp"] = "rbxassetid://401664936"
                            },
                        }
                        Sections.Visuals.Lighting:AddToggle({text = "Enabled", flag = "lightingEnabled", tooltip = "Enables lighting modifications.", callback = function(State)
                            if State then
                                if Flags.lightingAmbient then
                                    Lighting.Ambient = Flags.lightingAmbientAmnt
                                end
                                if Flags.lightingBrightness then
                                    Lighting.Brightness = Flags.lightingBrightnessAmnt
                                end
                                if Flags.lightingColorShift_Bottom then
                                    Lighting.ColorShift_Bottom = Flags.lightingColorShift_BottomAmnt
                                end
                                if Flags.lightingColorShift_Top then
                                    Lighting.ColorShift_Top = Flags.lightingColorShift_TopAmnt
                                end
                                if Flags.lightingEnvironmentDiffuseScale then
                                    Lighting.EnvironmentDiffuseScale = Flags.lightingEnvironmentDiffuseScaleAmnt
                                end
                                if Flags.lightingEnvironmentSpecularScale then
                                    Lighting.EnvironmentSpecularScale = Flags.lightingEnvironmentSpecularScaleAmnt
                                end
                                if Flags.lightingGlobalShadows then
                                    Lighting.GlobalShadows = Flags.lightingGlobalShadows
                                end
                                if Flags.lightingOutdoorAmbient then
                                    Lighting.OutdoorAmbient = Flags.lightingOutdoorAmbientAmnt
                                end
                                if Flags.lightingTechnology then
                                    sethiddenproperty(Lighting, "Technology", Flags.lightingTechnologyAmnt)
                                end
                                if Flags.lightingDecoration then
                                    sethiddenproperty(Terrain, "Decoration", not Flags.lightingDecoration)
                                end
                                if Flags.lightingClockTime then
                                    Lighting.ClockTime = Flags.lightingClockTimeAmnt
                                end
                                if Flags.lightingExposureCompensation then
                                    Lighting.ExposureCompensation = Flags.lightingExposureCompensationAmnt
                                end
                                for Index, Asset in pairs(SkyBoxes[Flags.lightingSky]) do
                                    Sky[Index] = Asset
                                end
                            else
                                for Property, Value in pairs(Old_Lighting) do
                                    pcall(function()
                                        Lighting[Property] = Value
                                        if Property == "Technology" then
                                            sethiddenproperty(Lighting, "Technology", Old_Lighting.Technology)
                                        end
                                    end)
                                end
                                for Index, Asset in pairs(SkyBoxes.Standard) do
                                    Sky[Index] = Asset
                                end
                                sethiddenproperty(Terrain, "Decoration", Old_Decoration)
                            end
                            for _, option in pairs(Sections.Visuals.Lighting.options) do
                                if option.flag == "lightingEnabled" then continue end
                                if option.risky ~= nil then
                                    option.enabled = State
                                end
                            end
                            Sections.Visuals.Lighting:UpdateOptions()
                            Tabs.Visuals:UpdateSections()
                        end})
                        
                        Sections.Visuals.Lighting:AddToggle({text = "Ambient", flag = "lightingAmbient", enabled = false, callback = function(State)
                            if State and Flags.lightingEnabled then
                                Lighting.Ambient = Flags.lightingAmbientAmnt
                            else
                                Lighting.Ambient = Old_Lighting.Ambient
                            end
                            Options.lightingAmbientAmnt.enabled = State
                            Options.lightingAmbient:UpdateOptions()
                            Tabs.Visuals:UpdateSections()
                        end}):AddColor({text = "Ambient Color", flag = "lightingAmbientAmnt", enabled = false, color = Old_Lighting.Ambient, callback = function(Color)
                            if Flags.lightingEnabled and Flags.lightingAmbient then
                                Lighting.Ambient = Color
                            end
                        end})
                        Utility:Connection(Lighting:GetPropertyChangedSignal("Ambient"), LPH_JIT_ULTRA(function()
                            if Flags.lightingEnabled and Flags.lightingAmbient then
                                Lighting.Ambient = Flags.lightingAmbientAmnt
                            end
                        end))
                        
                        Sections.Visuals.Lighting:AddToggle({text = "Brightness", flag = "lightingBrightness", enabled = false, callback = function(State)
                            if State and Flags.lightingEnabled then
                                Lighting.Brightness = Flags.lightingBrightnessAmnt
                            else
                                Lighting.Brightness = Old_Lighting.Brightness
                            end
                            Options.lightingBrightnessAmnt.enabled = State
                            Options.lightingBrightness:UpdateOptions()
                            Tabs.Visuals:UpdateSections()
                        end}):AddSlider({flag = "lightingBrightnessAmnt", enabled = false, min = 0, max = 10, increment = 0.01, value = Old_Lighting.Brightness, callback = function(Value)
                            if Flags.lightingEnabled and Flags.lightingBrightness then
                                Lighting.Brightness = Value
                            end
                        end})
                        Utility:Connection(Lighting:GetPropertyChangedSignal("Brightness"), LPH_JIT_ULTRA(function()
                            if Flags.lightingEnabled and Flags.lightingBrightness then
                                Lighting.Brightness = Flags.lightingBrightnessAmnt
                            end
                        end))
                        
                        Sections.Visuals.Lighting:AddToggle({text = "ColorShift Bottom", flag = "lightingColorShift_Bottom", enabled = false, callback = function(State)
                            if State and Flags.lightingEnabled then
                                Lighting.ColorShift_Bottom = Flags.lightingColorShift_BottomAmnt
                            else
                                Lighting.ColorShift_Bottom = Old_Lighting.ColorShift_Bottom
                            end
                            Options.lightingColorShift_BottomAmnt.enabled = State
                            Options.lightingColorShift_Bottom:UpdateOptions()
                            Tabs.Visuals:UpdateSections()
                        end}):AddColor({text = "ColorShift Bottom Color", flag = "lightingColorShift_BottomAmnt", enabled = false, color = Old_Lighting.ColorShift_Bottom, callback = function(Color)
                            if Flags.lightingEnabled and Flags.lightingColorShift_Bottom then
                                Lighting.ColorShift_Bottom = Color
                            end
                        end})
                        Utility:Connection(Lighting:GetPropertyChangedSignal("ColorShift_Bottom"), LPH_JIT_ULTRA(function()
                            if Flags.lightingEnabled and Flags.lightingColorShift_Bottom then
                                Lighting.ColorShift_Bottom = Flags.lightingColorShift_BottomAmnt
                            end
                        end))
                        
                        Sections.Visuals.Lighting:AddToggle({text = "ColorShift Top", flag = "lightingColorShift_Top", enabled = false, callback = function(State)
                            if State and Flags.lightingEnabled then
                                Lighting.ColorShift_Top = Flags.lightingColorShift_TopAmnt
                            else
                                Lighting.ColorShift_Top = Old_Lighting.ColorShift_Top
                            end
                            Options.lightingColorShift_TopAmnt.enabled = State
                            Options.lightingColorShift_Top:UpdateOptions()
                            Tabs.Visuals:UpdateSections()
                        end}):AddColor({text = "ColorShift Top Color", flag = "lightingColorShift_TopAmnt", enabled = false, color = Old_Lighting.ColorShift_Top, callback = function(Color)
                            if Flags.lightingEnabled and Flags.lightingColorShift_Top then
                                Lighting.ColorShift_Top = Color
                            end
                        end})
                        Utility:Connection(Lighting:GetPropertyChangedSignal("ColorShift_Top"), LPH_JIT_ULTRA(function()
                            if Flags.lightingEnabled and Flags.lightingColorShift_Top then
                                Lighting.ColorShift_Top = Flags.lightingColorShift_TopAmnt
                            end
                        end))
                        
                        Sections.Visuals.Lighting:AddToggle({text = "Diffuse Scale", flag = "lightingEnvironmentDiffuseScale", enabled = false, callback = function(State)
                            if State and Flags.lightingEnabled then
                                Lighting.EnvironmentDiffuseScale = Flags.lightingEnvironmentDiffuseScaleAmnt
                            else
                                Lighting.EnvironmentDiffuseScale = Old_Lighting.EnvironmentDiffuseScale
                            end
                            Options.lightingEnvironmentDiffuseScaleAmnt.enabled = State
                            Options.lightingEnvironmentDiffuseScale:UpdateOptions()
                            Tabs.Visuals:UpdateSections()
                        end}):AddSlider({flag = "lightingEnvironmentDiffuseScaleAmnt", enabled = false, min = 0, max = 1, increment = 0.001, value = Old_Lighting.EnvironmentDiffuseScale, callback = function(Value)
                            if Flags.lightingEnabled and Flags.lightingEnvironmentDiffuseScale then
                                Lighting.EnvironmentDiffuseScale = Value
                            end
                        end})
                        Utility:Connection(Lighting:GetPropertyChangedSignal("EnvironmentDiffuseScale"), LPH_JIT_ULTRA(function()
                            if Flags.lightingEnabled and Flags.lightingEnvironmentDiffuseScale then
                                Lighting.EnvironmentDiffuseScale = Flags.lightingEnvironmentDiffuseScaleAmnt
                            end
                        end))
                        
                        Sections.Visuals.Lighting:AddToggle({text = "Specular Scale", flag = "lightingEnvironmentSpecularScale", enabled = false, callback = function(State)
                            if State and Flags.lightingEnabled then
                                Lighting.EnvironmentSpecularScale = Flags.lightingEnvironmentSpecularScaleAmnt
                            else
                                Lighting.EnvironmentSpecularScale = Old_Lighting.EnvironmentSpecularScale
                            end
                            Options.lightingEnvironmentSpecularScaleAmnt.enabled = State
                            Options.lightingEnvironmentSpecularScale:UpdateOptions()
                            Tabs.Visuals:UpdateSections()
                        end}):AddSlider({flag = "lightingEnvironmentSpecularScaleAmnt", enabled = false, min = 0, max = 1, increment = 0.001, value = Old_Lighting.EnvironmentSpecularScale, callback = function(Value)
                            if Flags.lightingEnabled and Flags.lightingEnvironmentSpecularScale then
                                Lighting.EnvironmentSpecularScale = Value
                            end
                        end})
                        Utility:Connection(Lighting:GetPropertyChangedSignal("EnvironmentSpecularScale"), LPH_JIT_ULTRA(function()
                            if Flags.lightingEnabled and Flags.lightingEnvironmentSpecularScale then
                                Lighting.EnvironmentSpecularScale = Flags.lightingEnvironmentSpecularScaleAmnt
                            end
                        end))
                        
                        Sections.Visuals.Lighting:AddToggle({text = "Global Shadows", flag = "lightingGlobalShadows", enabled = false, callback = function(State)
                            if State then
                                if Flags.lightingEnabled then
                                    Lighting.GlobalShadows = State
                                end
                            else
                                Lighting.GlobalShadows = Old_Lighting.GlobalShadows
                            end
                        end}):SetState(Old_Lighting.GlobalShadows)
                        Utility:Connection(Lighting:GetPropertyChangedSignal("GlobalShadows"), LPH_JIT_ULTRA(function()
                            if Flags.lightingEnabled and Flags.lightingGlobalShadows then
                                Lighting.GlobalShadows = Flags.lightingGlobalShadows
                            end
                        end))
                        
                        Sections.Visuals.Lighting:AddToggle({text = "Outdoor Ambient", flag = "lightingOutdoorAmbient", enabled = false, callback = function(State)
                            if State and Flags.lightingEnabled then
                                Lighting.OutdoorAmbient = Flags.lightingOutdoorAmbientAmnt
                            else
                                Lighting.OutdoorAmbient = Old_Lighting.OutdoorAmbient
                            end
                            Options.lightingOutdoorAmbientAmnt.enabled = State
                            Options.lightingOutdoorAmbient:UpdateOptions()
                            Tabs.Visuals:UpdateSections()
                        end}):AddColor({text = "Outdoor Ambient Color", flag = "lightingOutdoorAmbientAmnt", enabled = false, color = Old_Lighting.OutdoorAmbient, callback = function(Color)
                            if Flags.lightingEnabled and Flags.lightingOutdoorAmbient then
                                Lighting.OutdoorAmbient = Color
                            end
                        end})
                        Utility:Connection(Lighting:GetPropertyChangedSignal("OutdoorAmbient"), LPH_JIT_ULTRA(function()
                            if Flags.lightingEnabled and Flags.lightingOutdoorAmbient then
                                Lighting.OutdoorAmbient = Flags.lightingOutdoorAmbientAmnt
                            end
                        end))
                        
                        Sections.Visuals.Lighting:AddToggle({text = "Technology", flag = "lightingTechnology", enabled = false, callback = function(State)
                            if State and Flags.lightingEnabled then
                                sethiddenproperty(Lighting, "Technology", Flags.lightingTechnologyAmnt)
                            else
                                sethiddenproperty(Lighting, "Technology", Old_Lighting.Technology)
                            end
                            Options.lightingTechnologyAmnt.enabled = State
                            Options.lightingTechnology:UpdateOptions()
                            Tabs.Visuals:UpdateSections()
                        end}):AddList({flag = "lightingTechnologyAmnt", enabled = false, selected = tostring(Old_Lighting.Technology):sub(17), values = {"Future", "ShadowMap", "Voxel", "Compatibility"}, callback = function(Technology)
                            if Flags.lightingEnabled and Flags.lightingTechnology then
                                sethiddenproperty(Lighting, "Technology", Technology)
                            end
                        end})
                        
                        Sections.Visuals.Lighting:AddToggle({text = "Decoration", flag = "lightingDecoration", enabled = false, callback = function(State)
                            if Flags.lightingEnabled then
                                sethiddenproperty(Terrain, "Decoration", State)
                            end
                        end}):SetState(Old_Decoration)
                        
                        Sections.Visuals.Lighting:AddToggle({text = "Time", flag = "lightingClockTime", enabled = false, callback = function(State)
                            if State and Flags.lightingEnabled then
                                Lighting.ClockTime = Flags.lightingClockTimeAmnt
                            else
                                Lighting.ClockTime = Old_Lighting.ClockTime
                            end
                            Options.lightingClockTimeAmnt.enabled = State
                            Options.lightingClockTime:UpdateOptions()
                            Tabs.Visuals:UpdateSections()
                        end}):AddSlider({flag = "lightingClockTimeAmnt", enabled = false, suffix = "h", min = 0, max = 23.99, increment = 0.01, value = Old_Lighting.ClockTime, callback = function(Value)
                            if Flags.lightingEnabled and Flags.lightingClockTime then
                                Lighting.ClockTime = Value
                            end
                        end})
                        Utility:Connection(Lighting:GetPropertyChangedSignal("ClockTime"), LPH_JIT_ULTRA(function()
                            if Flags.lightingEnabled and Flags.lightingClockTime then
                                Lighting.ClockTime = Flags.lightingClockTimeAmnt
                            end
                        end))
                        
                        Sections.Visuals.Lighting:AddToggle({text = "Exposure Compensation", flag = "lightingExposureCompensation", enabled = false, callback = function(State)
                            if State and Flags.lightingEnabled then
                                Lighting.ExposureCompensation = Flags.lightingExposureCompensationAmnt
                            else
                                Lighting.ExposureCompensation = Old_Lighting.ExposureCompensation
                            end
                            Options.lightingExposureCompensationAmnt.enabled = State
                            Options.lightingExposureCompensation:UpdateOptions()
                            Tabs.Visuals:UpdateSections()
                        end}):AddSlider({flag = "lightingExposureCompensationAmnt", enabled = false, min = -3, max = 3, increment = 0.001, value = Old_Lighting.ExposureCompensation, callback = function(Value)
                            if Flags.lightingEnabled and Flags.lightingExposureCompensation then
                                Lighting.ExposureCompensation = Value
                            end
                        end})
                        Utility:Connection(Lighting:GetPropertyChangedSignal("ExposureCompensation"), LPH_JIT_ULTRA(function()
                            if Flags.lightingEnabled and Flags.lightingExposureCompensation then
                                Lighting.ExposureCompensation = Flags.lightingExposureCompensationAmnt
                            end
                        end))
                        
                        Sections.Visuals.Lighting:AddList({text = "Sky", flag = "lightingSky", enabled = false, selected = "Standard", values = {"Standard", "Among Us", "Neptune", "Aesthetic Night", "Redshift"}, callback = function(Value)
                            if Flags.lightingEnabled then
                                for Index, Asset in pairs(SkyBoxes[Value]) do
                                    Sky[Index] = Asset
                                end
                            end
                        end})
                        
                        -- Visuals - Camera
                        Sections.Visuals.Camera:AddToggle({text = "Field of View", flag = "cameraFoV", callback = function(State)
                            if State then
                                Camera.FieldOfView = Flags.cameraFoVValue
                            else
                                Camera.FieldOfView = Old_Camera.FieldOfView
                            end
                            Options.cameraFoVValue.enabled = State
                            Options.cameraFoV:UpdateOptions()
                            Tabs.Visuals:UpdateSections()
                        end}):AddSlider({flag = "cameraFoVValue", enabled = false, suffix = "Â°", min = 1, max = 120, value = Old_Camera.FieldOfView, callback = function(Value)
                            if Flags.cameraFoV then
                                Camera.FieldOfView = Value
                            end
                        end})
                        
                        Sections.Visuals.Camera:AddToggle({text = "Zoom", flag = "cameraZoom", callback = function(State)
                            if State then
                                Camera.FieldOfView = Flags.cameraZoomValue
                            else
                                Camera.FieldOfView = Old_Camera.FieldOfView
                            end
                            Options.cameraZoomValue.enabled = State
                            Options.cameraZoom:UpdateOptions()
                            Tabs.Visuals:UpdateSections()
                        end}):AddBind({text = "Zoom", flag = "cameraZoomBind", tooltip = "Enables the zoom only when this key is held. Select BACKSPACE to make zoom always active.", mode = "hold", callback = function(State)
                            if Flags.cameraZoom then
                                if State then
                                    Camera.FieldOfView = Flags.cameraZoomValue
                                else
                                    if Flags.cameraFoV then
                                        Camera.FieldOfView = Flags.cameraFoVValue
                                    else
                                        Camera.FieldOfView = Old_Camera.FieldOfView
                                    end
                                end
                            end
                        end})
                        Options.cameraZoom:AddSlider({flag = "cameraZoomValue", enabled = false, suffix = "Â°", min = 1, max = 120, value = Old_Camera.FieldOfView, callback = function(Value)
                            if Flags.cameraZoom then
                                Camera.FieldOfView = Value
                            end
                        end})
                        
                        Sections.Visuals.Camera:AddToggle({text = "Third Person", flag = "lPlayerThirdPerson", callback = function(State)
                            Options.lPlayerThirdPersonValue.enabled = State
                            Options.lPlayerThirdPerson:UpdateOptions()
                            Tabs.Visuals:UpdateSections()
                        end}):AddBind({text = "Third Person", flag = "lPlayerThirdPersonBind", tooltip = "Toggles the third person when this key was pressed. Select BACKSPACE to make third person always active."})
                        Options.lPlayerThirdPerson:AddSlider({flag = "lPlayerThirdPersonValue", tooltip = "Third person distance.", enabled = false, min = 0, max = 100, increment = 0.1})
                        
                        Sections.Visuals.Camera:AddToggle({text = "Free Camera", flag = "lplayerFreeCamera", tooltip = "Blocks character movement and releases camera movement.", callback = function(State)
                            if State then
                                if Flags.lplayerFreeCameraBind then
                                    FreeCamera:Start()
                                end
                            else
                                FreeCamera:Stop()
                            end
                            Options.lplayerFreeCameraSpeed.enabled = State
                            Options.lplayerFreeCamera:UpdateOptions()
                            Tabs.Visuals:UpdateSections()
                        end}):AddBind({text = "Free Camera", flag = "lplayerFreeCameraBind", tooltip = "Toggles the free camera when this key was pressed. Select BACKSPACE to make free camera always active.", callback = function(State)
                            if State then
                                if Flags.lplayerFreeCamera then
                                    FreeCamera:Start()
                                else
                                    FreeCamera:Stop()
                                end
                            else
                                FreeCamera:Stop()
                            end
                        end})
                        Options.lplayerFreeCamera:AddSlider({flag = "lplayerFreeCameraSpeed", tooltip = "Free camera speed.", enabled = false, min = 0, max = 2, value = 0.5, increment = 0.01, callback = function(Value)
                            FreeCamera.Speed = Value
                        end})
                        
                        Utility:Connection(Camera:GetPropertyChangedSignal("FieldOfView"), LPH_JIT_ULTRA(function()
                            if Flags.cameraZoom and Flags.cameraZoomBind then
                                Camera.FieldOfView = Flags.cameraZoomValue
                                return
                            end
                            if Flags.cameraFoV then
                                Camera.FieldOfView = Flags.cameraFoVValue
                            end
                        end))
                        
                        -- Visuals - Other
                        Sections.Visuals.Other:AddToggle({text = "Field of View Circle", tooltip = "Draws a circle displaying your aimbot's field of view.", flag = "visualsShowFoV", callback = function(State)
                            FOV_Circle.Visible = State
                            Options.visualsShowFoVCol.enabled = State
                            Options.visualsShowFoV:UpdateOptions()
                            Tabs.Visuals:UpdateSections()
                        end}):AddColor({text = "FOV Circle Color", flag = "visualsShowFoVCol", enabled = false, callback = function(Color, Transparency)
                            FOV_Circle.Color = Color
                            FOV_Circle.Transparency = 1 - Transparency
                        end})
                        
                        local VisualizeLagFolder
                        Sections.Visuals.Other:AddToggle({text = "Visualize Fake Lag", flag = "visualsVisualizeLags", tooltip = "Shows your fake lag position. May cause lags if fake lag limit is low.", callback = function(State)
                            if not State then
                                task.spawn(function()
                                    task.wait()
                                    VisualizeLagFolder:ClearAllChildren()
                                end)
                            end
                            Options.visualsVisualizeLagsColor.enabled = State
                            Options.visualsVisualizeLags:UpdateOptions()
                            Tabs.Visuals:UpdateSections()
                        end}):AddColor({text = "Visualized Fake Lag Color", flag = "visualsVisualizeLagsColor", enabled = false})
                        
                        Sections.Visuals.Other:AddToggle({text = "Chinese Hat", flag = "visualsChineseHat", tooltip = "Draws a chinese hat on your head.", callback = function(State)
                            ESP.Settings.China_Hat.Enabled = State
                            for i = 1,30 do
                                ESP.China_Hat[i][1].Visible = State
                                ESP.China_Hat[i][2].Visible = State
                            end
                            Options.visualsChineseHatColor.enabled = State
                            Options.visualsChineseHatHeight.enabled = State
                            Options.visualsChineseHatRadius.enabled = State
                            Options.visualsChineseHatOffset.enabled = State
                            Options.visualsChineseHat:UpdateOptions()
                            Tabs.Visuals:UpdateSections()
                        end}):AddColor({text = "Chinese Hat Color", flag = "visualsChineseHatColor", enabled = false, trans = 0.5, callback = function(Color, Transparency)
                            ESP.Settings.China_Hat.Color = Color
                            ESP.Settings.China_Hat.Transparency = Transparency
                        end})
                        Options.visualsChineseHat:AddSlider({flag = "visualsChineseHatHeight", tooltip = "Chinese hat height.", enabled = false, min = -5, max = 5, value = 0.5, increment = 0.1, callback = function(Value)
                            ESP.Settings.China_Hat.Height = Value
                        end})
                        Options.visualsChineseHat:AddSlider({flag = "visualsChineseHatRadius", tooltip = "Chinese hat radius.", enabled = false, min = -5, max = 5, value = 1, increment = 0.1, callback = function(Value)
                            ESP.Settings.China_Hat.Radius = Value
                        end})
                        Options.visualsChineseHat:AddSlider({flag = "visualsChineseHatOffset", tooltip = "Chinese hat offset.", enabled = false, min = -5, max = 5, value = 1, increment = 0.1, callback = function(Value)
                            ESP.Settings.China_Hat.Offset = Value
                        end})
                        
                        -- Miscellaneous - LocalPlayer
                        local SpeedHack
                        Sections.Miscellaneous.LocalPlayer:AddToggle({text = "Speedhack", flag = "lplayerSpeedhack", tooltip = "Speeds up your character.", callback = LPH_JIT_MAX(function(State)
                            if State then
                                if SpeedHack ~= nil then
                                    SpeedHack:Disconnect()
                                    SpeedHack = nil
                                end
                                SpeedHack = Utility:Connection(RunService.Stepped, function()
                                    local IsFlying = (Flags.lPlayerSpeedhackFly and Flags.lPlayerSpeedhackFlyBind) or false
                                    local Character, SpeedActive, Speed, FlyEnabled, Fly = LocalPlayer.Character, Flags.lplayerSpeedhackBind or false, IsFlying and Flags.lPlayerSpeedhackFlySpeed or Flags.lplayerSpeedhackValue
                                    if not Library.open and Character then
                                        local HumanoidRootPart, Humanoid = Character:FindFirstChild("HumanoidRootPart"), Character:FindFirstChildOfClass("Humanoid")
                                        if HumanoidRootPart and Humanoid then
                                            if SpeedActive then
                                                if Humanoid:GetState() ~= Enum.HumanoidStateType.Climbing and UserInputService:IsKeyDown(Enum.KeyCode.W) then HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + Camera.CFrame.LookVector * Speed end
                                                if UserInputService:IsKeyDown(Enum.KeyCode.S) then HumanoidRootPart.CFrame = HumanoidRootPart.CFrame - Camera.CFrame.LookVector * Speed end
                                                if UserInputService:IsKeyDown(Enum.KeyCode.A) then HumanoidRootPart.CFrame = HumanoidRootPart.CFrame - Camera.CFrame.RightVector * Speed end
                                                if UserInputService:IsKeyDown(Enum.KeyCode.D) then HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + Camera.CFrame.RightVector * Speed end
                                            end
                                            if SpeedActive and IsFlying then
                                                HumanoidRootPart:ApplyImpulse(-HumanoidRootPart.Velocity)
                                                HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                                                HumanoidRootPart.CFrame = CFrame.lookAt(HumanoidRootPart.Position, HumanoidRootPart.Position + Camera.CFrame.LookVector)
                                                Workspace.Gravity = 0
                                                Humanoid.PlatformStand = Flags.lPlayerSpeedhackFlyPlatformStand
                                                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, Speed, 0) end
                                                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -Speed, 0) end
                                            end
                                        end
                                    end
                                end)
                            else
                                task.spawn(function()
                                    task.wait()
                                    if SpeedHack ~= nil then
                                        SpeedHack:Disconnect()
                                        SpeedHack = nil
                                    end
                                    if LocalPlayer.Character then
                                        local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                                        if Humanoid then
                                            Humanoid.PlatformStand = false
                                        end
                                    end
                                    if Flags.lplayerGravity then
                                        Workspace.Gravity = Flags.lplayerGravityValue
                                    else
                                        Workspace.Gravity = Old_Gravity
                                    end
                                end)
                            end
                            Options.lplayerSpeedhackValue.enabled = State
                            Options.lPlayerSpeedhackFly.enabled = State
                            Options.lplayerSpeedhack:UpdateOptions()
                            Sections.Miscellaneous.LocalPlayer:UpdateOptions()
                            Tabs.Miscellaneous:UpdateSections()
                        end)}):AddBind({text = "Speedhack", flag = "lplayerSpeedhackBind", tooltip = "Toggles the speedhack when this key was pressed. Select BACKSPACE to make speedhack always active.", callback = function(State)
                            if not State and Flags.lPlayerSpeedhackFly then
                                task.spawn(function()
                                    task.wait()
                                    if LocalPlayer.Character then
                                        local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                                        if Humanoid then
                                            Humanoid.PlatformStand = false
                                        end
                                    end
                                    if Flags.lplayerGravity then
                                        Workspace.Gravity = Flags.lplayerGravityValue
                                    else
                                        Workspace.Gravity = Old_Gravity
                                    end
                                end)
                            end
                        end})
                        Options.lplayerSpeedhack:AddSlider({flag = "lplayerSpeedhackValue", tooltip = "Speedhack speed.", enabled = false, min = 0, max = 3, increment = 0.0001, value = 0})
                        
                        Sections.Miscellaneous.LocalPlayer:AddToggle({text = "Speedhack Fly", flag = "lPlayerSpeedhackFly", tooltip = "Lets you fly with speedhack enabled.", enabled = false, callback = function(State)
                            if not State then
                                task.spawn(function()
                                    task.wait()
                                    if LocalPlayer.Character then
                                        local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                                        if Humanoid then
                                            Humanoid.PlatformStand = false
                                        end
                                    end
                                    if Flags.lplayerGravity then
                                        Workspace.Gravity = Flags.lplayerGravityValue
                                    else
                                        Workspace.Gravity = Old_Gravity
                                    end
                                end)
                            end
                            Options.lPlayerSpeedhackFlySpeed.enabled = State
                            Options.lPlayerSpeedhackFlyPlatformStand.enabled = State
                            Options.lPlayerSpeedhackFly:UpdateOptions()
                            Sections.Miscellaneous.LocalPlayer:UpdateOptions()
                            Tabs.Miscellaneous:UpdateSections()
                        end}):AddBind({text = "Speedhack Fly", flag = "lPlayerSpeedhackFlyBind", tooltip = "Enables the speedhack flying only when this fly active and key is held. Select BACKSPACE to make speedhack flying always active.", mode = "hold", callback = function(State)
                            if Flags.lPlayerSpeedhackFly then
                                if not State then
                                    task.spawn(function()
                                        task.wait()
                                        if LocalPlayer.Character then
                                            local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                                            if Humanoid then
                                                Humanoid.PlatformStand = false
                                            end
                                        end
                                        if Flags.lplayerGravity then
                                            Workspace.Gravity = Flags.lplayerGravityValue
                                        else
                                            Workspace.Gravity = Old_Gravity
                                        end
                                    end)
                                end
                            end
                        end})
                        Options.lPlayerSpeedhackFly:AddSlider({flag = "lPlayerSpeedhackFlySpeed", tooltip = "Speedhack speed when flying.", enabled = false, min = 0, max = 3, increment = 0.0001, value = 0})
                        
                        Sections.Miscellaneous.LocalPlayer:AddToggle({text = "Fly Platform Stand", flag = "lPlayerSpeedhackFlyPlatformStand", tooltip = "If disabled then you probably will fly in vehicles. Disabling makes on foot fly unstable.", enabled = false}):SetState(true)
                        
                        -- Sections.Miscellaneous.LocalPlayer:AddToggle({text = "Gravity", flag = "lplayerGravity", tooltip = "Changes world gravity.", callback = function(State)
                        --     if State then
                        --         Workspace.Gravity = Flags.lplayerGravityValue
                        --     else
                        --         Workspace.Gravity = Old_Gravity
                        --     end
                        --     Options.lplayerGravityValue.enabled = State
                        --     Options.lplayerGravity:UpdateOptions()
                        --     Tabs.Miscellaneous:UpdateSections()
                        -- end}):AddSlider({flag = "l
                        -- GravityValue", tooltip = "Gravity value.", enabled = false, min = 0, max = 1000, increment = 0.001, value = Old_Gravity, callback = function(Value)
                        --     if Flags.lplayerGravity then
                        --         Workspace.Gravity = Value
                        --     end
                        -- end})
                        
                        Utility:Connection(Workspace:GetPropertyChangedSignal("Gravity"), LPH_JIT_ULTRA(function()
                            if Flags.lplayerSpeedhack and Flags.lPlayerSpeedhackFly and Flags.lPlayerSpeedhackFlyBind then
                                Workspace.Gravity = 0
                                return
                            end
                            if Flags.lplayerGravity then
                                Workspace.Gravity = Flags.lplayerGravityValue
                            end
                        end))
                        
                        local Noclip
                        Sections.Miscellaneous.LocalPlayer:AddToggle({text = "Noclip", flag = "lplayerNoclip", tooltip = "Allows you to clip through walls.", callback = LPH_JIT_ULTRA(function(State)
                            if State then
                                if Noclip ~= nil then
                                    Noclip:Disconnect()
                                    Noclip = nil
                                end
                                Noclip = Utility:Connection(RunService.Stepped, function()
                                    if Flags.lplayerNoclipBind and LocalPlayer.Character then
                                        for _, Child in pairs(LocalPlayer.Character:GetDescendants()) do
                                            if Child:IsA("BasePart") and Child.CanCollide == true then
                                                Child.CanCollide = false
                                            end
                                        end
                                    end
                                end)
                            else
                                task.spawn(function()
                                    task.wait()
                                    if Noclip ~= nil then
                                        Noclip:Disconnect()
                                        Noclip = nil
                                    end
                                end)
                            end
                        end)})
                        -- Options.lplayerNoclip:AddBind({text = "Noclip", flag = "lplayerNoclipBind", tooltip = "Toggles the noclip when this key was pressed. Select BACKSPACE to make noclip always active."})
                        
                        -- Sections.Miscellaneous.LocalPlayer:AddToggle({text = "Auto Hop", flag = "lplayerBhop", tooltip = "Makes you jump as soon as you land."})
                        -- Options.lplayerBhop:AddBind({text = "Auto Hop", flag = "lplayerBhopBind", tooltip = "Enables the auto hop only when this key is held. Select BACKSPACE to make auto hop always active.", mode = "hold"})
                        
                        -- Sections.Miscellaneous.LocalPlayer:AddToggle({text = "Infinite Jump", flag = "lplayerInfJump", tooltip = "Lets you jump when in air."})
                        -- Options.lplayerInfJump:AddBind({text = "Infinite Jump", flag = "lplayerInfJumpBind", tooltip = "Enables the infinite jump only when this key is held. Select BACKSPACE to make infinite jump always active.", mode = "hold"})
                        
                        -- Utility:Connection(UserInputService.JumpRequest, LPH_JIT_ULTRA(function()
                        --     if Flags.lplayerInfJump and Flags.lplayerInfJumpBind then
                        --         local Character = LocalPlayer.Character
                        --         if Character then
                        --             local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                        --             if Humanoid then
                        --                 Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                        --             end
                        --         end
                        --     end
                        -- end))
                        
                        -- if LocalPlayer.Character then
                        --     local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                        --     if Humanoid then
                        --         Utility:Connection(Humanoid.StateChanged, LPH_JIT_ULTRA(function(_, newState)
                        --             if newState == Enum.HumanoidStateType.Landed then
                        --                 if Flags.lplayerBhop and Flags.lplayerBhopBind then
                        --                     Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                        --                 end
                        --             end
                        --         end))
                        --     end
                        -- end
                        
                        -- Utility:Connection(LocalPlayer.CharacterAdded, LPH_JIT_ULTRA(function(Character)
                        --     local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                        --     if Humanoid then
                        --         Utility:Connection(Humanoid.StateChanged, function(_, newState)
                        --             if newState == Enum.HumanoidStateType.Landed then
                        --                 if Flags.lplayerBhop and Flags.lplayerBhopBind then
                        --                     Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                        --                 end
                        --             end
                        --         end)
                        --     else
                        --         local c; c = Utility:Connection(Character.ChildAdded, function(Humanoid)
                        --             if Humanoid:IsA("Humanoid") then
                        --                 Utility:Connection(Humanoid.StateChanged, function(_, newState)
                        --                     if newState == Enum.HumanoidStateType.Landed then
                        --                         if Flags.lplayerBhop and Flags.lplayerBhopBind then
                        --                             Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                        --                         end
                        --                     end
                        --                 end)
                        --                 c:Disconnect()
                        --             end
                        --         end)
                        --     end
                        -- end))
                        
                        -- Miscellaneous - Network
                        VisualizeLagFolder = Framework:Instance("Folder", {Parent = Camera})
                        Sections.Miscellaneous.Network:AddToggle({text = "Fake Lag", flag = "networkFakeLag", callback = LPH_JIT_ULTRA(function(State)
                            if State then
                                task.spawn(function()
                                    task.wait()
                                    local Tick = 0
                                    while Flags.networkFakeLag and Running do
                                        Tick = Tick + 1
                                        local Character = LocalPlayer.Character
                                        if Character then
                                            local Head, HumanoidRootPart, Humanoid = Character:FindFirstChild("Head"), Character:FindFirstChild("HumanoidRootPart"), Character:FindFirstChild("Humanoid")
                                            if Head and HumanoidRootPart and Humanoid and Humanoid.Health > 0 then
                                                if Tick >= Flags.networkFakeLagLimit then
                                                    Tick = 0
                                                    NetworkClient:SetOutgoingKBPSLimit(math.huge)
                                                    if Flags.visualsVisualizeLags then
                                                        VisualizeLagFolder:ClearAllChildren()
                                                        Character.Archivable = true
                                                        local Clone = Character:Clone()
                                                        Character.Archivable = false
                                                        for _, Child in pairs(Clone:GetDescendants()) do
                                                            if Child:IsA("SurfaceAppearance") or Child:IsA("Humanoid") or Child:IsA("BillboardGui") or Child:IsA("Decal") or Child.Name == "HumanoidRootPart" then
                                                                Child:Destroy()
                                                                continue
                                                            end
                                                            if Child:IsA("BasePart") then
                                                                Child.CanCollide = false
                                                                Child.Anchored = true
                                                                Child.Material = Enum.Material.ForceField
                                                                Child.Color = Flags.visualsVisualizeLagsColor
                                                                Child.Transparency = Options.visualsVisualizeLagsColor.trans
                                                                Child.Size = Child.Size + Vector3.new(0.025, 0.025, 0.025)
                                                            end
                                                        end
                                                        Clone.Parent = VisualizeLagFolder
                                                    end
                                                elseif (Flags.aimbotAutoFireNoLags and IsClicking and true) or (Flags.networkFakeLagNoMouse and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) and true) then
                                                    Tick = 0
                                                    NetworkClient:SetOutgoingKBPSLimit(math.huge)
                                                    if Flags.visualsVisualizeLags then
                                                        VisualizeLagFolder:ClearAllChildren()
                                                        Character.Archivable = true
                                                        local Clone = Character:Clone()
                                                        Character.Archivable = false
                                                        for _, Child in pairs(Clone:GetDescendants()) do
                                                            if Child:IsA("SurfaceAppearance") or Child:IsA("Humanoid") or Child:IsA("BillboardGui") or Child:IsA("Decal") or Child.Name == "HumanoidRootPart" then
                                                                Child:Destroy()
                                                                continue
                                                            end
                                                            if Child:IsA("BasePart") then
                                                                Child.CanCollide = false
                                                                Child.Anchored = true
                                                                Child.Material = Enum.Material.ForceField
                                                                Child.Color = Flags.visualsVisualizeLagsColor
                                                                Child.Transparency = Options.visualsVisualizeLagsColor.trans
                                                                Child.Size = Child.Size + Vector3.new(0.025, 0.025, 0.025)
                                                            end
                                                        end
                                                        Clone.Parent = VisualizeLagFolder
                                                    end
                                                else
                                                    NetworkClient:SetOutgoingKBPSLimit(1)
                                                end
                                            end
                                        end
                                        RunService.Stepped:Wait()
                                    end
                                end)
                            else 
                                task.spawn(function()
                                    task.wait()
                                    NetworkClient:SetOutgoingKBPSLimit(math.huge)
                                    VisualizeLagFolder:ClearAllChildren()
                                end)
                            end
                            Options.networkFakeLagLimit.enabled = State
                            Options.networkFakeLagNoMouse.enabled = State
                            Options.networkFakeLag:UpdateOptions()
                            Sections.Miscellaneous.Network:UpdateOptions()
                            Tabs.Miscellaneous:UpdateSections()
                        end)}):AddSlider({flag = "networkFakeLagLimit", tooltip = "Lag ticks limit (How long you will not send bandwidth).", enabled = false, suffix = "t", min = 0, max = 80, value = 0})
                        
                        Sections.Miscellaneous.Network:AddToggle({text = "Disable Fake Lag On Mouse", flag = "networkFakeLagNoMouse", enabled = false, tooltip = "Disables fake lags when holding left mouse button.",})
                        
                        -- Players - Players
                        local joinedAfterMe = {}
                        updateInfo = LPH_JIT_MAX(function(Name, Again)
                            local Player = Players:FindFirstChild(Name)
                            if not Player then return end
                            if not Again then
                                Options.playersName:SetText(("Name: %s"):format(Name))
                                Options.playersAge:SetText(("Account Age: %sd"):format(Player.AccountAge))
                                local User = game:HttpGet("https://users.roblox.com/v1/users/"..Player.UserId)
                                local Data = HttpService:JSONDecode(User)
                                Options.playersDate:SetText(("Join Date: %s"):format(Data.created:sub(1,10)))
                                Options.playersMembership:SetText(("Roblox Membership: %s"):format(tostring(gethiddenproperty(Player, "MembershipTypeReplicate")):sub(21)))
                                Options.playersJoined:SetText(("Joined Server After You: %s"):format(table.find(joinedAfterMe, Name) and "Yes" or "No"))
                            end
                            local Character, Health, Distance, Invis, Noclip = ESP:Get_Character(Player), "-", "-", "-", "-"
                            if Character then
                                local Head, HumanoidRootPart, Humanoid = Character:FindFirstChild("Head"), Character:FindFirstChild("HumanoidRootPart"), Character:FindFirstChildOfClass("Humanoid")
                                if Humanoid and HumanoidRootPart then
                                    Distance = tostring(math.floor((HumanoidRootPart.Position - Camera.CFrame.p).Magnitude / 3.5714285714 + 0.5)).."m"
                                    Health = tostring(math.floor(Humanoid.Health + 0.5))
                                    Invis = Head.Transparency == 1 and "Yes" or "No"
                                    Noclip = (Humanoid.RigType == "R15" and Character.UpperTorso.CanCollide == false and "Yes") or (Humanoid.RigType == "R6" and Character.Torso.CanCollide == false and "Yes") or "No"
                                end
                            end
                            local Team = ESP:Get_Team(Player)
                            Options.playersTeam:SetText(("Team: %s"):format((Team ~= nil and tostring(Team)) or "None"))
                            Options.playersInvis:SetText(("Invisible: %s"):format(Invis))
                            Options.playersNoclipping:SetText(("Noclipping: %s"):format(Noclip))
                            Options.playersHealth:SetText(("Health: %s"):format(Health))
                            Options.playersDistance:SetText(("Distance: %s"):format(Distance))
                            Options.playersTool:SetText(("Tool: %s"):format(ESP:Get_Tool(Player)))
                        end)
                        Sections.Players.Players:AddList({text = "Player", flag = "playersPlayer", callback = LPH_JIT_MAX(function(Name)
                            updateInfo(Name)
                        end)})
                        Sections.Players.Players:AddText({text = "Name: -", flag = "playersName"})
                        Sections.Players.Players:AddText({text = "Account Age: -", flag = "playersAge"})
                        Sections.Players.Players:AddText({text = "Join Date: -", flag = "playersDate"})
                        Sections.Players.Players:AddText({text = "Roblox Membership: -", flag = "playersMembership"})
                        Sections.Players.Players:AddText({text = "Joined Server After You: -", flag = "playersJoined"})
                        Sections.Players.Players:AddText({text = "Team: -", flag = "playersTeam"})
                        Sections.Players.Players:AddText({text = "Invisible: -", flag = "playersInvis"})
                        Sections.Players.Players:AddText({text = "Noclipping: -", flag = "playersNoclipping"})
                        Sections.Players.Players:AddText({text = "Health: -", flag = "playersHealth"})
                        Sections.Players.Players:AddText({text = "Distance: -", flag = "playersDistance"})
                        Sections.Players.Players:AddText({text = "Tool: -", flag = "playersTool"})
                        
                        -- Sections.Players.Players:AddButton({text = "Teleport to Player", callback = LPH_JIT_MAX(function()
                        --     pcall(function()
                        --         LocalPlayer.Character.HumanoidRootPart.CFrame = ESP:Get_Character(Players[Flags.playersPlayer]).HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
                        --     end)
                        -- end)})
                        
                        local isSpectating, SubjectChanged, HumanoidDied = false, nil, nil
                        Sections.Players.Players:AddButton({text = "Spectate", flag = "spectateButton", callback = LPH_JIT_MAX(function()
                            if not isSpectating then
                                pcall(function()
                                    local Character = LocalPlayer.Character
                                    if Character then
                                        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                                        if Humanoid then
                                            Humanoid.AutoRotate = false
                                        end
                                    end
                                    Camera.CameraSubject = Players[Flags.playersPlayer].Character
                                    isSpectating = true
                                    Options.spectateButton:SetText("Unspectate")
                                    SubjectChanged = Utility:Connection(Camera:GetPropertyChangedSignal("CameraSubject"), function()
                                        Camera.CameraSubject = LocalPlayer.Character
                                        local Character = LocalPlayer.Character
                                        if Character then
                                            local Humanoid, HumanoidRootPart = Character:FindFirstChildOfClass("Humanoid"), Character:FindFirstChild("HumanoidRootPart")
                                            if Humanoid and HumanoidRootPart then
                                                Camera.CFrame = CFrame.lookAt(Camera.CFrame.p, Camera.CFrame.p + HumanoidRootPart.CFrame.LookVector)
                                                Humanoid.AutoRotate = true
                                            end
                                        end
                                        isSpectating = false
                                        Options.spectateButton:SetText("Spectate")
                                    end)
                                    local Humanoid = Players[Flags.playersPlayer].Character:FindFirstChildOfClass("Humanoid")
                                    if Humanoid then
                                        HumanoidDied = Utility:Connection(Humanoid.Died, function()
                                            Camera.CameraSubject = LocalPlayer.Character
                                            local Character = LocalPlayer.Character
                                            if Character then
                                                local Humanoid, HumanoidRootPart = Character:FindFirstChildOfClass("Humanoid"), Character:FindFirstChild("HumanoidRootPart")
                                                if Humanoid and HumanoidRootPart then
                                                    Camera.CFrame = CFrame.lookAt(Camera.CFrame.p, Camera.CFrame.p + HumanoidRootPart.CFrame.LookVector)
                                                    Humanoid.AutoRotate = true
                                                end
                                            end
                                            isSpectating = false
                                            Options.spectateButton:SetText("Spectate")
                                        end)
                                    end
                                end)
                            else
                                pcall(function()
                                    if SubjectChanged ~= nil then
                                        SubjectChanged:Disconnect()
                                        SubjectChanged = nil
                                    end
                                    if HumanoidDied ~= nil then
                                        HumanoidDied:Disconnect()
                                        HumanoidDied = nil
                                    end
                                    Camera.CameraSubject = LocalPlayer.Character
                                    local Character = LocalPlayer.Character
                                    if Character then
                                        local Humanoid, HumanoidRootPart = Character:FindFirstChildOfClass("Humanoid"), Character:FindFirstChild("HumanoidRootPart")
                                        if Humanoid and HumanoidRootPart then
                                            Camera.CFrame = CFrame.lookAt(Camera.CFrame.p, Camera.CFrame.p + HumanoidRootPart.CFrame.LookVector)
                                            Humanoid.AutoRotate = true
                                        end
                                    end
                                    isSpectating = false
                                    Options.spectateButton:SetText("Spectate")
                                end)
                            end
                        end)})
                        
                        Sections.Players.Players:AddButton({text = "Update", callback = LPH_JIT_MAX(function()
                            updateInfo(Flags.playersPlayer, true)
                        end)})
                        
                        for _, Player in pairs(Players:GetPlayers()) do
                            Options.playersPlayer:AddValue(Player.Name)
                        end
                        
                        Utility:Connection(Players.PlayerAdded, LPH_JIT_ULTRA(function(Player)
                            table.insert(joinedAfterMe, Player.Name)
                            Options.playersPlayer:AddValue(Player.Name)
                            ESP:Player(Player)
                        end))
                        
                        Utility:Connection(Players.PlayerRemoving, LPH_JIT_ULTRA(function(Player)
                            for i,v in pairs(joinedAfterMe) do
                                if v == Player.Name then
                                    joinedAfterMe[i] = nil
                                end
                            end
                            Options.playersPlayer:RemoveValue(Player.Name)
                            local Object = ESP:GetObject(Player)
                            if Object then
                                Object:Destroy()
                            end
                        end))
                        
                        -- Settings - Other
                        Sections.Settings.Other:AddToggle({text = "Team Check", flag = "teamCheck", callback = function(State)
                            ESP.Settings.Team_Check = State
                        end})
                        
                        Sections.Settings.Other:AddToggle({text = "Improved Visible Check", flag = "improvedVisibleCheck", tooltip = "Improves visible check by multi casting rays. Medium low perfomance impact.", callback = function(State)
                            ESP.Settings.Improved_Visible_Check = State
                        end}):SetState(true)
                        
                        Sections.Settings.Other:AddList({text = "Visible Check Mode", flag = "visibleCheckMode", tooltip = "Choose from where visible checking ray will be casted.", values = {"Camera", "Head"}, selected = "Camera"})
                        
                        Sections.Settings.Other:AddSlider({text = "Between Clicks Time", flag = "betweenClickTime", tooltip = "Wait time between mouse press and mouse release.", min = 0, max = 1, increment = 0.01})
                        
                        -- Unload
                        Utility:Connection(Library.unloaded, LPH_JIT_MAX(function()
                            Running = false
                            task.spawn(function()
                                task.wait()
                                for _, Object in pairs(ESP.Objects) do
                                    Object:Destroy()
                                end
                                ESP_RenderStepped:Disconnect()
                                for _, Player in pairs(Players:GetPlayers()) do
                                    if Player == LocalPlayer then continue end
                                    local Character = ESP:Get_Character(Player)
                                    if Character == nil then continue end
                                    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                                    if not HumanoidRootPart then continue end
                                    if HumanoidRootPart.Material == Enum.Material.Plastic then continue end
                                    HumanoidRootPart.Material = Enum.Material.Plastic
                                    HumanoidRootPart.Size = Old_HumanoidRootPart_Size
                                    HumanoidRootPart.Transparency = 1
                                end
                                for Property, Value in pairs(Old_Lighting) do
                                    pcall(function()
                                        Lighting[Property] = Value
                                        if Property == "Technology" then
                                            sethiddenproperty(Lighting, "Technology", Old_Lighting.Technology)
                                        end
                                    end)
                                end
                                sethiddenproperty(Terrain, "Decoration", Old_Decoration)
                                Camera.FieldOfView = Old_Camera.FieldOfView
                                FOV_Circle:Remove()
                                FOV_Circle = nil
                                if LocalPlayer.Character then
                                    local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                                    if Humanoid then
                                        Humanoid.PlatformStand = false
                                    end
                                end
                                Workspace.Gravity = Old_Gravity
                                for _, connection in pairs(getconnections(Workspace:GetPropertyChangedSignal("Gravity"))) do
                                    connection:Enable()
                                end
                                for _, connection in pairs(getconnections(Workspace.Changed)) do
                                    connection:Enable()
                                end
                                local Character = LocalPlayer.Character
                                if Character then
                                    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                                    if Humanoid then
                                        for _, connection in pairs(getconnections(Humanoid.StateChanged)) do
                                            connection:Enable()
                                        end
                                    end
                                end
                                VisualizeLagFolder:Destroy()
                                VisualizeLagFolder = nil
                                settings().Network.IncomingReplicationLag = 0
                                NetworkClient:SetOutgoingKBPSLimit(math.huge)
                                FreeCamera:Unload()
                                createTracer, Noclip, SpeedHack, HumanoidDied, SubjectChanged, Workspace, Camera, Players, LocalPlayer, RunService, UserInputService, HttpService, Lighting, NetworkClient, Utility, Window, Tabs, Sections, Settings, Mouse, Old_HumanoidRootPart_Size, ESP, ESP_RenderStepped, Framework, Flags, Options, Library, joinedAfterMe, isSpectating, Old_Platform, Old_Gravity, LastCameraCFrame, IsClicking, Old_Lighting, Old_Camera, Aimbot, Loaded = nil
                            end)
                        end))
                        
                        Loaded = true
