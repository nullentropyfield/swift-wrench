$DebugPreference =  "SilentContinue" #"Continue"

# Delete Tables from Storage

$SubscriptionName="Visual Studio Enterprise with MSDN"

$subscriptions = Get-AzureSubscription -SubscriptionName $SubscriptionName

Select-AzureSubscription -SubscriptionName $SubscriptionName –Default

function Remove-VmArtifacts
{

    $vmName =  $args[0]

    $VM = Get-AzureVM -Name $vmName -ServiceName $vmName

    Remove-AzureVm -Name $vmName -ServiceName $vmName

    Remove-AzureService -ServiceName $vmName -force

   
}

Remove-VmArtifacts "pstest004b"


function Remove-RmVmArtifacts
{

    $vmName = "pstest004b"
    $resourceGroupName = "diagtest"
    $storageAccountName ="diagtest6744"

    $storageAccount = Get-AzureRmStorageAccount -Name $storageAccountName -ResourceGroupName $resourceGroupName

    #Get VM Info
    $VM = Get-AzureRmVm -Name $vmName -ResourceGroupName $resourceGroupName

    # Delete Netowrk
    $networkName = $VM.NetworkInterface[0].name
    Remove-AzureRmNetworkInterface -name $networkName -ResourceGroupName $resourceGroupName -Force


    # Delete VM   
    Remove-AzureRmVm -Name $vmName -ResourceGroupName $resourceGroupName

    Remove-AzureRmNetworkSecurityGroup -Name $vmName -ResourceGroupName $resourceGroupName -Force

    Remove-AzureRmPublicIpAddress -Name $vmName  -ResourceGroupName $resourceGroupName -Force


    # Delete Metric Tables
    $tables = Get-AzureStorageTable -Context $storageAccount.Context
    Foreach ($table in $tables) {

        Remove-AzureStorageTable –Name $table.Name –Context $storageAccount.Context

    }
 }