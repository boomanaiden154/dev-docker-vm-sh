for i in {1..30}
do
    for j in {1..30}
    do
        /scripts/benchmark.sh ./test-$i test-$i.$j.benchmark.txt
        python3 /scripts/benchmark_average.py test-$i.benchmark.txt >> test-$i.benchmarks-review.txt
    done
done
