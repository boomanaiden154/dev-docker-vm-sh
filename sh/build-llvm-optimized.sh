set -e
git clone https://github.com/llvm/llvm-project
mkdir llvm-project/build
cd llvm-project/build
cmake -G Ninja /llvm-project/llvm \
  -C /llvm-project/clang/cmake/caches/BOLT-PGO.cmake \
  -DBOOTSTRAP_LLVM_ENABLE_LLD=ON \
  -DBOOTSTRAP_BOOTSTRAP_LLVM_ENABLE_LLD=ON \
  -DPGO_INSTRUMENT_LTO=Thin \
  -DLLVM_ENABLE_RUNTIMES="compiler-rt" \
  -DCMAKE_INSTALL_PREFIX="/llvm-install" \
  -DLLVM_ENABLE_PROJECTS="bolt;clang;lld;lldb;clang-tools-extra" \
  -DLLVM_DISTRIBUTION_COMPONENTS="lld;clangd;compiler-rt;lldb;liblldb;lldb-argdumper;lldb-server;clang-format" \
  -DCLANG_DEFAULT_LINKER="lld" \
  -DBOOTSTRAP_CLANG_PGO_TRAINING_DATA_SOURCE_DIR=/llvm-project/llvm
ninja stage2-clang-bolt stage2-install-distribution
ninja install-distribution
cd ..
rm -rf ./build
