{-# LANGUAGE DataKinds #-}
{-# LANGUAGE KindSignatures #-}

module AppServer where

import Servant ( Server, Application, type (:<|>)((:<|>)), serve )
import Data.Time ( UTCTime, defaultTimeLocale, parseTimeOrError )
import Network.Wai.Handler.Warp ( run )

import Model.User ( User(User) )
import API ( API, apiType, swagger ) 
import Config ( Config, retrieveConfig )
import qualified Data.Configurator as C
import Control.Monad.IO.Class ( liftIO)
import qualified Control.Exception as E


timeFormat :: String
timeFormat = "%H:%M:%S"
understandTime :: String -> UTCTime
understandTime = parseTimeOrError True defaultTimeLocale timeFormat

time :: UTCTime
time = understandTime "10:30:20"

user:: User
user = User "Isaac Newton"  372 "isaac@newton.co.uk" time

server :: Server API
server = return user :<|> pure swagger

app :: Application
app = serve apiType server

runApp :: IO ()
runApp  = do
    (configE :: Either E.SomeException Config) <- E.try retrieveConfig
    case configE of
        Left err -> print err
        Right config -> do
            (portE :: Either E.SomeException Int) <- E.try  $ C.require config "web_server.port"
            case portE of
                Left err -> print err
                Right port -> do
                    run port app

