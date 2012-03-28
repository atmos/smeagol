#
# Cookbook Name:: homebrew
# Recipe:: homebrew
#

HOMEBREW_DEFAULT_SHA1 = '8560672847891fa0c52f69f65b109673430556c8'

root = File.expand_path(File.join(File.dirname(__FILE__), ".."))

SMEAGOL_ROOT_DIR = ENV['SMEAGOL_ROOT_DIR'] || "#{ENV['HOME']}/Developer"

require root + '/resources/homebrew'
require root + '/providers/homebrew'
require 'etc'

directory SMEAGOL_ROOT_DIR do
  action :create
end

directory "#{SMEAGOL_ROOT_DIR}/tmp" do
  action :create
end

directory "#{ENV['HOME']}/.cinderella" do
  action :create
end

directory "#{ENV['HOME']}/Library/Caches/Homebrew" do
  action :create
end

execute "download homebrew installer" do
  command "/usr/bin/curl -sfL http://github.com/mxcl/homebrew/tarball/master | /usr/bin/tar xz -m --strip 1"
  cwd     "#{SMEAGOL_ROOT_DIR}"
  not_if  "test -e #{SMEAGOL_ROOT_DIR}/bin/brew"
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

template "#{SMEAGOL_ROOT_DIR}/cinderella.profile" do
  mode   0700
  owner  ENV['USER']
  group  Etc.getgrgid(Process.gid).name
  source "dot.profile.erb"
  variables({ :home => ENV['HOME'], :root => SMEAGOL_ROOT_DIR })
end

%w(bash_profile bashrc zshrc).each do |config_file|
  execute "include cinderella environment into defaults for ~/.#{config_file}" do
    command "if [ -f ~/.#{config_file} ]; then echo 'source #{SMEAGOL_ROOT_DIR}/cinderella.profile' >> ~/.#{config_file}; fi"
    not_if  "grep -q 'cinderella.profile' ~/.#{config_file}"
  end
end

execute "setup cinderella profile sourcing in ~/.profile" do
  command "echo 'source #{SMEAGOL_ROOT_DIR}/cinderella.profile' >> ~/.profile"
  not_if  "grep -q 'cinderella.profile' ~/.profile"
end

homebrew "git"

script "ensure the git remote is installed" do
  interpreter "bash"
  code <<-EOS
    source #{SMEAGOL_ROOT_DIR}/cinderella.profile
    cd #{SMEAGOL_ROOT_DIR}
    if [ ! -d ./.git ]; then
      git init
      git remote add origin git://github.com/mxcl/homebrew.git
      git fetch -q origin
      git reset --hard origin/master
    fi
  EOS
end

script "updating homebrew from github" do
  interpreter "bash"
  code <<-EOS
    source #{SMEAGOL_ROOT_DIR}/cinderella.profile
    (cd #{SMEAGOL_ROOT_DIR} && git fetch -q origin && git reset --hard #{ENV['CINDERELLA_RELEASE'] || HOMEBREW_DEFAULT_SHA1}) >> ~/.cinderella/brew.log 2>&1
  EOS
end

homebrew "nginx"
homebrew "bash-completion"

script "installing a non-busted versino of gcc, fuck everything about this" do
  interpreter "bash"
  code <<-EOS
    source #{SMEAGOL_ROOT_DIR}/cinderella.profile
    brew install https://raw.github.com/Homebrew/homebrew-dupes/master/apple-gcc42.rb
  EOS
end
# homebrew "solr"
