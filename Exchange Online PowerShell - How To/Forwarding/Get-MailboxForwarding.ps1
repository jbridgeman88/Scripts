<#
https://o365info.com/forward-mail-powershell-commands-quick/

Sample Results:

DeliverToMailboxAndForward : True
ForwardingAddress          :
ForwardingSmtpAddress      : smtp:cbaird@mltaikins.com


BEFORE RUNNING, RUN THE FOLLOWING:
Get-Module -ListAvailable

*** look for MSOnline in the list of modules, if not there, run:
Install-module -name MSOnline
*** look for AzureAD in the list of modules, if not there, run:
Install-module -name AzureAD

Connect-MsolService
*** complete the sign-in
*** confirm you're signed in by running Get-MsolCompanyInformation



Run the following to check forwarding on a Mailbox:
.\Get-MailboxForwarding jsalgado@mltaikins.com

#>

$userEmail = $args[0]
Get-Mailbox $userEmail | FL DeliverToMailboxAndForward,ForwardingAddress,ForwardingSmtpAddress