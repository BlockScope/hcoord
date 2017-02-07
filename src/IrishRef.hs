{-|
  To represent an Irish National Grid reference.

  Projection: Transverse Mercator
  Reference ellipsoid: Modified Airy
  Units: metres
  Origin: 53&deg;30'N, 8&deg;W
  False co-ordinates of origin: 200000m east, 250000m north
-}
module IrishRef where

import Control.Monad.Except
import Data.Char
import Datum
import Ellipsoid
import qualified LatLng as L
import MathExtensions

data IrishRef = IrishRef { easting :: Double -- ^ The easting in metres relative to the origin of the British National Grid.
                         , northing :: Double -- ^ The northing in metres relative to the origin of the British National Grid.
                         , datum :: Datum
                         } deriving (Show)

scaleFactor, falseOriginLatitude, falseOriginLongitude, falseOriginEasting, falseOriginNorthing :: Double
scaleFactor = 1.000035
falseOriginLatitude = 53.5
falseOriginLongitude = -8.0
falseOriginEasting = 200000.0
falseOriginNorthing = 250000.0

{-|
  Create a new Ordnance Survey grid reference using a given easting and
  northing. The easting and northing must be in metres and must be relative
  to the origin of the British National Grid.
-}
mkIrishRef :: Double -- ^ The easting in metres. Must be greater than or equal to 0.0 and less than 400000.0.
              -> Double -- ^ The northing in metres. Must be greater than or equal to 0.0 and less than or equal to 500000.0.
              -> Except String IrishRef -- ^ Throws an exception if either the easting or the northing are invalid.
mkIrishRef e n = do
  est <- withExcept (const "Invalid easting") (evalEasting e)
  nrt <- withExcept (const "Invalid northing") (evalNorthing n)
  pure IrishRef { easting = est, northing = nrt, datum = ireland1965Datum }


{-|
  Take a string formatted as a six-figure OS grid reference (e.g. "TG514131")
  and create a new OSRef object that represents that grid reference. The
  first character must be H, N, S, O or T. The second character can be any
  uppercase character from A through Z excluding I.
-}
mkIrishRef' :: String -- ^ A String representing a six-figure Ordnance Survey grid reference in the form XY123456.
               -> Except String IrishRef -- ^ Throws an exception if ref is not of the form XY123456.
mkIrishRef' ref = do
  -- TODO 2006-02-05 : check format
  let
      east = (read (take 3 $ drop 1 ref) :: Int) * 100
      north = (read (take 3 $ drop 4 ref) :: Int) * 100
      firstCh = ord (ref !! 0)
      ch = if firstCh > 73 then firstCh - 1 else firstCh -- Adjust for no I
      nx = ((ch - 65) `mod` 5) * 100000
      ny = (4 - floor ((fromIntegral ch - 65) / 5)) * 100000

  est <- withExcept (const "Invalid easting") (evalEasting $ fromIntegral (east + nx))
  nrt <- withExcept (const "Invalid northing") (evalNorthing $ fromIntegral (north + ny))
  pure IrishRef { easting = est, northing = nrt, datum = ireland1965Datum }


mkIrishRef'' :: L.LatLng -> Except String IrishRef
mkIrishRef'' (L.LatLng latitude longitude height _) = do
  let
      n0 = falseOriginNorthing
      e0 = falseOriginEasting
      phi0 = toRadians falseOriginLatitude
      lambda0 = toRadians falseOriginLongitude

      el = ellipsoid ireland1965Datum
      a = scaleFactor * semiMajorAxis el
      b = scaleFactor * semiMinorAxis el
      eSquared = eccentricitySquared el

      phi = toRadians latitude
      lambda = toRadians longitude
      n = (a - b) / (a + b)

      va = a * (1 - eSquared * sinSquared phi) ** (-0.5)
      rho = a * (1 - eSquared) * (1 - eSquared * sinSquared phi) ** (-1.5)
      etaSquared = va / rho - 1

      m = b * (((1 + n + (1.25 * n ** 2) + (1.25 * n ** 3)) * (phi - phi0))
          - ((3 * n + 3 * n ** 2 + (21.0 / 8.0 * n ** 3)) * sin (phi - phi0) * cos (phi + phi0))
          + ((15.0 / 8.0 * n ** 2 + 15.0 / 8.0 * n ** 3) * sin(2.0 * (phi - phi0)) * cos(2.0 * (phi + phi0)))
          - ((35.0 / 24.0 * n ** 3) * sin(3.0 * (phi - phi0)) * cos(3.0 * (phi + phi0))))

      i = m + n0
      ii = va / 2.0 * sin phi * cos phi
      iii = va / 24.0 * sin phi * cos phi ** 3 * (5.0 - tanSquared phi + 9.0 * etaSquared)
      iiia = va / 720.0 * sin phi * cos phi ** 5 * (61.0 - 58.0 * tanSquared phi + tan phi ** 4)
      iv = va * cos(phi)
      v = va / 6.0 * cos phi ** 3 * (va / rho - tanSquared phi)
      vi = va / 120.0 * cos phi ** 5.0 * (5.0 - 18.0 * tanSquared phi + tan phi ** 4.0
           + 14 * etaSquared - 58 * tanSquared phi * etaSquared)

      north = i + ii * (lambda - lambda0) ** 2
              + iii * (lambda - lambda0) ** 4
              + iiia * (lambda - lambda0) ** 6

      east = e0 + iv * (lambda - lambda0)
             + v * (lambda - lambda0) ** 3
             + vi * (lambda - lambda0) ** 5

  est <- withExcept (const "Invalid easting") (evalEasting east)
  nrt <- withExcept (const "Invalid northing") (evalNorthing north)
  pure IrishRef { easting = est, northing = nrt, datum = ireland1965Datum }



-- | Validate the easting.
evalEasting :: Double                  -- ^ The easting in metres. Must be greater than or equal to 0.0 and less than 400000.0.
               -> Except String Double -- ^ Throws an Exception if the easting is invalid.
evalEasting e | e < 0.0 || e >= 400000.0 = throwError ("Easting (" ++ show e ++ ") is invalid. Must be greater than or equal to 0.0 and less than 400000.0.")
              | otherwise = pure (e)


-- | Validate the northing.
evalNorthing :: Double                  -- ^ The northing in metres. Must be greater than or equal to 0.0 and less than or equal to 500000.0.
                -> Except String Double -- ^ Throws an Exception if the northing is invalid.
evalNorthing n | n < 0.0 || n > 500000.0 = throwError ("Northing (" ++ show n ++ ") is invalid. Must be greather than or equal to 0.0 and less than or equal to 500000.0.")
               | otherwise = pure (n)
