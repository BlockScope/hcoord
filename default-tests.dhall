-- {=}
-- NOTE: To switch hlint tests alternate commenting lines above or below.
{ hlint-test =
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
