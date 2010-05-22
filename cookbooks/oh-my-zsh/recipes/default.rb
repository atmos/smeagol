#
# Cookbook Name:: oh-my-zsh
# Recipe:: default
#

execute "zsh install from github" do
  command "wget http://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh"
end

execute "source the normal profile for zsh" do
  command "echo 'source ~/.profile' >> ~/.zshrc"
end
