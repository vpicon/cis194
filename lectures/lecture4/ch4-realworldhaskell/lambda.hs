-- But as we can't write multiple clauses to define a lambda, 
-- we must be certain that any patterns we use will match.
unsafeHead = \(x:_) -> x
-- The definition typechecks, so it will compile, 
-- so the error will occur at runtime. <<<<<<<<<<<<<<<<<<<


mySum :: [Integer] -> Integer
mySum xs = foldr (\x y -> x+y) 0 xs

mySum2 :: [Integer] -> Integer
mySum2 xs = foldr (+) 0 xs

myNicerSum :: [Integer] -> Integer
myNicerSum = foldr (+) 0


isLowerCase :: Char -> Bool
isLowerCase = (`elem` ['a'..'z'])

