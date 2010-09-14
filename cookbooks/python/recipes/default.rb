#
# Cookbook Name:: python
# Recipe:: default
#

root = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "homebrew"))

require root + "/resources/homebrew"
require root + "/providers/homebrew"

homebrew "python"
homebrew "pip"
