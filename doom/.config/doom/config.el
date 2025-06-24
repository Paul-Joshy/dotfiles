;;; ~/.config/doom/config.el

;; --- Gemini LLM Chat Setup ---
(setenv "GEMINI_API_KEY" "AIzaSyBl0aHaNDqz-KxiidnwbmhPRXHVbwB8V2g")

;; Define a fallback Gemini call directly
;; (defun my/gemini-api-call (prompt)
;;   "Call Gemini 2.5 Flash API with PROMPT and return result."
;;   (let ((url "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent")
;;         (api-key (getenv "GEMINI_API_KEY")))
;;     (with-current-buffer
;;         (url-retrieve-synchronously (concat url "?key=" api-key) t t)
;;       (goto-char (point-min))
;;       (re-search-forward "^$")
;;       (let* ((json-object-type 'alist)
;;              (json-array-type 'list)
;;              (json-key-type 'string)
;;              (json (json-read)))
;;         (alist-get 'text (elt (alist-get 'parts (elt (alist-get 'candidates json) 0)) 0))))))

(defun my/gemini-api-call (prompt)
  "Call Gemini API with PROMPT and return result."
  (let* ((url "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent")
         (api-key (getenv "GEMINI_API_KEY"))
         (url-request-method "POST")
         (url-request-extra-headers '(("Content-Type" . "application/json")))
         (url-request-data (json-encode `(("contents" . [(( "parts" . [(( "text" . ,prompt ))]))])))))
    (with-current-buffer
        (url-retrieve-synchronously (concat url "?key=" api-key) t t)
      (goto-char (point-min))
      (re-search-forward "^$")
      (let ((response (buffer-substring (point) (point-max))))
        (with-current-buffer (get-buffer-create "*Gemini Raw Response*")
          (erase-buffer)
          (insert response)
          (display-buffer (current-buffer)))
        (let* ((json-object-type 'alist)
               (json-array-type 'list)
               (json-key-type 'string)
               (json (ignore-errors (json-read))))
          (if json
              (alist-get 'text (elt (alist-get 'parts (elt (alist-get 'candidates json) 0)) 0))
            (message "❌ Failed to parse JSON. See *Gemini Raw Response* for details.")
            nil)))))

;; Define simple chat command using minibuffer
(defun my/gemini-chat ()
  "Prompt for input and send it to Gemini."
  (interactive)
  (let* ((prompt (read-string "You: "))
         (response (my/gemini-api-call prompt)))
    (with-current-buffer (get-buffer-create "*Gemini Chat*")
      (read-only-mode -1)
      (goto-char (point-max))
      (insert (format "\nYou: %s\nGemini: %s\n" prompt response))
      (read-only-mode 1)
      (pop-to-buffer (current-buffer)))))

;; Bind your own commands directly
(map! :leader
      (:prefix ("a" . "AI")
       :desc "Chat with Gemini" "c" #'my/gemini-chat))

;; --- Theme ---
(setq catppuccin-flavor 'mocha)
(setq doom-theme 'catppuccin)
;; Explicitly require it if needed
(require 'catppuccin-theme)
