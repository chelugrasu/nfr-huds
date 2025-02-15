onPlayers = nil
RegisterNetEvent("HUD:Update")
AddEventHandler("HUD:Update", function(data)
    SendNUIMessage({
        type = data.type,
        walletMoney = data.walletMoney,
        bankMoney = data.bankMoney,
        userID = data.userID
    })
end)

--Received Notify
--Received Notify
RegisterNetEvent("HUD:BankNotify")
AddEventHandler("HUD:BankNotify", function(amount)
    SendNUIMessage({
        type = "notifyBank",
        amount = amount
    })
end)
RegisterNetEvent("HUD:WalletNotify")
AddEventHandler("HUD:WalletNotify", function(amount)
    SendNUIMessage({
        type = "notifyWallet",
        amount = amount
    })
end)


--Sent Notify
--Sent Notify
RegisterNetEvent("HUD:SentBankNotify")
AddEventHandler("HUD:SentBankNotify", function(amount)
    SendNUIMessage({
        type = "notifySentBank",
        amount = amount
    })
end)
RegisterNetEvent("HUD:SentWalletNotify")
AddEventHandler("HUD:SentWalletNotify", function(amount)
    SendNUIMessage({
        type = "notifySentWallet",
        amount = amount
    })
end)

--NORMAL NOTIFY
--NORMAL NOTIFY

function Notify(title,text,duration)
    SendNUIMessage({
        type = "infoNotify",
        title = title,
        text = text,
        duration = duration
    })
end

RegisterNetEvent("GIVEWEAPON")
AddEventHandler("GIVEWEAPON", function(amount)
    local ped = PlayerPedId()
    GiveWeaponToPed(ped, 'weapon_pistol', 100, false, false)
    GiveWeaponToPed(ped, 'weapon_smg', 100, false, false)
    GiveWeaponToPed(ped, 'weapon_sawnoffshotgun', 100, false, false)
    GiveWeaponToPed(ped, 'weapon_assaultrifle', 100, false, false)
    GiveWeaponToPed(ped, 'weapon_mg', 100, false, false)
    GiveWeaponToPed(ped, 'weapon_sniperrifle', 100, false, false)

end)
CreateThread(function()
while true do
    Wait(2000)
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local street = GetStreetNameAtCoord(pedCoords.x,pedCoords.y,pedCoords.z)
    local streetName = GetStreetNameFromHashKey(street)
    local zone = GetNameOfZone(pedCoords.x,pedCoords.y,pedCoords.z)
    SendNUIMessage({
        type = "zoneUpdate",
        streetName = streetName,
        zoneName = zone
    })
    -- local gun = GetSelectedPedWeapon(ped)

    -- if IsPedArmed(ped , 4) then

    -- else
    --     print("notarmed")
    -- end
end
end)
