#
# Cookbook Name:: ruby
# Recipe:: rbenv
#

DEFAULT_RUBY_VERSION = "1.8.7-p352"

script "installing rbenv to ~/Developer" do
  interpreter "bash"
  code <<-EOS
    source ~/.cinderella.profile
    if [[ ! -d ~/Developer/.rbenv ]]; then
      git clone git://github.com/sstephenson/rbenv.git ~/Developer/.rbenv
    fi
  EOS
end

script "installing ruby-build to ~/Developer" do
  interpreter "bash"
  code <<-EOS
    source ~/.cinderella.profile
    if [[ ! -x ~/Developer/bin/ruby-build ]]; then
      git clone git://github.com/sstephenson/ruby-build.git #{Dir.tmpdir}/ruby-build >> ~/.cinderella/ruby.log
      cd #{Dir.tmpdir}/ruby-build && /usr/bin/env PREFIX=~/Developer ./install.sh >> ~/.cinderella/ruby.log
    fi
  EOS
end

script "installing ruby-#{DEFAULT_RUBY_VERSION} to ~/Developer/.rbenv" do
  interpreter "bash"
  code <<-EOS
    source ~/.cinderella.profile

    if [ ! -d ~/Developer/.rbenv/versions/#{DEFAULT_RUBY_VERSION} ]; then
      ruby-build #{DEFAULT_RUBY_VERSION} ~/Developer/.rbenv/versions/#{DEFAULT_RUBY_VERSION}
    fi
  EOS
end

script "ensuring a default ruby is set" do
  interpreter "bash"
  code <<-EOS
    source ~/.cinderella.profile
    `which ruby | grep -q rbenv`
    if [ $? -ne 0 ]; then
      rbenv init
      rm -rf ~/.rbenv/versions
      ln -s ~/Developer/.rbenv/versions ~/.rbenv/versions
      rbenv rehash
      rbenv set-default #{DEFAULT_RUBY_VERSION}
    fi
  EOS
end

RUBYGEMS_VERSION="1.6.2"

script "installing rubygems #{RUBYGEMS_VERSION}" do
  interpreter "bash"
  code <<-EOS
    source ~/.cinderella.profile
    curl http://production.cf.rubygems.org/rubygems/rubygems-#{RUBYGEMS_VERSION}.tgz -o #{Dir.tmpdir}/rubygems-#{RUBYGEMS_VERSION}.tgz
    cd #{Dir.tmpdir} && tar zxvf rubygems-#{RUBYGEMS_VERSION}.tgz
    cd rubygems-#{RUBYGEMS_VERSION} && ruby setup.rb
    rbenv rehash
  EOS
end

script "installing basic gems" do
  interpreter "bash"
  code <<-EOS
    source ~/.cinderella.profile
    gem install bundler
    gem install rake -v=0.8.7
    rbenv rehash
  EOS
end

# directory "#{ENV['HOME']}/Developer/.rvm/gemsets" do
#   action 'create'
# end

# template "#{ENV['HOME']}/Developer/.rvm/gemsets/default.gems" do
#   source "default.gems.erb"
# end

# script "ensuring default rubygems are installed" do
#   interpreter "bash"
#   code <<-EOS
#     source ~/.cinderella.profile
#     rvm gemset load ~/Developer/.rvm/gemsets/default.gems >> ~/.cinderella/ruby.log 2>&1
#   EOS
# end

# execute "cleanup rvm build artifacts" do
#   command "find ~/Developer/.rvm/src -depth 1 | grep -v src/rvm | xargs rm -rf "
# end

template "#{ENV['HOME']}/.gemrc" do
  source "dot.gemrc.erb"
end

template "#{ENV['HOME']}/.rdebugrc" do
    source "dot.rdebugrc.erb"
end

homebrew "rpg"
