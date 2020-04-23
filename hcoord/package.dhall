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
          { hcoord-test =
              { dependencies =
                  [ "HUnit", "ieee754", "data-default" ]
              , main =
                  "Spec.hs"
              , source-dirs =
                  [ "test", "src" ]
              }
          , hlint-test =
              { dependencies =
                  [ "hlint" ]
              , ghc-options =
                  [ "-threaded", "-rtsopts", "-with-rtsopts=-N" ]
              , main =
                  "HLint.hs"
              , source-dirs =
                  "hlint"
              , when =
                  { condition =
                      "flag(suppress-failing-tests)"
                  , buildable =
                      False
                  }
              }
          }
      }
