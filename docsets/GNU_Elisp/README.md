GNU Elisp Docset
================
Source: https://www.gnu.org/software/emacs/manual/elisp.html_node.tar.gz

There are Index.html and index.html in the archive. On Mac this will cause
problem since index.html will likely be overwritten by Index.html because by
default, Mac OS X's file system is case insensitive.

```
# first extract the main page index.html and rename it
# You'll need GNU tar for this.
$ tar zxvf elisp.html_node.tar.gz elisp/index.html
$ mv elisp/index.html elisp/zzz.html

# then extract the archive
$ tar zxvf elisp.html_node.tar.gz

# Move Index.html
mv elisp/Index.html elisp/Main-Index.html
mv elisp/zzz.html elisp/index.html

# Edit index.html
# 1. Change all occurrences of Index.html to Main-Index.html
# 2. Optionally remove the link to ../dir/index.html at the bottom:
#    'Up <a href="../dir/index.html">(dir)</a>'
mkdir -p GNU_Elisp.docset/Contents/Resources/Documents/
mv elisp GNU_Elisp.docset/Contents/Resources/Documents/

# Extract variables, functions, macros etc... from HTML files for
# indexing
# Need DBD::SQLite from cpan
./gen_elisp_db.pl GNU_Elisp.docset/Contents/Resources GNU_Elisp.docset/Contents/Resources/Documents/elisp/*.html
tar --exclude='.DS_Store' -cvzf GNU_Elisp.tgz GNU_Elisp.docset
```
