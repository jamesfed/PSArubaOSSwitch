function Get-ArubaOSLogin
{

<#
.Synopsis
   This function gets a login cookie to use with HPE ArubaOS-Switch Network Switches
.DESCRIPTION
   Use this function to login to the switch before calling other functions in this module (like Get-ArubaOSVlan).
.EXAMPLE
   To login to the switch with Hostname sw-swspare01.example.com with the username manager and password standbyfortitanfall use the following.

   Note that the param $ArubaOS is used to store the result of the function in (to be used in later functions).

   $ArubaOS = Get-ArubaOSLogin -Username manager -Password standbyfortitanfall -Switch sw-swspare01.example.com
#>

param(
    #This set of params are used when the details of the Username/Password/Switch Hostname are in the script
    [Parameter(Mandatory=$true,HelpMessage="Enter the username which has administrative permissions to the switch",ParameterSetName='CredsInScript')]
    [String]$Username,
    [Parameter(Mandatory=$true,HelpMessage="Enter the password of the user previously entered",ParameterSetName='CredsInScript')]
    [String]$Password,
    [Parameter(Mandatory=$true,HelpMessage="Enter the hostname for the switch you are connecting to",ParameterSetName='CredsInScript')]
    [String]$Switch
   )
    
    #Force PowerShell to use TLS1.2
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::TLS12
    
    #Allow the use of self signed certs (to be improved upon in later releases)
    [System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}

    #Build a hash table of the Username and Password
    $HashTable = @{ 
        password = $Password
        userName = $Username
    }

    #Convert the hash table to JSON
    $HashTable = $HashTable | ConvertTo-Json -Compress

    #Get the login cookie
    $ArubaOSCookie = Invoke-RestMethod -Method Post -Uri https://$Switch/rest/v1/login-sessions -Body $HashTable -DisableKeepAlive

    return $ArubaOSCookie.cookie
}