<#
.SYNOPSIS
    Start creating your gif
.DESCRIPTION
    Start capturing screenshots of either the active window or your full screen and generate a gif
.PARAMETER Screen
    Screenshot of the entire screen 
.PARAMTER ActiveWindow
    Screenshot of the active window 
.PARAMETER Milliseconds
    Milliseconds between screenshot
.PARAMTER FilePath
    Name and location to save the generated gif
.EXAMPLE 1
    Start-Capture -Screen -FilePath "c:\users\msadministrator\Desktop\mynewgif.gif"
.NOTES 
    Name: Start-Capture 
    Author: Josh Rickard (MSAdministrator) 
    DateCreated: 07/07/2018
#>
function Start-Capture {
    [CmdletBinding(DefaultParameterSetName = 'screen',
        SupportsShouldProcess = $true,
        PositionalBinding = $false,
        HelpUri = '',
        ConfirmImpact = 'Medium')]
    Param (
        # Screenshot of the entire screen
        [Parameter(
            Mandatory = $false,
            ParameterSetName = "screen",
            ValueFromPipelineByPropertyName = $true)]
        [switch]$Screen,

        # Screenshot of the active window
        [Parameter(
            Mandatory = $false,
            ParameterSetName = "window",
            ValueFromPipelineByPropertyName = $true)]
        [switch]$ActiveWindow,

        # Milliseconds between screenshot
        [Parameter(
            Mandatory = $false,
            ValueFromPipelineByPropertyName = $true)]
        [int]$Milliseconds = '1000',

        # Name and location to save the generated gif
        [Parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName = $true)]
        [ValidateScript( {
                if ($_ -notmatch "(\.gif)") {
                    throw "The file specified in the path argument must be type of gif"
                }
                return $True
            } )
        ]
        [string]$FilePath
    )

    $script:GifFilePath = $FilePath

    try {
        if (Get-ChildItem -Path "$env:TEMP\CaptureIT\" -ErrorAction SilentlyContinue) {
            try {
                [IO.File]::OpenWrite($file).close();
            }
            catch {}

            Remove-Item -Path "$env:TEMP\CaptureIT\" -Recurse -Force
        }
    }
    catch {
        Write-Error -ErrorRecord $Error[0] -RecommendedAction "Please remove stale screenshots from $env:TEMP\CaptureIT\"
    }

    if ($Screen) {
        if ($pscmdlet.ShouldProcess("Entire Screen", "Begin Capturing")) {
            try {
                Write-Verbose -Message 'Calling Start-FullScreenCapture'
                Start-FullScreenCapture -Milliseconds $Milliseconds
            }
            catch {
                Write-Error -ErrorRecord $Error[0]
                exit -1
            }

            try {
                Write-Verbose -Message 'Attempting to generate gif'

                ConvertTo-Gif -FilePath $script:GifFilePath
            }
            catch {
                Write-Error -ErrorRecord $Error[0]
            }
        }
    }
    elseif ($ActiveWindow) {
        if ($pscmdlet.ShouldProcess("Active Window", "Begin Capturing")) {
            try {
                Write-Verbose -Message 'Calling Start-ActiveWindowCapture'
                Start-ActiveWindowCapture -Milliseconds $Milliseconds
            }
            catch {
                Write-Error -ErrorRecord $Error[0]
                exit -1
            }

            try {
                Write-Verbose -Message 'Attempting to generate gif'

                ConvertTo-Gif -FilePath $script:GifFilePath
            }
            catch {
                Write-Error -ErrorRecord $Error[0]
            }
        }
    }
    else {
        Write-Warning -Message 'Please add a switch to indicate if you want to capture the Full Screen or Active Window'
    }
}