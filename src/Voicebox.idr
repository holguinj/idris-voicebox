module Main

import Effects
import Effect.StdIO

import Voicebox.Actions -- defines `sayHello`

main : IO ()
main = run sayHello
