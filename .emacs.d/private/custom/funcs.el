;; Contains my custom funcitons functions. Loaded after
;; layers.el
;; packages.el


;; Formatting ;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun xml-format ()
  (interactive)
  (save-excursion
    (shell-command-on-region (mark) (point) "xmllint --format -" (buffer-name) t)
    )
  )


;; Copy Filename/Path to Clipboard

(defun copy-file-name-to-clipboard (filename-manipulate-func)
  "Copy the current buffer file name to the clipboard after the application of the input function."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (let ((changedFilename (funcall filename-manipulate-func filename)))
        (when changedFilename
          (kill-new changedFilename)
          (message "Copied buffer file name '%s' to the clipboard." changedFilename))))))

(defun copy-file-name-and-path-to-clipboard ()
  "Copy the current buffer file name and path to clipboard."
  (interactive)
  (copy-file-name-to-clipboard 'identity))

(defun copy-just-file-name-to-clipboard ()
  "Copy just the current buffer file name to clipboard."
  (interactive)
  (copy-file-name-to-clipboard 'file-name-nondirectory))


;; Move line

(defun move-line-up ()
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun move-line-down ()
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))


;; Window Manipulation

(defun set-window-width (n)
  "Set the selected window's width."
  (adjust-window-trailing-edge (selected-window) (- n (window-width)) t))

(defun set-80-columns ()
  "Set the selected window to 80 columns."
  (interactive)
  (set-window-width 80))


;; Text Manipulation

(defun reverse-words (beg end)
  "Reverse the order of words in region . "
  (interactive "*r")
  (apply
   'insert
   (reverse
    (split-string
     (delete-and-extract-region beg end) "\\b"))))


;; Buffer Manipulation

(defun delete-file-and-buffer ()
  "Kill the current buffer and deletes the file it is visiting . "
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (if (vc-backend filename)
          (vc-delete-file filename)
        (progn
          (delete-file filename)
          (message "Deleted file %s" filename)
          (kill-buffer))))))


;; Align command !!!

;; from http://stackoverflow.com/questions/3633120/emacs-hotkey-to-align-equal-signs
;; another information: https://gist.github.com/700416
;; use rx function http://www.emacswiki.org/emacs/rx

(defun align-to-colon (begin end)
  "Align region to colon (:) signs"
  (interactive "r")
  (align-regexp begin end
                (rx (group (zero-or-more (syntax whitespace))) ":") 1 1 ))

(defun align-to-comma (begin end)
  "Align region to comma  signs"
  (interactive "r")
  (align-regexp begin end
                (rx "," (group (zero-or-more (syntax whitespace))) ) 1 1 ))


(defun align-to-equals (begin end)
  "Align region to equal signs"
  (interactive "r")
  (align-regexp begin end
                (rx (group (zero-or-more (syntax whitespace))) " =") 1 1 ))

(defun align-to-hash (begin end)
  "Align region to hash (                                        => ) signs"
  (interactive "r")
  (align-regexp begin end
                (rx (group (zero-or-more (syntax whitespace))) " =>") 1 1 ))

;; work with this
(defun align-to-comma-before (begin end)
  "Align region to equal signs"
  (interactive "r")
  (align-regexp begin end
                (rx (group (zero-or-more (syntax whitespace))) ",") 1 1 ))

(defun indent-buffer ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  ;;  (align-current)
  (save-excursion (indent-region (point-min) (point-max) nil))
  ;;  (align-to-equals (point-min) (point-max))
  (untabify (point-min) (point-max)))

 ; Macros ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fset 'navigate-scala-error
   [?\C-  ?\C-s ?: left ?\M-w ?\C-x ?o ?\M-: ?\( ?f ?i ?n ?d ?- ?f ?i ?l ?e ?  ?\" ?\C-y right return ?\C-u ?\C-x ?o right ?\C-  ?\C-s ?: left ?\M-w ?\C-x ?o ?\M-g ?\M-g ?\C-y return])
