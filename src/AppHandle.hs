{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE FlexibleContexts #-}

module AppHandle

where

import qualified Config as C
import GHC.Generics (Generic)
import Control.Monad.Except ()
import Control.Monad.Logger ( runStdoutLoggingT, LoggingT ) 
import Control.Monad.Reader ( MonadIO, MonadReader )
import Colog ( Message, LogAction )

data AppHandle = AppHandle
  { 
    appHandleConfig :: C.Config
  }
  deriving (Generic)

type MonadHandler m = (MonadIO m, MonadReader (LogAction m Message) m)


withAppHandle :: (AppHandle -> LoggingT IO b) -> IO b
withAppHandle action = do
  config <- C.retrieveConfig
  runStdoutLoggingT $ action $ AppHandle  config 