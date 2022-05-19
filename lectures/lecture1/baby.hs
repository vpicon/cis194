doubleMe x = x + x

doubleUs x y = doubleMe x + doubleMe y

doubleSmallNumber x = if x > 100  then x  else x*2 
doubleSmallNumber' x = (doubleSmallNumber x) + 1

e = exp 1

length' xs = sum [1 | _ <- xs]

-- Compute the sum of the integers from 1 to n.
sumtorial :: Integer -> Integer
sumtorial 0 = 0
sumtorial n = n + sumtorial (n-1)
