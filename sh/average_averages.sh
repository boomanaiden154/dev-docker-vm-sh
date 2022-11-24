for j in {1..30}
do
    python3 /scripts/benchmark_average.py test-1.$j.benchmark.txt >> benchmarks-rtr.txt
done
