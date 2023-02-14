Blip = function(coords, sprite, colour, text, scale)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, scale)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
end

AddEventHandler('alx_joblisting:selectjob', function(data)
    local data = data
    local alert = lib.alertDialog({
        header = Language.dialog.header,
        content = Language.dialog.content,
        centered = true,
        cancel = true
    })
    if alert == "confirm" then
        lib.notify({
            title = Language.notify.title,
            description = Language.notify.accept_job,
        })
        local done = lib.callback.await('alx_joblisting:selectjob', 100, data)
    elseif alert == "cancel" then
        lib.notify({
            title = Language.notify.title,
            description = Language.notify.decline_job,
        })
    end
end)

AddEventHandler('alx_joblisting:interact', function(data)
    local storeData = data.store
    local jobs = storeData.jobs
    local Options = {}
    for i=1, #jobs do
        table.insert(Options, {
            title = jobs[i].label,
            description = jobs[i].description,
            event = 'alx_joblisting:selectjob',
            args = { job = jobs[i].job, job_grade = jobs[i].job_grade }
        })
    end
    lib.registerContext({
        id = 'JobListInteract',
        title = storeData.label,
        options = Options
    })
    lib.showContext('JobListInteract')
end)

CreateThread(function()
    for i=1, #Config.Job do
        exports.qtarget:AddBoxZone(i.."", Config.Job[i].coords, 1.0, 1.0, {
            name=i.."",
            heading=Config.Job[i].blip.heading,
            debugPoly=false,
            minZ=Config.Job[i].coords.z-1.5,
            maxZ=Config.Job[i].coords.z+1.5
        }, {
            options = {
                {
                    event = 'alx_joblisting:interact',
                    label = Language.target.label,
                    store = Config.Job[i]
                }
            },
            job = 'all',
            distance = 1.5
        })
        if Config.Job[i].blip.enabled then
            Blip(Config.Job[i].coords, Config.Job[i].blip.sprite, Config.Job[i].blip.color, Config.Job[i].label, Config.Job[i].blip.scale)
        end
    end
end)

local pedSpawned = {}
local pedPool = {}
CreateThread(function()
	while true do
		local sleep = 1500
        local playerPed = cache.ped
        local pos = GetEntityCoords(playerPed)
		for i=1, #Config.Job do
			local dist = #(pos - Config.Job[i].coords)
			if dist <= 20 and not pedSpawned[i] then
				pedSpawned[i] = true
                lib.requestModel(Config.Job[i].ped, 100)
                lib.requestAnimDict('mini@strip_club@idles@bouncer@base', 100)
				pedPool[i] = CreatePed(28, Config.Job[i].ped, Config.Job[i].coords.x, Config.Job[i].coords.y, Config.Job[i].coords.z, Config.Job[i].heading, false, false)
				FreezeEntityPosition(pedPool[i], true)
				SetEntityInvincible(pedPool[i], true)
				SetBlockingOfNonTemporaryEvents(pedPool[i], true)
				TaskPlayAnim(pedPool[i], 'mini@strip_club@idles@bouncer@base','base', 8.0, 0.0, -1, 1, 0, 0, 0, 0)
			elseif dist >= 21 and pedSpawned[i] then
				local model = GetEntityModel(pedPool[i])
				SetModelAsNoLongerNeeded(model)
				DeletePed(pedPool[i])
				SetPedAsNoLongerNeeded(pedPool[i])
                pedPool[i] = nil
				pedSpawned[i] = false
			end
		end
		Wait(sleep)
	end
end)