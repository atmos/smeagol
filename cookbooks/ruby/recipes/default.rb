#
# Cookbook Name:: ruby
# Recipe:: default
#

DEFAULT_RUBY_VERSION = "1.8.7-p248"

script "installing rvm to ~/Developer" do
  interpreter "bash"
  code <<-EOS
    source ~/.cider.profile
    if [[ ! -d ~/Developer/.rvm ]]; then
      git clone git://github.com/atmos/rvm.git rvm
      cd rvm
      bin/rvm-install --prefix #{ENV['HOME']}/Developer/. >> ~/.cider.log 2>&1
    fi
  EOS
end

script "updating rvm to the latest stable version" do
  interpreter "bash"
  code <<-EOS
    source ~/.cider.profile
    rvm update -—head
  EOS
end

script "installing ruby" do
  interpreter "bash"
  code <<-EOS
    source ~/.cider.profile
    `rvm list | grep -q '#{DEFAULT_RUBY_VERSION}'`
    if [ $? -ne 0 ]; then
      rvm install #{DEFAULT_RUBY_VERSION}
    fi
  EOS
end

script "ensuring a default ruby is set" do
  interpreter "bash"
  code <<-EOS
    source ~/.cider.profile
    `which ruby | grep -q rvm`
    if [ $? -ne 0 ]; then
      rvm use #{DEFAULT_RUBY_VERSION} --default
    fi
  EOS
end

execute "cleanup rvm build artifacts" do
  command "find ~/.rvm/src -depth 1 | grep -v src/rvm | xargs rm -rf "
end

template "#{ENV['HOME']}/.gemrc" do
  source "dot.gemrc.erb"
end

homebrew "rpg"
