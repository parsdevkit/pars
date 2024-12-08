file(WRITE ${CONFIG_FILE_PATH} "$packageName = '${PROJECT_NAME}'\n")
file(APPEND ${CONFIG_FILE_PATH} "$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)\n")
file(APPEND ${CONFIG_FILE_PATH} "$installDir = Join-Path -Path $env:ProgramFiles -ChildPath $packageName -ChildPath 'bin'\n")
file(APPEND ${CONFIG_FILE_PATH} "\n")
file(APPEND ${CONFIG_FILE_PATH} "if (Test-Path $installDir){\n")
file(APPEND ${CONFIG_FILE_PATH} "\tRemove-Item -Path $installDir -Recurse -Force\n")
file(APPEND ${CONFIG_FILE_PATH} "}\n")
file(APPEND ${CONFIG_FILE_PATH} "\n")

file(APPEND ${CONFIG_FILE_PATH} "\n")
file(APPEND ${CONFIG_FILE_PATH} "$appDataDir = [System.IO.Path]::Combine($env:LOCALAPPDATA, $packageName)\n")
file(APPEND ${CONFIG_FILE_PATH} "if (Test-Path $appDataDir){\n")
file(APPEND ${CONFIG_FILE_PATH} "\tRemove-Item -Path $appDataDir -Recurse -Force\n")
file(APPEND ${CONFIG_FILE_PATH} "}\n")
file(APPEND ${CONFIG_FILE_PATH} "\n")
file(APPEND ${CONFIG_FILE_PATH} "Write-Output 'Application removed successfully.'\n")



