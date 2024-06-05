Config { font         = "Terminess Nerd Font 18"
       , textOffset   = 1
       , border       = BottomBM 1
       , borderColor  = "#6e18cc"
       , bgColor      = "#0f0f0f"
       , fgColor      = "grey"
       -- , position     = TopH 24 -- No Tray 
       , position     = TopH 45 -- With Tray
       , lowerOnStart = True
       , sepChar      = "%"
       , alignSep     = "}{"
       , template     = "%XMonadLog% }{%playing% %multicpu% %memory% %dynnetwork% %KDFW% <fc=#7e18cc>%date%</fc>|                   "
       , commands     = [ Run DynNetwork [ "--template" , "⬆️ <tx>k/s ⬇️ <rx>k/s"
                                         , "--Low"      , "1000"       -- units: kB/s
                                         , "--High"     , "5000"       -- units: kB/s
                                         , "--low"      , "darkgreen"
                                         , "--normal"   , "darkorange"
                                         , "--high"     , "darkred"
                                         ] 10
                        , Run MultiCpu ["-t","🥔 <total>%"] 50
                        , Run WeatherX "KDFW"
                        [ ("clear", "☀️")
                        , ("sunny", "☀️")
                        , ("mostly clear", "🌤")
                        , ("mostly sunny", "🌤")
                        , ("partly sunny", "⛅")
                        , ("fair", "🌑")
                        , ("cloudy","☁")
                        , ("overcast","☁")
                        , ("partly cloudy", "⛅")
                        , ("mostly cloudy", "🌧")
                        , ("considerable cloudiness", "⛈")]
                        ["-t", "<fn=2><skyConditionS></fn> <tempF>°"
                        , "-L","50", "-H", "90", "--normal", "grey"
                        , "--high", "#de5e5e", "--low", "lightblue"] 18000
                        , Run Memory ["-t","🐏 <used> Gb", "-d", "1", "--", "--scale", "1024"] 50
                        , Run Date "%a %m/%d %I:%M" "date" 10
                        , Run Com "/bin/bash" ["-c", "~/dotfiles/scripts/spotify.sh"] "playing" 10
                        , Run XMonadLog
                        ]

}
