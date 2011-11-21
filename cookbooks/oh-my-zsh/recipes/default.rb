#
# Cookbook Name:: oh-my-zsh
# Recipe:: default
#

SMEAGOL_ROOT_DIR = ENV['SMEAGOL_ROOT_DIR'] || "#{ENV['HOME']}/Developer"

script "oh-my-zsh install from github" do
  interpreter "bash"
  code <<-EOS
    source #{SMEAGOL_ROOT_DIR}/cinderella.profile
    curl https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -o - | sh
  EOS
end
