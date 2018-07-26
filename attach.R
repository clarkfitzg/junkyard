d = data.frame(a = 1, b = "foo")

attach(d)

search()
# This won't change
# .GlobalEnv, d, ...

find("a")
# d

a = NA

find("a")
# .GlobalEnv AND d
# Which means that the global version masks the one in d.

d$a
# 1, doesn't change

denv = parent.env(.GlobalEnv)

assign("a", 100, envir = denv)

# Now there are three a's.
# But this doesn't seem so bad. The global one just masks the one attached
# from d.

a
# NA

denv$a
# 100

d$a
# 1
