param ($userID1, $userID2) 


<#
Set and View Send on Behalf using PowerShell
.\Set-and-View-Send-on-Behalf-with-PowerShell jbridgeman jsalgado

#>

Set-Mailbox $userID1@mltaikins.com -GrantSendonBehalfTo $userID2@mltaikins.com




