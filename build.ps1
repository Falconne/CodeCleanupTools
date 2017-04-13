Set-StrictMode -Version Latest

$scriptDir = $PSScriptRoot

$ErrorActionPreference = "Stop"

$sln = Join-Path $scriptDir "CodeCleanupTools.sln"

Write-Host "Restoring nuget packages"
$nuget = Join-Path $scriptDir "nuget.exe"
& $nuget restore $sln
if ($LASTEXITCODE -ne 0)
{
    Stop-WithError "Error during nuget restore"
}


$outdir = Join-Path $scriptDir "bin"
if (Test-Path $outdir) { Remove-Item -Recurse $outdir  }

build $sln

Write-Host "All Done"
