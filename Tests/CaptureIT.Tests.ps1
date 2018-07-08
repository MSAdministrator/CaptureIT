$here = "$(Split-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -Parent)\CaptureIT"

$module = 'CaptureIT'

Describe "$module PowerShell Module Tests" {
    
    Context 'Module Setup' {

        It "has the root module $module.psm1" {
            "$here\$module.psm1" | Should exist
        }

        It "has the manifest file $module.psd1" {
            "$here\$module.psd1" | should exist
            "$here\$module.psd1" | Should contain "$module.psm1"
        }

        It "$module has functions" {
            "$here\Public\*.ps1" | Should exist
            "$here\Private\*.ps1" | should exist
        }

        It "$module is valid PowerShell Code" {
            $psFile = Get-Content -Path "$here\$module.psm1" -ErrorAction Stop
            $errors = $null

            $null = [System.Management.Automation.PSParser]::Tokenize($psFile, [ref]$errors)
            $errors.count | Should be 0
        }
    }
}



$pubFunctions = ('ConvertTo-Gif',
                 'Start-ActiveWindowCapture',
                 'Start-FullScreenCapture',
                 'Start-Capture'

)

$privFunctions = ('New-GifWriterClass',            
                  'New-ScreenCaptureClass'
)

$folders = ( 'Public',
             'Private'
)


foreach ($folder in $folders) {
    Describe 'Folders Tests' {
            
        It "$folder should exist" {
            "$here\$Folder" | Should Exist
        }
    }
}

Describe 'Function Tests' {
    foreach ($function in $pubFunctions) {
        Context 'Public Functions' {

            It "$function.ps1 should exist" {
                "$here\Public\$function.ps1" | Should Exist
            }

            It "$function.ps1 should have help block" {
                "$here\Public\$function.ps1" | Should contain '<#'
                "$here\Public\$function.ps1" | Should contain '#>'
            }
            
            It "$function.ps1 should have a SYNOPSIS section in the help block" {
                "$here\Public\$function.ps1" | Should contain '.SYNOPSIS'
            }

            It "$function.ps1 should have a DESCRIPTION section in the help block" {
                "$here\Public\$function.ps1" | Should contain '.DESCRIPTION'
            }

            It "$function.ps1 should have a EXAMPLE section in the help block" {
                "$here\Public\$function.ps1" | Should contain '.EXAMPLE'
            }

            It "$function.ps1 should be an advanced function" {
                "$here\Public\$function.ps1" | Should contain 'function'
                "$here\Public\$function.ps1" | Should contain 'CmdLetBinding'
                "$here\Public\$function.ps1" | Should contain 'param'
            }

            It "$function.ps1 should contain Write-Verbose blocks" {
                "$here\Public\$function.ps1" | Should contain 'Write-Verbose'
            }

            It "$function.ps1 is valid PowerShell code" {
                $psFile = Get-Content -Path "$here\Public\$function.ps1" -ErrorAction Stop
                $errors = $null

                $null = [System.Management.Automation.PSParser]::Tokenize($psFile, [ref]$errors)
                $errors.count | Should be 0
            } 
        }# Context Public Function Tests
    } # foreach for public functions

    foreach ($function in $privFunctions) {
        Context 'Private Functions' {

            It "$function.ps1 should exist" {
                "$here\Private\$function.ps1" | Should Exist
            }

            It "$function.ps1 should have help block" {
                "$here\Private\$function.ps1" | Should contain '<#'
                "$here\Private\$function.ps1" | Should contain '#>'
            }
            
            It "$function.ps1 should have a SYNOPSIS section in the help block" {
                "$here\Private\$function.ps1" | Should contain '.SYNOPSIS'
            }

            It "$function.ps1 should have a DESCRIPTION section in the help block" {
                "$here\Private\$function.ps1" | Should contain '.DESCRIPTION'
            }

            It "$function.ps1 should have a EXAMPLE section in the help block" {
                "$here\Private\$function.ps1" | Should contain '.EXAMPLE'
            }

            It "$function.ps1 should be an advanced function" {
                "$here\Private\$function.ps1" | Should contain 'function'
                "$here\Private\$function.ps1" | Should contain 'CmdLetBinding'
                "$here\Private\$function.ps1" | Should contain 'param'
            }

            It "$function.ps1 should contain Write-Verbose blocks" {
                "$here\Private\$function.ps1" | Should contain 'Write-Verbose'
            }

            It "$function.ps1 is valid PowerShell code" {
                $psFile = Get-Content -Path "$here\Private\$function.ps1" -ErrorAction Stop
                $errors = $null

                $null = [System.Management.Automation.PSParser]::Tokenize($psFile, [ref]$errors)
                $errors.count | Should be 0
            }
        } # Context Private Function Tests
    } # end of foreach
} # end of describe block