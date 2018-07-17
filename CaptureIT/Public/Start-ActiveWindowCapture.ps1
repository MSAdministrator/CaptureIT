<#
.SYNOPSIS
    Capture the active window
.DESCRIPTION
    Capture the active window
.PARAMETER Milliseconds
    Milliseconds between screenshot
.PARAMETER ImageType
    Image type to capture
.EXAMPLE
    Start-ActiveWindowCapture
.EXAMPLE
    Start-ActiveWindowCapture -Milliseconds 500 -ImageType jpeg
.NOTES
    This was borrowed from Boe Prox in his Take-ScreenShot PowerShell Function    This function has used some of Boe Prox's Take-ScreenShot PowerShell function  
        Name: Take-ScreenShot 
        Author: Boe Prox 
        DateCreated: 07/25/2010
        Modified Author: Josh Rickard (MSAdministrator)
        Modified Date: 07/07/2018
#>
function Start-ActiveWindowCapture {
    [CmdletBinding(DefaultParameterSetName = 'Parameter Set 1',
        SupportsShouldProcess = $true,
        PositionalBinding = $false,
        HelpUri = '',
        ConfirmImpact = 'Medium')]
    Param (
        # Milliseconds between screenshot
        [Parameter(
            Mandatory = $false,
            ValueFromPipelineByPropertyName = $true)]
        [int]$Milliseconds = '1000',

        # Image type to capture
        [Parameter(
            Mandatory = $false,
            ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('jpeg', 'png')]
        [string]$ImageType = 'png'
    )

    Write-Verbose -Message 'Starting Active Window Capture'

    try {
        Write-Debug -Message 'Getting ScreenCapture Class'
        $ScreenCaptureObject = Import-ScreenCaptureClass -ErrorAction Stop
    }
    catch {
        Write-Error -ErrorRecord $Error[0]
    }

    $varCount = 1
    try {
        if ($pscmdlet.ShouldProcess("Active Window", "Capturing")) {
            
            while ($true) {
                Start-Sleep -Milliseconds $Milliseconds

                Write-Verbose "Taking screenshot of the active window"

                Write-Verbose -Message 'Saving screenshots of the active window'
                $TempFileLocation = "$env:TEMP\CaptureIT\ScreenCapture$varCount.$ImageType"
            
                Write-Verbose -Message "Creating temporary screenshot: $TempFileLocation"
                New-Item -Path $TempFileLocation -Force | Out-Null

                Write-Verbose "Creating activewindow file: $TempFileLocation"
                $ScreenCaptureObject.CaptureActiveWindowToFile($TempFileLocation, $ImageType)

                Write-Debug -Message 'Incremeting varCount by 1'
                $varCount++
            }
        }
    }
    catch {
        Write-Error -ErrorRecord $Error[0]
        exit -1
    }

    Write-Verbose -Message 'Captured Active Window successfully'
    Write-Output $true
}