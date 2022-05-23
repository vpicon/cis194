{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
import StackVM
import Parser
import Calc


instance Expr Program where
    lit n = [PushI n]
    add p q = p ++ q ++ [Add]
    mul p q = p ++ q ++ [Mul]


compile :: String -> Maybe Program
compile = parseExp lit add mul


compute :: String -> Either String StackVal
compute str = case program of
                Just p -> stackVM p
                _      -> Left ("Error compiling program: " ++ str)
              where program = compile str
