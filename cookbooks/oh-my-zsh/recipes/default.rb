#
# Cookbook Name:: oh-my-zsh
# Recipe:: default
#

script "zsh install from github" do
  interpreter "bash"
  code <<-EOS
    source ~/.cider.profile
    wget http://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
  EOS
end
