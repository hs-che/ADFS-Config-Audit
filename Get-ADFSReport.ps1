<#
 
.SYNOPSIS
Simple script to document ADFS configuration details to a text file
No parameters, simply launch
based on https://jorgequestforknowledge.wordpress.com/2014/03/12/additional-powershell-scripts-for-migrating-adfs-v2-x-to-adfs-v3-0/
edited by Nils Kaczenski, michael-wessel.de
Date/version: 2015-04-29-10-50


#>

$myDate = Get-Date -Format 'yyyyMMdd-HHmmss'

###### EDIT HERE ###############
# File name for output (edit path)
$OutFile = "C:\install\ADFS-Config-$env:COMPUTERNAME-$myDate.txt"
###### END EDIT ################

'wait ...'
"writing ADFS data to $OutFile"

'ADFS configuration information' | Out-File $OutFile -Append
'ADFS farm: ' + (Get-AdfsProperties).DisplayName | Out-File $OutFile -Append
'Date: ' + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss') | Out-File $OutFile -Append
'*' * 80 | Out-File $OutFile -Append

# Record ADFS Service Properties
'ADFS Service Properties' | Out-File $OutFile -Append
'*' * 80 | Out-File $OutFile -Append
Get-Service -Name ADFSSRV | Select * | Out-File $OutFile -Append
Get-WmiObject win32_service | ?{$_.name -eq "ADFSSRV"} | Select * | Out-File $OutFile -Append
# Record All ADFS Properties
'All ADFS Properties' | Out-File $OutFile -Append
'*' * 80 | Out-File $OutFile -Append
Get-ADFSProperties | Out-File $OutFile -Append
# Record All ADFS Endpoints
'All ADFS Endpoints' | Out-File $OutFile -Append
'*' * 80 | Out-File $OutFile -Append
Get-ADFSEndpoint | Out-File $OutFile -Append
# Record All ADFS Claim Descriptions
'All ADFS Claim Descriptions' | Out-File $OutFile -Append
'*' * 80 | Out-File $OutFile -Append
Get-ADFSClaimDescription | Out-File $OutFile -Append
# Record All ADFS Certificates
'All ADFS Certificates' | Out-File $OutFile -Append
'*' * 80 | Out-File $OutFile -Append
Get-ADFSCertificate | Out-File $OutFile -Append
# Record All ADFS Claims Provider Trusts
'All ADFS Claims Provider Trusts' | Out-File $OutFile -Append
'*' * 80 | Out-File $OutFile -Append
Get-ADFSClaimsProviderTrust | Out-File $OutFile -Append
# Record All ADFS Relying Party Trusts
'All ADFS Relying Party Trusts' | Out-File $OutFile -Append
'*' * 80 | Out-File $OutFile -Append
Get-ADFSRelyingPartyTrust | Out-File $OutFile -Append
# Record All ADFS Attribute Stores
'All ADFS Attribute Stores' | Out-File $OutFile -Append
'*' * 80 | Out-File $OutFile -Append
Get-ADFSAttributeStore | %{
    "##########" | Out-File $OutFile -Append
    "Store Name. = " + $_.Name | Out-File $OutFile -Append
    "Store Class = " + $_.StoreTypeQualifiedName | Out-File $OutFile -Append
    "Store Config:" | Out-File $OutFile -Append
    $_.Configuration.GetEnumerator() | %{
        "  * " + $_.Name + " = " + $_.Value | Out-File $OutFile -Append
    }
    "" | Out-File $OutFile -Append
}
'finished'