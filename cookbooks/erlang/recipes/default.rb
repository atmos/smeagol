#
# Cookbook Name:: erlang
# Recipe:: default
#
# Copyright 2010, atmos.org
#

SMEAGOL_ROOT_DIR = ENV['SMEAGOL_ROOT_DIR'] || "#{ENV['HOME']}/Developer"

root = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "homebrew"))
require root + '/resources/homebrew'
require root + '/providers/homebrew'

script "installing erlang" do
  interpreter "bash"
  code <<-EOS
    source #{SMEAGOL_ROOT_DIR}/cinderella.profile
    if [ ! -f #{SMEAGOL_ROOT_DIR}/bin/erlc ]; then
      /usr/bin/env HOMEBREW_TEMP=#{SMEAGOL_ROOT_DIR}/tmp brew install erlang --use-gcc
    fi
  EOS
end

homebrew "riak"
