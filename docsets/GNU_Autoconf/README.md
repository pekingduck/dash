GNU Autoconf Docset
===================
Source: http://www.gnu.org/software/autoconf/manual/autoconf.html_node.tar.gz

Run ../../docset_init.sh
```
$ docset_init.sh GNU_Autoconf autoconf autotools
```
The shell script will create the directory tree and Info.plist

Download the manual in HTML format and uncompress the tar.gz file. Then:
```
$ mv autoconf.html_node GNU_Autoconf/Contents/Resources/Documents/autoconf
```

Run the index generation script:
```
$ ./gen_autoconf_doc.py GNU_Autoconf/Contents/Resources
```

That's it.
