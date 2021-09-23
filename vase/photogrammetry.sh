#!/bin/bash
# Photogrammety automation script.
#
# Based on https://peterfalkingham.com/2018/04/01/colmap-openmvs-scripts-updated/
# Adapted from https://www.instructables.com/Free-Photogrammetry-on-Mac-OS-From-Photos-to-3D-Mo/
#
# See full guide on Jeff Geerling's blog:
# TODO
#
# Usage:
#   1. Save this script into a file named `photogrammetry.sh`, in the directory
#      where you saved the photos you took of a 3D object.
#   2. Give it execute permissions (`chmod +x photogrammetry.sh`).
#   3. Replace the '/Users/jgeerling/*' paths with your own.
#   4. Run `./photogrammetry.sh`
#   5. Wait.
#
# It will take a LONG time, especially if you use tons of high-res photos.

# Get current directory path.
current_dir=$PWD

# Store the current directory name for object output.
dir_name=${PWD##*/}

# Set colmap directory (change this to where you've placed colmap).
colmap_dir=/usr/local/bin/colmap

# Set openMVS directory (change this to the 'bin/Release' folder where you built openMVS).
openmvs_dir=~/colmap/openMVS_build/bin

# Set Working Directory (I create a temporary workspace folder in my 'Projects' directory to process data in)
working_dir=~/Documents/photogrammetry/workspace

mkdir $working_dir
cp *.jpg $working_dir/
cp *.JPG $working_dir/
cd $working_dir

$colmap_dir feature_extractor --database_path database.db --image_path .
$colmap_dir exhaustive_matcher --database_path database.db
mkdir sparse
$colmap_dir mapper --database_path database.db --image_path . --output_path sparse
$colmap_dir model_converter --input_path sparse/0 --output_path model.nvm --output_type NVM
$openmvs_dir/InterfaceVisualSFM model.nvm
$openmvs_dir/DensifyPointCloud model.mvs
$openmvs_dir/ReconstructMesh model_dense.mvs
$openmvs_dir/RefineMesh --resolution-level 1 model_dense_mesh.mvs
$openmvs_dir/TextureMesh --export-type obj -o $dir_name.obj model_dense_mesh_refine.mvs

mkdir $current_dir/model/
cp *.obj $current_dir/model/
cp *.mtl $current_dir/model/
cp *Kd.jpg $current_dir/model/

cd $current_dir