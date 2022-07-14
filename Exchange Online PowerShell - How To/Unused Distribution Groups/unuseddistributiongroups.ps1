install-module ExchangeOnlineManagement 
import-module ExchangeOnlineManagement
Connect-ExchangeOnline
 
 
$VerbosePreference = "Continue"
 
# Get all DGs and historical searches
$DistributionGroups = Get-DistributionGroup -ResultSize Unlimited
$HistoricalSearches = Get-HistoricalSearch -ResultSize Unlimited | Sort-Object SubmitDate -Descending
 
# For each DG, ensure a historical search is started
$SearchesToProcess = $DistributionGroups | 
    ForEach-Object {
        Write-Verbose "Processing $($_.PrimarySMTPAddress) ($($_.Guid))"
        $EmailAddresses = $_.EmailAddresses | Where-Object {$_ -like "smtp:*"} | ForEach-Object {$_ -replace "smtp:",""}
         
        $ReportTitle = "Distribution group mapping - $($_.Guid)"
        $HistoricalSearch = $HistoricalSearches | Where-Object ReportTitle -eq $ReportTitle | Select-Object -First 1
 
        if($HistoricalSearch) {
            Write-Verbose "Found existing historical search '$ReportTitle' with submit date $($HistoricalSearch.SubmitDate)"
 
            if($HistoricalSearch.SubmitDate -lt (Get-Date).AddDays(-7)) {
                Write-Verbose "Existing historical search '$ReportTitle' found, but it is more than 7 days old - starting again"
                Start-HistoricalSearch -RecipientAddress $EmailAddresses -StartDate (Get-Date).AddDays(-90) -EndDate (Get-Date) -ReportType MessageTrace -ReportTitle $ReportTitle
            } else {
                $HistoricalSearch
            }
        } else {
            Write-Verbose "No existing historical search '$ReportTitle' found, creating a new one"
 
            Start-HistoricalSearch -RecipientAddress $EmailAddresses -StartDate (Get-Date).AddDays(-90) -EndDate (Get-Date) -ReportType MessageTrace -ReportTitle $ReportTitle
        }
    } 
 
# Wait for all searches to complete
$Percent = 0
while($SearchesToProcess.ReportStatusDescription -contains "Pending") {
    Write-Verbose "Waiting for historical searches to complete... $Percent %"
    Start-Sleep 60    
     
    # Refresh SearchesToProcess variable
    $SearchesToProcess = $SearchesToProcess | Get-HistoricalSearch
 
    $Percent = $SearchesToProcess |
        ForEach-Object {
            if($_.ReportStatusDescription -eq "Pending") {
                0
            } else {
                100
            }
        } | 
        Measure-Object -Average | 
        Select-Object -ExpandProperty Average
 
    $SearchesToProcess | 
        Select-Object ReportTitle, Status, ReportStatusDescription, JobProgress, @{Label="EstimatedCompletionTime";Expression={$_.EstimatedCompletionTime.ToLocalTime()}} |
        Format-Table
}
 
# Find any result that has more than 0 rows - these are for DGs that has received emails!
$DistributionGroupReport = $SearchesToProcess | 
    ForEach-Object {
        if($_.Status -ne "Done") {
            Write-Host "Job '$($_.JobId)' has status $($_.Status)"
        } else {
            $Guid = $_.ReportTitle -split " - " | Select-Object -Last 1
            $DG = $DistributionGroups | Where-Object Guid -eq $Guid
 
            [PSCustomObject] @{
                DisplayName = $DG.DisplayName 
                GroupType = $DG.GroupType 
                PrimarySmtpAddress = $DG.PrimarySMTPAddress
                Name = $DG.Name 
                Guid = $Guid
                InUse = $_.Rows -gt 0
            }
        } 
    }
 
 
# All distribution groups not in use
$DistributionGroupReport | Where-Object InUse -eq $false | Format-Table