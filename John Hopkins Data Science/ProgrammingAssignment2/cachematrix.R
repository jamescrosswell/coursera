## The makeCacheMatrix and cacheSolve functions let us store matrices and 
## calculate their inverses. However instead of calculating the inverse of  
## a matrix every time this is requested, a matrix inverse is only calculated
## the first time we ask for it (i.e. on the first call to cacheSolve). 
## During the first call to cacheSolve, the inverse of a cacheMatrix gets 
## stored/cached and this cached value is returned for subsequent calls to 
## cacheSolve (saving a few cpu cycles for large matrices).

## makeCacheMatrix takes a square matrix as a parameter and returns 
## a special list "object" containing three functions get, set and 
## getinverse. The first two (get and set) are simply accessors to 
## the underlying matrix. The last (getinverse) lets us get the 
## inverse of that matrix but also caches the value so that 
## subsequent successive calls to the getinverse method do not require
## recalculation of the matrix inverse.
makeCacheMatrix <- function(x = matrix()) {
    # This is where we store the inverse of the matrix
    inv <- NULL  
    
    # Returns the underlying matrix (x)
    get <- function() x
    
    # Sets the underlying matrix to a new value (and clears the 
    # cached inverse value)
    set <- function(y) {
        x <<- y
        inv <<- NULL
    }
    
    # Returns the inverse of the matrix (from cache, if possible... 
    # this gets calculated and cached otherwise and then returned)
    getinverse <- function(...){
        if(!is.null(inv)) {
            message("getting cached data")
            return(inv)
        }  
        
        message("solving for inverse")
        inv <<- solve(x, ...)
        inv
    }
    
    # Indicates whether or not the inverse is presently cache
    cached <- function() !is.null(inv)
    
    # This is the return value for our function
    list(
        get = get,
        set = set,
        getinverse = getinverse,
        cached = cached
        )
}


## cacheSolve simply calls the underlying getInverse function on our 
## special cacheMatrix object... which takes care of the grunt work of
## either fetching the cached matrix inverse or calculating this (which
## only happens the first time the inverse is requested).
##
## As such, most of the interesting logic is in the getInverse() function
## on the cacheMatrix object
cacheSolve <- function(x, ...) {
      ## Return a matrix that is the inverse of 'x'
      x$getinverse(...)
}
