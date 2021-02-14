Keys = {
	[","] = 82, ["-"] = 84, ["."] = 81, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161,
	["8"] = 162, ["9"] = 163, ["="] = 83, ["["] = 39, ["]"] = 40, ["A"] = 34, ["B"] = 29, ["BACKSPACE"] = 177, ["C"] = 26, ["CAPS"] = 137, 
	["D"] = 9, ["DELETE"] = 178, ["UP"] = 172, ["DOWN"] = 173, ["E"] = 38, ["ENTER"] = 18, ["ESC"] = 322, ["F"] = 23, ["F1"] = 288, ["F10"] = 57, ["F2"] = 289,
	["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["G"] = 47, ["H"] = 74, ["HOME"] = 213, ["K"] = 311,
	["L"] = 182, ["LEFT"] = 174, ["LEFTALT"] = 19, ["LEFTCTRL"] = 36, ["LEFTSHIFT"] = 21, ["M"] = 244, ["N"] = 249, ["N+"] = 96, ["N-"] = 97,
	["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118, ["NENTER"] = 201, ["P"] = 199, ["PAGEDOWN"] = 11,
	["PAGEUP"] = 10, ["Q"] = 44, ["R"] = 45, ["RIGHT"] = 175, ["RIGHTCTRL"] = 70, ["S"] = 8, ["SPACE"] = 22, ["T"] = 245, ["TAB"] = 37,
	["TOP"] = 27, ["U"] = 303, ["V"] = 0, ["W"] = 32, ["X"] = 73, ["Y"] = 246, ["Z"] = 20, ["~"] = 243,
}

Controls = {
	Current = nil,
	MenuKeys = {"UP", "DOWN", "LEFT", "RIGHT", "ENTER"},
	KeyTimeout = 120
}

RegisterCommand("ScenesInfo", function()
	if Scene.State == "Placing" then
		Scene.Info = not Scene.Info
	end
end)

RegisterKeyMapping("ScenesInfo", "Toggles the scene info.", "keyboard", "i")

function GetKey(str)
	local Key = Keys[string.upper(str)]
	if Key then return Key else return false end
end

function CurrentKey(key, time, wait)
	if Controls.Current == key then
		if time then Controls.KeyTimeout = time else Controls.KeyTimeout = 120 end
		return true
	end
	return false
end

CreateThread(function()
	while true do Wait(0)
		if Scene.State then
			for k,v in pairs(Controls.MenuKeys) do
				if IsControlPressed(0, GetKey(v)) then
					Controls.Current = v
					Wait(1)
					Controls.Current = nil
					Wait(Controls.KeyTimeout or 120)
				end
			end
		else
			Wait(1000)
		end
	end
end)