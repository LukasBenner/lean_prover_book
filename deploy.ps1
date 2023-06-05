$ErrorActionPreference = "Stop"

if (Test-Path deploy) {
  Remove-Item deploy -Recurse -Force
}

# 1. Build

& python .\lean_source\mkdoc.py

& .\Make.bat clean
& .\Make.bat html
& .\Make.bat latexpdf

# 3. Deploy

& git clone https://github.com/DEST_REPO deploy

Set-Location deploy

if (Test-Path html) {
  Remove-Item .\html -Recurse -Force
}
if (Test-Path src) {
  Remove-Item .\src -Recurse -Force
}

Copy-Item ..\user_repo\. . -Recurse -Force
Copy-Item ..\leanpkg.toml . -Force

Copy-Item ..\build\html .\html -Recurse -Container
Copy-Item ..\build\latex\BOOK_FILE_NAME.pdf . -Force
Copy-Item ..\src .\src -Recurse -Container

$DATE=Get-Date

& git add .
& git commit -m "Update $DATE"
& git push

Set-Location ..\.
Remove-Item 'deploy' -Recurse -Force
