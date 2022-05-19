{-# OPTIONS_GHC -Wall #-}
module LogAnalysis where
import Log

-- Message Parsing
-- --------------------

typeToString :: MessageType -> String 
typeToString Info    = "I"
typeToString Warning = "W"
typeToString (Error x) = "E "++(show x)


parseMessageWords :: MessageType -> [String] -> LogMessage
parseMessageWords mType xs = 
    let timeStamp = read (head xs) :: Int
    in LogMessage mType timeStamp (unwords . tail $ xs)


parseErrorMessageWords :: [String] -> LogMessage
parseErrorMessageWords xs = 
    let severity = read (head xs) :: Int
    in parseMessageWords (Error severity) (tail xs)


parseMessage :: String -> LogMessage
parseMessage str = case messageWords of 
                     "I":xs -> parseMessageWords Info xs
                     "W":xs -> parseMessageWords Warning xs
                     "E":xs -> parseErrorMessageWords xs
                     _      -> Unknown str
                   where messageWords = words str


parse :: String -> [LogMessage]
parse s = map parseMessage (lines s)


-- Log Sorting
-- --------------------

-- Give timestamp of LogMessage, if it is unknown return -1.
logTime :: LogMessage -> Int
logTime (LogMessage _ time _) = time
logTime _ = -1


insert :: LogMessage -> MessageTree -> MessageTree
insert (Unknown _) tree = tree
insert x@(LogMessage _ _ _) Leaf = Node Leaf x Leaf
insert x@(LogMessage _ _ _) (Node left y right) 
  | (logTime x <= logTime y) = Node (insert x left) y right -- Insert x in left subtree
  | otherwise = Node left y (insert x right)                -- Insert x in right subtree


build :: [LogMessage] -> MessageTree
build (m:ms) = insert m (build ms)
build [] = Leaf 


inOrder :: MessageTree -> [LogMessage]
inOrder (Node left root right) = (inOrder left) ++ [root] ++ (inOrder right)
inOrder Leaf = []


-- Log file postmortem
-- --------------------

logMessageString :: LogMessage -> String
logMessageString (LogMessage _ _ str) = str
logMessageString (Unknown str) = str


isWrongMessage :: LogMessage -> Bool
isWrongMessage (LogMessage (Error severity) _ _) = severity > 50
isWrongMessage _ = False


whatWentWrong :: [LogMessage] -> [String]
whatWentWrong logs  = let filteredLogs = filter isWrongMessage logs
                        in let orderedLogs = inOrder . build $ filteredLogs
                          in map logMessageString orderedLogs
