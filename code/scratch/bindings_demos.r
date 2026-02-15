# demos from Advanced R
# Advanced R (https://adv-r.hadley.nz) 

library(lobstr)

# demo of copy binding to value
x <- c(1,2,3)
print("--- Binding to a value")
print(obj_addr(x))

# y is just another binding to the same object 
y <- x
print("--- Another binding to same object")
print(sprintf("x address: %s",obj_addr(x)))
print(sprintf("y address: %s",obj_addr(y)))

# demo of copy-on-modify for object with multiple bindings (x & y bindings)
print("--- copy-on-modify")
y[[3]] <- 4
print(sprintf("x address: %s",obj_addr(x)))
print(sprintf("y address: %s",obj_addr(y)))

# demo of no-copy use of function arguments
print("--- no-copy use of function arguments")
f <- function(a) {
  a
}
x <- c(4,5,6)
print(sprintf("x address: %s",obj_addr(x)))
z <- f(x)
print(sprintf("z address: %s",obj_addr(z)))

# demo get object size
obj_size(x)


# demo of modify-in-place for object with a single binding (according to
# Advanced R (https://adv-r.hadley.nz) section 2.5.1
print("--- modify-in-place for single binding")
v <- c(1,2,3)
print(sprintf("z address: %s",obj_addr(z)))

v[[3]] <- 5
print(sprintf("z address: %s",obj_addr(z)))
