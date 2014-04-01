;; evil mappings
(define-key evil-normal-state-map (kbd "TAB") 'evil-indent-line)
(define-key evil-visual-state-map (kbd "TAB") 'indent-region)
(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-mode)

;; smart jump to start of line
(defun beginning-of-line-or-text ()
  "Move to beginning of line or beginning of text"
  (interactive)
  (let ((pt (point)))
    (beginning-of-line-text)
    (when (eq pt (point))
      (beginning-of-line))))
(global-set-key (kbd "C-a") 'beginning-of-line-or-text)

;; f key mappings
(global-set-key (kbd "<f9>") 'switch-to-buffer)
(global-set-key (kbd "<f10>") 'projectile-find-file)
(global-set-key (kbd "<f11>") 'find-file)

(provide 'init-keymaps)