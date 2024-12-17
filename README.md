# ⚠️ SOME EMULATORS WILL NOT CORRECTLY WRITE FILES SUCH AS, BLUESTACKS (FROM MY EXPERIENCE). ⚠️

# Status: Working

# BloxyBin-Key-System
A script that adds a Key System UI using BloxyBins Key System API.

## The purpose
The purpose of me making this script was to help people monetize their script. What I mean by that is allowing creators to make money for their work, with the use of keys. The user generates a key, which in the process can earn you some amount of money, compensating you for your work!
 
I wanted to allow people to have this oppourtinity by utalizing BloxyBin's easy to understand API which generates user keys, earns you some profit, and is completely free to use.

Please Note:
* Security is not garuenteed. I will try to make this library as secure as possible, so bad actors couldn't bypass, but just be aware that bypasses or vulnerabilities may be present. I do not intend for these bypasses or vulnerabilities, and if one does occur I will try to patch it as fast as I could.
* 


# All this will be remade. Better features coming.

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
KeySystem:Initialize({
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

### Logging

If you want to log users, doing so is easy. Simply add another table into the function call names `Logging` Here is an example of what the table should look like. This isn't required to make the script work.
```lua
Logging = {
    Enabled = true,
    URL = "logging URL",
    Bannable = true,
    Type = 1 -- 1 for url arguments, 2 for http body
    Log = {
        HWID = true,
        IP = false, -- NOT RECCOMENDED FOR USER PRIVACY
        UserID = true,
        Username = true,
        Executor = true
    }
}
```
Here you have basic Logging settings, with what to log in the `Log` table (true meaning to log it, and false meaning to no log it) Here's a list of what each setting and log setting is.

* Enabled: A boolean value which simply states weather the logging should be enable or not. Can be helpful for random logs, logging periods, etc.
* URL: A string which tells the script where to send the logged data to. This will simply send a post request, either with the arguemtnts or body. (This goes without saying, but make sure it's your own server or a server that you trust)
* Bannable: A boolean value which states weather a user can be banned from a script. This check will be done in the server, and a value will be returned on weather to kick the user or not.
* Type: A number which tells the script to either send the log data in URL arguemnts, or bodys. (1 being the URL arguments, 2 being the body)
* Log: A table to tell the script what to send in the log report. All are boolean values.
    * HWID: Logs the users HWID. Reccomended as it keeps user privacy while still giving a fingerprint of them
    * IP: Logs the users IP address. Not reccomended as it doesn't keep user privacy.
    * UserID: Logs the users account ID.
    * Username: Logs the users username (Not display name)
    * Executor: Logs the executor that the user is using.

Note that everything is logged, but what is true is only sent to the server.

All together, the final function should look like this (If you decide to log.)

```lua
KeySystem:Initialize({
    -- Script creator and Script name aren't mentioned because we want to fetch them from BloxyBin
    Paste_ID = "Paste ID",
    Callback = function()
        any_function()
    end,
    Logging = { -- Not necessary, but we want to log them for analytic and banning purposes.
        Enabled = true,
        URL = "logging URL",
        Bannable = true,
        Type = 2
        Log = {
            HWID = true,
            IP = false,
            UserID = true,
            Username = true,
            Executor = true
        }
    }
})
```

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

KeySystem:Initialize({
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
 KeySystem:Initialize({
    Script_Name = "Name of Script",
    Script_Creator = "Script Creator",
    Paste_ID = "Paste ID",
    Callback = function()
        loadstring(game:HttpGet("https://example.com/script-location.lua"))() -- Here is the problem
    end
})
 ```
 
You shouldn't do this as a user can use something like HttpSpy to get the loadstring and bypass the key system. The only way to get around this is by obfuscating that script and adding the key system in there **OR THE BETTER OPTION**, putting it all into one script.