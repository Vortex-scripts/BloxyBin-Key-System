# ⚠️ EXECUTORS THAT ARE ON EMULATORS MAY NOT SAVE KEYS. I DON'T KNOW WHY IT'S NOT MY FAULT ⚠️

# Status: The BloxyBin API is fine, the issue is that pastes that have keys enabled are forced to be private. I've talked with the owner of BloxBin and he's getting it fixed.

# BloxyBin-Key-System
A script that adds a Key System UI using BloxyBins Key System API.

## The purpose
The purpose of me making this script was to help people monetize their script. What I mean by that is allowing creators to make money for their work, with the use of keys. The user generates a key, which in the process can earn you some amount of money, compensating you for your work!
 
I wanted to allow people to have this oppourtinity by utalizing BloxyBin's easy to understand API which generates user keys, earns you some profit, and is completely free to use.

## Features
 This Script includes features, such as:
 * A pre-made GUI
 * One function which does all the work for you
 * Automatic Key Checking (With the use of BloxyBin)
 * Automatically save and uses saved keys
 * And of course, it's open source.

## How to use it

1) Include the script by putting this somewhere in the script. (Recommended at the top or after the main script is defined)

```lua
local KeySystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/Vortex-scripts/BloxyBin-Key-System/main/main.lua"))()
```

2) Then call the `Initialize` function by adding a few paramaters, and thats it!
```lua
KeySystem:Initialize({
    Script_Name = "Name of Script",     -- Fill all these out with the details of your script
    Script_Creator = "Script Creator",  -- Otherwise, it would not initialize and may throw an error.
    Paste_ID = "Paste ID", -- THIS IS VERY IMPORTANT, MAKE SURE IT MATCHES YOUR PASTE ID
    Callback = function()
        any_function()
    end
})
```

After all this setup, you would have a working key system that's integrated with the BloxyBin key system.

## Recommended & unrecommended setup
I recommended that you first set your paste to have a Key (Obviously). You can create a key by [going here](https://bloxybin.com/account/dashboard?=key_api) after logging in to BloxyBin, and selecting a paste to have a key.

Next, the paste should be a loadstring, leading to the main script. The script itself should be obfuscated since there is a key involved. If you don't have money for one, I suggest using [this Lua Obfuscator](https://luaobfuscator.com). It's free and does a good job obfuscating scripts.

Now for the actual script, it should be done something like this.

 ```lua
local KeySystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/Vortex-scripts/BloxyBin-Key-System/main/main.lua"))()

local function main()
    print("Hello World")
    -- Put all your main code in this function
end

-- You can also call the script here if you'd like. Just have it before you want to make the Key System.

KeySystem:Initialize({
    Script_Name = "Name of Script",
    Script_Creator = "Script Creator",
    Paste_ID = "Paste ID",              
    Callback = function()
        main()
    end
})
 ```
 
I would, however, not recommend you do something like this.
 
 ```lua
 KeySystem:Initialize({
    Script_Name = "Name of Script",
    Script_Creator = "Script Creator",
    Paste_ID = "Paste ID",
    Callback = function()
        loadstring(game:HttpGet("https://example.com/script-location.lua"))() -- LOADSTRINGS
    end
})
 ```
 
You shouldn't do this as a user can use something like HttpSpy to get the loadstring and bypass the key system. The only way to get around this is by obfuscating that script and adding the key system in there OR the better option, putting it all into one script.