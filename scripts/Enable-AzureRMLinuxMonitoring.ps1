$DebugPreference =  "Continue" #"SilentContinue"

Login-AzureRmAccount

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

function Enable-AzureRmLinuxMonitoring
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
        Classic Linux VM

    #>

    $VM = $args[0]
    $StorageAccount = $args[1]
    $storageAccountKey = $args[2]

    # Linux Configuration
    $ExtensionName = 'Microsoft.Insights.VMDiagnosticsSettings'
    $Publisher = 'Microsoft.OSTCExtensions'
    $ExtensionType = 'LinuxDiagnostic'
    $Version = '2.0'

    
    $xmlCfg = Create-AzureMonitoringXmlConfig $VM.Id
    $xmlCfgEncoded =  [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($xmlCfg ))
    $StorageAccountName = $StorageAccount.StorageAccountName
    $Settings = @{"StorageAccount"="$StorageAccountName";"xmlCfg"="$xmlCfgEncoded"}; 

    $ProtectedSettings = @{"storageAccountName"="$StorageAccountName";"storageAccountKey"="$storageAccountKey"};

    #$ProtectedSettings = @{"storageAccountName" = $StorageAccount.Name; "storageAccountKey" = $storageAccountKey};
    Set-AzureRmVMExtension -ExtensionType $ExtensionType -Name $ExtensionName -Publisher $Publisher -ResourceGroupName $VM.ResourceGroupName -VMName $VM.Name -TypeHandlerVersion $Version -ProtectedSettings $ProtectedSettings -Settings $Settings -Location $VM.Location
     
    # May only work for Windows   
    #Set-AzureRmDiagnosticSetting -Enabled $true -ResourceId $VM.Id -StorageAccountId $StorageAccount.Id
  

}

#Get VM
$resourceGroupName = "diagtest"
$vmName = "pstets002o"
$VM = Get-AzureRMVM -ResourceGroupName $resourceGroupName -Name $vmName

# Get Storage Account and info
$storageAccountName ="diagtest6744"
$storageAccountKey = "bzju6LaboFuuGQX99JAy2/38rkFcDXiJX07DlBJ21/2lEvutoxp8wWsKaYkkQvHgBD0/rkY2x2rwQ6s5wsNm+w=="
$StorageAccount = Get-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName


Enable-AzureRmLinuxMonitoring $VM $StorageAccount $storageAccountKey 


# Check if Extension is Enabled
#$VM.Extensions[0].VirtualMachineExtensionType -match "LinuxDiagnostic"
#OR
#Get-AzureRmVMExtension -ResourceGroupName $resourceGroupName -VMName $vmName -Name "Microsoft.Insights.VMDiagnosticsSettings"

