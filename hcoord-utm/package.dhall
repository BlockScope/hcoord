    let defs = ./../defaults.dhall

in    defs
    ⫽ { name =
          "hcoord-utm"
      , dependencies =
          defs.dependencies # [ "mtl", "hcoord" ]
      , library =
          { source-dirs = "src", exposed-modules = "UTMRef" }
      , tests =
          { hcoord-utm-test =
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
