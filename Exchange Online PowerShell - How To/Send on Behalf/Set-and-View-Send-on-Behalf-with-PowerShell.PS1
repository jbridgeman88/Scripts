param ($userID1, $userID2) 


<#
Set and View Send on Behalf using PowerShell
.\Set-and-View-Send-on-Behalf-with-PowerShell Jason Jon

#>

Set-Mailbox "$userID1@mltaikins.com -GrantSendonBehalfTo @{add=$userID2@mltaikins.com}" 




