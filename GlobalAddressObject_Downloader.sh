#!/bin/bash
########## Global Address Object Downloader ###########

#################### Set Variables ####################

# License string
license="your_license"

# Release version
release_version="latest"  

# Target directory - where you want to download files to; The default is current directory.   
target_directory=$PWD

# Program directory - where you put MelissaUpdater.exe; The default is current directory.
# Melissa Updater source code: https://github.com/MelissaData/MelissaUpdater
# Melissa Updater binary download link: https://releases.melissadata.net/Download/Library/LINUX/NET/ANY/latest/MelissaUpdater
program_directory="$target_directory/MelissaUpdater"
program_path="$program_directory/MelissaUpdater"


###################### Functions ######################
 
Get-File() 
{
    path="$target_directory/$6" 
    
    verifyPath="$target_directory/$6/$1"
    $program_path verify --path $verifyPath
    
    if [ $? -eq 0 ];
    then
        eval "$program_path file --filename $1 --release_version $release_version --license $license --type $2 --os $3 --compiler $4 --architecture $5 --target_directory $path "
    else
        eval "$program_path file --force --filename $1 --release_version $release_version --license $license --type $2 --os $3 --compiler $4 --architecture $5 --target_directory $path "
    fi
}

Get-Manifest() 
{
    path="$target_directory/$2"

    eval "$program_path manifest --product $1 --release_version $release_version --license $license --target_directory $path "
}

######################## Main #########################

###################
# Section 1: Data #
###################

# Global Address Object Data
target_path="Data"
Get-Manifest "global_dq_data" $target_path

# Address Object Data
Get-Manifest "dq_addr_data" $target_path

# Geocoder Object Data
Get-Manifest "geocoder_data" $target_path

# RightFielder Object Data
Get-Manifest "rf_data" $target_path


######################
# Section 2: Objects #
######################

# Global Address Object 
target_path="Objects"
Get-File "libmdGlobalAddr.so" "BINARY" "LINUX" "GCC48" "64BIT" $target_path

# Address Object
Get-File "libmdAddr.so" "BINARY" "LINUX" "GCC48" "64BIT" $target_path

# Geocoder Object
Get-File "libmdGeo.so" "BINARY" "LINUX" "GCC48" "64BIT" $target_path

# RightFielder Object
Get-File "libmdRightFielder.so" "BINARY" "LINUX" "GCC48" "64BIT" $target_path

#######################
# Section 3: Wrappers #
#######################

# Global Address Object Wrappers
target_path="Wrappers"
Get-Manifest "global_dq_addr_wrappers" $target_path
