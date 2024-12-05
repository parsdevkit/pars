file(WRITE ${CONFIG_FILE_PATH} "$packageName = '${PROJECT_NAME}'\n")
file(APPEND ${CONFIG_FILE_PATH} "$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)\n")
file(APPEND ${CONFIG_FILE_PATH} "$installDir = Join-Path -Path $env:ProgramFiles -ChildPath $packageName\n")
file(APPEND ${CONFIG_FILE_PATH} "\n")
file(APPEND ${CONFIG_FILE_PATH} "if (-not (Test-Path $installDir)){\n")
file(APPEND ${CONFIG_FILE_PATH} "\tNew-Item -Path $installDir -ItemType Directory | Out-Null\n")
file(APPEND ${CONFIG_FILE_PATH} "}\n")
file(APPEND ${CONFIG_FILE_PATH} "\n")
file(APPEND ${CONFIG_FILE_PATH} "Copy-Item -Path (Join-Path -Path $toolsDir -ChildPath '${APP_NAME}${EXT}') -Destination $installDir -Force\n")
file(APPEND ${CONFIG_FILE_PATH} "\n")
file(APPEND ${CONFIG_FILE_PATH} "Write-Output 'Application installed successfully.'\n")




