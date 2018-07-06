;; Salesforce-Mode for Emacs!
;; The unofficial, but completely awesome MavensMate plugin for Emacs

;; Copywrite (c) 2016 Chris Watson <chris@marginzero.co> (cwatsondev.com) @iDev0urer

;; Version:      0.0.1
;; Author:       Chris Watson
;; URL:          http://github.com/iDev0urer/MavensMate-Emacs
;; Last Updated:
;; Keywords:     salesforce, visualforce, apex, mavensmate, force

;; Permission is hereby granted, free of charge, to any per son obtaining a copy
;; of this software and associated documentation files (the "Software"), to deal
;; in the Software without restriction, including without limitation the rights
;; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;; copies of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be included in all
;; copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

;; -- Constants -----------------------------------------------------------------

(defconst salesforce-mode:version "0.0.1"
  "salesforce-mode version")

;; -- Groups --------------------------------------------------------------------

(defgroup salesforce-mode nil
  "Major mode for interacting with salesforce"
  :group 'languages
  :prefix "sf-"
  :link '(url-link :tag "Repository" "https://github.com/iDev0urer/salesforce-mode")
  )

(defgroup salesforce-mode-faces nil
  "Faces for syntax highlighting"
  :group 'salesforce-mode
  :group 'faces
  )

;; -- Customs -------------------------------------------------------------------

(defcustom sf-compile-on-save t
  "Compile the current file every time it is saved"
  :type 'boolean
  :group 'salesforce-mode
  )

;; -- Faces ---------------------------------------------------------------------

;; -- Vars ----------------------------------------------------------------------

(defvar sf-apex-font-lock-keywords
  (list
   '((regexp-opt
      '("public" "global" "private" "protected" "static" "final" "transient"
        "virtual" "override" "abstract" "class" "interface" "new" "enum"
        "implements" "extends" "instanceof" "if" "then" "else" "do" "while"
        "break" "continue" "try" "catch" "throw" "finally" "trigger" "on"
        "before" "after" "return" "testmethod" "future" "callout" "select" "from"
        "using" "where" "not" "or" "null" "void" "true" "false" "like" "as" "in")
      'words)
     (1 font-lock-keyword-face))

   '((concat
     (regexp-opt
      '("insert" "update" "upsert" "delete" "undelete" "merge"
        "find" "search" "returning" "fields" "phrase"
        )
      'words)
     "(")
     (1 font-lock-function-name-face))

   '("\\<\\([0-9]+[lL]\\|\\([0-9]+\\.?[0-9]*\\|\\.[0-9]+\\)\\([eE][-+]?[0-9]+\\)?[fF]?\\)\\>"
    . font-lock-constant-face)
   ;; should "null" be here?

   '("\\<$[0-9]+\\>" . font-lock-variable-name-face)

   '((regexp-opt
    '("list" "set" "map"
      "Blob" "Boolean" "Date" "Datetime" "Decimal" "Double" "ID" "Integer" "Long" "String" "Time"
      )
    'words)
     (1 font-lock-type-face)))
  "regexps to highlight in apex mode")

(defvar sf-apex-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?\/  ". 12b"  st) ;; C-style "// ..."
    (modify-syntax-entry ?\n  "> b"    st)
    ;; define comment for this style: "/* ... */" 
    (modify-syntax-entry ?\/ ". 14" st)
    (modify-syntax-entry ?*  ". 23"   st)
    st)
  "Syntax table for apex mode"
  )


(defvar salesforce-mode-hook nil)
