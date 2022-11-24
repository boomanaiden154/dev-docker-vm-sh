PYTHONPATH=$PYTHONPATH:. python3 compiler_opt/tools/generate_default_trace.py \
    --data_path=/corpus \
    --output_path=/default_trace \
    --gin_files=compiler_opt/rl/regalloc/gin_configs/common.gin \
    --gin_bindings=config_registry.get_configuration.implementation=@configs.RegallocEvictionConfig \
    --gin_bindings=clang_path="'/llvm-project/build/bin/clang'" \
    --sampling_rate=0.1
PYTHONPATH=$PYTHONPATH:. python3 compiler_opt/rl/train_bc.py \
    --root_dir=/warmstart \
    --data_path=/default_trace \
    --gin_files=compiler_opt/rl/regalloc/gin_configs/behavioral_cloning_nn_agent.gin
