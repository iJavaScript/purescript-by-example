module Main where

import Prelude
import Data.List
import Data.Foldable
import Network.HTTP.Affjax (AJAX())
import Control.Monad.Aff
import Control.Monad.Eff
import Control.Monad.Eff.Class
import Control.Monad.Eff.Console
import Control.Monad.Eff.Exception (EXCEPTION())

import Hello.Alert as A
import Hello.Global as G
import API.User as U


main2 :: forall e. Eff (alert :: A.ALERT | e) Unit
main2 = return unit

main :: forall e. Eff (ajax :: AJAX, err :: EXCEPTION, console :: CONSOLE | e) Unit
main = launchAff $ do
  user <- U.getCurrentUser
  liftEff $ print $ user.status
  liftEff $ print $ user.headers
  liftEff $ print user.response
  us <- U.getUser "00uivl5oQraxHH1X00g3"
  liftEff $ print us.response

alert :: String -> forall e. Eff (alert :: A.ALERT | e) Unit
alert = A.alert

addNum :: Number -> Number -> Number
addNum = G.addNum

addNum2 :: Number -> Number -> Number
addNum2 = G.addNum2

sum2 :: List Number -> Number
sum2 = foldr addNum 0.0
