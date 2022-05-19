{-
    Haskell Pattern Matching
    ----------------------------

     Haskell runtime checks the value we supply against the 
    value constructor in the first pattern. 

    If it does not match, tries the second pattern.
     At match, it succeeds using the right hand side of the 
    equation as the result of the function application
-}

myNot :: Bool -> Bool
myNot True  = False
myNot False = True

-- Here  the pattern to be used is the ":", which is the 
-- familiar list constructor, (:)
--
-- For example [1, 2, 3] is constructed by (1: (2:[])), so it
-- will match the (x:xs) match expression.
sumList :: [Integer] -> Integer
sumList []     = 0
sumList (x:xs) = x + sumList xs


rare (x: xs) = x + rare xs
rare _  = 0

data Polar = Polar {
      x :: Integer,
      y :: Integer
    } deriving (Show)
