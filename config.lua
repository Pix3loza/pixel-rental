Config = {}

Config['CarRental'] = {
    {
        model = 'g_m_m_armboss_01',
        coords = vector4(117.6158, -1048.8928, 28.2052, 156.2062),
        veh = {
            {model = 'sultan', price = 500, desc = 'Kwota Wynajmu Sultana To 500$', CarName = 'Sultan'},
            {model = 'sentinel', price = 500, desc = 'Kwota Wynajmu sentinela To 500$', CarName = 'sentinel'},
            {model = 'felon', price = 500, desc = 'Kwota Wynajmu felona To 500$', CarName = 'felon'}
        },
        parking = {
            vector4(105.5631, -1063.2297, 28.9928, 242.7834),
            vector4(107.4711, -1059.8142, 29.1927, 246.9820),
            vector4(108.9850, -1056.4426, 29.1927, 243.8829),
            vector4(110.4811, -1052.8763, 29.2032, 252.8613),
            vector4(112.1965, -1049.8881, 29.2127, 252.1519)
        }
    },
    { -- Template For more rentals 
        model = 'g_m_m_armboss_01', -- https://docs.fivem.net/docs/game-references/ped-models/
        coords = vector4(1529.9207, 3778.3850, 34.5114, 211.0399), -- Spawn Ped & target
        veh = {
             {model = 'sultan', price = 500, desc = 'Kwota Wynajmu Sultana To 500$', CarName = 'Sultan'},
             {model = 'felon', price = 500, desc = 'Kwota Wynajmu felona To 500$', CarName = 'Felon'}
        },
        parking = { -- car spawn location,  if all spots are filled it will not create the vehicle and will show notifications
            vector4(1523.1072, 3767.7576, 33.6247, 224.1134),
            vector4(1516.6947, 3763.9688, 33.6048, 196.0755),
            vector4(1511.2900, 3762.0994, 33.5837, 196.5286)
        }
    } 
}