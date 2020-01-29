--[[
********************************************************************
CONTACT: Garou
********************************************************************
Github: https://github.com/qarou
Discord: Garou#0190
Discord Server: https://discord.gg/VkJ6tT5
********************************************************************
]]

Config = {}

Config.CarModels = { -- Here you can add vehicles or change the variation of vehicles (Put the spawn name) - Burada araç ekleyebilir veya araçların varyasyonunu değiştirebilirsiniz (spawn adını koyun)
    "xa21",
    "nero",
    "comet5"
}

Config.LockPickTime = 5000 -- Time in ms for lockpicking the door to break in. 1000ms = 1 second. - Kilidi kırmak için ms cinsinden geçen süre. 1000ms = 1 saniye.
Config.LockPicking = 'Kırılıyor...' -- Notification Text while lockpicking. - Kilidi kırarken yazılacak yazı.
Config.TrackerTime = 120 -- Set the time in seconds for the tracker to get removed while standing still or having a passenger. - Hareketsiz dururken veya bir yolcu varken izleyicinin kaldırılacağı süreyi saniye cinsinden ayarlayın.
Config.CooldownTime = 25 -- This is the time in seconds for the cooldown on taking another car. - Bu, bekleme süresinin ayarlanması için saniye cinsinden zamandır.
Config.CopsRequired = 1 -- Amount of cops required to start. - Kaç polis gerektirdiğini buradan ayarlayın.

Config.Start = {
    ["Start"] = {
        ["Pos"] = vector3(846.43347167969, -902.63452148438, 25.251483917236), -- position of starting point. - başlangıç ​​noktasının konumu.
        ["Text"] = "Konus",
        ["Ped"] = {
            ["Pos"] = vector3(844.99591064453, -902.92425537109, 25.251482009888), -- position of ped. - pedin konumu.
            ["Heading"] = 270.54299926758, -- heading of ped. - pedin konumu 
            ["Model"] = GetHashKey("g_m_m_armboss_01") -- ped model. - pedin modeli.
        }
    },
}

Config.ReturnVehicle = {
    ["Pos"] = vector3(-1325.0148925781, -236.54602050781, 42.685005187988), -- Position of dropoff point. - Bırakma noktasının konumu.
    ["Reward"] = 5000, -- amount of money you get from completing it. - işlem bittiğinde alınacak para miktarı.
    ["Text"] = "Araci Sat" -- Text over marker. - Yazınızı buraya girin
}

Config.Coords = {
    [1] = {
        ["GarageEnter"] = {
            ["Pos"] = vector3(-2001.1409912109, 613.03735351563, 118.1019821167), -- Location for entering garage byt foot. - Garaj konumu.
            ["VehPos"] = vector3(-1989.7598876953, 604.84808349609, 117.90341186523), -- Location for exiting with stolen vehicle. - Çalınan araçların çıkış konumu.
            ["VehHeading"] = 261.5061340332,
            ["Heading"] = 322.59564208984,
            ["Action"] = "Enter",
            ["Text"] = "Gir" -- Text over marker. - Yazınızı buraya girin
        },
        ["GarageExit"] = {
            ["Pos"] = vector3(206.68142700195, -998.91186523438, -98.999923706055), -- Location for interior spawn. - Garajın çıkış konumu.
            ["Heading"] = 86.347755432129,
            ["Action"] = "Steal",
            ["Text"] = "Cik", -- Text over marker. - Yazınızı buraya girin
        },
        ["Keys"] = {
            ["Lockers"] = {
                ["Pos"] = vector3(190.85746765137, -1002.1414794922, -99.0),
                ["Text"] = "Ara", -- Text over marker. - Yazınızı buraya girin
                ["Action"] = "Search",
                ["Random"] = 1
            },
            
            ["Boxes"] = {
                ["Pos"] = vector3(206.55833435059, -1006.3706054688, -99.0),
                ["Text"] = "Ara", -- Text over marker. - Yazınızı buraya girin
                ["Action"] = "Search",
                ["Random"] = 2
            },
            
            ["KeyCabinet"] = {
                ["Pos"] = vector3(190.11595153809, -994.80334472656, -99.0),
                ["Text"] = "Ara", -- Text over marker. - Yazınızı buraya girin
                ["Action"] = "Search",
                ["Random"] = 3
            },
            
            ["Table"] = {
                ["Pos"] = vector3(201.95524597168, -994.60620117188, -99.0),
                ["Text"] = "Ara", -- Text over marker. - Yazınızı buraya girin
                ["Action"] = "Search",
                ["Random"] = 4
            },
        },
        ["Car"] = {
            ["Pos"] = vector3(198.29605102539, -998.82592773438, -99.0), -- Position of car inside garage. - Arabanın garaj içindeki konumu.
            ["Heading"] = 178.8497467041, -- Heading of car in garage. - Arabanın garaj içindeki konum ayarı.
        },
    },
    [2] = {
        ["GarageEnter"] = {
            ["Pos"] = vector3(-151.84712219238, 910.71740722656, 235.65560913086), -- Location for entering garage byt foot. - Garaj konumu.
            ["VehPos"] = vector3(-136.15100097656, 902.82336425781, 235.72392272949), -- Location for exiting with stolen vehicle. - Çalınan araçların çıkış konumu.
            ["VehHeading"] = 316.79638671875,
            ["Heading"] = 322.59564208984,
            ["Action"] = "Enter",
            ["Text"] = "Gir" -- Text over marker. - Yazınızı buraya girin
        },
        ["GarageExit"] = {
            ["Pos"] = vector3(212.20077514648, -999.09240722656, -98.999923706055), -- Location for interior spawn. - Garajın çıkış konumu.
            ["Heading"] = 86.347755432129,
            ["Action"] = "Steal",
            ["Text"] = "Cik", -- Text over marker. - Yazınızı buraya girin
        },
        ["Keys"] = {
            ["Lockers"] = {
                ["Pos"] = vector3(190.85746765137, -1002.1414794922, -99.0),
                ["Text"] = "Ara", -- Text over marker. - Yazınızı buraya girin
                ["Action"] = "Search",
                ["Random"] = 1
            },
            
            ["Boxes"] = {
                ["Pos"] = vector3(206.55833435059, -1006.3706054688, -99.0),
                ["Text"] = "Ara", -- Text over marker. - Yazınızı buraya girin
                ["Action"] = "Search",
                ["Random"] = 2
            },
            
            ["KeyCabinet"] = {
                ["Pos"] = vector3(190.11595153809, -994.80334472656, -99.0),
                ["Text"] = "Ara", -- Text over marker. - Yazınızı buraya girin
                ["Action"] = "Search",
                ["Random"] = 3
            },
            
            ["Table"] = {
                ["Pos"] = vector3(201.95524597168, -994.60620117188, -99.0),
                ["Text"] = "Ara", -- Text over marker. - Yazınızı buraya girin
                ["Action"] = "Search",
                ["Random"] = 4
            },
        },
        ["Car"] = {
            ["Pos"] = vector3(198.29605102539, -998.82592773438, -99.0), -- Position of car inside garage. - Arabanın garaj içindeki konumu.
            ["Heading"] = 178.8497467041, -- Heading of car in garage. - Arabanın garaj içindeki konum ayarı.
        },
    },
}