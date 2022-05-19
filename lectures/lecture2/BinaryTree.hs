data Tree a = Node a (Tree a) (Tree a)
            | Nil
              deriving (Show)
