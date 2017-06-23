function Get-ArubaOSPort
{

<#
.Synopsis
   This function returns the details of a Port on a ArubaOS-Switch Network Switch
.DESCRIPTION
   This function returns the details of a Port on a ArubaOS-Switch Network Switch including the Port ID, Port Name, Enabled/Disabled State, Config/Trunk mode, Flow Control status and DHCP Snooping Trust status.
.EXAMPLE
   To get infomation about Port with ID 5 on the switch sw-swspare01.example.com using the cookie stored in $ArubaOS use the following.

   Get-ArubaOSPort -ArubaOSCookie $ArubaOSCookie -Switch sw-swspare01.queens.ox.ac.uk -Port 5
#>

param(
    [Parameter(Mandatory=$true,HelpMessage="Provide the Parameter that the login session obtained from Get-ArubaOSLogin")]
    $ArubaOSCookie,
    [Parameter(Mandatory=$true,HelpMessage="Enter the hostname for the switch you are connecting to")]
    [String]$Switch,
    [Parameter(Mandatory=$true,HelpMessage="Enter the Port ID to lookup")]
    [Int]$Port
   )
    
    #Force PowerShell to use TLS1.2
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::TLS12
    
    #Allow the use of self signed certs (to be improved upon in later releases)
    [System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}

    #Logout of the switch using the cookie previously obtained
    Invoke-RestMethod -Method Get -Uri https://$Switch/rest/v1/ports/$Port -DisableKeepAlive -Headers @{"cookie"="$ArubaOSCookie"}
}