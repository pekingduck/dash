#!/usr/local/bin/bash

# $1 - Docset dir name. E.g. "GNU_Emacs"
# $2 - Doc id. E.g. "emacs"
# $3 - Doc family ID. Optionally, default to $2 doc_id.

mkdir -p $1.docset/Contents/Resources/Documents/
name=`echo $1 | tr _ ' '`
id=$2
if [ "Z$3" == "Z" ]
then
    echo doc family not supplied
    family=$2
else
    family=$3
fi
cat > $1.docset/Contents/Info.plist <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleIdentifier</key>
	<string>$id</string>
	<key>CFBundleName</key>
	<string>$name</string>
	<key>DocSetPlatformFamily</key>
	<string>$family</string>
	<key>isDashDocset</key>
	<true/>
	<key>dashIndexFilePath</key>
	<string>$id/index.html</string>
	<key>isJavaScriptEnabled</key>
	<true/>
</dict>
</plist>
EOF
