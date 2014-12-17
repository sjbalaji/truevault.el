;; -*- lexical-binding: t -*-
;;; truevault.el --- Truevault RESI API bindings for emacs

;; Author: Balaji S <sjbalajimdu@gmail.com>
;; URL: https://github.com/sjbalaji/truevault.el
;; Version: 0.0.1
;; Keywords: truevault rest API binding for emacs

;; Copyright (c) 2014 Balaji
;;
;; MIT License
;;
;; Permission is hereby granted, free of charge, to any person obtaining
;; a copy of this software and associated documentation files (the
;; "Software"), to deal in the Software without restriction, including
;; without limitation the rights to use, copy, modify, merge, publish,
;; distribute, sublicense, and/or sell copies of the Software, and to
;; permit persons to whom the Software is furnished to do so, subject to
;; the following conditions:
;;
;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
;; LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
;; OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
;; WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

;;; Commentary:

;; truevault.el is a truevault REST API binding for emacs



;;; Code:

(require 'json-reformat)

(setq lexical-binding t)
(setq URL "https://api.truevault.com")
;; Set your API_KEY here
(setq API_KEY "000000000000000000000000000000000000:")

(defun truevault-create-user(username password &optional attributes schema_id)
  "Create a new truevault user"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/users" 
		 (if (or username password attributes schema_id) "?") 
		 (if username (concat "&username=" username)) 
		 (if password (concat "&password=" password)) 
		 (if attributes (concat "&attributes=" attributes)) 
		 (if schema_id (concat "&schema_id=" schema_id)))))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XPOST" "-u" API_KEY)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-read-user(user-id)
  "Read a truevault user"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/users/" user-id)))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XGET" "-u" API_KEY)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-list-all-users()
  "List all truevault users"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/users")))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XGET" "-u" API_KEY)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-update-user(user-id &optional username password access_token attributes status)
  "Update a truevault user"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/users/" user-id 
		 (if (or username password access_token attributes status) "?") 
		 (if username (concat "&username=" username)) 
		 (if password (concat "&password=" password))
		 (if access_token (concat "&access_token=" access_token))
		 (if attributes (concat "&attributes=" attributes)) 
		 (if status (concat "&status=" status)))))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XPUT" "-u" API_KEY)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-delete-user(user-id)
  "Delete a truevault user"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/users/" user-id)))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XDELETE" "-u" API_KEY)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-create-access-token-for-user(user-id)
  "Create access token for a truevault user"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/users/" user-id "/access_token")))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XPOST" "-u" API_KEY)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-create-api-key-for-user(user-id)
  "Create api key for a truevault user"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/users/" user-id "/api_key")))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XPOST" "-u" API_KEY)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-create-api-key-for-user(user-id)
  "Create api key for a truevault user"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/users/" user-id "/api_key")))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XPOST" "-u" API_KEY)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-login-user(username password account-id)
  "Login a truevault user"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/auth/login"))
	(data 
	 (concat 
	  (if username (concat "&username=" username)) 
	  (if password (concat "&password=" password))
	  (if account-id (concat "&account_id=" account-id)))))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XPOST" "--data" data)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-logout-user(access-token)
  "Logout a truevault user"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/auth/logout"))
	(access-key
	 (concat 
	  (if access-token (concat access-token ":")))))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XPOST" "-u" access-key)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-verify-user(access-token)
  "Logout a truevault user"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/auth/me"))
	(access-key
	 (concat 
	  (if access-token (concat access-token ":")))))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XGET" "-u" access-key)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-create-group(name &optional policy user-ids)
  "Create a truevault user group"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/groups"))
	(data 
	 (concat 
	  (if name (concat "&name=" name)) 
	  (if policy (concat "&policy=" policy))
	  (if user-ids (concat "&user_ids=" user-ids)))))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XPOST" "--data" data "-u" API_KEY)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-read-group(group-id)
  "Read a truevault user group"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/groups/" group-id)))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XGET" "-u" API_KEY)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))


(defun truevault-update-group(group-id &optional name policy user-ids operation)
  "Update a truevault user group"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/groups/" group-id))
	(data 
	 (concat 
	  (if name (concat "&name=" name)) 
	  (if policy (concat "&policy=" policy))
	  (if operation (concat "&operation=" operation))
	  (if user-ids (concat "&user_ids=" user-ids)))))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XPUT" "--data" data "-u" API_KEY)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-delete-group(group-id)
  "Delete a truevault user group"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/groups/" group-id)))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XDELETE" "-u" API_KEY)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-create-vault(vault-name)
  "Delete a truevault user group"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/vaults"))
	(data
	 (concat "name=" vault-name)))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XPOST" "-u" API_KEY "--data" data)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-read-vault(vault-id)
  "Read a truevault vault"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/vaults/" vault-id)))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XGET" "-u" API_KEY)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-list-all-vaults(&optional page per-page)
  "List all truevault vault"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/vaults"))
	(data 
	 (concat 
	  (if page (concat "&page=" page))
	  (if per-page (concat "&per_page=" per-page)))))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XGET" "-u" API_KEY)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-update-vault(vault-id &optional name)
  "Update a vault"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/vaults/" vault-id))
	(data 
	 (concat 
	  (if name (concat "&name=" name)))))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XPUT" "-u" API_KEY "--data" data)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-delete-vault(vault-id)
  "Delete a vault"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/vaults/" vault-id)))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XDELETE" "-u" API_KEY)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-create-blob(vault-id file-path)
  "Create a truevault blob"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/vaults/" vault-id "/blobs"))
	(file 
	 (concat 
	  (if file-path (concat "file=@" file-path)))))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XPOST" "-u" API_KEY "--form" file "-H" "Content-Type:multipart/form-data")
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-read-blob(vault-id blob-id)
  "Read a truevault blob"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/vaults/" vault-id "/blobs/" blob-id)))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XGET" "-u" API_KEY)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer))))))

(defun truevault-list-all-blobs(vault-id)
  "List all truevault blobs in the vault"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/vaults/" vault-id "/blobs")))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XGET" "-u" API_KEY)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-update-blob(vault-id blob-id file-path)
  "Create a truevault blob"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/vaults/" vault-id "/blobs/" blob-id))
	(file 
	 (concat 
	  (if file-path (concat "file=@" file-path)))))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XPUT" "-u" API_KEY "--form" file "-H" "Content-Type:multipart/form-data")
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-delete-blob(vault-id blob-id)
  "Delete a truevault blob"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/vaults/" vault-id "/blobs/" blob-id)))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XDELETE" "-u" API_KEY)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-create-document(vault-id document &optional schema-id)
  "Create a truevault document"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/vaults/" vault-id "/documents"))
	(data 
	 (concat 
	  (if document (concat "&document=" document)) 
	  (if schema-id (concat "&schema_id=" schema-id)))))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XPOST" "-u" API_KEY "--data" data)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-read-document(vault-id document-id)
  "Read a truevault blob"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/vaults/" vault-id "/documents/" document-id)))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XGET" "-u" API_KEY)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer))))))

(defun truevault-list-all-documents-in-vault(vault-id &optional full page per-page)
  "List all the documents in a given truevault vault"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/vaults/" vault-id "/documents" 
		 (if (or full page per-page) "?")
		 (if full (concat "&full=" full)) 
		 (if page (concat "&page=" page))
		 (if per-page (concat "&per_page=" per-page)))))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl" "-s"  url "-XGET" "-u" API_KEY)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-list-all-documents-with-schema(vault-id schema-id &optional full page per-page)
  "List all the documents in a given truevault vault"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/vaults/" vault-id "/schemas/" schema-id "/documents"
		 (if (or full page per-page) "?")
		 (if full (concat "&full=" full))
		 (if page (concat "&page=" page))
		 (if per-page (concat "&per_page=" per-page)))))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl" "-s"  url "-XGET" "-u" API_KEY)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-update-document(vault-id document-id &optional document schema-id)
  "Create a truevault blob"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/vaults/" vault-id "/documents/" document-id))
 	(data 
	 (concat 
	  (if document (concat "&document=" document))
	  (if schema-id (concat "&schema_id=" schema-id)))))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XPUT" "-u" API_KEY "--data" data)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-delete-document(vault-id document-id)
  "Delete a truevault document"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/vaults/" vault-id "/documents/" document-id)))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XDELETE" "-u" API_KEY)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-reindex-document(vault-id document-id)
  "Reindex a truevault document"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/vaults/" vault-id "/documents/" document-id "/reindex")))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XPOST" "-u" API_KEY)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-create-schema(vault-id schema)
  "Create a new truevault schema"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/vaults/" vault-id "/schemas")) 
	(data
	 (concat "schema=" schema)))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XPOST" "-u" API_KEY "--data" data)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-read-schema(vault-id schema-id)
  "Read a new truevault schema"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/vaults/" vault-id "/schemas/" schema-id)))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XGET" "-u" API_KEY)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-list-all-schemas(vault-id)
  "List all schemas in a given truevault vault"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/vaults/" vault-id "/schemas")))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XGET" "-u" API_KEY)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-update-schema(vault-id schema-id schema)
  "Update truevault schema"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/vaults/" vault-id "/schemas/" schema-id)) 
	(data
	 (concat "schema=" schema)))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XPUT" "-u" API_KEY "--data" data)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-delete-schema(vault-id schema-id)
  "Delete a truevault schema"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/vaults/" vault-id "/schemas/" schema-id)))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XDELETE" "-u" API_KEY)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))

(defun truevault-search(vault-id search-option)
  "List a schema in a truevault vault"
  (let ((my-buffer
	 (concat "*TrueVaultAPI* " (current-time-string)))
	(url
	 (concat URL "/v1/vaults/" vault-id "/"))
	(data
	 (concat "search_option=" search-option)))
    (set-process-sentinel
     (start-process "curl-process" my-buffer "curl"  "-s"  url "-XGET" "-u" API_KEY "--data" data)
     (lambda (p e) (when (= 0 (process-exit-status p))
		     (switch-to-buffer my-buffer)
		     (json-reformat-region (point-max) (point-min)))))))
