#
# Cookbook Name:: erlang
# Recipe:: default
#
# Copyright 2010, atmos.org
#

# homebrew "erlang"

script "installing erlang" do
  interpreter "bash"
  code <<-EOS
    source ~/.cinderella.profile
    if [ ! -f #{SMEAGOL_ROOT_DIR}/bin/erlc ]; then
      /usr/bin/env HOMEBREW_TEMP=#{SMEAGOL_ROOT_DIR}/tmp brew install erlang --use-gcc
    fi
  EOS
end
