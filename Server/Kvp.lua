local Limit = 3000

if Config.Database == "KVP" then

	log("^3You can ignore the error above since you're not using SQL.^7")
	DB.Timecheck = function()
		local Today = os.time()
		local Count = 0
		for k,v in pairs(Scenes.Current) do
			local Expired = v.Created + 3600*v.Hours
			if Expired < Today then
				DeleteResourceKvp("dpscene"..k)
				Scenes.Current[k] = nil
				Count = Count +1
			end
		end
		if Count > 0 then log("Deleted "..Count.." expired scenes.") end
		TriggerClientEvent("Scene:RecieveAll", -1, Scenes.Current)
	end

	DB.NewScene = function(scene, Src, Id, CreationTime, NewScene)
		local This = #Scenes.Current+1
		if This < Limit then
			local k = {Owner = Id, Hours = scene.Hours, Created = CreationTime, Data = NewScene }
			scene["Created"] = CreationTime scene["Owner"] = Id
			SetResourceKvp("dpscene"..This, json.encode(k))
			Scenes.Current[This] = scene
			TriggerClientEvent("Scene:Recieve", -1, scene, This)
		else
			Chat(Src, "The servers scene limit appears to have been reached, this is bad!")
		end
	end

	DB.GrabAll = function()
		for i = 1, Limit do
			local Scene = GetResourceKvpString("dpscene"..i)
			if Scene then
				local SceneTable = json.decode(Scene)
				local NewScene = json.decode(SceneTable.Data)
				local Old = NewScene.Location
				NewScene["Created"] = SceneTable.Created
				NewScene["Owner"] = SceneTable.Owner
				NewScene["Hours"] = SceneTable.Hours
				NewScene.Location = vec(Old.x, Old.y, Old.z)
				Scenes.Current[i] = NewScene
			end
		end
		TriggerClientEvent("Scene:RecieveAll", -1, Scenes.Current)
	end

	DB.RemoveScene = function(id)
		DeleteResourceKvp("dpscene"..id)
		Scenes.Current[id] = nil
		TriggerClientEvent("Scene:RecieveAll", -1, Scenes.Current)
	end

end