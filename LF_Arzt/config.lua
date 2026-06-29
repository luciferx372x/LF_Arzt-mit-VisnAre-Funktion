Config = {}

Config.MinMedics = 2           -- Ab wie vielen echten Sanitätern schaltet sich der NPC aus
Config.HealingCost = 1500       -- Kosten am Tresen
Config.MobileMedicCost = 3000  -- Kosten für den Krankenwagen, der zu dir kommt

Config.Hospitals = {
    {
        name = "Pillbox Hill",
        npcModel = `s_m_m_doctor_01`,
        npcCoords = vector4(-487.951660, -999.217590, 23.584594, 215.433074), -- Wo der Arzt am Tresen steht
        --spawnVehicle = vector4(333.1, -572.1, 28.8, 318.0) -- Wo der KI-Krankenwagen spawnt
    },
    {
        name = "Sandy Shores",
        npcModel = `s_m_m_doctor_01`,
        npcCoords = vector4(1839.072510, 3672.817626, 34.267456, 209.763778), -- Wo der Arzt am Tresen steht
        --spawnVehicle = vector4(333.1, -572.1, 28.8, 318.0) -- Wo der KI-Krankenwagen spawnt
    },
    {
        name = "Paleto Bay",
        npcModel = `s_m_m_doctor_01`,
        npcCoords = vector4(-248.887908, 6331.318848, 32.413940, 272.125976), -- Wo der Arzt am Tresen steht
        --spawnVehicle = vector4(333.1, -572.1, 28.8, 318.0) -- Wo der KI-Krankenwagen spawnt
    },
}