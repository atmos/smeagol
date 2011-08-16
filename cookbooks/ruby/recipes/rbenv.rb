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

script "installing basic gems" do
  interpreter "bash"
  code <<-EOS
    source ~/.cinderella.profile
    gem install bundler heroku cinderella
    gem install rake -v=0.8.7
    rbenv rehash
  EOS
end
