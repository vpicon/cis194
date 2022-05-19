listLength :: [a] -> Int
listLength [] = 0
listLength (x : xs) = 1 + listLength xs

sumEveryTwo :: [Int] -> [Int]
sumEveryTwo []         = []  -- Do nothing for empty list
sumEveryTwo [x]        = [x] -- Do nothing for single element list
sumEveryTwo (x:(y:zs)) = (x + y) : sumEveryTwo zs
