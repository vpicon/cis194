{-# OPTIONS_GHC -Wall #-}

-- Type definitions for the Hanoi Towers
type Peg  = String
type Move = (Peg, Peg)


-- To move n discs (stacked in increasing size) from peg a to peg b
-- using peg c as temporary storage,
--     1. move n − 1 discs from a to c using b as temporary storage,
--     2. move the top disc from a to b,
--     3. move n − 1 discs from c to b using a as temporary storage.
hanoi :: Integer -> Peg -> Peg -> Peg -> [Move]
hanoi n fromPeg toPeg auxPeg
  | n <= 0    = []
  | otherwise =  (hanoi (n-1) fromPeg auxPeg toPeg) 
              ++ [(fromPeg, toPeg)]
              ++ (hanoi (n-1) auxPeg toPeg fromPeg) 


