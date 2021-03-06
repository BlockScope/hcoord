module Equals where

import LatLng
import UTMRef

import Data.AEq

instance Eq LatLng where
    (LatLng latitude1 longitude1 height1 datum1) == (LatLng latitude2 longitude2 height2 datum2) =
        (latitude1 ~== latitude2) && (longitude1 ~== longitude2) && (height1 ~== height2) && (datum1 == datum2)

instance Eq UTMRef where
    (UTMRef easting1 northing1 latZone1 lngZone1 datum1) == (UTMRef easting2 northing2 latZone2 lngZone2 datum2) =
        (easting1 ~== easting2) && (northing1 ~== northing2) && (latZone1 == latZone2) && (lngZone1 == lngZone2) && (datum1 == datum2)
