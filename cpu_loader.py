'''
cpu_loader.py

Load a CPU by adding integers. Watch this program run and you can also
see the memory effiency that comes from reducing an iterator, since
each process uses only about 2 MB of memory.
'''

import multiprocessing

ncores = multiprocessing.cpu_count()

numbers = [int(1e9)] * ncores

def big_sum(n):
    return sum(range(n))

with multiprocessing.Pool(ncores) as pool:
    results = pool.map(big_sum, numbers)

print(results)
