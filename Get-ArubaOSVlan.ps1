function Get-ArubaOSVlan
{

<#
.Synopsis
   This function returns the details of an existing VLAN on a ArubaOS-Switch Network Switch
.DESCRIPTION
   This function returns the details of an existing VLAN on a ArubaOS-Switch Network Switch including the VLAN ID, VLAN Name, the Status and Type of the VLAN as well as if Voice, Jumbo Frames and DHCP Snooping is enabled.
.EXAMPLE
   To get infomation about VLAN with ID 5 on the switch sw-swspare01.example.com using the cookie stored in $ArubaOS use the following.

   Get-ArubaOSVlan -ArubaOSCookie $ArubaOSCookie -Switch sw-swspare01.queens.ox.ac.uk -Vlan 5
#>

param(

    #This set of params are used when the details of the Username/Password/WSDL are in the script
    [Parameter(Mandatory=$true,HelpMessage="Provide the Parameter that the login session obtained from Get-ArubaOSLogin")]
    $ArubaOSCookie,
    [Parameter(Mandatory=$true,HelpMessage="Enter the hostname for the switch you are connecting to")]
    [String]$Switch,
    [Parameter(Mandatory=$true,HelpMessage="Enter the VLAN ID to lookup")]
    [ValidateRange(1,4096)]
    [Int]$Vlan
   )
    
    #Force PowerShell to use TLS1.2
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::TLS12
    
    #Allow the use of self signed certs (to be improved upon in later releases)
    [System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}

    #Logout of the switch using the cookie previously obtained
    Invoke-RestMethod -Method Get -Uri https://$Switch/rest/v1/vlans/$Vlan -DisableKeepAlive -Headers @{"cookie"="$ArubaOSCookie"}
}