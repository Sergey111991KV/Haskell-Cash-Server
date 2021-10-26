{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RankNTypes #-}

module API where
    
import Servant ( Proxy(..), type (:>), JSON, Get )

import Model.User ( User )

type UserAPI = "user" :> Get '[JSON] User


userAPI :: Proxy UserAPI
userAPI = Proxy