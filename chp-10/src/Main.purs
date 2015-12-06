module Main where

import Prelude
import Data.List
import Data.Foldable
import Network.HTTP.Affjax (AJAX())
import Control.Monad.Eff
import Control.Monad.Eff.Console
import Control.Monad.Eff.Exception (EXCEPTION())

import Hello.Alert as A
import Hello.Global as G
import Hello.Ajax as AJ
import Config as C


main2 :: forall e. Eff (alert :: A.ALERT | e) Unit
main2 = return unit

main :: forall e. Eff (ajax :: AJAX, err :: EXCEPTION, console :: CONSOLE | e) Unit
main = AJ.fetchAppsUserType C.token

fetchWeather :: forall e. Eff (ajax :: AJAX, err :: EXCEPTION, console :: CONSOLE | e) Unit
fetchWeather = AJ.fetchWeather

appsUserType :: String -> forall e. Eff (ajax :: AJAX, err :: EXCEPTION, console :: CONSOLE | e) Unit
appsUserType = AJ.fetchAppsUserType

alert :: String -> forall e. Eff (alert :: A.ALERT | e) Unit
alert = A.alert

addNum :: Number -> Number -> Number
addNum = G.addNum

addNum2 :: Number -> Number -> Number
addNum2 = G.addNum2

sum2 :: List Number -> Number
sum2 = foldr addNum 0.0
