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
                    name = 'ls-rentcar',
                    icon = 'fa-solid fa-car',
                    label = 'Otwórz Liste Pojazdów',
                    onSelect = function ()
                        OpenContext()
                    end
                },
            },
            distance = 1.5,
        })
    end
end)

function OpenContext()
    local Rentals = Config['CarRental']
    local options = {}

    for i = 1, #Rentals do
        local vehicles = Rentals[i].veh
        local Parking = Rentals[i].parking

        for car = 1, #vehicles do
            table.insert(options, {
                title = vehicles[car].CarName,
                description = vehicles[car].desc,
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
                        SpawnVeh(vehicles[car].price, vehicles[car].model, availableSpot)
                    else
                        ESX.ShowNotification("Brak dostępnych miejsc parkingowych")
                    end
                end,
            })
        end
    end

    lib.registerContext({
        id = 'rentCar',
        title = 'Car Rental',
        options = options
    })

    lib.showContext('rentCar')
end

function SpawnVeh(price, model, coords)
    ESX.TriggerServerCallback('ls-rentcar:removeMoney', function(cb)
        if cb then
            local CarModel = model
            RequestModel(CarModel)
            while not HasModelLoaded(CarModel) do 
                Wait(100)
            end
            local Number = math.random(1, 999)
            local Vehicle = CreateVehicle(CarModel, coords.x, coords.y, coords.z, coords.w, true, false)
            local plate = 'Rent' .. Number
            SetVehicleNumberPlateText(Vehicle, plate)
            TriggerServerEvent('ls-rentcar:Documents', plate)
        end
    end, price)
end

Citizen.CreateThread(function ()
    exports.ox_inventory:displayMetadata({
        plateRent = 'Rejestracja pojazdu',
        dateRent = 'Data Wynajmu',
        nameRent = 'Wynajmujący'
    })
end)

