## The functions in this script will cache matrix inverse data
## so that the matrix inverse need only be calculated once for a 
## given matrix

## makeCacheMatrix takes as input a matrix and outputs a list
## of functions. Those functions are: 
## set which sets teh value of the matrix
## and allows the matrix to be accessible in 
## environments outside of the makeCacheMatrix environment 
## get used to access the matrix
## setinv which will set the matrix inverse
## getinv can be used to access the matrix inverse to determine
##if it is cached

makeCacheMatrix <- function(x = matrix()) {
        invx <- NULL
        set <- function(y) {
                x <<- y
                invx <<- NULL
        }
        get <- function() x
        setinv <- function(inverted) invx <<- inverted
        getinv <- function() invx
        list(set = set, get = get,
             setinv = setinv,
             getinv = getinv)
}

## Operates using the functions in the list created by 
## makeCacheMatrix to see if the matrix inverse is cached
## if so it will return the cached value
## if not it will calculate and cache the inverse

cacheSolve <- function(x, ...) {
        invx <- x$getinv()
        if(!is.null(invx)) {
                message("getting cached data")
                return(invx)
        }
        data <- x$get()
        invx <- solve(data, ...)
        x$setinv(invx)
        invx
}