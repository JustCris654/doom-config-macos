;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;;
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
;; accept.

(setq user-full-name "Cristian Scapin"
      user-mail-address "cristian.scapin654@icloud.com"
      doom-font (font-spec :family "FiraCode Nerd Font" :size 13)
      doom-big-font (font-spec :family "FiraCode Nerd Font" :size 14)
      doom-variable-pitch-font (font-spec :family "FiraCode Nerd Font" :size 13)
      doom-font-increment 1
      doom-theme 'doom-one
      display-line-numbers-type 'relative
      org-directory "~/org/"
      projectile-project-search-path '(("~/.config" . 1) ("~/Documents" . 2))
      doom-modeline-enable-word-count t
      )

(custom-theme-set-faces! 'doom-one
  '(line-number :foreground "plum1")
  '(line-number-current-line :foreground "thistle1"))

(global-tree-sitter-mode)
(add-hook 'typescript-mode-hook #'tree-sitter-hl-mode)
(add-hook 'rjsx-mode-hook #'tree-sitter-hl-mode)
(add-hook 'c-mode-hook #'tree-sitter-hl-mode)

;; (use-package! tree-sitter
;;    :hook (prog-mode . turn-on-tree-sitter-mode)
;;    :hook (tree-sitter-after-on . tree-sitter-hl-mode)
;;    :config
;;    (require 'tree-sitter-langs)
;;    ;; This makes every node a link to a section of code
;;    (setq tree-sitter-debug-jump-buttons t
;;          ;; and this highlights the entire sub tree in your code
;;          tree-sitter-debug-highlight-jump-region t))

;; use prettier as formatter for javascript
(setq-hook! 'js-mode-hook +format-with-lsp nil)
(setq-hook! 'js-mode-hook +format-with :none)
(add-hook 'js-mode-hook 'prettier-js-mode)

(setq lsp-eslint-validate '("svelte" "react"))


(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq lsp-clients-clangd-args '("-j=3"
				"--background-index"
				"--clang-tidy"
				"--completion-style=detailed"
				"--header-insertion=never"
				"--header-insertion-decorators=0"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))

(setq org-roam-graph-viewer nil)

(map! :map dap-mode-map
      :leader
      :prefix ("d" . "dap")
      ;; basics
      :desc "dap next"          "n" #'dap-next
      :desc "dap step in"       "i" #'dap-step-in
      :desc "dap step out"      "o" #'dap-step-out
      :desc "dap continue"      "c" #'dap-continue
      :desc "dap hydra"         "h" #'dap-hydra
      :desc "dap debug restart" "r" #'dap-debug-restart
      :desc "dap debug"         "s" #'dap-debug

      ;; debug
      :prefix ("dd" . "Debug")
      :desc "dap debug recent"  "r" #'dap-debug-recent
      :desc "dap debug last"    "l" #'dap-debug-last

      ;; eval
      :prefix ("de" . "Eval")
      :desc "eval"                "e" #'dap-eval
      :desc "eval region"         "r" #'dap-eval-region
      :desc "eval thing at point" "s" #'dap-eval-thing-at-point
      :desc "add expression"      "a" #'dap-ui-expressions-add
      :desc "remove expression"   "d" #'dap-ui-expressions-remove

      :prefix ("db" . "Breakpoint")
      :desc "dap breakpoint toggle"      "b" #'dap-breakpoint-toggle
      :desc "dap breakpoint condition"   "c" #'dap-breakpoint-condition
      :desc "dap breakpoint hit count"   "h" #'dap-breakpoint-hit-condition
      :desc "dap breakpoint log message" "l" #'dap-breakpoint-log-message)

;; dap-modes
(require 'dap-node)
(dap-node-setup)

(map! :leader
      (:prefix ("b" . "git")
       :desc "Next git conflict"       "n" #'smerge-vc-next-conflict))

(map!
 ;; need to invert + and =
 ;; and also need to be consistant because C-- was on text-scale-decrease
 :n "C-+" #'doom/increase-font-size
 :n "C--" #'doom/decrease-font-size
 :n "C-=" #'doom/reset-font-size)

(map! "C-c C-n" #'smerge-vc-next-conflict)

(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))


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


;; Custom functions

(defun jc/insert-random-uuid ()
  (interactive)
  (shell-command "uuidgen" t))

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

(fset 'quote-props
      (kmacro-lambda-form [?0 ?w ?d ?w ?i ?' escape ?p ?j] 0 "%d"))

;; Run C programs directly from within emacs
(defun execute-c-program ()
  (interactive)
  (defvar execute-c)
  (setq execute-c(concat "gcc " (buffer-name) " && ./a.out" ))
  (shell-command execute-c))
