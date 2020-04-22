    let defs = ./../defaults.dhall

in    defs
    ⫽ { name =
          "hcoord-osgb"
      , dependencies =
          defs.dependencies # [ "mtl", "hcoord" ]
      , library =
          { source-dirs = "src", exposed-modules = "OSRef" }
      , tests =
            ./../default-tests.dhall
          ⫽ { hcoord-osgb-test =
                { dependencies =
                    [ "HUnit", "ieee754", "data-default" ]
                , main =
                    "Spec.hs"
                , source-dirs =
                    [ "test", "src" ]
                }
            }
      }
