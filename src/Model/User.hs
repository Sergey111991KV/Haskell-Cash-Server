module Model.User where

import qualified Data.Text as T
import qualified Data.Time as Time
import qualified Data.Aeson as J
import GHC.Generics (Generic)

data User = User {
  name :: T.Text,
  age :: Int,
  email :: T.Text,
  registration_date :: Time.UTCTime
}  deriving (Show, Eq, Generic)

instance J.ToJSON User

instance J.FromJSON User

