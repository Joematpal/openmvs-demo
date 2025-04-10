# Install dependencies
# sudo apt install git cmake build-essential libboost-all-dev libeigen3-dev \
#      libsuitesparse-dev qtbase5-dev libqt5opengl5-dev libcgal-dev \
#      libglew-dev freeglut3-dev

# sudo apt install libpng-dev libjpeg-dev libtiff-dev libglu1-mesa-dev \
#      libatlas-base-dev libprotobuf-dev protobuf-compiler
# sudo apt update
# sudo apt install libopencv-dev
# sudo apt update
# sudo apt install libvcg-dev
sudo apt-get install \
    git \
    cmake \
    ninja-build \
    build-essential \
    libboost-program-options-dev \
    libboost-graph-dev \
    libboost-system-dev \
    libeigen3-dev \
    libflann-dev \
    libfreeimage-dev \
    libmetis-dev \
    libgoogle-glog-dev \
    libgtest-dev \
    libgmock-dev \
    libsqlite3-dev \
    libglew-dev \
    qtbase5-dev \
    libqt5opengl5-dev \
    libcgal-dev \
    libceres-dev

sudo apt-get install libgmp-dev
sudo apt-get install libmpfr-dev
sudo apt-get install libcgal-dev
sudo apt-get install libcgal-demo

sudo apt-get update
sudo apt-get install libflann-dev
sudo apt-get update
sudo apt-get install libceres-dev


# Clone and build
# git clone https://github.com/colmap/colmap.git
# cd colmap
# mkdir build && cd build
# cmake ..
# make -j$(nproc)
# sudo make install
# cd -

# Clone OpenMVS
git clone https://github.com/cdcseacave/openMVS.git
cd openMVS
git submodule update --init --recursive

# Build
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j$(nproc)
sudo make install
cd -