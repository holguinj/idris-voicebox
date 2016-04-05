module Voicebox.Voice

import Voicebox.Word

%access public export

data VoiceSettings = StgNormalize | StgRaw | StgSignificance

||| Represents data from the given corpus.
record Voice where
  constructor MkVoice
  dict : Dictionary -- the dictionary constructed from the source on the first pass
  activeDict : Dictionary -- a pruned version of dict containing only words that occur a certain number of times
  settings : VoiceSettings -- determines the pruning criterion for this voice and the way in which its words get ranked

restrict : Voice -> (List Word) -> Voice
restrict voice@(MkVoice dict _ _) words = record { activeDict = restrict' dict words } voice

atLeast : Voice -> Nat -> Voice
atLeast voice@(MkVoice dict activeDict settings) threshold =
  let passing = filter (passes threshold) dict in
    restrict voice passing
