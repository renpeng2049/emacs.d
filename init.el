
;;; This file bootstraps the configuration, which is divided into
;;; a number of other files.

(let ((minver "24.1"))
  (when (version< emacs-version minver)
    (error "Your Emacs is too old -- this config requires v%s or higher" minver)))
(when (version< emacs-version "24.4")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'init-benchmarking) ;; Measure startup time

(defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer
(defconst *is-a-mac* (eq system-type 'darwin))


;;----------------------------------------------------------------------------
;; Temporarily reduce garbage collection during startup
;;----------------------------------------------------------------------------
(defconst sanityinc/initial-gc-cons-threshold gc-cons-threshold
  "Initial value of `gc-cons-threshold' at start-up time.")
(setq gc-cons-threshold (* 128 1024 1024))
(add-hook 'after-init-hook
          (lambda () (setq gc-cons-threshold sanityinc/initial-gc-cons-threshold)))

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(require 'init-utils)
(require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el
;; Calls (package-initialize)
(require 'init-elpa)      ;; Machinery for installing required packages
(require 'init-exec-path) ;; Set up $PATH

;;----------------------------------------------------------------------------
;; Allow users to provide an optional "init-preload-local.el"
;;----------------------------------------------------------------------------
(require 'init-preload-local nil t)


;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------

(require-package 'wgrep)
(require-package 'project-local-variables)
(require-package 'diminish)
(require-package 'scratch)
(require-package 'command-log-mode)

(require 'init-frame-hooks)
(require 'init-xterm)
(require 'init-themes)
(require 'init-gui-frames)
(require 'init-dired)
;(require 'init-flycheck)

(require 'init-recentf)
(require 'init-smex)
(require 'init-ivy)
(require 'init-hippie-expand)
(require 'init-company)
(require 'init-windows)
(require 'init-sessions)
(require 'init-fonts)


(require 'init-editing-utils)
(require 'init-whitespace)
(require 'init-fci)


(require 'init-vc)
(require 'init-darcs)
(require 'init-git)
(require 'init-github)

(require 'init-projectile)

(require 'init-compile)
;(require 'init-crontab)
(require 'init-textile)
(require 'init-markdown)
;(require 'init-csv)
(require 'init-javascript)

(require 'init-org)
(require 'init-python-mode)

(require 'init-sql)

(require 'init-paredit)
(require 'init-lisp)
(require 'init-slime)



(require 'init-evil)

(require 'init-multi-term)


;(require 'init-common-lisp)

;(require 'init-gnus)


;;(when *spell-check-support-enabled*
;;  (require 'init-spelling))
;;
;;(require 'init-misc)
;;
;;(require 'init-folding)
;;(require 'init-dash)
;;(require 'init-ledger)
;;;; Extra packages which don't require any configuration
;;
;;(require-package 'gnuplot)
;;(require-package 'lua-mode)
;;(when *is-a-mac*
;;  (require-package 'osx-location))
;;(maybe-require-package 'regex-tool)

;;----------------------------------------------------------------------------
;; Allow access from emacsclient
;;----------------------------------------------------------------------------
(require 'server)
(unless (server-running-p)
  (server-start))


;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------
(when (file-exists-p custom-file)
  (load custom-file))


;;----------------------------------------------------------------------------
;; Allow users to provide an optional "init-local" containing personal settings
;;----------------------------------------------------------------------------
(require 'init-local nil t)


;;----------------------------------------------------------------------------
;; Locales (setting them earlier in this file doesn't work in X)
;;----------------------------------------------------------------------------
(require 'init-locales)


(when (maybe-require-package 'uptimes)
  (add-hook 'after-init-hook (lambda () (require 'uptimes))))

(provide 'init)

;; Local Variables:
(setq-default indent-tabs-mode nil)
;; coding: utf-8
;; no-byte-compile: t
;; End:
