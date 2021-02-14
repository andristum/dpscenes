DB = {}

function PrepareSceneForDatabase(i)
	-- Here we just clear some of the data thats not needed but other players.
	local s = i; s.State = nil s.Info = nil s.Background.Colour.ColourName = nil
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
AddEventHandler("Scene:AttemptDelete", function(Id)
	local Src = source
	local Me = GetLicense(Src, Config.IdentifierType)
	local ScenesOwner = Scenes.Current[Id].Owner
	local Override = CanDeleteAnyScene(Me)
	if Me == ScenesOwner or Override then
		DB.RemoveScene(Id)
		Chat(Src, Lang("RemovedScene"))
	else
		Chat(Src, Lang("NoPerms"))
	end
end)