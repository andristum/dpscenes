Config = {
	Language = "en",
	-- steam/discord, whatever.
	IdentifierType = "steam",
	--[[
		You can either choose SQL or KVP.
		SQL is pretty usual, but KVP does not require mysql-async.
		If you choose SQL you have to import the sql provided, KVP does not require any extra work.
	]]--
	Database = "KVP",
	-- Max scenes a player is allowed to have on their own.
	MaxScenes = 20,
	FontSize = {
		Min = 0.25,
		Max = 0.65
	},
	-- Amount of hours a scene is allowed to be up for.
	SceneLength = {
		{Hours = 1},
		{Hours = 6},
		{Hours = 12},
		{Hours = 24},
		{Hours = 48},
		{Hours = 72},
	},
	MaxSceneLength = 72, -- For validation upon creating a scene, incase someone has a preset saved with Hours = 128 or something.
	--[[ 
		Blacklist works like this:
		If the function returns true then it displays the error text.
		And makes it so the player cant place their scene.
		Very useful for blocking placing in an area.
		I also check if they are placing on a vehicle or a ped to help reduce floating scenes.
		To add an area simply copy the already provided one and just replace the coords and range.
	]]--
	Blacklist = {
		{
			Error = "~r~Cant place scene on vehicle.",
			Function = function(i)
				if IsEntityAVehicle(i.Entity) then
					return true
				end
			end
		},
		{
			Error = "~r~Cant place scene on pedestrian.",
			Function = function(i)
				if IsEntityAPed(i.Entity) then
					return true
				end
			end
		},
		{
			Error = "~r~Cant place scene in this area.",
			Function = function(i)
				local Area = vec(-1559.31, -2712.37, 13.95)
				local Range = 10
				if Distance(Area, i.Coords) < Range then
					return true
				end
			end
		},
	},
	--[[ 
		Scene Functions are functions users can choose to put on their scenes.
		They are triggered by going up to the active scene and pressing E.
		I've added these 2 basic functions that people can use.
	]]--
	SceneFunctions = {
		{
			Name = "None",
			Alter = function(e)
				Scene.Function = false
			end 
		},
		{
			Name = "Emote",
			Prefix = "/e",
			Alter = function()
				local Arg = ""
				if Scene.Function then
					Arg = Scene.Function.Variable
					if Scene.Function.Current ~= "Emote" then
						Arg = ""
					end
				end
				local New = TextInput("What emote do you want the scene to trigger?", Arg, 12)
				if New ~= "" then
					Scene.Function = {
						Current = "Emote",
						Prefix = "e",
						Variable = New,
					}
					Scene.State = "Placing"
				end
			end
		},
		{
			Name = "Me",
			Prefix = "/me",
			Alter = function()
				local Arg = ""
				if Scene.Function then
					Arg = Scene.Function.Variable
					if Scene.Function.Current ~= "Me" then
						Arg = ""
					end
				end
				local New = TextInput("What action do you want the scene to trigger?", Arg, 90)
				if New ~= "" then
					Scene.Function = {
						Current = "Me",
						Prefix = "me",
						Variable = New,
					}
					Scene.State = "Placing"
				end
			end
		},
		{
			Name = "GPS",
			Function = function(c)
				SetNewWaypoint(c.x, c.y)
			end,
			Alter = function()
				if IsWaypointActive() then
					local blip = GetFirstBlipInfoId(8)
    				local coord = false
    				if (blip ~= 0) then
    				    coord = GetBlipCoords(blip)
    				    Scene.Function = {
							Current = "GPS",
							Prefix = false,
							Description = "Set your waypoint to %s?",
							Variable = coord,
							String = GetStreetNameFromHashKey(GetStreetNameAtCoord(coord.x, coord.y, coord.z)),
						}
    				else
    					Chat("Error getting waypoint")
    				end
				else
					Chat("You have to have a waypoint active.")
				end
			end
		},
	},
	Colours = {
		{Name = "Black", Colour = { 0, 0, 0}},
		{Name = "Gray", Colour = {128, 128, 128}},
		{Name = "Light Grey", Colour = {211, 211, 211}},
		{Name = "White", Colour = {255, 255, 255}},
		{Name = "Alice Blue", Colour = {240, 248, 255}},
		{Name = "Antique White", Colour = {250, 235, 215}},
		{Name = "Aqua", Colour = { 0, 255, 255}},
		{Name = "Aquamarine", Colour = {127, 255, 212}},
		{Name = "Azure", Colour = {240, 255, 255}},
		{Name = "Beige", Colour = {245, 245, 220}},
		{Name = "Bisque", Colour = {255, 228, 196}},
		{Name = "Blue", Colour = { 0, 0, 255}},
		{Name = "Blue Violet", Colour = {138, 43, 226}},
		{Name = "Brown", Colour = {165, 42, 42}},
		{Name = "Burly Wood", Colour = {222, 184, 135}},
		{Name = "Cadet Blue", Colour = { 95, 158, 160}},
		{Name = "Chartreuse", Colour = {127, 255, 0}},
		{Name = "Chocolate", Colour = {210, 105, 30}},
		{Name = "Coral", Colour = {255, 127, 80}},
		{Name = "Cornflower Blue", Colour = {100, 149, 237}},
		{Name = "Crimson", Colour = {220, 20, 60}},
		{Name = "Cyan", Colour = { 0, 255, 255}},
		{Name = "Dark Blue", Colour = { 0, 0, 139}},
		{Name = "Dark Cyan", Colour = { 0, 139, 139}},
		{Name = "Dark Goldenrod", Colour = {184, 134, 11}},
		{Name = "Dark Gray", Colour = {169, 169, 169}},
		{Name = "Dark Green", Colour = { 0, 100, 0}},
		{Name = "Dark Grey", Colour = {169, 169, 169}},
		{Name = "Dark Khaki", Colour = {189, 183, 107}},
		{Name = "Dark Magenta", Colour = {139, 0, 139}},
		{Name = "Dark Olive Green", Colour = { 85, 107, 47}},
		{Name = "Dark Orange", Colour = {255, 140, 0}},
		{Name = "Dark Orchid", Colour = {153, 50, 204}},
		{Name = "Dark Red", Colour = {139, 0, 0}},
		{Name = "Dark Salmon", Colour = {233, 150, 122}},
		{Name = "Dark Seagreen", Colour = {143, 188, 143}},
		{Name = "Dark Slateblue", Colour = { 72, 61, 139}},
		{Name = "Dark Slategray", Colour = { 47, 79, 79}},
		{Name = "Dark Slategrey", Colour = { 47, 79, 79}},
		{Name = "Dark Turquoise", Colour = { 0, 206, 209}},
		{Name = "Dark Violet", Colour = {148, 0, 211}},
		{Name = "Deep Pink", Colour = {255, 20, 147}},
		{Name = "Deep Sky Blue", Colour = { 0, 191, 255}},
		{Name = "Dim Gray", Colour = {105, 105, 105}},
		{Name = "Dodger Blue", Colour = { 30, 144, 255}},
		{Name = "Fire Brick", Colour = {178, 34, 34}},
		{Name = "Forest Green", Colour = { 34, 139, 34}},
		{Name = "Fuchsia", Colour = {255, 0, 255}},
		{Name = "Gainsboro", Colour = {220, 220, 220}},
		{Name = "Gold", Colour = {255, 215, 0}},
		{Name = "Goldenrod", Colour = {218, 165, 32}},
		{Name = "Green", Colour = { 0, 128, 0}},
		{Name = "Green Yellow", Colour = {173, 255, 47}},
		{Name = "Honeydew", Colour = {240, 255, 240}},
		{Name = "Hot Pink", Colour = {255, 105, 180}},
		{Name = "Indian Red", Colour = {205, 92, 92}},
		{Name = "Indigo", Colour = { 75, 0, 130}},
		{Name = "Ivory", Colour = {255, 255, 240}},
		{Name = "Khaki", Colour = {240, 230, 140}},
		{Name = "Lawn Green", Colour = {124, 252, 0}},
		{Name = "Light Blue", Colour = {173, 216, 230}},
		{Name = "Light Coral", Colour = {240, 128, 128}},
		{Name = "Light Cyan", Colour = {224, 255, 255}},
		{Name = "Light Gray", Colour = {211, 211, 211}},
		{Name = "Light Green", Colour = {144, 238, 144}},
		{Name = "Light Pink", Colour = {255, 182, 193}},
		{Name = "Light Salmon", Colour = {255, 160, 122}},
		{Name = "Light Sea Green", Colour = { 32, 178, 170}},
		{Name = "Light Sky Blue", Colour = {135, 206, 250}},
		{Name = "Light Steel Blue", Colour = {176, 196, 222}},
		{Name = "Light Yellow", Colour = {255, 255, 224}},
		{Name = "Lime", Colour = { 0, 255, 0}},
		{Name = "Lime Green", Colour = { 50, 205, 50}},
		{Name = "Magenta", Colour = {255, 0, 255}},
		{Name = "Maroon", Colour = {128, 0, 0}},
		{Name = "Medium Aquamarine", Colour = {102, 205, 170}},
		{Name = "Medium Blue", Colour = { 0, 0, 205}},
		{Name = "Medium Orchid", Colour = {186, 85, 211}},
		{Name = "Medium Purple", Colour = {147, 112, 219}},
		{Name = "Medium Sea Green", Colour = { 60, 179, 113}},
		{Name = "Medium Slate Blue", Colour = {123, 104, 238}},
		{Name = "Medium Spring Green", Colour = { 0, 250, 154}},
		{Name = "Medium Turquoise", Colour = { 72, 209, 204}},
		{Name = "Medium Violet Red", Colour = {199, 21, 133}},
		{Name = "Midnight Blue", Colour = { 25, 25, 112}},
		{Name = "Navy", Colour = { 0, 0, 128}},
		{Name = "Olive", Colour = {128, 128, 0}},
		{Name = "Orange", Colour = {255, 165, 0}},
		{Name = "Orange Red", Colour = {255, 69, 0}},
		{Name = "Orchid", Colour = {218, 112, 214}},
		{Name = "Pale Green", Colour = {152, 251, 152}},
		{Name = "Pale Turquoise", Colour = {175, 238, 238}},
		{Name = "Pale Violet Red", Colour = {219, 112, 147}},
		{Name = "Peru", Colour = {205, 133, 63}},
		{Name = "Pink", Colour = {255, 192, 203}},
		{Name = "Plum", Colour = {221, 160, 221}},
		{Name = "Powder Blue", Colour = {176, 224, 230}},
		{Name = "Purple", Colour = {128, 0, 128}},
		{Name = "Red", Colour = {255, 0, 0}},
		{Name = "Royal Blue", Colour = { 65, 105, 225}},
		{Name = "Saddle Brown", Colour = {139, 69, 19}},
		{Name = "Salmon", Colour = {250, 128, 114}},
		{Name = "Sandy Brown", Colour = {244, 164, 96}},
		{Name = "Sea Green", Colour = { 46, 139, 87}},
		{Name = "Silver", Colour = {192, 192, 192}},
		{Name = "Sky Blue", Colour = {135, 206, 235}},
		{Name = "Slate Blue", Colour = {106, 90, 205}},
		{Name = "Slate Gray", Colour = {112, 128, 144}},
		{Name = "Spring Green", Colour = { 0, 255, 127}},
		{Name = "Steel Blue", Colour = { 70, 130, 180}},
		{Name = "Tan", Colour = {210, 180, 140}},
		{Name = "Teal", Colour = { 0, 128, 128}},
		{Name = "Tomato", Colour = {255, 99, 71}},
		{Name = "Turquoise", Colour = { 64, 224, 208}},
		{Name = "Violet", Colour = {238, 130, 238}},
		{Name = "Yellow", Colour = {255, 255, 0}}
	},
	BackgroundSprites = {
		{Name = "Sleek", Sprite = "TallFive", Desc = "Tall and sleek. (5px)"},
		{Name = "Sleek 2", Sprite = "TallTen", Desc = "Tall and sleek. (10px)"},
		{Name = "Sleek 3", Sprite = "TallFifteen", Desc = "Tall and sleek. (15px)"},
		{Name = "Simple", Sprite = "Background", Desc = "As simple as it gets."},
		{Name = "Blood", Sprite = "Blood", Desc = "Bloody mess."},
		{Name = "Blood 2", Sprite = "Blood2", Desc = "Bloody mess."},
		{Name = "Blood 3", Sprite = "Blood3", Desc = "Bloody mess."},
		{Name = "Blood 4", Sprite = "Blood4", Desc = "Bloody mess."},
		{Name = "Blood 5", Sprite = "Blood5", Desc = "Bloody mess."},
		{Name = "Brush", Sprite = "Brush", Desc = "A simple brush stroke."},
		{Name = "Chain", Sprite = "Chain", Desc = '"Never break the chain"'},
		{Name = "Metal", Sprite = "Metal", Desc = "Not to be confused with rock."},
		{Name = "Metal 2", Sprite = "Metal2", Desc = "Not to be confused with rock."},
		{Name = "Gradient", Sprite = "Gradient1", Desc = "A little bit of gradient in my life."},
		{Name = "Gradient 2", Sprite = "Gradient2", Desc = "A little bit of gradient by my side."},
		{Name = "Gradient 3", Sprite = "Gradient3", Desc = "A little bit of gradient is all i need."},
		{Name = "Gradient 4", Sprite = "Gradient4", Desc = "A little bit of gradient is what i see."},
		{Name = "Noise", Sprite = "Noise", Desc = "Too loud."},
		{Name = "Note", Sprite = "Note", Desc = "Colour white recommended."},
		{Name = "Note 2", Sprite = "Note2", Desc = "Colour white recommended."},
		{Name = "Note 3", Sprite = "Note3", Desc = "Colour white recommended."},
		{Name = "Note 4", Sprite = "Note4", Desc = "Colour white recommended."},
		{Name = "Note 5", Sprite = "Note5", Desc = "Colour white recommended."},
		{Name = "Note 6", Sprite = "Note6", Desc = "Colour white recommended."},
		{Name = "Spray", Sprite = "Spray", Desc = "Just a spray."},
	}
}

