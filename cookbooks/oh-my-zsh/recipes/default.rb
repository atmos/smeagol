#
# Cookbook Name:: oh-my-zsh
# Recipe:: default
#

script "oh-my-zsh install from github" do
  interpreter "bash"
  code <<-EOS
    source ~/.cinderella.profile
    curl https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -o - | sh
  EOS
end
