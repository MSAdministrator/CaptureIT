<#
.SYNOPSIS
    Capture the Full Screen
.DESCRIPTION
    Capture the Full Screen
.PARAMETER Milliseconds
    Milliseconds between screenshot
.PARAMETER ImageType
    Image type to capture
.EXAMPLE
    Start-FullScreenCapture
.EXAMPLE
    Start-FullScreenCapture -Milliseconds 500 -ImageType jpeg
.NOTES
    This was borrowed from Boe Prox in his Take-ScreenShot PowerShell Function    This function has used some of Boe Prox's Take-ScreenShot PowerShell function  
        Name: Take-ScreenShot 
        Author: Boe Prox 
        DateCreated: 07/25/2010
        Modified Author: Josh Rickard (MSAdministrator)
        Modified Date: 07/07/2018
#>
function Start-FullScreenCapture {
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

        [Parameter(
            Mandatory = $False,
            ValueFromPipelineByPropertyName = $False)]
        [ValidateSet('jpeg', 'png')]
        [string]$ImageType = 'png' 
    )

    Write-Verbose -Message 'Starting Full Screen Capture'

    try {
        Write-Debug -Message 'Getting ScreenCapture Class'
        $ScreenCaptureObject = Import-ScreenCaptureClass -ErrorAction Stop
    }
    catch {
        Write-Error -ErrorRecord $Error[0]
    }

    $varCount = 1
    try {
        if ($pscmdlet.ShouldProcess("Full Screen", "Capturing")) {

            do {
                Write-Output "Press the 'x' key to stop capturing."

                Write-Verbose "Taking screenshot of the entire screen"

                Write-Verbose -Message 'Saving screenshots of the enter screen'
                $TempFileLocation = "$env:TEMP\CaptureIT\ScreenCapture$varCount.$ImageType"

                Write-Verbose -Message "Creating temporary screenshot: $TempFileLocation"
                New-Item -Path $TempFileLocation -Force | Out-Null

                Write-Verbose "Creating Full Screen file: $TempFileLocation"
                $ScreenCaptureObject.CaptureScreenToFile($TempFileLocation, ${ImageType})

                Write-Debug -Message 'Incremeting varCount by 1'
                $varCount++

                while ([console]::KeyAvailable -eq $false) {
                    Start-Sleep -Milliseconds 100
                }

                $CKI = [console]::ReadKey($true)
                Write-Output "You pressed the $($CKI.Key) key."
                    
                if ($CKI.Key -eq 'x') {
                    Write-Progress -Activity 'Creating GIF' -Status 'Creating....'
                    ConvertTo-Gif -FilePath $script:GifFilePath
                    Write-Progress -Activity 'Creating GIF' -Status 'Complete!'
                    return
                }

            } while ($CKI.Key -ne 'x')
        }
    }
    catch {
        Write-Error -ErrorRecord $Error[0]
        exit -1
    }

    Write-Verbose -Message 'Captured Full Screen successfully'
    Write-Output $true
}