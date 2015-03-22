(prelude-require-packages '(solarized-theme
                            window-numbering
                            go-eldoc
                            go-autocomplete
                            dockerfile-mode
                            sbt-mode
                            ensime
                            ;;desktop-save-mode
                            ;;battery
                            ))
;; - rust-mode
;; - go-mode
;; - omnisharp
;; - jedi  (for Python autocomplete)

(window-numbering-mode 1)

;; automatically save/restore opened files, windows config (number of windows, size, position), when quit ＆ restart emacs.
(desktop-save-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Misc Settings
;;

;; http://stackoverflow.com/questions/69934/set-4-space-indent-in-emacs-in-text-mode
;; 4 space identation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Scala
;;
;; (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;; from: https://github.com/hvesalai/scala-mode2
(add-hook 'scala-mode-hook '(lambda ()
                              (require 'whitespace)
                              
                              ;; clean-up whitespace at save
                              (make-local-variable 'before-save-hook)
                              (add-hook 'before-save-hook 'whitespace-cleanup)

                              ;; turn on highlight. To configure what is highlighted, customize
                              ;; the *whitespace-style* variable. A sane set of things to
                              ;; highlight is: face, tabs, trailing
                              (whitespace-mode)

                              (ensime-scala-mode-hook)
                              ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  GoLang
;;

(setenv "GOPATH" (concat (getenv "HOME") "/workspace/go-path/"))
;(setenv "GOROOT" (concat (getenv "HOME") "/bin/google-cloud-sdk/platform/google_appengine/goroot/"))

;; Go setup
;; run this to get the dependencies:
;; go get -u github.com/nsf/gocode
;; go get -u code.google.com/p/rog-go/exp/cmd/godef
;; go get -u github.com/dougm/goflymake
;; go get github.com/smartystreets/goconvey

;; OS X
;;(if  (file-directory-p "/usr/local/opt/go/libexec/misc/emacs/")
;;    (add-to-list 'load-path "/usr/local/opt/go/libexec/misc/emacs/"))
;; Ubuntu
;;(if  (file-directory-p "/usr/local/go/misc/emacs/")
;;    (add-to-list 'load-path "/usr/local/go/misc/emacs/"))
;; (add-to-list 'load-path (concat (live-pack-lib-dir) "go-mode.el/"))

;; http://godoc.org/code.google.com/p/go.tools/cmd/goimports

;;(require 'go-mode-load)
(require 'go-mode-autoloads)
(setq gofmt-command "goimports")

(add-hook 'before-save-hook 'gofmt-before-save)

(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))
(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd "C-c i") 'go-goto-imports)))
(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd "M-.") 'godef-jump)))

;; gocode for autocomplete
(add-to-list 'load-path "~/workspace/go-path/src/github.com/nsf/gocode/emacs/")
(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)

;; go-flymake
;(add-to-list 'load-path "~/workspace/go-path/src/github.com/dougm/goflymake")
;(require 'go-flymake)

;;(add-to-list 'load-path "~/workspace/go-path/src/github.com/dougm/goflymake")
;;(require 'go-flycheck)

;; TODO
;; go-errcheck
;; (add-to-list 'load-path "~/.live-packs/miguel-pack/lib/go-errcheck.el")
;; (require 'go-errcheck)

;; TODO https://github.com/dominikh/go-errcheck.el

;; M-x package-install go-eldoc
(add-hook 'go-mode-hook 'go-eldoc-setup)

(set-face-attribute 'eldoc-highlight-function-argument nil
                    :underline t :foreground "green"
                    :weight 'bold)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;    EShell
;;
;; http://www.howardism.org/Technical/Emacs/eshell-fun.html
(defun eshell-here ()
  "Opens up a new shell in the directory associated with the
current buffer's file. The eshell is renamed to match that
directory to make multiple eshell windows easier."
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (height (/ (window-total-height) 3))
         (name   (car (last (split-string parent "/" t)))))
    (split-window-vertically (- height))
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))

    (insert (concat "ls"))
    (eshell-send-input)))

(global-set-key (kbd "C-!") 'eshell-here)


(defun eshell/x ()
  (insert "exit")
  (eshell-send-input)
  (delete-window))
