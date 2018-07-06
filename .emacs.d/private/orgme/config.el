(add-hook
 'org-load-hook
 (lambda ()
   (require 'ox-latex)
   (setq org-latex-default-class "org-book")
   (add-to-list 'org-latex-classes
                '("org-book"
                  "\\documentclass{book}"
                  ("\\chapter{%s}" . "\\chapter*{%s}")
                  ("\\section{%s}" . "\\section*{%s}")
                  ("\\subsection{%s}" . "\\subsection*{%s}")
                  ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                  ("\\paragraph{%s}" . "\\paragraph*{%s}")
                  ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))))

(with-eval-after-load 'org
  (require 'ox-beamer)
  (require 'ox-md)
  (require 'ox-confluence)
  )
