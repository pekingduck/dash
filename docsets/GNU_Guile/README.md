GNU Libtool Docset
================--
Source: http://www.gnu.org/software/libtool/manual/guile.html_node.tar.gz

Run ../../docset_init.sh
```
$ docset_init.sh GNU_Guile guile guile
```
The shell script will create the directory tree and Info.plist

Download the manual in HTML format and uncompress the tar.gz file. Then:
```
$ mv guile.html_node GNU_Guile/Contents/Resources/Documents/guile
```

Run the index generation script:
```
$ ./gen_guile_doc.pl GNU_Guile/Contents/Resources GNU_Guile/Contents/Resources/Documents/guile/*.html
```

That's it.
