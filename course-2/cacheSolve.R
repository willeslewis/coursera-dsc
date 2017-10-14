cacheSolve <- function(x, ...) {
        invx <- x$getinv()
        print(invx)
        if(!is.null(invx)) {
                message("getting cached data")
                return(invx)
        }
        data <- x$get()
        invx <- solve(data, ...)
        x$setinv(invx)
        invx
}