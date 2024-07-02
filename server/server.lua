ESX.RegisterServerCallback('ls-rentcar:removeMoney', function(source, cb, countmoney)
    local xPlayer = ESX.GetPlayerFromId(source)
    local getMoney = xPlayer.getInventoryItem('money')
    if getMoney.count >= countmoney then
        xPlayer.removeInventoryItem('money', countmoney)
        TriggerClientEvent('esx:showNotification', source, 'Pomyślnie Opłaciłeś Wynajem Pojazdu')
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

RegisterServerEvent('ls-rentcar:Documents')
AddEventHandler('ls-rentcar:Documents', function(plate)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local date = os.date("%x | %X")
    local Customer = xPlayer.getName()
    exports.ox_inventory:AddItem(xPlayer.source, 'rentcar_paper', 1, {plateRent = plate, dateRent = date, nameRent= Customer})
end)