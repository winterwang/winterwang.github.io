# Resolve project root (directory containing this script)
$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
if (-not $projectRoot -or $projectRoot -eq "") {
    $projectRoot = (Get-Location).Path
}

# Define Go version and installation path
$goVersion = "1.22.5"
$goArch = "amd64"
$installPath = Join-Path $projectRoot ".tools"
$goInstallDir = Join-Path $installPath "go"
$goZipFile = Join-Path $installPath "go${goVersion}.windows-${goArch}.zip"
$goUrl = "https://golang.org/dl/go${goVersion}.windows-${goArch}.zip"

# Ensure the installation directory exists
if (-not (Test-Path -Path $installPath)) {
    New-Item -ItemType Directory -Path $installPath | Out-Null
}

# Check if Go is already installed
if (-not (Test-Path -Path (Join-Path $goInstallDir "bin\go.exe"))) {
    Write-Host "Go is not found. Downloading and installing..."

    # Download Go
    Write-Host "Downloading Go from $goUrl..."
    Invoke-WebRequest -Uri $goUrl -OutFile $goZipFile

    # Unzip Go
    Write-Host "Extracting Go to $goInstallDir..."
    Expand-Archive -Path $goZipFile -DestinationPath $installPath -Force

    # Clean up the zip file
    Remove-Item $goZipFile
} else {
    Write-Host "Go is already installed in $goInstallDir."
}

# Add Go to the PATH for the current session if not already present
$goBinPath = Join-Path $goInstallDir "bin"
if (-not ($env:PATH -split ';' | Where-Object { $_ -eq $goBinPath })) {
    $env:PATH = "$goBinPath;" + $env:PATH
}

Write-Host "Go is ready to use. Go version:"
go version

# Ensure Node.js is available locally (portable install)
$nodeVersion = "20.18.0"
$nodeBaseName = "node-v$nodeVersion-win-x64"
$nodeInstallDir = Join-Path $installPath $nodeBaseName
$nodeZipFile = Join-Path $installPath "$nodeBaseName.zip"
$nodeUrl = "https://nodejs.org/dist/v$nodeVersion/$nodeBaseName.zip"

if (-not (Test-Path -Path (Join-Path $nodeInstallDir "node.exe"))) {
    Write-Host "Node.js is not found. Downloading Node.js $nodeVersion..."
    Invoke-WebRequest -Uri $nodeUrl -OutFile $nodeZipFile
    Write-Host "Extracting Node.js to $nodeInstallDir..."
    Expand-Archive -Path $nodeZipFile -DestinationPath $installPath -Force
    Remove-Item $nodeZipFile
} else {
    Write-Host "Node.js is already installed in $nodeInstallDir."
}

if (Test-Path -Path (Join-Path $nodeInstallDir "node.exe")) {
    if (-not ($env:PATH -split ';' | Where-Object { $_ -eq $nodeInstallDir })) {
        $env:PATH = "$nodeInstallDir;" + $env:PATH
    }

    $npmBinPath = Join-Path $nodeInstallDir "node_modules\npm\bin"
    if ((Test-Path -Path $npmBinPath) -and -not ($env:PATH -split ';' | Where-Object { $_ -eq $npmBinPath })) {
        $env:PATH = "$npmBinPath;" + $env:PATH
    }

    $nodeExe = Join-Path $nodeInstallDir "node.exe"
    $npmCmd = Join-Path $nodeInstallDir "npm.cmd"
    if (Test-Path $nodeExe) {
        Write-Host "Node.js is ready to use. Node version:"
        & $nodeExe -v
    }
    if (Test-Path $npmCmd) {
        Write-Host "npm version:"
        & $npmCmd -v
    }

    # Install project Node dependencies if needed
    $packageJsonPath = Join-Path $projectRoot "package.json"
    $packageLockPath = Join-Path $projectRoot "package-lock.json"
    $nodeModulesDir = Join-Path $projectRoot "node_modules"
    $shouldInstall = $false

    if (Test-Path $packageJsonPath) {
        if (-not (Test-Path $nodeModulesDir)) {
            $shouldInstall = $true
        } elseif (Test-Path $packageLockPath) {
            $nodeModulesInfo = Get-Item $nodeModulesDir
            $packageLockInfo = Get-Item $packageLockPath
            if ($packageLockInfo.LastWriteTimeUtc -gt $nodeModulesInfo.LastWriteTimeUtc) {
                $shouldInstall = $true
            }
        }

        if ($shouldInstall) {
            Write-Host "Installing Node dependencies (npm install)..."
            Push-Location $projectRoot
            try {
                & $npmCmd install --no-audit --no-fund
            } finally {
                Pop-Location
            }
        } else {
            Write-Host "Node dependencies already installed; skipping npm install."
        }
    }

    $projectBinPath = Join-Path $projectRoot "node_modules\.bin"
    if ((Test-Path -Path $projectBinPath) -and -not ($env:PATH -split ';' | Where-Object { $_ -eq $projectBinPath })) {
        $env:PATH = "$projectBinPath;" + $env:PATH
    }
} else {
    Write-Warning "Node.js installation failed or node.exe not found. Tailwind builds may still fail."
}

# Ensure R (including Rscript) is on the PATH for convenience
$rBaseDir = Join-Path $env:LOCALAPPDATA "Programs\R"
$rBinPath = $null
if (Test-Path -Path $rBaseDir) {
    $rCandidate = Get-ChildItem -Path $rBaseDir -Directory | Sort-Object LastWriteTime -Descending | Select-Object -First 1
    if ($rCandidate) {
        $possibleBin = Join-Path $rCandidate.FullName "bin"
        if (Test-Path -Path (Join-Path $possibleBin "Rscript.exe")) {
            $rBinPath = $possibleBin
        }
    }
}

if ($rBinPath) {
    if (-not ($env:PATH -split ';' | Where-Object { $_ -eq $rBinPath })) {
        $env:PATH = "$rBinPath;" + $env:PATH
    }
    Write-Host "Rscript is ready to use. Rscript path: $rBinPath"
    Rscript -e "cat('Rscript version: ', R.version.string, '\n', sep='')"
} else {
    Write-Warning "Rscript.exe was not found. You can install R from https://cran.r-project.org/"
}
