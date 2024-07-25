import Graphics.X11.ExtraTypes.XF86
import XMonad
import XMonad.Actions.NoBorders
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.WindowSwallowing
import XMonad.Layout.Drawer
import XMonad.Layout.LayoutModifier
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.NoFrillsDecoration
import XMonad.Layout.Tabbed
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce

myTerm = "alacritty" :: String

myFM = "thunar" :: String

mySS = "bash -c ~/dotfiles/scripts/screenshot.sh" :: String

myColor = "#df5714" :: String

myNormalBorderColor = "#1d2021" :: String

myFocusedBorderColor = myColor :: String

myBorderWidth = 4 :: Dimension

myXmobar = x1 <> x2 :: StatusBarConfig
  where
    x1 = statusBarProp "xmobar -x 0 ~/dotfiles/xmonad/xmobar.hs" (pure myXMobarPP)
    x2 = statusBarProp "xmobar -x 1 ~/dotfiles/xmonad/xmobar.hs" (pure myXMobarPP)

main :: IO ()
main =
  do
    xmonad
    $ ewmh
    $ ewmhFullscreen
    $ withEasySB myXmobar defToggleStrutsKey
    $ defaults

myKeys :: [(String, X ())]
myKeys =
  [ ("<XF86AudioNext>", spawn "playerctl -p spotify next"),
    ("<XF86AudioPlay>", spawn "playerctl -p spotify play-pause"),
    ("<XF86AudioPrev>", spawn "playerctl -p spotify previous"),
    ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 10"),
    ("<XF86MonBrightnessUp>", spawn "xbacklight -inc 10"),
    ("M-S-b", withFocused toggleBorder),
    ("M-S-d", spawn "discord"),
    ("M-S-l", spawn "slock"),
    ("M-S-p", spawn "spotify"),
    ("M-S-r", spawn "sh -c ~/dotfiles/scripts/screenlayout.sh"),
    ("M-S-s", spawn mySS),
    ("M-S-t", spawn myFM),
    ("M-f", spawn "firefox"),
    ("M-p", spawn "dmenu_run"),
    ("M-q", spawn "xmonad --restart"),
    ("M-S-a", spawn "anki")
  ]
  where
    openInTerm = "alacritty -e "
    openInTermFloat = "alacritty --class 'ame-term' -e "

defaults =
  def
    { modMask = mod4Mask,
      terminal = myTerm,
      borderWidth = myBorderWidth,
      normalBorderColor = myNormalBorderColor,
      focusedBorderColor = myFocusedBorderColor,
      manageHook = myManageHook,
      layoutHook = myLayout
    }
    `additionalKeysP` myKeys

myLayout = lessBorders Screen $ avoidStruts $ tiled ||| mtiled ||| full

winDeco = noFrillsDeco shrinkText winDecoConfig
winDecoConfig = def { activeBorderColor = "#df5714"
                 , activeTextColor = "#dcdad7"
                 , activeColor = "#df5714"
                 , inactiveColor = "#1d2021"
                 , inactiveBorderColor = "#1d2021"
                 , inactiveTextColor = "#5b5e5e"
                 }

tiled = renamed [Replace "tall"] $ winDeco $ smartSpacingWithEdge 10 $ Tall (1) (3 / 100) (1 / 2)
mtiled = renamed [Replace "wide"] $ winDeco $ Mirror $ smartSpacingWithEdge 10 $ Tall (1) (3 / 100) (1 / 2)
full = renamed [Replace "full"] $ tabbed shrinkText winDecoConfig

myHandleEventHook = swallowEventHook (className =? "Kitty" <||> className =? "Alacritty") (return True)

myManageHook :: ManageHook
myManageHook =
  composeAll
    [ className =? "ame-term" --> doFloat,
      className =? "cadence" --> doShift "8",
      className =? "discord" --> doShift "9",
      className =? "Gimp" --> doFloat,
      className =? "guitarix" --> doShift "8",
      className =? "Spotify" --> doShift "9",
      isDialog --> doFloat
    ]

myXMobarPP :: PP
myXMobarPP =
  def
    { ppCurrent = xmobarBorder "Top" "#6e18cc" 3,
      ppExtras = [logTitles formatFocused formatUnfocused],
      ppHiddenNoWindows = const "",
      ppHidden = white,
      ppOrder = \[ws, l, _, wins] -> [wrap "" "" ws, l],
      -- ppOrder = \[ws, l, _, wins] -> [wrap " " "" ws, pad l, wins],
      ppSep = " ",
      ppTitleSanitize = shorten 10 . xmobarStrip
    }
  where
    formatFocused = padB white . wal . ppWindow
    formatUnfocused = padB lowWhite . grey . ppWindow
    padB color = wrap (color "[") (color "]")
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 9
    blue = xmobarColor "#bd93f9" ""
    green = xmobarColor "#8ba37d" ""
    grey = xmobarColor "#8e8e8e" ""
    lowWhite = xmobarColor "#bbbbbb" ""
    magenta = xmobarColor "#ff79c6" ""
    red = xmobarColor "#ff5555" ""
    wal = xmobarColor myColor ""
    white = xmobarColor "#f8f8f2" ""
    yellow = xmobarColor "#f1fa8c" ""
