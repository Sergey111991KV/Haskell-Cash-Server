module AppServer where

import Servant ( Server, Application, serve )
import Data.Time ( UTCTime, defaultTimeLocale, parseTimeOrError )

import Model.User ( User(User) )
import API ( UserAPI, userAPI )

timeFormat :: String
timeFormat = "%H:%M:%S"
understandTime :: String -> UTCTime
understandTime = parseTimeOrError True defaultTimeLocale timeFormat

time :: UTCTime
time = understandTime "10:30:20"

user:: User
user = User "Isaac Newton"  372 "isaac@newton.co.uk" time


server :: Server UserAPI
server = return user

app :: Application
app = serve userAPI server