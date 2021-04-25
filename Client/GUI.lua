Menu = {
	Option = 1,
	Option2 = 1,
	Option3 = 1,
	FontOption = 1,
	FunctionOption = 1,
	PresetOption = 1,
	TimeOption = 4,
	ShowAgeOption = 1,
}

local Outlines = {Lang("Outline"), Lang("Shadow"), Lang("None2")}
local YesNo = {Lang("Yes"), Lang("No")}

Menus = {
	{
		Modifier = "Enter",
		Label = Lang("SelectFont"),
		Desc = Lang("SelectDesc"),
		Current = function()
			return Fonts[Scene.Text.Font].Name
		end,
		Function = function(x,y,control)
			if IsControlJustPressed(0, GetKey("ENTER")) and control and not Scene.Info then
				CreateThread(function()
					Scene.State = "Fonts"
				end)
			end
		end
	},
	{
		Modifier = "Switch",
		Label = Lang("TextSize"),
		Desc = string.format(Lang("TextDesc"), Config.FontSize.Min, Config.FontSize.Max),
		Current = function()
			return Scene.Text.Size
		end,
		Function = function()
			if CurrentKey("LEFT") then
				Scene.Text.Size = AlterOverflow(Scene.Text.Size, -0.01, Config.FontSize.Min-0.01, Config.FontSize.Max+0.01)
			elseif CurrentKey("RIGHT") then
				Scene.Text.Size = AlterOverflow(Scene.Text.Size, 0.01, Config.FontSize.Min-0.01, Config.FontSize.Max+0.01)
			end
		end
	},
	{
		Modifier = "Switch",
		Label = Lang("TextOutline"),
		Current = function()
			return Outlines[Scene.Text.Outline]
		end,
		Function = function()
			if CurrentKey("LEFT") then
				Scene.Text.Outline = AlterOverflow(Scene.Text.Outline, 1, 1, #Outlines, true)
			elseif CurrentKey("RIGHT") then
				Scene.Text.Outline = AlterOverflow(Scene.Text.Outline, -1, 1, #Outlines, true)
			end
		end
	},
	{
		Modifier = "Switch",
		Label = Lang("Background"),
		Current = function()
			return Config.BackgroundSprites[Scene.Background.Sprite].Name
		end,
		Desc = function()
			return Config.BackgroundSprites[Scene.Background.Sprite].Desc
		end,
		Function = function()
			if CurrentKey("LEFT") then
				Scene.Background.Sprite = AlterOverflow(Scene.Background.Sprite, -1, 1, #Config.BackgroundSprites, true)
			elseif CurrentKey("RIGHT") then
				Scene.Background.Sprite = AlterOverflow(Scene.Background.Sprite, 1, 1, #Config.BackgroundSprites, true)
			end
		end
	},
	{
		Modifier = "Switch",
		Label = Lang("BHeight"),
		Current = function()
			return Scene.Background.Settings.h
		end,
		Function = function()
			if CurrentKey("LEFT") then
				Scene.Background.Settings.h = Scene.Background.Settings.h - 0.002
			elseif CurrentKey("RIGHT") then
				Scene.Background.Settings.h = Scene.Background.Settings.h + 0.002
			end
		end
	},
	{
		Modifier = "Switch",
		Label = Lang("BWidth"),
		Current = function()
			return Scene.Background.Settings.w
		end,
		Function = function()
			if CurrentKey("LEFT") then
				Scene.Background.Settings.w = Scene.Background.Settings.w - 0.002
			elseif CurrentKey("RIGHT") then
				Scene.Background.Settings.w = Scene.Background.Settings.w + 0.002
			end
		end
	},
	{
		Modifier = "Enter",
		Label = Lang("BColour"),
		Desc = function()
			return string.format(Lang("BColourDesx"), Menu.Option3, #Config.Colours)
		end,
		Current = function()
			return Scene.Background.ColourName
		end,
		Function = function(x,y,control)
			local Col = Scene.Background.Colour
			DrawRect(x-0.008, y+0.013, 0.011, 0.02, 0, 0, 0, 150)
			DrawRect(x-0.008, y+0.013, 0.008, 0.015, Col[1], Col[2], Col[3], 255)
			if CurrentKey("LEFT") and control then
				Menu.Option3 = AlterOverflow(Menu.Option3, -1, 1, #Config.Colours, true)
				Scene.Background.Colour = Config.Colours[Menu.Option3].Colour
				Scene.Background.ColourName = Config.Colours[Menu.Option3].Name
			elseif CurrentKey("RIGHT") and control then
				Menu.Option3 = AlterOverflow(Menu.Option3, 1, 1, #Config.Colours, true)
				Scene.Background.Colour = Config.Colours[Menu.Option3].Colour
				Scene.Background.ColourName = Config.Colours[Menu.Option3].Name
			elseif IsControlJustPressed(0, GetKey("ENTER")) and control and not Scene.Info then
				CreateThread(function()
					Scene.State = "Colour"
					Scene.Background.ColourName = "Custom"
					Menu.Option3 = 1
				end)
			end
		end
	},
	{
		Modifier = "Switch",
		Label = Lang("BOpacity"),
		Current = function()
			return Scene.Background.Settings.o
		end,
		Function = function()
			if CurrentKey("LEFT", 25) then
				Scene.Background.Settings.o = AlterOverflow(Scene.Background.Settings.o, -5, 0, 255)
			elseif CurrentKey("RIGHT", 25) then
				Scene.Background.Settings.o = AlterOverflow(Scene.Background.Settings.o, 5, 0, 255)
			end
		end
	},
	{
		Modifier = "Switch",
		Label = Lang("BX"),
		Current = function()
			return Scene.Background.Settings.x
		end,
		Function = function()
			if CurrentKey("LEFT") then
				Scene.Background.Settings.x = AlterOverflow(Scene.Background.Settings.x, -0.002, -0.2, 0.2)
			elseif CurrentKey("RIGHT") then
				Scene.Background.Settings.x = AlterOverflow(Scene.Background.Settings.x, 0.002, -0.2, 0.2)
			end
		end
	},
	{
		Modifier = "Switch",
		Label = Lang("BY"),
		Current = function()
			return Scene.Background.Settings.y
		end,
		Function = function()
			if CurrentKey("LEFT") then
				Scene.Background.Settings.y = AlterOverflow(Scene.Background.Settings.y, -0.002, -0.2, 0.2)
			elseif CurrentKey("RIGHT") then
				Scene.Background.Settings.y = AlterOverflow(Scene.Background.Settings.y, 0.002, -0.2, 0.2)
			end
		end
	},
	{
		Modifier = "Switch",
		Label = Lang("BRotation"),
		Current = function()
			return Scene.Background.Settings.r
		end,
		Function = function()
			if CurrentKey("LEFT") then
				Scene.Background.Settings.r = AlterOverflow(Scene.Background.Settings.r, -10.0, 0.0, 350.0, true)
			elseif CurrentKey("RIGHT") then
				Scene.Background.Settings.r = AlterOverflow(Scene.Background.Settings.r, 10.0, 0.0, 350.0, true)
			end
		end
	},
	{
		Modifier = "Switch",
		Label = Lang("SceneLength"),
		Desc = Lang("SceneLengthDesc"),
		Current = function()
			return Scene.Hours.." "..Lang("Hours")
		end,
		Function = function(x,y,control)
			if CurrentKey("LEFT") then
				Menu.TimeOption = AlterOverflow(Menu.TimeOption, -1, 1, #Config.SceneLength, true)
				Scene.Hours = Config.SceneLength[Menu.TimeOption].Hours
			elseif CurrentKey("RIGHT") then
				Menu.TimeOption = AlterOverflow(Menu.TimeOption, 1, 1, #Config.SceneLength, true)
				Scene.Hours = Config.SceneLength[Menu.TimeOption].Hours
			end
		end
	},
	{
		Modifier = "Switch",
		Label = Lang("ShowSceneLength"),
		Desc = Lang("ShowSceneLengthDesc"),
		Current = function()
			return YesNo[Scene.ShowAge]
		end,
		Function = function()
			if CurrentKey("LEFT") then
				Scene.ShowAge = AlterOverflow(Scene.ShowAge, 1, 1, #YesNo, true)
			elseif CurrentKey("RIGHT") then
				Scene.ShowAge = AlterOverflow(Scene.ShowAge, -1, 1, #YesNo, true)
			end
		end
	},
	{
		Modifier = "Enter",
		Label = Lang("InteractFunction"),
		Desc = Lang("InteractDesc"),
		Current = function()
			if Scene.Function then
				local Cs = Scene.Function.Current
				if Scene.Function.Current == "GPS" then
					Cs = Cs.." ("..Scene.Function.String..")"
				elseif Scene.Function.Variable ~= "" then
					Cs = Cs.." ("..Scene.Function.Variable..")"
				end
				return Cs
			else
				return ""
			end
		end,
		Function = function(x,y,control)
			if IsControlJustPressed(0, GetKey("ENTER")) and control and not Scene.Info then
				CreateThread(function()
					Scene.State = "Functions"
				end)
			end
		end
	},
	{
		Modifier = "Enter",
		Label = Lang("Presets"),
		Desc = Lang("PresetsDesc"),
		Current = function()
			return ""
		end,
		Function = function(x,y,control)
			if IsControlJustPressed(0, GetKey("ENTER")) and control and not Scene.Info then
				CreateThread(function()
					Scene.State = "Presets"
				end)
			end
		end
	},
}

function DrawColourSelect()
	local Col = Scene.Background.Colour
	local Options = {"r","g","b"}
	local x = 0.70 local y = 0.687 local Offset = 0.025
	DrawSprite("dpscenes", "SlickFade", x+0.0116, y+0.0625, 0.06, 0.09, 0.0, 0, 0, 0, 170)
	DrawRect(x+0.028, y+0.063, 0.012, 0.0699, Col[1], Col[2], Col[3], 255)
	Text({Text = ">", x = x-0.006, y = y+Offset*Menu.Option2, Align = 1, Scale = 0.35, Outline = true})
	if CurrentKey("DOWN") then
		Menu.Option2 = AlterOverflow(Menu.Option2, 1, 1, #Options, true)
	elseif CurrentKey("UP") then
		Menu.Option2 = AlterOverflow(Menu.Option2, -1, 1, #Options, true)
	elseif IsControlJustPressed(0, GetKey("ENTER")) or IsControlJustPressed(0, GetKey("BACKSPACE")) then
		Scene.State = "Placing"
	end

	for k,v in pairs(Options) do
		Text({Text = string.upper(v), x = x, y = y+Offset*k, Align = 1, Scale = 0.35, Outline = true})
		if v == "r" then
			DrawRect(x+0.015, y+0.013+Offset*k, 0.01, 0.02, Col[1], 0, 0, 255)

		elseif v == "g" then
			DrawRect(x+0.015, y+0.013+Offset*k, 0.01, 0.02, 0, Col[2], 0, 255)
		elseif v == "b" then
			DrawRect(x+0.015, y+0.013+Offset*k, 0.01, 0.02, 0, 0, Col[3], 255)
		end

		if Menu.Option2 == k then
			Text({Text = tostring(Scene.Background.Colour[k]), x = x-0.013, y = y+Offset*Menu.Option2, Align = 0, Scale = 0.35, Outline = true, Center = true})
			if CurrentKey("RIGHT", 10) then
				Scene.Background.Colour[k] = AlterOverflow(Scene.Background.Colour[k], 5, 0, 255)
			elseif CurrentKey("LEFT", 10) then
				Scene.Background.Colour[k] = AlterOverflow(Scene.Background.Colour[k], -5, 0, 255)
			end
		end
	end
end

function DeletePreset(k)
	Menu.PresetOption = Menu.PresetOption-1
	Presets[k] = nil
	SavePresets()
end

function SaveSceneForPresets(s)
	local PresetSceneName = TextInput(Lang("PresetName"), "Preset-"..#Presets, 10)
	if PresetSceneName ~= "" then
		local Preset = {
			Name = PresetSceneName,
			Saved = s
		}
		table.insert(Presets, Preset)
		SavePresets()
	else
		--didnt enter name
	end
end

function DrawPresets()
	local x = 0.765 local y = 0.59 local Offset = 0.025

	local PresetMenu = {
		{
			Name = Lang("PresetSave"),
			Handler = function()
				SaveSceneForPresets(Scene)
			end
		},
	}
	for k,v in pairs(Presets) do
		local Preset = {
			Name = v.Name,
			PresetId = k,
			Description = Lang("PresetDelete"),
			Handler = function()
				Scene = v.Saved
			end
		}
		table.insert(PresetMenu, Preset)
	end

	if CurrentKey("DOWN") then
		Menu.PresetOption = AlterOverflow(Menu.PresetOption, 1, 1, #PresetMenu, true)
	elseif CurrentKey("UP") then
		Menu.PresetOption = AlterOverflow(Menu.PresetOption, -1, 1, #PresetMenu, true)
	end

	if IsControlJustPressed(0, GetKey("BACKSPACE")) then
		Scene.State = "Placing"
	end

	local Desc = false

	for k,v in pairs(PresetMenu) do
		Text({Text = v.Name, x = x-0.149, y = y+Offset*k-0.0269, Align = 1, Scale = 0.30, Outline = true})
		if Menu.PresetOption == k then
			DrawSprite("dpscenes", "SlickBar", x-0.089, y+Offset*k-0.015, 0.13, 0.023, 0.0, 0, 120, 210, 255)
			if IsControlJustPressed(0, GetKey("ENTER")) then
				v.Handler()
			elseif IsControlJustPressed(0, GetKey("DELETE")) then
				if v.PresetId then
					DeletePreset(v.PresetId)
				end
			end
			if v.Description then
				local Description = v.Description
				Text({Text = Description, x = x-0.149, y = y+Offset*(#PresetMenu+1)-0.02, Align = 1, Scale = 0.30, Outline = true, Wrap = {x = 0.0, y = 0.90}})
				DrawSprite("dpscenes", "SlickFade", x-0.089, y+Offset*(#PresetMenu+1), 0.13, 0.050, -90.0, 0, 0, 0, 140)
			end
		else
			DrawSprite("dpscenes", "SlickBar", x-0.089, y+Offset*k-0.015, 0.13, 0.023, 0.0, 0, 0, 0, 255)
		end
	end

end

function DrawFunctions()
	local x = 0.765 local y = 0.59 local Offset = 0.025

	if CurrentKey("DOWN") then
		Menu.FunctionOption = AlterOverflow(Menu.FunctionOption, 1, 1, #Config.SceneFunctions, true)
	elseif CurrentKey("UP") then
		Menu.FunctionOption = AlterOverflow(Menu.FunctionOption, -1, 1, #Config.SceneFunctions, true)
	end

	if IsControlJustPressed(0, GetKey("BACKSPACE")) then
		Scene.State = "Placing"
	end

	for k,v in pairs(Config.SceneFunctions) do
		Text({Text = v.Name, x = x-0.149, y = y+Offset*k-0.0269, Align = 1, Scale = 0.30, Outline = true})
		if Menu.FunctionOption == k then
			DrawSprite("dpscenes", "SlickBar", x-0.089, y+Offset*k-0.015, 0.13, 0.023, 0.0, 0, 120, 210, 255)
			if IsControlJustPressed(0, GetKey("ENTER")) then
				if v.Alter then
					v.Alter()
				end
			end
		else
			DrawSprite("dpscenes", "SlickBar", x-0.089, y+Offset*k-0.015, 0.13, 0.023, 0.0, 0, 0, 0, 255)
		end
	end
end

function DrawFonts()
	local x = 0.765 local y = 0.59 local Offset = 0.025

	if CurrentKey("DOWN") then
		Menu.FontOption = AlterOverflow(Menu.FontOption, 1, 1, #FontCategories, true)
	elseif CurrentKey("UP") then
		Menu.FontOption = AlterOverflow(Menu.FontOption, -1, 1, #FontCategories, true)
	end

	for k,v in pairs(FontCategories) do
		
		Text({Text = v, x = x-0.149, y = y+Offset*k-0.0269, Align = 1, Scale = 0.30, Outline = true})
		local Choice = CategorizedFonts[v][Menu[v]].Name
		if Menu.FontOption == k then Choice = "- "..Choice.." -" end
		Text({Text = Choice, x = x-0.1, y = y+Offset*k-0.0269, Align = 1, Scale = 0.30, Outline = true})
		
		if CurrentKey("RIGHT", 200) and Menu.FontOption == k then
			Menu[v] = AlterOverflow(Menu[v], 1, 1, #CategorizedFonts[v], true)
		elseif CurrentKey("LEFT", 200) and Menu.FontOption == k then
			Menu[v] = AlterOverflow(Menu[v], -1, 1, #CategorizedFonts[v], true)
		end

		if Menu.FontOption == k then
			DrawSprite("dpscenes", "SlickBar", x-0.089, y+Offset*k-0.015, 0.13, 0.023, 0.0, 0, 120, 210, 255)
			if Scene.Text.Font ~= CategorizedFonts[v][Menu[v]].Base then
				Scene.Text.Font = CategorizedFonts[v][Menu[v]].Base
			end
		else
			DrawSprite("dpscenes", "SlickBar", x-0.089, y+Offset*k-0.015, 0.13, 0.023, 0.0, 0, 0, 0, 255)
		end
	end

	if IsControlJustPressed(0, GetKey("ENTER")) or IsControlJustPressed(0, GetKey("BACKSPACE")) then
		Scene.State = "Placing"
	end
end

function DrawInfo()
	local x = 0.75 local y = 0.6725 local Offset = 0.025
	DrawSprite("dpscenes", "TallTen", x-0.04, y+0.046, 0.06, 0.31, 90.0, 0, 0, 0, 170)
	DrawSprite("dpscenes", "Information", x-0.04, y+0.03, 0.14, 0.5, 0.0, 255, 255, 255, 255)
	Text({Text = "~b~Text~n~~g~Text", x = x-0.0642, y = y+0.1625, Align = 1, Scale = 0.30, Outline = true, Font = 4})
end

function DrawMenu(control)
	local x = 0.75 local y = 0.475 local Offset = 0.025
	DrawSprite("dpscenes", "KeyE", x+0.005, y-0.005, 0.027, 0.05, 0.0, 255, 255, 255, 255)
	Text({Text = Lang("Confirm"), x = x+0.013, y = y-0.009, Align = 1, Scale = 0.30, Outline = true})
	DrawSprite("dpscenes", "KeyX", x+0.045, y-0.005, 0.027, 0.05, 0.0, 255, 255, 255, 255)
	Text({Text = Lang("Cancel"), x = x+0.053, y = y-0.009, Align = 1, Scale = 0.30, Outline = true})
	DrawSprite("dpscenes", "KeyI", x+0.085, y-0.005, 0.027, 0.05, 0.0, 255, 255, 255, 255)
	Text({Text = Lang("Help"), x = x+0.093, y = y-0.009, Align = 1, Scale = 0.30, Outline = true})

	if CurrentKey("DOWN") and control then
		Menu.Option = AlterOverflow(Menu.Option, 1, 1, #Menus, true)
	elseif CurrentKey("UP") and control then
		Menu.Option = AlterOverflow(Menu.Option, -1, 1, #Menus, true)
	end

	for k,v in pairs(Menus) do
		Text({Text = v.Label, x = x, y = y+Offset*k-0.012, Align = 1, Scale = 0.325, Outline = true})
		
		if Menu.Option == k then
			DrawSprite("dpscenes", "SlickBar", x+0.073, y+Offset*k, 0.16, 0.023, 0.0, 0, 120, 210, 255)
			if v.Function then
				v.Function(x+0.09,y+Offset*k-0.013,control)
			end
			if v.Desc then
				local Description = v.Desc
				if type(v.Desc) == "function" then
					Description = v.Desc()
				end
				Text({Text = Description, x = x-0.0025, y = y+Offset*(#Menus+1)-0.0075, Align = 1, Scale = 0.325, Outline = true, Wrap = {x = 0.0, y = 0.90}})
				DrawSprite("dpscenes", "SlickFade", x+0.073, y+Offset*(#Menus+1)+0.014, 0.16, 0.050, -90.0, 0, 0, 0, 140)
			end
		else
			DrawSprite("dpscenes", "SlickBar", x+0.073, y+Offset*k, 0.16, 0.023, 0.0, 0, 0, 0, 255)
		end
		if v.Current then
			local CurrentText = tostring(v.Current())
			if Menu.Option == k then
				local Mod = v.Modifier
				if Mod == "Enter" then
					CurrentText = CurrentText.." >>"
				elseif Mod == "Switch" then
					CurrentText = "- "..CurrentText.." -"
				end
			end

			Text({Text = CurrentText, x = x+0.09, y = y+Offset*k-0.012, Align = 1, Scale = 0.35, Outline = true})
		end
	end
end