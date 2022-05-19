import Data.List 

sieveSundaram :: Integer -> [Integer]
sieveSundaram 1 = [1]
sieveSundaram 2 = [1, 2]
sieveSundaram n = 
    let ijs = filter (<= n) [i + j + 2*i*j | i <- [1..n], j <- [1..n]]
        rests = filter (\x -> not $ elem x ijs) [1..n]
    in [1, 2] ++ map (\x -> x*2 + 1) rests
     
