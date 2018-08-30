    let defs = ./defaults.dhall

in    defs
    ⫽ { name =
          "hcoord-mgrs"
      , dependencies =
          defs.dependencies # [ "mtl", "regex-pcre", "hcoord", "hcoord-utm" ]
      , library =
          { source-dirs = "src", exposed-modules = "MGRSRef" }
      , tests =
            ./default-tests.dhall
          ⫽ { hcoord-mgrs-test =
                { dependencies =
                    [ "HUnit", "ieee754", "data-default" ]
                , main =
                    "Spec.hs"
                , source-dirs =
                    [ "test", "src" ]
                }
            }
      }
