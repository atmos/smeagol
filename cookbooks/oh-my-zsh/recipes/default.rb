#
# Cookbook Name:: oh-my-zsh
# Recipe:: default
#

script "zsh install from github" do
  interpreter "bash"
  code <<-EOS
    source ~/.profile
    wget http://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
  EOS
end

execute "source the normal profile for zsh" do
  command "echo 'source ~/.profile' >> ~/.zshrc"
  not_if "grep -q 'source ~/.profile' ~/.zshrc"
end
