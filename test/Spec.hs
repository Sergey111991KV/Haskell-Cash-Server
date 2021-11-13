import           Test.Hspec
import Network.HTTP.Client ( defaultManagerSettings, newManager )
import qualified Network.Wai.Handler.Warp         as Warp

import Servant ( Proxy(..) )
import Servant.Client
    ( client,
      mkClientEnv,
      runClientM,
      parseBaseUrl,
      BaseUrl(baseUrlPort) )
import Servant.Server ()
import Model.User ( User(User) )
import Data.Time ( UTCTime )
import API ( UserAPI )
-- import           Servant.QuickCheck
-- import           Servant.QuickCheck.Internal (serverDoesntSatisfy)

import AppServer

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  businessLogicSpec
--   thirdPartyResourcesSpec
--   servantQuickcheckSpec

timeTest :: UTCTime
timeTest = understandTime "10:30:20"


withUserApp :: (Warp.Port -> IO ()) -> IO ()
withUserApp = Warp.testWithApplication (pure app)


businessLogicSpec :: Spec
businessLogicSpec =
  around withUserApp $ do
    let createUser = client (Proxy :: Proxy UserAPI)
    baseUrl <- runIO $ parseBaseUrl "http://localhost"
    manager <- runIO $ newManager defaultManagerSettings
    let clientEnv port = mkClientEnv manager (baseUrl { baseUrlPort = port })
    describe "POST /user" $ do
      it "should take first user example" $ \port -> do
        result <- runClientM createUser (clientEnv port)
        result `shouldBe`  (Right $ User "Isaac Newton"  372 "isaac@newton.co.uk" timeTest)