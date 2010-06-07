#
# Cookbook Name:: homebrew
# Recipe:: dbs
#

root = File.expand_path(File.join(File.dirname(__FILE__), ".."))

require root + '/resources/homebrew'
require root + '/providers/homebrew'

homebrew_db "redis"
homebrew_db "mongodb"
homebrew_db "memcached"
homebrew_db "postgresql"
homebrew_db "mysql"
