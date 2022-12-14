FROM llvm-mlgo:latest
RUN mkdir -p /llvm-corpus/stage_instrument
WORKDIR /llvm-corpus/stage_instrument
RUN cmake -G Ninja \
	-DCMAKE_C_COMPILER=/llvm-build/tools/clang/stage2-instrumented-bins/tools/clang/stage2-bins/bin/clang-bolt \
	-DCMAKE_CXX_COMPILER=/llvm-build/tools/clang/stage2-instrumented-bins/tools/clang/stage2-bins/bin/clang++-bolt \
	-DCMAKE_BUILD_TYPE=Release \
	-DLLVM_TARGETS_TO_BUILD=Native \
	-DLLVM_ENABLE_PROJECTS="clang;lld" \
	-DLLVM_ENABLE_RUNTIMES="compiler-rt;libcxx;libcxxabi" \
	-DBUILD_SHARED_LIBS=OFF \
	-DLLVM_ENABLE_ASSERTIONS=ON \
	-DLLVM_BUILD_INSTRUMENTED=IR \
	-DLLVM_BUILD_RUNTIME=No \
	-DZLIB_ROOT=/usr/include \
        -DZLIB_LIBRARY=/usr/lib/x86_64-linux-gnu/libz.so \
	/llvm-project/llvm
RUN cmake --build .
RUN mkdir /llvm-corpus/stage_profiling
WORKDIR /llvm-corpus/stage_profiling
RUN cmake -G Ninja \
	-DCMAKE_C_COMPILER=/llvm-corpus/stage_instrument/bin/clang \
	-DCMAKE_CXX_COMPILER=/llvm-corpus/stage_instrument/bin/clang++ \
	-DCMAKE_BUILD_TYPE=Release \
	-DLLVM_TARGETS_TO_BUILD=Native \
	-DLLVM_ENABLE_PROJECTS="clang;lld" \
	-DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;compiler-rt" \
	-DBUILD_SHARED_LIBS=OFF \
	-DLLVM_ENABLE_ASSERTIONS=ON \
	-DLLVM_BUILD_INSTRUMENTED=IR \
	-DLLVM_BUILD_RUNTIME=No \
	/llvm-project/llvm
RUN cmake --build .
RUN cmake --build . --target check-llvm; exit 0
RUN cmake --build . --target check-clang; exit 0
RUN /llvm-project/build/bin/llvm-profdata merge -output=/llvm-corpus/profdata.prof /llvm-corpus/stage_profiling/profiles/*.profraw
RUN mkdir /llvm-corpus/stage_pgo
WORKDIR /llvm-corpus/stage_pgo
RUN cmake -G Ninja \
	-DCMAKE_C_COMPILER=/llvm-build/tools/clang/stage2-instrumented-bins/tools/clang/stage2-bins/bin/clang-bolt \
	-DCMAKE_CXX_COMPILER=/llvm-build/tools/clang/stage2-instrumented-bins/tools/clang/stage2-bins/bin/clang++-bolt \
	-DCMAKE_BUILD_TYPE=Release \
	-DLLVM_TARGETS_TO_BUILD=Native \
	-DLLVM_ENABLE_PROJECTS="clang;lld" \
	-DBUILD_SHARED_LIBS=OFF \
	-DLLVM_ENABLE_ASSERTIONS=ON \
	-DLLVM_PROFDATA_FILE=/llvm-corpus/profdata.prof \
	-DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
	-DZLIB_ROOT=/usr/include \
        -DZLIB_LIBRARY=/usr/lib/x86_64-linux-gnu/libz.so \
	-DCMAKE_C_FLAGS="-Xclang -fembed-bitcode=all" \
	-DCMAKE_CXX_FLAGS="-Xclang -fembed-bitcode=all" \
	/llvm-project/llvm
RUN cmake --build .
