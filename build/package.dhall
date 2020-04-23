{ name =
    "build-hcoord"
, synopsis =
    "A shake build of hcoord packages."
, description =
    "Builds the hcoord packages."
, category =
    "Build"
, executables =
    { build-hcoord =
        { dependencies =
            [ "base"
            , "ansi-terminal"
            , "dhall"
            , "shake"
            , "raw-strings-qq"
            , "text"
            , "time"
            ]
        , ghc-options =
            [ "-rtsopts", "-threaded", "-with-rtsopts=-N" ]
        , main =
            "Main.hs"
        , source-dirs =
            "."
        }
    }
}
