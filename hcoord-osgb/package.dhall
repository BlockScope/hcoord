    let defs = ./../defaults.dhall

in    defs
    ⫽ { name =
          "hcoord-osgb"
      , dependencies =
          defs.dependencies # [ "mtl", "hcoord" ]
      , library =
          { source-dirs = "src", exposed-modules = "OSRef" }
      , tests =
          { hcoord-osgb-test =
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
