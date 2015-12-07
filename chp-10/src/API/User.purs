module API.User where

import Prelude
import Data.Maybe
import Data.String
import Data.Foreign
import Data.Foreign.Class
import Data.Foreign.NullOrUndefined
import Network.HTTP.Affjax

import API.Common as Common


getCurrentUser :: forall e. Affjax e (F User)
getCurrentUser = getUser "me"

getUser :: String -> forall e. Affjax e (F User)
getUser uid = do
  res <- Common.getF ("/api/v1/users/" ++ uid)
  return $ res { response = read res.response }


type Date = String
type Phone = String
data Password = Password { value :: Maybe String }

data Status = STAGED | PROVISIONED | ACTIVE | RECOVERY | LOCKED_OUT | PASSWORD_EXPIRED | DEPROVISIONED

data Link = Link { href :: Maybe String
                 , method :: Maybe String
                 }

data Links = Links { self :: Maybe Link
                   , activate :: Maybe Link
                   , deactivate :: Maybe Link
                   }

data RecoveryQuestion = RecoveryQuestion { question :: Maybe String
                                         , answer :: Maybe String
                                         }

data Provider = Provider { ptype :: String
                         , name :: Maybe String
                         }

data Credentials = Credentials { password :: Maybe Password
                               , recoveryQuestion :: Maybe RecoveryQuestion
                               , provider :: Provider
                               }

data Profile = Profile { login :: String
                       , firstName :: String
                       , lastName :: String
                       , email :: String
                       -- , nickName :: Maybe String
                       -- , displayName :: Maybe String
                       -- , secondEmail :: Maybe String
                       -- , profileUrl :: Maybe String
                       -- , preferredLanguage :: Maybe String
                       -- , userType :: Maybe String
                       -- , organization :: Maybe String
                       -- , title :: Maybe String
                       -- , division :: Maybe String
                       -- , department :: Maybe String
                       -- , costCenter :: Maybe String
                       -- , employeeNumber :: Maybe String
                       -- , mobilePhone :: Maybe Phone
                       -- , primaryPhone :: Maybe Phone
                       -- , streetAddress :: Maybe String
                       -- , city :: Maybe String
                       -- , state :: Maybe String
                       -- , zipCode :: Maybe String
                       -- , countryCode :: Maybe String
                       }

data User = User { id :: String
                 , profile :: Profile
                 -- , activated :: Maybe String
                 , created :: Date
                 -- , credentials :: Credentials
                 -- , lastLogin :: Maybe Date
                 -- , lastUpdated :: Date
                 -- , passwordChanged :: Maybe Date
                 , transitioningToStatus :: Maybe String
                 -- , status :: Status
                 -- , statusChanged :: Maybe String
                 -- , links :: Maybe Links
                 }


instance showProfile :: Show Profile where
  show (Profile p) = "profile { "
                     ++ joinWith ", " [ p.firstName, p.lastName, p.login, p.email ]
                     ++ " }"

instance showUser :: Show User where
  show (User u) = "User { "
                  ++ show u.profile
                  ++ ", "
                  ++ show u.transitioningToStatus
                  ++ " }"

instance userIsForeign :: IsForeign User where
  read value = do
    id  <- readProp "id"  value
    profile  <- readProp "profile"  value
    created  <- readProp "created"  value
    transitioningToStatus  <- readProp "transitioningToStatus"  value
    return $ User { id: id
                  , profile: profile
                  , created: created
                  , transitioningToStatus: runNullOrUndefined transitioningToStatus
                  }

instance profileIsForeign :: IsForeign Profile where
  read value = do
    login  <- readProp "login"  value
    firstName  <- readProp "firstName"  value
    lastName  <- readProp "lastName"  value
    email  <- readProp "email"  value
    return $ Profile { login: login, firstName: firstName, lastName: lastName, email: email }
