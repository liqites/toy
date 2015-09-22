doubleMe x = x + x

doubleUs x y = doubleMe x + doubleMe y

doubleSmallNumber x = if x > 100 then x else x*2

doubleSmallNumber' x = (if x > 100 then x else x * 2) + 1

conanO'Brien = "It's a-me, Conan O'Brien!"

removeNunUppercase :: [Char] -> [Char]
removeNunUppercase st = [c | c <- st, c `elem` ['A'..'Z']]

addTree :: Int -> Int -> Int -> Int
addTree x y z = x + y + z