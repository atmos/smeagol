#
# Cookbook Name:: python
# Recipe:: default
#

root = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "homebrew"))

require root + "/resources/homebrew"
require root + "/providers/homebrew"

execute "downloading proper distribute package" do
  command "wget http://cinderella.s3.amazonaws.com/distribute-0.6.21.tar.gz"
  cwd "#{ENV['HOME']}/Library/Caches/Homebrew"
  not_if "test -e #{ENV['HOME']}/Library/Caches/Homebrew/distribute-0.6.21.tar.gz"
end

homebrew "python"

# execute "install pip" do
#   command "easy_install pip"
# end
