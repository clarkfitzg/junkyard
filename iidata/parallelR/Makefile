bootbetas.so: bootbetas.c
	R CMD SHLIB $<

test_openmp.so: test_openmp.c
	gcc -std=gnu99 -fopenmp -I/usr/share/R/include -fpic -g -O2 -c $< -o test_openmp.o
	gcc -std=gnu99 -shared -o $@ test_openmp.o -L/usr/lib/R/lib -lR -lgomp

hellomp: hellomp.c
	gcc $< -o $@ -fopenmp
