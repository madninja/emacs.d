;;; Completions
(require-package 'company-irony)
(require-package 'company-irony-c-headers)

(add-hook 'c-mode-common-hook 'irony-mode)

;; Replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's asynchronous function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point] 'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol] 'irony-completion-at-point-async))

(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(after-load 'company (add-to-list 'company-backends '(company-irony-c-headers company-irony)))


;;; Eldoc integration
(require-package 'irony-eldoc)
(add-hook 'irony-mode-hook 'irony-eldoc)


;;; Flycheck integration
(require-package 'flycheck-irony)
(after-load 'flycheck (add-hook 'flycheck-mode-hook #'flycheck-irony-setup))
(add-hook 'c-mode-common-hook 'flycheck-mode)


;;; Basic settings
(setq-default c-basic-offset 4)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))


;;; Formatting
(require-package 'clang-format)
(defun clang-format-region-or-buffer ()
  "Run clang-format on region or buffer."
  (interactive)
  (if (region-active-p)
      (clang-format-region (region-beginning)
                           (region-end))
    (clang-format-buffer)))

(add-hook 'c-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-f") 'clang-format-region-or-buffer)
            (hs-minor-mode)))

(add-hook 'c++-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-f") 'clang-format-region-or-buffer)
            (hs-minor-mode)
            (setq comment-start   "/*" comment-end     "*/" comment-padding " ")))

;; Don't indent in extern "C" regions
(add-hook 'c-mode-common-hook
          (lambda()
            (c-set-offset 'inextern-lang 0)))

(provide 'init-c)
