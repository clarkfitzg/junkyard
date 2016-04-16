library(gam)

npts = 50
pts = seq(0, 1, length.out=npts)

xy = expand.grid(x=pts, y=pts)

plot3d = function(zvector, title='', ...){
    # Helper function for 3d plots
    z = matrix(zvector, nrow=npts)
    persp(x, y, z, zlab='f(x, y)'
          , theta=-10, phi=10
          , main=title
          )
}

xy$z = xy$x * xy$y

plot3d(xy$z)

# Trying out gam software
# This ought to be the same as a linear model
fit1 = gam(z ~ x + y, data=xy)

plot3d(fitted(fit1))

plot3d(residuals(fit1))

fit2 = gam(z ~ s(x, 4) + s(y, 4), data=xy)

plot3d(fitted(fit2))
# Even with the smoothing splines it can't be fit

# a polynomial in x, y should work very well
xy$z = with(xy, 2 + 3*x -4*x^2 -y + y^2)

plot3d(xy$z)

fit3 = gam(z ~ s(x, 4) + s(y, 4), data=xy)

plot3d(fitted(fit3))

hist(residuals(fit3))
