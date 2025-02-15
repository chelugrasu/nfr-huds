
local shouldSendNUIUpdate = false
local isHudHidden = false

seatbeltOn = false
local lastCarLS_r, lastCarLS_o, lastCarLS_h
local lastCarFuelAmount, lastCarHandbreak, lastCarBrakePressure
local lastCarIL, lastCarRPM, lastCarSpeed, lastCarGear

displayKMH = 0
local nitro = 0



RegisterNetEvent("hudevents:leftVehicle")
AddEventHandler('hudevents:leftVehicle', function()
	isInVehicle = false

	if not isHudHidden then
		isHudHidden = true

		SendNUIMessage({
			HideHud = isHudHidden
		})
	end
end)

RegisterNetEvent("hudevents:enteredVehicle")
AddEventHandler('hudevents:enteredVehicle', function(currentVehicle, currentSeat, vehicle_name, net_id)

	isInVehicle = true

	if isHudHidden then
		isHudHidden = false
		SendNUIMessage({
			HideHud = isHudHidden
		})
	end

	while isInVehicle do
		Wait(50)	

		local PlayerPed = PlayerPedId()
		
		if not isHudHidden then
			if IsVehicleEngineOn(currentVehicle) then
				local carRPM = GetVehicleCurrentRpm(currentVehicle)			
				
				local multiplierUnit = 3.6

				local carSpeed = math.floor(GetEntitySpeed(currentVehicle) * multiplierUnit)
				local carGear = GetVehicleCurrentGear(currentVehicle)
				local carHandbrake = GetVehicleHandbrake(currentVehicle)
				local carBrakePressure = GetVehicleWheelBrakePressure(currentVehicle, 0)
				local fuelamount = GetVehicleFuelLevel(currentVehicle) or 0

				shouldSendNUIUpdate = false

				if lastCarRPM ~= carRPM then lastCarRPM = carRPM shouldSendNUIUpdate = true end
				if lastCarSpeed ~= carSpeed then lastCarSpeed = carSpeed shouldSendNUIUpdate = true end
				if lastCarGear ~= carGear then lastCarGear = carGear shouldSendNUIUpdate = true end
				if lastCarHandbreak ~= carHandbrake then lastCarHandbreak = carHandbrake shouldSendNUIUpdate = true end
				if lastCarBrakePressure ~= carBrakePressure then lastCarBrakePressure = carBrakePressure shouldSendNUIUpdate = true end

				if lastCarFuelAmount ~= fuelamount then lastCarFuelAmount = fuelamount shouldSendNUIUpdate = true end

				if shouldSendNUIUpdate then
					SendNUIMessage({
						ShowHud = true,
						CurrentCarRPM = carRPM * 10,
						CurrentCarGear = carGear,
						CurrentCarSpeed = carSpeed,
						CurrentCarHandbrake = carHandbrake,
						CurrentCarFuelAmount = math.ceil(fuelamount),
						CurrentDisplayKMH = displayKMH,
						CurrentCarBrake = carBrakePressure,					
					})		
				end
			end
		end
	end
end)


local function GetPedVehicleSeat(entity)
    local Vehicle = GetVehiclePedIsIn(entity, false)

	for i= -2, GetVehicleMaxNumberOfPassengers(Vehicle) do
        if GetPedInVehicleSeat(Vehicle, i) == entity then
			return i
		end
    end

	return -2
end

AddEventHandler('onResourceStart', function()
	local PlayerPed = PlayerPedId()

	if IsPedInAnyVehicle(PlayerPed, false) then
		local currentVehicle = GetVehiclePedIsUsing(PlayerPed)
		local currentSeat = GetPedVehicleSeat(PlayerPed)
		local netID = VehToNet(currentVehicle)

		TriggerEvent('hudevents:enteredVehicle', currentVehicle, currentSeat, GetDisplayNameFromVehicleModel(GetEntityModel(currentVehicle)), netID)

		cruiser = true
		ExecuteCommand('cruiser')
	end
end)