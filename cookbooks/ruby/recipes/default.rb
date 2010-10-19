#
# Cookbook Name:: ruby
# Recipe:: default
#

DEFAULT_RUBY_VERSION = "1.8.7-p248"

script "installing rvm to ~/Developer" do
  interpreter "bash"
  code <<-EOS
    source ~/.cinderella.profile
    if [[ ! -d ~/Developer/.rvm ]]; then
      git clone git://github.com/atmos/rvm.git rvm
      cd rvm
      bin/rvm-install --prefix #{ENV['HOME']}/Developer/. >> ~/.cinderella/ruby.log 2>&1
    fi
  EOS
end

script "updating rvm to the latest stable version" do
  interpreter "bash"
  code <<-EOS
    source ~/.cinderella.profile
    rvm update -—head >> ~/.cinderella/ruby.log 2>&1
  EOS
end

script "installing ruby" do
  interpreter "bash"
  code <<-EOS
    source ~/.cinderella.profile
    `rvm list | grep -q '#{DEFAULT_RUBY_VERSION}'`
    if [ $? -ne 0 ]; then
      rvm install #{DEFAULT_RUBY_VERSION}
    fi
  EOS
end

script "ensuring a default ruby is set" do
  interpreter "bash"
  code <<-EOS
    source ~/.cinderella.profile
    `which ruby | grep -q rvm`
    if [ $? -ne 0 ]; then
      rvm use #{DEFAULT_RUBY_VERSION} --default
    fi
  EOS
end

template "#{ENV['HOME']}/Developer/.rvm/gemsets/default.gems" do
  source "default.gems.erb"
end

script "ensuring default rubygems are installed" do
  interpreter "bash"
  code <<-EOS
    source ~/.cinderella.profile
    rvm gemset load ~/Developer/.rvm/gemsets/default.gems >> ~/.cinderella/ruby.log 2>&1
  EOS
end

execute "cleanup rvm build artifacts" do
  command "find ~/Developer/.rvm/src -depth 1 | grep -v src/rvm | xargs rm -rf "
end

template "#{ENV['HOME']}/.gemrc" do
  source "dot.gemrc.erb"
end

template "#{ENV['HOME']}/.rdebugrc" do
    source "dot.rdebugrc.erb"
end

homebrew "rpg"
