#
# Cookbook Name:: ruby
# Recipe:: bundler
#

{ 'bundler' => '0.9.26', 'bundler08' => '0.8.5', 'cider' => '0.1.4',
  'mysql'   => '2.8.1' }.each do |name, version|
  script "updating to the latest #{name} -> #{version}" do
    interpreter "bash"
    code <<-EOS
      source ~/.cider.profile
      `gem list #{name} | grep -q '#{version}'`
      if [[ $? -ne 0 ]]; then
        gem install #{name} --no-rdoc --no-ri >> ~/.cider/stdout.log 2>> ~/.cider/stderr.log
      fi
    EOS
  end
end
