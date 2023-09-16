;; Define the init file that emacs automatically writes to
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; Define and initialise package repositories
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; use-package to simplify the config file
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure 't)

;; copy and paste from clipboard
(use-package xclip)
(xclip-mode 1)

 ;; Keyboard-centric user interface
;; removes startup screen
  (setq inhibit-startup-message t)
;; removes toolbar, menubar and scrollbar
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
;; yes or no -> y/n
(defalias 'yes-or-no-p 'y-or-n-p)

;; Theme
(use-package kaolin-themes)
(load-theme 'kaolin-aurora t)

;; Open dired in same buffer
(put 'dired-find-alternate-file 'disabled nil)

;; Sort Dired buffers
(setq dired-listing-switches "-agho --group-directories-first")

;; Move deleted files to trash
(setq delete-by-moving-to-trash t)

;; Keep folders clean (create new directory when not yet existing)
(make-directory (expand-file-name "backups/" user-emacs-directory) t)
(setq backup-directory-alist `(("." . ,(expand-file-name "backups/" user-emacs-directory))))

;; Define external image viewer/editor
(setq image-dired-external-viewer "/usr/bin/eog")

;; Helm configuration
  (use-package helm
    :config
    ;; (require 'helm-config)
    :init
    (helm-mode 1)
    :bind
    (("M-x"     . helm-M-x) ;; Evaluate functions
     ("C-x C-f" . helm-find-files) ;; Open or create files
     :map helm-map
     ("C-z" . helm-select-action)
     ("<tab>" . helm-execute-persistent-action)))

;; Auto completion
(use-package company
  :config
  (setq company-idle-delay 0
        company-minimum-prefix-length 3
        company-selection-wrap-around t))
(global-company-mode)

(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-idle 0.5
	which-key-idle-dely 50)
  (which-key-setup-minibuffer))

;; Sensible line breaking
(add-hook 'text-mode-hook 'visual-line-mode)
;; Overwrite selected text
(delete-selection-mode t)
;; Scroll to the first and last line of the buffer
(setq scroll-error-top-bottom t)


