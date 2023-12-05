########## Global Address Object Downloader ###########

#################### Set Variables ####################

# License string
$license            = "your_license"

# Release version
$release_version    = "latest"  

# Target directory - where you want to download files to; The default is current directory.
$target_directory   = Get-Location

# Program directory - where you put MelissaUpdater.exe; The default is current directory.
# Melissa Updater source code: https://github.com/MelissaData/MelissaUpdater
# Melissa Updater binary download link: https://releases.melissadata.net/Download/Library/WINDOWS/NET/ANY/latest/MelissaUpdater.exe
$program_directory  = "$target_directory\MelissaUpdater" 
$program_path       = "$program_directory\MelissaUpdater.exe" 


###################### Functions ######################
 
function Get-File {
    param (
      [parameter(Mandatory=$true)][String]$Filename,
      [parameter(Mandatory=$false)][String]$Type,
      [parameter(Mandatory=$true)][String]$OperatingSystem,
      [parameter(Mandatory=$true)][String]$Compiler,
      [parameter(Mandatory=$true)][String]$Architecture,
      [parameter(Mandatory=$true)][String]$TargetDirectory,
      [parameter(Mandatory=$false)][String]$WorkingDirectory
    )
       
    $path = "$target_directory\$TargetDirectory" 
    
    $verifyPath = "$target_directory\$TargetDirectory\$Filename"
    $params = "verify", "-p", "$verifyPath"
    & $program_path $params
    
    if($? -eq $False) {
      Invoke-Expression "$program_path file -f -n `"$Filename`" -r `"$release_version`" -l `"$license`" -y `"$Type`" -o `"$OperatingSystem`" -c `"$Compiler`" -a `"$Architecture`" -t `"$path`" " 
    } else {
      Invoke-Expression "$program_path file -n `"$Filename`" -r `"$release_version`" -l `"$license`" -y `"$Type`" -o `"$OperatingSystem`" -c `"$Compiler`" -a `"$Architecture`" -t `"$path`" " 
    }
}
  

function Get-Manifest {
    param (
      [parameter(Mandatory=$true)][String]$ProductName,
      [parameter(Mandatory=$true)][String]$TargetDirectory,
      [parameter(Mandatory=$false)][String]$WorkingDirectory
    )
       
    $path = "$target_directory\$TargetDirectory" 
    
    Invoke-Expression "$program_path manifest -p `"$ProductName`" -r `"$release_version`" -l `"$license`" -t `"$path`" " 
}


######################## Main #########################

###################
# Section 1: Data #
###################

# Global Address Object Data
$target_path = "Data"
Get-Manifest -ProductName "global_dq_data" -TargetDirectory $target_path

# Address Object Data
Get-Manifest -ProductName "dq_addr_data" -TargetDirectory $target_path

# Geocoder Object Data
Get-Manifest -ProductName "geocoder_data" -TargetDirectory $target_path

# RightFielder Object Data
Get-Manifest -ProductName "rf_data" -TargetDirectory $target_path


######################
# Section 2: Objects #
######################

# Global Address Object 
$target_path = "Objects"
Get-File -Filename "mdGlobalAddr.dll" -Type "BINARY" -OperatingSystem "WINDOWS" -Compiler "DLL" -Architecture "64BIT" -TargetDirectory $target_path

# Address Object
Get-File -Filename "mdAddr.dll" -Type "BINARY" -OperatingSystem "WINDOWS" -Compiler "DLL" -Architecture "64BIT" -TargetDirectory $target_path

# Geocoder Object
Get-File -Filename "mdGeo.dll" -Type "BINARY" -OperatingSystem "WINDOWS" -Compiler "DLL" -Architecture "64BIT" -TargetDirectory $target_path

# RightFielder Object
Get-File -Filename "mdRightFielder.dll" -Type "BINARY" -OperatingSystem "WINDOWS" -Compiler "DLL" -Architecture "64BIT" -TargetDirectory $target_path

#######################
# Section 3: Wrappers #
#######################

# Global Address Object Wrappers
$target_path = "Wrappers"
Get-Manifest -ProductName "global_dq_addr_wrappers" -TargetDirectory $target_path