module API.Common where

import Prelude
import Data.Maybe

import Network.HTTP.Affjax
import Network.HTTP.Affjax.Request
import Network.HTTP.RequestHeader
import Network.HTTP.Method

import Data.Foreign

import Config as C


getF :: forall e. URL -> Affjax e Foreign
getF u = affjax $ defaultReq { url = C.domain ++ u }

postF :: forall e a. (Requestable a) => URL -> a -> Affjax e Foreign
postF u c = affjax $ defaultRequest { method = POST, url = u, content = Just c }

putF :: forall e a. (Requestable a) => URL -> a -> Affjax e Foreign
putF u c = affjax $ defaultRequest { method = PUT, url = u, content = Just c }

deleteF :: forall e. URL -> Affjax e Foreign
deleteF u = affjax $ defaultRequest { method = DELETE, url = u }

defaultReq :: AffjaxRequest Unit
defaultReq =
  { method: GET
  , url: "/"
  , headers: defaultHeaders
  , content: Nothing
  , username: Nothing
  , password: Nothing
  }

defaultHeaders :: Array RequestHeader
defaultHeaders = [ RequestHeader "Accept" "application/json"
                 , RequestHeader "ContentType" "application/json"
                 , RequestHeader "Authorization" ("SSWS " ++ C.token)
                 ]
