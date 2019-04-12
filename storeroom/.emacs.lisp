(setq make-backup-files nil)
(setq auto-save-default nil)
(setq auto-save-list-file-name nil)

(setq display-time-24hr-format t) ;; 24-часовой временной формат в mode-line
(display-time-mode t) ;; показывать часы в mode-line

(setq word-wrap t) ;; переносить по словам
(global-visual-line-mode t)

;; Indent settings
(setq-default tab-width 4) ;; ширина табуляции - 4 пробельных символа
(setq-default standart-indent 4) ;; стандартная ширина отступа - 4 пробельных символа

(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)

;; Scrolling settings
(setq scroll-step 1)
(setq scroll-margin 10)
(setq scroll-conservatively 10000)

;; Highlight search resaults
(setq search-highlight t)
(setq query-replace-highlight t)

;; alt+x customize-th
