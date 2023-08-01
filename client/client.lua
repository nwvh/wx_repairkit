local optionsRepair =     {
	name = 'wx_repairkit:target',
	icon = 'fa-solid fa-wrench',
	label = "Use repair kit",
  bones = 'engine',
  canInteract = function(entity, distance, coords, name, boneId)
      if GetVehicleDoorLockStatus(entity) > 1 then return end
      if IsVehicleDoorDamaged(entity, 4) then return end
      return #(coords - GetEntityBonePosition_2(entity, boneId)) < 0.9
  end,
	onSelect = function(data)
		RepairKit(data.entity)
	end
}
local optionsWash =     {
	name = 'wx_repairkit:target',
	icon = 'fa-solid fa-soap',
	label = "Wash vehicle",
	onSelect = function(data)
		CleanVehicle(data.entity)
	end
}

exports.ox_target:addGlobalVehicle(optionsRepair)
exports.ox_target:addGlobalVehicle(optionsWash)

function GetItemName(item)
  local labels = {}
  for _, data in pairs(exports.ox_inventory:Items()) do
    labels[data.name] = data.label
  end
  if labels[item] ~= nil then
    return labels[item]
  else
    print("[WARNING] The required item doesn't exist! - "..item)
    return "UNKNOWN ITEM"
  end
end

function RepairKit(vehicle)
  local count = lib.callback.await('ox_inventory:getItemCount', false, wx.neededItems['Repair'])
  if count >= 1 then
    TaskTurnPedToFaceEntity(PlayerPedId(),vehicle)
    lib.progressCircle({
      duration = tonumber(wx.progressTimes['Repair']),
      position = 'bottom',
      label = "Fixing vehicle...",
      useWhileDead = false,
      canCancel = false,
      disable = {
          car = true,
          move = true,
          combat = true
      },
      anim = {
          dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
          clip = 'machinic_loop_mechandplayer'
      },
    })
    TriggerServerEvent('wx_repairkit:usedRepairkit')
    SetVehicleFixed(vehicle)
  else
    Notify('Error','You need at least one '..GetItemName(wx.neededItems['Repair']))
  end
end

function CleanVehicle(vehicle)
  local count = lib.callback.await('ox_inventory:getItemCount', false, wx.neededItems['Wash'])
    if count >= 1 then
      TaskTurnPedToFaceEntity(PlayerPedId(),vehicle)
      lib.progressCircle({
        duration = tonumber(wx.progressTimes['Wash']),
        position = 'bottom',
        label = "Cleaning vehicle...",
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
            combat = true
        },
        anim = {
            dict = 'timetable@floyd@clean_kitchen@base',
            clip = 'base'
        },
        prop = {
          model = `prop_sponge_01`,
          bone = 28422,
          pos = vec3(0.0, 0.0, -0.01),
          rot = vec3(90.0, 0.0, 0.0)
        },

      })
      TriggerServerEvent('wx_repairkit:usedSponge')
      SetVehicleDirtLevel(vehicle,0.0)
  else
    Notify('Error','You need at least one '..GetItemName(wx.neededItems['Wash']))
  end
end
