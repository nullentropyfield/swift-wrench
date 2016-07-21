$SA_NAME_LENGTH = 24
$RG_NAME_LENGTH = 24
$CC_SA_PREFIX = "ccmonitorsa"
$CC_RG_PREFIX = "ccmonitorrg"
$ASM_SA_TYPE = "Standard_GRS"
$ARM_SA_TYPE = "Standard_GRS"
$ASM_LINUX_STRING = "Linux"
$ASM_WINDOWS_STRING = "Windows"

function New-AlphabetGeneratorLowerNumber {

    $alphabet = @()

    for ($a=48; $a –le 57; $a++) { $alphabet +=, [char][byte]$a }
    for ($a=97; $a –le 122; $a++) { $alphabet +=, [char][byte]$a }

    return $alphabet
}

function New-RandomStringGenerator {

    Param ([char[]]$alphabet, [int]$length)

    $name = ""

    for ($i=1; $i –le $length; $i++) { $name += ($alphabet | GET-RANDOM) }

    return $name
}

function New-AzureMonitorStorageAccountName {

    $length = $SA_NAME_LENGTH - $CC_SA_PREFIX.Length
    $alphabet = New-AlphabetGeneratorLowerNumber

    $name = $CC_SA_PREFIX + (New-RandomStringGenerator $alphabet $length)

    return $name
}

function New-AzureMonitorResourceGroupName {

    $length = $RG_NAME_LENGTH - $CC_RG_PREFIX.Length
    $alphabet = New-AlphabetGeneratorLowerNumber

    $name = $CC_RG_PREFIX + (New-RandomStringGenerator $alphabet $length)

    return $name
}

function Find-AzureMonitorStorageAccount {

    $obj = Get-AzureStorageAccount -WarningAction SilentlyContinue | where { $_.StorageAccountName.StartsWith($CC_SA_PREFIX) }

    return $obj
}

function Find-AzureRmMonitorStorageAccount {

    $obj = Get-AzureRmStorageAccount -WarningAction SilentlyContinue | where { $_.StorageAccountName.StartsWith($CC_SA_PREFIX) }

    return $obj
}

function New-AzureMonitorStorageAccount {

    Param ([string]$location)

    $name = New-AzureMonitorStorageAccountName

    $obj = New-AzureStorageAccount -StorageAccountName $name -Label $name -Location $location -Description $name -Type $ASM_SA_TYPE -WarningAction SilentlyContinue

    return $obj
}

function New-AzureRmMonitorResourceGroup {

    Param ([string]$location)

    $rgName = New-AzureMonitorResourceGroupName

    $obj = New-AzureRmResourceGroup -ResourceGroupName $rgName -Location $location -WarningAction SilentlyContinue

    return $obj
}

function New-AzureRmMonitorStorageAccount {

    Param ([string]$location, [string]$rgName)

    $saName = New-AzureMonitorStorageAccountName

    $obj = New-AzureRmStorageAccount -Name $saName -ResourceGroupName $rgName -Location $location -SkuName $ARM_SA_TYPE -WarningAction SilentlyContinue

    return $obj
}








# Login-AzureRmAccount

$sa = @{}

$location = ""
$locations = @()

$vm = ""
$vms = @()

$subscriptions = @()
$subscriptions = Get-AzureSubscription

foreach ($subscription in $subscriptions) {

	Select-AzureSubscription $subscription.SubscriptionName

    $locations = New-Object System.Collections.ArrayList
	$vms = Get-AzureVM

    foreach ($vm in $vms) {

        $location = (Get-AzureService -ServiceName $vm.ServiceName).Location

        if (!$locations.Contains($location)) {

            $sa = Find-AzureMonitorStorageAccount

            if (!$sa) {
                $sa = New-AzureMonitorStorageAccount $location
            }

            [void]$locations.Add($location)
        }

        if ([string]::Equals($ASM_LINUX_STRING, $vm.VM.OSVirtualHardDisk.OS)) {

            echo ("ASM Linux VM: " + $vm.Name)
        }
        elseif ([string]::Equals($ASM_WINDOWS_STRING, $vm.VM.OSVirtualHardDisk.OS)) {

            echo ("ASM Windows VM: " + $vm.Name)            

        }
        else {

            echo ("ASM VM [SKIPPED]: " + $vm.Name)

        }
    }

    $locations = New-Object System.Collections.ArrayList
    $vms = Get-AzureRmVM

    foreach ($vm in $vms) {

        $location = $vm.Location

        if (!$locations.Contains($location)) {

               $sa = Find-AzureRmMonitorStorageAccount

            if (!$sa) {
                $rgNew = New-AzureRmMonitorResourceGroup $location
                $sa = New-AzureRmMonitorStorageAccount $location $rgNew.ResourceGroupName
            }

            [void]$locations.Add($location)
        }

        if (![string]::IsNullOrEmpty($vm.OSProfile.LinuxConfiguration)) {
        
            echo ("ARM Linux VM: " + $vm.Name)

        }
        elseif (![string]::IsNullOrEmpty($vm.OSProfile.WindowsConfiguration)) {
        
            echo ("ARM Windows VM: " + $vm.Name)

        }
        else {

            echo ("ARM VM [SKIPPED]: " + $vm.Name)

        }
    }
}
