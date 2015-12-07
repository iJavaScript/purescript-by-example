-- try ajax

module Hello.Ajax where

import Prelude
import Control.Monad.Eff
import Control.Monad.Eff.Class
import Control.Monad.Eff.Console (log, CONSOLE())
import Control.Monad.Eff.Exception (EXCEPTION())
import Control.Monad.Aff

import Network.HTTP.Affjax
import Network.HTTP.Method


-- an public weather api
-- http://api.openweathermap.org/data/2.5/weather?zip=94568,us&appid=2de143494c0b295cca9337e1e96b00e0
fetchWeather :: forall e. Eff (ajax :: AJAX, err :: EXCEPTION, console :: CONSOLE | e) Unit
fetchWeather = launchAff $ do
  res <- affjax $ defaultRequest {
    url = "http://api.openweathermap.org/data/2.5/weather?zip=94568,us&appid=2de143494c0b295cca9337e1e96b00e0",
    method = GET
  }
  liftEff $ log $ "GET weather response: " ++ res.response
