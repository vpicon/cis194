-- Given an integer n, returns the nth fibonacci number.
-- Recursive implementation, so exponential time.
fib :: Integer -> Integer
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)


fibs :: [Integer]
fibs = map fib [0..]
-- fibs = foldr (\x xs -> (fib x) : xs) undefined $ [0..]


-- Given an integer n, returns the nth fibonacci number.
-- Dynamic programming implementation, O(n) time.
fibs2 :: [Integer]
fibs2 = foldr f undefined [0..]
    where f n xs 
            | n == 0    = 0:xs
            | n == 1    = 1:xs
            | otherwise = (f1 + f2):xs where f1 = head (f (n-1) xs)
                                             f2 = head (f (n-2) xs)


