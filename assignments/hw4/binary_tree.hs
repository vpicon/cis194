data Tree a = Leaf
            | Node Integer (Tree a) a (Tree a)
            deriving (Show, Eq)


-- Returns the height of a given tree, with -1 the height of a Leaf.
height :: Tree a -> Integer
height Leaf = -1
height (Node h _ _ _) = h


-- Augments a balanced binary tree to append it the given new element, 
-- and keeps it balanced.
augmentTree :: a -> Tree a -> Tree a  
augmentTree x Leaf = Node 0 Leaf x Leaf
augmentTree x t@(Node h left y right) =
    if (diffHeight augLeft right <= 1) 
       then Node ((maxHeight augLeft right) + 1) augLeft y right
    else Node ((maxHeight left augRight) + 1) left y augRight
    where augLeft = augmentTree x left 
          augRight = augmentTree x right
          diffHeight l r = abs (height l - height r) 
          maxHeight  l r = max (height l) (height r) 


-- Returns a balanced binary tree from a given list of elements.
-- Remark: A balanced binary tree is not a nearly complete binary tree.
foldTree :: [a] -> Tree a
foldTree = foldr augmentTree Leaf 
