
Server_Config
	var
		ooc_enabled = 1 // Whether OOC is enabled on the server.
		pvp_enabled = 1 // Whether PVP is enabled on the server.

	proc
		LoadConfig() // The configuration is loaded dynamically from a text file that is stored in plaintext savefile format.
			var config_text = file2text("config/server.txt")
			if(config_text)
				var savefile/F = new()
				F.ImportText("/", config_text)
				if(F["ooc"] != null) ooc_enabled = F["ooc"]
				if(F["pvp"] != null) pvp_enabled = F["pvp"]



var/Server_Config/Server_Config

world
	New()
		..()
		Server_Config = new()
		Server_Config.LoadConfig()