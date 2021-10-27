module Config where

import Control.Monad.IO.Class (MonadIO, liftIO)
import qualified Data.Configurator as C
import qualified Data.Configurator.Types as C

type Config = C.Config

retrieveConfig :: MonadIO m => m C.Config
retrieveConfig = do
  let configPath = "./config/local.conf"
  let templateConfigPath = "./config/template.conf"
  liftIO $ C.load [C.Required templateConfigPath, C.Optional configPath]