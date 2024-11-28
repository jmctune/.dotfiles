cmd /c mklink /J $env:USERPROFILE\AppData\Local\nvim .config\nvim
rm $env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json; cmd /c mklink /H $env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json microsoft_windows\windows_terminal\settings.json
