# Create build directory absolute path
SCRIPT_DIR=cmake
BUILD_DIR="build-dreamcast"
mkdir -p "$BUILD_DIR"

# Configure with CMake
echo "Configuring ZSTD for Dreamcast..."
kos-cmake -S "$SCRIPT_DIR" \
      -B "$BUILD_DIR" \
      -DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
    -DCMAKE_INSTALL_PREFIX="${KOS_BASE}/addons" \
    -DCMAKE_INSTALL_LIBDIR="lib/dreamcast" \
    -DCMAKE_INSTALL_INCLUDEDIR="include/" \
      -DZSTD_BUILD_COMPRESSION=OFF \
      -DZSTD_BUILD_DECOMPRESSION=ON \
      -DZSTD_BUILD_DICTBUILDER=OFF \
      -DZSTD_BUILD_DEPRECATED=OFF \
      -DZSTD_BUILD_PROGRAMS=OFF \
      -DZSTD_BUILD_SHARED=OFF \
      -DZSTD_BUILD_STATIC=ON \
      -DZSTD_BUILD_TESTS=OFF \
      -DZSTD_LEGACY_SUPPORT=OFF \
      -DZSTD_LZ4_SUPPORT=OFF \
      -DZSTD_LZMA_SUPPORT=OFF \
      -DZSTD_ZLIB_SUPPORT=OFF \
      -DZSTD_MULTITHREAD_SUPPORT=OFF

# Build
echo "Building ZSTD..."
cmake --build "$BUILD_DIR" -- -j$(nproc)

# Install
echo "Installing ZSTD to ${KOS_BASE}/addons..."
cmake --install "$BUILD_DIR"

# echo "Stripping libzstd.a to reduce size..."
# sh-elf-strip "${KOS_BASE}/addons/lib/dreamcast/libzstd.a"
