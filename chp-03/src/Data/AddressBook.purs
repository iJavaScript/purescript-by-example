module Data.AddressBook where

import Prelude

import Data.List
import Data.Maybe
import Control.Plus (empty)

type Entry = { firstName :: String
             , lastName  :: String
             , address   :: Address
             }

type Address = { street :: String
               , city   :: String
               , state  :: String
               }

type AddressBook = List Entry

showEntry :: Entry -> String
showEntry e = e.lastName
              ++ ", "
              ++ e.firstName
              ++ ": "
              ++ showAddress e.address

showAddress :: Address -> String
showAddress add = add.street ++ ", " ++ add.city ++ ", " ++ add.state


emptyAddressBook :: AddressBook
emptyAddressBook = empty

insertEntry :: Entry -> AddressBook -> AddressBook
insertEntry = Cons

findEntry :: String         -- first name
          -> String         -- last name
          -> AddressBook
          -> Maybe Entry
findEntry fname lname = filter (isEntry fname lname) >>> head

isEntry :: String -> String -> Entry -> Boolean
isEntry fname lname entry = entry.firstName == fname && entry.lastName == lname

findByStreet :: String -> AddressBook -> Maybe Entry
findByStreet street = filter isStreet >>> head
  where isStreet entry = entry.address.street == street

printEntry :: String -> String -> AddressBook -> Maybe String
printEntry fname lname book = showEntry <$> findEntry fname lname book

isInAddress :: String -> String -> AddressBook -> Boolean
isInAddress fname lname = filter (isEntry fname lname) >>> null >>> not


removeDuplicates :: AddressBook -> AddressBook
removeDuplicates = nubBy isSameEntry
  where isSameEntry e1 e2 = e1.firstName == e2.firstName && e1.lastName == e2.lastName
