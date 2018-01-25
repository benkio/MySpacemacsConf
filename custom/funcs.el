;; Contains my custom funcitons functions. Loaded after
;; layers.el
;; packages.el

(defun xml-format ()
  (interactive)
  (save-excursion
    (shell-command-on-region (mark) (point) "xmllint --format -" (buffer-name) t)
    )
  )