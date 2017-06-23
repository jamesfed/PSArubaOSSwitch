function Remove-ArubaOSLogin
{

<#
.Synopsis
   This function logs out of the switch by providing it with the cookie obtained from Get-ArubaOSLogin
.DESCRIPTION
   This function logs out of the switch by providing it with the cookie obtained from Get-ArubaOSLogin.
.EXAMPLE
   To logout of the switch sw-swspare01.example.com using the cookie stored in $ArubaOS use the following.

   Remove-ArubaOSLogin -ArubaOSCookie $ArubaOSCookie -Switch sw-swspare01.queens.ox.ac.uk
#>

param(

    #This set of params are used when the details of the Username/Password/WSDL are in the script
    [Parameter(Mandatory=$true,HelpMessage="Provide the Parameter that the login session obtained from Get-ArubaOSLogin")]
    $ArubaOSCookie,
    [Parameter(Mandatory=$true,HelpMessage="Enter the hostname for the switch you are connecting to")]
    [String]$Switch
   )
    
    #Force PowerShell to use TLS1.2
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::TLS12
    
    #Allow the use of self signed certs (to be improved upon in later releases)
    [System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}

    #Logout of the switch using the cookie previously obtained
    Invoke-RestMethod -Method Delete -Uri https://$Switch/rest/v1/login-sessions -DisableKeepAlive -Headers @{"cookie"="$ArubaOSCookie"}

}