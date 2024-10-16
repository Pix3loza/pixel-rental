local options = {}

Citizen.CreateThread(function ()
    local Ped = Config['CarRental']
    for i=1 , #Ped, 1 do

        while not HasModelLoaded(GetHashKey(Ped[i].model)) do
            Wait(100)
            RequestModel(GetHashKey(Ped[i].model))
        end

        local ped = CreatePed(4, Ped[i].model, Ped[i].coords, false, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)

        exports.ox_target:addBoxZone({
            name = "megaas",
            coords = vec3(Ped[i].coords.x, Ped[i].coords.y, Ped[i].coords.z + 1),
            size = vec3(1, 1, 2.25),
            rotation = 337.75,
            options = {
                {
                    name = 'pixel-rental',
                    icon = 'fa-solid fa-car',
                    label = 'Otwórz Liste Pojazdów',
                    onSelect = function ()
                        OpenContext(i)
                    end
                },
            },
            distance = 1.5,
        })
    end
end)

function OpenContext(n)
    local cfg = Config['CarRental']
    local veh = cfg[n].veh
    local Parking = cfg[n].parking
    
    options = {}

    for i = 1, #veh do
        table.insert(options, {
            title = veh[i].CarName,
            description = veh[i].desc,
            icon = 'car',
            onSelect = function()
                local availableSpot = nil
                for parkings = 1, #Parking do
                    local spot = Parking[parkings]
                    local vehicle = GetClosestVehicle(spot.x, spot.y, spot.z, 1.0, 0, 70)
                    if not DoesEntityExist(vehicle) then
                        availableSpot = spot
                        break
                    end
                end

                if availableSpot then
                    SpawnVeh(veh[i].price, veh[i].model, availableSpot)
                else
                    ESX.ShowNotification("Brak dostępnych miejsc parkingowych")
                end
            end,
        })
    end

    lib.registerContext({
        id = 'rentCar',
        title = 'Car Rental',
        options = options
    })

    lib.showContext('rentCar')
end


function SpawnVeh(price, model, coords)
    local Number = math.random(1, 999)
    local plate = 'RENT' .. Number

    ESX.TriggerServerCallback('pixel-rental:removeMoney', function(cb)
        if cb then
            local CarModel = model
            RequestModel(CarModel)
            while not HasModelLoaded(CarModel) do 
                Wait(100)
            end
            local Vehicle = CreateVehicle(CarModel, coords.x, coords.y, coords.z, coords.w, true, false)
            SetVehicleNumberPlateText(Vehicle, plate)
            TriggerServerEvent('pixel-rental:Documents', plate)
        end
    end, price, plate)
end

Citizen.CreateThread(function ()
    exports.ox_inventory:displayMetadata({
        plateRent = 'Rejestracja pojazdu',
        dateRent = 'Data Wynajmu',
        nameRent = 'Wynajmujący'
    })
end)

