set -e
git clone https://github.com/llvm/llvm-project
mkdir /llvm-project/build
cd /llvm-project/build
cmake -GNinja \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DLLVM_ENABLE_ASSERTIONS=ON \
    -DLLVM_ENABLE_PROJECTS="clang" \
    -DLLVM_ENABLE_RUNTIMES="compiler-rt" \
    -DCMAKE_C_COMPILER_LAUNCHER="ccache" \
    -DCMAKE_CXX_COMPILER_LAUNCHER="ccache" \
    -DLLVM_USE_LINKER="lld" \
    -DLLVM_BUILD_DOCS=true \
    -DLLVM_ENABLE_SPHINX=true \
    -DSPHINX_OUTPUT_MAN=false \
    ../llvm
ninja
