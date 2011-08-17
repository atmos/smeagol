#
# Cookbook Name:: homebrew
# Recipe:: homebrew
#

root = File.expand_path(File.join(File.dirname(__FILE__), ".."))

require root + '/resources/homebrew'
require root + '/providers/homebrew'
require 'etc'

directory "#{ENV['HOME']}/Developer" do
  action :create
end

directory "#{ENV['HOME']}/Developer/tmp" do
  action :create
end

directory "#{ENV['HOME']}/.cinderella" do
  action :create
end

execute "download homebrew installer" do
  command "/usr/bin/curl -sfL http://github.com/mxcl/homebrew/tarball/master | /usr/bin/tar xz -m --strip 1"
  cwd     "#{ENV['HOME']}/Developer"
  not_if  "test -e ~/Developer/bin/brew"
end

script "cleaning legacy artifacts" do
  interpreter "bash"
  code <<-EOS
  if [ -f ~/.cider.profile ]; then
    rm ~/.cider.profile
  fi
  if [ -f ~/.cider.profile.custom ]; then
    mv ~/.cider.profile.custom ~/.cinderella.profile.custom
  fi
  EOS
end

template "#{ENV['HOME']}/.cinderella.profile" do
  mode   0700
  owner  ENV['USER']
  group  Etc.getgrgid(Process.gid).name
  source "dot.profile.erb"
  variables({ :home => ENV['HOME'] })
end

%w(bash_profile bashrc zshrc).each do |config_file|
  execute "include cinderella environment into defaults for ~/.#{config_file}" do
    command "if [ -f ~/.#{config_file} ]; then echo 'source ~/.cinderella.profile' >> ~/.#{config_file}; fi"
    not_if  "grep -q 'cinderella.profile' ~/.#{config_file}"
  end
end

execute "setup cinderella profile sourcing in ~/.profile" do
  command "echo 'source ~/.cinderella.profile' >> ~/.profile"
  not_if  "grep -q 'cinderella.profile' ~/.profile"
end

homebrew "git"

script "ensure the git remote is installed" do
  interpreter "bash"
  code <<-EOS
    source ~/.cinderella.profile
    cd ~/Developer
    if [ ! -d ./.git ]; then
      git init
      git remote add origin git://github.com/mxcl/homebrew.git
      git fetch origin
      git reset --hard origin/master
    fi
  EOS
end

script "updating homebrew from github" do
  interpreter "bash"
  code <<-EOS
    source ~/.cinderella.profile
    PATH=#{ENV['HOME']}/Developer/bin:$PATH; export PATH
    ~/Developer/bin/brew update >> ~/.cinderella/brew.log 2>&1
  EOS
end

homebrew "nginx"
homebrew "bash-completion"
# homebrew "solr"
