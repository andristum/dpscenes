PlayerData = "User"

CreateThread(function() 
    PlayerData = "User"
    if PlayerData then
        UpdatePresetsFromData(PlayerData)
    end
end)

function UpdatePresetsFromData(Data)
    local Key = "Scenes_Presets_"..Data
    local KVPPresets = GetResourceKvpString(Key)
    if KVPPresets == nil then
    	Presets = {}
    	SetResourceKvp(Key, json.encode(Presets))
    else
    	Presets = json.decode(KVPPresets)
    end
end

function SavePresets()
	local Key = "Scenes_Presets_"..PlayerData
	SetResourceKvp(Key, json.encode(Presets))
	Presets = Presets
end

RegisterCommand("sceneresetpresets", function()
	Presets = {}
	SavePresets()
end)