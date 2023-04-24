;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Cristian Scapin"
      user-mail-address "cristian.scapin654@icloud.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Fira Code" :size 13)
     doom-big-font (font-spec :family "Fira Code" :size 14))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

(custom-theme-set-faces! 'doom-one
    '(line-number :foreground "plum1")
    '(line-number-current-line :foreground "thistle1"))


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq projectile-project-search-path '(("~/.config" . 1) ("~/Documents" . 2)))

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq lsp-clients-clangd-args '("-j=3"
				"--background-index"
				"--clang-tidy"
				"--completion-style=detailed"
				"--header-insertion=never"
				"--header-insertion-decorators=0"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                          ;;
;; bionic reading functions ;;
;;                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; command to bold the first half of letters of every word in buffer or region
(defvar bionic-reading-face nil "a face for `bionic-reading-region'.")

(setq bionic-reading-face 'bold)
;; try
;; 'bold
;; 'error
;; 'warning
;; 'highlight
;; or any value of M-x list-faces-display

(defun bionic-reading-buffer ()
  (interactive)
  (bionic-reading-region (point-min) (point-max)))

(defun bionic-reading-region (Begin End)
  (interactive "r")
  (let (xBounds xWordBegin xWordEnd  )
    (save-restriction
      (narrow-to-region Begin End)
      (goto-char (point-min))
      (while (forward-word)
        ;; bold the first half of the word to the left of cursor
        (setq xBounds (bounds-of-thing-at-point 'word))
        (setq xWordBegin (car xBounds))
        (setq xWordEnd (cdr xBounds))
        (setq xBoldEndPos (+ xWordBegin (1+ (/ (- xWordEnd xWordBegin) 2))))
        (put-text-property xWordBegin xBoldEndPos
                           'font-lock-face bionic-reading-face)))))

(defun jc/insert-random-uuid ()
  (interactive)
  (shell-command "uuidgen" t))

(defun jc/quote-props (Begin End)
  (interactive "r")
  (let (xBounds xWordBegin xWordEnd)
    (narrow-to-region Begin End)
    (goto-char (point-min))
    (setq xBounds (bounds-of-thing-at-point 'word))
    (setq xWordBegin (car xBounds))
    (setq xWordEnd (cdr xBounds))
    (message xBounds)
    ))


(defun jc/fc-no-top-bar ()
  (interactive)
  (setq ns-auto-hide-menu-bar t)
  (set-frame-position nil 0 -24)
  (tool-bar-mode 0)
  (set-frame-size nil 332 98)     ;; Pick values matching your screen.
  )

(defun jc/top-bar ()
  (interactive)
  (setq ns-auto-hide-menu-bar nil)
  (tool-bar-mode 0))
