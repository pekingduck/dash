GNU Libtool Docset
================--
Source: http://www.gnu.org/software/libtool/manual/libtool.html_node.tar.gz

Run ../../docset_init.sh
```
$ docset_init.sh GNU_Libtool libtool autotools
```
The shell script will create the directory tree and Info.plist

Download the manual in HTML format and uncompress the tar.gz file. Then:
```
$ mv libtool.html_node GNU_Libtool/Contents/Resources/Documents/libtool
```

Run the index generation script:
```
$ ./gen_libtool_doc.pl GNU_Libtool/Contents/Resources GNU_Libtool/Contents/Resources/Documents/libtool/*.html
```

That's it.
