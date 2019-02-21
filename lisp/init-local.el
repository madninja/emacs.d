(setq debug-on-error nil)

(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(require-package 'nlinum)
(add-hook 'prog-mode-hook 'nlinum-mode)

(require-package 'protobuf-mode)
(add-hook 'irony-mode-hook
          (lambda ()
            (push 'protobuf-mode irony-supported-major-modes)
            )
          )
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
  (require-package 'xclip)
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
