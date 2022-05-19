f :: ([a], Int) -> [a]
f (xs, i) 
    | length xs < i = []
    | otherwise = last (take i xs) : f ((drop i xs), i)

skips :: [a] -> [[a]]
skips ls = map f (zip (repeat ls) [1..(length ls)])
