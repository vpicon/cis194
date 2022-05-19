data List t = E 
            | C t (List t)
            deriving Show



-- One important thing to remember about polymorphic functions is 
-- that the caller gets to pick the types !!!
--
-- When you write a polymorphic function, it must work for every 
-- possible input type.


filterList :: (t -> Bool) -> List t -> List t
filterList _ E = E
filterList p (C x xs)
  | p x       = C x (filterList p xs)
  | otherwise = filterList p xs



-- Too restrictive attempt for mapList:
--    mapList :: (t -> t) -> List t -> List t
-- Let's make it more generic:
mapList :: (a -> b) -> List a -> List b
mapList _ E = E
mapList f (C x xs) = C (f x) (mapList f xs)


-- What if you find yourself writing a partial functions? 
-- There are two approaches to take. The first is to change the 
-- output type of the function to indicate the possible failure. 
-- Recall the definition of Maybe:
--     data Maybe a = Nothing | Just a

-- For example a safer total head function:
safeHead :: [a] -> Maybe a
safeHead []    = Nothing
safeHead (x:_) = Just x


-- OK, but what if we know that we will only use head in situations 
-- where we are guaranteed to have a non-empty list? In such a 
-- situation, it is really annoying to get back a Maybe a, since we 
-- have to expend effort dealing with a case which we “know” cannot 
-- actually happen.

-- The answer is that if some condition is really guaranteed, then 
-- the types ought to reflect the guarantee! Then the compiler can 
-- enforce your guarantees for you. For example:

data NonEmptyList a = NEL a [a]

nelToList :: NonEmptyList a -> [a]
nelToList (NEL x xs) = x:xs

listToNel :: [a] -> Maybe (NonEmptyList a)
listToNel []     = Nothing
listToNel (x:xs) = Just $ NEL x xs

headNEL :: NonEmptyList a -> a
headNEL (NEL a _) = a

tailNEL :: NonEmptyList a -> [a]
tailNEL (NEL _ as) = as

