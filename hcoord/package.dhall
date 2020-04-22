    let defs = ./../defaults.dhall

in    defs
    ⫽ { name =
          "hcoord"
      , dependencies =
          defs.dependencies # [ "mtl" ]
      , library =
          { source-dirs =
              "src"
          , exposed-modules =
              [ "Datum"
              , "DMS"
              , "ECEFRef"
              , "Ellipsoid"
              , "LatLng"
              , "MathExtensions"
              ]
          }
      , tests =
            ./../default-tests.dhall
          ⫽ { hcoord-test =
                { dependencies =
                    [ "HUnit", "ieee754", "data-default" ]
                , main =
                    "Spec.hs"
                , source-dirs =
                    [ "test", "src" ]
                }
            }
      }
