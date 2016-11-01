require("Rcpp")

# Try 1
############################################################
# Basically copying and trying stuff from Dirk's website:
# http://dirk.eddelbuettel.com/code/rcpp/Rcpp-modules.pdf

#require("inline")
#s = sourceCpp("hello_r.cpp")
# This function is now available
#times2(10L)
#m = Module(s$modules[1], s$functions[1])
#m$hello()  # Fails to find it...

# Try 2
############################################################
# Now following this
# http://stackoverflow.com/questions/3327697/how-to-make-rcpp-find-a-new-module

#dyn.load( "hello.so" )
#hello <- Module( "hello", PACKAGE = "hello" )
#hello$hello( "world" )

# Try 3
############################################################
# problem may have been that the files lack the code found in
# RcppExports.cpp

# Start out with a skeleton
#Rcpp.package.skeleton(module=TRUE)
# Trim it to make some minimal example then run this:
#compileAttributes("anRpackage")

library("anRpackage")

anRpackage::hello()

anRpackage::times2(10L)

anRpackage::times3(10L)

# If we inspect the object we see that it's of class C++ function and it
# did grab type and signature info.
# Nitpick- doc string should be available by calling ?times2

# Next step- see what it takes for Rcpp to do this sort of thing for code
# which is not in the package directory. 
