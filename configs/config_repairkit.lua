wx = {}

wx.allowWhileLocked = false -- Allow washing and repairing vehicles even when they're locked?

wx.neededItems = { -- Needed items for certain actions
-- Do not Rename      Item Name
    ['Repair']      = 'repairkit',
    ['Wash']        = 'sponge',
}

wx.progressTimes = { -- How long should certain actions take
-- Do not rename    Time in ms
    ['Repair']      = 15000,
    ['Wash']        = 8500,
}

Notify = function (title,desc) -- You may replace this function
    lib.notify({
        title = title,
        description = desc,
        position = 'top',
        style = {
            backgroundColor = '#1E1E2E',
            color = '#C1C2C5',
            ['.description'] = {
              color = '#909296'
            }
        },
        icon = 'car-side',
        iconColor = '#cba6f7'
    })
end
