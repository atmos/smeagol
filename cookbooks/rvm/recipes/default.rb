#
# Cookbook Name:: rvm
# Recipe:: default
#

execute "install rvm to system gems" do
  command "sudo gem install rvm --no-rdoc --no-ri"
end

execute "install rvm for the user" do
  command "rvm-install"
end

execute "install rvm for the user" do
  command "rvm install 1.8.7-p173"
end

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
