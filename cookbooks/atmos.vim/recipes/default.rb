#
# Cookbook Name:: atmos.vim
# Recipe:: default
#

script "installing http://github.com/scrooloose/vimfiles" do
  interpreter "bash"
  code <<-EOS
    source ~/.cider.profile
    if [ ! -d ~/.vim ]; then
      git clone git://github.com/scrooloose/vimfiles.git ~/.vim
      cd ~/.vim
      git submodule init
      git submodule update
    fi
  EOS
end

if ENV['DONT_TOUCH_MY_VIMRC'].nil?
  directory "#{ENV['HOME']}/.vimswap" do
    action 'create'
  end

  template "#{ENV['HOME']}/.vimrc" do
    source "dot.vimrc.erb"
  end
end

script "installed macvim from google code" do
  interpreter "bash"
  code <<-EOS
    source ~/.cider.profile
    if [ ! -e ~/Developer/bin/mvim ]; then
      rm -rf /Applications/MacVim.app
      curl http://macvim.googlecode.com/files/MacVim-snapshot-52.tbz -o - | tar xj -
      cd MacVim-snapshot-52
      cp mvim ~/Developer/bin
      cp -r MacVim.app /Applications/
    fi
  EOS
end
