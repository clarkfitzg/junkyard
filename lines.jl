using Base.Iterators: peel

# What is going on here?
# https://mikeinnes.github.io/2020/06/04/iterate.html
# The author calims that you can't have infinite functional data structures.
#
# iterate(x) returns the next element in x, and the new iteration state.
# iterate(x, curstate) returns the next element in x, and the new iteration state, starting from `curstate` as the state.
# 
# For the alternate implementation to work, iterate(x) should return the next element in x, and a new iterator that knows what the next element should be.
# In other words, the current state (`curstate` above) is part of the iterator.
#
# How does the alternate iteration protocol prevent memory leaks?
# Both implementations require you to maintain the current state.
# Is it somehow easier for 

# This is relevant to developers implementing the iteration protocol, particularly if they are worried about memory efficiency.
#
# As an end user I would iterate over a data structure `xlazy`, and expect it to use O(1) memory:
#
# for x in xlazy
#   foo(x)
# end

lines = eachline("README.md")
nr = enumerate(lines)

for (i, line) in nr
    println(i)
    println(line)
end

xlazy = Iterators.countfrom()

iterate(xlazy)
# same thing:
iterate(xlazy)

# Iterating over Iterators.countfrom returns to the first element every time.
# In other words, `iterate(xlazy)` does not mutate `xlazy`, which appears more like functional programming to me as an end user.
#
# In contrast to Julia's The second way only uses the one argument call to 
#
# itr = iterator(xs)
# while true
#   next = iterate(itr)
#   next == nothing && break
#   x, itr = next
#   # do something with x
# end

for i in xlazy
    if i > 3
        break
    end
end

# Iterating over the lines of a file maintains state.
# Some iterators are stateful, and some are not.
# This is similar to how an array would behave
peel(lines)

