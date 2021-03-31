ESX = nil
local isInVehicle = false
local hasShownMessage = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(Config.MarkerZones) do
        	local ped = PlayerPedId()
			local src = source
            local pedcoords = GetEntityCoords(ped, false)
            local distance = Vdist(pedcoords.x, pedcoords.y, pedcoords.z, Config.MarkerZones[k].x, Config.MarkerZones[k].y, Config.MarkerZones[k].z)
            if distance <= 1.20 then
				DrawText3D(Config.MarkerZones[k].x, Config.MarkerZones[k].y, Config.MarkerZones[k].z + 0.2, "[E] - Deneme Trigger'i")
				DrawMarker(2, Config.MarkerZones[k].x, Config.MarkerZones[k].y, Config.MarkerZones[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.4, 0, 150, 150, 100, 0, 0, 0, 0)	
				if IsControlJustPressed(0, 46) and IsPedOnFoot(ped) then
					TriggerEvent('disc-death:revive', src) -- 1 nci örnek Disc-Ambulancejob
					TriggerEvent('esx_ambulancejob:revive', src) --2 nci örnek esx_ambulancejob Kullananlar Icin.
				end 
			elseif distance < 1.45 then
				ESX.UI.Menu.CloseAll()
            end
		end
    end
end)




function DrawText3D(x,y,z, text)
    local onScreen, _x, _y = World3dToScreen2d(x,y,z)
    if onScreen then
        local factor = #text / 420
        SetTextScale(0.30, 0.30)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry('STRING')
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
       DrawRect(_x, _y + 0.0120, 0.006 + factor, 0.024, 0, 0, 0, 155)
    end
end