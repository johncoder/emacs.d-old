(defun other-window-prev ()
  (interactive)
  (other-window -1))

(add-hook 'org-mode-hook
          '(lambda ()
             (define-key org-mode-map [(control tab)] nil)))

(defun select-to-beginning-of-line ()
  (interactive)
  (set-mark-command nil)
  (beginning-of-line))

(delete-selection-mode 1)

(defun move-and-center ()
  (interactive)
  (forward-line)
  (scroll-up 1))

(defun move-and-center-reverse ()
  (interactive)
  (forward-line -1)
  (scroll-up -1))

;;;; TESTING
(defvar testing-command "echo No testing command configured!")

;; Credit: http://jakemccrary.com/blog/2013/08/10/emacs-capture-shell-command-output-in-temporary-buffer/
(defun execute-tests ()
  (interactive)
  (when (and (buffer-modified-p)
             (y-or-n-p (format "Save file %s? " (buffer-file-name))))
    (save-buffer))
  (with-output-to-temp-buffer "*automated tests*"
    (shell-command (concat "echo Running: " testing-command) "*automated tests*")
    (shell-command testing-command
                   "*automated tests*")
    (pop-to-buffer "*automated tests*")))

;;;; RUNNING
(defvar running-command "echo No running command configured!")

(defun execute-run-command ()
  (interactive)
  (when (and (buffer-modified-p)
             (y-or-n-p (format "Save file %s? " (buffer-file-name))))
    (save-buffer))
  (with-output-to-temp-buffer "*run application*"
    (shell-command (concat "echo Running: " running-command) "*run application*")
    (shell-command running-command
                   "*run application*")
    (pop-to-buffer "*run application*")))

;;;; SHELL STUFF
(defvar default-local-browser-port "80")
(defun open-browser (port)
  (interactive
   (list (read-string (format "Open Browser to (default-local-browser-port: %s) http://localhost:" default-local-browser-port))))
  (shell-command
   (concat "open -a 'Google Chrome.app' 'http://localhost:'"
           (if (= (length port) 0) default-local-browser-port port))))

(global-set-key (kbd "C-|") 'magit-status)
(global-set-key (kbd "C-,") 'imenu)
(global-set-key (kbd "C-S-A") 'select-to-beginning-of-line)
(global-set-key (kbd "C-<tab>") 'other-window)
(global-set-key (kbd "C-S-<tab>") 'other-window-prev)
(global-set-key (kbd "<f5>") 'compile)
(global-set-key (kbd "C-<f5>") 'next-error)
(global-set-key (kbd "C-S-<f5>") 'previous-error)
(global-set-key (kbd "M-<f5>") 'execute-tests)
(global-set-key (kbd "<f8>") 'execute-run-command)
(global-set-key (kbd "<f7>") 'open-browser)
(global-set-key (kbd "M-<RET>") 'move-and-center)
(global-set-key (kbd "M-\\") 'move-and-center-reverse)
(require 'smart-comment)
(global-set-key (kbd "M-;") 'smart-comment)

