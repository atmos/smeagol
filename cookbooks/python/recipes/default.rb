#
# Cookbook Name:: python
# Recipe:: default
#

root = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "homebrew"))

require root + "/resources/homebrew"
require root + "/providers/homebrew"

script "downloading proper distribute package" do
  interpreter "bash"
  code <<-EOS
    source ~/.cinderella.profile
    cd #{ENV['HOME']}/Library/Caches/Homebrew
    wget http://cinderella.s3.amazonaws.com/distribute-0.6.21.tar.gz
  EOS
end

homebrew "python"

# execute "install pip" do
#   command "easy_install pip"
# end
