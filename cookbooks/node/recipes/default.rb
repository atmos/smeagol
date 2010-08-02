#
# Cookbook Name:: node
# Recipe:: default
#
#
root = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "homebrew"))

require root + '/resources/homebrew'
require root + '/providers/homebrew'
require 'etc'


### install a bunch of utils
%w(rlwrap node rlwrap kiwi).each do |pkg|
  homebrew pkg
end

### Installing npm is kinda painful, homebrew recipe coming soon
npm_executable = "#{ENV['HOME']}/Developer/bin/npm"

file npm_executable do
  owner  ENV['USER']
  group  Etc.getgrgid(Process.gid).name
  mode   "0755"
  action :create
end

template npm_executable do
  source "npm.erb"
end

directory "setup npm install directory" do
  mode      "0755"
  path      "#{ENV['HOME']}/Developer/Cellar/npm/src"
  group     Etc.getgrgid(Process.gid).name
  owner     ENV['USER']
  recursive true
end

script "configuring npm" do
  interpreter "bash"
  code <<-EOS
    source ~/.cider.profile
    cd #{ENV['HOME']}/Developer/Cellar/npm/src
    if [[ -f "./cli.js" ]]; then
      git reset --hard origin/master 2>&1
      git pull >> ~/.cider.log 2>&1
    else
      git clone --depth 1 git://github.com/isaacs/npm.git . >> ~/.cider.log 2>&1
    fi
  EOS
end


script "configuring ndistro" do
  interpreter "bash"
  code <<-EOS
    source ~/.cider.profile
    cd #{ENV['HOME']}/Developer/bin

    curl -# -L http://github.com/visionmedia/ndistro/raw/master/bin/ndistro > ndistro 2> ~/.cider.log
    chmod 0755 ndistro
  EOS
end
