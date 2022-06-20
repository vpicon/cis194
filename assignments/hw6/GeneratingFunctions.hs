{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-missing-methods #-}

import Stream


-- Constants
zeros :: Stream Integer
zeros = streamRepeat 0

x :: Stream Integer
x = Stream 0 (Stream 1 zeros)

instance Num (Stream Integer) where
    fromInteger n = Stream n zeros
    negate = streamMap (*(-1))
    (+) (Stream a0 a') (Stream b0 b') = Stream (a0+b0) (a' + b')
    (*) (Stream a0 a') b@(Stream b0 b') = 
        Stream (a0*b0) ((fromInteger a0)*b' + a'*b)


instance Fractional (Stream Integer) where
    (/) a@(Stream a0 a') b@(Stream b0 b') = 
        Stream (div a0 b0) ((a'/(fromInteger b0) - (a/b)*b'/(fromInteger b0)))


fibs3 :: Stream Integer
fibs3 = x/(1 - x - x^2)

