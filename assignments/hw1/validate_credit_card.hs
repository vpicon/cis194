-- Obtains list of digits of given integer n. In big endian order.
toDigits :: Integer -> [Integer]
toDigits xs = reverseList (toDigitsRev xs)


-- Obtains list of digits of given integer n. In little endian order.
toDigitsRev :: Integer -> [Integer]
toDigitsRev n
  | n > 0     = (mod n 10) : toDigitsRev (div n 10)
  | otherwise = []


-- Reverses a list
reverseList :: [a] -> [a]
reverseList []     = []
reverseList (x:[]) = [x]
reverseList (x:xs) = reverseList xs ++ [x]


-- Double every other digit of a number list, looking from the end
doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther []         = []
doubleEveryOther (x:[])     = [x]
doubleEveryOther (x:(y:zs)) = if length zs `mod` 2 == 0
                              then [2*x, y] ++ doubleEveryOther zs
                              else x : doubleEveryOther (y:zs)

-- Sum the digits of all numbers in the list
sumDigits :: [Integer] -> Integer
sumDigits [] = 0
sumDigits (x:xs) = sumIntegerDigits x + sumDigits xs


-- Sum the digits of the given positive number
sumIntegerDigits n 
  | n > 0     = n `mod` 10 + sumIntegerDigits (div n 10)
  | otherwise = 0


-- Indicates whether an Integer could be a valid credit card number.
validate :: Integer -> Bool
validate n
  | n > 0     = sumDigits (doubleEveryOther (toDigits n)) `mod` 10 == 0
  | otherwise = False
