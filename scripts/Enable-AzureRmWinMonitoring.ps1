$DebugPreference =  "Continue" #"SilentContinue"

#Login-AzureRmAccount


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
    $configPath = "{0}\..\configs\WinWadConfig.xml" -f $PSScriptRoot

    Set-AzureRmVMDiagnosticsExtension  -ResourceGroupName $resourceGroupName -VMName $VM.name -DiagnosticsConfigurationPath $configPath -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey

}

function Test-RmEnabled
{

    <#

    .SYNOPSIS
    Test if Azure Monitoring for Win VMs is enabled in ARM

    .PARAMETER resourceGroupName 
    the resource group name for the VM

    .PARAMETER vmName
    the name of the VM

    #>

    $resourceGroupName = $args[0]
    $vmName = $args[1]
   
    # Check if enabled
    $extension = Get-AzureRmVMDiagnosticsExtension -ResourceGroupName $resourceGroupName -VMName $vmName
    
    if($extension){
        return $true
    }
    else
    {
        return $false
    }

}

#Get VM
$resourceGroupName = "diagtest"
$vmName = "pstest005a"
$VM = Get-AzureRMVM -ResourceGroupName $resourceGroupName -Name $vmName

# Get Storage Account and info
$storageAccountName = $env:RmStorageName
$storageAccountKey = $env:RmStorageKey

$StorageAccount = Get-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName

# Get Config Path
Enable-AzureRmWinMonitoring $VM $resourceGroupName $storageAccountName $storageAccountKey

#Test-RmEnabled $resourceGroupName $vmName
