<#
.SYNOPSIS
    Convert a set of images into a GIF
.DESCRIPTION
    Convert a set of images (png or jpeg) into a GIF to share with the world!
.PARAMETER FilePath
    Name and location to save the generated gif
.EXAMPLE
    ConvertTo-Gif -FilePath "c:\users\msadministrator\Desktop\mynewgif.gif"
.NOTES
    Name: ConvertTo-Gif 
    Author: Josh Rickard (MSAdministrator) 
    DateCreated: 07/07/2018
#>
function ConvertTo-Gif {
    [CmdletBinding(DefaultParameterSetName = 'Parameter Set 1',
        PositionalBinding = $false,
        HelpUri = '',
        ConfirmImpact = 'Medium')]
    Param (
        # Name and location to save the generated gif
        [Parameter(
            Mandatory = $True,
            ValueFromPipelineByPropertyName = $true)]
        [ValidateScript( {
                if ($_ -notmatch "(\.gif)") {
                    throw "The file specified in the path argument must be type of gif"
                }
                return $true
            } )
        ]
        [string]$FilePath
    )

    if (-not(Get-ChildItem -Path "$env:TEMP\CaptureIT\" -ErrorAction SilentlyContinue)) {
        Write-Error -Message 'There are no screenshots available to create GIF from'
        exit -1
    }

    $ScreenShotImages = (Get-ChildItem -Path "$env:TEMP\CaptureIT\").FullName

    try {
        if (-not(Get-ChildItem -Path $FilePath -ErrorAction SilentlyContinue)) {
            New-Item -Path $FilePath -Force
        }
    }
    catch {
        Write-Error -ErrorRecord $Error[0] -RecommendedAction 'Ensure that you have access to create files in the provided filepath location'
    }

    try {
        Write-Verbose -Message 'Creating GitWriter object'

        $GifWriterObject = Import-GifWriterClass

        foreach ($image in $ScreenShotImages) {
            [System.Drawing.Image]$imageObject = [System.Drawing.Image]::FromFile("$image")
            $GifWriterObject.WriteFrame([System.Drawing.Image]$imageObject)

            $imageObject = $null
        }

        $GifWriterObject.Dispose()
        Write-Output $True
    }
    catch {
        Write-Error -ErrorRecord $Error[0]
        exit -1
    }
}