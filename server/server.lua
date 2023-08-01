RegisterNetEvent('wx_repairkit:usedRepairkit')
AddEventHandler('wx_repairkit:usedRepairkit',function ()
    exports.ox_inventory:RemoveItem(source, wx.neededItems['Repair'], 1, nil, nil, nil)
end)

RegisterNetEvent('wx_repairkit:usedSponge')
AddEventHandler('wx_repairkit:usedSponge',function ()
    exports.ox_inventory:RemoveItem(source, wx.neededItems['Wash'], 1, nil, nil, nil)
end)