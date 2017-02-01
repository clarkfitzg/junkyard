Wed Feb  1 14:26:47 PST 2017

Debugging with valgrind.

```
$ R -d valgrind -e "source('test_bootbetas.R')"
==8008== Memcheck, a memory error detector
==8008== Copyright (C) 2002-2015, and GNU GPL'd, by Julian Seward et al.
==8008== Using Valgrind-3.11.0 and LibVEX; rerun with -h for copyright info
==8008== Command: /usr/lib/R/bin/exec/R --no-save -e source('test_bootbetas.R')
==8008==

R version 3.3.2 (2016-10-31) -- "Sincere Pumpkin Patch"
Copyright (C) 2016 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

> source('test_bootbetas.R')
==8008== Invalid read of size 8
==8008==    at 0x15B08670: fit_ols (bootbetas.c:15)
==8008==    by 0x4F0A57F: ??? (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F4272E: Rf_eval (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F45FB5: ??? (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F42520: Rf_eval (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F4747E: ??? (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F35D27: ??? (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F4215F: Rf_eval (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F43DDC: Rf_applyClosure (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F3CC3F: ??? (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F4215F: Rf_eval (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F42A3A: ??? (in /usr/lib/R/lib/libR.so)
==8008==  Address 0x134cbe68 is 0 bytes after a block of size 80,040 alloc'd
==8008==    at 0x4C2DB8F: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==8008==    by 0x4F735AC: Rf_allocVector3 (in /usr/lib/R/lib/libR.so)
==8008==    by 0x150CF627: ??? (in /usr/lib/R/library/stats/libs/stats.so)
==8008==    by 0x4F3A27C: ??? (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F4215F: Rf_eval (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F43DDC: Rf_applyClosure (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F422FC: Rf_eval (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F45FB5: ??? (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F42520: Rf_eval (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F4747E: ??? (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F35D27: ??? (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F4215F: Rf_eval (in /usr/lib/R/lib/libR.so)
==8008==
==8008== Invalid read of size 8
==8008==    at 0x15B08675: fit_ols (bootbetas.c:16)
==8008==    by 0x4F0A57F: ??? (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F4272E: Rf_eval (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F45FB5: ??? (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F42520: Rf_eval (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F4747E: ??? (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F35D27: ??? (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F4215F: Rf_eval (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F43DDC: Rf_applyClosure (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F3CC3F: ??? (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F4215F: Rf_eval (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F42A3A: ??? (in /usr/lib/R/lib/libR.so)
==8008==  Address 0x134f7ed8 is 0 bytes after a block of size 80,040 alloc'd
==8008==    at 0x4C2DB8F: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==8008==    by 0x4F735AC: Rf_allocVector3 (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4EB3EA8: ??? (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4EB8220: ??? (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F42678: Rf_eval (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F4613B: ??? (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F42604: Rf_eval (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F4613B: ??? (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F42604: Rf_eval (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F45FB5: ??? (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F42520: Rf_eval (in /usr/lib/R/lib/libR.so)
==8008==    by 0x4F4747E: ??? (in /usr/lib/R/lib/libR.so)
==8008==

 *** caught segfault ***
address 0x13e01000, cause 'invalid permissions'

Traceback:
 1: .Call("fit_ols", x, y, n, beta)
 2: eval(expr, envir, enclos)
 3: eval(ei, envir)
 4: withVisible(eval(ei, envir))
 5: source("test_bootbetas.R")
An irrecoverable exception occurred. R is aborting now ...
==8008==
==8008== Process terminating with default action of signal 11 (SIGSEGV)
==8008==    at 0x5464269: raise (pt-raise.c:35)
==8008==    by 0x546438F: ??? (in /lib/x86_64-linux-gnu/libpthread-2.23.so)
==8008==    by 0x15B08674: fit_ols (bootbetas.c:15)
==8008==
==8008== HEAP SUMMARY:
==8008==     in use at exit: 29,617,508 bytes in 13,254 blocks
==8008==   total heap usage: 27,388 allocs, 14,134 frees, 52,209,717 bytes allocated
==8008==
==8008== LEAK SUMMARY:
==8008==    definitely lost: 0 bytes in 0 blocks
==8008==    indirectly lost: 0 bytes in 0 blocks
==8008==      possibly lost: 864 bytes in 3 blocks
==8008==    still reachable: 29,616,644 bytes in 13,251 blocks
==8008==         suppressed: 0 bytes in 0 blocks
==8008== Rerun with --leak-check=full to see details of leaked memory
==8008==
==8008== For counts of detected and suppressed errors, rerun with: -v
==8008== ERROR SUMMARY: 1048915 errors from 2 contexts (suppressed: 1 from 1)
Killed
clark@DSI-CF ~/junkyard/iidata/parallelR (master)
$
```

Looks like the relevant one is this one:

```
==8008==  Address 0x134cbe68 is 0 bytes after a block of size 80,040 alloc'd
```
