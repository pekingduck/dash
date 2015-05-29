GNU Gettext Docset
===================
Source: http://www.gnu.org/software/gettext/manual/gettext.html_node.tar.gz

Run ../../docset_init.sh
```
$ docset_init.sh GNU_Gettext gettext autotools
```
The shell script will create the directory tree and Info.plist

Download the manual in HTML format and uncompress the tar.gz file. Then:
```
$ mv gettext.html_node GNU_Gettext/Contents/Resources/Documents/gettext
```

Run the index generation script:
```
$ ./gen_gettext_doc.py GNU_Gettext/Contents/Resources
```

That's it.
