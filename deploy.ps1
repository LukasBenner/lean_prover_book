Enable-ExperimentalFeature PSNativeCommandErrorActionPreference
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true


if (Test-Path deploy) {
  Remove-Item deploy -Recurse -Force
}

# 1. Build

& .\lean_source\mkall.bat

& .\Make.bat clean
& .\Make.bat html
& .\Make.bat latexpdf

# 3. Deploy

& git clone git@github.com:YOUR DESTINATION REPOSITORY deploy

Set-Location deploy

if (Test-Path html) {
  Remove-Item .\html -Recurse -Force
}
if (Test-Path src) {
  Remove-Item .\src -Recurse -Force
}

Copy-Item ..\user_repo\* . -Force
Copy-Item ..\leanpkg.path . -Force
Copy-Item ..\leanpkg.toml . -Force


Copy-Item ..\build\html .\html -Recurse -Container
Copy-Item ..\build\latex\title_of_the_book.pdf .
Copy-Item ..\src .\src -Recurse -Container

$DATE=Get-Date

& git add .
& git commit -m "Update $DATE"
& git push


Set-Location ..\.
Remove-Item 'deploy' -Recurse -Force

