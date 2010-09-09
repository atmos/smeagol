#
# Cookbook Name:: oh-my-zsh
# Recipe:: default
#

script "oh-my-zsh install from github" do
  interpreter "bash"
  code <<-EOS
    source ~/.cinderella.profile
    wget http://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
  EOS
end
