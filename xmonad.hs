import XMonad

import XMonad.Util.EZConfig
import XMonad.Util.Ungrab

import XMonad.Config.Azerty

import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.NoBorders
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.WindowArranger

import XMonad.Hooks.EwmhDesktops

import XMonad.Actions.MouseResize

myLayout = gaps[(L,80)] $ tiled ||| Mirror tiled ||| Full
  where
    tiled   = Tall nmaster delta ratio
    nmaster = 1      -- Default number of windows in the master pane
    ratio   = 1/2    -- Default proportion of screen occupied by master pane
    delta   = 3/100  -- Percent of screen to increment by when resizing panes

myKeys :: [(String, X ())]
myKeys = [
       ("M-C-j", decWindowSpacing 4)
     , ("M-C-k", incWindowSpacing 4)
     , ("M-C-h", decScreenSpacing 4)
     , ("M-C-l", incScreenSpacing 4)
     , ("M-S-a", sendMessage Arrange)
     , ("M-S-h", sendMessage (IncreaseDown 1))
     , ("M-S-l", sendMessage (IncreaseUp 1))
     ]
main :: IO ()
main = xmonad $ ewmhFullscreen $ ewmh $ belgianConfig
    { modMask    = mod4Mask
    , layoutHook = mouseResize $ windowArrange $ spacingWithEdge 10 $ smartBorders $ myLayout
    , terminal   = "kitty"
    , startupHook = do
            spawn "~/.config/scripts/startup.sh"
    , focusedBorderColor = "#8BE9FD"
    , normalBorderColor  = "#262834"
    } `additionalKeysP` myKeys
