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

script "configuring mysqld" do
  interpreter "bash"
  code <<-EOS
    source ~/.cinderella.profile
    if [[ ! -d ~/Developer/var/mysql ]]; then
      mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=#{ENV['HOME']}/Developer/var/mysql --tmpdir=/tmp
    fi
  EOS
end
