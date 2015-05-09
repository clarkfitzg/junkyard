#!/bin/bash

for run in {1..3}
do
    for order in ijk ikj jik jki kij kji
    do
        for n in 100 200 500 1000 2000 5000
        do
            echo hello $n $order
        done
    done
done
