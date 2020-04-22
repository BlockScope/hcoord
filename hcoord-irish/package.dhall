    let defs = ./../defaults.dhall

in    defs
    ⫽ { name =
          "hcoord-irish"
      , dependencies =
          defs.dependencies # [ "mtl", "hcoord" ]
      , library =
          { source-dirs = "src", exposed-modules = "IrishRef" }
      , tests =
            ./../default-tests.dhall
          ⫽ { hcoord-irish-test =
                { dependencies =
                    [ "HUnit", "ieee754", "data-default" ]
                , main =
                    "Spec.hs"
                , source-dirs =
                    [ "test", "src" ]
                }
            }
      }
