;;; packages.el --- apex layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: enrico benini <enrico@enricos-MBP.fritz.box>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `apex-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `apex/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `apex/pre-init-PACKAGE' and/or
;;   `apex/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst apex-packages
  '()
  "The list of Lisp packages required by the apex layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")


; -*- Mode: Emacs-Lisp -*-

;;; apex-mode.el -- Major mode for Salesforce Apex files (Apex 18.0 - Winter '10 Release)

;; Software License Agreement (BSD License)
;;
;; Copyright (c) 2010 Orangatame LLC.
;; All rights reserved.
;;
;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions
;; are met:
;; 1. Redistributions of source code must retain the above copyright
;;    notice, this list of conditions and the following disclaimer.
;; 2. Redistributions in binary form must reproduce the above copyright
;;    notice, this list of conditions and the following disclaimer in the
;;    documentation and/or other materials provided with the distribution.
;; 3. The name of the author may not be used to endorse or promote products
;;    derived from this software without specific prior written permission.
;;
;; THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
;; IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
;; OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
;; IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
;; INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
;; NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
;; DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
;; THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
;; (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
;; THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

;; Put this file into your Emacs lisp path (eg. site-lisp)
;; and add the following line to your ~/.emacs file:
;;
;;   (require 'apex-mode)

(require 'font-lock)

(defvar apex-mode-hook nil)

(defvar apex-mode-map
  (let ((keymap (make-sparse-keymap)))
    (define-key keymap (kbd "RET") 'newline-and-indent)
    keymap)
  "Keymap for Apex major mode")

(add-to-list 'auto-mode-alist '("\\.cls\\'" . apex-mode))

(defconst apex-font-lock-keywords
  `((,(regexp-opt
       '("public" "global" "private" "protected" "static" "final" "transient" "virtual" "override" "abstract"
   "class" "interface" "new" "enum" "implements" "extends" "instanceof"
         "if" "then" "else" "do" "while" "break" "continue"
   "try" "catch" "throw" "finally"
   "trigger" "on" "before" "after"
   "return"
   "testmethod" "future" "callout"
   "select" "from" "using" "where" "not" "or" "null" "void" "true" "false" "like" "as" "in"
   )
       'words)
     (1 font-lock-keyword-face))

    (,(concat
       (regexp-opt
        '("insert" "update" "upsert" "delete" "undelete" "merge"
    "find" "search" "returning" "fields" "phrase"
    )
        'words)
       "(")
     (1 font-lock-function-name-face))

    ("\\<\\([0-9]+[lL]\\|\\([0-9]+\\.?[0-9]*\\|\\.[0-9]+\\)\\([eE][-+]?[0-9]+\\)?[fF]?\\)\\>"
     . font-lock-constant-face)
    ;; should "null" be here?

    ("\\<$[0-9]+\\>" . font-lock-variable-name-face)

    (,(regexp-opt
       '("list" "set" "map"
   "Blob" "Boolean" "Date" "Datetime" "Decimal" "Double" "ID" "Integer" "Long" "String" "Time"
   )
       'words)
     (1 font-lock-type-face)))
  "regexps to highlight in apex mode")

(defvar apex-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?\/  ". 12b"  st) ;; C-style "// ..."
    (modify-syntax-entry ?\n  "> b"    st)
;; define comment for this style: "/* ... */"
    (modify-syntax-entry ?\/ ". 14" st)
    (modify-syntax-entry ?*  ". 23"   st)
    st)
  "Syntax table for apex mode")

;; the command to comment/uncomment text
(defun apex-comment-dwim (arg)
"Comment or uncomment current line or region in a smart way.
For detail, see `comment-dwim'."
   (interactive "*P")
   (require 'newcomment)
   (let ((deactivate-mark nil) (comment-start "/*") (comment-end "*/"))
     (comment-dwim arg)))

(define-derived-mode apex-mode java-mode "Apex"
  "Major mode for editing Salesforce Apex files"
  :syntax-table apex-mode-syntax-table
  (define-key apex-mode-map [remap comment-dwim] 'apex-comment-dwim)

  (set (make-local-variable 'font-lock-defaults) '(apex-font-lock-keywords nil t))
  )

(provide 'apex-mode)

;;; end of apex-mode.el

;;; packages.el ends here
