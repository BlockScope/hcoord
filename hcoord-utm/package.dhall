    let defs = ./../defaults.dhall

in    defs
    ⫽ { name =
          "hcoord-utm"
      , dependencies =
          defs.dependencies # [ "mtl", "hcoord" ]
      , library =
          { source-dirs = "src", exposed-modules = "UTMRef" }
      , tests =
            ./../default-tests.dhall
          ⫽ { hcoord-utm-test =
                { dependencies =
                    [ "HUnit", "ieee754", "data-default" ]
                , main =
                    "Spec.hs"
                , source-dirs =
                    [ "test", "src" ]
                }
            }
      }
