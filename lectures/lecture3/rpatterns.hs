data IntList = Empty 
             | Cons Int IntList
             deriving Show

addOne :: Int -> Int 
addOne x = x + 1

square x = x * x


mapIntList :: (Int -> Int) -> IntList -> IntList
mapIntList _ Empty = Empty
mapIntList f (Cons x xs) 
  = Cons (f x) (mapIntList f xs)


filterIntList :: (Int -> Bool) -> IntList -> IntList
filterIntList _ Empty = Empty
filterIntList test (Cons x xs)
  | test x    = Cons x (filterIntList test xs)
  | otherwise = filterIntList test xs


reduceIntList :: (Int -> Int -> Int) -> IntList -> Int
reduceIntList _ Empty = 0
reduceIntList _ (Cons x Empty) = x
reduceIntList f (Cons x xs) = f x (reduceIntList f xs)
