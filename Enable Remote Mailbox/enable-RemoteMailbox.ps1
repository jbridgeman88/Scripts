param ($userId=hutch)
<#
Perform on SMLTAEX01

Launch Exchange Management Shell


Execute the following
.\enable-RemoteMailbox hutch

#>


enable-RemoteMailbox -remoteroutingaddress  "$userId@mltaikins.onmicrosoft.com" -identity "$userId@mltaikins.com"