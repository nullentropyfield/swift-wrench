Login-AzureRmAccount

$DebugPreference = "Continue" 


function Create-AzureVMDiagnosticResourceId
{
    <#

    .SYNOPSIS
    Creates a resourceId given a subscription and vm

    .PARAMETER subscriptionId 
    the subscriptionId where the vm lives

    .PARAMETER vmName    
    name of the vm

    .NOTES
    Tested the following:
        Classic Linux VM

    #>

    # Pattern for ASM Linux VM
    #"/subscriptions/bdbd15ff-95ed-430a-a857-552511111874/resourceGroups/bxtest3/providers/Microsoft.ClassicCompute/virtualMachines/bxtest3"
    $subscriptionId = $args[0]
    $resourceGroupName = $args[1]
    $provider = "Microsoft.ClassicCompute"
    $vmName = $args[1]

    "/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/$provider/virtualMachines/$vmName"
}


function Create-AzureMonitoringXmlConfig
{
    <#

    .SYNOPSIS
    Creates an Azure MOnitoring Xml Config file for a Linux vm (Classic or Arm)

    .PARAMETER vmResourceId 
    the subscriptionId where the vm lives

    .NOTES
    Tested the following:
        Classic Linux VM

    #>

    $xmlTemplate = '<WadCfg><DiagnosticMonitorConfiguration overallQuotaInMB="4096"><DiagnosticInfrastructureLogs scheduledTransferPeriod="PT1M" scheduledTransferLogLevelFilter="Warning"/><PerformanceCounters scheduledTransferPeriod="PT1M"><PerformanceCounterConfiguration counterSpecifier="\Memory\AvailableMemory" sampleRate="PT15S" unit="Bytes"><annotation displayName="Memory available" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Memory\PercentAvailableMemory" sampleRate="PT15S" unit="Percent"><annotation displayName="Mem. percent available" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Memory\UsedMemory" sampleRate="PT15S" unit="Bytes"><annotation displayName="Memory used" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Memory\PercentUsedMemory" sampleRate="PT15S" unit="Percent"><annotation displayName="Memory percentage" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Memory\PercentUsedByCache" sampleRate="PT15S" unit="Percent"><annotation displayName="Mem. used by cache" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Memory\PagesPerSec" sampleRate="PT15S" unit="CountPerSecond"><annotation displayName="Pages" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Memory\PagesReadPerSec" sampleRate="PT15S" unit="CountPerSecond"><annotation displayName="Page reads" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Memory\PagesWrittenPerSec" sampleRate="PT15S" unit="CountPerSecond"><annotation displayName="Page writes" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Memory\AvailableSwap" sampleRate="PT15S" unit="Bytes"><annotation displayName="Swap available" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Memory\PercentAvailableSwap" sampleRate="PT15S" unit="Percent"><annotation displayName="Swap percent available" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Memory\UsedSwap" sampleRate="PT15S" unit="Bytes"><annotation displayName="Swap used" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Memory\PercentUsedSwap" sampleRate="PT15S" unit="Percent"><annotation displayName="Swap percent used" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Processor\PercentIdleTime" sampleRate="PT15S" unit="Percent"><annotation displayName="CPU idle time" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Processor\PercentUserTime" sampleRate="PT15S" unit="Percent"><annotation displayName="CPU user time" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Processor\PercentNiceTime" sampleRate="PT15S" unit="Percent"><annotation displayName="CPU nice time" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Processor\PercentPrivilegedTime" sampleRate="PT15S" unit="Percent"><annotation displayName="CPU privileged time" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Processor\PercentInterruptTime" sampleRate="PT15S" unit="Percent"><annotation displayName="CPU interrupt time" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Processor\PercentDPCTime" sampleRate="PT15S" unit="Percent"><annotation displayName="CPU DPC time" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Processor\PercentProcessorTime" sampleRate="PT15S" unit="Percent"><annotation displayName="CPU percentage guest OS" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Processor\PercentIOWaitTime" sampleRate="PT15S" unit="Percent"><annotation displayName="CPU IO wait time" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\PhysicalDisk\BytesPerSecond" sampleRate="PT15S" unit="BytesPerSecond"><annotation displayName="Disk total bytes" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\PhysicalDisk\ReadBytesPerSecond" sampleRate="PT15S" unit="BytesPerSecond"><annotation displayName="Disk read guest OS" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\PhysicalDisk\WriteBytesPerSecond" sampleRate="PT15S" unit="BytesPerSecond"><annotation displayName="Disk write guest OS" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\PhysicalDisk\TransfersPerSecond" sampleRate="PT15S" unit="CountPerSecond"><annotation displayName="Disk transfers" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\PhysicalDisk\ReadsPerSecond" sampleRate="PT15S" unit="CountPerSecond"><annotation displayName="Disk reads" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\PhysicalDisk\WritesPerSecond" sampleRate="PT15S" unit="CountPerSecond"><annotation displayName="Disk writes" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\PhysicalDisk\AverageReadTime" sampleRate="PT15S" unit="Seconds"><annotation displayName="Disk read time" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\PhysicalDisk\AverageWriteTime" sampleRate="PT15S" unit="Seconds"><annotation displayName="Disk write time" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\PhysicalDisk\AverageTransferTime" sampleRate="PT15S" unit="Seconds"><annotation displayName="Disk transfer time" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\PhysicalDisk\AverageDiskQueueLength" sampleRate="PT15S" unit="Count"><annotation displayName="Disk queue length" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\NetworkInterface\BytesTransmitted" sampleRate="PT15S" unit="Bytes"><annotation displayName="Network out guest OS" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\NetworkInterface\BytesReceived" sampleRate="PT15S" unit="Bytes"><annotation displayName="Network in guest OS" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\NetworkInterface\PacketsTransmitted" sampleRate="PT15S" unit="Count"><annotation displayName="Packets sent" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\NetworkInterface\PacketsReceived" sampleRate="PT15S" unit="Count"><annotation displayName="Packets received" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\NetworkInterface\BytesTotal" sampleRate="PT15S" unit="Bytes"><annotation displayName="Network total bytes" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\NetworkInterface\TotalRxErrors" sampleRate="PT15S" unit="Count"><annotation displayName="Packets received errors" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\NetworkInterface\TotalTxErrors" sampleRate="PT15S" unit="Count"><annotation displayName="Packets sent errors" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\NetworkInterface\TotalCollisions" sampleRate="PT15S" unit="Count"><annotation displayName="Network collisions" locale="en-us"/></PerformanceCounterConfiguration></PerformanceCounters><Metrics resourceId="{0}"><MetricAggregation scheduledTransferPeriod="PT1H"/><MetricAggregation scheduledTransferPeriod="PT1M"/></Metrics></DiagnosticMonitorConfiguration></WadCfg>'
    
    $vmResourceId = $args[0]

    $xmlTemplate -f $vmResourceId

}


function Enable-AzureLinuxMonitoring
{

    <#

    .SYNOPSIS
    Enable Azure Monitoring for Linux Classic VMs 

    .PARAMETER subscription
    the subscription where this VM lives

    .PARAMETER VM 
    the linux VM

    .PARAMETER storageAccountName 
    the storage account name for monitoring metrics

    .PARAMETER storageAccountKey 
    the storage account key for monitoring metrics

    .NOTES
    Tested the following:
        Classic Linux VM

    #>

    $subscription = $args[0]
    $VM = $args[1]
    $storageAccountName = $args[2]
    $storageAccountKey = $args[3]

    Write-Debug "VM Name: $VM.Name"

    # Linux Configuration
    $ExtensionName = 'LinuxDiagnostic'
    $Publisher = 'Microsoft.OSTCExtensions'
    $Version = '2.*'
    
    # Generate vmResourceId
    $vmResourceId = Create-AzureVMDiagnosticResourceId  $subscription.SubscriptionId $VM.Name
    Write-Debug "ResourceId $vmResourceId"

    # Generate Config
    $xmlCfg = Create-AzureMonitoringXmlConfig $vmResourceId
    Write-Debug "xmlCfg $xmlCfg"

    $xmlCfgEncoded =  [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($xmlCfg ))
    $PublicConf = "{`"StorageAccount`":`"$storageAccountName`",`"xmlCfg`":`"$xmlCfgEncoded`"}" 

    $PrivateConf = "{
        `"storageAccountName`": `"$storageAccountName`",
        `"storageAccountKey`": `"$storageAccountKey`"
    }"

    Set-AzureVMExtension -ExtensionName $ExtensionName -VM $VM `
      -Publisher $Publisher -Version $Version `
      -PrivateConfiguration $PrivateConf -PublicConfiguration $PublicConf |
      Update-AzureVM

}




# Get Subscription and VM
$subscriptons = Get-AzureSubscription
$curSubscription = $subscriptons[1]

# Get VM
$ServiceName = "pstest001z"
$VMName = "pstest001z"
$VM = Get-AzureVM -ServiceName $ServiceName -Name $VMName

# Storage Info
$storageAccountName = "bxdiagnostic"
$storageAccountKey = "u1GM0hq+DhUq1CiGuDMT77B6xiNjaz3nmhHMcRmCqJp2yvd0ZTE2iOgnx03gdYhzgKnDkTRETvqB2pZth/T7rA=="


Enable-AzureLinuxMonitoring $curSubscription $VM $storageAccountName $storageAccountKey

