local ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('luks_ura:getStatus', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then
        return cb(nil)
    end

    local cash = xPlayer.getMoney() or 0
    local bank = 0
    local bankAccount = xPlayer.getAccount('bank')
    if bankAccount then bank = bankAccount.money or 0 end
    local jobLabel = "N/A"
    local rankLabel = "N/A"

    if xPlayer.job then
        if xPlayer.job.label then
            jobLabel = xPlayer.job.label
        end
        if xPlayer.job.grade_label and xPlayer.job.grade_label ~= "" then
            rankLabel = xPlayer.job.grade_label    
        elseif xPlayer.job.grade_name and xPlayer.job.grade_name ~= "" then
            rankLabel = xPlayer.job.grade_name:gsub("^%l", string.upper)
        end
    end

    cb({
        cash = cash,
        bank = bank,
        job = jobLabel,
        rank = rankLabel,
        id  = source
    })
end)
