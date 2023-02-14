if Config.Framework == 'esx' then
    ESX = exports["es_extended"]:getSharedObject()
elseif Config.Framework == 'qb' then
    QBCore = exports['qb-core']:GetCoreObject()
end

if Config.Framework == 'esx' then
    lib.callback.register('alx_joblisting:selectjob', function(source, data)
        local xPlayer = ESX.GetPlayerFromId(source)
        local xJob = xPlayer.setJob(data.job, data.job_grade)
    end)
elseif Config.Framework == 'qb' then
    lib.callback.register('alx_joblisting:selectjob', function(source, data)
        local xPlayer = QBCore.Functions.GetPlayer(source)
        local xJob = xPlayer.Functions.SetJob(data.job, data.job_grade)
    end)
end