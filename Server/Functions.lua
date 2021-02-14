Locale = {}
function Lang(what)
	local Dict = Locale[Config.Language]
	if not Dict[what] then return Locale["en"][what] end -- If we cant find a translation, use the english one.
	return Dict[what]
end

function log(what)
	if type(what) == "table" then
		print(json.encode(what))
	else
		print(tostring(what).." | "..type(what))
	end
end

function Chat(source, Msg)
	TriggerClientEvent("chatMessage", source, "^4Scenes^7", {255,255,255}, Msg)
end

function Distance(first, second)
	local distance = #(first - second)
	return distance
end

function GetLicense(s, t)
	for k,v in ipairs(GetPlayerIdentifiers(s)) do
		if string.sub(v, 1, string.len(t)) == string.lower(t) then
			return v
		end
	end
	return false
end