#
# Cookbook Name:: rails
# Recipe:: default
#
RAILS_2_VERSION = "2.3.8"
RAILS_3_VERSION = "3.0.0.beta3"

script "updating to the latest rails version #{RAILS_2_VERSION}" do
  interpreter "bash"
  code <<-EOS
    source ~/.cider.profile
    `gem list rails | grep -q '#{RAILS_2_VERSION}'`
    if [[ $? -ne 0 ]]; then
      gem install rails --version=#{RAILS_2_VERSION} --no-rdoc --no-ri
    fi
  EOS
end

script "installing the latest rails3 beta #{RAILS_3_VERSION}" do
  interpreter "bash"
  code <<-EOS
    source ~/.cider.profile
    `gem list rails | grep -q '#{RAILS_3_VERSION}'`
    if [[ $? -ne 0 ]]; then
      gem install rails --version=#{RAILS_3_VERSION} --pre --no-rdoc --no-ri
    fi
  EOS
end
