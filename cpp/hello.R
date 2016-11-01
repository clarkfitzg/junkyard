require("Rcpp")

# Basically copying and trying stuff from Dirk's website:
# http://dirk.eddelbuettel.com/code/rcpp/Rcpp-modules.pdf



#require("inline")
#s = sourceCpp("hello_r.cpp")
# This function is now available
#times2(10L)
#m = Module(s$modules[1], s$functions[1])
#m$hello()  # Fails to find it...

############################################################
# Now following this
# http://stackoverflow.com/questions/3327697/how-to-make-rcpp-find-a-new-module

dyn.load( "hello.so" )

hello <- Module( "hello", PACKAGE = "hello" )

hello$hello( "world" )
