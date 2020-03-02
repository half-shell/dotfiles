;;; init-file --- This is half-shell's init file
;;; Commentary:
;;; I like trains
(require 'package)

;;; code:
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; sensible defaults
(tool-bar-mode -1)
(menu-bar-mode -1)
(blink-cursor-mode -1)
(setq package-check-signature nil)
;; get rid of the startup screen
(setq inhibit-startup-screen t)

;; Fancy default
(setq ring-bell-function 'ignore)
(global-hl-line-mode t)
(electric-pair-mode t)
(show-paren-mode +1)
(scroll-bar-mode -1)
(global-prettify-symbols-mode +1)
;; reduce timing between keystroke trigger and its display
(setq echo-keystrokes 0.5)

;; Choose which version of nvm to use
;; this solves tern error
(nvm-use "v10.16.3")

;; Fonts
(set-face-attribute 'default nil :font "FantasqueSansmono Nerd Font Mono-12")
(set-frame-font "FantasqueSansMono Nerd Font Mono-12" nil t)

;; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; Remove trailing whitespaces before saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Change align rules
(defvar align-rules-list '())
(add-hook 'align-load-hook
          (lambda ()
            (add-to-list 'align-rules-list
                         '(text-column-whitespace
                           (regexp . "\\(^\\|\\S-\\)\\([ \t]+\\)")
                           (repeat . t)))))

(global-set-key (kbd "C-c a") 'align-current)

;; iBuffer
;; create default filter groups

;; Dired
;; allows us not to have several dired buffers when navigating
(put 'dired-find-alternate-file 'disabled nil)
;; Don't clutter up the working directory
(require 'dired-single)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq dired-listing-switches "-laGh --group-directories-first")

;; Term mode
;; Enabled utf-8
(add-hook 'term-exec-hook
          (function
           (lambda ()
             (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))))

;; Theme
(load-theme 'gruvbox-light-soft t)

;; Org Mode
;; Prettier bullet points
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda ()
                           (org-bullets-mode 1)
                           (visual-line-mode 1)))

;; setup babel for code blocks execution
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sql . t)
   (js . t)
   (lisp . t)))

;; source block syntax highlighting
(setq org-src-fontify-natively 1)

;; Smerge Mode
;; Change prefix
(setq smerge-command-prefix "\C-cm")

;; JS2-mode
(require 'js2-mode)
(require 'js2-refactor)
(add-hook 'js2-mode-hook (lambda ()
                           (js2-add-additional-externs
                            ;; Jest specific keywords
                            (list "it" "describe" "expect" "beforeEach" "beforeAll"
                                  "afterEach" "afterAll" "jest" "context"))
                           (setq js2-include-node-externs t)
                           (setq js2-basic-offset 2)
                           (js2-refactor-mode +1)
                           (eslintd-fix-mode +1)
                           (tern-mode t)))
;; (setq js2-strict-missing-semi-warning nil)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(js2r-add-keybindings-with-prefix "C-c C-k")

;; Company
(require 'company)
(require 'company-tern)
(global-company-mode +1)
(add-hook 'after-init-hook 'global-company-mode)
(add-to-list 'company-backends 'company-tern)

;; Projectile
(require 'projectile)
(projectile-mode +1)
(defvar projectile-mode-map)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(defvar projectile-project-search-path '("~/Work/"))
(setq projectile-switch-project-action #'projectile-find-dir) ;; open dired when switching project
;; Manage projectile actions for npm projet-types
;; (projectile-register-project-type 'npm '("package.json")
;;                                   :src-dir "./src"
;;                                   :compile "make deps"
;;                                   :test "make test"
;;                                   :run "make run"
;;                                   :test-suffix ".spec")


;; Magit
(require 'magit)
(require 'magit-gitflow)
(global-magit-file-mode)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch)
(add-hook 'magit-mode-hook 'turn-on-magit-gitflow)

;; js-comint
;; Enables node version with nvm
(defun inferior-js-mode-hook-setup ()
  "Getting a cleaner output from nodejs."
  '(add-hook 'comint-output-filter-functions 'js-comint-process-output))
(add-hook 'inferior-js-mode-hook 'inferior-js-mode-hook-setup t)
(js-do-use-nvm)

;; flycheck
;; (add-hook 'after-init-hook #'global-flycheck-mode)

;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.ejs\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
(setq web-mode-code-indent-offset 2)
(setq web-mode-markup-indent-offset 2)
(setq web-mode-script-padding 0)
(setq web-mode-style-padding 0)
(setq web-mode-css-indent-offset 2)
(setq web-mode-enable-css-colorization t)
;; Fix several kinds of indentation issues
(add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
(add-to-list 'web-mode-indentation-params '("lineup-calls" . nil))
(add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
(add-to-list 'web-mode-indentation-params '("lineup-ternary" . nil))
(setq web-mode-extra-keywords '(("comment" . ("NOTE"))))
;; Turn off pair matching as it conflicts with smartparens
(setq web-mode-enable-auto-pairing nil)
(setq web-mode-enable-comment-interpolation t)
(set-face-attribute 'web-mode-json-key-face nil :foreground "DeepSkyBlue4")
(set-face-attribute 'web-mode-comment-keyword-face nil :foreground "LightSkyBlue3")

;; smartparens
(require 'smartparens)
(smartparens-global-mode +1)
;;(smartparens-strict-mode +1)
(sp-pair "<" ">" :wrap "C->")

;; FZF
(require 'fzf)
(global-set-key (kbd "M-n") 'fzf-git-files)

;; AG
(require 'ag)
(setq ag-reuse-window +1)
(setq ag-reuse-buffers +1)
(setq ag-highlight-search +1)

;; embrace
(require 'embrace)
(global-set-key (kbd "C-,") #'embrace-commander)
(add-hook 'org-mode-hook #'embrace-org-mode-hook)

;; expand-region
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; indent-guide
(require 'indent-guide)
(indent-guide-global-mode)

;; multiple cursorsx
(require 'multiple-cursors)
(global-set-key (kbd "C-c m c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; dumb-jump
(require 'dumb-jump)
(dumb-jump-mode)

;; modeline
(require 'mood-line)
(mood-line-mode 1)

;; Replace a full path in HOME with "~"
(setq frame-title-format
  '(:eval
    (if buffer-file-name
        (replace-regexp-in-string
         "\\\\" "/"
         (replace-regexp-in-string
          (regexp-quote (getenv "HOME")) "~"
          (convert-standard-filename buffer-file-name)))
      (buffer-name))))

(defun mood-line-segment-buffer-name ()
  "Displays the name of the current buffer in the mode-line."
  (concat (propertize
           (if (buffer-file-name)
               (mapconcat 'identity (last (split-string (buffer-file-name) "/") 2) "/")
             "%b")
           'face
           'mode-line-buffer-id)
          "  "))

;; keyfreq
(require 'keyfreq)
(keyfreq-mode +1)
(keyfreq-autosave-mode +1)

;; undo tree
(require'undo-tree)
(global-undo-tree-mode +1)

;; Change indentation in json-mode
(setq js-indent-level 2)
(add-hook 'json-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 2)
            (smartparens-mode 0)))

;; hl-todo-mode
(require 'hl-todo)
(global-hl-todo-mode +1)

;; plantUML mode
(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
(setq plantuml-output-type "svg")
(setq plantuml-executable-path "/usr/bin/plantuml")
(setq plantuml-default-exec-mode 'executable)


;; Evil mode
;;(require 'evil)
;;(require 'evil-magit)
;;(require 'evil-surround)
;;(evil-mode +1)
;; (global-evil-surround-mode +1)

;; Custom functions
(defun insert-random-uuid ()
  "This generate and insert a random guid under cursor."
  (interactive)
  (shell-command-to-string "uuidgen"))

(provide 'init)
;;; init.el ends here
