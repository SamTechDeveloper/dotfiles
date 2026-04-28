
;;; package -- Summary

;;; Commentary:
;;
;;; Author: Sameer Ghanekar
;;

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;; Load it if it exists (don’t error if missing)
(when (file-exists-p custom-file)
  (load custom-file))

;;; Code:
;;; ============================================================
;;; 1. PACKAGE BOOTSTRAP  (built-in package.el + use-package)
;;; ============================================================

(require 'package)
(setq package-archives
      '(("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/packages/")
        ("melpa"  . "https://melpa.org/packages/")))
(package-initialize)

;; Bootstrap use-package on first run
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;;; ============================================================
;;; 2. STARTUP PERFORMANCE
;;; ============================================================

;; Raise GC threshold while loading, restore to sane value after
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold  16000000
                  gc-cons-percentage 0.1)))

;; Bigger subprocess reads — clangd sends large JSON payloads
(setq read-process-output-max (* 4 1024 1024))

;;; ============================================================
;;; 3. CORE SETTINGS
;;; ============================================================
(add-to-list 'file-coding-system-alist
             '("\\(^\\|/\\)[^./]+\\'" . utf-8))
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

;; Guard UI calls — terminal Emacs doesn't have scroll-bar-mode etc.
(when (fboundp 'menu-bar-mode)   (menu-bar-mode   -1))
(when (fboundp 'tool-bar-mode)   (tool-bar-mode   -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(when (fboundp 'tooltip-mode)    (tooltip-mode    -1))

(require 'auto-complete)
(global-auto-complete-mode t)

(require 'which-func)
(which-function-mode t)

(require 'use-package)
(setq use-package-always-ensure t)  ;; Auto-install packages

(add-to-list 'default-frame-alist
             '(font . "JetBrainsMono Nerd Font-14"))
(set-face-attribute 'default nil
                    :font "JetBrainsMono Nerd Font-14"
                    :weight 'normal)
(set-fontset-font t 'symbol "JetBrainsMono Nerd Font" nil 'append)

(add-to-list 'auto-mode-alist '("/Makefile[^/]*\\'" . makefile-mode))

;; Theme Starts ==
;; (setq catppuccin-flavor 'mocha) ; or 'latte, 'macchiato, or 'mocha
;; (load-theme 'catppuccin t)
(load-theme 'doom-one t)
(defvar my/doom-one-current 'dark
  "Current doom-one theme variant.")
;; (load-theme 'doom-gruvbox-light t)
;; (defvar my/doom-one-current 'light
;;   "Current doom-one theme variant.")

;; (defun my/apply-comment-color ()
;;   (set-face-attribute 'font-lock-comment-face nil
;;                       :foreground "coral1"))
;; (add-hook 'after-load-theme-hook #'my/apply-comment-color)

(defun my/toggle-doom-one ()
  "Toggle between doom-one and doom-one-light."
  (interactive)
  ;; disable all active themes first
  (mapc #'disable-theme custom-enabled-themes)

  (if (eq my/doom-one-current 'dark)
      (progn
        (load-theme 'doom-gruvbox-light t)
        (setq my/doom-one-current 'light))
    (progn
      (load-theme 'doom-one t)
      ;;(my/apply-comment-color)
      ;;(load-theme 'catppuccin t)
      (setq my/doom-one-current 'dark))))

(global-set-key (kbd "<f8>") #'my/toggle-doom-one)
(setq my/doom-one-current 'dark)
;; Apply once on startup
;;(my/apply-comment-color)

;; Theme Ends ==

;; (use-package doom-modeline
;;   :ensure t
;;   :hook (after-init . doom-modeline-mode)
;;   :config
;;   (setq doom-modeline-buffer-file-name-style 'buffer-name)
;;   (setq doom-modeline-modal-modern-icon t)
;;   (setq doom-modeline-lsp t)          ;; show lsp/eglot status
;;   (setq doom-modeline-lsp-icon t)
;;   (setq doom-modeline-checker-simple-format nil)  ;; show warning/error counts
;;   (setq doom-modeline-display-misc-in-all-mode-lines t))

(add-to-list 'auto-mode-alist '("\\.service\\'" . systemd-mode))
(add-to-list 'auto-mode-alist '("\\.socket\\'"  . systemd-mode))
(add-to-list 'auto-mode-alist '("\\.timer\\'"   . systemd-mode))
(add-to-list 'auto-mode-alist '("\\.mount\\'"   . systemd-mode))
(add-to-list 'auto-mode-alist '("\\.target\\'"  . systemd-mode))

;;Custom moved to custom.el

;; 1. File Type Associations
(add-to-list 'auto-mode-alist '("\\.h\\'"   . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cgi\\'" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.pm\\'"  . cperl-mode))

;; 2. Multicolored Highlight Function
(defun my-apply-highlights ()
  "Adds specific colors to different developer tags."
  (font-lock-add-keywords nil
    '(("\\<\\(FIXME\\|XXX\\|DOUBT\\|TESTING\\|BUG\\):" 1 '(:foreground "#FF3131" :weight bold) t)
      ("\\<\\(WARN\\):"        1 '(:foreground "yellow" :weight bold) t)
      ("\\<\\(TODO\\|FIX\\|FIXED\\|BUG_FIX\\):"        1 '(:foreground "green" :weight bold) t)
      ("\\<\\(NOTE\\|INFO\\):"        1 '(:foreground "cyan" :weight bold) t))))

;; 3. Activate for C, C++, and Perl
(add-hook 'c-mode-hook     'my-apply-highlights)
(add-hook 'c++-mode-hook   'my-apply-highlights)
(add-hook 'cperl-mode-hook 'my-apply-highlights)
(add-hook 'perl-mode-hook  'my-apply-highlights)

(defun insert-current-date ()
  "Insert current date in ISO format."
  (interactive)
  (insert (upcase(format-time-string "%d%b%Y"))))

;;; Minimal C/C++ terminal setup for Emacs 29.3

;; ----------------------------
;; Basic UI cleanup
;; ----------------------------
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(show-paren-mode 1)
(column-number-mode      1)

;; ----------------------------
;; Eglot + clangd
;; ----------------------------
(require 'eglot)

(add-hook 'c-mode-common-hook #'eglot-ensure)

(setq eglot-inlay-hints-mode nil)
(add-hook 'eglot-managed-mode-hook
          (lambda ()
            (eglot-inlay-hints-mode -1)))
(setq eglot-stay-out-of '(imenu))


;; ----------------------------
;; Navigation (definition)
;; ----------------------------
(global-set-key (kbd "M-.") #'xref-find-definitions)
(global-set-key (kbd "M-,") #'xref-pop-marker-stack)

;;; ============================================================
;;; 11. FLYMAKE  (built-in; eglot feeds it diagnostics)
;;; ============================================================

(use-package flymake
  :ensure nil
  :hook (prog-mode . flymake-mode)
  :bind (:map flymake-mode-map
         ("M-n"   . flymake-goto-next-error)
         ("M-p"   . flymake-goto-prev-error)
         ("C-c e" . flymake-show-buffer-diagnostics))
  :custom
  (flymake-fringe-indicator-position 'right-fringe))

;; ----------------------------
;; Clean Eldoc (no minibuffer resizing)
;; ----------------------------
(setq eldoc-echo-area-use-multiline-p nil)
(setq eldoc-idle-delay 2)
(setq max-mini-window-height 10)
(global-eldoc-mode 1)

(use-package eldoc-box
  :hook (eglot-managed-mode . eldoc-box-hover-mode))
;;; End of minimal config


;;; ============================================================
;;; 15. QUALITY OF LIFE
;;; ============================================================

;; (use-package rainbow-delimiters
;;   :hook (prog-mode . rainbow-delimiters-mode))

(use-package hl-todo
  :hook (prog-mode . hl-todo-mode)
  :custom
  (hl-todo-keyword-faces
   '(("TODO"  . "#ff9900")
     ("FIXME" . "#ff4444")
     ("CASE"  . "#ff4444")
     ("HACK"  . "#cc44ff")
     ("NOTE"  . "#44aaff")
     ("PERF"  . "#00cc88"))))

(use-package avy
  :bind
  (("C-j"   . avy-goto-char-timer)
   ("M-g l" . avy-goto-line)))

(use-package expand-region
  :bind ("C-=" . er/expand-region))



