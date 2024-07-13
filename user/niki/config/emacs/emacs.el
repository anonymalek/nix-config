(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(custom-set-variables
 '(custom-enabled-themes '(modus-vivendi))
 '(package-selected-packages
   '(evil-collection pdf-tools popup-imenu popwin company eglot magit nix-mode projectile ivy lua-mode org-bullets)))

(package-initialize)

(defun become-evil ()
	(interactive)
	(setq evil-want-keybinding nil)
	(evil-mode 1)
	(evil-collection-init)
	(modify-syntax-entry ?_ "w")
	)

(become-evil)

(keymap-global-set "C-c c" '(lambda () (interactive) (find-file "~/.emacs")))

(ido-mode 1)

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

(global-display-line-numbers-mode 1)
(setq-default display-line-numbers-type 'relative)

(setq-default scroll-step 1)
(setq-default scroll-margin 10)
(setq-default use-dialog-box nil)
(setq-default tab-width 4)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq make-backup-files nil)

(add-hook
 'org-mode-hook
 (lambda ()
   (org-bullets-mode 1)))

(with-eval-after-load "org"
	(define-key org-mode-map (kbd "C-M-n") 'org-metadown)
	(define-key org-mode-map (kbd "C-M-p") 'org-metaup)
	(define-key org-mode-map (kbd "M-p") 'org-backward-heading-same-level)
	(define-key org-mode-map (kbd "M-n") 'org-forward-heading-same-level)

	(define-key org-mode-map (kbd "C-M-n") 'org-metadown)
	(define-key org-mode-map (kbd "C-M-b") 'org-metaleft)
	(define-key org-mode-map (kbd "C-M-f") 'org-metaright)
	(define-key org-mode-map (kbd "C-M-f") 'org-metaright)

	(define-key org-mode-map (kbd "C-M-a") 'org-shiftleft)
	(define-key org-mode-map (kbd "C-M-e") 'org-shiftright)

	(define-key org-mode-map (kbd "C-M-k") 'org-shiftup)
	(define-key org-mode-map (kbd "C-M-j") 'org-shiftdown)
)

(setq c-default-style "linux"
	  c-basic-offset 4)

(keymap-global-set "C-c d" 'eglot-find-declaration)

(keymap-global-set "C-c j" 'magit)

(projectile-mode 1)
(keymap-global-set "C-c p" 'projectile-command-map)
(setq projectile-completion-system 'ivy)

(define-key projectile-mode-map (kbd "C-c f") 'projectile-find-file)
(define-key projectile-mode-map (kbd "C-c g") 'projectile-grep)

(popwin-mode 1)

(keymap-global-set "M-g i" 'popup-imenu)

(use-package ivy
  :config
  '((ivy-mode 1)
	(ivy--regex-fuzzy 1)))

(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))

(require 'pdf-tools)
(add-to-list 'auto-mode-alist '("\\.pdf\\'" . pdf-view-mode))
(add-hook 'pdf-view-mode-hook '(lambda () (interactive) (display-line-numbers-mode -1)))

;; (add-hook 'after-init-hook 'global-company-mode)

