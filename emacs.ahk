; https://github.com/tigerhawkvok/emacs.ahk/blob/master/emacs.ahk
;;
;; An autohotkey script that provides emacs-like keybinding on Windows
;;
#InstallKeybdHook
#UseHook

; The following line is a contribution of NTEmacs wiki http://www49.atwiki.jp/ntemacs/pages/20.html
SetKeyDelay 0

; turns to be 1 when ctrl-x is pressed
is_pre_x = 0
; turns to be 1 when ctrl-space is pressed
is_pre_spc = 0
; turns to 1 if the application has alternate forward-search
alt_forward_search = 0
has_started_search = 0


; Applications you want to disable emacs-like keybindings
; (Please comment out applications you don't use)
is_target()
{
  IfWinActive,ahk_class ConsoleWindowClass ; Cygwin
    Return 1 
  IfWinActive,ahk_class MEADOW ; Meadow
    Return 1 
  IfWinActive,ahk_class cygwin/x X rl-xterm-XTerm-0
    Return 1
  IfWinActive,ahk_class MozillaUIWindowClass ; keysnail on Firefox
    Return 1
  ; Avoid VMwareUnity with AutoHotkey
  IfWinActive,ahk_class VMwareUnityHostWndClass
    Return 1
  IfWinActive,ahk_class Vim ; GVIM
    Return 1
  IfWinActive,ahk_class SWT_Window0 ; Eclipse
    Return 1
;   IfWinActive,ahk_class Xming X
;     Return 1
;   IfWinActive,ahk_class SunAwtFrame
;     Return 1
   IfWinActive,ahk_class Emacs ; NTEmacs
     Return 1  
   IfWinActive,ahk_class XEmacs ; XEmacs on Cygwin
     Return 1
   IfWinActive,ahk_class PuTTY
     Return 1
  Return 0
}

does_alt_forward_search()
{
  IfWinActive,ahk_class Chrome_WidgetWin_1 ; Chrome
    Return 1
  global has_started_search = 0
  Return 0 
}

send_alt_forward_search_key()
{
  IfWinActive,ahk_class Chrome_WidgetWin_1 ; Chrome
    Send ^g
}
send_alt_backward_search_key()
{
  IfWinActive,ahk_class Chrome_WidgetWin_1 ; Chrome
    Send ^G
}

delete_char()
{
  Send {Del}
  global is_pre_spc = 0
  Return
}
delete_backward_char()
{
  Send {BS}
  global is_pre_spc = 0
  Return
}
copy_line()
{
  Send {HOME}{ShiftDown}{END}{SHIFTUP}
  Sleep 50
  Send ^c
}
duplicate_line()
{
  copy_line()
  Send {Enter}
  Send ^v
}
kill_line()
{
  Send {ShiftDown}{END}{SHIFTUP}
  Sleep 50 ;[ms] this value depends on your environment
  Send ^x
  global is_pre_spc = 0
  Return
}
open_line()
{
  Send {END}{Enter}{Up}
  global is_pre_spc = 0
  Return
}
quit()
{
  Send {ESC}
  global is_pre_spc = 0
  global has_started_search = 0
  global is_pre_x = 0
  global alt_forward_search = 0
  Return
}
newline()
{
  Send {Enter}
  global is_pre_spc = 0
  Return
}
indent_for_tab_command()
{
  Send {Tab}
  global is_pre_spc = 0
  Return
}
newline_and_indent()
{
  Send {Enter}{Tab}
  global is_pre_spc = 0
  Return
}
isearch_forward()
{
  global
  If alt_forward_search And has_started_search
    send_alt_forward_search_key()
  Else
    {
      Send ^f
      alt_forward_search = does_alt_forward_search()
      If alt_forward_search
        has_started_search = 1
    }
  is_pre_spc = 0
  Return
}
isearch_backward()
{
  global
  If alt_forward_search And has_started_search
    send_alt_backward_search_key()
  Else
    {
      Send ^f
      alt_forward_search = does_alt_forward_search()
      If alt_forward_search
        has_started_search = 1
    }
  is_pre_spc = 0
  Return

}
kill_region()
{
  Send ^x
  global is_pre_spc = 0
  Return
}
kill_ring_save()
{
  Send ^c
  global is_pre_spc = 0
  Return
}
yank()
{
  Send ^v
  global is_pre_spc = 0
  Return
}
undo()
{
  Send ^z
  global is_pre_spc = 0
  Return
}
find_file()
{
  Send ^o
  global is_pre_x = 0
  Return
}
save_buffer()
{
  Send, ^s
  global is_pre_x = 0
  Return
}
kill_emacs()
{
  Send !{F4}
  global is_pre_x = 0
  Return
}

move_beginning_of_line()
{
  global
  if is_pre_spc
    Send +{HOME}
  Else
    Send {HOME}
  Return
}
move_end_of_line()
{
  global
  if is_pre_spc
    Send +{END}
  Else
    Send {END}
  Return
}
previous_line()
{
  global
  if is_pre_spc
    Send +{Up}
  Else
    Send {Up}
  Return
}
next_line()
{
  global
  if is_pre_spc
    Send +{Down}
  Else
    Send {Down}
  Return
}
forward_char()
{
  global
  if is_pre_spc
    Send +{Right}
  Else
    Send {Right}
  Return
}
backward_char()
{
  global
  if is_pre_spc
    Send +{Left} 
  Else
    Send {Left}
  Return
}
scroll_up()
{
  global
  if is_pre_spc
    Send +{PgUp}
  Else
    Send {PgUp}
  Return
}
scroll_down()
{
  global
  if is_pre_spc
    Send +{PgDn}
  Else
    Send {PgDn}
  Return
}


^x::
  If is_target()
    Send %A_ThisHotkey%
  Else
    If is_pre_x
    {
      send ^x
      is_pre_x = 0
    }
    Else
      is_pre_x = 1
  Return 
^f::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
    If is_pre_x
      find_file()
    Else
      Send %A_ThisHotkey%
  }
  Return  
^c::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
    If is_pre_x
      kill_emacs()
    Else
      Send %A_ThisHotkey%
  }
  Return
; Select a buffer
h::
  If is_pre_x
  {
    If is_target()
      Send %A_ThisHotkey%
    Else
    {
      Send ^a
      is_pre_x = 0
    }
  }
  Else
  {
    ; if caps lock is on, send it capped ...
    state := GetKeyState("Capslock","T")
    If state
      Send H
    Else
      Send %A_ThisHotkey% 
  }
  Return
^d::
  If is_target()
    Send %A_ThisHotkey%
  Else
    duplicate_line()
  Return
^k::
  If is_target()
    Send %A_ThisHotkey%
  Else
    kill_line()
  Return
;; ^o::
;;   If is_target()
;;     Send %A_ThisHotkey%
;;   Else
;;     open_line()
;;   Return
^g::
  If is_target()
    Send %A_ThisHotkey%
  Else
    quit()
  Return
^j::
  If is_target()
    Send %A_ThisHotkey%
  Else
    newline_and_indent()
  Return
^m::
  If is_target()
    Send %A_ThisHotkey%
  Else
    newline()
  Return
^i::
  If is_target()
    Send %A_ThisHotkey%
  Else
    indent_for_tab_command()
  Return
^s::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
    If is_pre_x
      save_buffer()
    Else
      isearch_forward()
  }
  Return
^r::
  If is_target()
    Send %A_ThisHotkey%
  Else
    isearch_backward()
  Return
^w::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
    clipboard= ; Empty the clipboard
    Send ^c
    ClipWait,0.1
    If ErrorLevel
      Send %A_ThisHotkey%
    Else
      kill_region()
  }
  Return
!w::
  If is_target()
    Send %A_ThisHotkey%
  Else
    kill_ring_save()
  Return
^y::
  If is_target()
    Send %A_ThisHotkey%
  Else
    yank()
  Return
^_::
  If is_target()
    Send %A_ThisHotkey%
  Else
    undo()
  Return  
  
;$^{Space}::
^vk20sc039::
  If is_target()
    Send {CtrlDown}{Space}{CtrlUp}
  Else
  {
    If is_pre_spc
      is_pre_spc = 0
    Else
      is_pre_spc = 1
  }
  Return
^@::
  If is_target()
    Send %A_ThisHotkey%
  Else
  {
    If is_pre_spc
      is_pre_spc = 0
    Else
      is_pre_spc = 1
  }
  Return
^a::
  If is_target()
    Send %A_ThisHotkey%
  Else
    move_beginning_of_line()
  Return
^e::
  If is_target()
    Send %A_ThisHotkey%
  Else
    move_end_of_line()
  Return
