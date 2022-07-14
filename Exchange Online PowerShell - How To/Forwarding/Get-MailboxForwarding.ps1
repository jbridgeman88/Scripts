<#
https://o365info.com/forward-mail-powershell-commands-quick/

Sample Results:

DeliverToMailboxAndForward : True
ForwardingAddress          :
ForwardingSmtpAddress      : smtp:cbaird@mltaikins.com

Run the following to check forwarding on a Mailbox:
.\Get-MailboxForwarding.ps1 jsalgado

#>

$userEmail = $args[0]
Get-Mailbox $userEmail@mltaikins.com | FL DeliverToMailboxAndForward,ForwardingAddress,ForwardingSmtpAddress