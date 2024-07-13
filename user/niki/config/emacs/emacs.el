(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode -1)
(ido-mode 1)

(setq display-line-numbers-type 'relative) 
(global-display-line-numbers-mode 1)
(setq-default indent-tabs-mode t)
(setq-default tab-width 4)

(setq make-backup-files nil)

(setq scroll-step 1)
(setq scroll-margin 10)

(setq use-dialog-box nil)

(setq c-default-style "linux"
	  c-basic-offset 4)

(keymap-global-set "C-c f" 'projectile-find-file)
(keymap-global-set "C-c g" 'projectile-grep)

(keymap-global-set "C-c d" 'eglot-find-declaration)

(keymap-global-set "M-g i" 'popup-imenu)

(keymap-global-set "C-c j" 'magit)

(add-hook 'org-mode-hook
		  (lambda ()
			(org-bullets-mode 1)
			(local-set-key (kbd "C-M-n") 'org-metadown)
			(local-set-key (kbd "C-M-p") 'org-metaup)
			(local-set-key (kbd "M-p") 'org-backward-heading-same-level)
			(local-set-key (kbd "M-n") 'org-forward-heading-same-level)
			
			(local-set-key (kbd "C-M-n") 'org-metadown)
			(local-set-key (kbd "C-M-b") 'org-metaleft)
			(local-set-key (kbd "C-M-f") 'org-metaright)
			(local-set-key (kbd "C-M-f") 'org-metaright)

			(local-set-key (kbd "C-M-a") 'org-shiftleft)
			(local-set-key (kbd "C-M-e") 'org-shiftright)
			
			(local-set-key (kbd "C-M-k") 'org-shiftup)
			(local-set-key (kbd "C-M-j") 'org-shiftdown)
			))

(require 'popwin)
(popwin-mode 1)

(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
;; (evil-mode 1)

(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(setq projectile-completion-system 'ivy)

(use-package ivy
  :config
  '((ivy-mode 1)
    (ivy--regex-fuzzy 1)))

(require 'nix-mode)
(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))

(require 'pdf-tools)
(add-to-list 'auto-mode-alist '("\\.pdf\\'" . pdf-view-mode))

(add-hook 'pdf-view-mode-hook #'(lambda () (interactive)  (display-line-numbers-mode  -1)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(modus-vivendi))
 '(custom-safe-themes
   '("d80952c58cf1b06d936b1392c38230b74ae1a2a6729594770762dc0779ac66b7" "72ed8b6bffe0bfa8d097810649fd57d2b598deef47c992920aef8b5d9599eefe" "b1a691bb67bd8bd85b76998caf2386c9a7b2ac98a116534071364ed6489b695d" "fa49766f2acb82e0097e7512ae4a1d6f4af4d6f4655a48170d0a00bcb7183970" "3e374bb5eb46eb59dbd92578cae54b16de138bc2e8a31a2451bf6fdb0f3fd81b" "19a2c0b92a6aa1580f1be2deb7b8a8e3a4857b6c6ccf522d00547878837267e7" "2ff9ac386eac4dffd77a33e93b0c8236bb376c5a5df62e36d4bfa821d56e4e20" default))
 '(package-selected-packages
   '(pdf-tools popup-imenu dumb-jump popwin gruvbox-theme company eglot magit nix-mode pacmacs projectile ivy)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
