#
# Cookbook Name:: ruby
# Recipe:: rails
#
EY_GEM_VERSION      = "0.9.2"
RAILS_2_VERSION     = "2.3.8"
RAILS_3_VERSION     = "3.0.0.beta3"
HEROKU_GEM_VERSION  = "1.9.11"

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

script "installing the latest engineyard gem" do
  interpreter "bash"
  code <<-EOS
    source ~/.cider.profile
    `gem list engineyard | grep -q '#{EY_GEM_VERSION}'`
    if [[ $? -ne 0 ]]; then
      gem install engineyard --version=#{EY_GEM_VERSION} --no-rdoc --no-ri
    fi
  EOS
end

script "installing the latest heroku gem" do
  interpreter "bash"
  code <<-EOS
    source ~/.cider.profile
    `gem list heroku | grep -q '#{HEROKU_GEM_VERSION}'`
    if [[ $? -ne 0 ]]; then
      gem install heroku --version=#{HEROKU_GEM_VERSION} --no-rdoc --no-ri
    fi
  EOS
end
