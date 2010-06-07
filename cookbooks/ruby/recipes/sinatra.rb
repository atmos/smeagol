#
# Cookbook Name:: ruby
# Recipe:: sinatra
#
SINATRA_VERSION = "1.0"

script "updating to the latest sinatra version" do
  interpreter "bash"
  code <<-EOS
    source ~/.cider.profile
    `gem list sinatra | grep -q '#{SINATRA_VERSION}'`
    if [[ $? -ne 0 ]]; then
      gem install sinatra --version=#{SINATRA_VERSION} --no-rdoc --no-ri
    fi
  EOS
end
