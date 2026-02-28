import Graphics.X11.ExtraTypes.XF86
import XMonad
import XMonad.Actions.NoBorders
import XMonad.Actions.WithAll
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.WindowSwallowing
import XMonad.Layout.Drawer
import XMonad.Layout.Gaps
import XMonad.Layout.LayoutModifier
import XMonad.Layout.NoBorders
import XMonad.Layout.NoFrillsDecoration
import XMonad.Layout.Renamed
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed
import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce

myOrange :: String
myOrange = "#cc3333"

myGray :: String
myGray = "#222222"

-- myPurple = "#6e18cc" :: String
myPurple = "#005577" :: String

myNormalBorderColor :: String
myNormalBorderColor = myGray

myFocusedBorderColor :: String
myFocusedBorderColor = myPurple

myBorderWidth :: Dimension
myBorderWidth = 4

myXmobar :: StatusBarConfig
myXmobar = x 0 <> x 1
  where
    x screen = statusBarProp ("xmobar -x " ++ show screen ++ " ~/dotfiles/.config/xmonad/xmobar.hs") $ pure myXMobarPP

main :: IO ()
main =
  do
    xmonad $ ewmh $ ewmhFullscreen $ withEasySB myXmobar defToggleStrutsKey defaults

myKeys :: [(String, X ())]
myKeys =
  [ ("<XF86AudioNext>", spawn "playerctl next"),
    ("<XF86AudioPlay>", spawn "playerctl play-pause"),
    ("<XF86AudioPrev>", spawn "playerctl previous"),
    ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 10"),
    ("<XF86MonBrightnessUp>", spawn "xbacklight -inc 10"),
    ("M-S-b", (<>) (withFocused toggleBorder) refresh),
    ("M-C-b", (<>) (withAll toggleBorder) refresh),
    ("M-S-g", (<>) toggleWindowSpacingEnabled toggleScreenSpacingEnabled),
    -- , ("M-S-d", spawn "com.discordapp.Discord")
    ("M-S-l", spawn "slock"),
    -- , ("M-S-p", spawn "spotify")
    ("M-S-r", spawn "sh -c ~/dotfiles/scripts/screenlayout.sh"),
    ("M-S-v", spawn "pavucontrol"),
    ("M-S-s", spawn "sh -c ~/dotfiles/scripts/screenshot.sh"),
    ("M-S-t", spawn "thunar"),
    ("M-f", spawn "librewolf"),
    ("M-p", spawn "dmenu_run"),
    ("M-q", spawn "xmonad --restart")
    -- , ("M-S-a", spawn "anki")
  ]

defaults =
  def
    { modMask = mod4Mask,
      terminal = "setxkbmap -option caps:escape && alacritty",
      borderWidth = myBorderWidth,
      normalBorderColor = myNormalBorderColor,
      focusedBorderColor = myFocusedBorderColor,
      manageHook = myManageHook,
      layoutHook = myLayout
    }
    `additionalKeysP` myKeys

myLayout = lessBorders Screen $ avoidStruts $ tiled ||| mtiled ||| full

winDeco = noFrillsDeco shrinkText winDecoConfig

winDecoConfig =
  def
    { activeBorderColor = myPurple,
      activeTextColor = "#dcdad7",
      activeColor = myPurple,
      inactiveColor = myGray,
      inactiveBorderColor = myGray,
      inactiveTextColor = "#5b5e5e",
      fontName = "xft:Terminess Nerd Font:size=12"
    }

tiled = renamed [Replace "tall"] $ winDeco $ smartSpacingWithEdge 10 $ Tall 1 (3 / 100) (1 / 2)

mtiled = renamed [Replace "wide"] $ winDeco $ Mirror $ smartSpacingWithEdge 10 $ Tall 1 (3 / 100) (1 / 2)

full = renamed [Replace "full"] $ tabbedAlways shrinkText winDecoConfig

myManageHook :: ManageHook
myManageHook =
  composeAll -- the *second* string returned by WM_CLASS in xprop
    [ className =? "ame-term" --> doFloat,
      className =? "Cadence" --> doShift "8",
      className =? "discord" --> doShift "9",
      className =? "Gimp" --> doFloat,
      className =? "Guitarix" --> doShift "8",
      className =? "Spotify" --> doShift "9",
      isDialog --> doFloat
    ]

myXMobarPP :: PP
myXMobarPP =
  def
    { ppCurrent = xmobarBorder "Top" myPurple 3,
      ppExtras = [logTitles id id],
      ppHidden = xmobarColor "#f8f8f2" "",
      ppOrder = \[ws, l, _, wins] -> [wrap "" "" ws, l],
      ppSep = " "
    }
