import XMonad

import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Util.NamedScratchpad

import XMonad.Config.Azerty
import XMonad.StackSet as W

import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.NoBorders
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.WindowArranger
import XMonad.Layout.Fullscreen

import XMonad.Hooks.EwmhDesktops
import XMonad.ManageHook

import XMonad.Actions.MouseResize
import qualified XMonad.Actions.FlexibleManipulate as Flex

mySpacing :: Int
mySpacing = 10

myLayout = toggleLayouts (Full) (tiled ||| Mirror tiled)
  where
    tiled   = Tall nmaster delta ratio
    nmaster = 1     
    ratio   = 1/2  
    delta   = 3/100

myKeys :: [(String, X ())]
myKeys = [
       ("M-C-j", decWindowSpacing 4)
     , ("M-C-k", incWindowSpacing 4)
     , ("M-C-h", decScreenSpacing 4)
     , ("M-C-l", incScreenSpacing 4)
     , ("M-S-h", sendMessage (IncreaseDown 1))
     , ("M-S-l", sendMessage (IncreaseUp 1))
     , ("M-S-f", do 
                 sendMessage (Toggle "Full")
                 toggleScreenSpacingEnabled
                 toggleWindowSpacingEnabled) 
     , ("M-f", do 
               sendMessage (Toggle "Full")
               setScreenSpacingEnabled True
               setWindowSpacingEnabled True)
     , ("M-b", namedScratchpadAction scratchpads "htop")
     ]

myMouse :: [((ButtonMask, Button), Window -> X ())]
myMouse = [
        ]

scratchpads :: [NamedScratchpad]
scratchpads = [
    NS "htop" "kitty -e htop" (title =? "htop") defaultFloating
    ] where role = stringProperty "WM_WINDOW_ROLE"


main :: IO ()
main = xmonad $ ewmhFullscreen $ ewmh $ belgianConfig
    { modMask    = mod4Mask
    , layoutHook = mouseResize $ windowArrange $ spacingWithEdge 10 $ smartBorders $ myLayout
    , terminal   = "kitty"
    , startupHook = do
          spawn "~/.config/scripts/startup.sh"
    , normalBorderColor  = "#262834"
    , focusedBorderColor = "#6C7D9B"
    , manageHook = namedScratchpadManageHook scratchpads
    } `additionalKeysP` myKeys
      `additionalMouseBindings` myMouse
