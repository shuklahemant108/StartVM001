Disable-AzContextAutosave -Scope Process
$AzureContext = (Connect-AzAccount -Identity).context
$AzureContext = Set-AzContext -SubscriptionName $AzureContext.Subscription -DefaultProfile $AzureContext

Connect-AzAccount -Identity

#Variables

$tag = "StartVM01"
$tagValue = "9am"

#Function to start VM
function Start-Vms {
     param (
          $vms
       )
     foreach ($vm in $vms) {
         try{
            #start the VM
            $vm | Start-AzVM 
        }
         catch {
             $ErrorMessage = $_.Exception.message
            Write-Error ("Error in starting the VM: " + $ErrorMessage)
            Break
        }
    }
}

#Get the server
try{
    $vms = (Get-AzVM | Where-Object { $_.tags[$tag] -eq $tagValue })
}
catch {
    $ErrorMessage = $_.Exception.message
    Write-Error ("Error returning the VMs: " + $ErrorMessage)
    Break
}


Write-output "starting the folloing server:"
Write-output $vms.Name
Start-vms $vms