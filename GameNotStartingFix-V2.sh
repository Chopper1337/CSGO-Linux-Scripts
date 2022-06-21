#!/bin/bash
# Version 2

# ----- Variables ----- 
csgoDir="/tmp/";

# -----  Functions ----- 

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
  echo "Fix found at:\nhttps://github.com/ValveSoftware/csgo-osx-linux/issues/2659#issuecomment-934357559\n"
  cd "$csgoDir/bin/linux64"
  mv "$csgoDir/csgo/panorama/videos" "$csgoDir/csgo/panorama/videos.bak"
  echo "[IMPORTANT]: Please add '-novid' to your CSGO launch parameters!\nExpect videos to no longer show, usually replaced with black.\nShould work now, valve please fix..."
};

function goFix(){
  csgoDir= "$(pwd)"
  sudo dmesg | grep libtcmalloc_minimal && fixSegFault || echo "Not found."
  sudo dmesg | grep panorama && fixPanorama || echo "Not found."
}

ls | grep csgo_linux64 && goFix || echo "Please place the script in the root of your CSGO installation folder!"
exit
