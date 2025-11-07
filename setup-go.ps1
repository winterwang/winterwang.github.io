# Define Go version and installation path
$goVersion = "1.22.5"
$goArch = "amd64"
$installPath = "C:\Users\GQAEC\OneDrive - Bayer\Rprojects\blogdowndown\.tools"
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

# Add Go to the PATH for the current session
$goBinPath = Join-Path $goInstallDir "bin"
$env:PATH = "$goBinPath;" + $env:PATH

Write-Host "Go is ready to use. Go version:"
go version
