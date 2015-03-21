
;; Prelude does not mess by default with the standard mapping of Command (to Super) and Option (to Meta).
;; If you want to swap them add this to your personal config:
;; Change meta key to cmd
;; http://stackoverflow.com/questions/7743402/how-can-i-change-meta-key-from-alt-to-cmd-on-mac-in-emacs-24
(setq mac-command-modifier 'meta
      mac-option-modifier 'super)

;;(setq prelude-theme 'solarized-dark)

(toggle-scroll-bar -1)

(setq prelude-whitespace nil)

;;; You email address
(setq user-mail-address "mvitorino@gmail.com")

;; show battery percentage in mode line
(setq battery-mode-line-format "[%b%p%%]") ;; "#%b %p %t" ;; "[%b%p%%]"
(setq battery-load-critical 7)
(display-battery-mode t)

;; display current time
;;(setq display-time-day-and-date nil)
;;(setq display-time-24hr-format nil)
(setq display-time-format " %H:%M"
      display-time-default-load-average nil)
(display-time-mode 1)

(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.

This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

;;(set-exec-path-from-shell-PATH)
