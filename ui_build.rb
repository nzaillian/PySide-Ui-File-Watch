#!/usr/bin/env ruby
$:.unshift File.expand_path('../vendor/filesystemwatcher', __FILE__)

require 'filesystemwatcher'
require 'servicestate'

if ARGV[0] == '-h' || ARGV[0] == '--help'
  puts "usage: ui_build.rb [-w|--watch] <base dir>\n" +
       "w: watch mode\n"+
       "base dir: base of directory hierarchy you want to watch or "+
       "immediately build all .ui files from\n(default is current directory)"
  exit
end

def compile_ui(file)
  compiled_ui_file_path = file.gsub(/.ui$/,'.py')
  puts "compiling #{file} > #{compiled_ui_file_path}"
  system "pyside-uic #{file} > #{compiled_ui_file_path}"
end  

if ARGV[0] == '-w' || ARGV[0] == '--watch'

  # watch mode!  
  
  watcher = FileSystemWatcher.new()

  base_dir = ARGV[1] || Dir.pwd()

  watcher.addDirectory(base_dir, "**/*.ui")

  watcher.sleepTime = 2
  
  watcher.start { |status, file| 
    if status == FileSystemWatcher::CREATED || status == FileSystemWatcher::MODIFIED
      compile_ui(file)
    end
  }

  # keep the watcher thread awake...
  watcher.join()
else
  # non-watch mode: simply recurse directory hierarchy
  # from base_dir and compile any '.ui' files...
  
  base_dir = ARGV[0] || Dir.pwd()

  Dir[base_dir + '/**/*.ui'].each do |file|
    compile_ui(File.expand_path(file))
  end  
end  