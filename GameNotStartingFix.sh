#!/bin/bash
# Version 1

# ----- Variables ----- 
dmesgResult="false";
csgoDir="/tmp/";

# -----  Functions ----- 

# Makes sure you are running the script in the CSGO directory
function checkDir(){
  if [[ $(ls | grep csgo_linux64 | wc -c) -gt 0 ]]
  then
    echo "Script in correct location."
    csgoDir= "$(pwd)"
    echo "CSGO Directory:"
    echo "$(pwd)"
    echo "Only continue if this is correct..."
    pauseInput
  else
    echo "[ERROR]: Please place the script in the root of your CSGO directory..."
    exit
  fi
}

# Press enter to continue function
function pauseInput(){
  printf "%s " "Press enter to continue..."
  read ans
};

# Applies the fix for the libtcmalloc_minimal segfault.
function fixSegFault(){
  echo "Fix found at:"
  echo "https://github.com/ValveSoftware/csgo-osx-linux/issues/2659#issuecomment-1081135949"
  echo 
  cd "$csgoDir/bin"
  mv libtcmalloc_minimal.so.4 libtcmalloc_minimal.so.4.bak
  ln -s /usr/lib64/libtcmalloc_minimal.so.4 libtcmalloc_minimal.so.4
  echo "In bin/"
  ls -la | grep libtcmalloc_minimal

  cd "$csgoDir/bin/linux64"
  mv libtcmalloc_minimal.so.0 libtcmalloc_minimal.so.0.bak
  mv libtcmalloc_minimal.so.4 libtcmalloc_minimal.so.4.bak
  ln -s /usr/lib64/libtcmalloc_minimal.so.4 libtcmalloc_minimal.so.0
  ln -s /usr/lib64/libtcmalloc_minimal.so.4 libtcmalloc_minimal.so.4
  echo 
  echo "In bin/linux64/"
  ls -la | grep libtcmalloc_minimal
  echo "libtcmalloc_minimal fixes applied. valve please fix..."
};

# Applies fix for the panorama video segfault
function fixPanorama(){
  echo "Fix found at:"
  echo "https://github.com/ValveSoftware/csgo-osx-linux/issues/2659#issuecomment-934357559"
  echo 
  cd "$csgoDir/bin/linux64"
  mv "$csgoDir/csgo/panorama/videos" "$csgoDir/csgo/panorama/videos.bak"
  echo "[IMPORTANT]: Please add '-novid' to your CSGO launch parameters!"
  echo "Expect videos to no longer show, usually replaced with black."
  echo "Should work now, valve please fix..."
};

# Function to check if dmesg contains a string
function checkDmesg(){
  if [[ $(sudo dmesg | grep $1 | wc -c) -gt 0 ]]
  then
    echo ""
    echo "$1 error found in dmesg."
    dmesgResult="true";
  else
    echo "$1 not found in dmesg."
    echo "Fix need not be applied."
    echo ""
  fi
}

# -----  Main script begins here ----- 
checkDir
checkDmesg libtcmalloc_minimal
if [ $dmesgResult == "true" ]
  then
  echo "You are about to modify the contents of your CSGO directory."
  pauseInput
  fixSegFault
fi

# Reset variable
dmesgResult=false;

checkDmesg panorama
if [[ $dmesgResult == "true" ]]
then
  echo "You are about to modify the contents of your CSGO directory."
  pauseInput
  fixPanorama
fi

if [[ $dmesgResult == "false" ]]
then
  echo "No fixes were applied."
fi

exit
