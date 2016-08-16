# Writes this line to stderr
# cat: /proc/cpuinfo: No such file or directory

# So we want to grab this line


# Still goes to stderr
#capture.output(
#    parallel::detectCores(all.tests = TRUE, logical = FALSE)
#    , file = stdout(), type = "message"
#)

# Still goes to stderr
#capture.output(
#    parallel::detectCores(all.tests = TRUE, logical = FALSE)
#    , file = stdout(), type = "output"
#)

# Still goes to stderr
#sink(file = stdout(), type = "message")
#parallel::detectCores(all.tests = TRUE, logical = FALSE)
#sink(file = NULL, type = "message")

# Nope
#sink(file = stdout(), type = "output")
#parallel::detectCores(all.tests = TRUE, logical = FALSE)
#sink(file = NULL, type = "output")

# Maybe since it's coming from a system command something weirder is
# happening

# Still goes to stderr
capture.output(
    system2("cat", "nonexistent.file")
    , file = stdout(), type = "message"
)

parallel::detectCores(logical = FALSE)


write("prints to stderr", stderr())
