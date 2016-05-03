/**
map a function over a value with context

Expected function type: `(a -> b) -> f a -> f b`

*/
infix operator <^> {
    associativity left

    // Same precedence as the equality operator (`==`)
    precedence 130
}

/**
apply a function with context to a value with context

Expected function type: `f (a -> b) -> f a -> f b`
*/
infix operator <*> {
    associativity left

    // Same precedence as the equality operator (`==`)
    precedence 130
}

/**
map a function over a value with context and flatten the result

Expected function type: `m a -> (a -> m b) -> m b`
*/
infix operator >>- {
    associativity left

    // Lower precedence than the logical comparison operators
    // (`&&` and `||`), but higher precedence than the assignment
    // operator (`=`)
    precedence 100
}

/**
map a function over a value with context and flatten the result

Expected function type: `(a -> m b) -> m a -> m b`
*/
infix operator -<< {
    associativity right

    // Lower precedence than the logical comparison operators
    // (`&&` and `||`), but higher precedence than the assignment
    // operator (`=`)
    precedence 100
}
