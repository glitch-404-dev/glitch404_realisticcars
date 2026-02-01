local appliedVehicles = {}

function ApplyHandling(vehicle, data)
    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMax", data.traction)
    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMin", data.traction - 0.4)
    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveForce", data.acceleration)
    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fBrakeForce", data.brakeForce)
    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveMaxFlatVel", data.topSpeed)

    SetVehicleEngineDamageMultiplier(vehicle, data.damageMultiplier)
    SetVehicleBodyDamageMultiplier(vehicle, data.damageMultiplier)
    SetVehiclePetrolTankDamageMultiplier(vehicle, data.damageMultiplier)

    SetVehicleCanBreak(vehicle, false)
    SetVehicleStrong(vehicle, true)
end

-- 🚀 OX CACHE VEHICLE DETECTION (BEST)
lib.onCache('vehicle', function(vehicle)
    if not vehicle then return end
    if appliedVehicles[vehicle] then return end

    local model = GetEntityModel(vehicle)
    local modelName = GetDisplayNameFromVehicleModel(model):lower()
    local config = Config.Vehicles[modelName]

    if not config then return end

    ApplyHandling(vehicle, config)
    appliedVehicles[vehicle] = true
end)
