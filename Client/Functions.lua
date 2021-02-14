Locale = {}

function Lang(what)
	local Dict = Locale[Config.Language]
	if not Dict[what] then return Locale["en"][what] end -- If we cant find a translation, use the english one.
	return Dict[what]
end

function TextInput(TextEntry, ExampleText, MaxStringLength)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength or 20)
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do Wait(0) end
	if UpdateOnscreenKeyboard() ~= 2 then
		local Result = GetOnscreenKeyboardResult()
		Wait(200) return Result
	else
		Wait(200) return ExampleText
	end
end

function Text(t)
	local Align = t.Align or 0
	local Colour = t.Colour or {255,255,255}
	local Font = t.Font or 4
	local Scale = t.Scale or 0.25
	local Alpha = t.Alpha or 255
	SetTextFont(Font)
	SetTextJustification(Align)
	SetTextScale(Scale, Scale)
	if t.Center then SetTextCentre() end
	SetTextColour(Colour[1], Colour[2], Colour[3], Alpha)
	if t.Outline then SetTextOutline() end
	if t.Wrap then SetTextWrap(t.Wrap.x, t.Wrap.y) end
	SetTextEntry("STRING")
	AddTextComponentString(t.Text)
	DrawText(t.x,t.y)
end

function Distance(first, second)
	local distance = #(first - second)
	return distance
end

function Chat(Msg)
	TriggerEvent("chatMessage", "^4Scenes^7", {255,255,255}, Msg)
end

function log(what)
	if type(what) == "table" then
		print(json.encode(what))
	else
		print(tostring(what).." | "..type(what))
	end
end

function AlterOverflow(var, value, min, max, around)
    local v = var+value
    if v > max then
        if around then
            return min
        end
        return var
    end
    if v < min then
        if around then
            return max
        end
        return var
    end
    return v
end

function GetCursor()
	local sx, sy = GetActiveScreenResolution()
	local cx, cy = GetNuiCursorPosition()
	local cx, cy = (cx / sx) + 0.008, (cy / sy) + 0.027
	return cx, cy
end

function SplitString(s)
    local Rows = 0
    for i = 100, string.len(s), 99 do
        local String = string.sub(s, i, i+99)
        AddTextComponentString(String)
        Rows = Rows+1
    end
    return Rows
end

local function RotationToDirection(rotation)
	local New = 
	{ 
		x = (math.pi / 180) * rotation.x, 
		y = (math.pi / 180) * rotation.y, 
		z = (math.pi / 180) * rotation.z 
	}
	local Dir = 
	{
		x = -math.sin(New.z) * math.abs(math.cos(New.x)), 
		y = math.cos(New.z) * math.abs(math.cos(New.x)), 
		z = math.sin(New.x)
	}
	return Dir
end

function RayCastGamePlayCamera(distance)
	local Rotation = GetGameplayCamRot()
	local Cam = GetGameplayCamCoord()
	local Dir = RotationToDirection(Rotation)
	local Des = 
	{ 
		x = Cam.x + Dir.x * distance, 
		y = Cam.y + Dir.y * distance, 
		z = Cam.z + Dir.z * distance 
	}
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(Cam.x, Cam.y, Cam.z, Des.x, Des.y, Des.z, -1, -1, 1))
	return b, c, e, Des
end