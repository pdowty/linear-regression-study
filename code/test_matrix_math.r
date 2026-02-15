x <- c(1,2,3,4,5)
m <- 10
b <- 1
resid <- data.frame(x1=c(10,12,22),
                    x2=c(11,13,23),
                    x3=c(13,13,24),
                    x4=c(14,14,25),
                    x5=c(16,15,26))

try1 <- m*x +b + resid

xdf <- data.frame(x1=rep(x[1],3),
                  x2=rep(x[2],3),
                  x3=rep(x[3],3),
                  x4=rep(x[4],3),
                  x5=rep(x[5],3))

try2a <- m*xdf + b
try2 <- try2a + resid

