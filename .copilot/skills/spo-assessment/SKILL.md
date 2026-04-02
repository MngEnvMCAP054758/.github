---
name: spo-assessment
description: "Run the full SPO Storage Assessment workflow: connect to VM, execute scripts 0-5, collect CSVs, transfer locally, update Power BI."
---

# SPO Assessment Execution

## Trigger
"run spo assessment", "run the scripts", "execute the assessment"

## VM Details
- Name: vm-spo-assess
- IP: 20.91.186.25
- User: azadmin
- Resource Group: rg-spo-assessment
- Scripts location on VM: C:\Users\azadmin\Desktop\Scripts\

## Execution Order
1. Ensure VM is running
2. Script 0: `0_SPO_Assessment_PreRequisites.ps1` — validates certificates, connections
3. Script 0b: `0_SPO_Assessment_TenantMetrics.ps1` — tenant-level storage metrics
4. Script 1: `1_SPO_SiteOrchestrator.ps1` → SPO_SitesStorage.csv (37 cols)
5. Script 2: `2_SPO_LibraryOrchestrator.ps1` → SPO_LibrariesStorage.csv (17 cols)
6. Script 3: `3_SPO_FileOrchestrator.ps1` → SPO_FilesStorage.csv (10 cols)
7. Script 4: `4_SPO_SiteMembershipOrchestrator.ps1` → SPO_SitesMembership.csv (3 cols)
8. Script 5: `5_SPO_VideosOrchestrator.ps1` → SPO_VideosMetrics.csv (13 cols)

## Post-Execution
1. Transfer all CSVs to local: `C:\Users\v-amera\Downloads\SPO_Assessment\Export\`
2. Transfer PBIX if needed
3. Note: Power BI data source path needs manual update in PBI Desktop

## Known Bug Fixes Applied
- Functions.ps1: `continue` → `return` in search result processing
- MembershipOrchestrator: variable declaration ordering fix
- Videos.ps1: API path `alltime` → `allTime` (case-sensitive)
