(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

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

(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode)
)


(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode)
)


(global-set-key [(meta up)]  'move-line-up)
(global-set-key [(meta down)]  'move-line-down)


(defun dublicate-line-up ()
  "Dublicate up the curent line."
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
  (forward-line -1)
)


(defun dublicate-line-down ()
  "Dublicate down the curent line."
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)

(global-set-key [(meta shift up)]  'dublicate-line-up)
(global-set-key [(meta shift down)]  'dublicate-line-down)
