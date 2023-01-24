local label = 
[[ 
  //
  || 
  ||
  ||
  ||  ░█▀▀█ ░█▀▀▄  ░█▀▀▄ ░█▀▀▀ ░█──░█ ░█▀▀▀ ░█─── ░█▀▀▀█ ░█▀▀█ ░█▀▄▀█ ░█▀▀▀ ░█▄─░█ ▀▀█▀▀ 
  ||  ░█▄▄▀ ░█─░█  ░█─░█ ░█▀▀▀ ─░█░█─ ░█▀▀▀ ░█─── ░█──░█ ░█▄▄█ ░█░█░█ ░█▀▀▀ ░█░█░█ ─░█── 
  ||  ░█─░█ ░█▄▄▀  ░█▄▄▀ ░█▄▄▄ ──▀▄▀─ ░█▄▄▄ ░█▄▄█ ░█▄▄▄█ ░█─── ░█──░█ ░█▄▄▄ ░█──▀█ ─░█── 
  ||                                                
  ||  
  ||           Created by RD DEVELOPMENT TEAM
  ||]]
  
Citizen.CreateThread(function()
	local CurrentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)
	if not CurrentVersion then
		print('^PushOver Version Check Failed!^7')
	end

	function VersionCheckHTTPRequest()
		PerformHttpRequest('https://github.com/Dndmee/rd-pushveh', VersionCheck, 'GET')
	end

	function VersionCheck(err, response, headers)
		Citizen.Wait(3000)
		if err == 200 then
			local Data = json.decode(response)
			if CurrentVersion ~= Data.NewestVersion then
				print( label )			
				print('  ||    \n  ||    PushOver is outdated!')
				print('  ||    Current version: ^2' .. Data.NewestVersion .. '^7')
				print('  ||    Your version: ^1' .. CurrentVersion .. '^7')
				print('  ||    Please download the lastest version from ^5' .. Data.DownloadLocation .. '^7')
				if Data.Changes ~= '' then
					print('  ||    \n  ||    ^5Changes: ^7' .. Data.Changes .. "\n^0  \\\\\n")
				end
			else
				print( label )			
				print('  ||    ^2PushOver is up to date!\n^0  ||\n  \\\\\n')
			end
		else
			print( label )			
			print('  ||    ^1There was an error getting the latest version information, if the issue persists contact Dndmee#0252 on Discord.\n^0  ||\n  \\\\\n')
		end
		
		SetTimeout(60000000, VersionCheckHTTPRequest)
	end

	VersionCheckHTTPRequest()
end)
