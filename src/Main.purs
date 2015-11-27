module Main where

import Prelude
import Control.Monad.Eff
import Control.Monad.Eff.Console
import Math (sqrt, pi)

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log "Hello sailor!"
  log $ show $ diagonal 3.0 4.0


diagonal :: Number -> Number -> Number
diagonal w h = sqrt (w * w + h * h)

circleArea :: Number -> Number
circleArea radius = Math.pi * radius * radius
