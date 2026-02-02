PARAM()

# Configuration
$currentDir = Get-Location
$modName = "Exoskeleton Mark II"
$destinationDir = Join-Path $env:APPDATA "Factorio\mods\$modName"
$factorioExePath = "${env:ProgramFiles(x86)}\Steam\steamapps\common\Factorio\bin\x64\factorio.exe"

try {
    # Clean existing mod directory
    if (Test-Path $destinationDir) {
        Remove-Item $destinationDir -Recurse -Force
    }
    New-Item -ItemType Directory -Path $destinationDir | Out-Null

    # Copy all files excluding .git and the script itself
    $exclude = @('.git', 'debug', '.vscode')
    Get-ChildItem -Path $currentDir -Exclude $exclude | ForEach-Object {
        Copy-Item -Path $_.FullName -Destination $destinationDir -Recurse -Force
    }

    # Restart Factorio
    $factorioProcess = Get-Process factorio -ErrorAction SilentlyContinue
    if ($factorioProcess) {
        Stop-Process -Name factorio -Force
        Start-Sleep -Seconds 2
    }

    if (Test-Path $factorioExePath) {
        Start-Process $factorioExePath
    }
    else {
        Write-Host "Factorio executable not found at: $factorioExePath" -ForegroundColor Red
    }

    Write-Host "Deployment completed successfully!" -ForegroundColor Green
}
catch {
    Write-Host "An error occurred: $_" -ForegroundColor Red
}