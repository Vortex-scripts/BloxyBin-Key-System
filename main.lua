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

    local BloxybinKeySys = Instance.new("ScreenGui")
    getgenv().BloxyBinKeyUI = BloxybinKeySys
    local Main_Entry = Instance.new("Frame")
    local Main_UI_Corner = Instance.new("UICorner")
    local Input = Instance.new("Frame")
    local Key_Input = Instance.new("TextBox")
    local Key_Input_Corner = Instance.new("UICorner")
    local Buttons = Instance.new("Frame")
    local Submit = Instance.new("Frame")
    local Submit_Button = Instance.new("TextButton")
    local Button_UICorner = Instance.new("UICorner")
    local CopyLink = Instance.new("Frame")
    local Copy_Link_Button = Instance.new("TextButton")
    local Copy_Link_UICorner = Instance.new("UICorner")
    local ErrorText = Instance.new("Frame")
    local ErrorTextLabel = Instance.new("TextLabel")
    local UIControls = Instance.new("Frame")
    local CloseButton = Instance.new("ImageButton")
    local Close_UICorner = Instance.new("UICorner")
    local Script_Info = Instance.new("Frame")
    local Script_Name = Instance.new("TextLabel")
    local Creator_Name = Instance.new("TextLabel")
    local Image = Instance.new("Frame")
    local Script_Thumbnail = Instance.new("ImageLabel")
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")

    local function randomString() -- Used to give random names to the UI elements for added anti-detections
        local length = math.random(10,20)
        local array = {}
        for i = 1, length do
            array[i] = string.char(math.random(32, 126))
        end
        return table.concat(array)
    end
    


    --Properties:

    BloxybinKeySys.Name = randomString()
    BloxybinKeySys.ZIndexBehavior = Enum.ZIndexBehavior.Sibling


    -- Protects the UI from client-sided detecitons (When possible)
    local CoreGui = game:GetService("CoreGui")
    if gethui then
        BloxybinKeySys.Parent = gethui()
    elseif CoreGui:FindFirstChild("RobloxGui") then
        BloxybinKeySys.Parent = CoreGui:FindFirstChild("RobloxGui")
    else
        BloxybinKeySys.Parent = CoreGui
    end

    Main_Entry.Name = randomString()
    Main_Entry.Parent = BloxybinKeySys
    Main_Entry.AnchorPoint = Vector2.new(0.5, 0.5)
    Main_Entry.BackgroundColor3 = Color3.fromRGB(28, 27, 31)
    Main_Entry.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Main_Entry.BorderSizePixel = 0
    Main_Entry.Position = UDim2.new(0.499681115, 0, 0.5, 0)
    Main_Entry.Size = UDim2.new(0, 559, 0, 300)
    Main_Entry.ClipsDescendants = true

    Main_UI_Corner.Name = randomString()
    Main_UI_Corner.Parent = Main_Entry

    Input.Name = randomString()
    Input.Parent = Main_Entry
    Input.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Input.BackgroundTransparency = 1.000
    Input.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Input.BorderSizePixel = 0
    Input.Position = UDim2.new(-0.5, 0, 0.383, 0)
    Input.Size = UDim2.new(0, 279, 0, 173)

    Key_Input.Name = randomString()
    Key_Input.Parent = Input
    Key_Input.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
    Key_Input.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Key_Input.BorderSizePixel = 0
    Key_Input.Position = UDim2.new(0.0250896066, 0, 0, 0)
    Key_Input.Size = UDim2.new(0, 264, 0, 50)
    Key_Input.Font = Enum.Font.SourceSans
    Key_Input.PlaceholderText = "Bloxybin Key"
    Key_Input.Text = ""
    Key_Input.TextColor3 = Color3.fromRGB(255, 255, 255)
    Key_Input.TextSize = 16.000
    Key_Input.TextWrapped = true
    Key_Input.TextXAlignment = Enum.TextXAlignment.Center
    Key_Input.TextYAlignment = Enum.TextYAlignment.Center

    Key_Input_Corner.Name = randomString()
    Key_Input_Corner.Parent = Key_Input

    Buttons.Name = randomString()
    Buttons.Parent = Input
    Buttons.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Buttons.BackgroundTransparency = 1.000
    Buttons.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Buttons.BorderSizePixel = 0
    Buttons.Position = UDim2.new(0, 0, 0.289017349, 0)
    Buttons.Size = UDim2.new(0, 279, 0, 123)

    Submit.Name = randomString()
    Submit.Parent = Buttons
    Submit.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Submit.BackgroundTransparency = 1.000
    Submit.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Submit.BorderSizePixel = 0
    Submit.Position = UDim2.new(0.193548381, 0, 0.357723564, 0)
    Submit.Size = UDim2.new(0, 170, 0, 42)

    Submit_Button.Name = randomString()
    Submit_Button.Parent = Submit
    Submit_Button.BackgroundColor3 = Color3.fromRGB(59, 59, 59)
    Submit_Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Submit_Button.BorderSizePixel = 0
    Submit_Button.Size = UDim2.new(0, 170, 0, 42)
    Submit_Button.Font = Enum.Font.SourceSans
    Submit_Button.Text = "Submit"
    Submit_Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Submit_Button.TextSize = 25.000

    Button_UICorner.Name = randomString()
    Button_UICorner.Parent = Submit_Button

    CopyLink.Name = randomString()
    CopyLink.Parent = Buttons
    CopyLink.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CopyLink.BackgroundTransparency = 1.000
    CopyLink.BorderColor3 = Color3.fromRGB(0, 0, 0)
    CopyLink.BorderSizePixel = 0
    CopyLink.Position = UDim2.new(0.311827958, 0, 0.048780486, 0)
    CopyLink.Size = UDim2.new(0, 104, 0, 28)

    Copy_Link_Button.Name = randomString()
    Copy_Link_Button.Parent = CopyLink
    Copy_Link_Button.BackgroundColor3 = Color3.fromRGB(59, 59, 59)
    Copy_Link_Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Copy_Link_Button.BorderSizePixel = 0
    Copy_Link_Button.Size = UDim2.new(0, 104, 0, 28)
    Copy_Link_Button.Font = Enum.Font.SourceSans
    Copy_Link_Button.Text = "Copy Link"
    Copy_Link_Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Copy_Link_Button.TextSize = 14.000
    Copy_Link_Button.TextWrapped = true

    Copy_Link_UICorner.Name = randomString()
    Copy_Link_UICorner.Parent = Copy_Link_Button

    ErrorText.Name = randomString()
    ErrorText.Parent = Input
    ErrorText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ErrorText.BackgroundTransparency = 1.000
    ErrorText.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ErrorText.BorderSizePixel = 0
    ErrorText.Position = UDim2.new(0.225999996, 0, 0.81400001, 0)
    ErrorText.Size = UDim2.new(0, 153, 0, 25)
    ErrorText.ClipsDescendants = true

    ErrorTextLabel.Name = randomString()
    ErrorTextLabel.Parent = ErrorText
    ErrorTextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ErrorTextLabel.BackgroundTransparency = 1.000
    ErrorTextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ErrorTextLabel.BorderSizePixel = 0
    ErrorTextLabel.Size = UDim2.new(0, 153, 0, 25)
    ErrorTextLabel.Position = UDim2.new(0, 0, 1, 0)
    ErrorTextLabel.Font = Enum.Font.SourceSans
    ErrorTextLabel.Text = ""
    ErrorTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ErrorTextLabel.TextScaled = true
    ErrorTextLabel.TextSize = 14.000
    ErrorTextLabel.TextWrapped = true

    UIControls.Name = randomString()
    UIControls.Parent = Main_Entry
    UIControls.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    UIControls.BackgroundTransparency = 1.000
    UIControls.BorderColor3 = Color3.fromRGB(0, 0, 0)
    UIControls.BorderSizePixel = 0
    UIControls.Position = UDim2.new(0.90697664, 0, 0, 0)
    UIControls.Size = UDim2.new(0, 52, 0, 52)

    CloseButton.Name = randomString()
    CloseButton.Parent = UIControls
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.BackgroundTransparency = 1.000
    CloseButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
    CloseButton.BorderSizePixel = 0
    CloseButton.Size = UDim2.new(0, 52, 0, 52)
    CloseButton.Image = "rbxassetid://11293981586"

    Close_UICorner.Name = randomString()
    Close_UICorner.Parent = CloseButton

    Script_Info.Name = randomString()
    Script_Info.Parent = Main_Entry
    Script_Info.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Script_Info.BackgroundTransparency = 1.000
    Script_Info.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Script_Info.BorderSizePixel = 0
    Script_Info.Size = UDim2.new(0, 279, 0, 106)
    Script_Info.Position = UDim2.new(-0.5, 0, 0, 0)

    Script_Name.Name = randomString()
    Script_Name.Parent = Script_Info
    Script_Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Script_Name.BackgroundTransparency = 1.000
    Script_Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Script_Name.BorderSizePixel = 0
    Script_Name.Position = UDim2.new(-0.00358422939, 0, 0.0849056616, 0)
    Script_Name.Size = UDim2.new(0, 279, 0, 50)
    Script_Name.Font = Enum.Font.SourceSans
    Script_Name.Text = settings.Script_Name or full_response.paste.title
    Script_Name.TextColor3 = Color3.fromRGB(255, 255, 255)
    Script_Name.TextScaled = true
    Script_Name.TextSize = 14.000
    Script_Name.TextWrapped = true

    Creator_Name.Name = randomString()
    Creator_Name.Parent = Script_Info
    Creator_Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Creator_Name.BackgroundTransparency = 1.000
    Creator_Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Creator_Name.BorderSizePixel = 0
    Creator_Name.Position = UDim2.new(0, 0, 0.622641504, 0)
    Creator_Name.Size = UDim2.new(0, 191, 0, 25)
    Creator_Name.Font = Enum.Font.SourceSans
    Creator_Name.Text = settings.Script_Creator or full_response.creator.username
    Creator_Name.TextColor3 = Color3.fromRGB(131, 131, 131)
    Creator_Name.TextScaled = true
    Creator_Name.TextSize = 14.000
    Creator_Name.TextWrapped = true

    Image.Name = randomString()
    Image.Parent = Main_Entry
    Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Image.BackgroundTransparency = 1.000
    Image.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Image.BorderSizePixel = 0
    Image.Position = UDim2.new(1, 0, 0.197, 0)
    Image.Size = UDim2.new(0, 270, 0, 227)

    Script_Thumbnail.Name = randomString()
    Script_Thumbnail.Parent = Image
    Script_Thumbnail.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Script_Thumbnail.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Script_Thumbnail.BorderSizePixel = 0
    Script_Thumbnail.Size = UDim2.new(0, 270, 0, 227)
    Script_Thumbnail.Image = thumbnail
    Script_Thumbnail.BackgroundTransparency = 1

    UIAspectRatioConstraint.Parent = BloxybinKeySys
    UIAspectRatioConstraint.AspectRatio = 1.890

    TweenService:Create(Script_Info, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = UDim2.new(0, 0, 0, 0)}):Play()
    wait(0.25)
    TweenService:Create(Input, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = UDim2.new(0, 0, 0.383, 0)}):Play()
    wait(0.25)
    TweenService:Create(Image, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = UDim2.new(0.5, 0, 0.2, 0)}):Play()

    CloseButton.Activated:Connect(function()
        BloxybinKeySys:Destroy()
    end)

    Copy_Link_Button.Activated:Connect(function()
        local suc = pcall(function()
            setclipboard("https://bloxybin.com/key/" .. settings.Paste_ID)
        end)

        if not suc then

            ErrorTextLabel.Text = "Unable to copy link."
            TweenService:Create(ErrorTextLabel, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
            wait(1.5)
            TweenService:Create(ErrorTextLabel, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Position = UDim2.new(0, 0, 1, 0)}):Play()

        end
    end)

    Submit_Button.Activated:Connect(function()

        local key_status = check_key(Key_Input.Text, settings.Paste_ID)

        if key_status == 200 then -- Key is correct

            writefile("BloxyBinKeySystem/Keys/" .. settings.Paste_ID .. ".txt", Key_Input.Text)
                
            TweenService:Create(Input, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = UDim2.new(-0.5, 0, 0.383, 0)}):Play()
            wait(0.25)
            TweenService:Create(Image, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = UDim2.new(1, 0, 0.2, 0)}):Play()
            wait(0.25)
            TweenService:Create(Script_Info, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = UDim2.new(-0.5, 0, 0, 0)}):Play()
            wait(1)

            BloxybinKeySys:Destroy()

            settings.Callback()

        elseif key_status == 400 or key_status == 0 then -- This is an invalid key / Key isn't for this script

            TweenService:Create(Submit_Button, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(109, 0, 0)}):Play()
            TweenService:Create(Submit, TweenInfo.new(0.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Position = UDim2.new(0.184, 0, 0.358, 0)}):Play()
            wait(0.1)
            TweenService:Create(Submit, TweenInfo.new(0.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Position = UDim2.new(0.204, 0, 0.358, 0)}):Play()
            wait(0.1)
            TweenService:Create(Submit, TweenInfo.new(0.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Position = UDim2.new(0.194, 0, 0.358, 0)}):Play()
            TweenService:Create(Submit_Button, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(59, 59, 59)}):Play()

        elseif key_status == 404 then -- Something with the server

            ErrorTextLabel.Text = "BloxyBin Servers errored! Please try again later."
            TweenService:Create(ErrorTextLabel, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
            wait(1.5)
            TweenService:Create(ErrorTextLabel, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Position = UDim2.new(0, 0, 1, 0)}):Play()

        end
    end)

    wait(0.25)
    ErrorTextLabel.Text = "Read & Write file functions may be broken on some executors."
    TweenService:Create(ErrorTextLabel, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
    wait(2.5)
    TweenService:Create(ErrorTextLabel, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Position = UDim2.new(0, 0, 1, 0)}):Play()
    
end

function main:Initialize(settings: table)
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
            settings.Callback()
            return
        end
    end

    local key_status = check_key(key, settings.Paste_ID)

    if key_status == 200 then
        settings.Callback()
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