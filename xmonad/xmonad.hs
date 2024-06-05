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

mM = mod4Mask :: KeyMask

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

myKeys :: [((KeyMask, KeySym), X ())]
myKeys =
  [ ((0, xF86XK_AudioNext), spawn "playerctl -p spotify next"),
    ((0, xF86XK_AudioPlay), spawn "playerctl -p spotify play-pause"),
    ((0, xF86XK_AudioPrev), spawn "playerctl -p spotify previous"),
    ((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ +1%"),
    ((mM .|. controlMask, xK_p), spawn "sh -c ~/dotfiles/scripts/spotify-notif.sh"),
    ((mM .|. shiftMask, xK_b), withFocused toggleBorder),
    ((mM .|. shiftMask, xK_d), spawn "discord"),
    ((mM .|. shiftMask, xK_f), spawn "google-chrome-stable"),
    ((mM .|. shiftMask, xK_l), spawn "slock"),
    ((mM .|. shiftMask, xK_m), spawn "sh -c ~/dotfiles/scripts/mansplain.sh"),
    ((mM .|. shiftMask, xK_p), spawn "spotify"),
    ((mM .|. shiftMask, xK_s), spawn mySS),
    ((mM .|. shiftMask, xK_t), spawn myFM),
    ((mM, xK_f), spawn "firefox"),
    ((mM, xK_p), spawn "dmenu_run"),
    ((mM, xK_p), spawn "rofi -show run -theme dmenu_ame"),
    ((mM, xK_q), spawn "xmonad --restart")
    -- , ((0, xF86XK_AudioLowerVolume) , spawn "pactl set-sink-volume @DEFAULT_SINK@ -1%")
    -- , ((0, xF86XK_AudioLowerVolume) , spawn "pactl set-sink-volume @DEFAULT_SINK@ -1%")
    -- , ((0, xF86XK_AudioLowerVolume) , spawn "pactl set-sink-volume @DEFAULT_SINK@ -1%")
    -- , ((0, xF86XK_AudioMute) , spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    -- , ((0, xF86XK_AudioMute) , spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    -- , ((0, xF86XK_AudioMute) , spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
  ]

defaults =
  def
    { modMask = mM,
      terminal = myTerm,
      borderWidth = myBorderWidth,
      normalBorderColor = myNormalBorderColor,
      focusedBorderColor = myFocusedBorderColor,
      -- , focusFollowsMouse = False
      manageHook = myManageHook,
      layoutHook = (lessBorders Screen $ myLayout)
    }
    `additionalKeys` myKeys

myLayout =
  avoidStruts $
    tiled
      ||| Mirror tiled
      ||| Full

tiled =
  renamed [Replace "Tall"] $
    smartSpacingWithEdge 10 $
      Tall nmaster delta ratio
  where
    nmaster = 1
    ratio = 1 / 2
    delta = 3 / 100

myHandleEventHook = swallowEventHook (className =? "Kitty" <||> className =? "Alacritty") (return True)

myManageHook :: ManageHook
myManageHook =
  composeAll
    [ className =? "Gimp" --> doFloat,
      isDialog --> doFloat,
      className =? "Spotify" --> doShift "9",
      className =? "discord" --> doShift "9",
      className =? "guitarix" --> doShift "8",
      className =? "cadence" --> doShift "8"
    ]

myXMobarPP :: PP
myXMobarPP =
  def
    { ppSep = wal " ",
      ppTitleSanitize = shorten 10 . xmobarStrip,
      ppCurrent = xmobarBorder "Top" "#6e18cc" 2,
      ppHidden = white,
      -- ppHiddenNoWindows = lowWhite . wrap "" "", -- IF YOU WANT ALL WORKSPACES ON THE BAR
      ppHiddenNoWindows = const "", -- OR ONLY SHOW POPULATED WORKSPACES
      ppUrgent = red . wrap (yellow "!") (yellow "!"),
      -- ppOrder = \[ws, l, _, wins] -> [wrap " " "" ws, pad l, unwords $ take 4 $ words wins],
      ppOrder = \[ws, l, _, wins] -> [wrap " " "" ws, pad l, wins],
      ppExtras = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused = wrap (white "[") (white "]") . wal . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . grey . ppWindow
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 9
    magenta = xmobarColor "#ff79c6" ""
    blue = xmobarColor "#bd93f9" ""
    white = xmobarColor "#f8f8f2" ""
    yellow = xmobarColor "#f1fa8c" ""
    red = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""
    grey = xmobarColor "#8e8e8e" ""
    green = xmobarColor "#8ba37d" ""
    wal = xmobarColor myColor ""
