local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")
CreateThread(function()
    while true do
        Wait(2000)
        for _, p in pairs(vRP.getUsers()) do
            user_id = vRP.getUserId({p})
            bank_money = vRP.getBankMoney({user_id})
            wallet_money = vRP.getMoney({user_id})
            data1 = {
                type = "moneyHud",
                walletMoney = wallet_money,
                bankMoney = bank_money,
                userID = user_id
            }


            TriggerClientEvent("HUD:Update", p, data1)
        end
    end
end)
RegisterCommand('test1', function(source, args)
	local user_id = vRP.getUserId({source})
	vRP.giveBankMoney({user_id,360000})  
end)
RegisterCommand('giveweapon', function(source, args)
	TriggerClientEvent("GIVEWEAPON", source)
end)
RegisterCommand('test2', function(source, args)
	local user_id = vRP.getUserId({source})
	vRP.giveMoney({user_id,36000})  
end)

RegisterCommand('test3', function(source, args)
	local user_id = vRP.getUserId({source})
	vRP.tryPayment({user_id,72000})  
end)
RegisterCommand('test4', function(source, args)
	local user_id = vRP.getUserId({source})
	vRP.tryBankPayment({user_id,72000}) 
end)

--Received Notify

function showBankNotify(source, amount)
    for _, p in pairs(vRP.getUsers()) do
        TriggerClientEvent("HUD:BankNotify", p, amount)
    end
end
exports("bankNotify", showBankNotify)

function showWalletNotify(source, amount)
    for _, p in pairs(vRP.getUsers()) do
        TriggerClientEvent("HUD:WalletNotify", p, amount)
    end
end
exports("walletNotify", showWalletNotify)


--Sent Notify
--Sent Notify

function showSentBankNotify(source, amount)
    for _, p in pairs(vRP.getUsers()) do
        TriggerClientEvent("HUD:SentBankNotify", p, amount)
    end
end
exports("sentBankNotify", showSentBankNotify)

function showSentWalletNotify(source, amount)
    for _, p in pairs(vRP.getUsers()) do
        TriggerClientEvent("HUD:SentWalletNotify", p, amount)
    end
end
exports("sentWalletNotify", showSentWalletNotify)




--SPEEDOMETER


RegisterServerEvent('hudevents:leftVehicle')
AddEventHandler('hudevents:leftVehicle', function()	
    TriggerClientEvent('hudevents:leftVehicle', source)
end)

RegisterServerEvent('hudevents:enteredVehicle')
AddEventHandler('hudevents:enteredVehicle', function(currentVehicle, currentSeat, vehicle_name, net_id)	
    TriggerClientEvent('hudevents:enteredVehicle', source, currentVehicle, currentSeat, vehicle_name, net_id)
end)