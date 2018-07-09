[cmdletbinding()]
Param (
    [switch]$CleanBuild,
    [switch]$InstallModule,
    [switch]$PublishModule,
    [string]$ApiKey,
    [string[]]$PowerShellModules = @("Pester", "Psake", "BuildHelpers", "Plaster", "Platyps"),
    [string[]]$PackageProviders = @('NuGet', 'PowerShellGet')
)


if ($CleanBuild) {
    If (Get-Module -Name CaptureIT) {
        Remove-Module -Name CaptureIT -Force
    }
}

if ($InstallModule) {

    # Install package providers for PowerShell Modules
    ForEach ($Provider in $PackageProviders) {
        If (!(Get-PackageProvider $Provider -ErrorAction SilentlyContinue -Force -ForceBootstrap)) {
            Install-PackageProvider $Provider -Force -ForceBootstrap -Scope CurrentUser
        }
    }

    # Install the PowerShell Modules
    ForEach ($Module in $PowerShellModules) {
        If (!(Get-Module -ListAvailable $Module -ErrorAction SilentlyContinue)) {
            Install-Module $Module -Scope CurrentUser -Force -Repository PSGallery
        }
        Import-Module $Module
    }

    Push-Location $PSScriptRoot
    Write-Output "Retrieving Build Variables"
    Get-ChildItem -Path env:\bh* | Remove-Item
    Set-BuildEnvironment

    if (-not(Get-Module -Name CaptureIT)) {
        Import-Module .\CaptureIT\CaptureIT.psm1
    }
}

if ($PublishModule) {
    If (![string]::IsNullOrEmpty($ApiKey)) {
        $Env:APIKEY = $ApiKey

        Publish-Module -Name CaptureIT -Repository PSGallery -NugetApiKey $env:APIKEY -Verbose
    }
    else {
        Write-Warning -Message 'Unable to publish module because no API key was provided'
        exit -1
    }
}
