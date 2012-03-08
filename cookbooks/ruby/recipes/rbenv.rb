#
# Cookbook Name:: ruby
# Recipe:: rbenv
#
root = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "homebrew"))

require root + "/resources/homebrew"
require root + "/providers/homebrew"

SMEAGOL_ROOT_DIR = ENV['SMEAGOL_ROOT_DIR'] || "#{ENV['HOME']}/Developer"
DEFAULT_RUBY_VERSION = "1.8.7-p352"

homebrew "rbenv"
homebrew "ruby-build"

script "installing ruby-#{DEFAULT_RUBY_VERSION} to #{SMEAGOL_ROOT_DIR}/.rbenv" do
  interpreter "bash"
  code <<-EOS
    source #{SMEAGOL_ROOT_DIR}/cinderella.profile

    if [ ! -d #{SMEAGOL_ROOT_DIR}/.rbenv/versions/#{DEFAULT_RUBY_VERSION} ]; then
      ruby-build #{DEFAULT_RUBY_VERSION} #{SMEAGOL_ROOT_DIR}/.rbenv/versions/#{DEFAULT_RUBY_VERSION}
    fi
  EOS
end

script "installing ruby-1.9 to #{SMEAGOL_ROOT_DIR}/.rbenv" do
  interpreter "bash"
  code <<-EOS
    source #{SMEAGOL_ROOT_DIR}/cinderella.profile

    if [ ! -d #{SMEAGOL_ROOT_DIR}/.rbenv/versions/#{DEFAULT_RUBY_VERSION} ]; then
      ruby-build 1.9.3-p125 #{DEFAULT_RUBY_VERSION} #{SMEAGOL_ROOT_DIR}/.rbenv/versions/1.9.3-p125
    fi
  EOS
end

script "ensuring a default ruby is set" do
  interpreter "bash"
  code <<-EOS
    source #{SMEAGOL_ROOT_DIR}/cinderella.profile
    `which ruby | grep -q rbenv`
    if [ $? -ne 0 ]; then
      rbenv init
      rbenv rehash
      rbenv global #{DEFAULT_RUBY_VERSION}
    fi
  EOS
end

script "installing basic gems" do
  interpreter "bash"
  code <<-EOS
    source #{SMEAGOL_ROOT_DIR}/cinderella.profile
    gem install bundler heroku cinderella
    gem install rake -v=0.8.7
    rbenv rehash
  EOS
end
