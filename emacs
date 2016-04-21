(require 'org-install)


(require 'python)

(defun my-shell-mode-hook ()
  (add-hook 'comint-output-filter-functions 'python-pdbtrack-comint-output-filter-function t))

(add-hook 'shell-mode-hook 'my-shell-mode-hook)


(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files (list "~/notes/notes.org"))

(setq org-directory "~/notes/")
(setq org-default-notes-file "~/notes/remember.org")
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)
(define-key global-map "\C-cr" 'org-remember)


(defun shell-2 () (interactive) (shell "*shell*<2>"))

(defun shell-3 () (interactive) (shell "*shell*<3>"))
(defun shell-4 () (interactive) (shell "*shell*<4>"))
(defun shell-5 () (interactive) (shell "*shell*<5>"))

(defun shell-6 () (interactive) (shell "*shell*<6>"))
(defun shell-7 () (interactive) (shell "*shell*<7>"))
(defun shell-8 () (interactive) (shell "*shell*<8>"))
(defun shell-9 () (interactive) (shell "*shell*<9>"))
; (global-set-key (kbd "C-c 1") (shell))

; (global-set-key (kbd "C-c 2") (shell-2))

(global-set-key "\C-c1" 'shell)
(global-set-key "\C-c2" 'shell-2)
(global-set-key "\C-c3" 'shell-3)
(global-set-key "\C-c4" 'shell-4)


(global-set-key "\C-c5" 'shell-5)
(global-set-key "\C-c6" 'shell-6)
(global-set-key "\C-c7" 'shell-7)
(global-set-key "\C-c8" 'shell-8)
(global-set-key "\C-c9" 'shell-9)

(global-set-key "\M-m" 'compile)


     (setq load-path
           (append (list nil 
			 "~/emacs-wiki-2.72"
                         )
                   load-path))


(require 'emacs-wiki)

(emacs-wiki-find-file "DailyLogJulyTwelve")




;(add-to-list 'load-path "~/Downloads/ensime_2.9.0-0.6.0.RC1/elisp/" "~/Downloads/pinard-Pymacs-016b0bc")
;(load-library "ensime")
;(autoload 'pymacs-apply "pymacs")
;(autoload 'pymacs-call "pymacs")
;(autoload 'pymacs-eval "pymacs" nil t)
;(autoload 'pymacs-exec "pymacs" nil t)
;(autoload 'pymacs-load "pymacs" nil t)
;;(eval-after-load "pymacs"
;;  '(add-to-list 'pymacs-load-p

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Library Paths
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d" "~/python-mode.el-6.0.3")

(setq ipython-command "/usr/local/bin/ipython")


(require 'comint)
(define-key comint-mode-map [(meta p)]
   'comint-previous-matching-input-from-input)
(define-key comint-mode-map [(meta n)]
   'comint-next-matching-input-from-input)
(define-key comint-mode-map [(control meta n)]
    'comint-next-input)
(define-key comint-mode-map [(control meta p)]
    'comint-previous-input)

(setq comint-completion-autolist t	;list possibilities on partial
					;completion
       comint-completion-recexact nil	;use shortest compl. if
					;characters cannot be added
       ;; how many history items are stored in comint-buffers (e.g. py-shell)
       ;; use the HISTSIZE environment variable that shells use (if  avail.)
       ;; (default is 32)
       comint-input-ring-size (string-to-number (or (getenv  
"HISTSIZE") "100")))


(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(require 'ipython)
(setq py-python-command-args '("-pylab" ))

(require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

;(require 'lambda-mode)
;(add-hook 'python-mode-hook #'lambda-mode 1)
;(setq lambda-symbol (string (make-char 'greek-iso8859-7 107)))

;(require 'anything)
;(require 'anything-ipython)

;(when (require 'anything-show-completion nil t)
;   (use-anything-show-completion 'anything-ipython-complete
;                                 '(length initial-pattern)))
;(require 'python-pep8)
;(require 'python-pylint)
;(require ‘anything-ipython)
;(define-key py-mode-map (kbd "M-") 'anything-ipython-complete)
;(define-key py-shell-map (kbd "M-") 'anything-ipython-complete)
(define-key py-mode-map (kbd "C-c M") 'anything-ipython-import-modules-from-buffer)

(dolist (key '(          
               "\C-z"))
  (global-unset-key key))

  (display-time)

  (when (load "flymake" t) 
         (defun flymake-pyflakes-init () 
           (let* ((temp-file (flymake-init-create-temp-buffer-copy 
                              'flymake-create-temp-inplace)) 
              (local-file (file-relative-name 
                           temp-file 
                           (file-name-directory buffer-file-name)))) 
             (list "/Users/tom/pychecker.sh" (list local-file)))) 

         (add-to-list 'flymake-allowed-file-name-masks 
                  '("\\.py\\'" flymake-pyflakes-init))) 

   (add-hook 'find-file-hook 'flymake-find-file-hook)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(py-pychecker-command "/users/tom/pychecker.sh")
 '(py-pychecker-command-args (quote ("")))
 '(python-check-command "/users/tom/pychecker.sh")
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 587))

(put 'upcase-region 'disabled nil)

; (require 'websearch)
(require 'jumper)

(require 'gnus)

 	
(setq gnus-select-method              '(nnimap "Gmail"
                      (nnimap-address "imap.gmail.com")))

(add-to-list 'gnus-secondary-select-methods
             '(nnimap "Gmail"
                      (nnimap-address "imap.gmail.com")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; START inserted by setup-dev.sh
(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 4)
(setq-default show-trailing-whitespace t)
;; END inserted by setup-dev.sh

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))

(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
(setq exec-path (append exec-path '("/usr/local/bin")))
