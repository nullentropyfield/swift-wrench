$DebugPreference =  "Continue" #"SilentContinue"

Login-AzureRmAccount


function Enable-AzureRmWinMonitoring
{

    <#

    .SYNOPSIS
    Enable Azure Monitoring for Linux VMs in ARM

    .PARAMETER VM 
    the linux VM

    .PARAMETER StorageAccount
    the storage account where monitoring data is stored

    .PARAMETER storageAccountKey
    the storage account key where monitoring data is stored

    .NOTES
    Tested the following:
        RM Win VM

    #>

    $VM = $args[0]
    $resourceGroupName = $args[1]
    $storageAccountName = $args[2]
    $storageAccountKey = $args[3]
   

    #!! The config has a hard-coded resourceID
    $Config_Path = "C:\Users\brlamore\OneDrive - Microsoft\PowershellScripts\WadConfig.xml"

    Set-AzureRmVMDiagnosticsExtension  -ResourceGroupName $resourceGroupName -VMName $VM.name -DiagnosticsConfigurationPath $Config_Path -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey

}

#Get VM
$resourceGroupName = "diagtest"
$vmName = "pstest004a"
$VM = Get-AzureRMVM -ResourceGroupName $resourceGroupName -Name $vmName

# Get Storage Account and info
$storageAccountName ="diagtest6744"
$storageAccountKey = "bzju6LaboFuuGQX99JAy2/38rkFcDXiJX07DlBJ21/2lEvutoxp8wWsKaYkkQvHgBD0/rkY2x2rwQ6s5wsNm+w=="
$StorageAccount = Get-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName


Enable-AzureRmWinMonitoring $VM $resourceGroupName $storageAccountName $storageAccountKey

# Check if enabled
$extension = Get-AzureRmVMDiagnosticsExtension -ResourceGroupName $resourceGroupName -VMName $vmName
$extension.PublicSettings


#Set-AzureRmDiagnosticSetting -Enabled $true -ResourceId $VM.Id -StorageAccountId $StorageAccount.Id