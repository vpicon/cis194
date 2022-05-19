-- Other than foldl we have foldr:
--
--     foldr :: (a -> b -> b) -> b -> [a] -> b
--     foldr step zero (x:xs) = step x (foldr step zero xs)
--     foldr _    zero []     = zero
--
--
-- Example of application
-- foldr (+) 0 (1:2:3:[])
--           == 1 +           foldr (+) 0 (2:3:[])
--           == 1 + (2 +      foldr (+) 0 (3:[])
--           == 1 + (2 + (3 + foldr (+) 0 []))
--           == 1 + (2 + (3 + 0))
--
--
-- The functions which can be written in terms of foldr are called
--   primitive recursive. 
--
-- Surprisingly, a large set of functions is primitive recursive.
--


myFilter :: (a -> Bool) -> [a] -> [a]
myFilter p xs = foldr step [] xs
    where step x ys | p x       = x : ys
                    | otherwise = ys


myMap :: (a -> b) -> [a] -> [b]
myMap f xs =  foldr step [] xs
    where step x ys = f x : ys


myFoldl :: (a -> b -> a) -> a -> [b] -> a

myFoldl f z xs = foldr step id xs z
    where step x g a = g (f a x)

-- Another useful way to think about it is that it transforms its 
-- input list. Its first two arguments are "what to do with each 
-- head/tail element of the list", and "what to substitute for the 
-- end of the list".

identity :: [a] -> [a]
identity xs = foldr (:) [] xs

-- This gives us another way to look at Haskell's list append 
-- function, (++).

append :: [a] -> [a] -> [a]  
append xs ys = foldr (:) ys xs

-- Due to the thunking behavior of foldl, it is wise to avoid this 
-- function in real programs: even if it doesn't fail outright, 
-- it will be unnecessarily inefficient. 
--
-- Instead, import Data.List and use foldl'. <<<<<<<<<<<<<<
--
--Exercise 3
myConcat :: [[a]] -> [a]
myConcat xss = foldr step [] xss
    where step xs ys = xs ++ ys
