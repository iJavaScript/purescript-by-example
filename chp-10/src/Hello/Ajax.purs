-- try ajax

module Hello.Ajax where

import Prelude
import Data.Maybe
import Control.Monad.Eff
import Control.Monad.Eff.Class
import Control.Monad.Eff.Console (log, CONSOLE())
import Control.Monad.Eff.Exception (EXCEPTION())
import Control.Monad.Aff

import Network.HTTP.Affjax
import Network.HTTP.Affjax.Request
import Network.HTTP.RequestHeader
import Network.HTTP.Method

import Config as C

-- an public weather api
-- http://api.openweathermap.org/data/2.5/weather?zip=94568,us&appid=2de143494c0b295cca9337e1e96b00e0

fetchWeather :: forall e. Eff (ajax :: AJAX, err :: EXCEPTION, console :: CONSOLE | e) Unit
fetchWeather = launchAff $ do
  res <- affjax $ defaultRequest {
    url = "http://api.openweathermap.org/data/2.5/weather?zip=94568,us&appid=2de143494c0b295cca9337e1e96b00e0",
    method = GET
    }
  liftEff $ log $ "GET weather response: " ++ res.response


fetchAppsUserType :: String
                  -> forall e. Eff (ajax :: AJAX, err :: EXCEPTION, console :: CONSOLE | e) Unit
fetchAppsUserType token = launchAff $ do
  res <- affjax $ defaultReq { method = GET
                             , url = C.domain + "/api/v1/users/me"
                             }
  liftEff $ log $ "GET app user types: " ++ res.response


defaultReq :: AffjaxRequest Unit
defaultReq =
  { method: GET
  , url: "/"
  , headers: [ RequestHeader "Accept" "application/json"
             , RequestHeader "ContentType" "application/json"
             , RequestHeader "Authorization" ("SSWS " ++ C.token)
             ]
  , content: Nothing
  , username: Nothing
  , password: Nothing
  }
