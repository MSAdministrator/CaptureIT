---
external help file: CaptureIT-help.xml
Module Name: CaptureIT
online version:
schema: 2.0.0
---

# Start-Capture

## SYNOPSIS

Start creating your gif

## SYNTAX

### Parameter Set 1 (Default)

```powershell
Start-Capture [-Milliseconds <Int32>] -FilePath <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### screen

```powershell
Start-Capture [-Screen] [-Milliseconds <Int32>] -FilePath <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### window

```powershell
Start-Capture [-ActiveWindow] [-Milliseconds <Int32>] -FilePath <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

Start capturing screenshots of either the active window or your full screen and generate a gif

## EXAMPLES

### Example 1

```powershell
PS C:\> Start-Capture -Screen -FilePath "c:\users\msadministrator\Desktop\mynewgif.gif"
```

Capture a GIF of the entire screen and save it in the provided path

## PARAMETERS

### -Screen

Screenshot of the entire screen 

```yaml
Type: SwitchParameter
Parameter Sets: screen
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ActiveWindow

Screenshot of the active window

```yaml
Type: SwitchParameter
Parameter Sets: window
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Milliseconds

Milliseconds between screenshot

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FilePath

Name and location to save the generated gif

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.SwitchParameter

System.Int32
System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
