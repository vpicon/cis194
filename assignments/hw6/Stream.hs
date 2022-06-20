module Stream where

data Stream a = Stream a (Stream a) 


streamToList :: Stream a -> [a]
streamToList (Stream x xs) = x : streamToList xs
-- streamToList = foldr (:) undefined  <-  NO! Stream is not instace of Foldable

instance Show a => Show (Stream a) where
    show = show . take 20 . streamToList 

-- Streaming Tools
------------------------------------------------
streamRepeat :: a -> Stream a
streamRepeat x = Stream x (streamRepeat x)


streamMap :: (a -> b) -> Stream a -> Stream b
streamMap f (Stream x xs) = Stream (f x) (streamMap f xs)


streamFromSeed :: (a -> a) -> a -> Stream a
streamFromSeed f x =  Stream x (streamFromSeed f (f x))


interleaveStreams :: Stream a -> Stream a -> Stream a
interleaveStreams (Stream x xs) (Stream y ys) = 
    Stream x (Stream y (interleaveStreams xs ys))


-- Some Stream objects
-- ---------------------------------------------
nats :: Stream Integer
nats = streamFromSeed (+1) 0


-- ruler :: Stream Integer
-- ruler = 

