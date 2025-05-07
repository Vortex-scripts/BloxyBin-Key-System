# Status: Working

# BloxyBin-Key-System
A script that adds a Key System UI using BloxyBins Key System API.

## The purpose
I made this script to help people monetize their scripts. By that, I mean allowing creators to make money for their work through the use of keys. The user generates a key, which can earn them some money and compensate them for their work!
 
I wanted to give people this opportunity by utilizing BloxyBin's easy-to-understand API, which generates user keys, earns you some profit, and is completely free to use.

Please Note:
* Security is not guaranteed. I will try to make this library as secure as possible so bad actors can't bypass it, but just be aware that bypasses or vulnerabilities may exist. I do not intend for these bypasses or vulnerabilities, and if one does occur, I will try to patch it as fast as I can.

## Features
 This Script includes features, such as:
 * A pre-made GUI
 * One function that does all the work for you
 * Automatic Key Checking (With the use of BloxyBin)
 * Automatically save and use saved keys
 * And of course, it's open source.

## How to use it

### Basic Setup

1) Include the script by putting this somewhere in the script. (Recommended at the top or after the main script is defined)

```lua
local KeySystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/Vortex-scripts/BloxyBin-Key-System/main/main.lua"))()
```

2) Then call the `Initialize` function by adding a few parameters, and that's it!
```lua
KeySystem.Initialize({
    Script_Name = "Name of Script",     -- Optional
    Script_Creator = "Script Creator",  -- Optional
    Paste_ID = "Paste ID",              -- THIS IS VERY IMPORTANT, MAKE SURE IT MATCHES YOUR PASTE ID
    Callback = function(key)
        any_function(key)
    end
})
```

Note that you do not have to give a value for `Script_Name` or `Script_Creator` if you want to automatically get that information from Bloxybin. Simply leave it as nil (don't mention it in the table). Only the `Paste_ID` and `Callback` are necessary for the script to work.

If you want to display key information yourself, then the script will automatically pass the variable `key` into the function, which was successfully used.

After all this setup, you will have a working key system integrated with the BloxyBin key system.

## Bypass key

If you want to easily continue developing your script or bypass your own keysystem, you can add a bypass key. Simply input the `Bypass_Key` string into the initialize function and add it to the file location `BloxyBinKeySystem/Keys/(Your paste ID).txt` in the workspace folder. The new table should look like this.
```lua
KeySystem.Initialize({
    Script_Name = "Name of Script",
    Script_Creator = "Script Creator",
    Paste_ID = "Paste ID",
    Bypass_Key = "Whatever string"
    Callback = function(key)
        any_function(key)
    end
})
```

The more complex the bypass key, the harder it is for people to guess. However, people can use other scripts to get the key or "crack" your script by reverse engineering obfuscation, which is why I recommend one of two options.

1) Moving the file somewhere outside of workspace, only putting it in when you are loading your script
2) Not including this in your script

**Use this responsibly**

## Recommended & unrecommended setup
I recommended that you first set your paste to have a Key (Obviously). You can create a key by [going here](https://bloxybin.com/account/dashboard?=key_api) after logging in to BloxyBin and selecting a paste to have a key.

Next, the paste should be a loadstring, leading to the main script. The script itself should be obfuscated since there is a key involved. If you don't have money for one, I suggest using [this Lua Obfuscator](https://luaobfuscator.com). It's free and does a good job of obfuscating scripts.

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



# Hall of shame

Some example of what __**NOT**__ to do as a script creator.

## Exhibit A

<p align="center">
<img src="./ReadMe Things/bad1.png" alt="Image showing someone use no obfuscation and exposes their loadstring.", width="100%">
</p>

This goes against 3 things.
1) The ID isn't actually the same as the link. It leads to a different paste that just has the pure loadstring. This person may not have known that you can edit pastes.
2) They have no obfuscation for the keysystem, meaning someone can remove it.
3) They use `loadstring`, when I said not to.