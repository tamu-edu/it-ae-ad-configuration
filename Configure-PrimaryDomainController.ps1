param(
    [Parameter(Mandatory = $true)]
    [String] $DomainName,

    [Parameter(Mandatory = $true)]
    [String] $DirectoryServicesRestoreModePassword
)

begin{
    Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
    Import-Module ADDSDeployment
}
process{
    Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath 'C:\\Windows\\NTDS' -DomainName $DomainName -DomainNetbiosName 'AUTH' -DomainMode 'WinThreshold' -ForestMode 'WinThreshold' -InstallDns:$true -LogPath 'C:\\Windows\\NTDS' -NoRebootOnCompletion:$false -SysvolPath 'C:\\Windows\\SYSVOL' -SafeModeAdministratorPassword (ConvertTo-SecureString $DirectoryServicesRestoreModePassword -AsPlainText -Force) -Force:$true;
}
end{
    exit 0
}