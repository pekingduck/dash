GNU Emacs Docset
================
Source: http://www.gnu.org/software/emacs/manual/emacs.html_node.tar.gz

```
$ tar zxvf emacs.html_node.tar.gz
$ ls
emacs/
$ 
# Optionally remove the link to ../dir/index.html at the bottom:
# 'Up <a href="../dir/index.html">(dir)</a>'

$ mkdir -p GNU_Emacs.docset/Contents/Resources/Documents/
$ mv elisp GNU_Emacs.docset/Contents/Resources/Documents/

# Extract variables, functions, macros etc... from HTML files for
# indexing
# Need Python3 w/Beautiful Soup 4
$ ./gen_emacs_doc.py GNU_Emacs.docset/Emacs.tgz GNU_Emacs.docset
```
