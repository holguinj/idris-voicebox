module Voicebox.Word

%access public export

mutual -- dictionaries have words and words have dictionaries
  ||| This is just (List Word) for now as a placeholder.
  ||| any function that relies on this implementation should be kept in this module.
  Dictionary : Type
  Dictionary = (List Word)

  record Word where
    constructor MkWord
    name : String -- the actual word
    freq : Nat -- the raw frequency of the word within its dictionary
    sub1 : Dictionary -- words that come after this word
    sub2 : Dictionary -- words that come two after this word
    norm : Double -- normalized frequency of the word (chance of occurring)
    sig : Double -- the significance of this word, which is how much the
               -- frequency in this dictionary exceeds the baseline frequency

implementation Show Word where
    show (MkWord name freq sub1 sub2 norm sig) = unlines
      [ name
      , "freq: " ++ (show freq)
      , "norm: " ++ (show norm)
      , "sig: " ++ (show sig)
      , ""]

implementation Eq Word where
    (==) x y = (name x) == (name y)

restrict' : Dictionary -> (List Word) -> Dictionary
restrict' [] _ = []
restrict' _ [] = []
restrict' dict list = filter (flip elem list) dict

passes : Nat -> Word -> Bool
passes threshold word = (freq word) >= threshold
