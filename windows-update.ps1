# Update Windows computers when windows update is disabled. 
# see the update.xml file for a task Scheduler.
# Need PSWindowsUpdate module installed for this script
# Open up powershell terminal in admin mode:
# Install-Module -Name PSWindowsUpdate
# Y then A

function Update-Computer{
   $user = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name.split("\")[1]
   $log_file = "C:\Users\$user\Desktop\update\log.txt"
   $date = Get-Date
   $blank = " - "
   $successful = "Windows Update was successful"
   $failed = "Something bad happened"
   $module_not_found = "PSWindowsUpdate module not found" 
   if (Get-Module -ListAvailable -Name PSWindowsUpdate) {
      try {
         Get-WindowsUpdate -AcceptAll -Install -AutoReboot
         Out-File -FilePath $log_file -InputObject $date -Append -NoNewLine
         Out-File -FilePath $log_file -InputObject $blank -Append -NoNewLine
         Out-File -FilePath $log_file -InputObject $successful -Append
      }
      catch{
         Out-File -FilePath $log_file -InputObject $date -Append -NoNewLine
         Out-File -FilePath $log_file -InputObject $blank -Append -NoNewLine
         Out-File -FilePath $log_file -InputObject $failed -Append
      }
   }
   else {
      Out-File -FilePath $log_file -InputObject $module_not_found -Append
   }
}

Update-Computer
