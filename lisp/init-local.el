(setq debug-on-error nil)

(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

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


;; From: https://emacs.stackexchange.com/a/32882
;; Put this in your ~/.gnupg/gpg-agent.conf:
;;
;; allow-emacs-pinentry
;; allow-loopback-pinentry
;;
;; Run:
;;
;; gpgconf --reload gpg-agent
;;
(maybe-require-package 'pinentry)
(setq epa-pinentry-mode 'loopback)
(pinentry-start)

;; Use keychain to wrap ssh-agent. Put something like the following in
;; your bashrc
;;
;; if [ -f /usr/bin/keychain ]; then
;;     /usr/bin/keychain --gpg2 --quiet
;;     source $HOME/.keychain/$HOSTNAME-sh
;; fi
;;
(maybe-require-package 'keychain-environment)
(keychain-refresh-environment)


(provide 'init-local)
