#
# Cookbook Name:: homebrew
# Recipe:: Mac OSX Bootstrapper
#
root = File.expand_path(File.join(File.dirname(__FILE__), ".."))

require root + '/resources/homebrew'
require root + '/providers/homebrew'

directory "#{ENV['HOME']}/Developer" do
  action :create
end

execute "download homebrew installer" do
  command "/usr/bin/curl -sfL http://github.com/mxcl/homebrew/tarball/master | /usr/bin/tar xz -m --strip 1"
  cwd     "#{ENV['HOME']}/Developer"
  not_if  "test -e ~/Developer/bin/brew"
end

template "#{ENV['HOME']}/.cider.profile" do
  mode   0700
  owner  ENV['USER']
  group  'staff'
  source "dot.profile.erb"
  variables({
    :home        => ENV['HOME'],
    :rvm_default => ENV['DEFAULT_RVM_VM'] || '1.8.7-p249'
  })
end

%w(profile bash_profile zshrc).each do |config_file|
  execute "include cider environment into defaults for ~/.#{config_file}" do
    command "if [ -f ~/.#{config_file} ]; then echo 'source ~/.cider.profile' >> ~/.#{config_file}; fi"
    not_if  "grep -q 'cider.profile' ~/.#{config_file}"
  end
end

homebrew "git"
script "updating homebrew from github" do
  interpreter "bash"
  code <<-EOS
    source ~/.cider.profile
    PATH=#{ENV['HOME']}/Developer/bin:$PATH; export PATH
    echo $PATH >> ~/.cider.log 2>&1
    ~/Developer/bin/brew update >> ~/.cider.log 2>&1
  EOS
end

homebrew_db "mongodb"
homebrew_db "postgresql"
homebrew_db "mysql"

### install a bunch of utils
%w(tig ack sqlite wget tig fortune proctools markdown).each do |pkg|
  homebrew pkg
end
