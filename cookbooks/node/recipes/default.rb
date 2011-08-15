#
# Cookbook Name:: node
# Recipe:: default
#
#
root = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "homebrew"))

require root + '/resources/homebrew'
require root + '/providers/homebrew'
require 'etc'

template "#{ENV['HOME']}/.npmrc" do
  mode   0700
  owner  ENV['USER']
  group  Etc.getgrgid(Process.gid).name
  source "dot.npmrc.erb"
  variables({ :home => ENV['HOME'] })
end

script "configuring nvm" do
  interpreter "bash"
  code <<-EOS
    source ~/.cinderella.profile
    cd #{ENV['HOME']}/Developer
    if [ ! -d ./.nvm ]; then
      git clone git://github.com/creationix/nvm.git .nvm >> ~/.cinderella/node.log
      source #{ENV['HOME']}/Developer/.nvm/nvm.sh        >> ~/.cinderella/node.log
      nvm install v0.4.10                                >> ~/.cinderella/node.log
      nvm alias default v0.4.10                          >> ~/.cinderella/node.log
      curl http://npmjs.org/install.sh | clean=yes sh    >> ~/.cinderella/node.log
    fi
  EOS
end
