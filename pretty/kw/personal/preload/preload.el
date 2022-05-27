(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'custom-theme-load-path "~/.emacs.d")
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa")

(set-frame-parameter (selected-frame) 'alpha '(85 . 50))
(add-to-list 'default-frame-alist '(alpha . (85 . 50)))

(setq prelude-theme 'flatui-dark)
(set-face-attribute 'default nil :height 190)

(set-language-environment "UTF-8")
(setq prelude-whitespace nil)
(add-hook 'text-mode-hook 'visual-line-mode)
