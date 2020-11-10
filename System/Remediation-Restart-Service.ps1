<#
.Synopsis
	Aternity - Remediation Script: Restart-AternityAgent
.DESCRIPTION
	Restart Aternity agent Service (A180WD)
	Use case: fix agent stuck issue
	Tested on Windows 10
	
	References:
	* https://www.aternity.com
	* https://help.aternity.com/search?facetreset=yes&q=remediation

.EXAMPLE
	Deploy in Aternity (Configuration > Remediation > Add Action) 
	Action Name: Restart-Service-xxxx
	Description: Restart-Sercice-xxxx
	Run the script in the System account: checked
	argument : Service name
.VERISON
	Date : 10/11/2020 V1.0
#>

$arguments = $args[0]
$result = ""

try
{
	# Load Agent Module
	Add-Type -Path $env:STEELCENTRAL_ATERNITY_AGENT_HOME\ActionExtensionsMethods.dll
	
	# region Remediation action logic
	# Restart Aternity watchdog service 
	if (!($arguments -eq ""))
		{
		Restart-Service -Name $arguments -Force -ErrorAction Stop
		$service = Get-Service $arguments
		$result = $service.name + " is " + $service.status + "."
		}
	else
		{
		$result = "No Service provided in parameter field"
		}
	#endregion
	# Set Output message
	[ActionExtensionsMethods.ActionExtensionsMethods]::SetScriptOutput($result)
}
catch
{
	[ActionExtensionsMethods.ActionExtensionsMethods]::SetFailed($_.Exception.Message)
}
#EOF
