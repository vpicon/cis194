# Rules Of Thumb For `foldr` and `foldl'`
`foldr` is not only the right fold, it is also most commonly the right fold 
to use, in particular when transforming lists (or other foldables) into lists 
with related elements in the same order. Notably, `foldr` will be effective 
for transforming even infinite lists into other infinite lists. For such 
purposes, it should be your first and most natural choice. For example, 
note that `foldr (:) [] == id`

Note that the initial element is irrelevant (never used) when `foldr` is 
applied to an infinite list. For that reason, it is may be good practice when 
writing a function which should only be applied to infinite lists to replace 
`foldr f []` with `foldr f undefined`. 
This both documents that the function should only be applied to infinite lists 
and will result in an error when you try to apply it to a finite list. 

The other very useful fold is `foldl'`. It can be thought of as a foldr with these differences:
* `foldl'` conceptually reverses the order of the list. One consequence is that a `foldl'` (unlike `foldr`) applied to an infinite list will be bottom; it will not produce any usable results, just as an express reverse would not. Note that `foldl' (flip (:)) [] == reverse`.
* `foldl'` often has much better time and space performance than a `foldr` would for the reasons explained in the previous sections.

You should pick foldl' principally in two cases:
* When the list to which it is applied is large, but definitely finite, you do not care about the implicit reversal (for example, because your combining function is commutative like `(+)`, `(*)`, or `Set.union`), and you seek to improve the performance of your code.
* When you actually do want to reverse the order of the list, in addition to possibly performing some other transformation to the elements. In particular, if you find that you precede or follow your fold with a reverse, it is quite likely that you could improve your code by using the other fold and taking advantage of the implicit reverse.

Another reason that `foldr` is often the better choice is that the folding function can *short-circuit*, that is, terminate early by yielding a result which does not depend on the value of the accumulating parameter. When such possibilities arise with some frequency in your problem, short-circuiting can greatly improve your program's performance. Left folds can never short-circuit. 

------------------------------------------------------------------------------------
Principal source: [Foldr Foldl Foldl'](https://wiki.haskell.org/Foldr_Foldl_Foldl').
