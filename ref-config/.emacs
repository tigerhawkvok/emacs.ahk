(setq gc-cons-threshold 50000000)
(setq default-buffer-file-coding-system 'utf-8-unix)
(setq load-prefer-newer t)

(ignore-errors
  (set-face-font 'default "Droid Sans Mono-9")
  (set-face-font 'bold "Droid Sans Mono W01 Bold-9")
  (set-face-font 'italic "Consolas-10")
  (set-face-font 'bold-italic "Anonymous Pro Bold Italic-10"))
(when (window-system)
  (set-default-font "Fira Code"))
;; (let ((alist '((33 . ".\\(?:\\(?:==\\|!!\\)\\|[!=]\\)")
;;                (35 . ".\\(?:###\\|##\\|_(\\|[#(?[_{]\\)")
;;                (36 . ".\\(?:>\\)")
;;                (37 . ".\\(?:\\(?:%%\\)\\|%\\)")
;;                (38 . ".\\(?:\\(?:&&\\)\\|&\\)")
;;                (42 . ".\\(?:\\(?:\\*\\*/\\)\\|\\(?:\\*[*/]\\)\\|[*/>]\\)")
;;                (43 . ".\\(?:\\(?:\\+\\+\\)\\|[+>]\\)")
;;                (45 . ".\\(?:\\(?:-[>-]\\|<<\\|>>\\)\\|[<>}~-]\\)")
;;                (46 . ".\\(?:\\(?:\\.[.<]\\)\\|[.=-]\\)")
;;                (47 . ".\\(?:\\(?:\\*\\*\\|//\\|==\\)\\|[*/=>]\\)")
;;                (48 . ".\\(?:x[a-zA-Z]\\)")
;;                (58 . ".\\(?:::\\|[:=]\\)")
;;                (59 . ".\\(?:;;\\|;\\)")
;;                (60 . ".\\(?:\\(?:!--\\)\\|\\(?:~~\\|->\\|\\$>\\|\\*>\\|\\+>\\|--\\|<[<=-]\\|=[<=>]\\||>\\)\\|[*$+~/<=>|-]\\)")
;;                (61 . ".\\(?:\\(?:/=\\|:=\\|<<\\|=[=>]\\|>>\\)\\|[<=>~]\\)")
;;                (62 . ".\\(?:\\(?:=>\\|>[=>-]\\)\\|[=>-]\\)")
;;                (63 . ".\\(?:\\(\\?\\?\\)\\|[:=?]\\)")
;;                (91 . ".\\(?:]\\)")
;;                (92 . ".\\(?:\\(?:\\\\\\\\\\)\\|\\\\\\)")
;;                (94 . ".\\(?:=\\)")
;;                (119 . ".\\(?:ww\\)")
;;                (123 . ".\\(?:-\\)")
;;                (124 . ".\\(?:\\(?:|[=|]\\)\\|[=>|]\\)")
;;                (126 . ".\\(?:~>\\|~~\\|[>=@~-]\\)")
;;                )
;;              ))
;;   (dolist (char-regexp alist)
;;     (set-char-table-range composition-function-table (car char-regexp)
;;                           `([,(cdr char-regexp) 0 font-shape-gstring]))))
;;; Fira code
;; This works when using emacs --daemon + emacsclient
(add-hook 'after-make-frame-functions (lambda (frame) (set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol")))
;; This works when using emacs without server/client
(set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol")
;; I haven't found one statement that makes both of the above situations work, so I use both for now

(defconst fira-code-font-lock-keywords-alist
  (mapcar (lambda (regex-char-pair)
            `(,(car regex-char-pair)
              (0 (prog1 ()
                   (compose-region (match-beginning 1)
                                   (match-end 1)
                                   ;; The first argument to concat is a string containing a literal tab
                                   ,(concat "	" (list (decode-char 'ucs (cadr regex-char-pair)))))))))
          '(("\\(www\\)"                   #Xe100)
            ("[^/]\\(\\*\\*\\)[^/]"        #Xe101)
            ("\\(\\*\\*\\*\\)"             #Xe102)
            ("\\(\\*\\*/\\)"               #Xe103)
            ("\\(\\*>\\)"                  #Xe104)
            ("[^*]\\(\\*/\\)"              #Xe105)
            ("\\(\\\\\\\\\\)"              #Xe106)
            ("\\(\\\\\\\\\\\\\\)"          #Xe107)
            ("\\({-\\)"                    #Xe108)
            ;("\\(\\[\\]\\)"                #Xe109)
            ("\\(::\\)"                    #Xe10a)
            ("\\(:::\\)"                   #Xe10b)
            ("[^=]\\(:=\\)"                #Xe10c)
            ("\\(!!\\)"                    #Xe10d)
            ("\\(!=\\)"                    #Xe10e)
            ("\\(!==\\)"                   #Xe10f)
            ("\\(-}\\)"                    #Xe110)
            ("\\(--\\)"                    #Xe111)
            ("\\(---\\)"                   #Xe112)
            ("\\(-->\\)"                   #Xe113)
            ("[^-]\\(->\\)"                #Xe114)
            ("\\(->>\\)"                   #Xe115)
            ("\\(-<\\)"                    #Xe116)
            ("\\(-<<\\)"                   #Xe117)
            ("\\(-~\\)"                    #Xe118)
            ;("\\(#{\\)"                    #Xe119)
            ("\\(#\\[\\)"                  #Xe11a)
            ("\\(##\\)"                    #Xe11b)
            ("\\(###\\)"                   #Xe11c)
            ("\\(####\\)"                  #Xe11d)
            ("\\(#(\\)"                    #Xe11e)
            ("\\(#\\?\\)"                  #Xe11f)
            ("\\(#_\\)"                    #Xe120)
            ("\\(#_(\\)"                   #Xe121)
            ("\\(\\.-\\)"                  #Xe122)
            ("\\(\\.=\\)"                  #Xe123)
            ("\\(\\.\\.\\)"                #Xe124)
            ("\\(\\.\\.<\\)"               #Xe125)
            ("\\(\\.\\.\\.\\)"             #Xe126)
            ("\\(\\?=\\)"                  #Xe127)
            ("\\(\\?\\?\\)"                #Xe128)
            ("\\(;;\\)"                    #Xe129)
            ("\\(/\\*\\)"                  #Xe12a)
            ("\\(/\\*\\*\\)"               #Xe12b)
            ("\\(/=\\)"                    #Xe12c)
            ("\\(/==\\)"                   #Xe12d)
            ("\\(/>\\)"                    #Xe12e)
            ("\\(//\\)"                    #Xe12f)
            ("\\(///\\)"                   #Xe130)
            ("\\(&&\\)"                    #Xe131)
            ("\\(||\\)"                    #Xe132)
            ("\\(||=\\)"                   #Xe133)
            ("[^|]\\(|=\\)"                #Xe134)
            ("\\(|>\\)"                    #Xe135)
            ("\\(\\^=\\)"                  #Xe136)
            ("\\(\\$>\\)"                  #Xe137)
            ("\\(\\+\\+\\)"                #Xe138)
            ("\\(\\+\\+\\+\\)"             #Xe139)
            ("\\(\\+>\\)"                  #Xe13a)
            ("\\(=:=\\)"                   #Xe13b)
            ("[^!/]\\(==\\)[^>]"           #Xe13c)
            ("\\(===\\)"                   #Xe13d)
            ("\\(==>\\)"                   #Xe13e)
            ("[^=]\\(=>\\)"                #Xe13f)
            ("\\(=>>\\)"                   #Xe140)
            ("\\(<=\\)"                    #Xe141)
            ("\\(=<<\\)"                   #Xe142)
            ("\\(=/=\\)"                   #Xe143)
            ("\\(>-\\)"                    #Xe144)
            ("\\(>=\\)"                    #Xe145)
            ("\\(>=>\\)"                   #Xe146)
            ("[^-=]\\(>>\\)"               #Xe147)
            ("\\(>>-\\)"                   #Xe148)
            ("\\(>>=\\)"                   #Xe149)
            ("\\(>>>\\)"                   #Xe14a)
            ("\\(<\\*\\)"                  #Xe14b)
            ("\\(<\\*>\\)"                 #Xe14c)
            ("\\(<|\\)"                    #Xe14d)
            ("\\(<|>\\)"                   #Xe14e)
            ("\\(<\\$\\)"                  #Xe14f)
            ("\\(<\\$>\\)"                 #Xe150)
            ("\\(<!--\\)"                  #Xe151)
            ("\\(<-\\)"                    #Xe152)
            ("\\(<--\\)"                   #Xe153)
            ("\\(<->\\)"                   #Xe154)
            ("\\(<\\+\\)"                  #Xe155)
            ("\\(<\\+>\\)"                 #Xe156)
            ("\\(<=\\)"                    #Xe157)
            ("\\(<==\\)"                   #Xe158)
            ("\\(<=>\\)"                   #Xe159)
            ("\\(<=<\\)"                   #Xe15a)
            ("\\(<>\\)"                    #Xe15b)
            ("[^-=]\\(<<\\)"               #Xe15c)
            ("\\(<<-\\)"                   #Xe15d)
            ("\\(<<=\\)"                   #Xe15e)
            ("\\(<<<\\)"                   #Xe15f)
            ("\\(<~\\)"                    #Xe160)
            ("\\(<~~\\)"                   #Xe161)
            ("\\(</\\)"                    #Xe162)
            ("\\(</>\\)"                   #Xe163)
            ("\\(~@\\)"                    #Xe164)
            ("\\(~-\\)"                    #Xe165)
            ("\\(~=\\)"                    #Xe166)
            ("\\(~>\\)"                    #Xe167)
            ("[^<]\\(~~\\)"                #Xe168)
            ("\\(~~>\\)"                   #Xe169)
            ("\\(%%\\)"                    #Xe16a)
            ;; ("\\(x\\)"                   #Xe16b) This ended up being hard to do properly so i'm leaving it out.
            ("[^:=]\\(:\\)[^:=]"           #Xe16c)
            ("[^\\+<>]\\(\\+\\)[^\\+<>]"   #Xe16d)
            ("[^\\*/<>]\\(\\*\\)[^\\*/<>]" #Xe16f))))

(defun add-fira-code-symbol-keywords ()
  (font-lock-add-keywords nil fira-code-font-lock-keywords-alist))

(add-hook 'prog-mode-hook
          #'add-fira-code-symbol-keywords)
;(require 'ess-site) ; For R, but laggy

(add-to-list 'load-path "~/elisp")

;(load "~/elisp/dvi-view.el")
(autoload 'batch-mode "batch-mode" "Major mode for editing DOS batch files." t)
;(autoload 'wikipedia-mode "~/elisp/wikipedia-mode.el"
;"Major mode for editing documents in Wikipedia markup." t)
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
;(load "~/elisp/nxhtml/autostart.el") ; slow as hell!
(autoload 'apache-mode "apache-mode" "Major mode for editing .htaccess and other server files." t)
(autoload 'coffee-mode "coffee-mode" "Major mode for editing coffeescript files." t)
(autoload 'yaml-mode "yaml-mode" "Major mode for editing YAML files." t)
(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown-style documents." t)
(autoload 'csv-mode "csv-mode" "Major mode for editing CSV documents." t)
(autoload 'gradle-mode "gradle-mode" "Major mode for editing gradle files." t)
(autoload 'gitconfig-mode "gitconfig-mode" "Major mode for editing .gitconfig files." t)
(autoload 'gitignore-mode "gitignore-mode" "Major mode for editing .gitignore files." t)
;https://github.com/joshwnj/json-mode
(autoload 'json-mode "json-mode" "Major mode for editing JSON files." t)
(autoload 'less-css-mode "less-css-mode" "Major mode for editing LESS files." t)
; (autoload 'gfm-mode "gfm-mode" "Major mode for editing Github-flavored Markdown documents." t)
; markdown mode: http://jblevins.org/projects/markdown-mode/

;(load "~/elisp/xml-rpc.el")
;(load "~/elisp/weblogger.el")
(require 'package)
(setq package-enable-at-startup nil)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))
;(add-hook 'after-init-hook #'global-flycheck-mode)
;(add-to-list 'flycheck-disabled-checkers 'php-phpcs)
(setq flycheck-highlighting-mode 'lines)

(setq php-mode-warn-if-mumamo-off nil)

; Spellchecking
;(add-to-list 'exec-path "C:\Program Files (x86)\Aspell\bin")
(add-to-list 'exec-path "~/elisp/aspell/bin")
(setq-default ispell-program-name "aspell.exe")
(require 'ispell)

; manage cross-device conflicts
(global-auto-revert-mode t)

; Packages
(ignore-errors
(require 'package)

;;; See https://github.com/nicferrier/elmarmalade/issues/50
;;; and https://marmalade-repo.org/#windowsinstructions
;; (add-to-list 'package-archives
;;              '("marmalade" . "https://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; (defadvice package-compute-transaction
  ;;     (before package-compute-transaction-reverse (package-list requirements) activate compile)
  ;;   "reverse the requirements"
  ;;   (setq requirements (reverse requirements))
  ;;   (print requirements))
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)
)

;; ; Git
;; (setq magit-commit-all-when-nothing-staged t)
;; (setq magit-save-some-buffers "y")

;; (defun git-save-commit ()
;;   (interactive)
;;   (setq magit-save-some-buffers "y")
;;   (magit-status(substring (pwd) 10))
;;   (magit-stage-all)
;;   (magit-log-edit)
;; )
;; (global-set-key (kbd "C-x g") 'git-save-commit)


;still necessary
(setenv "TEMP" "c:/windows/temp")
(setenv "TMP" "c:/windows/temp")

; Mouse behaves as browser
(global-set-key (kbd "<mouse-4>") 'previous-buffer)
(global-set-key (kbd "<mouse-5>") 'next-buffer)
(global-set-key (kbd "<C-mouse-5>") 'previous-multiframe-window)
(global-set-key (kbd "<C-mouse-5>") 'next-multiframe-window)
(global-set-key (kbd "C-x <pause>") 'save-buffers-kill-emacs) ; for SSHing into windows


; Set major modes
(add-to-list 'auto-mode-alist '("\\.htaccess\\'"   . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\\.conf\\'"  . apache-mode))
(add-to-list 'auto-mode-alist '("srm\\.conf\\'"    . apache-mode))
(add-to-list 'auto-mode-alist '("access\\.conf\\'" . apache-mode))
(add-to-list 'auto-mode-alist '("sites-\\(available\\|enabled\\)/" . apache-mode))
(add-to-list 'auto-mode-alist '("\\.\\(?:bat\\|com\\)$" . batch-mode))
(add-to-list 'auto-mode-alist
'("\\.wiki\\'" . wikipedia-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode)) ; Change this to html-mode manually when dealing with html-heavy files
(add-to-list 'auto-mode-alist '("\\.xht$" . html-mode))
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("README\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.csv\\'" . csv-mode))
(add-to-list 'auto-mode-alist '("\\.gradle\\'" . gradle-mode))
(add-to-list 'auto-mode-alist '("\\.gitconfig\\'" . gitconfig-mode))
(add-to-list 'auto-mode-alist '("\\.gitignore\\'" . gitignore-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))
(add-to-list 'auto-mode-alist '("\\.less\\'" . less-css-mode))

;; (eval-after-load 'gitignore-mode
;;   '(electric-indent-mode nil ))

;; Taken from https://github.com/yasuyk/web-beautify
;; Make sure js-beautify is install, for which NPM is needed:
;; Use http://nodejs.org/ and be sure npm is added to PATH

;; (eval-after-load 'js2-mode
;;   '(add-hook 'js2-mode-hook
;;              (lambda ()
;;                (add-hook 'before-save-hook 'web-beautify-js-buffer t t))))

;; ;; Or if you're using 'js-mode' (a.k.a 'javascript-mode')
;; (eval-after-load 'js
;;   '(add-hook 'js-mode-hook
;;              (lambda ()
;;                (add-hook 'before-save-hook 'web-beautify-js-buffer t t))))

;; (eval-after-load 'json-mode
;;   '(add-hook 'json-mode-hook
;;              (lambda ()
;;                (add-hook 'before-save-hook 'web-beautify-js-buffer t t))))

;; (eval-after-load 'sgml-mode
;;   '(add-hook 'html-mode-hook
;;              (lambda ()
;;                (add-hook 'before-save-hook 'web-beautify-html-buffer t t))))

;; (eval-after-load 'css-mode
;;   '(add-hook 'css-mode-hook
;;              (lambda ()
;;                (add-hook 'before-save-hook 'web-beautify-css-buffer t t))))

;; Removes toolbar
(tool-bar-mode 0)
;; automatically clean up bad whitespace
(setq whitespace-action '(auto-cleanup))
(setq global-whitespace-mode t)


;; Make sure that the bash executable can be found
;; (setq explicit-shell-file-name "C:/cygwin64/bin/bash.exe")
;; (setq shell-file-name explicit-shell-file-name)
;; (add-to-list 'exec-path "C:/cygwin64/bin")

;; Indents!
;; Shift the selected region right if distance is positive, left if
;; negative

(defun shift-region (distance)
  (let ((mark (mark)))
    (save-excursion
      (indent-rigidly (region-beginning) (region-end) distance)
      (push-mark mark t t)
      ;; Tell the command loop not to deactivate the mark
      ;; for transient mark mode
      (setq deactivate-mark nil))))

(defun shift-right ()
  (interactive)
  (shift-region 1))

(defun shift-left ()
  (interactive)
  (shift-region -1))

(defun insert-tabs (n)
  "Inserts N number of tabs"
  (interactive "nNumber of tabs: ")
  (dotimes (i n)
    (indent-for-tab-command)))

(defun open-buffer-path ()
  "Run explorer on the directory of the current buffer."
   (interactive)
   (shell-command (concat "explorer " (replace-regexp-in-string "/" "\\\\" (file-name-directory (buffer-file-name)) t t))))

;; Bind (shift-right) and (shift-left) function to your favorite keys. I use
;; the following so that Ctrl-Shift-Right Arrow moves selected text one
;; column to the right, Ctrl-Shift-Left Arrow moves selected text one
;; column to the left:

(global-set-key [C-S-right] 'shift-right)
(global-set-key [C-S-left] 'shift-left)
;; (global-set-key "\C->" '(insert-tabs 1))
;; (global-set-key "\C-<" '(insert-tabs -1))

; Pairing of programming characters
(electric-pair-mode 1)

(defun smart-close-tag()
  "When runnign close tag inside a tag, create a closed one"
  (interactive)
  (end-of-line)
  (sgml-close-tag)
  (backward-sexp)
  (new-line-dwim)
  )

(defun smart-semicolon()
  "When inserting a semicolon at the end of a string or ), jump outside it and insert"
  (interactive)
  (when (or (looking-at "\"") (looking-at "'") (looking-at ")") (looking-at "]"))
    (forward-char)
    (if (and (or (looking-back "\"") (looking-back "'")) (or (looking-at ")") (looking-at "]")))
        (forward-char))
    )
  (insert ";")
  )

(global-set-key (kbd ";") 'smart-semicolon)


;; Smart indenting
(electric-indent-mode 1)

;; Boring newline
(defun do-boring-newline()
  "Just do a newline to beginning"
  (interactive)
  (electric-indent-mode 0)
  (newline)
  (beginning-of-line)
  (delete-trailing-whitespace)
  (electric-indent-mode 1))
(global-set-key "\C-j" 'do-boring-newline) ;; remap C-j to what RET was

(defun escape-doublequotes-at-car-of-kill-ring ()
  "Escape doublequotes in car of kill-ring "
  (interactive)
  (with-temp-buffer
    (insert (car kill-ring))
    (goto-char (point-min))
    (while (search-forward "\"" nil t 1)
      (replace-match "\\\\\""))
    (kill-new (buffer-substring-no-properties (point-min) (point-max)))))

;;; Indentation for python

;; Ignoring electric indentation
(defun electric-indent-ignore-python (char)
  "Ignore electric indentation for python-mode"
  (if (equal major-mode 'python-mode)
      `no-indent'
    nil))
(add-hook 'electric-indent-functions 'electric-indent-ignore-python)
(defun electric-indent-ignore-coffee (char)
  "Ignore electric indentation for coffee-mode"
  (if (equal major-mode 'coffee-mode)
      `no-indent'
    nil))
(add-hook 'electric-indent-functions 'electric-indent-ignore-coffee)

;; Enter key executes newline-and-indent
(defun set-newline-and-indent ()
  "Map the return key with `newline-and-indent'"
  (local-set-key (kbd "RET") 'newline-and-indent))
(add-hook 'python-mode-hook 'set-newline-and-indent)


(dolist (command '(yank yank-pop))
   (eval `(defadvice ,command (after indent-region activate)
            (and (not current-prefix-arg)
                 (member major-mode '(emacs-lisp-mode lisp-mode
                                                      clojure-mode    scheme-mode
                                                      haskell-mode    ruby-mode
                                                      rspec-mode      python-mode
                                                      c-mode          c++-mode
                                                      objc-mode       latex-mode
                                                      plain-tex-mode  javascript-mode
                                                      php-mode        shell-mode
                                                      html-mode       ))
                 (let ((mark-even-if-inactive transient-mark-mode))
                                        ;(qq-region)
                   ;(escape-doublequotes-at-car-of-kill-ring)
                   (indent-region (region-beginning) (region-end) nil)
                   )))))


(defun kill-and-join-forward (&optional arg)
  "If at end of line, join with following; otherwise kill line.
Deletes whitespace at join."
  (interactive "P")
  (if (and (eolp) (not (bolp)))
      (delete-indentation t)
    (kill-line arg)
    (if (and (not (bolp)) (not(eolp)))
        (just-one-space))
    ))
(global-set-key "\C-k" 'kill-and-join-forward)

(global-set-key "\C-n" 'up-list) ; Move to the end of a balanced group

(defun new-line-dwim ()
  (interactive)
  (let ((break-open-pair (or (and (looking-back "{") (looking-at "}"))
                             (and (looking-back ">") (looking-at "<"))
                             (and (looking-back "(") (looking-at ")"))
                             (and (looking-back "\\[") (looking-at "\\]")))))
    (newline)
    (when break-open-pair
      (save-excursion
        (newline)
        (indent-for-tab-command)))
    (indent-for-tab-command)))

(global-set-key (kbd "RET") 'new-line-dwim)

;  Bracket navigation
; Source: http://ergoemacs.org/emacs/emacs_navigating_keys_for_brackets.html

(defun ergoemacs-forward-open-bracket (&optional number)
  "Move cursor to the next occurrence of left bracket or quotation mark.

With prefix NUMBER, move forward to the next NUMBER left bracket or quotation mark.

With a negative prefix NUMBER, move backward to the previous NUMBER left bracket or quotation mark."
  (interactive "p")
  (if (and number
           (> 0 number))
      (ergoemacs-backward-open-bracket (- 0 number))
    (forward-char 1)
    (search-forward-regexp
     (eval-when-compile
       (regexp-opt
        '("(" "{" "[" "<" "〔" "【" "〖" "〈" "《" "「" "『" "“" "‘" "‹" "«"))) nil t number)
    (backward-char 1)))

(defun ergoemacs-backward-open-bracket (&optional number)
  "Move cursor to the previous occurrence of left bracket or quotation mark.
With prefix argument NUMBER, move backward NUMBER open brackets.
With a negative prefix NUMBER, move forward NUMBER open brackets."
  (interactive "p")
  (if (and number
           (> 0 number))
      (ergoemacs-forward-open-bracket (- 0 number))
    (search-backward-regexp
     (eval-when-compile
       (regexp-opt
        '("(" "{" "[" "<" "〔" "【" "〖" "〈" "《" "「" "『" "“" "‘" "‹" "«"))) nil t number)))

(defun ergoemacs-forward-close-bracket (&optional number)
  "Move cursor to the next occurrence of right bracket or quotation mark.
With a prefix argument NUMBER, move forward NUMBER closed bracket.
With a negative prefix argument NUMBER, move backward NUMBER closed brackets."
  (interactive "p")
  (if (and number
           (> 0 number))
      (ergoemacs-backward-close-bracket (- 0 number))
    (search-forward-regexp
     (eval-when-compile
       (regexp-opt '(")" "]" "}" ">" "〕" "】" "〗" "〉" "》" "」" "』" "”" "’" "›" "»"))) nil t number)))

(defun ergoemacs-backward-close-bracket (&optional number)
  "Move cursor to the previous occurrence of right bracket or quotation mark.
With a prefix argument NUMBER, move backward NUMBER closed brackets.
With a negative prefix argument NUMBER, move forward NUMBER closed brackets."
  (interactive "p")
  (if (and number
           (> 0 number))
      (ergoemacs-forward-close-bracket (- 0 number))
    (backward-char 1)
    (search-backward-regexp
     (eval-when-compile
       (regexp-opt '(")" "]" "}" ">" "〕" "】" "〗" "〉" "》" "」" "』" "”" "’" "›" "»"))) nil t number)
    (forward-char 1)))


(defun remove-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))
(add-hook 'text-mode-hook 'remove-dos-eol)

(fset 'yes-or-no-p 'y-or-n-p) ;; simple y or n to answer questions
(setq inhibit-startup-message t) ; no emacs start-up message
(setq column-number-mode t) ; column number in modeline
(setq c-basic-offset 2)  ; set tabs equal to two spaces
(setq tab-width 2) ; set tab width on viewing
(setq-default indent-tabs-mode nil) ; don't use tabs when pressing tab, use spaces
(setq indent-tabs-mode nil) ; don't use tabs when pressing tab, use spaces
(setq php-mode-force-pear t) ; set PHP mode to use PEAR indentations
;(setq php-mode-enable-pear-coding-style t) ; set PHP mode to use PEAR indentations
;(setq php-manual-path "~/elisp/php_docs")
(setq markdown-enable-math t)

;; Duplicate a line
(defun copy-this-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
)
(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (do-boring-newline)
  (yank)
)

;;; Make a minor mode to, by default, use your keybindings in place of
;;; defaults
(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")

; helpful keybindings
(define-key my-keys-minor-mode-map  "\M-s" 'ispell-buffer)
(setq text-mode-hook '(lambda ()
                        (local-set-key "\M-\t" 'ispell-complete-word)))
(setq tex-mode-hook '(lambda ()
                       (local-set-key "\M-\t" 'ispell-complete-word)))
(setq latex-mode-hook '(lambda ()
                         (local-set-key "\M-\t" 'ispell-complete-word)))

(define-key my-keys-minor-mode-map  "\C-d" 'duplicate-line)
(define-key my-keys-minor-mode-map  "\C-c\C-e" 'smart-close-tag)
(define-key my-keys-minor-mode-map  "\C-q" 'copy-this-line)
(define-key my-keys-minor-mode-map  "\C-c\C-k" 'copy-this-line)
(define-key my-keys-minor-mode-map  (kbd "<delete>") 'delete-char)
(define-key my-keys-minor-mode-map  "\C-c\C-p" 'do-latex-pdf)

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t " my-keys" 'my-keys-minor-mode-map)

(defun my/coffee-mode-hook ()
  (modify-syntax-entry ?` "\"" coffee-mode-syntax-table))

(add-hook 'my-keys-minor-mode-hook
          ; Variable setting specific to the minor mode
          (function (lambda ()
                      (setq ispell-enable-tex-parser t)
                      (setq coffee-tab-width 2)
                      (add-hook 'text-mode-hook 'turn-on-auto-fill)
                      (add-hook 'markdown-mode-hook 'turn-on-auto-fill)
                      (add-hook 'markdown-mode-hook (function (lambda()
                                                                (setq whitespace-action '(nil))
                                                                )))
                      (add-hook 'gfm-mode-hook 'turn-on-auto-fill)
                      (add-hook 'php-mode-hook 'comment-auto-fill)
                      (add-hook 'python-mode-hook 'comment-auto-fill)
                      (add-hook 'lisp-mode-hook 'comment-auto-fill)
                      (add-hook 'emacs-lisp-mode-hook 'comment-auto-fill)
                      (add-hook 'javascript-mode-hook 'comment-auto-fill)
                      (add-hook 'coffee-mode-hook 'comment-auto-fill)
                      (add-hook 'latex-mode-hook 'comment-auto-fill)
                      (add-hook 'coffee-mode-hook 'my/coffee-mode-hook)
                      )))

(defun comment-auto-fill()
  (setq comment-auto-fill-only-comments t)
  (setq comment-multi-line t)
  (auto-fill-mode 1))

(my-keys-minor-mode 1)
(defun my-minibuffer-setup-hook ()
  (my-keys-minor-mode 0))

(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)

;;; End minor mode

(add-hook 'coffee-mode-hook
          (function (lambda ()
                      (setq indent-tabs-mode nil
                            tab-width 2))))

(defun do-latex-pdf()
  "Make the current TeX buffer render a PDF"
  (interactive)
  (save-buffer)
  (setq short-file (get-short-filename))
  (setq long-file (buffer-file-name))
  (setq file-dir (get-file-dir))
  (with-temp-buffer
    (message (concat "Compiling " long-file))
    (shell-command (concat "latex -interaction=nonstopmode -buf-size=9999999 -output-directory=" file-dir " " long-file) t)
                                        ; Run it again to fix refs
    (message "Fixing refs ...")
    (shell-command (concat "latex -interaction=nonstopmode -buf-size=9999999 -output-directory="  file-dir " " long-file) t)
    (message "Running DVI-PS")
    (shell-command (concat "dvips " short-file ".dvi") t)
    (message "Running PS2PDF")
    (shell-command (concat "ps2pdf " short-file ".ps") t)
    (message "Done")))

(defun get-short-filename()
  "Get the absolute filename minus the extension"
  (let ((exploded (split-string (buffer-file-name) "\\.")))
    (mapconcat 'identity (butlast exploded) ".")))

(defun get-file-extension()
  "Get the file extension of the current buffer"
  (let ((exploded (split-string (buffer-file-name) "\\.")))
  (car (last exploded))))

(defun get-file-dir()
  "Get the absolute filename minus the extension"
  (let ((exploded (split-string (buffer-file-name) "\\\\")))
    (mapconcat 'identity (butlast exploded) "\\\\")))

;;; translate unreadable characters
(defun qq ()
"translate unreadable characters in text file"
  (interactive)
  (let ((ll '(
	     "—" "--"
	     "" ""
	     "“" "\""
	     "‹" "-"
             "\214" "'"
	     "”" "\""
	     "’"    "'"
	     "‘" "'"
	     "…" "..."
	     "–" "--"
	     "©"    "(c)"
             "---" "-"
             "\\*\\*\\*" "*"
             "’" "'"
             "•" ""
  )))
(replace-loop ll))
(untabify)
)

(defun qq-region ()
  "translate unreadable characters in region"
  (interactive)
  (let ((ll '(
              "—" "--"
              "" ""
              "“" "\""
              "‹" "-"
              "\214" "'"
              "”" "\""
              "’"    "'"
              "‘" "'"
              "…" "..."
              "–" "--"
              "©"    "(c)"
              "---" "-"
              "\\*\\*\\*" "*"
              "’" "'"
              "o" ""
              "•" ""
              )))
    (replace-loop-region ll)))


;;; Region as UL
(defun ul-region ()
"makes a list seperated by new lines fill with list elements"
  (interactive)
  (let ((ll '(
	     "
" "</li>
<li>"
  )))
(replace-loop-region ll)))

;;; non-interactive -- used by unhtml, qq
;;; the arg is a list of from-to pairs of strings to be globally replaced
;;; "from" can be regexp

(defun replace-loop (ll)
  (beginning-of-buffer)
  (while ll
   (replace-regexp (pop ll) (pop ll))
   (beginning-of-buffer)))

(defun replace-loop-region (ll)
  (region-beginning)
  (while (and (ll) (not region-end))
   (replace-regexp (pop ll) (pop ll))
   (region-beginning)))

(defun reload-dotemacs-file ()
"reload your .emacs file without restarting Emacs"
(interactive)
(load-file "~/.emacs") )

;; Match parens

(global-set-key "%" 'match-paren)
    (defun match-paren (arg)
      "Go to the matching paren if on a paren; otherwise insert %."
      (interactive "p")
      (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
            ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
            (t (self-insert-command (or arg 1)))))

;;
;; Wombat theme ported from Vim
;;
(ignore-errors
  (show-paren-mode t)
  (set-background-color "#242424")
  (set-foreground-color "#f6f3e8")
  (set-cursor-color "#656565")
  (set-face-foreground 'font-lock-comment-face "#99968b")
  (set-face-font 'font-lock-comment-face "Consolas-10")
  (set-face-italic-p 'font-lock-comment-face t)
  (set-face-foreground 'font-lock-doc-face "#99968b")
  (set-face-italic-p 'font-lock-doc-face t)
  (set-face-foreground 'font-lock-constant-face "#e5786d")
  (set-face-foreground 'font-lock-string-face "#95e454")
  ;(set-face-font 'font-lock-string-face "Consolas-10")
  (set-face-italic-p 'font-lock-string-face t)
  (set-face-foreground 'font-lock-variable-name-face "#cae682")
  (set-face-foreground 'font-lock-function-name-face "#cae682")
  (set-face-foreground 'font-lock-type-face "#cae682")
  (set-face-foreground 'font-lock-builtin-face "#8ac6f2")
  (set-face-foreground 'font-lock-keyword-face "#8ac6f2")
  (set-face-foreground 'font-lock-preprocessor-face "#e5786d")
  (set-face-foreground 'font-lock-negation-char-face "#e7f6da")
  (set-face-foreground 'link "#8ac6f2")
  (set-face-bold-p 'link t)
  (set-face-underline-p 'link t)
  (set-face-foreground 'show-paren-match "#f6f3e8")
  (set-face-background 'show-paren-match "#857b6f")
  (set-face-bold-p 'show-paren-match t)
  (set-face-foreground 'region "#f6f3e8")
  (set-face-background 'region "#444444")
  (set-face-foreground 'lazy-highlight "black")
  (set-face-background 'lazy-highlight "yellow"))


;; ;; Yanked from UGAstro


;; ;; ;; Set the default mode to be paragraph-indent...
; (setq default-major-mode 'paragraph-indent-text-mode)
;; (add-hook 'text-mode-hook
;; 	  '(lambda ()
;; 	     (auto-fill-mode 1)
;; 	     ))
;; (add-hook 'html-mode-hook '(lambda () (auto-fill-mode 0)))
;; (auto-fill-mode 1)
;; (setq comment-auto-fill-only-comments t)
;; (setq comment-multi-line t)

;; backgroundify colors in css
;; modify to also do 3-color, and rgb(a)
(defvar hexcolour-keywords
  '(("#[abcdef[:digit:]]\\{6\\}"
     (0 (put-text-property
         (match-beginning 0)
         (match-end 0)
         'face (list :background
                     (match-string-no-properties 0)))))))
(defvar short-hexcolour-keywords
  '(("#[abcdef[:digit:]]\\{3\\}"
     (0 (put-text-property
         (match-beginning 0)
         (match-end 0)
         'face (list :background
                     (match-string-no-properties 0)))))))
(defvar rgb-color-keywords
  '(("rgb([0-9]+, *[0-9]+, *[0-9]+)"
     (0
      (put-text-property
       (match-beginning 0)
       (match-end 0)
       'face (list :background
                   (let ((color-channels (split-string (substring (match-string-no-properties 0) 4 -1) ",")))
                     (format "#%02X%02X%02X"
                             (string-to-number (nth 0 color-channels))
                             (string-to-number (nth 1 color-channels))
                             (string-to-number (nth 2 color-channels))))))))))
(defvar rgba-color-keywords
  '(("rgba([0-9]+, *[0-9]+, *[0-9]+, *[0-1]*\.*[0-9]+)"
     (0
      (put-text-property
       (match-beginning 0)
       (match-end 0)
       'face (list :background
                   (let ((color-channels (split-string (substring (match-string-no-properties 0) 5 -1) ",")))
                     (format "#%02X%02X%02X"
                             (string-to-number (nth 0 color-channels))
                             (string-to-number (nth 1 color-channels))
                             (string-to-number (nth 2 color-channels))))))))))
(defun hexcolour-add-to-font-lock ()
  (font-lock-add-keywords nil hexcolour-keywords)
  (font-lock-add-keywords nil short-hexcolour-keywords)
  (font-lock-add-keywords nil rgb-color-keywords)
  (font-lock-add-keywords nil rgba-color-keywords)
  )
(add-hook 'css-mode-hook 'hexcolour-add-to-font-lock)
(add-hook 'less-css-mode-hook 'hexcolour-add-to-font-lock)
(add-hook 'php-mode-hook 'hexcolour-add-to-font-lock)
(add-hook 'html-mode-hook 'hexcolour-add-to-font-lock)
(add-hook 'javascript-mode-hook 'hexcolour-add-to-font-lock)
(add-hook 'coffee-mode-hook 'hexcolour-add-to-font-lock)
(add-hook 'xml-mode-hook 'hexcolour-add-to-font-lock)
(add-hook 'lisp-mode-hook 'hexcolour-add-to-font-lock)
(add-hook 'emacs-lisp-mode-hook 'hexcolour-add-to-font-lock)
(add-hook 'markdown-mode-hook
            (lambda ()
              (when buffer-file-name
                (add-hook 'after-save-hook
                          'check-parens
                          nil t))))
; warning, may yield wrong results in edge-cases like single double-quotes in code block.
; Use only if your files usually are balanced w/r/t double-quotes
; <http://stackoverflow.com/questions/9527593/customizing-check-parens-to-check-double-quotes>
(add-hook 'markdown-mode-hook (lambda () (modify-syntax-entry ?\" "\"" markdown-mode-syntax-table)))

;; ;; Allow upcase and downcase of region...
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; ;; Calendar info...
(setq calendar-standard-time-zone-name "PST")
(setq calendar-daylight-time-zone-name "PDT")
(setq calendar-latitude 37.871592)
(setq calendar-longitude -122.272747)
(setq calendar-location-name "Berkeley, CA")

;; Bind key to kill to start of line...
(defun kill-line-backwards ()
  "Delete the current line from here to the start."
  (interactive)
  (kill-line -0))
(global-set-key "\C-xc" 'kill-line-backwards)

;; ;; Bind key to touch a file... think of as a forceful C-x C-s!
(defun touch ()
  "Save the file whether or not changes have been made."
  (interactive)
  (write-file (buffer-file-name)))
(global-set-key  [(control x) (meta t)] 'touch)

;; ;; Macro to count words in region...
(defun count-words-region (beginning end)
  "Print number of words in the region.
Words are defined as at least one word-constituent
character followed by at least one character that
is not a word-constituent.  The buffer's syntax
table determines which characters these are."
  (interactive "r")
  (message "Counting words in region ... ")

;;; 1. Set up appropriate conditions.
  (save-excursion
    (goto-char beginning)
    (let ((count 0))

;;; 2. Run the while loop.
      (while (< (point) end)
        (re-search-forward "\\w+\\W*")
        (setq count (1+ count)))

;;; 3. Send a message to the user.
      (cond ((zerop count)
             (message
              "The region does NOT have any words."))
            ((= 1 count)
             (message
              "The region has 1 word."))
            (t
             (message
              "The region has %d words." count))))))
; Rebind C-x e from "call last keyboard macro"...
(global-set-key "\C-xw" 'count-words-region)

(defun copy-line (arg)
      "Copy lines (as many as prefix argument) in the kill ring"
      (interactive "p")
      (kill-ring-save (line-beginning-position)
                      (line-beginning-position (+ 1 arg)))
      (message "%d line%s copied" arg (if (= 1 arg) "" "s")))


;; Macro to reload a file
(defun rr ()
  (interactive)
  (revert-buffer t))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(flycheck-phpcs-standard "C:\\Users\\Philip\\Dropbox\\GitHub\\php-custom.xml")
 '(package-selected-packages
   (quote
    (use-package flycheck php-mode xahk-mode web-beautify swift-mode scss-mode sass-mode php-scratch php-refactor-mode magit less-css-mode gradle-mode gitignore-mode gitconfig-mode gh-md csv-mode color-identifiers-mode coffee-mode arduino-mode ahk-mode)))
 '(send-mail-function nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil))
;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;'(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight normal :height 90 :width normal)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


; Word wrap comments, and boring text, but not code.
(add-hook 'my-keys-minor-mode-hook
          '(lambda () (auto-fill-mode 1)))
(add-hook 'my-keys-minor-mode-hook
          '(lambda() (set (make-local-variable 'comment-auto-fill-only-comments) t)))
(setq comment-auto-fill-only-comments t)
; (setq comment-multi-line t)
;; Removes auto-fill from text too
;;(add-hook 'text-mode-hook
;;          (lambda () (auto-fill-mode -1)))
(add-hook 'after-init-hook 'global-color-identifiers-mode)
(setq coffee-tab-width 2)
(setq tab-always-indent 'complete)
