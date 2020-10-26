<#
.Synopsis
	Aternity - Remediation Script: Aternity-LaunchRecorder
.DESCRIPTION
	Launch Aternity Recorder
	
	References:
	* https://www.aternity.com
	* https://help.aternity.com/search?facetreset=yes&q=remediation

.EXAMPLE
	Deploy in Aternity (Configuration > Remediation > Add Action) 
	Action Name: Aternity-LaunchRecorder
	Description: Launch Aternity Recorder
	Run the script in the System account: checked

.VERSION
	v1.0 2020/10/26
#>

try
{
	# Load Agent Module
    Add-Type -Path $env:STEELCENTRAL_ATERNITY_AGENT_HOME\ActionExtensionsMethods.dll
	
	#region Remediation action logic

		# Add your remediation code here and set the variable $result with the Output Message to be visible visible in Aternity's dashboards.
		#
		# For example:
		# 	Clear-DnsClientCache
		# 	$result="DNS Cache Cleared"

$recorderPath = "$env:STEELCENTRAL_ATERNITY_AGENT_HOME\..\Assistant\AternityRecorder.exe"

if (! (Test-Path -Path $recorderPath)) {
    throw "Could not find Aternity Recorder in $recorderPath"
}
else {
	Start-Process -FilePath "$recorderPath" 
	$result = "Recorder Launched"
}
	
	#endregion

	# Set Output message
	[ActionExtensionsMethods.ActionExtensionsMethods]::SetScriptOutput($result)
}
catch
{
	[ActionExtensionsMethods.ActionExtensionsMethods]::SetFailed($_.Exception.Message)
}
