PYTHONPATH=$PYTHONPATH:. python3 compiler_opt/tools/extract_ir.py \
    --cmd_filter="^-O2|-O3$" \
    --input=/llvm-corpus/stage_pgo/compile_commands.json \
    --input_type=json \
    --llvm_objcopy_path=/llvm-project/build/bin/llvm-objcopy \
    --output_dir=/corpus
