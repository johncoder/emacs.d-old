(delete-selection-mode 1)
(global-set-key (kbd "C-,") 'imenu)

(defun other-window-prev ()
  (interactive)
  (other-window -1))

(global-set-key (kbd "C-<tab>") 'other-window)
(global-set-key (kbd "C-S-<tab>") 'other-window-prev)
