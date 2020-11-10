<#
.Synopsis
   Aternity - Remediation Script: Restart-WindowsSearch
.DESCRIPTION
	Restart Windows Service service
	Use case: fix issues with Windows Search
	Tested on Windows 10
	
	References:
	* https://www.aternity.com
	* https://help.aternity.com/search?facetreset=yes&q=remediation

.EXAMPLE
   Deploy in Aternity (Configuration > Remediation > Add Action) 
   Action Name: Restart-WindowsSearch
   Description: Fix issues with Windows Search
   Run the script in the System account: checked
   
.VERSION
	Date : 11/09/2020 version 1.0   
#>

try
{
	# Load Agent Module
    Add-Type -Path $env:STEELCENTRAL_ATERNITY_AGENT_HOME\ActionExtensionsMethods.dll
	
	#region Remediation action logic

	#Restart the Wsearch service and verify if the service is up
	Restart-Service -Name WSearch -Force -ErrorAction Stop
	$service = Get-Service WSearch
	$result = $service.name + " is " + $service.status
	#endregion

	# Set Output message
    [ActionExtensionsMethods.ActionExtensionsMethods]::SetScriptOutput($result)
}
catch
{
    [ActionExtensionsMethods.ActionExtensionsMethods]::SetFailed($_.Exception.Message)
}
