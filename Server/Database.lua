DB = {}

function PrepareSceneForDatabase(i)
	-- Here we just clear some of the data thats not needed but other players.
	local s = i; s.State = nil s.Info = nil s.Background.ColourName = nil
	if s.Hours > Config.MaxSceneLength then s.Hours = Config.MaxSceneLength end
	return json.encode(s)
end

function CanDeleteAnyScene(Identifier)
	for k,v in pairs(Admins) do
		if v == Identifier then
			return true
		end
	end
	return false
end

RegisterNetEvent("Scene:New")
AddEventHandler("Scene:New", function(New)
	local Src = source
	local Id = GetLicense(Src, Config.IdentifierType)
	local Count = CountScenes(Id)
	if Count < Config.MaxScenes then
		if not CloseToOtherScene(New) then
			local NewScene = PrepareSceneForDatabase(New)
			local CreationTime = os.time()
			DB.NewScene(New, Src, Id, CreationTime, NewScene)
			TriggerClientEvent("Scene:Reset", Src)
		else
			Chat(Src, Lang("TooClose"))
		end
	else
		Chat(Src, string.format(Lang("TooMany"), Count))
	end
end)

RegisterNetEvent("Scene:AttemptDelete")
AddEventHandler("Scene:AttemptDelete", function(Id, Move)
	local Src = source
	local Me = GetLicense(Src, Config.IdentifierType)
	local SceneToDelete = Scenes.Current[Id]
	local Override = CanDeleteAnyScene(Me)
	if not Move then
		if Me == SceneToDelete.Owner or Override then
			DB.RemoveScene(Id)
			Chat(Src, Lang("RemovedScene"))
		else
			Chat(Src, Lang("NoPerms"))
		end
	else
		DB.RemoveScene(Id)
	end
end)

RegisterNetEvent("Scene:AttemptCopy")
AddEventHandler("Scene:AttemptCopy", function(Id)
	local Src = source
	local Me = GetLicense(Src, Config.IdentifierType)
	local SceneToCopy = Scenes.Current[Id]
	--local Override = CanDeleteAnyScene(Me)
	if Me == SceneToCopy.Owner then
		TriggerClientEvent("Scene:RecieveCopy", Src, SceneToCopy)
	else
		Chat(Src, Lang("OnlyCopyOwn"))
	end
end)