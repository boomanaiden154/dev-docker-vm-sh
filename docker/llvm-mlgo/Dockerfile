FROM mlgo-development:latest
RUN git clone https://github.com/llvm/llvm-project
RUN mkdir /llvm-build
WORKDIR /llvm-build
RUN cmake -G Ninja /llvm-project/llvm \
    	-C /llvm-project/clang/cmake/caches/BOLT-PGO.cmake \
    	-DBOOTSTRAP_LLVM_ENABLE_LLD=ON \
    	-DBOOTSTRAP_BOOTSTRAP_LLVM_ENABLE_LLD=ON \
    	-DPGO_INSTRUMENT_LTO=Thin
RUN cmake --build . --target stage2-clang++-bolt
RUN cmake --build ./tools/clang/stage2-instrumented-bins/tools/clang/stage2-bins --target runtimes
RUN mkdir /llvm-project/build
WORKDIR /llvm-project/build
RUN cmake -G Ninja \
    	-DCMAKE_BUILD_TYPE=Release \
    	-DTENSORFLOW_AOT_PATH=$(python3 -c "import tensorflow; import os; print(os.path.dirname(tensorflow.__file__))") \
    	-DLLVM_ENABLE_PROJECTS="clang;lld" \
    	-DLLVM_ENABLE_RUNTIMES="compiler-rt" \
	-DLLVM_ENABLE_ASSERTIONS=ON \
	-DCMAKE_C_COMPILER=/llvm-build/tools/clang/stage2-instrumented-bins/tools/clang/stage2-bins/bin/clang-bolt \
	-DCMAKE_CXX_COMPILER=/llvm-build/tools/clang/stage2-instrumented-bins/tools/clang/stage2-bins/bin/clang++-bolt \
	-DZLIB_ROOT=/usr/include \
	-DZLIB_LIBRARY=/usr/lib/x86_64-linux-gnu/libz.so \
	-C /tflite/tflite.cmake \
    	/llvm-project/llvm
RUN ninja all
WORKDIR /
