xor :: [Bool] -> Bool
xor = not . even . foldr step 0
    where step x acc = if x then 1+acc else acc
