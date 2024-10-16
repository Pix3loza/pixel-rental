ESX.RegisterServerCallback('pixel-rental:removeMoney', function(source, cb, countmoney, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local getMoney = xPlayer.getInventoryItem('money')
    if getMoney.count >= countmoney then
        xPlayer.removeInventoryItem('money', countmoney)
        TriggerClientEvent('esx:showNotification', source, 'Pomyślnie Opłaciłeś Wynajem Pojazdu')
        exports.ox_inventory:AddItem(source, "carkey", 1, plate)
        cb(true)
    else
        if getMoney.count >= 1 then
            TriggerClientEvent('esx:showNotification', source, 'Nie Posiadasz Wystraczająco gotówki, brakuje ci '..countmoney - getMoney.count..'$') 
        else 
            TriggerClientEvent('esx:showNotification', source, 'Nie Posiadasz gotówki, potrzebujesz '..countmoney..'$') 
        end
        cb(false)
    end
end)

RegisterServerEvent('pixel-rental:Documents')
AddEventHandler('pixel-rental:Documents', function(plate)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local date = os.date("%x | %X")
    local Customer = xPlayer.getName()
    exports.ox_inventory:AddItem(xPlayer.source, 'rentcar_paper', 1, {plateRent = plate, dateRent = date, nameRent= Customer})
end)