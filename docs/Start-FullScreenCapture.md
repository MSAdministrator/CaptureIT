---
external help file: CaptureIT-help.xml
Module Name: CaptureIT
online version:
schema: 2.0.0
---

# Start-FullScreenCapture

## SYNOPSIS

Capture the Full Screen

## SYNTAX

```powershell
Start-FullScreenCapture [-Milliseconds <Int32>] [-ImageType <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Capture the Full Screen

## EXAMPLES

### EXAMPLE 1

```powershell
Start-FullScreenCapture
```

### EXAMPLE 2

```powershell
Start-FullScreenCapture -Milliseconds 500 -ImageType jpeg
```

## PARAMETERS

### -Milliseconds

Milliseconds between screenshot

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 1000
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ImageType

Image type to capture

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Png
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

This was borrowed from Boe Prox in his Take-ScreenShot PowerShell Function    This function has used some of Boe Prox's Take-ScreenShot PowerShell function  
    Name: Take-ScreenShot 
    Author: Boe Prox 
    DateCreated: 07/25/2010
    Modified Author: Josh Rickard (MSAdministrator)
    Modified Date: 07/07/2018

## RELATED LINKS
