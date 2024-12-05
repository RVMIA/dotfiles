Config
    { font = "Terminess Nerd Font 18"
    , border = BottomBM 1
    , borderColor = "#6e18cc"
    , bgColor = "#0f0f0f"
    , fgColor = "grey"
    , -- , position     = TopH 24 -- No Tray
      position = TopH 45 -- With Tray
    , lowerOnStart = True
    , sepChar = "%"
    , alignSep = "}{"
    , template = " <fc=#7e18cc>%date%</fc> | %XMonadLog% | %playing% %multicpu% %memory% %dynnetwork% %KDFW% %battery%"
    , commands =
        [ Run
            DynNetwork
            [ "--template"
            , "⬆️ <tx>k/s ⬇️ <rx>k/s"
            , "--Low"
            , "1000" -- units: kB/s
            , "--High"
            , "5000" -- units: kB/s
            , "--low"
            , "darkgreen"
            , "--normal"
            , "darkorange"
            , "--high"
            , "darkred"
            ]
            10
        , Run MultiCpu ["-t", "<action=`alacritty -e htop`>🥔 <total>%</action>"] 50
        , Run
            WeatherX
            "KDFW"
            [ ("clear", "☀️")
            , ("sunny", "☀️")
            , ("mostly clear", "🌤")
            , ("mostly sunny", "🌤")
            , ("partly sunny", "⛅")
            , ("fair", "🌑")
            , ("cloudy", "☁")
            , ("overcast", "☁")
            , ("partly cloudy", "⛅")
            , ("mostly cloudy", "🌧")
            , ("considerable cloudiness", "⛈")
            ]
            [ "-t"
            , "<action=`alacritty --hold -e curl wttr.in/?0 | less`><fn=2><skyConditionS></fn> <tempF>°</action>"
            , "-L"
            , "50"
            , "-H"
            , "90"
            , "--normal"
            , "grey"
            , "--high"
            , "#de5e5e"
            , "--low"
            , "lightblue"
            ]
            18000
        , Run Memory ["-t", "<action=`alacritty -e htop`>🐏 <used>g</action>", "-d", "1", "--", "--scale", "1024"] 50
        , Run Com "/bin/sh" ["-c", "LC_ALL=ja_JP.UTF-8 date +\"%a %-m/%-d %-I:%M\""] "date" 10
        , Run Com "/bin/sh" ["-c", "~/dotfiles/scripts/spotify.sh"] "playing" 10
        , Run Com "/bin/sh" ["-c", "~/dotfiles/scripts/batt.sh"] "battery" 10
        , Run XMonadLog
        ]
    }
