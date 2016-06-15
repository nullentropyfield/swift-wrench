$DebugPreference =  "Continue" #"SilentContinue"

Login-AzureRmAccount


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
    Creates an Azure MOnitoring Xml Config file for a Windows vm (Classic)

    .PARAMETER vmResourceId 
    the subscriptionId where the vm lives

    .NOTES
    Tested the following:
        Classic Linux VM

    #>

    $xmlTemplate = '<WadCfg><DiagnosticMonitorConfiguration xmlns="http://schemas.microsoft.com/ServiceHosting/2010/10/DiagnosticsConfiguration" overallQuotaInMB="4096"><DiagnosticInfrastructureLogs scheduledTransferPeriod="PT1M" scheduledTransferLogLevelFilter="Warning"/><PerformanceCounters scheduledTransferPeriod="PT0S"><PerformanceCounterConfiguration counterSpecifier="\Processor(_Total)\% Processor Time" sampleRate="PT15S" unit="Percent"><annotation displayName="CPU percentage guest OS" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Processor(_Total)\% Interrupt Time" sampleRate="PT15S" unit="Percent"><annotation displayName="CPU interrupt time" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Processor(_Total)\% Privileged Time" sampleRate="PT15S" unit="Percent"><annotation displayName="CPU privileged time" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Processor Information(_Total)\Parking Status" sampleRate="PT15S" unit="Count"><annotation displayName="CPU parking status" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Processor(_Total)\% User Time" sampleRate="PT15S" unit="Percent"><annotation displayName="CPU user time" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Processor Information(_Total)\% Processor Performance" sampleRate="PT15S" unit="Count"><annotation displayName="Processor percent perf." locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Processor Information(_Total)\Processor Frequency" sampleRate="PT15S" unit="Count"><annotation displayName="Processor frequency" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\System\Threads" sampleRate="PT15S" unit="Count"><annotation displayName="Threads" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\System\Processes" sampleRate="PT15S" unit="Count"><annotation displayName="Processes" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Thread(_Total)\Context Switches/sec" sampleRate="PT15S" unit="CountPerSecond"><annotation displayName="Context switches" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Memory\Committed Bytes" sampleRate="PT15S" unit="Bytes"><annotation displayName="Memory committed" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Memory\Available Bytes" sampleRate="PT15S" unit="Bytes"><annotation displayName="Memory available" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Memory\% Committed Bytes In Use" sampleRate="PT15S" unit="Percent"><annotation displayName="Memory percentage" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Memory\Cache Faults/sec" sampleRate="PT15S" unit="CountPerSecond"><annotation displayName="Cache faults" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Memory\Page Faults/sec" sampleRate="PT15S" unit="CountPerSecond"><annotation displayName="Page faults" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Memory\Page Reads/sec" sampleRate="PT15S" unit="CountPerSecond"><annotation displayName="Page reads" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Memory\Pages/sec" sampleRate="PT15S" unit="CountPerSecond"><annotation displayName="Memory pages" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Memory\Transition Faults/sec" sampleRate="PT15S" unit="CountPerSecond"><annotation displayName="Transition faults" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Memory\Pool Paged Bytes" sampleRate="PT15S" unit="Bytes"><annotation displayName="Paged pool" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Memory\Pool Nonpaged Bytes" sampleRate="PT15S" unit="Bytes"><annotation displayName="Non-paged pool" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Process(_Total)\% Processor Time" sampleRate="PT15S" unit="Percent"><annotation displayName="Process total time" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Process(_Total)\Page Faults/sec" sampleRate="PT15S" unit="CountPerSecond"><annotation displayName="Process page faults" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Process(_Total)\Thread Count" sampleRate="PT15S" unit="Count"><annotation displayName="Process total threads" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Process(_Total)\Handle Count" sampleRate="PT15S" unit="Count"><annotation displayName="Process total handles" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Process(_Total)\Private Bytes" sampleRate="PT15S" unit="Bytes"><annotation displayName="Process private bytes" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Process(_Total)\Working Set" sampleRate="PT15S" unit="Bytes"><annotation displayName="Process working set" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Process(_Total)\Working Set - Private" sampleRate="PT15S" unit="Bytes"><annotation displayName="Process private working set" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\PhysicalDisk(_Total)\Disk Read Bytes/sec" sampleRate="PT15S" unit="BytesPerSecond"><annotation displayName="Disk read guest OS" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\PhysicalDisk(_Total)\Disk Write Bytes/sec" sampleRate="PT15S" unit="BytesPerSecond"><annotation displayName="Disk write guest OS" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Web Service(_Total)\Bytes Total/Sec" sampleRate="PT15S" unit="BytesPerSecond"><annotation displayName="Web service bytes" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Web Service(_Total)\ISAPI Extension Requests/sec" sampleRate="PT15S" unit="CountPerSecond"><annotation displayName="ISAPI extension requests" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Web Service(_Total)\Connection Attempts/sec" sampleRate="PT15S" unit="CountPerSecond"><annotation displayName="Web connection attempts" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Web Service(_Total)\Current Connections" sampleRate="PT15S" unit="Count"><annotation displayName="Web current connections" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Web Service(_Total)\Get Requests/sec" sampleRate="PT15S" unit="CountPerSecond"><annotation displayName="Web get requests" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\Web Service(_Total)\Post Requests/sec" sampleRate="PT15S" unit="CountPerSecond"><annotation displayName="Web post requests" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\TCPv4\Connections Established" sampleRate="PT15S" unit="Count"><annotation displayName="TCP connections established" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\TCPv4\Connection Failures" sampleRate="PT15S" unit="Count"><annotation displayName="TCP connections failed" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\TCPv4\Connections Reset" sampleRate="PT15S" unit="Count"><annotation displayName="TCP connections reset" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\TCPv4\Segments Sent/sec" sampleRate="PT15S" unit="CountPerSecond"><annotation displayName="TCP segments sent" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\TCPv4\Segments Received/sec" sampleRate="PT15S" unit="CountPerSecond"><annotation displayName="TCP segments received" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\TCPv4\Segments Retransmitted/sec" sampleRate="PT15S" unit="CountPerSecond"><annotation displayName="TCP seg. restransmitted" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\.NET CLR Jit(_Global_)\% Time in Jit" sampleRate="PT15S" unit="Percent"><annotation displayName=".NET CLR time in jit" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\.NET CLR Loading(_Global_)\% Time Loading" sampleRate="PT15S" unit="Percent"><annotation displayName=".NET CLR time loading" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\.NET CLR LocksAndThreads(_Global_)\Current Queue Length" sampleRate="PT15S" unit="Count"><annotation displayName=".NET CLR queue length" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\.NET CLR LocksAndThreads(_Global_)\Contention Rate / sec" sampleRate="PT15S" unit="CountPerSecond"><annotation displayName=".NET CLR contention rate" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\.NET CLR LocksAndThreads(_Global_)\# of current logical Threads" sampleRate="PT15S" unit="Count"><annotation displayName=".NET CLR logical threads" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\.NET CLR LocksAndThreads(_Global_)\# of current physical Threads" sampleRate="PT15S" unit="Count"><annotation displayName=".NET CLR phys. threads" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\.NET CLR Memory(_Global_)\% Time in GC" sampleRate="PT15S" unit="Percent"><annotation displayName=".NET CLR time in GC" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\.NET CLR Memory(_Global_)\Allocated Bytes/sec" sampleRate="PT15S" unit="BytesPerSecond"><annotation displayName=".NET CLR allocated" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\.NET CLR Memory(_Global_)\Gen 0 heap size" sampleRate="PT15S" unit="Bytes"><annotation displayName=".NET CLR gen 0 heap size" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\.NET CLR Memory(_Global_)\Gen 1 heap size" sampleRate="PT15S" unit="Bytes"><annotation displayName=".NET CLR gen 1 heap size" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\.NET CLR Memory(_Global_)\Gen 2 heap size" sampleRate="PT15S" unit="Bytes"><annotation displayName=".NET CLR gen 2 heap size" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\.NET CLR Memory(_Global_)\Large Object Heap size" sampleRate="PT15S" unit="Bytes"><annotation displayName=".NET CLR large obj. heap size" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\.NET CLR Memory(_Global_)\# Bytes in all Heaps" sampleRate="PT15S" unit="Bytes"><annotation displayName=".NET CLR heap bytes" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\.NET CLR Networking(_Global_)\Connections Established" sampleRate="PT15S" unit="Count"><annotation displayName=".NET CLR connections " locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\.NET CLR Remoting(_Global_)\Remote Calls/sec" sampleRate="PT15S" unit="CountPerSecond"><annotation displayName=".NET CLR remote calls" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\.NET CLR Exceptions(_Global_)\# of Exceps Thrown / sec" sampleRate="PT15S" unit="CountPerSecond"><annotation displayName=".NET CLR exception rate" locale="en-us"/></PerformanceCounterConfiguration><PerformanceCounterConfiguration counterSpecifier="\.NET CLR Interop(_Global_)\# of marshalling" sampleRate="PT15S" unit="Count"><annotation displayName=".NET CLR interop marsh." locale="en-us"/></PerformanceCounterConfiguration></PerformanceCounters><WindowsEventLog scheduledTransferPeriod="PT1M"><DataSource name="System!*[System[(Level = 1) or (Level = 2)]]"/><DataSource name="System!*[System[Provider[@Name=''Microsoft Antimalware'']]]"/><DataSource name="Security!*[System[(Level = 1) or (Level = 2)]]"/><DataSource name="Application!*[System[(Level = 1) or (Level = 2)]]"/></WindowsEventLog><Metrics resourceId="{0}"><MetricAggregation scheduledTransferPeriod="PT1H"/><MetricAggregation scheduledTransferPeriod="PT1M"/></Metrics></DiagnosticMonitorConfiguration></WadCfg>'

    $vmResourceId = $args[0]

    $xmlTemplate -f $vmResourceId

}

function Enable-AzureWinMonitoring
{

    <#

    .SYNOPSIS
    Enable Azure Monitoring for Win VMs in ARM

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
        Classic Win VM

    #>

   # $subscription = $args[0]
    $VM = $args[0]
    $storageAccountName = $args[1]
    $storageAccountKey = $args[2]

    # Linux Configuration
    #$ExtensionName = 'IaaSDiagnostics'
    #$Publisher = 'Microsoft.Azure.Diagnostics'
    #$Version = '1.*'

    # Generate vmResourceId
    #$vmResourceId = Create-AzureVMDiagnosticResourceId  $subscription.SubscriptionId $VM.Name

    # Generate Config
    #$xmlCfg = Create-AzureMonitoringXmlConfig $vmResourceId

    #$r = [xml]$xmlCfg
    #$filename = "C:\temp\{0}.xml" -f $vmResourceId -replace "/", '_'
    #$r.save($filename)

    #Write-Debug "xmlCfg $xmlCfg"

    #$xmlCfgEncoded =  [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($xmlCfg ))
    #$PublicConf = "{`"StorageAccount`":`"$storageAccountName`",`"xmlCfg`":`"$xmlCfgEncoded`"}" 

    #$PrivateConf = "{
    #    `"storageAccountName`": `"$storageAccountName`",
    #    `"storageAccountKey`": `"$storageAccountKey`"
    #}"

    #!! The config has a hard-coded resourceID
    $Config_Path = "C:\Users\brlamore\OneDrive - Microsoft\PowershellScripts\WadConfig.xml"

   
    Set-AzureVMDiagnosticsExtension -DiagnosticsConfigurationPath $Config_Path -VM $VM -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey |Update-AzureVM

    
    # Set-AzureVMExtension -ExtensionName $ExtensionName -VM $VM `
    #  -Publisher $Publisher -Version $Version `
    #  -PrivateConfiguration $PrivateConf -PublicConfiguration $PublicConf |
    #  Update-AzureVM
}

function Test-Enabled
{

    <#

    .SYNOPSIS
    Test if Azure Monitoring for Win VMs is enabled in ARM

    .PARAMETER ServiceName 
    the ServiceName of the VM

    .PARAMETER VMName 
    the VMName of the VM


    #>

    $ServiceName = $args[0]
    $VMName = $args[1]

    $VM = Get-AzureVM -ServiceName $ServiceName -Name $VMName
    $extensionName = "IaaSDiagnostics"
  
    # Check if enabled
    $extension = Get-AzureVMDiagnosticsExtension -VM $VM
   
    
    if($extension){
        if($extension.ExtensionName -match $extensionName)
        {
            return $extension.PublicConfiguration.Length -gt 250 #Disabling monitoring leaves an empty config file
        }
        else {

            return $false
        }
    }
    else
    {
        return $false
    }

}

# Get Subscription and VM
#$subscriptons = Get-AzureSubscription
#$curSubscription = $subscriptons[1]

# Get VM
$ServiceName = "pstest005b"
$VMName = "pstest005b"
$VM = Get-AzureVM -ServiceName $ServiceName -Name $VMName

# Storage Info
$storageAccountName = $env:ClassicStorageName 
$storageAccountKey = $env:ClassicStorageKey 

Enable-AzureWinMonitoring $VM $storageAccountName $storageAccountKey


# Test if Enabled
Test-Enabled $ServiceName $VMName