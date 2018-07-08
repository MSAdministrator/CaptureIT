# CaptureIT

[![Build status](https://ci.appveyor.com/api/projects/status/1q01o9rv2u1cu967?svg=true)](https://ci.appveyor.com/project/MSAdministrator/captureit)

## A PowerShell Module to generate GIFs

CaptureIT can generate GIFs of both:

* The actively selected window
* The entire screen

## Synopsis

A PowerShell Module to generate GIFs of the actively selected window or your entire desktop screen.

## Description

This module takes screenshots of the actively selected window or your entire desktop screen, and generates GIFs from these images.

## Using CaptureIT

To use this module, you will first need to download/clone the repository and import the module:

```powershell
Import-Module .\CaptureIT.psm1
```

Once you have imported the module you can use the main wrapper funtion `Start-Capture` to capture you entire desktop screen.  Additionally, you will need to specify the `FilePath` of your generated GIF.

```powershell
Start-Capture -Screen -FilePath "c:\users\msadministrator\Desktop\mynewgif.gif"
```

If you would like to capture the active window, you will need to specify the switch for `ActiveWindow`:

```powershell
Start-Capture -ActiveWindow -FilePath "c:\users\msadministrator\Desktop\mynewgif.gif"
```

## Notes

```yaml
   Name: CaptureIT
   Created by: Josh Rickard (MSAdministrator)
   Created Date: 07/07/2018 
```

Some of this code was borrowed from Boe Prox's Take-Screenshot PowerShell Function.

## TODO

There are a few issues still that need to be worked out:

* Find a better way to handle keyboard exiting
* Refactor to prompt a user to stop capturing and generate GIF
* Add keyboard exiting logic to the ActiveWindow function
* Plus, i'm sure more!