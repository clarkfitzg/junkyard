# How productive can you be from the command line?

ygui = c(1, 0.8, 0.5, 0.1, 0, 0)
ycmd = c(0.2, 0.3, 0.4, 0.6, 0.8, 1)
x = seq(0, 1, along.with = ygui)
splinex = function(y) spline(x, y, n = 100)
plot(splinex(ygui)
     , type = "l"
     , main = "Productivity for beginner - intermediate programmers"
     , ylim = c(0, 1)
     #, yaxt = "n"
     , xlab = "Task Complexity"
     , ylab = "Relative productivity"
     )
lines(splinex(ycmd), lty = 2)
legend("bottomleft", c("Click through", "Command line"), lty = 1:2)
