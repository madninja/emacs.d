(setq debug-on-error nil)

(require-package 'nlinum)
(add-hook 'prog-mode-hook 'nlinum-mode)

(require-package 'protobuf-mode)

(maybe-require-package 'alchemist)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(defun mn/mac-markdown-preview ()
  "Run Marked on the current file."
  (interactive)
  (shell-command
   (format "open -a /Applications/Marked\\ 2.app %s"
           (shell-quote-argument (buffer-file-name))))
  )

(when *is-a-mac*
  (add-hook 'markdown-mode-hook
            (lambda ()
              (let ((map markdown-mode-command-map))
                (define-key map (kbd "p") 'mn/mac-markdown-preview))
              )
            )
  )

(provide 'init-local)
