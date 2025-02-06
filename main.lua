--[[
    PLEASE LOOK AT THE README FILE FOR DOCUMENTATION
]]

-- Deletes a copy of the BloxyBin Key UI if it exists
if getgenv().BloxyBinKeyUI then
    getgenv().BloxyBinKeyUI:Destroy()
end

-- Actual stript
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local main = {}


local function check_key(key_input, pasteID) -- Returns the status code

    local res = request({
        Url = "https://bloxybin.com/api/v1/paste/key?token=" .. tostring(key_input) .. "&raw=false",
        Method = "GET",
    })

    if res.StatusCode == 200 then -- Checks if server responded with no issues
        local response = HttpService:JSONDecode(res.Body).payload
        -- In case the server doesn't corretly delete expire keys, this insures the keys won't work if they're expired
        if response.created + response.expires < workspace:GetServerTimeNow() then return 0 end 
        if response.key ~= key_input then return 0 end -- Just an extra check, may not be needed
        -- This is important to check if the key actually works for your script. Make sure the pasteID variable is set correctly.

        if response.paste.pasteID == pasteID then
            return 200 -- The key is correct
        else
            return 0 -- The key is incorrect
        end
    elseif res.StatusCode == 400 then
        return 400 -- This is an invalid key
    else
        return 404 -- Server error
    end
end

local function Make_Menu(settings)

    local has_thumbnail

    local res = request({
        Url = "https://bloxybin.com/api/v1/paste?id=" .. settings.Paste_ID,
        Method = "GET"
    })

    local full_response = HttpService:JSONDecode(res.Body).payload
    local thumbnail = nil
    has_thumbnail = full_response.paste.hasThumbnail

    if has_thumbnail then
        local suc = pcall(function()
            if not isfile("BloxyBinKeySystem/Images/" .. settings.Paste_ID .. ".png")  then 
                writefile("BloxyBinKeySystem/Images/" .. settings.Paste_ID .. ".png", game:HttpGet(full_response.paste.thumbnailLink))
            end
            thumbnail = getcustomasset("BloxyBinKeySystem/Images/" .. settings.Paste_ID .. ".png")
        end)
        if not suc then
            thumbnail = "rbxassetid://13584686088"
        end
    else
        thumbnail = "rbxassetid://13584686088"
    end

    local rbxmSuite = loadstring(game:HttpGetAsync("https://github.com/richie0866/rbxm-suite/releases/latest/download/rbxm-suite.lua"))()
    local Path = rbxmSuite.download("Vortex-scripts/BloxyBin-Key-System@latest", "UI.rbxm")

    local KeySystem = rbxmSuite.launch(Path, {
        runscripts = false,
        deferred = false,
        nocache = false,
        nocirculardeps = true,
        debug = false,
        verbose = false,
    })


    getgenv().BloxyBinKeyUI = KeySystem

    -- Protects the UI from client-sided detecitons (When possible)
    local CoreGui = game:GetService("CoreGui")
    if gethui then
        KeySystem.Parent = gethui()
    elseif CoreGui:FindFirstChild("RobloxGui") then
        KeySystem.Parent = CoreGui:FindFirstChild("RobloxGui")
    else
        KeySystem.Parent = CoreGui
    end

    KeySystem.Main_Entry.Input["Error Text"]["Error Text Label"].Text = ""
    KeySystem.Main_Entry.Image.Image.Image = thumbnail
    KeySystem.Main_Entry.Image.Image.BackgroundTransparency = 1
    KeySystem.Main_Entry.Script_Info.Creator_Name.Text = settings.Script_Creator or full_response.creator.username
    KeySystem.Main_Entry.Script_Info.Script_Name.Text = settings.Script_Name or full_response.paste.title

    KeySystem.Main_Entry.Visible = true

    TweenService:Create(KeySystem.Main_Entry.Script_Info, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = UDim2.new(0, 0, 0, 0)}):Play()
    task.wait(0.25)
    TweenService:Create(KeySystem.Main_Entry.Input, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = UDim2.new(0, 0, 0.383, 0)}):Play()
    task.wait(0.25)
    TweenService:Create(KeySystem.Main_Entry.Image, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = UDim2.new(0.5, 0, 0.2, 0)}):Play()

    KeySystem.Main_Entry["UI Controls"]["Close Button"].Activated:Connect(function()
        KeySystem:Destroy()
        getgenv().BloxyBinKeyUI = nil
    end)

    KeySystem.Main_Entry.Input.Buttons["Copy Link"].Button.Activated:Connect(function()
        local suc = pcall(function()
            setclipboard("https://bloxybin.com/key/" .. settings.Paste_ID)
        end)

        if not suc then

            KeySystem.Main_Entry.Input["Error Text"]["Error Text Label"].Text = "Unable to copy link."
            TweenService:Create(KeySystem.Main_Entry.Input["Error Text"]["Error Text Label"], TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
            task.wait(1.5)
            TweenService:Create(KeySystem.Main_Entry.Input["Error Text"]["Error Text Label"], TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Position = UDim2.new(0, 0, 1, 0)}):Play()

        end
    end)

    KeySystem.Main_Entry.Input.Buttons.Submit.Button.Activated:Connect(function()

        local key_status = check_key(KeySystem.Main_Entry.Input.Key_Input.Text, settings.Paste_ID)

        if key_status == 200 then -- Key is correct

            writefile("BloxyBinKeySystem/Keys/" .. settings.Paste_ID .. ".txt", KeySystem.Main_Entry.Input.Key_Input.Text)
                
            TweenService:Create(KeySystem.Main_Entry.Input, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = UDim2.new(-0.5, 0, 0.383, 0)}):Play()
            task.wait(0.25)
            TweenService:Create(KeySystem.Main_Entry.Image, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = UDim2.new(1, 0, 0.2, 0)}):Play()
            task.wait(0.25)
            TweenService:Create(KeySystem.Main_Entry.Script_Info, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = UDim2.new(-0.5, 0, 0, 0)}):Play()
            task.wait(1)

            KeySystem:Destroy()
            getgenv().BloxyBinKeyUI = nil

            local suc, msg = pcall(settings.Callback, KeySystem.Main_Entry.Input.Key_Input.Text)
            if not suc then
                warn([[==============
                Error. Key System couldn't run script!
                Error:\n]] .. msg)
            end

        elseif key_status == 400 or key_status == 0 then -- This is an invalid key / Key isn't for this script

            TweenService:Create(KeySystem.Main_Entry.Input.Buttons.Submit.Button, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(109, 0, 0)}):Play()
            TweenService:Create(KeySystem.Main_Entry.Input.Buttons.Submit, TweenInfo.new(0.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Position = UDim2.new(0.184, 0, 0.358, 0)}):Play()
            task.wait(0.1)
            TweenService:Create(KeySystem.Main_Entry.Input.Buttons.Submit, TweenInfo.new(0.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Position = UDim2.new(0.204, 0, 0.358, 0)}):Play()
            task.wait(0.1)
            TweenService:Create(KeySystem.Main_Entry.Input.Buttons.Submit, TweenInfo.new(0.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Position = UDim2.new(0.194, 0, 0.358, 0)}):Play()
            TweenService:Create(KeySystem.Main_Entry.Input.Buttons.Submit.Button, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(59, 59, 59)}):Play()

        elseif key_status == 404 then -- Something with the server

            KeySystem.Main_Entry.Input["Error Text"]["Error Text Label"].Text = "BloxyBin Servers errored! Please try again later."
            TweenService:Create(KeySystem.Main_Entry.Input["Error Text"]["Error Text Label"], TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
            task.wait(1.5)
            TweenService:Create(KeySystem.Main_Entry.Input["Error Text"]["Error Text Label"], TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Position = UDim2.new(0, 0, 1, 0)}):Play()

        end
    end)

    task.wait(0.25)
    KeySystem.Main_Entry.Input["Error Text"]["Error Text Label"].Text = "Read & Write file functions may be broken on some executors."
    TweenService:Create(KeySystem.Main_Entry.Input["Error Text"]["Error Text Label"], TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
    task.wait(2.5)
    TweenService:Create(KeySystem.Main_Entry.Input["Error Text"]["Error Text Label"], TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Position = UDim2.new(0, 0, 1, 0)}):Play()
    
end

main.Initialize = function(settings)
    if settings.Paste_ID == nil then error("BloxyBin error. PasteID not set. Please set a Paste ID") return end

    if typeof(settings.Paste_ID) == "number" then
        settings.Paste_ID = tostring(settings.Paste_ID)
    end

    if not isfile("BloxyBinKeySystem/Keys/" .. settings.Paste_ID .. ".txt") then
        Make_Menu(settings)
        return
    end

    local key = readfile("BloxyBinKeySystem/Keys/" .. settings.Paste_ID .. ".txt")

    if settings.Bypass_Key then
        if key == settings.Bypass_Key then
            local suc, msg = pcall(settings.Callback, key)
            if not suc then
                warn([[==============
                Error. Key System couldn't run script!
                Error:\n]] .. msg)
            end
            return
        end
    end

    local key_status = check_key(key, settings.Paste_ID)

    if key_status == 200 then
        local suc, msg = pcall(settings.Callback, key)
            if not suc then
                warn([[==============
                Error. Key System couldn't run script!
                Error:\n]] .. msg)
            end
    elseif key_status == 400 or key_status == 0 then
        Make_Menu(settings)
    elseif key_status == 404 then
        error("Error. Bloxybin didn't work")
    end
end


return main


--[[
    KeySystem Input Temp.

KeySystem:Initialize({
    Script_Name = "Name of Script",     -- Optional
    Script_Creator = "Script Creator",  -- Optional
    Paste_ID = "Paste ID", -- Mandatory,
    Bypass_Key = "whatever"
    Callback = function()
        any_function()
    end
})
]]