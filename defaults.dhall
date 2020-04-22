{ version =
    "2.1.0"
, author =
    "Daniele Francesconi"
, maintainer =
    "dfrancesconi12@gmail.com"
, github =
    "danfran/hcoord"
, copyright =
    "copyleft"
, license =
    "BSD3"
, license-file =
    "LICENSE"
, synopsis =
    "Short synopsis."
, description =
    "Longer description."
, category =
    "geography"
, tested-with = "GHC == 8.0.2, GHC == 8.2.2, GHC == 8.4.4, GHC == 8.6.5, GHC == 8.8.3"
, extra-source-files =
    [ "package.dhall", "README.md" ]
, ghc-options =
    [ "-Wall" ]
, dependencies =
    [ "base >=4 && <5" ]
, flags =
      { suppress-failing-tests = { manual = False, default = True } }
}
