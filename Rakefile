require 'fileutils'

def remove_all(path)
  Dir.glob(path) do |f|
    FileUtils.rm(f)
  end
end

def get_profiles
  path = "#{ENV["HOME"]}/\.profiles/\.*"
  files = []
  Dir.glob(path) do |f|
    if File::ftype(f) == "file"
      files << f
    end
  end
  files
end

def get_home_path(f)
  [ENV["HOME"], File::basename(f)].join('/')
end

task :unnecessary_file do
  remove_all "#{ENV["HOME"]}/.profiles/*~"
  remove_all "#{ENV["HOME"]}/.profiles/\.*~"
end

task :link=>[:unnecessary_file] do
  get_profiles.each do |f|
    file_name = get_home_path f
    p "#{f} -> #{file_name}"
    FileUtils.ln_sf f, file_name
  end
end

task :unlink=>[:unnecessary_file] do
  get_profiles.each do |f|
    file_name = get_home_path f
    FileUtils.rm_f(file_name)
  end
end

task :install_neobundle do
  neobundle_path = "#{ENV["HOME"]}/.vim/bundle"
  unless Dir.exist?(neobundle_path)
      FileUtils.mkdir_p(neobundle_path)
      spawn("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim", STDERR=>STDOUT)
  end
end

task :install_homebrew do
  unless FileTest.exist?("/usr/local/bin/brew") 
    spawn('ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"', STDERR=>STDOUT)
  end
end

task :all =>[:link, :install_neobundle, :install_homebrew]

task :default => [:all]
