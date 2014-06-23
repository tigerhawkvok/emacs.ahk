# emacs.ahk 
Allows you to use emacs-like key bindings on Windows environment.

This is a forked script to make it more like my standard emacs environment. I've also tweaked it to be more forgiving to standard Windows keybinds where they interfere.

## Supported keybindings
<table>
  <tr>
    <th>Keybinding</th>
    <th>Function(Emacs Lisp)</th>
  </tr>
<tr>
<td>C-Space</td>
<td>set-mark-command</td>
</tr>
<tr>
<td>C-@</td>
<td>set-mark-command</td>
</tr>
<tr>
<td>C-x C-f</td>
<td>find-file</td>
</tr>
<tr>
<td>C-x C-s</td>
<td>save-buffer</td>
</tr>
<tr>
<td>C-x C-c</td>
<td>kill-emacs</td>
</tr>
<tr>
<td>C-x h</td>
<td>mark-whole-buffer</td>
</tr>
<tr>
<td>C-d</td>
<td>duplicate-line</td>
</tr>
<tr>
<td>C-h</td>
<td>delete-backward-char</td>
</tr>
<tr>
<td>C-k</td>
<td>kill-line</td>
</tr>
<tr>
<td>C-g</td>
<td>quit</td>
</tr>
<tr>
<td>C-j</td>
<td>newline-and-indent</td>
</tr>
<tr>
<td>C-m</td>
<td>newline</td>
</tr>
<tr>
<td>C-i</td>
<td>indent-for-tab-command</td>
</tr>
<tr>
<td>C-s</td>
<td>isearch-forward</td>
</tr>
<tr>
<td>C-r</td>
<td>isearch-backward</td>
</tr>
<tr>
<td>C-w</td>
<td>kill-region (if text selected; otherwise default)</td>
</tr>
<tr>
<td>M-w</td>
<td>kill-ring-save</td>
</tr>
<tr>
<td>C-y</td>
<td>yank</td>
</tr>
<tr>
<td>C-_</td>
<td>undo</td>
</tr>
<tr>
<td>C-a</td>
<td>move-beginning-of-line</td>
</tr>
<tr>
<td>C-e</td>
<td>move-end-of-line</td>
</tr>
<tr>
<td>C-f</td>
<td>forward-char</td>
</tr>
<tr>
<td>C-b</td>
<td>backward-char</td>
</tr>
<tr>
<td>M-v</td>
<td>scroll-up</td>
</tr>
</table>
