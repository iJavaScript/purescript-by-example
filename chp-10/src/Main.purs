module Main where

import Prelude
import Data.List
import Data.Foldable
import Control.Monad.Eff

import Hello.Alert as A
import Hello.Global as G
import Hello.Ajax as AJ

main :: forall e. Eff (alert :: A.ALERT | e) Unit
main = return unit

fetchWeather = AJ.fetchWeather

alert :: String -> forall e. Eff (alert :: A.ALERT | e) Unit
alert = A.alert

addNum :: Number -> Number -> Number
addNum = G.addNum

addNum2 :: Number -> Number -> Number
addNum2 = G.addNum2

sum2 :: List Number -> Number
sum2 = foldr addNum 0.0
