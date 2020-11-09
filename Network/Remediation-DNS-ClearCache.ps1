<#
.Synopsis
   Aternity - Remediation Script: Remediation-DNS-ClearCache
.DESCRIPTION
	Clear the device DNS Cache
	
	Aternity References:
	* https://www.aternity.com
	* https://help.aternity.com/search?facetreset=yes&q=remediation

.EXAMPLE
   Deploy in Aternity (Configuration > Remediation > Add Action) 
   Action Name: DNS Clear Cache
   Description: Clear the device DNS Cache
 
.VERSION
Date : 11/09/2020 v1.0 
#>



try
{
	# Load Agent Module
    Add-Type -Path $env:STEELCENTRAL_ATERNITY_AGENT_HOME\ActionExtensionsMethods.dll
    
#region Remediation action logic

$beforeclean = Get-dnsClientcache
$beforecleanNumber = $beforeclean.Count
Clear-DnsClientCache
$AfterClean = Get-dnsClientcache
$AfterCleanNumber = $AfterClean.Count
$result="DNS Cache Cleared from "+ $beforecleanNumber + " Objects to " + $AfterCleanNumber + "."

#endregion

	# Set Output message
    [ActionExtensionsMethods.ActionExtensionsMethods]::SetScriptOutput($result)
}
catch
{
    [ActionExtensionsMethods.ActionExtensionsMethods]::SetFailed($_.Exception.Message)
}

