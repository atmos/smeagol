#
# Cookbook Name:: homebrew
# Recipe:: dbs
#

SMEAGOL_ROOT_DIR = ENV['SMEAGOL_ROOT_DIR'] || "#{ENV['HOME']}/Developer"

root = File.expand_path(File.join(File.dirname(__FILE__), ".."))

require root + '/resources/homebrew'
require root + '/providers/homebrew'

homebrew_db "redis"
homebrew_db "mysql"
homebrew_db "mongodb"
homebrew_db "memcached"
script "installing postgresql" do
  interpreter "bash"
  code <<-EOS
    source #{SMEAGOL_ROOT_DIR}/cinderella.profile
    if [ ! -f #{SMEAGOL_ROOT_DIR}/bin/psql ]; then
      /usr/bin/env HOMEBREW_TEMP=#{SMEAGOL_ROOT_DIR}/tmp brew install postgresql --without-ossp-uuid
    fi
  EOS
end
homebrew_db "elasticsearch"
