#
# Cookbook Name:: git
# Recipe:: default
#
root = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "homebrew"))
require root + '/resources/homebrew'
require root + '/providers/homebrew'

template "#{ENV['HOME']}/.gitconfig" do
  mode   0700
  owner  ENV['USER']
  group  'staff'
  source "dot.gitconfig.erb"
  variables({
    :home     => ENV['HOME'],
    :user     => ENV['USER'],
    :editor   => ENV['EDITOR']   || fail("No editor set for your ~/.gitconfig"),
    :email    => ENV['EMAIL']    || fail("No Email address set for your ~/.gitconfig"),
    :fullname => ENV['FULLNAME'] || fail("No Full Name set for your ~/.gitconfig")
  })
end

homebrew "hub"
