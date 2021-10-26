{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RankNTypes #-}

module API where
    
import Servant ( Proxy(..), type (:>), type (:<|>), JSON, Get ) 
import Data.Swagger ( Swagger ) 
import Servant.Swagger.Internal ( HasSwagger(toSwagger) )

import Model.User ( User )

type UserAPI = "user" :> Get '[JSON] User
type SwaggerAPI = "swagger" :> Get '[JSON] Swagger

type API = UserAPI :<|> SwaggerAPI

apiType :: Proxy API
apiType = Proxy

swagger :: Swagger
swagger = toSwagger (Proxy :: Proxy UserAPI)