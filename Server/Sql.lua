if Config.Database == "SQL" then

	DB.Timecheck = function()
		local Today = os.time()
		local Count = 0
		for k,v in pairs(Scenes.Current) do
			local Expired = v.Created + 3600*v.Hours
			if Expired < Today then
				MySQL.Async.execute("DELETE FROM scenes WHERE id = @id", { ['@id'] = k }, function()
					Scenes.Current[k] = nil
					TriggerClientEvent("Scene:Delete", -1, k)
				end)
				Count = Count +1
			end
		end
		if Count > 0 then
			log("Deleted "..Count.." expired scenes.")
		end
	end

	DB.NewScene = function(scene, Src, Id, CreationTime, NewScene)
		MySQL.Async.insert('INSERT INTO scenes (`data`, `owner`, `created`, `hours`) VALUES (@data, @owner, @created, @hours);',
			{data = NewScene, owner = Id, created = CreationTime, hours = scene.Hours},
		function(databaseid)
			scene["Created"] = CreationTime
			scene["Hours"] = scene.Hours
			scene["Owner"] = Id
			Scenes.Current[databaseid] = scene
			TriggerClientEvent("Scene:Recieve", -1, scene, databaseid)
		end)
	end

	DB.GrabAll = function()
		MySQL.Async.fetchAll("SELECT * FROM `scenes`", {}, function(result)
			for k,v in pairs(result) do
				local NewScene = json.decode(v.data)
				NewScene["Created"] = v.created
				NewScene["Owner"] = v.owner
				NewScene["Hours"] = v.hours
				local Old = NewScene.Location
				NewScene.Location = vector3(Old.x, Old.y, Old.z)
				Scenes.Current[v.id] = NewScene
			end
			TriggerClientEvent("Scene:RecieveAll", -1, Scenes.Current)
		end)
	end

	DB.RemoveScene = function(id)
		MySQL.Async.execute("DELETE FROM scenes WHERE id = @id", {['@id'] = id}, function()
			Scenes.Current[id] = nil
			TriggerClientEvent("Scene:Delete", -1, id)
		end)
	end

end



