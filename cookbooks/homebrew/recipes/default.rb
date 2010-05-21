#
# Cookbook Name:: homebrew
# Recipe:: Mac OSX Bootstrapper
#
# Copyright 2010, Atmos.org
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#
root = File.expand_path(File.join(File.dirname(__FILE__), ".."))

require root + '/resources/homebrew'
require root + '/providers/homebrew'

execute "setup /usr/local" do
  command "sudo mkdir -p /usr/local"
  not_if "test -d /usr/local"
end

execute "fix homebrew file ownerships" do
  command "sudo chown -R #{ENV['USER']}:staff /usr/local"
end

execute "download homebrew installer" do
  command "/usr/bin/curl -sfL http://github.com/mxcl/homebrew/tarball/master | /usr/bin/tar xz -m --strip 1"
  cwd '/usr/local'
  not_if "test -e /usr/local/bin/brew"
end

template "#{ENV['HOME']}/.profile" do
  mode  0700
  owner ENV['USER']
  group 'staff'
  source "dot.profile.erb"
  variables({ :home => ENV['HOME'] })
end

homebrew "git"
execute "update to the latest homebrew from github" do
  command "brew update"
end

homebrew_db "mongodb"
homebrew_db "postgresql"
homebrew_db "mysql"

### install a bunch of utils
%w(node rlwrap kiwi ack sqlite hub wget fortune).each do |pkg|
  homebrew pkg
end

#
#
## install rvm for ease of use
#sudo gem install rvm
#rvm-install
#source ~/.profile
#
## setup the default 1.8.7 version
#rvm install 1.8.7-p173
#rvm use 1.8.7-p173
#echo "rvm use 1.8.7-p173" >> ~/.profile
#
## install bundler
#gem install bundler
#git clone git://github.com/atmos/hancock.git
#cd hancock/
#bundle install
#bundle exec rake
#if [[ "$?" -eq "0" ]]; then
#  echo "Successfully bootstrapped your machine"
#else
#  echo "Shit failed. :("
#fi
##wget http://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
##cat ~/.profile >> ~/.zshrc
##rm ~/.profilet
