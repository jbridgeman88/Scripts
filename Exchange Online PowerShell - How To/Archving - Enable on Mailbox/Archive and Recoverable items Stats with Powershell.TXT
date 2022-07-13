
Removing and Creating a New Online Archive
https://newsignature.com/articles/removing-and-creating-new-office-365-online-archive/




 Get-MailboxFolderStatistics -Identity gfleetwood@mltaikins.com -FolderScope RecoverableItems |Format-Table Name,FolderAndSubfolderSize,ItemsInFolderandSubfolders

Name                                    FolderAndSubfolderSize           ItemsInFolderAndSubfolders
----                                    ----------------------           --------------------------
Recoverable Items                       100.9 GB (108,293,026,040 bytes)                     130565
Audits                                  16.09 MB (16,868,968 bytes)                            3304
Calendar Logging                        6.323 MB (6,630,362 bytes)                              161
Deletions                               54.15 MB (56,775,230 bytes)                              60
DiscoveryHolds                          100.3 GB (107,659,025,054 bytes)                     124597
SearchDiscoveryHoldsFolder              0 B (0 bytes)                                             0
SearchDiscoveryHoldsUnindexedItemFolder 789 MB (827,372,723 bytes)                              858
Purges                                  2.035 MB (2,134,370 bytes)                              247
SubstrateHolds                          0 B (0 bytes)                                             0
Versions                                526 MB (551,592,056 bytes)                             2196



Get-MailboxFolderStatistics -Identity gfleetwood@mltaikins.com -FolderScope Archive |Format-Table
Name,FolderAndSubfolderSize,ItemsInFolderandSubfolders

Name    FolderAndSubfolderSize  ItemsInFolderAndSubfolders
----    ----------------------  --------------------------
Archive 75.92 KB (77,744 bytes)                          1




Get-MailboxStatistics -Identity gfleetwood@mltaikins.com -Archive | Select DisplayName, StorageLim
itStatus, TotalItemSize, TotalDeletedItemSize, ItemCount, DeletedItemCount


DisplayName          : In-Place Archive -Gregory M. Fleetwood
StorageLimitStatus   :
TotalItemSize        : 18.37 GB (19,728,154,874 bytes)
TotalDeletedItemSize : 158.2 GB (169,879,047,756 bytes)
ItemCount            : 113472
DeletedItemCount     : 665071



Get-MailboxStatistics -Identity gfleetwood@mltaikins.com -Archive | Select DisplayName, StorageLim
itStatus, TotalItemSize, TotalDeletedItemSize, ItemCount, DeletedItemCount
Creating a new Remote PowerShell session using MFA for implicit remoting of "Get-MailboxStatistics" command ...


DisplayName          : In-Place Archive -Gregory M. Fleetwood
StorageLimitStatus   :
TotalItemSize        : 18.37 GB (19,728,154,874 bytes)
TotalDeletedItemSize : 158.2 GB (169,879,047,756 bytes)
ItemCount            : 113472
DeletedItemCount     : 665071



Get-Mailbox gfleetwood@mltaikins.com | FL Name,RecoverableItemsQuota,RecoverableItemsWarningQuota


Name                         : Greg M. Fleetwood
RecoverableItemsQuota        : 110 GB (118,111,600,640 bytes)
RecoverableItemsWarningQuota : 100 GB (107,374,182,400 bytes)



Get-Mailbox gfleetwood@mltaikins.com |fl Name, *archive*


Name                        : Greg M. Fleetwood
ArchiveDatabase             : CANPR01DG132-db107
ArchiveDatabaseGuid         : 8406e4ec-b91a-4446-8938-2edbe047c5e0
ArchiveGuid                 : fecc102c-40ba-4af1-9c9c-10246a0701a8
ArchiveName                 : {In-Place Archive -Gregory M. Fleetwood}
JournalArchiveAddress       :
ArchiveQuota                : 130 GB (139,586,437,120 bytes)
ArchiveWarningQuota         : 120 GB (128,849,018,880 bytes)
ArchiveDomain               :
ArchiveStatus               : Active
ArchiveState                : Local
AutoExpandingArchiveEnabled : True
DisabledArchiveDatabase     :
DisabledArchiveGuid         : 00000000-0000-0000-0000-000000000000
ArchiveRelease              :









