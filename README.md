# ⚠️ SOME EMULATORS WILL NOT CORRECTLY WRITE FILES SUCH AS, BLUESTACKS (FROM MY EXPERIENCE). ⚠️

# Status: Working

# BloxyBin-Key-System
A script that adds a Key System UI using BloxyBins Key System API.

## The purpose
The purpose of me making this script was to help people monetize their script. What I mean by that is allowing creators to make money for their work, with the use of keys. The user generates a key, which in the process can earn you some amount of money, compensating you for your work!
 
I wanted to allow people to have this oppourtinity by utalizing BloxyBin's easy to understand API which generates user keys, earns you some profit, and is completely free to use.

Please Note:
* Security is not garuenteed. I will try to make this library as secure as possible, so bad actors couldn't bypass, but just be aware that bypasses or vulnerabilities may be present. I do not intend for these bypasses or vulnerabilities, and if one does occur I will try to patch it as fast as I could.

## Features
 This Script includes features, such as:
 * A pre-made GUI
 * One function which does all the work for you
 * Automatic Key Checking (With the use of BloxyBin)
 * Automatically save and uses saved keys
 * And of course, it's open source.

## How to use it

### Basic Setup

1) Include the script by putting this somewhere in the script. (Recommended at the top or after the main script is defined)

```lua
local KeySystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/Vortex-scripts/BloxyBin-Key-System/main/main.lua"))()
```

2) Then call the `Initialize` function by adding a few paramaters, and thats it!
```lua
KeySystem.Initialize({
    Script_Name = "Name of Script",     -- Optional
    Script_Creator = "Script Creator",  -- Optional
    Paste_ID = "Paste ID",              -- THIS IS VERY IMPORTANT, MAKE SURE IT MATCHES YOUR PASTE ID
    Callback = function()
        any_function()
    end
})
```

Note that you do not have to give a value for `Script_Name` or `Script_Creator` if you want to automatically get that information from Bloxybin. Simply leave it as nil (don't mention it in the table). Only the `Paste_ID` and `Callback` are necessary for the script to work.

After all this setup, you would have a working key system that's integrated with the BloxyBin key system.

## Bypass key

If you want to easily continue developing your script or bypass your own keysystem, you can add a bypass key. Simply input the `Bypass_Key` string into the initialize function and add it to the file location `BloxyBinKeySystem/Keys/(Your paste ID).txt` in the workspace folder. The new table should look like this.
```lua
KeySystem.Initialize({
    Script_Name = "Name of Script",
    Script_Creator = "Script Creator",
    Paste_ID = "Paste ID",
    Bypass_Key = "Whatever string"
    Callback = function()
        any_function()
    end
})
```

The more complex the bypass key, the harder it is for people to guess. However, people can use other scripts to get the key or "crack" your script by reverse engeneering obfuscation, which is why I reccomend one of two option.

1) Moving the file somewhere outside of workspace, only putting it in when you are loading your script
2) Not including this into your script

**Use this responsibly**

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

KeySystem.Initialize({
    Script_Name = "Name of Script",
    Script_Creator = "Script Creator",
    Paste_ID = "Paste ID",              
    Callback = function()
        main()
    end
})
 ```
 
I would, however, **NOT** recommend you do something like this.
 
 ```lua
 KeySystem.Initialize({
    Script_Name = "Name of Script",
    Script_Creator = "Script Creator",
    Paste_ID = "Paste ID",
    Callback = function()
        loadstring(game:HttpGet("https://example.com/script-location.lua"))() -- Here is the problem
    end
})
 ```
 
You shouldn't do this as a user can use something like HttpSpy to get the loadstring and bypass the key system. The only way to get around this is by obfuscating that script and adding the key system in there **OR THE BETTER OPTION**, putting it all into one script.