library('testthat')

source('cachematrix.R')

test_that("makeCacheMatrix function works as expected", {    
    # Make a cached matrix
    m <- matrix(1:4,2,2)
    x <- makeCacheMatrix(m)
        
    # Make sure it's the expected type
    expect_that( x, is_a("list") )
    
    # Check the matrix has been stored correctly
    fetched <- x$get()
    expect_that( fetched, is_a("matrix") )
    expect_that( fetched, is_equivalent_to(m) )
    
    # Make sure the inverse has not yet been calculated/cached
    expect_false(x$cached())
    
    # Now calculate the inverse
    inv <- x$getinverse()
    
    # check it's what we're expecting:
    #     [,1] [,2]
    #     [1,]   -2  1.5
    #     [2,]    1 -0.5     
    expected <- matrix(c(-2,1,1.5,-0.5),2,2)
    expect_that( inv, is_a("matrix") )
    expect_that( inv, is_equivalent_to(expected) )
        
    # Make sure the inverse has been cached
    expect_true(x$cached())
    test_that(x$getinverse(), shows_message("getting cached data"))    
})

test_that("makeCacheMatrix function works as expected", {    
    # Make a cached matrix
    m <- matrix(1:4,2,2)
    x <- makeCacheMatrix(m)
    
    # Make sure the inverse has not yet been calculated/cached
    expect_false(x$cached())
    
    # Solve for the inverse
    inv <- cacheSolve(x)
    
    # check it's what we're expecting:
    #     [,1] [,2]
    #     [1,]   -2  1.5
    #     [2,]    1 -0.5     
    expected <- matrix(c(-2,1,1.5,-0.5),2,2)
    expect_that( inv, is_a("matrix") )
    expect_that( inv, is_equivalent_to(expected) )
    
    # Make sure the inverse has been cached
    expect_true(x$cached())    
})