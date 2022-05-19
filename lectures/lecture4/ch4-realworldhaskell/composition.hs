import Data.Char
import Data.List (isPrefixOf)
 
-- Counting the number of words in a string that begin with a capital 
-- letter:
capCount :: String -> Int
capCount = length . filter (isUpper . head) . words


{-
We want to extract a list of macro names from a C header file shipped 
with libpcap, a popular network packet filtering library. 
The header file contains a large number definitions of the following 
form. No comments

#define DLT_EN10MB      1       /* Ethernet (10Mb) */
#define DLT_EN3MB       2       /* Experimental Ethernet (3Mb) */
#define DLT_AX25        3       /* Amateur Radio AX.25 */
-}

dlts :: String -> [String]
dlts = foldr step [] . lines
    where step line ds
            | isPrefixOf "#define DLT_" line = macroName line : ds
            | otherwise                      = ds
          macroName = head . tail . words

