function Get-ArubaOSIpAddressSubnet
{

<#
.Synopsis
   This function returns the IP Address configuration of ArubaOS-Switch Network Switch
.DESCRIPTION
   This function returns the IP Address configuration of ArubaOS-Switch Network Switch, 
.EXAMPLE
   To get infomation about the switch sw-swspare01.example.com using the cookie stored in $ArubaOS use the following.

   Get-ArubaOSIpAddressSubnet -ArubaOSCookie $ArubaOSCookie -Switch sw-swspare01.example.com
#>

param(
    [Parameter(Mandatory=$true,HelpMessage="Provide the Parameter that the login session obtained from Get-ArubaOSLogin")]
    $ArubaOSCookie,
    [Parameter(Mandatory=$true,HelpMessage="Enter the hostname for the switch you are connecting to")]
    [String]$Switch
   )
    
    #Force PowerShell to use TLS1.2
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::TLS12
    
    #Allow the use of self signed certs (to be improved upon in later releases)
    [System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}

    #Query the switch for its status
    Invoke-RestMethod -Method Get -Uri https://$Switch/rest/v1/ipaddresses -DisableKeepAlive -Headers @{"cookie"="$ArubaOSCookie"}
}
