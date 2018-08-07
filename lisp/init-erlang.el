;;; init-erlang.el --- Support for the Erlang language -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(when (maybe-require-package 'erlang)
  (require 'erlang-start))

(when (maybe-require-package 'flycheck-rebar3)
  (flycheck-rebar3-setup))

(provide 'init-erlang)
;;; init-erlang.el ends here
