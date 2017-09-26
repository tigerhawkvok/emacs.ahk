@echo off
copy /y %appdata%\.emacs %appdata%\.emacs.bak
copy /y .emacs %appdata%\.emacs
rename %appdata%\elisp %appdata%\elisp.bak
mkdir %appdata%\elisp
xcopy /y emacs.d %appdata%\elisp
emacs\emacs-23.1\bin\runemacs.exe
echo Any existing configuration file backed up. Press a key when done to restore original configuration file.
pause
copy /y %appdata%\.emacs.bak %appdata%\.emacs
rmdir /s /q %appdata%\elisp
rename %appdata%\elisp.bak %appdata%\elisp