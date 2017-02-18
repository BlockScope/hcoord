module HUnitExtensions where
import Test.HUnit
import Control.Monad (unless)
import Control.Monad.Except
import Data.Default
import Datum
import IrishRef
import LatLng

instance Default LatLng where
    def = LatLng 0 0 0 wgs84Datum

instance Default IrishRef where
    def = IrishRef 0 0 ireland1965Datum

extract :: Default a => Except String a -> a
extract ex = either (const def) id (runExcept ex)

--------------------------

shouldThrow :: (Eq a, Eq e, Show a, Show e) => Except e a -> e -> Test
m `shouldThrow` e = runExcept m ~?= Left e

shouldReturn :: (Eq a, Eq e, Show a, Show e) => Except e a -> a -> Test
m `shouldReturn` x = runExcept m ~?= Right x