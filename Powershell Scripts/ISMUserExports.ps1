<#
./GetISMExports.ps1
#>

<#
$groups = get-content -path "C:\Exports\ISM\ADGroups.csv"
foreach ($GroupName in $groups)


{
    Get-AdGroupMember -Id $GroupName -Recursive | Where objectclass -eq 'user' | Get-ADUser -Properties Displayname,GivenName,Surname,UserPrincipalName,Title,Department,Enabled,ObjectClass, memberof | Select DistinguishedName, samAccountName, Name, Displayname, GivenName, Surname, UserPrincipalName, Title, Department, Enabled, ObjectClass | Export-Csv -path C:\Exports\ISM\ISMVmwareAccess_$month.csv -Append
}
#>

$month = Read-Host -Prompt "Enter MonthYear"

$groups = Get-Content C:\Exports\ISM\ADGroups.csv

$results = foreach ($group in $groups)
{
    Get-ADGroupMember $group | Select-Object -Property name,objectclass,samaccountname
}

$results

$results | Export-csv C:\Exports\ISM\_$month.csv -NoTypeInformation 