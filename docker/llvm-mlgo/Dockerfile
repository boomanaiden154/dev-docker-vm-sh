FROM mlgo-development:latest
RUN git clone https://github.com/llvm/llvm-project
RUN mkdir /llvm-project/build
WORKDIR /llvm-project/build
RUN cmake -G Ninja \
    	-DCMAKE_BUILD_TYPE=Release \
    	-DTENSORFLOW_AOT_PATH=$(python3 -c "import tensorflow; import os; print(os.path.dirname(tensorflow.__file__))") \
    	-DLLVM_ENABLE_PROJECTS="clang;lld" \
    	-DLLVM_ENABLE_RUNTIMES="compiler-rt" \
	-DLLVM_ENABLE_ASSERTIONS=ON \
	-C /tflite/tflite.cmake \
    	/llvm-project/llvm
RUN ninja all
