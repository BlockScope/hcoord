    let defs = ./../defaults.dhall

in    defs
    ⫽ { name =
          "hcoord-mgrs"
      , dependencies =
          defs.dependencies # [ "mtl", "regex-pcre", "hcoord", "hcoord-utm" ]
      , library =
          { source-dirs = "src", exposed-modules = "MGRSRef" }
      , tests =
          { hcoord-mgrs-test =
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
              }
          }
      }
