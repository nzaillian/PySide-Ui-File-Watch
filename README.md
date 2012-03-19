PySide Ui File Watch
--------------------

This repo contains a simple utility script I've been using in combination with [Qt Creator's](http://qt.nokia.com/products/developer-tools) UI designer and [PySide's](http://www.pyside.org/) "pyside-uic" compiler (which parses the contents of Qt .ui files and generates corresponding Python classes).  When passed the "-w" flag, the script ("ui_build.rb") watches the contents of the current directory (or a directory you've passed along with the flag) and all subdirectories and recompiles any .ui files that you've changed.  If passed no flag, the script simply recurses through the subdirectories of the current directory (or a directory whose name you've passed to the script) and compiles all .ui files it finds.  That's it!  Would have preferred to publish this as a gist, but because its one dependency ([FileSystemWatcher](http://paulhorman.com/filesystemwatcher)) isn't available on Github or Rubygems (and because I had to patch it for compatibility with Ruby 1.9+), I'll publish it in a repo along with the (patched) dependency (which is in the "vendor" directory).

  usage: ui_build.rb [-w|--watch] <base dir>

