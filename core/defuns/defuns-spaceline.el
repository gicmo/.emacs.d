;;; defuns-spaceline.el

(defvar doom-env-version-hook '()
  "Hook that runs whenever the environment version changes (e.g. rbenv/pyenv)")

;;;###autoload
(defun doom|spaceline-env-update ()
  (when doom--env-command
    (let ((default-directory (doom/project-root)))
      (let ((s (shell-command-to-string doom--env-command)))
        (setq doom--env-version (if (string-match "[ \t\n\r]+\\'" s)
                                    (replace-match "" t t s)
                                  s))
        (run-hook-with-args 'doom-env-version-hook doom--env-version)))))

;;;###autoload
(defun doom/-flycheck-count (state)
  "Return flycheck information for the given error type STATE."
  (when (flycheck-has-current-errors-p state)
    (if (eq 'running flycheck-last-status-change)
        "?"
      (cdr-safe (assq state (flycheck-count-errors flycheck-current-errors))))))

(provide 'defuns-spaceline)
;;; defuns-spaceline.el ends here
