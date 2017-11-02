;;; Compiled snippets and support files for `java-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'java-mode
                     '(("mthdoc" "    ///\n    /// $3\n    /// $4\n    /// @return $2 - \n    ///\n${1:private} ${2:void} ${3:name}(${4:args}) {\n    $0\n}" "methodDoc" nil nil nil "/Users/enrico/.emacs.d/private/snippets/java-mode/methodDoc" nil nil)
                       ("CCH" "/**\n * ${1:`(file-name-base buffer-file-name)`}\n *\n * @description       :   \n * @project           :   \n * @version           :   \n * @date              :   `(format-time-string \"%d %B %Y\")`$0\n * @author (original) :   Enrico Benini (enricobenini@)\n **/" "CodeCommentHeader" nil nil nil "/Users/enrico/.emacs.d/private/snippets/java-mode/CodeCommentHeader" nil nil)))


;;; Do not edit! File generated at Thu Nov  2 13:12:14 2017
