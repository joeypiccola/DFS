<#
.SYNOPSIS
short desc

.DESCRIPTION
long desc

.NOTES
Author: Joey Piccola
Last Modified: 05/05/16
Version: 11.04.16
#>

[CmdletBinding()]
Param (
    [Parameter()]
    [System.Management.Automation.CredentialAttribute()]$Credential
)

. .\configuration.ps1

DFS -OutputPath .\mofs -ConfigurationData .\ConfigurationData.psd1 -credential $Credential
Copy-Item -Path '.\mofs\*' '\\dscpull01\c$\users\joey.piccola\Desktop\configs\' -Force
Invoke-Command -ComputerName dscpull01 -ScriptBlock {Publish-DSCModuleandMOF -source 'c:\users\joey.piccola\desktop\configs'}