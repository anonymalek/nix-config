(load-theme 'modus-vivendi)

(ido-mode 1)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

(global-display-line-numbers-mode 1)

(setq-default
 display-line-numbers-type 'relative
 scroll-step 1
 scroll-margin 10
 use-dialog-box nil
 tab-width 4
 make-backup-files nil
 )

(defalias 'yes-or-no-p 'y-or-n-p)

(keymap-global-set "C-c c" '(lambda () (interactive) (find-file "~/.emacs")))
(keymap-global-set "C-S-v" '(lambda () (interactive) (set-rectangular-region-anchor)))

(setq c-default-style "linux"
	  c-basic-offset 4)

(defun insert-date ()
  (interactive)
  (insert (shell-command-to-string "printf %s \"$(date '+%Y-%m-%d %H:%M:%S')\"")))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(setq
 package-selected-packages
 '(
   auctex
   multiple-cursors
   undo-tree
   evil-collection
   pdf-tools
   popup-imenu
   popwin
   company
   eglot
   magit
   nix-mode
   projectile
   ivy
   lua-mode
   org-bullets
   ))

(package-initialize)

(setq use-package-always-ensure t)

(use-package org
  :config
  (add-hook
   'org-mode-hook
   (lambda ()
	 (org-bullets-mode 1)
	 (auto-fill-mode 1)
	 ))
  :bind (
		 :map org-mode-map
		 ("C-M-n" . 'org-metadown)
		 ("C-M-p" . 'org-metaup)
		 ("M-p" . 'org-backward-heading-same-level)
		 ("M-n" . 'org-forward-heading-same-level)

		 ("C-M-b" . 'org-promote-subtree)
		 ("C-M-f" . 'org-demote-subtree)

		 ("C-M-a" . 'org-shiftleft)
		 ("C-M-e" . 'org-shiftright)

		 ("C-M-k" . 'org-shiftup)
		 ("C-M-j" . 'org-shiftdown)

		 ("M-<return>" . 'org-insert-subheading)
		 ("C-<return>" . 'org-insert-heading)
		 )
  )

(setq evil-want-keybinding nil) ;; required by evil-collection

(use-package evil
  :init
  (setq evil-undo-system 'undo-tree)
  :config
  (evil-mode 1)

  :bind (:map evil-normal-state-map
			  ("C-u" . 'evil-scroll-up)))

(use-package evil-collection
  :config
  (evil-collection-init)
  )

(use-package undo-tree
  :config
  (setq undo-tree-auto-save-history nil)
  (global-undo-tree-mode))

(use-package multiple-cursors
  :config
  (setq mc/always-run-for-all t))

(use-package eglot
  :bind
  (("C-c d" . 'eglot-find-declaration)))

(use-package magit
  :bind
  (("C-c j" . 'magit)))

(use-package projectile
  :bind
  (("C-c p" . 'projectile-command-map)
   :map projectile-mode-map
   ("C-c f" . 'projectile-find-file)
   ("C-c g" . 'projectile-grep))
  :config
  (setq projectile-completion-system 'ivy)
  (projectile-mode 1))

(use-package popwin
  :config
  (popwin-mode 1))

(use-package popup-imenu
  :bind
  (("M-g i" . 'popup-imenu)))

(use-package ivy
  :config
  (ivy-mode 1))

(use-package nix-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode)))

(use-package pdf-tools
  :config
  (add-to-list 'auto-mode-alist '("\\.pdf\\'" . pdf-view-mode))
  (add-hook 'pdf-view-mode-hook '(lambda () (interactive) (display-line-numbers-mode -1))))

(use-package company
  :config
  (global-company-mode)
  )

