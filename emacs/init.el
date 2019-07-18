(add-to-list 'load-path "~/elisp/")
(setq backup-directory-alist '(("." . "~/.saves"))
      backup-by-copying t)
(global-set-key (kbd "C-c m c") 'mc/edit-lines)
(setq plstore-cache-passphrase-for-symmetric-encryption t)
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
(add-hook 'python-mode-hook 'jedi:setup)
(require 'package)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)
(autoload 'cobol-mode "cobol-mode" "A major mode for COBOL" t)
(autoload 'ledger-mode "ledger-mode" "A major mode for Ledger" t)
(autoload 'apex-mode "apex-mode" "A major mode for Apex" t)
(add-to-list 'auto-mode-alist '("\\.cob$" . cobol-mode))
(add-to-list 'auto-mode-alist '("\\.ledger$" . ledger-mode))
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
(add-to-list 'auto-mode-alist '("\\.cls\\'" . apex-mode))
(setq mail-user-agent 'mu4e-user-agent)
;; org-mode
(global-set-key (kbd "\C-c l") 'org-store-link)
(global-set-key (kbd "\C-c a") 'org-agenda)
(global-set-key (kbd "\C-c o") 'org-open-at-point-global)
(global-set-key (kbd "\C-c c") 'org-capture)
(require 'org-caldav)
(require 'org-protocol)
(setq org-caldav-url "https://central.saladisdead.com/remote.php/dav/calendars/uberphreak"
      org-caldav-calendar-id "personal"
      org-caldav-inbox "~/org/calendar.org"
      org-caldav-files (list "~/org/pride.org"
			     "~/org/cathedral.org"
			     "~/org/misc.org")
      org-icalendar-timezone "America/Kentucky/Louisville")
(with-eval-after-load 'org
  (setq org-catch-invisible-edits 'smart
	org-refile-targets '(("~/org/pride.org" :maxlevel . 1)
			     ("~/org/catehdral.org" :maxlevel . 1)
			     ("~/org/misc.org" :maxlevel . 1))
	org-emphasis-regexp-components '("- \t('\"{" "- \t(.,:!?;'\")}\\[" " \t\r\n" "." 1)
	org-log-done t
	org-directory "~/org"
	org-default-notes-file (concat org-directory "/capture.org")
	org-agenda-files (list "~/org/pride.org"
			       "~/org/cathedral.org"
			       "~/org/misc.org"
			       "~/org/accounts.org")
	org-link-abbrev-alist '(("cloud-sorce" . "https://source.developer.google.com"))
	org-ditaa-jar-path "/usr/share/ditaa/ditaa.jar"
	org-agenda-skip-scheduled-if-done t
	org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate
	org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)"))
	org-capture-templates
	'(("L" "Capture Link from Browser" entry (file "~/org/capture.org")
	   "* %?\n%i\n%a")
	  ("p" "Kentuckiana Pride Foundation")
	  ("pt" "Treasury")
	  ("ptt" "Task" entry (file+olp "~/org/pride.org" "Treasury" "Tasks")
	   "* TODO %?\n  %i\n  %a")
	  ("t" "todo" entry (file "~/org/capture.org")
	   "* TODO %?\n  SCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n  %a\n  "))
	org-clock-in-resume t
	org-plantuml-jar-path "/usr/share/plantuml/plantuml.jar"
	org-export-backends (quote (ascii html latex md icalendar)))
  (org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)
  (org-babel-do-load-languages
   (quote org-babel-load-languages)
   (quote ((ditaa . t)
	   (python . t)
	   (ledger . t)
	   (latex . t)
	   (shell . t)
	   (plantuml . t)
	   (C . t))))
  (defun my-org-confirm-babel-evaluate (lang body)
    (not (string= lang "ledger"))))
;; mastodon
(with-eval-after-load 'mastodon
  (setq mastodon-instance-url "https://mastodon.xyz"))
;; mu4e
(require 'mu4e-icalendar)
(mu4e-icalendar-setup)
(with-eval-after-load 'mu4e
  (require 'org-mu4e)
  (add-hook 'mu4e-view-mode-hook 'visual-line-mode)
  (define-key mu4e-headers-mode-map (kbd "C-c c") 'org-mu4e-store-and-capture)
  (define-key mu4e-view-mode-map    (kbd "C-c c") 'org-mu4e-store-and-capture)
  (setq mu4e-view-use-gnus t
	mu4e-view-show-images t
	mu4e-compose-dont-reply-to-self t
      	mu4e-show-images t
	mu4e-view-image-max-width 800
	mail-user-agent 'mu4e-user-agent
	mu4e-change-filenames-when-moving t
	mu4e-get-mail-command "mbsync -a"
	message-kill-buffer-on-exit t
	message-send-mail-function 'smtpmail-send-it
	mu4e-sent-folder "/protonmail/sent"
	mu4e-drafts-folder "/protonmail/drafts"
	user-mail-address "uberphreak@saladisdead.com"
        mu4e-user-mail-address-list (list "uberphreak@protonmail.com"
					  "uberphreak@saladisdead.com"
					  "aaron.angel@kypride.com"
					  "aaron.angel@kypride.com"
					  "aaron@romulus.jefferson.saladisdead.com")
	smtpmail-default-smtp-server "localhost"
	smtpmail-smtp-server "localhost"
	smtpmail-smtp-service 1025
	mu4e-bookmarks
	'(("g:unread AND NOT g:trashed" "Unread messages" ?u)
	  ("date:today..now" "Today's messages" ?t)
	  ("date:7d..now" "Last 7 days" ?w)
	  ("mime:image/*" "Messages with images" ?p)
	  ("m:/google/inbox OR m:/kypride/inbox OR m:/protonmail/inbox" "All inboxes" ?i)))
  (defvar my-mu4e-account-alist
    '(("protonmail"
       (mu4e-sent-folder "/protonmail/sent")
       (mu4e-drafts-folder "/protonmail/drafts")
       (user-mail-address "uberphreak@saladisdead.com")
       (smtpmail-smtp-user "uberphreak@protonmail.com")
       (smtpmail-default-smtp-server "localhost")
       (smtpmail-smtp-server "localhost")
       (smtpmail-smtp-service 1025))
      ("google"
       (mu4e-sent-messages-behavior delete)
       (mu4e-drafts-folder "/google/Drafts")
       (user-mail-address "aaron.angel@gmail.com")
       (smtpmail-smtp-user "aaron.angel@gmail.com")
       (smtpmail-default-smtp-server "smtp.gmail.com")
       (smtpmail-smtp-server "smtp.gmail.com")
       (smtpmail-smtp-service 587))
      ("kypride"
       (mu4e-sent-messages-behavior delete)
       (mu4e-drafts-folder "/kypride/Drafts")
       (user-mail-address "aaron.angel@kypride.com")
       (smtpmail-smtp-user "aaron.angel@kypride.com")
       (smtpmail-default-smtp-server "smtp.googlemail.com")
       (smtpmail-smtp-server "smtp.googlemail.com")
       (smtpmail-smtp-service 587))))
  (defun my-mu4e-set-account ()
    "Set the account for composing a message.
   This function is taken from: 
     https://www.djcbsoftware.nl/code/mu/mu4e/Multiple-accounts.html"
    (let* ((account
	    (if mu4e-compose-parent-message
		(let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
		  (string-match "/\\(.*?\\)/" maildir)
		  (match-string 1 maildir))
	      (completing-read (format "Compose with account: (%s) "
				       (mapconcat #'(lambda (var) (car var))
						  my-mu4e-account-alist "/"))
			       (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
			       nil t nil nil (caar my-mu4e-account-alist))))
	   (account-vars (cdr (assoc account my-mu4e-account-alist))))
      (if account-vars
	  (mapc #'(lambda (var)
		    (set (car var) (cadr var)))
		account-vars)
	(error "No email account found"))))
  (add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)
  (add-to-list 'mu4e-view-actions
	       '("View in browser" . mu4e-action-view-in-browser) t))
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(ledger-reports
   (quote
    (("test" "ledger ")
     ("bal" "%(binary) -f %(ledger-file) bal")
     ("reg" "%(binary) -f %(ledger-file) reg")
     ("payee" "%(binary) -f %(ledger-file) reg @%(payee)")
     ("account" "%(binary) -f %(ledger-file) reg %(account)"))))
 '(mail-host-address "romulus.jefferson.saladisdead.com")
 '(package-selected-packages
   (quote
    (mastodon jedi cobol-mode nov multiple-cursors org-protocol-jekyll dash org-trello oauth2 ## gnus-mock org htmlize)))
 '(scroll-bar-mode nil)
 '(send-mail-function nil)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(highlight ((t (:background "brightblack"))))
 '(org-document-info ((t (:foreground "brightred"))))
 '(org-document-title ((t (:foreground "brightred" :weight bold))))
 '(org-habit-clear-face ((t (:background "color-16"))))
 '(region ((t (:background "lightgoldenrod2" :foreground "black")))))
(put 'narrow-to-region 'disabled nil)
