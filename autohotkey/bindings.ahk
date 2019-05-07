#NoEnv
SendMode Input

;CapsLock to ESC - VIM 4 THE WIN!
CapsLock::Esc

; Alt is an antipattern
; Alt + F4 to Ctrl + Q
; https://old.reddit.com/r/AutoHotkey/comments/9t3b15/can_you_please_help_me_figure_this_out_its/
^q::Send !{F4}
    
; Ctrl and Alt swaps - Old OSX habits.
; LAlt::LCtrl
; LCtrl::LAlt

; Fix AltTab to CtrlTab
; https://autohotkey.com/board/topic/96465-switch-alt-and-ctrl-retain-alt-tab/
; If the physical key 'LAlt' is pressed, tab will send 'LCtrl up' to counter the 'LCtrl::LAlt'
; It then sends Alt down, and Tab
; #If GetKeyState("LAlt", "P")
; Tab::
; Send {LCtrl up}{Alt down}{Tab}
; return

; ; If the physical key 'LAlt' is not pressed, a 'Tab up' will send 'Alt up'
; #If !GetKeyState("LAlt", "P")
; Tab up::
; Send {Alt  up}
; return
; #If

; ; Since 'LAlt up' sends 'LCtrl up' we need it to also send 'Alt up' to get rid of the AltTab menu.
; LAlt up::Send {Alt up}
LCtrl & Tab:: AltTab
